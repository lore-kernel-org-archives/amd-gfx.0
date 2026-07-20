Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E446C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 13:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B4A897FB;
	Mon, 20 Jul 2026 13:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mffbusBR";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FDB897FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 13:59:30 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso636359866b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784555969; x=1785160769; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/w4/3RiluFhCb8tUheKIGpgsGQ6fJL81TFLkp6APJdI=;
 b=mffbusBRUPk5koz9k4tgdO1gVvwcbdRYtUb2LVxy+XBW9ZUyKyjAKnvFTCcNlVLxK+
 DOvzvNo/zixDf6pkp5OdRztX97PuGBLFZ1JurKy5dDHYzPsClUlq2lNU+4YHq3v2aapB
 h83RNx8zgF9JvWG801WrZ0pfEgTWv4TR9C0snvTicbyYunU6MwGlPNBrBb/veW9G03al
 gpBdyc6wmV8z0P1oh4kHq1bOak4PixbIO1QxtGV98JcKCJ40xodShfn9YzAJP2PsT8Gd
 yc1q4MIy334knlCIb1BZGJC/DrLgSCMD84jmmJ2res7scQ6VJKoij9jtIEqoUuAxCbOp
 te8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555969; x=1785160769;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/w4/3RiluFhCb8tUheKIGpgsGQ6fJL81TFLkp6APJdI=;
 b=TkzITdIL8BvvZQCT/5GOsHr8fb1qd/wxKolo4KeXQoOmOP2/Jl9zLXA/6FNl49Tdz4
 YjAhOfVUyIumBfhdKDfJUb++r2hmpNc9/hWgAK6I4c8YxG5S27ixG0koe4EALaVJNEUM
 dz4fY26efbtRH5lwsYK+sT328cZqeayE+zrlDa/oYTDmn9blbu9QGLCPM8W9D31eM40e
 WI4cZ4fmwsprLB1qLy6K5Axcbg4Yij/WSiddOV+LR/Vi61mIPEbbc4hvke9j3h7vvEdE
 3FTpjjl6Wag8ns0YRCOJYTPENE2n4P1yKkHtYXCAx4/DlcjM6Nj7Nn6UrnNY99xylEHq
 Y5Eg==
X-Gm-Message-State: AOJu0YyxEz6b23W3C7/YfmVI8YozjcTfQEyKwDGPRSwZ1RVn9dlH030M
 EscQya2UexhHrzQDkPfrfLPDmKFk5nqG8SkIRJBdVGcP4+6FZaaAH8wg
X-Gm-Gg: AfdE7cmd0AH9lm2CGISRAP9m2TC7cqeb4vi01o94MQg168jaKAOFgXUVS0aJlhpbRDt
 0ky5FhklCHydZKcrYlXPcYTJcO1Qk2NPSyKMRvrfMP+Uh+EUKXEOxj8BYdgdPH5eCZJ8E9FyWxo
 DNtvXR9uLwdWbvTZ5utS6e1tkQtG3kSsg/8UTw96CH+ZF1XPSV/Leyq0xAtFZRsnedvdHBqditi
 blJUaEzWEahluP12N+F5MsJRFJsszIFCfPRF03sPTumX1tNW/jHq00NLqeOQ+VIm9o2gOWN+yP1
 InVdMXNmzdsTlRP3XhPMzt6P8bMYAgR4Sckh1tyD8Ofs6ukMyRtlVq47/Gw1l91iBZLnSLZD3kn
 A7Jd26sxATY7dpxssznqe+VHNezRmAZjzMQfiYLEjYNH9dlZIIb0D9FEwva78uaTfNT7iA2e9n2
 2vYrBYIKINI09OIz5YlTJ/2ht2gClcqQ3ZfGC9vEZ7uEZS9Pqb
X-Received: by 2002:a17:907:b04d:10b0:c19:6a94:5beb with SMTP id
 a640c23a62f3a-c196a945cd7mr158276066b.51.1784555968788; 
 Mon, 20 Jul 2026 06:59:28 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1740bf48d9sm464218966b.57.2026.07.20.06.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:59:27 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
Date: Mon, 20 Jul 2026 15:59:26 +0200
Message-ID: <XMA6udstQameeRGAv_w1iw@gmail.com>
In-Reply-To: <CADnq5_OTNp-+mJ=BLU6p4vF4B4xrim+8hOVb6fbkmXC01PxURg@mail.gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <afb43e28-45d2-4529-98af-6fc7ea071ec7@ursulin.net>
 <CADnq5_OTNp-+mJ=BLU6p4vF4B4xrim+8hOVb6fbkmXC01PxURg@mail.gmail.com>
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

On Thursday, July 16, 2026 4:00:50=E2=80=AFPM Central European Summer Time =
Alex=20
> >=20
> > Right, AFAIU assuming the CP hangs, instead of waiting for the TDR
> > timeout with this patch it will be instant via drm_sched_fault() called
> > from either irq handler. Or if CP does not hang but somehow ends up
> > going over it with corruption with this patch it will insta GPU hang.
> >=20
> > In any case I think it is needed to have a definitive answer whether the
> > interrupts were not enabled until now, and if so, also exercise the
> > until now unused code paths just to make sure it all works as expected.
> > Presumably there are test cases which trigger both conditions?
> >=20
> > Then I would suggest putting this info in the commit message. That is,
> > instead of saying "These were used without ever calling get()/put() on
> > them." expand with the full story so the whole situation is clear both
> > before and after the patch.
> >=20
> > Assuming interrupts were not enabled until now, that the unused irq
>=20
> > handlers work as expected, and with the improved commit message:
> The interrupts would not have been enabled if get() was never called.
> I think they were never enabled because radeon didn't implement
> support and this code was ported from radeon.
> >=20
> > Unless you don't have the hardware to test it and there are no existing
> > test cases to verify it?
>=20
> An example test would be attempting to access a privileged register
> from a user IB.

Unfortunately I don't have any test cases like that. We've had some plans f=
or=20
writing such test cases and integrating them in IGT but the person who was=
=20
going to write them left and since then I haven't managed to get around to =
it=20
yet. So I've mainly just used the hang test suite for testing that soft res=
et=20
works.

If you have doubts about these interrupts on GFX6 then I think we should ju=
st=20
drop this patch until we finish those test cases.

I still plan to write those test cases but it's really tedious and thankles=
s=20
work, so it hasn't been my priority thus far.

Best regards,
Timur



