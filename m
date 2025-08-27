Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D2CCA0FF9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 17:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765ED10E86C;
	Wed, 27 Aug 2025 17:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gunmIobh";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2710710E86B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 17:11:04 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b49c729577dso23301a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756314664; x=1756919464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d10LDJ3bwTQSlKexD8CJK+polUB+DRwnBXR559Neu7w=;
 b=gunmIobh8BepIvIuSOZMb0Mg59CsXeM8BzWjt1A3M1E91ghURyzLUiH6/VoL7Oa9nG
 QU/UEs26XkW7RU6tEqclBLyYtl/xq4To4nKD04aV2zqvVjb43tzpZMxOIZk2QrSU1yZh
 l7YElphm3YBXE+9cr9XaWLRaEwRCwE1Q5qL5CQJcSrTJZ+XiWNo18EYI2C5TBTw0iCVK
 IfbjGkcUXCzmacdEGVcJNVIEOiS1+7k4AeDSmloL3AzE6edl3RQR4h6O0oxvlxrPuqPC
 9VycsI5hxafyxIBMNmoi0oVZ931/jwrbGxez41Y7tPOyA7viFFC/R2EoGR6zxOZQuIjv
 1omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756314664; x=1756919464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d10LDJ3bwTQSlKexD8CJK+polUB+DRwnBXR559Neu7w=;
 b=egXLEWkfqvFiVTeklRb3L2Y2F2cm9qDbjZLjXqUC9qFKuQYS9REnnHZtUuOU7qA1WD
 7oTPlHYrcQoejtd7p+AHziah3lRWiCDmpxU4ZhnkIxsOV0DZaA6dPK3C9Tup0yGUVDUx
 ZKQWW21qXE5t9/bQQq1FjjNm79uafZJ1deHVimgsryuUWr5ZhwgnKjXbkNy6/MbovCVX
 9dSnG3JjV3agapWJJda9XxC2yoxbvjI8RjUOtBEfWvpW5j+77yVODjv+0tFBeEcMfAWR
 Rn5F5yzvvqaekhmzQGK2mlSfgNvd8REu9G2ktUrIE4NgYWJtL6FzI4H+fFy92QbUydV7
 kGMg==
X-Gm-Message-State: AOJu0YzDXdrm1TrvW42Hlm2hlODH3ZVVcWpal24c6rC+Dnpw75HayYUH
 +goXtTvysfJl4nVchMboCiyUcOrQlrIpW60jLaMd/WfMaenBWJqSGYKdFdO17FczXpA4seZYkuZ
 Zd2moP9Wry6pAxSDkS0XkBb/AzCTycq8=
X-Gm-Gg: ASbGncuyuQ3fGxp0O0lniHGzbDeRR2PA/pSoyCl7T5GykEHefqM+VKYg2LOcss6DhDb
 t5QLcUPtbGyKplSRPe81X6uRM/7DPCwNipOsJiaWrzWjBN19jOpF8va01vfBlNKSunrWa+vtwz5
 yv3HjkQkOmvXPD8BAOyBicDGGYLJK6jJgfozqSE0L8FKMyHzF7wgv+HTRGZVvuwQiZPTdvy7b2o
 7X+eoGOmt9iSJSmhQ==
X-Google-Smtp-Source: AGHT+IHfk5xR1wvAH+Zfs9SHafO3Op/rHAOjBn6z/if1y3QxtOD88uO9oXbI8Q1fS1N1klazDcKeWJ5Gy928dFXXmtw=
X-Received: by 2002:a17:902:c40c:b0:248:79d4:939f with SMTP id
 d9443c01a7336-24879d49769mr44418955ad.7.1756314663578; Wed, 27 Aug 2025
 10:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250825221046.639289-1-timur.kristof@gmail.com>
 <CADnq5_Pyx1ZSen6kv+2ncXkpddrj-i2vr3bhoBLOo6=sYD=u1g@mail.gmail.com>
 <89d36c21cca1a0f1a20d0033269668b085e81181.camel@gmail.com>
 <CADnq5_P6NYuRmbwV1tYkDxeBEttwhTFUvYGpGKnPUnsMj_v7Cg@mail.gmail.com>
 <851c05776a0c4850373ab24aeba425e8459548f6.camel@gmail.com>
 <CADnq5_Nng6Hjz8st-UOUrgjq=rYVdr=13aK+0KM+Jf+FQ9mmaQ@mail.gmail.com>
 <ed2842cb1a35a95376ef55a28a8e0454b24fd787.camel@gmail.com>
In-Reply-To: <ed2842cb1a35a95376ef55a28a8e0454b24fd787.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 13:10:52 -0400
X-Gm-Features: Ac12FXzJGJt3E4M8I6ph2-QakMrttpdxLiHoRyrIOKE2Ifm1o8GkAWUQH-PIT1E
Message-ID: <CADnq5_PVQaoFDsuLtei_=C2i9zC32yxofAyBjSmbxUTKjiD_+w@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 1:08=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Wed, 2025-08-27 at 13:05 -0400, Alex Deucher wrote:
> > On Wed, Aug 27, 2025 at 12:54=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > On Wed, 2025-08-27 at 12:36 -0400, Alex Deucher wrote:
> > > > On Wed, Aug 27, 2025 at 10:36=E2=80=AFAM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >
> > > > > On Tue, 2025-08-26 at 10:03 -0400, Alex Deucher wrote:
> > > > > > On Mon, Aug 25, 2025 at 6:10=E2=80=AFPM Timur Krist=C3=B3f
> > > > > > <timur.kristof@gmail.com> wrote:
> > > > > > >
> > > > > > > Change the legacy (non-DC) display code to respect the
> > > > > > > maximum
> > > > > > > pixel clock for HDMI and DVI-D. Reject modes that would
> > > > > > > require
> > > > > > > a higher pixel clock than can be supported.
> > > > > > >
> > > > > > > Also update the maximum supported HDMI clock value
> > > > > > > depending on
> > > > > > > the ASIC type.
> > > > > > >
> > > > > > > For reference, see the DC code:
> > > > > > > check max_hdmi_pixel_clock in dce*_resource.c
> > > > > > >
> > > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > > ---
> > > > > > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 21
> > > > > > > +++++++++++++++++--
> > > > > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > > index 5e375e9c4f5d..abcc4469cf57 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > > @@ -1195,12 +1195,26 @@ static void
> > > > > > > amdgpu_connector_dvi_force(struct drm_connector *connector)
> > > > > > >                 amdgpu_connector->use_digital =3D true;
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * Returns the maximum supported HDMI (TMDS) pixel clock
> > > > > > > in
> > > > > > > KHz.
> > > > > > > + */
> > > > > > > +static int amdgpu_max_hdmi_pixel_clock(const struct
> > > > > > > amdgpu_device
> > > > > > > *adev)
> > > > > > > +{
> > > > > > > +       if (adev->asic_type >=3D CHIP_POLARIS10)
> > > > > > > +               return 600000;
> > > > > > > +       else if (adev->asic_type >=3D CHIP_TONGA)
> > > > > > > +               return 300000;
> > > > > > > +       else
> > > > > > > +               return 297000;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static enum drm_mode_status
> > > > > > > amdgpu_connector_dvi_mode_valid(struct
> > > > > > > drm_connector *connector,
> > > > > > >                                             const struct
> > > > > > > drm_display_mode *mode)
> > > > > > >  {
> > > > > > >         struct drm_device *dev =3D connector->dev;
> > > > > > >         struct amdgpu_device *adev =3D drm_to_adev(dev);
> > > > > > >         struct amdgpu_connector *amdgpu_connector =3D
> > > > > > > to_amdgpu_connector(connector);
> > > > > > > +       const int max_hdmi_pixel_clock =3D
> > > > > > > amdgpu_max_hdmi_pixel_clock(adev);
> > > > > > >
> > > > > > >         /* XXX check mode bandwidth */
> > > > > > >
> > > > > > > @@ -1208,10 +1222,13 @@ static enum drm_mode_status
> > > > > > > amdgpu_connector_dvi_mode_valid(struct drm_connector
> > > > > > >                 if ((amdgpu_connector->connector_object_id
> > > > > > > =3D=3D
> > > > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
> > > > > > >                     (amdgpu_connector->connector_object_id
> > > > > > > =3D=3D
> > > > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> > > > > > >                     (amdgpu_connector->connector_object_id
> > > > > > > =3D=3D
> > > > > > > CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
> > > > > > > -                       return MODE_OK;
> > > > > > > +                       if (mode->clock >
> > > > > > > max_hdmi_pixel_clock)
> > > > > > > +                               return MODE_CLOCK_HIGH;
> > > > > > > +                       else
> > > > > > > +                               return MODE_OK;
> > > > > >
> > > > > > I don't think it makes sense to limit dual link DVI to the
> > > > > > max
> > > > > > HDMI
> > > > > > clock.  HDMI is single link TMDS.  Other than that, the patch
> > > > > > looks
> > > > > > good to me.
> > > > > >
> > > > > > Alex
> > > > >
> > > > > Hi Alex,
> > > > >
> > > > > The problem I'm trying to solve here is that on the non-DC
> > > > > code, by
> > > > > default I get a black screen on DVI-D because the code doesn't
> > > > > set
> > > > > an
> > > > > upper limit on what is actually supported. (And the monitor
> > > > > supports
> > > > > some modes which won't work.)
> > > > >
> > > > > As far as I see, DC only allows 4K 30 Hz on DVI for the same
> > > > > connector
> > > > > and DVI/HDMI adapter. That may be wrong, though.
> > > > >
> > > > > What value do you suggest to use?
> > > > >
> > > > > If HDMI =3D single link TMDS, does that mean that a passive
> > > > > DVI/HDMI
> > > > > adapter cannot take advantage of dual-link DVI?
> > > >
> > > > DVI has a 165 Mhz limit per link so dual link would be 330 Mhz.
> > > >
> > > > Alex
> > >
> > > I see. That's my mistake, I thought that the max_hdmi_pixel_clock
> > > as
> > > defined in DC is applicable to all TMDS signals, not just HDMI.
> > >
> > > That being said, can you confirm that a DVI/HDMI adapter can indeed
> > > use
> > > both links of the dual-link DVI?
> > >
> >
> > DVI to HDMI adapters probably only wire up the a single TMDS link
> > because that is all HDMI supports.  HDMI is single link TMDS and it
> > was extended beyond 165 Mhz, so most monitors that support HDMI
> > support faster single link clocks on DVI as well if they have both
> > inputs since it's the same panel.  Older DVI only monitors are
> > probably the only ones where the single vs dual link clocks are
> > important.
> >
> > Alex
>
> Would it make sense to still use the HDMI clock for DVI-D when the
> monitor is a HDMI monitor, ie. display_info.is_hdmi is set? Considering
> that in this case we use the HDMI encoder mode.

Yes.  In that case, we are basically just sending an HDMI signal.

Alex

>
> >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Timur
> > > > >
> > > > > >
> > > > > > >                 } else if (connector->display_info.is_hdmi)
> > > > > > > {
> > > > > > >                         /* HDMI 1.3+ supports max clock of
> > > > > > > 340
> > > > > > > Mhz
> > > > > > > */
> > > > > > > -                       if (mode->clock > 340000)
> > > > > > > +                       if (mode->clock >
> > > > > > > max_hdmi_pixel_clock)
> > > > > > >                                 return MODE_CLOCK_HIGH;
> > > > > > >                         else
> > > > > > >                                 return MODE_OK;
> > > > > > > --
> > > > > > > 2.50.1
> > > > > > >
