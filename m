Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2192CCFA1A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 13:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925DF10E73B;
	Wed, 12 Nov 2025 13:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SC2eyyki";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC66210E6EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 11:14:08 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47777000dadso4801575e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 03:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762946047; x=1763550847;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bl6SQ7qXUiqcsgLtkIobuKMONTtj6njnFMSz31EY+yo=;
 b=SC2eyyki/lxmHW+lwuXhlIssf3puxsFQf0Jwx6srkZCSDXBJFrNLAtzKL98EwZ0AyJ
 zOIyCVgNcWH0mKMvvwxRLjUlVhAX2suQl/yIDlwiP2USYeYFexdxUVRyABJsSYyaYwj2
 HO1njs1fjhfmW+to01Z4B11D5mT7qF5wX4rQTz9F31xZxdSe8XZRLueraVYzYCBxgNfC
 DNfUUHJ0soqjD9Inh8WF3pzbbhqVl+e5QifZ79/lryoGhJKcoK6zJwlO6Cz6+SIpkYUB
 MqkJ2EGZmHv5BBUxAVPPm3bgSk+YGzzaie7ujadI0o6zKsT1TlvuUeD+DJrN/3wE3wdV
 HVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762946047; x=1763550847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bl6SQ7qXUiqcsgLtkIobuKMONTtj6njnFMSz31EY+yo=;
 b=cWOc54oqkILAfMoVlPlL6yg1wDwlbUOKY8toAEuCvkMHpy/E3gO8FZOyLD1qSf6QAk
 N5jnrARX13Duo5E9UkQmAxWRtp8zvn5ikmyIjdZer0rjZzUEaOEA5sp/OncOfszlQSAn
 aZZT2hsSE6qOxgOK7t+8m3OyodBKGkRvE5YlpWmw/OsYVaUAWk+e8lfdwN+zYVZDquC0
 3LsDG8pqpTP4ezAJ/wCk2s/dY7LJTym7iZgAJcPW9dxsjCWV+574W6ntISo+/3FemoBO
 sYI1CWrldIFAORRJPo2fXNyNfqmSQotTBUES9JTrBatGDOTH2Ju3nsrh1CmQH/k5wocC
 zxkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoEKbL/9E2PlomdyJuvHNgHWo2LdNW5DRB+k9WlZKjXsuoRcc6Bmf2uYcumYsJN2Ug3WTvFozi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZ+kou++dNdlqfh61ZGXRYcZa4Fxi/IzsOtJo1OCfTie5kjmEx
 C5aJGEYrSX+SOoAdZ/THxy6cAZTNTnJxjOmeLEFQNrHl/6VwAo/qSEM46dL/wvhZng4=
X-Gm-Gg: ASbGnctXVKYei3nH6W7dyPpIW+ZAhfvMUy3vBPNYGalyEJKreeBPy4LnNAovi/B+VJv
 qv2mVBdqDyiy9h5TvGdeWXQoFiAtWjpEzt5oxZd0Qg5GI53OqdfLgDXCDl50HHrSyKBuvqg68Qy
 rhhTMLJ26bYQld537G/zF6KbDvwKecOwwiXcHeZyfz5p3FlvwPcb79qfnRraHIek0ukjrPl7CfX
 Fs6Wim80IRTC0n7eyma1dVayPvbt/B2gMsfosLUYAQ50ch5mNdebDkxGOAS7baqboKDWAfAjwBD
 WSxbS12th7UftFRJNcAmrasUKivdknNkqkTiVPEoO780Rdrz7s+dfvafD/ROtOT5vDaOlOQuKiT
 szRO8GoACAtoc3YyuimWkmedzECufJQBMl0JjSRp7g8XefTcUwyOxHRHgO2pj7VHGQ0b9G/13PI
 Hd+ML4feNLu144yppkNBkEB/fygoIGl+4mZeUBYCQks9AB3hZt2oJL2Uz+W42MQ7w=
X-Google-Smtp-Source: AGHT+IFj7KpEwtDvFUrxkk4xtX7koUrgkhXj2xWlcOj3+ngcrsL/TuJRI6i4yinoF4negQfiC7WAXw==
X-Received: by 2002:a05:600c:4f50:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-4778703d5dfmr25615445e9.4.1762946047093; 
 Wed, 12 Nov 2025 03:14:07 -0800 (PST)
Received: from localhost
 (p200300f65f2353044a0b0c67e5b226aa.dip0.t-ipconnect.de.
 [2003:f6:5f23:5304:4a0b:c67:e5b2:26aa])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47787e87cedsm28753225e9.14.2025.11.12.03.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 03:14:06 -0800 (PST)
Date: Wed, 12 Nov 2025 12:14:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roman Savochenko <roman@oscada.org>, 1118349@bugs.debian.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="scqk2hg43lpurx5c"
Content-Disposition: inline
In-Reply-To: <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
X-Mailman-Approved-At: Wed, 12 Nov 2025 13:42:52 +0000
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


--scqk2hg43lpurx5c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
MIME-Version: 1.0

Control: tag -1 + moreinfo

Hello Roman,

On Mon, Nov 10, 2025 at 10:00:01PM +0200, Roman Savochenko wrote:
> 10.11.25 18:35, Deucher, Alexander:
> > > Is it a sensible quirk to let dpm default to 0 with that hardware? Or=
 does the
> > > behaviour depend on (e.g.) the actual monitor in use?
> > DPM worked fine on this hardware.  I'm not familiar with any general is=
sues with it.  It may be system specific.
>=20
> On my hardware that doesn't work and there is no specific.
>=20
> Now just I set "radeon.dpm=3D1", I got immediately restart with disabling=
 USB,
> so I have needed to restart for successful download with "radeon.dpm=3D0".

Can you try a different monitor?

Can you try which Debian kernel was the last one working fine respective
the first being broken in this regard? You can find all kernels on
https://snapshot.debian.org/. Please ask if it's unclear how to do that.

Best regards
Uwe

--scqk2hg43lpurx5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkUa/oACgkQj4D7WH0S
/k64HQgAqQhyw0z7OHphdv5jihelZFB9nJdFZb5Hco+1r4NAUu7zu2q4NWwBkUwL
Jhe+9DYzCAPxOvhyG2dDogBYl23A8j9k3y88YKmlH8erUhN/VIx7V92mHkXL777v
H+ImAekcBGNzq6vEk1qxn58PK9u7oQWtYtgatkUUhRmPbiB0CGyACWBE53hI3NmJ
0H/l7XfqdduwBUFJ1Ox8uMLwNa988Vdj30VTnA2XczgBF1pT286Up0BjSYCVYS0v
KE7IzcHOe4THykE5l+Ld1xNHiuy8s3lGUf2G0c3HDJvuAELySFA5mhGEUjM6MTdP
XlF7fsxCPRXwcMOXal+SnfS0Wu6ngw==
=5B+T
-----END PGP SIGNATURE-----

--scqk2hg43lpurx5c--
