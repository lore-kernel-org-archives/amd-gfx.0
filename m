Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5457AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD4110E765;
	Fri, 18 Nov 2022 16:01:51 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D9410E765
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:01:48 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id l127so5778228oia.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zj8xqHBzpyifKFAgILGM1HPxXlxGp7nmC5m9Wjecq8=;
 b=bEsr6VrgXhPNRSwAXEU9korbYauquGK82u8Ouv0B0N4aInZxAPuGLc50zVfFxp6EVC
 Jai7xnbCibuovi5pZIkIsWw5fhNI9QPe7qXZCOdb598O2nbg3owzTrYa+zRyIs2FTmOx
 6xt3n676cjwdXJa2+IUPPNjmGQKX6hi7Oqf32lZ+/QTQtKDlJAcBT5J3GpW4LPFAJGM1
 1l1XJgHX2KoI2WoQzydO0chhGvoSHIL0GiDgqzKfOQb8oyML+IdV/XEZNZ4FkV7EHNNI
 pv4PrLv8sGuPYBz6UnTqb6xTyRxLHrNBPsQJLz0/T94y2IMkqFvYzcJB1MoKdDnRwypo
 MW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9zj8xqHBzpyifKFAgILGM1HPxXlxGp7nmC5m9Wjecq8=;
 b=ZfOPBieSrW+UaTCOx3DFSbD30T8IHo4owjaLTDhCoMjkv5uYzg6nECy7HJT1N16xW+
 lccBoxOO4I8pHswX+UCiWBIMPP1QvUDfTurMDWPMlJezHkzCOZ5AymkIpOS5ifbcJ0JF
 O7JI5L3cDD1HJBt9Gsj5jA7B3aAggnJnXCGoD7XKfu3OBfId2iOugNGJhcQxlIwK7wdB
 3R+sW4G1ayBcktmBXl/QjLOm9wAu4M9M7pwT5MsLstvb/IvdGAkrceuNVi6bBRo5BnBR
 zk+9YbEnd+7cUrDgmMucHIeoIOR+33nTBcpr/HcTJnhff8DIvNicGBIKGBP/iniUjl5b
 7cEA==
X-Gm-Message-State: ANoB5pmI5VXA9MWRV5lby43ywsmz4d9mI7BbGMDm6dVvyIq07Z4SWOnT
 jtEJBY2yMNoWo79BIvcSENtKvv02yilQKgy9fPWA2FUD
X-Google-Smtp-Source: AA0mqf6hp4gV5VLoFsg9NOUkUYP+y+nUPibMMPnA83vXTzMEfWpGzpYk4zU+wlqDXozof11JNnwV6DGHSzkvpvew4zg=
X-Received: by 2002:a05:6808:295:b0:357:670f:9e4e with SMTP id
 z21-20020a056808029500b00357670f9e4emr6862674oic.46.1668787307582; Fri, 18
 Nov 2022 08:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116164006.2830029-1-alexander.deucher@amd.com>
In-Reply-To: <20221116164006.2830029-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Nov 2022 11:01:36 -0500
Message-ID: <CADnq5_PR8Q3FnRPpkPzL3VV26mYeOr43Z_Sa+AUP=L1-NcoSZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: don't free PSP buffers on suspend
To: Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 16, 2022 at 11:40 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> We can reuse the same buffers on resume.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Anyone want to give me an RB or AB?

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 56 +++++++++++++------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0a8c30475dda..d9cb4c4b8289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -172,6 +172,7 @@ void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
>  {
>         amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
>                               &mem_ctx->shared_buf);
> +       mem_ctx->shared_bo = NULL;
>  }
>
>  static void psp_free_shared_bufs(struct psp_context *psp)
> @@ -182,6 +183,7 @@ static void psp_free_shared_bufs(struct psp_context *psp)
>         /* free TMR memory buffer */
>         pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>         amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +       psp->tmr_bo = NULL;
>
>         /* free xgmi shared memory */
>         psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
> @@ -743,37 +745,39 @@ static int psp_load_toc(struct psp_context *psp,
>  /* Set up Trusted Memory Region */
>  static int psp_tmr_init(struct psp_context *psp)
>  {
> -       int ret;
> +       int ret = 0;
>         int tmr_size;
>         void *tmr_buf;
>         void **pptr;
>
> -       /*
> -        * According to HW engineer, they prefer the TMR address be "naturally
> -        * aligned" , e.g. the start address be an integer divide of TMR size.
> -        *
> -        * Note: this memory need be reserved till the driver
> -        * uninitializes.
> -        */
> -       tmr_size = PSP_TMR_SIZE(psp->adev);
> -
> -       /* For ASICs support RLC autoload, psp will parse the toc
> -        * and calculate the total size of TMR needed */
> -       if (!amdgpu_sriov_vf(psp->adev) &&
> -           psp->toc.start_addr &&
> -           psp->toc.size_bytes &&
> -           psp->fw_pri_buf) {
> -               ret = psp_load_toc(psp, &tmr_size);
> -               if (ret) {
> -                       DRM_ERROR("Failed to load toc\n");
> -                       return ret;
> +       if (!psp->tmr_bo) {
> +               /*
> +                * According to HW engineer, they prefer the TMR address be "naturally
> +                * aligned" , e.g. the start address be an integer divide of TMR size.
> +                *
> +                * Note: this memory need be reserved till the driver
> +                * uninitializes.
> +                */
> +               tmr_size = PSP_TMR_SIZE(psp->adev);
> +
> +               /* For ASICs support RLC autoload, psp will parse the toc
> +                * and calculate the total size of TMR needed */
> +               if (!amdgpu_sriov_vf(psp->adev) &&
> +                   psp->toc.start_addr &&
> +                   psp->toc.size_bytes &&
> +                   psp->fw_pri_buf) {
> +                       ret = psp_load_toc(psp, &tmr_size);
> +                       if (ret) {
> +                               DRM_ERROR("Failed to load toc\n");
> +                               return ret;
> +                       }
>                 }
> -       }
>
> -       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> -       ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
> -                                     AMDGPU_GEM_DOMAIN_VRAM,
> -                                     &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> +               ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
> +                                             AMDGPU_GEM_DOMAIN_VRAM,
> +                                             &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +       }
>
>         return ret;
>  }
> @@ -2701,8 +2705,6 @@ static int psp_suspend(void *handle)
>         }
>
>  out:
> -       psp_free_shared_bufs(psp);
> -
>         return ret;
>  }
>
> --
> 2.38.1
>
