Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47755C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D615C60FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615C60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B9A6E0C1;
	Wed, 19 May 2021 02:12:52 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4606E0C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:12:50 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so10433705otp.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3mfjMSzl2YKpgrrdQYu6hTTv/zkxlegU5OcqaIT3DOU=;
 b=tmeJN5efv3D1fFitDrcx3BB/E5Ixg0Mxz0t1kLxlKVA8uNZprbB5skdIeccatSGZ0O
 KrUQBXJv243E6kQf4owRqAdQToBPZILCdBgYDRCOxzi2a/RoxD4E6JMB9rUQYSQyYjGj
 aXybNB03DLYXL20N1MVDRqNTL9VFwsFBNBGx9tTdfTBI9S6RZJ91fCYpED4xVcChQ5my
 juTCmcz1hHaSAzD0ckOBCR6Ll6cyJj5NQJek6YIKJ7TvSrV+aaLZqi+WqSdcLxxWzRC8
 Njn0Qy6xop8gFyOcb1UuWixTu0tuOjHIXdkFhskQMZTstzvLiki29rmzoHMubODJAxLW
 +4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3mfjMSzl2YKpgrrdQYu6hTTv/zkxlegU5OcqaIT3DOU=;
 b=aCnOTnZmAkO8Lf8oab3229bHAeqaF9JiDkbVJIlTzJsIKS2Li4w+3+DsvMgf3qicfD
 XTZRkTfGIGMkVAH5uVBS120mo+ZNsd2M7gKzyLnHaZcicMpjo7O5dBsHGVjdZLoFAlPM
 lgk9F0oWETKsofpiCZ+4Zumw9mKAykLro13bxnPmx/AuBq+d++M6cP7WVPNbB1WcmBiD
 RYAKCCCYmFqVZOH2WRXl7jwwD4X+ZgKmyb6m38wkit94+uMgnHMmuIJtlH/hmQ5sWdGM
 5QmnMisQehqVPl67tHVJeqBvuEeBrcUN6rSWCHkY59V2nPw8K+qlwtqAGiG7J4S7NgtG
 Dmjw==
X-Gm-Message-State: AOAM532BcHID/RP+yh8sWMu3DuYmhDXNd74GLosszzyrqFbo2ZK5GwIT
 SEfFS/Yy9vsvBEx77sKwRvOutCF3AsRliseMx4fWfJp9
X-Google-Smtp-Source: ABdhPJySSGaMkhFHXsLPLkD3fUXQwPpw8FvdxIAN+cnBNUQ8Ryl47/hMAwOy9KZ+jnELyD6k3XXOIqh32Nnp9L6arHM=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr6754654oti.23.1621390369938; 
 Tue, 18 May 2021 19:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020502.351803-1-evan.quan@amd.com>
 <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 22:12:39 -0400
Message-ID: <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do we need a similar check in the vega powerplay code?

Alex


On Mon, May 17, 2021 at 10:59 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Tuesday, May 18, 2021 10:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
>
> No MGpuFanBoost setting for those ASICs which do not support it.
> Otherwise, it may breaks their fan control feature.
>
> Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9 +++++++++
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index d2063b1e7936..f16c76038f13 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
>
>  static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)  {
> +       struct smu_table_context *table_context = &smu->smu_table;
> +       PPTable_t *smc_pptable = table_context->driver_pptable;
>         struct amdgpu_device *adev = smu->adev;
>         uint32_t param = 0;
>
> @@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>         if (adev->asic_type == CHIP_NAVI12)
>                 return 0;
>
> +       /*
> +        * Skip the MGpuFanBoost setting for those ASICs
> +        * which do not support it
> +        */
> +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> +               return 0;
> +
>         /* Workaround for WS SKU */
>         if (adev->pdev->device == 0x7312 &&
>             adev->pdev->revision == 0)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 3c3a7f9233e0..159cd698323e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3201,6 +3201,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>
>  static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)  {
> +       struct smu_table_context *table_context = &smu->smu_table;
> +       PPTable_t *smc_pptable = table_context->driver_pptable;
> +
> +       /*
> +        * Skip the MGpuFanBoost setting for those ASICs
> +        * which do not support it
> +        */
> +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> +               return 0;
> +
>         return smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetMGpuFanBoostLimitRpm,
>                                                0,
> --
> 2.29.0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
