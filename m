Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E1ECE57E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B1610E6CA;
	Mon,  9 Sep 2024 21:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fD7NLq+Y";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B658D10E6CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:36:06 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-206b9ab5717so2623015ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917766; x=1726522566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjpiWjgwuc7BW6KLLhi6FskB2CZJtVXpwznxPWb49pU=;
 b=fD7NLq+YUbyRgOwKn6Rvztr//ZQq+GTcmPDi+U/kTR17hj3B+y7SEuPoBPY08J7kBX
 VX6C/SQT02dlEhcf+OqjFHf8lnIKPNzz4ivhvD1WG1j9HbZWe4dowjNRN/wYRwUbgUFe
 N/LJUey4auBahinvZEGWKJI9bXBv1Kee7OKn7SYedNz6P8MuYuqm7API4vs/KLuA+9WV
 o08dFEgfA1KOh/McceYRiqQ82UGMHBMcOYU1ReoAEIH58KXkXPNXltjxVHatxn5OYxGD
 cEXOFlknHhB4p5HsNsf4apWIbrilDMIPsscmZjGKxFm66BQPvIBfyCh0O1GQRDG8EGHL
 18zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917766; x=1726522566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjpiWjgwuc7BW6KLLhi6FskB2CZJtVXpwznxPWb49pU=;
 b=p3Y5XTRl7enihUeVeROHGyXgB3RGFVzdmSglOn8RQ54YyorK6FdR1w118zFSTtvJtG
 Ms5uEWaL5KoicZ7OJVzKcCJxr80uoNZJUfG0MR/d93jJ+2nfhjZ/H2wJ34aoP7vDkToE
 M8e/Xl18L2TrM3b96QvfD+d04ySZd/Tezz01w6vIoaUFJ3oFzX41dM2Quc5xxDJ1q713
 NvOLTXuvSdaWCniJG15Y6T3Tu5LcUnrgNI4i8PZriGokiFIFrUj7nVo/szWvP957U2gj
 Us6q6o5omTc69c/VoPspT5t7Nv6Wu3feT5XXzfb/qcpLEOrvBYE3cCgDcDh6xx9swRHv
 pRNQ==
X-Gm-Message-State: AOJu0Yw3mhrYEEuk7AlH9O7DGOwQYoQQ6Z/g62KJKdHQlzkzLLbow3N+
 9ZHhcfdl9DbGZNGwf8RxiiN08CHmcru+/xNA+VA0wYqswwFe/YSSsAf+oFAObbLleG5Fa51BJRE
 rsCqHtFgqUNSBy0Ltg4NTSj1nJXLOjg==
X-Google-Smtp-Source: AGHT+IGSJr7DWLZLSC6ksR2slomosgXlMf33QxdIT6x5OK/+8mQjexHwalRjpqE+UQCOs2ae9WlztTolzLKrcAfV8s8=
X-Received: by 2002:a17:902:d2d1:b0:205:8407:6307 with SMTP id
 d9443c01a7336-206f0652b08mr62153715ad.9.1725917765888; Mon, 09 Sep 2024
 14:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-7-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-7-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:35:54 -0400
Message-ID: <CADnq5_OH3_HM6w+UByQOd81FYkvCU7L3-gxuKEPiZgePyOEkoQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm/amdgpu: Refactor XGMI reset on init handling
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Use XGMI hive information to rely on resetting XGMI devices on
> initialization rather than using mgpu structure. mgpu structure may have
> other devices as well.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  6 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 72 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 +++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  5 ++
>  6 files changed, 90 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 468c4f590183..9f33de7ab656 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -155,7 +155,8 @@ struct amdgpu_init_level amdgpu_init_minimal =3D {
>         .level =3D AMDGPU_INIT_LEVEL_MINIMAL,
>         .hwini_ip_block_mask =3D
>                 BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
> -               BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
> +               BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)=
 |
> +               BIT(AMD_IP_BLOCK_TYPE_PSP)
>  };
>
>  static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
> @@ -2832,6 +2833,7 @@ static int amdgpu_device_init_schedulers(struct amd=
gpu_device *adev)
>   */
>  static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  {
> +       bool init_badpage;
>         int i, r;
>
>         r =3D amdgpu_ras_init(adev);
> @@ -2945,7 +2947,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>          * Note: theoretically, this should be called before all vram all=
ocations
>          * to protect retired page from abusing
>          */
> -       r =3D amdgpu_ras_recovery_init(adev, true);
> +       init_badpage =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MI=
NIMAL);
> +       r =3D amdgpu_ras_recovery_init(adev, init_badpage);
>         if (r)
>                 goto init_failed;
>
> @@ -4501,8 +4504,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_p=
m_domain);
>
>         if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
> -               queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wo=
rk,
> -                                  msecs_to_jiffies(AMDGPU_RESUME_MS));
> +               amdgpu_xgmi_reset_on_init(adev);
>
>         amdgpu_device_check_iommu_direct_map(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 65c891b6b999..2c29f4c34e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3216,12 +3216,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device =
*adev, bool init_bp_info)
>         max_eeprom_records_count =3D amdgpu_ras_eeprom_max_record_count(&=
con->eeprom_control);
>         amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
>
> -       /* Todo: During test the SMU might fail to read the eeprom throug=
h I2C
> -        * when the GPU is pending on XGMI reset during probe time
> -        * (Mostly after second bus reset), skip it now
> -        */
> -       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
> -               return 0;
>         if (init_bp_info) {
>                 ret =3D amdgpu_ras_init_badpage_info(adev);
>                 if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index a7a892512cb9..6a473a4262f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -860,8 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>         if (!adev->gmc.xgmi.supported)
>                 return 0;
>
> -       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
> -           amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 ret =3D psp_xgmi_initialize(&adev->psp, false, true);
>                 if (ret) {
>                         dev_err(adev->dev,
> @@ -907,8 +906,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>
>         task_barrier_add_task(&hive->tb);
>
> -       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
> -           amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgm=
i.head) {
>                         /* update node list for other device in the hive =
*/
>                         if (tmp_adev !=3D adev) {
> @@ -985,7 +983,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>                 }
>         }
>
> -       if (!ret && (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL=
))
> +       if (!ret)
>                 ret =3D amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>
>  exit_unlock:
> @@ -1500,3 +1498,67 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *=
adev)
>
>         return 0;
>  }
> +
> +static void amdgpu_xgmi_roi_handler(struct work_struct *work)

Use consistent naming for roi, depending on what you decide in the
earlier patches.  Other than that:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +{
> +       struct amdgpu_hive_info *hive =3D
> +               container_of(work, struct amdgpu_hive_info, roi_work);
> +       struct amdgpu_reset_context reset_context;
> +       struct amdgpu_device *tmp_adev;
> +       struct list_head device_list;
> +       int r;
> +
> +       mutex_lock(&hive->hive_lock);
> +
> +       INIT_LIST_HEAD(&device_list);
> +       list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
> +               list_add_tail(&tmp_adev->reset_list, &device_list);
> +
> +       tmp_adev =3D list_first_entry(&device_list, struct amdgpu_device,
> +                                   reset_list);
> +       amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +
> +       reset_context.method =3D AMD_RESET_METHOD_ON_INIT;
> +       reset_context.reset_req_dev =3D tmp_adev;
> +       reset_context.hive =3D hive;
> +       reset_context.reset_device_list =3D &device_list;
> +       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +       set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
> +
> +       amdgpu_reset_xgmi_rst_on_init(&reset_context);
> +       mutex_unlock(&hive->hive_lock);
> +       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
> +
> +       list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) =
{
> +               r =3D amdgpu_ras_init_badpage_info(tmp_adev);
> +               if (r && r !=3D -EHWPOISON)
> +                       dev_err(tmp_adev->dev,
> +                               "error during bad page data initializtion=
");
> +       }
> +}
> +
> +static void amdgpu_xgmi_schedule_reset_on_init(struct amdgpu_hive_info *=
hive)
> +{
> +       INIT_WORK(&hive->roi_work, amdgpu_xgmi_roi_handler);
> +       amdgpu_reset_domain_schedule(hive->reset_domain, &hive->roi_work)=
;
> +}
> +
> +int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_hive_info *hive;
> +       int r, num_devs;
> +
> +       hive =3D amdgpu_get_xgmi_hive(adev);
> +       if (!hive)
> +               return -EINVAL;
> +
> +       mutex_lock(&hive->hive_lock);
> +       num_devs =3D atomic_read(&hive->number_devices);
> +       if (num_devs =3D=3D adev->gmc.xgmi.num_physical_nodes)
> +               amdgpu_xgmi_schedule_reset_on_init(hive);
> +
> +       mutex_unlock(&hive->hive_lock);
> +       amdgpu_put_xgmi_hive(hive);
> +
> +       return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.h
> index a3bfc16de6d4..902c2f928653 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -45,6 +45,7 @@ struct amdgpu_hive_info {
>         struct amdgpu_reset_domain *reset_domain;
>         atomic_t ras_recovery;
>         struct ras_event_manager event_mgr;
> +       struct work_struct roi_work;
>  };
>
>  struct amdgpu_pcs_ras_field {
> @@ -75,5 +76,6 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_=
device *adev,
>                 adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);
>  }
>  int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
> +int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index c76ac0dfe572..bc30bc3b7851 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2413,11 +2413,17 @@ static int gmc_v9_0_hw_fini(void *handle)
>         if (adev->mmhub.funcs->update_power_gating)
>                 adev->mmhub.funcs->update_power_gating(adev, false);
>
> -       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +       /*
> +        * For minimal init, late_init is not called, hence VM fault/RAS =
irqs
> +        * are not enabled.
> +        */
> +       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) {
> +               amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> -       if (adev->gmc.ecc_irq.funcs &&
> -               amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> -               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +               if (adev->gmc.ecc_irq.funcs &&
> +                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +                       amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 8d16dacdc172..7901b3fbc127 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1295,7 +1295,12 @@ static int soc15_common_hw_fini(void *handle)
>         if (amdgpu_sriov_vf(adev))
>                 xgpu_ai_mailbox_put_irq(adev);
>
> +       /*
> +        * For minimal init, late_init is not called, hence RAS irqs are =
not
> +        * enabled.
> +        */
>         if ((!amdgpu_sriov_vf(adev)) &&
> +           (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
>             adev->nbio.ras_if &&
>             amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>                 if (adev->nbio.ras &&
> --
> 2.25.1
>
