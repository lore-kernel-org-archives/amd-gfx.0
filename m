Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E71CFD316
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Nov 2025 21:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A23310E163;
	Sun, 23 Nov 2025 21:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f78KftMz";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230DF10E163
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Nov 2025 21:55:05 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so20548495e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Nov 2025 13:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763934903; x=1764539703; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8KyQFF/BWq7Asr4z+IuAgSSUVB3pRSTDJ5HbnIiehsk=;
 b=f78KftMzWwaMFCNeObO6/rFLPSJywtfNkhVas5w+W5Ag0S63GGaHTQFo6HksEUFAYt
 IoFn/5vaWm9UPCb34fCf9SFPj4kWDc+E+653SByd1d/KZvTQfOsqXrpeCfb513+/kHmK
 uTB+qrXdzoSXo6pjMrHfN6ZgCTfin/umQg633RvoWTytZBBW2nXxS1KkFO/F4/iSLXap
 E+rg6nbPEUAw+fXTNXZ43DjojqgQM+m1VEWBbVNxD/8tm4aMGLj4a+AaUKDc9khdG8tG
 cg0Ntw0d21kcG4A59Aub5hyz1IPiVSwmK6/YazVrjpqCsYvGM6RLMMr7shBfYab7ZWBi
 SGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763934903; x=1764539703;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KyQFF/BWq7Asr4z+IuAgSSUVB3pRSTDJ5HbnIiehsk=;
 b=wlzk4FM0b0pe+Qbakv5TA8MKv843oya2EU99h8+NVA9qKX4878/rfb98pNdWO7/0Mx
 nBY1Nzn8uPn8+Ojxr1kzwb7QuCU7cteTbsjK/lsMt+csu9XKrZgtEpJ07Rv+PbKhdzbl
 ZWvd0Msuxzi9Xx9Vwd0zRYR9VeGNs/5oCtIIr620NWJXHK68KmMJJaYepNcsVhH6qY6Y
 XPg9INpvvwEUvMl8LJTWhUAIvRvQWyyCd53Dr7KgufR0Z4tgGhakIRpnHZ/NLgEMMspO
 ioo5xffVwoyrFbNfejaHvIUhZmjquB2NQca7y4vYJ3T73FmirhCN/paP3MIoRw4yOS8M
 vdKA==
X-Gm-Message-State: AOJu0YzD5QtVkaZy9xUr3I3akeOAHzleyOHPn3yKNp9jZyn46RcG5NBj
 M35i9K08j+8oBGWbyadM2mPBU5yA7hpFDeJrcBAoM/xL1Ue2i4fINOzk
X-Gm-Gg: ASbGncvOya2v1+p1WkP5vf+PDKCUn8Q5FhHkCE0mGZCJwgKRbZjRqgaG+mMb9HoOw2X
 677B2Ez3yoJtmQdE6DDfDeqSbWa2AbiFZ7uX9TUGQ7XCqJA0VpXOmvCeVuuSZbMUDdfY+GjSmFc
 qvMx9b46E/7eLVfP36dXAKg//5yXs2s0PBsNT1d2gUKcb5Rf0fThLfYiHoevxnU7f4lORVfCwj/
 lj+Q5asT1yp0z4iRi4Awj/RNqo22UVHjZF8MfbAfgr9TmaIlzzpykUaM3cd3cA0vOf2B7hJaJTj
 qDvnvQ+4dVQfMh9KGqz7mU+jBhrbklH9pP7HS/lPKPHqLinp8k50S+lrGgeXHJE7SVeW1FlY43R
 3pzkDlOejl6vRqa85cdcHjoUqHNfeMDQZ41vXY9NH7K3sBfg2hFUKouk5XfzLI/BKB0ZIUnpxDk
 Yg5jua5CjdHwlTaFoksUDs7o05Nsi0dPPvpJpcJAhhgTVjUkFLgUovxaizCdlfHDnrTk3n1HYZL
 CfoCqmdLNxO+rqvbXjCKONwPLAxguQsox3+6JoexXKIwy03jY0ecQE=
X-Google-Smtp-Source: AGHT+IFOog6DFXpznn1+mdSSVtdv/Mtbvoesf+tqA88TIxa8E8n7KvQDS72L9iGy7IDzRJWdIFw24g==
X-Received: by 2002:a05:600c:5253:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-477c01bf726mr74484285e9.25.1763934903354; 
 Sun, 23 Nov 2025 13:55:03 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24d8:e600:9a36:ae52:51a2:f002?
 (20014C4E24D8E6009A36AE5251A2F002.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:9a36:ae52:51a2:f002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4eb2sm159781765e9.12.2025.11.23.13.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 13:55:02 -0800 (PST)
Message-ID: <dcc5f1f5be517f535087de581860ecfb5a1e2cef.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix dereference-before-check for dc_link
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>, Harry
 Wentland	 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Date: Sun, 23 Nov 2025 22:55:00 +0100
In-Reply-To: <20251121150247.181583-1-srinivasan.shanmugam@amd.com>
References: <20251121150247.181583-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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

On Fri, 2025-11-21 at 20:32 +0530, Srinivasan Shanmugam wrote:
> The function dereferences amdgpu_dm_connector->dc_link early to
> initialize verified_link_cap and dc, but later still checks
> amdgpu_dm_connector->dc_link for NULL in the analog path.
>=20
> This late NULL check is redundant, introduce a local dc_link pointer,
> use it consistently, and drop the superfluous NULL check while using
> dc_link->link_id.id instead.
>=20
> The function uses dc_link at the very beginning without checking if
> it
> is NULL.=C2=A0 But later in the code, it suddenly checks if dc_link is
> NULL.
>=20
> This check is too late to be useful, because the code has already
> used
> dc_link earlier.=C2=A0 So this NULL check does nothing.
>=20
> We simplify the code by storing amdgpu_dm_connector->dc_link in a
> local
> dc_link variable and using it throughout the function.=C2=A0 Since dc_lin=
k
> is
> already dereferenced early, the later NULL check is unnecessary and
> is
> removed.
>=20
> Fixes the below:
> =C2=A0 amdgpu_dm_connector_get_modes():
> =C2=A0 variable dereferenced before check 'amdgpu_dm_connector->dc_link'
>=20
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
> =C2=A0 8845				&amdgpu_dm_connector->dc_link-
> >verified_link_cap;
> =C2=A0 8846		const struct dc *dc =3D amdgpu_dm_connector->dc_link-
> >dc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Dereference
> =C2=A0 ...
>=20
> =C2=A0 8856
> =C2=A0 8857			if (amdgpu_dm_connector->dc_sink &&
> =C2=A0 8858			=C2=A0=C2=A0=C2=A0 amdgpu_dm_connector->dc_link &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Checked too late.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Presumably this NULL check could be
> removed?
> =C2=A0 ...
>=20
> Fixes: c8f52ca2cefb ("drm/amd/display: Cleanup uses of the analog
> flag")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Nice catch!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
> =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8a0555365719..6eb88a96cc33 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8818,11 +8818,11 @@ static int
> amdgpu_dm_connector_get_modes(struct drm_connector *connector)
> =C2=A0{
> =C2=A0	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
> =C2=A0			to_amdgpu_dm_connector(connector);
> +	struct dc_link *dc_link =3D amdgpu_dm_connector->dc_link;
> =C2=A0	struct drm_encoder *encoder;
> =C2=A0	const struct drm_edid *drm_edid =3D amdgpu_dm_connector-
> >drm_edid;
> -	struct dc_link_settings *verified_link_cap =3D
> -			&amdgpu_dm_connector->dc_link-
> >verified_link_cap;
> -	const struct dc *dc =3D amdgpu_dm_connector->dc_link->dc;
> +	struct dc_link_settings *verified_link_cap =3D &dc_link-
> >verified_link_cap;
> +	const struct dc *dc =3D dc_link->dc;
> =C2=A0
> =C2=A0	encoder =3D amdgpu_dm_connector_to_encoder(connector);
> =C2=A0
> @@ -8834,9 +8834,8 @@ static int amdgpu_dm_connector_get_modes(struct
> drm_connector *connector)
> =C2=A0				drm_add_modes_noedid(connector,
> 1920, 1080);
> =C2=A0
> =C2=A0		if (amdgpu_dm_connector->dc_sink &&
> -		=C2=A0=C2=A0=C2=A0 amdgpu_dm_connector->dc_link &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 amdgpu_dm_connector->dc_sink->edid_caps.analog
> &&
> -		=C2=A0=C2=A0=C2=A0
> dc_connector_supports_analog(amdgpu_dm_connector->dc_link-
> >link_id.id)) {
> +		=C2=A0=C2=A0=C2=A0 dc_connector_supports_analog(dc_link-
> >link_id.id)) {
> =C2=A0			/* Analog monitor connected by DAC load
> detection.
> =C2=A0			 * Add common modes. It will be up to the
> user to select one that works.
> =C2=A0			 */
