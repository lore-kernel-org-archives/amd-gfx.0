Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E3D767C5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 10:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C4310EB7C;
	Fri, 19 Dec 2025 10:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="YpOpo8ov";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBE510EB7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 10:27:59 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJoAHZ011042;
 Fri, 19 Dec 2025 10:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oCCZtL
 f9y46h3RIyXStoErJKjbjIQ5gWHTOg38LMNW8=; b=YpOpo8ovMNrfKpq45gzZox
 R/tGtrTadTr42Uz2Wil4Huzixa10kPjBQkbArlANL5HfNycwGhySE21LuGwBfA0n
 QnvXalg/LMOtLVRCwOByE5LfsfKY8PXW4l9Nn/6taP9tl/+86US9qs9JgxbGYXyg
 Ccuqh6xGMk9UAYxu3QX2v4G7b2LjeuLpzWmGsMHYW64nWfmcxQ03xaT1HoH0SDO5
 pUvdPLF5MC8FMo78QM4fdPi77eczYFg160GOdkVPmfabYVEs3aFqUW20NLuowNwK
 B2CA3sXBXKv/dmt1zh1tb5/5XJpJajDIAwDkOeYuqH4GHwY/c55Uz7tLhjkTX2aQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3qavke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Dec 2025 10:27:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJARtg5031110;
 Fri, 19 Dec 2025 10:27:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3qavkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Dec 2025 10:27:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ7iEOe016334;
 Fri, 19 Dec 2025 10:27:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvr35um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Dec 2025 10:27:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BJARqAw59310574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Dec 2025 10:27:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE5F58052;
 Fri, 19 Dec 2025 10:27:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E8CD58056;
 Fri, 19 Dec 2025 10:27:49 +0000 (GMT)
Received: from [9.124.211.69] (unknown [9.124.211.69])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Dec 2025 10:27:48 +0000 (GMT)
Message-ID: <7e367a8b-6dda-4eec-98ff-aa0bb6550a77@linux.ibm.com>
Date: Fri, 19 Dec 2025 15:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/8] amdgpu: Align ctl_stack_size and wg_data_size
 to GPU page size instead of CPU page size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <f7f8f41d58ab2967cd8d077b4937aaa04d58a066.1765519875.git.donettom@linux.ibm.com>
 <2a213294-bf56-4ead-9e1f-cc8c3d4003a0@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <2a213294-bf56-4ead-9e1f-cc8c3d4003a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QWzF2gIO25gTnP5YpRiX04C5I_rgXia_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NCBTYWx0ZWRfXyGhZ/ru0DFwQ
 gPEgX83QJ4YxO1CL2Jcj6vE34arPRsJ2+MdIISkq+S+81cd8AxqrdXZue01pwEfJED0nUiat9gX
 riQSk7So2jcPU+RkflpHT0qEv/2HERzTXzKyYaFU4qmfq3cbvqMXXOgE9W/s0JN429RhyRG5+mL
 g2IWNq3Vy4rtfXINhA1fG7rBYgHGP1jMBXjLtQCN4gBvN92hlHGQeh0oo8xmNeLbUJakyF09qaY
 p2V0extveBnMp4eJ4sO5RRFrML2T0INem3spP+itFKa6gOafCF/N6uCBRaBVHUicd8/bF+FPGGH
 2Bjhs+k/1JgBQeRmDNgr1ndxDfheQy+btwuJoWP+57+4g7yn5a0QKzdT1c1mnWmgXc53WHxTd1l
 uSfKf3hWB7pT31gp9V+RqlAOKLbi+v4ubNjuQnU6NR18/8stCsiQmgahISu55Zxa7BOTLTyHbT/
 VsCKpcxYXIydFSKTJmA==
X-Proofpoint-ORIG-GUID: YonkJk4VBRZJ8CuAg6T5H5XdlqzbMHOo
X-Authority-Analysis: v=2.4 cv=C/HkCAP+ c=1 sm=1 tr=0 ts=694528ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=_9fUcSD2DwM5pkZo1yoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512190084
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


On 12/12/25 2:34 PM, Christian König wrote:
> On 12/12/25 07:40, Donet Tom wrote:
>> The ctl_stack_size and wg_data_size values are used to compute the total
>> context save/restore buffer size and the control stack size. These buffers
>> are programmed into the GPU and are used to store the queue state during
>> context save and restore.
>>
>> Currently, both ctl_stack_size and wg_data_size are aligned to the CPU
>> PAGE_SIZE. On systems with a non-4K CPU page size, this causes unnecessary
>> memory waste because the GPU internally calculates and uses buffer sizes
>> aligned to a fixed 4K GPU page size.
>>
>> Since the control stack and context save/restore buffers are consumed by
>> the GPU, their sizes should be aligned to the GPU page size (4K), not the
>> CPU page size. This patch updates the alignment of ctl_stack_size and
>> wg_data_size to prevent over-allocation on systems with larger CPU page
>> sizes.
> As far as I know the problem is that the debugger needs to consume that stuff on the CPU side as well.


Thank you for your help.

As mentioned earlier, we were observing some queue preemption and GPU 
hang issues. To address this, we introduced a patch, and after applying 
the 7/8 and 8/8 patches, those issues have not been seen anymore

While debugging the GPU hang issue, I made some additional observations.

On my system, I booted a kernel with a 4 KB system page size and 
modified both the ROCR runtime and the GPU driver to set the control 
stack size to 64 KB. Even on a 4 KB page-size system, using a 64 KB 
control stack size reliably reproduces the queue preemption failure when 
running RCCL unit tests on 8 GPUs. This suggests that the issue is not 
related to the system page size, but rather to the control stack size 
being exactly 64 KB.

When the control stack size is set to 64 KB ± 4 KB, the tests pass on 
both 4 KB and 64 KB system page-size configurations.

For gfxv9, is there any documented hardware limitation on the control 
stack size? Specifically, is it valid to use a control stack size of 
exactly 64 KB?


>
> I need to double check that, but I think the alignment is correct as it is.


The control stack is part of the context save-restore buffer, and we 
configure it on the GPU as shown below:

m->cp_hqd_ctx_save_base_addr_lo = 
lower_32_bits(q->ctx_save_restore_area_address);
m->cp_hqd_ctx_save_base_addr_hi = 
upper_32_bits(q->ctx_save_restore_area_address);
m->cp_hqd_ctx_save_size = q->ctx_save_restore_area_size;
m->cp_hqd_cntl_stack_size = q->ctl_stack_size;
m->cp_hqd_cntl_stack_offset = q->ctl_stack_size;
m->cp_hqd_wg_state_offset = q->ctl_stack_size;

The control stack occupies the region from cp_hqd_cntl_stack_offset down 
to 0 within the ctx save restore area, and the remaining space is used 
for WG state. This buffer is fully managed by the GPU during preemption 
and restore operations.
The control stack size is calculated based on hardware configuration (CU 
count and wave count). For example, on gfxv9, the size is typically 
around 32 KB. If we align this size to the system page size (e.g., 
64 KB), two issues arise:

1. Unnecessary memory overhead.
2. Potential queue preemption issues.

On the CPU side, we copy the control stack contents to other buffers for 
processing. Since the control stack size is derived from hardware 
configuration, aligning it to the GPU page size seems more appropriate. 
Aligning to the system page size would waste memory without adding 
value. Using GPU page size alignment ensures consistency with hardware 
and avoids unnecessary overhead.

Would you agree that aligning the control stack size to the GPU page 
size is the right approach? Or do you see any concerns with this method?


>
> Regards,
> Christian.
>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index dc857450fa16..00ab941c3e86 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -445,10 +445,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>>   		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
>>   		    : cu_num * 32;
>>   
>> -	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
>> +	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
>> +				AMDGPU_GPU_PAGE_SIZE);
>>   	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
>>   	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
>> -			       PAGE_SIZE);
>> +			       AMDGPU_GPU_PAGE_SIZE);
>>   
>>   	if ((gfxv / 10000 * 10000) == 100000) {
>>   		/* HW design limits control stack size to 0x7000.
>> @@ -460,7 +461,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>>   
>>   	props->ctl_stack_size = ctl_stack_size;
>>   	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
>> -	props->cwsr_size = ctl_stack_size + wg_data_size;
>> +	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
>>   
>>   	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
>>   		props->eop_buffer_size = 0x8000;
