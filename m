Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944DEF513F1
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 12:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009910E121;
	Sun,  8 Mar 2026 12:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdSvCNSF";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0AB10E04B
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2026 12:59:45 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so3438031f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Mar 2026 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772974784; x=1773579584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCcvTZODN6sqyoYdkdvVRxc4wALvjVCgUO6jSwYiCpc=;
 b=SdSvCNSF5HGbmIbCZrjV+nwxT6tVijagxjQxR0yglPgMDd1ld5kMTerHpV077gwPOK
 B+CAi/ePiknVvI4XqaDlsrC8l89IBjmSUmfdXFzP1NzIoKtqLUAFpB4rjhZvsg1Iaj4H
 RZsGD/FSUrDFEpFeV5bL9xEGNQvtYk1jeMz4pUD2uERxnzOCnP4iYEeSvR7h9O83aGE5
 TtlR5xmthFgMnSIzsMOY4woawZ4wquKMYFDmF0lgjCtpJat72AZhxifr3xsWEAdPCwc3
 hcRGc67WmTWYxzVy6ATX23FPruYu8LqdjtmSmjB+SXRVNmNoNHQ8OPcG3dpRxJ7705EY
 UsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772974784; x=1773579584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCcvTZODN6sqyoYdkdvVRxc4wALvjVCgUO6jSwYiCpc=;
 b=s5bPeWgid1pWObpQ5EYwQ+I8k0gUl1qcCHL6RKx9drpY1TA1WK4ZVc1oxJGgpgRvXg
 rIm8avLP8D0I+BZ648aHm4S7DV8SZgptPu5AdJZYW4KRvh7b+HJXMs4D0XphtKKMHGNd
 aLKY0O5Vsy/fc6H3V+37ea/KcR0P5TsQkF6d4iNXLO9WMoJXjAeG1F8LEj00xOnZQzJK
 sk0ciIUPcfCYeoK6Tc6uLGOQaKrkZTcqGjEnJ+5sY5ceAEO8N/17vf2sBGWx4fb8H/f6
 xaCBiJQr5+Zmda6XFJj1P4u6xT7DO5t2z6nfA25XfdC2DdAYiHzwinCk1HwylyXtRwdm
 6zzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdhL3nBzt9T+AxUDeF62i03y3g7UbXBo0/XqLelZTkp2nqxhUUSqvHOiMQ4lr66aOmFerTkqpT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl1+hxu5/v9yPMv0fb37nptiRufYTgpHL2lIPaNtQw+4oumoHx
 QC9UhgjiCfCs8zshMS2djy7DWDlrpLlJJR5KUOH82grsl9PAI9jJpZ1Q
X-Gm-Gg: ATEYQzy/Gxj8HvvvCX3ABDpmeBbtuJKzKyLg5WCTZo3gwtItdT4B2xcjBvS7PFnOWHr
 FZaYfX1ChyWLxivf1IhiX0J1KM80EszpWEK62lEri4/zrjaf8uhdfEimDSCLif3NPYDHqBJx21n
 AH8BbhEUJ65E6X2AkDeB9Be87vHQdb1HJmKOBsWi6XyCQdswR+QOnKk6nJBM33LJSz3tm9T3y8X
 m8ljk6B6j+FX6w29/Dm7Yczq2PHvQytUJjCpviph7zWr2a5hNNpozx1YGjk/0AdXqksdjl5NgwS
 USd5pZtavPjzP3nh7w6T7ZT5drszS3AGEHxXtB5r71/nIuTPtcxnWfP99Nlaae9PDhHL9+LEZw2
 fWXyszYzWKmVEvpsYVorE8xl4te1Iu62slDMdyMvQPhdq8flMateFo5Ekgdjv2H8Eojp5Mp+OGH
 4O/qdrzhlP3cjJljWPie8PG0xz8B3qZOB2Oa2h6c7BDa9H1TsFnz/srPGl5KLI2E2cIc4VP9TMU
 w5wKABqHm0=
X-Received: by 2002:a05:6000:2911:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-439da351b41mr14651067f8f.16.1772974783363; 
 Sun, 08 Mar 2026 05:59:43 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B97DE.dsl.pool.telekom.hu.
 [94.27.151.222]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8dbb3sm16332342f8f.4.2026.03.08.05.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 05:59:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: events@lists.x.org, xorg-devel@lists.x.org,
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 libre-soc-dev@lists.libre-soc.org, elections@x.org, members@x.org,
 xorg@lists.freedesktop.org
Cc: Mark Filion <mark.filion@collabora.com>
Subject: Re: Reminder: Deadline to renew X.Org memberships for 2026 is March
 16.
Date: Sun, 08 Mar 2026 13:59:41 +0100
Message-ID: <5818436.IbC2pHGDlb@timur-hyperion>
In-Reply-To: <77e280436ec5b54973a11303dd0446e9f3ab2ba1.camel@collabora.com>
References: <0070f3dd-a521-40ee-b6e7-8b1f82e48b66@amd.com>
 <77e280436ec5b54973a11303dd0446e9f3ab2ba1.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

This seems to be not working. I am not getting the confirmation email (yes,=
 I=20
checked the spam folder and it isn't there either).

Is this a known issue?

Thanks,
Tim

On Wednesday, March 4, 2026 5:12:37=E2=80=AFPM Central European Standard Ti=
me Mark=20
=46ilion wrote:
> Hi everyone,
>=20
> Just a friendly reminder that the deadline to renew X.Org memberships
> for 2026 is March 16.
>=20
> Membership renewal ensures you maintain your voting rights in the
> upcoming foundation elections, but also helps strengthen the foundation
> by giving it more credibility.
>=20
> https://members.x.org/
>=20
> Thank you for your continued support of the X.Org Foundation.
>=20
> Best,
>=20
> Mark
>=20
> On Wed, 2026-02-04 at 16:22 -0500, Harry Wentland wrote:
> > Hi all,
> >=20
> > it's a new year and with that a new X.Org Board of Directors
> > election. Please take the time to log in to members.x.org
> > and renew your membership for the new period or sign up for
> > the first time.
> >=20
> > These board members' periods will end this year:
> > - Mark Filion
> > - Erik Faye-Lund
> > - Simon Ser
> > - Neal Gompa
> >=20
> > The election dates will be as follows:
> >     Nomination period Start: Mon February 9th
> >     Nomination period End: Mon March 9th
> >     Publication of Candidates & start of Candidate QA: Mon March 16th
> >     Deadline of X.Org membership application or renewal: Mon March
> > 16th
> >     Election Planned Start: Mon March 23rd
> >     Election Planned End: Mon April 13th
> >=20
> > If you have questions or encounter issues don't hesitate
> > to reach out the Elections Committee at elections@x.org.
> >=20
> > Best Regards,
> > Harry




