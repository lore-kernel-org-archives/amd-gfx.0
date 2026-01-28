Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E74D3F080
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 15:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F77010E2CA;
	Wed, 28 Jan 2026 15:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="tIl+cZO4";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCCB10E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 15:33:20 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9ni0O019338;
 Wed, 28 Jan 2026 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=JXHsrrsP7GaWpbEncZU2sSefidcH
 JXyyRPGxm095sSk=; b=tIl+cZO44up99+cMpSuzqlPKhbGbe4DRvklQxYzzjj2C
 J/bPBQExPALZErQINDSLlzxT0WkevO0JiRe0q9BPzko8nB8/WZca1slfTYtg6Rsv
 JAYiAftUim/pfKk9lf46WXYtofDJIGO6hphxjh1aM54pHvd6oviwXGOY5KiLiAQm
 vhnKYSs6hMoBiHKbWMmWoYMgLmXhO1TVJq0MumUVjMKp868ImewfMLNaMNceNRKX
 cKVWBoq13bcnZV18dSytgPjsbS7UdTz11FDCaYgI8UiGnnSdvuVONj+ygH+nrpZh
 wcxqlbeOb8t2Uv2duvCKKcj9VPwXEgABjIElYKVo5w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg1wep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60SFU6x5005466;
 Wed, 28 Jan 2026 15:33:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg1weh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SB0950006687;
 Wed, 28 Jan 2026 15:33:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sye0tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60SFXDwc46137784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 15:33:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31FC32004B;
 Wed, 28 Jan 2026 15:33:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35E9D20043;
 Wed, 28 Jan 2026 15:33:10 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.124.209.179])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Jan 2026 15:33:09 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v2 0/5] drm/amd: Add support for non-4K page size systems – part 2
Date: Wed, 28 Jan 2026 21:03:01 +0530
Message-ID: <cover.1769612973.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697a2c3e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=4uLO6Mwu6PC_-4MHj0cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: CJErqmmh64_XGJRgLqt1v6ivhyKGS-nJ
X-Proofpoint-ORIG-GUID: bdcV5fV5-oTyjdGWVVBGWjXviZXVycCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyNiBTYWx0ZWRfX9HmVGIMwNl0w
 oPRev1K8/KE1J0BBQKULKrC1uWOGIMug5y4J+/mVoBWn1n/WlCQ7ojk7V6ZXpNyhUDMfuua5Uqn
 KRG84RAl3SEPovc3tlpep2dCzo0WDMUywmu1netqIKHi+xAgGoKtPKpX7nX9N1Ag/89bcRGL9UV
 LVnPbqnQrBaXWsiAdn4n7qEMoKW6CDg3k9Q9U/ha721ctXDHKGAm3C8sqpsTCipFEZo1tZjRev7
 DEIWvw9ubzhNU2bxhetGyVFLvASTJ6H5rA7Eeq4EAX2uvgruPmS5VE7zuWxpkhk0P536kHReaWM
 Dsagc972p11hsLZy/FbdsguiQuHx+gJRSpQrCDGLSDmZkzNFNLeDXlHyWv8tlC8bvl+7OUatOgn
 aFc/ehejrRsPLt6LSECCWitbTR38mK6gqqWs6Rt+InI9mmJLBD1X+F7gqXcf/6z0l2HbtGjuqZn
 qXIBafj1CGZpQQmhDsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601280126
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

This is v2, part-2 of the patch series for enabling non-4K system page
size support in AMDGPU. v2, part-1 of this series [1] has already
been picked up for the upcoming release.

This second part addresses additional issues uncovered in AMDGPU when
running rccl unit tests and rocr-debug-agent tests on Power platform 
with 64KB system pagesize.

With this series applied, all RCCL unit tests and rocr-debug-agent
tests pass on systems using a 64KB system page size, across
multi-GPU configurations, with XNACK both enabled and disabled.

Note: 
We believe Patch-1 in this series i.e. 
     drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE
fixes a kernel crash observed when running rocminfo on systems with a
64KB page size. So if you think, patch-1 looks good, then can it be
picked up indepdently of the rest of the series?

Because then, this patch along with previously picked up part-1 series
would allow amdgpu driver to work on non-4K pagesize system with at least
a two gpu configuration.

The questions we had for the rest of this seres are:
====================================================
When the control stack size is aligned to 64 KB, queue preemption or
eviction failures are consistently observed on gfx9, on both 4 KB and
64 KB system page-size configurations.

The control stack size is calculated based on the number of CUs and
waves and is then aligned to PAGE_SIZE. On systems with a 64 KB system
page size, this alignment always results in a 64 KB–aligned control
stack size, after which queue preemption fails.

1. Is there any hardware-imposed limitation on gfx9 that prevents the
   control stack size from being 64 KB? For gfx10, explicit hardware
   limitations on the control stack size are present in the code [2].
   Is there anything similar for gfx9?

2. What is the correct or recommended control stack size for gfx9?
   With a 4 KB system page size, the observed control stack size is
   around 44 KB—can it grow beyond this? If the control stack size is
   fixed for a given gfx version, are there any concerns with aligning
   the control stack size to the GPU page size?

Changes so far in this series:
==============================
1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB, while
   KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. This matches on
   4 KB page-size systems but results in a size mismatch on 64 KB
   systems, leading to kernel crashes when running rocminfo or RCCL
   unit tests.

   This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
   that the reserved trap area matches the allocation size across all
   system page sizes. This patch is required to enable minimal support
   for 64 KB system page sizes.

2. Fix the AMDGPU page fault handler (for XNACK) to pass the
   corresponding system PFN (instead of the GPU PFN) when restoring
   SVM range mappings.

3. Update AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
   across all system page sizes.

4. On systems where the CPU page size is larger than the GPU’s 4 KB
   page size, the MQD and control stack were aligned to the CPU
   PAGE_SIZE, causing multiple GPU pages to incorrectly inherit the
   uncached (UC) memory attribute.

   This change aligns both regions to the GPU page size, ensuring that
   the MQD is mapped as UC and the control stack as Non coherent (NC),
   restoring the correct behavior.

5. Queue preemption fails when the control stack size is aligned to
   64 KB. This patch fixes the issue by aligning the control stack size
   to the GPU page size.

Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
Name:                    gfx90a
Marketing Name:          AMD Instinct MI210

[1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457

RFC V1 - https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/

Donet Tom (5):
  drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
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
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  7 +--
 9 files changed, 80 insertions(+), 33 deletions(-)

-- 
2.52.0

