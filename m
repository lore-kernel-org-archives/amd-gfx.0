Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63482C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 21:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF43D10E891;
	Thu,  7 Aug 2025 21:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kr+5vtPX";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334E010E891
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 21:32:21 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-459ddf9019cso5588335e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Aug 2025 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754602340; x=1755207140; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7FRbv5DMC4Vv/eoqvDpDzhjNSdUujvqNuENvSMtZbs=;
 b=Kr+5vtPX9SnGbaAJDOhDfD3ZUHIbEtBq61d/NtnzNwmwVTddtf0boBZ4frGuxTBufe
 VMrweMuqImzHJBG9ahr5vWDKO/Cx/fg1WN1PM8WaBmQq72bmelgJ7aOqD3JHSadgFgwV
 NLJ1i9szQnZfFfxCvEQN6QlqYwhGiWEYdbinWc1rDcwICN2KSmqZakPH0Y/flaLbQGiO
 xomV86XhMN7CbFCmxMSeQ5SfzY+V1x+JejZoabNyECR4YD1jKPnx7hb2RIgbRxRBwN6K
 /B0KQXSOWGzIpZWydlrMucnTmEqPg9/WYajEZOKp9fHbNdo1ttdKDwaPTnDT88oigeWX
 YRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754602340; x=1755207140;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7FRbv5DMC4Vv/eoqvDpDzhjNSdUujvqNuENvSMtZbs=;
 b=V3WJUnNHQh6rvxj0o5ZZHR/tlZuN2LmCz1E18JSDWWcLyeYsaN0b/0XAwxMvozi0xU
 nzXuPbbqZZEAJtd9bqGq+m1hnZuOsQ4m7A6StxuXlKGao9xtseSAbBmV2vfMWhFylWvB
 ohWrh4bzFTXH24KFcp7t4Ndup+C8V4ikrqkg/e15k8jZShjHgM7AcS8CekiNHkEMdiCH
 qJC1fQKDZRHvyQzB9HaFoS6/OT8CgRxx5ihQb+xjnsBPU+CfmsEdmcVJVbRxlslW9eqq
 ia1IYU1eHKF6B5ifUdVS5G5z50Hjtu50/K0KbSibbUjxRVMht9j0hFvnr3g52a8pOxyi
 bwRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuxjxOPk6sXvpTs350Ks6Nz/wY7r6U3Qg8bTkvmE0Z55hEuxMULdYUiJwgOK0MX4DfUAvDCyrS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMo9inWL4DSjoZfBQCEQnJgtL6Jokt0f0GTqSn43tUVcvWe6XQ
 ORQAIvm7/b3GcGrU1TZRJSlJYGuxSAdWJ9PiNoVjuYWV7DPkMMKGD6aNLJI46g==
X-Gm-Gg: ASbGncvL9vBFq01jhStrJt3eKA4kbsJpfLKX6pmeOCJFJuX2sJUta690b1Mh/B9kZK0
 DsL18Eeaxj2xXNOxKdQEEhR9sgqsl8jOK+GqVKzQnEUU4gt6y1XfzWYOCSWs90xc7qBIRrZxRoB
 f++uBvJrlXVgIjvHJHgROh8YEGGf0glbYGLkh7z5iuqMrDm7VdemyDyoNlmZMN0lAkVe08rntsN
 TSyO6aTY4c0GUWi9ow/GoELfmCB+5FVO8F3M1+JWGzadRcWaahj8L3tZcmTDXLCpXAgc8Npx3Bn
 vMA9MhullsVGzRh5w3Os9TFixB3y0c/iuE2o2eiAhuFRkzDtT+i/xTeP8+hKfiFKPEdoIWtL6wK
 6AW2PWfkNZyQHMQM2B43s/zIna5Ujzo1g2wONpXT6pwdqNyoLRPze33hwYbGy1rmvS9ad3ZOSND
 ACY+K/wR7cw47BDNkvKtjceEf6lLqmLdZMqF5psGNdOvD+3JZ/XVaaAu7+qdtHfDUQOyS4pIm4
X-Google-Smtp-Source: AGHT+IHkrx4GopgJzlKaCN1pC2tm6iJO1QJI2Mphp7xesB5yJD41k2XVryhiNH3fb3TSLVn32uKd3g==
X-Received: by 2002:a05:600c:3589:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-459f4f0f380mr4017795e9.19.1754602339367; 
 Thu, 07 Aug 2025 14:32:19 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d0:2800:4c9e:4e3c:c732:bae6?
 (20014C4E24D028004C9E4E3CC732BAE6.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:2800:4c9e:4e3c:c732:bae6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586ad64sm106024965e9.20.2025.08.07.14.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 14:32:18 -0700 (PDT)
Message-ID: <24b4249761d7edb8df8551350475fd6dce274d93.camel@gmail.com>
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 07 Aug 2025 23:32:17 +0200
In-Reply-To: <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
 <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
 <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
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

On Thu, 2025-08-07 at 16:34 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-08-07 15:12, Harry Wentland wrote:
> > On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > > Analog displays typically have a DDC connection which can be
> > > used by the GPU to read EDID. This commit adds the capability
> > > to probe analog displays using DDC, reading the EDID header and
> > > deciding whether the analog link is connected based on the data
> > > that was read.
> > >=20
> > > As a reference, I used the following functions:
> > > amdgpu_connector_vga_detect
> > > amdgpu_display_ddc_probe
> > >=20
> > > DAC load detection will be implemented in a separate commit.
> >=20
> > Another regression in our internal testing with this patch,
> > unfortunately
> > only on not-yet released HW.
> >=20
>=20
> While this shows on unreleased HW I wouldn't be surprised if it
> repros on other (recent-ish) APUs (integrated GPUs). It's just
> that this week's test was on currently unreleased HW.
>=20
> Harry
>=20
> > I wonder if pipe-ctx->stream could be NULL in some cases.
> >=20
> > Harry
> >=20

Hi Harry,

Can you elaborate when / how it is valid for pipe->ctx->stream to be
NULL when the code gets here? Maybe that would give me a hint how to
resolve it.

Thanks,
Timur


> > >=20
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > > =C2=A0.../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 | 16 ++--
> > > =C2=A0.../drm/amd/display/dc/link/link_detection.c=C2=A0 | 80
> > > ++++++++++++++++++-
> > > =C2=A0.../gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0 |=C2=A0=
 3 +
> > > =C2=A0.../drm/amd/display/dc/link/link_factory.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 +
> > > =C2=A04 files changed, 95 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > index f3470716734d..b9ebb992dc98 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx
> > > *pipe_ctx)
> > > =C2=A0		return;
> > > =C2=A0	}
> > > =C2=A0
> > > -	link_enc->funcs->connect_dig_be_to_fe(link_enc,
> > > -			pipe_ctx->stream_res.stream_enc->id,
> > > true);
> > > +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > > +		link_enc->funcs->connect_dig_be_to_fe(link_enc,
> > > +				pipe_ctx->stream_res.stream_enc-
> > > >id, true);
> > > =C2=A0	if (dc_is_dp_signal(pipe_ctx->stream->signal))
> > > =C2=A0		pipe_ctx->stream->ctx->dc->link_srv-
> > > >dp_trace_source_sequence(pipe_ctx->stream->link,
> > > =C2=A0				DPCD_SOURCE_SEQ_AFTER_CONNECT_DI
> > > G_FE_BE);
> > > @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx
> > > *pipe_ctx)
> > > =C2=A0	if (stream_enc->funcs->enable_stream)
> > > =C2=A0		stream_enc->funcs->enable_stream(stream_enc,
> > > =C2=A0				pipe_ctx->stream->signal,
> > > false);
> > > -	link_enc->funcs->connect_dig_be_to_fe(
> > > -			link_enc,
> > > -			pipe_ctx->stream_res.stream_enc->id,
> > > -			false);
> > > +
> > > +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > > +		link_enc->funcs->connect_dig_be_to_fe(
> > > +				link_enc,
> > > +				pipe_ctx->stream_res.stream_enc-
> > > >id,
> > > +				false);
> > > +
> > > =C2=A0	if (dc_is_dp_signal(pipe_ctx->stream->signal))
> > > =C2=A0		pipe_ctx->stream->ctx->dc->link_srv-
> > > >dp_trace_source_sequence(
> > > =C2=A0				pipe_ctx->stream->link,
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > index 827b630daf49..fcabc83464af 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > @@ -942,6 +942,12 @@ static bool
> > > detect_link_and_local_sink(struct dc_link *link,
> > > =C2=A0			break;
> > > =C2=A0		}
> > > =C2=A0
> > > +		case SIGNAL_TYPE_RGB: {
> > > +			sink_caps.transaction_type =3D
> > > DDC_TRANSACTION_TYPE_I2C;
> > > +			sink_caps.signal =3D SIGNAL_TYPE_RGB;
> > > +			break;
> > > +		}
> > > +
> > > =C2=A0		case SIGNAL_TYPE_LVDS: {
> > > =C2=A0			sink_caps.transaction_type =3D
> > > DDC_TRANSACTION_TYPE_I2C;
> > > =C2=A0			sink_caps.signal =3D SIGNAL_TYPE_LVDS;
> > > @@ -1133,9 +1139,17 @@ static bool
> > > detect_link_and_local_sink(struct dc_link *link,
> > > =C2=A0				sink =3D prev_sink;
> > > =C2=A0				prev_sink =3D NULL;
> > > =C2=A0			}
> > > -			query_hdcp_capability(sink->sink_signal,
> > > link);
> > > +
> > > +			if (!sink->edid_caps.analog)
> > > +				query_hdcp_capability(sink-
> > > >sink_signal, link);
> > > =C2=A0		}
> > > =C2=A0
> > > +		/* DVI-I connector connected to analog display.
> > > */
> > > +		if ((link->link_enc->connector.id =3D=3D
> > > CONNECTOR_ID_DUAL_LINK_DVII ||
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0 link->link_enc->connector.id =3D=3D
> > > CONNECTOR_ID_SINGLE_LINK_DVII) &&
> > > +			sink->edid_caps.analog)
> > > +			sink->sink_signal =3D SIGNAL_TYPE_RGB;
> > > +
> > > =C2=A0		/* HDMI-DVI Dongle */
> > > =C2=A0		if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A
> > > &&
> > > =C2=A0		=C2=A0=C2=A0=C2=A0 !sink->edid_caps.edid_hdmi)
> > > @@ -1228,6 +1242,64 @@ static bool
> > > detect_link_and_local_sink(struct dc_link *link,
> > > =C2=A0	return true;
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * Evaluates whether an EDID header is acceptable,
> > > + * for the purpose of determining a connection with a display.
> > > + */
> > > +static bool link_detect_evaluate_edid_header(uint8_t
> > > edid_header[8])
> > > +{
> > > +	int edid_header_score =3D 0;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < 8; ++i)
> > > +		edid_header_score +=3D edid_header[i] =3D=3D ((i =3D=3D 0
> > > || i =3D=3D 7) ? 0x00 : 0xff);
> > > +
> > > +	return edid_header_score >=3D 6;
> > > +}
> > > +
> > > +/**
> > > + * Tries to detect a connected display by probing the DDC
> > > + * and reading the EDID header.
> > > + * The probing is considered successful if we receive a
> > > + * reply from the DDC over I2C and the EDID header matches.
> > > + */
> > > +static bool link_detect_ddc_probe(struct dc_link *link)
> > > +{
> > > +	if (!link->ddc)
> > > +		return false;
> > > +
> > > +	uint8_t edid_header[8] =3D {0};
> > > +	bool ddc_probed =3D i2c_read(link->ddc, 0x50, edid_header,
> > > sizeof(edid_header));
> > > +
> > > +	if (!ddc_probed)
> > > +		return false;
> > > +
> > > +	if (!link_detect_evaluate_edid_header(edid_header))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/**
> > > + * Determines if there is an analog sink connected.
> > > + */
> > > +static bool link_detect_analog(struct dc_link *link, enum
> > > dc_connection_type *type)
> > > +{
> > > +	/* Don't care about connectors that don't support an
> > > analog signal. */
> > > +	if (link->link_enc->connector.id !=3D CONNECTOR_ID_VGA &&
> > > +		link->link_enc->connector.id !=3D
> > > CONNECTOR_ID_SINGLE_LINK_DVII &&
> > > +		link->link_enc->connector.id !=3D
> > > CONNECTOR_ID_DUAL_LINK_DVII)
> > > +		return false;
> > > +
> > > +	if (link_detect_ddc_probe(link)) {
> > > +		*type =3D dc_connection_single;
> > > +		return true;
> > > +	}
> > > +
> > > +	*type =3D dc_connection_none;
> > > +	return true;
> > > +}
> > > +
> > > =C2=A0/*
> > > =C2=A0 * link_detect_connection_type() - Determine if there is a sink
> > > connected
> > > =C2=A0 *
> > > @@ -1238,6 +1310,7 @@ static bool
> > > detect_link_and_local_sink(struct dc_link *link,
> > > =C2=A0bool link_detect_connection_type(struct dc_link *link, enum
> > > dc_connection_type *type)
> > > =C2=A0{
> > > =C2=A0	uint32_t is_hpd_high =3D 0;
> > > +	bool supports_hpd =3D link->irq_source_hpd !=3D
> > > DC_IRQ_SOURCE_INVALID;
> > > =C2=A0
> > > =C2=A0	if (link->connector_signal =3D=3D SIGNAL_TYPE_LVDS) {
> > > =C2=A0		*type =3D dc_connection_single;
> > > @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct
> > > dc_link *link, enum dc_connection_type *
> > > =C2=A0		return true;
> > > =C2=A0	}
> > > =C2=A0
> > > +	if (!supports_hpd)
> > > +		return link_detect_analog(link, type);
> > > =C2=A0
> > > =C2=A0	if (!query_hpd_status(link, &is_hpd_high))
> > > =C2=A0		goto hpd_gpio_failure;
> > > @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct
> > > dc_link *link, enum dc_connection_type *
> > > =C2=A0		*type =3D dc_connection_single;
> > > =C2=A0		/* TODO: need to do the actual detection */
> > > =C2=A0	} else {
> > > +		if (link_detect_analog(link, type))
> > > +			return true;
> > > +
> > > =C2=A0		*type =3D dc_connection_none;
> > > =C2=A0		if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
> > > =C2=A0			/* eDP is not connected, power down it
> > > */
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > index d6b7347c6c11..ac25d89a4148 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
> > > =C2=A0		enable_link_lvds(pipe_ctx);
> > > =C2=A0		status =3D DC_OK;
> > > =C2=A0		break;
> > > +	case SIGNAL_TYPE_RGB:
> > > +		status =3D DC_OK;
> > > +		break;
> > > =C2=A0	case SIGNAL_TYPE_VIRTUAL:
> > > =C2=A0		status =3D enable_link_virtual(pipe_ctx);
> > > =C2=A0		break;
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > index 71c10a1261b9..c9725fd316f6 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link
> > > *link,
> > > =C2=A0	case CONNECTOR_ID_DUAL_LINK_DVII:
> > > =C2=A0		link->connector_signal =3D
> > > SIGNAL_TYPE_DVI_DUAL_LINK;
> > > =C2=A0		break;
> > > +	case CONNECTOR_ID_VGA:
> > > +		link->connector_signal =3D SIGNAL_TYPE_RGB;
> > > +		break;
> > > =C2=A0	case CONNECTOR_ID_DISPLAY_PORT:
> > > =C2=A0	case CONNECTOR_ID_MXM:
> > > =C2=A0	case CONNECTOR_ID_USBC:
> >=20
