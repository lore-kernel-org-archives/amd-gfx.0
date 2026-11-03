Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99426606D81E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bT6BHiyf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE5010F551;
	Tue,  3 Nov 2026 11:49:51 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E25E10E759
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 11:49:45 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so3727105e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793706584; x=1794311384; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q+oLP1OEwtePBrYrElNROHr+q71h1tBToe+zpCw5khE=;
 b=bT6BHiyfX8DiJkxRQSDayMKNqMTZUfO8rNhdEuf3yLeo466W95vHZ0RDpXUOcmNLqd
 gj+CCDL/d/zi+lQHDSZrql8qFpnheUMJRLxMVlI947zCaEv3ZZplhFOiDZAarwV8PO29
 9IcO2hg/lG5RuBzC3wRaxlAanv892vNTWrs4fIT133prmi8uew/FHl0k747EVTA+ZEQL
 I5nLZOO1gL2n13HQMo33rpCNPZpV5hkea7EjMyLtU3muEmOSl5nwGazXL5upCrOyvjhw
 eMHEXNbp8uAQ8qqLbBQ0HpyVV/CTH3aKZ7nwLAwRjEs9zRoIef/vU8hbpNdxCnq5FuYX
 w/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706584; x=1794311384;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+oLP1OEwtePBrYrElNROHr+q71h1tBToe+zpCw5khE=;
 b=aWiqfFMbeIGfw8/azZ/uVbUtruckKQ9iA81FM/gOskVeSxF/+XDgNseCbizbLkP1vx
 V7zl50Mpwh+XCUC51kvDVyPMVJvtKO7E9oErSMNjw2txPcJdMlmVQIyf6NuKoo51gIzo
 7j0aDXROpJxhVv5PQSGJwhHmsXUufZqY6Ep+uPVGhh6CFFuKBN9GNecjGKpmf6zWd0zH
 zUqlOpg+Qo00oNFpwy/ckCawZmZaTVSNnE05xxlsEID+s+0u9EfI4ebDrdg0eh+Me7ca
 xZGvjOiuv5xycr9xa3Gpy6V03jRybXSYODphPcqYO0TypBK81gDQLUYzEk57xnXvO/jY
 mgZg==
X-Gm-Message-State: APuU4Z9i+3kczGMQKm00u0xyHU8MOLaJdq4wbehiyB7R1a1Ipm/8t9c1
 SLFGvO/7OXT7ITdAQQd/xPSGPm14X/iqPijKVAv6cMyMD17TUwteDYiA
X-Gm-Gg: AYBFou3R5esWej/uSygVbJuoVdsdYUtMlCSGABqLMaiVdP7n7z3aLIvSM7VnuH8D5b9
 wJvDD4quHNUMB9kazB9Xe08f6s/V5uLPckclCl7xx5IoXvGyJlH27Hd+oWf06Sy7Gb34HWow3sN
 apLInkO8GOzMQYlYW7CQY7v9h3HsVc9TcLIzU+nj1MOOO7Q13XZk1TNApcf4t24SmY6QO9lb5yl
 VDUv4bLfqEfYvdpJ3TVJG+xOJ8XCDMfuHo3RmzNbQh+hUoGfvZa/tv++JXuThp2MJoLNEgAZkXL
 eWyr4XP4l5rNl5mL2BEBY16MyDuAm00F8ZgfWxT046baIbrY1wHi0x++7rJTbkfT/CZi14I/kf8
 RCA+Vm6HWDLSYXkVkVOiM10NSDtsVNt433HMxHwxk7ne282Y9Oc5HmGu7hOFxQNd4wpgrClrsm5
 6cY3l1p3lIeuB6IEgO9rQwNrrx5v4jSMdYEQAFujmFdlKAwXKCJaBXxTHPzSeB+t8v2zmWSR3wo
 epzjgTBBhp/URX6AiUxyLP32b+YEv4uD1aXnJd9C0oF3lwP70g5CGiJqWXkYN/Hes62zcUITE7i
 1RhKBIHmo8fLiCdagKPPfGDn49tZuhMdRANy9t0sUrkWxpVGhxZF1T2n96aURjlBdB/9PT2R8j9
 jQZ2Udb8X
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr309764195e9.13.1793706583552; 
 Tue, 03 Nov 2026 03:49:43 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm446345565e9.1.2026.11.03.03.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:49:43 -0800 (PST)
Message-ID: <be6a9d3074290c030a6dcf9211a02fe690fb5696.camel@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Only enable HDMI audio if display
 supports it
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Panpan Ren <renpanpan@kylinos.cn>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, tzimmermann@suse.de, 
 lijo.lazar@amd.com
Date: Tue, 03 Nov 2026 12:49:42 +0100
In-Reply-To: <20261103061147.25827-1-renpanpan@kylinos.cn>
References: <20261103061147.25827-1-renpanpan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-03 at 14:11 +0800, Panpan Ren wrote:
> From: renpanpan <renpanpan@kylinos.cn>
>=20
> The amdgpu legacy DCE audio path (dce_v6/v8/v10) unconditionally
> calls
> audio_enable(pin, true) at the end of afmt_setmode(), regardless of
> whether the connected display advertises audio support in its EDID.
>=20
> This causes a phantom HDMI audio output to appear for displays that
> have no audio capability (no basic audio bit, no Audio Data Block in
> EDID), because the GPU sets the AUDIO_ENABLED register bit, which
> drives the HDA codec's ELDV pin sense, making the codec report the
> jack as audio-available.
>=20
> The radeon, nouveau, and dw-hdmi drivers all gate audio enablement on
> the display's audio capability. Apply the same check to amdgpu's DCE
> afmt_setmode functions, while still respecting the
> AMDGPU_AUDIO_ENABLE
> override for users who explicitly force audio on.
>=20
> Fixes: e2cdf640cbb5 ("drm/amdgpu: add display controller
> implementation for si v10")
> Cc: stable@vger.kernel.org
> Signed-off-by: renpanpan <renpanpan@kylinos.cn>

Makes sense, thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
> Changes in v3:
> - Also gate the initial audio_enable(pin, false) to avoid touching a
> =C2=A0 potentially shared audio pin when the display has no audio support
>=20
> Changes in v2:
> - Respect AMDGPU_AUDIO_ENABLE override for users who force audio on
> - Add Fixes tag and Cc: stable@vger.kernel.org=C2=A0for stable backport
>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 12 ++++++++----
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=C2=A0 | 12 ++++++++----
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v8_0.c=C2=A0 | 12 ++++++++----
> =C2=A03 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index f2977fe6d824..a8f5eb2394c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1555,9 +1555,11 @@ static void dce_v10_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio prior to setting up hw */
> +	/* disable audio prior to setting up hw, unless the display
> has no audio */
> =C2=A0	dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v10_0_audio_set_dto(encoder, mode->clock);
> =C2=A0
> @@ -1705,8 +1707,10 @@ static void dce_v10_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset,
> 0x00000001);
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset,
> 0x00000001);
> =C2=A0
> -	/* enable audio after to setting up hw */
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index c68de0fe1d7d..3cd9f1bb3a70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1724,8 +1724,10 @@ static void dce_v6_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio before setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> +	/* disable audio before setting up hw, unless the display
> has no audio */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v6_0_audio_set_mute(encoder, true);
> =C2=A0	dce_v6_0_audio_write_speaker_allocation(encoder);
> @@ -1748,8 +1750,10 @@ static void dce_v6_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		dce_v6_0_audio_dp_enable(encoder, 1);
> =C2=A0	}
> =C2=A0
> -	/* enable audio after setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index c3906270f25e..eb1fcf0b39cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1523,9 +1523,11 @@ static void dce_v8_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio prior to setting up hw */
> +	/* disable audio prior to setting up hw, unless the display
> has no audio */
> =C2=A0	dig->afmt->pin =3D dce_v8_0_audio_get_pin(adev);
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v8_0_audio_set_dto(encoder, mode->clock);
> =C2=A0
> @@ -1653,8 +1655,10 @@ static void dce_v8_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
> =C2=A0
> -	/* enable audio after setting up hw */
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
