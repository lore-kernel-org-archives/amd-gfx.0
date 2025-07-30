Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729D7C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 17:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EBE10E0C0;
	Wed, 30 Jul 2025 17:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFkC3vVW";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEEB10E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 17:03:47 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4589b3e3820so238025e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753895026; x=1754499826; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgwE2d9rw7RXrV+FrBRUpInzGqDK6Ag6Y8yZ2IPmgjM=;
 b=fFkC3vVWo5LafnFRPW5mq4+llwCtwNnkXTHHoLVicvK/2t8+yyLzZbIs18buEHa4no
 6cI7XlsFqCAKIgC4vCfLceJ00EqjzNf3Fv9hm/pGPlsU4bFPQVE29oLTNMvD4xx296cu
 Gx6gakqTWwHsmWlIhz3kt63da9espdgR3j4E8LYOJC5uSjjrehhE0tz4WxMlcq8aVz5I
 vUVTwGE4HGxgyUaghbJGrQDSzxzn3dAUVohvrUNE0IQXRbT03N5FtIa/bFdIGUe4k/na
 nDTgzgyO189dn2NzelKDiNUrC7Pj0IuW1/1dx5izWWKTHmLDa4H3XOxWmhOcdQpMqn38
 ZG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895026; x=1754499826;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgwE2d9rw7RXrV+FrBRUpInzGqDK6Ag6Y8yZ2IPmgjM=;
 b=QZDQ4ZTzVXiMt7jD6Es/HULzRH+gSQL+idI680N9d9j+T/Za5CWGXJUr3cbWkVxM3/
 4Fz4yGiM5jOsdDyQRdI2nGaS9VXDdfCCsOXJphfeFTVN+Rrc8r8FUkjh7W71FnURUBzq
 SmD1kbQmQQDA6FIVAOKr8kpXo+59PakTxDO/1RqLSnlBZALNAEOIoX6UnF9qUvTO+R9H
 NDI0YpWKfAm17SbTfNRf9L+hpUvlKxLXizefI6NkVIhJiY8X6dngTvNxoVQK8DFbF8Rf
 bN5w6qWElzLqKKmy5PkEurqwRL9lXL9RMuFrWr58rvY2uGt8ztQC66tr9UHqtOTHgHeb
 nBCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF5I1Hmm/3lugQ3PLEi0/XcDRjFB/Je1TIs5HHP35cqdY8VfA+d9FzV7luXJQfVki1x4Lt3qqV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwlKKTbQWYEHMsBAQZlvxrpoCFj0cQtKKu1llYe9GV6vkmVgE3
 Rj2HT4Ap5KW6qkbKm9zJR/vaNc8WqxTEYIpHjufBOZlbSHfQYt/pNilN
X-Gm-Gg: ASbGncuiz++/vyrMH0XAgwiArLVawgXOHje+6pwhVoQ+lAqK1S6ZZ7hoUcci/UDU7eX
 dG1/fm2PuAOAw5PlTjOvwZB3+XFhWeNG8t+EDTq3biFbLL9zUKQDYJslcqqP36oyWQv8FkLUm9b
 Hv6Md/hCX+XejVXEMalzW4jqcXFH2glDlCJGIztti8mLXUdxqocCwlTRbKLfXfz64jzd4R6Zw4F
 RbdVvAy2GKTWQAK77Q5diNW+8blX6LQVXvObCbzLjo6yVH9RFE+qcnb4DVCChK+ilFt9HBJ/8IN
 f2WfgS5bQqNJL5leZ7FDYRvFvojAI1NOSFJkdNUNA/rpFnwG27eThGQyPgFG6GB5HDNhbk8DQmR
 VWcc5CWMYR/mUhSiaSdW2cXq1rTLUKGHvOU3mUwAqxuhadPvJpTMqcba8dGakMxgPC/A56Y3NX7
 obY9AQgF7DohbsUQyp7ESCKv5xChx9Cdnwyxpb7yMMJ37R6LWTFebSPKbRgBvGi+n0AlxkNRdE
X-Google-Smtp-Source: AGHT+IED5KtvaSzr0e3QDiKyMuv6yss1aNEVlPvTj4iQuZYLxMqyAarAlEVowWhsmtLb7fu7nEVA/g==
X-Received: by 2002:a05:600c:8812:b0:456:2397:817 with SMTP id
 5b1f17b1804b1-458930ecbccmr25181745e9.13.1753895026129; 
 Wed, 30 Jul 2025 10:03:46 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b795e199b6sm3191418f8f.20.2025.07.30.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:03:44 -0700 (PDT)
Message-ID: <54dd7186188f0deaf07570c16f5b3c3b9b263cc9.camel@gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type
 more accurately
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 19:03:43 +0200
In-Reply-To: <a2c6a809-183e-443e-b10f-a271c0e89058@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
 <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
 <a2c6a809-183e-443e-b10f-a271c0e89058@amd.com>
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

On Wed, 2025-07-30 at 10:30 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-30 03:40, Timur Krist=C3=B3f wrote:
> > On Tue, 2025-07-29 at 14:03 -0400, Harry Wentland wrote:
> > >=20
> > >=20
> > > On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:
> > > > Previously, DC determined the DRM connector type based on the
> > > > signal type, which becomes problematic when a connector may
> > > > support different signal types, such as DVI-I.
> > > >=20
> > > > With this patch, it is now determined according to the actual
> > > > connector type in DC, meaning it can now distinguish between
> > > > DVI-D and DVI-I connectors.
> > > >=20
> > > > A subsequent commit will enable polling for these connectors.
> > > >=20
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28
> > > > +++++++++++----
> > > > ----
> > > > =C2=A01 file changed, 16 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > index 096b23ad4845..c347b232ae06 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > @@ -8038,24 +8038,26 @@ static int
> > > > dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state
> > > > *state,
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > -static int to_drm_connector_type(enum signal_type st)
> > > > +static int to_drm_connector_type(uint32_t connector_id)
> > > > =C2=A0{
> > > > -	switch (st) {
> > > > -	case SIGNAL_TYPE_HDMI_TYPE_A:
> > > > +	switch (connector_id) {
> > > > +	case CONNECTOR_ID_HDMI_TYPE_A:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_HDMIA;
> > > > -	case SIGNAL_TYPE_EDP:
> > > > +	case CONNECTOR_ID_EDP:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_eDP;
> > > > -	case SIGNAL_TYPE_LVDS:
> > > > +	case CONNECTOR_ID_LVDS:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_LVDS;
> > > > -	case SIGNAL_TYPE_RGB:
> > > > +	case CONNECTOR_ID_VGA:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_VGA;
> > > > -	case SIGNAL_TYPE_DISPLAY_PORT:
> > > > -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> > > > +	case CONNECTOR_ID_DISPLAY_PORT:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_DisplayPort;
> > > > -	case SIGNAL_TYPE_DVI_DUAL_LINK:
> > > > -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> > > > +	case CONNECTOR_ID_SINGLE_LINK_DVID:
> > > > +	case CONNECTOR_ID_DUAL_LINK_DVID:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_DVID;
> > > > -	case SIGNAL_TYPE_VIRTUAL:
> > > > +	case CONNECTOR_ID_SINGLE_LINK_DVII:
> > > > +	case CONNECTOR_ID_DUAL_LINK_DVII:
> > > > +		return DRM_MODE_CONNECTOR_DVII;
> > > > +	case CONNECTOR_ID_VIRTUAL:
> > > > =C2=A0		return DRM_MODE_CONNECTOR_VIRTUAL;
> > > > =C2=A0
> > > > =C2=A0	default:
> > > > @@ -8440,6 +8442,8 @@ void
> > > > amdgpu_dm_connector_init_helper(struct
> > > > amdgpu_display_manager *dm,
> > > > =C2=A0			link->link_enc-
> > > > > features.dp_ycbcr420_supported ? true : false;
> > > > =C2=A0		break;
> > > > =C2=A0	case DRM_MODE_CONNECTOR_DVID:
> > > > +	case DRM_MODE_CONNECTOR_DVII:
> > > > +	case DRM_MODE_CONNECTOR_VGA:
> > >=20
> > > This seems unrelated and would do better in a separate patch.
> > >=20
> > > Harry
> >=20
> > Keep in mind that currently DC recognizes DVI-I as DVI-D, but after
> > this patch they will be recognized correctly as DVI-I. So without
> > this
> > part, the patch will regress the hotplug capability of those ports.
> >=20
>=20
> How will it regress when your patch series introduces analog support?
> Without that there shouldn't be DVII or VGA connectors.
>=20
> Harry

DVI-I can carry either an analog or a digital signal.

Before this patch, the DVI-I ports were recognized by DRM as
DRM_MODE_CONNECTOR_DVID and their digital part was already working.
That means you can plug in a digital DVI cable in a DVI-I port and it
will work today.

After this patch they will be recognized as DRM_MODE_CONNECTOR_DVII
instead, so in order to keep the same behaviour as before and avoid
regressing the digital part, we need to set DRM_CONNECTOR_POLL_HPD, and
in order to do that we need to add DRM_MODE_CONNECTOR_DVII to this
switch statement.

That being said, I can move this hunk to a separate patch before this
one. That way there is going to be no regression and this patch stays
simpler.

Does that sound ok to you?

Timur

>=20
> > That said, sure, I can move this part to a separate commit before
> > this
> > one, if you prefer.
> >=20
> > Timur
> >=20
> > >=20
> > > > =C2=A0		aconnector->base.polled =3D
> > > > DRM_CONNECTOR_POLL_HPD;
> > > > =C2=A0		break;
> > > > =C2=A0	default:
> > > > @@ -8631,7 +8635,7 @@ static int
> > > > amdgpu_dm_connector_init(struct
> > > > amdgpu_display_manager *dm,
> > > > =C2=A0		goto out_free;
> > > > =C2=A0	}
> > > > =C2=A0
> > > > -	connector_type =3D to_drm_connector_type(link-
> > > > > connector_signal);
> > > > +	connector_type =3D to_drm_connector_type(link-
> > > > >link_id.id);
> > > > =C2=A0
> > > > =C2=A0	res =3D drm_connector_init_with_ddc(
> > > > =C2=A0			dm->ddev,
