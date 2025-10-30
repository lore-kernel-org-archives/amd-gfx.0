Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F300CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C226210E9DE;
	Thu, 30 Oct 2025 15:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mBN0aoU1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8456B10E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:20:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E3F6761CED;
 Thu, 30 Oct 2025 15:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4C2C4CEF8;
 Thu, 30 Oct 2025 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761837623;
 bh=YjSyGFym0qydSuS0W0gAnrXMJDmimvYgbHCNnj86w7s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mBN0aoU1iQ6Gfz8xrU8TkxkjaNN92OcCPJV2m/l0DgjK1U2oYTMhGOV5//YBI/6bE
 Aw0tWrDJzTXAGBq+veuZBdY5wypOUV2ZIBs5QLoz2/i15zOqbm1dC0Ns+cempFJpFD
 AXJtRj8TmTmQG63MDmTWKZmvWWx3x97ttQatVCRvoH9EW2DjduLBeB/aiJRM7njrua
 fI0/GAcqqR5il4+4FepRX9uCjpTPpic9i6GOalMegwa8G/ESJoFV+DZVE/5bRBdUal
 83eixpcJZtclWtrvQ/lCn1VpnlcDrtC2kZg8uiCEDponF/ZAz1tsl2nMypZ/o0Y0Am
 J1BAKPamg3HZA==
Message-ID: <be426b87-ef51-40df-be42-b0a0a53209de@kernel.org>
Date: Thu, 30 Oct 2025 10:20:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] drm/amd: Add an unwind for failures in
 amdgpu_device_ip_suspend_phase1()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251026042942.549389-1-superm1@kernel.org>
 <20251026042942.549389-3-superm1@kernel.org>
 <CADnq5_NuD-h26B8tjPAKmWPE=48u6iFgYibi3uR9XXZuY=B5EA@mail.gmail.com>
 <fbf9fa5c-1c60-423c-a06b-b5e8525590ab@kernel.org>
 <CADnq5_Of+btg8pGcdOx1DDVv8uoeYq7myRZ5ycf0cK3hzTVNSg@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CADnq5_Of+btg8pGcdOx1DDVv8uoeYq7myRZ5ycf0cK3hzTVNSg@mail.gmail.com>
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



On 10/30/2025 10:18 AM, Alex Deucher wrote:
> On Thu, Oct 30, 2025 at 11:16 AM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/30/2025 10:14 AM, Alex Deucher wrote:
>>> Patches 2-4 are:
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Thanks!
>>
>> How about patch 1?  Patch 4 builds on it, so if that doesn't go in there
>> is another unwind step needed.
> 
> Oh, yeah, feel free to add my RB on that one as well, I guess it's not
> quite the same as the one I sent out originally.

OK Thanks.  Will queue up 1-4 and will drop #5 based on your comments 
from v4.

> 
> Alex
> 
>>
>>>
>>> On Sun, Oct 26, 2025 at 12:36 AM Mario Limonciello (AMD)
>>> <superm1@kernel.org> wrote:
>>>>
>>>> If any hardware IPs involved with the first phase of suspend fail, unwind
>>>> all steps to restore back to original state.
>>>>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++++--
>>>>    1 file changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index f6850b86e96f..b9ea91b2c92f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -178,6 +178,7 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
>>>>                   BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) |
>>>>                   BIT(AMD_IP_BLOCK_TYPE_PSP)
>>>>    };
>>>> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev);
>>>>
>>>>    static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
>>>>
>>>> @@ -3784,7 +3785,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
>>>>     */
>>>>    static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>    {
>>>> -       int i, r;
>>>> +       int i, r, rec;
>>>>
>>>>           amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>           amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>> @@ -3807,10 +3808,23 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>
>>>>                   r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
>>>>                   if (r)
>>>> -                       return r;
>>>> +                       goto unwind;
>>>>           }
>>>>
>>>>           return 0;
>>>> +unwind:
>>>> +       rec = amdgpu_device_ip_resume_phase3(adev);
>>>> +       if (rec)
>>>> +               dev_err(adev->dev,
>>>> +                       "amdgpu_device_ip_resume_phase3 failed during unwind: %d\n",
>>>> +                       rec);
>>>> +
>>>> +       amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW);
>>>> +
>>>> +       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
>>>> +       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>>>> +
>>>> +       return r;
>>>>    }
>>>>
>>>>    /**
>>>> --
>>>> 2.51.1
>>>>
>>

