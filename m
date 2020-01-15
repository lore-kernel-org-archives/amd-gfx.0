Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092CC33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 19:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5995A2084D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKBwsjCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5995A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEC56EA8B;
	Wed, 15 Jan 2020 19:48:51 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118B66EA8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 19:48:49 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p17so1299477wmb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ssstW0tJVNykfvidtDQ/2m8fl9k6ksen+IAO8cSqBM=;
 b=bKBwsjCkfYHFgo7wV3qtLQnDg7xmC/92/H+9K2meTa5bLn0KrQqFVO6utiJ6qjIbPh
 W3RRvWsBVoKpGAk45Zvxd68JkSnVhv489LIbu/LjbQ2ECf4HlHQEJofiuMJKC3XXew6p
 HFYK+BMkvN3mNtRObnk53mLhzVHc5LDrS/TjiySGGnSBRGvn8S8N42yLajQGsEBpo0Pu
 kEHEh14JqfNAKWu5coUNwBEKY0dPVTYqdghoGxi0Iwhc1ax4VAz7sximubcRVCZIwI+Q
 zeRmFyFrOpwYMqipLTnLae/BDBvuKTWA6ZTfLuFdcwyYMXu2LrXt2O+i27dGfyjMLsLD
 h/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ssstW0tJVNykfvidtDQ/2m8fl9k6ksen+IAO8cSqBM=;
 b=LFdCjBQL0y4WQHUvWSlrL5Aji/BL6Vk/ghYstBjlQADMAU+zuhbj/ECdjlucXCFYNs
 WxHdY0RD70e92Oly54xFgDSnRu4arebwEgRTQ9pIADm7jyNE7Lrd8V5yKR4IACukbomo
 JFhVIwq5TPjTg7s6RToF7DKVrJmF7MTAshi8ozwI15JdREy+Px3O10Q2PACWazRCzu+w
 LBymKlwHAmZNuGkTTefiz3joRdFFXGJ1/eIV02Syfqf9xpP+wg2G+6M3jPtWcY+EHZXm
 /ZAmLlw4ThPFdDkPDnMgKTMOny/c4TALrnM4UnYMCTmhhPq4eUGWPe6fVU0hv8GvgRvw
 YKvw==
X-Gm-Message-State: APjAAAVVNF3VpnEQIapEF6Rrlh94ts6QfYSdCpORWmjksRagmD8LqhI7
 IqrrwvHDKPWzXO43WYgxrc0mhCmwTMKL245f3fEdzw==
X-Google-Smtp-Source: APXvYqzzH3QB+jy5PXnB5W0IbCh3QcaQyNNi+ncyTLzC8nqWNEr6R6kYoii14fNImFUWSTvRykTwR0bmXat1sOE2v5o=
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr1813654wmp.30.1579117727712; 
 Wed, 15 Jan 2020 11:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20200115092054.13453-1-evan.quan@amd.com>
In-Reply-To: <20200115092054.13453-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2020 14:48:35 -0500
Message-ID: <CADnq5_MH-BvvSyfscWo3=U3LVcFXZo_mRnCMjXNooq9s9q23jA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: a quick fix for the deadlock issue
 below
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
Cc: Rui.Teng@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 4:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> NFO: task ocltst:2028 blocked for more than 120 seconds.
>      Tainted: G           OE     5.0.0-37-generic #40~18.04.1-Ubuntu
> echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> cltst          D    0  2028   2026 0x00000000
> all Trace:
> __schedule+0x2c0/0x870
> schedule+0x2c/0x70
> schedule_preempt_disabled+0xe/0x10
> __mutex_lock.isra.9+0x26d/0x4e0
> __mutex_lock_slowpath+0x13/0x20
> ? __mutex_lock_slowpath+0x13/0x20
> mutex_lock+0x2f/0x40
> amdgpu_dpm_set_powergating_by_smu+0x64/0xe0 [amdgpu]
> gfx_v8_0_enable_gfx_static_mg_power_gating+0x3c/0x70 [amdgpu]
> gfx_v8_0_set_powergating_state+0x66/0x260 [amdgpu]
> amdgpu_device_ip_set_powergating_state+0x62/0xb0 [amdgpu]
> pp_dpm_force_performance_level+0xe7/0x100 [amdgpu]
> amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]
>
> This was introduced by "drm/amd/powerplay: cleanup the interfaces for
> powergate setting through SMU".
>
> Change-Id: I6ae2ed89d40a9475ae37b58e22108f4d6da974bb
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Rui Teng <Rui.Teng@amd.com>

Please add the description of the deadlock from the comment in the
code to the patch description as well.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 40 +++++++++++++++----------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index 6c7dca1da992..19a042cf673c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -946,23 +946,36 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>         bool swsmu = is_support_sw_smu(adev);
>
>         switch (block_type) {
> -       case AMD_IP_BLOCK_TYPE_GFX:
>         case AMD_IP_BLOCK_TYPE_UVD:
> -       case AMD_IP_BLOCK_TYPE_VCN:
>         case AMD_IP_BLOCK_TYPE_VCE:
> -       case AMD_IP_BLOCK_TYPE_SDMA:
>                 if (swsmu) {
>                         ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
> -               } else {
> -                       if (adev->powerplay.pp_funcs &&
> -                           adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -                               mutex_lock(&adev->pm.mutex);
> -                               ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> -                                       (adev)->powerplay.pp_handle, block_type, gate));
> -                               mutex_unlock(&adev->pm.mutex);
> -                       }
> +               } else if (adev->powerplay.pp_funcs &&
> +                          adev->powerplay.pp_funcs->set_powergating_by_smu) {
> +                       /*
> +                        * TODO: need a better lock mechanism
> +                        *
> +                        * Here adev->pm.mutex lock protection is enforced on
> +                        * UVD and VCE cases only. Since for other cases, there
> +                        * may be already lock protection in amdgpu_pm.c.
> +                        * This is a quick fix for the deadlock issue.
> +                        */
> +                       mutex_lock(&adev->pm.mutex);
> +                       ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> +                               (adev)->powerplay.pp_handle, block_type, gate));
> +                       mutex_unlock(&adev->pm.mutex);
>                 }
>                 break;
> +       case AMD_IP_BLOCK_TYPE_GFX:
> +       case AMD_IP_BLOCK_TYPE_VCN:
> +       case AMD_IP_BLOCK_TYPE_SDMA:
> +               if (swsmu)
> +                       ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
> +               else if (adev->powerplay.pp_funcs &&
> +                        adev->powerplay.pp_funcs->set_powergating_by_smu)
> +                       ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> +                               (adev)->powerplay.pp_handle, block_type, gate));
> +               break;
>         case AMD_IP_BLOCK_TYPE_JPEG:
>                 if (swsmu)
>                         ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
> @@ -970,12 +983,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_GMC:
>         case AMD_IP_BLOCK_TYPE_ACP:
>                 if (adev->powerplay.pp_funcs &&
> -                   adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -                       mutex_lock(&adev->pm.mutex);
> +                   adev->powerplay.pp_funcs->set_powergating_by_smu)
>                         ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
>                                 (adev)->powerplay.pp_handle, block_type, gate));
> -                       mutex_unlock(&adev->pm.mutex);
> -               }
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
