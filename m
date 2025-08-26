Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A357CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8711910E642;
	Tue, 26 Aug 2025 14:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8v5+GZi";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9905310E649
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:03:39 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b49c729577dso818515a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756217019; x=1756821819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kfpwpo2jQXMSLFkQvQIhXRDzVvQ2J+/g2fldBn73ETg=;
 b=R8v5+GZiT5JVibIKO3JEr96LSQasvnLB6H/Z/63dxt98oMonmvOcIcQsvkAYYWd0dy
 eFTm3zBoHTCsSYUmN4sPbw2v8zUfjAlafTWt2XsrJp62PJ6hW4jSDkSmgojEm/QaaSug
 cnw9q9tyZb1s/2GZnLjRvfMKUpSPJ1naTSSaqHrsofWZDUXzs6c455w1FIu0k7HN3Wzd
 jYzwJUX+YLeTabgpCff3DZMnhorC3KRbxczJmtH9XfJ36OIg1d1wxV0NYXYv4zacRZy9
 UtnJyEttgXM28cJqtmmzhbP5yj+K83ILRf5RVSFxDdC7RsRPvFD6Dl8ws5oyc/zVPJ3P
 rMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756217019; x=1756821819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kfpwpo2jQXMSLFkQvQIhXRDzVvQ2J+/g2fldBn73ETg=;
 b=dn3TRrTByOrI+wO9WE8yUdNV8Z8Dq5I7fp9r29tuTWt9HvALOVFQQWcc5EmuThNxkB
 tS6OUDA5MLb1ixrBRygi8Cunm3Za3sbsFH+qVi5EgPNLeswpBkta/VrHeLg6eewGJ1xA
 B3VXKHlR9BsRa2sxkaneiixtZd/YhSUpce1FLgD1mVxNg5klLeSrfNu40teqijS9d+Ja
 tRbWWbGexYILX8BVAZNIcqdFEqiRwo4TWz6np8EreKNkQyNVdx5zLgQYEFm35jXYGFi/
 vEE7628Qu+kRkaeFAlUH/cKMQ0UUs+s5yKgEcgYsficf63yJsrui9y5w7iAXB+7onvKM
 SNcA==
X-Gm-Message-State: AOJu0YyYaLKlksX9bGR2lH5E7ovDm8IR3JozmsSKw5JX1biJBxuuvm20
 9la3ExOQiqmOFJFkSfdti38Gh4PwG+4coih+NRCTwj2yogJ1rJqcImnZ6lm/8KAxAZHXStzSy9U
 vawLkpMeOBMXdgnz3xtkjQoZfQiZYQxiETQ==
X-Gm-Gg: ASbGncvfrYBz0E7JLe0/0U91xzf2ECTUgO19cWUisbiUO+ndN75iw+8fxWkQR5ktsWX
 h3g+21REt7sOKHLVr04J17X+2iwcTPqzPmo02XrwBeENeJccddm51hvLdzm666DFuWpRHrK82bi
 JNm+naZ473lNUertPDY5/TblZMn10B5skc3V0b2eRfQtd7YJhq/d5etxi+Lhp3u2pMa+8g8vOG4
 bQ2grI38PhTzyq2cw==
X-Google-Smtp-Source: AGHT+IGOmqrBoqlA5pCMkfN3h21LNjikqeDYqXRD6AaAn8eTlWwyjehsXI0EMqyMbrEj3/ELfVbsGXYu3VH73OTG71s=
X-Received: by 2002:a17:902:cecd:b0:246:a19d:c13 with SMTP id
 d9443c01a7336-246a19d1686mr72394195ad.1.1756217018885; Tue, 26 Aug 2025
 07:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250825221046.639289-1-timur.kristof@gmail.com>
In-Reply-To: <20250825221046.639289-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 10:03:27 -0400
X-Gm-Features: Ac12FXwksXjnBPXA-NyfFkKlO23z6uuEC84mv2Z5Mgs0vO37GeM8vdvI0AxRWTo
Message-ID: <CADnq5_Pyx1ZSen6kv+2ncXkpddrj-i2vr3bhoBLOo6=sYD=u1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Respect max pixel clock for HDMI and DVI-D
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

On Mon, Aug 25, 2025 at 6:10=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Change the legacy (non-DC) display code to respect the maximum
> pixel clock for HDMI and DVI-D. Reject modes that would require
> a higher pixel clock than can be supported.
>
> Also update the maximum supported HDMI clock value depending on
> the ASIC type.
>
> For reference, see the DC code:
> check max_hdmi_pixel_clock in dce*_resource.c
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 5e375e9c4f5d..abcc4469cf57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1195,12 +1195,26 @@ static void amdgpu_connector_dvi_force(struct drm=
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
>
>         /* XXX check mode bandwidth */
>
> @@ -1208,10 +1222,13 @@ static enum drm_mode_status amdgpu_connector_dvi_=
mode_valid(struct drm_connector
>                 if ((amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_DUAL_LINK_DVI_I) ||
>                     (amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_DUAL_LINK_DVI_D) ||
>                     (amdgpu_connector->connector_object_id =3D=3D CONNECT=
OR_OBJECT_ID_HDMI_TYPE_B)) {
> -                       return MODE_OK;
> +                       if (mode->clock > max_hdmi_pixel_clock)
> +                               return MODE_CLOCK_HIGH;
> +                       else
> +                               return MODE_OK;

I don't think it makes sense to limit dual link DVI to the max HDMI
clock.  HDMI is single link TMDS.  Other than that, the patch looks
good to me.

Alex

>                 } else if (connector->display_info.is_hdmi) {
>                         /* HDMI 1.3+ supports max clock of 340 Mhz */
> -                       if (mode->clock > 340000)
> +                       if (mode->clock > max_hdmi_pixel_clock)
>                                 return MODE_CLOCK_HIGH;
>                         else
>                                 return MODE_OK;
> --
> 2.50.1
>
