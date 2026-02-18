Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC10E9A04C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 11:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7915110E6C2;
	Thu, 19 Feb 2026 11:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="WHWLwiRs";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B7B10E59E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1771409374; bh=b13CRDRWY7m0QdxhY2EQ1/+9RywH/Hi6A6ec55Hjluk=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=WHWLwiRsNOjW5w51k1TuCDu7zgcUNrM/VB5n3ePCp4lsVi9gPS+Oxs5SGWugBsYRn
 QFAffa/msg9Do1ZkzOUh5I7gI6PayELOkYqespNGPlJtchmbBL/bmJUuMkDQvlLhm9
 6UQvtv71iMAjsOIiCVG8i2ETPLq6L/3FUTx0n3Yz8PBTmuD0Z2TOBARBBnVsMF/MJd
 RneFLynkXfkn+pnCm3nJdBkfVGfZh95uYTYTboeDifN0oIpTQRIBn+GK9rWPgS965T
 q4agA7Oi6QrHiC6nr+A5mliFqAFPIVHLbXj81RGygMAbGqjQ9AXu4fOJwzzDiEt4pg
 +DQLES3DeIchQ==
Message-ID: <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
Date: Wed, 18 Feb 2026 11:09:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Feb 2026 10:59:48 +0000
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

Yes, but the original code path had the same problem.

Would drm_crtc_arm_vblank_event() be more appropriate here? The concern 
is that it reintroduces the starvation race if the vblank off-delay 
fires before the interrupt.

On 2/18/26 10:41, Michel Dänzer wrote:
> On 2/18/26 01:31, Michele Palazzi wrote:
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a8a59126b2d2..35987ce80c71 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10168,8 +10168,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>   	} else if (cursor_update && acrtc_state->active_planes > 0) {
>>   		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>   		if (acrtc_attach->base.state->event) {
>> -			drm_crtc_vblank_get(pcrtc);
>> -			acrtc_attach->event = acrtc_attach->base.state->event;
>> +			drm_crtc_send_vblank_event(pcrtc, acrtc_attach->base.state->event);
> 
> Can this code run before start of vblank? If yes, the event would have the wrong sequence number and timestamp.
> 
> 

