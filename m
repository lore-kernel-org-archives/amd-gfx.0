Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06666CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 16:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E3210E169;
	Wed, 27 Aug 2025 16:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hEKwxqSL";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46F310E166
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 16:36:52 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-771ffc22395so7348b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756312612; x=1756917412; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sygGa2hEx8sGa6GZ1mE/v0rbKu22l9JnmSDUbRHCkXU=;
 b=hEKwxqSL5coJGxGkvMO6+UaS5ShgSXhoII4dQerYbrEsEWcNOkQFc4869tIyM0SRQf
 JFoTKmr77YHMIJ5WTZ4NqXn7Sy/536h+1rDoiURNDNCJxXfIvh5xNxU4nhHdye5EF67U
 8/OiEuT9yrVRzO9IXjughSyJeWoRnI7v7HoIvNrss8gpNWwQWX7Fmrlb5PkTK/7RA8Vc
 e3SDCFMPHcTQAqoZz6vU8G71d1g+/yf7OOhkJMo/w4uRGzBooo6wexpAQ2jLLFEsIkpT
 MZlX6BNMSJ6Vfv+QBawMbL/tPWXwhac/JwF5q1/1vK9ANlYcv3cjXCUWWn2q/1pIfXNJ
 Kc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312612; x=1756917412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sygGa2hEx8sGa6GZ1mE/v0rbKu22l9JnmSDUbRHCkXU=;
 b=jOaGWL4+YpI8qbvTVTlAGORPVksuskShBBOWFT/btjmehmQ1E9KXwbW2Of8IArYiO4
 nE91D5abzKMhYilL5pt56tji9bmfYg7py4zPYcfnI6VBERhNhRfLobyB33Vp8nHUlgsa
 xMQQALigPJnq3mAu7K7BKE/jaQEpxjVoIU9a5aGNImdA03NTEItVl2Jta4suATXdoprE
 x2mvenwd+KXbXXJrjzocojTYaGIfhL373kjIs4qtbpmzIlj5tT4y188G0r8BFWsFYKeh
 o7BekmGiiyXZBHvhO1TGgMtE77v1Q9RFWJkXxIm9Y2ik32kmR2HTNUeZJKfttXozjfjA
 EgrA==
X-Gm-Message-State: AOJu0Yy8B3lQhOUzdvN6IhTE9dbbktgiYHZqcS38a4FUxlCSwl/xKXkS
 +DhPYaRjoHN7NXY59ouP4kOuvKRpqyryrZxOqPrJbXao4p266Ei8jZCaAHVOn2ok2pMZHfXr5mE
 rG4ZJL9x2qb9G4QK61WK0RP8nyBFbYjBpQQ==
X-Gm-Gg: ASbGnct//VxcKUiE4Ci6zoKzwOUVLNynqrFPzPBmjduQS0yonK4+ZZKoD7+6U6M5DnM
 BmBxnNUAVk0tK5FEg7qAEtbkMDiHnactuoRxQqPcUaqe3Nx/K2M22dyE4E2k4rHvz6kvpfObbwE
 ruQibcIZKjsnUljFFG+aU3Kj9ZS9PfvvYz0mXpO38SvyIsoXnuD9mfZXNQ3O89tpcgvx2XmyRSs
 Bj3wxA=
X-Google-Smtp-Source: AGHT+IH7GQSiVqNYlYqEc6R4HislWxLoVQ5H5yGCJFRnQS71JNaEnVZpHeaX1caqkUcHUzMmkDAw0fpPakD/+YJ7EN8=
X-Received: by 2002:a17:90b:38c4:b0:327:9b90:b295 with SMTP id
 98e67ed59e1d1-3279b90b458mr612123a91.0.1756312612023; Wed, 27 Aug 2025
 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250825221046.639289-1-timur.kristof@gmail.com>
 <CADnq5_Pyx1ZSen6kv+2ncXkpddrj-i2vr3bhoBLOo6=sYD=u1g@mail.gmail.com>
 <89d36c21cca1a0f1a20d0033269668b085e81181.camel@gmail.com>
In-Reply-To: <89d36c21cca1a0f1a20d0033269668b085e81181.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 12:36:40 -0400
X-Gm-Features: Ac12FXxuHTHwV8carMDp_usSOSgQdD_5tf7ozpFwwcSx6XmOsV0xPeRGc7y1fSw
Message-ID: <CADnq5_P6NYuRmbwV1tYkDxeBEttwhTFUvYGpGKnPUnsMj_v7Cg@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 10:36=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Tue, 2025-08-26 at 10:03 -0400, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 6:10=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > Change the legacy (non-DC) display code to respect the maximum
> > > pixel clock for HDMI and DVI-D. Reject modes that would require
> > > a higher pixel clock than can be supported.
> > >
> > > Also update the maximum supported HDMI clock value depending on
> > > the ASIC type.
> > >
> > > For reference, see the DC code:
> > > check max_hdmi_pixel_clock in dce*_resource.c
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 21
> > > +++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > index 5e375e9c4f5d..abcc4469cf57 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > @@ -1195,12 +1195,26 @@ static void
> > > amdgpu_connector_dvi_force(struct drm_connector *connector)
> > >                 amdgpu_connector->use_digital =3D true;
> > >  }
> > >
> > > +/**
> > > + * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
> > > + */
> > > +static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device
> > > *adev)
> > > +{
> > > +       if (adev->asic_type >=3D CHIP_POLARIS10)
> > > +               return 600000;
> > > +       else if (adev->asic_type >=3D CHIP_TONGA)
> > > +               return 300000;
> > > +       else
> > > +               return 297000;
> > > +}
> > > +
> > >  static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct
> > > drm_connector *connector,
> > >                                             const struct
> > > drm_display_mode *mode)
> > >  {
> > >         struct drm_device *dev =3D connector->dev;
> > >         struct amdgpu_device *adev =3D drm_to_adev(dev);
> > >         struct amdgpu_connector *amdgpu_connector =3D
> > > to_amdgpu_connector(connector);
> > > +       const int max_hdmi_pixel_clock =3D
> > > amdgpu_max_hdmi_pixel_clock(adev);
> > >
> > >         /* XXX check mode bandwidth */
> > >
> > > @@ -1208,10 +1222,13 @@ static enum drm_mode_status
> > > amdgpu_connector_dvi_mode_valid(struct drm_connector
> > >                 if ((amdgpu_connector->connector_object_id =3D=3D
> > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
> > >                     (amdgpu_connector->connector_object_id =3D=3D
> > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> > >                     (amdgpu_connector->connector_object_id =3D=3D
> > > CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
> > > -                       return MODE_OK;
> > > +                       if (mode->clock > max_hdmi_pixel_clock)
> > > +                               return MODE_CLOCK_HIGH;
> > > +                       else
> > > +                               return MODE_OK;
> >
> > I don't think it makes sense to limit dual link DVI to the max HDMI
> > clock.  HDMI is single link TMDS.  Other than that, the patch looks
> > good to me.
> >
> > Alex
>
> Hi Alex,
>
> The problem I'm trying to solve here is that on the non-DC code, by
> default I get a black screen on DVI-D because the code doesn't set an
> upper limit on what is actually supported. (And the monitor supports
> some modes which won't work.)
>
> As far as I see, DC only allows 4K 30 Hz on DVI for the same connector
> and DVI/HDMI adapter. That may be wrong, though.
>
> What value do you suggest to use?
>
> If HDMI =3D single link TMDS, does that mean that a passive DVI/HDMI
> adapter cannot take advantage of dual-link DVI?

DVI has a 165 Mhz limit per link so dual link would be 330 Mhz.

Alex

>
> Thanks,
> Timur
>
> >
> > >                 } else if (connector->display_info.is_hdmi) {
> > >                         /* HDMI 1.3+ supports max clock of 340 Mhz
> > > */
> > > -                       if (mode->clock > 340000)
> > > +                       if (mode->clock > max_hdmi_pixel_clock)
> > >                                 return MODE_CLOCK_HIGH;
> > >                         else
> > >                                 return MODE_OK;
> > > --
> > > 2.50.1
> > >
