Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 13:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DE710E600;
	Thu, 17 Nov 2022 13:50:49 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8452610E600
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 13:50:47 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 ja4-20020a05600c556400b003cf6e77f89cso4703962wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HprMsMjyGfwxTXLPdfD0JV8T8pnKhgKKKVZzbvpgM4=;
 b=uq+g0mAsHWmh98cKS3D0tc9XkWwHZlYF9R4Pz+TASRtyQx/ijmUP+DksTYY/BknSMN
 Q4nGteFYpuvx7Z8eBHacDVGM7w9Y4weKX1ocPbmbFad45bo8FZetC4XISDa9i4qFWGRp
 IRmgkFy2N2r4DXB0VPbidtKmafHp1HDZ5CUrsgxGaltg0oCwNEdbrHvFFZmhY0vrZtHo
 grLQrGMEmjUsJJFRg3wUa5yEV59xr15uXiUUvfy4v8R2WKbRm3yTOOYfW+yQscyG6b4/
 aFIcvou2EwLydkI6F/VnToCRjC1XR893RnW1DsqxD/O//KqANuibcoAoyFksoe6LEWaN
 Sphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HprMsMjyGfwxTXLPdfD0JV8T8pnKhgKKKVZzbvpgM4=;
 b=N3czpeOPpW9OD7QzWrJr21bfxERwv5EDJvAEt8drSidfIJBHX++Y3m5VEmqh1T46YY
 F+QDtzQU93q2WzpFKsxigzB6L+APLl50Dz67Th8c6UjgOVLmg0aRnzADzvaJbKnvRpGV
 70ujARKDjjNdNlgeK3jnqtkH+P8nDiMn9lopbcAvNCX87bljoLeSUrbjcvwZQv3sSo2p
 wzTfm6eYXfZsd9/DclrP1FH+NRxlbhYAoQAM6lmNtZ8ViRKjHol2GCFwNWkPpB93lkBF
 yVWM3uJVwaPq2gftdNeBHiD7x0D18z+Ejg+IsQTU46gVyD5QSRJfs3KEOBD98it18UXA
 Euiw==
X-Gm-Message-State: ANoB5pnLWqB+xVGULMLqiBnSFUxioux69Op4+MPcFQwS5oZy2oG6sSAD
 gdU2oBc/O+YhG1nFYe78NQO3hgguCBLaX4Z9sAvnDA==
X-Google-Smtp-Source: AA0mqf6P87BoMm0VPSBjQMTY90giYVoxTOOtc02hJ7dXyIxbCXOtqi4SbKWYKRFCGyjpWtNGCqylQmSzhshrE3bXvXc=
X-Received: by 2002:a1c:e917:0:b0:3cf:681a:43e1 with SMTP id
 q23-20020a1ce917000000b003cf681a43e1mr1671164wmc.126.1668693045906; Thu, 17
 Nov 2022 05:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
 <20221109061319.2870943-5-chiahsuan.chung@amd.com>
In-Reply-To: <20221109061319.2870943-5-chiahsuan.chung@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 17 Nov 2022 13:50:34 +0000
Message-ID: <CAHbf0-GWvsCiX8NtVvOPZuy+RUCwkcQgJy7pOs0v7Vi-C_QqjQ@mail.gmail.com>
Subject: Re: [PATCH 04/29] drm/amd/display: fix dpms_off issue when disabling
 bios mode
To: Tom Chung <chiahsuan.chung@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 Zhongwei Zhang <Zhongwei.Zhang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 9 Nov 2022 at 06:15, Tom Chung <chiahsuan.chung@amd.com> wrote:
>
> From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
>
> [Why]
> disable_vbios_mode_if_required() will set dpms_off to false
> during boot when pixel clk dismatches with driver requires.
> This will cause extra backlight on and off if OS call 2
> times setmode.
>
> [How]
> Set dpms_off to true to keep power_off and
> let OS control BL by display's powerState.
>
> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 9c3704c4d7e4..9f42adc234e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1192,7 +1192,7 @@ static void disable_vbios_mode_if_required(
>
>                                         if (pix_clk_100hz != requested_pix_clk_100hz) {
>                                                 core_link_disable_stream(pipe);
> -                                               pipe->stream->dpms_off = false;
> +                                               pipe->stream->dpms_off = true;
>                                         }
>                                 }
>                         }
> --
> 2.25.1
>

Hi, this patch gives me a blank screen when booting my Asus G513QY /
6800M. apart from the screen being of I can ssh in just fine

Reverting it puts things back to normal

Cheers

Mike
