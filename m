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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E9C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8420206E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI9ObQlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8420206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7B46E5C8;
	Thu,  4 Jun 2020 21:15:28 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D6A6E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 21:15:27 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id q19so7650546eja.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7jYt3PQwDFzvuTblloMkGQAsy1Fr8UAR/xsXwx5jq0=;
 b=WI9ObQlZsxG458u0VHTArPCgq8wPX7IIlKuzSmQzvpng+TcS0I0JUD7pqKI8ZyhXmb
 5tkRRLS6Dz4DMRbVk3gyh0try/KrqLrYSjdJr3+ppkh9ElEr0HkfBt8c7RmUAmd6HBWq
 k2JbXNxSTxWRxmxIe17GcjsNOudO7KkQz+tToXc/ph61Vg9kpFGdyX2RFPNAkkZgk2CD
 b3/tpzmCGKyUDa0zCL+qZggz97is8SeJN4ZYhFhi2F0VRO+dh0Z5RJL5drQ9cKNfgmg3
 LkPEAxBiKiMexsc7JrgWirSVLAiOBUgVXVSCniz1S01aI5TZoUR9giOArtz/Ryfk7wXa
 Rl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7jYt3PQwDFzvuTblloMkGQAsy1Fr8UAR/xsXwx5jq0=;
 b=ouw1iRx0cU/JGqUqtk7zFHEjVkVtqoS1oD+fh8RTEz+GPI3F7d5ydx/MUNIVvpSmEk
 hBuIbd5dGQMsQGwzErC1YSlcRnRmNYLkP7SVLTMYwPmx5MVj5Vz/qezsgHonyI11hyZ4
 TH9BGKPgDjphResq6jb+1gHzRNPMybKwGAwVpHAQ63FYXCPpYOnltU6fh2pm41Y+ICKq
 8YNiqtXWL1FZzFt1mLAJvZBOx0sZzoJvg1prxfpIo0iiombkzHJlMktto4SCsaZDCibJ
 S6ZHtCZ/OgtL/rhJEoAa2gnprbMcwG25xSwQOu5O35uSTVYZih4v2XYz90W25llXb9fP
 2DWw==
X-Gm-Message-State: AOAM5315Mp2vPK/tS3CMXoESKL09xr+hDp9KzO4OX29Hxbr40ZEEex0H
 a6HwbnLT0eHpTPYUWvGZpGYUkp7F0Lkso5Jgb5iHmjOr
X-Google-Smtp-Source: ABdhPJxXTPy+iOxKHIjqY2X8qi22+vllK2ZYvs6LTssK+4C/N4NfXr4pbclTckRMRo553C51WldXmrEgsUeMCGfb6ls=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr6081550wrq.362.1591304832438; 
 Thu, 04 Jun 2020 14:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-12-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-12-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 17:07:01 -0400
Message-ID: <CADnq5_OpT1bxmF-F52fN0gTMffRL49m_-Ln28JuLkCmXsdxBsA@mail.gmail.com>
Subject: Re: [PATCH 12/16] drm/amd/powerplay: better namings
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
> And some minor changes as dropping unused parameter and label
> internal used API as static.
>
> Change-Id: I0af0aea029dc4fc7d8e150ab6ec984e9a5f1a74a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 12 +++++-------
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 --
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b3410d111316..55ffbf1cf086 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -638,7 +638,7 @@ int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
>         return ret;
>  }
>
> -int smu_feature_init_dpm(struct smu_context *smu)
> +static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
>         int ret = 0;
> @@ -662,7 +662,6 @@ int smu_feature_init_dpm(struct smu_context *smu)
>         return ret;
>  }
>
> -
>  int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
> @@ -1115,8 +1114,7 @@ static int smu_sw_fini(void *handle)
>         return 0;
>  }
>
> -static int smu_smc_table_hw_init(struct smu_context *smu,
> -                                bool initialize)
> +static int smu_internal_hw_setup(struct smu_context *smu)

The "internal" in the name made me think this was related to someting
in smu_internal.h.  Maybe call it smu_smc_hw_setup()?  I guess I could
go either way.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret;
> @@ -1287,11 +1285,11 @@ static int smu_hw_init(void *handle)
>         if (ret)
>                 return ret;
>
> -       ret = smu_feature_init_dpm(smu);
> +       ret = smu_get_driver_allowed_feature_mask(smu);
>         if (ret)
>                 goto failed;
>
> -       ret = smu_smc_table_hw_init(smu, true);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
>                 goto failed;
>
> @@ -1487,7 +1485,7 @@ static int smu_resume(void *handle)
>                 goto failed;
>         }
>
> -       ret = smu_smc_table_hw_init(smu, false);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
>                 goto failed;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index b2de042493ad..5f5a210668a1 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -656,8 +656,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
>  extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
>  extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
>
> -extern int smu_feature_init_dpm(struct smu_context *smu);
> -
>  extern int smu_feature_is_enabled(struct smu_context *smu,
>                                   enum smu_feature_mask mask);
>  extern int smu_feature_set_enabled(struct smu_context *smu,
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
