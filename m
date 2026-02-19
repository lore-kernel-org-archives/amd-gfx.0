Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4EE9A048
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 13:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9E410E6E5;
	Thu, 19 Feb 2026 13:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hmeef2k3";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E131810E6DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 13:59:35 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fGw3m3NWtz9tnx;
 Thu, 19 Feb 2026 14:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771509572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAWAsIy76rFl74iU7cMO/1VOtM6d5T/dneYxMpLeLPc=;
 b=hmeef2k3VjgRzOAdcYbMseRLYigmfUnEHxcOOTOf1fLrVxW+sL+bkMRUyBtSpL8KcibfKx
 kCzZr/E/Qaj0W4m5YAASjGZ+RLxuMAr35L6/sk1++BceOO+uPUrsTwpJ/mLmkIrd9a4KLR
 6MF0HA42u12nc4YA8VdvsQr38zuNgvia8F2j9Q4A/7uleQ5lddFVybPzDF5F1Q4ww6NI4D
 ZECfTMGuABuSGeRdcxyOvqX2gehqnBc8tv70KVm7AoUzc8F8q/Uq3ECbvcZtdce1fs6mqk
 K0odvtOd8NpaPYyAJgGzc/ULZG8qfgw1LQNm/p91i6c48L1BxaVyMPoQnoK0Fw==
Message-ID: <43954b65-db3c-4f6b-837f-e025ac84788f@mailbox.org>
Date: Thu, 19 Feb 2026 14:59:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
 <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
 <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
 <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c5b26eacc40a5490b49
X-MBO-RS-META: maxmthesnnc7jg4q94a9n7686xuxjfsk
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

On 2/19/26 14:08, Michele Palazzi wrote:
> On 2/19/26 12:09, Michel Dänzer wrote:
>> On 2/18/26 11:09, Michele Palazzi wrote:
>>> On 2/18/26 10:41, Michel Dänzer wrote:
>>>> On 2/18/26 01:31, Michele Palazzi wrote:
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index a8a59126b2d2..35987ce80c71 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>>>        } else if (cursor_update && acrtc_state->active_planes > 0) {
>>>>>            spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>>>>            if (acrtc_attach->base.state->event) {
>>>>> -            drm_crtc_vblank_get(pcrtc);
>>>>> -            acrtc_attach->event = acrtc_attach->base.state->event;
>>>>> +            drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);
>>>>
>>>> Can this code run before start of vblank? If yes, the event would have the wrong sequence number and timestamp.
>>>
>>> Yes, but the original code path had the same problem.
>>
>> Are you sure?
>>
>> I'd expect the original code to send the event only when an interrupt fires during vblank, at which point the values are correct.
> 
> Actually you are indeed right, this approach potentially produces slightly anticipated cursor events, not noticeable but wrong nonetheless.

"not noticeable" by what? It might be noticeable e.g. for mutter's KMS thread deadline timer.


>>> Would drm_crtc_arm_vblank_event() be more appropriate here? The concern is that it reintroduces the starvation race if the vblank off-delay fires before the interrupt.
>>
>> Not sure that could happen, some of the issues discussed in the comment above drm_crtc_arm_vblank_event might apply though.
> 
> If i understand correctly, using drm_crtc_arm_vblank_event() we would still be having incorrect sequence, although delayed this time,

Not if used correctly, though per the comment above the function, there are various potential races as well.

> We could maybe add a dedicated flag to amdgpu_dm_crtc_handle_vblank() instead, but it's something i already tried before submitting this and it produced the second race condition, so that alone is not enough.
> 
> If there is a suggested approach i am willing to explore it

Can't the issue be solved by fixing the pflip_status handling in the vblank handler?
I guess that might also hit the second race condition:

> - If vblank is disabled by the off-delay timer before the handler
>   runs, the PENDING cursor event is never delivered and the commit hangs.

That sounds like the drm_crtc_vblank_get/put handling might be incorrect in amdgpu_dm.

In a nutshell, the vblank interrupt is kept enabled as long as there have been more 
drm_crtc_vblank_get calls than _put ones for the CRTC. I.e. amdgpu_dm needs to call the former under circumstances where it needs the interrupt to be on, and the latter only once it's no longer needed for those circumstances (in this case when sending the event).


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
