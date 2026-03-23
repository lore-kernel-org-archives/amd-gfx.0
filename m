Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44ECD58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1697510E07D;
	Mon, 23 Mar 2026 04:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="s+/1moVr";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C48910E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:28:53 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MJTEqZ504443; Mon, 23 Mar 2026 04:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=aodonUlTWkE13/tw1TybL98nBdgq
 di2v6CMTDCInby8=; b=s+/1moVrpBMcech8hdllyVTxM1C1/QZWC06q/YTi/YeT
 pS9Qbv1/+RcmpV9EsB3sFbMVewvi0SEXumB9xqRbNVl/Q+rhVwgVQU+WO0vnNCqp
 1VOAv/XGyAPUMfL4ix/yWkR8akHYlIq5wLeNhGOv4Q+X0+I+0LJfPWSiAnRkz2Kd
 3KVJSGCh6H+OhsE6s489G5H6bT5OJa0PWQWjbLGVv8y0INnS+3w90g8GDsvZ9491
 kESbUJAiUnDLl4N5Ju1ctaPTCq2zppWM6XT3FxcPdR7tiWqPwQD+Gt0FYNw2bHA1
 xcjHcgWoxUGu09d3WGhrQ2Dvqb7RPzqSG5RxIoZb8Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq5c6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N2MD5f012185;
 Mon, 23 Mar 2026 04:28:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjusk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4SjHb49873292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:28:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B354220049;
 Mon, 23 Mar 2026 04:28:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 496632004E;
 Mon, 23 Mar 2026 04:28:43 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:28:43 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RESEND RFC PATCH v3 0/6] drm/amd: Add support for non-4K page size
 systems
Date: Mon, 23 Mar 2026 09:58:33 +0530
Message-ID: <cover.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Zc8w8p3KHAfWbFS57SUY2phfvQEKNq3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfXwkhCK05sq/ml
 TDNKX3z8FB+j3ntZki2hhDtXVB9HhnknlHBS2Bz3coJ+ChSaF9ilMwzqaiXhgXbYxSvtEaflbRh
 yIovmLoi/9krb7obSEgIsAiZoyuMurXh6l8hsHCys+yxgajZKgP08knWd/wrrdhQzdnz1/si6yn
 +Rh+5YOMqcMaoQG0N+qT+XM2QY0aMu50EtBWpMXQSptnzDfxxWm4F4RCjYH+CPX5EpYB+nBpLPD
 ARsOyXwDuJZFnjyqrnQdXklQJiF4+iyWE5ZX9/efySn7lJmUck/vnzMWqGAurKqok7tCec40k6r
 XLKNuSlVeQSf7RleeI7xZxL57eJYmSNStBWPwZ6r5oshxst3twXS0NJthadwYSoccvc3sFcqLmV
 cbVD1/zibaZAPUgdyA4AkSNCV7yyiQtjsi3I5+ysk8Sn9aCXU/rPGR0VtaIkY+cp3jL4ONU5r8u
 /HCNTxC7n9Ky+4H+P6w==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c0c183 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=OJEFjdw1ULjcDAQblwcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: QC6_mRD53vN-jv9egF9PHl_BjYY19LiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230030
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

This is v3 of the patch series enabling 64 KB system page size support
in AMDGPU. v2, part 1 of this series [1] has already been merged
upstream and provides the minimal infrastructure required for 64 KB
page support.

This series addresses additional issues uncovered in AMDGPU when
running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
systems.

With this series applied, all RCCL unit tests and rocr-debug-agent
tests pass on systems using a 64 KB system page size, across
multi-GPU configurations, with XNACK both enabled and disabled.

Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
on systems with a 64 KB page size. This patch is required to enable
minimal support for 64 KB system page sizes.

Since RFC v2, we observed AQL queue creation failures while running
certain workloads on 64K page-size systems due to an expected queue size
mismatch. This issue is addressed in patch 2 of this series.

The questions we had in this seres are:
=======================================
1 When the control stack size is aligned to 64 KB, we consistently
  observe queue preemption or eviction failures on gfx9, on both
  4 KB and 64 KB system page-size configurations.

  The control stack size is calculated based on the number of CUs and
  waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
  system page size, this alignment always results in a 64 KB-aligned
  control stack size, after which queue preemption fails.

  Is there any hardware-imposed limitation on gfx9 that prevents the
  control stack size from being 64 KB? For gfx10, I see explicit
  hardware limitations on the control stack size in the code [2].
  Is there anything similar for gfx9?

  What is the correct or recommended control stack size for gfx9?
  With a 4 KB system page size, I observe a control stack size of
  around 44 KB—can it grow beyond this? If the control stack size
  is fixed for a given gfx version, do you see any issues with
  aligning the control stack size to the GPU page size?

This series has 5 patches
=========================
1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
   KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
   4 KB page-size systems but results in a size mismatch on 64 KB
   systems, leading to kernel crashes when running rocminfo or RCCL
   unit tests.
   This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
   that the reserved trap area matches the allocation size across all
   system page sizes. This is a must needed patch to enable minimal
   support for 64 KB system page sizes.

2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
   failure.

3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
   system pfn (instead of gpu pfn) for restoring SVM range mapping.

4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
   across all page sizes.

5. On systems where the CPU page size is larger than the GPU’s 4 KB page
   size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
   causing multiple GPU pages to incorrectly inherit the UC attribute.
   This change aligns both regions to the GPU page size, ensuring that
   the MQD is mapped as UC and the control stack as NC, restoring the
   correct behavior.

6. Queue preemption fails when the control stack size is aligned to
   64 KB. This patch fixes this issue by aligning the control stack
   size to gpu page size.

Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
Name:                    gfx90a
Marketing Name:          AMD Instinct MI210

[1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457

RFC V3 - https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm.com/
RFC V2 - https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/
RFC V1 - https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/


Donet Tom (6):
  drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
  drm/amdkfd: Align expected_queue_size to PAGE_SIZE
  drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
  drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
  drm/amd: Fix MQD and control stack alignment for non-4K
  drm/amdkfd: Fix queue preemption/eviction failures by aligning control
    stack size to GPU page size

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
 9 files changed, 82 insertions(+), 35 deletions(-)

-- 
2.52.0

