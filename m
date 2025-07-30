Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB1CC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 17:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C7A10E123;
	Wed, 30 Jul 2025 17:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O48Rj5yY";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB2910E123
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 17:08:59 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4589968e001so417385e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753895338; x=1754500138; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idyFMQuAvksj/nelnpM5zL01z8hNxeLhzOqGX9o4Bz4=;
 b=O48Rj5yYjMJdySyOCzsFLX/Tli3JTxForSjWk39cTTcw4DEIp2sTktDSlfuogoU0J0
 cxmClDL6KG4AxGTjy0Z94HKDyAdU8IHXdBnDSUKbi8Yd0Rm75B/fHmYFfiBasvOcmgZf
 /WKsmSilt3DqxuZCJbu/l91ACZKX/rXoBw3+zahyoa58tHnCbRdiU0XftSzl95Q1Ifbm
 TTTmBVtfXaWIaHRNTE3t74ACppOdVXigF6tjRS957h/61q4mHE6UfOv8WCi+uu6B2aMt
 0PIaSRb4Nns0PBwzenV6UiibOs2M47t65r0/7Mwu9U4Wiysn/1IkIRngclXYH8nqWFWx
 q/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895338; x=1754500138;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=idyFMQuAvksj/nelnpM5zL01z8hNxeLhzOqGX9o4Bz4=;
 b=DpcDwyUaKFYeDGThgHrM/lxMQaaznXuP+sf9DEAHMtGQVsemqb14KKmvvm772pnZrE
 sEFA0GBwE724V8CQdjm7DhStF1xIOJZRzYgYIs7sSpCy4sp5PNfo/KJytqIVxFANlpOK
 orReTxf7IdPOvOWWGWYAbOuhE6UV9otUzo3zX4hwEgx7hcO1MF0Pc1zKzT1qjO0Q7VUH
 i3yuwG+6OEUeh9HaBss1Z9ZJ/utwDmwTLk+geWFQCxdyh5SgVqpYDWTEneSu934P0q8g
 8fggI4Qqy2Jx5qmTXYhWyoXsryHeNWpIcSa/7NYbxDtUQArnAeYTlSgDV/JZOUDVxfVE
 tdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL0+CIY8r6nsnVaQVvtYME9uEeXywlB0z3d75cicF71OHLUbFY+ruW1FteKCUhX2Bm6NdEiHkw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmSktTLvHhCxXGToPbjll+KfQky0QUnJCw5uOycyD6+Sx3r57H
 RIJPRnLZcEQzUIQqucxESOwhmQVAae3sBS/Sl9DwKIXtJfaQbgasoccnvzICwQ==
X-Gm-Gg: ASbGnctzIOslFhICP3gJ9YQkyAeqFifavLC4cOXj6uB2FiSUE+OwzjDBCsFKevu+xZD
 Myic5fElG5HSw11GKuZ1RTn5c6nCrJ1aPezo0dwPtIlJCWUMU4zw277cdGAyB3BjuV3yWJo3laF
 wV0QTRKyMgClvGWgPnjs4rbKFxg7sWKMIRrscZG0PHFvTb1ekdM1agwN7udORe2GXnGq1zsZqpw
 J7HAtV9xcB+YUcgTJNvLz9lhTndFOvkv3Vno6es5AyjgDgvoiZjhhWK0whY2qJL9Hg1PXoIOuyd
 mRk5wuS99tjkwrOayz1zN17KC9JW0RlFZqcQb7i+MKFOBMtkmacNaAyM8xO/h4rOdFSV2xBPuTi
 ZqJ6iCC879EYuzolcJoMhpXLKUe4CZfIg1agTZVT/yWbNQZsHFR/pENTrXllcds2ipMI/CKpyuO
 gGFOlx9aqNrXRAiQy29LKEyybceKYpz5rZ+YYqq4rXjiHELLPV1lzqJ4vJC8yegg==
X-Google-Smtp-Source: AGHT+IGIQy3PaaRV6HrvliL7j9EAJMI872J8GcweMpkaccyx4CzAkxTnHJsnycqnu7QJ9to0U6IGIA==
X-Received: by 2002:a05:600c:4e03:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-45892b93d6dmr37677435e9.5.1753895337258; 
 Wed, 30 Jul 2025 10:08:57 -0700 (PDT)
Received: from ?IPv6:2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57?
 (20014C4D24D8FC00B1A6598E5B787D57.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:b1a6:598e:5b78:7d57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f04009sm16837241f8f.38.2025.07.30.10.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:08:56 -0700 (PDT)
Message-ID: <ada40fc10d06f8b4699ac128a56e59263d30c6d9.camel@gmail.com>
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio
 on RGB signals
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Date: Wed, 30 Jul 2025 19:08:55 +0200
In-Reply-To: <714ca8d3-5da7-4266-b258-aba3fbed4a40@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-8-timur.kristof@gmail.com>
 <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
 <7d1df06a6b19dc2d8e78059efb6e26f00bdb280a.camel@gmail.com>
 <714ca8d3-5da7-4266-b258-aba3fbed4a40@amd.com>
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

On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-07-30 04:19, Timur Krist=C3=B3f wrote:
> > On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
> > >=20
> > >=20
> > > On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > > > Features like stereo sync and audio are not supported by RGB
> > > > signals, so don't try to use them.
> > > >=20
> > >=20
> > > Where does it say that?
> > >=20
> > > Harry
> >=20
> > 1. Audio
> >=20
> > VGA ports (and the analog part of DVI-I ports) simply cannot carry
> > audio. So there is no hardware to control any audio, therefore
> > there is
> > nothing for this code to enable, which is why I added those ifs to
> > not
> > even try to enable audio on analog video signals.
> >=20
>=20
> My bad, I was thinking RGB as opposed to YCbCr. Forgot that we use
> RGB signal to refer to VGA.

Sorry for the confusion.

>=20
> > As a side note, DVI-D ports (and the digital part of DVI-I ports)
> > may
> > have a non-standard extension to carry digital audio signals, but
> > that
> > is not revelant to supporting analog displays.
> >=20
> > 2. Stereo sync
> >=20
> > With regards to stereo sync, I didn't find any reference to this in
> > the
> > legacy display code, so I assumed either it is unsupported or the
> > VBIOS
> > already sets it up correctly. At least, considering that the legacy
> > code didn't bother setting it up, we don't lose any functionality
> > if we
> > leave it out of DC as well.
> >=20
> > That being said, upon some further digging in the DCE register
> > files, I
> > found a register called DAC_STEREOSYNC_SELECT so maybe I could
> > investigate using that. Maybe it would be better to work with the
> > registers directly instead of the VBIOS? Would it be okay to
> > investigate that further in a future patch series once this one is
> > merged?
> >=20
>=20
> I don't think DC supports stereo sync currently. I'm not sure there
> is
> much value in pursuing that.

If stereo sync is not supported, what does setup_stereo_sync() do?

>=20
> > > > diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > index a10d6b988aab..825a08fcb125 100644
> > > > --- a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum
> > > > signal_type signal)
> > > > =C2=A0	}
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static inline bool dc_is_rgb_signal(enum signal_type signal)
>=20
> To avoid confusion with people that haven't worked on analog
> signals in years (or ever) it might be better to name this
> dc_is_analog_signal.
>=20
> Harry

Sounds good, I'll rename it in the next version of the series.
To further ease the confusion, what do you think about renaming
SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?

Thanks,
Timur


>=20
> > > > +{
> > > > +	return (signal =3D=3D SIGNAL_TYPE_RGB);
> > > > +}
> > > > +
> > > > =C2=A0static inline bool dc_is_tmds_signal(enum signal_type signal)
> > > > =C2=A0{
> > > > =C2=A0	switch (signal) {
