Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1BBD5CCB6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 10:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E11710E7BF;
	Tue, 16 Dec 2025 10:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="r7pBskc7";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25510E7BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 10:10:07 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFN7qBF025769;
 Tue, 16 Dec 2025 10:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=idiNHA
 Qy8IDAPocci8vlenj26wGl4DmwPdoVPp5h+Us=; b=r7pBskc7XmO9SB9IOwd26c
 GNRlpsQMU3L1qCXSNQw8KNDrH5S3r8uQznUDXIHZCNOPA8Cg98t2f24OAirAdPrz
 C0MRyQnU7lUJPK9C2uGe51yFJPb8dZ6QCKbZFSCwW18LdKUzhxNu2CyWyF4Ws30s
 38rr7/tHd6iqwPTINgxN8+9Xfc4OJ7hMZLIDTucA1m9YSSHnVeJRQ9j00aTuh2UI
 SM6v3Kgc6ONcnGG6VbffUeZMUjiyCMbt3oRvGJNk1GjmuCXyySwG9aTiTOqtDlFL
 vuTmG4r4eF1c3GV6+kGDNwtIQigayRyktMDA9NJlSmTsUlRwuDHH9Xrt/bohgF0g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8ehrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:10:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BG9YOv6025956;
 Tue, 16 Dec 2025 10:10:05 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8ehrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:10:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8mfnx026803;
 Tue, 16 Dec 2025 10:10:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsbrw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:10:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGAA3io20316672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 10:10:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68B4958056;
 Tue, 16 Dec 2025 10:10:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 711DA5803F;
 Tue, 16 Dec 2025 10:10:00 +0000 (GMT)
Received: from [9.124.208.98] (unknown [9.124.208.98])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 10:10:00 +0000 (GMT)
Message-ID: <fd192983-f86e-4dec-adbf-52ef29e86457@linux.ibm.com>
Date: Tue, 16 Dec 2025 15:39:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/8] amdkfd/kfd_svm: Fix SVM map/unmap address
 conversion for non-4k page sizes
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <901c6820624fa444f2c6fadf77e9a24f3f93bf42.1765519875.git.donettom@linux.ibm.com>
 <d901390b-ad17-44de-b7d1-a5c6034baa0a@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <d901390b-ad17-44de-b7d1-a5c6034baa0a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX5JojUFK09ZOE
 Wj3O+QyULANJHybIf6IP0Pj9F6ANFWhF2OpknEO5qkAx8pryVFCFZ/W2sTIPw0toTSzIxOcogcg
 TWZo6cjVZe7QZxOY7L06ZkRguGzJqpKVN8Z6/2ZrTD2hmtzi8pMk8whbwiKVLWodNGhmgrB8S5+
 RCcZnbZSJGt9z/LoEiQLb1HHTKOwq1iHH7Q4kOqIqo8ObhX5xJNpCOZFUslWIS9Hsk3UNOBcbcY
 P6TNLR7fBhktRe6Y85hFaOWdIC0AsyNS1afM4vJZdOcjsSPVzBiAfyQYbBzMwlncdA0VaOrkE+L
 I+mwG3NdGPR9LSWYq2d5QDsRfQ/CxTdw/Bv1EUl2aoE/11iLROgWhLOwm0tKOqy7+elbyVaUBj1
 Zg8EFj6RnLHvMAadCutLAjF4pz1RSg==
X-Proofpoint-GUID: cQ6v3b3aqozQpe8AN6lccbnx10RgyIdG
X-Proofpoint-ORIG-GUID: uvBXCCVUt9KRPbl_NT2LGoTMv5jXMX89
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69412ffe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=UWS1lxshbo5BsGJzeLAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018
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


On 12/16/25 2:14 AM, Philip Yang wrote:
>
>
> On 2025-12-12 01:40, Donet Tom wrote:
>> SVM range size is tracked using the system page size. The range start 
>> and
>> end are aligned to system page-sized PFNs, so the total SVM range size
>> equals the total number of pages in the SVM range multiplied by the 
>> system
>> page size.
>>
>> The SVM range map/unmap functions pass these system page-sized PFN 
>> numbers
>> to amdgpu_vm_update_range(), which expects PFNs based on the GPU page 
>> size
>> (4K). On non-4K page systems, this mismatch causes only part of the SVM
>> range to be mapped in the GPU page table, while the rest remains 
>> unmapped.
>> If the GPU accesses an unmapped address within the same range, it 
>> results
>> in a GPU page fault.
>>
>> To fix this, the required conversion has been added in both
>> svm_range_map_to_gpu() and svm_range_unmap_from_gpu(), ensuring that all
>> pages in the SVM range are correctly mapped on non-4K systems.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 ++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 74a1d3e1d52b..a2636f2d6c71 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1314,11 +1314,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>                struct dma_fence **fence)
>>   {
>>       uint64_t init_pte_value = 0;
>> +    uint64_t gpu_start, gpu_end;
>>   -    pr_debug("[0x%llx 0x%llx]\n", start, last);
>> +    // Convert CPU page range to GPU page range
>> +    gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +    gpu_end = (last + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
>>   -    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>> false, NULL, start,
>> -                      last, init_pte_value, 0, 0, NULL, NULL,
>> +    pr_debug("%s: CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", 
>> __func__,
> dynamic debug control can enable function name, linenum print with 
> +pfl, don't add __func__.
>> +         start, last, gpu_start, gpu_end);
>> +    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>> false, NULL, gpu_start,
>> +                      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>>                         fence);
>>   }
>>   @@ -1398,9 +1403,13 @@ svm_range_map_to_gpu(struct 
>> kfd_process_device *pdd, struct svm_range *prange,
>>            last_start, last_start + npages - 1, readonly);
>>         for (i = offset; i < offset + npages; i++) {
>> +        uint64_t gpu_start;
>> +        uint64_t gpu_end;
>> +
>>           last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>>           dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
>>   +
> remove extra blank line.
>>           /* Collect all pages in the same address range and memory 
>> domain
>>            * that can be mapped with a single call to update mapping.
>>            */
>> @@ -1415,17 +1424,22 @@ svm_range_map_to_gpu(struct 
>> kfd_process_device *pdd, struct svm_range *prange,
>>           if (readonly)
>>               pte_flags &= ~AMDGPU_PTE_WRITEABLE;
>>   -        pr_debug("svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n",
>> -             prange->svms, last_start, prange->start + i,
>> -             (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>> -             pte_flags);
>>             /* For dGPU mode, we use same vm_manager to allocate VRAM 
>> for
>>            * different memory partition based on fpfn/lpfn, we should 
>> use
>>            * same vm_manager.vram_base_offset regardless memory 
>> partition.
>>            */
>> +        gpu_start = last_start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>> +        gpu_end = (prange->start + i + 1) * 
>> AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
>> +
>> +        pr_debug("svms 0x%p map CPU[0x%lx 0x%llx] GPU[0x%llx 0x%llx] 
>> vram %d PTE 0x%llx\n",
>> +             prange->svms, last_start, prange->start + i,
>> +             gpu_start, gpu_end,
>> +             (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>> +             pte_flags);
>> +
>>           r = amdgpu_vm_update_range(adev, vm, false, false, 
>> flush_tlb, true,
>> -                       NULL, last_start, prange->start + i,
>> +                       NULL, gpu_start, gpu_end,
>>                          pte_flags,
> With those fixed, this looks good to me.


Than you. I will fix them in next version.


>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>                          (last_start - prange->start) << PAGE_SHIFT,
>>                          bo_adev ? 
>> bo_adev->vm_manager.vram_base_offset : 0,
>
