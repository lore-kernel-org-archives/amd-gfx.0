Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F4C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2E3611CD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2E3611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC25897E0;
	Wed, 26 May 2021 13:04:21 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95114897E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:04:20 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so923175otl.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E7lnBn6gtlT4pHAbocCm3Lz5cROgKSEt1zW2UhsRNFI=;
 b=N4o2MbOkwX4N0r3k2gB3PeYsVMBzlC0IkDyQRWRTVQsw1mOl/XIieTQ4keLeUTN1gQ
 XIP9hXxS73gcjIQWU31mk82jnD0QMJbH3c3yNgsWL+PhRDRGxUz0Ie8X76StBC32uYKR
 ZKzS8intaS8Ef9YQHr5HEopT+GVDdHOv4tnzk8DptYhVolWvxka+5v1oomrM4A4/Qe+L
 F/LwOwyAhqNgfkIbcYilSndIMc0U6Hbnw20iD1wQTubi4O8cw75ykO/ZAqjOkxXqc6ET
 ojj4JGDjXqtpyFlW/8GPLYSAWWzWiA32SBogu6igBRUua9dQwUroj++4/KahOY5le48a
 fNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E7lnBn6gtlT4pHAbocCm3Lz5cROgKSEt1zW2UhsRNFI=;
 b=VJjKh5PHAZBh2XGdF0fm6NdDtnhTpwJpxkfMXcgensmVJRrKECa5LvLS6XA3K7Irw/
 AV86+mgmSF9xG/Gy0I+uKZ65IBXuZkeaJ8Y2wFfbZwbBo4CPnqUVQB8kqisoNkM8WDhQ
 1khqtiPashRyHpbR+MsegsiSynT6Rx6gxa4hiZItTxphuchmzQ+6+uzsfGZBN35vUdPf
 Yca8uI4E+dhnfAfoPmo9ixSPFdD8d9P80HHbpiS74K7x5St4bl6GqWFXnmVTosW7KvCT
 Z1EkI/Ei+B8Vghp5gwLHRS+K7TB1wc9XjN/W3C/DsIIX2eTbFOmDxYDf6sSIE6L3Z5n2
 aTTQ==
X-Gm-Message-State: AOAM533/wcNNr1xz35eaNcsm+qr6P2XJtf39qZWv2tCfyfsDeGlUHcqx
 CxNM2sapP5Vi9WnD0vuQD4vGiV1IfzJ+lchqCMU=
X-Google-Smtp-Source: ABdhPJyUTbGpxfBhXTVlkB+FThDSERlUlUmFQhLgidMk6hw9zImL9wcXdhPrSSNIrS7LUNzkRbGqn7lY3T+n80aANOc=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr2269164otl.311.1622034259946; 
 Wed, 26 May 2021 06:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210526080625.1210268-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210526080625.1210268-1-Xiaojian.Du@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 09:04:07 -0400
Message-ID: <CADnq5_PDMSye=Be98YpeGf5Vi_2Zr-N2byKuMtCvhzuuTwm9qg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: retain the fine grain tuning parameters after
 resume
To: Xiaojian Du <Xiaojian.Du@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Anatoli.Antonovitch@amd.com, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Pavan.Ramayanam@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 26, 2021 at 4:06 AM Xiaojian Du <Xiaojian.Du@amd.com> wrote:
>
> This patch is to retain the fine grain tuning parameters after resume for
> legacy APU, it will cover Raven/Raven2/Picasso.
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  3 ++-
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> index 25b5831a15cd..370deae7b054 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> @@ -82,7 +82,8 @@ int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)
>
>         /* Skip for suspend/resume case */
>         if (!hwmgr->pp_one_vf && smum_is_dpm_running(hwmgr)
> -           && !amdgpu_passthrough(adev) && adev->in_suspend) {
> +           && !amdgpu_passthrough(adev) && adev->in_suspend
> +               && !adev->apu_flags) {

Might be clearer to check (asic_type != CHIP_RAVEN) here rather than
apu_flags.  Makes it more clear what you are checking for.  With that
fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>                 pr_info("dpm has been enabled\n");
>                 return 0;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index f5fe540cd536..8f71f6a4bb49 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -377,6 +377,27 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
>
>  static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>  {
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
> +       int ret = -EINVAL;
> +
> +       if (adev->in_suspend) {
> +               pr_info("restore the fine grain parameters\n");
> +
> +               ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                                       PPSMC_MSG_SetHardMinGfxClk,
> +                                       smu10_data->gfx_actual_soft_min_freq,
> +                                       NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                                       PPSMC_MSG_SetSoftMaxGfxClk,
> +                                       smu10_data->gfx_actual_soft_max_freq,
> +                                       NULL);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
