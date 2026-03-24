Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67891FEC0EB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 18:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8A710E616;
	Tue, 24 Mar 2026 18:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="cQIPQIpS";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EE810E616
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 18:19:16 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OEmge13384262; Tue, 24 Mar 2026 18:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MZLHYo
 tk/L8BhRefJoOq0cq8m08QcngpPIBIEMkEF3c=; b=cQIPQIpSgetLbVSmT569ac
 aFoZ/vLxXs1jNgw+AmnmUdp4ccub8zBhnwINrPsHRt1UfX9MheueId8HfHk3PiMI
 upcul4x3NJSCPGXoyFKh1RDvmXGKo5YrihXWsuqNHIagpDsyKqfSkxeIocdA4xXm
 n3YY83IzgM5oDYU1CDzMiuQ1vLezjPvDAPPc8Ju/qcCwgJXJlUMfmGUWPY8nhAhX
 lR/j7XfWqbE3dxvXKHP2iYSQJjSnTOavqeyQ+KTst9643G1cYCfIN19REpkBpnhJ
 XML1HdZLltOua33XtUgvWk3aRGfD5UaKFAEW/+WPHAnxmns2PkKsUVwemVwdRKnA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky04cp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 18:19:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFcid8005991;
 Tue, 24 Mar 2026 18:19:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ykbsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 18:19:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OIJB7s60948774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 18:19:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 266CD58064;
 Tue, 24 Mar 2026 18:19:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 403F058056;
 Tue, 24 Mar 2026 18:19:07 +0000 (GMT)
Received: from [9.39.25.178] (unknown [9.39.25.178])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 18:19:06 +0000 (GMT)
Message-ID: <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
Date: Tue, 24 Mar 2026 23:49:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org,
 Donet Tom <donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
 <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE0MiBTYWx0ZWRfX3kqCMKEoMZi3
 aAIDKDRXDAZlgjwEsSoOTVH2onrlrbOq4i5lv46Ot5kMY7OjnF8BTvcJsQQA0wrWK0sqKE07kAu
 xpUfTc2ChPHJ78G2v/2fBDl4SvOOj0Jo/rgqvMX5gATuGw91tgg9Co62DQODfQLt6pIzLc+Il5N
 bAehN3Ljd6isZLHYwerH4PdS5hLCwJh+qsn32lQA5McyFgzKLkD6RzksHzx+Iyowou0wUzB/mdM
 56w1hbKOE1G2fvzGamdoC8rYftwPE5AogM0JQ8hDa0NuUVsWgE1nJ5Ffj25BQPXsNGgSpLbbj3X
 oZHrR0iSLFHkAvT4BvkUCuugZyj8fn4fdQBA+ox/hTl/moWZkF1icddCcL7pRbSF3Pdkfv8cQAY
 MB5sl+tMOSK706Nb4ZZm7ohrjlelmvTX3g3Ig/himTj7vlGVSfLqd3IhxlEue9zDWefahg7K6De
 48LI+x7t3FpnZdb0n8g==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c2d5a1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=e-Egg3XyqFc5x-52FVUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4guCohB-uKdOcQOx0EfMdSrx6drUDMsm
X-Proofpoint-GUID: gp2kRtPN592T84C_F4Dh2UjtxSBxX9Bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240142
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


On 3/23/26 6:42 PM, Christian König wrote:
> On 3/23/26 12:50, Donet Tom wrote:
>> On 3/23/26 3:41 PM, Christian König wrote:
>>
>> Hi Christian
>>
>>> On 3/23/26 05:28, Donet Tom wrote:
>>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>>> 4K pages, both values match (8KB), so allocation and reserved space
>>>> are consistent.
>>>>
>>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>>>> while the reserved trap area remains 8KB. This mismatch causes the
>>>> kernel to crash when running rocminfo or rccl unit tests.
>>>>
>>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>>> Faulting instruction address: 0xc0000000002c8a64
>>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>>> Tainted: [E]=UNSIGNED_MODULE
>>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>>> XER: 00000036
>>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>>> IRQMASK: 1
>>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>>> c00000013d814540
>>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>>> 0000000000000000
>>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>>> 0000000084002268
>>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>>> 0000000000020000
>>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>>> 0000000000000000
>>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>>> c00000013d814500
>>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>>> c0000001e0957878
>>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>>> c0000001e0957888
>>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>>> Call Trace:
>>>> 0xc0000001e0957890 (unreliable)
>>>> __mutex_lock.constprop.0+0x58/0xd00
>>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>>> sys_ioctl+0x134/0x180
>>>> system_call_exception+0x114/0x300
>>>> system_call_vectored_common+0x15c/0x2ec
>>>>
>>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>>> ensuring that the reserved trap area matches the allocation size
>>>> across all page sizes.
>>>>
>>>> cc: stable@vger.kernel.org
>>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 139642eacdd0..a5eae49f9471 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>>>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>>   						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
>>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>>
>>> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>>>
>>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>>
>> Thanks Christian for reviewing this patch.
>>
>> It is defined in kfd_priv.h.
>>
>> /*
>>   * Size of the per-process TBA+TMA buffer: 2 pages
>>   *
>>   * The first chunk is the TBA used for the CWSR ISA code. The second
>>   * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>   */
>> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>
>>
>>
>> Could you please suggest the correct way to fix this issue?
> I'm only looking from the POV of the VM code on this, but my educated guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the CPU page size.
>
> Background is that this is written by the shader trap handler and that byte code doesn't care what CPU architecture you have.
>
> But I think only the engineers working on that trap handler can really answer this. @Felix / @Philip?


Hi @christian @Felix @Philip

To remove the dependency on CPU page size, can we use

+#define AMDGPU_VA_RESERVED_TRAP_SIZE    (2ULL << 16)

During reservation, we reserve 128 bytes, but during
allocation, we use 2 * PAGE_SIZE.


-Donet

>
> Regards,
> Christian.
>
>> -Donet
>>
>>> Regards,
>>> Christian.
>>>
>>>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>>   						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>   #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
