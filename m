Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DFC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D38310F586;
	Tue, 31 May 2022 07:45:35 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898E310E1CC;
 Mon, 30 May 2022 13:05:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E7BCEB80D83;
 Mon, 30 May 2022 13:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C10DC385B8;
 Mon, 30 May 2022 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1653915911;
 bh=f51GI44mfzMyxMYx34Abcuu4ez37U0rG+03vNzNKYvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pTejx5gj3sCKMu4j6ranmCfSYcL+sRDF2Gfl/9lBFZdp7mTZ16NrkVqnI8yYFRpk+
 P4BQYmj4q2K+9ThaYT+UiK0XPGqzT2ikn37DZjBwxwyPrZi//y0Naw+TSn2/rI1BNA
 9GvtDSGxkCyjdT8UH2U9QNayUsiwlXR4jzTErWCQ=
Date: Mon, 30 May 2022 15:05:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Lin <tsung-hua.lin@amd.com>
Subject: Re: [PATCH] BACKPORT: drm/amdgpu/disply: set num_crtc earlier
Message-ID: <YpTBBPVxcdJ8sn8m@kroah.com>
References: <20220530092902.810336-1-tsung-hua.lin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530092902.810336-1-tsung-hua.lin@amd.com>
X-Mailman-Approved-At: Tue, 31 May 2022 07:45:33 +0000
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
Cc: David Airlie <airlied@linux.ie>, leon.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ikshwaku Chauhan <ikshwaku.chauhan@amd.corp-partner.google.com>,
 Sasha Levin <sashal@kernel.org>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, praful.swarnakar@amd.com,
 Leo Li <sunpeng.li@amd.com>, Sean Paul <seanpaul@chromium.org>,
 ching-shih.li@amd.com, Simon Ser <contact@emersion.fr>,
 Roman Li <Roman.Li@amd.com>, stable@vger.kernel.org, shirish.s@amd.com,
 Daniel Vetter <daniel@ffwll.ch>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 30, 2022 at 05:29:02PM +0800, Ryan Lin wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> To avoid a recently added warning:
>  Bogus possible_crtcs: [ENCODER:65:TMDS-65] possible_crtcs=0xf (full crtc mask=0x7)
>  WARNING: CPU: 3 PID: 439 at drivers/gpu/drm/drm_mode_config.c:617 drm_mode_config_validate+0x178/0x200 [drm]
> In this case the warning is harmless, but confusing to users.
> 
> Fixes: 0df108237433 ("drm: Validate encoder->possible_crtcs")
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209123
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org


Why did you not sign off on this?

And what is the git id of this in Linus's tree?

> Conflicts:
> 	drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> 	[Ryan Lin: Fixed the conflict, remove the non-main changed part
> 	of this patch]

No need for this here, right?

thanks,

greg k-h
