Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA09C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71BF10E9A7;
	Thu, 10 Apr 2025 13:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="adxg/n7r";
	dkim-atps=neutral
X-Greylist: delayed 516 seconds by postgrey-1.36 at gabe;
 Wed, 09 Apr 2025 17:59:29 UTC
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0F08710E02A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
 t=1744221049; bh=nh8izWq+X0yrSGUlkZVxxOQsp+Fnt2wudcI3xDGhFs4=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=adxg/n7rXF5kxF9b6tAoyRZNpYzUo7uelPvSO3YLXBBjjTblyIRjAtq7wP0NRGFWF
 rtA+PNnRbFKQRj5ZGFwzXP5MBUbdIDP477R9wyPPxjyJThGZTJh2vV50OIw7syuZM8
 3cpBF8u85XTbJePE+uticylkZJYlrSzo7KC1Oqq8F2C0fMqn1kgHUH30/WnAAFQ0iX
 6ti04dNM24W8jdbTQm52x0ju9UZsQsmZlngsiWX+gaNxDA17DOQ01SYFcaQABn8rBs
 VgsPtkFC1JiTOy97LB++aLui9oWMEMRqpK6rKf7DGDEcSPpcEjHwQ4tu67LsrZYY1T
 1KSawr2Q+Ov0MpJAgFbf47Z5bFI1qWT6+pyP2NtpcYkcgaNKGS+OEd6lOQKLhSXA68
 8gXqI2D+MQXJPQ2vPDVs4epWUjbtrIxG9xzl/9vXlVrxhPDUYipYo0845HHad4KEbD
 grY8qelZNsEWocVRW0KNu0LxLVfNesfv2Jf1Mu3jQKcDAhL57QQ4yO11EODKltoIpk
 M66dWy/6C9bZ+ULrLsKQxDjLTIh51Fg10zS9FxMWsIpGoJCXtPBmfD152LgdlyBcNx
 jD4/nY6+Fj7MZz1bcDISuZ4tIB+JtjYGCZg2AqIVRLZCF+S9gbyGLc79T9sWSqWRcB
 NCd1dmbtazGJP+pUX6Q6fNX8=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
 by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 9EB651629F9;
 Wed,  9 Apr 2025 19:50:49 +0200 (CEST)
Message-ID: <a195aab4-b5df-4f51-b6be-84e76003907f@ijzerbout.nl>
Date: Wed, 9 Apr 2025 19:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/amd/display: use drm_err in
 create_validate_stream_for_sink()
To: amd-gfx@lists.freedesktop.org
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
 <20250326195202.17343-4-Jerry.Zuo@amd.com>
Content-Language: en-US
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250326195202.17343-4-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:30 +0000
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

Op 26-03-2025 om 20:49 schreef Fangzhi Zuo:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> make the drm device available in create_validate_stream_for_sink()
> so that drm_err() can be used
>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 16e2823f83b1..639b1c01cbf9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> [...]
> @@ -6872,6 +6872,7 @@ create_stream_for_sink(struct drm_connector *connector,
>   		       const struct dc_stream_state *old_stream,
>   		       int requested_bpc)
>   {
> +	struct drm_device *dev = connector->dev;
Here `connector` is used before checking for a NULL pointer.
>   	struct amdgpu_dm_connector *aconnector = NULL;
>   	struct drm_display_mode *preferred_mode = NULL;
>   	const struct drm_connector_state *con_state = &dm_state->base;
> @@ -6895,7 +6896,7 @@ create_stream_for_sink(struct drm_connector *connector,
>   	memset(&saved_mode, 0, sizeof(saved_mode));
>   
>   	if (connector == NULL) {
> -		DRM_ERROR("connector is NULL!\n");
> +		drm_err(dev, "connector is NULL!\n");
>   		return stream;
>   	}
>
This if statement a little later makes me think that it *is* possible that
`connector` can be NULL. (If not then the whole if can be removed.)
-- 
Kees
