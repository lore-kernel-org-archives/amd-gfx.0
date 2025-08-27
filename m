Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86CCCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 14:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E24810E82E;
	Wed, 27 Aug 2025 14:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L42I57fO";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C4E10E82E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 14:39:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7923so1212401f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756305591; x=1756910391; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=voiiV6hakwk7d6qVZDjf2PRdAjU2uNUIGApEH3OcVa8=;
 b=L42I57fO+rYavxPSxAtfFbFTg5Vplf3VbI3VD9B62oz0MzBe2aYHmuVmIaw1o1DAUk
 6euoHiv4uYDjDhhZp2Y4ag3BEq0Rj5nXXs9GIlPGiWWCqulpyRCDoGmcQaELZbYg0Qrn
 2ZqryTa3mqWESYF+I2YTLZ+BYiW+Wv+NfV/vv9+yA+9nq0yu8rXOFqrxU2fdDEKAa+uM
 fv/IlEdmCIVr4KjYQ4U5g/WKKQnHoyArg0lMvMHtLCF1yABwASmtDrScfTFSjhzZomQJ
 6oB+zfFkH1iO+4dJPi/Z+0o2GX4m3UmJbq5dXAgd5CQ4+oWH1VmPZIyKtkjBaNPW+6zi
 O+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305591; x=1756910391;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=voiiV6hakwk7d6qVZDjf2PRdAjU2uNUIGApEH3OcVa8=;
 b=UuHqGkusWJlZmnfBR/BpC4mpJqekR6KPRvlqKBcNO4BBdXcoN4TPkPe4UA14cDIDRD
 EnCX77XxKjGGoWo3AGfbkZIsIP2LrW3d4uh+KPuHlktvFpv+dU4NBMfQ7MhVzJDyWOiJ
 rOmp4Mpw8cOMshaTNRIAqyeUFEFr7TsTX8C0MGFbVfeYTxoKCUGTgs8dXIY1J7oGlQgM
 V3s9lTkWg5Wp2LKqKzxx/Fthkv/qwMEV9P0LdqJiLiX5Tkk7ff+FUAlzBpIyjBLs9ycP
 RcHCN9J0W0JIlIDtxkpvKkXy8U/abhUibN2G/V4NyhM+G7sYzia594lJ/Gx4Th9QVUjS
 bmdA==
X-Gm-Message-State: AOJu0YwzW1CVS7K+tzyxabcDAoEJUiLljCAq7rwH1BdJUZz7lMlnj/sB
 7z1GSZ19BmWO/1voxjqr2akNwvdvi8HqVtSByrusMnl5aAh2soahPA69
X-Gm-Gg: ASbGncsClCXiuhzYwDzXVhBhCqR18u13EnTeUlcKfN4NcAq1PSuijyMEfJOayKHARxI
 Fx/MLT4uJryevlLjUn87CN6e7X5IKeOhndyQ8I2C2G7Xi0xz8MEFP2tTc8veLd/HSksjejU5DWI
 DvzgvNuW6bEpX0TF0MuwNZQprdsguqFKU/wDsxvE3eDsopdxJ4LAB2VnR1LvxzAdDTh1s3tVJH3
 t1DKiXCpR0RA4Obbe0iswk3gOAd2hu0ZbFEvqhYkI0nLwAtXpFfPsC34aCGwaXay/7bK4n4e17n
 lZECeRSJQDTVyu0/L9VSba3J2upK+KP1VmEyijzlgknSqt+1mBKn2F/ubyyaRp6lrOGCCl01IlF
 jn6LPsmObZFrRHla5g3d+GcvDgci6seex+CUQd+ch+MpPC+DuMioJANpDtmcf41SE87rUnCwAiD
 PwUayD0H9kWT3F6RLbvFvGSSj/e8NDf/BFX5ycoevnaaqi4GV3nS+ZXAwafgxUYQ==
X-Google-Smtp-Source: AGHT+IFXpzts2RxwheG9b3wCJ5zzWq0AqurQD4My2jnG2Yax400899ahsqsHMMlWy4cszH4vK/oyWw==
X-Received: by 2002:a05:6000:430c:b0:3c7:a2d5:b299 with SMTP id
 ffacd0b85a97d-3c7a2e4fee4mr11370795f8f.17.1756305591013; 
 Wed, 27 Aug 2025 07:39:51 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:f46e:206e:80c6:1890?
 (20014C4E24E36900F46E206E80C61890.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:f46e:206e:80c6:1890])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cca0dd7014sm3279420f8f.13.2025.08.27.07.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:39:50 -0700 (PDT)
Message-ID: <24bbe97b3a2f97ed1f4dfde727ba6939831bf35f.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
Date: Wed, 27 Aug 2025 16:39:49 +0200
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

Thank you!

I just want to add that the code path without audio for both DVI-D and
HDMI seems to be broken and probably needs further investigation.

I might come back to this problem later when/if I have an opportunity
to test with a display that actually uses DVI-D. Right now I only have
the DVI/HDMI adapter which seems to work differently (as noted in the
above patch).

Timur


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
