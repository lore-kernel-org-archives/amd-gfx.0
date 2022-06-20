Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8724AC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 22:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167DE10F84E;
	Mon, 20 Jun 2022 22:23:27 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A7710F850
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 22:23:25 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-317803b61e5so88299107b3.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mjBNWOOoKKzUZy9cusfMrMPROTy9mqwxralkbulZM3M=;
 b=ZxVX42LSBY4Bdr8DPkS588hAuDBJjM5IZkNuMoetd8NB3bWinLU3/4apAr7SMnGs1d
 NHCFrv46UixYnZ3rZi54y8SON4cGqeDY8BYrJ5yyZNyaTyje1OV9aikMSi0Eihp+CecY
 a+XUkF0eiQpCHoUgeOdNJOgx8H0FcmrD0Pmc6XmoYumYsDSg67kEbEgr5Y8qW2qFeQGU
 N2YUXqz4Rdkz9FOlymVwbgEclAeeuNgqOHF5U03EjuGjMGpIJZgPuLg8o4/wCnxFBaB2
 4jpDokCKKBH8kAau/e2O0NeYX0e1y0sSp3rl0IWtvrHgu1/x6FYhKAcibfPrIIFMo/zt
 MohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mjBNWOOoKKzUZy9cusfMrMPROTy9mqwxralkbulZM3M=;
 b=bSzzKjdX7+pA8VJA66limI/sg8jMyAZrrqetwFXkU9YddiM9DOt1T26jCnbRvDy03o
 PIZieWBib1+HHiL3LNyOuHPfNDz9NBLu9Pq1lPTaw8VLCSnybnBgSVtxY2E5w2jmVp+9
 NwrzPyUWHR48YKvFN7y2llcQZKRZWrOIxd9mmieNKcNGhRO4l4Ezg5sw4WlWbTA9GUy0
 AVgbZ7oQdLptojXmgMCx02xSt0hyQNU4fegTe7u5ROdep84waVqiC6/M2n+jICGU4vn3
 0UJiHWeRr8p3CMj5MSVPnDTdC3dJSsGQ0ghtYGso+Oiiu+epNybmJXEq8H6Z47ewKDXo
 v2Og==
X-Gm-Message-State: AJIora9RHs7rrPOYQeqPGLtffCFaN9xAgTcvqkbWcawEN3tclHqNgSGt
 DbPDBj9gF+ymysHjQ6xyJVxaY2883jY+jTIK2QkXuiJ7
X-Google-Smtp-Source: AGRyM1uJVeJRlWvlyDzKBynwCctWNHC4ykMs3CKzy8MjkqZ87fl5Va+hzJV/8uo9y+bEcltdUAL1KomOj2kbY+lMmY0=
X-Received: by 2002:a0d:ed83:0:b0:317:50bb:5463 with SMTP id
 w125-20020a0ded83000000b0031750bb5463mr30139310ywe.149.1655763804564; Mon, 20
 Jun 2022 15:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220616012127.793375-1-joshua@froggi.es>
In-Reply-To: <20220616012127.793375-1-joshua@froggi.es>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 18:23:13 -0400
Message-ID: <CADnq5_NdAmAJ93A8ADVYzvYN=-hdWACxJyeBAfgmxc6_-RUq-Q@mail.gmail.com>
Subject: Re: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
To: Joshua Ashton <joshua@froggi.es>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jun 15, 2022 at 9:21 PM Joshua Ashton <joshua@froggi.es> wrote:
>
> For DCN20 and above, the code that actually hooks up the provided
> input_color_space got lost at some point.
>
> Fixes COLOR_ENCODING and COLOR_RANGE doing nothing on DCN20+.
> Tested using Steam Remote Play Together + gamescope.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
>  3 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> index 970b65efeac1..eaa7032f0f1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> @@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
>                 break;
>         }
>
> +       /* Set default color space based on format if none is given. */
> +       color_space = input_color_space ? input_color_space : color_space;
> +
>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> index 8b6505b7dca8..f50ab961bc17 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
> @@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
>                 break;
>         }
>
> +       /* Set default color space based on format if none is given. */
> +       color_space = input_color_space ? input_color_space : color_space;
> +
>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> index 9cca59bf2ae0..3c77949b8110 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> @@ -294,6 +294,9 @@ void dpp3_cnv_setup (
>                 break;
>         }
>
> +       /* Set default color space based on format if none is given. */
> +       color_space = input_color_space ? input_color_space : color_space;
> +
>         if (is_2bit == 1 && alpha_2bit_lut != NULL) {
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
>                 REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
> --
> 2.36.1
>
