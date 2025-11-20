Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671DCF885C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 13:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5997910E280;
	Thu, 20 Nov 2025 13:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zH9LdiNq";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D17E10E70E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 08:38:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477a219db05so3790585e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 00:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627906; x=1764232706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ntq/vIaFWsPpB5ihVetw3eGLTvWD7chHnu3trWGKo38=;
 b=zH9LdiNqSubb9MQv9jnJm/L+2C37/lXLFIIxav77A9MYw99JzMYGbw3MDsYBOq223z
 uyqzXSDKQMDN+ybv6tOvhel/UhT3yhLF3gWRF8Ho3by+V3xBY+Q+efSKEG3ygLzoOrl9
 GTNjD3tF9+MaYtcynrkBUuDIQQnPUt+2cXpnKLcdSvtaU6IKBDlKXA6IHH+9rHrNkZBd
 9jAkeldgUk4XS/NVZwLaharHBsZwf4DuvXPth9Brn/tE/tmY4/PqkSMH0T0TjftpSZM0
 XDMeEeYyKRvEcBuLUkNbo71XdqkfCID7Oy0oDdak8LY5vt2W/Ejj5BDyuP0R6tyZuO9l
 Eruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763627906; x=1764232706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ntq/vIaFWsPpB5ihVetw3eGLTvWD7chHnu3trWGKo38=;
 b=LQ6w5sYndjUFMklcq2rsMiLB8Dlha+Zt1Ocb6pQ21gXRNBkdVvnxQ6K2EqyGj93yZw
 UHfFKqfmyo3VsJOLHgf9ODizXldN3nnVh3xD6qmkevI6QeasVVYdTRGXY1ZaKjZsGeAU
 SHikLqRy26uwBVf7v1Oo3MrT4GyocSIm72+f7TLwKhYCbj58BgDsq3y9EynZts+l9ZOu
 VTMHXuVp1jXHlsJ4m8ePrmbnY1R0P+s0HwUXxv7lmznq27hxrOMGpfmohaot42Wrrl57
 2XZY5F6JE4V5kUZwW8ufg0SQif5IGFjmUt0DmZPVxpmtYQrS+EqT1QYdvFgwvUa/Rimo
 CoyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX9FfSPq1hO07aMSR2KVV8Rsy35DDJYZiZxlMSD5bU2HxpHKh6W2nOCipM7TA2UQT3zosteaCB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAfI7Ge0BNlwS/sEO/QCbN+n2Vakm8PoKmQ1t5hW1Wc+jilaDz
 N0kpFJ50+4dJpOLZaui2RLQkn9YR6wanwAaG6ie2Uoi3OSwR0cuqJA/JVX0GKRmGV0Q=
X-Gm-Gg: ASbGncvk+3y1J8t8X17VpJeNv6d7Uws/rhT3H/nAhLjXLwWdPV4zr6Eruci/0VmfWhO
 /m9xKobAh7Wv6FP0HCJOJVSFUoZcqsM4FuVZyLc+NCNF2hk1jiKToaI4VO9ePTpb1beKxOKE7/p
 +aFC2TSEdo7b+vRLPK3SPeMg8yF+J3Z1q5vAhbYTWNAC7Nl+1uQm0nPkLf9Cv0Ll+h4sbrvJLQB
 iPJtdYfU8iWqG6fKKeHdia1fQpovjx3enswJLzIYMVeWlPGXMB0cYVFZ5ZRK1uNnqGzrpxOhsEl
 tbPEFF3QmYqi2GH7hQMuEDeH5G7J87NHqAghweNH5qE4u9HD1P6DhY5vZimOGnbyO8JCGwKdeHz
 HxwSJZRrYceqaEhNU4rs/H975DNGSiZRhsIPO71STQowJjom9r3hykdwR38g+2UBtJwmZAze0iR
 ELqR/O4/JsOSezjW8jxc+N/88xt7jmUYHa/8acxUBY+yOe19ADDtvE2WF+0T+i22mUH8aMkJYa2
 B2vHjwZS5Ev
X-Google-Smtp-Source: AGHT+IHQP6HtTXxsbtyGfaDhjFgrL6Q3RDIyrPa0daWs1aiyf2DGyKAXtG2c0Jq18b8aBQnsypPb0A==
X-Received: by 2002:a05:600c:1caa:b0:471:13dd:baef with SMTP id
 5b1f17b1804b1-477b8a9b2edmr21954455e9.26.1763627905599; 
 Thu, 20 Nov 2025 00:38:25 -0800 (PST)
Received: from localhost
 (p200300f65f02670804308c1a33c02ebb.dip0.t-ipconnect.de.
 [2003:f6:5f02:6708:430:8c1a:33c0:2ebb])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477a9723a6esm62446155e9.1.2025.11.20.00.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:38:24 -0800 (PST)
Date: Thu, 20 Nov 2025 09:38:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roman Savochenko <roman@oscada.org>
Cc: 1118349@bugs.debian.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
References: <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q2mpyaq27v2ydmum"
Content-Disposition: inline
In-Reply-To: <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
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


--q2mpyaq27v2ydmum
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Hello Roman,

On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
> 19.11.25 19:05, Uwe Kleine-K=F6nig:
> > On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
> > > 12.11.25 17:03, Christian K=F6nig:
> > > > On 11/12/25 15:28, Roman Savochenko wrote:
> > > > > 12.11.25 13:14, Uwe Kleine-K=F6nig:
> > > > > > > On my hardware that doesn't work and there is no specific.
> > > > > > >=20
> > > > > > > Now just I set "radeon.dpm=3D1", I got immediately restart wi=
th disabling USB,
> > > > > > > so I have needed to restart for successful download with "rad=
eon.dpm=3D0".
> > > > > > Can you try a different monitor?
> > > > > I have only one, connected through DVI, and there is no problem o=
n Linux Kernel 5.
> > > > Kernel 5 what? E.g. which concrete version number? (output of uname=
 -a).
> > > user@debian:~$ cat /proc/version
> > >=20
> > > Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
> > > (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2=
=2E35.2)
> > > #1 SMP Debian 5.10.223-1 (2024-08-10)
> > >=20
> > > > > > Can you try which Debian kernel was the last one working fine r=
espective
> > > > > > the first being broken in this regard? You can find all kernels=
 on
> > > > > > https://snapshot.debian.org/. Please ask if it's unclear how to=
 do that.
> > > > > I can try all kernels in Debian starting 7 and finishing 13, but =
I have traced that before and the problem reproduction started from Debian =
9, terminated on Debian 11 and renewed on Debian 12.
> > Not sure I follow. Does that mean that Debian 9, Debian 10, Debian 12
> > and Debian 13 show the symptom and Debian 11 doesn't?
>=20
> Yes, and in kernels that is 4, 6 show the symptom and 3, 5 don't.

I think this statement isn't helpful unless you're saying that Linux
5.19 was good and 6.0 was bad. Kernel versions started with 5 between
2019-03-03 and 2022-07-31, not taking stable releases into account. And
there are 294457 commits in that range
(`git rev-list v5.0..v5.19 | wc -l`). So "kernel 5" and "kernel 6" is a
bit too fuzzy to work with.

> > In that case the interesting interval is 5.10 .. 6.1. If you could
> > pinpoint the oldest kernel image package that shows the symptoms that
> > would be great.
>=20
> I can show only the last official kernels in the correspond Debian
> distributive due to their applied in the Live Disks!
>=20
> That is, I have recorded a video when the problem reproduction started, t=
hat
> is Debian 9 with kernel 4.9.

Nobody in the OSS community is interested in 4.9 any more. This kernel
version is EOL since January 2023.

Can you please confirm that 5.19.x (e.g. a kernel package from
https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
6.0.x (e.g. https://snapshot.debian.org/package/linux/6.0.12-1/)
doesn't? (Or a similar statement with other consecutive mainline
versions.)

Note that even that might not be enough to spot the problem and you
might have to get your hands dirty then and compile development kernels
and test them.

Best regards
Uwe

--q2mpyaq27v2ydmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmke030ACgkQj4D7WH0S
/k6Gbgf+Mi99VhlF2xEbFvN9qTwHY8cJEoXpr7Ih4PXNLqaVH8ysM4TMERog20wt
QRNrMeIKqgVoIvjG4xXUYOl+kiEsdG6UhWCk1NtVWuszGuHFL1iEVItr7V4wkvNp
QkE2PWG3PotdXr2+iyWEEkAS1kXHgin9idePnFfdOuJRSfwRDNV+Bbfj521tf1h7
cy8KEOdGI+e34/DfBUWF0t1BwH364DAx97aMmqWd0Iwwh5jLJMK9EOzrGmIriQC+
HwiPibzUaRoboSM/Ju+sGDwDJtBh3hWF6Nux+BN5SkurO84ysrjigXudUowmyYKH
r5WYVm46+JzBJobc3Y84zyNegXJ4gQ==
=GRVO
-----END PGP SIGNATURE-----

--q2mpyaq27v2ydmum--
