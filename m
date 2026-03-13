Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A855107BCD1
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 23:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784DB10E432;
	Fri, 13 Mar 2026 23:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pQIdOvS2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0DF10E432
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 23:58:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7795B60008;
 Fri, 13 Mar 2026 23:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FA8C19421;
 Fri, 13 Mar 2026 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773446320;
 bh=r0cd1om1L6suNE9Lk75EmKlOheDhnjQsUXN8RTmJ/4k=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=pQIdOvS2pxXA+S6o8XdE1bHXV5zwfTlMN7oxfo9KOA2YTgCRpYY+GWBazM2Ib9Izc
 LH+2vpOw1ZNQpCLTx86m+sn3gCo/G7phK1YX9/viqGM6PDXVmPeBUCtAZ1qoJr/e1D
 a+6eOPa9Ug1yoWGTEHYaZ53ITjC7CXX/yiNVMy5Mrj8/q94s5IZbxp51hdbelRMWlf
 pe4CCl24ovfVw63wEO30ENTge2+K1ZtH24gHqpEZSntBz3T3nOcO5rJY9ednyHFemQ
 HElOkJEsAwTvxwQ6mt8L4dPcE7ZkVddw0FTfPWvHXe8o2dEQijO00LI6qKZkVySPXP
 EPUa1Fv90xTPA==
Message-ID: <9bbdbe21-010a-4fe3-b480-1a94c55a0ea3@kernel.org>
Date: Fri, 13 Mar 2026 18:58:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
 <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
 <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
 <541ae425-cd9b-4088-addf-0a212df9dd8e@amd.com>
 <39534a37-ace9-4623-9bce-dee0f7e7fa06@amd.com>
 <2bce8ba2-c36f-4c64-b54e-aeb964a47ebc@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2bce8ba2-c36f-4c64-b54e-aeb964a47ebc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Well the original patch was intended for userq but is causing issues on 
systems without userq.  How about just narrowing it down to only userq 
for now until we have a root cause?

On 3/13/26 7:03 AM, Christian König wrote:
> Yeah, but that is still not the root cause.
> 
> Attaching the TLB fence all the time just makes more use of the MES, it doesn't cause any additional problems which wouldn't have been there before.
> 
> Regards,
> Christian.
> 
> On 3/12/26 22:08, Mario Limonciello wrote:
>> There is actually a contingent of two people who claim that this patch is the cause for MES resets here:
>>
>> https://gitlab.freedesktop.org/drm/amd/-/issues/4749
>>
>>
>> On 3/5/2026 3:43 AM, Christian König wrote:
>>> The original reporter already mentioned on the ticket that this patch is not the actual cause of the issues.
>>>
>>> It basically just changes timing to create and eventually wait for the TLB fence to signal.
>>>
>>> Let's see what the reporter finds with his extended bisect.
>>>
>>> Regards,
>>> Christian.
>>>
>>> On 3/5/26 07:48, Liang, Prike wrote:
>>>> [Public]
>>>>
>>>> It’s possible that we failed to save and invalidate some active pages during suspend, which then prevents those pages from being restored correctly on resume.
>>>>
>>>> For now, we still rely on this patch to keep the userq page tables updated and synchronized. Until the full solution is ready, how about we fall back to the initial approach and restrict this TLB flush to only the userq path?
>>>>
>>>> Regards,
>>>>         Prike
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Wednesday, March 4, 2026 9:57 PM
>>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>>>> gfx@lists.freedesktop.org
>>>>> Cc: Liang, Prike <Prike.Liang@amd.com>
>>>>> Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
>>>>>
>>>>> On 3/4/26 14:54, Alex Deucher wrote:
>>>>>> This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.
>>>>>>
>>>>>> This causes framebuffer corruption after suspend.
>>>>>
>>>>> But prevents massive memory corruption with userqueues.
>>>>>
>>>>> I have strong doubts that this is related to the FB corruption in any way, it will just
>>>>> change the timing.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: Prike Liang <Prike.Liang@amd.com>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index 01fef0e4f4085..25b1d679ba262 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct
>>>>> amdgpu_vm_update_params *params,
>>>>>>       }
>>>>>>
>>>>>>       /* Prepare a TLB flush fence to be attached to PTs */
>>>>>> -   if (!params->unlocked) {
>>>>>> +   if (!params->unlocked && vm->is_compute_context) {
>>>>>>               amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>>>>
>>>>>>               /* Makes sure no PD/PT is freed before the flush */
>>>>
>>>
>>>
>>
> 
> 

