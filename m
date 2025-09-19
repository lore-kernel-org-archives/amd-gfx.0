Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5581ECAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 15:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF6010EA39;
	Fri, 19 Sep 2025 15:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZ9t2fFo";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D0710EA39
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 15:20:52 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45f31adf368so15848185e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758295251; x=1758900051; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XUNzm2y2m33f/1luH1mQKp6uRXVjAcVzBqklxYkIhoE=;
 b=PZ9t2fFoWhihcmoMekkLZV7AHdNNj7eCBd1fv0l9rYICaz90956Ob6hTeGi8d3euP/
 bBaOJ+gzXFG115PE1vgTmPk1nSMefLQhlxpAzDzRGx1Uh1Y7WnwgFR1LGnVx763BIOzt
 wAve60ky2tIQ6ha5XnpPiM3oMvjuwO0B2YziByaQImt5zWVK+bfN+meP8ZXjmFG+hHQl
 c6fpYgEhoqMHYdHPB/nw/iRczM7b9zZA1sM/mHG84T3mzdi06fDYlCv8MefZwBLGQ17k
 B9vRaorWTNuYs3MfvRDJtRPVYzsrUVkclKC3ab/clURIbRVWWOX6kXkNsVXit0/WmO/8
 itsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758295251; x=1758900051;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XUNzm2y2m33f/1luH1mQKp6uRXVjAcVzBqklxYkIhoE=;
 b=AxiMZ7x/Ek3KxpB4FkKIvYcDrpAa5tK8bbkjGZLOGCPMwjHzboPzRl0t9gRQno52rS
 CpwVKYC2a+6owAeeY2jYib1321Ck3gCq6/xwAEQfl4BlStxpJQPnmpKdqNxzV/JG6/qP
 6ekcG/A3MfNmf927PwLpmSh8HWn5TObNwolr/8K68vX+4erkFi4nBW+s1S2EAfRUVK4i
 HFEqWGjv4zo8BR/LSDO1PUFQAbschgfi7tJ01mm+3X8EUgGK0OoFp+opZjvaYgxlHlHT
 bV/vWtYWPrQP0D/k9hLMBOJVeLVyo3Oo+SetZYrXwjOMosaFpu8fOB4WWdgPmup+DE74
 /Y2w==
X-Gm-Message-State: AOJu0YyOMFPNkldtPPPSTkQ2nXPQkuZkAZM/U3xGNuUC2zGXCUD+xBMR
 V1bUjncPT/E7YUk3pb5tKmw+1teAueJNRnpsINufCVE0g4YQN9qokL0VClBuYQ==
X-Gm-Gg: ASbGnctaeYDHuZ6jhSe5cx+nBzB/+GLTHXvuWGwGoXb8gHy+HydIDQtqTtJVJTq2ddc
 HkCU1RcX4hfy0fjEyimsD5XFKdSVo2gpDieok6CpuOaqh12h6+N+cp4jFG026cz8K0iJqmyjK6+
 zsgtiiPG4WxVGR6dL4apR0FWqWN54k7aAaqdOQ7fh8u1IezLp32a0QB07O8GSTcCFds3dUbDR+z
 zW2eZ2n/OJ0uHyTOdibm9P1/8W2GP6hBYA4xofQhAVPiZ1UEZEWmwzWJmo/z1R0Y+zamwZ2dGZQ
 5LP24aVpbsZvqoBcxr4gfbmZViUppEgSSQJA00SHoYAGMU50RqjsIkivYGAHntt2DclgwEE+Fs4
 WL+oNrsIBuh+fD16DX2nry3sgfstWaPzI2KgNrbBcHXmXnwN0LdtLlGY1Yl/eHQiCzPZMPWagte
 o=
X-Google-Smtp-Source: AGHT+IGF71w0yANXCOsDouBI1SooDLwoWnOgW8por4l7GcP1es1Kyuhpt43QLYwvl/okKXVnCVGRlw==
X-Received: by 2002:a05:600c:444d:b0:45f:31d8:4977 with SMTP id
 5b1f17b1804b1-467ebbbfbd2mr35094515e9.30.1758295250195; 
 Fri, 19 Sep 2025 08:20:50 -0700 (PDT)
Received: from [192.168.101.182] (catv-178-48-232-92.catv.fixed.one.hu.
 [178.48.232.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407ccasm8320144f8f.15.2025.09.19.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 08:20:49 -0700 (PDT)
Message-ID: <45c57fda591a68d7acd5a872047f87becd9cad0a.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reject YUV422 encoding over DP on DCE
From: timur.kristof@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 alex.hung@amd.com, 	harry.wentland@amd.com, siqueira@igalia.com
Date: Fri, 19 Sep 2025 17:20:48 +0200
In-Reply-To: <CADnq5_Pj43m4C2esgH5wVFfbq5rSehSeL-7NkdwHU0ByNSRdUg@mail.gmail.com>
References: <20250919081419.9034-1-timur.kristof@gmail.com>
 <CADnq5_Pj43m4C2esgH5wVFfbq5rSehSeL-7NkdwHU0ByNSRdUg@mail.gmail.com>
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

On Fri, 2025-09-19 at 11:09 -0400, Alex Deucher wrote:
> On Fri, Sep 19, 2025 at 4:14=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Mark YUV422 unsupported over DP on DCE to work around a
> > regression caused by the recent YUV422 fallback patch.
> >=20
> > See https://gitlab.freedesktop.org/drm/amd/-/issues/4585
> >=20
> > The recent YUV422 fallback breaks DisplayPort on DCE6-10 because
> > it can select a high refresh rate mode with YUV422 and 6 BPC,
> > which is apparently not actually supported by the HW, causing
> > it to boot to a "no signal" screen.
> >=20
> > Tested with a Samsung Odyssey G7 on the following GPUs:
> >=20
> > - Cape Verde (DCE 6): affected
> > - Tonga (DCE 10): affected
> > - Polaris (DCE 11.2): not affected
> > - Vega (DCE 12): not affected
> >=20
> > Polaris and Vega are not affected because the same mode
> > gets rejected by other parts of the code base, possibly the
> > bandwidth calculation which exists for DCE11+ but not older HW.
> >=20
> > It is not documented whether YUV422 is actually supported over DP
> > on DCE, but considering that this encoding was never used before,
> > and that YUV420 is already marked unsupported, probably not.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Fixes: db291ed1732e02 ("drm/amd/display: Add fallback path for
> YCBCR422")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4585
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> Would be good to get feedback from the display team on what the
> actual
> capabilities are, but seems reasonable to me.
>=20
> Alex

Thanks Alex.

I prefer not to add the Closes tag, as this patch doesn't really
resolve the issue, it's just a workaround that I came up with until
someone who knows better can properly fix it.

The proper fix would be:

1. Determine which DCE and DCN versions actually support 422 over DP
and HDMI, and add new fields to the encoder capabilities:
dp_ycbcr422_supported
hdmi_ycbcr420_supported
(I didn't find this info anywhere publicly, but can I can help write
that patch if someone from AMD confirms which DCE/DCN versions support
422 and which don't.)

2. If it so happens that DCE actually supports 422 over DP, we should
determine why this mode doesn't work. (I suspect that it was rejected
on Polaris and Vega by the bandwidth calculation.)

3. If the current link encoder doesn't support 422 and/or 420, the code
should not even attempt to use them.

Thanks & best regards,
Timur

>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > index 0c50fe266c8a..686f6be68c91 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > @@ -798,7 +798,8 @@ bool dce110_link_encoder_validate_dp_output(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dce110_link_enc=
oder *enc110,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dc_crtc_timing =
*crtc_timing)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (crtc_timing->pixel_encoding =
=3D=3D PIXEL_ENCODING_YCBCR420)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (crtc_timing->pixel_encoding =
=3D=3D PIXEL_ENCODING_YCBCR420
> > ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 crtc_timing->pixel_encoding =3D=3D
> > PIXEL_ENCODING_YCBCR422)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return false;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > --
> > 2.51.0
> >=20
