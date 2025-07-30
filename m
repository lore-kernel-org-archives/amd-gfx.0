Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760D1C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 18:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1289B10E383;
	Wed, 30 Jul 2025 18:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wkiz5JHN";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A9C10E226
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 18:19:16 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so63271f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753899555; x=1754504355; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9RtY61TnLHGulcg2rwyxoN2sER35a+Ek0l9CoBI5D8=;
 b=Wkiz5JHNaucL+hI9eg+x/rcD0tbYhmMaKuGis7mCFa8w2j/23T3TT4n+M/indxBrOz
 xZ8gzszW/q8vsaj2CssYFSHdjG8X+lt9diLXxRyTx/KNzScVVQenxNJb825K941hSd8b
 XUQpywxwq4yL9jm4UEODPWy8tjqLaSzdoVLCEvQmKf0aNZWL/TIN6C+Qo/tn2qlbpTB4
 AFPMSCYr8w7PMS2Hb5Gv8uJPU8GSW1tyvkhuPo5CJmMgnnEFUEVlreRzJ7TBqnUGsKoy
 sbG+sKH094f+v41Ltr8bjuEF8EdkVyWB8pen7zO0y9nJ1M+TBi7z4ZRyq345FKedV3LK
 ZWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753899555; x=1754504355;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9RtY61TnLHGulcg2rwyxoN2sER35a+Ek0l9CoBI5D8=;
 b=wbsHwP1CgWkh7WgPQNnb1cUrs4/fcvsTguRZMNU7I1tL+uZM5xD2CSMr+xAv9hWs7p
 22a1dgreOEKuJb5p6D0x7EY4mmDeGnPfwa2ArdNOfOJDKoa3rU1/VFY8IdPT30noYxZt
 0jpES9wrb7fA9Vayf90/LupRRNyxzvRy6YAJVZkFkXySAP8zkDe3h6alW+xnnnV2i8Rr
 2A3r/tDGIziU8v2aZP3xwxnlDqXN5Sa86WwSCKDO+34T8j2lKfwUMvWly+d0z463kwyZ
 F2qBw1l0ivi8YXYDJnh8Gwnqz27Ztx6K5dEuZyv/c15tSOirm4OehX0Lzsn6YW8dP+Ar
 qEhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4SNG+pkSBb+bT1mywitJ0f0EyuPX2ZlhvNfr669YZ4Gu9lVxsvPAOuorrPwOwDt0sVT1A3VXW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxUaDnovqDfonmxIN+CVfFlWkUGVpXeUTog45MzApj2BZENq9e
 SVzFOLCacCVk+dcPalEJVr61D8M1MOjAk7aCVIvOrEf2Humy4AhKIxC+
X-Gm-Gg: ASbGncv7lOFM4XmLCNZ45KJ3m9YwyhqmoZrnDOkL1tIqsRHJpWzIlwe13RLaUFBRYAC
 kCgE8ko7QzUV2i/uHx824LVE6MR1GcORxh84xBtNn/ZtGMW71xUFWJIrmgCzoOh8KbMPsFRt+5r
 280/qwWGXmv93y92C1zsL54CtzM3d5UZkzwphuIEGqRs3p9sw7NIq7h5CegThslN/zdrLmZDcr8
 yXF9wsfWJffzno99LTcdhKXIZ71zQ+mcBAUVXgKROWmy4VOMyDepSH+kAlcv7dnuB7M1PZgEdYP
 SnQ7sFkULGP6gg6qDhYgPFAnmdLum/FzyDx1+zkzisGqUrLs66472zKfH/ogDbEYVNQVfraEgXY
 VPZxwv7ADkW80QdCYbnTBR1APaAYSoQVMwN2ba0jImRoRL33gFlY0kOmTj6aB5dGVIV+qtBq/Ad
 wWDxO//JNFWZbR8chb0plZLU5Mh2OpHLrgCeznOP5SUAPw0g/HiUsaUvObXkQACw==
X-Google-Smtp-Source: AGHT+IGju4glDSqEp3tRbMNWkAv8QqyGnNm3lERgWIAIcRE9c7HLWmbffd2N25O5FUal9aexvAuDyA==
X-Received: by 2002:a5d:64e5:0:b0:3b7:8b2e:cc5a with SMTP id
 ffacd0b85a97d-3b794ff1e65mr3738174f8f.40.1753899554736; 
 Wed, 30 Jul 2025 11:19:14 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78acd884dsm9467477f8f.33.2025.07.30.11.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 11:19:13 -0700 (PDT)
Message-ID: <c1b1c40e4efb6e7df8ca6f097c649b1ef73ea37b.camel@gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type
 more accurately
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 20:19:13 +0200
In-Reply-To: <f0e92c68-759e-42a4-8f5a-8c49a786985f@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
 <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
 <a2c6a809-183e-443e-b10f-a271c0e89058@amd.com>
 <54dd7186188f0deaf07570c16f5b3c3b9b263cc9.camel@gmail.com>
 <f0e92c68-759e-42a4-8f5a-8c49a786985f@amd.com>
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

On Wed, 2025-07-30 at 13:29 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-30 13:03, Timur Krist=C3=B3f wrote:
> > On Wed, 2025-07-30 at 10:30 -0400, Harry Wentland wrote:
> > >=20
> > >=20
> > > On 2025-07-30 03:40, Timur Krist=C3=B3f wrote:
> > > > On Tue, 2025-07-29 at 14:03 -0400, Harry Wentland wrote:
> > > > >=20
> > > > >=20
> > > > > On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:
> > > > > > Previously, DC determined the DRM connector type based on
> > > > > > the
> > > > > > signal type, which becomes problematic when a connector may
> > > > > > support different signal types, such as DVI-I.
> > > > > >=20
> > > > > > With this patch, it is now determined according to the
> > > > > > actual
> > > > > > connector type in DC, meaning it can now distinguish
> > > > > > between
> > > > > > DVI-D and DVI-I connectors.
> > > > > >=20
> > > > > > A subsequent commit will enable polling for these
> > > > > > connectors.
> > > > > >=20
> > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > ---
> > > > > > =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28
> > > > > > +++++++++++----
> > > > > > ----
> > > > > > =C2=A01 file changed, 16 insertions(+), 12 deletions(-)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > index 096b23ad4845..c347b232ae06 100644
> > > > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > > @@ -8038,24 +8038,26 @@ static int
> > > > > > dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state
> > > > > > *state,
> > > > > > =C2=A0	return 0;
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > -static int to_drm_connector_type(enum signal_type st)
> > > > > > +static int to_drm_connector_type(uint32_t connector_id)
> > > > > > =C2=A0{
> > > > > > -	switch (st) {
> > > > > > -	case SIGNAL_TYPE_HDMI_TYPE_A:
> > > > > > +	switch (connector_id) {
> > > > > > +	case CONNECTOR_ID_HDMI_TYPE_A:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_HDMIA;
> > > > > > -	case SIGNAL_TYPE_EDP:
> > > > > > +	case CONNECTOR_ID_EDP:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_eDP;
> > > > > > -	case SIGNAL_TYPE_LVDS:
> > > > > > +	case CONNECTOR_ID_LVDS:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_LVDS;
> > > > > > -	case SIGNAL_TYPE_RGB:
> > > > > > +	case CONNECTOR_ID_VGA:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_VGA;
> > > > > > -	case SIGNAL_TYPE_DISPLAY_PORT:
> > > > > > -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> > > > > > +	case CONNECTOR_ID_DISPLAY_PORT:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_DisplayPort;
> > > > > > -	case SIGNAL_TYPE_DVI_DUAL_LINK:
> > > > > > -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> > > > > > +	case CONNECTOR_ID_SINGLE_LINK_DVID:
> > > > > > +	case CONNECTOR_ID_DUAL_LINK_DVID:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_DVID;
> > > > > > -	case SIGNAL_TYPE_VIRTUAL:
> > > > > > +	case CONNECTOR_ID_SINGLE_LINK_DVII:
> > > > > > +	case CONNECTOR_ID_DUAL_LINK_DVII:
> > > > > > +		return DRM_MODE_CONNECTOR_DVII;
> > > > > > +	case CONNECTOR_ID_VIRTUAL:
> > > > > > =C2=A0		return DRM_MODE_CONNECTOR_VIRTUAL;
> > > > > > =C2=A0
> > > > > > =C2=A0	default:
> > > > > > @@ -8440,6 +8442,8 @@ void
> > > > > > amdgpu_dm_connector_init_helper(struct
> > > > > > amdgpu_display_manager *dm,
> > > > > > =C2=A0			link->link_enc-
> > > > > > > features.dp_ycbcr420_supported ? true : false;
> > > > > > =C2=A0		break;
> > > > > > =C2=A0	case DRM_MODE_CONNECTOR_DVID:
> > > > > > +	case DRM_MODE_CONNECTOR_DVII:
> > > > > > +	case DRM_MODE_CONNECTOR_VGA:
> > > > >=20
> > > > > This seems unrelated and would do better in a separate patch.
> > > > >=20
> > > > > Harry
> > > >=20
> > > > Keep in mind that currently DC recognizes DVI-I as DVI-D, but
> > > > after
> > > > this patch they will be recognized correctly as DVI-I. So
> > > > without
> > > > this
> > > > part, the patch will regress the hotplug capability of those
> > > > ports.
> > > >=20
> > >=20
> > > How will it regress when your patch series introduces analog
> > > support?
> > > Without that there shouldn't be DVII or VGA connectors.
> > >=20
> > > Harry
> >=20
> > DVI-I can carry either an analog or a digital signal.
> >=20
> > Before this patch, the DVI-I ports were recognized by DRM as
> > DRM_MODE_CONNECTOR_DVID and their digital part was already working.
> > That means you can plug in a digital DVI cable in a DVI-I port and
> > it
> > will work today.
> >=20
> > After this patch they will be recognized as DRM_MODE_CONNECTOR_DVII
> > instead, so in order to keep the same behaviour as before and avoid
> > regressing the digital part, we need to set DRM_CONNECTOR_POLL_HPD,
> > and
> > in order to do that we need to add DRM_MODE_CONNECTOR_DVII to this
> > switch statement.
> >=20
>=20
> Thanks for the explanation. In that case the changes are all related
> and it's probably easier to keep them together.
>=20
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>=20
> Harry

Thank you.

In the next version of the series I'll edit the commit message to make
it clearer why this is necessary.

>=20
> > That being said, I can move this hunk to a separate patch before
> > this
> > one. That way there is going to be no regression and this patch
> > stays
> > simpler.
> >=20
> > Does that sound ok to you?
> >=20
> > Timur
> >=20
> > >=20
> > > > That said, sure, I can move this part to a separate commit
> > > > before
> > > > this
> > > > one, if you prefer.
> > > >=20
> > > > Timur
> > > >=20
> > > > >=20
> > > > > > =C2=A0		aconnector->base.polled =3D
> > > > > > DRM_CONNECTOR_POLL_HPD;
> > > > > > =C2=A0		break;
> > > > > > =C2=A0	default:
> > > > > > @@ -8631,7 +8635,7 @@ static int
> > > > > > amdgpu_dm_connector_init(struct
> > > > > > amdgpu_display_manager *dm,
> > > > > > =C2=A0		goto out_free;
> > > > > > =C2=A0	}
> > > > > > =C2=A0
> > > > > > -	connector_type =3D to_drm_connector_type(link-
> > > > > > > connector_signal);
> > > > > > +	connector_type =3D to_drm_connector_type(link-
> > > > > > > link_id.id);
> > > > > > =C2=A0
> > > > > > =C2=A0	res =3D drm_connector_init_with_ddc(
> > > > > > =C2=A0			dm->ddev,
