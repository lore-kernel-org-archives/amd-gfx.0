Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE6AC56204
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 14:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F6110EA7F;
	Tue,  4 Aug 2026 14:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rJqAkFyO";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D48E10EA7F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 14:11:56 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so528616a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 07:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852716; cv=none;
 d=google.com; s=arc-20260327;
 b=N+h2tdaXU3E8d5N1j2WpdXGdQ/HfIPI0tJ0NLoswkfHmlJfZHEzk9CBpuS/OfvC5ou
 eAlLJFGkBvwqCgTcjtB/qa0HxS4PRqp1KniEtdJ4rp8vOScFU/9EV7UgvH2RXWxRA2V1
 /Zl+Sf9yre5YwSUEaSY11ToMC8qNVQGUKgcQBdq8ICLc4QuzXmzF+bGfxcywbcR7ZlIK
 fL4DVdaV1ylKrtpOceLJ0mmFVUgN5SiMGuZyCVC5UMH+5z29p3+1z19XsoXW5njMxtVU
 e9qYO7NYbFe2T3eK/Dj7w8aCL7sIzbj4y7NMbSh2zCf579LS5WzGAfT3o6G6jJYX/BrI
 ytew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4RCB93s6LiU/6Wv8nb5uglDKWGJ/ikQBkn85jrwSfis=;
 fh=/tu72ylnJ0kCzCU6hvKKHktTogYml1it2vtbmy8I+WM=;
 b=sLncdjwqGdeuWhguWKVJVad7RIMWVEyU0flTSW0o7mJaHpkWfSjMb0S2veXzkJ9Bav
 XZ64Rt/IpM/bmNsUZBdCXtkFE+yqa888zGzkW0f1S0vFjjeXWmY2sk8ALLEgnBfDkyZW
 U2mvBU25mBeRXbawpixxCUUXDZbH+nEsLPzNqAMFFdmPnsAXNabQ7HQT8cEbtVHtx2U3
 jQ7ihfggrG6+R2sUx07rxHhsKa+RdvySo84gOa2yfl6H/zB4815rgWYEruj+hgCRDRQe
 ODBz0CojLCRbsgtX1jVXCQuipMY9u2+Np1soEwIn0NsyatK4FA1/8vRhP8kBEJHrrX5e
 FqIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785852716; x=1786457516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4RCB93s6LiU/6Wv8nb5uglDKWGJ/ikQBkn85jrwSfis=;
 b=rJqAkFyOZFNgPJcSJ1xdgIqG2wUw+0ks1m+mfmNU/SKVQYXjJYVb6dO02tqEYuOSm4
 GugwZbQos614fVxpR8iYwwDujWWSgw449WJkCEum2hTJcq1uHGhVxZT8by2OBEJs6N7Y
 Dj57hhIHaVskUJ3T3xu8bYtx9W0Q0gt0ToYwgEVMUXWg1qNowkabAYxB7sErT4hyGvOs
 EVX22Wzk6VXcWTNpyd3NXivUpm18PczAenAf5Jz/OWjMXgFDYK4RY5oSnGs/ro5Yo8bF
 932emTxLYGVgVXJRVwoLsmHZ14SztsYDibmasFfG86SdReLlTYbdQUUMq2gSTk4mdeEM
 4BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852716; x=1786457516;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4RCB93s6LiU/6Wv8nb5uglDKWGJ/ikQBkn85jrwSfis=;
 b=MRFCgO0/LrlIpibQgAnCW5NPxi/jvTWla5sRQ6qRc7n/gKcTy7bS9oy648SGRffyzj
 skdbCGvpbrphHMP3EBgN1DOPrjLSqpLa0ygocFdZcdaYWCEZm2lCUrXv1O2aDOgtjte1
 NnlIDwCxkkSMT5jsRsLVDs8GtMojLyDkutCYUp7rKhDNpbRQ396Mlq+Vb+5GxjRe8/cV
 oshyI7FFT0s/FCbe0IJ6W4ZCv/tMC1r+RnwGqQZf0iiI73uQ0OyGCTANwgtIfOSpf0Nw
 9PrWfZz4suAl0GEZoMWwDt/OJ0eHWDdeT2Lo0w3Xuq7556yrSmX+QnglQqh1/SEV4NA2
 c6pg==
X-Gm-Message-State: AOJu0YwvUh0N7J0tEX4qgex1YRAqr+Pg6Ra/w3ZaW10xM2170dbaE/Ee
 2/AvuaSHP1lnWTvry1yi6XzZDh/hDKNU78GdqGU8xmHnXU7qXaVLoBxogv8zCxi5Qw7nMan/MT7
 DNQPtE2bHNl9sZc4Wv0Jc+zcgGdXT5quqBA==
X-Gm-Gg: AR+sD11htRD2POlyUHmme5/owf9IsA8qTsx72RswS+S5qvzRXxntYFBbg3QstgtList
 CI4IvU9I3hv873LL0LMOp4CE60gUckMYD8KXT7A3Zs+mi/tAG2Pd9pbewLA9WmYMQ2lW6PvA0ZW
 vBIH+0ErQ5hr/KJSHQNSIoR3PPT6tb/7URDgho33TADh37t81U0saCUsngBiGQEwCAMSyMPFV3m
 IBT7s9M9eizcwm3naZ4FzXgXkqo32vg7pvi5fj6SFJqoRlXga8wMQfYLD50lfMdsZNMgfrkmDve
 94/ebcYemZmJThrNEgBaYy0moawg2L1s5FrLF/oi6TJmU/nDk/cZJkGf6d5FCvMtQokhkJxJU2g
 KExNAP2DZiXg5Kk81OBJvEzHZKjrQ7dM=
X-Received: by 2002:a17:90a:e7cf:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38fbc0c3541mr17099853a91.0.1785852715778; Tue, 04 Aug 2026
 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260728153930.1531949-1-alexander.deucher@amd.com>
 <CADnq5_N3oqFeYwaV6nO_wxU+7K=4ymM=yLHZCy1e03FxMQy2Jw@mail.gmail.com>
In-Reply-To: <CADnq5_N3oqFeYwaV6nO_wxU+7K=4ymM=yLHZCy1e03FxMQy2Jw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 10:11:43 -0400
X-Gm-Features: AUfX_mzRSy4VKZzPtxr9mwwi77HMFj1DEtcgVHaz4o9nep81RCKYPKcScpG3LEg
Message-ID: <CADnq5_M3YV1OhEtYUY9Ym5w7FqnVYvsV1WAFBNVSJgC3gwmgxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun Liu <shaoyun.liu@amd.com>
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

Gentle ping?

On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Ping?
>
> On Tue, Jul 28, 2026 at 11:48=E2=80=AFAM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > Check for mmhub0 rather than mmhub1.  Looks like a copy
> > paste typo.
> >
> > Fixes: d0c989a0aad3 ("drm/amd/amdgpu : Use the MES INV_TLBS API for tlb=
 invalidation on gfx12_1")
> > Cc: Shaoyun Liu <shaoyun.liu@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_1.c
> > index 855cd29cbffaa..54a5e64f53b3b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> > @@ -396,7 +396,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,
> >
> >                 if (all_hub) {
> >                         /* invalidate mm_hub */
> > -                       if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mas=
k)) {
> > +                       if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mas=
k)) {
> >                                 input.hub_id =3D AMDGPU_MMHUB0(0);
> >                                 adev->mes.funcs->invalidate_tlbs_pasid(=
&adev->mes, &input);
> >                         }
> > --
> > 2.55.0
> >
