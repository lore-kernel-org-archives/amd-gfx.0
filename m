Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D9CC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219D210ED4B;
	Tue, 14 Jul 2026 13:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BzXdXE8d";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0544810ED4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:36:52 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso11932395ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036211; cv=none;
 d=google.com; s=arc-20260327;
 b=NCi80mltTBM9yybvP/YTm7U9AOmqMEWhl3ZcbO2c2O52FhR5qj50FnH95uKzOTJS1D
 ulI2i/ZKnERuJ5EQxI/MzZzueTikD80PGpRVFrZmJnQKpiwrIx69DGX2cf+4Iarb8B6H
 jpTOpbF4Amm0sivBwHF+oV1SpVY3re2uEJSzVS/sMHFJyGqdWjZmqi9P8/7ypsUem6v3
 uchxXutYlwa/Ndvs/cngdhIcJ+yAu6XwY3tjbPG6va5vY6g/jiKupSr1IkXbMetb4c22
 +5XI2Kvnu0UTZWaO78akdgiazob5t273uj68Mj2wW9lqNxEXt1QyVqCeYTmTANyI4rtu
 4LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e0uR5TsnldD22UbNVtH3933qHDGf95MOXOJB5FzcY70=;
 fh=um3rK6dJDxiIl42w9K2UJdByoFe+bs3ULDbFVzpDJAc=;
 b=M+SvNY2HHVvy5+coxh4BrlLMLKRhqq0204lb1/UpvA/rQwOWI2xaEYPNmiYSPrJC/A
 k60mCD1Bidl65z3OMu1ymKHwjPaGM8+AQ+g39YN0dS0wNsNqaQrD9SURZ96vSbS8tVLR
 7gSDBUU5XV3lTbmTbLjD+qen6nRQyFNkqAudhKB2xHoKIs8Yzs7nbrvv+kXgDnGEDb2f
 FvAN2FRxkHBrv9MpMcP3YpMz7I66It8qDnt3493p0Yp0mgI/n8hdAdWqXem09zjH9KxI
 X/eVXhkaN5lr7gJNpInOgQmOcE08wpmSG73fWEYPS6EvTXt/kGjv8+NzMfka6vLhjdCs
 B9Pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784036211; x=1784641011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0uR5TsnldD22UbNVtH3933qHDGf95MOXOJB5FzcY70=;
 b=BzXdXE8dSPf7Y/zt3DV3oN0T7QQRkSXebfZIEBmO0sElPvp84gXGpvdMjiSy4iksNz
 ScR9EDXZ8CiU0oV4I/wY9AsRSDPAqcZv6sKv7pnOEZaE7rtp8ki/4KctwfphyZjyU8q2
 YJxitbT1IqHGQy/A3P+sI3NJIKQdgKlbYF+dTZ0kLl9rQsTKiMmuPBlRdAuprnNgcrhg
 JQzIuOs5RUFkV+1pGaP0lRzTSt1AaTPrC54q7KxuF3aw1J7iF5bgLNpKotfJa/CbcE1S
 LSmKzR2Q6W46LcP1g5dw+BL7Qwi8YK98lVsyJ9YnYw6hlJrPIUyzGNiuq6dTpkPBnnAb
 dyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784036211; x=1784641011;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0uR5TsnldD22UbNVtH3933qHDGf95MOXOJB5FzcY70=;
 b=ACWZpe6zd0gXL8MgFDST72GaGljk5YA6rtWfS/PNwe6JBGsZo35LvYbAKUuV4A3086
 xy7PgAYd8ysAM7Z6YbuFYDpJ3zj8Y0U2CtK+u1XcMqzB0/kLH/p+9MHtUf2FuHS7ImPL
 CgSySyUQXjXkXS5RoZVzm5JEav3OiJPxE7ae/UZBdp3sWGmc3uxsMYY6DPjU1V2Wn/x+
 pSapOliH3q1B2bmX2g1iCWIz5ykmUfAmudq+AVfeyYcZ4GycL91FnP/k+Uu7FaXNuo6/
 nrJdrO/T1J+7blHxITbaZ8e8HtjgeZPD46gPsxVWnmsBaQ8T2HfDvQUdVVIHYk60aH69
 qchA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTEoG2VV8QeHPIWEc4PS90BolgyNbFK2x/OxPuAss32qxk/JtXTaR5+m3nZgpubL+wj5gojFYd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWZm9IYcmAmnESTxoVEstGgKprV20cYr9QB2bAKyYUr59jmo9Y
 aaKjQlvqV7x+1Qy5RanTWKZFFDS193YjoBOzhUrXCGMTB5AXev2q7VfZzGQJLI4ldD0lCpQq3nu
 U5NYjB+kzFpIftnMn0ZzX9F0DBNR8amY=
X-Gm-Gg: AfdE7ckSKtmpOoCfALng00MDgpq/iRMZBQbpCJentWon7O4Gxb6mCvoJQh6lWI3h6aW
 vzJpcaOUtCVjJ+iGefmduFUP15flWgaPjsb1nysPGWRSUi1q8HpjTghAoDsquROVv5b2dwZukcl
 Cp522f+haqqDk4TSh+UgeAApKKRcoERXPkzk6S5829m7jXBL450C20DVOxgAHep3+AR39jn5vWQ
 D7fNTUshCk74xi/wxB6MktRzj3/7eCIhkjNxDfGq3PYZOGyzeLgsIIUz0FkRwZwHvXeVkiLN1fI
 oeVVRT4e/qIJRlNm2RGg1WiS++cN2OgUc6gNW4hlC4/nbxpp2kEpi5VhJvY=
X-Received: by 2002:a17:903:24e:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2ce9f1599f9mr103296685ad.4.1784036211252; Tue, 14 Jul 2026
 06:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <0bdd946c-3763-430a-b613-be7f1c9b5885@amd.com>
In-Reply-To: <0bdd946c-3763-430a-b613-be7f1c9b5885@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:36:39 -0400
X-Gm-Features: AUfX_mzUaTycv7_cA8medhAfrpY1MXluz44Uc4OH-EWpMbABkEXL2SqGDkyYmrc
Message-ID: <CADnq5_MfYX0fSmsxSABGWRQhig97967fEZjT8McoijSr0FA=_Q@mail.gmail.com>
Subject: Re: [PATCH 01/14] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jul 14, 2026 at 5:39=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/13/26 20:27, Alex Deucher wrote:
> > We need to disallow gfxoff if we touch GC MMIO registers.
> > At the moment we use KIQ or MES for TLB flushes so
> > no intended functional change.
>
> IIRC we actually tried this before and reverted it because it caused quit=
e a bit of trouble.
>
> The final solution was to use the semaphore to prevent GFXOFF from happen=
ing.

I think you need to disallow gfxoff to access the semaphore registers
via MMIO.  The semaphore registers just prevent the smu from entering
gfxoff while they are held.  I think the problem was that the smu
would enter gfxoff while the CP/SDMA was waiting for the ACK which
caused the ACK to never signal.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index 1fcc0594fd0a9..83b91c94a6623 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_d=
evice *adev, uint32_t vmid,
> >               return;
> >       }
> >
> > +     /* disabllow gfxoff when we invalidate */
> > +     if (vmhub < AMDGPU_MMHUB0(0))
> > +             amdgpu_gfx_off_ctrl(adev, false);
> > +
> >       /* This path is needed before KIQ/MES/GFXOFF are set up */
> >       spin_lock(&adev->gmc.invalidate_lock);
> >
> > @@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
> >
> >       spin_unlock(&adev->gmc.invalidate_lock);
> >
> > +     if (vmhub < AMDGPU_MMHUB0(0))
> > +             amdgpu_gfx_off_ctrl(adev, true);
> > +
> >       if (j < adev->usec_timeout)
> >               return;
> >
>
