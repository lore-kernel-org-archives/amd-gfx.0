Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C755C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC4B10E882;
	Thu,  1 Aug 2024 03:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EgFHxYPs";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DB510E882
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:24:07 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa7bso7054884a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482645; x=1723087445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9eOUww4MPb/032QgFYcZ0qFv6d2LRzVfnJOwB1qmKc=;
 b=EgFHxYPsOfQSDYijVMq5UtgGyTu27HNVxs3L/00YciTAeNVG9mIZemdv+1w8ymBold
 5gSQ0ZcjZ0AnWZDlLmv7gzfbQiGNfHyR2mtDeF6c5qRzLA3x/wu5YOaNeWi0v2zIPYwV
 J50ICCsJHP+3or4WcNnw3opv667OkqBNmhdq/xk/UEYQlI0NXLBvju8SSfQFp1Uv9vsh
 qu3BM8gazg1HGtLntScYdawGFRqHEiLgGGPTMN0H9UOFx5DkSKWJoYAFN0vgkLMZiOKD
 vDL/OfJUzgktwAi++IkJ3ry2xDZStFLM1OP6zcsAMykpf834OIFPAc+EbGxNdYDBfa+I
 37tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482645; x=1723087445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9eOUww4MPb/032QgFYcZ0qFv6d2LRzVfnJOwB1qmKc=;
 b=wAa6jWu0wieENzzDrgfDlNuXVCD/ftkKINs46Ro1YPZJptSyI2dLz10uKIl+jVPYdD
 FVVM+o+4CHILHynBs8GH/U8FLkxqkNxqKGjMCLFuRFPULu4fVg9h+u51YyxhYpgAtACk
 /NsZr+PVY16/xPzRNAAQcjP/gtoN+j+YeqCvsQbUe7kgzeLlcqTxNqES0gRSg7HM+ZTS
 laDKrmcEeoCu3nMD+qLhqZ55p4a8wNvo7rqKTAjNiiArBIfuImLefncF/8HiSG+EVeVI
 CvPd3ZT7hqHvAux4OBNKzC8lM+MsPV3cSkNEW4Ch/Ot8L3o0+U62Cy48732mlyLNokjd
 6h/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrAKMfAuv5y0pxXf1pNAznXkfHgOKnunv97sNTRv3cq2RSkPYlDIEiR8k8XCCoOWKrVMRgpa+F@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyupRxTN+kRtgCtOGp7EPIrMAeFqj46levNK1QVo5nq2ibsniiV
 UlxZPjhgAqoJMlUaGEyXAurkvhHtbOKEN9S1NUUVuQ3H34XkgM6iDySoV5H++lBz90W5UjpWIud
 1zs7/oMF5PZo3v9fRR/4RyiQau/U=
X-Google-Smtp-Source: AGHT+IHbD2nF0B7qpn1+XiOMZ1q8+4PbX6RNC47iZ4oUcbj288NUmXZOtVou2SQcxDEjyk1sftduNgg7vi6jX7oTMvc=
X-Received: by 2002:a17:907:96a9:b0:a7a:387c:23f8 with SMTP id
 a640c23a62f3a-a7daf4c28a0mr91756066b.3.1722482645110; Wed, 31 Jul 2024
 20:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240731131252.354336-1-sunil.khatri@amd.com>
 <20240731131252.354336-2-sunil.khatri@amd.com>
In-Reply-To: <20240731131252.354336-2-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:23:29 -0400
Message-ID: <CAAxE2A4xmSKiV8+haUC_kbpid1dMHBPB0G1eyY5sFQgPJKw=DA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/amdgpu: optimize the padding for gfx12
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

On Wed, Jul 31, 2024 at 9:13=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
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
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index f932c7ff85e3..29b3bf1b29b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5005,6 +5005,24 @@ static void gfx_v12_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t n=
um_nop)
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

This loop should be removed. I explained the reason in the gfx10 commit.

Marek

> +}
> +
>  static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -5186,7 +5204,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>         .emit_hdp_flush =3D gfx_v12_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v12_0_ring_test_ring,
>         .test_ib =3D gfx_v12_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v12_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_cntxcntl =3D gfx_v12_0_ring_emit_cntxcntl,
>         .init_cond_exec =3D gfx_v12_0_ring_emit_init_cond_exec,
> @@ -5224,7 +5242,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_compute =3D {
>         .emit_hdp_flush =3D gfx_v12_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v12_0_ring_test_ring,
>         .test_ib =3D gfx_v12_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v12_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
> --
> 2.34.1
>
