Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA62AC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E7510E5AD;
	Mon,  4 Aug 2025 15:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuC0pK+B";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B4710E5AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:59:31 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-31ef3e9f0adso370693a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323171; x=1754927971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kura2iSqy2PkGGubyC6SqOK1wYtr24GkyMyHy0flQNk=;
 b=OuC0pK+BtmfR1cnUzuKm4vq9ght1hNZyv3XRJ+vFAAkVFjA5rodx39goyWNcVp0rxZ
 qCW9cG9HxxFFp6N0i83ZyaiYgMV8p29nb/7qfhQ6ivSWtroPV0rsXtY+DYiOEwlXdCHy
 hKV0iTF1d+QnMrlbzOTbgmPd6t56wwxDLnoglHPUgIvy6rit4qEw5P2g/Ix+D6ck12hW
 3Xbs086h3gEp/CUtOl+edZcQIkmzOIEVHwSm1EmwfTWRWkjfKow/f35sOUbKDcBzljnF
 +ez3eiT4u3s5E9VpLMXsmUr/952bFg0P6OvjJxnHTOKV6mDzO0te91Xh5iahqHhetaLe
 2SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323171; x=1754927971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kura2iSqy2PkGGubyC6SqOK1wYtr24GkyMyHy0flQNk=;
 b=ZUpUoGR1Qf19+9cPtVNKg6ya3J5tkFSiLFL1YioK7l3w6HzzVI6o/yiBfgUSwi7LuC
 4x7THt1ZjOoF8bJmMKZTUGNlIes7n6AG9jo0/BqIpZVZdjFHwLELwqMGiW6Uy8H/5PRS
 /b/lVgDqtNNNCqFWL+VE1KZ5kEpLlAuRizFutC5nG/2iftSk3nxrOhBy+DePUFCJd0le
 4xP6L4wVeOY78Dz4E64zae4rnvyrvxhjnVmYN7ZWH7/g0AjVUShj5c0i9gTCwb6mvqsr
 VkX3Zrhs7B6EuQ6MmULddpZXFVM6tgNGwEEeumiGXR0RpW+8tae4o7SurNaQjQ/nna9c
 ebzw==
X-Gm-Message-State: AOJu0YzqJxvKDooM2hi0UtXKcYdHaQgR3XQ3ov5NcGAYRf2SfRiMzQcw
 X9P48CFDLY2ca4x+/lys7D0HH+lsF/7L8KnClMkmen1xVzidWq923otDQEgKGHnyGLtP9W21a91
 17N9FCA1GuFwhOll24xmN2N7zUM1XlBw=
X-Gm-Gg: ASbGncsgTHI46iOWE/e0vx8M8ltVGWjOVVa8ptAOfYg1za8QTSGxMlCreDoVwA97TYz
 ovkKSrrxyHaCzH4PnjzXbGVPvNbqLK7zl8VtiIQ3Ek0MwvHnLIocBCDE1ds3rWoGlvVrd5DFx4a
 qQYCCaus0XtOPVNhgs/ChYzKioWfefQgEunoTA9MoQoxgaoYcuv3GCVEgvBGNX8KZygHy6mXM4v
 F1uFqaj
X-Google-Smtp-Source: AGHT+IFKyd8XVFOludrae/Ce5MxhR0UBNLl4/OwIpWpH3s2Zx95D/KyaOPDApz0CmlGvw/FUBgwCkpI7v+ofObfoUac=
X-Received: by 2002:a17:90b:3e87:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-321162e37bcmr5467226a91.7.1754323171152; Mon, 04 Aug 2025
 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-6-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-6-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:59:19 -0400
X-Gm-Features: Ac12FXzFZnHoaN3KesWBVtBLo-KeiygOkYIFYDWAm6A6pls2QyJXfl4fYqqjOyw
Message-ID: <CADnq5_PYQXTCpjOob2ef3N8kR3Kpzvt-ByYCAf6H3HU55ODMiA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Don't warn when missing DCE encoder
 caps
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jul 31, 2025 at 5:53=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On some GPUs the VBIOS just doesn't have encoder caps,
> or maybe not for every encoder.
>
> This isn't really a problem and it's handled well,
> so let's not litter the logs with it.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 4a9d07c31bc5..0c50fe266c8a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -896,13 +896,13 @@ void dce110_link_encoder_construct(
>                                                 enc110->base.id, &bp_cap_=
info);
>
>         /* Override features with DCE-specific values */
> -       if (BP_RESULT_OK =3D=3D result) {
> +       if (result =3D=3D BP_RESULT_OK) {
>                 enc110->base.features.flags.bits.IS_HBR2_CAPABLE =3D
>                                 bp_cap_info.DP_HBR2_EN;
>                 enc110->base.features.flags.bits.IS_HBR3_CAPABLE =3D
>                                 bp_cap_info.DP_HBR3_EN;
>                 enc110->base.features.flags.bits.HDMI_6GB_EN =3D bp_cap_i=
nfo.HDMI_6GB_EN;
> -       } else {
> +       } else if (result !=3D BP_RESULT_NORECORD) {
>                 DC_LOG_WARNING("%s: Failed to get encoder_cap_info from V=
BIOS with error code %d!\n",
>                                 __func__,
>                                 result);
> @@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
>                                                 enc110->base.id, &bp_cap_=
info);
>
>         /* Override features with DCE-specific values */
> -       if (BP_RESULT_OK =3D=3D result) {
> +       if (result =3D=3D BP_RESULT_OK) {
>                 enc110->base.features.flags.bits.IS_HBR2_CAPABLE =3D
>                                 bp_cap_info.DP_HBR2_EN;
>                 enc110->base.features.flags.bits.IS_HBR3_CAPABLE =3D
>                                 bp_cap_info.DP_HBR3_EN;
>                 enc110->base.features.flags.bits.HDMI_6GB_EN =3D bp_cap_i=
nfo.HDMI_6GB_EN;
> -       } else {
> +       } else if (result !=3D BP_RESULT_NORECORD) {
>                 DC_LOG_WARNING("%s: Failed to get encoder_cap_info from V=
BIOS with error code %d!\n",
>                                 __func__,
>                                 result);
> --
> 2.50.1
>
