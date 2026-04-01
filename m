Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FCD2ED0A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0290010E319;
	Wed,  1 Apr 2026 13:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUfsQbR7";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAD110E319
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:34:55 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so293647c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 06:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050495; cv=none;
 d=google.com; s=arc-20240605;
 b=QinL7DG62Bp7gQf69c/LYwb+rjZCUo4jy/6pI1qe38nVvrF986NIXReEPPYvwttCUV
 diGaKiybe57rf66cq4MBiyYFE7QbpfXZG9YgyRK+/3pgYouUj2rioPzzo7aQqh2d4gKN
 ADYhwFgl3Lpnbrgb3f9EBH3tbx9xv54TeiZT3smEbuc27cNF433HP/toh7yYw7qBJ7NT
 A8Rf1r6AHR+M5bCXwTCfXt2ygNln+P9Rqr1TzgDRTuQOnuJcUVr0C+tm1/JcEFcPuvBX
 zyzamGnK+NZ3djVw6KOp2hl/Ql97JievLEAsm8j2GPasDCQV5yJtRTagz3wShx2YIazD
 dS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 fh=PgrFK1KxlXT8wKj4V/UDSBh3gW8Wl6rqW1k2Ikgixpw=;
 b=BWQdt3WPUOCSpUovj9zq+x0qzVMAP/ArhcKXmG08OlfFbr7676wjZAgV3/pL/fXZFi
 gXg9G6UgrzZX/9oN6u4aw85DwDxgJgiUoonCzEve5pO7A73byDp+b4rzs+h0W1A/KT4t
 +OaNE3+h2CtS6Pc6rHr3BAGeKPUu9g8RCcY4s+rm0G11AgzclWzmyUGXlQ/iR+CW3sj9
 3T5N3LT4T1cXGORWeu4PQY3UJu8txF+Gxs0KgMlQvWwtTf0kmQpzWRh/vmvAD2E54fuV
 XoH7mVlKl6f/5+th8eL1ZsO57PRMRNKCQqVMKdkVxFQKOTyuG44ds3m9eqKW6VYQOIfo
 AUIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775050495; x=1775655295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 b=OUfsQbR7syCKJ+PRM1E99dVfMqtY7qYX2IDY2J9LwXV4BUdK5soL+piuUOP1Jff6Bu
 NZRBAwhrQ14efMTbaX144Z8hucS5uLocZSKPWKuXIJ4hF5NAm2FY3RREGfA+1cuscf8D
 YYm0IldwEqXK/oyzE2aIsqc2XsCpbZ9Q3YSz/lv+9ENwx4Hepm1SLnanXGTCZ//qbXTy
 uEgBkEolzz+cgs+wN4O+P66NZ9fgwj5hbJ85XUevSOOno1xROXNHo2WMQu7NnYMsZTUq
 u+v6054rtjx3gco3RNaUJ5AOLBxUFKcNdffkGujydKsaon+6xkvNGjvg4ELlg9HMVO7d
 o/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050495; x=1775655295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eLfBNRbSl1W6d33tZWXwxSJsOwniWi9VQ/dTIyU4S4o=;
 b=RTcvE/JOtzeMjwekwQtRzLVfo48kcg1tlxKiVoiST70RcpC4v0Fz3I6biFjjiobWOZ
 EhFvJ6ma09pkPjT1XS6XMS5NglKQHdLsWckJ/gz9kC0YChJm56zXPZRZs6nT5RByNRhr
 6RatpDxcQeXKqJ+86XY7T6WeOLOkrj12c5GbR9ThFbL6Cqxlr1+1k8G3tEEuzQ9kNGzA
 T3SJLGw+UkvNvHP4tX+p3666iegtBFBMoKgPl1Sh2AoNmoGQh5IYfM/JPH1Ioalo5qzE
 yn6HSpOhwXPPrsix2axP/VfADmzMcaF1/MLVXo7kUPnDqCbjDWl8dTTbIzvUzI6cXk/1
 2bdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmNnYrtKJqNP2CThk/YywFLYm+Dlz04RrCiTa5VoE+ilCGq1uopd8OwrmW18Ptxw23NJIJTQbe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdU/VWwdB7INqezZtjbHfpZwmE3ZE/pkxW89pKQsX4xvKkmTm5
 YcY4zh3lpsiVGmYmpC9AnnXh0uXkRNDkMgEtY2VuTkRtAhJ6xN59AGxDkGxkWi9L3CzH3nPH59m
 50czdI7shlEc1+DCRORbawumNKG6B2aY=
X-Gm-Gg: ATEYQzyDp0AKfuZxbp6wsbFE1aoE1eJgEVxi13COBPj0+ardclyJ4TQnBH1eaRb2h7U
 jXVATnclS11z66DYTiSJkMHoB6GqfNQSCcwnY58bgBvGB1rN83/XY0qiUHIwTf62EXUI0kEaEaJ
 JFIUEahfJd9+GYeWjg5nBznItK14H8Xs1KLYzA8qZ0/gGyOtBxV65Tf7t+YvS66dkEElCUHcYMH
 MyUpMgylZJ3WwhDcZT5+xmELQO+6PcYTKqEvE2jPl5UsRAOuUYg5e9Ni8kW8djtknDGgy56mm43
 v8ZzgNeqM7AWDknAY6+8rK1avUATbra92L+Oe6WLEsP30S8cxRB6+jKfVo83cTckMPk7vnOLqOr
 8nRl9
X-Received: by 2002:a05:7022:f102:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-12be65ef768mr812956c88.6.1775050494670; Wed, 01 Apr 2026
 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260401113911.593661-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260401113911.593661-1-mikhail.v.gavrilov@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Apr 2026 09:34:43 -0400
X-Gm-Features: AQROBzDM4v695EYwPKTDGmz6KMhv1DQeuqsvqsHzrCsiA4CXWIs1f39e3GLleS0
Message-ID: <CADnq5_MGEpvyoSLe8=k+n=59B3Qx0=e6aeZTOyxMNbPqF9vaLw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: use IRQ-safe xarray API for PASID
 management
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 7:39=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
> regardless of XA_FLAGS_LOCK_IRQ =E2=80=94 the flag only affects lockdep
> annotations, not runtime locking.
>
> Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
> xa_lock_irq/xa_unlock_irq internally.
>
> For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
> xa_unlock_irqrestore since this function can be called from hardirq
> context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
> xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.
>
> Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Applied and squashed into the original patch.

Thanks!

Alex

> ---
>
> v4: Move comment to kerneldoc, add Reviewed-by. (Christian K=C3=B6nig)
> v3: Shortened comment per Christian K=C3=B6nig.
>     https://lore.kernel.org/all/20260401120055.46498-1-mikhail.v.gavrilov=
@gmail.com/
> v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
>     amdgpu_pasid_free() instead of xa_erase_irq(). (Christian K=C3=B6nig)
>     https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov=
@gmail.com/
> v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilo=
v@gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index a6ac3b4ce0df..684f40fce73f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>         if (bits =3D=3D 0)
>                 return -EINVAL;
>
> -       r =3D xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +       r =3D xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0=
),
>                             XA_LIMIT(1, (1U << bits) - 1),
>                             &amdgpu_pasid_xa_next, GFP_KERNEL);
>         if (r < 0)
> @@ -81,11 +81,18 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  /**
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
> + *
> + * Called in IRQ context.
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +       unsigned long flags;
> +
>         trace_amdgpu_pasid_freed(pasid);
> -       xa_erase(&amdgpu_pasid_xa, pasid);
> +
> +       xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +       __xa_erase(&amdgpu_pasid_xa, pasid);
> +       xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>  }
>
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> --
> 2.53.0
>
