Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBC6D20694
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 13:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFF310E1DD;
	Thu,  4 Dec 2025 13:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GLrtC2q+";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7779A10E81D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 23:58:48 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2953ad5517dso3437395ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Dec 2025 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764806328; x=1765411128; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GRvZmNocZChOaH+XMJgg9lf8vYT4BPfuN+xdAI+uCKk=;
 b=GLrtC2q+V0Pfx22c3ZFaglPxuL/qjChCorLeXyUMmFMQk9pk7dc6i+yaoXNLqoxGGH
 mC51v1ipvnycfx/fVPpYiNylLi6lYglqmkGAWL7wy/D8MABSWxZDYfbxwRdBpdUYsStN
 Qq5HhmPjwaasUefP2qlwds7m+inmIF9m+3SQRjoUQBKBa9EoTorC9NqCOtDSUZWMgIGz
 gJlHaId+P18UD/EoClYkIpmiPUMQgyoUic9RLJDoTulyyVGUF6b+OniB6YoFShoKg1P/
 TsWy8zKFrm2cD0kC5H1Wq8omKhKH7hvqvKwUu9r7GGt0Q2Z+LShCp00WWLPhPPjAUyhc
 HIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764806328; x=1765411128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRvZmNocZChOaH+XMJgg9lf8vYT4BPfuN+xdAI+uCKk=;
 b=LCqgzG9heqs1bLD0ZcsOgiU4d20hA/LaQHLoHm0R7FRD5+6zL7E2Ax7N5fTK3y8/Kr
 ue4P6Tu8C18fY6q2X6EeOxaMOaGt3V550Lbp8hZbbaqFcoSeWRvGug9uF6J3KvmokWtn
 RfKpjr40PgX7HfYVdxj4IA9O7cui7KaaauJ7mAAj3ddx+C2DofKsFCbBFOWGq3ahRZO6
 Ei2EeLhok5PryxTdUoC2i4BnYWNi9ha7395CnkHori3GgdpaxnWh135NY5mnDH4dnQcs
 RUQQ7TNSdNsMuENreWrEkC+q1l8Qhc6MtddGcXKBiq7QziazAdr/4oX8aS28FxZlWb3D
 Ibvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxRc4v3VXkldQpjFRz8DKvsT3IO4ltduXJtY2tZPSGzHCQRABAMYz6/tJYDXMkClnw3CDjkOUp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkK7CbiXjzxYn0lZAmHqMxkpAv2xQywVKM1I8Tmt28meb3XJCN
 p70fwXKyfI9Kk/mOuiflet1ONGQbnUKiH2Yi5QfVdLGdbKdzFo6yB1a9
X-Gm-Gg: ASbGncsmt+SHENRaKChzY//kdv+i1+g65E7PCIMnm2qDSb2UQjSeQ6wDuvRe/m0FOzg
 HVdon7+UboX+b2P0IFLsK0zMdaN+ev3y/DlWeZPTtKmDHNAco2Y47PTbug6A6BWRfjPqPruj3hp
 gDAjGZ7LOoIYGB8Bnrh4OTVKiw0sweNBxa1IrX3BavrgCb0xy2ExOUQ8D5e0vkMGBshs/daFOME
 5EAI1h1R2dawxglbSVoC1sPHF1FJIrqgTT4etQH7feMMf89w5cpN/Z7G2mYAlXwFV39BASCRcNr
 Uk6HFNbYIHEzlZELkrg8yTz2mU+6S7P4fhZ7vjkiJGdlw8H807kO4iNArlCrItQJtCsgCpdr4Fp
 Z4c4lBbo4ViKmWXjTQ9dBgsUotAEzlUCkOvrnVf2LyzXvoONwre6zH5Z301RXpCboObeFmUMamG
 j0tzBTS4v6zcM=
X-Google-Smtp-Source: AGHT+IGLmOh6OQdBHx4G5q4S6N/1ExJ2TdxuwD40xz88RA8jLaB2hG2Ymfw2hokNgJs/XVsvYbEIzg==
X-Received: by 2002:a17:903:2ac6:b0:295:507c:4b80 with SMTP id
 d9443c01a7336-29da1f20fb3mr11557625ad.61.1764806327742; 
 Wed, 03 Dec 2025 15:58:47 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29dae99f223sm236425ad.62.2025.12.03.15.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 15:58:46 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id 86DA441E8D3F; Thu, 04 Dec 2025 06:58:44 +0700 (WIB)
Date: Thu, 4 Dec 2025 06:58:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.18 amdgpu build error
Message-ID: <aTDOtCpsnfHZIJLm@archie.me>
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
 <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="erbTTBANn0MwVJLS"
Content-Disposition: inline
In-Reply-To: <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:40:42 +0000
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


--erbTTBANn0MwVJLS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 03:16:24PM -0700, Shuah Khan wrote:
> I am also seeing issues with cloning kernel.org repos on my system after
> a recent update:
>=20
> remote: Enumerating objects: 11177736, done.
> remote: Counting objects: 100% (1231/1231), done.
> remote: Compressing objects: 100% (624/624), done.
> remote: Total 11177736 (delta 855), reused 781 (delta 606), pack-reused 1=
1176505 (from 1)
> Receiving objects: 100% (11177736/11177736), 3.01 GiB | 7.10 MiB/s, done.
> Resolving deltas: 100% (9198323/9198323), done.
> fatal: did not receive expected object 0002003e951b5057c16de5a39140abcbf6=
e44e50
> fatal: fetch-pack: invalid index-pack output

I have no problem on my system (running Arch Linux) when cloning sparse.git
repo (also hosted on git.kernel.org) [1].

Thanks.

[1]: https://git.kernel.org/pub/scm/devel/sparse/sparse.git/

--=20
An old man doll... just what I always wanted! - Clara

--erbTTBANn0MwVJLS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaTDOsAAKCRD2uYlJVVFO
o6b+AQD5uSCz5nOd54BudHosSWoAiEPzzQFwHE2XFagnsG3HSgEA4HpLgkS7ZAM4
HrYlOF4SRvIYztoJrs15CyANGFpAtQA=
=IrVl
-----END PGP SIGNATURE-----

--erbTTBANn0MwVJLS--
