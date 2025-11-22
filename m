Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE39ACFD31C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA1510E1E0;
	Mon, 24 Nov 2025 08:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jxseR9Yb";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6525710E0A9
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 17:22:51 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b72bf7e703fso498888366b.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763832169; x=1764436969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ebvr+Er9ZmrMvX2hlDqQQqyIjJL0TxuMtB/bjzjqAeM=;
 b=jxseR9Yb1uCQ0dyF6rA49SzujCstAHa6M2VV1ooK13NG0EuZZHvYiy+PhRoxWYrZUy
 P7tWk22aCuxx90P2oh5bKZt0dZ1Lfix8AnS3n70Xbnu7i3pbXcbkcPRM2b6DIDK1r2zS
 rb9Tu46FVF4fsRVXUJudQ6caSEJi9imA97pJKO3EyTML3Ff0bhXUhfikdFVfmEsQ5Iq4
 C8Gt5iw3unPnburQ3m+q3o3izLTk1PSLtEYU1EBkvEvBtZjI+ezxiJySKPp0CCEbvtXZ
 85nb9PuQSC56/iaZ87xnLoSsAnJtshckVg5wL57aL9KWIBJMYqK+Zx3FQjhbRzxjnKfT
 dAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763832169; x=1764436969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebvr+Er9ZmrMvX2hlDqQQqyIjJL0TxuMtB/bjzjqAeM=;
 b=jegWds3PObyT4gjJu1qiyqzvfM8oB6xPcoIBfD0Q0zF686pYFfN+nG++nZOtKlIN+N
 jifZUjT9ebh9WPi7Db1yGLg/ynl9jKdPm55UBhxM1Ka34IBwyseV7uRDcDVcZgZupHc1
 +5pk84FmQEpIUERJPIxBp9XUzdEXJSCQ0o5Qw+Rf5Dfmif7NxKbG3s5CiwVdGJEMCNk+
 vTDCpXZOPd0IpInGJzLLyLK/zJQqrOcKU0/1ANOUREBLiqQ5qrERbFNWQG9u8yJPjodD
 lbAMMqfUWJ/z6apaCoi2SbTX1M3S1dUjnSwKrJ+cvLh9IMrDIMT11/y/mNWvYsTcoh/V
 4hYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtQzwB4BrGWzdvtSFFspDSC57Vw+IU2FrXVh6VEjCu0TWtm1MXMQd24veUvU4QWPaCcSoT1mY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYq92Mf1ufrWFVI3qUNhbyelIXl14MXe17RXWl/6tMlvTqkRm6
 CLXqp/Nc7Qz+Zg3WjMLdU/3LSIo5oZ9R1q4XZpZ/RnFbC0C/P+0KdRmnTJoOgesUZR0=
X-Gm-Gg: ASbGncvQLjhaIjWrdgQomkwq5ICkXxlS6G/wPJj9Oq19iwjRWxKAsykdAtd2S2TpB52
 BVAZ31hqU3lk6wIv5cfR1a2gPPbOA+t14iRpsJIl7atNc2hxiFXeyV8tB+WgaWRo08F3QIjITac
 hEuMX0nuQUGZV3hky7BVJxshVKP1PIw+UG8+Z8TXxCMxAsjqqgovM5AObKcgk4lrF8BvOuY/ZWx
 hghh4ls4gvAjz9iR800wy0Y28UbneYCBMy8kxO19rkBUjokpGAnhog5dKMRmXuXqdUy8IB+wwLf
 geEmrcT/x+MK24GswTuD8nrbzDBvuhKqgxLZ1y6qeaH/9rUbiVn+lpOTXC+I33cMOKSe8PZIJEA
 qaacILoL7LgP5lM/KNJPhcSzZ+lRtWfJ/CPCiIbapd6AIOrRaAV3e57kFbouZchiqKGbzTGFamu
 9emKx9GGYHAkKoMZ3g
X-Google-Smtp-Source: AGHT+IECpl96bi+jTaR7ifan1o5YuVFjhQ1FfEsRqKJAvWqHZyJjxHr7Ac0zwWV4qI9zfj2Gr9K4+Q==
X-Received: by 2002:a17:907:2da8:b0:b76:277b:9a5b with SMTP id
 a640c23a62f3a-b76716888b5mr656892366b.6.1763832169447; 
 Sat, 22 Nov 2025 09:22:49 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654d73e6csm783956766b.25.2025.11.22.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 09:22:48 -0800 (PST)
Date: Sat, 22 Nov 2025 18:22:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roman Savochenko <roman@oscada.org>
Cc: 1118349@bugs.debian.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
References: <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="47wkgll2lv4ybpsd"
Content-Disposition: inline
In-Reply-To: <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
X-Mailman-Approved-At: Mon, 24 Nov 2025 08:12:45 +0000
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


--47wkgll2lv4ybpsd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Hello Roman,

On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
> 21.11.25 10:35, Uwe Kleine-K=C3=B6nig:
> > On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
> > > 20.11.25 10:38, Uwe Kleine-K=C3=B6nig:
> > > > On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
> > > > > 19.11.25 19:05, Uwe Kleine-K=C3=B6nig:
> > > > > > On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrot=
e:
> > > > > > > 12.11.25 17:03, Christian K=C3=B6nig:
> > > > > > > > On 11/12/25 15:28, Roman Savochenko wrote:
> > > > > > > > > 12.11.25 13:14, Uwe Kleine-K=C3=B6nig:
> > > OK, and what do you want from me?
> > Quoting an earlier mail in that thread:
> >=20
> > 	Can you try which Debian kernel was the last one working fine
> > 	respective the first being broken in this regard? You can find
> > 	all kernels on https://snapshot.debian.org/. Please ask if it's
> > 	unclear how to do that.
>=20
> I have told that as the kernel in Debian 11.

Is that the last working or the first broken?

The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
the last in buster-security which would be 5.10.244-1? Or do you mean
the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
think)?

The kernels before and after that are depending on what you meant above
5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?

The gist to take away here is: Don't specify kernel versions as "the one
in Debian 11" or "kernel 5" but use the proper kernel (package) version.
Everything else is too fuzzy for me to work with.

> > > Must I say you the exact commit or what,
> > > or you are waiting I must recompile all kernels with 294457 commits?
> > >=20
> > > I say you in what way the problem related through the stable kernels =
in
> > > Debian releases and that is exactly assigned to the major versions of=
 the
> > > Linux kernel, even for broken v5.19 which can include backports from =
6!
> > Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
> > several years of development each and thus are not helpful to locate the
> > change that broke your setup. Unless it is really 5.19 that was good and
> > 6.0 that is bad which limits the amount of changes from:
>=20
> I keep talking that only for understanding the problem depth and not for
> fixing that in 4 kernels!
>=20
> That is, there can be simpler to apply that workaround.
>=20
> > . This is still a lot and we might ask you to do more tests to further
> > limit the set of candidate commits that are broken on your end.
>=20
> OK, ask.

That depends on the answers for the questions I already asked and that
are still not answered in a way that I can ask the followup questions.

> > > > Can you please confirm that 5.19.x (e.g. a kernel package from
> > > > https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
> > > > 6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
> > > > doesn't? (Or a similar statement with other consecutive mainline
> > > > versions.)
> > > 5.19.0 has this problem in view of hanging.
> > You lost me here. What is "problem in view of hanging"? Are we talking
> > about more than one problem? Or different variants of the same problem?
>=20
> We talk about different variants, and the hanging I saw also on one 6 ker=
nel
> just after installing Debian 13 and that is why #1118349 I opened about t=
he
> hanging but not rebooting in the initial report #879992.

Here is our language problem again. I fail to parse that sentence.

> > > > Note that even that might not be enough to spot the problem and you
> > > > might have to get your hands dirty then and compile development ker=
nels
> > > > and test them.
> > > Note, my hands in that "dirty" are 22 years already and I hoped I wil=
l not
> > > get their at least on Linux kernel again =E2=80=94 http://oscada.org/=
wiki/Special:MyLanguage/Sub-projects/Automation_Linux_distributive
> > > . :)
> > >=20
> > > And I have resolved the problem for myself by the option "radeon.dpm=
=3D0" in
> > > all my Live Disks. If you want to tell that is my problem, throw it a=
way and
> > > reject the workaround!:)
> > There might be a misconception about the roles involved here.
> >=20
> > In my eyes the situation is as follows: You have a problem.
>=20
> I have resolved the problem for myself far ago.
>=20
> > I (and possibly others) offer to help.
>=20
> To help for other with same hardware, since I can fix that for myself if I
> need.

??

> > For now your problem report isn't in a form that I can act upon. So it'=
s in your interest to provide the
> > information that I ask for. If you don't want to do that, that's fine,
> > and I won't have sleepless nights about it. The likely outcome is that
> > the problem isn't addressed.
>=20
> Whether I don't provide you all information beyond "get my hand in the
> dirty"? :)

??

> > Parts of the misunderstanding here might also be a language barrier. So
> > maybe try to get some help in the kernel community that speaks your
> > native tongue.
>=20
> So, English isn't native one for you? :)

Right, and I doubt it's yours either. Or you would be the first native
English speaker in my career that I fail to understand when
communicating about Linux topics. (The only other explanations for that
I can come up with are a) you suffer from dyslexia; or b) you write
glibberish on purpose to annoy.)

PSA: This is my last mail to you for this bug until you come up with a
statement like:

	I tested Debian kernel image package version a.b.c-d and its
	broken with the following symptoms: [....]. The kernel image
	that occurs in the list on
	https://snapshot.debian.org/package/linux/ directly after that
	(i.e. version e.f.g-h) doesn't show these symptoms.

Best regards
Uwe

--47wkgll2lv4ybpsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkh8WMACgkQj4D7WH0S
/k6msQf/WD8rPN/drpv3sbAe+b6QUzgEMDq2iB8KfOJpmouQ6RWsHALz3mLQ8+No
KwlZIjC6NRoHiRVkYzL6hhGqsu2x6D9eVLGDW+5qB+tJf4dVlKnyOeYNK968KHMq
yF3Z1m2fDvV+cSdIrfoELOGQ5GkikgPCtp2CbHYmCtEiZHomVfCqMoJ5YOieFDQF
tu8jP/R/xcZ+hSdFTcwAsCS/cv+UTR+lSCnNenzoGElJVlscUvOzQ5nDztZAJxvk
LBIMS3iX2oPwIOOJ2827kyc73YcF/ptdKqLSpqDc7LDXuauu7k93XygPkAMsXQQc
jQW1hN6dWlzzEYzWPiKyBbDi9twDLQ==
=sqsU
-----END PGP SIGNATURE-----

--47wkgll2lv4ybpsd--
