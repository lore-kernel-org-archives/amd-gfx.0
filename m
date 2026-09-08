Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3376FC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 08:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E9B10E25D;
	Tue,  8 Sep 2026 08:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="opf77sKz";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455CB10E25D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 08:14:20 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so40756465e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788855258; x=1789460058; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f24jn/NesUcrjh37BVFH2/U3ZUvd2+K3BGJ7AspAGEg=;
 b=opf77sKzvGyyQP09YRkdsDIGH4HHutiE9WiMNkNwQeSwzL0sRrLiW0lKByaYYi4lkZ
 6LmtmpRy460iNTx57Xn2SjBbw6/eBekYGYbI31WYm8s5lzePWvWMZUf0PLAUL+79kDS0
 nTooBvNVz46AgYira7IV5P/Mq3CbimXQk/CvnwBk1bma1Ize3KJS+a4HzAjWxAPi8wv3
 mQGgAitUHt1T7GGzNyNzOR3KSEH2g9k645DVpdAEP0okAQff9X5DRg2Ks4cA9VJYo9pg
 QMi/OrJ+gpjpSwWqccbKjVpONYlzo1svdO41ziqHVM+SZlHwcAXmSPaS0+jNnCijQ83i
 23aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788855258; x=1789460058;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f24jn/NesUcrjh37BVFH2/U3ZUvd2+K3BGJ7AspAGEg=;
 b=kKp8a+BryK6bE72Oysq62/Y7+H072JjanqaIHPUe7vJ7VvtMechm6PfscqHw4bkoCY
 E3dU+yCnrCp+Yj7XGfBaOYvfT9Mt55LFG8ojCqu4opvC6yIcW7w3WzC+dTcykU99wHUT
 SiC8IiuuVqypeIgccqjaAvXrzaqk0EpI8juFW427n4sf6O3x157iOA4IrRjeJGh+mMyI
 rWl7tnvPxHDAvIQEszDtBnd/P6EJOkt0Ay5Pvvjm76WaUb0vx7WXotpIU1RgKQ9OXAHH
 E6YF+adQ+cub+J08fnIp30cxCjDoF3g/36FRXtuDSELOhhuV/oMnXUbYdGjGOvDRr7Rt
 oUSQ==
X-Gm-Message-State: AFuF++nUa85i7jgyb9O6ECs79jpvAo0BrE7VGQ2tcGLwUJDFsXmpWa17
 BnTNUyH1tHVenSqfGtl2ZJBKweUBEfp5mN6mKc69LZ52G+MCAl+hYvqPuriF5wAl
X-Gm-Gg: AYBFou3hSkohulRaXHPZYRJ8mMY8i5KdCk66eYRFSk2mGpLO8ddqBp/JTKcnHiUcoD9
 1Izm7Pj7X8CGtUWY1+/CD+o2J0FmZBD1d1dPM+i39BW0HUqvfqZxhnJKm8Ldnzd7KF1Nn4iL0HN
 1FFEOSXpxHNpyuVfZwK72C7B+z1mKobhLgrgIVT/5n+Vr1Pq5bITV04tjkr00r1JTMeAPHAehS2
 uM6CVFcjPXUDU4luRUY780mP+DVRIIqeYVmZvuKIjVZWvHirLDoIu1vAbRp4bYSa+wY++KMQUZZ
 eIszS5DGweTkmYw7Oc3rkt7pBZZ07ZVyxoHtxtouP6UWi/E5L98rCOJXT39M33HAyPrSLQXaX+t
 LxehCU0tkEb/wH1Kc7Dz2KeXXPyMXMLneJ5T9DNJu42MjTQzzy4TmjiVj9owJ4e6hjXaJqNUS9A
 uVTttEE0NUndqkK0NVX39fVYRoC3x79eWiNPuQvk14hyx3/QQIaIJV2kJHt2KYJXK7SrSiXp5an
 ZH6+7GJyqC+fTRTuA0WZjWAdkjMBujE
X-Received: by 2002:a05:600c:8b05:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49cf82787camr277729605e9.15.1788855258185; 
 Tue, 08 Sep 2026 01:14:18 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm34485670f8f.1.2026.09.08.01.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:14:17 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <nat@pixelcluster.dev>,
 Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 10/12] drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be
 per instance
Date: Tue, 08 Sep 2026 10:14:16 +0200
Message-ID: <hzs0nGCHSt6jpoHrzEB04w@gmail.com>
In-Reply-To: <8c9a61ed-5c68-4391-8736-251ac9deef9b@ursulin.net>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <20260907203316.159103-11-timur.kristof@gmail.com>
 <8c9a61ed-5c68-4391-8736-251ac9deef9b@ursulin.net>
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

On 2026. szeptember 8., kedd 9:41:48 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=A1r=
i id=C5=91 Tvrtko Ursulin=20
wrote:
> On 07/09/2026 21:33, Timur Krist=C3=B3f wrote:
> > This prepares the code for implementing recovery for SDMA 4.0.
> >=20
> > Reorganize the SDMA 4.0 code so that the functions that are
> > responsible for managing the SDMA engines take an instance ID
> > as an argument.
> >=20
> > This makes it possible to manage the SDMA instances
> > independently of each other, which will enable us to
> > also use these functions to implement resetting and
> > recovering them independently.
>=20
> Radom patch to drop a comment on the whole series. It looks clean and
> reasonable to me. Once the pre-requisite series is reviewed I can do a
> more detail pass and slap an r-b to it.

Thanks! If we agree this is the right approach, I would like to do the same=
=20
refactor for all the newer SDMA blocks as well for the sake of consistency.

This refactor is necessary because I want to reuse the same functions for=20
implementing per-instance SDMA soft reset (as opposed to duplicating a lot =
of=20
code which seems to me to be more error-prone).

> One discussion point could be is do we maybe want the prototype for all
> to be "struct amdgpu_sdma_instance *" instead of "struct amdgpu_device,
> const u32 instance_id"?

I don't want to complicate this with the amdgpu_sdma_instance struct, becau=
se=20
these functions only need the instance ID, and only for the purpose of know=
ing=20
the register offset.

> Could I also interest you in a related cleanup:
>=20
> https://lore.kernel.org/amd-gfx/20260622143649.54632-1-tvrtko.ursulin@iga=
lia
> .com/#t
>=20
> ?

I've taken a quick look, I'd suggest a different approach to it.
I will reply on your commits.

Thanks & best regards,
Timur


