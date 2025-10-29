Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC15CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42E510E719;
	Wed, 29 Oct 2025 08:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvJtoOPX";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3266D10E719
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:07:20 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b7042e50899so79299966b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761725238; x=1762330038; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0OrFXF36VhEXULs+xM5uUkEctAGjAeupmgro1NFT1Yo=;
 b=BvJtoOPXOwR1pJtToAszXCWMAe1w5ZK08wTsAZYORB6Hjeg64+1aT2Pz7uelzrS5nX
 BQycSYfbcB4nPKVhM0qhVGdzR9fZUf9REDMV4BARXnYmzvJbTqs+4EFAT1jGPB7WfClx
 SvkgeKZSM5BoPbtc0wBYwAAG02r1MM3brNff+Ea/nzVyfylq5hjTQl/a5HUQpGy225Oj
 0JsvziakFkmmLWqQvVNmTCMk/GFD7GyUh8d6+q042XXSF5355+CTpdOt2zpJonJMTUwp
 4qAsbD6hm9Ux5H45tpj+bLQ6OzymSMDkFUoFU0WVl2Zo/y1igJDjkztnlC173plsafRP
 +dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725238; x=1762330038;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0OrFXF36VhEXULs+xM5uUkEctAGjAeupmgro1NFT1Yo=;
 b=hvxrcreuh8WGCV1e4ZSyXS3s75ISytv9lSlfjqaA2HwBZkCaNQWZdmVrIwriayPeS8
 7Q76VxUGOJoCQmUpaEl5c8gQjab66sbMhSaJHCnL9D97ytQpIvXj7b7CHDR3F7agOppC
 UMtsshCyuzVOwFh9Z1Ish8bloiEERbPnd2WcvaIsHUXlJj2V/aZUpJdyLkjpTbB5Wzxt
 0lW1180R7bTmSCQ9kT36vBjtB22zVIDRjgBSjq8PTK6RZxdBtJzgew2xljmO4eGCWJfX
 RWLzpgg5L9qsvk4h7GcbT4KhzRedz4xHMKXiHHwuP4xCqZN5P6/ocKBaoU2i7xZ/SMuI
 kWVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7dFbfU2tCQ/dDzOLkEpBuIcKEkDnraFFTSj/dT3Tf3hX/1Hlhqc2lHnQX0mwLPbutX2u9p2oH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHXyqdxVHWBnCE9WRiafWdbdOpCLRg1MFpYsbwtXnt7k/3Z/Lx
 sPnBBp6+yKY54CAHbMp1qsmaHobW3tMd+Nms4QJfvirjJG4ghQRc+0gK
X-Gm-Gg: ASbGnctSQ1W79VtvXfUsb/Rk51iS1Q15d4N5p5XZ+Pex9/Whr9Pkad56ttwukCEwGVb
 /n5KZwDPGYdH/MPG3wOlSwKv+71l8QQ/6iw5OjgbBkt92+AgyCBWwfr/mlqxee3wv6pVWpOfSAE
 IeC6sGU4AnH37othpuON3fHIYsXvDhOlp3xFLOJ9STX2JcLzuNvSrg83gbmA2JbBpM+qnKnfPEg
 T96MOFv+0PhzLgw6Ybn311fhmfC9oU8n4WfKFeIIB9IX5RYb0h9d1Unq85T3+p1J7PQNW7cxffk
 iC8KrJEQayYwKrqU3Yjoscsx42m8lAifQWVhmxjTJFS3xWzt64HpzT7Ba/8E5tOfoxI3+4gI981
 8d6tMo7orZ62g7sMegmRwt1TTAXQg9iYR0B4AEuKoCTTEqeLo+aCrvyEezYSUGMEyMrET9o+p9d
 hWn4hoFmnjQpcF6gLLScSJP2g5A9qCxgQ2dxlwgE5TFiXYhBqyPQmpeLJbo7wfEm82E8iUV93gt
 fNc3cQpHtlLeWh7h1QcPO2smBQueM8SrDlZENMw5uAn
X-Google-Smtp-Source: AGHT+IGr+BqJTX/YCuAukrdVUZgab3ewSbC4v+K7y582bbHHo3kd96iQ76HnIMJ19C31Pl+RQmkkSw==
X-Received: by 2002:a17:907:f496:b0:b33:671:8a58 with SMTP id
 a640c23a62f3a-b703d492fe1mr180805366b.37.1761725238358; 
 Wed, 29 Oct 2025 01:07:18 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853c664asm1345292766b.42.2025.10.29.01.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 01:07:17 -0700 (PDT)
Message-ID: <0756e73047c861ccaa326134e723d09722fe5ccb.camel@gmail.com>
Subject: Re: [PATCH 11/13] drm/amd/display: Fix black screen with HDMI outputs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Ray Wu <ray.wu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung	 <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler	 <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung	 <alex.hung@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>
Date: Wed, 29 Oct 2025 09:07:17 +0100
In-Reply-To: <20251029030935.2785560-12-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
 <20251029030935.2785560-12-ray.wu@amd.com>
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

Hi,

On Wed, 2025-10-29 at 11:02 +0800, Ray Wu wrote:
> From: Alex Hung <alex.hung@amd.com>
>=20
> [Why & How]
> This fixes the black screen issue on certain APUs with HDMI,
> accompanied by the following messages:
>=20
> amdgpu 0000:c4:00.0: amdgpu: [drm] Failed to setup vendor info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 frame on connector DP-1: -=
22
> amdgpu 0000:c4:00.0: [drm] Cannot find any crtc or sizes [drm]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cannot find any crtc or si=
zes
>=20
> Fixes: 99ff9bc57b02 ("drm/amd/display: Fix DVI-D/HDMI adapters")
> Suggested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index c417780f37bc..e8566a5218fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1252,11 +1252,16 @@ static bool detect_link_and_local_sink(struct
> dc_link *link,
> =C2=A0			sink->edid_caps.analog)
> =C2=A0			sink->sink_signal =3D SIGNAL_TYPE_RGB;
> =C2=A0
> +		if (sink->sink_signal !=3D link->connector_signal)
> +			DC_LOG_WARNING("sink_signal (%d) does not
> match connector_signal (%d)\n",
> +					sink->sink_signal, link-
> >connector_signal);
> +


We should not print warnings for things that occur during normal
operation. Warning is incorrect because the different signal type is
normal and expected on certain connectors, for example:

- DVI-I: the signal type may be DVI (dual or single link) or RGB
- DP: the signal type may be DP, DVI or HDMI (for dongles)
- HDMI: the signal type may be HDMI or DVI (without native audio)

My recommendation is the following:
1. Change the warning to a debug message (DC_LOG_DC)
2. Move it a few lines below where the sink_signal is determined.

Thanks & best regards,
Timur

> =C2=A0		/* HDMI-DVI Dongle */
> =C2=A0		if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 !sink->edid_caps.edid_hdmi)
> =C2=A0			sink->sink_signal =3D
> SIGNAL_TYPE_DVI_SINGLE_LINK;
> =C2=A0		else if (dc_is_dvi_signal(sink->sink_signal) &&
> +			 dc_is_dvi_signal(link->connector_signal) &&
> =C2=A0			 aud_support->hdmi_audio_native &&
> =C2=A0			 sink->edid_caps.edid_hdmi)
> =C2=A0			sink->sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
