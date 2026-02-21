Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BADC61DBE
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC7910E14F;
	Sat, 21 Feb 2026 07:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="fMw8Y+UT";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F2E10E14F
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:53 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L31dP32058372; Sat, 21 Feb 2026 07:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=19+jLy
 Qm4zvsV2sS5egiKao0eNycbroVcOHWTBRuZDc=; b=fMw8Y+UT/AgKmkmCMGUh06
 iVFIVupwkHtQ3/90OQN8fcoy40IMeVp5cn78eC206qaIQZEHUm4wylph5mr0qTaP
 x1RTcVbh4FfTJIEv6ETOXHcgt4s/Bx+RKlPmr2uubRMZFQFS0bPOR+Ph7sCpjkif
 GFbix7QLJm3LRfkr+CiJZXgTQT8vBUHzLIHwGbgxNbr4G+69biyPrSIZOBXr6IJR
 g2ULoag0PkvoDtzMmAWiiYYCRYrlKB1hcqDReUbhyxem26XiCsjol1O1A7VWdfFP
 fJMHMPmxhy0v9Kd5Ym4WteqEwtJVPOs6SZ6Hg/0yEtFiRhe0rkNKKW25GOdypF7A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e30f9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L13ksr011920;
 Sat, 21 Feb 2026 07:09:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb27bdcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79kw225231770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2F9A20043;
 Sat, 21 Feb 2026 07:09:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD81220040;
 Sat, 21 Feb 2026 07:09:43 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:43 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 4/6] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for
 non-4K page size
Date: Sat, 21 Feb 2026 12:39:22 +0530
Message-ID: <009fce778133332ea29cf73b52e5b19f4dce9fb5.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=69995a3f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=8OR251-K1x8n-3lZjzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RaQWhEZ_BjzZBKDY1QTOOiFBhSUAyE4d
X-Proofpoint-ORIG-GUID: MgD2Os-i-ENPVIV2CqTkRzEIotWthvcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfX9rJdHSzN2758
 xCfUdfPRr8fD7E/7UsxJvOGW0Pf8WYNQpkQtD1B7Ny719OSxgAuNONCRUZWX3wv6ZNiJUBAw79o
 dAozHLl5VxwfnX/0SYO5P2JcLnWq4ErDj/fZWY7d4v/NOi4kc4iOKaq/wXFz6T2csowMTKPyioX
 4+st+pRl85Uknjp+1D0+rbW5USRdeo9k5INusASR0laRnNCbOWR+NqOuGNU3S1iCRhOCUl+Eq0K
 +SISuEe1qkK8BXx7XzzHHHB2F+s+sEiyUO8iDn3N0HdgPoLPEdD/tSr52aV42w09Dvk6B0QYV0C
 ikCU6+ZxelDo3d2NgSM4FnSU6KRS33LvD5tNMX8roTH8yQSN4ikMybenaFzSCiJrRDii6CVSHvj
 RrOYOTEC3715RPzsqEHvT5FOsWbi3raZhA9KQ0mBESmaCZwmIQTxaxW2XZv6iRaymEfKYxPEtY2
 LNxhAyJt/Zcluz97/5A==
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

