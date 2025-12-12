Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A5ED4921F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 12:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA6710E00A;
	Fri, 12 Dec 2025 12:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="jttoxoo2";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E2510E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 12:29:26 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC1Fqkj001279;
 Fri, 12 Dec 2025 12:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IhERqv
 7OoeEQX5baFlu68eZHWh7pj7sidiYb1j4qIGg=; b=jttoxoo2qBnAMi5hn2SDk1
 v9wiu6MK48QJAzaMrmxIK/4M/Gev7IdtVHHSBGx/ocK8hHuf2N5xPOFCddeQYkHO
 Bt6WvMwuRdE3aXhC/+s7jL5Da34lktRYTvWNIol5ZE4elp1ORcVwoKti50jJG+rk
 BF5oNaQ9VrWL3jhh3iANefOhbbEhzve62wMnO5UvH7qWsBjWEhBU9luc/4cI/H25
 n+KIpFXDlqW7zAzb3bDrLiMi+wmv1i66y71WSYep7KN/+5hOh/RmESeyirAA/dnu
 cqr3eo5cf2JS4aMJmV4latotqJE5Y0rdo0ydFT4PaCoXW1GnLQPOt/aorjIxJJIA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww4k4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:29:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCCG4MC021041;
 Fri, 12 Dec 2025 12:29:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww4k4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:29:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCAjN8n008472;
 Fri, 12 Dec 2025 12:29:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytnbty0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 12:29:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCCTMYE33882848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 12:29:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B75F5805C;
 Fri, 12 Dec 2025 12:29:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAD175805A;
 Fri, 12 Dec 2025 12:29:19 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 12:29:19 +0000 (GMT)
Message-ID: <55448dbc-8bd5-4641-b16e-0d16d73ef054@linux.ibm.com>
Date: Fri, 12 Dec 2025 17:59:18 +0530
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
X-Proofpoint-GUID: 2fwxmkgyqbBPheW8LyC3tbM3s__Tv2j1
X-Proofpoint-ORIG-GUID: xrfSvsy42ZwHgBZ1tnuOqzItzw3HRVWb
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693c0aa5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=4G8YUOFLx5gCFBDtBM8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXzn0DC9pufx/3
 qIAYInL2L5SYXx71mrGGZLkPK0ScxFJ9fPYaikIt8SyEcormHb2YLDVm4vlNNMQf2tHorg200wZ
 7KkaKddYiUh7d3dPXOPQqOBpGtJLefIpfnDrGcs78qcXwni+mGwCB7pY2hi1M5csB/3b/N7aLPt
 jlWGrV45niwU4fHFNeRVDbkfBrky6FBPNEwIWTJA7qcRdmmzEYe8Ay7n7wACMLSY3EqHmyVDQbT
 Ie74xv752NFXpQjEeqYNlAYAygsrhL073qN9lgjmh8V1vA/P3g30kUH0W3o6ko59s8vdAhXZSab
 jgAVIEwwx1GRw7+EdXliTD2flK/YjbNU4qm8tVgdyqihwBTGkvSuUP7kHuhxLTwsYEK7rGbVS59
 R/0XOiAJHr18eo7BftHBGnGdZxWLSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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
>
> I need to double check that, but I think the alignment is correct as it is.


Thanks Christian

We were observing the following errors during RCCL unit tests when 
running on more than two GPUs, which eventually led to a GPU hang:

[  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for 
queue with doorbell_id: 80030008
[  606.696820] amdgpu 0048:0f:00.0: amdgpu: amdgpu: Failed to evict 
process queues
[  606.696826] amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source:  4
[  610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for 
queue with doorbell_id: 80030008
[  610.696869] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
[  610.696942] amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues


After applying the alignment change and the change in patch 8/8, we are 
not seeing this issue.


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
