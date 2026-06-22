Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60FACD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 11:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A0B10E658;
	Mon, 22 Jun 2026 11:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rrwM5iLG";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3304D10E658
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 11:53:36 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4923139e940so24974425e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782129214; x=1782734014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lg4TfjbDIzotwfM2Q3aPAVSvn0sGgO2kKwJWPzAol4=;
 b=rrwM5iLGKXe6kZe0NLwWkVmF9n5O5fSCymA4/QOHO+FsW8BPHngzPY0UUbNbVHK+Vn
 p3/Vrrulu2hZowvCp5NGff3RUm9F9gef2vbM5x3aU4n/4w9SnYLklu5s4/8B/6kA9Tm6
 haEKanP7KzluUDV812QJHhf7hafn0/RrfMwsvkevzpqAafvWR9+dTYrx1FL4eSSR3ItQ
 Ddy2WgucYC9orCZoJb1yKoHCDczgcKIX9jzFSZ05vZSZ/zYuaxV14tcwrjjt4qqD1nWr
 SM/NPwUqAESBnnZzeMl3J3n9A9tMtaM+gItJVT4VW8eIj/qclADhAQYmS2+HFqXbC6n1
 lgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782129214; x=1782734014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/lg4TfjbDIzotwfM2Q3aPAVSvn0sGgO2kKwJWPzAol4=;
 b=OMj8Keo+vUD7aqCr8mWeQ7ziVEmG3Ybof5efPVffkoE73yDO/soJcFmW8dPmmQ/I9D
 o0iYb0zKC076Acac67wkupuWXPqvCrQKD5qB+FVfwCpcr2vIjY/i7dYoB+kvrB9DRIbG
 JrKtq8I13C4QsXlOM/5CFSEedm7NCjeTyMSR0rVgcxh6uzPLo1YpOcL/F5dCJZOjgFee
 6zwPjEcNwg1g4cD65uO+ou3EaDMRQi0EmnX3TlUW67ZWyeDqIQmXFGg/5xYFThHD6Qv9
 RQ/m3j8z+SNE/8FODARPEpsLM4NxbYs0Ioao/I3EsinuaPItT/Dhe73svCHde06w4jwr
 e01A==
X-Gm-Message-State: AOJu0YxFrdfemYMAqzZWXh4CO8qoYCvqCvghJS+oOnPKEBQRsKsMY1kw
 PrepBaiuPiK/FUD9mPPngB1ldtn48T9xKoTlr0gRdGxFLz9l6XILn/J3
X-Gm-Gg: AfdE7cn3lfm91L2MLkCOlTtkKdYfupFikllBQpJy4JCNoUz2Sh64t6sfbN6e+AYFQUn
 hghS8rcV8w4Eh4eDpViZdbGMeL4+bv+D77euZg97GBacuKUouVMx3MjDEMilPeBPBnFT5HzukyN
 BqQf7Wn84Mc3aE6Sb110XVs5YiKuH0afKafXND9I35sfYQmlJmsuMF2WcUenKZ/2jeWAFx9AiyK
 Df6vdSEwnxlyEWQ+603pOihnwtnq20fYf7vXuand+Opx99GEkArCsl+ImKgc/KSTL3Wu5shbEF3
 tnU13cgJSIlZz1CRCu1B/GFMdydiWBiPKAZ+s1NlBiKj0OuXBcWCtvxgFCk/AEtqyoatO1+kVxK
 jYPSs7YzA2ugdazdPl3M32gp0pfB2feenxF5f9mepeZ0NL5bD5x8IwZ31fpn6tAAe3N9QevCI/p
 U1CWoRIXcUSZ88aDorqFUytfdEn9AIir8RA8HFEn2M+cuK5FVMFY2a9d3s9obsZfIzYnLh9UtTK
 5yK3IrGyEvIv5ccvLREZrMstTlszA==
X-Received: by 2002:a05:600c:3516:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-4924258fbbdmr213502365e9.34.1782129214194; 
 Mon, 22 Jun 2026 04:53:34 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24F13B00B65759E31FE89790.dsl.pool.telekom.hu.
 [2001:4c4e:24f1:3b00:b657:59e3:1fe8:9790])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881b4sm23820213f8f.24.2026.06.22.04.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:53:33 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Date: Mon, 22 Jun 2026 13:53:32 +0200
Message-ID: <2217972.9o76ZdvQCi@timur-max>
In-Reply-To: <IA0PR12MB82084FFD926ED6F878B843AD90EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
 <27422769.1r3eYUQgxm@timur-max>
 <IA0PR12MB82084FFD926ED6F878B843AD90EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
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

On 2026. j=C3=BAnius 22., h=C3=A9tf=C5=91 13:18:55 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 SHANMUGAM,=20
SRINIVASAN wrote:
>=20
> Hi Srini,
>=20
> I'm sorry for the trouble, I haven't seen this warning.
> Please give me a moment, I can send a fix later today.
>=20
> Thanks & best regards,
>=20
>=20
>=20
> Thanks Timur.
> Sounds good.
> While looking into the issue, I noticed that the temporary array is only
> used to collect the affected rings before passing them to the multi-ring
> reset helpers. It looks like the intermediate array may be avoidable by
> having the helpers iterate directly over adev->rings[] while applying the
> same ring_type_mask filter.

Thank you Srini. I agree, I had the same idea in mind.

I'll write a patch this afternoon and give it some testing to make sure I=20
don't accidentally regress the functionality, then I can send it to ML=20
tomorrow at the latest.

Best regards,
Timur



