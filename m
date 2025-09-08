Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C58CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 17:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6C410E58E;
	Mon,  8 Sep 2025 17:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvH2PwWu";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDFA10E58E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 17:36:23 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24b150fb800so12342785ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757352983; x=1757957783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuj+wh2g8WgorlyJB9JuhhYp0Vxb0zQm7ckc4uM5Kkc=;
 b=TvH2PwWuIlbNbHlew+jHqZbyiSAOLzZ9kfIBIJv80PpIBV7sTvuG4icyUHz9EwHH8Y
 1QEwm5ooCZJ7v43gkb9sLIPnY8nUVNwZrCkrpkreaBrKpJO37aKzGBKVo1yFVBL2YThq
 SLiv4fo5h0QdnWrsLFKXbChCEy/QjpYiWyP1Nw/86zt9OhvxayWUuh4PWwZ/c+ROt98P
 5xJR7nnU7xzRmOSjxB97SfndjWd8LDz8xXoil5zAAQDD37NSyqy/WdI6jy65aXpPeWn0
 jdUO5DkaYO6iFl8YsDyISyQSg78bpL9PnPzbiNGalW4GOVythab6WSRbMZuCwaCLEzmc
 I3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757352983; x=1757957783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuj+wh2g8WgorlyJB9JuhhYp0Vxb0zQm7ckc4uM5Kkc=;
 b=nrRtUmq4swsMGkastabQXWIR7PrFbkS94aPi2FkuDu356nONkUEcoB2yN0S76P8Wcc
 xOI+YGwdb5yJBDWzefQm4SOCjw5V2soIEV2ZPTGPRagn7IW8apfut3jY2fHvfAd9hfk3
 zYsC2yRIMX+QOfyLGFBZJ5DcqRaxMbwy35vQXAojjhUfVXJIvWkvw8cGk1sUYYnV++mm
 wXUdZDxiFdyGflzXPF6k/BUuJLPL2aoG9kHAflXhFs07Am+NvOo2c7DxF0QrlAJS8tJ4
 Aa7gG/s1agrIeRXxrHnPyEzAhN8zyimsRPdBEpZ2nbMe3/b2qqUX13kWseaUvyNgYSNW
 Izhg==
X-Gm-Message-State: AOJu0YxHzMUeBsTg8e4j9Rtk7CoGVpamTTu4atrPQV5egKfx/cueueyQ
 qEXfCJDaZ2FWOudyXrsFQzq2AooegFnQCucXZNXtEbofDxdOvcSL/2goeTEQUB74P83Ndk5wPnX
 VZ15zP1OChXapCVsmWFgIn3XUrBcTyjg=
X-Gm-Gg: ASbGncsZsFLwhsgAK/Xw82cSR+q+wOir9omIBKwfjgDSEhvnxKk7QQ5WK8JIjCh2yng
 iXRH0f0o4gR5Ypo/EL0jsX+Im479KM9aRxf6heM/SXpggORuRXdV5NNO8dK/9hg9obHZgPWerU8
 z1eylsItSja2kgi/+bwQWsF9WBWz3ofg6E9uyxMc+uOzRA1/N/zcwXBEG3xYNpRnlo+RzIVVNAs
 cIOrE8=
X-Google-Smtp-Source: AGHT+IHwSIxjZpqZUb5WrMrY1bzyTQUBYE/q/beiNx9VIHcjmp+gVvqxBNC9JS4H8F3oR8WEbPw+h1zhxo6uW20dtcQ=
X-Received: by 2002:a17:903:1207:b0:24d:8d39:d2fb with SMTP id
 d9443c01a7336-2516fdc7599mr66269045ad.3.1757352983182; Mon, 08 Sep 2025
 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
 <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
In-Reply-To: <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 13:36:11 -0400
X-Gm-Features: Ac12FXxe-qqj7bSaiv7WfLiyueb2Ht3CfIcUMlz0Ku_77OgyB40E4cZpOIiiBk4
Message-ID: <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

@alexhung@amd.com@Wentland, Harry
 Were you planning to pick this up for this week's promotion or should
I grab it?

Thanks,

Alex

On Wed, Sep 3, 2025 at 11:27=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
> > On Mon, Aug 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > When the EDID has the HDMI bit, we should simply select
> > > the HDMI signal type even on DVI ports.
> > >
> > > For reference see, the legacy amdgpu display code:
> > > amdgpu_atombios_encoder_get_encoder_mode
> > > which selects ATOM_ENCODER_MODE_HDMI for the same case.
> > >
> > > This commit fixes DVI connectors to work with DVI-D/HDMI
> > > adapters so that they can now produce output over these
> > > connectors for HDMI monitors with higher bandwidth modes.
> > > With this change, even HDMI audio works through DVI.
> > >
> > > For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> > > with the following GPUs:
> > >
> > > Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> > > Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >
> > Makes sense to me, but would be good to get input from display team
> > in
> > case there is anything I'm missing.
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> @harry.wentland@amd.com or @alex.hung@amd.com Can you guys please
> review this patch? Thank you!
>
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > index 827b630daf49..42180e6aca91 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > @@ -1140,6 +1140,10 @@ static bool
> > > detect_link_and_local_sink(struct dc_link *link,
> > >                 if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A =
&&
> > >                     !sink->edid_caps.edid_hdmi)
> > >                         sink->sink_signal =3D
> > > SIGNAL_TYPE_DVI_SINGLE_LINK;
> > > +               else if (dc_is_dvi_signal(sink->sink_signal) &&
> > > +                       aud_support->hdmi_audio_native &&
> > > +                       sink->edid_caps.edid_hdmi)
> > > +                       sink->sink_signal =3D
> > > SIGNAL_TYPE_HDMI_TYPE_A;
> > >
> > >                 if (link->local_sink &&
> > > dc_is_dp_signal(sink_caps.signal))
> > >                         dp_trace_init(link);
> > > --
> > > 2.50.1
> > >
