Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD02CD343A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1C210E69C;
	Mon,  4 May 2026 12:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KRD3pgMc";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B092C10E1D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:25:58 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so16246245e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777645557; x=1778250357;
 darn=lists.freedesktop.org; 
 h=mime-version:message-id:date:user-agent:references:organization
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DYv/GlnIowzYK/Y+vOhHbB/BH7X8bAFCbDKncVCH2Ls=;
 b=KRD3pgMcyJWmTzUySZUJ88SGPbfcfIJHzlZatOJrKN/iddWj5hik40rTa2FFFevl/s
 oejvEmbs8BM92YBhSS0DvFFLDdrQnFClbFh3e4nMZcYcSAE+GIEiz2AgVdftTGDbMEd7
 qxFjJ72cY9jeL7qmwpbU7fhjY/a7Wm0lKonDBzH2CZRmc56CQn2ajnh+w49mvfAJUJkw
 sdl8+fIy/SQj9M2vzHbEG66qRZrfNlrLcndfXvHgLg+kwK8z+YSXlTiVJA5AWX10kNGU
 Gr68CeqAZ7hUDdzkYn3tc02eO3V4GzjOSDxBIwfBZDkokhEtEl+X09a+cKAk0m732dFY
 iIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777645557; x=1778250357;
 h=mime-version:message-id:date:user-agent:references:organization
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DYv/GlnIowzYK/Y+vOhHbB/BH7X8bAFCbDKncVCH2Ls=;
 b=Dw2Go2FOgRPSStl7ItHTSthSEGcrBZDdqOQZiSFYMMGC5QEE31M4yQ4Z10SWH1Czta
 1fdHiNsX5wCDk8sA39NJpANTTg9wbj2IeHW62E00YU5MdlBGfmsdc1IOgwBuqiSBf88h
 V4s6wdlYM8QQC195rBjRrvvm1LvsAgFE106vaZnRixT73a5JYey5i81xZ4Tf9dY/APEP
 ZQK+MlcHEQUSta7bF0HEuVwZ0xl9syn9rp+NFNIlp7g81YY5YvK7NCxVMvpj5ndrgbgu
 64s2hZ+D92ekJPSn3y00YerAUPirf5lc5L1nLDbPJo9jVbDOAMsbHiZFOx3dsdxQuRht
 YAfg==
X-Gm-Message-State: AOJu0Yw2HZypE00T8urACX+aeDp4o1yJxxH4lK2WuPzfwKByOEl3ExGP
 umUlweKojNZy6saDqkJQrsAy48W3IR9FJKF6rr+8Dz/ZCYrye7ji+SzE4+8NkqmrZYw=
X-Gm-Gg: AeBDievNGnXhzC4euTPuYNjy1NbpDTCdnjRFb/ii2BN3Z8JCjw1pDc4wuOJ1zZBvElH
 TZ0oVRPytT7zovUtc/43jLa0zVQW2PMABck73cBS1P7LsAg/fjOAzx+AHThE1sfEeOeSEtHf2z6
 ejW/jVBd1LrPsGNRt/H/Pfi/twknY2i9sKOz483uTmUjYxu3AyECARx+oqVGK44FUHfeRGDG9h+
 +Op6LJvJatmjgESpJGPM5bHt+Uc9URkTHKrAItZe+mwvAyQP5LB6zhSxOThFmdFcZKNMvYWudfh
 ZGcxx8xjPjCvFPQq+CZ6VbrKsM/6e2WU6/rApZXX3JzOcV/EnZRgjYHuUY/5Q1/BO7WVUrOBdoV
 Q0qiVl88ugyjnxrJxVlvsAagK0hkh9Wa5dhU/9SPO7oEeGHHG69Hc357BEOYQ+jKqcsLl77Lw8T
 lEEkBx9WIqRxXgdnMKS2HdX6jx2K1D
X-Received: by 2002:a05:600c:1f83:b0:48a:674d:e756 with SMTP id
 5b1f17b1804b1-48a84458f63mr116689945e9.20.1777645556755; 
 Fri, 01 May 2026 07:25:56 -0700 (PDT)
Received: from bstg ([146.70.193.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm51896485e9.11.2026.05.01.07.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 07:25:56 -0700 (PDT)
From: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: amd-gfx@lists.freedesktop.org,  linux-mm@kvack.org,
 cs-tech-ext@baylibre.com
Subject: Re: [BUG] Frequent hangs or WARNINGs when using heterogeneous
 memory with an AMD MI210 GPU
In-Reply-To: <afREaF6hcka_cxnY@nvdebian.thelocal>
Organization: BayLibre
References: <86ecjz2hhr.fsf@baylibre.com> <86tssu0w8p.fsf@baylibre.com>
 <afREaF6hcka_cxnY@nvdebian.thelocal>
User-Agent: mu4e 1.14.0; emacs 31.0.50
Date: Fri, 01 May 2026 16:25:53 +0200
Message-ID: <86340bp5ou.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Approved-At: Mon, 04 May 2026 12:42:21 +0000
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alistair Popple <apopple@nvidia.com> writes:

> I don't know the AMD driver well enough to comment definitively but
> chances are this warning is spurious. I have been meaning to put
> togeather a fix for it.  The problem is that migrate_vma_setup()
> etc. allow for migration of anonymous folios, which is subtly
> different from only allowing migration of anonymous VMA's.
>
> Specifically migrate_vma checks for folio_test_anon() which returns
> true for private file-backed VMAs while the warning is based on
> vma_is_anonymous() which is false for such mappings. So it is possible
> for the driver to migrate a private filebacked mapping to GPU memory
> which will trigger this warning during teardown if the page wasn't
> migrated back.

Ah, if it is spurious, that is quite unfortunate.  We were hoping it's
the same issue as the one the rest of the email was describing (those
hangs, unkillable processes, and bad page states), since that means we
have a good reproducer for it.

FWIW, that sounds like a plausible explanation; the program is using
dynamic_cast, so typeinfo will need to be accessed.  The typeinfo is
mmap-ped from the executable, so it's file-backed.  I don't see any
reason for this page to be thrown out of the GPU later, so it stays
mapped until exit, and causes the warning.

The trigger for the latter is significantly harder to reproduce, and far
less self-contained.

So, I suppose we're left with a bug for which the reproducer "run more
than nproc of parallel AMDGPU&HMM-utilizing processes in a loop and
cross fingers".  :/

Thank you very much for fixing the WARN_ON!

Have a lovely day.
=2D-=20
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEKBAEWCgCyFiEE/uKz0RP8AKMWLWBhUsKUMB6ixJMFAmn0t/EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRGRUUyQjNEMTEzRkMwMEEzMTYyRDYw
NjE1MkMyOTQzMDFFQTJDNDkzGBxhYXJzZW5vdmljQGJheWxpYnJlLmNvbQAKCRBS
wpQwHqLEk5KiAP9PMMBwrhXRhH/toIRa9Gd89OXC/klbJT/ORaNbQLu4ZAD/fjQY
F8L55iUDPgzIF3dph1C7Td/BL6/SbmcILMaW4QY=
=+HE3
-----END PGP SIGNATURE-----
--=-=-=--
