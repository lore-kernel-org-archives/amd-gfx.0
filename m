Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA63F54AB0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D50C10E6CA;
	Tue, 24 Mar 2026 13:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLpbIGiR";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181DA10E6C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:22:24 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1273c690e5bso500749c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358543; cv=none;
 d=google.com; s=arc-20240605;
 b=Gt0OLA3C60K3FN3KDHvAyomyS/P7ox2FZTY7YXsp5AiKVOziceMfLFNr64fWWodHOr
 Z84IoW6ND01IKv+v/pqi0RpynKgLWsZ04iAyj9sTQHKh5nKOVFIHFCynkgbpdNkqjJDl
 BduTu3KlwbYXzryELzitA5BQUK5Se+FZigggHdYNByb0YGSlO45TNyrpEYZXGcYLqOSu
 QajCAqSUATmzEOQ8yIFk3K7r+cVpmLll78J3xgw4EcJ5EETblaPsFKP9/nGOwn8rNjjF
 8K1JXl4s7DYTdYcHasOMx2774T7L7J4r/4R8MIYwpCEsVAJ4NUPoEj/O4A4MmVNoTuKB
 bkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 fh=WO8wYbuP7fVnYwVoKUe57FqCNRHmei5UiKYHDcBSSlI=;
 b=CkGNSpkpJVWts/be6U4IHyNN9MqdylFNQ8U8uUQM7bGLh6s1vhLqyeA+XIFZfTn0KT
 HdL0JtPWUoBT53XdRciJkV5aubWd0ffcB/orjpAREcGPfY2RMBA4uYAXLSaulkYrfEbq
 Rou6ZC5E+oNjanBWOiroQp+w6XNTDdM+GiKHh+UF8NWTrkuDhcUeT4EmVYDdiQZpHyvJ
 CcLX9kZP/9iy34E8W/SvXaAlAKd/SHxxFiakSN0FhZF02VvKa3MYEwOVPaZ/Tu1T4tK4
 9w8I4wciq75tPjIKydJk3cc04raQv6Spm/dOQXqJYn/GiqbE5aiKsSoSs7MuACBzOU6k
 h2Tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358543; x=1774963343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 b=HLpbIGiRKqvFhhE0q2Zg4ZYS8I+L15QbfkvtnbtyHlZdFZqKji8vpt+TD9DkKyX7J3
 FI3YRZ9hztugm2Fxe1+zm5gNs4PhY1OWVJzzjMZrCLSE9NMRn5FKWj7Mn3EY4/9d4K42
 JcWSjQgpuZ6NYscSeaVA5D3O2mqotqHnkd+PCP7Vt/b++0DZXYMHgvSq1I4ZCz+Y6xD0
 2ZL7wJT7tBgJ8cfbDMJYq6OI8bgCcC7dryImzieuHi7Blv13vBHjSP4Up8pu2PdE0sK7
 W7nxO3MbJMDJEGmHBBzYSb8d/euAch2LhpSURXjNLM1AbE20UVSZabye0JYoAIEPpLv9
 Qfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358543; x=1774963343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpafDwQpmjLC+aw1RTAqKBuFIpkEFXad75Wwh/OZldU=;
 b=AQIJrDMb3Iqeut94sQaY3o6QTzwrLnbJ85PMlvDQDhvvGay5pyV7flDAkSMjcsxjkF
 6vuTTyRfpdjBBlUbCco2ej5i/Fli8OWs5a8JhF1TCRcT1Ed3yu5CXK5cHXrreOAm/WLe
 5I38fKHcfzP0v75mQgtBx3q2ds68BKYVe8eApkUOPtxM3w16j5gwSqLrpPp72o1bv2M+
 BBvENY9XJY0I9owYcwjdoyypKUu42swmDzEk5GnbjECHlQAUo+ZdrHAcUywyu53ZqGvK
 kSpnZ6ICrZGZRSWy2IcDGuVPR2LTZJUH7HiAFa4/X7fXKux7mHaD7ymsnzhvhdEDZs/T
 wGPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjUnAdsmm47b/i6Qz+wtF748tDJNXksehaGIjyULFPQtjDIMNXsd5Vwf/zURGdr6Mx/eHZVIJt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdHzudYNlQWGsOs80ZSF0h0P/XVP/iQujz1KHzlhavMOa5+KUF
 D9WfsByC89P68Xpp5kNDgXxOkOvygBbL0s+Yq+7HyCmt1pvjFAZeUGlGmCINYOXAEN+1Agv/7MT
 WnIJOAOpB1YbbToMVzWZoOsLgkpRjT7Y=
X-Gm-Gg: ATEYQzzSJA4zH3frpg/N/qMt/8NmTY1175SPd/+prvMwRAZ72cacR7eSqjpQdqWI1Wf
 yOQLkmd80aqvvI0gGLCBxHGDVBh/KW81Gqu3OyeXtZKDZjD+FqodBe0JuaSvNtmQOJaxtX4Nj7D
 GSt1TpT0FyikOosXNSPw+dhvrIsYOMwi6UbWLG//Gt6XgmrZusZ30aKi8LyiTrYDMS0+GI5xXTQ
 dekgpEGqM9Ph6FaSILpyxvACQ6d65Evq3ACn9M1hy3V1dvokVyTWjf1AAwHNVr2K2WO3O+xeyhw
 IbdYtRqSFImMsAyELzWSW8SvmlzM6Rq17Ohc2RzShdQ5HQthbqvztrZFcorNlGriI2g4Yw==
X-Received: by 2002:a05:7022:2224:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a726c143dmr3378135c88.4.1774358543184; Tue, 24 Mar 2026
 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260323224348.343495-1-colin.i.king@gmail.com>
 <1060acb4-1a8c-4e52-add2-fbda4f2efb7d@amd.com>
In-Reply-To: <1060acb4-1a8c-4e52-add2-fbda4f2efb7d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:22:10 -0400
X-Gm-Features: AaiRm5365YdEJSMouctlHAFL3xVlmZM5_M9mMvfLm75WvY684wOEa50LTTLTuN0
Message-ID: <CADnq5_MBNLH6ArJT5J87xcqvPo4y4N15EKO-oJPa3MAqEnr2_g@mail.gmail.com>
Subject: Re: [PATCH][nexr] drm/amdgpu/mes12_1: emove extra ;
 from declaration statement
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Mar 24, 2026 at 5:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/23/26 23:43, Colin Ian King wrote:
> > There is a declaration statement that has a ;; at the end, remove the
> > extraneous ;
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v12_1.c
> > index 5dcc2c32644a..0e9089544769 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> > @@ -2227,7 +2227,7 @@ static int mes_v12_1_self_test(struct amdgpu_devi=
ce *adev, int xcc_id)
> >       struct amdgpu_bo *meta_bo =3D NULL, *ctx_bo =3D NULL;
> >       void *meta_ptr =3D NULL, *ctx_ptr =3D NULL;
> >       u64 meta_gpu_addr, ctx_gpu_addr;
> > -     int size, i, r, pasid;;
> > +     int size, i, r, pasid;
> >
> >       pasid =3D amdgpu_pasid_alloc(16);
> >       if (pasid < 0)
>
