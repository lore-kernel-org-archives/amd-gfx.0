Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1DD3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B2010E465;
	Mon,  8 Dec 2025 15:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pkk1vcjH";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E590910E465
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:32:58 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-3e8f418e051so3152773fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765207978; x=1765812778; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jKJ/Zs6ccWyr5E6wGVNJLWVjlpCNXNA6eycWo2CmM8A=;
 b=Pkk1vcjH3F3+VGFBJEHEALYz6iOsWl3uA+lWozBBD4cyk/peBIDJZK2GNG50BxPdud
 XyDho4nrXa7zg6HEfd4ga4DY0KJvnD73rI/mM7MdQpU0L4cdS0b8KWUy0iRqzZYXaYAL
 obm02Q8zHNKLe61zopBzFZndr/9/+C717Eo7V5fylyajP9YKVDvLV0xkREqHFTjgdcE+
 dOSvGY/dQoyZ/8F/lU9kuXNh25492yDuY2eUGB8cFp3v9FcpKrWKnkyfFoFXZTCqpcNU
 GItsVsvkDOjXmcLOKUnULK2bmLJI9rMbdZb0qha/Ea76dWjQcXYF/jfqzK8Q9rnhO94v
 xvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765207978; x=1765812778;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jKJ/Zs6ccWyr5E6wGVNJLWVjlpCNXNA6eycWo2CmM8A=;
 b=mwDyd4Aqq+ZWW2CpzbRtLA00hi1VlD3KF5IFvYVR1Vn3KdGu+38QLEw9IVd1ybsriS
 pFngiqSlgKObTQzHFi63WG+tLBFf0ulIaW5+QDQ8S44Ay8t2bD1JJN0MBMnvZVQdWVZ8
 aFd+h/opmFjtFqCZuoRIYlCN/CtvzLCbv50oe7iESA3HmjLOsHSeZhzgPoBmL0+Zzjfc
 +tJ7JP5ne+lQEM0lVZUxmFtKE7Bp3clsuLOY5zN4sP3SZrzZkriplA4kAQD4t/TXUKlF
 0pf+0MmK3B1Bf505fKFcCQgYg06cQaFX+3CE/dhth5AqHCAWbCl5jbYYjUB1cQFAt16L
 PagQ==
X-Gm-Message-State: AOJu0YzpgazBXG2uWjGdyT2GbI38b4tTu6wftgAtjVPjhXnD+BaqVFlA
 5fW6f2+Int+6WewljvkkuESuy3cktDfddOB40IAO/kzgapQOW9trnUHc
X-Gm-Gg: ASbGnctvGgwuhqGVBLZlZXHVpSvFV2sz51bXCh/qGng9GUqh8DYLarMcnwsdYB7epuV
 SztU2r4N3RDBE4eaBIJWMooUCE7YRvVfydyG/OALqKJftGXq8AMHSm0+iPq6fDfT9GY0E31dosq
 zf4v7z35c+Rm0Fbn74SclJh+tytk8hWfEqY54Mio1cITe/AKDxgDZ2O/KephJvcv0abDWTchF9z
 pY8GvFeQQRVguQUCGqI2AfyJ4OlpOXbPZxY53zmDlGq/iru6sTy+gOfA5SFObSDnHz96Ob21vaa
 u09sjCQLc394d2Oo2my945vyu1UcLrYdJJzLhX4Sr+nLKtWlnfmpZCLVFFZKijUUFm588duJ8uT
 UsA12pXLkh0g9hXy3RDOMENsGl+zu999WHJGkQT30GOwpZS8PV1ZU8L2kX4t7Tez/YWEJlIamLx
 X5AXgGFUYx3yk1mecVEPE=
X-Google-Smtp-Source: AGHT+IGvTNVGsIP0ANujYKU1n7Eqygpp0XP5TGmk4J5BtAB+cnaZ2YwimQVkvBkW3g39fCakHuqVLA==
X-Received: by 2002:a05:6871:5e05:b0:378:e537:475f with SMTP id
 586e51a60fabf-3f543edca7dmr3412988fac.24.1765207977877; 
 Mon, 08 Dec 2025 07:32:57 -0800 (PST)
Received: from [192.168.2.3] ([189.139.20.240])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa31534sm9085224fac.2.2025.12.08.07.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:32:57 -0800 (PST)
Message-ID: <367cb1e91844f9c219509cf7c7c1880a77660018.camel@gmail.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Setup DAC encoder before using it
From: timur.kristof@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, 	siqueira@igalia.com
Date: Mon, 08 Dec 2025 09:32:56 -0600
In-Reply-To: <CADnq5_NjSQvc2UQFBP4Xy8S4t=xxPhRHgKD5HGd3Dy2xs=nbMQ@mail.gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <20251206023106.8875-5-timur.kristof@gmail.com>
 <dd54ad10dfacf8211231c3981b1bb6730d772708.camel@gmail.com>
 <CADnq5_NjSQvc2UQFBP4Xy8S4t=xxPhRHgKD5HGd3Dy2xs=nbMQ@mail.gmail.com>
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

On Mon, 2025-12-08 at 10:27 -0500, Alex Deucher wrote:
> On Mon, Dec 8, 2025 at 10:21=E2=80=AFAM <timur.kristof@gmail.com> wrote:
> >=20
> > On Sat, 2025-12-06 at 03:31 +0100, Timur Krist=C3=B3f wrote:
> > > Just like for other signal types, call the encoder control
> > > command in the VBIOS to setup the DAC encoder.
> > > The DAC doesn't work well without this on some GPUs,
> > > for example the Radeon HD 7790 needs this.
> > >=20
> > > Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog
> > > encoders
> > > (v2)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > > =C2=A0.../amd/display/dc/dce/dce_stream_encoder.c=C2=A0=C2=A0 | 25
> > > ++++++++++++++++++-
> > > =C2=A0.../amd/display/dc/inc/hw/stream_encoder.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 +++
> > > =C2=A0.../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 |=C2=A0 4 ++=
+
> > > =C2=A03 files changed, 32 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > index 574618d5d4a4..1fbf6263c235 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > @@ -693,6 +693,24 @@ static void
> > > dce110_stream_encoder_lvds_set_stream_attribute(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(crtc_timing->pixel_encoding =3D=
=3D PIXEL_ENCODING_RGB);
> > > =C2=A0}
> > >=20
> > > +static void dce110_stream_encoder_analog_set_stream_attribute(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct stream_encoder *enc,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct dc_crtc_timing *crtc_timing)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct dce110_stream_encoder *enc110 =3D
> > > DCE110STRENC_FROM_STRENC(enc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct bp_encoder_control cntl =3D {0};
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 cntl.action =3D ENCODER_CONTROL_SETUP;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 cntl.engine_id =3D enc110->base.id;
> >=20
> > Found a mistake here.
> > This should use the analog_id added in the previous patch.
>=20
> The series looks good to me.=C2=A0 Do you want to resend with this fixed?
> I'll apply it.
>=20
> Thanks,
>=20
> Alex

Thanks Alex.
I will send a second version with this fixed.

Also I would like to wait for Mauro to test it. The series fixes the
"black screen" issue on my HD 7790, but Mauro told me that it doesn't
fix it for him.

>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 cntl.pixel_clock =3D crtc_timing->pix_clk_1=
00hz / 10;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (enc110->base.bp->funcs->encoder_control=
(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc110->base.bp, &cn=
tl) !=3D BP_RESULT_OK)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(crtc_timing->pixel_encoding =3D=3D P=
IXEL_ENCODING_RGB);
> > > +}
> > > +
> > > =C2=A0static void dce110_stream_encoder_set_throttled_vcp_size(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct stream_encoder *enc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fixed31_32 avg_time_slots_per_m=
tp)
> > > @@ -1521,6 +1539,8 @@ static const struct stream_encoder_funcs
> > > dce110_str_enc_funcs =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dce110_stream_encoder_dvi_set_stream_attribute,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lvds_set_stream_attribute =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dce110_stream_encoder_lvds_set_stream_attribute,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .analog_set_stream_attribute =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dce110_stream_encoder_analog_set_stream_attribute,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_throttled_vcp_size =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dce110_stream_encoder_set_throttled_vcp_size,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .update_hdmi_info_packets =3D
> > > @@ -1568,7 +1588,10 @@ void dce110_stream_encoder_construct(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enc110->se_mask =3D se_mask;
> > > =C2=A0}
> > >=20
> > > -static const struct stream_encoder_funcs dce110_an_str_enc_funcs
> > > =3D
> > > {};
> > > +static const struct stream_encoder_funcs dce110_an_str_enc_funcs
> > > =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .analog_set_stream_attribute =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dce110_stream_encoder_analog_set_stream_attribute,
> > > +};
> > >=20
> > > =C2=A0void dce110_analog_stream_encoder_construct(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dce110_stream_encoder *enc110,
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > index 27f950ae45ee..9658b06f32f7 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > @@ -153,6 +153,10 @@ struct stream_encoder_funcs {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct stream_encoder *enc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct dc_crtc_timing *crtc_timing);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 void (*analog_set_stream_attribute)(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct stream_encoder *enc,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct dc_crtc_timing *crtc_timing);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*set_throttled_vcp_size)(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct stream_encoder *enc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct fixed31_32 avg_time_slots_per_mtp);
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > index befa67b2b2ae..90ff4fdd79b7 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > @@ -148,6 +148,10 @@ void setup_dio_stream_attribute(struct
> > > pipe_ctx
> > > *pipe_ctx)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 stream_encoder->funcs->lvds_set_stream_attribute(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_encoder,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &stream->timing);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (dc_is_rgb_signal(stream->signal))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 stream_encoder->funcs->analog_set_stream_attribute(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream_encoder,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &stream->timing);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dc_is_dp_signal(stream->signal))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 link->dc->link_srv->dp_trace_source_sequence(link,
