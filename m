Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8389FCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 17:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E61610E03C;
	Wed, 27 Aug 2025 17:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feYmy7Z9";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F228110E03C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 17:05:57 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-248cd112855so66745ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756314357; x=1756919157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLt7PaEuiVtzHuFcz6qpIyZKwilWdxL5eb2qU8+Fync=;
 b=feYmy7Z94IuO5fVJY2CuMBZY6bIiH/V16vlvc3dxaEKaIN7RTb6Pwowt0WeRnViPfr
 K68et9WRqAfyt+Hb3ml4I8R+Nyi5m6TgzWZkc4rAysx2AkdspB3gqZ122a2thAqUXS7i
 ABXwUHSoGnU56FDLOydCc87kGrQx0LUuBXTc1E4Ws5AtSk6jzBWUgTwnBfzrhulJdVVF
 K6NgB/SrrBYutsXjxMn204LCtl88eyXtAtWUI6D9WQyOwqPMWfD55eFRoqfjAcBw9pFl
 MlWeAHBc8pcCqCJf6lYyqvfK3PRoicKb5kknzeeAlfPa5zxut/0GLmliHEtZsvFlw60s
 O5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756314357; x=1756919157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLt7PaEuiVtzHuFcz6qpIyZKwilWdxL5eb2qU8+Fync=;
 b=KzKjCOEpL4NKkNr+opsU5G3bqb8q1tPRjfhi6JvL9FLfVNN3cpGRk4tE18JDjY2jII
 nzLtH8HIs0IdvPZcxRa6pPx3RfY7lhr0eRFkVTFe7HO3XS3TcC0Go8zMZiq4Dqp9DkIO
 IG62JDiPsPHfWjC5+If3NDK2FOa097atIShCV53WSk6DcqbO/R+UjKa/6geSLuazHbjS
 a3mJAJ80Ak+uBZ5PTullHeNzEky/5YdH0VsPUy6XKv+snA4NHAzF+MohBabv7ap1frcp
 NticJ4E90TsDd30k+XOwsAdv4rvCfVokjqTJ0eWoTNalU79+x7s3FP54tgo5zhWumnrM
 q1LA==
X-Gm-Message-State: AOJu0YzjNuFiYSfoiSidgBrppF38c+NAC45gTQIQ7RBJXixfr01neOJv
 RVUabE+kYUmb91hXJ+zn79JWjkPtyUMqMS+ajHGlliWDpA2Pg7LwwqIaq37Vu1MoOAu04S5WA/X
 8fpeQ02fUCIWtAGJmm4tu8D8ao74FAjg=
X-Gm-Gg: ASbGncssMG0np8jSlYD0Ahn/xaQReuJvyREYtxIXVvLa9d7b/3BBFMp8fK/AEBu8KSu
 sIW5r05s3FeEP2EewINVfFknLx035FTkPKkbPxSCP5OQjlNixJMbwcbufeFqsLxVZzrwSJePgGo
 nwI9z9nxHjk6xbnLHYOa8GQfujXn3SOgn+16z+iYCM3iIpLx5rqwoP1bw3pQch3nD2skX3i1VFm
 CcAESs=
X-Google-Smtp-Source: AGHT+IFN1P0YEDQvxtBLvxxX/qusZjCPQnRquPLnytM2ABQDCgo9Tat1UN2OgcHkO1SfeD2gXp84TzRILE6o7YesoVI=
X-Received: by 2002:a17:902:e744:b0:248:7a43:e1c5 with SMTP id
 d9443c01a7336-2487a43e264mr45436525ad.7.1756314357384; Wed, 27 Aug 2025
 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250825221046.639289-1-timur.kristof@gmail.com>
 <CADnq5_Pyx1ZSen6kv+2ncXkpddrj-i2vr3bhoBLOo6=sYD=u1g@mail.gmail.com>
 <89d36c21cca1a0f1a20d0033269668b085e81181.camel@gmail.com>
 <CADnq5_P6NYuRmbwV1tYkDxeBEttwhTFUvYGpGKnPUnsMj_v7Cg@mail.gmail.com>
 <851c05776a0c4850373ab24aeba425e8459548f6.camel@gmail.com>
In-Reply-To: <851c05776a0c4850373ab24aeba425e8459548f6.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 13:05:45 -0400
X-Gm-Features: Ac12FXx8YC9pXRxwQ3o1Hibz0dG_bEnEhVzuJUAkItoBgmiaCZIStaFr8ux5m_I
Message-ID: <CADnq5_Nng6Hjz8st-UOUrgjq=rYVdr=13aK+0KM+Jf+FQ9mmaQ@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 12:54=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Wed, 2025-08-27 at 12:36 -0400, Alex Deucher wrote:
> > On Wed, Aug 27, 2025 at 10:36=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > On Tue, 2025-08-26 at 10:03 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 25, 2025 at 6:10=E2=80=AFPM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >
> > > > > Change the legacy (non-DC) display code to respect the maximum
> > > > > pixel clock for HDMI and DVI-D. Reject modes that would require
> > > > > a higher pixel clock than can be supported.
> > > > >
> > > > > Also update the maximum supported HDMI clock value depending on
> > > > > the ASIC type.
> > > > >
> > > > > For reference, see the DC code:
> > > > > check max_hdmi_pixel_clock in dce*_resource.c
> > > > >
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > ---
> > > > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 21
> > > > > +++++++++++++++++--
> > > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > index 5e375e9c4f5d..abcc4469cf57 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > @@ -1195,12 +1195,26 @@ static void
> > > > > amdgpu_connector_dvi_force(struct drm_connector *connector)
> > > > >                 amdgpu_connector->use_digital =3D true;
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * Returns the maximum supported HDMI (TMDS) pixel clock in
> > > > > KHz.
> > > > > + */
> > > > > +static int amdgpu_max_hdmi_pixel_clock(const struct
> > > > > amdgpu_device
> > > > > *adev)
> > > > > +{
> > > > > +       if (adev->asic_type >=3D CHIP_POLARIS10)
> > > > > +               return 600000;
> > > > > +       else if (adev->asic_type >=3D CHIP_TONGA)
> > > > > +               return 300000;
> > > > > +       else
> > > > > +               return 297000;
> > > > > +}
> > > > > +
> > > > >  static enum drm_mode_status
> > > > > amdgpu_connector_dvi_mode_valid(struct
> > > > > drm_connector *connector,
> > > > >                                             const struct
> > > > > drm_display_mode *mode)
> > > > >  {
> > > > >         struct drm_device *dev =3D connector->dev;
> > > > >         struct amdgpu_device *adev =3D drm_to_adev(dev);
> > > > >         struct amdgpu_connector *amdgpu_connector =3D
> > > > > to_amdgpu_connector(connector);
> > > > > +       const int max_hdmi_pixel_clock =3D
> > > > > amdgpu_max_hdmi_pixel_clock(adev);
> > > > >
> > > > >         /* XXX check mode bandwidth */
> > > > >
> > > > > @@ -1208,10 +1222,13 @@ static enum drm_mode_status
> > > > > amdgpu_connector_dvi_mode_valid(struct drm_connector
> > > > >                 if ((amdgpu_connector->connector_object_id =3D=3D
> > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
> > > > >                     (amdgpu_connector->connector_object_id =3D=3D
> > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> > > > >                     (amdgpu_connector->connector_object_id =3D=3D
> > > > > CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
> > > > > -                       return MODE_OK;
> > > > > +                       if (mode->clock > max_hdmi_pixel_clock)
> > > > > +                               return MODE_CLOCK_HIGH;
> > > > > +                       else
> > > > > +                               return MODE_OK;
> > > >
> > > > I don't think it makes sense to limit dual link DVI to the max
> > > > HDMI
> > > > clock.  HDMI is single link TMDS.  Other than that, the patch
> > > > looks
> > > > good to me.
> > > >
> > > > Alex
> > >
> > > Hi Alex,
> > >
> > > The problem I'm trying to solve here is that on the non-DC code, by
> > > default I get a black screen on DVI-D because the code doesn't set
> > > an
> > > upper limit on what is actually supported. (And the monitor
> > > supports
> > > some modes which won't work.)
> > >
> > > As far as I see, DC only allows 4K 30 Hz on DVI for the same
> > > connector
> > > and DVI/HDMI adapter. That may be wrong, though.
> > >
> > > What value do you suggest to use?
> > >
> > > If HDMI =3D single link TMDS, does that mean that a passive DVI/HDMI
> > > adapter cannot take advantage of dual-link DVI?
> >
> > DVI has a 165 Mhz limit per link so dual link would be 330 Mhz.
> >
> > Alex
>
> I see. That's my mistake, I thought that the max_hdmi_pixel_clock as
> defined in DC is applicable to all TMDS signals, not just HDMI.
>
> That being said, can you confirm that a DVI/HDMI adapter can indeed use
> both links of the dual-link DVI?
>

DVI to HDMI adapters probably only wire up the a single TMDS link
because that is all HDMI supports.  HDMI is single link TMDS and it
was extended beyond 165 Mhz, so most monitors that support HDMI
support faster single link clocks on DVI as well if they have both
inputs since it's the same panel.  Older DVI only monitors are
probably the only ones where the single vs dual link clocks are
important.

Alex

> >
> > >
> > > Thanks,
> > > Timur
> > >
> > > >
> > > > >                 } else if (connector->display_info.is_hdmi) {
> > > > >                         /* HDMI 1.3+ supports max clock of 340
> > > > > Mhz
> > > > > */
> > > > > -                       if (mode->clock > 340000)
> > > > > +                       if (mode->clock > max_hdmi_pixel_clock)
> > > > >                                 return MODE_CLOCK_HIGH;
> > > > >                         else
> > > > >                                 return MODE_OK;
> > > > > --
> > > > > 2.50.1
> > > > >
