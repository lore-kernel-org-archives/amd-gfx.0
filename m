Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4373C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 16:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D338010E76A;
	Fri, 25 Nov 2022 16:59:30 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BBE10E76A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 16:59:28 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id v81so4984203oie.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t6G04z/jGDGEVMsiac7fQ3ryxwlSPLKfGWd4634o/cM=;
 b=eXGx8cJNqoKGNsgsUPBu5j2UhMpBx/8lUJWt6pm/VxIg4jUDIlpmdjaK2IBTcDR+BM
 E9DhJGwQ1BPKRKsaN4MGoGuH2Nnw0+9o0ktjcIJZCOQyBOkbPC/5Tc3XuPKUstroR0nS
 ajSGFZP6TERzJGqbO+l+owHo1IanvMnHwIFqn+bke4/EpG8hkf4M/yDEro+02NrGfvGr
 VwEeKPjeaPkxfqNIe7q5mSC9QQqpQWcFPFvhJGh8u0ywteTkbsRt+qz1RxqAFdHTs4Q/
 CSVH9DnSa4QpYBchTP4EAvOeDtDkA2YG1JJrTfb432dufY90GehGy27/Ns7k+5EcLWWK
 4VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6G04z/jGDGEVMsiac7fQ3ryxwlSPLKfGWd4634o/cM=;
 b=SRaVtZLJwNF46F49FcNnZa9vEL7VtckdSvi8iFyUEwQz88afmGKtow/Q8+MV5Svh7P
 H8Eh311kjm2RePNDlU3hBIKZk8G0gQps2U3f0BxzYguGhBwf6lrA1ce70iQLGEzoi4WO
 UGFtFRc4j4ojp3ipvKAop7m4kj4MgDHMwN2R9YmZ8vtyWiAQNZa1Qho2HoC8sc0c4OCo
 MPE7RUXiRCeHI+O548ttfqOwC0Ppjtw2142QROlR7ZyCmFUZge6J3N15N9QmBHMSz2gp
 9pS5dOrbXRn/kuhLOBlIS5Sm6+OPPSh8t2Z0YXFYjg1UCbbYZzMPsKB5d8hEbMOGpsLG
 uVqg==
X-Gm-Message-State: ANoB5pnJvgrp5VijxSrwdfPeAW4CoOaHjcpknYMHYIq6/baqmwB3Mh5j
 ObM64OupYScRF7WkVZd1s1wtMgExAPk+U7ztnxpMI2EN
X-Google-Smtp-Source: AA0mqf6/v5obWsVjKhP2hHXIPYcHH1L6YzMYrNCLK9yTv1OsunBV8Yo/hFOEhfsRaLG4OQ1869DCe5+qX8q2FZOh+Vs=
X-Received: by 2002:a05:6808:295:b0:357:670f:9e4e with SMTP id
 z21-20020a056808029500b00357670f9e4emr22244510oic.46.1669395567578; Fri, 25
 Nov 2022 08:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20221124052830.1340810-1-guchun.chen@amd.com>
In-Reply-To: <20221124052830.1340810-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Nov 2022 11:59:16 -0500
Message-ID: <CADnq5_Nt1zouwaQXo6oiPPUj5xcMFUFW4WK1nd=ayyHJ6JUVSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use dev_dbg to print messages in runtime cycle
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, evan.quan@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 24, 2022 at 12:29 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Runtime PM can happen pretty frequently, as these printings
> may be annoyed, switch to dev_dbg.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8b1f6c032a2e..447e27b2e16b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2568,7 +2568,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>                 amdgpu_device_baco_enter(drm_dev);
>         }
>
> -       dev_info(&pdev->dev, "asic/device is runtime suspended\n");
> +       dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 7bb2de1d11ff..4a18d1944e4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -861,7 +861,7 @@ static int psp_tmr_unload(struct psp_context *psp)
>         struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
>
>         psp_prep_tmr_unload_cmd_buf(psp, cmd);
> -       dev_info(psp->adev->dev, "free PSP TMR buffer\n");
> +       dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
>
>         ret = psp_cmd_submit_buf(psp, NULL, cmd,
>                                  psp->fence_buf_mc_addr);
> --
> 2.25.1
>
