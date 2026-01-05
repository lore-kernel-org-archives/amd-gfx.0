Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CABC47BC8
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769B210E4AB;
	Tue,  6 Jan 2026 08:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qc55tR0O";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE7C10E413
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:30:59 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb95009so47383a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767645058; x=1768249858; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hVECE95AM8EQn11Eu+Wr1AoXJjdignGWqzA0rD5sR/g=;
 b=Qc55tR0OvuWG3l1ivg7U4MifO2GI2tJMqKMLTgfwwbEC/YuLSzTuL1VvWieLccZZMq
 iDQnwIkRFw/SHGHu6wzqe/zkdyPnWscRk3zLV7AnxYZoBYCE0AtxIU5L+w7VBQ8E7zdr
 32kcaxP2awRx2s3mPZCC9ySt3FPvL6stbpizBA6xkWDdWhgX7NzW3UNBvamSdYhCfenz
 p3SKXRTuWeW1K4hnUWy9LVbXHvOfNlEXalE8L/8wpG/8b8x912SY9bg2yOTCU3DyLayB
 LgGwCKpWX0vE2zbGdUcb8D1AgXeZq+OAZ8CcPvqHakR7xj59Pwju31VfPDCRE2MTNfPK
 nmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767645058; x=1768249858;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hVECE95AM8EQn11Eu+Wr1AoXJjdignGWqzA0rD5sR/g=;
 b=Fn1KPqtX7cJZYGFScRioHVPz8K/Y/HTqGFJuZ8cElXoJyry4XuwW4hf7+DzTb9/cj/
 lGZ1Y7BOCVG9GxT+bVnSOJIJGqrlCgSpgaBVafQFWH63Ll2aOKPhNQFxGbQOhn8YhIFN
 /cc0ZAiXRrtcdOViAyXl5/sfHrbG74UpdaxXLpzDfgTS68Zc/sWyrGGEn1liM0LpXxhK
 ME2DxM/tN5eOQ6mv5k4+smDKNkLgUQKRRF6T8VlfiPwf1T6zTHd3mwvRIkGim1XtoVj7
 9H1xoKl3arxr9GYWf7wu2vFxpDki69ddHTGEupI7g+drMuu1SrIAoUirPb3Idusdv/J7
 ZrvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBy5WDe0JohRejWRZFmay1Ft+Qh2FOydt9/wyMs6SoEfCqZ/CM1r9lnD2PYe9qG8aHj/yDHE3I@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw7wbHQU3TlEPY5qATxnpody3PZ4Me+WZpzRcR44+I5VNSXFzI
 94sQl8f3AEoX3ZD8Xrp5fG4DvE5m69NhLH3mJyRxFeRNV9tJJX5WybgX
X-Gm-Gg: AY/fxX6j69euV+RjLr7HqHsaEE2nQzMp6HjNjwZVTXWtjzh3SSCxD6jt0G/xBCq5SJp
 6sQjIndfTBoExbAP3pQQHci198+DfE9wkJ0gA7R+tvAFJ0+reiu/OtHQOLvds/10TeTjiYqdtIi
 SyZbT2FPCGqHsTgNWPDpGUrR+JyFupqWjlJlo1IQWfJv6RIw/+4ejt+UCdFQzRmU7F1wPJEAWtz
 qyGHX6deKhfPbpM+yw+9rFViPw4Pc2lNOV3C5ejURwGuWRkTbS8Cd9ACq3dEyCnXLiSLsI17G/x
 l3aWy93BLNPzsDISC8oCT3DU8DrMsegKmToZrnpy4STTwPxwboKVFC6SyA1S8vn3uX14UtIsPw4
 sXf0As+oBUEy/h+jO/oMFoniDz0Jo3584MgsagZtG59ocg6HbK5exiNbo3qSFhs4wdYIIYDXabx
 GAUNa/XxLBKTO3GbwsBbyCkZvOWJ+FnDF0hQCWS0qoTqWyvEaElFWCY388vpZYazxIvcmKTO0=
X-Google-Smtp-Source: AGHT+IEebwiWuXl1F8QHnnykIpu9467Snh7tcDDZiJH8az6WUjwWW9mBHxH2ppJZkdF+bHqj2P8QOA==
X-Received: by 2002:a05:6402:3513:b0:640:abd5:8646 with SMTP id
 4fb4d7f45d1cf-6507955d2abmr365284a12.4.1767645057730; 
 Mon, 05 Jan 2026 12:30:57 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d31e7sm22291166b.42.2026.01.05.12.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:30:57 -0800 (PST)
Message-ID: <9213ab090c4aab1bdd134857d3f5a88cff505fc6.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add VRR support for MST connectors
From: tomasz.pakula.oficjalny@gmail.com
To: =?UTF-8?Q?Micha=C5=82_Bie=C5=82aga?= <mbielaga1@gmail.com>, 
 amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, 	siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Date: Mon, 05 Jan 2026 21:30:56 +0100
In-Reply-To: <20251103100845.12802-1-michal.bielaga@deliveroo.com>
References: <20251103100845.12802-1-michal.bielaga@deliveroo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 06 Jan 2026 08:31:34 +0000
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

On Mon, 2025-11-03 at 11:08 +0100, Micha=C5=82 Bie=C5=82aga wrote:
> From: Michal Bielaga <mbielaga1@gmail.com>
>=20
> Variable Refresh Rate (VRR/FreeSync) currently only works with
> Single-Stream Transport (SST) DisplayPort connections. Monitors
> connected via MST hubs cannot utilize VRR even when they support it,
> because the driver only enables VRR for SST connections.
>=20
> This patch enables VRR for DisplayPort MST by:
> - Including SIGNAL_TYPE_DISPLAY_PORT_MST in VRR capability detection
> - Reading VRR range from display EDID instead of MST hub DPCD, since
>   dc_link points to the hub rather than the actual display
> - Fixing call order to parse EDID before checking VRR capabilities,
>   ensuring display_info.monitor_range is populated
> - Properly attaching VRR property to MST connectors by reusing the
>   master connector's property
>=20
> Without this patch, MST displays cannot use VRR even if they support
> it, limiting the user experience for multi-monitor DisplayPort MST
> setups.
>=20
> Signed-off-by: Michal Bielaga <mbielaga1@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 11 +++++++++--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   |  9 ++++++---
>  2 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ef026143dc1c..ac5b6c22361f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12644,9 +12644,16 @@ void amdgpu_dm_update_freesync_caps(struct drm_c=
onnector *connector,
>  		parse_edid_displayid_vrr(connector, edid);
> =20
>  	if (edid && (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> +		     sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST ||
>  		     sink->sink_signal =3D=3D SIGNAL_TYPE_EDP)) {
> -		if (amdgpu_dm_connector->dc_link &&
> -		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_p=
aram) {
> +		/* For MST, check monitor range from EDID directly since the dc_link
> +		 * points to the MST hub, not the actual display
> +		 */
> +		if ((sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST ||
> +		     (amdgpu_dm_connector->dc_link &&
> +		      amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing=
_param)) &&
> +		    connector->display_info.monitor_range.min_vfreq &&
> +		    connector->display_info.monitor_range.max_vfreq) {
>  			amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ra=
nge.min_vfreq;
>  			amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ra=
nge.max_vfreq;
>  			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq >=
 10)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 77a9d2c7d318..062259514b3c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -443,6 +443,9 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>  			}
>  		}
> =20
> +		/* Update connector with EDID first so display_info.monitor_range is p=
opulated */
> +		drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
> +
>  		if (aconnector->dc_sink) {
>  			amdgpu_dm_update_freesync_caps(
>  					connector, aconnector->drm_edid);
> @@ -459,8 +462,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>  		}
>  	}
> =20
> -	drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
> -
>  	ret =3D drm_edid_connector_add_modes(connector);
> =20
>  	return ret;
> @@ -650,9 +651,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_m=
gr *mgr,
>  	if (connector->max_bpc_property)
>  		drm_connector_attach_max_bpc_property(connector, 8, 16);
> =20
> +	/* Reuse VRR property from master connector for MST connectors */
>  	connector->vrr_capable_property =3D master->base.vrr_capable_property;
>  	if (connector->vrr_capable_property)
> -		drm_connector_attach_vrr_capable_property(connector);
> +		drm_object_attach_property(&connector->base,
> +					   connector->vrr_capable_property, 0);
> =20
>  	drm_object_attach_property(
>  		&connector->base,

This doesn't consider if the connected MST device actually supports VRR
pass-through. Unfortunately, this basically breaks display out with my
Thinkpad Universal USB-C dock if VRR is ever toggled. It just can't do
variable signal and immediately drops out.

In current state, this patch sadly breaks more things than it fixes.
