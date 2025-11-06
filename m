Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4986FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 02:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D9310E7EA;
	Thu,  6 Nov 2025 02:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltdaPJt1";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C44A10E7EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 02:40:58 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5db308cddf0so366744137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 18:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762396857; x=1763001657; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fz3VOOaK2WJzX49TNEhoEpdRHL0wcrha2M363m/VmQg=;
 b=ltdaPJt1fgwyiaDtbvhT51QdVdYjjC75nydjokcdh/CkBg3Xtzp9KQPc5CsJwQNqlf
 C8vcXTYkYg6felLuioj4OoNpN9eAOiez+bwfygidtiTTJdt8sfF+veorr+JNtWewGUNr
 ytO3yIv2iPs1rVNGfVA2BVLVkdjW2ZqHdwxAXxxzLEeeUUAQZqUzFsuTXfjDZiv8yFAN
 H3w0baQTy25k1UXUWr0iwrJZJRd1yZp+JALaKvGQ5TBB4aoW8SxLkH20lpfhMBY2YHr9
 opwLoXAG3DwIDgYlGCfAf9M9bUy0rAdiCyuaj+5MKkxk1IbwKxz+cIALzJnVvGIpq9vZ
 GRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762396857; x=1763001657;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fz3VOOaK2WJzX49TNEhoEpdRHL0wcrha2M363m/VmQg=;
 b=nUM79jPoYGyQfp03kGJYoJy0gDSVyg1UZlrkuNXosoPEcnhS4erL673gdex6EcqgwR
 RgB7vbPrgfy+G+ZOz7wJduRHMd0qHHTRD7JMRGJ6D61jkmR1r9Jaj+E5AD5qdNTqEZGS
 qZzapjGj2dfr6L8XJp/qbUvTIlYv5h9CqxEwdmBvQcKwH3tdQF4MKklQTr33cQYiZHad
 FIesv76QofR7w0GzkaMkpspyn0688xGzWvQix18dHnVCI0FAOeOmtGYMCsW7G12fpbRY
 gdc5Q9ChbadoJUNngTnu2SW+MC8sMyUjMxh+LiFFDkwH+sKKq7lZn4pL/mTNjwnyG0o2
 vovw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEKjUvx8OWT7VW5nxQ+JAR9oZ9fOSYPxygcHacVOqqcUo6xy3QVWRqaNEs4269/jNQ7cU488qA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg/iLOMVNo5nC/QKJZglOjN0rnLzopCv91PyJckz3Sxljpq6kF
 QhSRW4Ts1mg7gea8F7uxzAAnMh7KulrMN/WYokq3rM1znghogPfsKsT5
X-Gm-Gg: ASbGnct8FZPpnGrI/Iovpxjh0GgmZdAb2fAXkdnIHrIfwezBmXJeb+WykphH1q90Qzm
 LBkUdJgDl474lZ8roS/MNXQLK6Ysx1ZkMpPoQ2Hw2kSwosFAdPLTjaXc7XCn+PwHmRwb/ZsBgAK
 AWBIXjjiPcrD2lArRnPPdgqaNF2IMpFQOnWJWHnMvsOb6nc6H8aabQTZHEmbL+6tLfZvE0o6KJ8
 S34dJ3oDNBZyv2zNl9rOEzw3HuStiN2f8smyMxY7pxXzew4bpeZc2zeJq6byd1E1WqGxm3tk/u6
 fF39Hs4WsVsasQ2i7JDDbOBt2yXgRO2loYy+6P+iL+Axcde5jwmKkyBLMkapb5vzOHQZHvnLfQG
 BWEPw9VKdN1CMTKOzp43F64aR+LtvK1frqTnKF9bcWneWFg1V1n9RGWL24ru+nU/p9P+lFyRtvD
 mgyk90IV8uDCKL1s1SvZUvpla6lAHqAYTM/Ufgfxi1l8yvGFZnp3/gyEw=
X-Google-Smtp-Source: AGHT+IG48Ju4qzSiYeWrBUsxbdpp5+5EAVK8wecVkm+QFCx/tSKCn4HCOp+AQxx2reLlG02y/qKwQQ==
X-Received: by 2002:a05:6102:304d:b0:59d:ad3:e1e4 with SMTP id
 ada2fe7eead31-5dd89174feamr2084724137.5.1762396856783; 
 Wed, 05 Nov 2025 18:40:56 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-93708862f07sm500320241.7.2025.11.05.18.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 18:40:56 -0800 (PST)
Message-ID: <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David
 Airlie	 <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel	 <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 03:40:52 +0100
In-Reply-To: <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
References: <1043551.1761844832@turing-police>
 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police>
 <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
>=20
> >=20
> > What do I need to do to trigger the warning?
> >=20
> I have the same problem.
>=20
> linux-next on Arch Linux
> GCC : 15.2.1 20250813
>=20
>=20
> Steps to reproduce the error
> - make mrproper
> - make allmodconfig
> - make drivers/gpu/drm/amd/amdgpu/
>=20
> Turns out its due to randconfig, See [1]
>=20
> Setting RANDSTRUCT_NONE=3Dy seems to stop the error.

Can you please try and see if this fixes the warning?
https://pastebin.com/raw/b8j3UABj

Alternatively, if anyone has other recommendations on how to fix it,
I'm also open to suggestions.

Thanks,
Timur


> >=20
> > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=91=
pont: 2025.
> > nov.
> > 2., Vas 1:59):
> >=20
> > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > >=20
> > > > Can you say how to reproduce that?
> > > > I use the same version of GCC but it hasn't given me any
> > > > warning or
> > > > error for that patch.
> > >=20
> > > Upon further testing,
> > >=20
> > > [/usr/src/linux-next] make
> > >=20
> > > is sufficient on my system. Turns out that it errors out even
> > > without W=3D1.
> > > My
> > > next guess was that it had to do with -Werror, which would cause
> > > warnings
> > > to
> > > be treated as errors, but my .config has
> > >=20
> > > # CONFIG_WERROR is not set
> > > # CONFIG_DRM_WERROR is not set
> > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > >=20
> > > Do you perhaps have patches in your tree that aren't in next-
> > > 20251029?
> > >=20
> > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > from the
> > > build you're using....
> > >=20
> > >=20
> > >=20
> > >=20
