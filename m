Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BF1C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CC210E87B;
	Thu,  1 Aug 2024 03:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVg7YfHt";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC8910E87B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:20:00 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so7064307a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482399; x=1723087199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvFBn4l7WndRyw8Mi7rmRXUkgC+ba7ljquCmW/36hSo=;
 b=KVg7YfHtH35L2H3T0n9RYKzNFfPELXvps7qvfIinU7EG4K/rDp7WS1fihNXJmb3gqk
 xHuZ8kdE9kdy3DwcVN9ELSiPvuTq0XfYC4ajtE1Hynvp9d8FcunxzovWpkbDQMIBrv5e
 ahEgLPT9GU2qT44Wh3nfPCbKVhvv5zV5NnYXkQDTn14//NANAImoK/TcKOSMk2nmUsZi
 orJ2Fa9pBwQVz99DOuQJVDyz1U9Gx228+yw7DXmrNj8sX9wcFA4tv97rwUANU9BWhayb
 bfnB8pRBOAwDHazDCUKGGzZTprLtSjwZCzIsu6YT7OOgjKlja25NiZenPN4xaRuZ59t6
 tqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482399; x=1723087199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GvFBn4l7WndRyw8Mi7rmRXUkgC+ba7ljquCmW/36hSo=;
 b=MFLU5jZtyRVXTenMA2ymKeksYwaRhoYRQ3MvRj/nQVqtqGmhUq0MPTCdhjuJlaQiL9
 S4y3b3pdZ1B9YVFUhNDrYQO83/hxCCH7YWeE68ZSCxm/MouTFlZ2LwiMGSPi2c4R2Z97
 GzTyaXl8rT9NkHXYuP4B7cAQntFarOwhpjziMHLvMdK2iSdmg+7jeV/W+22ZbGnwxC64
 J3KwKHehFixaBc3V0gijWxkBoLI9x0X3j8urcgIvY0pTGi4EpHmnqGmEg7gIXcbm/A+/
 gmo/rWILllAePjRTq/h1xvQA5Y9Tk1EYCwDn4+bs9H34m8GuBlDCPQgDkjWi1MsUDXca
 PPUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvQOw1jkHOQFXuPLxgnnxo4T72BVNQQSB3rmA7osHu9L50QexLcQ7fBNoU0hYw4o0AKAU+jAMd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGbeGkvTFEnxFYCf9hJ/4k+mYLMJXT2c4ywbPNLkk3twNJ4Xur
 a3qlxL84Smu8PL4s1yNYZf0ovdfe6ulNlCRCcumXGWFjZd9I0v3kSw97KnF+Guo/F+67A7HBCB6
 uY1/Vfen+lhKcJZxb8i/87srxd1W09mBw
X-Google-Smtp-Source: AGHT+IGoSU+CwInpG5gF9N4J4ESTvHiQ3RjjHLJEF1IoMnnBMYY4Rj/XXv08zrlaZ+U2NIADXfaTF7doc8vlA7CqlkM=
X-Received: by 2002:a05:6402:a41:b0:5a1:f74d:2d58 with SMTP id
 4fb4d7f45d1cf-5b700c913e0mr497487a12.24.1722482398691; Wed, 31 Jul 2024
 20:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
In-Reply-To: <20240730124332.38030-1-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:19:22 -0400
Message-ID: <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
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

This loop should be removed. It's unnecessary CPU overhead and we
should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
whole packet body uninitialized is the fastest option.

Marek

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
