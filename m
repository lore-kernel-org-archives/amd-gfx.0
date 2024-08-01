Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A613C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5E210E886;
	Thu,  1 Aug 2024 03:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z1wJMqpW";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D524C10E885
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:25:34 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so341508966b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482733; x=1723087533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVVtSN5I7mwmSnp4wA5I8bbrLHXwcfjCASH39Om0jxI=;
 b=Z1wJMqpWECz8dCmnbzqCPNNrQIRujHWpOVndkOEWwN4NEEoop1dplujz6fyKIAGtnh
 hw/ZRWY8+eWMbu/Ek/Xi/0uo3COGle6rBgeliY8E6nPrI+nlGRic+QICy1Gxb/8pgjtd
 tGDTnKUXmWVWbd0F3MeTsRU2En0la1P1yRWz28g2ggsBdAuE8gu3d2KGG62ar+emNoeN
 iEJ6DJwqKU8RVJ8WubUCyCtX/xiKsH2P6dE2Ngh3w6GHSSoOfQj8Jl16GFsR0N5XVw5a
 lzRtQtgSKchbORlooUYViJ8H/BVn09ZMaUSGViSA4YrH8TvbJu93cAyK8IjQqSrgRJFS
 l1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482733; x=1723087533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVVtSN5I7mwmSnp4wA5I8bbrLHXwcfjCASH39Om0jxI=;
 b=pwyRY6BbPo7vnNYsXBB3Gi+Sf+emSh8GGmqWZecQp9uWw86O7cA5gn30ADq2oFajly
 LpZmDCvLkQdJEBEvS2KAXR51B7t2IrmX4Sczu4b3iu/KkNhgDqNJFg9L3X8YeRy4TpPy
 jH3Zz7Q2T1Umo3v+E76teskVwEIWWuipn4M/mQPTN/FtGcSBn0HMt7/PrBj6xoemINLH
 kawnEnEMuUk5WC1whxyfTh/8+bk9lb512tZW5g6VMAq5FZT8snExhG+pXWft8Nc1QUk2
 0yU9uNTn1ETlK+Gnp5l4848CtO5o7BuGG2U/AylWJ/HUtxDMcZPKB7RXsdNRiYUN1LrA
 D8jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXaEHotZKGIxpG+1H/CjcW6snkglVJCc0crBwfMkWp8UePi6uVup1mig7aFiF9GdeXZDdx1jdhZVUNgw/anwU0mGkOUVQW0T7fYVXKaQ==
X-Gm-Message-State: AOJu0YywdkQDXMlWfHvP5mL2coRYABwyW2t3wKg6m2470vEism9UlYh9
 h1HqrgVrpvEeUIdDzlksCXL3ZvzfxuAh0X1zVcCOGlgN72bfYjkfwR3Rc8oDUoJdXXnYlLrbpWi
 f20dTBMjF/rEdjM0U8GjnGLYeNSk=
X-Google-Smtp-Source: AGHT+IGg9t+bR8qLvhzlGTGpP4PvkT3wPnMxAluS3qepPid0IgF4MuPHl+9otKIEJ6M5PDVocmt1yqLbI2rPT2GvRXY=
X-Received: by 2002:a17:907:7b88:b0:a7a:8c55:6b2 with SMTP id
 a640c23a62f3a-a7daf4fdc8fmr85408266b.14.1722482732997; Wed, 31 Jul 2024
 20:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
In-Reply-To: <20240730124332.38030-1-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:24:56 -0400
Message-ID: <CAAxE2A7AoEXu_TP8LkMb6KbeSMtL2QT+AfjQMoi52WHYMixkSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Tue, Jul 30, 2024 at 8:43=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Adding NOP packets one by one in the ring
> does not use the CP efficiently.
>
> Solution:
> Use CP optimization while adding NOP packet's so PFP
> can discard NOP packets based on information of count
> from the Header instead of fetching all NOP packets
> one by one.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Tvrtko Ursulin <tursulin@igalia.com>
> Cc: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 853084a2ce7f..edf5b5c4d185 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint3=
2_t num_nop)

It would be better to have this function in common code instead of
duplicating it in 5 files.

Marek

> +{
> +       int i;
> +
> +       /* Header itself is a NOP packet */
> +       if (num_nop =3D=3D 1) {
> +               amdgpu_ring_write(ring, ring->funcs->nop);
> +               return;
> +       }
> +
> +       /* Max HW optimization till 0x3ffe, followed by remaining one NOP=
 at a time*/
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3=
ffe)));
> +
> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
> +       for (i =3D 1; i < num_nop; i++)
> +               amdgpu_ring_write(ring, ring->funcs->nop);
> +}
> +
>  static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v10_0_ring_test_ring,
>         .test_ib =3D gfx_v10_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_switch_buffer =3D gfx_v10_0_ring_emit_sb,
>         .emit_cntxcntl =3D gfx_v10_0_ring_emit_cntxcntl,
> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v10_0_ring_test_ring,
>         .test_ib =3D gfx_v10_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_kiq =3D {
>         .emit_fence =3D gfx_v10_0_ring_emit_fence_kiq,
>         .test_ring =3D gfx_v10_0_ring_test_ring,
>         .test_ib =3D gfx_v10_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D amdgpu_gfx10_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_rreg =3D gfx_v10_0_ring_emit_rreg,
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
> --
> 2.34.1
>
