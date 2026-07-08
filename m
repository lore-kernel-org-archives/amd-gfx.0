Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB9FC44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 17:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A7810E3E1;
	Wed,  8 Jul 2026 17:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sOHpog/1";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3191110E40B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 17:27:00 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cc7a269ca1so1517595ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 10:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783531620; cv=none;
 d=google.com; s=arc-20260327;
 b=BcPpUKpMtfOoIKN99SfVfMQKhk8oeh8+WIHoGeQiE+9p56bTvupoeIJAp9Shq35xVY
 R4I1cP5qezY+jcZiWUakN7OteTWGu+Q3BSwLKR70JrDfxXz2YUnof9L0NlIK0We/uGRi
 M4io/uaps4X0SL3OZyIo6dvzsCHTM7tyrWweZk7PY/T9t1Xqet/mFRLoEuFAP+Q5VsYr
 c0+IrbL9DhkTRLParGszCFiQ6sKaFuXSWHIVLhbhbo1sksp4dmO+3P5OgbRsjqRdVaF7
 1sCYRhHpPAMyY35kE6PONYWILvCUIXfqqP9JxKBb7IOST6+cQkPz6g+xvw4ZuR17IC7U
 1I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kpU7Mu1mZxXFjEe70JSeaFfv84/FPXdAhclxIwrMZgQ=;
 fh=gZ/QuQ1El2NU1RRI5pc/CAX4Mv4g4Ez7PWwEsOz7Ag0=;
 b=sAI/TyIDnEUKHIjI9RnUmZbi+TmmhDtAxP0Rj9vExCvXX9V+8eb1ag/Fv1ey80RO/O
 YicPGEfig9PHvFZR3WPc1w/ciM9wFPmL4sXAVwGiihh3RzhDvt6efYPrxRpGdmKW9cvq
 O4QZlrsSqdffqWdxwWNMopE/cDsmgYIkPxHf+IX2ciBWRJIZhIocd50zAwY+lU6iTlU5
 ueXvC2vTVTaUf6EXihcA3I/PCztHcIPtwddVXHU1kTtkh4YH9PgjnZAtvu9NXbSgPtLG
 Oeuv06cpicg9Q2/wAdOO985DTTgG6kZZWcFaE/7NoEnuBjiYHgLWsoP+Q8nIXVoxG34D
 8Idw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783531620; x=1784136420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kpU7Mu1mZxXFjEe70JSeaFfv84/FPXdAhclxIwrMZgQ=;
 b=sOHpog/1ksaM9YobPip7hYJ/zNt8gX3dvw+l16remMmZO5VgbheH+0FYyeGPka/XDc
 vxxfmDoOLsgp2RR9FB4/e47TIl+WoU8j7VAeAQdRaI2yV/vgRXscHbRcR1kDlQiuTixM
 cbDI3p3pRraX6C+DL76nPqTnUrtKfkvfb1QSecBS67fg0+kiIf4ff4ypqDJOK2YL/+sM
 2LsFz0UjEA1IQjyGdNjn3a4dkwC9o+Cndc1pCV5krr1W0aT59ci3BboEbh0pDlbLpIm0
 86ubodyGTfmzUmLlHrdCqLyq5hGAfgCVtdsnClyln5Gczoiy/+9ma4Fni34yyzh9dX2a
 mmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783531620; x=1784136420;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kpU7Mu1mZxXFjEe70JSeaFfv84/FPXdAhclxIwrMZgQ=;
 b=XUkut3SpCYXyXorLr4jSmoFJSaC2xDPnaLskBWwlGYjm2p6kxc+xj5CyCB5ZS66uKE
 qMRoJg9//QIh9M3q8flgig0VotXbDCLpVrkscZC3aa+jekVF+KX2H0dtH/srshqcSEGV
 4pKhhoCfoOWV5/HHe8wO6r1Q/4ZVz80dpiRoZNmocPy7U6tmu8XsA1gBS2SZJshHpQ6t
 4m6TgE7ywa7qPoKykpaWDTG8yRKataaVvRvMlgA/e8gedYpS1H0m+V52LzOirVllaz8T
 7Bo9/QKb3RjXw9bGQYBKhm9Me2wcklxUWcaiA2pL+QkI9nJLyqdbNj6pm7EcSNlIgU1j
 Qahg==
X-Gm-Message-State: AOJu0Yytbb32nzxBYGvUSDDPD3rV7O/QQru9AeW+1MMXQZgQVTKooXjZ
 wG1LZLkPPcqxwPweYjFiexQ3YqaqZeZ5Wd300m4NuBTox+l5skhFmf3Y6k76VvQDug2URdrrAEt
 V72k6hTxPWxhqPRhA51ottwGAxPYhS4z0zQ==
X-Gm-Gg: AfdE7cnbm+Mhc72VO11qRXYynG/7v1suAglmoTbkUo+M7oeeb557MbcPPX1Pw3u4q4F
 2sjIp33kz0Db10KZQ0W3q4H26NhleawMAHVdn86G9bhYZr/SoGE319ODjEAq+oiey7jwyyXR4R5
 KssnW/0Ehz/turruWKyHO08ywa+lwm7jcpXWXEFg4f0UkD81O/huaFnJBKk6A0f8CR9HxlBY2yS
 nH45IVvy46cUKqfQFmBwFN7+XGXTodRMOnddLOLaV3AjU9yiCy4reeJp5f11SZGQg0+jhZOua5A
 s59on27YZsqSj94Lgw1PfDquUEUmBL5cAQVOJvV2DiSm4p3TGPkVmiUJxnY=
X-Received: by 2002:a17:902:e80a:b0:2ca:d344:7743 with SMTP id
 d9443c01a7336-2ccff305eadmr3203105ad.7.1783531619583; Wed, 08 Jul 2026
 10:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260708164336.4099991-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260708164336.4099991-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 13:26:47 -0400
X-Gm-Features: AVVi8CdNpZ9hQouomun9sWZq0Wqwz4PRV2UO94YTD0JrFnUSTInnPcNSQWZJvlQ
Message-ID: <CADnq5_MkXOYQ_2N5cgyx6+7nMzWqK3mTwa-RU7ck-YyAc8Ew8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix 32-bit overflow in CWSR total size
 calculation
To: Yongqiang Sun <Yongqiang.Sun@amd.com>
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

On Wed, Jul 8, 2026 at 12:54=E2=80=AFPM Yongqiang Sun <Yongqiang.Sun@amd.co=
m> wrote:
>
> total_cwsr_size was computed in 32-bit before being used as a BO/SVM
> allocation size.
> With large ctx_save_restore_area_size and debug_memory_size
> multiplied by the XCC count, the product can wrap,
> yielding an undersized CWSR save area that firmware later overruns.
>
> Promote total_cwsr_size to u64 and use check_add_overflow()/
> check_mul_overflow() in both kfd_queue_acquire_buffers() and
> kfd_queue_release_buffers().
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index 9d4838461168..01e228fc1860 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include <linux/slab.h>
> +#include <linux/overflow.h>
>  #include "kfd_priv.h"
>  #include "kfd_topology.h"
>  #include "kfd_svm.h"
> @@ -235,7 +236,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_devi=
ce *pdd, struct queue_prope
>         struct kfd_topology_device *topo_dev;
>         u64 expected_queue_size;
>         struct amdgpu_vm *vm;
> -       u32 total_cwsr_size;
> +       u64 total_cwsr_size;
>         int err;
>
>         topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
> @@ -308,8 +309,14 @@ int kfd_queue_acquire_buffers(struct kfd_process_dev=
ice *pdd, struct queue_prope
>                 goto out_err_unreserve;
>         }
>
> -       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> -                          topo_dev->node_props.debug_memory_size) * NUM_=
XCC(pdd->dev->xcc_mask);
> +       total_cwsr_size =3D (u64)properties->ctx_save_restore_area_size +
> +                         topo_dev->node_props.debug_memory_size;
> +       if (check_mul_overflow(total_cwsr_size,
> +                              NUM_XCC(pdd->dev->xcc_mask),
> +                              &total_cwsr_size)) {
> +               err =3D -EINVAL;
> +               goto out_err_unreserve;
> +       }
>         total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>         err =3D kfd_queue_buffer_get(vm, (void *)properties->ctx_save_res=
tore_area_address,
> @@ -344,7 +351,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_devi=
ce *pdd, struct queue_prope
>  int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties)
>  {
>         struct kfd_topology_device *topo_dev;
> -       u32 total_cwsr_size;
> +       u64 total_cwsr_size;
>
>         kfd_queue_buffer_put(&properties->wptr_bo);
>         kfd_queue_buffer_put(&properties->rptr_bo);
> @@ -355,8 +362,12 @@ int kfd_queue_release_buffers(struct kfd_process_dev=
ice *pdd, struct queue_prope
>         topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>         if (!topo_dev)
>                 return -EINVAL;
> -       total_cwsr_size =3D (properties->ctx_save_restore_area_size +
> -                          topo_dev->node_props.debug_memory_size) * NUM_=
XCC(pdd->dev->xcc_mask);
> +       total_cwsr_size =3D (u64)properties->ctx_save_restore_area_size +
> +                         topo_dev->node_props.debug_memory_size;
> +       if (check_mul_overflow(total_cwsr_size,
> +                              NUM_XCC(pdd->dev->xcc_mask),
> +                              &total_cwsr_size))
> +               return -EINVAL;
>         total_cwsr_size =3D ALIGN(total_cwsr_size, PAGE_SIZE);
>
>         kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_a=
ddress, total_cwsr_size);
> --
> 2.43.0
>
