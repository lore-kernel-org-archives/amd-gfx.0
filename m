Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC77C44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 07:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A53D10E6B9;
	Tue, 21 Jul 2026 07:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="EWaeLO3n";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B4810E18C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 11:34:56 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so785434f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784547294; x=1785152094;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5MEo8NUpZhRQI5j1rCBJtgFOMjhyLVipMDpM+l3a/38=;
 b=EWaeLO3nna+D5L9LsREjPOugThtVZrVwIVsTZHuzSzanTo/rVtcW7kKjN66rWnRPar
 1cBbd7YZoaicbQfmAx21upRLBlXJv4qZmCLzWGASDqSmC79kTB3HQcSrDaplkWdPmmBN
 gDFoPfL87yic6lBBNMzN1Kh3/esxrqv1Vw8dcCNZBYH6PHgPhVRGuX8/+273IoR2Nr73
 IoRkjvf/h+1r9Cki+UReG1eW0BjEXkK0x24zA9a0rYScZ5G64p9WGGdObLnBZTfyGS9T
 AEVWkHKgXifTYu4lEa86EhlFwWJuygzWWHr0IFcpvf2zxrdTFRaw2KB53cqYCR9FI+DD
 /h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547294; x=1785152094;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5MEo8NUpZhRQI5j1rCBJtgFOMjhyLVipMDpM+l3a/38=;
 b=ORcey3o9oCOagqIrKtcIm6RFxa9ftjenQGCMuDEi+8/nDzXeVi4JitiJvxvsrJJnD0
 ICePvn0T0k0u1CQjioMnYXgpy9bhhcCiRrJf2PkPQ5wacccekJAQOofArBYE0f8zP22g
 3fqYK+YJrbA26X0/pj3OM88QVxMBRiQfw7rw+Q2J2hXIiIDpj8ljaz5HFPe11zvJqTBX
 QCZJ1HYqeV6J+REWgIepg+all86EVmjlIE8cW5Id8biGFwaRhJdloSKTgfU4kN9Wdbzw
 Yobo844LxBAg5E/FcpqlHqsOKqTtmK6eGgPn4a4rSZZNWeO1oLC6DYvdfzFS3QOaaXhK
 NK+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvOjeTRaJm/9ZWSSnJeBNQBp0YjXjytMaJHu7FvEKA2G2BbGI+OIiD3fe1C7MA/XtRtxePt6Yl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEvjBIVATwgkDFth3AprwUd7q+t6bpFSKlh7+rrOfmG0dnKPrJ
 YsZsuCiPlMMSHnLi5cFUsjNuRuC7R+b5mYlXITgJ1Kgp2s69N3Wyn2Mq/rI/W6HtmUs=
X-Gm-Gg: AR+sD11kW7sgK9n5yMAB/TzQFbqpb0WFvSNUmDjUFi9RwZ1yzIFonfGDbrWYEZoKse6
 PFTSVU8TzLxIxqL2zQDTwq+poLXRcxmX43SKCjKzNueKs1FtFdGENwSDdndobV8s8R7aP2/EtbU
 OJOVRbWbPKmIOu0wc5k9DXXfC6KRHtM0xSrUDZcAiVk7eEm7Gn7qAXuJ7bbwvHpCS9hZYlJlQVw
 T4kndzJlswOYVmxWSloVMx6QQLxEfWAHrr441ysDcOuvxk6BLVG9Sskl6uHGpcjJt9dPPEDR/Cr
 7rDl3vUK2yS5929zgf5NMo8tjI9qnv4Eyl0bC/KWCoB+E8InVG7mHmXUsEhtE6H8DgBg/Cfjupk
 RoS05/YS9DGqzQ5fuBI19c+U8ZCfyiDDaEBfUav8ACpoQgswPS5jEfuUb5hRflXlnFCNOyKEjvb
 ng2ESlnjjdddXoAiVXVzmNmtWLZXZchRfXVx9LSEznFNmHjv2CGD+FxCvhPVroApS0cQ==
X-Received: by 2002:a05:6000:4b14:b0:47e:aa3f:f822 with SMTP id
 ffacd0b85a97d-47f6233be35mr16319068f8f.53.1784547294401; 
 Mon, 20 Jul 2026 04:34:54 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f6fa848fcsm19241724f8f.0.2026.07.20.04.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:34:53 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:34:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
Message-ID: <al4HlJxVqCDae5yL@monoceros>
References: <20260429171644.8406-2-u.kleine-koenig@baylibre.com>
 <aimWvtBTQvd7O2F0@monoceros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rjr5ydhtag5cemwi"
Content-Disposition: inline
In-Reply-To: <aimWvtBTQvd7O2F0@monoceros>
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:22:12 +0000
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


--rjr5ydhtag5cemwi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello,

On Wed, Jun 10, 2026 at 06:55:09PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Wed, Apr 29, 2026 at 07:16:44PM +0200, Uwe Kleine-K=F6nig (The Capable=
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
> Gentil ping! I'd like to work on changing pci_device_id, but that
> requires that this patch hits mainline first ...

Would it help to resend? Did I fail to Cc: someone to get this patch
into some tracking?

Best regards
Uwe

--rjr5ydhtag5cemwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeB9kACgkQj4D7WH0S
/k5Z6Af9Gq2QxbDClvePDJgb1S0Btc3vPaIme+YCro+lTIwcbZZ1CHZKRKdrSSda
ajvSbtUH6ZT2Dj/grtQNq0MAgwRXNJjpEtNUVhuKa/g/O9G6HseGT/JLZ6gpbE3V
FvjvZLvFYE0cC5UBxPsfpJZWSZ4b6HHG2yaqgGbKG01UIuW0bu2ElQXzN8z9FLqW
QjR8PEoBgfPQZA2TUqtRQ0tjbMFA+FEpFWkuPSmdDFVR4OPZUbAIltzKfYnCcmch
cEnAnx/m12gfxUS1cBy7m120C/Ko+q4UszZPzbPrivbFGby8/E52ee+rVAuzdcCE
TPAmP3ysP/Olxv7n3XJ9LHGrkhVHuQ==
=E0ji
-----END PGP SIGNATURE-----

--rjr5ydhtag5cemwi--
