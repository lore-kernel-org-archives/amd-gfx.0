Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5B310E87E;
	Thu,  1 Aug 2024 03:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyzSvUxP";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFBB10E87E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:20:48 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-52efa16aad9so9462306e87.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482447; x=1723087247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FJgmRK3XPWGf4Nh1RbXViO4Y5mcUiyNgClLoKyQdDQ=;
 b=IyzSvUxPaFAJH36axeyQxY2jiRUzKaVwIYp59wKkKzJwidYRoc+RlIRxBWLpExG01C
 HoBZVAvm70gtk5mi3jXJ97kFJuXoFGBb7xzIqn0Frx+pFlyUpmiCZDe9xJph9GLwn16h
 dzTYWiKWFSItMQPwzmBbegLtT4w5Ahd9UJ5DdMtSChBcYO8hCo4pubaG9CG9AiTEw/em
 ZyxPmXCst13jdDYE0rz0R/xl+CTt3d0HUkLmQCAE8eoqo1Jn4ptvI8j/59t1QkStQpLf
 iOawK2A52sq4e3A/6DEyRLQYYXKu+hLH9nlFiZ8TUHHwNW60MxrDC5pz7o9pcC7oqtiC
 IsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482447; x=1723087247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FJgmRK3XPWGf4Nh1RbXViO4Y5mcUiyNgClLoKyQdDQ=;
 b=p7m91XQWRF5XPFcK0WDhBc65C/9zYHpqVujkS0VWoe7QQNJTKdHR4WxViCvW83rPcs
 mKsSHLctup+wmiR8HLFyQE6aXHqiwLZQ7fJZIadiioNLpd+nxCt8jQr8ZqPO8KLwpSu5
 1u62RUMMcTMnhRgQRB+yMWIzdWnuMKUJYQ+cR3kLwPp6QTFlysEcbVMBl4YRClhF/lgX
 W1+D7QT90J1B29SaKReyNvBBCQ50BPz5wMT2dlL4mNUVYKQRRU20HfUaotwik570n6R+
 3izc/zkt5dMS+thi/EY5NBoXUKKvlcTYxx7/qDWdPEF6NHhteNArXtELKSZs2+ndFrl2
 B2+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcca4FrRY+AAU+dJhQr2uKu8dc2mePtDl+LYpG/p68mgLavfa+IqgwlB6PpLJNPXXEtxV5NSSF7hPON02q/chCxKykgl7oSB5+we9n+g==
X-Gm-Message-State: AOJu0YzncyuiXVDLpTMD9ecvDUHMFr4w8kGNDPuLtYNWUwlaKenaNR8N
 8hc2x8h5RotxcSMLdrxZspAf6JzwD4pgbeoxA6VrBbb2OtAcRscSHWUzZvsQ+jMzr3smPAvbMnh
 OEVJ9NNtPnjk1YKwqa0LZEel3Qn8=
X-Google-Smtp-Source: AGHT+IHcYXVqliNifI24KZwnCRnJqlnyLUwlWY4rUOLkgpPghNNj2soZiAhFLytdYayemXu+0IVpP2imCBcBD4Ms+3k=
X-Received: by 2002:a05:6512:3408:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-530b61f7823mr522111e87.57.1722482446265; Wed, 31 Jul 2024
 20:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240731081203.25148-1-sunil.khatri@amd.com>
 <20240731081203.25148-2-sunil.khatri@amd.com>
In-Reply-To: <20240731081203.25148-2-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:20:10 -0400
Message-ID: <CAAxE2A7z8siOqR5GO4m4GJn+U9V0nDKH73T0iJOM9S1QKaMQqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: optimize the padding for gfx11
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

On Wed, Jul 31, 2024 at 4:12=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
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
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 4a9766635933..e7c160b9d0fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -481,6 +481,24 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_rin=
g *ring, int eng_sel,
>         amdgpu_ring_write(ring, inv); /* poll interval */
>  }
>
> +static void gfx_v11_ring_insert_nop(struct amdgpu_ring *ring, uint32_t n=
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
>  static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -6709,7 +6727,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>         .emit_hdp_flush =3D gfx_v11_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v11_0_ring_test_ring,
>         .test_ib =3D gfx_v11_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v11_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_cntxcntl =3D gfx_v11_0_ring_emit_cntxcntl,
>         .emit_gfx_shadow =3D gfx_v11_0_ring_emit_gfx_shadow,
> @@ -6751,7 +6769,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_compute =3D {
>         .emit_hdp_flush =3D gfx_v11_0_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v11_0_ring_test_ring,
>         .test_ib =3D gfx_v11_0_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v11_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
> --
> 2.34.1
>
