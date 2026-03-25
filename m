Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43712103A99F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 10:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C255A10E197;
	Wed, 25 Mar 2026 10:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="n0dRZI6u";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D7D10E197
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 10:26:58 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OIh1pQ428595; Wed, 25 Mar 2026 10:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xEzctg
 L2toZZpM14O+9eMtShPKtafLMsZurlEi6TqBE=; b=n0dRZI6u/J6S1226npX6Zm
 f7WmR25hx78wOid3oJUTBawOckf3O9k73eJ9FMoFzgdwuysC8bwlQuzPhHbbSWWh
 wbBMTnVS1+90QmduJBYYE9Msi5lCwhXhJWpBRgwQaWz9smz8XllUqNBbas4PLtaT
 AW17LltdorGzCgiuG7ZfmBwJT4m1TFYpsUDBFDpA1fnCwWsksNSYWCv4zOuW3tA0
 gUP2HtJtFSVoNMdlSUl2LAqXEya5+O3ztL6uqWRB4yxYUqR/WodQ3zoIufSeKeYy
 4EmLGEuMzn1Kk5El7Krzi4ER9+sVdxogxoXP6REqkWGU0RT7R73c1V7SSySB5QGw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky072wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 10:26:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAGEuD006009;
 Wed, 25 Mar 2026 10:26:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yp6na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 10:26:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PAQrdx2884596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 10:26:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F8135805D;
 Wed, 25 Mar 2026 10:26:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD26F58059;
 Wed, 25 Mar 2026 10:26:49 +0000 (GMT)
Received: from [9.39.25.125] (unknown [9.39.25.125])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 10:26:49 +0000 (GMT)
Message-ID: <79783c4d-13cb-4ae9-b2ba-45c066fb515a@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:56:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
 <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
 <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
 <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
 <cbbc63ba-0c21-4fd9-b701-d79356b75d12@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <cbbc63ba-0c21-4fd9-b701-d79356b75d12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MyBTYWx0ZWRfX+NQpmWN98oUq
 Rwt0p76Ry+jvcmAqYihHZXoPch9yJ+dIFMqrlJ2tjBtHBft0vx0j8r/Extwc9BCWU5Jm2mIMcdb
 YbC1JQxcs809p3Yzf/E/QK1EmzNrLKkHIANjHaZrfNo/p4WUBcuLjS1q4BwTYqJN9CV5U0n79qY
 VxbBKlsmbAs0i4N0tN4lkpYIXxkD96w/gL7U54+XEWGm4VnaUOx3mvFP5Pw8EXQVdxrZaQ3jb5e
 XdQs/kfnwqUaXOsyqa5TKbDPQhNYO7wn2TrqW/XLTWU3M5yu9mkxJs3ohhe9MzRYrhT7q2QbwK+
 CFGQ6qYI/e0BbDfuftgUM9s+McKx02UGgy7ZIASsr0naA8NgRIl5savdCylxYVYCUvsFVPo7WB4
 k0sHX3QVdNpYHvVL2BG35pZ8umgEBc1PoUN4s6V6mBra2OWsLcWcngLsnnljCX+V2FQDTgLhvsK
 BGK2qYUB0ze7IyrtGQQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3b86f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=D-IjpWJdYNhAPmWGjlQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kfs9QcFhAD3JtDPicFPA1tvblV8xPZW7
X-Proofpoint-GUID: MHqapQdhllkkx_vPSfbbNtHYpDTsJAOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250073
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


On 3/25/26 3:04 PM, Christian König wrote:
> On 3/25/26 03:26, Kuehling, Felix wrote:
>> On 2026-03-24 14:19, Donet Tom wrote:
>>> On 3/23/26 6:42 PM, Christian König wrote:
>>>> On 3/23/26 12:50, Donet Tom wrote:
>>>>> On 3/23/26 3:41 PM, Christian König wrote:
>>>>>
>>>>> Hi Christian
>>>>>
>>>>>> On 3/23/26 05:28, Donet Tom wrote:
>>>>>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>>>>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>>>>>> 4K pages, both values match (8KB), so allocation and reserved space
>>>>>>> are consistent.
>>>>>>>
>>>>>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>>>>>>> while the reserved trap area remains 8KB. This mismatch causes the
>>>>>>> kernel to crash when running rocminfo or rccl unit tests.
>>>>>>>
>>>>>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>>>>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>>>>>> Faulting instruction address: 0xc0000000002c8a64
>>>>>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>>>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>>>>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>>>>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>>>>>> Tainted: [E]=UNSIGNED_MODULE
>>>>>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>>>>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>>>>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>>>>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>>>>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>>>>>> XER: 00000036
>>>>>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>>>>>> IRQMASK: 1
>>>>>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>>>>>> c00000013d814540
>>>>>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>>>>>> 0000000000000000
>>>>>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>>>>>> 0000000084002268
>>>>>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>>>>>> 0000000000020000
>>>>>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>>>>>> 0000000000000000
>>>>>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>>>>>> c00000013d814500
>>>>>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>>>>>> c0000001e0957878
>>>>>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>>>>>> c0000001e0957888
>>>>>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>>>>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>>>>>> Call Trace:
>>>>>>> 0xc0000001e0957890 (unreliable)
>>>>>>> __mutex_lock.constprop.0+0x58/0xd00
>>>>>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>>>>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>>>>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>>>>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>>>>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>>>>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>>>>>> sys_ioctl+0x134/0x180
>>>>>>> system_call_exception+0x114/0x300
>>>>>>> system_call_vectored_common+0x15c/0x2ec
>>>>>>>
>>>>>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>>>>>> ensuring that the reserved trap area matches the allocation size
>>>>>>> across all page sizes.
>>>>>>>
>>>>>>> cc: stable@vger.kernel.org
>>>>>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>>>>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> index 139642eacdd0..a5eae49f9471 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>>>>>    #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>>>>>>    #define AMDGPU_VA_RESERVED_SEQ64_START(adev) (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>>>>>                             - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>>>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>>>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << PAGE_SHIFT)
>>>>>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>>>>>
>>>>>> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>>>>>>
>>>>>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>>>>>
>>>>> Thanks Christian for reviewing this patch.
>>>>>
>>>>> It is defined in kfd_priv.h.
>>>>>
>>>>> /*
>>>>>    * Size of the per-process TBA+TMA buffer: 2 pages
>>>>>    *
>>>>>    * The first chunk is the TBA used for the CWSR ISA code. The second
>>>>>    * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>>>>    */
>>>>> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>>>>
>>>>>
>>>>>
>>>>> Could you please suggest the correct way to fix this issue?
>>>> I'm only looking from the POV of the VM code on this, but my educated guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the CPU page size.
>>>>
>>>> Background is that this is written by the shader trap handler and that byte code doesn't care what CPU architecture you have.
>>>>
>>>> But I think only the engineers working on that trap handler can really answer this. @Felix / @Philip?
>>>
>>> Hi @christian @Felix @Philip
>>>
>>> To remove the dependency on CPU page size, can we use
>>>
>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE    (2ULL << 16)
>>>
>>> During reservation, we reserve 128 bytes, but during
>>> allocation, we use 2 * PAGE_SIZE.
>> We only need two GPU pages here. I think what Christian is objecting to is, that the GPU VM layout should not depend on the CPU page size.
> Yes, exactly that was my concern.
>
>> @Christian, it sounds like the BO allocations happen with 64KB granularity, but the mapping is still using 4KB granularity. Is the right solution to GPU-map only the first 8KB of the trap handler BO to keep the layout the same across CPU architectures?
> Well that would work technically, but I agree that it also sounds a bit questionable as well.
>
>> I guess then the "correct" solution would be to change amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu and amdgpu_amdkfd_gpuvm_map_memory_to_gpu to support mapping of the requested size with GPU page size granularity regardless of the CPU page size. But that would increase complexity for a very niche uses case.
>>
>> An easier solution would be to PAGE_ALIGN 8KB to the system page size. But that results in the virtual address space layout to depend on the system page size.
> Yeah, that dependency is certainly undesirable. We could easily end up with issues which can only be reproduced on systems with 64k page size.
>
>> If that's objectionable, then the next best solution is to round up the trap handler size to 64KB byte unconditionally, so its the same with 4KB or 64KB system page size. But that would mean unnecessarily wasting a little memory per process/GPU on x86.
> How about we always reserve 64KiB address space (or maybe even more, if you reserve 2MiB or 64KiB doesn't matter), but only map as large as the allocated buffer actually is?
>
> I think that this would be my preferred solution.


Hi @Christian @Felix

Thanks for the review.

I have made the suggested change. I am now reserving 64 KB
in the  address space for the trap, while allocating
only 8 KB for both 4K and 64K page sizes. With this change,
I am no longer seeing crashes on either 4K or 64K systems.

Does this approach look reasonable to you?

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bb276c0ad06d..d5b7061556ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
  #define AMDGPU_VA_RESERVED_SEQ64_SIZE          (2ULL << 20)
  #define AMDGPU_VA_RESERVED_SEQ64_START(adev) 
  (AMDGPU_VA_RESERVED_CSA_START(adev) \
                                                  - 
AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE           (1ULL << 16)
  #define AMDGPU_VA_RESERVED_TRAP_START(adev) 
(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
                                                  - 
AMDGPU_VA_RESERVED_TRAP_SIZE)
  #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e5b56412931b..035687a17d89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -102,8 +102,8 @@
   * The first chunk is the TBA used for the CWSR ISA code. The second
   * chunk is used as TMA for user-mode trap handler setup in 
daisy-chain mode.
   */
-#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
-#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
+#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
+#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)

  #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE               \
         (KFD_MAX_NUM_OF_PROCESSES *



>
> Regards,
> Christian.
>
>> Regards,
>>    Felix
>>
>>
>>>
>>> -Donet
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> -Donet
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>    #define AMDGPU_VA_RESERVED_TRAP_START(adev) (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>>>>>                             - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>>>>    #define AMDGPU_VA_RESERVED_BOTTOM        (1ULL << 16)
