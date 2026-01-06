Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38376CDC196
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 13:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8F510E3DE;
	Tue,  6 Jan 2026 13:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="pAW0DdAO";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5008C10E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 13:01:32 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6063RP1k021194;
 Tue, 6 Jan 2026 13:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9jbSco
 21zae7i/5a9bg9g1EY4HJCCMvtMwp/RjzT9/o=; b=pAW0DdAO5FBqsJtlC/Hui4
 3Z/W71fXFRBDEfKeDb+coYa39FNtIuDSar1CIPy2jFP95XiL4YHkU3eRnp4BlqAW
 z7xou2mpxVsB2zNgjrU92jc3LJJNgcAopJzKn2iHXnZ5jkPhFEFXKadOFvrzPpo6
 /bJyR1ehWPwLy4Bsk2ZjM/Gj6mG7LDavYOdQzhAvEVCGyM3v9qNQmKSrI1LMGOik
 14lxALx1N1iQd8NajvcHWu/nN+TJJwCBF/p9STOq79Zilef+w9cDg3oNnkV/GWrs
 fFQ3Vajb4jCOszCkr7rIsoa1sa1+jr06OBOiFEoKRu3E7QmnkcOD1/pB6eiXKdRw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq3ya6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 13:01:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606D1Tfc024164;
 Tue, 6 Jan 2026 13:01:29 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsq3ya2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 13:01:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606AYTf1012568;
 Tue, 6 Jan 2026 13:01:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjb6tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 13:01:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606D1Qvk58523924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 13:01:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26E6358068;
 Tue,  6 Jan 2026 13:01:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7838558063;
 Tue,  6 Jan 2026 13:01:23 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 13:01:23 +0000 (GMT)
Message-ID: <1ae40c17-ae39-4772-993e-f61531869b67@linux.ibm.com>
Date: Tue, 6 Jan 2026 18:31:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/8] amdgpu: Align ctl_stack_size and wg_data_size
 to GPU page size instead of CPU page size
From: Donet Tom <donettom@linux.ibm.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <f7f8f41d58ab2967cd8d077b4937aaa04d58a066.1765519875.git.donettom@linux.ibm.com>
 <2a213294-bf56-4ead-9e1f-cc8c3d4003a0@amd.com>
 <7e367a8b-6dda-4eec-98ff-aa0bb6550a77@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7e367a8b-6dda-4eec-98ff-aa0bb6550a77@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zdA8TMid6cgSf9Ja5Pbx7d98EpmUobPn
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695d07a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=81G2EmcVL6cvyjW_qqkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ae1-HzaxjaR6tgECcqiNTTolykCt2_85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMiBTYWx0ZWRfXx5QwUDKvGd6A
 M9qzxj7qTgHbGFEAuubAH85z2/aW80+63qGtrYwIpALrIcveUasWkJxWdCvXNh2CqiTEX6i8fQ/
 oPSfVz73BudOZ9E8gYmB/kdNQtya4LYCjiVBtLUVTcnXPFz8o8XziPjjfNo39rAgqhDR/xJ1teW
 58dKV6iA93/4w7MIe9e9SxHtcSSDi6TO3i0MIfeslUNbfnEBUaYAu5Ob9JGpTsm4OAnMsTlG3sR
 /i0bhBHH2NkboHUv0elpgv3lLV97WVb9sK462Kp22KgCyDnPOq4hbpd34r1qYkuBg3g0ZwFCjbJ
 KLAbJXMS39xt9FFFvZ/NSjPy+JCzS/jumGNTZGpmBZ6zRJ4E1Pd+mpfiIP1MntMV1IblaPYtXGG
 orY8TWo7a72dv8kM/Rg+lbFlFKUr2GmGMEQ99NGNQXAsIg4OJrf6x676XmbzpGR/a6iCj//02M6
 XVc/LwLCktSQ/A0fxeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601060102
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


On 12/19/25 3:57 PM, Donet Tom wrote:
>
> On 12/12/25 2:34 PM, Christian König wrote:
>> On 12/12/25 07:40, Donet Tom wrote:
>>> The ctl_stack_size and wg_data_size values are used to compute the 
>>> total
>>> context save/restore buffer size and the control stack size. These 
>>> buffers
>>> are programmed into the GPU and are used to store the queue state 
>>> during
>>> context save and restore.
>>>
>>> Currently, both ctl_stack_size and wg_data_size are aligned to the CPU
>>> PAGE_SIZE. On systems with a non-4K CPU page size, this causes 
>>> unnecessary
>>> memory waste because the GPU internally calculates and uses buffer 
>>> sizes
>>> aligned to a fixed 4K GPU page size.
>>>
>>> Since the control stack and context save/restore buffers are 
>>> consumed by
>>> the GPU, their sizes should be aligned to the GPU page size (4K), 
>>> not the
>>> CPU page size. This patch updates the alignment of ctl_stack_size and
>>> wg_data_size to prevent over-allocation on systems with larger CPU page
>>> sizes.
>> As far as I know the problem is that the debugger needs to consume 
>> that stuff on the CPU side as well.
>
>
> Thank you for your help.
>
> As mentioned earlier, we were observing some queue preemption and GPU 
> hang issues. To address this, we introduced a patch, and after 
> applying the 7/8 and 8/8 patches, those issues have not been seen anymore
>
> While debugging the GPU hang issue, I made some additional observations.
>
> On my system, I booted a kernel with a 4 KB system page size and 
> modified both the ROCR runtime and the GPU driver to set the control 
> stack size to 64 KB. Even on a 4 KB page-size system, using a 64 KB 
> control stack size reliably reproduces the queue preemption failure 
> when running RCCL unit tests on 8 GPUs. This suggests that the issue 
> is not related to the system page size, but rather to the control 
> stack size being exactly 64 KB.
>
> When the control stack size is set to 64 KB ± 4 KB, the tests pass on 
> both 4 KB and 64 KB system page-size configurations.
>
> For gfxv9, is there any documented hardware limitation on the control 
> stack size? Specifically, is it valid to use a control stack size of 
> exactly 64 KB?


I have one more question based on my understanding of the code. The 
control stack size depends on the number of CUs and waves. For GFXv9, 
what is the maximum possible control stack size? Can it reach 64K?

For GFX10, I’ve seen that the control stack size must be less than or 
equal to 0x7000. Is there a similar limitation for GFXv9?

I’m asking because, with both 4K and 64K page sizes, I’m seeing queue 
preemption failures on GFXv9 when the control stack size is set to 64K.


>
>
>>
>> I need to double check that, but I think the alignment is correct as 
>> it is.
>
>
> The control stack is part of the context save-restore buffer, and we 
> configure it on the GPU as shown below:
>
> m->cp_hqd_ctx_save_base_addr_lo = 
> lower_32_bits(q->ctx_save_restore_area_address);
> m->cp_hqd_ctx_save_base_addr_hi = 
> upper_32_bits(q->ctx_save_restore_area_address);
> m->cp_hqd_ctx_save_size = q->ctx_save_restore_area_size;
> m->cp_hqd_cntl_stack_size = q->ctl_stack_size;
> m->cp_hqd_cntl_stack_offset = q->ctl_stack_size;
> m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>
> The control stack occupies the region from cp_hqd_cntl_stack_offset 
> down to 0 within the ctx save restore area, and the remaining space is 
> used for WG state. This buffer is fully managed by the GPU during 
> preemption and restore operations.
> The control stack size is calculated based on hardware configuration 
> (CU count and wave count). For example, on gfxv9, the size is 
> typically around 32 KB. If we align this size to the system page size 
> (e.g., 64 KB), two issues arise:
>
> 1. Unnecessary memory overhead.
> 2. Potential queue preemption issues.
>
> On the CPU side, we copy the control stack contents to other buffers 
> for processing. Since the control stack size is derived from hardware 
> configuration, aligning it to the GPU page size seems more 
> appropriate. Aligning to the system page size would waste memory 
> without adding value. Using GPU page size alignment ensures 
> consistency with hardware and avoids unnecessary overhead.
>
> Would you agree that aligning the control stack size to the GPU page 
> size is the right approach? Or do you see any concerns with this method?
>
>
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index dc857450fa16..00ab941c3e86 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -445,10 +445,11 @@ void kfd_queue_ctx_save_restore_size(struct 
>>> kfd_topology_device *dev)
>>>               min(cu_num * 40, props->array_count / 
>>> props->simd_arrays_per_engine * 512)
>>>               : cu_num * 32;
>>>   -    wg_data_size = ALIGN(cu_num * 
>>> WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
>>> +    wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, 
>>> props),
>>> +                AMDGPU_GPU_PAGE_SIZE);
>>>       ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
>>>       ctl_stack_size = 
>>> ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
>>> -                   PAGE_SIZE);
>>> +                   AMDGPU_GPU_PAGE_SIZE);
>>>         if ((gfxv / 10000 * 10000) == 100000) {
>>>           /* HW design limits control stack size to 0x7000.
>>> @@ -460,7 +461,7 @@ void kfd_queue_ctx_save_restore_size(struct 
>>> kfd_topology_device *dev)
>>>         props->ctl_stack_size = ctl_stack_size;
>>>       props->debug_memory_size = ALIGN(wave_num * 
>>> DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
>>> -    props->cwsr_size = ctl_stack_size + wg_data_size;
>>> +    props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, 
>>> PAGE_SIZE);
>>>         if (gfxv == 80002)    /* GFX_VERSION_TONGA */
>>>           props->eop_buffer_size = 0x8000;
