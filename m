Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EB8CF9C74
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 08:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24AB10E7F8;
	Fri, 21 Nov 2025 08:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YEbfbG2P";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1142510E2BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 08:35:28 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso2973016a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 00:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763714127; x=1764318927;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jVahUwMSPAWIbUd4G4WWiZQjpXqyMYOk+KCmtOmyOFc=;
 b=YEbfbG2PpMhmrXe/7h5SaKPQ+6rzEhPdZhliMH3CmujafdOcUVF416Nh0DH4js2RpJ
 34yfWIytunJs3EvAYeQc+ptTlVIX3p991lcsNwFUDEsb1DMLv0AcJ4KvSNvzu7nxLnxA
 XR49mkwAG7AMluppQPV2uYUPYKk7rX/fcbw9xYsLIlWpgsrYJn2+oMIDNQEPVMBLzlrY
 YzFqamlaG5HjqbWIR/cRHfyO932UaY/WxXFuHLF5OTpw5l6KWehXUMFSMyDY0HocT/Gd
 OBRANM8YCxfMcvP3zxcD1PNCZg0SIyy4sz/Ts8vpmd/ldSKMNODCIO+RSe6cQ1BdOiQP
 yMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763714127; x=1764318927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVahUwMSPAWIbUd4G4WWiZQjpXqyMYOk+KCmtOmyOFc=;
 b=NDWfobdIbalJseaota5+eWWksk6RKtI+VfLjG4wE8x9PeJz8djcQ/sZ19aNubbSliI
 egqVYCp+VwiekWEyuZ4YzTWtIUM9J1KwIivpwBmY6WQv7ro4i6bApFT+DUhZO8GviM80
 n9tlaWnIT8rtCCnYtJF3OwCZheKmYYiwZRbTncMEjlzRvYLeLMLNp7aNvtKbVHVj47g4
 D4da5WrKhX1JExUWGbFpRs5eW+UUxAVkHJVS0LE/qGWFXKDN9hmtxGKqai85JVQ5v846
 vAaDp6BaGhBImg6FYCv6jt0TqF6Sefmifh4imlDCBUxwDyQnwpt94ZvDJtFBJVMer0S6
 qGOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXukyJr5Cbz9oiOTlvqUY+DQMFGI+dTjRddNMDRQaOEDx8j0aoa7JjvkQXL5x+Ml0f4C65mivIs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxXteRLxh8dgpjAhxrXK5Dtf4wjWMrg2Gk/AN8VXSd/UwC8aI3
 7ffjWhHdFH9F3QqBijvgpbipOBwH7DELKBxkFXMN9C2NlMOfWqZJfwe3R+k0BdfE7+8=
X-Gm-Gg: ASbGncshMeenrYw98FaoY6oV3SzF/zZ/6DXKJoJEgQULHKWz3PzruGHoG+VRftKWCZP
 BzJMmR0dJ/Ybv2b1IBhd1mVdSka/dmaS7DawLsZmdDkCEW97PYFKqnQFauxiCk2wxShbIObziCY
 j4SHxuWkxTdZckw/sJvb/gk4eCgklCKSqXQbuyMVpig+sipGyEOucvq9+09ti+FyXSjMTBmHXgn
 0PWHgUR7VCLsr6Yca8Wjxf1zGSsTEgqPyqFCd3gZMbYQWTEfhqYbZ2xU4q/My88viyrZ2FXO1Mr
 xaNxDhqISQCi7f/LS4HOOz6fpvV3MLG7NdkmKE63cc2OEg2KFlORXkma2OVhD87nm4bw7m4niS4
 l4YNoVY3TMs0GqmK+y6tjhtNWPXJERNA7omoj55kYqc1FKRMTDB3dSppkP5VG0Y8YAKzTUQMgd6
 ilE8wDxWjlsnbz0x2XHfu/HLzebaqq1yBxuXL5aTzNUONPth7WLRUo406pFZmj5PdtElUzIqguh
 Ko=
X-Google-Smtp-Source: AGHT+IEMiLJH4Ga9GIKj75UCI5p33B8WCCewVUKBk993fLKB5PgF0CNMipmsIE1/6pH0644NMj5SKQ==
X-Received: by 2002:a17:907:6eaa:b0:b72:e158:8234 with SMTP id
 a640c23a62f3a-b7671558169mr132777266b.3.1763714127103; 
 Fri, 21 Nov 2025 00:35:27 -0800 (PST)
Received: from localhost
 (p200300f65f026708fb6c1faf4b8beb83.dip0.t-ipconnect.de.
 [2003:f6:5f02:6708:fb6c:1faf:4b8b:eb83])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654ff3c6asm400146266b.52.2025.11.21.00.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 00:35:26 -0800 (PST)
Date: Fri, 21 Nov 2025 09:35:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roman Savochenko <roman@oscada.org>
Cc: 1118349@bugs.debian.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
References: <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qj4wtpoc3hkxeqk2"
Content-Disposition: inline
In-Reply-To: <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
X-Mailman-Approved-At: Fri, 21 Nov 2025 08:57:04 +0000
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


--qj4wtpoc3hkxeqk2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Hello Roman,

On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
> 20.11.25 10:38, Uwe Kleine-K=C3=B6nig:
> > On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
> > > 19.11.25 19:05, Uwe Kleine-K=C3=B6nig:
> > > > On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
> > > > > 12.11.25 17:03, Christian K=C3=B6nig:
> > > > > > On 11/12/25 15:28, Roman Savochenko wrote:
> > > > > > > 12.11.25 13:14, Uwe Kleine-K=C3=B6nig:
> > > > > > > > > On my hardware that doesn't work and there is no specific.
> > > > > > > > >=20
> > > > > > > > > Now just I set "radeon.dpm=3D1", I got immediately restar=
t with disabling USB,
> > > > > > > > > so I have needed to restart for successful download with =
"radeon.dpm=3D0".
> > > > > > > > Can you try a different monitor?
> > > > > > > I have only one, connected through DVI, and there is no probl=
em on Linux Kernel 5.
> > > > > > Kernel 5 what? E.g. which concrete version number? (output of u=
name -a).
> > > > > user@debian:~$ cat /proc/version
> > > > >=20
> > > > > Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (g=
cc-10
> > > > > (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debia=
n) 2.35.2)
> > > > > #1 SMP Debian 5.10.223-1 (2024-08-10)
> > > > >=20
> > > > > > > > Can you try which Debian kernel was the last one working fi=
ne respective
> > > > > > > > the first being broken in this regard? You can find all ker=
nels on
> > > > > > > > https://snapshot.debian.org/. Please ask if it's unclear ho=
w to do that.
> > > > > > > I can try all kernels in Debian starting 7 and finishing 13, =
but I have traced that before and the problem reproduction started from Deb=
ian 9, terminated on Debian 11 and renewed on Debian 12.
> > > > Not sure I follow. Does that mean that Debian 9, Debian 10, Debian =
12
> > > > and Debian 13 show the symptom and Debian 11 doesn't?
> > > Yes, and in kernels that is 4, 6 show the symptom and 3, 5 don't.
> > I think this statement isn't helpful unless you're saying that Linux
> > 5.19 was good and 6.0 was bad. Kernel versions started with 5 between
> > 2019-03-03 and 2022-07-31, not taking stable releases into account. And
> > there are 294457 commits in that range
> > (`git rev-list v5.0..v5.19 | wc -l`). So "kernel 5" and "kernel 6" is a
> > bit too fuzzy to work with.
>=20
> OK, and what do you want from me?

Quoting an earlier mail in that thread:

	Can you try which Debian kernel was the last one working fine
	respective the first being broken in this regard? You can find
	all kernels on https://snapshot.debian.org/. Please ask if it's
	unclear how to do that.

> Must I say you the exact commit or what,
> or you are waiting I must recompile all kernels with 294457 commits?
>=20
> I say you in what way the problem related through the stable kernels in
> Debian releases and that is exactly assigned to the major versions of the
> Linux kernel, even for broken v5.19 which can include backports from 6!

Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
several years of development each and thus are not helpful to locate the
change that broke your setup. Unless it is really 5.19 that was good and
6.0 that is bad which limits the amount of changes from:

	git rev-list v5.0..v6.0 | wc -l
	311041

to

	$ git rev-list v5.19..v6.0 | wc -l
	16584

=2E This is still a lot and we might ask you to do more tests to further
limit the set of candidate commits that are broken on your end.

> > > > In that case the interesting interval is 5.10 .. 6.1. If you could
> > > > pinpoint the oldest kernel image package that shows the symptoms th=
at
> > > > would be great.
> > > I can show only the last official kernels in the correspond Debian
> > > distributive due to their applied in the Live Disks!
> > >=20
> > > That is, I have recorded a video when the problem reproduction starte=
d, that
> > > is Debian 9 with kernel 4.9.
> > Nobody in the OSS community is interested in 4.9 any more. This kernel
> > version is EOL since January 2023.
>=20
> I just say you all history of the problem for detect some relations.
>=20
> > Can you please confirm that 5.19.x (e.g. a kernel package from
> > https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
> > 6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
> > doesn't? (Or a similar statement with other consecutive mainline
> > versions.)
>=20
> 5.19.0 has this problem in view of hanging.

You lost me here. What is "problem in view of hanging"? Are we talking
about more than one problem? Or different variants of the same problem?
=20
> 6.0.0 has this problem like in all 6 kernels.

ok.
=20
> > Note that even that might not be enough to spot the problem and you
> > might have to get your hands dirty then and compile development kernels
> > and test them.
>=20
> Note, my hands in that "dirty" are 22 years already and I hoped I will not
> get their at least on Linux kernel again =E2=80=94 http://oscada.org/wiki=
/Special:MyLanguage/Sub-projects/Automation_Linux_distributive
> . :)
>=20
> And I have resolved the problem for myself by the option "radeon.dpm=3D0"=
 in
> all my Live Disks. If you want to tell that is my problem, throw it away =
and
> reject the workaround!:)

There might be a misconception about the roles involved here.

In my eyes the situation is as follows: You have a problem. I (and
possibly others) offer to help. For now your problem report isn't in a
form that I can act upon. So it's in your interest to provide the
information that I ask for. If you don't want to do that, that's fine,
and I won't have sleepless nights about it. The likely outcome is that
the problem isn't addressed.

Parts of the misunderstanding here might also be a language barrier. So
maybe try to get some help in the kernel community that speaks your
native tongue.

Best regards
Uwe

--qj4wtpoc3hkxeqk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkgJEoACgkQj4D7WH0S
/k7Stwf/dHSRL1dkYtuqhN+MPFkBFrQOxGQnATsDWHYPjWEnXUXZY6IXFvf4iomu
4vhhM5hedyXuUOM+p2BXb97DykrhBDuCFMmJDm/e38mNjqGCPcgTczefHKdtxw79
pc6dCejQig6GJSIJS0vWef0lm52gUz9n2jyyn9acdDFVLk51naMs9YzLrG8+rYdd
YP8LcZpv5rNv42hHBR1fBJBpmva+wqnOYKRkMOWvZbipPQyUx0vjFWY+VKLe5OzG
Wi1ljIVFPZ/tstuTYAC75MiVnlxhrAyRWqXz/mEw0MG4OK/rk55g9oTtT6N+JAwq
wLy0cjy4lIbXqAnJHOmoWF3EClzTrA==
=QJUc
-----END PGP SIGNATURE-----

--qj4wtpoc3hkxeqk2--
