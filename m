Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A27CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 17:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4236D10E865;
	Wed, 27 Aug 2025 17:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NleN4G19";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E3F10E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 17:08:27 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso28867f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756314506; x=1756919306; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5Fzu/3IcnrKpQXItSKtR1YBZwfBtroidKgpk+FxQlvc=;
 b=NleN4G19QAMKcw+9g1DEb1VZTCV/U08i/K+iyWG80WoTXVOqpn6rLNZbE5nM5s6lOc
 n85kg4HjyLZARmMuBA7m9Ttmmw/c8Et0Or+kx3N8MKuRMxpF9AdnCCzuSn7NJzHkdY7r
 ktCqRgjV847XIwSjFyp0m4hYTPoGW+PPxY7hBGMXjPZbGYSzHz2SOn5mfX+JGLxnd5XP
 IqJniNQ9T5WM+zr4lmTW1heXsZQRhK5S/Z6pNRDhWW8CH5PtZToopqZK5NkWfhdGnslY
 680pJ++X05pQlEKIIWUHOBcUtH5fzC6LkhVvphiuRdM/Vxczn5wM6Ln6pihPvU/4yKUk
 u08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756314506; x=1756919306;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Fzu/3IcnrKpQXItSKtR1YBZwfBtroidKgpk+FxQlvc=;
 b=HGMfwRHc9zf4bVPQ3wxfhQm1Oxe1iH4syjxMajWccUDS1MUbeirP/ASPxJWJbU2FPz
 tCJCJGs+OyU92d3gsvpiTdOe0RX6lvm2Q3VEObBqLHf6U+ewXfcYziO7/IA8cNYTJnBD
 vNAaIOmg9VGQenFyPGEjH3be6ji7EFqbV91iSXVmsrczkwNGY97WVmx498TOu6HxeQBR
 fTMM8nc7lleh6sX7gawWfsizM6XBYwiflZxjb4Rto/GTl+ADjh7QTn09ZwlY1l8XFlVn
 iUWRpeybANy9cACBjHnp4F3s4d6tF+VcvW5lrpxVfbq+hixWxnh7jIG0eblHonsZBtju
 0+hw==
X-Gm-Message-State: AOJu0YxU7O0cELoYI48tH6XMZ8tBayLfW/sUls4ogr5irLpjaU+PYTMT
 TIEpgUQXP0jN1IERSxAIXfJVlZewfPS6XTBVjSKGBpAM8qHjrCPxrcca
X-Gm-Gg: ASbGnctqxpPPyyYaqC/XEqFfKuFHQJWGJIGkqPGZp2/96+dhNTnYMMsAWy6/Bw69mg8
 FzF0fRIqF4fnqOPI2eU10FBgM69Iq0ZmShZEFIrcUXhZGhCVZJbILahAnNP5/wPJkVA4KlrxuAZ
 rPPnLvbmOw8r7UJ53MPMrF1Rq16hCnO/m6j8yGTFG+uwv2PwJSWLUhbf8dNGYxLOx8MXZQMPOpC
 Ay6LTlT/UrVSkJ7sjqxrfqrPl/G+2nVdEYwYkFYMFs6kM9IQKvYu535s0bbNNPc815+syJH0Ao+
 o9Zs5qQpQLoYvx4v1yydlm/pZNFkrKhzBn5iiLF/r3FpHc/tc4TWdXIYuDssr6L/u0T0bCABJh0
 Z6/q7/s8L96H7KlqW5+iCo41Kffik0Nt6cWkQIOnUAmQsnHkEIHi9he4lPJuGNJUgvfFEtD4uRf
 REy4GdPeG4qf25vIBS52zKKJzoy66IDwui/NkpGO4NWIrliT6tX/bR5D0/CXAKaU96ELsLGf+K
X-Google-Smtp-Source: AGHT+IHwN8y1SqYDFgrZ8tRuNarcYm+0drq9PxsWlBnGWjcOBDQPrpmHAI00HGijfqgxqhrsaweOag==
X-Received: by 2002:a5d:5d84:0:b0:3b9:10c4:e99a with SMTP id
 ffacd0b85a97d-3c5dc734325mr13502056f8f.34.1756314506224; 
 Wed, 27 Aug 2025 10:08:26 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:f46e:206e:80c6:1890?
 (20014C4E24E36900F46E206E80C61890.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:f46e:206e:80c6:1890])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f334c95sm37308295e9.25.2025.08.27.10.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 10:08:25 -0700 (PDT)
Message-ID: <ed2842cb1a35a95376ef55a28a8e0454b24fd787.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Respect max pixel clock for HDMI and DVI-D
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
Date: Wed, 27 Aug 2025 19:08:24 +0200
In-Reply-To: <CADnq5_Nng6Hjz8st-UOUrgjq=rYVdr=13aK+0KM+Jf+FQ9mmaQ@mail.gmail.com>
References: <20250825221046.639289-1-timur.kristof@gmail.com>
 <CADnq5_Pyx1ZSen6kv+2ncXkpddrj-i2vr3bhoBLOo6=sYD=u1g@mail.gmail.com>
 <89d36c21cca1a0f1a20d0033269668b085e81181.camel@gmail.com>
 <CADnq5_P6NYuRmbwV1tYkDxeBEttwhTFUvYGpGKnPUnsMj_v7Cg@mail.gmail.com>
 <851c05776a0c4850373ab24aeba425e8459548f6.camel@gmail.com>
 <CADnq5_Nng6Hjz8st-UOUrgjq=rYVdr=13aK+0KM+Jf+FQ9mmaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-08-27 at 13:05 -0400, Alex Deucher wrote:
> On Wed, Aug 27, 2025 at 12:54=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > On Wed, 2025-08-27 at 12:36 -0400, Alex Deucher wrote:
> > > On Wed, Aug 27, 2025 at 10:36=E2=80=AFAM Timur Krist=C3=B3f
> > > <timur.kristof@gmail.com> wrote:
> > > >=20
> > > > On Tue, 2025-08-26 at 10:03 -0400, Alex Deucher wrote:
> > > > > On Mon, Aug 25, 2025 at 6:10=E2=80=AFPM Timur Krist=C3=B3f
> > > > > <timur.kristof@gmail.com> wrote:
> > > > > >=20
> > > > > > Change the legacy (non-DC) display code to respect the
> > > > > > maximum
> > > > > > pixel clock for HDMI and DVI-D. Reject modes that would
> > > > > > require
> > > > > > a higher pixel clock than can be supported.
> > > > > >=20
> > > > > > Also update the maximum supported HDMI clock value
> > > > > > depending on
> > > > > > the ASIC type.
> > > > > >=20
> > > > > > For reference, see the DC code:
> > > > > > check max_hdmi_pixel_clock in dce*_resource.c
> > > > > >=20
> > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > ---
> > > > > > =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_connectors.c=C2=A0=C2=A0=C2=
=A0 | 21
> > > > > > +++++++++++++++++--
> > > > > > =C2=A01 file changed, 19 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > index 5e375e9c4f5d..abcc4469cf57 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > > > > > @@ -1195,12 +1195,26 @@ static void
> > > > > > amdgpu_connector_dvi_force(struct drm_connector *connector)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_connector->use_digital =3D true;
> > > > > > =C2=A0}
> > > > > >=20
> > > > > > +/**
> > > > > > + * Returns the maximum supported HDMI (TMDS) pixel clock
> > > > > > in
> > > > > > KHz.
> > > > > > + */
> > > > > > +static int amdgpu_max_hdmi_pixel_clock(const struct
> > > > > > amdgpu_device
> > > > > > *adev)
> > > > > > +{
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->asic_type >=3D =
CHIP_POLARIS10)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 600000;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (adev->asic_type =
>=3D CHIP_TONGA)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 300000;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 297000;
> > > > > > +}
> > > > > > +
> > > > > > =C2=A0static enum drm_mode_status
> > > > > > amdgpu_connector_dvi_mode_valid(struct
> > > > > > drm_connector *connector,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> > > > > > drm_display_mode *mode)
> > > > > > =C2=A0{
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_device *d=
ev =3D connector->dev;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device=
 *adev =3D drm_to_adev(dev);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_connec=
tor *amdgpu_connector =3D
> > > > > > to_amdgpu_connector(connector);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int max_hdmi_pixel_=
clock =3D
> > > > > > amdgpu_max_hdmi_pixel_clock(adev);
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX check mode ba=
ndwidth */
> > > > > >=20
> > > > > > @@ -1208,10 +1222,13 @@ static enum drm_mode_status
> > > > > > amdgpu_connector_dvi_mode_valid(struct drm_connector
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((amdgpu_connector->connector_object_id
> > > > > > =3D=3D
> > > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (amdgpu_connector->conn=
ector_object_id
> > > > > > =3D=3D
> > > > > > CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (amdgpu_connector->conn=
ector_object_id
> > > > > > =3D=3D
> > > > > > CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn MODE_OK;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (mode->clock >
> > > > > > max_hdmi_pixel_clock)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return MODE_CLOCK_HIGH;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return MODE_OK;
> > > > >=20
> > > > > I don't think it makes sense to limit dual link DVI to the
> > > > > max
> > > > > HDMI
> > > > > clock.=C2=A0 HDMI is single link TMDS.=C2=A0 Other than that, the=
 patch
> > > > > looks
> > > > > good to me.
> > > > >=20
> > > > > Alex
> > > >=20
> > > > Hi Alex,
> > > >=20
> > > > The problem I'm trying to solve here is that on the non-DC
> > > > code, by
> > > > default I get a black screen on DVI-D because the code doesn't
> > > > set
> > > > an
> > > > upper limit on what is actually supported. (And the monitor
> > > > supports
> > > > some modes which won't work.)
> > > >=20
> > > > As far as I see, DC only allows 4K 30 Hz on DVI for the same
> > > > connector
> > > > and DVI/HDMI adapter. That may be wrong, though.
> > > >=20
> > > > What value do you suggest to use?
> > > >=20
> > > > If HDMI =3D single link TMDS, does that mean that a passive
> > > > DVI/HDMI
> > > > adapter cannot take advantage of dual-link DVI?
> > >=20
> > > DVI has a 165 Mhz limit per link so dual link would be 330 Mhz.
> > >=20
> > > Alex
> >=20
> > I see. That's my mistake, I thought that the max_hdmi_pixel_clock
> > as
> > defined in DC is applicable to all TMDS signals, not just HDMI.
> >=20
> > That being said, can you confirm that a DVI/HDMI adapter can indeed
> > use
> > both links of the dual-link DVI?
> >=20
>=20
> DVI to HDMI adapters probably only wire up the a single TMDS link
> because that is all HDMI supports.=C2=A0 HDMI is single link TMDS and it
> was extended beyond 165 Mhz, so most monitors that support HDMI
> support faster single link clocks on DVI as well if they have both
> inputs since it's the same panel.=C2=A0 Older DVI only monitors are
> probably the only ones where the single vs dual link clocks are
> important.
>=20
> Alex

Would it make sense to still use the HDMI clock for DVI-D when the
monitor is a HDMI monitor, ie. display_info.is_hdmi is set? Considering
that in this case we use the HDMI encoder mode.

>=20
> > >=20
> > > >=20
> > > > Thanks,
> > > > Timur
> > > >=20
> > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (connector->display_info.is_hdmi)
> > > > > > {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* HDMI 1.3+ supports max clock of
> > > > > > 340
> > > > > > Mhz
> > > > > > */
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (mode->clock > 340000)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (mode->clock >
> > > > > > max_hdmi_pixel_clock)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return MODE_CLOCK_HIGH;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 else
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return MODE_OK;
> > > > > > --
> > > > > > 2.50.1
> > > > > >=20
