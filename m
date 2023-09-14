Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1BEEAA71
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 20:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8642F10E57E;
	Thu, 14 Sep 2023 20:52:57 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482EF10E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 20:52:56 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c504386370so797723fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724775; x=1695329575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/H+DMo2HUiVvHB4YDLhJMrCVy2xySAe+OvK4zkA2/5c=;
 b=FeJo09RjcrG33O6+alGH6dslhSy+gxN7gS1FDsYOLuco4Zdvp2c7kDyNHHe8VmsFs0
 D+I//QNTb1bEEBZM9AVTXnRfdB5WdFGk8ZcllbEHOmSTK70aKT6d/eleDuYO+qW5QSRT
 XoTJGYfc7NZxjlcLkOEVbGft8tevHdV78bTr9wvhYmJQ39UxcqUh6UmizHUMyf+dnz2X
 O41qo+a2p13ekFiQ5FBsvOiHc34qk6j0fH0IhuYX2S+V7HeAb5p0j4n8sgnqh/5frmnQ
 TWH36no173KvD4SahvWpFEU7xFTm3OwdfGWcfg0qwngkMaQHmPX3MXodjydklpBJWJhx
 2ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724775; x=1695329575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/H+DMo2HUiVvHB4YDLhJMrCVy2xySAe+OvK4zkA2/5c=;
 b=ao8ixJFX/DyuNvaC3Px8cWHnjv92Va1grTDD8DBIk1gWAYjejM2qd6kMsZm3z1Emf7
 Np0U2M1i/P8sfvcmumgTpN03zOrDPHSsnk6tzQrbxnApqVUU1+bBV72PMcaxTh6HtXtf
 MKHxfvBsaA3GG3mbJcTEDfIJ7o4BDdU28mYFliumby73ZCFIMEK4g+1hHBekJ3Rm7SbS
 Zis6sUffrVOkxpr7AtF44i4XdFDafl3jusLjc6U3GPHVVzmVg5YN2QoLdVzuBypIjfIX
 LPxhX4ePch3SrtbSLEzZY4Y7w+FRu5LoeO+tzUh81ISHiCuGMl3SjPVb1BwR5ffpmzOq
 heHQ==
X-Gm-Message-State: AOJu0Yy0JnKwoxhwH7peL9MuWU88FEjdNJ1zVHqSlt6P2NjO36ODQv9e
 TvvCXzJzkP9JTPAEK5LUPvcD+a5zMAwNyvYdkz5V738fjSU=
X-Google-Smtp-Source: AGHT+IHOcXCKVUilRe9nbKYN0yKCqPSQaDsGeIyPpqRjM3NrfgxJumzS+gPRyo16tCLKDC1o+CRzJuVb4D5P94EMeE4=
X-Received: by 2002:a05:6870:ea84:b0:1bb:bcc3:c96 with SMTP id
 s4-20020a056870ea8400b001bbbcc30c96mr7198451oap.33.1694724775344; Thu, 14 Sep
 2023 13:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230911143639.3110-1-michel@daenzer.net>
In-Reply-To: <20230911143639.3110-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Sep 2023 16:52:44 -0400
Message-ID: <CADnq5_P-r5mtirGWgb3HzOwj9AeLSn3rB30u969gLxBF3DVHGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Handle NULL dccg in dce110_disable_stream
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 11, 2023 at 10:36=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer=
.net> wrote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> It can be NULL e.g. with Raven.
>
> Fixes: 927e784c180c ("drm/amd/display: Add symclk enable/disable during s=
tream enable/disable")
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>

Looks like this was fixed in:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/7f7925e258288cfcfa2b0e0=
631fcd91a39744f94
but needs to be applied to 6.6.  I'll queue it up for 6.6.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index ad967b58d7be..a9dca69ee8f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1179,9 +1179,11 @@ void dce110_disable_stream(struct pipe_ctx *pipe_c=
tx)
>                 dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
>                 dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
>                 dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_h=
po_inst);
> -       } else if (pipe_ctx->stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PO=
RT_MST && dccg->funcs->disable_symclk_se)
> +       } else if (pipe_ctx->stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PO=
RT_MST &&
> +                  dccg && dccg->funcs->disable_symclk_se) {
>                 dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_e=
nc_inst,
> -                               link_enc->transmitter - TRANSMITTER_UNIPH=
Y_A);
> +                                              link_enc->transmitter - TR=
ANSMITTER_UNIPHY_A);
> +       }
>
>         if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
>                 /* TODO: This looks like a bug to me as we are disabling =
HPO IO when
> --
> 2.40.1
>
