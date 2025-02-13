Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17FAC0219D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 10:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C3010E2B9;
	Thu, 13 Feb 2025 10:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rKfjJO0W";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D753110EA21
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 08:43:24 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so91505766b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 00:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739436203; x=1740041003;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E7GuVlbsAtqSiVuG5Xfjh7yj9/bwGZqjpH5YRkLKt9M=;
 b=rKfjJO0WXwKjIy4njsm7QW5O0OrBiqqVnvcNfBe2JugwsKp+lO6teLkm4L6I12zG39
 TRYLwMMb12zEZNGA9fTfCunnID8kFrEyLXxUnDMCb2Rnzp3VO3EKf+o6yGxoUBZrT/VE
 3B7EWc3mwu248ZlhJHv9scH3l9pY2BlajktQcqbnEHkcqeY1a4ltbihe5dQ9PBv8pR1Q
 WveEEZqalxiLMVXDGxRtovZ/ENrN16efLBz1jest4KXy1Lh/6HqH2YbvxUG8k52a1DtH
 AOnoKaOd0fg5Tinx9UK863qm+nc3Ik3oJeWdhpaFALMcL1dBGME3IEZmk5Uy/pzFs92I
 9tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739436203; x=1740041003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7GuVlbsAtqSiVuG5Xfjh7yj9/bwGZqjpH5YRkLKt9M=;
 b=G4if6y2h6TtM10zu3eHNNnXuraIORfN/D3hw+JZoPJp9hlKLN27plvqTrAPhaSXuE+
 BSQNoj+bw70rD+JMIItqLIq9hsqK9SBGkX+vzJaygs9lDVI29sJh5zM+0+Km+XY/gJIo
 EQOYKkmc1/uf1afehqEFkvrLBvc0gWXL6JpAicCqdUQMYTiYc3VBwnT4jo9w/GsEFbmv
 rTq6fysKYsXdHrGFG+H07PuUBWQ1OgrI/rFIxvcr/ICMPXsbhJQpi6bck0baLoAzmtQx
 JaJeRTiDutDe87JKPS8KfXaw9WjObTdujo2DpIbdsGSxPPagn5AUVg6LPwdtEGzv5Dtu
 Rk0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUgtAgLOfS34Rhl1MF0vHtM/fKdRDlYygHILgGl44f+3K5rQXmxTdDkBsdCrXmakQkavTUuTTI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEQpcLg3TP3XvxyGUB7Ni7wS9SSFAucydy0AqIuZfvfAvFcid8
 tbmxV4PrcJi13PXFsl1UpVUAd/A0hqTSsvJLhD5ONtASsIjKVpIUhrC/yyJMl/U=
X-Gm-Gg: ASbGncsrZm+B0wo15Qo0Jzx2E0Cl4z91ANQ9j9R9nYUEHsHMlJH78JQPhxA6mEXvma+
 BpbGTeAMDuzN0wZNnNLz+4ylQnrRoOzj2wV/4w7t2yWtE6Zh99nOFXLGlbYitRX9PDe9pMA1/V8
 iGqcwnrTxt2pAlXvehnmy/bfpMqn1JNEmL5IZV3GarrhYi0E8RcdSN8aHTw+z9wXQ2DS2QMhPAt
 B4xE04Lqhe5Kbqe/Em1Dc0jDZ5PnehyaCScqhWnnkZo3bW2hquBaR7I1dvMuobWl691gi5YLspV
 z195EFYs4Zuf/4Z6cU9E
X-Google-Smtp-Source: AGHT+IFC4ljA8wwltB0xasz6EULC7geM5Zzr5NP5AJCPgvbCO/ID+phFeBvn+sF9xJWIxqJ2VVxENQ==
X-Received: by 2002:a17:907:94c5:b0:aac:619:e914 with SMTP id
 a640c23a62f3a-ab7f33b480amr740579066b.16.1739436202934; 
 Thu, 13 Feb 2025 00:43:22 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba569dd835sm54108966b.57.2025.02.13.00.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 00:43:22 -0800 (PST)
Date: Thu, 13 Feb 2025 09:43:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philip Yang <yangp@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com, christian.koenig@amd.com, 
 regressions@lists.linux.dev, Dieter Faulbaum <mail@faulbaum.in-berlin.de>
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
Message-ID: <qyjwmvbvhb2jcxwu5ubf4asghcovkfc2rfnrhdbbxa6dos5q23@k6b5ftwcefgs>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <20240718210558.26340-5-Philip.Yang@amd.com>
 <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
 <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="76qq4sekzudox6xn"
Content-Disposition: inline
In-Reply-To: <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com>
X-Mailman-Approved-At: Thu, 13 Feb 2025 10:34:09 +0000
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


--76qq4sekzudox6xn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 06:02:15PM -0500, Philip Yang wrote:
> [html-content]

Are you aware that your mail is hard for some people (e.g. those like me
who read their mail in a terminal, but also consider people who have to
rely on braille readers) to read and also isn't properly archived on
lore.kernel.org[1]?

Would be great if you could tune the settings of your thunderbird
profile to send text replies. The in-kernel documentation[2] might help
here.

Best regards
Uwe

[1] https://lore.kernel.org/all/315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com/
[2] https://www.kernel.org/doc/html/v4.11/process/email-clients.html#thunderbird-gui

--76qq4sekzudox6xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmetsKQACgkQj4D7WH0S
/k6Rsgf7BXpuAXhdwSjIKCfK4LG/paS+Dc554ox30FWJASPPEW3Z6nYd+onK5aRm
fjfL2BYUyFQ838cxeUV6RuRDHUp8pi04o7ljfUchJbxLOxNp2RO2klKgN4JtebBP
qW5bTzZpi+Y6rV6yyieEm4CuMwR5L1o+lMxVPf/mh3mUX9aEI8XYX02ewDu7pQNb
921o9tmJnTznQ5r65bEazwPf06jKj/73KKGYUhKXOAyw7COTxnH6MDvDglsjEabh
XKt4ChTLA0PnFhnHecvgX9TyV8gzrqoWIZ+4LBE6zaInVw7MrkTUSApD6F9koAJZ
PjqHqcwSUYNcMDYra01MKTzOfHOcfQ==
=2y3A
-----END PGP SIGNATURE-----

--76qq4sekzudox6xn--
