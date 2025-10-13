Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C46ACCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFFA10E475;
	Mon, 13 Oct 2025 14:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S7Obeeh3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E0710E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:03:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C09D43772;
 Mon, 13 Oct 2025 14:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78768C4CEE7;
 Mon, 13 Oct 2025 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760364235;
 bh=BAmJtqvfittnIApXdZARrikYv/k7r/sGm0zU8XFguWo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S7Obeeh3KgLFptOwLHxv/CeHRlj7OxSHR/eaNRIFtu28JDTxq7nvah0C/e+yey92h
 5UObY5TRx3uISp8SPIxDjlUWEoqpnmIUe+j+gBLn350BL6l7HexHziP7YTo3g/IQhj
 ctb4uqFPr/7saVC/ZKpvU+ZOocU3mr0v1xhMvpjox5Uw0MvqrbtfAap8Uhu6RtVPTG
 fTxHXgm00CeD+knRqs84DCwRba5xlvBo9gcZ7ZfW+wPYkAgm6RrK0H+m92WtGASjgn
 28oXJZ6vovfaqNTNiCH/naICctbIClD/krVqN1vkrW/EBSTy1gKpDGc4bEqg9URlpZ
 /QuHlxizmGoTQ==
Message-ID: <944a8da2-7b01-4a0c-846e-66e5ba908e51@kernel.org>
Date: Mon, 13 Oct 2025 09:03:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
 handler
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Lee, Peyton" <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
References: <20251012191823.856295-1-superm1@kernel.org>
 <DS0PR12MB78042769FD23A8C5346A561497EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <46350316-9b32-4495-8e8c-c9672da34156@kernel.org>
 <DS0PR12MB7804BA493A16EFD092EB6A9897EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <DS0PR12MB7804BA493A16EFD092EB6A9897EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/13/25 8:59 AM, Lazar, Lijo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Mario Limonciello <superm1@kernel.org>
>> Sent: Monday, October 13, 2025 7:21 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Lee, Peyton
>> <Peyton.Lee@amd.com>; Sultan Alsawaf <sultan@kerneltoast.com>
>> Subject: Re: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
>> handler
>>
>> On 10/12/25 11:54 PM, Lazar, Lijo wrote:
>>> [Public]
>>>
>>> Doesn't this translate to just a higher idle timeout (VPE_IDLE_TIMEOUT ) for
>> the particular VPE version?
>>>
>>> Thanks,
>>> Lijo
>>
>> Yes if the VPE microcode adjusts DPM at runtime this makes sure that it has
>> settled when workload is complete.
>>
>> I expect that a higher VPE_IDLE_TIMEOUT would work too, but it seems less
>> scalable to me.
>>
> [lijo]
> 
> I guess VPE firmware behavior could vary across generations. For ex: even if it doesn't lower the clocks in this generation, it could do so after seeing a power gate (any handshake with PMFW). Or, even if it doesn't lower the clock, it may adjust the clocks after powering up.
> 
> So probably just keeping vpe.idle_timeout as a variable based on IP version may be good enough for the current issue.

"Ideally" PMFW would lower clocks before turning off VPE, but that's not 
the case right now on Strix Halo.  We just get lucky with older VPE 
microcode that it doesn't change this.

My thought was this current solution will work properly on all microcode 
version on all products.  If PMFW changes behavior we could add 
conditional code later to only do this check for DPM level if on older PMFW.

Alex,

What do you want to see here?
> 
> Thanks,
> Lijo
> 
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Mario Limonciello (AMD)
>>>> Sent: Monday, October 13, 2025 12:48 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Lee, Peyton
>>>> <Peyton.Lee@amd.com>; Sultan Alsawaf <sultan@kerneltoast.com>
>>>> Subject: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle
>>>> handler
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> [Why]
>>>> Newer VPE microcode has functionality that will decrease DPM level
>>>> only when a workload has run for 2 or more seconds.  If VPE is turned
>>>> off before this DPM decrease, the SOC can get stuck with a higher DPM level.
>>>>
>>>> This can happen from amdgpu's ring buffer test because it's a short
>>>> quick workload for VPE and VPE is turned off after 1s.
>>>>
>>>> [How]
>>>> In idle handler besides checking fences are drained check that VPE
>>>> DPM level is really is at DPM0. If not, schedule delayed work again until it is.
>>>>
>>>> Cc: Peyton.Lee@amd.com
>>>> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v3:
>>>> * Use label to avoid a register read if fences active
>>>> ---
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 15 ++++++++++++---
>>>> 1 file changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>>> index 474bfe36c0c2f..e8e512de5992a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>>> @@ -326,14 +326,23 @@ static void vpe_idle_work_handler(struct
>>>> work_struct *work)  {
>>>>         struct amdgpu_device *adev =
>>>>                 container_of(work, struct amdgpu_device,
>>>> vpe.idle_work.work);
>>>> +      struct amdgpu_vpe *vpe = &adev->vpe;
>>>>         unsigned int fences = 0;
>>>> +      uint32_t dpm_level;
>>>>
>>>>         fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
>>>> +      if (fences)
>>>> +              goto reschedule;
>>>>
>>>> -      if (fences == 0)
>>>> +      dpm_level = adev->pm.dpm_enabled ?
>>>> +                  RREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>>>> regs.dpm_request_lv)) : 0;
>>>> +      if (!dpm_level) {
>>>>                 amdgpu_device_ip_set_powergating_state(adev,
>>>> AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>>>> -      else
>>>> -              schedule_delayed_work(&adev->vpe.idle_work,
>>>> VPE_IDLE_TIMEOUT);
>>>> +              return;
>>>> +      }
>>>> +
>>>> +reschedule:
>>>> +      schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>>>> }
>>>>
>>>> static int vpe_common_init(struct amdgpu_vpe *vpe)
>>>> --
>>>> 2.43.0
>>>
> 

