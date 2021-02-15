Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB3D64D73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3D64D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCDB6E925;
	Mon, 15 Feb 2021 19:09:18 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649A46E925;
 Mon, 15 Feb 2021 19:09:18 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id u66so8758625oig.9;
 Mon, 15 Feb 2021 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GClquQcAvL3ODjC4fKRgV6AWuLnyOd0CieFT5ljIGg8=;
 b=taj7fGCvjY4kZfKOHznRrl1eWou+/GeW+2Pk5HdH+qvf8ZlNmgb//Tl7QA0+1OZbwD
 QLg+RZ/y4hNC1LaPD5ZB6hJzy9WNNg+d8yDDHR5CUjGz4UY1XjH3/acruXWhokGY76hC
 9ry09Fu7O7Hdd4lmrKiiiR/aciVULTwIE0HicKv3mK9sycJmrVb5JG4UVM0ZLPE78kFh
 nUybjGwt9T7fUh+RHHijuSEIdQcxQDlihqh3+IsHpbrND4oE4E9UyTpKCKUNJl1F34iP
 ue9PqvcZ0DfKtVEUVmzbj49eyYkwPYZjfx/KSuHdssQ/4DCLnIkOJQauGYSPEqigJTyc
 cLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GClquQcAvL3ODjC4fKRgV6AWuLnyOd0CieFT5ljIGg8=;
 b=GZ1c3O8P4EIPm2UAdHq0aPIfGZ0tU9uAvUMAM30VjZxRbjH6/5F0bEGsO4t9rZcG4f
 OhX1j3P6LDdJSskS0ZaznJmbpiLexzQqo6RA67tp6MCGVxTHi6P2kBLJilptkzm3Sckt
 S5QNhBs/iTNXFUMNytAvIw15PsVDz2+Ph8JxzJC4xkomhfHgqOoiyX3zkigt7JqP69sP
 uApfMIkwXUrI1BckJKUCtismNs4XCfO5uHYpkeCNPo+/jg2OdNQ70bqiu/OGfsAYwOsw
 gb2On0CFKovaNFwkXpxBt0/6pxhmNTxZ7IOuOJ7ctBzPk2XyQWP0vfdtlkyNYbp2mbq4
 2jmg==
X-Gm-Message-State: AOAM532WHwktTVNofQOSTfnInpvYw6r/CyAyICaX8sZokEm4dM1rJujv
 KW5q0Fs/jB9O7H7XESmfK4u0HV6x3lbFf/Kea6M=
X-Google-Smtp-Source: ABdhPJzgAEqiVGVhF8zQSY7YeQUWYWVibxqUAQIKX3OliJx9GWkVb7ps+03mCfHf22m+ZnMZ8l+TvD5ydzyuR8ucRJc=
X-Received: by 2002:aca:5404:: with SMTP id i4mr227737oib.123.1613416157760;
 Mon, 15 Feb 2021 11:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20210212222954.6510-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20210212222954.6510-1-mario.kleiner.de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Feb 2021 14:09:07 -0500
Message-ID: <CADnq5_OwuiAjDcP+xwspbN+H7+=aLdnGE51O0qiALnHhmjaZiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Allow spatial dither to 10 bpc on all !=
 DCE-11.0.
To: Mario Kleiner <mario.kleiner.de@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 12, 2021 at 5:30 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Spatial dithering to 10 bpc depth was disabled for all DCE's.
> Restrict this to DCE-11.0, but allow it on other DCE's.
>
> Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill
> effects, but a measureable precision improvement (via colorimeter)
> when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected
> HDR-10 monitor.
>
> Alex suggests this may have been a workaround for some DCE-11.0
> Carrizo and Stoney Asics, so lets try to restrict this to DCE 11.0.
>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> index 4600231da6cb..4ed886cdb8d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> @@ -216,9 +216,12 @@ static void set_spatial_dither(
>         REG_UPDATE(FMT_BIT_DEPTH_CONTROL,
>                 FMT_TEMPORAL_DITHER_EN, 0);
>
> -       /* no 10bpc on DCE11*/
> -       if (params->flags.SPATIAL_DITHER_ENABLED == 0 ||
> -               params->flags.SPATIAL_DITHER_DEPTH == 2)
> +       if (params->flags.SPATIAL_DITHER_ENABLED == 0)
> +               return;
> +
> +       /* No dithering to 10 bpc on DCE-11.0 */
> +       if (params->flags.SPATIAL_DITHER_DEPTH == 2 &&
> +               opp110->base.ctx->dce_version == DCE_VERSION_11_0)
>                 return;

I'm inclined to just remove this check altogether.  This is just the
dithering control.  I think the limitations are more around the
formats (e.g., FP formats) than the dithering.

Alex


>
>         /* only use FRAME_COUNTER_MAX if frameRandom == 1*/
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
