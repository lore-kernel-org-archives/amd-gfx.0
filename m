Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF498C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8417920772
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXCAdHPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8417920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4131989C5E;
	Wed,  3 Jun 2020 13:51:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC9289C5E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 13:51:22 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y17so2443222wrn.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jun 2020 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6UCDAOPst/9fPUt6iaYZyNmi3bC52LA+oveCLbM4bEM=;
 b=gXCAdHPZSr5pUAbGZRbv1h/vDa6M4n05KOtTwMOhnqFBQdj9vRDVPxxtHp8fytMejI
 lbxaEGer2jcqX/BSCnaLYoX1OSmER12BQhgMApIskA5afDI4TI0WLsKkgrKVHIklwKS2
 05XVmptdiWLmdWe3J1c4Xd2LBTQjUcqx75tSfKyGDm6XZ+oeROH9Hg0/R/cD/k2woRkN
 xS91dq8KD+AGF6wuQrb/0W7zoS8xQZZoa9b7PD59QRkyjnOnvOTND+HUpRYqrBn3bMVs
 xBgahx5lF35ja6AygUjSc3GTKmCBqVRZRLViTSN4hRondLXbDjY/bqKgs8hS6+tz9YfV
 6t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UCDAOPst/9fPUt6iaYZyNmi3bC52LA+oveCLbM4bEM=;
 b=QAEclONIyoqDZ915Dnjt0QPoNh4EHxIBHytN+wcac7W4zuZB4Nx8pCQdhfUxe0hPOf
 NJCFAkyCY4E1ZHRel6zNYHsHbBdoxfdYUqUA6ZjSZyFAMCeLmIdCCcZNWNpRJMOPNoMN
 A5yX4t3ER/Ch+RTPgMpe+aPo9wAX7i9gBSYUWmMo6WqGnYETUh/t1sd0ay9MHTPcXkoH
 Jfmr9QWmAYmF0qp/Gso1v8R8jdsrzJmwExOJYCF4A3xfwVtUCZWUfhAF54DnzS/GIH9y
 98IKFkSChAPw6qwbHzkmqpKrYGDay0xjcc8HS12V8B6/1eCEWzgSyotg11XaYyllLBrN
 NIPQ==
X-Gm-Message-State: AOAM531V+BdWNC89vfLpFMWoWnSdbvtxwrkbFSC8DDALAhY786JHEyrd
 z8JimawWFDjNU/S/hC296u+qcWl1b/5Zj7/h3q0=
X-Google-Smtp-Source: ABdhPJw2LO0uObFYK4z6JyRmKVz5v82+1qrvunwcuVf0cvXZnIcLDieutCpmoxHNc0gjabGVmB2xbkJesVXxQvDhro8=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr30481553wrq.362.1591192281338; 
 Wed, 03 Jun 2020 06:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200603050327.16680-1-evan.quan@amd.com>
In-Reply-To: <20200603050327.16680-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jun 2020 09:51:10 -0400
Message-ID: <CADnq5_PbvFucKVs0KEo4usov2anbfVaDv5RogUWRXDNPQMi18A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: use work queue to perform throttling
 logging
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

On Wed, Jun 3, 2020 at 1:03 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As IO operations(access to SMU internals) and possible sleep are
> involved in throttling logging. Workqueue can handle them well.
> Otherwise we may hit "scheduling while atomic" error.
>
> Change-Id: I454d593e965e54b13fdf04c112abb0a022204278
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 10 ++++++++++
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 ++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 342fd75b0806..e25a3b1ce7ac 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1053,6 +1053,14 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
>         return 0;
>  }
>
> +static void smu_throttling_logging_work_fn(struct work_struct *work)
> +{
> +       struct smu_context *smu = container_of(work, struct smu_context,
> +                                              throttling_logging_work);
> +
> +       smu_log_thermal_throttling(smu);
> +}
> +
>  static int smu_sw_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1074,6 +1082,7 @@ static int smu_sw_init(void *handle)
>         spin_lock_init(&smu->metrics_lock);
>         spin_lock_init(&smu->message_lock);
>
> +       INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
>         smu->watermarks_bitmap = 0;
>         smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> @@ -1295,6 +1304,7 @@ static int smu_internal_hw_cleanup(struct smu_context *smu)
>
>         smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
>
> +       cancel_work_sync(&smu->throttling_logging_work);
>         ret = smu_disable_thermal_alert(smu);
>         if (ret) {
>                 pr_warn("Fail to stop thermal control!\n");
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 6f44ffb6eb51..b970b4d663b0 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -411,6 +411,8 @@ struct smu_context
>
>         bool uploading_custom_pp_table;
>         bool dc_controlled_by_gpio;
> +
> +       struct work_struct throttling_logging_work;
>  };
>
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index adde9eb7b283..69b1160d8ba2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1597,7 +1597,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                                         return 0;
>
>                                 if (__ratelimit(&adev->throttling_logging_rs))
> -                                       smu_log_thermal_throttling(smu);
> +                                       schedule_work(&smu->throttling_logging_work);
>
>                                 break;
>                         }
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
