Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79F2CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 11:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C5910E7C2;
	Wed, 27 Aug 2025 11:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="flwbDkTh";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3A110E7C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 11:37:06 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7f8ea864d63so9038285a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1756294625; x=1756899425;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfndeEOwCnpCOK3QWCzVz+jGoFaf5I3pq8HSBnsv0uc=;
 b=flwbDkThB1u8SBy3BCPRJJNRYIZruo+2KB5pR18leEg0qctsa5bBEy9JATYuNTZvb5
 dzOyy24sdUWoP9qPRmyO47cMzxSdmMqHxbVfhcZopmKaetrOluj0g/LtsoVWF0Lj8pj4
 Xwz3a9ndP31hQZUx1EzFV+elEZNAzIb77JqqA0U80f0FxJbskGu24rgnrqqIbfR2/ziT
 jIW7pEqjmx8kHo4dIzqBrdN/77MuNZGCapJCZBU5sfmjtMOIU0KnKaMF4QSrhCQoFVPH
 bJI0dtwC6qp3INKDFDyqdsOaRuWkSi58ymRUcZTslqf9qSC8ptSPUvxgz0qrHS9JlDQB
 Q1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756294625; x=1756899425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfndeEOwCnpCOK3QWCzVz+jGoFaf5I3pq8HSBnsv0uc=;
 b=c2t8NCUVzV0Q6Sv9EHSqcieCSFoV7hlHs+t8XXJmidgUidgZXh9Ut9RM4PyfK67IpW
 w8ka63zVPgic04MeVQkF+vm9j5aU5MlxHinq+WON8a00KACIBJugCWqEfq660glrXRRY
 HKbvVmEehaaE52yMovk/QQ2xI3z/3vpcDn6tBk/5oq6WxOHCpbE2FYQ0OGV2Ss8BIgAx
 nOfoXGzY4XBgpOzHpqPFVkpjHJ+KlcNnpNqI4m9bWeWKj6BZRHTQQY3zCwP9zUohN5QE
 fPTSUknrGcf3PGm5aL2yzIEkgBcSEyCvmswHAZQ4ovbJDcP9JDGyyVK9yMOCWOekCypV
 cK8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2FzYI3+kGUC3EXmswAtfjxKFuO5cNZ8WSe0sUclIvWhka4uzLvgRdC0LXWOIGFHx1VdNtWuos@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9uZCk3+YfNlhKTatepJ2h0bb2UUmX4O8P+Qbmt/Bro3InE+5w
 Z2Bg2ipVNVZQKl4BQYq3EgtmljDvTmoDdxrGQWeF6PqkjCG6oQRIwML+nEt+ZcdlOvkp3vU/n3S
 JDQYKRQObCyeMMDHNg9BeFGaK419KHjS4LBjmQTnAzA==
X-Gm-Gg: ASbGncuWPdOcpbHG5FwZAVK4yrQGFeQIRwyddF71wXrtaErIL9spKbUPJN9TFjT8Fbw
 mLl7+sxxs8EqzpF3x7vNPGw26reXKfN3X1aF3qq/qakXEiQ1I7e5doSb2Q3r0FkJwHKIeNgy79/
 ISxXjYhee6LjDgbj1FWUjsL8a25OwfQ9Tks6MBDbqXjGejejsWa5Z1LkaIpBDP7+TlDfCuZvVKA
 jmgGQ/s99WfC+IX
X-Google-Smtp-Source: AGHT+IGm7iJLIIebL1+88laKEXRfjU4Dz7HmoTdOZAJey6UBB7j4fE3V3lw96EobEWDFpPJOKKiRUxKIM3arwj0EGNg=
X-Received: by 2002:a05:620a:3711:b0:7ee:4a7e:e9a3 with SMTP id
 af79cd13be357-7ee4a7eece9mr1477937485a.48.1756294625009; Wed, 27 Aug 2025
 04:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
 <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
 <20250827-enchanted-merciful-badger-d51816@houat>
In-Reply-To: <20250827-enchanted-merciful-badger-d51816@houat>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 27 Aug 2025 12:36:53 +0100
X-Gm-Features: Ac12FXzn6v9MHx6a6sqFNAPJ1q2fkI0xvp2gSmrt9F65w1ac40HF9ChdBRScx2U
Message-ID: <CAPj87rMDj-3ohEtXQYy25Rp0zNtZxQxS4Rmd-akgx9kkvB4Ysw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
To: Maxime Ripard <mripard@kernel.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, Marius Vlad <marius.vlad@collabora.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, 
 tim.huang@amd.com, dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, 
 alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com, 
 chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com, Wayne.Lin@amd.com, 
 dominik.kaszewski@amd.com, alvin.lee2@amd.com, Aric.Cyr@amd.com, 
 Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
 dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, 
 linux@treblig.org, haoping.liu@amd.com, Relja.Vojvodic@amd.com, 
 Yihan.Zhu@amd.com, Samson.Tam@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org
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

Hey,

On Wed, 27 Aug 2025 at 12:21, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Aug 27, 2025 at 11:39:25AM +0100, Daniel Stone wrote:
> > There are other reasons to have uAPI though ...
> >
> > One is because you really care about the colour properties, and you'd
> > rather have better fidelity than anything else, even if it means some
> > modes are unusable.
> >
> > Another is for situations which static quirks can't handle. If you
> > want to keep headroom on the link (either to free up bandwidth for
> > other uses), or you accidentally bought a super-long cable so have a
> > flaky link, you might well want to force it to use lower fidelity so
> > you can negotiate a lower link rate.
> >
> > I'm all for just dtrt automatically, but there are definitely reasons
> > to expose it to userspace regardless.
>
> Oh, yeah, definitely.
>
> But bringing the big guns and the requirements we have for those to
> address the point initially discussed by the gitlab issues seems like
> biting off more than they can chew.
>
> Even more so since whatever uapi we come up with would still depend on
> the EDIDs, and they would still be broken for these monitors.

Sounds like we're agreeing with each other then.

Shengyu's 'I want these broken panels to work' usecase is probably
best served with an EDID quirk, yeah.

The reason Marius is working on it is the reasons I said above though
- some for uses where we'd rather clearly fail out and push an error
to userspace than continue with visually-degraded output, and some for
uses where people have bought a too-long cable (or bought a too-short
one which is now at tension through a 180=C2=B0 bend) so we want to force
the lowest link rate possible, without dropping to a ridiculously low
resolution.

So I don't think these are in tension, and Marius should proceed with
his work (complete with the proper userspace to back it up), and
Shengyu should proceed with new in-kernel quirks, which will be
effective when the properties are set to auto, but hard overridden by
userspace if it decides otherwise.

How does that sound?

Cheers,
Daniel
