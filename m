Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91EE10A3D87
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541F610EA7B;
	Thu, 26 Mar 2026 12:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Mak8u9aV";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169F810EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:21:53 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q2t1M61172616; Thu, 26 Mar 2026 12:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Rc+LqE
 +GwMHrVScGpe3Jau+Wa+j+LhaXQO4EpGgYjrc=; b=Mak8u9aVy58o3z0boxYEx1
 rPxvdAGExxtcfqGPaHcXWSvtEjMxN2n3OyVlpzkm+YxK/L8uYz34yOzxF3G55JS+
 VFFDlwlZ/lwZpuSR75GKdVaWTFjS5KeecfKGiUtzGrN+Nk4j3UMl4/Pvpf8d4JC3
 UO7JxeTw5OTDruKXEQHJjkBWEm9xFvNG0n51K/7Ig0lMHGcsm4i3MArKPC006Mvl
 N6B5Q4JGxGjyTljp5T5g9R6Tm6erGb1mUZHWM4TugHRsSaq5LVwGolsBhDoroiiI
 J7L2qLrcJwmfPzxeeEqrX+/BJxeKmNtcJWbEwXX5h3jLiz7Bmvo2R2NeY8QWKb+A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumv6cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 12:21:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q7t3ci011789;
 Thu, 26 Mar 2026 12:21:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkap99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 12:21:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QCLkFx51118542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 12:21:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 703B92004B;
 Thu, 26 Mar 2026 12:21:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB3AE20043;
 Thu, 26 Mar 2026 12:21:43 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.29.115]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 12:21:43 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [PATCH v4 2/2] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for
 non-4K page size
Date: Thu, 26 Mar 2026 17:51:29 +0530
Message-ID: <b68780ba172175c68b313c48076185629fee9b7b.1774521183.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774521183.git.donettom@linux.ibm.com>
References: <cover.1774521183.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: G7l0HyERAfILM-gqtv-xSB0P9RnlJ4rW
X-Proofpoint-ORIG-GUID: 8pV_ZLtf-COyC4H4yx9sqB15TB3PswQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4NiBTYWx0ZWRfX/fs3dz3BOXaX
 zgoocsQ0f/IQgwrmhSF1rm2goQokLOOrUWAQskNl+Q4NVCJWe5Smn8YC8YdVqMLoO7NM2gjuUra
 ZoGS3rc6Ci6rQQQRno4yR6Fn1Sex4+feX4tCjZaPO15HyYJcXcsnwhsXyCYepKXXvkdHZB0Bew3
 Xqu6M4jl6kTjQbvM1ugsouSAMhAW1mOMAEwic23hF+jOmGRL02gWO7Qs47LZjd9u3q30k4kaTuY
 1NQ/nnf5nfAki6+YTpXgXj3ExEszHc1a+0TmLDMjZz5hKKWWHIQ4cUm3XhU68MrLmZRaQVNrt+U
 hmZiMb3O1M8/I8zoTViBSLzwgWVhK7s0XMQ1ijfvyeR7AWrfHKQqKSgQxK+UvR+lg645ZiOpWb6
 qhC0f4xsJj9Gybbvlw6mPFDSok398EwmQwlaBCE5ybu4WxL6dO4tiCEfQgpbYQxzaCxJvcgGrdN
 fMPAX0Fonet0qa/MG5Q==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c524df cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=8OR251-K1x8n-3lZjzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260086
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
index 0ccb31788b20..f9f534119cbe 100644
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

