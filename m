Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA6C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C7B64E61
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C7B64E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA9888420;
	Tue, 23 Feb 2021 16:47:13 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041DD89688
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 16:47:12 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id l5so4004019ooj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=axwbOXUnAuPhXyEjRjZSPVqraDeM7Dho04A/0S+t9Ig=;
 b=WUdr+TWvc12+YUHeaYxENtI62DPV+bJKkJ8mWHQGva7a1wGX5KP92dIt7PWb9noLFr
 B3VzvYF6sWbb1ZNKZ1usSfHB6g0PJoE0M7vmkLUUP2CW6Xi5zdaEIltAIRv8mOuHHHEu
 tTERDHnSYo+H6yTdNnbvI3LfO0lbtDXiSkXr5JgzQ6koxBigm1T5Qh7ES8eAWNofte1z
 e1C+pI1ndxT3GFKjFpJnUFkA48Q00i7aC+JqqBXWyqOtrUL7TJ5Rk5vwqTvMBhzwnz8f
 qHi2WGSMD+KF0o9QFJFL19HhAgnI5XmFOSpncn0w804mpke74lYDOiBOVLQGHY9z9ooO
 Dm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=axwbOXUnAuPhXyEjRjZSPVqraDeM7Dho04A/0S+t9Ig=;
 b=laF6VJAf6G1870k/vIg/agaVHo6TYNw1Cysj5sq7D3grtbkctyrqlTYG7Mt2IPos8U
 OVOD7lS7yhXFHoFah6x66nRI2zc9jvDJbvORAhQYkSJYXPs1u1E2DjzDeQkgD5vZvf/n
 MGHeYlA0TxpQ9Z28jTlbyjVwaVtpryB4t9KzigGzPK2qrvmPvf4YVlPTPZygiXuxv+JI
 wMsFAJvrVZBJ1huYJUXBBN23jzEhnO+PFurYWRmT5eV4XqrL5ubdqDOtrl+/bxuirpDD
 qw2vEeHv5BuAk9N5xJU7zaGhn/uZTcnClN4DOByaLiP3Y0f2oycqz50PDvZrMKQPxWNW
 1ksQ==
X-Gm-Message-State: AOAM531zCpp6PA8kbtYOOj1otCxwNyfqjw6gI8Il0XX+vZivE1EVtMP+
 YuUJ/kJTnPLyp4ULg8sZG+QEbt1QHbOdr6/y4dU=
X-Google-Smtp-Source: ABdhPJz16KuKbiaVqHHhMo+m7N+ugBluQfuPpkm7oj8YaTGubneATxEnSvSYWtioyGFgJvQ15AOxYmbz2cmqhAEaBP4=
X-Received: by 2002:a4a:d155:: with SMTP id o21mr20372889oor.72.1614098831224; 
 Tue, 23 Feb 2021 08:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20210219011846.28413-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011846.28413-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 11:47:00 -0500
Message-ID: <CADnq5_O=oTMZse8k9iWp+5PDO4R9KK8_uiFy2rY2dbnm-N4HOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
To: shaoyunl <shaoyun.liu@amd.com>
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

On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices
> without sync to each other. This could cause device hang since for XGMI configuration, all the devices
> within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue
> by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't
> do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init
> to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing
> gpu_recovery routine.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
>  4 files changed, 87 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f9ad7ed82be..9f574fd151bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>                 }
>         }
>
> +       /* Don't post if we need to reset whole hive on init */
> +       if (adev->gmc.xgmi.pending_reset)
> +               return false;
> +
>         if (adev->has_hw_reset) {
>                 adev->has_hw_reset = false;
>                 return true;
> @@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>                         if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>                                 continue;
>
> +                       if (!adev->ip_blocks[i].status.sw)
> +                               continue;
> +
>                         /* no need to do the fw loading again if already done*/
>                         if (adev->ip_blocks[i].status.hw == true)
>                                 break;
> @@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>
>         if (adev->gmc.xgmi.num_physical_nodes > 1)
>                 amdgpu_xgmi_add_device(adev);
> -       amdgpu_amdkfd_device_init(adev);
> +
> +       /* Don't init kfd if whole hive need to be reset during init */
> +       if (!adev->gmc.xgmi.pending_reset)
> +               amdgpu_amdkfd_device_init(adev);
>
>         amdgpu_fru_get_product_info(adev);
>
> @@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                         adev->ip_blocks[i].status.hw = false;
>                         continue;
>                 }
> +
> +               /* skip unnecessary suspend if we do not initialize them yet */
> +               if (adev->gmc.xgmi.pending_reset &&
> +                   !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
> +                       adev->ip_blocks[i].status.hw = false;
> +                       continue;
> +               }
>                 /* XXX handle errors */
>                 r = adev->ip_blocks[i].version->funcs->suspend(adev);
>                 /* XXX handle errors */
> @@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          *  E.g., driver was not cleanly unloaded previously, etc.
>          */
>         if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
> -               r = amdgpu_asic_reset(adev);
> -               if (r) {
> -                       dev_err(adev->dev, "asic reset on init failed\n");
> -                       goto failed;
> +               if (adev->gmc.xgmi.num_physical_nodes) {
> +                       dev_info(adev->dev, "Pending hive reset.\n");
> +                       adev->gmc.xgmi.pending_reset = true;
> +                       /* Only need to init necessary block for SMU to handle the reset */
> +                       for (i = 0; i < adev->num_ip_blocks; i++) {
> +                               if (!adev->ip_blocks[i].status.valid)
> +                                       continue;
> +                               if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> +                                       DRM_DEBUG("IP %s disabed for hw_init.\n",
> +                                               adev->ip_blocks[i].version->funcs->name);
> +                                       adev->ip_blocks[i].status.hw = true;
> +                               }
> +                       }
> +               } else {
> +                       r = amdgpu_asic_reset(adev);
> +                       if (r) {
> +                               dev_err(adev->dev, "asic reset on init failed\n");
> +                               goto failed;
> +                       }
>                 }
>         }
>
> @@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* enable clockgating, etc. after ib tests, etc. since some blocks require
>          * explicit gating rather than handling it automatically.
>          */
> -       r = amdgpu_device_ip_late_init(adev);
> -       if (r) {
> -               dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> -               amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> -               goto failed;
> +       if (!adev->gmc.xgmi.pending_reset) {
> +               r = amdgpu_device_ip_late_init(adev);
> +               if (r) {
> +                       dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> +                       amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> +                       goto failed;
> +               }
> +               /* must succeed. */
> +               amdgpu_ras_resume(adev);
> +               queue_delayed_work(system_wq, &adev->delayed_init_work,
> +                                  msecs_to_jiffies(AMDGPU_RESUME_MS));
>         }
>
> -       /* must succeed. */
> -       amdgpu_ras_resume(adev);
> -
> -       queue_delayed_work(system_wq, &adev->delayed_init_work,
> -                          msecs_to_jiffies(AMDGPU_RESUME_MS));
> -
>         if (amdgpu_sriov_vf(adev))
>                 flush_delayed_work(&adev->delayed_init_work);
>
> @@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (amdgpu_device_cache_pci_state(adev->pdev))
>                 pci_restore_state(pdev);
>
> +       if (adev->gmc.xgmi.pending_reset) {
> +               struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
> +
> +               if (atomic_read(&hive->number_devices) ==
> +                   adev->gmc.xgmi.num_physical_nodes) {
> +                       /* Trigger hive reset when all gpus within the hive is ready */
> +                       dev_info(adev->dev, "Trigger XGMI reset during init.\n");
> +                       amdgpu_device_gpu_recover(adev, NULL);
> +               }
> +               amdgpu_put_xgmi_hive(hive);
> +       }
> +
>         return 0;
>
>  failed:
> @@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>         int i, r = 0;
>         bool need_full_reset  = *need_full_reset_arg;
>
> -       amdgpu_debugfs_wait_dump(adev);
> +       /* no need to dump if device is not in good state during probe period */
> +       if (!adev->gmc.xgmi.pending_reset)
> +               amdgpu_debugfs_wait_dump(adev);
>
>         if (amdgpu_sriov_vf(adev)) {
>                 /* stop the data exchange thread */
> @@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>                 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>                         /* For XGMI run all resets in parallel to speed up the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> +                               tmp_adev->gmc.xgmi.pending_reset = false;
>                                 if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>                                         r = -EALREADY;
>                         } else
> @@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>         list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>                 if (need_full_reset) {
>                         /* post card */
> -                       if (amdgpu_device_asic_init(tmp_adev))
> +                       r = amdgpu_device_asic_init(tmp_adev);
> +                       if (r) {
>                                 dev_warn(tmp_adev->dev, "asic atom init failed!");
> -
> -                       if (!r) {
> +                       } else {
>                                 dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>                                 r = amdgpu_device_ip_resume_phase1(tmp_adev);
>                                 if (r)
> @@ -4790,6 +4844,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 if (audio_suspended)
>                         amdgpu_device_resume_display_audio(tmp_adev);
>                 amdgpu_device_unlock_adev(tmp_adev);
> +               /*enable buffer function after reset */

Space between * and comment, e.g., /* Enable

> +               amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);

Will this cause issues with any of the other flows through this code?

>         }
>
>  skip_recovery:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index aa0c83776ce0..8c71d84a2fbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>         struct list_head head;
>         bool supported;
>         struct ras_common_if *ras_if;
> +       bool pending_reset;
>  };
>
>  struct amdgpu_gmc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 839917eb7bc3..5e127a59b121 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
>                 goto failed;
>         }
>
> +       /*Don't do the real PSP HW init if we are pending on XGMI reset.
> +        *The above init probably should move to psp_sw_init
> +        */

Space between * and comment.  E.g., /* Don't

This whole thing seems kind of fragile.  Is there some way we can
restructure the init code to provide two code high level code paths?
One for regular init and one for this case?  I feel like this will be
prone to breakage if this code sees any changes.

Alex


> +       if (adev->gmc.xgmi.pending_reset)
> +               return 0;
> +
>  skip_memalloc:
>         ret = psp_hw_start(psp);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 659b385b27b5..b1c8fd90c1b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>         if (!adev->gmc.xgmi.supported)
>                 return 0;
>
> -       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (!adev->gmc.xgmi.pending_reset &&
> +           amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 ret = psp_xgmi_initialize(&adev->psp);
>                 if (ret) {
>                         dev_err(adev->dev,
> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>
>         task_barrier_add_task(&hive->tb);
>
> -       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (!adev->gmc.xgmi.pending_reset &&
> +           amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>                         /* update node list for other device in the hive */
>                         if (tmp_adev != adev) {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
