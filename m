Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49867D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D23B10E0DB;
	Mon,  8 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4mu33Dn";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E955210E0DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:27:39 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7ae1c96ece1so332028b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765207659; x=1765812459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYQAz4ndgm8whQCLK9FnRUIHaBbe0MW0Bdy+VYBAOcE=;
 b=K4mu33DnEfXuAS+1CCavXDqtn0s6Yqkqdp7khVrGMACbqB0MjkYdxdY2ytEuFPJ9rk
 1q71koe0ocMFuPScWz9oSO7RDh0h2/4vo0OiYWj0giIsSLQ8g2u01VgDEQnb4vrMiY1H
 JWWGsBVCpcHmxDCk0K8LgfiAGlNHUYs5gs1xqdQWw1n4lUrXaHLoXDxeG7xRPv6Xl9ap
 LW5EzrBqza4kGCT7QN5dGrfgpu+EyhGF/O1ngqdhGVghTnx/EzptV33vLYuAlobuCAUy
 ubzyHSTcE/Bobv77F5l3tH8m7bXcaF07pyYXDdIjpfBLHDQ0Un0k2kBLnQKOxV5Ecbgx
 W70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765207659; x=1765812459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYQAz4ndgm8whQCLK9FnRUIHaBbe0MW0Bdy+VYBAOcE=;
 b=CUUbd9CzOLQC8H9jF95tFFaStckGr1dozFvHZsYaWN8sB1bfE47cAZdxHUZORE6Y1v
 dd9XyCHnHhRvrfcK9S0OZONQGBUiUSiw9kpmkLBqy33HptigOcVs+GG0yTeKisy+BI3I
 OJv1f4SmFLkBgJ+tMQyOFnT3PnEI6MDsqQiSFHeSMqIILg9G6gYVClhIil0PwjVUraOA
 VWAoN7DxJuA2NLiFP2KZQZH+9sQABriaKjrioLTHimxbrgUB8T8bEy0ugs7EHUvgrMf6
 37AfmcSEnIo18J3PY8d2qm6pdC5XTW/3sIoaMBQ+VenS5u3gcCyxlXmRt1bqnUxxlEJY
 /sMQ==
X-Gm-Message-State: AOJu0Yxyzx2SLZCnQ1LKfauYyhwhACSPp2lvzenZ6jpJaqOI3gacRXJ6
 Or+d5ETZ8BQnF+BSs9GIEipua4rvdncNvhJVX2DZRgRloxSjkZf4U01izTYlFPudliLS/xoDPth
 sIF+6Q3OfLxKQ9RiWsPe/8V2jyZRIJ7w=
X-Gm-Gg: ASbGnctOccYcTHWWEZUqbixutrSYsIpt8KUjqr6FBhdSgXYjrpeHweh5SkacoJxavmj
 HYKyRAgqQUn0m6BTwfysOu5o6cy6CedSH9jnlJKPeq6QufUKErzEgdGKLFxBKDhe0iVTQAXTHIk
 kJk+w+Y4FC9mGVIlX+jYdfp4hikID+BtaXeIQGPfVH1iG368vEN8v/GzOLNPZiT80lC/YsVZ0q/
 1mK30scAgu5/hwB+cm5kM81gZAXR+3z4COXsnzXE1cqZY6N4+9Gynx861fyp9l/BCnD6N8=
X-Google-Smtp-Source: AGHT+IFHwXFyVHC7KhD0C9AZKtniOlKt40/Q8YW/QotecVWzx+0A7F8L0449++ltZinXjvoKcF8Hj1xVOCpnRUfA+Uc=
X-Received: by 2002:a05:7022:e16:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11e03e9450bmr3064367c88.7.1765207659257; Mon, 08 Dec 2025
 07:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <20251206023106.8875-5-timur.kristof@gmail.com>
 <dd54ad10dfacf8211231c3981b1bb6730d772708.camel@gmail.com>
In-Reply-To: <dd54ad10dfacf8211231c3981b1bb6730d772708.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 10:27:27 -0500
X-Gm-Features: AQt7F2qAZrtmbGfLyxDzrkQvyEbr60arjHR17moO-m-T2a3djcdFVSMaecV-kv0
Message-ID: <CADnq5_NjSQvc2UQFBP4Xy8S4t=xxPhRHgKD5HGd3Dy2xs=nbMQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Setup DAC encoder before using it
To: timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 8, 2025 at 10:21=E2=80=AFAM <timur.kristof@gmail.com> wrote:
>
> On Sat, 2025-12-06 at 03:31 +0100, Timur Krist=C3=B3f wrote:
> > Just like for other signal types, call the encoder control
> > command in the VBIOS to setup the DAC encoder.
> > The DAC doesn't work well without this on some GPUs,
> > for example the Radeon HD 7790 needs this.
> >
> > Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog encoders
> > (v2)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >  .../amd/display/dc/dce/dce_stream_encoder.c   | 25
> > ++++++++++++++++++-
> >  .../amd/display/dc/inc/hw/stream_encoder.h    |  4 +++
> >  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 +++
> >  3 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > index 574618d5d4a4..1fbf6263c235 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > @@ -693,6 +693,24 @@ static void
> > dce110_stream_encoder_lvds_set_stream_attribute(
> >       ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB);
> >  }
> >
> > +static void dce110_stream_encoder_analog_set_stream_attribute(
> > +     struct stream_encoder *enc,
> > +     struct dc_crtc_timing *crtc_timing)
> > +{
> > +     struct dce110_stream_encoder *enc110 =3D
> > DCE110STRENC_FROM_STRENC(enc);
> > +     struct bp_encoder_control cntl =3D {0};
> > +
> > +     cntl.action =3D ENCODER_CONTROL_SETUP;
> > +     cntl.engine_id =3D enc110->base.id;
>
> Found a mistake here.
> This should use the analog_id added in the previous patch.

The series looks good to me.  Do you want to resend with this fixed?
I'll apply it.

Thanks,

Alex

>
> > +     cntl.pixel_clock =3D crtc_timing->pix_clk_100hz / 10;
> > +
> > +     if (enc110->base.bp->funcs->encoder_control(
> > +                     enc110->base.bp, &cntl) !=3D BP_RESULT_OK)
> > +             return;
> > +
> > +     ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB);
> > +}
> > +
> >  static void dce110_stream_encoder_set_throttled_vcp_size(
> >       struct stream_encoder *enc,
> >       struct fixed31_32 avg_time_slots_per_mtp)
> > @@ -1521,6 +1539,8 @@ static const struct stream_encoder_funcs
> > dce110_str_enc_funcs =3D {
> >               dce110_stream_encoder_dvi_set_stream_attribute,
> >       .lvds_set_stream_attribute =3D
> >               dce110_stream_encoder_lvds_set_stream_attribute,
> > +     .analog_set_stream_attribute =3D
> > +             dce110_stream_encoder_analog_set_stream_attribute,
> >       .set_throttled_vcp_size =3D
> >               dce110_stream_encoder_set_throttled_vcp_size,
> >       .update_hdmi_info_packets =3D
> > @@ -1568,7 +1588,10 @@ void dce110_stream_encoder_construct(
> >       enc110->se_mask =3D se_mask;
> >  }
> >
> > -static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D
> > {};
> > +static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D {
> > +     .analog_set_stream_attribute =3D
> > +             dce110_stream_encoder_analog_set_stream_attribute,
> > +};
> >
> >  void dce110_analog_stream_encoder_construct(
> >       struct dce110_stream_encoder *enc110,
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > index 27f950ae45ee..9658b06f32f7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > @@ -153,6 +153,10 @@ struct stream_encoder_funcs {
> >               struct stream_encoder *enc,
> >               struct dc_crtc_timing *crtc_timing);
> >
> > +     void (*analog_set_stream_attribute)(
> > +             struct stream_encoder *enc,
> > +             struct dc_crtc_timing *crtc_timing);
> > +
> >       void (*set_throttled_vcp_size)(
> >               struct stream_encoder *enc,
> >               struct fixed31_32 avg_time_slots_per_mtp);
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > index befa67b2b2ae..90ff4fdd79b7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > @@ -148,6 +148,10 @@ void setup_dio_stream_attribute(struct pipe_ctx
> > *pipe_ctx)
> >               stream_encoder->funcs->lvds_set_stream_attribute(
> >                               stream_encoder,
> >                               &stream->timing);
> > +     else if (dc_is_rgb_signal(stream->signal))
> > +             stream_encoder->funcs->analog_set_stream_attribute(
> > +                             stream_encoder,
> > +                             &stream->timing);
> >
> >       if (dc_is_dp_signal(stream->signal))
> >               link->dc->link_srv->dp_trace_source_sequence(link,
