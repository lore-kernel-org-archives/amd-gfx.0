Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74829C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 21:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74C2075A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 21:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSMROAgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB5F6E101;
	Wed, 27 May 2020 21:05:08 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B016E101
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 21:05:08 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id v19so1017482wmj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qiePC7R1hRKUBXk7uMROHKiOujWNUXvdc6UCwgYEkTI=;
 b=vSMROAgNjk9TeJd/T1pvSOr6CODum3VHhmzJv2lfQSCKl/PoiaHB7/RdY5HTuqLQbp
 FSYxf2bhYIw8ze4BQ7xVZoOOhgjhnC3bYTe0xXOL3GHJ1t+MoFCdhISp8DzY8IUtKDVM
 qP5HEBmoIqxJufOGhG+z1/rXtrqlZsQbktlyp2rNWruXdBuHdjNNKO3g8MnZxClnay70
 vm/8IrJAiBoaDqSXSSYOSKvDW9NIylHLl3NfGAVXzZ6UaDJB9bYQg66AE6BoaMX/xxBV
 /b2OmnNV1HzwGReqVyuHbkR2czZFEfo7xznPwHaHoQzhL6wpwPeS5e24RWTEDi14iLMp
 4JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qiePC7R1hRKUBXk7uMROHKiOujWNUXvdc6UCwgYEkTI=;
 b=JGDLQqts5c1Oa2Cf5iE7oj+OVK8ZgBKyii9FYNKBMvY1tXqHtDxwQED2mlmzq9O+69
 xJ0L4Pp+QVCe951JuyTUD6lP16A4mDMJQkavniFlgaO6owSBIdP9b+Ds/1Yv3C7giDM1
 q7M2RyDuodv2BLHOa+EzXYWmmhXDOFv99T1vDU97oAnGKeqfuTg6MIPTarPIUhhJ0nOr
 3jnVYddUZpgUgDn8dRimzShnHIsvLI3uEh8pDeMOAUkYknUg2DNo3WyLPNHk5wbm/WTU
 oU7C9P76GB84B77lRapbIROT9p1PGuLA5zCG+eixFp/ZCPXOOdTM9Y2kbkBN2l75H48S
 gOpg==
X-Gm-Message-State: AOAM5308BH0vsSuKF0VcE3IAizdEdpY1Pf9GtvbuK10w5FhWNAIDUHgz
 gOubkJ9wRS0ofANTRVlDoEUTJBvIY1SiV6jPatjPCA==
X-Google-Smtp-Source: ABdhPJxg6gsalDzTYrXKqr9EQC5WOZ681NiuAK5hs1QGTRgDemCOC1y7/oqoupClkTFYv2TqXPcOAe7Ojlh6IKp5SB4=
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr46654wml.70.1590613507031; 
 Wed, 27 May 2020 14:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <HB1_5z8Vnk8KvqVJezbdCJ0uUkI29R_Q7ksMByqCNQ3DG9HWd_iJP6b0WL1jIIJLBPdN25D8iC4BN-Jbf8NbKSL_Ep6IKVn3DaHpe_h5Ljg=@emersion.fr>
In-Reply-To: <HB1_5z8Vnk8KvqVJezbdCJ0uUkI29R_Q7ksMByqCNQ3DG9HWd_iJP6b0WL1jIIJLBPdN25D8iC4BN-Jbf8NbKSL_Ep6IKVn3DaHpe_h5Ljg=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2020 17:04:55 -0400
Message-ID: <CADnq5_PP_5vzhZ1XOeci=HtDq_N7vZpzKyEU6UsswZaGTBPaYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: drop cursor position check in atomic test
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, May 23, 2020 at 7:53 AM Simon Ser <contact@emersion.fr> wrote:
>
> get_cursor_position already handles the case where the cursor has
> negative off-screen coordinates by not setting
> dc_cursor_position.enabled.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Fixes: 626bf90fe03f ("drm/amd/display: add basic atomic check for cursor plane")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 28e651b173ab..7fc15b82fe48 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7880,13 +7880,6 @@ static int dm_update_plane_state(struct dc *dc,
>                         return -EINVAL;
>                 }
>
> -               if (new_plane_state->crtc_x <= -new_acrtc->max_cursor_width ||
> -                       new_plane_state->crtc_y <= -new_acrtc->max_cursor_height) {
> -                       DRM_DEBUG_ATOMIC("Bad cursor position %d, %d\n",
> -                                                        new_plane_state->crtc_x, new_plane_state->crtc_y);
> -                       return -EINVAL;
> -               }
> -
>                 return 0;
>         }
>
> --
> 2.26.2
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
