Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902CBD6101B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 14:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CF510E30A;
	Thu, 29 Jan 2026 14:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YTIW8BS/";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A40A10E30A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 14:09:30 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124a946a340so64881c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 06:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769695769; cv=none;
 d=google.com; s=arc-20240605;
 b=YlalVHQXLpCLW8AYuFiiX0frT33tOcMeRXcMuMB/JS/SgA0Yzwhv4PTQjWRf8VcKAx
 TWwMoKRvpgy9ZFpTAPoeE+UeSpapqqc/QH7uFe7ZP3MolHXTUWRN5unw4dCUjl/YpYeF
 yGM2eCnXLhcmR/DEtzG0ZKFvZRZg6zjbG/IXPDloIhQPmoXlHDCXFP1U+ostsOVvmzLE
 HcijqI078gG5vfjisMnXG/NyuYRZDaruDAaaWufD5cSh6v1MFIN4Om7mAWaWcI+snqGL
 htFXxte845vWqTDwZgnjKP+8YakaZkmeYVgVo2XWHXYeWx8ZybUnuDS6POSN/XejTXAi
 mfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rptuOO/ce0DAKWW4N7EkthTC7Y1C9194sRWvfeCuCJA=;
 fh=TWw7CjKH/oUmBDR6co52ihjCaPrF1ed6XoUc5ohkm2I=;
 b=PsmiBcR4hSV+htwLpS2EWzxK8vWCvfOgw+SUYd9KiAiUN2qtWBLm1X60JpmyF6uXEu
 zeBYvDOEs9TWakV4hJYOxzr1Ao9KKoO+yB9LkzysNH/EoSw/JAtkGiMMu2MO5Av4nuhu
 liczttS/3eqaP6cjEyy67ByTS6jd1+x+xTecjgvL09iF5QzstndjV+EApsXNhyVcA8Ff
 Ah47RnjQyjwarA4ALFUnostLmbHIyFvZsttwTR+r3W6aRGeUICskISH5o5SzuWp8q3vS
 g5EcjMHIRXMPhCZIczTbZiHP1090GmtiEO9zOQGoL2TpcG9mOsBtnfoFdFEbgTkp1cza
 cUOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769695769; x=1770300569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rptuOO/ce0DAKWW4N7EkthTC7Y1C9194sRWvfeCuCJA=;
 b=YTIW8BS/6QEKIG4x20pHm27G2eGsQG2nXntVV1Y5Vgy11D+f6zxue5mgTCCtllrmRH
 Guv0daZfIw5oiENK4wfTiMgTauUYccZyuA9egL/CQWcaq6NhCe1HjKFzEPfEk7nPGLqC
 hrPGA8XiU0yK2LoNSKpcAxc9G4ryruzZzNQqJferyGyenyURCyw1sCu3S0T9S++lT/PO
 6SNfreH3NHG7roy5FQcAx28OdvcpXyyndxxjAE9+bkhqdeYBng6vt/2BjEqfczW7r9/e
 JSN8k4WkafdhJyeK0Xdf4ueUM4V2WIeJqGb8QM1esHFQ3TJWQevP0QO5ffSc12c47Fs8
 bsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769695769; x=1770300569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rptuOO/ce0DAKWW4N7EkthTC7Y1C9194sRWvfeCuCJA=;
 b=LYwEb1YVbFFSyoosQYskuqaSiJsI0viIadnNBEIWPQ9OY5Lhvkjot1DSAqIUrPyoDC
 UjLmSGzlT3+GUnmItGyRRYJanGNU3EnIMsxuSpYLMScpT2TJf5Mm+moxXgAenqpp0iNQ
 gdA2zqQ7cwISz/pvxL4Hb17q6DxcLZGK+VSvxTDgYgt9/MsxVUZ5snVzXTJhBA4r2gqG
 BEr24AzHRxCBMFOX6sgPoKPiXEaFZvH6U7gEqdXKwgWuegExU6r+i3fA4m+K42ldVjuC
 R6rPG+Qt8ZukAL5HvsMKYIMz8xOB30R6kQ0YYtK6fE81qlNkBfRDoq5SjnURWlWnygdW
 vyJg==
X-Gm-Message-State: AOJu0Yy7tL10lxHWEyGGQCw1ovkwVMhuhvPBHEThKE8TY62gLLQNqBzu
 IquSUsCBSFrfBaJGxKGxMURl/YguJfuzmFGEzovEAH5MU0pZjgQQvS6AfgWTpnAcz+PPUp6i5PS
 wuxf6Wnn7LNf7og3ludvG93ZH73XwEiI=
X-Gm-Gg: AZuq6aI8v70PVslLiOSqR2EfeEa8WeXyuzpMxTrsZ13NT7SnRi3qDzVwUjaGYvILH4z
 0O8zvHYYaYknU/pArquNaQGy+b6gYlws9D56PV4L3plqKfokaCoiDcknbMyvSwLiXXLGhpfFK1V
 oEvITC7XKe7DIrLf7CDEXyDEixk8baMZeJJaRW1VD8udHjYL4II5qTsPsr6zCpBWFyBlKFrXD54
 yiAVKlNONmLOC/s5Jlr9SmuGI/vCAFNQgxv+m6dlVIcg+2Zrrx3yszvMC1I3ApeCGX0+Ki1
X-Received: by 2002:a05:7300:e616:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2b7af7b668emr1028760eec.6.1769695769327; Thu, 29 Jan 2026
 06:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20260129043446.33377-1-alexander.deucher@amd.com>
 <3572729.LZWGnKmheA@timur-hyperion>
In-Reply-To: <3572729.LZWGnKmheA@timur-hyperion>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jan 2026 09:09:17 -0500
X-Gm-Features: AZwV_Qi5UuphhXZexvCHv-NUzTp6u6lXAl8E_Z52NStayIsUfbGhFus3Y6BmLnw
Message-ID: <CADnq5_NCo1Vr7WBhzzAutp36QA+OUOzNGMOtnkkbfqJbaY10mA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Jan 29, 2026 at 4:42=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Thursday, January 29, 2026 5:34:44=E2=80=AFAM Central European Standar=
d Time Alex
> Deucher wrote:
> > wptr is a 64 bit value and we need to update the
> > full value, not just 32 bits. Align with what we
> > already do for KCQs.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> for the series.
>
> I notice that the code base already does this for gfx9, but is rather
> inconsistent on gfx6-8. If you think that's useful, I could submit some
> patches to do the same on older GPUs. What do you think?

Thanks.  Pre-gfx9 only had a 32 bit wptr so they don't use the upper 32 bit=
s.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c index e9254ec3b6417..ef7d91a44=
37ec
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu=
_ring
> > *ring, bool reset) memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx],
> > sizeof(*mqd)); /* reset the ring */
> >               ring->wptr =3D 0;
> > -             *ring->wptr_cpu_addr =3D 0;
> > +             atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> >               amdgpu_ring_clear_ring(ring);
> >       }
>
>
>
>
