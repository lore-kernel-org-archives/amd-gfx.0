Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7312BC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 15:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1488E10E8A5;
	Fri,  1 Aug 2025 15:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g7ldhrPd";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B78310E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 15:09:49 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so9440155e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754060988; x=1754665788; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4L5CZrOLlbhejk7E8rDG3smNNdI8wupBfI1uATCRCI=;
 b=g7ldhrPdSF/5yNF+L8eTBp0JpGYfhIwWNKkbbN+ylfoHWr+p0xgX+aUiEjl5SA8KXm
 kaH27z5umwkVL5x991/jpohqKmsX33BUCgt7yaNz8rkyPDFQNFN/RA/hBnthNDzkbr2M
 PHk8zH35m7yddDDUs+B2VJNUHybu+6Fni6evRcjqwo1+0iAVpz2DRfHegIy8iAjfyRu4
 DmFjMLiBxo7ddAh4kXssxzhZMDYVzFFkKzBdL+1xmXFzhclizp0+ryKIRYXYMb5MfADp
 KD+xROBRHz0wrXWcICjLAdA1H0MH3mp0FQLCBKGKukHLpm3j7dYvSwOA4rjsTBndGWQA
 5dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060988; x=1754665788;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4L5CZrOLlbhejk7E8rDG3smNNdI8wupBfI1uATCRCI=;
 b=l4/6dfJd8T8fhyJpT1jO9/T5EPAlmjYbhDqWoiA28FKLusWppal8YghamQUOatcLqJ
 3bonbwBYy11GifD5dvnRbjBgUOom3bkxugyidsZ7RroNnLDtw/X8WcYDin7F9E0TdnBG
 6PhIJUGQyjeZ1XyupDsnDAtrnoHJKuX/0vbm4f5ImBgPTgpCmS2fdk+FvjU7toHfahV6
 jcYxGvTiywAIdeXUeADOhNDycDLI1Pk3bgR64PGTfcNvaaTWnUOYIllQ168uLNHnoIoP
 Q0aOHdbns8qcYex1t2PcNapv8sgqLm8EHvSl7M9+1Op+eitAxn695FtFAnc0bVYi7h4B
 AVrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhSs7rMXf6UoqL4f5Hsgykvrv8fMOooUna61UYywa1rSWdcj6pUXat3O1jj1noyKzovDbVyPDW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhEMWVAdSk+FQHin88+xMUX0iSloiF5IJGFoRwTmlUxlQKaWHJ
 ftc2wLkE7sRyzU+cmG7WYDSQEEeXE3Bi+BbyrduE/Dfb3EcEVN+0Bw2Y
X-Gm-Gg: ASbGncv9jABoz0teiDahZxpYVlF1EuzDJAMiFVEtqSN0HK2ZhyQ8RmFSscgU1wGdw8L
 17IMA+I/c+ZEh4hFzBgza9u69tAdDxHMTucwRAPBh2EnFnKj+Z9TewLgKuhMICeyVjXzhAnvpFB
 jJ9/vI5ERFYSeWF/I++Rw9WSXZ6G7AgGgjYZ/sneHbg4nDHOEd4NHjG5/e+/vaFD7p1opgHEC7T
 vN1fj5az0h71Z5c7L77OOe+j9XIodjWWIYcAvUfcpStGfovshHOganXgDkuTXvZEOdaXw62B+KA
 qi/YbMLRZGQGK/gUO5CWlR7qDj6wjciCJHBJWjU4yDadzayB1eexnzGfTdvP5Yozc6VDRnyaskP
 pvuTVYNv8PhcKttt0540kNFy/ZcWk9nbg0UKvIra5if8ga9SOQ9KYtkHOO4mAyO4j8C/K8tax38
 y17N4wlwSToi5all62SXaFGykSYvRRv4a9L1+DoKjcnkJDE0YrDyz/cLd/KGXSXQ==
X-Google-Smtp-Source: AGHT+IFkHhEMM9tFtDmP5Nr93EyRf8SXMugC6gCv/ysl6h7y7dqUDm0TYrf0dvSGmffB79Vf9FPBww==
X-Received: by 2002:a05:600c:518f:b0:456:1d06:f38b with SMTP id
 5b1f17b1804b1-45892b9da13mr104132795e9.8.1754060987493; 
 Fri, 01 Aug 2025 08:09:47 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24dd:b700:267c:66b8:50a0:e369?
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaf08sm104680335e9.26.2025.08.01.08.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:09:46 -0700 (PDT)
Message-ID: <95f5b650547161ac00a5717b126e6abc7ac7140b.camel@gmail.com>
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio
 on RGB signals
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, alexandre.f.demers@gmail.com, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 01 Aug 2025 17:09:45 +0200
In-Reply-To: <a9bb6304-f6b3-4ae4-bbd8-fbd569ce237a@amd.com>
References: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
 <1ce09488-0384-4d88-a1eb-cdff89c0bed1@gmail.com>
 <0942ca2451ec8614835a9a56a3e0725ecb0aa6d7.camel@gmail.com>
 <a9bb6304-f6b3-4ae4-bbd8-fbd569ce237a@amd.com>
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

On Fri, 2025-08-01 at 10:55 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-08-01 04:39, Timur Krist=C3=B3f wrote:
> > On Fri, 2025-08-01 at 03:19 -0400, Alexandre Demers wrote:
> > > > On 2025-07-30 13:08, Timur Krist=C3=B3f wrote:
> > > > > On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 2025-07-30 04:19, Timur Krist=C3=B3f wrote:
> > > > > > > On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > > > > > > > > Features like stereo sync and audio are not supported
> > > > > > > > > by
> > > > > > > > > RGB
> > > > > > > > > signals, so don't try to use them.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Where does it say that?
> > > > > > > >=20
> > > > > > > > Harry
> > > > > > >=20
> > > > > > > 1. Audio
> > > > > > >=20
> > > > > > > VGA ports (and the analog part of DVI-I ports) simply
> > > > > > > cannot
> > > > > > > carry
> > > > > > > audio. So there is no hardware to control any audio,
> > > > > > > therefore
> > > > > > > there is
> > > > > > > nothing for this code to enable, which is why I added
> > > > > > > those
> > > > > > > ifs to
> > > > > > > not
> > > > > > > even try to enable audio on analog video signals.
> > > > > > >=20
> > > > > >=20
> > > > > > My bad, I was thinking RGB as opposed to YCbCr. Forgot that
> > > > > > we
> > > > > > use
> > > > > > RGB signal to refer to VGA.
> > > > >=20
> > > > > Sorry for the confusion.
> > > > >=20
> > > > > >=20
> > > > > > > As a side note, DVI-D ports (and the digital part of DVI-
> > > > > > > I
> > > > > > > ports)
> > > > > > > may
> > > > > > > have a non-standard extension to carry digital audio
> > > > > > > signals,
> > > > > > > but
> > > > > > > that
> > > > > > > is not revelant to supporting analog displays.
> > > > > > >=20
> > > > > > > 2. Stereo sync
> > > > > > >=20
> > > > > > > With regards to stereo sync, I didn't find any reference
> > > > > > > to
> > > > > > > this in
> > > > > > > the
> > > > > > > legacy display code, so I assumed either it is
> > > > > > > unsupported or
> > > > > > > the
> > > > > > > VBIOS
> > > > > > > already sets it up correctly. At least, considering that
> > > > > > > the
> > > > > > > legacy
> > > > > > > code didn't bother setting it up, we don't lose any
> > > > > > > functionality
> > > > > > > if we
> > > > > > > leave it out of DC as well.
> > > > > > >=20
> > > > > > > That being said, upon some further digging in the DCE
> > > > > > > register
> > > > > > > files, I
> > > > > > > found a register called DAC_STEREOSYNC_SELECT so maybe I
> > > > > > > could
> > > > > > > investigate using that. Maybe it would be better to work
> > > > > > > with
> > > > > > > the
> > > > > > > registers directly instead of the VBIOS? Would it be okay
> > > > > > > to
> > > > > > > investigate that further in a future patch series once
> > > > > > > this
> > > > > > > one is
> > > > > > > merged?
> > > > > > >=20
> > > > > >=20
> > > > > > I don't think DC supports stereo sync currently. I'm not
> > > > > > sure
> > > > > > there
> > > > > > is
> > > > > > much value in pursuing that.
> > > > >=20
> > > > > If stereo sync is not supported, what does
> > > > > setup_stereo_sync()
> > > > > do?
> > > > >=20
> > > >=20
> > > > My bad. Not sure then. But no objection if you want to explore
> > > > it.
> > > >=20
> > > > Harry
> > > > > > >=20
> > > > > > > > > diff --git
> > > > > > > > > a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > > > b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > > > index a10d6b988aab..825a08fcb125 100644
> > > > > > > > > ---
> > > > > > > > > a/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > > > +++
> > > > > > > > > b/drivers/gpu/drm/amd/display/include/signal_types.h
> > > > > > > > > @@ -118,6 +118,11 @@ static inline bool
> > > > > > > > > dc_is_dvi_signal(enum
> > > > > > > > > signal_type signal)
> > > > > > > > > =C2=A0	}
> > > > > > > > > =C2=A0}
> > > > > > > > > =C2=A0
> > > > > > > > > +static inline bool dc_is_rgb_signal(enum signal_type
> > > > > > > > > signal)
> > > > > >=20
> > > > > > To avoid confusion with people that haven't worked on
> > > > > > analog
> > > > > > signals in years (or ever) it might be better to name this
> > > > > > dc_is_analog_signal.
> > > > > >=20
> > > > > > Harry
> > > > >=20
> > > > > Sounds good, I'll rename it in the next version of the
> > > > > series.
> > > > > To further ease the confusion, what do you think about
> > > > > renaming
> > > > > SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?
> > > I think Harry hasn't answered your proposition. I must say that
> > > the=20
> > > first time I looked for VGA in the legacy code, I stumbled upon
> > > the
> > > RGB=20
> > > usage. But then, it began to make sense (I'm not completely sure
> > > if=20
> > > signals and connector types are used properly everywhere),
> > > because we
> > > are mostly translating DRM signal types to supported connector=20
> > > types.That being said, while both dc_is_rgb_signal() and=20
> > > dc_is_analog_signal() could be used here, we are specifically
> > > querying=20
> > > the signal type and this signal type is RGB. Because of this, I
> > > would
> > > be=20
> > > in favor of keeping dc_is_rgb_signal() unless there is another
> > > analog
> > > type that could be queried and not rename SIGNAL_TYPE_RGB to=20
> > > SIGNAL_TYPE_ANALOG in any case. Cheers, Alexandre
> >=20
> > Hi Alexandre,
> >=20
> > I think the confusion comes from "RGB" being a very overloaded term
> > in
> > this space, so I am in favour of clarifying the name. I am open to
> > suggestion as to what is the best clarification. If you want to
> > keep
> > the "RGB" part then I propose:
> >=20
> > SIGNAL_TYPE_RGB -> SIGNAL_TYPE_ANALOG_RGB
> >=20
> > Which should make it very clear what it is.
> >=20
> > Otherwise, I would like to apply Harry's suggestion to name the new
> > helper function dc_is_analog_singal. Considering we don't support
> > other
> > types of analog signals, I don't think there is any confusion with
> > that.
> >=20
> > Let me know what you think.
>=20
> After going through the entire series I'm not so sure
> it only makes sense to rename this function to _analog_.
>=20
> Either rename all of SIGNAL_TYPE_RGB (like you suggest)
> or leave it all as RGB. The former creates a whole bunch
> of churn and it might make sense to just leave things as
> RGB. My confusion came from the fact that I've spent a
> lot of time in the world of color spaces and over the
> years have forgotten our terms for analog connectors.
>=20
> So, no strong opinion from me. Maybe slightly in favor
> of avoiding churn.
>=20
> Harry

Hi Harry,

It sounds like both Alexandre and yourself are slightly in favour of
keeping the old names, SIGNAL_TYPE_RGB and dc_is_rgb_signal.

So, I'll just leave them as they are.
I will soon send a v2 for the series addressing the feedback.

Thanks,
Timur



>=20
> >=20
> > Timur
> >=20
> >=20
> >=20
> > > > > Thanks,
> > > > > Timur
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > > > > +{
> > > > > > > > > +	return (signal =3D=3D SIGNAL_TYPE_RGB);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0static inline bool dc_is_tmds_signal(enum
> > > > > > > > > signal_type
> > > > > > > > > signal)
> > > > > > > > > =C2=A0{
> > > > > > > > > =C2=A0	switch (signal) {
> > >=20
