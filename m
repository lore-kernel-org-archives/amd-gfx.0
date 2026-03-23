Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E12D58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728FD10E2FA;
	Mon, 23 Mar 2026 04:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="XFI+fxxs";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AD710E2FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:29:05 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNhBhH665898; Mon, 23 Mar 2026 04:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=19+jLy
 Qm4zvsV2sS5egiKao0eNycbroVcOHWTBRuZDc=; b=XFI+fxxsxHrkfI5vZr5pjX
 Mes3kDgSYueJlBXszOPRxhtOrRbHO2Gsh8PbsBV0PtFdEsMayp8Q5yB2pKBDbCjA
 a4kjQgJLhfpqPvf2Drv+4v78xA4UklVB7kHmRlxWCRESoVl7nbuuSuNRifjziv6s
 i1uiLobsZff2SgGWHN1vLCwyaaRLKhb/zHHfA4c7skwJ6XbUbMTL3ZeVSg2ENa+m
 bZI0MVtI9GmTDwmZaBcNbcDacthB4jUxL5PZ6DBrOLCkmFDYfyrZ/nkYVHN80Hh2
 ZEaGA6gLI9Tg1q/2WrLx78ZmXJdxPGoxdD0oKbxKGf2niJBfYX0ovEs+/MNV6Rgw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9ncas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:29:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N13JNb031583;
 Mon, 23 Mar 2026 04:29:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsm3rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:29:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4SwfB29229476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:28:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56C042004D;
 Mon, 23 Mar 2026 04:28:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C10FD20049;
 Mon, 23 Mar 2026 04:28:55 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:28:55 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RESEND RFC PATCH v3 4/6] drm/amdgpu: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
Date: Mon, 23 Mar 2026 09:58:37 +0530
Message-ID: <5c4031f2858c8591f4881bfab26a2fa3edfa9be6.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: c8AbsyQNd-tZfjW_GXqzv6oiTgfGk2xo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfX+8Wuipo1447Q
 2vTd8otAaty9a7Jr2zm5c3QUL8pj77Jeu0HF4dkazOmKhk0VVm3ZtazOsagBjoZtri9h1gkyXjR
 4PyH/ZuZ3diahkircB5FegMbC24q+9JW72PQWFTRDNGdGcU0/k6eX/4UEeaJDu+FVxEnQfDmbax
 rC6MLFul44APrsfhWWpZg9jZ6RAJriDL71Hlg96zUPOxXzUEEuPQwsTes/+Oas4CrSFlLZVXT0M
 H2MABmgjbtxDblL1s9AzAW1cOqEsWOEGW1/RwbmWaovXDPYup8S1Qv2YBfcC4CE2U8MO0Xw/H1L
 F3uYrW/HR52fdPTwoi4nuQchT5JKr7cgRDVBd/AbDccRGez6P1H/0KCJWom7i+QSUpO2NJx1BBI
 LzQ60FMSwDsPJxUzv9Rbr0VL93YllzY+MR9D2U5sCemp6rD4h6xVRvSe505WrfnnofPBpjeFS2O
 4h2oScLzzB/9dIBubpQ==
X-Proofpoint-GUID: 9oGsWDvhp09vjOMy0uOIwUIUVdxZ0cot
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c0c18f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=8OR251-K1x8n-3lZjzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230030
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

AMDGPU_GTT_MAX_TRANSFER_SIZE represented the maximum number of
system-page-sized pages that could be transferred in a single
operation. The effective maximum transfer size was intended to be
one PMD-sized mapping.

In the existing code, AMDGPU_GTT_MAX_TRANSFER_SIZE was hard-coded
to 512 pages. This corresponded to 2 MB on 4 KB page-size systems,
matching the PMD size. However, on systems with a non-4 KB page
size, this value no longer matched the PMD size.

This patch changed the calculation of AMDGPU_GTT_MAX_TRANSFER_SIZE
to derive it from PMD_SHIFT and PAGE_SHIFT, ensuring that the
maximum transfer size remained PMD-sized across all system page
sizes.

Additionally, in some places, AMDGPU_GTT_MAX_TRANSFER_SIZE was
implicitly assumed to be based on 4 KB pages. This resulted in
incorrect address offset calculations. This patch updated the
address calculations to correctly handle non-4 KB system page
sizes as well.

amdgpu_ttm_map_buffer() can create both GTT GART entries and
VRAM GART entries. For GTT mappings, amdgpu_gart_map() takes
system page–sized PFNs, and the mappings are created correctly.

However, for VRAM GART mappings, amdgpu_gart_map_vram_range() expects
GPU page–sized PFNs, but CPU page–sized PFNs were being passed,
resulting in incorrect mappings.

This patch updates the code to pass GPU page–sized PFNs to
amdgpu_gart_map_vram_range(), ensuring that VRAM GART mappings are
created correctly.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 15d561e3d87f..67983955a124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -204,7 +204,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	int r;
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
-	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
+	       AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8);
 
 	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
 		return -EINVAL;
@@ -230,7 +230,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 
 	*addr = adev->gmc.gart_start;
 	*addr += (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
-		AMDGPU_GPU_PAGE_SIZE;
+		AMDGPU_GPU_PAGES_IN_CPU_PAGE * AMDGPU_GPU_PAGE_SIZE;
 	*addr += offset;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
@@ -248,7 +248,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	src_addr += job->ibs[0].gpu_addr;
 
 	dst_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
-	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
+	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
+		AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8;
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
 				dst_addr, num_bytes, 0);
 
@@ -266,6 +267,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	} else {
 		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
 
+		num_pages *= AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 143201ecea3f..15aff225af1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -38,7 +38,7 @@
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
 #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1 << (PMD_SHIFT - PAGE_SHIFT))
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 9ae424618556..b2d4114c258c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -48,7 +48,8 @@
 #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
 
 #define VCE_V1_0_GART_PAGE_START \
-	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
+	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GPU_PAGES_IN_CPU_PAGE * \
+	 AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
 #define VCE_V1_0_GART_ADDR_START \
 	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
 
-- 
2.52.0

