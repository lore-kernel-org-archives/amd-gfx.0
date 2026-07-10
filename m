Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E463C44501
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7190C10F8C7;
	Fri, 10 Jul 2026 13:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UwlyvmeR";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E5A10F8C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:21:05 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2caf18d4904so1785595ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689664; cv=none;
 d=google.com; s=arc-20260327;
 b=cPGNbSuXOBcuiYPpdF8Z6JdL9gnDvgICf9TVGSHzBqErmp6DV+NfAu8ruTIt3OXcWS
 uRshAQ0xvZA03HlZechlWgVHC8OiC4R73Cig6YgDIMjqtdZ8S4wLCq5tlMcQG0q5YD2v
 tgVivZqihYX5AiehU1khc/MHDvwt5jEmBSlMfEeahQzdn2SdLj8JpltRm+Kz88DhxY4/
 VvvgKIgCoPcbAnrw5hfoKBNsqxygCAo4KsjXvqQwH6F+0EwIsst0Pal25cp9Z67Jf/tG
 oYNm6cc/VBdBFJzl92B9IgATkNDp8P28RxRQQwC77jpcp30k3CehGgyXU3ICssvjfojT
 vwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 fh=PSm27EbGRM6F2hsg87pdtkFCHF4tLmWSTgMvkZYoYQI=;
 b=AwxYUmpi19ceCcfN58LAg+FnSXs2+5UUbci9CXr8HN3cjqls2WV8/VeAmwIwGCjw3E
 PyGT3sdMaM4n0klexYNCwqZMZxleIPghOKB+tTeUb+7pg4uFsPdSI1oj6H16oPTI97Xa
 Lr/EWLVA6lpXiNY8jMkIEzIlg8954uDlURpanXjk8dBrcC9QRyb7UX9wG3lSFSC688UC
 RWjgmHPtVbg4YUPnBUH+20hqVSwPv3KbE0E5YtEi9qOk7UZrA7tzsH4MaDXLWn67Ij3Q
 B7v2fOyzyL47WzuCdsQzoGw8Ae5c5rCYy6E2EAfp6WrziFqWN4xk2GYF39kyVze/4QT1
 FOcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783689664; x=1784294464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 b=UwlyvmeRQkvUJG8Kl2nxCt+d9I15hSxFVRPhl4zQAaSB6Bug5/x/jcSMhR7thLWdao
 nkhEqTQ+MehDeVlcbRH7RAhYTf+Sq6q7epdtu58Za4nOAlr5iiszrSf5hqHtS9fPCHZN
 SFX67lQaIbOyWWMbvV47MlzJg4xufR+zL9FsAKULcctOmKU4vocUO6SvrHdZv+HFLORt
 oImoXgiIU/teESm7Mpnauns/LmbMS1SItdQoB3GkrlxHe87MKHaTNqPHAYkdTO594hjZ
 CKOud7VhBzvlgk0hRuLseTvqqOTQ72ntIsrWpaIaIjnOxZBGrEsIDRjpO8JV56cun7jY
 LSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689664; x=1784294464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Iv3/dHJP9eh11tlfDrZvOZIybFL9oIplbeFCapfAmc=;
 b=fuPOU7UQuc4hIxftU1i5iw7UsXlvC4sudnEkSBhde07t6QgarUjAm2d6185bLIM/RA
 3i1bpk1TqpJS//6350rrTIPD/WyAFfSF7oazTvh/d4uKvToGzKtoEDJDln12jaX6Lar4
 CaiVXl0CJDBHrqdl20ym0tTMVQnuq7k9H+ktPN7mirE7PkYAeTKo7GSO1f13o+xcGrJ3
 fYICkqdH2P/QHVQ480XSDyz5KXpy6m2fVo/Ewny6kegoso3p3uhKZDnAt6vDp3qevyOp
 QeXz1hp+T9XQFgeBv/CiEegkEfHce0H6SksRAS6iBjupC6UsapZeAtea9ttrpWpECfPR
 +O+g==
X-Gm-Message-State: AOJu0YzIWMT0tL7xf0MnMhVCuZLTfDkEHaT4fhIfltLZysU0cEqZl8Z6
 cxhW8PuEPtpOI8ynPqOd9NLgI63a0p/2ikiEIoe1cbgipivvIQAYfC9gvt8X1B74aeeBryvWh8E
 iWBcXR8NHclOX9FCOvfkGPz+HWz56Wqw=
X-Gm-Gg: AfdE7cnpv0jzArumT/QJGnUbv1EgIgvrlCm1rWMFrd+X2PMRtT+tRIYaWTKmPGMsUna
 sYUB0iV8n/4MTvvqZ89e8EKxw+pEUEMtUSLjL2+rUHBKZP/eeMZT+rhBYf+J1Q0toFT6FyDyqir
 vYpjRBfdAuvGqlec8OIT/ehUfHxXZk72NcSIPUTdaPP8BR7/XGdvbWw+njx6XzLP7SUn+wryxB1
 pIVBc/jn024RmdYAfpA7SydU0Omt1m/vcT7D4u4PI8YtdKVYMMdZqKRhHcFqJvpdaet7oIv+bzM
 jLv2pMzQu7Npr+mX5I9LQyr2laF7WVnBk5DkNJWfYm5WEqy8C71Ymdws53QxBxU6BFZo5g==
X-Received: by 2002:a17:902:e5c5:b0:2c6:b3d9:9bbd with SMTP id
 d9443c01a7336-2ccea4822d3mr83423935ad.8.1783689664480; Fri, 10 Jul 2026
 06:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260708163013.221986-1-andrebueno.mac@gmail.com>
In-Reply-To: <20260708163013.221986-1-andrebueno.mac@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:20:52 -0400
X-Gm-Features: AVVi8CdHtR54ckxCbr800ZtgJ2GncqvnzX-KSnJuu5g2WzyX6D9T6ZYw-f3QraM
Message-ID: <CADnq5_PXnX97HrF3t1xXeEZR7iV6ojDyTc3ReiNurY15e8bvLg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
To: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 Enzo Furegatti Spinella <enzo.spinella@usp.br>, dri-devel@lists.freedesktop.org
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

Applied.  Thanks!

On Thu, Jul 9, 2026 at 3:44=E2=80=AFAM Andre Luiz Batista Bueno
<andrebueno.mac@gmail.com> wrote:
>
> Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical
> interrupt processing routines. To avoid code duplication,
> make the implementation in jpeg_v5_0_1.c non-static and
> call it directly from jpeg_v5_0_2.c.
>
> Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
> Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> ---
>
> v2:
>  - Dropped the new jpeg_v5_0_interrupt.c/h files and Makefile changes.
>  - Kept the interrupt routine in jpeg_v5_0_1.c but removed the 'static' m=
odifier.
>  - Declared the function prototype in jpeg_v5_0_1.h and included it in jp=
eg_v5_0_2.c to call it directly, as suggested by Alex Deucher.
>
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  8 +++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 63 ++----------------------
>  3 files changed, 12 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index edecbfe66c79..46bcbecd89e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -755,7 +755,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct=
 amdgpu_device *adev,
>
>
>
> -static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
> +int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
>                                          struct amdgpu_irq_src *source,
>                                          struct amdgpu_iv_entry *entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.h
> index a7e58d5fb246..67346faecb47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
> @@ -108,4 +108,12 @@ enum amdgpu_jpeg_v5_0_1_sub_block {
>         AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
>  };
>
> +struct amdgpu_irq_src;
> +struct amdgpu_iv_entry;
> +struct amdgpu_device;
> +
> +int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
> +                                       struct amdgpu_irq_src *source,
> +                                       struct amdgpu_iv_entry *entry);
> +
>  #endif /* __JPEG_V5_0_1_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index 285c459379c4..250e7f849037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -34,6 +34,8 @@
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +#include "jpeg_v5_0_1.h"
> +
>  static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
>  static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
> @@ -583,65 +585,6 @@ static int jpeg_v5_0_2_set_interrupt_state(struct am=
dgpu_device *adev,
>         return 0;
>  }
>
> -static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
> -                                        struct amdgpu_irq_src *source,
> -                                        struct amdgpu_iv_entry *entry)
> -{
> -       u32 i, inst;
> -
> -       i =3D node_id_to_phys_map[entry->node_id];
> -       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
> -
> -       for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
> -               if (adev->jpeg.inst[inst].aid_id =3D=3D i)
> -                       break;
> -
> -       if (inst >=3D adev->jpeg.num_jpeg_inst) {
> -               dev_WARN_ONCE(adev->dev, 1,
> -                             "Interrupt received for unknown JPEG instan=
ce %d",
> -                             entry->node_id);
> -               return 0;
> -       }
> -
> -       switch (entry->src_id) {
> -       case VCN_5_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG1_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG2_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG3_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG4_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG5_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG6_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG7_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG8_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG9_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
> -               break;
> -       default:
> -               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> -                             entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> -}
>
>  static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
>  {
> @@ -749,7 +692,7 @@ static void jpeg_v5_0_2_set_dec_ring_funcs(struct amd=
gpu_device *adev)
>
>  static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs =3D {
>         .set =3D jpeg_v5_0_2_set_interrupt_state,
> -       .process =3D jpeg_v5_0_2_process_interrupt,
> +       .process =3D jpeg_v5_0_1_process_interrupt,
>  };
>
>  static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
> --
> 2.43.0
>
