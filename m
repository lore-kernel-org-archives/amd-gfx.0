Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B8C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7403920731
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peczO/0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7403920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376716E598;
	Mon,  6 Jan 2020 23:10:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179EE6E598
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 23:10:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d139so12931673wmd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VAG2RHI28VFw2xbkef7srwK+9lOknFdwWEep5+GifGE=;
 b=peczO/0omSvWNyctr/4UUIqyc6w/m9+Rgf829GhlLX+7UYGA/3mNRTCIklNBTbOGhX
 yYxUeDQ5Hls6dYF68t9TsdBv+uvHBb9F+JzbEPwvdJhJlCkF7QYgzO1KAMDYo+Pq8ygF
 bjg55fMsn1y2KGuA8ypeMQXUMMlObfLarW1Ee5GrqHnZKTxWHIUGLJ3UF3T8qAKCoDPr
 oRBK2NRPs/IJZ1r+kZNwlaD6MXO2D+5AYeWvRYGoVylZIwJdry9lNA5Tcck+Yx51mWVO
 VV7qjj/ykO6PfS1d8ln/qehNRPkSRq7sdiukAuIobve8yYqog0qT1W/rbBj/W/y2foTU
 a+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VAG2RHI28VFw2xbkef7srwK+9lOknFdwWEep5+GifGE=;
 b=kmpXsGvg+ZDvk+YkBDz+1uEs7rgCPYRzihePQMabOdRIRwDmg7FUo+5rDWyFCk7yZg
 Hvm9PxFg5fMGE5ZAgquhe/TEECxZ4L1qUbznAHhU7JIQOEmYUncaxSSZqVifOgdwlOZZ
 soFBpTnsIS+344Fymz9AUXW+rY4A1EjYSCWeblzyB346bskkBH3y21Wjfovj+6nmo+HR
 fM03emFh0651jMa+Pqc6U/mJScH2IwVQQ4RRJ2AMLk766sxFJfaFukgLLD5k54vw1j+5
 I/tkjjzsgcuLm50tdrvvPPIKBix6YiY91DxrC1TZtSDb5S8OO5fbd+0aKVVdce6m/KLu
 AsIA==
X-Gm-Message-State: APjAAAU7zsWwoKRkGfhBJOQsURLwlrlX5HYsvNQl4MxY1iwMY3sA5ksD
 AW9CPsOJaKL/OkLu5Yn3lSASXAXvne85epVug1U=
X-Google-Smtp-Source: APXvYqx3yxTuJe69oeFIO8RTZNVyhdyFnYr9CS6rI7RpGMMvHaiAquz2geHPhrAtDU8dPHdxOO00I2IFKui4zVLsabs=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr36528082wmq.65.1578352254638; 
 Mon, 06 Jan 2020 15:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20200103094639.32372-1-evan.quan@amd.com>
In-Reply-To: <20200103094639.32372-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2020 18:10:43 -0500
Message-ID: <CADnq5_ORLGdeEP7TTK+4tsQo6BOUBS3RjSk4gVJOCiCeSfC1Dw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: cleanup the interfaces for powergate
 setting through SMU
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

On Fri, Jan 3, 2020 at 4:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Provided an unified entry point. And fixed the confusing that the API
> usage is conflict with what the naming implies.

At some point it would be nice to unify the interfaces between
powerplay and swSMU so we don't seem all the is_sw_smu checks, but for
now,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: If068980ca6a7b223d0b4d087cd99cdeb729b0e77
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 23 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 43 ++++++++--------------
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  6 +--
>  3 files changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index 9cc270efee7c..cd76fbf4385d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -951,16 +951,31 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_VCN:
>         case AMD_IP_BLOCK_TYPE_VCE:
>         case AMD_IP_BLOCK_TYPE_SDMA:
> +               if (swsmu) {
> +                       ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
> +               } else {
> +                       if (adev->powerplay.pp_funcs &&
> +                           adev->powerplay.pp_funcs->set_powergating_by_smu) {
> +                               mutex_lock(&adev->pm.mutex);
> +                               ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> +                                       (adev)->powerplay.pp_handle, block_type, gate));
> +                               mutex_unlock(&adev->pm.mutex);
> +                       }
> +               }
> +               break;
> +       case AMD_IP_BLOCK_TYPE_JPEG:
>                 if (swsmu)
>                         ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
> -               else
> -                       ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> -                               (adev)->powerplay.pp_handle, block_type, gate));
>                 break;
>         case AMD_IP_BLOCK_TYPE_GMC:
>         case AMD_IP_BLOCK_TYPE_ACP:
> -               ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> +               if (adev->powerplay.pp_funcs &&
> +                   adev->powerplay.pp_funcs->set_powergating_by_smu) {
> +                       mutex_lock(&adev->pm.mutex);
> +                       ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
>                                 (adev)->powerplay.pp_handle, block_type, gate));
> +                       mutex_unlock(&adev->pm.mutex);
> +               }
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b32adda70bbc..285d460624c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -2762,17 +2762,12 @@ static void amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  {
>         int ret = 0;
> -       if (is_support_sw_smu(adev)) {
> -           ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_UVD, enable);
> -           if (ret)
> -               DRM_ERROR("[SW SMU]: dpm enable uvd failed, state = %s, ret = %d. \n",
> -                         enable ? "true" : "false", ret);
> -       } else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -               /* enable/disable UVD */
> -               mutex_lock(&adev->pm.mutex);
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> -               mutex_unlock(&adev->pm.mutex);
> -       }
> +
> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> +       if (ret)
> +               DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> +                         enable ? "enable" : "disable", ret);
> +
>         /* enable/disable Low Memory PState for UVD (4k videos) */
>         if (adev->asic_type == CHIP_STONEY &&
>                 adev->uvd.decode_image_width >= WIDTH_4K) {
> @@ -2789,17 +2784,11 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  {
>         int ret = 0;
> -       if (is_support_sw_smu(adev)) {
> -           ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_VCE, enable);
> -           if (ret)
> -               DRM_ERROR("[SW SMU]: dpm enable vce failed, state = %s, ret = %d. \n",
> -                         enable ? "true" : "false", ret);
> -       } else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -               /* enable/disable VCE */
> -               mutex_lock(&adev->pm.mutex);
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> -               mutex_unlock(&adev->pm.mutex);
> -       }
> +
> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> +       if (ret)
> +               DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> +                         enable ? "enable" : "disable", ret);
>  }
>
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> @@ -2818,12 +2807,10 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
>  {
>         int ret = 0;
>
> -       if (is_support_sw_smu(adev)) {
> -               ret = smu_dpm_set_power_gate(&adev->smu, AMD_IP_BLOCK_TYPE_JPEG, enable);
> -               if (ret)
> -                       DRM_ERROR("[SW SMU]: dpm enable jpeg failed, state = %s, ret = %d. \n",
> -                                 enable ? "true" : "false", ret);
> -       }
> +       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
> +       if (ret)
> +               DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
> +                         enable ? "enable" : "disable", ret);
>  }
>
>  int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index e1b64134bbd8..fabc46dfb933 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -433,10 +433,10 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>
>         switch (block_type) {
>         case AMD_IP_BLOCK_TYPE_UVD:
> -               ret = smu_dpm_set_uvd_enable(smu, gate);
> +               ret = smu_dpm_set_uvd_enable(smu, !gate);
>                 break;
>         case AMD_IP_BLOCK_TYPE_VCE:
> -               ret = smu_dpm_set_vce_enable(smu, gate);
> +               ret = smu_dpm_set_vce_enable(smu, !gate);
>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
>                 ret = smu_gfx_off_control(smu, gate);
> @@ -445,7 +445,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>                 ret = smu_powergate_sdma(smu, gate);
>                 break;
>         case AMD_IP_BLOCK_TYPE_JPEG:
> -               ret = smu_dpm_set_jpeg_enable(smu, gate);
> +               ret = smu_dpm_set_jpeg_enable(smu, !gate);
>                 break;
>         default:
>                 break;
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
