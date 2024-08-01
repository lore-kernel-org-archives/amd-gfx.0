Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D83C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA2E10E884;
	Thu,  1 Aug 2024 03:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9Mx1Hfi";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A37010E885
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:24:46 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so8804160a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482684; x=1723087484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+lma511F82N+HnLjVI5wDkDSL9QwL33NfAxliXklPY=;
 b=d9Mx1Hfi5s85OE3xEk4POOrgWmg8jjlsH4BPYZHl/nczvw8VAsQ3bjEVawgqwQsveQ
 dfaizFdIg2eZ+C+xbLX+Pm3z2334+LWnAPRJGSrDDU7dDP+OzvgeCrumeOqfmCFnC6uO
 HczvXUgGysBOkgDviW8leNDXtwC/xS2aCVgjfrHA+gcA5ZsPELdDQGHpVsSMnZHOjLfc
 RwZvbcAxJpNwA2k9/bpiQiCgW6ta13E/KPDGhsEAAlqIZ9+K87ft1AYXlxbxf257L86b
 XU4rGTXam9eieyqUr6JYc+ADixGDJIFtaNarwTg4Q39xTQZ2lLYm2zz6f+RPR5nL5X7Y
 4Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482684; x=1723087484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+lma511F82N+HnLjVI5wDkDSL9QwL33NfAxliXklPY=;
 b=dIbifD1SJhcZ5vpDL4bqtpcfW/eFuM9VkCDwdkqlpl+CqxwPlILfrquPtH4rQaMKIQ
 vChXUHQHWBOv0JXhu0q62FdJ6LUOGKYekwaAPkld2Hw4iZlt5Ir5L+K+71Li/ZhbOk8m
 nVNx9Ydltu9r96+4jeH9s8jVz5eghqCYdKfa5r2R7zsVezrQQmLv/neQwKxwL1LgbXFK
 0jlbk2xtIw+hnctMl9olCKZtyYjO8Abe3byHGWnhZxw2Bm3tK8IhsYdPFxwnEYqp+q4g
 cLFdDws3xFt4RnxAeOOR4XBI3AjF+KkbuT/84EY/2qFRfWCHs9p1HWcaqd7faEssL4NN
 lRTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUysc/fORcdrTk5EH9oSPA89URH0soc/DoulXDfcemdWIXeMp96lt3VS36eCOl4UhqGXgPgRhy8XvtPSsSSEHeFgRF16/BLTafEy4RPwA==
X-Gm-Message-State: AOJu0Yy/cuYTF9nq1r6zIT0k9tbt8Tnz0JeSezHbZQs23Vev31/F2frb
 DFtQtBLOsttu2DOCWMzkFmM2422x9f7Hi5DTz1jPx9nWDVuouegYTMUeVPMHJdmh/7rpV1mYXk8
 8mjhvmx1qD/nJsJyVyrFHGizVMEg=
X-Google-Smtp-Source: AGHT+IHAUW1lmk+p7h+Amns24ZLmJIyjUip2B6rkseIP11f9GDwo1n/1VWVRvDAfdc5gVHceroYIA5kdBRRkPxWjxOE=
X-Received: by 2002:a05:6402:a50:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5b7003d82dbmr517184a12.27.1722482684152; Wed, 31 Jul 2024
 20:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240731131252.354336-1-sunil.khatri@amd.com>
 <20240731131252.354336-3-sunil.khatri@amd.com>
In-Reply-To: <20240731131252.354336-3-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:24:08 -0400
Message-ID: <CAAxE2A7StENNesgM6vpXTpuV0eZ3=_H6jJtEJKLzwAvMpN_7Bw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/amdgpu: optimize the padding for gfx9
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
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 675a1a8e2515..991f7c2fc1a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7100,6 +7100,24 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu=
_ring *ring, bool enable)
>         }
>  }
>
> +static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t nu=
m_nop)
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
>  static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -7240,7 +7258,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_gfx =3D {
>         .emit_gds_switch =3D gfx_v9_0_ring_emit_gds_switch,
>         .emit_hdp_flush =3D gfx_v9_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v9_0_ring_test_ring,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v9_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_switch_buffer =3D gfx_v9_ring_emit_sb,
>         .emit_cntxcntl =3D gfx_v9_ring_emit_cntxcntl,
> @@ -7294,7 +7312,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .emit_hdp_flush =3D gfx_v9_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v9_0_ring_test_ring,
>         .test_ib =3D gfx_v9_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_sw_ring_insert_nop,
> +       .insert_nop =3D gfx_v9_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_switch_buffer =3D gfx_v9_ring_emit_sb,
>         .emit_cntxcntl =3D gfx_v9_ring_emit_cntxcntl,
> @@ -7338,7 +7356,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>         .emit_hdp_flush =3D gfx_v9_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v9_0_ring_test_ring,
>         .test_ib =3D gfx_v9_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v9_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> --
> 2.34.1
>
