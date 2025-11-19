Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2CCCF8860
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 13:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DD810E746;
	Thu, 20 Nov 2025 13:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wI5nmViu";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FF210E66A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 17:05:08 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so664024f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763571906; x=1764176706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SpIUuWPAq8xqPaEg9x1oOUftTzMiswVUqIcnyOOxJ7A=;
 b=wI5nmViu6bAJGRqnWjwI2JPDUExMcbgA9lLgKWAAQaCxWq2P0DlP92BLAf8+cAHzQ6
 p3vGVFdaX9QrW6cyVY/0nhuIGihuYTWrGwVoDXyeXYo8rK0xpoWpIQzQTdDnnT3s+6Dh
 H2wT82EAeIBrh+kKL441ZKWfWMtvD9SWQYfPetxNPjZzZ3+0S7khqSMCvqtDlyMrtLgP
 jl/nGbvcVIS3aIJpgrbZaxZ54RGpM1wwekdIeCY7WHtPdnyZlVk0T3kegqdfGC19xlzw
 sho9coV6It81IScht/sqSME45IOzOkmEJqDHKZkve8hGcYI1VQFYMBudGrkh8bV5rAsr
 UYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763571906; x=1764176706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpIUuWPAq8xqPaEg9x1oOUftTzMiswVUqIcnyOOxJ7A=;
 b=dxPRXjnixU02TsiUM0CFhIC+7Db1hR1dGlNQOKHsPXrMm/uU7hGBrKeQr5Ws6fjRpp
 2JkURFv3oZVxOVHHV+jJFLXiV8tccatzofgvNxBzVYWdAbFkeMaGXWy9RIy/rc9ldX4D
 xqOBd6BLzrZyVq3lfb6EQQFvDonvJg2YaMDaWzM7EBzpE52XzCVwZcvc5XAyWjybzgQy
 giQaODeXJoQjlGKDqpwoQhbEHgqGtuPSY5MJpfEyS+tniz5Cw0m8/7WgYtuCE7E7RXSj
 lqJigsEqi+SyVWHT1NHzJqeT4JHqRyh5y65gOL/nHAl03EnozNEV6CqI7phDE20ywuXU
 O5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdDJg2wxerS2xLObYSn7kdKkJtqKRao+tQBqQ5TJPrtYyvv/Y32Fycq15BkR/bKxz97jtVFNin@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUTtE1j+QvOHt20zk4e5TKUC60k28oQzEqbIxQ7dtkcTOlnatR
 1h6eMiw0tvBcj+/0kf8gQTMssVo25X6NLWrZLd6Hs7XmsHTP5eb+/WdeFJdnffZU1JQ=
X-Gm-Gg: ASbGncuEI6cpSwiFBGB78Y6sNNFogg6tzk00hBmtJhyyXAKuDHYiDR4k2GgnewiAEFi
 SPwpijVQWXsKc9Pm9o7aQJIHTV8OEwx/KTPLQGH8fOQZ3pgUJdXQSesvSh+8yR2/0e3ZO0FNVCc
 LczPSNZai2buW9+Gp7qb3jae1HEhaKuXnCNjQS+JrM7qtxzFMfLNbbuiMebUp1324N0+iluzam/
 qTTQZeAQI0VJWYaGs4Z8Y2l6JQw2oCfLBreCI9qkcg/ssjwUlDZwTfSXfdv22ylRLuAUnxRjalD
 ECqWeSjSnVEXtYDzTXVDki9iPWGzDnj5jCEkYvC1wf6QkEYyfydUBEzNbYTt3JshU5vkDksROT7
 T6ouBmfrwP+r1Po2zZyMDuDjARFWc3jovwfCoavU1Hxdyecl/tCgVEHD872oNUhxoA+Fkl7IDuF
 RVGFcg/qUuClY2qjm7+TyPPwZOFi4azMmRyBE8ogaxQYgNVlQjzSN+3peBm82avg39yXLgZuT65
 D21SrXuuAk6kA==
X-Google-Smtp-Source: AGHT+IGyjnLVU4D9u2D45u2Wal+Kezx1sPJlYQiqNfFPTwYYUqn33JZO3glMlmY2VOJjvcoe2RtzPA==
X-Received: by 2002:adf:f98f:0:b0:42b:5448:7b34 with SMTP id
 ffacd0b85a97d-42cb21e7690mr2799841f8f.7.1763571906479; 
 Wed, 19 Nov 2025 09:05:06 -0800 (PST)
Received: from localhost
 (p200300f65f02670883c4a3b3f2bee88d.dip0.t-ipconnect.de.
 [2003:f6:5f02:6708:83c4:a3b3:f2be:e88d])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f2e454sm252057f8f.2.2025.11.19.09.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:05:05 -0800 (PST)
Date: Wed, 19 Nov 2025 18:05:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roman Savochenko <roman@oscada.org>, 1118349@bugs.debian.org
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wjh2nulgapw6al2j"
Content-Disposition: inline
In-Reply-To: <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
X-Mailman-Approved-At: Thu, 20 Nov 2025 13:53:05 +0000
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


--wjh2nulgapw6al2j
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Hello,

On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
> 12.11.25 17:03, Christian K=F6nig:
> > On 11/12/25 15:28, Roman Savochenko wrote:
> > > 12.11.25 13:14, Uwe Kleine-K=F6nig:
> > > > > On my hardware that doesn't work and there is no specific.
> > > > >=20
> > > > > Now just I set "radeon.dpm=3D1", I got immediately restart with d=
isabling USB,
> > > > > so I have needed to restart for successful download with "radeon.=
dpm=3D0".
> > > > Can you try a different monitor?
> > > I have only one, connected through DVI, and there is no problem on Li=
nux Kernel 5.
> > Kernel 5 what? E.g. which concrete version number? (output of uname -a).
> user@debian:~$ cat /proc/version
>=20
> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.=
2)
> #1 SMP Debian 5.10.223-1 (2024-08-10)
>=20
> > > > Can you try which Debian kernel was the last one working fine respe=
ctive
> > > > the first being broken in this regard? You can find all kernels on
> > > > https://snapshot.debian.org/. Please ask if it's unclear how to do =
that.
> > > I can try all kernels in Debian starting 7 and finishing 13, but I ha=
ve traced that before and the problem reproduction started from Debian 9, t=
erminated on Debian 11 and renewed on Debian 12.

Not sure I follow. Does that mean that Debian 9, Debian 10, Debian 12
and Debian 13 show the symptom and Debian 11 doesn't?

In that case the interesting interval is 5.10 .. 6.1. If you could
pinpoint the oldest kernel image package that shows the symptoms that
would be great.

> > How keen are you to compile the kernel yourself? That is usually relati=
vely easy to do and git has a bisect command which allows you to pinpoint w=
hich kernel patch actually changes something.

For the typical Linux user compiling their own kernel is a big hurdle,
so usually we (=3D Debian kernel team) ask for bisecting using
distribution kernel packages first which tends to be a bit easier.

Best regards
Uwe

--wjh2nulgapw6al2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkd+L4ACgkQj4D7WH0S
/k6AAAf/UHJoqq0WyfYRhxRKZ8ECDXEjZDuH4bnjk58eZyptpBYly5gFbzpWBcX0
oudEcYN9meLg5FRqePIELcRSXR1KxosfEFJfiQ8JW3qFawj8mXi0IXZHP8jd5LUX
PjugHx9JQ5P8R4+0O+TsdLz/0aPn58pLAa5yXCsBZYM4mKlfkyXi/rB0G6hpgLvb
KL8EamySGA3ZalBcZyPa4jjJ9l6Zx6A+REP5SJsSF6IGXxqDrSR7Mhwbox3J4iVF
YxwH4gOJKq7u0at05zAsyOAiUcmXIe66hlCfRnLrZLhVLY9OMnctkcVC7DttVpjY
UynXQ856esYcZbULM6J6g9jve4ZNyw==
=/St3
-----END PGP SIGNATURE-----

--wjh2nulgapw6al2j--
