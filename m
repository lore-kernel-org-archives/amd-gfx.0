Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A33DC0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 14:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDF910E6EC;
	Thu, 13 Jul 2023 14:33:36 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BC210E6EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 14:33:34 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a412653352so680455b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689258814; x=1691850814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZ04sF4LHeFgirV0fg1swBzlnsJWFY5CNBLSjTkYrhQ=;
 b=amqKjLcVZkOftznfxPb2mfqsv7vk2JHbTlWyMRLQg0vl2WA/qZ3wKPo4GX4mEodhSE
 IDQNJ0uiuD9che/Ky+MGHFyUx8gfvfL9/H8SDxJugMc+tDFIQukyWJ5XvZCiVOsgEu33
 MUQa1gGOwm7WG6xkTxlsjllgp+8NHqXUEYMQBDI87Hg7juibEGTUehNIsSH2aljBW624
 Gex0WB1w+ZbQZq7Qj3UyphxhKH1zRDVfRPxv4ucpK5Hd917dAAgRRJsjzywcPIvI0+Q5
 HcuuceQYlHHfdJ4pJoK6Ge0Xc+dJnw6mlGQdybcav+tIAz8fqMwQhOO56ORxMG3x4U/j
 Qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689258814; x=1691850814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZ04sF4LHeFgirV0fg1swBzlnsJWFY5CNBLSjTkYrhQ=;
 b=lAOorWrTSVIsyMG0TbeU16psDfKExllpqz3nVJRd70rrXQpRJwdBEbSqnj33C+CWMO
 2dxNnRRWriVcCOb6JQS13HC8udI8UBnii/5RkKWcvYGxuvqdlNKrBm5/t+4wg6Llk+We
 K13uxJrP5uUpDLqX12hKUnWrR8lFI3BJCUxTp0Fl6z8Ykmntjh2Traq/kDh54bcKlgYt
 JPTmV0TgxqrNLioQXloUm/xAG62vGBxEo1DiG6R2v8PqCo62q+8eeie8OA7mMTE8iLTC
 MsKEn05qgDjJ8HnLIMmQRl+9j49fDcsUjhvIwtyPghw/uLsj7ge1qHOfvVxjQ4yr3HDe
 KKdg==
X-Gm-Message-State: ABy/qLaPNiEU2mQdsP6tIxcS98gi0ujEyzf3OhMA2ceqbJIv7Y039RMG
 JXyzkKutTlu7DHZ9/7Y+w+1mVfoSAN9kjrr7M6w=
X-Google-Smtp-Source: APBJJlFbVCZGgx7jA9UqEsRukAGfBKxt0yPPxQzoiKcHmvmyWTCDNum6EuHEc7DCro3Mi4PQ/Ir7X8srX3co/2jZ4Bo=
X-Received: by 2002:a05:6808:19a5:b0:3a1:d656:21c with SMTP id
 bj37-20020a05680819a500b003a1d656021cmr2242810oib.21.1689258813678; Thu, 13
 Jul 2023 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164148.2631132-1-alexander.deucher@amd.com>
 <20230613164148.2631132-2-alexander.deucher@amd.com>
In-Reply-To: <20230613164148.2631132-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jul 2023 10:33:22 -0400
Message-ID: <CADnq5_NP5AR0X5k1ZAC-P-dX5CoUyZS_uftXyVPdPbpLCUkcFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: make mclk consistent for smu 13.0.7
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Tue, Jun 13, 2023 at 12:42=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Use current uclk to be consistent with other dGPUs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index cda4e818aab7..8eb8c30e6c69 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -949,7 +949,7 @@ static int smu_v13_0_7_read_sensor(struct smu_context=
 *smu,
>                 break;
>         case AMDGPU_PP_SENSOR_GFX_MCLK:
>                 ret =3D smu_v13_0_7_get_smu_metrics_data(smu,
> -                                                      METRICS_AVERAGE_UC=
LK,
> +                                                      METRICS_CURR_UCLK,
>                                                        (uint32_t *)data);
>                 *(uint32_t *)data *=3D 100;
>                 *size =3D 4;
> --
> 2.40.1
>
