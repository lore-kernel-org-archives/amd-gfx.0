Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E961D3F080
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 15:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E2A10E720;
	Wed, 28 Jan 2026 15:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="purEtNZ/";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831F910E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 15:33:39 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S7TQ2o024275;
 Wed, 28 Jan 2026 15:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qWFtLz
 KPBvMomMkzBgtCJf3o7Prd244o7gLOO3AUrBU=; b=purEtNZ/FHt1SM4euzWJs6
 R0CPZYA7uSEgOnI45sbx7BDwUTnNAUG2n8ssiKeP4qTRsvSOLDRfEg9HoNiGBJBK
 DzjD+931KyrH5ouvhUCKJzPS7P1Pkt2zv3Zp0sKhf9QvjqlChaK9vJf88O0LxPfd
 QRKfRVCdZm2oPqH3Vok2UFeyHr365w9Dr0No6oo8qLNtcGBt6cA4H+ejwSI0SuzF
 cEvNtJhKp0Xtl2iGORQRTlqzUb5gL1Bo02GHBD5a/qXcvuJ1DjSuLW39AN6r8yPj
 RDDsOZtFAigO3qmZWyznh8fMF+q2szrf5n3MPu4V80+njMwdVZOXPur7VseYjdxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7v5nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60SFR9Gk021932;
 Wed, 28 Jan 2026 15:33:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7v5nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SB0956006687;
 Wed, 28 Jan 2026 15:33:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sye0vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 15:33:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60SFXVgO41746760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 15:33:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B778420040;
 Wed, 28 Jan 2026 15:33:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDD1120043;
 Wed, 28 Jan 2026 15:33:27 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.124.209.179])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Jan 2026 15:33:27 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v2 3/5] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for
 non-4K page size
Date: Wed, 28 Jan 2026 21:03:04 +0530
Message-ID: <8230bc5b6d1aa9d4a930af4301fa2e98a4422a9c.1769612973.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769612973.git.donettom@linux.ibm.com>
References: <cover.1769612973.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9x37EKix4mUjbSjpkUM6id-CkKUDaFds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyNiBTYWx0ZWRfX8o13oVeAHPko
 BOrUGhYUvNMz5DhR9VVVk3rac2PibQUezv6rSqq2buO1jGDAJ1Pq/bhRPmIiy3bRI/jeAOHauaQ
 73tsY10q038v32OBXmRjwOqOya410HfBhsG9gWpSNCEFxkI3AFpmEsNBTlD4RTjj2bYrVb9TgNy
 OoP+mrpJ6zQ3ourxR1RMZKaT24AcHBkE/sp6/9N2nSnI+cXjXvPCw5AbujJgM3zxbkdckgQGM8i
 F2qSIweDlwP0A5TbaElgsX3Pwm+Lli7KrVjvp39urnokVc9MT39gCt61wooGP5cYm2sj8oPZPLO
 mC79oIwYKJkIdsN0sFJsMI8nCNgo8LwAAqJ1TIdK2MJh+gHIWYt7PyRLhuHMiCpIyiaUPyUOV2L
 JZMcbivF8XE68tbSAPXxM7rz6Js16tsnvAfS95FDdPF8tyYom6VoEi39IrpKyBdLoTpQRIK0IDi
 eX7UaFHUbPaO1vyhAmA==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697a2c51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=8OR251-K1x8n-3lZjzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l3DRVeC9iXcHfmS6McX-q94hMxNxPJ3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
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
index 2b931e855abd..e4a11944a1fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -191,7 +191,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	int r;
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
-	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
+	       AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8);
 
 	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
 		return -EINVAL;
@@ -217,7 +217,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 
 	*addr = adev->gmc.gart_start;
 	*addr += (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
-		AMDGPU_GPU_PAGE_SIZE;
+		AMDGPU_GPU_PAGES_IN_CPU_PAGE * AMDGPU_GPU_PAGE_SIZE;
 	*addr += offset;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
@@ -235,7 +235,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	src_addr += job->ibs[0].gpu_addr;
 
 	dst_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
-	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
+	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
+		AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8;
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
 				dst_addr, num_bytes, 0);
 
@@ -256,6 +257,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	} else {
 		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
 
+		num_pages *= AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 577ee04ce0bf..d9020a60c13e 100644
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

