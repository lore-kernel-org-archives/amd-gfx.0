Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14692ECE577
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F71310E5E9;
	Mon,  9 Sep 2024 17:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQKlDY/D";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EA610E5E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:05:18 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-20543c6f3b5so2387515ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725901518; x=1726506318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6Y+Y2elhwdk3ilrS+wSVk6eYNt3OwL07RSQc1M8uWo=;
 b=jQKlDY/DhcBPG/uV7L8Uioi1gi50g3rK16jMRU9LJzLHiQf7cbZJw0F6eBzFx4BFax
 2z7aYhWc7fQzw9/a6fw7gVCKjPGf6nehUn8NZ/g5NB9GqsE5Cyo/AShMgmWNCds6yMrH
 7S1aP4FrRuK1PYBS+xGRuelMelJ7QngpeZL2obvXRvATqNaad3esK7bZj9Kvuhwm4a1r
 52eCPb5NU3GllSzuW0xf0jodBgX/hvH/XgzTKRafB29Z0H2WucZm+ImgWAHn4h9/KCVu
 BDmXCNBjzS9bkqPBdCSr2C5GetG5jVrODTqTEcVETnvByLH55Wy9YZlhh5JxmyR35QyY
 d2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725901518; x=1726506318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6Y+Y2elhwdk3ilrS+wSVk6eYNt3OwL07RSQc1M8uWo=;
 b=kPzKi0MmG05I9DcfDcgK3oeK2jHt39KXUX8uI586mO08BiqUjK6T8OnipKoQaq282Q
 EgYZeUHouRzn8KwyBkb6xnygDxUgevSVxNK98/Du+bE+XKZjSb8183FV9Z1FDk3Tbv1O
 KsLyQtaReWqG4gw2zhcT7v5JBFsfjEhmb+tIRMZo3yE/TzvQbrZxU6g3WHXA355LTjRy
 +syL5Vmt8tmS8q03SmztqDhDtlb7AxXTn8wNRwO/C4vvr6p8FaiKJXsnAzDGrpNxYUQG
 xnqyxSgdKtoIdazScAhUyS389ioj7qFoOEJTsdga0/TZXDcyOiYBHLG02L/n0A0jrArV
 Qh2g==
X-Gm-Message-State: AOJu0YztYgEow/cLfAy3BKLguGThTXAZunYkhcRBcsZa0cc7/9h0+kQA
 HQfkcyJ+71LyJCi0I05rfchZiNUVJg9IWbgO3HTBikTsI4irXMJqdDOTV3kr2AuHSdugZizutPJ
 1rlXpfwi8qQ4LGR+XcXsKwwi/Tjk=
X-Google-Smtp-Source: AGHT+IF/xiAkAkd5LwX+bJquESN0j+R/HhQergEF7QO2dOs283WvGjcFQmxOCl2YXIqvyC2hvuvjdVqAVnp7dMxamco=
X-Received: by 2002:a17:902:e54f:b0:207:da7:bd97 with SMTP id
 d9443c01a7336-2070da7bde0mr32073615ad.15.1725901517885; Mon, 09 Sep 2024
 10:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240909095408.1683-1-jiadong.zhu@amd.com>
In-Reply-To: <20240909095408.1683-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:05:06 -0400
Message-ID: <CADnq5_Onzu0=xGiP3QhjEFG7cZeFE1upKC8wEXyPEbw0JousCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: update mes_reset_queue function to
 support sdma queue
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Sep 9, 2024 at 5:54=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Reset sdma queue through mmio based on me_id and queue_id.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 53 ++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 5174ed31ae5c..285ea4cdd5b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -914,7 +914,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_devic=
e *adev,
>         queue_input.me_id =3D ring->me;
>         queue_input.pipe_id =3D ring->pipe;
>         queue_input.queue_id =3D ring->queue;
> -       queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
> +       queue_input.mqd_addr =3D ring->mqd_obj ? amdgpu_bo_gpu_offset(rin=
g->mqd_obj) : 0;
>         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
>         queue_input.vmid =3D vmid;
>         queue_input.use_mmio =3D use_mmio;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index c4212b6fbc56..2b94a8e7f509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -366,7 +366,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_m=
es *mes, uint32_t queue_typ
>                                       uint32_t queue_id, uint32_t vmid)
>  {
>         struct amdgpu_device *adev =3D mes->adev;
> -       uint32_t value;
> +       uint32_t value, reg;
>         int i, r =3D 0;
>
>         amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> @@ -422,6 +422,57 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_=
mes *mes, uint32_t queue_typ
>                 }
>                 soc21_grbm_select(adev, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
> +       } else if (queue_type =3D=3D AMDGPU_RING_TYPE_SDMA) {
> +               switch (me_id) {
> +               case 0:

You can just move the default case here.

> +                       reg =3D SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RE=
SET_REQ);
> +                       break;
> +               case 1:
> +                       reg =3D SOC15_REG_OFFSET(GC, 0, regSDMA1_QUEUE_RE=
SET_REQ);
> +                       break;
> +               default:
> +                       reg =3D SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RE=
SET_REQ);
> +               }
> +
> +               switch (queue_id) {
> +               case 0:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE0_RESE=
T__SHIFT;
> +                       break;
> +               case 1:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE1_RESE=
T__SHIFT;
> +                       break;
> +               case 2:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE2_RESE=
T__SHIFT;
> +                       break;
> +               case 3:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE3_RESE=
T__SHIFT;
> +                       break;
> +               case 4:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE4_RESE=
T__SHIFT;
> +                       break;
> +               case 5:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE5_RESE=
T__SHIFT;
> +                       break;
> +               case 6:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE6_RESE=
T__SHIFT;
> +                       break;
> +               case 7:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE7_RESE=
T__SHIFT;
> +                       break;
> +               default:
> +                       value =3D 1 << SDMA0_QUEUE_RESET_REQ__QUEUE0_RESE=
T__SHIFT;
> +               }

This can be simplified to value =3D 1 << queue_id;

Alex

> +               WREG32(reg, value);
> +               /* wait for queue reset done */
> +               for (i =3D 0; i < adev->usec_timeout; i++) {
> +                       if (!(RREG32(reg) & value))
> +                               break;
> +                       udelay(1);
> +               }
> +               if (i >=3D adev->usec_timeout) {
> +                       dev_err(adev->dev, "failed to wait on sdma queue =
reset done\n");
> +                       r =3D -ETIMEDOUT;
> +               }
>         }
>
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> --
> 2.25.1
>
