Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17696CA6004
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A635810F5A3;
	Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="lIt8skck";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A4610E031
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 12:51:40 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BZYkM3473981; Tue, 6 Oct 2026 12:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RJ2Fjok6almPgGIgqOSysslRh6dhI13eGzSG4tU+H
 bA=; b=lIt8skckpk8wktofITbc/ji/nvgEE5EFtctp9i59mxymix0U0AwYTY0Vn
 HKVWv6MnvEPUY4keR/Voeg3rmbDEB/6RbCE6cwI8Baq1SJk2PNAd5Anj00MEeSkM
 I+Ur+k9IXsbwoqgPr6lNUMIUXsi1oYUe/h6l0fkdc0Cvtf0a18eRqp0Fuvpx+Gwt
 zU79tNZuMlWfLLoNZ0Rxxp//H/a26K58MdD6L9GLWgT0Ldrd3I0QJx6avHTgYPkY
 xnrwumXRLKMYOCS3NofDrwOJR4oqEEjIATnPAaufPiEl6rl+5we3xHIml6Bjzhx/
 Lfr7cq3q6STcwbHxAni6QtuX2PypA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jqf9a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BWYPG203598; Tue, 6 Oct 2026 12:51:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsx19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696CpWtT33751370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 12:51:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 985A72004D;
 Tue,  6 Oct 2026 12:51:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 503C620049;
 Tue,  6 Oct 2026 12:51:29 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.4.213])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 12:51:29 +0000 (GMT)
From: Dhruv B <dhruv.b@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com
Subject: [PATCH v2 0/3] drm/amdkfd: Add support for discontiguous and CPU-less
 NUMA topologies
Date: Tue,  6 Oct 2026 18:21:21 +0530
Message-ID: <cover.1791289746.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QTQjdcUuKLBsofCZWG_pmN-FFLiU3rBL
X-Proofpoint-GUID: RvFrKrgqtnLIe0o1jx5e2CCDvwR3lPcE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX+OkP/hHAuZ4x
 5nz3ng29ZVG16/mY5vD+7KwaHD4tWdz0D6GneBdg/Spmo1yAjPTOvMGaC0qTS5dxz7hP6sC1eOY
 U+SP/+SpPr2A79SQwPpT1QCVmd3EH5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX80AyHs3LnGqC
 rDwgsH7KsRv3F9yey+PM2oixIiir87vxpioKf2ZS2QFPBJeN/S/flhq1HyPSU3ByV4PgKkvkA4x
 Cs1LQrVTdcwEbJ5YiQpaccpVZ85lDB6O8e2pY2X5unwodRUFeZFcOnzi5jhmVAboGJrXRmf6bbc
 LqQnikX57WyIC4UusXVPxXvkAKs+wXgAVIvvKocO/W5l68Xiz5bqsHdglii3MN6T99Fl0UFsCMA
 kOmEJKU+bxEeNwAjPOA9Dx18UdVdccxhHQhD+u0MmIr6OLB8+4UkwDMclBe95Vr8Kc0WS1U9kLo
 Ip6MJmsNGmEK8laaGeRHMX2PPHjr6KRhlA5zTRHXUvo62bRcjNGG+F1sEPMdKfwovlHUnvhL/hI
 sFJM4fmC0pTpiHyVownWihvgPDOzkabqtP+fgvZ5ZHfKYyKkDKwGc8LXFrfQdPLrqRd82kqcU/k
 19iaeQ+GaQuuZ/OByJw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4eeda cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7NOnr3KcR_XrSfShZVUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060050
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
valid CPU cores (kfd_numa_node_to_apic_id() != -1), and Memory
entries are only written for nodes that actually contain memory
(node_state(N_MEMORY)). This prevents invalid or empty CRAT subtype
entries from being emitted for CPU-less, memory-less, or empty NUMA
nodes.

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
  1: cpu_cores_count 0   mem_banks_count 0  io_links_count 0 (Absent node, placeholder domain)
  2: cpu_cores_count 0   mem_banks_count 0  io_links_count 2 (CPU-less, GPUs attached here)
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
to-proximity-domain mapping.

Patch 3 restricts Compute Unit and Memory CRAT subtype entries to
NUMA nodes that actually have the corresponding resources.
---
v1 -> v2
- Addressed Felix's comment and fixed the incorrect proximity domain mapping 
  caused due to crat_table->num_domains++ being at the start of the loop.

v1 - https://lore.kernel.org/all/cover.1791208447.git.dhruv.b@linux.ibm.com/
---
Dhruv B (3):
  drm/amdkfd: Remove unused code in CRAT initialization
  drm/amdkfd: Add support for discontiguous NUMA node topology
  drm/amdkfd: Restrict CU and memory entries to resource nodes

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 60 ++++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +----
 3 files changed, 35 insertions(+), 38 deletions(-)

-- 
2.54.0 (Apple Git-157)

