#!/usr/bin/env python3
import numpy as np
import math

total_validators = 10000
validator_per_machine = 100
total_network_supernode_percentage = 0.5
start = 0

cl_split = {
    'prysm': 0.44,
    'lighthouse': 0.44,
    'teku': 0,
    'lodestar': 0,
    'nimbus': 0,
    'grandine': 0.12
}


el_split = {
    'geth': 0.34,
    'nethermind': 0.33,
    'ethereumjs': 0,
    'reth': 0.33,
    'besu': 0,
    'erigon': 0,
    'nimbusel': 0,
}

pairwise_validators = {}

for cl_name, cl_percent in cl_split.items():
    for el_name, el_percent in el_split.items():
        validators = total_validators * cl_percent * el_percent
        pairwise_validators[(cl_name, el_name)] = validators

output = ""
for (cl, el), count in pairwise_validators.items():
    variable_name = f"{cl.lower()}_{el.lower()}"
    name = f"{cl.lower()}-{el.lower()}"
    machine_count = math.ceil(count / validator_per_machine)

    end = start + int(count)

    # Calculate proportional supernode split with 4 decimal places
    supernode_value = round(total_network_supernode_percentage * el_split[el], 4)

    output += f'variable "{variable_name}" {{\n'
    output += f'  default = {{\n'
    output += f'    name            = "{name}"\n'
    output += f'    count           = {machine_count}\n'
    output += f'    validator_start = {start}\n'
    output += f'    validator_end   = {end}\n'
    output += f'    ipv6            = false\n'
    output += f'    supernode       = {supernode_value}\n'
    output += f'  }}\n'
    output += f'}}\n\n'

    start = end

print(output)
