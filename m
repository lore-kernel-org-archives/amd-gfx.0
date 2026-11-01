Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCE606A32C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjJsJ2PF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A47A10EC07;
	Mon,  2 Nov 2026 08:07:30 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A07110E3B6
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 23:37:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so19196515e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Nov 2026 15:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793576244; cv=none;
 d=google.com; s=arc-20260327;
 b=EYz/ru8kknv9rV2t3nsWzD6THQLsQq2jU+5ZDfDTZkZLIzrnQKKr17l6YE9VU+Omrl
 OFaVKRNM+c4u6nG5eXqx6ti5OCZQhZNaiTU4kQxLOBDvLuZccoLY5PEGUgGS8rFUzxBy
 lzkOrj9lqTvn6DQr6yADwEibegChRQ7HIuy73g/zXCdaGH6Gbfc0M6JS6oQ8qJnuCIhA
 86bMl2nrnM6ZGGP4k9QKnYkiamvH0KlHwPm8bSah171gR/5Y3q+68btplT2g2tPND42U
 C8yMlazOtkgXeKwXDKXVNe6mylVK/lh2M79ZRpRWbufip4RMIWLMSD3TzuuBhl2zg6GA
 6QxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 fh=yXVx3fdyNGachXNsXgidlHJkhkdQSLsQK8wg1ZxtFJQ=;
 b=k5+skekt+9cpo/CTcF9JyvebBoE+uvIy+c/r9ljWpHtIJxXUz4vH4QS/y0sY85sN72
 79SA/Q+BJFrXBq35lhFH3RhSQNvWxXBBZvw8pqHjOn8njub32BN//+JO961zBU46g+xU
 P6/UEmyxPuo8iBbqhd/wH2goK+n8kdzRQDYQzihJdaCy4L3OGVBaI3KPVz8+X1dFA650
 leKQ//QXY1CtK7mDrp5pn8lha+KoWBrTgk//ua2r34S3HZZEvHDKMGZUX9FoCiy5UlBI
 vhg8FOwMMDoEjZIcIUkYyLfD/jmyB5xoyM9HJ6uUmfvwXSs8s1uvtNA3p2gt7xX9UDMg
 Bv9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793576244; x=1794181044; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 b=SjJsJ2PFQa5Bcv7PUbUgpRE0t60QeXfn1ClzbdhA9Qi9Tl0KDw2kpv9ua9eo0ZdxNz
 sKxOuYKr1iXhy6SrOY/W2yI3nHaxl3S1ivM8gXRo2SgrwkRMBfTaJ0hlAo8HmlCVWLYE
 gSZljv0oZMaxQXlCqVPsUlYorrm++nL5di9aYZfIXPuPTwIVItUaP+KnXTb1UhR8vPx0
 SKK7wECon7WtmwzfOToZvckIV0BLTBkpqP1lcbghV0/LxseKw46R5Sb+K5/fbdvrnrXr
 HH8yeSCkJXd4Cnmwqd/m3f5itOl+gkCUgzkjuR6Gn+u02GDot31FssMjfE/NwtDaDxPa
 bDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793576244; x=1794181044;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uycyJS0DpZnW8iPJ9gPVOdKwEEcjN0iqSHG3ZEmJNDY=;
 b=dN3nN3XDVKiRNP0lY0YWllypELNxTuFQnMV8pbohrT1WOLWdJg0MDKD0i6wEKNMheZ
 0FEEWQAm/8OYJy+T0lzwr7t07mDhkjegTbU8g3kWhwWNE9DDxPk4AQzjhQv+fjYzOEAw
 aCcY/4QQkAaSltN9Ymj1NEVwr8526YCyQ/Pz7V5zC9gRyOkXRlepkVzdm2Jbawv5zRSc
 jXSBKqIZ92Dsr3YDh02NhmHufNaFt1WVjCttyeg89K/w/SJ5FT2xXiopiR1gMRZkNZYR
 Gkl4gvVI9FWXMOLYmMuWpFWG4XCyKbT0d19Tea3fXYFqB5tktoq1F8y1Y6cIpXj+ElyF
 mzVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ3LWVtLmhqrIWTlskvfTj7bw02aKTjWZizpVkwQ5TqsMM50XxZhbLkEQyK+yhlcnL3tj/B2x6@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2faVmTPEzAsKNRanttO0YUKmx1CqcCa/KB3bxaLcBM5ZwO9n0
 LfNSRftlXsfNPjf4RmHcAVETMZuEFSAyM5b2Bju1TBtP2ha4Q4qlSa1MKH+P8tiI3FSMy1Iks4P
 W4kU9r/yJxsV2uxgbQvot/BHe0kBG8yk=
X-Gm-Gg: AYBFou1jlt2ccdJUKpZcrXA+hTUQUGKpOwEp4PkWeTP2Ugjx8X/VCf10sBKanLwwC9h
 bFmR908CzfpJITOFKWLVVCT3AGakYKXIZwMBa0O4zGNRmArjE1urcWf1jQk3g6PgAGyIF8ZiWjR
 kbdb9yEPaiozXYvmrxOrQ5h1J6cG6JLze1DgXoAvO5yVXJ7xcTveBa88xvqkFyFrHvEMkRE2CR8
 WI9VPpiiLgIOX7f5lr3sOrLtyQjv5wMVjR/cORohEYiD/kAaZUa0w3vK4kCaX0BrCH2OhbVPZoX
 vXRaaa7nJzme06Se8TjwOBTchFRE3yi7NtasDIK92t8j/ZXSc44dEb/VLYDsBov8174g49+VDVE
 gEXwUPwSqmHHeu94XXzz+d38qWb9NfCZdU6+KA4A=
X-Received: by 2002:a05:600c:6089:b0:4a2:a8c:22b0 with SMTP id
 5b1f17b1804b1-4ac14ec75fbmr185544245e9.1.1793576243659; Sun, 01 Nov 2026
 15:37:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Arnaud BERTRAND <arnaud078@gmail.com>
Date: Mon, 2 Nov 2026 00:37:11 +0100
X-Gm-Features: AclHuK9ns4XBGZ7zNo5bqw4a_9l2SxlgD9VWWmJ9YT0QG78bE9OgwzMy8CJwXYU
Message-ID: <CAGxFSwnBDM93ouN6Aq2ppm5zF1h19XE6NJ92NT2UEhMP1P4xEg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Oz Tiram <oz@shift-computing.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I have two dGPUs : a Radeon RX 6800
XT and a Radeon RX 6800. They both report the same PCI identity
1002:73bf and each has a different VBIOS.
I hit the same VFCT bus-number mismatch on 7.2.10, but with a different
outcome: on my machine the device-identity fallback actively breaks the second
dGPU.
I patched my kernel to remove the fallback, but I would like to have a
better solution for my use case.
Would it be possible to apply the patch only to APUs ? That would keep
Oz's APU case working but a dGPU with a stale bus number would fall
through to its own ROM, which is the source that is
guaranteed to match the card in the slot.
I can provide more details if needed, I am out of my depth here.
Thanks
Arnaud
