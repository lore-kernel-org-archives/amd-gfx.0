Return-Path: <SRS0=l1g4=2Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E4C2D0C2
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 16:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EFD22B48
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p71kS71L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EFD22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9836E03D;
	Sat,  4 Jan 2020 16:56:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3679E6E03D
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2020 16:56:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d73so10893583wmd.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Jan 2020 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IragSPKEJzcx/VyNrnKNDe1wLmSE5YrZIBOjjL2/BUI=;
 b=p71kS71Lx3TeNl/+Nm/2TRGamQCXwDlEf87LWXXy0AeXooK//Il5u6a+KO3xhGVQBI
 qNwUtni35Iry9mUiChQTe318u726FUwF9dBmlq4AUpHW9fwZMJsnl7GzihkCM5mNiCg4
 /oSKrZnIVHcNpFtT0JeROs+WUcS2qHbKjAw7rSJAoQU8s6pA4MJb809ml0Spp2pswdHI
 v1qOTU8UYfZHpUcGchsAWzbicHNbGSU1uNv8UPuhA+D6WcvgrDt+fICEuE/u51DudaOi
 FN4i0XSPeFWf9WWcNgN3DB9T1WE72e7TPNjn/vuEFMc+l0iJYCYPryOdiVHDYig/wd9S
 /lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IragSPKEJzcx/VyNrnKNDe1wLmSE5YrZIBOjjL2/BUI=;
 b=nI+SebZtH0JBSTVIb6aLcFYtjJpE7rVB46JqW9ZF5DjsxvexvSeuMpPXf0k5cIXXqY
 Pg5JyQH/Qaix+6mR0RcIWf0CspQQSM315ZH9JKGqh9XuqAn2/Sn8W2CF81hfZpEQfoBP
 FyKayEemySFl927MAv+QftrwHpzusc7rWOZQuCcAzLouvRuBgxvr+9hqPhhIPVrSSRzs
 y4q9rMFealGMznEhKA+6Awg/E9uImi/iD2L+CEJKyxZcxvz8JAXrLLaOo3Xi2bk0wMZ0
 rpwcFK0PSqEtXhDcODB2+kXLqfmvKy1y4UPlCOreBIPS880VEkjDOxIEowI0FJ9ttsEb
 1mrg==
X-Gm-Message-State: APjAAAX04WUL8Rt305EP5vvLjNXPpzGP+iIcTtR2/TYqJfZhHhopNWMu
 urOpyBjul3GUJmjW3SuxPtgz4FuOUdkn2v2M2JfmBg==
X-Google-Smtp-Source: APXvYqzF3JZsdCpsqFCfrCuSRU2ewHFc+Viz+xi1mLr+he9aJlzIY2FQpBtIYCJcPiwe6cjyfzICfTbxNsNeOw7oyTA=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr24720017wmc.57.1578156977868; 
 Sat, 04 Jan 2020 08:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20200103094836.32505-1-evan.quan@amd.com>
In-Reply-To: <20200103094836.32505-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 4 Jan 2020 11:56:04 -0500
Message-ID: <CADnq5_NC_AM1dhmTjvx5uShJfQuc5H1EQpnBr3FF9fNK3oLPgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: refine code to support no-dpm case
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 3, 2020 at 4:48 AM Evan Quan <evan.quan@amd.com> wrote:
>
> With "dpm=0", there will be no DPM enabled. The code
> needs to be refined to support this.
>
> Change-Id: Ief1561e69a24472135e0499073a27ea5fd8174e2
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  5 ++++-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  6 ++++++
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 10 ++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index 7293763d524c..c195575366a3 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -927,9 +927,12 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
>  {
>         struct pp_hwmgr *hwmgr = handle;
>
> -       if (!hwmgr || !hwmgr->pm_en)
> +       if (!hwmgr)
>                 return -EINVAL;
>
> +       if (!hwmgr->pm_en)
> +               return 0;
> +
>         if (hwmgr->hwmgr_func->set_mp1_state)
>                 return hwmgr->hwmgr_func->set_mp1_state(hwmgr, mp1_state);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 96e3f0ee64d8..a56ebcc4e3c7 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1364,6 +1364,9 @@ static int smu_hw_fini(void *handle)
>                 smu_powergate_jpeg(&adev->smu, true);
>         }
>
> +       if (!smu->pm_enabled)
> +               return 0;
> +
>         if (!amdgpu_sriov_vf(adev)){
>                 ret = smu_stop_thermal_control(smu);
>                 if (ret) {
> @@ -1448,6 +1451,9 @@ static int smu_suspend(void *handle)
>         struct smu_context *smu = &adev->smu;
>         bool baco_feature_is_enabled = false;
>
> +       if (!smu->pm_enabled)
> +               return 0;
> +
>         if(!smu->is_apu)
>                 baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 064b5201a8a7..1c15c6fbe3b9 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2176,8 +2176,12 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
>  static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> +       struct smu_context *smu = &adev->smu;
>         int res;
>
> +       if (!smu->pm_enabled)
> +               return -EOPNOTSUPP;
> +
>         control->owner = THIS_MODULE;
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
> @@ -2193,6 +2197,12 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>
>  static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>  {
> +       struct amdgpu_device *adev = to_amdgpu_device(control);
> +       struct smu_context *smu = &adev->smu;
> +
> +       if (!smu->pm_enabled)
> +               return;
> +
>         i2c_del_adapter(control);
>  }
>
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
