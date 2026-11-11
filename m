Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132D606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eQIgQn/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9983689ABE;
	Wed, 11 Nov 2026 09:37:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3484010E9DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:04:49 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso28187685e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794387887; x=1794992687;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sP7k6XjcVumCLj2NxGQn6KKl25HOAblRp6pXpTH9GPw=;
 b=eQIgQn/BEHgv1PIxN/oPQH+GEMlJj8Ic1Qly6o2qIW5ZA6OFX0i1+Wb09yfE4JTXa3
 iwHv6HO6jukke0JK4qskPzi/03ek3vYFjgYzZqCgGqQmghb9LUx/gP6IbNzkycVnq1Lc
 ZFs+8P1FwKr3uCXQYRQ+eapHHF2h0KhHIC5hMEXxOlCqcXo9d4CX2LQZbMaLnQL+w74d
 qSZzF9z4q7XhxJi4YNbX3wm7Te/kPnxesk8fG4Cye4H97JUoP3BieAYvy/L0pSX7NYlN
 hLMBuDBOGOeOvPU2IjPjyzvV2A15QWp31lSajjtfB2roR+42zYItBtz0HTp/GGCpVPKq
 q1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387887; x=1794992687;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sP7k6XjcVumCLj2NxGQn6KKl25HOAblRp6pXpTH9GPw=;
 b=S1klbouyot8FKLQt5bxUESVSa70Mfr0ST8VhPKpqRPiaciC26l3+MascVrzzHxY4yn
 pG25eXhEGL5TRs/uGA+razD6M53lABXbIjwExrhYa1nxnQz5ynMatljxDpzI10VAaZzu
 VlKQVdNnOjh2RGzE3bn6URYu8rnxWCNlRl/c7fj2/qBsYpCSSfm/okNz/MkoR/CCTm7Z
 Xetn+mrF7GVnJVAnhkW8rPG93ve1EkI3ml9fo+PvJGBaf69bTDxE7bm1fOZNXhs311Po
 x7nCtn276I+Ztaw5Ud7UnDuxV0AZQI0ILlANtQWZVlz15HrZd9W8WTzFQdJtePWR0GiR
 NK5w==
X-Gm-Message-State: APuU4Z9mKtzTU+7UxReMdv1VJEl8DIw5kpR6d5db2DhWGFCkkAPDPbFQ
 yyjOeDhOU8PLJC0+dKNBV6IpuJUr+wBK3NvpnOL3BerkYnb4lQx7rzcY6llQX6yVR/U=
X-Gm-Gg: AYBFou2d6bB9LLejFtYpQil+ky8QldN+pdZ1EL6ayffmk4mZnL/diE9OQnD1MqadvjC
 6r4OmfIG31KbHweIea0Kku34AVV80hgsYAQYGvcGKOWrNf5Xxg5drl+0jIz4V0zIA7L4DYpKKeQ
 kfr7XCEc/6/k3k+Qc7bOvNEmvKZ5OWm1EIET0mgdSbvJC0nF2YFRHPYRLvor3G4DhQdDJhMYKY/
 ULP/CV6p/5EF4vsrSpeN/glBIY24gVIBNuNV+VUgxDSCpaq+zcC2ng8LmhkF3+UqsVCx947jPDR
 4pPDnQu4YUZVoZXpaqrFTW4K7fHeU9SBwZPwkzeKxylh3lxA/cScNSd1UTMgaRf1I2CrAPA+qGh
 x25PTPtjqO35zKQ6PCnlNXxlSoC4DCgN9rKAcceSIj8gVrNU+YRKbCowhdP8R6XgK+aJR9dty5g
 BhIgM4Pe0tMooHsAmbbPUasTtmNm1sculbnxuB1Y8LfYn3CgClxRe7Q6NtfpWMfGgKwDtcrsiZF
 rnYRswfwVcLzV3BbEG/roqoo9xYzbbjV1bIKZ8GF3xFFHYMCy+mKyHMgAdR/fZ2vc3t5Y8VE7wN
 VefOkJ+lnWqU8emKP25vl8bmfOME8C1kOsYhbmJCiE6+AtWV7OKAVyy93l4tObPVjZ3R53wLO1f
 OQGOMqkpKA06RzGz650D1kpny13zG7scI5VA=
X-Received: by 2002:a05:600c:4e87:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4ba0938ae31mr28591735e9.32.1794387887546; 
 Wed, 11 Nov 2026 01:04:47 -0800 (PST)
Received: from localhost
 (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:6051:dd5:6fc:51af])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4ba09509c74sm24119845e9.2.2026.11.11.01.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:04:46 -0800 (PST)
Date: Wed, 11 Nov 2026 10:04:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
Message-ID: <avQvaiaEyWDUQsZz@monoceros>
References: <20260430102958.136859-2-u.kleine-koenig@baylibre.com>
 <aimXCmtgcejwInNg@monoceros>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pma5azs7fhrm2bnu"
Content-Disposition: inline
In-Reply-To: <aimXCmtgcejwInNg@monoceros>
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:24 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--pma5azs7fhrm2bnu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/radeon: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 06:56:35PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Hello,
>=20
> On Thu, Apr 30, 2026 at 12:29:57PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The struct pci_device_id array of supported device was initialized
> > by list expressions. This isn't easily readable if you're not into PCI.
> >=20
> > Use PCI_DEVICE* helper macros and named initializers which is more
> > explicit and thus easier to parse. Also skip explicit assignments of 0
> > (which the compiler then takes care of).
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > array. Tested on x86 and arm64.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> Similar to the amdgpu driver patch I just pinged, this patch would also
> be great if it made it in for 7.2-rc1. Please?

That didn't work and it failed to go into 7.4-rc1 either :-\ It still
applies to next-20261110, is it still on your radar?

Best regards
Uwe

--pma5azs7fhrm2bnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0L6kACgkQj4D7WH0S
/k4KfAf/f5q3Vl7EnPVZaB/M3tX4n0SFtnKOCJkLtj4107/VpJ+jLb3mrCXFulXy
Z1rgfK86pXvaFuknlwOCHRZ6mpoZCgbp7YQYcc1+hWncLfLYFcnGvQKoZLKP8RK6
yHLzpWaGzaZvH7Q6DBQurfqIwGwTNRrFyZzi4ILzOS2nIhFGSsDwCxKAlkX1OrEp
d1wJQgg7dLK5dcHAoejIUCKED5kOVs+Sh81KFrkkgvyDB6FunShTz3T3Q0BhTALD
c1MP6XcJaHm5IpB4yWysfiiuKeYcO45KZSSKa0XoBjpmhXooicsJk6ggWaQbxElk
MUXB5eCUZ9TeWy82BMLT7UZrHZzvRA==
=gtpi
-----END PGP SIGNATURE-----

--pma5azs7fhrm2bnu--
