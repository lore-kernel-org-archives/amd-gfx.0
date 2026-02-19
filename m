Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F31DE9A048
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 13:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91E110E0AC;
	Thu, 19 Feb 2026 13:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="s5HhTA5m";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D655D10E0AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1771506501; bh=zxtHWhN7P4iiWeNyrAAO4fZOHb7CZBSnGfV9FUbggWQ=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=s5HhTA5mH76GueohAzqjUXJ8LO+CFfFX6lgWW82cjfN0RILt7kgzh2uvb0CM6kUn3
 FI5Qq8epzKfwteqQHh9ROr5wuiLM95pa7mHhqEhDQ1N7WTZOlOlVAY5XTIZ1qqWgg5
 zamKzuWu+P3F2gdZbPs5Ov/PP38N+o9Nl6oh5yg7obemhEKX1fUVY9kFpBn2dsPuHS
 cuYM4sT7TFwEyxPywa1vyOdwdvPt+ygsgVgHXROJCfRYAA5xChjCFZ6B7IUvHu+qO+
 Uhjina6mDQ6xrTXjMPUWsRLbub736GvqkgFJJSS0G2Dg+c36X0EjXD7Q1kCTtPbl3U
 L5a4tllc/Vg0w==
Message-ID: <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
Date: Thu, 19 Feb 2026 14:08:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
 <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
 <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
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


On 2/19/26 12:09, Michel Dänzer wrote:
> 
> [ Fixed up the top-posting, please don't ]

thanks, i won't.

> On 2/18/26 11:09, Michele Palazzi wrote:
>> On 2/18/26 10:41, Michel Dänzer wrote:
>>> On 2/18/26 01:31, Michele Palazzi wrote:
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index a8a59126b2d2..35987ce80c71 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>>        } else if (cursor_update && acrtc_state->active_planes > 0) {
>>>>            spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>>>            if (acrtc_attach->base.state->event) {
>>>> -            drm_crtc_vblank_get(pcrtc);
>>>> -            acrtc_attach->event = acrtc_attach->base.state->event;
>>>> +            drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);
>>>
>>> Can this code run before start of vblank? If yes, the event would have the wrong sequence number and timestamp.
>>
>> Yes, but the original code path had the same problem.
> 
> Are you sure?
> 
> I'd expect the original code to send the event only when an interrupt fires during vblank, at which point the values are correct.

Actually you are indeed right, this approach potentially produces 
slightly anticipated cursor events, not noticeable but wrong nonetheless.

>> Would drm_crtc_arm_vblank_event() be more appropriate here? The concern is that it reintroduces the starvation race if the vblank off-delay fires before the interrupt.
> 
> Not sure that could happen, some of the issues discussed in the comment above drm_crtc_arm_vblank_event might apply though.

If i understand correctly, using drm_crtc_arm_vblank_event() we would 
still be having incorrect sequence, although delayed this time, if so i 
am not sure a v2 using that would be any better.

We could maybe add a dedicated flag to amdgpu_dm_crtc_handle_vblank() 
instead, but it's something i already tried before submitting this and 
it produced the second race condition, so that alone is not enough.

If there is a suggested approach i am willing to explore it





