Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 17:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58319208D5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 17:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueq3Sx0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58319208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3126E9FA;
	Wed, 17 Jun 2020 17:40:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E256E9FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 17:40:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t13so826363wrs.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=63cN0m61X8b9N+4yp6ILdvxaKksaON8Wc9AsnJeypO4=;
 b=ueq3Sx0mFHjFhFlTPYWMick+m38TAAqjKbCH6Ety+MfJafteYuI4vjOzQyzh76z/uX
 Wm+lMZvLBt0wvwghOuqEE7dB4vp67VrPCYvAtOPBc9/tyfqjReY+I5+CrOjQoqdQz0gf
 0ru5U59g2+S1/iRkuRH6xGiQHbE7pEKoYsJvCIza1e9Kl+mju5++R7FGoV705y+ArHMj
 kzYdpWVFsUku6CiLIbKQW4TMam1HDUhx8ilOvKjYgVZbwhI0lfwHVPZXk3GFuJSpMJ0q
 lhzAyBnf8xo34S5QhU6EVE2AOFrHFPvbhWRH8HUzRbaUWQoDPBwidECzxF0IXaC5SqXP
 OPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=63cN0m61X8b9N+4yp6ILdvxaKksaON8Wc9AsnJeypO4=;
 b=lIC/MgmgqcHNMg3DBiPovQtOqrv5GLWD7ilYTe3rPETXXQFmjRm7h09GszbI4FniqT
 4ZXWVwcXt2twOCj9LB/8fMNVu63PNdczRea2YNBndrIF97EpT/CHAWhZWhsaNIR6u9ri
 wPKcBULLSwmuiwqfqA4AcTFj/t944eZ4cQ3cpA+uZhuY9MM0GTTCx31etGrfd0KON24D
 /O0i64FfXwVuew+Vja1v7CgIsI7ywSNliOk+1aTh7UL5w/xsby461DCJN8LAM0m0GVhs
 ABcW0aKMUmmcnp75+i1BNSO1/tV5xEZ/j4oDjnZ5Oqwmcwe9+00lFU4rMfr6ycSKkEPh
 Bh1w==
X-Gm-Message-State: AOAM530L5Sg0PrZuv1fPmwvII6YMiNkPDuO+FKHwjao5RG3s+YxTy09n
 A/2OmjGaNPoV7C8F4OLEUpHbGJsWGHgUHjkuZUQ=
X-Google-Smtp-Source: ABdhPJx0GYcj5A0/nQSoMsp10/CBx47C7DDsbpVFp/aigZ2mnF7PH09b18Vu3p7nPpVe3dugi6fTOTpKPv3IQI0C7tI=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr375067wrq.362.1592415620116; 
 Wed, 17 Jun 2020 10:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200617071631.7274-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200617071631.7274-1-pmenzel@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2020 13:40:09 -0400
Message-ID: <CADnq5_O+ciZU7YnmWA=f3yi4J8y7kDN+gZxgxPwosjM1JtxUBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Warn about disabled DPM
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 17, 2020 at 3:34 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Currently, besides there is no explicit message, that DPM is disabled.
> The user would need to know, that the missing success line is an
> indicator.
>
>     [drm] amdgpu: dpm initialized
>
> So, add an explicit message, and make it log level warning, as disabling
> dpm is not the default.
>
> Resolves: https://gitlab.freedesktop.org/drm/amd/-/issues/1173
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> index 4b3faaccecb9..071215e8039a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> @@ -3014,8 +3014,10 @@ static int kv_dpm_sw_init(void *handle)
>         adev->pm.current_mclk = adev->clock.default_mclk;
>         adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
>
> -       if (amdgpu_dpm == 0)
> +       if (amdgpu_dpm == 0) {
> +               DRM_WARN("amdgpu: dpm disabled\n");
>                 return 0;
> +       }
>
>         INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
>         mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index c00ba4b23c9a..6af89587f80c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -7687,8 +7687,10 @@ static int si_dpm_sw_init(void *handle)
>         adev->pm.current_mclk = adev->clock.default_mclk;
>         adev->pm.int_thermal_type = THERMAL_TYPE_NONE;
>
> -       if (amdgpu_dpm == 0)
> +       if (amdgpu_dpm == 0) {
> +               DRM_INFO("amdgpu: dpm disabled\n");

These should both be WARN or both be INFO for consistency.  Also,
please use dev_info or dev_warn rather than the old DRM macros.  They
provide better information when multiple GPUs are present.

Thanks,

Alex

>                 return 0;
> +       }
>
>         ret = si_dpm_init_microcode(adev);
>         if (ret)
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
