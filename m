Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBD6C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 04:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBA010F16E;
	Fri, 12 Apr 2024 04:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtqCf2Nt";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EF810F1B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 04:16:48 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-6ed11782727so480749b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712895408; x=1713500208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWVBrhR96MU7O68Lc7evtdfYeQAHDjbF8YjpibJUwks=;
 b=KtqCf2NtU0VMpWtWmcRbs7/lQYssnYUkbqqigRXN0rlVO9bf8r0qtijf6KfrHdNuLH
 g2wY0ApPINElYGMo3uPIfS8tnOKqbgukqohR7zSlP4/w+6kV5hmMmLM8AEvgpH1KYHcv
 1TIzvL7tBd/0e9TLJudSbIiT95oLLnj9YjW7fCO/2JY49Z5u2dqrZbQT7BLqy0x6+Kmv
 F2rktP3vBAiu7LAw+JEZu8+guwnz3QSC74zBVEd9Qx4dHcssZvlE4lKrE4YszGQAGg2m
 8gJ3OXqEmZGIZXaU2TleHxOuMajsLxXrzk1KHGRrAF61FIlSqygFsg05m76XpU6Z1X4l
 VdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712895408; x=1713500208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWVBrhR96MU7O68Lc7evtdfYeQAHDjbF8YjpibJUwks=;
 b=lCrKcgPso490GXSzYIeav0UgAPf0nPizRmcYCJkN+YTvZBSq0BU3FkLrJb8CsPFBhE
 izI965QehtGvYs1s5TtHxvM3o8EtKDv4JAyztepz/F8L2t/0Rtbvle3xZnHyys/5J1qz
 e3kv8tDgGM9+X/L1Pqy0odWE0thF2Fgp4aODsGgrV4PaKd8Z6j3Vyf4QY4fGeQWYEHr4
 DvCQ9j9rcJooUzAoERiBYtrI7GjCaeailIjjC8suEhBNriV34BOaAX1212XYMqnc+ffb
 TQ7JkMMFRp1Liu7JALx+MXG/k8xavQFdcwdMGIOpN65FXXmaavzezMl0jnApq25otF/N
 TGwQ==
X-Gm-Message-State: AOJu0YwxsMOW/wenBlZRIQunqu3Sm1enFz5sl+jGrKJ0pc2O95WIAFZs
 oepfE7e0/jj2f30VsYbU2gMUndjQItRpB9+lRKel4wItlh3kz3PCD+aQd9uzQwtb9iU8AmoV3SZ
 lpbE6gSw/laPcNQwvB/4ii7B3/DrhnA==
X-Google-Smtp-Source: AGHT+IEW685NP7c++Pd5T5z4sPXa6PprsdKCxNummF6E4Rd2QrykhpYO39w+LXuUmwTZweOhj3chhVE5VR0NCIcG0G8=
X-Received: by 2002:a05:6a20:dd96:b0:1a5:6f21:f8a8 with SMTP id
 kw22-20020a056a20dd9600b001a56f21f8a8mr1763333pzb.15.1712895408200; Thu, 11
 Apr 2024 21:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240329225852.9648-1-alexander.deucher@amd.com>
In-Reply-To: <20240329225852.9648-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 00:16:36 -0400
Message-ID: <CADnq5_O3y-zbBA__JHT6pJKd5L8CcF6KB0-GRJjGF=JG8ANMsA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: fix USB-C flag update after
 enc10 feature init"
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Muhammad Ahmed <ahmed.ahmed@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, Charlene Liu <charlene.liu@amd.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Harry Wentland <harry.wentland@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping?

On Fri, Mar 29, 2024 at 6:59=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This reverts commit b5abd7f983e14054593dc91d6df2aa5f8cc67652.
>
> This change breaks DSC on 4k monitors at 144Hz over USB-C.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3254
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Charlene Liu <charlene.liu@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 8 +++-----
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 4 ++--
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.=
c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
> index e224a028d68ac..8a0460e863097 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
> @@ -248,14 +248,12 @@ void dcn32_link_encoder_construct(
>         enc10->base.hpd_source =3D init_data->hpd_source;
>         enc10->base.connector =3D init_data->connector;
>
> -       enc10->base.preferred_engine =3D ENGINE_ID_UNKNOWN;
> -
> -       enc10->base.features =3D *enc_features;
>         if (enc10->base.connector.id =3D=3D CONNECTOR_ID_USBC)
>                 enc10->base.features.flags.bits.DP_IS_USB_C =3D 1;
>
> -       if (enc10->base.connector.id =3D=3D CONNECTOR_ID_USBC)
> -               enc10->base.features.flags.bits.DP_IS_USB_C =3D 1;
> +       enc10->base.preferred_engine =3D ENGINE_ID_UNKNOWN;
> +
> +       enc10->base.features =3D *enc_features;
>
>         enc10->base.transmitter =3D init_data->transmitter;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.=
c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
> index 6e6ae3de08e4c..6864b6d174370 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
> @@ -184,6 +184,8 @@ void dcn35_link_encoder_construct(
>         enc10->base.hpd_source =3D init_data->hpd_source;
>         enc10->base.connector =3D init_data->connector;
>
> +       if (enc10->base.connector.id =3D=3D CONNECTOR_ID_USBC)
> +               enc10->base.features.flags.bits.DP_IS_USB_C =3D 1;
>
>         enc10->base.preferred_engine =3D ENGINE_ID_UNKNOWN;
>
> @@ -238,8 +240,6 @@ void dcn35_link_encoder_construct(
>         }
>
>         enc10->base.features.flags.bits.HDMI_6GB_EN =3D 1;
> -       if (enc10->base.connector.id =3D=3D CONNECTOR_ID_USBC)
> -               enc10->base.features.flags.bits.DP_IS_USB_C =3D 1;
>
>         if (bp_funcs->get_connector_speed_cap_info)
>                 result =3D bp_funcs->get_connector_speed_cap_info(enc10->=
base.ctx->dc_bios,
> --
> 2.44.0
>
