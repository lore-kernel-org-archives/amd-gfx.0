Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB113C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 02:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FF010E470;
	Mon, 21 Jul 2025 02:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eBavyu9Y";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F1D10E470
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 02:20:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ED7E05C59C8;
 Mon, 21 Jul 2025 02:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB18C4CEE7;
 Mon, 21 Jul 2025 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753064448;
 bh=5jb/stM65I+0aJAhwVu6+xUzsAk79UL5kdDuxBOv+RQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eBavyu9YloMUuBvSPrBaFBPIz8Ja0Y04OudwJ4HnqGLBVcn/jX4waGNzeN8A70QCC
 8AriE4rCaeFZNiznwfNSYbvnXW1dLv8n6iUtMR208TVHb2h+wwe+4o0CNknpNjwRtE
 GKOSkLio5a9PQ8QXcVcxuoTCJSQbnm/kpeBToR6PZbPmFrhtuaJ7IFXRZvBhawpydQ
 uEpyi1Wpxz23XQPeDTy3WtgjyzFjBlJLaSK/9vi9VH5naFQNdlJdgouER5+p5br//i
 Wk+1PHuFTOILbYdT9ptYcN+OwF4d7w+rp1G5fjUySGqald8WwMS9wjJg7l+7C1+th9
 Ke8VIO8hVd2FQ==
Message-ID: <0f094c4b-d2a3-42cd-824c-dc2858a5618d@kernel.org>
Date: Sun, 20 Jul 2025 21:20:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [PATCH v2] drm/amd/display: fix initial backlight
 brightness calculation
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
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



On 7/20/25 7:59 PM, Lauri Tirkkonen wrote:
> DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> division needs to be performed after the multiplication and not the
> other way around, to properly scale the value.
> 
> Fixes: 8b5f3a229a70 ("drm/amd/display: Fix default DC and AC levels")
> Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
> Cc: stable@vger.kernel.org

Thanks so much!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

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

