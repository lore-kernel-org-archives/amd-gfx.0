Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46719C61DC4
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CB610E153;
	Sat, 21 Feb 2026 07:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="OZFXrA8g";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1173C10E153
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:56 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L3OSAt2099575; Sat, 21 Feb 2026 07:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5GQwrX
 SOZnh7eQFnLSl3+xAn0sbH1kDU2ESubo13hkQ=; b=OZFXrA8gTGa/PJPZpO2qS2
 k9uIa5Ce9POBXu9SJuBlOtmcA6tc6ZKEtOZ66F6f+Yf6S5svkr9lexPxmO3q8p42
 CEQGwqUV6j1LiIU/uIKVM1COZkzatp11YulvAiOUf/tntrO7EUt/VF+cq4pLn8s5
 QVK1fgYKZqwqhDm9fP4/zDQMrdIBfpbVN7/Qzt9XLVs63i4lMj/Hq9Gm7FPxI2qg
 L+uumNVD0X8KnL12qo7rBsAe+BITNgYD5Zx0u7RPFGX5OH06Mc7tAogdnOqCg6UR
 u/T2tkJpcXuUjkDdyIDd7gQ53tH6U3Z6zdtiif0OgZVuM1x8XeMZlvuMNH+zd7LA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e30f9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L73cXT001883;
 Sat, 21 Feb 2026 07:09:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bubm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79ntM25952524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1950D20043;
 Sat, 21 Feb 2026 07:09:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7F2820040;
 Sat, 21 Feb 2026 07:09:46 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:46 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 5/6] drm/amd: Fix MQD and control stack alignment for
 non-4K
Date: Sat, 21 Feb 2026 12:39:23 +0530
Message-ID: <bbff8a89df9e5d7fff50ccf767cd354b0fbc89d3.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=69995a42 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=-1EX8FYKhcfrhsM7lu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: Jnz2TqNitjeoMb6u-GO2feKl37X46g_V
X-Proofpoint-ORIG-GUID: mX52bBJ3UPVuYVt89Xm2x5A6DWF5m10f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfX5lXoJL4tHYVS
 rmXanVUz7l6LRI8P2hpctSk14NKY7KwoGJ083HOZagI7MHe5/udaRdv2/1i7I4LwvarEhUh93qe
 tPuadRW5ldPJXd8lyYUp31SRZMGc8txVyN2CbySR28nUzs+B/8aIIowEg90LWlfcZ0Dr6H2vAxz
 qDlk1y3V5TLhmYXqzVT1q9g6x1GoMdBWuId2EUB5lErbxEAJLn2++B1BD0+RPYuH7gCLkTCnDxj
 LG0MKxSKLD77oUfaDb3k36QJqjRF5YzJD5toCTlhbNK0EnxO69bq8ljFgb5qGMy6nXG8n22E863
 JKoidyzd9Z1YZMBTVHg0CvYaoqH0KJ6S1j+F7O6RHnUg7XMwbBcoYrufmUgfMwFEGxvNYVhN11t
 7EzSZefG/5unwgA6qsBy3WAdFYhFUSMcbHBNRVRVEyQnito30SNpJQcONmWL4+yxSG2HhY9e4Cb
 0OCJKDef6uatVDxiNQQ==
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

For gfxV9, due to a hardware bug ("based on the comments in the code
here [1]"), the control stack of a user-mode compute queue must be
allocated immediately after the page boundary of its regular MQD buffer.
To handle this, we allocate an enlarged MQD buffer where the first page
is used as the MQD and the remaining pages store the control stack.
Although these regions share the same BO, they require different memory
types: the MQD must be UC (uncached), while the control stack must be
NC (non-coherent), matching the behavior when the control stack is
allocated in user space.

This logic works correctly on systems where the CPU page size matches
the GPU page size (4K). However, the current implementation aligns both
the MQD and the control stack to the CPU PAGE_SIZE. On systems with a
larger CPU page size, the entire first CPU page is marked UC—even though
that page may contain multiple GPU pages. The GPU treats the second 4K
GPU page inside that CPU page as part of the control stack, but it is
incorrectly mapped as UC.

This patch fixes the issue by aligning both the MQD and control stack
sizes to the GPU page size (4K). The first 4K page is correctly marked
as UC for the MQD, and the remaining GPU pages are marked NC for the
control stack. This ensures proper memory type assignment on systems
with larger CPU page sizes.

[1]: https://elixir.bootlin.com/linux/v6.18/source/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c#L118

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++-----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
 4 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index ec911dce345f..4d884180cf61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -403,6 +403,50 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 	drm_dev_exit(idx);
 }
 
+/**
+ * amdgpu_gart_map_gfx9_mqd - map mqd and ctrl_stack dma_addresses into GART entries
+ *
+ * @adev: amdgpu_device pointer
+ * @offset: offset into the GPU's gart aperture
+ * @pages: number of pages to bind
+ * @dma_addr: DMA addresses of pages
+ * @flags: page table entry flags
+ *
+ * Map the MQD and control stack addresses into GART entries with the correct
+ * memory types on gfxv9. The MQD occupies the first 4KB and is followed by
+ * the control stack. The MQD uses UC (uncached) memory, while the control stack
+ * uses NC (non-coherent) memory.
+ */
+void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
+			int pages, dma_addr_t *dma_addr, uint64_t flags)
+{
+	uint64_t page_base;
+	unsigned int i, j, t;
+	int idx;
+	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
+	void *dst;
+
+	if (!adev->gart.ptr)
+		return;
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return;
+
+	t = offset / AMDGPU_GPU_PAGE_SIZE;
+	dst = adev->gart.ptr;
+	for (i = 0; i < pages; i++) {
+		page_base = dma_addr[i];
+		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
+			if ((i == 0) && (j == 0))
+				amdgpu_gmc_set_pte_pde(adev, dst, t, page_base, flags);
+			else
+				amdgpu_gmc_set_pte_pde(adev, dst, t, page_base, ctrl_flags);
+			page_base += AMDGPU_GPU_PAGE_SIZE;
+		}
+	}
+	drm_dev_exit(idx);
+}
+
 /**
  * amdgpu_gart_bind - bind pages into the gart page table
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index d3118275ddae..6ebd2da32ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -62,6 +62,8 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, dma_addr_t *dma_addr, uint64_t flags,
 		     void *dst);
+void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
+			int pages, dma_addr_t *dma_addr, uint64_t flags);
 void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		      int pages, dma_addr_t *dma_addr, uint64_t flags);
 void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 67983955a124..e086eb1d2b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -855,25 +855,15 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
 	int i;
-	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
 
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
 
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
-		/* MQD page: use default flags */
-		amdgpu_gart_bind(adev,
+		amdgpu_gart_map_gfx9_mqd(adev,
 				gtt->offset + (page_idx << PAGE_SHIFT),
-				1, &gtt->ttm.dma_address[page_idx], flags);
-		/*
-		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
-		 * the second page of the BO onward.
-		 */
-		amdgpu_gart_bind(adev,
-				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
-				pages_per_xcc - 1,
-				&gtt->ttm.dma_address[page_idx + 1],
-				ctrl_flags);
+				pages_per_xcc, &gtt->ttm.dma_address[page_idx],
+				flags);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..ff0e483514da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -42,9 +42,16 @@ static uint64_t mqd_stride_v9(struct mqd_manager *mm,
 				struct queue_properties *q)
 {
 	if (mm->dev->kfd->cwsr_enabled &&
-	    q->type == KFD_QUEUE_TYPE_COMPUTE)
-		return ALIGN(q->ctl_stack_size, PAGE_SIZE) +
-			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE);
+	    q->type == KFD_QUEUE_TYPE_COMPUTE) {
+
+		/* On gfxv9, the MQD resides in the first 4K page,
+		 * followed by the control stack. Align both to
+		 * AMDGPU_GPU_PAGE_SIZE to maintain the required 4K boundary.
+		 */
+
+		return ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE);
+	}
 
 	return mm->mqd_size;
 }
@@ -148,8 +155,8 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 		if (!mqd_mem_obj)
 			return NULL;
 		retval = amdgpu_amdkfd_alloc_kernel_mem(node->adev,
-			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
-			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
+			(ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
 			mqd_on_vram(node->adev) ? AMDGPU_GEM_DOMAIN_VRAM :
 						  AMDGPU_GEM_DOMAIN_GTT,
@@ -357,7 +364,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	struct kfd_context_save_area_header header;
 
 	/* Control stack is located one page after MQD. */
-	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
+	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
@@ -394,7 +401,7 @@ static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, voi
 {
 	struct v9_mqd *m;
 	/* Control stack is located one page after MQD. */
-	void *ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
+	void *ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
@@ -440,7 +447,7 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 		*gart_addr = addr;
 
 	/* Control stack is located one page after MQD. */
-	ctl_stack = (void *)((uintptr_t)*mqd + PAGE_SIZE);
+	ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
 	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
 
 	m->cp_hqd_pq_doorbell_control =
-- 
2.52.0

