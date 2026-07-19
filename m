Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07FBC4450A
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2026 18:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8E110E0A0;
	Sun, 19 Jul 2026 18:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="g2VdAKwl";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5B310E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 18:49:00 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-667ef69424bso7660206d50.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784486939; cv=none;
 d=google.com; s=arc-20260327;
 b=XrLlWKxIUE7hBwzqh46IDqHnOWZ1vU9LEEaMPLuf0HXAuBXWpQQXWRV7yWvTCm3y4x
 A1dGmk+iwuA0zcJagcn7ZTbUwAgvldAgxIN1zIORTggTMwKfxYSVcLOE4dmC2I88S8II
 TDS1bcWd23Brrg76oJnLG8QHRj+oSznr8MDhfO1Jm9PonSE1oIo9EUQZU/PXXI2dJa9w
 9wXxOZJrEkzxsVc9p9QvtXS8amHoLNZRnHISxkhzsg3M2N23SYGHCy2sW0i5QeNDmq1C
 QL3owNGGhZHbRDljLn3ZVAVTMRYA3dz6oF2xGQQBuxBNWuJ/fgIikB0xgaTgnuicSExG
 76FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 fh=RMIEXLYiUjUgayTRZ0I+ifpviJBdQ9ATiSLVcTKyS/k=;
 b=CDGPk2m8SrMfvKqQXgIZ28UzzaMQl2OsTixQWocvdhcZ7cKXKX9fW5JWea8i12TtCe
 RhBESxuNV1hxL2D4qqYQmUEpyUFD2+tBywXGWhqoxZQb3V/hQ3glb72xur+kWbgMd484
 uTiiis7fMt3S3V7J0k17VWNA3BTrhCwVd+9/kE5lWwrDfcbP1+IqN3quEzXxJ3u2xV9G
 YskBNMcI8INZj4lYCpSj/JBvLT8wrz+IHBYI/TiVC3dCsovunK/qVkn82aDk2cQ+cBwS
 UPV2piBeQWrfRYubbpyFRsfm/0kWS6JDORsFjl1JB6zBf3jY+Ia6nQr6YJfgt7NMDajt
 LZmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784486939; x=1785091739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 b=g2VdAKwl09FKahCNER56Gave2Dnz01KjJtryyMISbD53OOzRWoYd0JCDA74Llr9XiY
 w19XXz8q4Q3IJVWx6ljdwRJv4lhAFhTIlN0QXoqrTZOtyPVHFN8ykNvqqrjt5gd4iUAW
 Fh2U1fTxynnKLPv1tNfj/JOUwG75BZwAGMKX8d2Jc97LRR+x3pDzr2ZZdgkmv64QBAlR
 6uIJeZSxHvvV07J1sOGQ0WrXkXZzjwKn/rHDpkDP2A7sVVK3KMXBw3rS9F9dN6JWix9R
 0/fWvVCZ4MnittJZNVi6Jo8gGWuzm6UiKZ19RmUT7uVWquX19VIjDp5yOEx+BzSCVip9
 aYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784486939; x=1785091739;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRic/h6jvKg5PWOIQ/kn7VXz1vdGbrm1xHGrkWFRxoQ=;
 b=hhC43gIw3gjdYtbP5ua9nbF9xqO21gxjibn+XRqUlDVdQvEbdeg4nAT4ySrKgDTzgV
 RLbd2BW6vJHctERmrxEcHyO0NsVbtR/+sET5MM8sUHtvt8Yds3k0bytQ6AL+A6HeNo3K
 phcaIS9tGlz3yP2V5LcNN7xrmq9XUsCwNBsThOJ0rmTVOwyrne4WvyOZ+/LDVR1lfZwC
 OqbTw7p/+EBBhMH1hHBThlXNmzp+M5q3vz+Jy2HEyM8h1lH+zt/v62A8nhtC17HdTOf6
 Vsv41sb19oN7bT4kuY6RvE5LJLhq4dzMrweV2fTzPcEsLZXmyMYT+M0+UjxWJiCP+DW7
 nuGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogXhfSGkwrPaHCAWxLeci2EKZhFlBzufiS4QTvrB1yX9tap30TegJfGIAEBD0IUajOUOsLdrBi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxyr7a4g+DEARSqgloH/PfOLqYKdGXFgxojesA/F5EXrTLeyrFM
 UsLIIwZrXcwzoRDjHGZSZ5jHhEPR/YfmKWTyZh64mGeOGUyHQGuHZzHbt2CUYcYFAQTndFwapzv
 gXJCEu2uKeSjj9vn6ot9inB0Wy3MsWKq/w8RAG+AW2A==
X-Gm-Gg: AfdE7cmsnPTV/AfKvhDK0OJ1dChMQMjSPxZJ/5N7Oyk5KyhtIhUS4ZpVlSx5LnWNTNc
 ZPTz6gWmkivn3fUwmE0HoZd8b6cjFm2sBqF8fe79+RDQdhyn6paGp/GIhzS4T4enaNSVryX6mDB
 B0h6mbh94xl6mzogHNnCB2UsKz5+u/mgh/fKVD12dkDOOGolLmv/Ja0qqyuZDUMBzV0eWIiUsRf
 7TGr92pht7iFcorA1mlrKnzfBToXvOOCKgCoGUDiqbPoxtWfQ7Z2YvsvbjGQ+RnDl7OXUDPg7ds
 w1G51kRsMYO7udOEoNV7j6dhtsp1mwuSoLME2qLT9Lmw7HU=
X-Received: by 2002:a05:690e:1586:10b0:667:8b91:2421 with SMTP id
 956f58d0204a3-6683bdf0897mr2543977d50.104.1784486939236; Sun, 19 Jul 2026
 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
 <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
 <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
 <CAEev2e8e4Q2zgQxkodBzNpXCDCFhE4femijQ_K8yQrKe7bXn=Q@mail.gmail.com>
 <679e18a5-9402-41dc-bd7d-58bc7714ff62@amd.com>
In-Reply-To: <679e18a5-9402-41dc-bd7d-58bc7714ff62@amd.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:48:48 -0500
X-Gm-Features: AUfX_myTyI1c07sHOlj_UviaIekPWxJEsUXexFve-I2x4sfOS9IQksI4qi2DPZg
Message-ID: <CAEev2e8HfUEMCct6exgukAp+7eyj0E=J040UqmF8GsS7T4MBwg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Christian,

On Fri, Jul 17, 2026 at 2:37=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/16/26 16:31, Anirudh Srinivasan wrote:
> ...
> >>>>
> >>>> What could be possible is to add a special quirk for your platform t=
o not allocate the dummy page as DMA32 in the first place.
> >>>
> >>> So some kind of a whitelisted set of PCIE vendor/ID combos (with
> >>> working IOMMUS?) where we fallback to non DMA32 ranges?
> >>
> >> No, what you are testing here is basically that display is functional =
and not anything else.
> >
> > I think I understand this now. You're suggesting that we skip
> > allocating the dummy page in this specific case.
>
> Well that won't really work.
>
> We had some minimal fallback to enable only CRTCs in the radeon driver bu=
t that was more or less only used to print error messages and not let peopl=
e end up with a completely black desktop if HW initialization fails.
>
> As far as I can see you can't use the driver/HW combination on this platf=
orm when DMA32 isn't available.
>
> You could give efifb or vesafb a try, that is pretty much the same functi=
onality as radeon without acceleration.
>
> On the other hand what HW generation do you have? Maybe it's possible tha=
t this is something newer like SI or CIK? In that case you could try the mo=
re modern amdgpu driver, it should be able to better deal with the situatio=
n.

I haven't gotten the chance to test this yet. My chip is from SI, so
I'll try out amdgpu too.

>
> Regards,
> Christian.
>
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards
> >>> Anirudh Srinivasan
> >>
>
