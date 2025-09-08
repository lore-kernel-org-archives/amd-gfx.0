Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276C8CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 17:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C376410E59A;
	Mon,  8 Sep 2025 17:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G6H5bpBv";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D3C10E59A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 17:45:59 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7728a8862ccso4054129b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757353559; x=1757958359; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ASbZTkERMV4TSSI3t+VtlXmTLTFyKfyAc5D9NkjMPoU=;
 b=G6H5bpBvem9sNW3dBPqwrCxlGfD23vSQna9oD25Dm/bevdoyaIr8Y1TApbbqAX7hk0
 JkI+JA8ku+Ljz2Qf4/Jp12glYKTWAdKUTfYXeurgGB0kVRFLnzpuwBaUmMISTcIDwiVY
 3PnlyN58mSDZs08TWqcmw9HNlGPDrqOJg4Hm6YvXdOnSOdpSajaKVk1nf9ZjmnCZtvpD
 kCpEvulFGmSLnS6ePNsZo4MpoiQ0+RalyuHx6Hizaq6GSDF204dXVttT2HXk9v7fr6qj
 V3u90EMT1LOqQNwBvvbLEsK5LC6D+M20GlNPb0QgxKnLVBsrMYHuQkqU4Njd4+ZmmzDP
 tdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757353559; x=1757958359;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ASbZTkERMV4TSSI3t+VtlXmTLTFyKfyAc5D9NkjMPoU=;
 b=O05Ip05kMYXrBc9UzDhFn/W0jFENqnTuBhl93jU5vRVZFOCqST7y0wHSN8fnZbOjxp
 715mbBJ3kvWwfttT16D7GYlJcCBVHo550y2kl7fcIz55897HKwAzmPQYh4gLPcuZzDqv
 STp3OWE4o8Jdt8GTOfMoknKBgagGfuj0WYoRpSKDfU9mX619L0mf5l9G0rap5UWL0Hwn
 oO4tC1UE8RuJ4Rj+PeL85mf+g7+tQTUxaPxsvDo6JApRXSmFMbMohSNWH0/ydnUzyKM/
 gyrycIoYVts/zwEnBHbrpSxs8/rNMXyMgf4aKgbhYIxs9YMeg/8S16EaPSYbT87FcU8L
 VBkw==
X-Gm-Message-State: AOJu0YwH9s34tr0+kKkQs9ufhictPN0nG7Y2aESjs1aPEZ893Ut9FJmt
 KneFOaoxZj/s72eU579opczLFgmwrmxlj1QXhSUWtPs0ZS36TST5Um4C
X-Gm-Gg: ASbGncvt2gZAEBIo01yX7XfEq6EPaK6MJzA9MCcWRxPnqcfqqi6P/BsAHsSZ1BeylqV
 EP6TJFWSNFnuSjV2tWScs4rBWfGIRTNeRqmnwHDcIT8XpH68KBGjLEkJn7YC/ZKgX9wffnmPeJq
 OeKFFe75r8sm48tgVZ52kV6wck1gDe/okYBbytZyWOvHpb9cMzr7zQOBbgEcy3OzDBOPz5Mak9D
 wCj9QFO+lei7mTIdfhBSLB6IVMEqzdJVzq1VbET+/GSrZ4VjHRcJAz2HxPbCDVRbgxSfnEB1bsH
 CpBUI6B/IhZyc/t4H+KRs6cjGU9vf/wy+bfgczGNiPTrmf1SMm7hXxkSg46pbeAfAvegu5gEtuE
 PxqIrds+nP5vhPY/eXD7WdfTMuF1dglL5NHt79zRnbIe4sYc+FnMZnk7R+jA8eM9334N0QAS/wk
 Q9ykFySbqrVCakRccDk2Bu+SEs/fpRQmQw0Nk63qrHTFe0rPLu+uHZLMTpwRK4ckCNqvNyypfWX
 sH8lf/raXI=
X-Google-Smtp-Source: AGHT+IHZtmpSao+ynxI6+PzSa/9b5BXcbxsbz4UrjauZcF2vsZYCrXv+WY2hzDskjy8ZlOIY7UOAWg==
X-Received: by 2002:a17:902:f68c:b0:24c:e3c0:936b with SMTP id
 d9443c01a7336-25179688478mr111110075ad.22.1757353559140; 
 Mon, 08 Sep 2025 10:45:59 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2?
 (20014C4E24D7A1006CBC3A09AC015CE2.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24c860066d3sm152034845ad.71.2025.09.08.10.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 10:45:58 -0700 (PDT)
Message-ID: <29046ec704624b7a65cfa1bb4c0511472ba78912.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Hung <alex.hung@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com
Date: Mon, 08 Sep 2025 19:45:51 +0200
In-Reply-To: <44b39851-9775-4bb8-9558-3cd4f298120c@amd.com>
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
 <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
 <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
 <44b39851-9775-4bb8-9558-3cd4f298120c@amd.com>
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

On Mon, 2025-09-08 at 11:40 -0600, Alex Hung wrote:
>=20
>=20
> On 9/8/25 11:36, Alex Deucher wrote:
> > @alexhung@amd.com@Wentland, Harry
> > =C2=A0 Were you planning to pick this up for this week's promotion or
> > should
> > I grab it?
>=20
> I will send them to weekly DC promotion.
>=20
> Thanks.
>=20
> >=20
> > Thanks,
> >=20
> > Alex
> >=20
> > On Wed, Sep 3, 2025 at 11:27=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >=20
> > > On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
> > > > On Mon, Aug 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f
> > > > <timur.kristof@gmail.com> wrote:
> > > > >=20
> > > > > When the EDID has the HDMI bit, we should simply select
> > > > > the HDMI signal type even on DVI ports.
> > > > >=20
> > > > > For reference see, the legacy amdgpu display code:
> > > > > amdgpu_atombios_encoder_get_encoder_mode
> > > > > which selects ATOM_ENCODER_MODE_HDMI for the same case.
> > > > >=20
> > > > > This commit fixes DVI connectors to work with DVI-D/HDMI
> > > > > adapters so that they can now produce output over these
> > > > > connectors for HDMI monitors with higher bandwidth modes.
> > > > > With this change, even HDMI audio works through DVI.
> > > > >=20
> > > > > For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> > > > > with the following GPUs:
> > > > >=20
> > > > > Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> > > > > Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
> > > > >=20
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > >=20
> > > > Makes sense to me, but would be good to get input from display
> > > > team
> > > > in
> > > > case there is anything I'm missing.
> > > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > >=20
> > > @harry.wentland@amd.com=C2=A0or @alex.hung@amd.com=C2=A0Can you guys =
please
> > > review this patch? Thank you!
> > >=20
> > > >=20
> > > > > ---
> > > > > =C2=A0 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4
> > > > > ++++
> > > > > =C2=A0 1 file changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > index 827b630daf49..42180e6aca91 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > @@ -1140,6 +1140,10 @@ static bool
> > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sink->sink_signal =3D=3D
> > > > > SIGNAL_TYPE_HDMI_TYPE_A &&
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !sink->edid_caps.=
edid_hdmi)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sink->sink_signal =3D
> > > > > SIGNAL_TYPE_DVI_SINGLE_LINK;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else if (dc_is_dvi_signal(sink->sink_signal)
> > > > > &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aud_s=
upport->hdmi_audio_native &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink-=
>edid_caps.edid_hdmi)
>=20
> nitpick: probably need extra spaces to align with dc_is_dvi_signal,

Thank you for the comment!

The check patch script actually warns against using spaces and tabs on
the same line, so I wanted to avoid doing that.

I couldn't find a clear guideline on how to format multiline
conditions, so I just aligned them to the other conditions that were
already here.

> but=20
> I can fix it manually after this patch passes promotion test.
>=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink-=
>sink_signal =3D>>>>
> > > > > SIGNAL_TYPE_HDMI_TYPE_A;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (link->local_sink &&
> > > > > dc_is_dp_signal(sink_caps.signal))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dp_trace_init(link);
> > > > > --
> > > > > 2.50.1
> > > > >=20
