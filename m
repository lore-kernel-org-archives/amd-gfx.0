Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7386C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF14910ECDE;
	Wed, 26 Aug 2026 12:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="he+L3ERj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326D710EC99
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 10:21:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B610744061;
 Wed, 26 Aug 2026 10:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E101F000E9;
 Wed, 26 Aug 2026 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787739689;
 bh=V4ZoqREWKBTRVg5Xn9QozpDz1SHMaORIEQ1sJJ24y7A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=he+L3ERjvLJF+HhBWPGlFU631R+nhAUjQrBb4XbYA7uSGfYyCb0C46Z9EDpfBwNVN
 vs7GHzPDRIpU3HeU+l3PXa3L7P6RcmSw/5AZYYRqbt9nGHr+25xRSg3DDjLwdxqSgf
 FGS2pLhzlJXzzR44xoUfxT9ode8TL62gzzvvqXaE=
Date: Wed, 26 Aug 2026 11:22:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: spasswolf@web.de, alexander.deucher@amd.com,
 regressions@lists.linux.dev, leandro.ribeiro@collabora.com,
 mwen@igalia.com, alex.hung@amd.com, mario.limonciello@amd.com,
 jesse.zhang@amd.com, Amber.Lin@amd.com,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: warnings from validate_blend_mode_for_alpha_formats() in
 next-20260715
Message-ID: <2026082651-spinning-cornbread-33ba@gregkh>
References: <20260716152933.6744-1-spasswolf@web.de>
 <20260825212815.48959-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825212815.48959-1-mikhail.v.gavrilov@gmail.com>
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
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

On Wed, Aug 26, 2026 at 02:28:15AM +0500, Mikhail Gavrilov wrote:
> Hi,
> 
> this is not a linux-next-only issue any more: 860e748bddcc came in with the
> drm-next pull of the 7.3 merge window, so it now warns on plain mainline. Here
> it fires 16 times on every boot - 8 per GPU, on the 4 primary and 4 cursor
> planes of each of the two cards in this machine:
> 
>   [PLANE:44:plane-0] pixel format with alpha exposed but blend mode not setup
>   WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0xa16/0x13b0
> 
> I ran into it on 7.2.0-2709dd5ae32f, bisected it to 860e748bddcc and confirmed
> by reverting that commit, before I found this thread. Hardware:
> 0000:03:00.0 Navi 31 (DCN 3.2) and 0000:0f:00.0 Raphael iGPU (DCN 3.1.5).
> 
> Nobody has put this on regzbot yet, so:
> 
> #regzbot introduced: 860e748bddcc
> #regzbot title: drm: WARNING at drm_mode_config_validate() for planes exposing alpha without a blend mode property
> #regzbot monitor: https://lore.kernel.org/all/20260813143605.106104-1-mwen@igalia.com/
> 
> Status as far as I can see it: Melissa Wen's v3 series (monitored above) fixes
> amdgpu for both DCN and DCE, has Reviewed-by from Alex Hung and Tested-by from
> Daniel Wheeler, and I tested it here too - the warnings are gone on both GPUs.
> It is in neither linux-next nor amd-staging-drm-next so far. 271e90eb5f9f
> ("drm: use drm_warn() in validate_blend_mode_for_alpha_formats()") turns the
> splat into a plain warning and went to drm-next on 2026-08-20 as part of
> drm-misc-next-fixes-2026-08-20, but has not reached mainline either. Other
> drivers are being fixed in separate threads (imx dcss, rockchip, vkms).
> 
> Since this was introduced during the 7.3 merge window, the fixes should land
> in 7.3 rather than wait for the next one.

I can confirm this regression.  It's hitting me here too on Linus's
latest tree.  It's not good to boot and have a bunch of warnings already
happening, resulting in a "tainted" kernel before I have the chance to
break anything manually myself...

thanks,

greg k-h
