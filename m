Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3940FC61DBE
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A1410E009;
	Sat, 21 Feb 2026 07:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ooma/2N6";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844A10E009
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:38 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L30YDZ2056418; Sat, 21 Feb 2026 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=NYfuo6wUi8fXx7eJVvZfULJwxist
 ZcXAIpgPCN0SQd0=; b=ooma/2N62sN/iCZCU4jA3TmShACyRtBu4Z9tNUsB3+fB
 bYvHuYtSuyZ4Mqq39l1gQ1S28ulGqYYMNLpixmJL/PR2LXmRC9L9NydyjdXaXz5C
 WoZsbcaYp2/CF1ENWzwUi5CQGAZHawpinPfAbtQh6xDemW0DZk9xDUgZos1J5sOs
 Dgh2JlGFJ6xLBCHTgMmCLVaHzKCQPUKDhrphQh/bmuleoQlBOK92KVwwzXBIs5h4
 loYcAOz/eGqTD3DM1NFTB/KIwZkK1shKNRtVLVXg9MvBEl0JkjIzN2sWMyVh+0XH
 X3YdaWR5qt+RrwzR/SsIOFzHHQSFenDFPz0FRxxeDA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e30f92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0WDc8024414;
 Sat, 21 Feb 2026 07:09:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45kd2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79Uc046596532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD73620043;
 Sat, 21 Feb 2026 07:09:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CEF120040;
 Sat, 21 Feb 2026 07:09:28 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:28 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 0/6] drm/amd: Add support for non-4K page size systems
Date: Sat, 21 Feb 2026 12:39:18 +0530
Message-ID: <cover.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=69995a30 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=OJEFjdw1ULjcDAQblwcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: Zlqk-JXge1dzvLfUIKD2vp90rFQ16fk8
X-Proofpoint-ORIG-GUID: Kp8QgBWPGWzDaB9Y8zY_PEknjbUjjc8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfXz/DmudVhNfca
 Fb9oUnC41VQhUtxv0M/c1l+N2N0YTj8DdLQTdlA5jyUdVdv0z0Y7dFhTHUDGUL5ikW7IHmqKU2+
 y9rlNMS8+PisMjlfmiZ3GsT6BA3azRzT9SwOfYfBIkg2+Xw+etl95sPXuo0o1ClXxAxYqLXhn6a
 AvRRFwPiaPsy/fPSafmssBwtN9ac6ffRrirRynECKgin2gF9pP13/T0ZkKcDrt3sB+3LwoJZU0X
 sO6bAAoHeFqMnfmvYlpeqq6U+PRzIKSfkBhU47q6ttvDqJsivG+SYSwNXS1ICO9HXpjLrvOMLf3
 0XcAISJ0FIjnnTjM10iTgY9EHgd4PDUb3SQvTIJuR7vO3XQLthy3tgpW3iA6bpSNnoa2gYdi2Lh
 owSuEs0i1T8xYetwLRo3HxCT4b9++mxwy1JfJMOQIl4ex3FngjvNJnavHDN9vFrDOeJudy002Uo
 MaTMyAm2has/Hkmav+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602210073
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

