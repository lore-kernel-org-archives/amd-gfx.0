Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031DEC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B2861DC2
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B2861DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6F889E19;
	Tue, 29 Jun 2021 14:31:58 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD10989E19
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 14:31:57 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 a5-20020a05683012c5b029046700014863so6041603otq.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W5Oe2lefGOs1uyIojHIl36QwmAY0wzVXlIPsn6I2bqs=;
 b=o42+ehzD9GHmRXSVHVhzM0nBY1vUNhDBUhI8YuDORn1xUwe8yFH1W7rmTD+zEThUnM
 X6Vd8JWjEZA7Ay8MtHJpuQFXSe5ODhE2Yx9peZLuCeAM3bP/G7XfoXBrhGzX9dgsBl3D
 nGHP5xaeDrKH54JGCnjD+BRYHhR0EXCtOKQSWhKAF80xk2G9UGaS3MNrOyOQ6IjsR7Pb
 jn1Xyp8tjd1ApuEtV3eBqbUcRWriEfEtU102DF8L1g2CK5D6VJ9s78d0oGKudpC/SMZR
 B2JdhkFC6l2YqgMHT3wIcSNjo1BJnBW9wss+P+lpCWhpd3L1kRiufauthyZ5/Ak/qbpw
 mS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5Oe2lefGOs1uyIojHIl36QwmAY0wzVXlIPsn6I2bqs=;
 b=PSU/KuIKFvb3bsHDvZbG1ytPUV342kMKSVgGk/qb/Q8Om5cWtH3/RpAZybTQqWprIt
 0lAYlcHYsWiCmV4H8325oZjWKb6nh0Og72F/F931OWYpqc+CubKoLXD///Dx9tID4Mha
 tVObCRDVYDVLKIDI/0YDNyEtC1f42f71UoKNBx1VZZS5ngIxrQ+atOuvESeamvnS4KyL
 ckRQkQ2kau6BtisXtbm1X3rVkl5VGrTKm/0KqizU4MgL21s4rfEIbw4UwYRkxo/mLeHr
 oLK+2Hh6CRL2lc9G9r81g+EoR1JwBeconwQQ/LFxJxpu9HFm6jrJb9u37I+6DE7WbvGF
 lfkA==
X-Gm-Message-State: AOAM5324JomHTroLjy3YY1QEZuqvo21kF21ks30bwqDfbg7LBLXnSFAq
 Yf3w6L27YrrUKyMIfoyLQGdH97bP47TDXLoMu5Y=
X-Google-Smtp-Source: ABdhPJzjxPfzUlCvPrSLCW9Il9JwYuwVPRG2WCx6bM51JGh/iTbqD3klv8S+Gj1Mjk/AAEKZPwxzGQDHZDbylUj7Ryo=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr4650292otr.23.1624977117086; 
 Tue, 29 Jun 2021 07:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210624195403.1050871-1-markyacoub@chromium.org>
In-Reply-To: <20210624195403.1050871-1-markyacoub@chromium.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jun 2021 10:31:46 -0400
Message-ID: <CADnq5_O6zSwgn=xkYbTZOx=2WXuzL8iNSBgT76WXrZjJB6LVMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove assignments in if clauses.
To: Mark Yacoub <markyacoub@chromium.org>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Sean Paul <seanpaul@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Jun 25, 2021 at 3:28 AM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> Fixes Commit a46b6bd5 (drm/amd/display: Verify Gamma & Degamma LUT sizes
> in amdgpu_dm_atomic_check)
>
> Tested on Zork: IGT:kms_color
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 3 ++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 91e13ae388b7f..c0cc4ca5fdf60 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7792,7 +7792,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>                     old_crtc_state->vrr_enabled == new_crtc_state->vrr_enabled)
>                         continue;
>
> -               if ((ret = amdgpu_dm_verify_lut_sizes(new_crtc_state)))
> +               ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
> +               if (ret)
>                         goto fail;
>
>                 if (!new_crtc_state->enable)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 9543b10e7e0bf..6acc460a3e982 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -342,7 +342,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
>         bool is_legacy;
>         int r;
>
> -       if ((r = amdgpu_dm_verify_lut_sizes(&crtc->base)))
> +       r = amdgpu_dm_verify_lut_sizes(&crtc->base);
> +       if (r)
>                 return r;
>
>         degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
> --
> 2.32.0.93.g670b81a890-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
