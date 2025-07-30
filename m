Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDFC87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 07:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1785D10E078;
	Wed, 30 Jul 2025 07:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hW/AkFQZ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3182010E41B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 07:40:37 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4561607166aso3675865e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753861236; x=1754466036; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjzwSGQ7KvLMFxqNNCt98j7LHzaqcDg9LLSZJ+YJ5ds=;
 b=hW/AkFQZ6XveFjhpansj4i6JSYxIA2jW6Hj8JP2C3yeBbBhb2MO+4FrUM087AEJHeL
 9RqNb2XTwZQVcA0/BpRxCBPKOLeqYtkjIKLtoVPNSoGZlWciid1l8zG8EqpsBRID4gqp
 Vete5TO4e0DqVbMV8Gv33an0+zf5f1nAjC5K0coMLNPG9ELHNZnt6HNUUkwDR87DBpgC
 H+6TYb6dDbqQBBe/6HvaiFqeSLfrFOSpk/3vVBXNYqgJ52VmsHbxcvmmmZ8s19ru1Dwl
 SWvLBzrPTlwTxfyEkCMgACY73xAOrZeSAQhf6Vynu/qqwnRDGOzBClaeR/v2rdXXE8v8
 KyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753861236; x=1754466036;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PjzwSGQ7KvLMFxqNNCt98j7LHzaqcDg9LLSZJ+YJ5ds=;
 b=Kut5cwcW8b9HM1EMIhA80KPfIJvvegqY57p6Ru8DcdGHrbkeP0gjzKsmnXXpUtxfhO
 ni/F7L+Zo8cTQiOF9ueGfr5u50VqiaszxmSEr3qiwr/gxOg0CDO7uPeSjZGV0qDAJWhD
 o2u62Q1hqqQ+rRwrkXfv2JIc38rkAUuB2B2PyRLf60U/+xKhKHrUKkJ8VVNctmivW9PO
 B6OJUfUgIAtZs/HuctbFXEtaty/DAEEDEb9pd2k2BKhZWyim84OiHHSbJcX5XKJFDsqQ
 sMhLejWk6N6z82f604Qy7r3DzCUk4sXowZMGJ7ObW8Oe0KonBDL3+FoioUgwGI9w7pZn
 OoLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBUJi6ww/fGi6bOCVQMwPtbKO6Jat8Fj9qHVllMlRIAwmj0FVvzC3tbPACKsaV681AJxHgxRq5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHTRhu6Y5818nwjEJ1IQd8q40B2Sh91yjIsdhTd19nvLHn2a3Q
 9WmFysWoAHgy1Qa7qaoBcYIBnqcvRCRrZrnfdq1SmthiaI10hPI+REf4
X-Gm-Gg: ASbGncsEzIEtWfBOVjOH6nYJ2SyfmLLBusl/WWkfA1ix8hqTMmNNec4Wqu+W0C91BTi
 57NQ0zlcwfJJuELBCZMggCyyu+OZzI9txXSs1VaRsrlnUTrVo39eyhy4DjuW+kBdcspZ5molF9S
 t+OCR/LSfRUzdHh+ZujW7YJgDR3IlP9H0Kyt6dlpzW1lrh+YoznNMwcj+u3k+DicqYzsvvDu3MT
 jRN0sQz1cM29Bc25oIE5qO0h7yJxyr2E28q4SdZqiOR/fslm3a4xCIJqOonRzzAL3vcNPBfhH+j
 Oc9Rw2Eq9172UPM3HBlRfpgPJYHh1zHclNTqW4X+enBGH8Iop7FrY8wjJ+/VNYbQVX8/ksI6j7m
 5CWw/2hq+ocSM+isIv16hz/Fz9/7dM98pgAejrlIqxjzrTrpAb6rmyGWriDt7ca9Pn8hKW+mWVD
 HKh5dnitbHa6t/SuvDdpMe/g6uXLEPbPP/T6e5zhMHYfbjevdDt17ic5xnZBAIXw==
X-Google-Smtp-Source: AGHT+IFFfmTdKmvd4y/HIADMOh/qp4rBV82Qs3tqJkhCi4bXtEVOp9W2iQxLaXmoqe1u046EUelW+A==
X-Received: by 2002:a5d:5f90:0:b0:3b7:8d6f:9fe2 with SMTP id
 ffacd0b85a97d-3b794fed8f0mr1463133f8f.23.1753861235411; 
 Wed, 30 Jul 2025 00:40:35 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78404f5b0sm11468647f8f.41.2025.07.30.00.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 00:40:34 -0700 (PDT)
Message-ID: <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type
 more accurately
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 09:40:34 +0200
In-Reply-To: <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
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

On Tue, 2025-07-29 at 14:03 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:
> > Previously, DC determined the DRM connector type based on the
> > signal type, which becomes problematic when a connector may
> > support different signal types, such as DVI-I.
> >=20
> > With this patch, it is now determined according to the actual
> > connector type in DC, meaning it can now distinguish between
> > DVI-D and DVI-I connectors.
> >=20
> > A subsequent commit will enable polling for these connectors.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++---=
-
> > ----
> > =C2=A01 file changed, 16 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 096b23ad4845..c347b232ae06 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8038,24 +8038,26 @@ static int
> > dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -static int to_drm_connector_type(enum signal_type st)
> > +static int to_drm_connector_type(uint32_t connector_id)
> > =C2=A0{
> > -	switch (st) {
> > -	case SIGNAL_TYPE_HDMI_TYPE_A:
> > +	switch (connector_id) {
> > +	case CONNECTOR_ID_HDMI_TYPE_A:
> > =C2=A0		return DRM_MODE_CONNECTOR_HDMIA;
> > -	case SIGNAL_TYPE_EDP:
> > +	case CONNECTOR_ID_EDP:
> > =C2=A0		return DRM_MODE_CONNECTOR_eDP;
> > -	case SIGNAL_TYPE_LVDS:
> > +	case CONNECTOR_ID_LVDS:
> > =C2=A0		return DRM_MODE_CONNECTOR_LVDS;
> > -	case SIGNAL_TYPE_RGB:
> > +	case CONNECTOR_ID_VGA:
> > =C2=A0		return DRM_MODE_CONNECTOR_VGA;
> > -	case SIGNAL_TYPE_DISPLAY_PORT:
> > -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> > +	case CONNECTOR_ID_DISPLAY_PORT:
> > =C2=A0		return DRM_MODE_CONNECTOR_DisplayPort;
> > -	case SIGNAL_TYPE_DVI_DUAL_LINK:
> > -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> > +	case CONNECTOR_ID_SINGLE_LINK_DVID:
> > +	case CONNECTOR_ID_DUAL_LINK_DVID:
> > =C2=A0		return DRM_MODE_CONNECTOR_DVID;
> > -	case SIGNAL_TYPE_VIRTUAL:
> > +	case CONNECTOR_ID_SINGLE_LINK_DVII:
> > +	case CONNECTOR_ID_DUAL_LINK_DVII:
> > +		return DRM_MODE_CONNECTOR_DVII;
> > +	case CONNECTOR_ID_VIRTUAL:
> > =C2=A0		return DRM_MODE_CONNECTOR_VIRTUAL;
> > =C2=A0
> > =C2=A0	default:
> > @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct
> > amdgpu_display_manager *dm,
> > =C2=A0			link->link_enc-
> > >features.dp_ycbcr420_supported ? true : false;
> > =C2=A0		break;
> > =C2=A0	case DRM_MODE_CONNECTOR_DVID:
> > +	case DRM_MODE_CONNECTOR_DVII:
> > +	case DRM_MODE_CONNECTOR_VGA:
>=20
> This seems unrelated and would do better in a separate patch.
>=20
> Harry

Keep in mind that currently DC recognizes DVI-I as DVI-D, but after
this patch they will be recognized correctly as DVI-I. So without this
part, the patch will regress the hotplug capability of those ports.

That said, sure, I can move this part to a separate commit before this
one, if you prefer.

Timur

>=20
> > =C2=A0		aconnector->base.polled =3D DRM_CONNECTOR_POLL_HPD;
> > =C2=A0		break;
> > =C2=A0	default:
> > @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct
> > amdgpu_display_manager *dm,
> > =C2=A0		goto out_free;
> > =C2=A0	}
> > =C2=A0
> > -	connector_type =3D to_drm_connector_type(link-
> > >connector_signal);
> > +	connector_type =3D to_drm_connector_type(link->link_id.id);
> > =C2=A0
> > =C2=A0	res =3D drm_connector_init_with_ddc(
> > =C2=A0			dm->ddev,
