Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D68C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 16:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9384410EA42;
	Thu, 28 Aug 2025 16:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UlvSpdOg";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F1210EA42
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 16:06:17 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b4741e1cde5so201538a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756397177; x=1757001977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAHSUiuKAk3XhfWS2yylFKu534+cGnZqY5gYI3F0ivA=;
 b=UlvSpdOgcrEORMnPxpsiAbtBpXZ80rhRoHnR9J5WbepaIswDYll5wf+tnrUISkw4HQ
 s16cjCn2tVDUhzFOD3xoMxgkc+nG7aDQjMATGRuA0TLZxWTnhTPSlFS0ZmSHCsxdACUJ
 1VufUTHjfu4yaa5L81pXpZWCCEN6TdOrRsaKBqkxluarSdR8vIFtAn8atAriO42rY2Qx
 48ecR7UtqzE7lYPpkE5dH8ZGErxZqBtB8TDarrI1SHW5331dKYVO6cxvMCdGHWJdm71i
 eiXkTU4NGsqh1Kkq8goIsAOZHMsto9GmhR5xgnYOwx4arydyqPjEeqrkol2azZmdbmEN
 pgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756397177; x=1757001977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAHSUiuKAk3XhfWS2yylFKu534+cGnZqY5gYI3F0ivA=;
 b=RqMlY5Lg2/CZtzM9+hqu1zD0OvcLXqPDHfgzKcg8r964jOH/EOl62AVb5JhahIwjs1
 35jnj5H+dXZoJ6S/emxAq6EWE95v31gIyIC9qE5S9AcPNDgo7TvEndvDob3yVJCcWrYx
 AJuSHIthiI/pFXE8TTL2PL4yDdqreQK1Q2RAjqdf31N47RWm1WJmiO2s8H++1dvvG+/l
 NEHs/86Q+16kLlvdmsQVvUiY9MELH9b3LGrrpoT51hMSBN3+Zf36aRtQm3uSsnGDVnQV
 52yaFMS7yFsQI/6ZCTewLndJ67crj3aN6+07Hx7/Ff07RnqHWC5frkgH/rCQzFtNSt4h
 tOJg==
X-Gm-Message-State: AOJu0YyctIdlk4idPWQl7G3OAtyNcN1voPmt0jlyUZOTePIT/KKiZGZ+
 QUxnNnD3Cc5TRhUJ27x8+PZ/N9xPjfZ7eNlEe2C5P7XdeLa9Q+vQxntJOcDgFZSGVmKUaBJYpbj
 T24G8yAIMpOXiYRyv6rA75dX3rHTyBwY=
X-Gm-Gg: ASbGncvIe1yqX53OvYoe4LvGRg9cNhk/stdH9Vm+xQQ/+Qou5Crf85DaCWTAdNwrIb5
 XhmvNx0R8KSNvLROo0fl91o2xRPnZatNX31An6O/mOktZvc3DQmJw9XNusXMysAvJ11vqNlMN1B
 iVjs6Qbjm9J1Ixx6boWAYdC0oOKcUIWXso1jUQht23eNrl+g3k/ZuS5TjQoUdOkSAKAe2XO7WYS
 v1NjBy+RXPu7zXiBg==
X-Google-Smtp-Source: AGHT+IFfPJX6fXvH680OlWEg0D1lZGOKkVzx55HQZBMgHeOUdPnkhBIfKZc8+o6JkTKLktqx+xBqnfZAvRjfTgvBCHE=
X-Received: by 2002:a17:902:c409:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-248a01fa7aamr44386095ad.11.1756397176846; Thu, 28 Aug 2025
 09:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250828145036.6853-1-timur.kristof@gmail.com>
In-Reply-To: <20250828145036.6853-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 12:06:05 -0400
X-Gm-Features: Ac12FXypqNDIyffqTRSzxjw1ERUXy4QyFGBfStskaS3sRS4FvArfMJyaCdi7QcY
Message-ID: <CADnq5_OH7NoYOKubsXHxgLNJwvPn0h=zAgWNaAaBx5FPsHc-0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Respect max pixel clock for HDMI and DVI-D
 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

On Thu, Aug 28, 2025 at 10:50=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> Update the legacy (non-DC) display code to respect the maximum
> pixel clock for HDMI and DVI-D. Reject modes that would require
> a higher pixel clock than can be supported.
>
> Also update the maximum supported HDMI clock value depending on
> the ASIC type.
>
> For reference, see the DC code:
> check max_hdmi_pixel_clock in dce*_resource.c
>
> v2:
> Fix maximum clocks for DVI-D and DVI/HDMI adapters.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
And applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 57 ++++++++++++++-----
>  1 file changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 5e375e9c4f5d..a381de8648e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1195,29 +1195,60 @@ static void amdgpu_connector_dvi_force(struct drm=
_connector *connector)
>                 amdgpu_connector->use_digital =3D true;
>  }
>
> +/**
> + * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
> + */
> +static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device *adev)
> +{
> +       if (adev->asic_type >=3D CHIP_POLARIS10)
> +               return 600000;
> +       else if (adev->asic_type >=3D CHIP_TONGA)
> +               return 300000;
> +       else
> +               return 297000;
> +}
> +
> +/**
> + * Validates the given display mode on DVI and HDMI connectors,
> + * including analog signals on DVI-I.
> + */
>  static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_c=
onnector *connector,
>                                             const struct drm_display_mode=
 *mode)
>  {
>         struct drm_device *dev =3D connector->dev;
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(connector);
> +       const int max_hdmi_pixel_clock =3D amdgpu_max_hdmi_pixel_clock(ad=
ev);
> +       const int max_dvi_single_link_pixel_clock =3D 165000;
> +       int max_digital_pixel_clock_khz;
>
>         /* XXX check mode bandwidth */
>
> -       if (amdgpu_connector->use_digital && (mode->clock > 165000)) {
> -               if ((amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_DUAL_LINK_DVI_I) ||
> -                   (amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> -                   (amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_HDMI_TYPE_B)) {
> -                       return MODE_OK;
> -               } else if (connector->display_info.is_hdmi) {
> -                       /* HDMI 1.3+ supports max clock of 340 Mhz */
> -                       if (mode->clock > 340000)
> -                               return MODE_CLOCK_HIGH;
> -                       else
> -                               return MODE_OK;
> -               } else {
> -                       return MODE_CLOCK_HIGH;
> +       if (amdgpu_connector->use_digital) {
> +               switch (amdgpu_connector->connector_object_id) {
> +               case CONNECTOR_OBJECT_ID_HDMI_TYPE_A:
> +                       max_digital_pixel_clock_khz =3D max_hdmi_pixel_cl=
ock;
> +                       break;
> +               case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_I:
> +               case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D:
> +                       max_digital_pixel_clock_khz =3D max_dvi_single_li=
nk_pixel_clock;
> +                       break;
> +               case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I:
> +               case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D:
> +               case CONNECTOR_OBJECT_ID_HDMI_TYPE_B:
> +                       max_digital_pixel_clock_khz =3D max_dvi_single_li=
nk_pixel_clock * 2;
> +                       break;
>                 }
> +
> +               /* When the display EDID claims that it's an HDMI display=
,
> +                * we use the HDMI encoder mode of the display HW,
> +                * so we should verify against the max HDMI clock here.
> +                */
> +               if (connector->display_info.is_hdmi)
> +                       max_digital_pixel_clock_khz =3D max_hdmi_pixel_cl=
ock;
> +
> +               if (mode->clock > max_digital_pixel_clock_khz)
> +                       return MODE_CLOCK_HIGH;
>         }
>
>         /* check against the max pixel clock */
> --
> 2.51.0
>
