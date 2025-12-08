Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C46D3B7F2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2E410E47A;
	Mon,  8 Dec 2025 15:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDmzOFXe";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3438E10E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:46:33 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-bd2decde440so324155a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765208793; x=1765813593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I1MeXAlIsXqwaYnJhmPjgkj9y1gc7C1hN/3WNClYfE=;
 b=EDmzOFXewYynyW4UPQs1rcAbRJm6f3jre8VCsBr3/RYny9wFK6mLQCUajNxnqKZa7a
 2qdMxkTbwTFVkGkpmIQ+/RQGIT++rYqRTXFD069S/FVcNXiwt7poWytWXroRi86Ado5z
 OEpHbmKVjVoonjPafqGBoGMJEWpBGFztasHk/Ul17lVzeaLL8c4ZeNDcBlwLPDcRiqM/
 igZdBOhG02XqxStKeoVVycUwfVQmlabAG275jOLQ068MNHExmUdV+RKYMUzkDAKNaHLy
 NlmSEntTxaLKuA7K+YovzFoo31T5t6tEtganTiSfhzgjxfFYSlNsfv21OfgFn6FQHy+f
 HEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765208793; x=1765813593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6I1MeXAlIsXqwaYnJhmPjgkj9y1gc7C1hN/3WNClYfE=;
 b=ZEIIlSwmxMEzR/OhRVoCLwf/2BhKm2JbJe5uWXUUahlh9PuOk0WXclUDXHrRyJhzpW
 H2vDguJu0nPBLd9kYNUPh88q9gbzCQ5+T7K4sCSNvuNuXO1TGdStIywpKq7Cij8s9bu3
 w5YkFRnSwaJx9EWKAqTtTk9DdSzTay2PCvtxaNZ/5n44eBj0BumAQoKkfN3p1lLtfmoF
 QccriJwIiYcpskcSG5a2XtyYheWyd4bWIxxJZy98t+Uwj19F2w9+wBCov67cviV+Ot4t
 3UgwuA0DloOsRt6p5TpFFLsC9sVtxkhmAn9hESYv3AgSlbAMChdujSnhdAcr/aT9CWJI
 DB+w==
X-Gm-Message-State: AOJu0YyFUkqlqjtannn8xxhQU+0QUaogZFFDIBcJCpv9zonJr6Z1khNA
 qHwypq5+altoXTAMzkvN6jj3Tq2LfdH7zViqRBcTVEki8C4ZZGMDVC84DmfNx8C7BLNiybMwPwP
 Hun3eGw2/4d0oSUdBRVeDNzLt1PAIdP4=
X-Gm-Gg: ASbGncvEaTxQ/8fze1ahemh/rMSDcOKIKD92lK26Z1ygMZb/x54oKBgAPHQsKgiE/FH
 ax6HCrvS0vADJOHfUbAfaeVOzCt3SBVJ7eXXXLiF3UGo8aF9Vy0x291ijY2U9glRylnWzlioggJ
 qdqxrkUN3fn44lvd+Ho9YUg53cNrbe3BFFuCooVt1ZSva6mARVvNGJfhJrM0FjaN2qsXw5+QbNg
 zKrA1n2H04H591iVEci70YRxQyhuoWWoJ+WnP3SAAT7y0/fyWZ/G7Ba//vouQiP9eiygxw=
X-Google-Smtp-Source: AGHT+IEm3WyC9F+T8nNv31AUL5NPthgcPQRylycgztfxdx4YRXWGzL/HUMXAYxTKSJS/8AvQtxwug2fmI0b7xSyeCmg=
X-Received: by 2002:a05:7022:b90:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11e031047c8mr3616087c88.0.1765208792589; Mon, 08 Dec 2025
 07:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <20251206023106.8875-5-timur.kristof@gmail.com>
 <dd54ad10dfacf8211231c3981b1bb6730d772708.camel@gmail.com>
 <CADnq5_NjSQvc2UQFBP4Xy8S4t=xxPhRHgKD5HGd3Dy2xs=nbMQ@mail.gmail.com>
 <367cb1e91844f9c219509cf7c7c1880a77660018.camel@gmail.com>
In-Reply-To: <367cb1e91844f9c219509cf7c7c1880a77660018.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 10:46:20 -0500
X-Gm-Features: AQt7F2oF0O8v3JE_7v1lmthMRBe7nBth0yfBlwevhelV7rrlRsBMkw2Iau2D9_4
Message-ID: <CADnq5_Oxio4sBY++6VhUMp2J3DeZmgxL4K6r+b-v0Hu7dVaN9A@mail.gmail.com>
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

On Mon, Dec 8, 2025 at 10:32=E2=80=AFAM <timur.kristof@gmail.com> wrote:
>
> On Mon, 2025-12-08 at 10:27 -0500, Alex Deucher wrote:
> > On Mon, Dec 8, 2025 at 10:21=E2=80=AFAM <timur.kristof@gmail.com> wrote=
:
> > >
> > > On Sat, 2025-12-06 at 03:31 +0100, Timur Krist=C3=B3f wrote:
> > > > Just like for other signal types, call the encoder control
> > > > command in the VBIOS to setup the DAC encoder.
> > > > The DAC doesn't work well without this on some GPUs,
> > > > for example the Radeon HD 7790 needs this.
> > > >
> > > > Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog
> > > > encoders
> > > > (v2)")
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > >  .../amd/display/dc/dce/dce_stream_encoder.c   | 25
> > > > ++++++++++++++++++-
> > > >  .../amd/display/dc/inc/hw/stream_encoder.h    |  4 +++
> > > >  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 +++
> > > >  3 files changed, 32 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > > b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > > index 574618d5d4a4..1fbf6263c235 100644
> > > > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> > > > @@ -693,6 +693,24 @@ static void
> > > > dce110_stream_encoder_lvds_set_stream_attribute(
> > > >       ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)=
;
> > > >  }
> > > >
> > > > +static void dce110_stream_encoder_analog_set_stream_attribute(
> > > > +     struct stream_encoder *enc,
> > > > +     struct dc_crtc_timing *crtc_timing)
> > > > +{
> > > > +     struct dce110_stream_encoder *enc110 =3D
> > > > DCE110STRENC_FROM_STRENC(enc);
> > > > +     struct bp_encoder_control cntl =3D {0};
> > > > +
> > > > +     cntl.action =3D ENCODER_CONTROL_SETUP;
> > > > +     cntl.engine_id =3D enc110->base.id;
> > >
> > > Found a mistake here.
> > > This should use the analog_id added in the previous patch.
> >
> > The series looks good to me.  Do you want to resend with this fixed?
> > I'll apply it.
> >
> > Thanks,
> >
> > Alex
>
> Thanks Alex.
> I will send a second version with this fixed.

Feel free to add my RB for the series.

>
> Also I would like to wait for Mauro to test it. The series fixes the
> "black screen" issue on my HD 7790, but Mauro told me that it doesn't
> fix it for him.

Thanks for the update.  Sounds like it's still a valid bug fix even if
additional fixes may be needed for Mauro's system.

Alex


>
> >
> > >
> > > > +     cntl.pixel_clock =3D crtc_timing->pix_clk_100hz / 10;
> > > > +
> > > > +     if (enc110->base.bp->funcs->encoder_control(
> > > > +                     enc110->base.bp, &cntl) !=3D BP_RESULT_OK)
> > > > +             return;
> > > > +
> > > > +     ASSERT(crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)=
;
> > > > +}
> > > > +
> > > >  static void dce110_stream_encoder_set_throttled_vcp_size(
> > > >       struct stream_encoder *enc,
> > > >       struct fixed31_32 avg_time_slots_per_mtp)
> > > > @@ -1521,6 +1539,8 @@ static const struct stream_encoder_funcs
> > > > dce110_str_enc_funcs =3D {
> > > >               dce110_stream_encoder_dvi_set_stream_attribute,
> > > >       .lvds_set_stream_attribute =3D
> > > >               dce110_stream_encoder_lvds_set_stream_attribute,
> > > > +     .analog_set_stream_attribute =3D
> > > > +             dce110_stream_encoder_analog_set_stream_attribute,
> > > >       .set_throttled_vcp_size =3D
> > > >               dce110_stream_encoder_set_throttled_vcp_size,
> > > >       .update_hdmi_info_packets =3D
> > > > @@ -1568,7 +1588,10 @@ void dce110_stream_encoder_construct(
> > > >       enc110->se_mask =3D se_mask;
> > > >  }
> > > >
> > > > -static const struct stream_encoder_funcs dce110_an_str_enc_funcs
> > > > =3D
> > > > {};
> > > > +static const struct stream_encoder_funcs dce110_an_str_enc_funcs
> > > > =3D {
> > > > +     .analog_set_stream_attribute =3D
> > > > +             dce110_stream_encoder_analog_set_stream_attribute,
> > > > +};
> > > >
> > > >  void dce110_analog_stream_encoder_construct(
> > > >       struct dce110_stream_encoder *enc110,
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > > b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > > index 27f950ae45ee..9658b06f32f7 100644
> > > > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> > > > @@ -153,6 +153,10 @@ struct stream_encoder_funcs {
> > > >               struct stream_encoder *enc,
> > > >               struct dc_crtc_timing *crtc_timing);
> > > >
> > > > +     void (*analog_set_stream_attribute)(
> > > > +             struct stream_encoder *enc,
> > > > +             struct dc_crtc_timing *crtc_timing);
> > > > +
> > > >       void (*set_throttled_vcp_size)(
> > > >               struct stream_encoder *enc,
> > > >               struct fixed31_32 avg_time_slots_per_mtp);
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > index befa67b2b2ae..90ff4fdd79b7 100644
> > > > --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > @@ -148,6 +148,10 @@ void setup_dio_stream_attribute(struct
> > > > pipe_ctx
> > > > *pipe_ctx)
> > > >               stream_encoder->funcs->lvds_set_stream_attribute(
> > > >                               stream_encoder,
> > > >                               &stream->timing);
> > > > +     else if (dc_is_rgb_signal(stream->signal))
> > > > +             stream_encoder->funcs->analog_set_stream_attribute(
> > > > +                             stream_encoder,
> > > > +                             &stream->timing);
> > > >
> > > >       if (dc_is_dp_signal(stream->signal))
> > > >               link->dc->link_srv->dp_trace_source_sequence(link,
