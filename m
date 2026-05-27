Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145CCCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800DD10E23F;
	Wed, 27 May 2026 11:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="V2H7NBZ9";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B16010E23F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 11:18:05 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QL4UTn3594574; Wed, 27 May 2026 11:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5xjafkb7sBA6QP4WoEtqLrMnANaz2n5CMt/noem0p
 TA=; b=V2H7NBZ9WAyJxhU2olI92eQxdrVvX+6BfMR0qqBQVn01ha66xTo66fzJc
 C0lWRaJ/imPSQ94HLmYhbXUh0jXeUYG4NjCUiHA/Zij2/1N9llYW5LncHkGn9jXe
 efNxdkmhTsESchYoqND0yddNeVPudwWijVwsm37BkndtkVtnkEMT0qUavIn5rh86
 7Rsxq5AjW4ZuUYscfNyG09Jyu/7RX2h2cinB0Z2FvhOAx/6uUlAl1YVGpdHIBTYt
 /q97aoKoI7MyuMc2DGObddX2bNRspSXz1E0mnaIDY8EE3G590P5XwI5uPN93rb0I
 +m4r7kGvNY+kkBygV+PEirxDzIALg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2gxuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 11:18:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RB969a005099;
 Wed, 27 May 2026 11:18:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb2q3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 11:18:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64RBHvqP30212586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 11:17:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D6820043;
 Wed, 27 May 2026 11:17:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFCF420040;
 Wed, 27 May 2026 11:17:53 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.20.122]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2026 11:17:53 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
 timur.kristof@gmail.com
Subject: [PATCH v2] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
Date: Wed, 27 May 2026 16:47:50 +0530
Message-ID: <20260527111750.1084088-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oGRCi6Bpda83vHsoUjzFZBky6Gpl6sAf
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a16d2eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=n88roBbitPJnb_ZC6A4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEwOCBTYWx0ZWRfX1klgxZy0tspy
 n5a0W0fN86c+xARHIk7wk60oE87LlxbQvCCo7S4z1LOaVz/bo/Kh9E/ZwHp0qJXU3sTSggEWRlc
 e5ovJZUoxBJheBEB9nUXohfhi7LWSiuoEzBeZqlVjXtWmjsB7+EfViHhkFsvfSi4TjXug8U+t59
 xAjWHpsxAnpPhmWLiStX1vBrBODpDKTvA8hTsl6SbZKe/EsPUpM9+/uH8j2vS2LvAc3XG0Js/F0
 uOTY57tbhtbRtKNNHXK1N+FWeKagm3fzhZi0cWcvC31H9K+5bwY/lP6ykHoHOXI8jxjTcsthcPK
 L2CSy/OloW5skLYbG+2GFCm6WJ9udVcsWAYurkagxYcNzEG0I8eXG2TslRwMQK0w+0ns+CG+xeh
 gVNnKa1a3YgbC5Dg4e7kCbHmoXDcSYU5zAIlaMy52ixx7H4Z/073I55oSgLlTHvubVvIwK9lBHk
 03nScFJ0T6v2lOLX+ng==
X-Proofpoint-ORIG-GUID: eSHmWSAwDIs4vlRVTC_qqhN-l7Z_DllO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270108
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

When mapping VRAM pages into the GART page table,
amdgpu_gart_map_vram_range() assumes that the system page size is the
same as the GPU page size.

On systems with non-4K page sizes, multiple GPU pages can exist within
a single CPU page. As a result, the mappings are created incorrectly
because fewer page table entries are programmed than required.

Fix this by programming the mappings correctly for non-4K page size
systems.

Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
v1 -> v2
- Addressed Felix's comment by updating the definition of
  amdgpu_gart_map_vram_range() to support non-4K page sizes.

v1 - https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index b6f849d51c2e..66a15ee13b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 				uint64_t start_page, uint64_t num_pages,
 				uint64_t flags, void *dst)
 {
-	u32 i, idx;
+	u32 i, j, t = 0, idx;
+	u64 page_base;
 
 	/* The SYSTEM flag indicates the pages aren't in VRAM. */
 	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
@@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
-	for (i = 0; i < num_pages; ++i) {
-		amdgpu_gmc_set_pte_pde(adev, dst,
-			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	page_base = pa;
+	for (i = 0; i < num_pages; i++) {
+		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
+			amdgpu_gmc_set_pte_pde(adev, dst, start_page + t, page_base, flags);
+			page_base += AMDGPU_GPU_PAGE_SIZE;
+		}
 	}
 
 	drm_dev_exit(idx);
-- 
2.52.0

