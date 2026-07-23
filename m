Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BF3C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 19:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5B310E2D9;
	Thu, 23 Jul 2026 19:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ruw+6Sg9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC76B10E2D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 19:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEF02600B1;
 Thu, 23 Jul 2026 19:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C441F000E9;
 Thu, 23 Jul 2026 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784836554;
 bh=IstEdE1mm1dk1YzWfKusFzYmF4ElNOCGCSBmMFJzhy0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ruw+6Sg9OdFRZZaEtH/etwesJQv/HcdWyKLRuCms6ZdfwH1lkUDcNeCTBSM1RoYi7
 KdsH87S9BNa6dTXFqNyF9e3/GhTtBiYQBI1j5N7tDl3Q0WrviyvtB9Q4EPOT7S7hh4
 nkPWpfvN8q516k74uPeJ1fz52r9WIyA79JWwm1KPCMTaQOzKuSUaKpmev4BKtLehAZ
 3mriP/10pjtCn/8Em4K4o+7I7sG4RwOYsYevWQ1861rFwvG1eE8yeFMICc9ZwFz70p
 tJ85D92CnUZBCzVbF72eUaLqSxFPNjfA2vBpB8eJ7/8zHGQxOPT+gmBnUcXzTLPpZL
 RC9JJ0iIA7FUw==
Message-ID: <85f87f21-d04a-4d27-ae4c-9e0cd64517fe@kernel.org>
Date: Thu, 23 Jul 2026 14:55:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix flip-done timeouts on mode1 reset
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, alexander.deucher@amd.com, stable@vger.kernel.org
References: <20260723180159.52121-1-sunpeng.li@amd.com>
 <66071e47-2743-48ab-bb3c-8a8ae4ec199d@kernel.org>
 <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
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

On 7/23/26 14:47, Leo Li wrote:
> 
> 
> On 2026-07-23 15:18, Mario Limonciello wrote:
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index 05d6915f9a6b0..079d4ccc88da6 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>>>         * is enabled. On DCE, vupdate is only needed in VRR mode.
>>>         */
>>>        if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
>>> -        rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
>>> +        if (enable) {
>>> +            rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
>>> +            drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
>>> +        } else {
>>> +            rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
>>> +            drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
>>> +        }
>>
>> For completeness in error handling, shouldn't you pass up the return code on non-zero?  It looks like it could pass up to DRM core then.
> 
> It's not shown in the context here, but the rc is passed up later:
> https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L295
> 
> - Leo
> 
Ah got it, thanks.  No concerns.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>>
>>>        } else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>>>            if (enable) {
>>> -            /* vblank irq on -> Only need vupdate irq in vrr mode */
>>> +            /* vblank irq on -> Only need vupdate irq in vrr mode
>>> +             * Not ref-counted since we need explicit enable/disable
>>> +             * for DCE VRR handling
>>> +             */
>>>                if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>>>                    rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>>>            } else {
> 

