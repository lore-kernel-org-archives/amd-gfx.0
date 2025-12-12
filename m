Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D02D44145
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE40410E588;
	Fri, 12 Dec 2025 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="UgeNKoX2";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1559D10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:42 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBHqdfC002757;
 Fri, 12 Dec 2025 06:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/KvlNfMoY6mf6F7iM
 c/9M9qd+8CJsefM1yDTjX2Ajxs=; b=UgeNKoX2YzntPDeaeu2xNfJKoZf0b3UHr
 ZC8oTK2Z7ubqpOJHDyPUaPf0cljv2Kw2sFae0eGHeMRZxInxJfJ3vVmU2ocOkZgz
 GImbPDGa3YvO7R3AcYISi9y8leXuR3SCu7SZStOfGBc5FsChSzLGBluoJjNBpP0b
 o4x7NvSSW8aoVhknVRFGzDvByb+zpji+IP0p66RKmOS5KeBkd1rpfr3HGB0aKNRo
 IRs2VUxWMqt+S4NC1tntnNtWbgpDAYSmRBLqqPBK00uu9bAJW2Vm6fqLLJZsLYp6
 /5nZ45hV7snkRLH9dArZL2X9XISwASDqMUDWBpOPfpgwXc6/lxgig==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6edaC030494;
 Fri, 12 Dec 2025 06:40:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC2BwxC012907;
 Fri, 12 Dec 2025 06:40:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0akafm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6eYoL31785334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2080C2004D;
 Fri, 12 Dec 2025 06:40:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A63720040;
 Fri, 12 Dec 2025 06:40:32 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:31 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 2/8] amdkfd/kfd_svm: Fix SVM map/unmap address
 conversion for non-4k page sizes
Date: Fri, 12 Dec 2025 12:10:09 +0530
Message-ID: <901c6820624fa444f2c6fadf77e9a24f3f93bf42.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gpzTo6StwJk5fEgGBJBGizgpJ2YSzObh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX+O/L9CVGo3lC
 vm3to3fbTGxbicEGSHkzQZLSbI7sIwEzxPlFlhiO7+L6aNnhBJdKPNlBknYkcLQYisOPOZyF2/2
 VJtYfEAQLK6N6XZv0RlFYxBDcrM5t25H7Yq8vF0J/ZlCUQ7g6rYrT4L4T/xp9Z2wxS9TafFGT3V
 NG4mWr324tt/22sGe6mb4rg42HrM7ZRGGOOkCYfIWKNr737y5TgNZZyjZxRz5bvtz4IDe4kSmIF
 JHl8seGfYLU6thRSF5pvgg+kE2ruYVTSVF6n46e5Bz8UZxsKXRzRXL071Nt1tyzPbjT/CGlcRBu
 jwFxXBeCbfzFRMwi+xHn50xQ3vkJXJwfA/lNKxK5/nD9can8/M9BKIVkdBxYsYnRPOBvJTaN2Et
 7Q46o68/nInvkGi4FpJFMcUgM4gW1Q==
X-Proofpoint-GUID: 8dtYosrg0qlOgQ8CQGDslE1M_-SmvIG4
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693bb8e8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=7_Q2Oju5quXlzP8DWyYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
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

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 ++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 74a1d3e1d52b..a2636f2d6c71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1314,11 +1314,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			 struct dma_fence **fence)
 {
 	uint64_t init_pte_value = 0;
+	uint64_t gpu_start, gpu_end;
 
-	pr_debug("[0x%llx 0x%llx]\n", start, last);
+	// Convert CPU page range to GPU page range
+	gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+	gpu_end = (last + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
-				      last, init_pte_value, 0, 0, NULL, NULL,
+	pr_debug("%s: CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", __func__,
+		 start, last, gpu_start, gpu_end);
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
 
@@ -1398,9 +1403,13 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		 last_start, last_start + npages - 1, readonly);
 
 	for (i = offset; i < offset + npages; i++) {
+		uint64_t gpu_start;
+		uint64_t gpu_end;
+
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
 
+
 		/* Collect all pages in the same address range and memory domain
 		 * that can be mapped with a single call to update mapping.
 		 */
@@ -1415,17 +1424,22 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
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

