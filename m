Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9C5C9EC8D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3073B10E3D9;
	Mon, 12 Jan 2026 14:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ZEaReFjB";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBFA10E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:07:45 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BKshYA005333;
 Mon, 12 Jan 2026 14:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/PgWzdJeil1GJc1bl
 PY1tnMjNhsGe9lHJML8BcRLNa0=; b=ZEaReFjBAvOw2LU6bvSkKo1bsWDWEzzaO
 vqpgpZE7HCC0DrrO8kbIZM9kS+vc0iUzBZmBXg6FOqpqsiJQbRTq3Nbvy9Coj2bq
 RrJwwXwo3XCSsE3hweymM/j3t3SUYAJW0d+JRm6kYkKENSnA4cMPubnQHngZ1buU
 fuF3TDVv8U93Xs3hD8bXiJxHloTKgWFW/OQFtfM4LI2JkFYpBjPhsxmpEHyZgMfu
 V8Kt/wStO7XXV7e169qjecmONO5eee1wrK9sKY8ft6UVkc8ifB3SQuh5cjNDe02b
 dXNCJzvL8EvBeI975CYldpHzxJgetHM2IeYlyvzzpclwl494LtZQg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gyc2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CE6Odm003390;
 Mon, 12 Jan 2026 14:07:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gyc2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CDmGui025961;
 Mon, 12 Jan 2026 14:07:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23mx8s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CE7ZSY46727520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 14:07:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D519420043;
 Mon, 12 Jan 2026 14:07:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BB3520040;
 Mon, 12 Jan 2026 14:07:33 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 14:07:33 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
 donettom@linux.ibm.com, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/3] drm/amdkfd: Fix SVM map/unmap address conversion for
 non-4k page sizes
Date: Mon, 12 Jan 2026 19:36:55 +0530
Message-ID: <3c386fa5a476c196cef1d1f1a32c284de7daeb48.1768223974.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768223974.git.donettom@linux.ibm.com>
References: <cover.1768223974.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HC5NlnIzWKReen7hZNwYG_T1B6IBbgHl
X-Proofpoint-ORIG-GUID: V5hr11MUVIBn5FhRYMmjTnL3dj0a2IqE
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6965002d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7_Q2Oju5quXlzP8DWyYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExMSBTYWx0ZWRfXxrprQyLoLkHc
 WNB2SpyMWhHm0v0eAWcFnoCa2bkp+tKztQilIBj2oz+z9SIUDU8mNnV0ENZxa1CD1IS04U8Y8fD
 oW6rAK+RbbQBMvp/uphqwSWwYVjOOA/9jZhUDthoAzI7b6MB/EUATE0LLN4zC6mzBxfbHjeujOu
 Ez05PZCT/9QZ+e5zVyqw0UHoyuMuSA/SPSungrzNDZ9t0Y6Fa3mYTDbjidHADFlWArxwX+LTAl1
 pwnAoD9n1onheUvc5IucAhA+ffHeS6u/w9efXLquQObYSbicnrzG19wv2Tg2ptsz8y4dhU1pP32
 wafncnF5pkN6OGV6FwMQ2zLhZbVG1ltx3NOo3P6u9IIp7pVMxibHx2PWRFGLdq8Ae+i7sbE/xot
 jI0EVqTsIBX4Oc9maEdhCs/bvwW3RASurHWElmpybkdBmOaUl0utU/aF1oa58zGWrTVvsxUpQm9
 aPM9pDWX8XEBk4xsqWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120111
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

SVM range size is tracked using the system page size. The range start and
end are aligned to system page-sized PFNs, so the total SVM range size
equals the total number of pages in the SVM range multiplied by the system
page size.

The SVM range map/unmap functions pass these system page-sized PFN numbers
to amdgpu_vm_update_range(), which expects PFNs based on the GPU page size
(4K). On non-4K page systems, this mismatch causes only part of the SVM
range to be mapped in the GPU page table, while the rest remains unmapped.
If the GPU accesses an unmapped address within the same range, it results
in a GPU page fault.

To fix this, the required conversion has been added in both
svm_range_map_to_gpu() and svm_range_unmap_from_gpu(), ensuring that all
pages in the SVM range are correctly mapped on non-4K systems.

Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 79ea138897fc..afaec58e1a21 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1332,11 +1332,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			 struct dma_fence **fence)
 {
 	uint64_t init_pte_value = 0;
+	uint64_t gpu_start, gpu_end;
 
-	pr_debug("[0x%llx 0x%llx]\n", start, last);
+	/* Convert CPU page range to GPU page range */
+	gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+	gpu_end = (last + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
-				      last, init_pte_value, 0, 0, NULL, NULL,
+	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
+		gpu_start, gpu_end);
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
 
@@ -1416,6 +1421,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		 last_start, last_start + npages - 1, readonly);
 
 	for (i = offset; i < offset + npages; i++) {
+		uint64_t gpu_start;
+		uint64_t gpu_end;
+
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
 
@@ -1433,17 +1441,22 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		if (readonly)
 			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
 
-		pr_debug("svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n",
-			 prange->svms, last_start, prange->start + i,
-			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
-			 pte_flags);
 
 		/* For dGPU mode, we use same vm_manager to allocate VRAM for
 		 * different memory partition based on fpfn/lpfn, we should use
 		 * same vm_manager.vram_base_offset regardless memory partition.
 		 */
+		gpu_start = last_start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+		gpu_end = (prange->start + i + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
+
+		pr_debug("svms 0x%p map CPU[0x%lx 0x%llx] GPU[0x%llx 0x%llx] vram %d PTE 0x%llx\n",
+			 prange->svms, last_start, prange->start + i,
+			 gpu_start, gpu_end,
+			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
+			 pte_flags);
+
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
-					   NULL, last_start, prange->start + i,
+					   NULL, gpu_start, gpu_end,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-- 
2.52.0

