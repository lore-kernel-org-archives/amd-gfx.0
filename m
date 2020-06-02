Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FAC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E9D206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPG9q58l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E9D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA6F6E413;
	Tue,  2 Jun 2020 15:12:38 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E8F6E415
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:12:36 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id l26so3292785wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jvF7hThlDqu+eZDzaUi3uz+y8WzMRylOMCpaTMfF6hs=;
 b=OPG9q58l7fe/ZAiKVATrMvn2EPyBCemh76lJfw4EnqXrT/KgW9PRQCmxuAK+hVkKd9
 1snzrc7vwEq1JQbflbg9RMmeR9N6FVgbzJ1eDB3gPiwlMqXsVaPlhoU4EimhuYcPBZQV
 LQM8PTE3Ijeb9sq9K28I2qVEQvdvfttiU/tk5s09SdSYyGt57PRJ+ar0QOhatxuI+hoZ
 9H+lCFByfvbm81LQP9ia/yA4Qh67H7flu4ll675fuKc8Qc/euukY2wu4kVq2pxCAUn0M
 LHLV4GunV4pzCawqpvHrpSl0/4VKs4kjOtcjnofMQyud63DjkASVafmhp9e/Fzh7PBkK
 G4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jvF7hThlDqu+eZDzaUi3uz+y8WzMRylOMCpaTMfF6hs=;
 b=ppHd94/5a/otnfnDvsf+D7MUPfAYXX2YQ6JOeplVLKhHcYd2np7Z5Jx+iRytpjQLTf
 NYty9/fhSeQ//BIe6J5xAhRA2XcRa2BrP5pzsB5TSj6POHn5EC5FdFBkVfFRRQW2Lc6T
 LhyNBR28/PPWI95uxb4Zm47C2pFAg0IZMltK0AH389iAgz5IMV1CBlVRp9yeRbdTorFV
 0i360LEVGci2e1CHh1CLu2CaMOJWZbveFNiWBs66oCtnZA1MeGCpD3zSkbbEQBgNrVHF
 h+TfI1i0+0RLQ2jBhEF2ntFG3WXnmZCLB4vOyF5phjSrgbTuYhopxuApmSgC2xaK9e+U
 C2Qg==
X-Gm-Message-State: AOAM532gB2wGY3+YK15SQSPv9Bfov1yV92mF3Z17IdSfnpKAWaPQaX52
 acAd/ddf8spzufFUoNGhTfvcYLTABqSEcB7buoU=
X-Google-Smtp-Source: ABdhPJzcKFoOePBddl9euhrHsTdPrbYS4SXCNAVrSGgQB3wEF5BisFbLMW+2GoL5kubVoU1hzB9pGvLWDH1qojgOkRg=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr4566675wmh.39.1591110755474; 
 Tue, 02 Jun 2020 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-8-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-8-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:12:24 -0400
Message-ID: <CADnq5_PTH9Sp+Wx3Ub2m=uz1AFd_1u7D1CLbmF-YECxPsMqKDA@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/amd/powerplay: drop unnecessary dynamic buffer
 allocation
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 1, 2020 at 3:31 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Since the structure comes with only several bytes.
>
> Change-Id: Ie9df0db543fdd4cf5b963a286ef40dee03c436bf
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  3 ---
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 15 +++------------
>  3 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index e55c6458b212..b353ac1b0f07 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1121,9 +1121,6 @@ static int smu_sw_fini(void *handle)
>         struct smu_context *smu = &adev->smu;
>         int ret;
>
> -       kfree(smu->irq_source);
> -       smu->irq_source = NULL;
> -
>         ret = smu_smc_table_sw_fini(smu);
>         if (ret) {
>                 pr_err("Failed to sw fini smc table!\n");
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 4aa63dc79124..7fed2556213f 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -356,7 +356,7 @@ struct smu_baco_context
>  struct smu_context
>  {
>         struct amdgpu_device            *adev;
> -       struct amdgpu_irq_src           *irq_source;
> +       struct amdgpu_irq_src           irq_source;
>
>         const struct pptable_funcs      *ppt_funcs;
>         struct mutex                    mutex;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 891781a5c0d4..e2b1c619151f 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1167,7 +1167,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>                 if (ret)
>                         return ret;
>
> -               ret = amdgpu_irq_get(adev, smu->irq_source, 0);
> +               ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
>                 if (ret)
>                         return ret;
>
> @@ -1191,7 +1191,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
>  {
> -       return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
> +       return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
>  }
>
>  static uint16_t convert_to_vddc(uint8_t vid)
> @@ -1607,18 +1607,9 @@ static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
>  int smu_v11_0_register_irq_handler(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> -       struct amdgpu_irq_src *irq_src = smu->irq_source;
> +       struct amdgpu_irq_src *irq_src = &smu->irq_source;
>         int ret = 0;
>
> -       /* already register */
> -       if (irq_src)
> -               return 0;
> -
> -       irq_src = kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
> -       if (!irq_src)
> -               return -ENOMEM;
> -       smu->irq_source = irq_src;
> -
>         irq_src->num_types = 1;
>         irq_src->funcs = &smu_v11_0_irq_funcs;
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
