Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C4606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BALys4I4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CAE1126B0;
	Fri, 30 Oct 2026 09:13:39 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E5410E85B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 08:33:20 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F0ZI1226962; Fri, 30 Oct 2026 08:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=idW0Au6ouGH8QZRKNCQTESYjN9tu33A1RQUt2frD7
 Yo=; b=BALys4I4wsEIUOoWkeizUVpBrb2bn1BOHjvhGmMIpC310wrogjnMZk9uK
 AgZAVpUXNnKV0Q6ectJOQgiO14MWo7d0iZVHbVK0rToOu9eNAV/hdj4VFJzuRhgY
 UKkZjVOi4oQfbqOUhviXwgdWlxwT7sJVqGl+Jl4oVrmEb3r+Jfid4N6Q0R7PWE1c
 MumdyuHy3DXUK9niprkJkXrXT2AFSINTunXTdrLSlRcv72U1P4DWj2g9P/rjWm7W
 hHJ/OpYwqdNK2vHZWI3ss2cQzqUC/tOUC1Pbu/hRnJeojA0ex18aQyxWeuG1TnL/
 n9dRQhR+y1UJLUGXh+vd35Ri5gPoA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeaysscs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:33:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8JsDI282332; Fri, 30 Oct 2026 08:33:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hma542pap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:33:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69U8XCGr47710466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 08:33:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0C8D20049;
 Fri, 30 Oct 2026 08:33:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8102A20040;
 Fri, 30 Oct 2026 08:33:09 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.4])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 08:33:09 +0000 (GMT)
From: Dhruv B <dhruv.b@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com
Subject: [PATCH v3 0/2] drm/amdkfd: Add support for discontiguous and CPU-less
 NUMA topologies
Date: Fri, 30 Oct 2026 14:03:02 +0530
Message-ID: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: merKYby3f__nvc2QNVkuWAhaP2kLaAki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX0CG6OPSEFYo8
 rO3Bt9TY04As1PjQDRq+LBbdQwANbG96hZDbvQyzPpMiL7F/rOjrBzmZ3TFHRsySyhycfSXTFpx
 i23eyMeUsFTgGUgbn2LM3fuOCnTIGMZ5NkuNxy89U3nmeoSRZHXEi29I/x4U+Xj+1EVbdIspP8z
 VzWyeA3JZrUJJouYFKQcqyeNnObDbENUf28vLaDSrI+yZH7IjicpuhA7yXw6V8d7+NsAsaapcuI
 Is2aIPoJdcMhRVnWYFj1TLT7hoHdUzY/n66vC72KtQSZ6xeYassnyGq0hNLfAwdqA+YB4QB04mM
 4sJBCTS9b7Wiyi8ApY+zFs+XoO70ay5xIT1A+41xCQ5bnVZ14HbqoxK0I37Hw8CzUWFha8tFbKc
 JHJpBM7JFXzmO3dI6vBoiEt0/X+C7IYpCuFo8rbqBcnlPZ5rImD0PNeNOsRhEDnU6tzeCqebFKP
 CwNLREAGIPh6GHOy6Kg==
X-Authority-Analysis: v=2.4 cv=Ms3HeGae c=1 sm=1 tr=0 ts=6ae4564d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K-omiuHvK0rvsS5rvXwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX9e5mnF/jZxy3
 7uiPMXO/1FK7anHX1jdAGLLXTb7WVI05Nfg7xhyidUhO9jHrlZeYjU85oxF3hDdivCana4FBhQ0
 WqVjzdg+z5KAM0VFDrBcEmlkHYmlQq0=
X-Proofpoint-ORIG-GUID: bgG50Yeb_8oD-OcPCs6WF7HCpxzxRuUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300032
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:13:37 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes VCRAT generation in AMDKFD for systems that do not
provide a CRAT table and where the driver generates a Virtual CRAT
(VCRAT) for the CPU topology.

The current implementation uses for_each_online_node() to iterate over
NUMA nodes and assigns proximity domain IDs sequentially (0, 1, 2, ...)
regardless of the actual NUMA node IDs. It also assumes that every
online NUMA node contains both CPUs and memory, unconditionally
emitting Compute Unit and Memory CRAT subtypes for each node.

These assumptions break on systems with:

  Discontiguous (sparse) NUMA node IDs
  CPU-less NUMA nodes
  Memory-less NUMA nodes

For example:

  available: 3 nodes (0,2-3)

  node 0: CPUs present
  node 2: CPU-less
  node 3: CPU-less

In this case, the existing code iterates over nodes 0, 2 and 3 and
assigns proximity domains 0, 1 and 2 respectively, instead of 0, 2
and 3. The mismatch between NUMA node IDs and proximity domain IDs
results in an inconsistent KFD topology and causes topology parsing
to fail with:

  amdgpu: Virtual CRAT table created for GPU
  amdgpu: Error parsing VCRAT
  kfd: amdgpu: Error adding device to topology
  kfd: amdgpu: Error initializing KFD node

To fix the proximity domain mismatch, the VCRAT generation loop is
changed to iterate over the complete NUMA node ID range up to the
last online node, incrementing num_domains for every node ID in the
range. This preserves a direct 1:1 mapping between NUMA node ID and
proximity domain ID, while skipping resource entry creation for
offline or unpopulated node IDs.

To fix the unconditional subtype emission, explicit guards are added
so that Compute Unit entries are only written for nodes that have
CPUs (kfd_numa_node_to_apic_id() != -1), and Memory entries are only
written for nodes that contain memory (node_state(numa_node_id, N_MEMORY)).

Additionally, kfd_parse_subtype_mem() is updated to use simd_count
instead of cpu_cores_count to distinguish host nodes from GPU nodes.
This ensures that memory on CPU-less host NUMA nodes (e.g. CXL memory,
PMEM, or memory-only NUMA partitions) is correctly classified as
system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
framebuffer memory.

The placeholder domains created for offline node IDs have no IO links,
so kfd_create_indirect_link_prop() is updated to skip offline and CPU-less
nodes when building indirect GPU to CPU links.

On a system with contiguous NUMA nodes, numactl reports:

  $ numactl -H
  available: 4 nodes (0-3)
  node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
           18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
           34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
           50 51 52 53 54 55
  node 0 size: 881496 MB
  node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
           71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86
           87 88 89 90 91 92 93 94 95 96 97 98 99 100 101
           102 103 104 105 106 107 108 109 110 111
  node 1 size: 885640 MB
  node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122
           123 124 125 126 127 128 129 130 131 132 133 134
           135 136 137 138 139 140 141 142 143 144 145 146
           147 148 149 150 151 152 153 154 155 156 157 158
           159 160 161 162 163 164 165 166 167
  node 2 size: 885640 MB
  node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178
           179 180 181 182 183 184 185 186 187 188 189 190
           191 192 193 194 195 196 197 198 199 200 201 202
           203 204 205 206 207 208 209 210 211 212 213 214
           215 216 217 218 219 220 221 222 223
  node 3 size: 885394 MB

The KFD topology sysfs reflects all 4 CPU nodes plus 2 GPUs:

  /sys/class/kfd/kfd/topology/nodes: 0  1  2  3  4  5

  0: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
  1: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
  2: cpu_cores_count 56  mem_banks_count 1  io_links_count 2
  3: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
  4: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
  5: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)

On the same system with sparse NUMA nodes, numactl reports:

  $ numactl -H
  available: 3 nodes (0,2-3)
  node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
           18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
           34 35 36 37 38 39
  node 0 size: 519305 MB
  node 2 cpus:
  node 2 size: 0 MB
  node 3 cpus:
  node 3 size: 0 MB

After this series the KFD topology sysfs correctly reflects all node
IDs including the absent node 1 as a placeholder:

  /sys/class/kfd/kfd/topology/nodes: 0  1  2  3  4  5

  0: cpu_cores_count 40  mem_banks_count 1  io_links_count 0
  1: cpu_cores_count 0   mem_banks_count 0  io_links_count 0 (Absent)
  2: cpu_cores_count 0   mem_banks_count 0  io_links_count 2 (CPU-less)
  3: cpu_cores_count 0   mem_banks_count 0  io_links_count 0 (CPU-less)
  4: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
  5: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)

The GPU I/O links correctly reference proximity domain 2, which
corresponds directly to NUMA node 2 where the GPUs are physically
attached. This is confirmed by the io_links sysfs entries:

  node 4 io_link: node_from 4  node_to 2  type 2  max_bandwidth 10000
  node 5 io_link: node_from 5  node_to 2  type 2  max_bandwidth 10000

Both GPUs report node_to 2, matching the proximity domain of NUMA
node 2 (the CPU-less node to which the GPUs are connected).

This series consists of the following patches:

Patch 1 removes unused code in the CRAT initialization path as a
preparatory cleanup.

Patch 2 fixes the proximity domain mismatch by iterating through
the complete NUMA node ID range and preserving a direct NUMA-node-
to-proximity-domain mapping. Emits Compute Unit and Memory CRAT
entries only for nodes that have the corresponding resources, updates
the memory subtype parser to key off simd_count, and makes
kfd_create_indirect_link_prop() skip placeholder and CPU-less nodes.
---
v2 -> v3
- Addressed Felix's review comments:
  - Fixed a regression in kfd_create_indirect_link_prop(). Placeholder
    domains and CPU-less nodes have no CPU IO links, so the lookup failed
    with -ENOMEM and all indirect GPU links were silently dropped. Such
    nodes are now skipped.
  - Updated kfd_parse_subtype_mem() to use simd_count instead of
    cpu_cores_count to distinguish host nodes from GPU nodes so that memory
    on CPU-less host nodes is correctly classified as HSA_MEM_HEAP_TYPE_SYSTEM.
  - Only emit Compute Unit entries for nodes with CPUs, and Memory entries
    for nodes with memory.

v1 -> v2
- Addressed Felix's comment and fixed the incorrect proximity domain mapping
  caused due to crat_table->num_domains++ being at the start of the loop.

v2 - https://lore.kernel.org/all/cover.1791289746.git.dhruv.b@linux.ibm.com/
v1 - https://lore.kernel.org/all/cover.1791208447.git.dhruv.b@linux.ibm.com/
---
Dhruv B (2):
  drm/amdkfd: Remove unused code in CRAT initialization
  drm/amdkfd: Add support for discontiguous and CPU-less NUMA topologies

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 69 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 ++---
 3 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.56.0

