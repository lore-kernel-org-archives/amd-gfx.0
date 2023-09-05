Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6ECCA101A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796F510E104;
	Tue,  5 Sep 2023 22:40:01 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A1C10E104
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:39:59 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a812843f0fso1720166b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693953599; x=1694558399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9qcAb7b75f0KVLanKe/fgCVBTZeCys3ls9TaYFnVjI=;
 b=cicZQ1e0IfYO3DMDdr7W/yGhGSAW85e7eK4rL0olI6AEOkJPZ4IF9Jm67JzTmz1br0
 q6FlsVObtSHh9quS1JUo4cbER06pS6h98WVvllZEgc7m0G0EIkrjhn2yrN3usrgceEIy
 2bnJN8LjGbttZtPa7Bm3LFF1QjUDbeYey10lhGC4N1Kdha2racs/FGLyIkyHQof8l5s/
 zh8FXRRBbFmJQaxQv5MyrwtwBybNU4wprYuW48gz2wy4AOLHx+2lymaLIl93aaoCbsaU
 YlVujeygwgI5LNGL8BYyBHOcwVdRvUz5QBXjORfTNnFCo8rNRDhYszYFZtFjC7jNPTSn
 vZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693953599; x=1694558399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9qcAb7b75f0KVLanKe/fgCVBTZeCys3ls9TaYFnVjI=;
 b=cGYBx4x/+DewlCMF6YfhWHUMRXSpn5NHyWFd8lJET16cS6HwKecpchWt0txQdFCowV
 6jVtS7EmsmK4XQmsl2nmJzqzucuVn+eWm8uvcYTL4SuMz2xAqUriB7Qp77N+3SO/J0WB
 E74/XRHg1KNydN841CHf5qAlZLN1as9oyUX/9BWQaA1030437R+22kfblKOCLasic3yA
 pMBRMrfYmD8BNFiirV6Sc6kV+tDAAiNbRa+4ojbzOvfQD8XRTlpdzixltK76t+HWhiVk
 Q8AXc1ha3+mjfGHKpffeG+mDTnYYKxW1DWDeoPOLOvbiQsvGXesKN9ieFOjDvOo/fThR
 Ex7g==
X-Gm-Message-State: AOJu0YzPU29QA7M8aeJHH3l+yrMv0uM8J/9Wh74BqDcxo3g/8bHeRIzs
 xTWYc3oMpSvoZItHwl/THOKgzIQcret8br1vH/8=
X-Google-Smtp-Source: AGHT+IGbPhymAGwgtm7m6ZLyPUkpOnaqNLFqzmQ46HlqgGWIZbBquWQq661j2XvV7tTEgZeA3J+MZsgl8OpT7gPACpA=
X-Received: by 2002:a05:6808:d52:b0:3a0:38c2:2654 with SMTP id
 w18-20020a0568080d5200b003a038c22654mr14166375oik.58.1693953599099; Tue, 05
 Sep 2023 15:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-5-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:39:48 -0400
Message-ID: <CADnq5_PsyrqNgLnbFqy7wP2wHkHo2rTQDBxRhMR8Dkc3r5RGEQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 7:30=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Testing for reset is pointless since the reset can start right after the
> test. Grab the reset semaphore instead.
>
> The same PASID can be used by more than once VMID, build a mask of VMIDs
> to reset instead of just restting the first one.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 6a6929ac2748..9e19a752f94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
> +#include "amdgpu_reset.h"
>
>  #include "bif/bif_4_1_d.h"
>  #include "bif/bif_4_1_sh_mask.h"
> @@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>                                         uint16_t pasid, uint32_t flush_ty=
pe,
>                                         bool all_hub, uint32_t inst)
>  {
> +       u32 mask =3D 0x0;
>         int vmid;
> -       unsigned int tmp;
>
> -       if (amdgpu_in_reset(adev))
> -               return -EIO;
> +       if(!down_read_trylock(&adev->reset_domain->sem))
> +               return 0;
>
>         for (vmid =3D 1; vmid < 16; vmid++) {
> +               u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>
> -               tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>                 if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -                       (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) =3D=
=3D pasid) {
> -                       WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -                       RREG32(mmVM_INVALIDATE_RESPONSE);
> -                       break;
> -               }
> +                   (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) =3D=3D pa=
sid)
> +                       mask |=3D 1 << vmid;
>         }
>
> +       WREG32(mmVM_INVALIDATE_REQUEST, mask);
> +       RREG32(mmVM_INVALIDATE_RESPONSE);
> +       up_read(&adev->reset_domain->sem);
>         return 0;
>  }
>
> --
> 2.34.1
>
