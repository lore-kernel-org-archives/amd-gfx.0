Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C85C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 22:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE72D10E24B;
	Wed, 15 Jul 2026 22:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cBdcrhAW";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE3A10E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 22:55:38 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47db714766aso1869f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784156137; x=1784760937; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jsLgkDHCq8u4EU+MVVZBIsI4ojJiSQfUWOkOQyZ2UmQ=;
 b=cBdcrhAWOS2QpoQImoS6ZenzPQzeMLoBeaoFaX8MUkDvQrbgwhOi6Lye4guBBXSnWl
 U8CabPrkSvw/ZgPMHi0cW/ZV0pgi13/uI0aCYqlFnGJQpWErPyrMhgpQTFkG+wFX12L6
 hXzRCkJelU0/4oxLZBZvIf487V0MriLeH7FGxAg2geo1hpxPUKfIhXCuVA7YENQYPIdM
 JK7GN+YoAsKuLugeHKBKo0s4I7UhDV3UeYEE4Ik9K9X7L3Z2KlmMmSlnawLeHv4zKvom
 NwYc0SPSlvKDq37MpP5byJx+h76IR04I2NwsTO2UtqrgPNt+xzV5kvhoyS03FfBpklzK
 UCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784156137; x=1784760937;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jsLgkDHCq8u4EU+MVVZBIsI4ojJiSQfUWOkOQyZ2UmQ=;
 b=YNJ5G5xTuUsmmy3GfdDonViUeOXimFKMbSLA20MQAJEhYVLhOA0BJ9oo+tQITQR+QG
 x1x0F0g4aFBnFFmgPWv5q0xmlbzheeQiEG3Sjck2YKTxW+z9oca89Kk24jhOnWC+fuWg
 z2bFVWp5LrGuqTU1rCDOm0R55us9D2Vjw57nuf25cg3WtGvNqraWA8zz39Y2ThDhNjKu
 oBOF11FDoHVP4zxhQhsCE2Rlq27ug5NcuUTUfCoBS40P343YGN0F7sw8SQG7Xpdb/qd8
 kzXITaimXTdazCvWpI+eBoboDxhEPv1G6AJbBxl33wRZj53XGrf71fCvBUWDCV/tfksw
 SOew==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN1ti6uMKFlAq+5HBUOs9xbQDPFBmrxNId8Oy+jhFsJ+3MZ9/odLPNPcNB0DVrOFekLRvxYS9i@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHz9kYjWxdgooXEy8SlXq+tu1XFDHwEtRCoK6ZaOsdSMH1hsCU
 T8CWaTUVvKzUK6d2JkBKpa6Q8H9SvJDfSWOuofhbzZYHrMU1bqE5I4cE
X-Gm-Gg: AfdE7ckZnd4/+kvy24jW2SM0Z2vTuZ93rayPK7Lx8Fx+RzF2WX1PZnTFSlgUsWybR5c
 q1Z8WGpLOWU9hs6zjOOsMeczzjVg7jVUhrlEcQl4lIJakZb8X67vLYqecGT58xKhy1pV3Pd6plC
 jf0uY4Ki0YooQheq8aryVSM3e0LpXmydBe0jXG+Bbu5C7995s2js+gD4DgbbkpoxQxG3NYdTNS+
 YsCuwOJp55isV7B8rIuOTQTwuLOuFM7vVc9URGqXMMpI9d9+RzuLBPJ/jl9x00DMxrJcn6ayx3H
 J++W5bcnJs/kz2IsIivs7LL/qa6TwR6Ai6zc2QhI5t7iuEtMnhyXunAYoLdxHnJM6hrGcJ70GIP
 QJ9IdCQ7ob2SMCTwgPgfHMOJlQQtBO0/c7XL+YEEmByRNXine9bVc2mbtPyI+3cAHrC38YNmF3W
 mJ9kYdMGnBX0LkSr8iBYDkqVyqxQz+d+eTeM/vE1Zi4eSMTXx2
X-Received: by 2002:a5d:5f47:0:b0:474:da39:e5b3 with SMTP id
 ffacd0b85a97d-47f5a41b60dmr95673f8f.2.1784156136900; 
 Wed, 15 Jul 2026 15:55:36 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635aa34sm18097627f8f.15.2026.07.15.15.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:55:36 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Date: Thu, 16 Jul 2026 00:55:35 +0200
Message-ID: <H4udL4GlQcaqUkZjX19xCw@gmail.com>
In-Reply-To: <e934a6fc-473f-4a98-92c0-5cefdfc7e202@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <3014087.Ex9A2HvPv6@timur-max> <e934a6fc-473f-4a98-92c0-5cefdfc7e202@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, July 7, 2026 10:25:09=E2=80=AFAM Central European Summer Time L=
azar, Lijo=20
wrote:
> On 04-Jul-26 12:20 AM, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 3., p=C3=A9ntek 20:11:59 k=C3=B6z=C3=A9p-eur=C3=B3=
pai ny=C3=A1ri id=C5=91 Joshi, Mukul
> >=20
> > wrote:
> >>> I still haven't found any explanation why we use a doorbell for the C=
AM
> >>> in
> >>> the first
> >>=20
> >> place? Lijo, Alex, Felix does anybody know that?
> >>=20
> >>=20
> >> If I remember correctly, we weren't sure if the IH_RETRY_CAM_ACK regis=
ter
> >> would be available under
> >> virtualization. And we were sure doorbells would
> >> work for both bare-metal and virtualization.
> >=20
> > Hi Mukul,
> >=20
> > Can you clarify that please?
> >=20
> > How are retry faults supposed to work under virtualization? Is the
> > interrupt processed by the guest or the host? Why is the IH_RETRY_CAM_A=
CK
> > register not available under virtualization?
>=20
> For clarification - CAM entries are separate for PF/VF. ACK register
> also has PF/VF copies. However, in general host driver imposes MMIO
> register access restrictions to VF, possibly that's the reason.
>=20
> Please note that IH_RETRY_INT_CAM_CNTL is PF only. With new versions,
> please make sure to add a VF check for programming.

Hi Lijo,

Can you please clarify what PF and VF means here?
I'm not familiar with those abbreviations.

Thanks,
Timur


