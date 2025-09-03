Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED95CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 15:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA10C10E8C0;
	Wed,  3 Sep 2025 15:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7PmwQQ9";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05C210E8C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 15:27:52 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-61edf1686ffso990202a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756913271; x=1757518071; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ditTHevfAFl04TzL82CywYFerkMVjz/mcI6Br/WZ4Dw=;
 b=k7PmwQQ9fdhK8Lsvr8U5A9Vuab0PG6WeVl6ZYHifsbWdMrF+FgtXMRD2cvmdXbr5rg
 UQ8IeeswIZoZj6E7zzMckhW1csQ6wvxheJnWsWvdBs2ScJqeDb6VplVDN1NBUrQt2T4L
 I8jBhW+qWAac9w/yxaDjjTAmnwbXv/0mrpdkDpaIw7wkyu5cnIQRZbGjchkGSdR0Yv4q
 +go84o7IziH5rsYezzgjn7G8bm+S7oqnPXwqW5vr1HEVUoUcl9O1ul3KFz1SMLzObI9U
 uVyJrPXPdK+XG4JQqeOpWalnzvC1DFrESaLCbky8mgzekEaSIm6Gb9ibBUPk2+gbNzJO
 ww7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756913271; x=1757518071;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ditTHevfAFl04TzL82CywYFerkMVjz/mcI6Br/WZ4Dw=;
 b=O0hWkK2ZMv6VQkjCrJ1d3YCiJX6P2Vfqm895ERZb4zUlTkK/7PADPFaNoI00PS+q3V
 ubXlezUktwKuRUw2AI3T8RDn412bxparDG9+EUiyKSJ9Qhxz6hS4NoJqp8rSAramC7uZ
 pBCfDYLtAAtZfHGOysP5mFKEAqMjMSmTvBfj/IeFUs5hVj9Pc2nVDciAtkGV5jWMPWkH
 CckHZ2NONIN40pxqPnw0AxDnZx25auuNJFMRkCFqeOXAtoharHiFWTvbPAYmdPBg8j7B
 FTIWq/R5Kiar1pVFEPN4soNXeKsWGhDiHXBsZq0cqjsXwRoX+fgKS9Vq/2KTpj/eirHT
 7BdQ==
X-Gm-Message-State: AOJu0YzOAEQpOzsAx++8QwkP4GZGxhppHqBSN+kmdNHgodP+Vo6xPVhm
 JY9U+zx9DcqOABiYrAyaU1hc+mp6r2TrZSnVWv0J9UZk1jO727aKSowl
X-Gm-Gg: ASbGncu2LuCT3W2iPtIE8obMtjJ/+6SsApprw7ZAckYJACqaKDSRLn5zU4GZDmzanq+
 9zFyybfhaTv6wChS6ihROuTijkZaJbmhPm3rYT4HsDFjeiW7xGSawK6YDRVjNW+KXjwdrr9DTwn
 7WZUsnDZx1YFJfarVg/vTD9DjCc7O0ZWhMxnquwXaWFM60LndjpQ47YIAHBk4UujyJt9WyxgeMf
 zX931UVbwLu0UqeADWJspN715HCc5IJ9UCrCl8JajazUm17uKjOPpNNTtjbnVZuzt25bjRSDv6j
 a3/Uz/Xd0LbwkRdkUX1V2+yKYh8h8BeoKIYLUXWBo9jSOLDYTKzTfa/DCEl5G3MlVJ4W24f2Drr
 rCn1m+CQ05+z0UBNWKDEuq5t4ckWo6d7zH6fF4RfpvfaSt9Uq4ev8PlsS+5zcwkJTLy8=
X-Google-Smtp-Source: AGHT+IHSu3KlY3pY6EyQDiXeZOFdNH8jpFcqN0SUk89Z51seYbd/cVFXMm8D/aaV1320vYdn7sHgKg==
X-Received: by 2002:a05:6402:27cb:b0:61c:5b94:c725 with SMTP id
 4fb4d7f45d1cf-61d26873cf1mr14482436a12.8.1756913270858; 
 Wed, 03 Sep 2025 08:27:50 -0700 (PDT)
Received: from [172.16.22.69] (254C0095.nat.pool.telekom.hu. [37.76.0.149])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61d3174074bsm8964659a12.35.2025.09.03.08.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 08:27:50 -0700 (PDT)
Message-ID: <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
Date: Wed, 03 Sep 2025 17:27:49 +0200
In-Reply-To: <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
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

On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
> On Mon, Aug 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > When the EDID has the HDMI bit, we should simply select
> > the HDMI signal type even on DVI ports.
> >=20
> > For reference see, the legacy amdgpu display code:
> > amdgpu_atombios_encoder_get_encoder_mode
> > which selects ATOM_ENCODER_MODE_HDMI for the same case.
> >=20
> > This commit fixes DVI connectors to work with DVI-D/HDMI
> > adapters so that they can now produce output over these
> > connectors for HDMI monitors with higher bandwidth modes.
> > With this change, even HDMI audio works through DVI.
> >=20
> > For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> > with the following GPUs:
> >=20
> > Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> > Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Makes sense to me, but would be good to get input from display team
> in
> case there is anything I'm missing.
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

@harry.wentland@amd.com or @alex.hung@amd.com Can you guys please
review this patch? Thank you!

>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > index 827b630daf49..42180e6aca91 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > @@ -1140,6 +1140,10 @@ static bool
> > detect_link_and_local_sink(struct dc_link *link,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A =
&&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !sink->edid_caps.edid_hdmi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink-=
>sink_signal =3D
> > SIGNAL_TYPE_DVI_SINGLE_LINK;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else if (dc_is_dvi_signal(sink->sink_signal) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aud_support=
->hdmi_audio_native &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink->edid_=
caps.edid_hdmi)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink->sink_=
signal =3D
> > SIGNAL_TYPE_HDMI_TYPE_A;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (link->local_sink &&
> > dc_is_dp_signal(sink_caps.signal))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dp_tr=
ace_init(link);
> > --
> > 2.50.1
> >=20
