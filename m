Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B70C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A113D2077D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH0UF64c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A113D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6837A6E5C1;
	Thu,  4 Jun 2020 20:58:48 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A9C6E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 20:58:46 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l11so7618733wru.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TwLA2s2zNoX3AI1diYckOJEnnKx4UnTg3y3Cu9ppfgQ=;
 b=DH0UF64ctazPbxrvRFiQGiDyIKPpr5ri3/fLdg4YpiyOgEVufHmPtyP095gzwePUvJ
 d035LJh/Lxjh1GjkczlVGlwak989cVJ09FOJ09HbVF4hjn7sbtGU0EM3XUWUV0LqjbEC
 94NkUimP800BBobSqXIgks37K8pNrviF9v/jy6wd6Buo6sy3pNgsDeWyQmkjQEjCKdV2
 ufndjmNQkorvb0YrcQrDAJUOwU1zAjxAzqZTcXMMgm8rQ0Ci9amd0YaLuSPuyYWC6T/T
 s5LmB4ITvwvn8VL8bFU5J3LKMDzYEFdevnP0AijpB8b2eVLuUG+yKjM8zQYXpb/uRcTt
 NnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TwLA2s2zNoX3AI1diYckOJEnnKx4UnTg3y3Cu9ppfgQ=;
 b=U5W+19ni3k4ZRE1oO3EUQI597YfX4ghQ6C2ZGJIdlznViuEY9+7SHZckQX+wGZvMQk
 01g0W3+SMC2L4iV3RYv7egeZZTAhW2O/GxfTa/OiSEzB1Z3ITFCs+XVyHOJ43KW4V3n1
 Ss2Dqmb6Z/RJzuRLZ8C/ErJ47xC3aCxhamHT7US+bPJ5QbyaqtoLgxaOgecESPKnIlVu
 +gsjSzxTiM8TZoVj6c3IfIqx7zgYHZxGfbjfnaEvspsXFH40jiO4q03+otsE3061JKt6
 GV7pbm+JlOxa61qEqlwBXtYZtLk9+vNNzjdIA6Ed5HJxYKWj+np1LszvmrQgJjWUe+te
 aqEA==
X-Gm-Message-State: AOAM531TJhq6Nek1GgAxuegAri6/vNqliZqii/idLLhCDQIMhY0ZXTKA
 UHBBi8zUQqalzTS/5qlZFetN3aKbnqX0jE3AApiGq6w/
X-Google-Smtp-Source: ABdhPJwkWAS4iQPoZ3CuWohuGt3LPS0jnl3aTijOWg6+hhkYmkV/cpb16CJmzz/znGakv3m4afCgGMqwQejfy6xeTxg=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr6053333wrq.362.1591304325417; 
 Thu, 04 Jun 2020 13:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-9-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-9-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 16:58:34 -0400
Message-ID: <CADnq5_M2wA_7EfLsa=c9FZDjp5+q80c1=p=oRo7Zj1Uck+Pyww@mail.gmail.com>
Subject: Re: [PATCH 09/16] drm/amd/powerplay: move those operations not needed
 for resume out
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
> Since smu_smc_table_hw_init() is needed for both .hw_init and .resume.
> By doing this, we can drop unnecessary operations on resume.
>
> Change-Id: I2af6277efaa9adba2de69161e20e54c4aa10a411
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 40 +++++++++++-----------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 78fb2b42fc93..3bd6b9a5b63c 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1130,25 +1130,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       if (initialize) {
> -               /* get boot_values from vbios to set revision, gfxclk, and etc. */
> -               ret = smu_get_vbios_bootup_values(smu);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_setup_pptable(smu);
> -               if (ret)
> -                       return ret;
> -
> -               /*
> -                * Send msg GetDriverIfVersion to check if the return value is equal
> -                * with DRIVER_IF_VERSION of smc header.
> -                */
> -               ret = smu_check_fw_version(smu);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         ret = smu_set_driver_table_location(smu);
>         if (ret)
>                 return ret;
> @@ -1236,10 +1217,20 @@ static int smu_start_smc_engine(struct smu_context *smu)
>
>         if (smu->ppt_funcs->check_fw_status) {
>                 ret = smu->ppt_funcs->check_fw_status(smu);
> -               if (ret)
> +               if (ret) {
>                         pr_err("SMC is not ready\n");
> +                       return ret;
> +               }
>         }
>
> +       /*
> +        * Send msg GetDriverIfVersion to check if the return value is equal
> +        * with DRIVER_IF_VERSION of smc header.
> +        */
> +       ret = smu_check_fw_version(smu);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> @@ -1268,6 +1259,15 @@ static int smu_hw_init(void *handle)
>         if (!smu->pm_enabled)
>                 return 0;
>
> +       /* get boot_values from vbios to set revision, gfxclk, and etc. */
> +       ret = smu_get_vbios_bootup_values(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_setup_pptable(smu);
> +       if (ret)
> +               return ret;
> +
>         ret = smu_feature_init_dpm(smu);
>         if (ret)
>                 goto failed;
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
