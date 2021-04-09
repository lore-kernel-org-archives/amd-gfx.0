Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F5C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 13:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C56610FB
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 13:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C56610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9386EA1C;
	Fri,  9 Apr 2021 13:19:55 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4256EA1C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 13:19:53 +0000 (UTC)
Date: Fri, 09 Apr 2021 13:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1617974391;
 bh=tHPkIhE14AwUmcCL/p2WjqB6xb4AsRVTbsP7rUcY6tY=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=DY1NuncJpvOyXa9BmJEAqv9C2oTCUPZLZwuvdTs/PQnCETxCgfahU+I+hH3CWrB8K
 cYHZ0shPsjCu51CPCiXeIgWCzpmTqtbLCXOxr4QV5n+V4UeXMFfEYFtFDHYkuTMEd+
 76zfKgNGWFRXA5vUQ/lZJf5Igygbik03K0HaVqHcxxvPEC6JvbSI8FznNlDZmx3YKc
 d3dZTocDbukho5r+VdQ0w09Dqazuz5i1GNdowYSL6PvMvfrYpvSmvko00gI02GTYlW
 NHrXEzTliw6OhvDkpg+QEzGiHEMqV5pI7eNWXukTJGemJ9T4dBSgVz02DTM6bOLk8B
 CLiIMJSHu6TMA==
To: Simon Ser <contact@emersion.fr>
From: Simon Ser <contact@emersion.fr>
Subject: Re: amd/display: allow non-linear multi-planar formats
Message-ID: <YsPGje8t2-fY1GTI6waUph1jQzm5WtagjUUi0lFy3Q7_I20gG8Ln1bIBqi00nj5RMzdkFhrftPbUrpqwrV2bSvEJbDD8IG9dPHAaZNTLQM8=@emersion.fr>
In-Reply-To: <20210326165944.1310-1-contact@emersion.fr>
References: <20210326165944.1310-1-contact@emersion.fr>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Can you have a look at this patch?

Thanks,

Simon

On Friday, March 26th, 2021 at 5:59 PM, Simon Ser <contact@emersion.fr> wrote:

> Accept non-linear buffers which use a multi-planar format, as long
> as they don't use DCC.
>
> Tested on GFX9 with NV12.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 36ee52104007..66e3ecf123d1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4216,13 +4216,6 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>  	if (modifier == DRM_FORMAT_MOD_LINEAR)
>  		return true;
>
> -	/*
> -	 * The arbitrary tiling support for multiplane formats has not been hooked
> -	 * up.
> -	 */
> -	if (info->num_planes > 1)
> -		return false;
> -
>  	/*
>  	 * For D swizzle the canonical modifier depends on the bpp, so check
>  	 * it here.
> @@ -4241,6 +4234,10 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>  		/* Per radeonsi comments 16/64 bpp are more complicated. */
>  		if (info->cpp[0] != 4)
>  			return false;
> +		/* We support multi-planar formats, but not when combined with
> +		 * additional DCC metadata planes. */
> +		if (info->num_planes > 1)
> +			return false;
>  	}
>
>  	return true;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
