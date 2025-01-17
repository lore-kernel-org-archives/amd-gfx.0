Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FEC02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 13:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A3310E30E;
	Fri, 17 Jan 2025 13:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=noa-labs.com header.i=@noa-labs.com header.b="CHP4GVZ9";
	dkim-atps=neutral
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3AAA10EADA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 12:27:45 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb7e725aa0so828979b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=noa-labs.com; s=google; t=1737116865; x=1737721665;
 darn=lists.freedesktop.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IcD6iONF1jYl/3AQEnjrI5kDYNGZJl5PbkHO55OHMEo=;
 b=CHP4GVZ9zQxpmTM3tMTjDZhw2ugupeLJC5S2z4FHlCKzQQcGdVzF2ZD2TZcUm0BOZy
 fa8LPQ97ZYw7+sIcLRRTlOGBOeCziLK4xSkvCPXWKJPvyfCMh5KuBwfmx7K4k+VWKYU0
 X4clVRxSVkFPRol3H5F+IJETnuSbBga1a7uZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737116865; x=1737721665;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcD6iONF1jYl/3AQEnjrI5kDYNGZJl5PbkHO55OHMEo=;
 b=D0KpvdY4+jSvMzJIDgb2K/rjfaaGs+ZzKy+yue4ZhyHJxJ9kk+6GeRqZG7FDkkql/7
 Je1QLHpv3raU7pH4HjikP/w8LyCK9uLqDocVc6vFXDE1LDCUJJD0VBVSTJ4MYjN+p/CU
 QVrsi0D/BteH5uwe8tPCxm2m2Uh/gE++EQGyTVlJy25nsFRqZzHDICKg1nz0aloKIS3M
 jxSsKnZ99BYl7EZnHErzevpNElCerR0cJbQo16VPvotFk7y6TLrvy1Q60FAYNQFx3JdR
 e4V59GadYgWh3OcacKILhb7gDpbZLINN+rkxE+Xkf2bbkLoHgAdby5VCz1ixfTHGLiTV
 6TCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQMDwFXt3US8SooMo2Ld8zSi8FPACN9WiLVk4diDvKXbGcal915Iyxeq43RbhKkb6bvjPRB5c5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLQC+Q+vthJYHFXz6bApo3TDwhfHScUTiCeADP/foVwvs/Q3qY
 KBIGe9CwCLKxo2povRptzWI6DH6Fwk4UqaT6YN+ecQwyayzh5U9L9M5QmstbRoxphOiUW3f05D2
 05w05lY3v1lvsZnmZFexdvHTTUADhJlTqKJ7cmA==
X-Gm-Gg: ASbGncvuDTHxC/5reg42/Ii7hoRqGsovq8uR4PjkM8oNPvcgiWLxU9WX5gn7tc/paCP
 HjYpV7uFu296k3bwiyPoX4K6J2Wceu0oOcwzCoBvgAAKmG8QSNRBO8bHgRxeVaf3HL+ag3+M=
X-Google-Smtp-Source: AGHT+IELAuIw16i4b4QS9hZ0fQDDSFeOPvB9tLwrYhWqptnG2iP8wny9TEwEq3mjp03Rwtf1S/qkCOnL0wniBQAbxSM=
X-Received: by 2002:a05:6871:618b:b0:29e:5dfd:1e17 with SMTP id
 586e51a60fabf-2b1c0ad0420mr1275959fac.23.1737116864834; Fri, 17 Jan 2025
 04:27:44 -0800 (PST)
MIME-Version: 1.0
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Fri, 17 Jan 2025 16:27:34 +0400
X-Gm-Features: AbW1kvYrEzrvb_JPM_Yi3jTQJPjR30QnVW2aWyLKWqh-cqOr5we1b4GhM9lBx2M
Message-ID: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: "alexdeucher@gmail.com" <alexdeucher@gmail.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Jan 2025 13:59:17 +0000
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

I think it persists as of 6.12.9 and today's firmware version from git.

Hardware Asus um5606

It only happens when the AC adaptor is disconnected, and the screen
refresh frequency is set to 120hz. It does not happen on any other
refresh frequency, or when the charger is connected.

It might be happening in Windows, but at much lower rate, like once in
a month. The windows version might be applying some mitigations.

Trying to catch what may be a prelude to hang never worked. It's just
instahang, without panic, or anything. I cannot debug it without
JTAGing the CPU, for which I have no equipment, nor am I sure if there
are even JTAG headers exposed on the laptop motherboard.
