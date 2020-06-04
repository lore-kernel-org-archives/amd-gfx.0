Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13041C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF2A2077D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJFeqVbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF2A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEE86E526;
	Thu,  4 Jun 2020 21:13:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98DE6E526
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 21:13:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id l26so6547500wme.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D1Ij8gmD4C+fsYrVCDxSF9UzntfkOXlMASu2I6U92yI=;
 b=AJFeqVbUPxl6xCQX/pTBK0doAvDs8k8wJCCG32NJQj3gtSEtLfyNZ6dq66G1VxRSOw
 kL2t49WXETd7lRAmQ0uk/57pPiE6uoeQfyqdUiFtZ34deASDPVXVZXzHMhlGmMN5AS2f
 lyASGxwGpaIGaYQ6xagde5ZsYi66DX4/5FiP2Xw0ow5i4vObL22lVjL6ChqK3zKWMYuw
 zFu5tvMeh6p9Gu+MRUTgGm9ZPnGjmKa+dK5dnZqtqxnx6X1GV8YpRrWz/c40Jg06mrP6
 +bqK17/2WNfcNvTeLuv0d7Aokt93OxVbHmotXUFUskS3q4EUBlE06vwExNKbjij800JK
 rrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D1Ij8gmD4C+fsYrVCDxSF9UzntfkOXlMASu2I6U92yI=;
 b=HNwpUmYh+KKN0BAY8Z5nTREUM1VjENE725XWlJrG64FRgFakMyXfIGT1ftqrd6ZyFB
 G+4R22tpxLQCjXXHAtelcxF9blJ0sBk1UK1BQC2xO+g2V9qYJJIVZO8+/KvuiIlaz2vs
 KEXk8pu/NahWqM0At6GHjLAE4s/aYUj1BgCQcmEaL58/OuMs7EzHeHKK4aGpTmbcrQRx
 co4oNOvjMDJiP2zxIQ5Hzi/28Gg0eBlpTAjJJJyxCyLgUSzKU4j5MHa9i/FwOVx5xsmj
 HiAu4b+Q7UIVgVnv41ffVYI9x6pOGVUFlP/Gs1vUlLFPkZ9kZs76i7X6Mn7mt1ejjlsN
 BZ4A==
X-Gm-Message-State: AOAM531jL/BMaCdJZmXKJ/cBmHLqq6BlyME18pXBBWyq3UPTsAuc5S+d
 9foLlcwN+KqEMP1oKdIUObdM+xlrBlz+Wv/3ta0B/tjt
X-Google-Smtp-Source: ABdhPJzD7lZOHTHgQBnwwo/rcUHOQw3gU9Cq/1v6dpH+szO8a1AIPrxtg+cNgb2LsVdU8Z1j7ZPKOW5ltieqX3T2uBc=
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr5871945wme.79.1591305206321; 
 Thu, 04 Jun 2020 14:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-14-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-14-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 17:13:15 -0400
Message-ID: <CADnq5_MJKpDfpPf29J0296PHCX=sAbjuYFL21qi6v1Yj=s46kQ@mail.gmail.com>
Subject: Re: [PATCH 14/16] drm/amd/powerplay: allocate the struct
 amdgpu_irq_src on the stack
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

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Since it is only several bytes in size.

I think the subject and description should be clarified a bit.  We are
not allocating it on the stack.  We are just moving the object to the
smu structure allocation rather than allocating it dynamically at
runtime.  We always allocate it anyway so no need to handle it
allocate it separately. With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: Ie9df0db543fdd4cf5b963a286ef40dee03c436bf
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  3 ---
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 15 +++------------
>  3 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 65f5edcaa405..23eb64ae7432 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1102,9 +1102,6 @@ static int smu_sw_fini(void *handle)
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
> index 5f5a210668a1..90bb61c159fb 100644
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
> index 5f3125ec5850..6c53488acd68 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1174,7 +1174,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>                 if (ret)
>                         return ret;
>
> -               ret = amdgpu_irq_get(adev, smu->irq_source, 0);
> +               ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
>                 if (ret)
>                         return ret;
>
> @@ -1198,7 +1198,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
>  {
> -       return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
> +       return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
>  }
>
>  static uint16_t convert_to_vddc(uint8_t vid)
> @@ -1615,18 +1615,9 @@ static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
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
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
