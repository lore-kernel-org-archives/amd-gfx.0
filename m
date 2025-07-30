Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0698EC87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 08:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B3110E084;
	Wed, 30 Jul 2025 08:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFCbOwbY";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A6810E084
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 08:19:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so3295565e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753863562; x=1754468362; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmKjOzeyQMIZhibyQLuAbd6+laxFAg3QswPHaTEJkPg=;
 b=YFCbOwbYGgbfmOh0UniyXxLkRspJKV4hrlAYsII5Y8G+8Zboo8T/m6k/tN021G/qIy
 9yTs0Wg5sNjab33MNmSXt70WusCdrf8ppYAAjX2/pjELPAfOaqWfreBlGLmcHGfESw+f
 I4gfKLbB8ZUanUYav9KodX6unQqiy4XY+hzBR8xssdM3gJbFmtMwwA8p+0R+z2uBpWRs
 sKiZPcIha+JvRz8NH3sNox1Oh4EjaLMycsGm3VEH08HZh4S5sGSJE8tmu9hdgLa/yD2V
 NH0NuL9e2jwe4yN3fQlxOsAVuFCjqiEp7/AtUPJNaBdDuTfo4vL/RNljPTgNfXDl2h7A
 ANoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753863562; x=1754468362;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmKjOzeyQMIZhibyQLuAbd6+laxFAg3QswPHaTEJkPg=;
 b=HD5aipDUXZx6J4W5VZK4VzRip1Ldg87F5QnQ/Ri/3pZ29/WlFlQdBBr0rGfyNtzPql
 GMoqmP7eLpBLQoAemoSg+8UEuXvXnuLAXrvHI0hoZc5Qk/YpA17ZCVfN++1Wuy/o2QV2
 yhjiw0/SN4O78LdF27wq708Qdw3+TRY8GRQ9KVB0cvh+cHJjMXf9ls+P//hGkqnM4Uls
 OC0J3kna6s+0RNIMPAISWYy3VcY6v7GiG93ysHx6GJ8SFrDAM4dqTPlc0bz8Pce9dnOl
 FYdLKH//icT8UnWHoH4dRNARsu6+q3/UEpZaHhYUuXzZZGnuZV2CIhPzG7sALFV/Vmk+
 IMlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWtcFUrf07zcKiU/EHJ2EYbaGwk6faZqjngt0Z3dEwedNIdf5NsIoFOdEnf7nNA171DfjCj2gM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1Tt3M3XOR9kAaXas2lA24VI2TILQBCUdWV2z28ukrnxeb1eTd
 Jb+/tRQQA6nH9sl0vrMxviDfc3Qt/QPOgn1OnhASAk/0dmUeA8cAVjhb
X-Gm-Gg: ASbGncuhciNbrpcseJEsK5bkMBshl1ETaYGXYt2jEnltpKnfmv9iLWIaVJzfeC7Tkq8
 V/y6FV2bnhv7pW2SWn+jPp49+JAbzrzswiXXtEsAx5Oyep4pWsOi50hcyw0MUX+1NNc1yWmjjm+
 RUAqE3g1ZXk4wOsY7/uA8cVr+gXlAjixsqIe30L5qmx3pO8CLQalgqPFeC9NODte6K7sz8la07H
 koGt9vajEvXDpXImvtyStQgDJ9uGGSgmFqq2ZeB+wRzF2YCcG5vUxqmLfRTAPNNqOWEcxooysdv
 /qjwElXbBvl9DHFD3PlUIBAnDifxANI9HWPVii+tFGtfYCye+oOKNtBB1KHS/9v3n4Vs5ehBuqR
 sTnzLJSo0u3TiROU6Q5oWpxoi0sU5sczk/uEp8f5ZJGzh0QUa4u06dXTMq2i2+AKYy2LqvNocej
 F/LyfrRFLbnpMBncaDTCmTf7ZnV1UVfw0SY1R0sFnc/3wD67AA6caMfy86IOrnHrl1Y5xEtZDO
X-Google-Smtp-Source: AGHT+IF4i+ea0fLdxAwth9NpBsGC8W3fnyE2TmLg8TwH1zuncaX4mg2IPgRVIvTgn4NjsKVIbniZ4w==
X-Received: by 2002:a05:600c:78f:b0:456:12ad:ec3d with SMTP id
 5b1f17b1804b1-4588d17968dmr37643395e9.14.1753863562248; 
 Wed, 30 Jul 2025 01:19:22 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588d89c50fsm36009035e9.0.2025.07.30.01.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 01:19:21 -0700 (PDT)
Message-ID: <7d1df06a6b19dc2d8e78059efb6e26f00bdb280a.camel@gmail.com>
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio
 on RGB signals
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 10:19:21 +0200
In-Reply-To: <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-8-timur.kristof@gmail.com>
 <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
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

On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > Features like stereo sync and audio are not supported by RGB
> > signals, so don't try to use them.
> >=20
>=20
> Where does it say that?
>=20
> Harry

1. Audio

VGA ports (and the analog part of DVI-I ports) simply cannot carry
audio. So there is no hardware to control any audio, therefore there is
nothing for this code to enable, which is why I added those ifs to not
even try to enable audio on analog video signals.

As a side note, DVI-D ports (and the digital part of DVI-I ports) may
have a non-standard extension to carry digital audio signals, but that
is not revelant to supporting analog displays.

2. Stereo sync

With regards to stereo sync, I didn't find any reference to this in the
legacy display code, so I assumed either it is unsupported or the VBIOS
already sets it up correctly. At least, considering that the legacy
code didn't bother setting it up, we don't lose any functionality if we
leave it out of DC as well.

That being said, upon some further digging in the DCE register files, I
found a register called DAC_STEREOSYNC_SELECT so maybe I could
investigate using that. Maybe it would be better to work with the
registers directly instead of the VBIOS? Would it be okay to
investigate that further in a future patch series once this one is
merged?

Thanks,
Timur



>=20
> > Also add a dc_is_rgb_signal similar to other dc_is_*_signal.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c | 3 ++-
> > =C2=A0drivers/gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++-
> > -
> > =C2=A0drivers/gpu/drm/amd/display/include/signal_types.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
> > =C2=A03 files changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > index b68bcc9fca0a..f3470716734d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > @@ -115,7 +115,8 @@ void setup_dio_stream_attribute(struct pipe_ctx
> > *pipe_ctx)
> > =C2=A0	struct dc_stream_state *stream =3D pipe_ctx->stream;
> > =C2=A0	struct dc_link *link =3D stream->link;
> > =C2=A0
> > -	if (!dc_is_virtual_signal(stream->signal))
> > +	if (!dc_is_virtual_signal(stream->signal) &&
> > +		!dc_is_rgb_signal(stream->signal))
> > =C2=A0		stream_encoder->funcs->setup_stereo_sync(
> > =C2=A0				stream_encoder,
> > =C2=A0				pipe_ctx->stream_res.tg->inst,
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > index 8c8682f743d6..d6b7347c6c11 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > @@ -2369,7 +2369,8 @@ void link_set_dpms_off(struct pipe_ctx
> > *pipe_ctx)
> > =C2=A0			set_avmute(pipe_ctx, true);
> > =C2=A0	}
> > =C2=A0
> > -	dc->hwss.disable_audio_stream(pipe_ctx);
> > +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > +		dc->hwss.disable_audio_stream(pipe_ctx);
> > =C2=A0
> > =C2=A0	update_psp_stream_config(pipe_ctx, true);
> > =C2=A0	dc->hwss.blank_stream(pipe_ctx);
> > @@ -2656,7 +2657,8 @@ void link_set_dpms_on(
> > =C2=A0		enable_stream_features(pipe_ctx);
> > =C2=A0	update_psp_stream_config(pipe_ctx, false);
> > =C2=A0
> > -	dc->hwss.enable_audio_stream(pipe_ctx);
> > +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > +		dc->hwss.enable_audio_stream(pipe_ctx);
> > =C2=A0
> > =C2=A0	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
> > =C2=A0		set_avmute(pipe_ctx, false);
> > diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h
> > b/drivers/gpu/drm/amd/display/include/signal_types.h
> > index a10d6b988aab..825a08fcb125 100644
> > --- a/drivers/gpu/drm/amd/display/include/signal_types.h
> > +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
> > @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum
> > signal_type signal)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +static inline bool dc_is_rgb_signal(enum signal_type signal)
> > +{
> > +	return (signal =3D=3D SIGNAL_TYPE_RGB);
> > +}
> > +
> > =C2=A0static inline bool dc_is_tmds_signal(enum signal_type signal)
> > =C2=A0{
> > =C2=A0	switch (signal) {
