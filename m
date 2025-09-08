Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD8FCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 18:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D5210E5A2;
	Mon,  8 Sep 2025 18:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWv4j1V9";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100910E5A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 18:04:23 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7723f0924a3so6264222b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757354663; x=1757959463; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N3Yi+x/nPbKm4KgnW3DrONQIjrems/Bw17BcpL69EM8=;
 b=UWv4j1V9JZY4/ujvqJPcJ+AWo1W6dc8vlb0i28GoQrekH8iUWGyD+ZzFU4GnyYM1Br
 oh1oLr/SfuOWkhuQG1POTlBjNXqB3/d9yP2fhfEcaodo8G85ofoerlYifh3fYysyJOmU
 0TivntkR9yr6ZVcm53V1oSQxwPxLYVJWXlnXxupSUyjafDJcX8kdk7keNfxF2Z9lBb+5
 HDh1xa7w8Y0rrJsioemUEaGcv6xQ7aYLPx2aupvbDqOrYiSMHZvDGhHlezxp60jXrYIM
 PFwWOq8H1vunYwUgEc0gL23rhQvieCICvRBXqJkt6WiiIHDUX+l0/M/Fc99Y60HY3R2x
 F9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757354663; x=1757959463;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3Yi+x/nPbKm4KgnW3DrONQIjrems/Bw17BcpL69EM8=;
 b=EKpo0avobv96WUjIucXcT2lj4epZdn/0AyMnG1Y2RGexSmxXhvVuuZvr+xBtuFpYBH
 erV+Ie9s7q6erG1q3uxmIO6FQiEVRKoCiToCovSbeHHVNuMiO139D0905TKmrB7qvQRP
 M/s+DVBos88GSz+rsEoUhH6wPca1L+jY93V5snP9NKjOxyGe5hEXC0l2tW5txfhY3+dr
 IM2muSx6uzNNVRiTRirseKkdLVgwzcD/5W9Tscr7aLunwW8SYdKhevUUWS76L81TKNmm
 kErq0r2iI/jeFchhJgEgEu99YIB29/cS86BUNeHCm589e/ncFRToVQoHH3jVtJSIErsq
 4IGQ==
X-Gm-Message-State: AOJu0YxOIwrypcTnE49llRK30dbc8KS1wt0oGfEJKDgDZWJ8DD8c7/a/
 0xz4hZ5KJPx10uCUyVb+ui/rASqYSeV95lxtOwG8VQsbgM69qge9gvFjN9ZthQ==
X-Gm-Gg: ASbGncvirMbu6CE2vBYDiGQwkI4UxA72QEVwnoA01oAfCyV3aexY1zgDzqBBBbU9mK+
 i/syf0y+y+JyObvTnCQtL+gOL/mJF/54ZIA22yL7zfBPgPwxrwS1PsOl+Jd9Ge6TUWsaW3kDUha
 8RA2oxdvhmBSWE5/g6dlNPjPyFwvRctFJ6v+257qyaXED6LRjTjjs4sRRypNxhIj6zYmGnduCNp
 +3DLGMyiQAkBu8aGJYCRXAIrupBCq6lKtEZ11P4huQJsQ0UOmMPMWIL+GfqlKp1/R9gGEbkjYqi
 VSRuXTrwZgXQnWTeNfYCm9r2TYFrJYiydO6H8F7xG/Do4lJKU3hdwn/Srj9PVmi0XvwaXpQYtDb
 H7NmG3793XV5HEgD8guDgDLPtiZ3FeR4SIkRKaX2SxxYiR1c7fEK0GjtqMX27+qp+h8qHcrx5yo
 Ouuu6O5AXzsSoBamzQobHlTF+OI0MOGAqGfbwY/MfJzFiJolRnjYDmlT3SLXG7GpZ70N1HGa1P/
 2zyKObCiws=
X-Google-Smtp-Source: AGHT+IF5SGouQ6nyI+Z4MzcFupoXXT6jzpAvFO9B87aeZH6hGAz2TMnMRA06K3Gp/ZbX7ngCFhZ5nQ==
X-Received: by 2002:a17:902:e489:b0:24c:6125:3928 with SMTP id
 d9443c01a7336-2516dfcb600mr71202765ad.14.1757354662469; 
 Mon, 08 Sep 2025 11:04:22 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2?
 (20014C4E24D7A1006CBC3A09AC015CE2.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b0d881afasm186689725ad.47.2025.09.08.11.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:04:21 -0700 (PDT)
Message-ID: <a9d4549830f67e8efa57a1fe70ec23a00180c6fb.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Hung <alex.hung@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com
Date: Mon, 08 Sep 2025 20:04:16 +0200
In-Reply-To: <7af4f869-ade9-4b33-a3bc-6ab565ae311b@amd.com>
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
 <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
 <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
 <44b39851-9775-4bb8-9558-3cd4f298120c@amd.com>
 <29046ec704624b7a65cfa1bb4c0511472ba78912.camel@gmail.com>
 <7af4f869-ade9-4b33-a3bc-6ab565ae311b@amd.com>
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

On Mon, 2025-09-08 at 12:02 -0600, Alex Hung wrote:
>=20
>=20
> On 9/8/25 11:45, Timur Krist=C3=B3f wrote:
> > On Mon, 2025-09-08 at 11:40 -0600, Alex Hung wrote:
> > >=20
> > >=20
> > > On 9/8/25 11:36, Alex Deucher wrote:
> > > > @alexhung@amd.com@Wentland, Harry
> > > > =C2=A0=C2=A0 Were you planning to pick this up for this week's prom=
otion
> > > > or
> > > > should
> > > > I grab it?
> > >=20
> > > I will send them to weekly DC promotion.
> > >=20
> > > Thanks.
> > >=20
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Alex
> > > >=20
> > > > On Wed, Sep 3, 2025 at 11:27=E2=80=AFAM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >=20
> > > > > On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
> > > > > > On Mon, Aug 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f
> > > > > > <timur.kristof@gmail.com> wrote:
> > > > > > >=20
> > > > > > > When the EDID has the HDMI bit, we should simply select
> > > > > > > the HDMI signal type even on DVI ports.
> > > > > > >=20
> > > > > > > For reference see, the legacy amdgpu display code:
> > > > > > > amdgpu_atombios_encoder_get_encoder_mode
> > > > > > > which selects ATOM_ENCODER_MODE_HDMI for the same case.
> > > > > > >=20
> > > > > > > This commit fixes DVI connectors to work with DVI-D/HDMI
> > > > > > > adapters so that they can now produce output over these
> > > > > > > connectors for HDMI monitors with higher bandwidth modes.
> > > > > > > With this change, even HDMI audio works through DVI.
> > > > > > >=20
> > > > > > > For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> > > > > > > with the following GPUs:
> > > > > > >=20
> > > > > > > Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> > > > > > > Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over
> > > > > > > DVI
> > > > > > >=20
> > > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > >=20
> > > > > > Makes sense to me, but would be good to get input from
> > > > > > display
> > > > > > team
> > > > > > in
> > > > > > case there is anything I'm missing.
> > > > > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > > >=20
> > > > > @harry.wentland@amd.com=C2=A0or @alex.hung@amd.com=C2=A0Can you g=
uys
> > > > > please
> > > > > review this patch? Thank you!
> > > > >=20
> > > > > >=20
> > > > > > > ---
> > > > > > > =C2=A0=C2=A0 drivers/gpu/drm/amd/display/dc/link/link_detecti=
on.c |
> > > > > > > 4
> > > > > > > ++++
> > > > > > > =C2=A0=C2=A0 1 file changed, 4 insertions(+)
> > > > > > >=20
> > > > > > > diff --git
> > > > > > > a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > > > index 827b630daf49..42180e6aca91 100644
> > > > > > > ---
> > > > > > > a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > > > +++
> > > > > > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > > > @@ -1140,6 +1140,10 @@ static bool
> > > > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sink->sink_signal =3D=3D
> > > > > > > SIGNAL_TYPE_HDMI_TYPE_A &&
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !sink->e=
did_caps.edid_hdmi)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sink->sink_signal =3D
> > > > > > > SIGNAL_TYPE_DVI_SINGLE_LINK;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 else if (dc_is_dvi_signal(sink-
> > > > > > > >sink_signal)
> > > > > > > &&
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 au=
d_support->hdmi_audio_native &&
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
nk->edid_caps.edid_hdmi)
> > >=20
> > > nitpick: probably need extra spaces to align with
> > > dc_is_dvi_signal,
> >=20
> > Thank you for the comment!
> >=20
> > The check patch script actually warns against using spaces and tabs
> > on
> > the same line, so I wanted to avoid doing that.
> >=20
> > I couldn't find a clear guideline on how to format multiline
> > conditions, so I just aligned them to the other conditions that
> > were
> > already here.
>=20
> I did not see any warning as below, but this is a nitpick.

Thank you. I'll keep that style in mind for my future patches.


>=20
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1140,6 +1140,10 @@ static bool detect_link_and_local_sink(struct=20
> dc_link *link,
> =C2=A0=C2=A0		if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A &&
> =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 !sink->edid_caps.edid_hdmi)
> =C2=A0=C2=A0			sink->sink_signal =3D
> SIGNAL_TYPE_DVI_SINGLE_LINK;
> +		else if (dc_is_dvi_signal(sink->sink_signal) &&
> +			 aud_support->hdmi_audio_native &&
> +			 sink->edid_caps.edid_hdmi)
> +			sink->sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
>=20
> =C2=A0=C2=A0		if (link->local_sink &&
> dc_is_dp_signal(sink_caps.signal))
> =C2=A0=C2=A0			dp_trace_init(link);
