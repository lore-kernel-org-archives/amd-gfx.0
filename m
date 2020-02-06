Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EFC35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5DA218AC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIOOQTcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5DA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6576E26C;
	Thu,  6 Feb 2020 20:06:28 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835FD6E26C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 20:06:27 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c84so176096wme.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 12:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cMi0UJbtcCOR6EVJ2iy+dRQLT8BVCe34TFzqlgfttTc=;
 b=GIOOQTcljs/fxjHriLcVnsECM+YGAwEIdUHSlyw1b1agxE0t8FCj8NhsaOdmPItXM2
 rwkNafEOdS4QPbD32H4Mj8F/7VLbV7gtJ7SaWI9qEHEJUe2Le16MGhX68kkGFD0eeOf7
 pJDiOUY+letcFHbnQI9srOY5J5OK+htVfImB/B3kqVeeE2RmRXcR0/L2I+huPzkXKh05
 0FWGPhj2molOdloFi1lh1Tby+7ALLxBBBPJHNHhV3VyDtcCQpLx9YNaL1P5CEPIyu7oq
 q5t9vgbJmfScnxWQCkWDSFxQ+O4h+WcNQJR3khGTAd4z5hI0SW2R9Jor05g3T0d66rhz
 EZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cMi0UJbtcCOR6EVJ2iy+dRQLT8BVCe34TFzqlgfttTc=;
 b=n6cVD+4mIo5p6OkjQrU5EZpuJM8TTWMB9ZN1FAnGlHWAjDCu6akMTWgGdW75iIVDJx
 3n75y88EczHYkHPkozmdVGUfXcLV/WLao5sKU9FvdSnKANQpjQz9Ii9JwN5qNQbCnTLJ
 syyppzylEU1mISNQ5DmI8wPVQ4+YWm6T2M6g8sYE1lBMZgFr7BOQUFq4NdYU/cYqIfEj
 glO5BwRMdSLseueeyvugrQuyZ6LDiZPC6uv3v4qrG+Trb+lNpMMlpuLwtOzqc4yrlwwU
 e8ypTpM7Elwa55ijGNqB5LRls5fX3RSfxM38Bdb5m+XAokYmsY50uMLIogxHu6AZqkbT
 F0PA==
X-Gm-Message-State: APjAAAV/fgVDMk2+fko0WmXrPkQqM5oLBmY2jUWyejrnBNX84a3pcdN1
 c/zGdbnMxyr+8sotYH4B257KiI2l+8+u1Rw3tfY=
X-Google-Smtp-Source: APXvYqyDuDuAZeS3bd8/1opONyxUlLO9x19TO1ojbS5/CyXkSxlfpRAMaPagyIHq7gnDeer8iVDddppQ1Zg3fr1yUZU=
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6283629wmi.70.1581019586200; 
 Thu, 06 Feb 2020 12:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20200206195935.36365-1-samir.dhume@amd.com>
In-Reply-To: <20200206195935.36365-1-samir.dhume@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2020 15:06:14 -0500
Message-ID: <CADnq5_OHPGkXH6qc6ZxZyekeFvr4oTDUcqT3D0B05+kDS28Ffg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
To: Samir Dhume <samir.dhume@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 6, 2020 at 3:00 PM Samir Dhume <samir.dhume@amd.com> wrote:
>
> Ported from Vega10. SDMA stress tests sometimes see IRQ lost.
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index cf557a428298..e08245a446fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -32,6 +32,7 @@
>  #include "soc15_common.h"
>  #include "navi10_ih.h"
>
> +#define MAX_REARM_RETRY 10
>
>  static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
>
> @@ -283,6 +284,38 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
>         ih->rptr += 32;
>  }
>
> +/**
> + * navi10_ih_irq_rearm - rearm IRQ if lost
> + *
> + * @adev: amdgpu_device pointer
> + *
> + */
> +static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
> +                              struct amdgpu_ih_ring *ih)
> +{
> +       uint32_t reg_rptr = 0;
> +       uint32_t v = 0;
> +       uint32_t i = 0;
> +
> +       if (ih == &adev->irq.ih)
> +               reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
> +       else if (ih == &adev->irq.ih1)
> +               reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
> +       else if (ih == &adev->irq.ih2)
> +               reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
> +       else
> +               return;
> +
> +       /* Rearm IRQ / re-write doorbell if doorbell write is lost */
> +       for (i = 0; i < MAX_REARM_RETRY; i++) {
> +               v = RREG32_NO_KIQ(reg_rptr);
> +               if ((v < ih->ring_size) && (v != ih->rptr))
> +                       WDOORBELL32(ih->doorbell_index, ih->rptr);
> +               else
> +                       break;
> +       }
> +}
> +
>  /**
>   * navi10_ih_set_rptr - set the IH ring buffer rptr
>   *
> @@ -297,6 +330,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>                 /* XXX check if swapping is necessary on BE */
>                 *ih->rptr_cpu = ih->rptr;
>                 WDOORBELL32(ih->doorbell_index, ih->rptr);
> +
> +               if (amdgpu_sriov_vf(adev))
> +                       navi10_ih_irq_rearm(adev, ih);
>         } else
>                 WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
>  }
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
