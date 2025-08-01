Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ADDC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3023D10E49B;
	Fri,  1 Aug 2025 08:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZK2aBQPe";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8C110E49B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:39:57 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so12223175e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754037596; x=1754642396; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEAGgytGciENH9M1JCeUiwpy1wpDMWrhTCh0b+w4GA4=;
 b=ZK2aBQPeApl9jCvvE2kSJfsvB+0z2Rh7BsLpVRk6f6+6UFBvEohM+ZY8YWMF646k+1
 fyPI/eZeakW0Zxms/gbdbR532avSnt88csW60Qcfybwar1A/cRtrUmHgbEt21z1fXvtq
 h5nhj9rvsEJrCbj1kV28mHeTy3NCFTMxOgwdffIM69aEAWL/VPBRk8dh3OJnvUpD3qYM
 b11aHixIPqIBCYRXMgKUBLfGWW5PsgUhDkOZ5uLN54/1t+zto5V9vg3Nw51xmdwIC1ol
 H20FAWM62obgc+CKpayFc881hyuu+U8mtoild8BwfaHtcOxvK5H+b+Odod3w+/302Lu0
 c+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754037596; x=1754642396;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEAGgytGciENH9M1JCeUiwpy1wpDMWrhTCh0b+w4GA4=;
 b=gWAk6LiwFWhTNQH1hhPgU5Qg7PxMP3zHdExkpKRlGRcRwtNaEyAHpI7GT5zs/CNj6N
 PJGIkPDnPLGzZFly1d4E4sipmuqUzuYkVwP+ACCw/6x9rOzIhcl2H5yDWvsQSxYp5D0F
 QKwAugLRWNsApaAGPXF65I/V+CKakoyMrJC5tK9MSCh3qivpmQd4IBlTEUMM4uD0tX4R
 IfxDlFAeBvF4yyisAEbEYaggfm35t/d9qmrZg9eLMSojQOmDtMQKEuVqf+YaJkVA0rfq
 6xnXL3LlPUj+5nsDEmxIlLuHG7xqfTywk/Q1g/wWlzEr6iDiZRUc/VZ14HAZnTVPeuvQ
 VL9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr6jmgw09h+RGKEXMJT4RxxEa4fUy/usWKHits6x5uQX/Rl3SaSHKFaS+ON6x/i2IeKBKIb/Sh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzD+enl49H1X0woIoO+fgQ2gzcFnYJJMeg1Wg0D+IrxsUaaMDRQ
 bMHbhjIglktPlL28jHgtxjc6HT9ttKD9jor1XdkeQRfMEI2cqJ2oCqKn
X-Gm-Gg: ASbGncs+LqRYQmj6elkTZnU+iXNHCai//4Zk3IIympA4C2ALTg50X30MJVVX+XdXnYA
 TcgtE2P7T/ezN7ylkK1vRbEP80An/Oiu78Obna5m87Gv6CLtNp7EFjZUqSFRdnWeCDTyq/HDQVz
 6jEXCNuSGL8Tm4v+qfooNCU5I0u6FLcUgqUHI8bkLxOfYleo6zBY35QwwvnPpCWMWi04z5NtLKl
 CkOSOPTagBPs6olsuxWPbH1cUy3nLYh6ZCw5StEC43HI1WVKmmr/J9nGttoXJEaY8rJ3+IgkpDN
 1o0Y8G1x+mAMSPInTGZ2dJDI46lvtNcYDSnW7WqvBc+hLkpENhvok9EoJho6g/YU83wfakdrhSV
 ZR6uNu0A1zJs5VwCFWpql+7W9EV//bz+oYPFzjSIE4PWPwJMKDooRCL4UGrqMUFSBuNxd9QiQCe
 CQyHeyXRgOQ0jrpb+4iPxdVjo6fC9zUa5oqCZ0ZB5o/vb4f+zqbwt7StHxno0aUh2h4dqDTie2
X-Google-Smtp-Source: AGHT+IGH266A7axX437+S+5MQnSi4zTZ6YbA23F+JJmnTRqIHxhjnb0AYkExsdbG8Rki40TGKyrJtA==
X-Received: by 2002:a05:600c:3502:b0:455:f59e:fd9b with SMTP id
 5b1f17b1804b1-458aa45a5b5mr13569855e9.24.1754037595870; 
 Fri, 01 Aug 2025 01:39:55 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24dd:b700:267c:66b8:50a0:e369?
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee57c18sm55849135e9.28.2025.08.01.01.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 01:39:55 -0700 (PDT)
Message-ID: <0942ca2451ec8614835a9a56a3e0725ecb0aa6d7.camel@gmail.com>
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio
 on RGB signals
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: alexandre.f.demers@gmail.com, amd-gfx@lists.freedesktop.org
Date: Fri, 01 Aug 2025 10:39:54 +0200
In-Reply-To: <1ce09488-0384-4d88-a1eb-cdff89c0bed1@gmail.com>
References: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
 <1ce09488-0384-4d88-a1eb-cdff89c0bed1@gmail.com>
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

On Fri, 2025-08-01 at 03:19 -0400, Alexandre Demers wrote:
> > On 2025-07-30 13:08, Timur Krist=C3=B3f wrote:
> > > On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
> > > >=20
> > > >=20
> > > > On 2025-07-30 04:19, Timur Krist=C3=B3f wrote:
> > > > > On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > > > > > > Features like stereo sync and audio are not supported by
> > > > > > > RGB
> > > > > > > signals, so don't try to use them.
> > > > > > >=20
> > > > > >=20
> > > > > > Where does it say that?
> > > > > >=20
> > > > > > Harry
> > > > >=20
> > > > > 1. Audio
> > > > >=20
> > > > > VGA ports (and the analog part of DVI-I ports) simply cannot
> > > > > carry
> > > > > audio. So there is no hardware to control any audio,
> > > > > therefore
> > > > > there is
> > > > > nothing for this code to enable, which is why I added those
> > > > > ifs to
> > > > > not
> > > > > even try to enable audio on analog video signals.
> > > > >=20
> > > >=20
> > > > My bad, I was thinking RGB as opposed to YCbCr. Forgot that we
> > > > use
> > > > RGB signal to refer to VGA.
> > >=20
> > > Sorry for the confusion.
> > >=20
> > > >=20
> > > > > As a side note, DVI-D ports (and the digital part of DVI-I
> > > > > ports)
> > > > > may
> > > > > have a non-standard extension to carry digital audio signals,
> > > > > but
> > > > > that
> > > > > is not revelant to supporting analog displays.
> > > > >=20
> > > > > 2. Stereo sync
> > > > >=20
> > > > > With regards to stereo sync, I didn't find any reference to
> > > > > this in
> > > > > the
> > > > > legacy display code, so I assumed either it is unsupported or
> > > > > the
> > > > > VBIOS
> > > > > already sets it up correctly. At least, considering that the
> > > > > legacy
> > > > > code didn't bother setting it up, we don't lose any
> > > > > functionality
> > > > > if we
> > > > > leave it out of DC as well.
> > > > >=20
> > > > > That being said, upon some further digging in the DCE
> > > > > register
> > > > > files, I
> > > > > found a register called DAC_STEREOSYNC_SELECT so maybe I
> > > > > could
> > > > > investigate using that. Maybe it would be better to work with
> > > > > the
> > > > > registers directly instead of the VBIOS? Would it be okay to
> > > > > investigate that further in a future patch series once this
> > > > > one is
> > > > > merged?
> > > > >=20
> > > >=20
> > > > I don't think DC supports stereo sync currently. I'm not sure
> > > > there
> > > > is
> > > > much value in pursuing that.
> > >=20
> > > If stereo sync is not supported, what does setup_stereo_sync()
> > > do?
> > >=20
> >=20
> > My bad. Not sure then. But no objection if you want to explore it.
> >=20
> > Harry
> > > > >=20
> > > > > > > diff --git
> > > > > > > a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > index a10d6b988aab..825a08fcb125 100644
> > > > > > > --- a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > @@ -118,6 +118,11 @@ static inline bool
> > > > > > > dc_is_dvi_signal(enum
> > > > > > > signal_type signal)
> > > > > > > =C2=A0	}
> > > > > > > =C2=A0}
> > > > > > > =C2=A0
> > > > > > > +static inline bool dc_is_rgb_signal(enum signal_type
> > > > > > > signal)
> > > >=20
> > > > To avoid confusion with people that haven't worked on analog
> > > > signals in years (or ever) it might be better to name this
> > > > dc_is_analog_signal.
> > > >=20
> > > > Harry
> > >=20
> > > Sounds good, I'll rename it in the next version of the series.
> > > To further ease the confusion, what do you think about renaming
> > > SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?
> I think Harry hasn't answered your proposition. I must say that the=20
> first time I looked for VGA in the legacy code, I stumbled upon the
> RGB=20
> usage. But then, it began to make sense (I'm not completely sure if=20
> signals and connector types are used properly everywhere), because we
> are mostly translating DRM signal types to supported connector=20
> types.That being said, while both dc_is_rgb_signal() and=20
> dc_is_analog_signal() could be used here, we are specifically
> querying=20
> the signal type and this signal type is RGB. Because of this, I would
> be=20
> in favor of keeping dc_is_rgb_signal() unless there is another analog
> type that could be queried and not rename SIGNAL_TYPE_RGB to=20
> SIGNAL_TYPE_ANALOG in any case. Cheers, Alexandre

Hi Alexandre,

I think the confusion comes from "RGB" being a very overloaded term in
this space, so I am in favour of clarifying the name. I am open to
suggestion as to what is the best clarification. If you want to keep
the "RGB" part then I propose:

SIGNAL_TYPE_RGB -> SIGNAL_TYPE_ANALOG_RGB

Which should make it very clear what it is.

Otherwise, I would like to apply Harry's suggestion to name the new
helper function dc_is_analog_singal. Considering we don't support other
types of analog signals, I don't think there is any confusion with
that.

Let me know what you think.

Timur



> > > Thanks,
> > > Timur
> > >=20
> > >=20
> > > >=20
> > > > > > > +{
> > > > > > > +	return (signal =3D=3D SIGNAL_TYPE_RGB);
> > > > > > > +}
> > > > > > > +
> > > > > > > =C2=A0static inline bool dc_is_tmds_signal(enum signal_type
> > > > > > > signal)
> > > > > > > =C2=A0{
> > > > > > > =C2=A0	switch (signal) {
>=20
