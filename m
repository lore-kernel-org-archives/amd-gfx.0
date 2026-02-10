Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631A7EB597F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 08:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E23510E22F;
	Wed, 11 Feb 2026 08:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="getsRlrh";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC37B10E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 20:54:51 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b88610494b8so74628566b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770756890; x=1771361690; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kfTsDpxF/1pt/GYWHrHA8HMvDdV44JWrQ/sRs5nS5WI=;
 b=getsRlrhs5aXI8H4t6kLLLmmI5oms0Fe/JO1IGf0xNA70h8ek4iHISNG0w4gX3F2v5
 mO72ZvrqYj3gXu8EN0l8i0ZBk+yodgAUM9kBQ8ZcQ0RtXJMNtd1lYwP+poc3Jk9ZsmXJ
 zx3QJ+nm2ssGzYzElAmUX38+CvODJfbgvrDnoPkr2WH3YCGxHUACpkFIDj5lZZkFVz89
 2HyqlmRURa2ktidFanp5wSUCHSvMbvPK2tJ3w+QF91hzlrzlsYRwMNaWx6yLReLipoWw
 BYWIp16HlWf4+LUgDRz4Zyzcr0+NTKAetZ4aECUxhvKcSr37DR9Fy6pCVpnpH2LqdWnC
 MNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770756890; x=1771361690;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kfTsDpxF/1pt/GYWHrHA8HMvDdV44JWrQ/sRs5nS5WI=;
 b=soEa77c8npe8iJSyGzHt8+Txea4HApsQgBIoJbq4YiftvURDcyAXgz0V/nthZU+6+j
 HEZcBnw4N6VNMrhIy3w5yp9JH3cYI4iFlMXRMmHaUW9sfGeKOOpkbMOsB6HWRt8wb6/f
 AISWDYadz12Kv1Ir5eTAr5H7Akl+xVkpXCe6e/KhajMnUfCKgwe7+eCJaNC1inhs4iWa
 DHURMFyfheGKRoQF3f2AbYgdtWrTvu2OLdeKJtQQrwho1gEYGlnUIWNfI9kcT3tMJ1fL
 P1YxWJgLaO70QAg6a8kt5ZzwWtJNegvyYoEGtncmS+jEvZbhxubCK9T+TifaubzQ8g/8
 XkMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSlH1RbvHX9QyCgTDvhJFrgZzwTZ0C0wI9x8Cv3/KkwpxDn89d8vY13oGWkrMcTJExK1U/VZbr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMc5DWFKGZTm2RBTnM/OgGvRUTkHbEhFGA2o1ZjlKWdG5dvtAX
 nIwFrjiryEBq4nj1J0nUEtOvZhH8uRmACXKmZISTpyffrnb/u2ZNCeYa
X-Gm-Gg: AZuq6aKy2D/2E3T2uGd6Pn+h+HWjemXkX0Rhpd7ME7l2+ZRSllFNnFydmCDbUKepAzO
 v7vouQ1TvoQ+/2KY1+TixdzRwanHE74B5eiIeHoy6cTSZ4qLt5pWfpOuyXTTEePtYzeJxORb90P
 nfbMLGIqBxBed1VhN6d9EQyKLQOynUKDq6oKCVp0wfiyqvOqTgeoc3oaRgqzu6ZQ+winCg/435n
 cGxRUWyw/w0LCVSYkS5G8fD6cut/xZAshrXwvXj5DJhh/6zFUVVI04cN7ovdAp/2KscIE0HZk+3
 qvPb0WEAoRJRhxCf97wtGw68iAckkX8DTY/81YkxQNneaVNdXc4KRoFslf2gAyHJILLSQTxr6XG
 7mORoxQu6WaNFhHupXWCKYnqDs7E/A70FxHp+hKSycJdRSc/ftUooVS5H1FPU4nP7RJq0RCPvT3
 gWMfNhOSPM3SBTpQZUosDtj1l7TgL21IqONhLRYcfNKaWJLGJt4yPxiu6EgoLzoSuLq/JNfsLay
 pUEWtw7wi5YXcIBGnVfkA==
X-Received: by 2002:a17:907:1c03:b0:b87:6c5c:d3d4 with SMTP id
 a640c23a62f3a-b8f549a17cbmr130270466b.2.1770756889693; 
 Tue, 10 Feb 2026 12:54:49 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8f6e71dce1sm93866b.0.2026.02.10.12.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:54:49 -0800 (PST)
Message-ID: <0627d5bfb4b58e7c767097fd8bf58345eb7196bd.camel@gmail.com>
Subject: Re: [PATCH v3 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com, 
 sunpeng.li@amd.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Date: Tue, 10 Feb 2026 21:54:46 +0100
In-Reply-To: <CADnq5_Nrni6_Y7BCn9GH-aF2A1iOjgbr4Ebouf76Qogtb_v3zQ@mail.gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-17-tomasz.pakula.oficjalny@gmail.com>
 <f19af3c6-f865-4758-8c50-aba40ec1cf68@amd.com>
 <79264ab170e48e1372b3b847d75f4635dcc57aa6.camel@gmail.com>
 <CADnq5_PhcNPU=4s1P30OqbWY7qPD3dHmjEtoz4_Md41u=xaxFw@mail.gmail.com>
 <1002281ca27d58a47a47fb655a88637e49776706.camel@gmail.com>
 <CADnq5_Nrni6_Y7BCn9GH-aF2A1iOjgbr4Ebouf76Qogtb_v3zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Feb 2026 08:09:45 +0000
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

On Tue, 2026-02-10 at 14:17 -0500, Alex Deucher wrote:
> On Tue, Feb 10, 2026 at 1:44=E2=80=AFPM Tomasz Paku=C5=82a
> <tomasz.pakula.oficjalny@gmail.com> wrote:
> >=20
> > On Fri, 2026-02-06 at 17:04 -0500, Alex Deucher wrote:
> > >=20
> > > Also, maybe a per connector kms property would be preferable.  Then
> > > you could change it per display.
> > >=20
> > > Alex
> >=20
> > I've dealt with all Harry's comments but wanted to make sure I
> > understand properly. Do you mean, that the two settings should be a
> > connector property like VRR_ENABLED? I understand the intent and I thin=
k
> > in some time, it would be best to have these exposed in compositor
> > settings but how would a user control this until then?
> >=20
> > Would it suffice to fire IOCTLs from a third-party tool like LACT where
> > support for this could be added in a short time?
> >=20
> > I made it a module property in the first place, because I thought such
> > settings are pretty set-and-forget and module properties are just easy
> > to set :)
> >=20
> > Still, I think the defaults are sane. If I have to spend some more time
> > to get the connector properties working, I could send the patches with
> > the module properties ripped out for now.
>=20
> My understanding is that these are something the compositor would like
> to manage.  I'd like to avoid adding module parameters if we can help
> it because they usually cause more trouble than they help due to
> unforeseen interactions with other features or "conventional wisdom"
> blindly followed which leads to a bad user experience.
>=20
> Alex

Sure!

I'll remove the parameters for now and send v4 to get some feedback on
the cleanups and then I'll figure out the KMS properties. You're right,
leaving that in would surely lead to issues and then people lamenting
their removals..

Thanks for all the comments and all your work!

Tomasz
