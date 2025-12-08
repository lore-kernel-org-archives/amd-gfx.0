Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6F7D3B7F2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748AA10E3F1;
	Mon,  8 Dec 2025 15:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNIEwVAY";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1955F10E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:21:27 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7c7660192b0so3618942a34.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765207286; x=1765812086; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHHNBiEnRsI1Bk5Bu5OH4fwZypMuhTrBFUOUtdi/ukc=;
 b=MNIEwVAYTBxcTPQfwQNfzEmMv2Q7rz/JWXBE7cYyQUk6HELAtQS+tt1nAklWr7PAoq
 y/16r8WLGO79U30fRcHkSxp38qdAzaEAPlfjBU6TMEcBhmvd49uB7i6+m57C3GYGJXIW
 AFT/RxUvzwrG3fdwPAFWCjzOKERt8qaf+5GeVP1cuGVy2GHp3Lz3MqMGJ/23OjP9iNHB
 RXCNU9dBh+fi6khvMYPu4SNRJEzLGCkLDtPX3IntXtpWsvk9auIN/haKoWRmmhrGRxH+
 Srfi83lLKqsAP/AIypz932pIM/5bhGPCDJtCsRDp/VeH1HRJDR4JZ/Xf8POLM/t5JmRi
 xMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765207286; x=1765812086;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHHNBiEnRsI1Bk5Bu5OH4fwZypMuhTrBFUOUtdi/ukc=;
 b=tt4iooEVMhRmGueiYd9i41y8OF1pQzniorc8GkhA9auJMdIKvrltgbewhODBSD7C9R
 pbPHsFmEGwamZ8iIET2IpZy2pGoygo9QrLgRb8rAx8rDFaMQLZIN3HXrwwEiVi+Vurn3
 UeycooEcGmgOuWss1/C1hStmY9fu6fdFK+fLXHHHrLpQFJxK7Y+fZYAu0ZVQdOTuwqLM
 uTJaUjKb/2Dtb8It2hRiCFeKZdQgvig79g+Q49XRCOquHbiRRiecq7U87S0tcL/R1/1R
 9TyxACo+DI8TM/GkgwwEUuyDIoCWf2ZyWn6Hl4QHrds1qKxs7pz9fEWp10CJnUXIuRyg
 UsNw==
X-Gm-Message-State: AOJu0YwZZGDb0VRt8V9+AjxAf7DCTpqnDvw5OIO3Af+C1nDBe/dSNsI0
 1U5WSt9nfjsYzzFOtrV0+rn8DATT0wY78GyqS2uX3RPc3u4x/VS+K6xADuvoYg==
X-Gm-Gg: ASbGncuzetc6e4PY4o2TxMxG1kurnS5ziJI1iezV7XI9U5oK1i7EA5yWvs/BfGGKIl6
 SleW8jOrk9YszKYwfCo1lW+rLbIxO2RFqgwcgJvaZuGK0uXrIPa+j4lubyfs0p85tZ++n/x1W5E
 Hae3jVSTmNNMqVkAPF8nwHS6EwmkLwmShRuPynqX0jut3g3tMq5h9UtrlXKOJk6USH6p9G2ATB1
 KPxoUX6sDP/69mS/sWe39yYJekTkQ2Z4yxxUwDOS6xDbuI8JXwSLe6rmo6YeSVWSYksTDpy0Q8E
 3RLmhsAwqNHuLzFywhJuTwYiOwd/41Y0B+amuIuz5Al439CKU8VG9io/0V11/RjZCnLFhzEhw5H
 +wXyxirpBVsvmj+Y2Dc//0eck7Rbf0RngxAguJO8FySwxAUc1DU/KdN32oQjhtorvtXM/wNxerW
 8puak7/DrDhM/XzoC5EFY=
X-Google-Smtp-Source: AGHT+IEjt2o77p5CT+5evB6vNmKzuLUZRULCu5kh1pR5Fh0Jdor4K8gd9ALw5lvm4TWVKEZa60kgHQ==
X-Received: by 2002:a05:6830:44a3:b0:7c1:12c5:334e with SMTP id
 46e09a7af769-7c970826776mr4418885a34.17.1765207286168; 
 Mon, 08 Dec 2025 07:21:26 -0800 (PST)
Received: from [192.168.2.3] ([189.139.20.240])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acb0565sm10012114a34.24.2025.12.08.07.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:21:25 -0800 (PST)
Message-ID: <dd54ad10dfacf8211231c3981b1bb6730d772708.camel@gmail.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Setup DAC encoder before using it
From: timur.kristof@gmail.com
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, 	siqueira@igalia.com
Date: Mon, 08 Dec 2025 09:21:24 -0600
In-Reply-To: <20251206023106.8875-5-timur.kristof@gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <20251206023106.8875-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
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

On Sat, 2025-12-06 at 03:31 +0100, Timur Krist=C3=B3f wrote:
> Just like for other signal types, call the encoder control
> command in the VBIOS to setup the DAC encoder.
> The DAC doesn't work well without this on some GPUs,
> for example the Radeon HD 7790 needs this.
>=20
> Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog encoders
> (v2)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
> =C2=A0.../amd/display/dc/dce/dce_stream_encoder.c=C2=A0=C2=A0 | 25
> ++++++++++++++++++-
> =C2=A0.../amd/display/dc/inc/hw/stream_encoder.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +++
> =C2=A0.../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 |=C2=A0 4 +++
> =C2=A03 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> index 574618d5d4a4..1fbf6263c235 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> @@ -693,6 +693,24 @@ static void
> dce110_stream_encoder_lvds_set_stream_attribute(
> =C2=A0	ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB);
> =C2=A0}
> =C2=A0
> +static void dce110_stream_encoder_analog_set_stream_attribute(
> +	struct stream_encoder *enc,
> +	struct dc_crtc_timing *crtc_timing)
> +{
> +	struct dce110_stream_encoder *enc110 =3D
> DCE110STRENC_FROM_STRENC(enc);
> +	struct bp_encoder_control cntl =3D {0};
> +
> +	cntl.action =3D ENCODER_CONTROL_SETUP;
> +	cntl.engine_id =3D enc110->base.id;

Found a mistake here.
This should use the analog_id added in the previous patch.

> +	cntl.pixel_clock =3D crtc_timing->pix_clk_100hz / 10;
> +
> +	if (enc110->base.bp->funcs->encoder_control(
> +			enc110->base.bp, &cntl) !=3D BP_RESULT_OK)
> +		return;
> +
> +	ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB);
> +}
> +
> =C2=A0static void dce110_stream_encoder_set_throttled_vcp_size(
> =C2=A0	struct stream_encoder *enc,
> =C2=A0	struct fixed31_32 avg_time_slots_per_mtp)
> @@ -1521,6 +1539,8 @@ static const struct stream_encoder_funcs
> dce110_str_enc_funcs =3D {
> =C2=A0		dce110_stream_encoder_dvi_set_stream_attribute,
> =C2=A0	.lvds_set_stream_attribute =3D
> =C2=A0		dce110_stream_encoder_lvds_set_stream_attribute,
> +	.analog_set_stream_attribute =3D
> +		dce110_stream_encoder_analog_set_stream_attribute,
> =C2=A0	.set_throttled_vcp_size =3D
> =C2=A0		dce110_stream_encoder_set_throttled_vcp_size,
> =C2=A0	.update_hdmi_info_packets =3D
> @@ -1568,7 +1588,10 @@ void dce110_stream_encoder_construct(
> =C2=A0	enc110->se_mask =3D se_mask;
> =C2=A0}
> =C2=A0
> -static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D
> {};
> +static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D {
> +	.analog_set_stream_attribute =3D
> +		dce110_stream_encoder_analog_set_stream_attribute,
> +};
> =C2=A0
> =C2=A0void dce110_analog_stream_encoder_construct(
> =C2=A0	struct dce110_stream_encoder *enc110,
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> index 27f950ae45ee..9658b06f32f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> @@ -153,6 +153,10 @@ struct stream_encoder_funcs {
> =C2=A0		struct stream_encoder *enc,
> =C2=A0		struct dc_crtc_timing *crtc_timing);
> =C2=A0
> +	void (*analog_set_stream_attribute)(
> +		struct stream_encoder *enc,
> +		struct dc_crtc_timing *crtc_timing);
> +
> =C2=A0	void (*set_throttled_vcp_size)(
> =C2=A0		struct stream_encoder *enc,
> =C2=A0		struct fixed31_32 avg_time_slots_per_mtp);
> diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> index befa67b2b2ae..90ff4fdd79b7 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> @@ -148,6 +148,10 @@ void setup_dio_stream_attribute(struct pipe_ctx
> *pipe_ctx)
> =C2=A0		stream_encoder->funcs->lvds_set_stream_attribute(
> =C2=A0				stream_encoder,
> =C2=A0				&stream->timing);
> +	else if (dc_is_rgb_signal(stream->signal))
> +		stream_encoder->funcs->analog_set_stream_attribute(
> +				stream_encoder,
> +				&stream->timing);
> =C2=A0
> =C2=A0	if (dc_is_dp_signal(stream->signal))
> =C2=A0		link->dc->link_srv->dp_trace_source_sequence(link,
