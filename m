Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7FC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB297613AD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB297613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8026F4A8;
	Thu, 29 Apr 2021 20:17:05 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BF16F4A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:17:04 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 y14-20020a056830208eb02902a1c9fa4c64so26016187otq.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOIOOR8ZIXKkYd24PPoz1uxrToX7SZAliufHwEQ5OEY=;
 b=rRoOZHvZ7zZEmMHF9pyoksXnm+HOWI5NSYEdZIeceaW849ti/3JAUcwgLS2Qoy9okZ
 xukjHw/rwNREuZbw1HoX4pxLDyqpkAk1lSpBkP9p1Y7YEn96+4dtLfxyHCyhGcT5StN4
 qr+mp6fnK6PjoL7SKiraW6hZvWQepGRYTsRtYjkUIF2dJKOhzVr1AvYZiVO66xQ5u0js
 llvPQysSD4OlTGeqtNSiIKug6WpOviNAdVqHDuuvAygtCY2dYju/pvZ274fgmSerSRKQ
 vreZPaNCVTaReeeedpvEih/WyUbevEEIj5GJAt0tHLhOgxVCui1jMHhMxwMHSXwrwGLf
 RaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOIOOR8ZIXKkYd24PPoz1uxrToX7SZAliufHwEQ5OEY=;
 b=oJ64Y0/l14ShL1UNh/th/bX8p2OOVphgoVfIRZzVuf0Wossle0Sd0wyxreuX9OIGlu
 aR0ocVV5tKNxTEzq8BJ4nULcVBfrQTcwrL3Qko2zvGtj+fiUfRu7szHASiCxIAQP9Me7
 QkjQfjff8tf8t5nIumZ98wSatqxy32wbitJuItYAx03NklK2akArcWF5JINlbkV1JEcK
 qY6tKG9XhpJWKTYADSZPmo67AnBM1nLX5dU/jAFDrGKFHXn9Duoxr+yTjlrLCdNeylb/
 PtBpKJjWirDROYOEyUFP3lOvKQ7F9sKxlXpaMEbchmL5YDb3NL+F5yT5T29vBzck71fD
 o8VQ==
X-Gm-Message-State: AOAM53246qnRjeY4F/UNoAmSOKM3xynctKFapQuHdJey4OwLpPDLeyw6
 NqjYV29bPOrijcWn7XasZTgTvIfVVnVmth+rjcM=
X-Google-Smtp-Source: ABdhPJy2Tnf/vrv3VfPTonfVhYwTZWPomZmoRgi1cw3Sx90Jv1omZf+PPFEka5LShZSZYAgJG6thh5RdN/PhbVmhEtk=
X-Received: by 2002:a9d:63d1:: with SMTP id e17mr667943otl.311.1619727423754; 
 Thu, 29 Apr 2021 13:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210429201312.10498-1-zhigang.luo@amd.com>
 <20210429201312.10498-2-zhigang.luo@amd.com>
In-Reply-To: <20210429201312.10498-2-zhigang.luo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Apr 2021 16:16:53 -0400
Message-ID: <CADnq5_M_WSZiWxnXAMBB3rBxXHAbUOkNVkRKchf_PLGEx2VQBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
To: Zhigang Luo <zhigang.luo@amd.com>
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

On Thu, Apr 29, 2021 at 4:13 PM Zhigang Luo <zhigang.luo@amd.com> wrote:
>
> 1. add Aldebaran in virtualization detection list.
> 2. disable Aldebaran virtual display support as there is no GFX
>    engine in Aldebaran.
> 3. skip TMR loading if Aldebaran is in virtualizatin mode as it
>    shares the one host loaded.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 623044414bb5..17b728d2c1f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -422,6 +422,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
>         switch (psp->adev->asic_type) {
>         case CHIP_NAVI12:
>         case CHIP_SIENNA_CICHLID:
> +       case CHIP_ALDEBARAN:
>                 return true;
>         default:
>                 return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 0c9c5255aa42..691066e9c1f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -50,9 +50,11 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>         struct drm_device *ddev = adev_to_drm(adev);
>
>         /* enable virtual display */
> -       if (adev->mode_info.num_crtc == 0)
> -               adev->mode_info.num_crtc = 1;
> -       adev->enable_virtual_display = true;
> +       if (adev->asic_type != CHIP_ALDEBARAN) {

We should check for ARCTURUS here as well.

Alex

> +               if (adev->mode_info.num_crtc == 0)
> +                       adev->mode_info.num_crtc = 1;
> +               adev->enable_virtual_display = true;
> +       }
>         ddev->driver_features &= ~DRIVER_ATOMIC;
>         adev->cg_flags = 0;
>         adev->pg_flags = 0;
> @@ -679,6 +681,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>                 case CHIP_VEGA10:
>                 case CHIP_VEGA20:
>                 case CHIP_ARCTURUS:
> +               case CHIP_ALDEBARAN:
>                         soc15_set_virt_ops(adev);
>                         break;
>                 case CHIP_NAVI10:
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
