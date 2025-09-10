Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CEECA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 09:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1318110E0ED;
	Wed, 10 Sep 2025 09:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXmaU2mb";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAF710E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 09:34:59 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-24b13313b1bso48263725ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757496899; x=1758101699; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HXbAsR7aVzqW9fkya7RufHoVSzXiKWBBOA2e4TxC9iY=;
 b=DXmaU2mbw64lDNUYz1XE7ERV8TRtsqV04+FKhdbF8Huh9qMrB8B41D07YZnsGXwW/A
 tbYQbD3twLeYVaiRvNpGx/pPvPrKu98uK7KvaGR513xNE6PgasvYMWdEMdqJ+6XhTtSF
 XjI0hYLmhd7liB1xodtHBMzMMkBJsL3xbCMAJPSGhL6z71wEdnpcc1lLBkttjiZp2BRY
 S5OAocZbsU/UcFQxAiAnhXJzD6O8d+7N/MD1q22iD7FdU/KpVAWP02feYHMBDg6mDuwa
 ahiqnodVsXaUuX1rAU5CD1CZHiG6h3uinAJ6hhCh9g78nG/muAGCdYT4VuAoMUvOOKNq
 bF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757496899; x=1758101699;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXbAsR7aVzqW9fkya7RufHoVSzXiKWBBOA2e4TxC9iY=;
 b=Km1JwA9Pv4NhlbsZuFx5wJ8kGuXBM3jdk9fVQb/DFHtLHsZVu/OIFcUP0TSzjkJjZx
 ZZRuPVKOzQxG+wHyCs2o10SE57bquTp/lB2g7W/ndQYrI9tOYzVHMnckzymbDwo2dzRq
 jY549SpIy5C1DH3j0GwU3jpqbGuW47KWF/SyjdZM9M91uefJYv9ewB3WJbpsaCbV2t9W
 2CZxuoO3BenhZTcAbkHoo7w00zCGggO54b4EYaZu0Jr+LyUsVV3+bCIe7PE2jrFmCUGB
 bT0EywaJc9y6DmNoziL21QfvW585f9Kpc17akJMyIWXqYjSCl7+kt27K7zoj6tzdIo+z
 KscA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqjZQDV0GS9RhnYoh6oJbiZfi6sCqzVNJXzt70PaZ2IOOxllYbsMwZzDWRCt/fXFQ+BynXgbdb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2rTzjwzSZhKP/9QJy3z9kSXnMjZ+zPziCk16Vyq85CD2CGn+f
 4nBgqrVBk/hUmAmno+OeuzOi3HGySlGrnDXA6QL7QRkHNWcYWH+jPb7H
X-Gm-Gg: ASbGnctcqtJrfHER6y33iUjZjEzxs5yTOUYbUIf1O44vaZnVuyFiJm8+q9I9FL6VnI3
 GoKHIA2QqiQ79jW89DY01gxJptoXCpST6YZcH4ZtB2hxW0JnZcaSPFV9Rhk/s9CYurVFExZybdq
 jC/QWWinVCqg5p0po4P2m6jO+XDQ95X8wZYUYQXSXfMXtkd1ZseZU5TDv2mjDpPf+AB+A0bSLzq
 +OCjSFcWrEncCZ2sawAuJuMtAWu+axahfFwbF0ZR1SPghkPY/UBx/KgMyx1RoGpOmUQZSmZscW6
 6PG/Fydsbe6+LuPG+dpSEIifgsOgOqrovkNiszP1PKdBDMZ67hRbVDNunHICDaWX5YRNY9jGNlR
 RNXv6ETv9F2O6ARhUmi1dNVl6cEpOBTAtGj/uoG5tQ6ywo0Og0CHR4+ASMfvXWYSmqLP/3nHhUL
 M+7uqsio2t0brhw5BURbsGYh3e+77nGTcjtsx5lwWFldNtYvWqqExb0xvFuR5YVEZ92aysw2PWf
 aWMmaPbarfh
X-Google-Smtp-Source: AGHT+IECr0geTRsdv4blLJYS1bKVoFI6eqD70xvLSB2AOQSrtdGssxUOoVJemVpbI9kG11SGO49XfQ==
X-Received: by 2002:a17:902:c94f:b0:24c:bdbe:cc90 with SMTP id
 d9443c01a7336-2516f04ef6bmr224381965ad.1.1757496899081; 
 Wed, 10 Sep 2025 02:34:59 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2?
 (20014C4E24D7A1006CBC3A09AC015CE2.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a274258b6sm22010625ad.26.2025.09.10.02.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 02:34:58 -0700 (PDT)
Message-ID: <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, "Olsak, Marek" <Marek.Olsak@amd.com>
Date: Wed, 10 Sep 2025 11:34:52 +0200
In-Reply-To: <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
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

On Wed, 2025-09-10 at 10:34 +0200, Christian K=C3=B6nig wrote:
> On 09.09.25 18:56, Timur Krist=C3=B3f wrote:
> > > Even when we apply it I think we should drop that, the value the
> > > kernel uses is correct.
> >=20
> > Hi Christian,
> >=20
> > The kernel and Mesa disagree on the limits for almost all SDMA
> > versions, so it would be nice to actually understand what the
> > limits of
> > the SDMA HW are and use the same limit in the kernel and Mesa, or
> > if
> > that isn't viable, let's document why the different limits make
> > sense.
> >=20
> > I'm adding Marek to CC, he wrote the comment that I referenced
> > here.
> > As far as I understand from my conversation with Marek, the kernel
> > is
> > actually wrong.
> >=20
> > If the limits depend on alignment, then we should either set a
> > limit
> > that is always safe, or make sure SDMA copies in the kernel are
> > always
> > aligned and add assertions about it.
>=20
> That's already done. See the size restrictions applied to BOs and the
> callers of amdgpu_copy_buffer().

Based on the code comments I cited, as far as I understand, the issue
is with copying the last 256 bytes of 2^22-1. Do I understood your
response correctly that you are saying that the kernel isn't affected
by this issue because it always copies things that are 256 byte
aligned?

I checked the callers of amdgpu_copy_buffer and can't find what you are
referring to. However, assuming that all callers use amdgpu_copy_buffer
on 256 byte aligned addresses, there is still an issue with large BOs:

When the kernel copies a BO that is larger than 0x3fffe0 bytes then it
needs to emit multiple SDMA copy packets, and the copy done by the
second packet (and other subsequent packets) won't be 256 byte aligned.

>=20
> We could add another warning to amdgpu_copy_buffer(), but that is
> just the backend function.
>=20
> > Looking at the implementation of
> > amdgpu_copy_buffer in the kernel, I see that it relies on
> > copy_max_bytes and doesn't take alignment into account, so with the
> > current limit it could issue subsequent copies that aren't 256 byte
> > aligned.
>=20
> "Due to HW limitation, the maximum count may not be 2^n-1, can only
> be 2^n - 1 - start_addr[4:2]"
>=20
> Well according to this comments the size restriction is 32 bytes (256
> bits!) and not 256 bytes.
>=20
> Were do you actually get the 256 bytes restriction from?

The comments I cited above are from the following sources:

PAL uses 1<<22-256 =3D 0x3fff00 here:
https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c54=
9bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308

Mesa also uses 0x3fff00 here:
https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d48=
e511ae078f8c2/src/amd/common/sid.h#L390

The limit in Mesa was added by this commit:
https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0=
d41c095004232ed
According to the commit message, Dave added this limit when hitting an
issue trying to use SDMA with buffers that are larger than this.

For SDMA v5.2 and newer, a larger limit was added by Marek later:
https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660=
cc4b3f8abbde259
Which confirms the same issue copying the last 256 bytes on these
versions, although in this case the kernel isn't technically wrong
because it uses a smaller overall maximum.




