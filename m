Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F710CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 07:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB30C10F169;
	Thu, 25 Jun 2026 07:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="tr0wI6UZ";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF9C10F169
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 07:52:28 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mZ312889258; Thu, 25 Jun 2026 07:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=y0u/WQTiVYBc3mGCwC6DvPC3wCAoQf71irkXV52yO
 rs=; b=tr0wI6UZY+tpvTm5kHXoPG5FzQG8IKAgWaxxuS2OezblCYDEdwNzv/KGF
 AIbCXCBIx063bBkXi2S4sxBkbBzTdbhT4E8zlc7dUi9saKLyUf3enmnpUxLGTUNJ
 pBK0KjP6uEABoSN+iQ0IMtWhbWUqD7ZPSNVUn4Ta4Wssa9x4NDNtI2Lrrho2wkiA
 evHkWcfd2Amm2zUWkKcnpiy5h6Ylb4RVyxijRVqJ5/e27Ssd2jiubJP1LZkhquc5
 Ve1RRDnHZGXshuC2iOU43KXTcJzOjjWkafc02xNU4AqnhWsGLCwbvagBchu13daV
 hG0Yx1nOy6B+gsceaE0L9YOav5C1A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt0816-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:52:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7njr9003653;
 Thu, 25 Jun 2026 07:52:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66kd2x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:52:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P7qL3Y13762950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:52:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D79162004D;
 Thu, 25 Jun 2026 07:52:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B30942004E;
 Thu, 25 Jun 2026 07:52:17 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.124.222.69]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2026 07:52:17 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>, pierre-eric.pelloux-prayer@amd.com
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [PATCH] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K
 systems
Date: Thu, 25 Jun 2026 13:22:06 +0530
Message-ID: <20260625075206.1105650-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX2j71QETiAB7s
 sf/ycKWy0vYBbfa4Tdr5dkcDlmmGKhH/CpAfq0q4bLEtBjETcW0PX0R6oNk43HFl5YPhZRkkyQk
 oXDaaHUqwX7ifKQMKI5bBgMvEawFiE9RL0+ZxeKHi4VDUHYNJYv3IwTJi3Y+5kPLM9VNdvXzpf9
 V6YV+jn0OGHNOtpmKrYemKl6Gs2/QG/FZKHLQCTcWXDwN1GA+IcPtZHfKZTXlCcgLFxfQ/f/H1q
 S0KRjy+gsy9i4lVkxwgTuel/GJjhEqrccZsHsG+wsfDTnnQB72FPQFBEn8z4Al5hSBF68sKu+M6
 WJI50Ie2yOI5tre0G3+vr7IN4/XWmmmxwO3OTpbxe1Mn7SiMT2Ud4VJsAoyf9nEmZlLA944UP/O
 5DdqoRq34f2co6Al3Tq88TE4+pK0RTo0qWMQdvkYGG2vv7HE4V4nmBi/lDVkTsI2otceyFwBCc4
 dRdaww/b41+7m1jCFSA==
X-Proofpoint-GUID: RRfEDZhvigWHDvxID_uabathswkjEhSI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX3xhQMrqdaFA9
 cTarE/RwwOZncNVuZeRt+8StpnlK0nVZ6KrmF3oLUfah0eDgc+BxKOhmqjeSBT8gEvtwsHB2SSK
 kwGNbBjJuHXABKytpq6GwTyz65HmOeE=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3cde3b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=9GqvVxz53e6ScOHA3rkA:9
X-Proofpoint-ORIG-GUID: lJEtgTi_mQykVP04mSZprjG0B29wploY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250066
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

Running RCCL unit tests on a system with a 64K PAGE_SIZE triggers
the following warning and causes the test to terminate on latest
upstream kernel:

WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1335 at
amdgpu_bo_release_notify+0x1bc/0x280 [amdgpu],
CPU#18: rccl-UnitTests/33151

Call trace:
amdgpu_bo_release_notify
ttm_bo_release
amdgpu_gem_object_free
drm_gem_object_free
amdgpu_bo_unref
amdgpu_bo_create
amdgpu_bo_create_user
amdgpu_gem_object_create
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu
kfd_ioctl_alloc_memory_of_gpu
kfd_ioctl
sys_ioctl

The warning is triggered because
amdgpu_ttm_next_clear_entity() returns NULL when a clear buffer
operation is requested. This happens because the GART window
allocation for the default_entity, clear_entity and move_entity
fails during initialization.

Commit [1] introduced separate GART windows for the
default_entity, clear_entity and move_entity of each SDMA
instance. Their sizes are derived from
AMDGPU_GTT_MAX_TRANSFER_SIZE, which is currently defined as 1024
pages. This implicitly assumes a 4K PAGE_SIZE, where 1024 pages
correspond to a 4MB transfer. On a 64K PAGE_SIZE system, however,
the same value expands to 64MB.

The default_entity and clear_entity each allocate one
AMDGPU_GTT_MAX_TRANSFER_SIZE GART window, while the move_entity
allocates two such windows. This results in 16MB of GART space
per SDMA instance on a 4K PAGE_SIZE system, but 256MB per SDMA
instance on a 64K PAGE_SIZE system.

On an MI210 system with five SDMA instances and a 512MB GART
aperture, the total GART space required becomes 1.25GB,
exceeding the available GART aperture. Consequently, GART window
allocation fails, amdgpu_ttm_next_clear_entity() returns NULL,
and the above warning is triggered.

Redefine AMDGPU_GTT_MAX_TRANSFER_SIZE in bytes instead of page
units. Where a page count is required, convert it using
PAGE_SHIFT. This preserves the existing 4MB transfer size across
all PAGE_SIZE configurations while keeping GART window
allocations within the available GART aperture.

[1] https://lore.kernel.org/all/20260408100327.1372-3-pierre-eric.pelloux-prayer@amd.com/#t

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2740de94e93c..bad33b3368eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -208,9 +208,10 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	void *cpu_addr;
 	uint64_t flags;
 	int r;
+	const u64 GTT_MAX_PAGES = (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE_SHIFT);
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
-	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
+	       GTT_MAX_PAGES * AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8);
 
 	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
 		return -EINVAL;
@@ -230,7 +231,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	offset = mm_cur->start & ~PAGE_MASK;
 
 	num_pages = PFN_UP(*size + offset);
-	num_pages = min_t(uint32_t, num_pages, AMDGPU_GTT_MAX_TRANSFER_SIZE);
+	num_pages = min_t(uint32_t, num_pages, GTT_MAX_PAGES);
 
 	*size = min(*size, (uint64_t)num_pages * PAGE_SIZE - offset);
 
@@ -2015,6 +2016,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 					 u32 num_gart_windows)
 {
 	int i, r, num_pages;
+	const u64 GTT_MAX_PAGES = (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE_SHIFT);
 
 	r = drm_sched_entity_init(&entity->base, prio, scheds, num_schedulers, NULL);
 	if (r)
@@ -2027,7 +2029,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 	if (num_gart_windows == 0)
 		return 0;
 
-	num_pages = num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
+	num_pages = num_gart_windows * GTT_MAX_PAGES;
 	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages,
 					 DRM_MM_INSERT_BEST);
 	if (r) {
@@ -2038,7 +2040,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 	for (i = 0; i < num_gart_windows; i++) {
 		entity->gart_window_offs[i] =
 			amdgpu_gtt_node_to_byte_offset(&entity->gart_node) +
-				i * AMDGPU_GTT_MAX_TRANSFER_SIZE * PAGE_SIZE;
+				i * GTT_MAX_PAGES * PAGE_SIZE;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2d72fa217274..b5d938b31383 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -39,7 +39,7 @@
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
 #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
-#define AMDGPU_GTT_MAX_TRANSFER_SIZE	1024
+#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1ULL << 22)
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 28dc6886c1ff..8aec1ae60ca1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -128,7 +128,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			     enum MIGRATION_COPY_DIR direction,
 			     struct dma_fence **mfence)
 {
-	const u64 GTT_MAX_PAGES = AMDGPU_GTT_MAX_TRANSFER_SIZE;
+	const u64 GTT_MAX_PAGES = (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE_SHIFT);
 	struct amdgpu_ring *ring;
 	struct amdgpu_ttm_buffer_entity *entity;
 	u64 gart_s, gart_d;
-- 
2.54.0

