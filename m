Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA209C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863D320661
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrjAE8Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863D320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B746E2A5;
	Thu,  6 Feb 2020 02:53:13 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0480E6E2A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:53:11 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a9so5188248wmj.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 18:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iTBaAe7EyzMwvYeSf00uN3lDYg73mL3mOHI8JqqWUCs=;
 b=RrjAE8NqgdJ8R6OMYEn/NpXdHLXJjVJPUHLnrnF2wQbsUJCYSAQarQ64GuMEbvbO5E
 bqJxFhY8Tih/lq48Vk3lAtNazOKN8E1GaGCIiMFheqZ+yhckZZjDcoX37JE7mu0z7TJy
 +pht85GryBN3NEvdaD1VESmGinT7j73UKIx4tySOOjCJNwC+Do1ga4EBZox+enNQgZ35
 Dd7pKnfR/pNGqDpjVAzIoznMSSTLatu3O//RiJj+DRtfxsOBLboyWMgbY2/OZj7E+Cyg
 JHClgVQsxixCv/Bh3d63f1ix11oyDlHgd3uQtwCH3T2wT1puJiGCS6CN8E9ZilqyOgBv
 915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iTBaAe7EyzMwvYeSf00uN3lDYg73mL3mOHI8JqqWUCs=;
 b=N3tngVVJBbx7ps9vyNVey9NLXc0zRm2tmf4qBZSfKw0l5YSPcBuhF39LfIaSzQ6QIM
 8T2ob/0k9ArH1tLN6V5+T8yrcHpmAPTfk6KmLlHXdRz6Q/Y+3fT5OVdorCBgp1chJz3q
 JIb1FocNDQT4/fosQghUdxqaeUkelrNXxS+9zUs3QDOv9ebM9JTTb2/ecy5yS1IzAPpU
 aFk7tp6l1+N3w+1Jk+rFAYF0swySNo5U7Dxp7I44mUPqDV7EEx1dNGKk74ARiXA1OiPA
 o+ZNwHV5AoPH4jkXm0CA0Qcx6++bXoS4zhoHFom9DScF9OXiQ5Vl7f+wb8SlR1l0/S3a
 2yhA==
X-Gm-Message-State: APjAAAW7sDNFORJVZuH8HXCAxu5fqamw/1Hp8duZmGLAwGXz4easCSWu
 B8Q/iipsHnmUpzRcAbA1rrhKbJeYke2VpxsNLGg=
X-Google-Smtp-Source: APXvYqxqonyV+OnhXoHEJdElAkD2LucAjilTAeDB/A1WzHkV/jb16QehaFu34/xsgXBlkN1pFXA6uWPa9HKUpKGM1kc=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr1127349wmg.39.1580957590618; 
 Wed, 05 Feb 2020 18:53:10 -0800 (PST)
MIME-Version: 1.0
References: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2020 21:52:59 -0500
Message-ID: <CADnq5_MbCUGjMywtWMf58e2FJb9SxLfPz=J+DVzR9OJMz1QOsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
To: Jack Zhang <Jack.Zhang1@amd.com>
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

On Wed, Feb 5, 2020 at 4:18 AM Jack Zhang <Jack.Zhang1@amd.com> wrote:
>
> For sriov and pp_onevf_mode, do not send message to set smu
> status, becasue smu doesn't support these messages under VF.

Typo: becasue -> because
With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Besides, it should skip smu_suspend when pp_onevf_mode is disabled.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 21 +++++++++++++--------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4ff7ce3..2d1f8d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2353,15 +2353,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                 }
>                 adev->ip_blocks[i].status.hw = false;
>                 /* handle putting the SMC in the appropriate state */
> -               if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
> -                       r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
> -                       if (r) {
> -                               DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
> -                                         adev->mp1_state, r);
> -                               return r;
> +               if(!amdgpu_sriov_vf(adev)){
> +                       if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
> +                               r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
> +                               if (r) {
> +                                       DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
> +                                                       adev->mp1_state, r);
> +                                       return r;
> +                               }
>                         }
>                 }
> -
>                 adev->ip_blocks[i].status.hw = false;
>         }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 99ad4dd..a6d7b5f 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1461,21 +1461,26 @@ static int smu_suspend(void *handle)
>         struct smu_context *smu = &adev->smu;
>         bool baco_feature_is_enabled = false;
>
> +       if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +               return 0;
> +
>         if (!smu->pm_enabled)
>                 return 0;
>
>         if(!smu->is_apu)
>                 baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
>
> -       ret = smu_system_features_control(smu, false);
> -       if (ret)
> -               return ret;
> -
> -       if (baco_feature_is_enabled) {
> -               ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> -               if (ret) {
> -                       pr_warn("set BACO feature enabled failed, return %d\n", ret);
> +       if(!amdgpu_sriov_vf(adev)) {
> +               ret = smu_system_features_control(smu, false);
> +               if (ret)
>                         return ret;
> +
> +               if (baco_feature_is_enabled) {
> +                       ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> +                       if (ret) {
> +                               pr_warn("set BACO feature enabled failed, return %d\n", ret);
> +                               return ret;
> +                       }
>                 }
>         }
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
