Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCD4CA6004
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9197610F220;
	Tue,  6 Oct 2026 07:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="G8891UQP";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FC210E5D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 14:00:44 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZTcI3033289; Mon, 5 Oct 2026 14:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KIYR3c+bnN1HCsBEqwBC/lIHrtDY2MmPT0yVU0BX6
 VI=; b=G8891UQPbiSsQYonUEmhrLAuM2IGPzbc8xVSmyWmK0l9vmkOjK1t+xRLM
 othcduL2bQiHsdDoJeSKiF8Kctb9WAWAFcsWxjo1uWtvclEDUyPx81EwkLc8r2bC
 bwHSaJL0I1A78czIV9n8CBgYWrjPvFnmzwtkw0NGE77PZZaXeuA0QsWuaMzt29Mi
 oer4/IiW/79lq1Jwj7dN94h3Qf5QB4EWB+nsA5Ev1Hnnz4F24k9YBOiJGU6GlFHJ
 xRWF2m8xLYGdm1JVCTWp15d1dGgunl0U8XX1qlPMJIhwfBymRGXQ1FZPi7Oa8FMF
 xNUFbYsFX/xpDCKjD6/Wq3RzQ4eQw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrakxg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CWlO92894074; Mon, 5 Oct 2026 14:00:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvnts6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695E0axL31916648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 14:00:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0056620043;
 Mon,  5 Oct 2026 14:00:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38D5F20040;
 Mon,  5 Oct 2026 14:00:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.115.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 14:00:33 +0000 (GMT)
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
Subject: [PATCH 0/3] drm/amdkfd: Add support for discontiguous and CPU-less
 NUMA topologies
Date: Mon,  5 Oct 2026 19:30:20 +0530
Message-ID: <cover.1791208447.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX+uoLKtaT/6Q5
 8ZLwRJFG4tzguD6WY6F6o4YLlYm65+xL5D8JGSoAV3KiFf7cEiwdhHPtFnpHC+uojJNLpdnMmAz
 7osJhSYLQh70Zs84HRaWKgNk179WZ7M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX1Cdlc8u7W4wB
 E+655FqKUz4VKIGCyuPg9v/b2RWzxvkNcjNEGEBSvdHqzlPGZvL6GgGtEG9PhiTBoYYpRoDkPPG
 e1+3aHI0tr8m2kAWsucPhtAviCiDQUBC/J/rcW2RiiZEbHoVdtCqdqOjUmwg5Hfd4SRwZ/Hrm/0
 5HpRXxlj/mmN1z3XXvY2n+8E4HV3Z3zZulI9knA7+WeOKjFi0li7KY1vHSXDYa4T/gtAZjrZgE0
 Sv+7dZQb08rJyFZsw5ZrOiF5Pwcw+o/2vCNuYxXI7zc6itmDloaZTUO9dMVKEV1F/NQ4vcm86Ym
 W2/a6ZRDEovi5gi0w4795c7Mf4OSp0CK8DgkXOrUEyJExrTcYKr73IlBYf2W7WkYIa3DtGD7LtN
 JC24QPv9SErlbiMQ+Rlrp8YKI5Z+9MC+Mpbgrx/a0swd1fRpcz3b4CCLf2ejU4Y5QgyLSXvt6Sc
 osfV9Gzo/vYKN5Hqe0Q==
X-Proofpoint-GUID: 05ikkrIyxUPNWoVcQCqauvJ7_04xQUvi
X-Proofpoint-ORIG-GUID: IlnQ67EoCVVXor1HMGqc5V7807S-bVeN
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3ad89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=2T2nS5HjsIvHWfO5MkkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050053
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:35:16 +0000
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
regardless of the actual NUMA node IDs. It also assumes that every online
NUMA node contains both CPUs and memory, unconditionally emitting
Compute Unit and Memory CRAT subtypes for each node.

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
results in an inconsistent KFD topology and causes topology parsing to
fail with:

  amdgpu 0038:12:00.0: Error parsing VCRAT
  kfd kfd: Error adding device to topology
  kfd kfd: Error initializing KFD node

To fix the proximity domain mismatch, the VCRAT generation loop is
changed to iterate over the complete NUMA node ID range up to the last
online node, incrementing num_domains for every node ID in the range.
This preserves a direct 1:1 mapping between NUMA node ID and proximity
domain ID, while skipping resource entry creation for offline or
unpopulated node IDs.

To fix the unconditional subtype emission, explicit guards are added so
that Compute Unit entries are only written for nodes that have valid CPU
cores (kfd_numa_node_to_apic_id() != -1), and Memory entries are only
written for nodes that actually contain memory (node_state(N_MEMORY)).
This prevents invalid or empty CRAT subtype entries from being emitted
for CPU-less, memory-less, or empty NUMA nodes.

This series consists of the following patches:

Patch 1 removes unused code in the CRAT initialization path.

Patch 2 fixes the proximity domain mismatch by iterating through the
complete NUMA node ID range and preserving a direct NUMA-node-to-
proximity-domain mapping.

Patch 3 restricts Compute Unit and Memory CRAT subtype entries to NUMA
nodes that actually have the corresponding resources.

Dhruv B (3):
  drm/amdkfd: Remove unused code in CRAT initialization
  drm/amdkfd: Add support for discontiguous NUMA node topology
  drm/amdkfd: Restrict CU and memory entries to resource nodes

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 61 ++++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +---
 3 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.54.0 (Apple Git-157)

