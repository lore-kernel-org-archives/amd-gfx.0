Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4945C207FC
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbtczW/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4945C207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996FB6E497;
	Tue,  4 Aug 2020 16:57:42 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC576E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 16:57:41 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y3so38081454wrl.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aNUSjgTyDpduyMo5XV7HZHBvS7gMWnPrnqLjhAyC4lw=;
 b=kbtczW/j/rDtMJo/bf+/wSSdjmCQJlh+/GXKQ7wtJYper7HyrkvBOYT/7fs+vl9rGl
 PfCx7SYF3CYinElNMekxY+4MwXOjnavx7Gam/CxJt8sApiBu0My3qjI48glZZxai1nkf
 BTuZ/aiAFCGGtqoQMyaj7CiBeK+XibWMYivxevz2RIXJ0F5XcfZ40PPyhCdlcwX4mugZ
 F9gwtjZ4TYYTCXxDwE7JN5B4nc0aZjHEfdl5M36HHSNeCOXUWdj1nqnqCbkf8+ceIMnR
 Oe7ladOYM4KmnKaEyVAVWiO0zXsTQYHiyfrX7do78Csfq2VnGpvD9A/J8fqNVybYJNIk
 sPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aNUSjgTyDpduyMo5XV7HZHBvS7gMWnPrnqLjhAyC4lw=;
 b=cuQkpPIOBDjSd16/qm/NtTOr4MDIdS1k5J+0K654/OC45fDNYPP2qzt/F7yLx5jGUJ
 Krv1qZpXX2QLbgwU+eqb0qN40uigZsPthgs2RcjAatlp/oUNIOzBjjMrcBtqhws+NVGP
 vGR3ug2yHMNS+bJiaFLAc26q7PLwxKsAYWMyOnc0XJKfOqocjK1FZsm7//NpTR8VRRLA
 Tbk9KVQVsG3dIfaw7usIny2CptsJXEjrsXcElEE0DuUJWoQy+LrjlzgDnsBNyWEwapwp
 g8HPHImgRBDdCwUn+DkX6JuEzYhMLG8QQHNn0zamb0lgWVcBWrjqWjEe1YUnHVztEBdr
 ILQQ==
X-Gm-Message-State: AOAM533BkfWZSrtQySyPhBHxFst9VMLbTYa+QjU6Ov6mM/tSFmALXxSs
 /aKdXiyb7WpeMGptDvA97HFDVcBhu52LOfWhN2EKuA==
X-Google-Smtp-Source: ABdhPJyu90uIswk8d4aAGJVSg2POGbX435kvbkyg2F2LFyZ29m4n7vLs3mc4dh03PJ/AXtFelG25fs5P/JsgrSUTo9M=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr2903353wrs.419.1596560259751; 
 Tue, 04 Aug 2020 09:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200730192439.2005-1-alexander.deucher@amd.com>
In-Reply-To: <20200730192439.2005-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 12:57:28 -0400
Message-ID: <CADnq5_OO1GAAG+4qpHSoiHs7nFb54MNLz6tcBCfJCUzM6c5C2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu: rework i2c adpater registration
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?


On Thu, Jul 30, 2020 at 3:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> The i2c init/fini functions just register the i2c adapter.
> There is no need to call them during hw init/fini.  They only
> need to be called once per driver init/fini.  The previous
> behavior broke runtime pm because we unregistered the i2c
> adapter during suspend.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 12 ++++++------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 14 --------------
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 14 --------------
>  drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 14 --------------
>  4 files changed, 6 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 55463e7a11e2..d03b4852ed5f 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -579,6 +579,10 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       ret = smu_i2c_init(smu, &smu->adev->pm.smu_i2c);
> +       if (ret)
> +               return ret;
> +
>         return 0;
>  }
>
> @@ -586,6 +590,8 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
>  {
>         int ret;
>
> +       smu_i2c_fini(smu, &smu->adev->pm.smu_i2c);
> +
>         ret = smu_free_memory_pool(smu);
>         if (ret)
>                 return ret;
> @@ -845,10 +851,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>                 return ret;
>         }
>
> -       ret = smu_i2c_init(smu, &adev->pm.smu_i2c);
> -       if (ret)
> -               return ret;
> -
>         ret = smu_disable_umc_cdr_12gbps_workaround(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> @@ -1047,8 +1049,6 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0;
>
> -       smu_i2c_fini(smu, &adev->pm.smu_i2c);
> -
>         cancel_work_sync(&smu->throttling_logging_work);
>
>         ret = smu_disable_thermal_alert(smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index f13979687b9e..0147a5b9b06d 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2080,22 +2080,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
>         .functionality = arcturus_i2c_func,
>  };
>
> -static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
> -{
> -       struct amdgpu_device *adev = to_amdgpu_device(control);
> -
> -       return control->dev.parent == &adev->pdev->dev;
> -}
> -
>  static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         int res;
>
> -       /* smu_i2c_eeprom_init may be called twice in sriov */
> -       if (arcturus_i2c_adapter_is_added(control))
> -               return 0;
> -
>         control->owner = THIS_MODULE;
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
> @@ -2111,9 +2100,6 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
>
>  static void arcturus_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
>  {
> -       if (!arcturus_i2c_adapter_is_added(control))
> -               return;
> -
>         i2c_del_adapter(control);
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 6aaf483858a0..c33bdc6747f2 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2457,22 +2457,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
>         .functionality = navi10_i2c_func,
>  };
>
> -static bool navi10_i2c_adapter_is_added(struct i2c_adapter *control)
> -{
> -       struct amdgpu_device *adev = to_amdgpu_device(control);
> -
> -       return control->dev.parent == &adev->pdev->dev;
> -}
> -
>  static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         int res;
>
> -       /* smu_i2c_eeprom_init may be called twice in sriov */
> -       if (navi10_i2c_adapter_is_added(control))
> -               return 0;
> -
>         control->owner = THIS_MODULE;
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
> @@ -2488,9 +2477,6 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
>
>  static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
>  {
> -       if (!navi10_i2c_adapter_is_added(control))
> -               return;
> -
>         i2c_del_adapter(control);
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index f64a1be94cb8..f373e2d0d31c 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -2630,22 +2630,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
>         .functionality = sienna_cichlid_i2c_func,
>  };
>
> -static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapter *control)
> -{
> -       struct amdgpu_device *adev = to_amdgpu_device(control);
> -
> -       return control->dev.parent == &adev->pdev->dev;
> -}
> -
>  static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         int res;
>
> -       /* smu_i2c_eeprom_init may be called twice in sriov */
> -       if (sienna_cichlid_i2c_adapter_is_added(control))
> -               return 0;
> -
>         control->owner = THIS_MODULE;
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
> @@ -2661,9 +2650,6 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
>
>  static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
>  {
> -       if (!sienna_cichlid_i2c_adapter_is_added(control))
> -               return;
> -
>         i2c_del_adapter(control);
>  }
>
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
