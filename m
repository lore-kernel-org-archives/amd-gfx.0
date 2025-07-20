Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0994FC83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 12:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFEF895CA;
	Sun, 20 Jul 2025 12:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GvzWUlFD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09AA895CA
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 12:49:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4570545531;
 Sun, 20 Jul 2025 12:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B65C4CEE7;
 Sun, 20 Jul 2025 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753015792;
 bh=oxFpdknoeX5Vw+UUVKkbtToVxydEtk2SgKvQHO4LClA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GvzWUlFD5xtVgR4UOIIYcFPe2ZprorZ8ZGG+bXlshclLbKYjwp40Eg+C4sLajjrPF
 62cjZW0idnISxvQ1FVr8yi5SwGi8whd368XgEGRjERcAJpoda4/InBqp++bc+oiprP
 TUNIg4pzl2ymi4ELcsDptVd4Qwx6Qpx/8y4lzwxVqXpYBvKflp6UGoLqw/09r8NjF0
 3hrHJuRsZeCpJZKlMcDFamJD0HAcI5gPUdV77NNlGOJqhZ5U2QK0DVfUPBftiZCNz8
 +Bi7NqFynEo+emRFifeUKiBT7xs+qy0IzOV6Ey5Ktu/yVMF+342ZWb4fjfua438tja
 g7AqvYW8liYCw==
Message-ID: <18a71fc3-dd01-4335-9655-716c87048530@kernel.org>
Date: Sun, 20 Jul 2025 07:49:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi> <aHy4tohvbwd1HpxI@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aHy4tohvbwd1HpxI@hacktheplanet.fi>
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



On 7/20/25 4:36 AM, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")
> Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f58fa5da7fe5..8a5b5dfad1ab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4941,9 +4941,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   	caps = &dm->backlight_caps[aconnector->bl_idx];
>   	if (get_brightness_range(caps, &min, &max)) {
>   		if (power_supply_is_system_supplied() > 0)
> -			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
> +			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
>   		else
> -			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
> +			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
>   		/* min is zero, so max needs to be adjusted */
>   		props.max_brightness = max - min;
>   		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,

Thanks! The change makes sense.  Besides Greg's comments can you please 
send out of the regression thread?  IMO This should be it's own patch 
thread.
