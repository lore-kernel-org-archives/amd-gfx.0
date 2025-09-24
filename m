Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51970CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBEB10E791;
	Wed, 24 Sep 2025 17:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A38IC9wU";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D976510E791
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:05:47 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b55138c1974so2763a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758733547; x=1759338347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuuzfJiatIgV9Vuk5brwh4LmYbhvtsx6zQltjm8Ml8o=;
 b=A38IC9wUHKU7aaP7pgKBJPTrN3ClKaQtZN2zPmcxPO9ADPdsB1aPhKkR5JUrnedLyD
 0wggMlCa/M1Ng5945BxotcdWaXRmpA20RB7IRPkmWtIVcntJpKY5XAAe2vZollaM+sQp
 iHbbkLnmJ+2qcDFzkLL7jsTEWOkQY7gInYlt3plP3C9OGCis45iYkDXSv3YFCAZzFB5u
 MLW5b7h60y1ymhlGMAYosfI0TTZ3UlODUugBIRj61+FvCeolxFh5ergvzNUwVUKjchcU
 Una/TFBExHpsv3Tfhv88xix8J+XZkAM5deJT2OfYyzlVyTqowxmSt1FfAzUPrSnTZkBk
 ziIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733547; x=1759338347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuuzfJiatIgV9Vuk5brwh4LmYbhvtsx6zQltjm8Ml8o=;
 b=glDZLMxo6y97KBK7TVRZE6cUwkDYLmVJc9XKxm8CP0uY9pitXyUvmGZqeeD6UFcLCC
 Y/UYO29YKpOjmuyyq+m/itw+RIOWntXWUyF9zj/nG+OVB+WZWpMfV4yf6xX8UVSoN8YN
 dUza9EqOC/HrzcVAJmPms0kuGWnF6eaSOKB+0YZhXJlsP0GKXQ7X+lWBjpnhZMTbUQTL
 DdZqjMXgg4vb32d+lrtce3D87bSi5RhnGZrTmOXT7gX3tFvq8t8cVjxvKyybnz8H7h0d
 WOgJT6oLWJN+Wkmpdx5C/6d411wTSVJXKffGjaohjzUO9TZzghUuoWGyynPSiGvWwR56
 anuA==
X-Gm-Message-State: AOJu0Yx0lhYR+LMznBszAhYzlk68ibH7eluvcTdJe5fhij2MiFb/GVIg
 nPClkc7wlTbpQSMr1xKtWtB9wjLRcVKQlQ4mR1eD68kx3yVrRuUfMt5d/KbNjaUOEK+rEOxLl3c
 704eMMeCH6h/w7K6LL8XTf06nZNYE40A=
X-Gm-Gg: ASbGncuX2FPnSU0NzaF1n0q2GqsgGCoJSBzC5NYr2PimJ2Mul2+zKEwG+oi5+LLPYwZ
 KITfJRSEdJxP3n5TbcqG+6vMlQRJbLs7Ecd4z5nx7OnSKcZzKUjh6C+Mdm1F/RYjNhdrKpmFIjI
 OSekczPFNfYOzNp4i7uAnE6e61FJxqsv4X+OK7XL30iI8xv92h4vMZACEi5zmsIifGN/TZz7CVR
 +u7aeM=
X-Google-Smtp-Source: AGHT+IGQSegMdfNCPk0uDTRAB7lx4+pXWA26WYLYe3F2zBpn1g09a6ScxNNMw664cXkVx/BmaHsZnTYNQw6Q0JjUNmU=
X-Received: by 2002:a17:903:1a6f:b0:24b:142a:c540 with SMTP id
 d9443c01a7336-27ed49ae2f0mr2995355ad.1.1758733547140; Wed, 24 Sep 2025
 10:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <20250924161624.1975819-4-mario.limonciello@amd.com>
In-Reply-To: <20250924161624.1975819-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 13:05:35 -0400
X-Gm-Features: AS18NWAxLcyqskhIo0hTTOfVSHFdLSPj7-teE2zz-7l7ECl7-EAV1nImUiktgHM
Message-ID: <CADnq5_NbaKMLVs6J+5NMwi3Qq4TbQNga9iAnVdQ1Wb-F+jzpeQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amd: Use dynamic array size declaration for
 amdgpu_connector_add_common_modes()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Wed, Sep 24, 2025 at 12:54=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> Adding or removing a mode from common_modes[] can be fragile if a user
> forgot to update the for loop boundaries.
>
> [How]
> Use ARRAY_SIZE() to detect size of the array and use that instead.
>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 84a8af961531..ba24a0eba2a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -398,10 +398,11 @@ static void amdgpu_connector_add_common_modes(struc=
t drm_encoder *encoder,
>         struct drm_display_mode *mode =3D NULL;
>         struct drm_display_mode *native_mode =3D &amdgpu_encoder->native_=
mode;
>         int i;
> +       int n;
>         static const struct mode_size {
>                 int w;
>                 int h;
> -       } common_modes[17] =3D {
> +       } common_modes[] =3D {
>                 { 640,  480},
>                 { 720,  480},
>                 { 800,  600},
> @@ -421,7 +422,9 @@ static void amdgpu_connector_add_common_modes(struct =
drm_encoder *encoder,
>                 {1920, 1200}
>         };
>
> -       for (i =3D 0; i < 17; i++) {
> +       n =3D ARRAY_SIZE(common_modes);
> +
> +       for (i =3D 0; i < n; i++) {

Could drop n and just use ARRAY_SIZE() directly here.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 if (amdgpu_encoder->devices & (ATOM_DEVICE_TV_SUPPORT)) {
>                         if (common_modes[i].w > 1024 ||
>                             common_modes[i].h > 768)
> --
> 2.51.0
>
