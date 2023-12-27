Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88179C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 16:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC22891A3;
	Wed, 27 Dec 2023 16:12:37 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ACA10E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 02:30:33 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d9ac0520b0so533598b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 18:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703644233; x=1704249033; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0xBQFRljuS9xylNChmSTG+Qfitf8PreuDOuqdWWJFaE=;
 b=c7J680pWix3epOud5xEoysTtXUtWECsIwwL/nf6wuk4hhVNO4KpYUleSXZXqekj1t4
 nsASkUf2+rpLd8NrbysHAT8N+CNy3n1hRg9wjEN9fDAwSw21ZGnZnISe+AelwPNj2HbD
 Gilpioa/W0/ARw98UVrDZHIRVB7RhlMYmxqW8jRgmLd5+S3zO8kQrtG3la26Tf/7oqhK
 QVfw9rzBk58nzJ1D/D7pfLf85zvBOM3orKwSCG2WrgAFMNIJWI3LF9Awwrh0GmR7ndWO
 EKXn3TJEJl79vZBNUB1XUnFJd9sIjZ0o4ovdpjZ+YTgDwZHmwhzQM77BG8XPH455SwSJ
 +KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703644233; x=1704249033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xBQFRljuS9xylNChmSTG+Qfitf8PreuDOuqdWWJFaE=;
 b=gkcuipbHo5FLceuiOn8ruObzLWFvUDNTJEM73SHnf/6n9nKQry9jjFHTadRwgwQW2S
 gzeB9sr3KjPLdHz33d4njViQOmQh86HCLofa2PM6nLVB9Wa0uf6lKfhz4sqEnCugtzQO
 ajKVGNRpo11ypO09Moojr8UnsgLx6ds/UN1zSjVkeC9SrjehNLddYs3f5bpPXT/xQPyg
 05PuQ/KmPGao/EPu+bwA2outWp9wkRB8ApQAZivER8D4TSid6LXrcoMNs66WRysqXN9A
 Y60TsskLYYWBjDHTnuYg4OUZydlc6aHLWKzZvFGYSfJecug3ita+ZjKZ8x3UDYqSSKNc
 CbVA==
X-Gm-Message-State: AOJu0Yzu1racw2xbXb2tYe2SkT2PLAg0mKxAcqLkQ9Yh4GBF3Dl5nCK6
 EvJMM609oW2os59z8i+Teds=
X-Google-Smtp-Source: AGHT+IG+MdvAkbNYUXMrY+Ex/TfjFJSwXDbSpWCZpzIXMEpnK2Ai7ihhFdQ35uuh+PBi/Ud8dCq35Q==
X-Received: by 2002:a05:6a20:160c:b0:195:edf4:9e8f with SMTP id
 l12-20020a056a20160c00b00195edf49e8fmr674581pzj.66.1703644232903; 
 Tue, 26 Dec 2023 18:30:32 -0800 (PST)
Received: from archie.me ([103.131.18.64]) by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001d4752f540esm1744485plk.198.2023.12.26.18.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 18:30:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id A304610205C65; Wed, 27 Dec 2023 09:30:29 +0700 (WIB)
Date: Wed, 27 Dec 2023 09:30:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
Subject: Re: [PATCH] Removing duplicate copyright text
Message-ID: <ZYuMRZU85plJiVWO@archie.me>
References: <20231226235741.4376-1-marcelomspessoto@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZGVgynaKhqIN2HVd"
Content-Disposition: inline
In-Reply-To: <20231226235741.4376-1-marcelomspessoto@gmail.com>
X-Mailman-Approved-At: Wed, 27 Dec 2023 16:12:36 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--ZGVgynaKhqIN2HVd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 08:57:41PM -0300, Marcelo Mendes Spessoto Junior wr=
ote:
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
>=20
> The file display/modules/inc/mod_freesync.h has two identical AMD
> Copyright texts. This simple patch aims to remove the duplicate one.

Hi Marcelo,

The patch subject should have a subsystem prefix (e.g. the full subject
should have been "[PATCH] drm/amdgpu: mod_freesync: Remove duplicate
copyright boilerplate").

For patch description, I'd like to write it as "mod_freesync header file
has duplicated copyright boilerplate. Drop the duplicate". And make
sure that your Signed-off-by: trailer is on the bottom of description,
before triple dashes (`git commit -s` does it for you).

>=20
> ---
>  .../amd/display/modules/inc/mod_freesync.h    | 28 -------------------
>  1 file changed, 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/dri=
vers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index afe1f6cce..cc3dc9b58 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -1,31 +1,3 @@
> -/*
> - * Copyright 2016 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -
> -
>  /*
>   * Copyright 2016 Advanced Micro Devices, Inc.
>   *

The diff itself LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ZGVgynaKhqIN2HVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYuMQgAKCRD2uYlJVVFO
o0qFAP48gatzxW12gHZZvhcbCTjbLWlzeSScerZ+QyttfS1K4QEAxEaqJj86R9nS
X7dnpFXXjKu+pZ+rN8LzhrBwEQgndQk=
=xonQ
-----END PGP SIGNATURE-----

--ZGVgynaKhqIN2HVd--
