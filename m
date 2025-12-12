Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA904D44148
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A164910E270;
	Fri, 12 Dec 2025 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="eSZWPPkS";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDB610E08C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:59 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBNn9Im019332;
 Fri, 12 Dec 2025 06:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IClozS
 yyuKdH5UxnV26uLpDOW81e+shOmNEmwMo/cpg=; b=eSZWPPkS4++PVaJ03yzqjV
 Y/xJ18D4ifR790efH6yCvqevurbZJ/gSevgIYMP6xPhdmgObzBJAr1lM2QMegzLt
 ZfzrereeqKzFVZGeMqtMASSRPfwEvFaM93rmCBDBt6Py8zW9uTu3nzuecJu37xyl
 eIxrX8axiJ9EwSvERf9E10NIMzP5s2HoqdKaHlZn3m8CUkKG1xZX7aiS6j8gTUxI
 HrBUW/8aEU0tKlnQcaAvO2NCv/yuR/Zd+CUmTWzv20JQ0+GEIf6KehYa15CBUhWT
 AucLGDxph0C/e4eCzMAVSkT9EDuSPVnCLOqYOoMLRW+pSQPPtaFCpzLDb76wuHCQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6a7l7022388;
 Fri, 12 Dec 2025 06:40:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC5KS97028126;
 Fri, 12 Dec 2025 06:40:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6yane3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6ep5F27132632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62E7820043;
 Fri, 12 Dec 2025 06:40:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87DBB20040;
 Fri, 12 Dec 2025 06:40:49 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:49 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 8/8] amdgpu: Fix MQD and control stack alignment for
 non-4K CPU page size systems
Date: Fri, 12 Dec 2025 12:10:15 +0530
Message-ID: <99f81bd30011e743ca96f471b5af78bcfd2bbc45.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pG2SBbfHo0dCbLsKX0A9ZgsPS0aHVWjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX9yhDBtvoR3Gv
 v6jo/yOEgo2T/3d+aXXFBajQtwUzKl0BbaKzNTkh/91C5qxlPhCeQW+NgOOkHSm0nF6Zx5gV4zc
 xb3rgM4xoYy//KYda82jyO6dg/dv3Larv8iWldlhMtYbcD8VK0z0Ua9SQwFORFn85irDxkX04vS
 8kRFpu2CujjLgAU1jHWLqnFRMvAHupq8dbdJyG+ZpP0PEX7l870ahLypnAm9Vxo2LfKw1z2xouY
 NPSAstmd56JI9fmziayzCTBvf/6fbPipolGUcxfClftDXvUdb2xFNAqABbYnIr0OKyXMYVYGIXK
 pqQrgsqr2WrCNy3ypZEKHRTiB+RBohffh2bKGgnFOShQeVJboqXv5zIFdiXSFwWYko/V4HqFsM7
 xfkJkGbSd9wrjVCRtuT0jUDGBNlUlw==
X-Proofpoint-GUID: mgeBgTs0XPHqNWwgh9ZlPQcbLZkQuNmz
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693bb8f9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8 a=EcPYo12vaGZsXEfV-mwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
X-Mailman-Approved-At: Fri, 12 Dec 2025 08:29:54 +0000
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
incorrectly mapped as UC. This misalignment leads to queue preemption
and eviction failures.

This patch fixes the issue by aligning both the MQD and control stack
sizes to the GPU page size (4K). The first 4K page is correctly marked
as UC for the MQD, and the remaining GPU pages are marked NC for the
control stack. This ensures proper memory type assignment on systems
with larger CPU page sizes and prevents incorrect behavior in queue
preemption and eviction.

[1]: https://elixir.bootlin.com/linux/v6.18/source/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c#L118

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++--------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++++-----
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index b2033f8352f5..0e1c017d10dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -368,6 +368,35 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 	}
 	drm_dev_exit(idx);
 }
+void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
+		    int pages, dma_addr_t *dma_addr, uint64_t flags)
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
 
 /**
  * amdgpu_gart_bind - bind pages into the gart page table
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 7cc980bf4725..1beef780936d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -62,6 +62,8 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, dma_addr_t *dma_addr, uint64_t flags,
 		     void *dst);
+void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
+		     int pages, dma_addr_t *dma_addr, uint64_t flags);
 void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		      int pages, dma_addr_t *dma_addr, uint64_t flags);
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9d568c16beb1..c2e0d2518345 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -882,25 +882,15 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
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
index f2dee320fada..e45e39cd65fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -43,8 +43,8 @@ static uint64_t mqd_stride_v9(struct mqd_manager *mm,
 {
 	if (mm->dev->kfd->cwsr_enabled &&
 	    q->type == KFD_QUEUE_TYPE_COMPUTE)
-		return ALIGN(q->ctl_stack_size, PAGE_SIZE) +
-			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE);
+		return ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE);
 
 	return mm->mqd_size;
 }
@@ -136,13 +136,12 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		if (!mqd_mem_obj)
 			return NULL;
 		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
-			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
-			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
+			(ALIGN(ALIGN(q->ctl_stack_size, AMDGPU_GPU_PAGE_SIZE) +
+			ALIGN(sizeof(struct v9_mqd), AMDGPU_GPU_PAGE_SIZE), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
-
 		if (retval) {
 			kfree(mqd_mem_obj);
 			return NULL;
@@ -343,7 +342,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	struct kfd_context_save_area_header header;
 
 	/* Control stack is located one page after MQD. */
-	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
+	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
@@ -380,7 +379,7 @@ static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, voi
 {
 	struct v9_mqd *m;
 	/* Control stack is located one page after MQD. */
-	void *ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
+	void *ctl_stack = (void *)((uintptr_t)mqd + AMDGPU_GPU_PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
@@ -426,7 +425,7 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 		*gart_addr = addr;
 
 	/* Control stack is located one page after MQD. */
-	ctl_stack = (void *)((uintptr_t)*mqd + PAGE_SIZE);
+	ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
 	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
 
 	m->cp_hqd_pq_doorbell_control =
-- 
2.52.0

