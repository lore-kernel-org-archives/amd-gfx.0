Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC1BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2199320663
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9breK7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2199320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1166E08A;
	Fri, 22 May 2020 15:58:07 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CEC6E08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 15:58:06 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id e1so10646331wrt.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4hwYz0zIqaQD2Be1MRIC+f7jcC7Ti+O4roK4IGs/KT8=;
 b=U9breK7gqxvWPJGsjfjd6FmSvh0c7g5TPddyNEVz8LeH0WsATAQ2DEIsrriecbze6j
 TCWIpXw/FxBq9M7K7HJtXoCZte4WYDDcXGZouCbxGwinHXtmBZxye0FVkBURbNhW0/Nc
 McrWjC4ks2NIsUdSO9fvMyuoNk4YZOMPtXV7I84uocaOggkzZFlawCl9MdJQYUtBe38e
 OqtrXyJgrTCm6373V0uJnnrK6nPSTMtTnZoNmp4KeGW8Xm3+S4Jbgn3d0JiBTt53bbRe
 uDzHs889j+eY1mr2aXh7fMDq6tgUcwBw4dgad9KeCgaTteaK0yMdMuED3QUMNrZ95ySl
 PeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4hwYz0zIqaQD2Be1MRIC+f7jcC7Ti+O4roK4IGs/KT8=;
 b=T2yk+AGjLKwV5J+nfoqqQrM2LQGK4/82uqKtEyx3/7WAAbFhmTgJe8UqARjnt7b0c2
 6FoUHEuN5d8dd6MCGW8kIgVwr3BbZBp7DjeFcXi47OAyDRxMWE2W3zNpFFHzOFxISD/8
 IWmE+Xmb/a3rmipQfQtCMEZAYiPepxK5QzVrIRmKajFSVsRlLigfEkFmdLFETpCJPr8L
 QnsvzcGwHFbwCyCsUpGAfJ5Ni7/polpDwPQta8FDRjB+PZu7De4M9nVQDsYDiKDmctP3
 MJ6ng2jJ0csSBjQVMoFBRxQlcu833lnToV8T6HHppvpiD43xZOjoKy2UJ99AVRcfiJwA
 7+pw==
X-Gm-Message-State: AOAM530jGoESnnWXK8zU4EEnWW2GW/qO/dEpkMGwPd9W15thd2eqCEmz
 YpyK3nQhA7n1NLPv/L0o48vva2lRlOmTB4keNfI=
X-Google-Smtp-Source: ABdhPJy1pRw6DE/3NJ+4utLh8kqPvWA3KAkn7+60V5nM8EZD7X3XYMknolh1w5GK2WR5g89Cb/y4URZNKlY3guUriDw=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr3876032wrr.111.1590163084606; 
 Fri, 22 May 2020 08:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200522154209.4866-1-kevin1.wang@amd.com>
In-Reply-To: <20200522154209.4866-1-kevin1.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 11:57:53 -0400
Message-ID: <CADnq5_OAPR02Ww4JQZjsz90xL_HqJLyMmPX1J38pnSduSyA9-Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix device attribute node create failed
 with multi gpu
To: Kevin Wang <kevin1.wang@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 22, 2020 at 11:41 AM Kevin Wang <kevin1.wang@amd.com> wrote:
>
> the origin design will use varible of "attr->states" to save node
> supported states on current gpu device, but for multi gpu device, when
> probe second gpu device, the driver will check attribute node states
> from previous gpu device wthether to create attribute node.
> it will cause other gpu device create attribute node faild.
>
> 1. add member attr_list into amdgpu_device to link supported device attribute node.
> 2. add new structure "struct amdgpu_device_attr_entry{}" to track device attribute state.
> 3. drop member "states" from amdgpu_device_attr.
>
> v2:
> 1. move "attr_list" into amdgpu_pm and rename to "pm_attr_list".
> 2. refine create & remove device node functions parameter.
>
> fix:
> drm/amdgpu: optimize amdgpu device attribute code
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Looks good.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 85 ++++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h  | 13 ++--
>  3 files changed, 58 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> index 956f6c710670..6a8aae70a0e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> @@ -450,6 +450,7 @@ struct amdgpu_pm {
>
>         /* Used for I2C access to various EEPROMs on relevant ASICs */
>         struct i2c_adapter smu_i2c;
> +       struct list_head        pm_attr_list;
>  };
>
>  #define R600_SSTU_DFLT                               0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 55815b899942..dd5be3bb4bb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1725,7 +1725,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  };
>
>  static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> -                              uint32_t mask)
> +                              uint32_t mask, enum amdgpu_device_attr_states *states)
>  {
>         struct device_attribute *dev_attr = &attr->dev_attr;
>         const char *attr_name = dev_attr->attr.name;
> @@ -1733,7 +1733,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>         enum amd_asic_type asic_type = adev->asic_type;
>
>         if (!(attr->flags & mask)) {
> -               attr->states = ATTR_STATE_UNSUPPORTED;
> +               *states = ATTR_STATE_UNSUPPORTED;
>                 return 0;
>         }
>
> @@ -1741,34 +1741,34 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>
>         if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>                 if (asic_type <= CHIP_VEGA10)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>                 if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (asic_type < CHIP_VEGA20)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
>                 if (asic_type == CHIP_ARCTURUS)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> -               attr->states = ATTR_STATE_UNSUPPORTED;
> +               *states = ATTR_STATE_UNSUPPORTED;
>                 if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>                     (!is_support_sw_smu(adev) && hwmgr->od_enabled))
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>                 if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pcie_bw)) {
>                 /* PCIe Perf counters won't work on APU nodes */
>                 if (adev->flags & AMD_IS_APU)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(unique_id)) {
>                 if (!adev->unique_id)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_features)) {
>                 if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
> -                       attr->states = ATTR_STATE_UNSUPPORTED;
> +                       *states = ATTR_STATE_UNSUPPORTED;
>         }
>
>         if (asic_type == CHIP_ARCTURUS) {
> @@ -1789,27 +1789,29 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>
>  static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>                                      struct amdgpu_device_attr *attr,
> -                                    uint32_t mask)
> +                                    uint32_t mask, struct list_head *attr_list)
>  {
>         int ret = 0;
>         struct device_attribute *dev_attr = &attr->dev_attr;
>         const char *name = dev_attr->attr.name;
> +       enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
> +       struct amdgpu_device_attr_entry *attr_entry;
> +
>         int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> -                          uint32_t mask) = default_attr_update;
> +                          uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
>
>         BUG_ON(!attr);
>
>         attr_update = attr->attr_update ? attr_update : default_attr_update;
>
> -       ret = attr_update(adev, attr, mask);
> +       ret = attr_update(adev, attr, mask, &attr_states);
>         if (ret) {
>                 dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
>                         name, ret);
>                 return ret;
>         }
>
> -       /* the attr->states maybe changed after call attr->attr_update function */
> -       if (attr->states == ATTR_STATE_UNSUPPORTED)
> +       if (attr_states == ATTR_STATE_UNSUPPORTED)
>                 return 0;
>
>         ret = device_create_file(adev->dev, dev_attr);
> @@ -1818,7 +1820,14 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>                         name, ret);
>         }
>
> -       attr->states = ATTR_STATE_SUPPORTED;
> +       attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
> +       if (!attr_entry)
> +               return -ENOMEM;
> +
> +       attr_entry->attr = attr;
> +       INIT_LIST_HEAD(&attr_entry->entry);
> +
> +       list_add_tail(&attr_entry->entry, attr_list);
>
>         return ret;
>  }
> @@ -1827,24 +1836,23 @@ static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_
>  {
>         struct device_attribute *dev_attr = &attr->dev_attr;
>
> -       if (attr->states == ATTR_STATE_UNSUPPORTED)
> -               return;
> -
>         device_remove_file(adev->dev, dev_attr);
> -
> -       attr->states = ATTR_STATE_UNSUPPORTED;
>  }
>
> +static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> +                                            struct list_head *attr_list);
> +
>  static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
>                                             struct amdgpu_device_attr *attrs,
>                                             uint32_t counts,
> -                                           uint32_t mask)
> +                                           uint32_t mask,
> +                                           struct list_head *attr_list)
>  {
>         int ret = 0;
>         uint32_t i = 0;
>
>         for (i = 0; i < counts; i++) {
> -               ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
> +               ret = amdgpu_device_attr_create(adev, &attrs[i], mask, attr_list);
>                 if (ret)
>                         goto failed;
>         }
> @@ -1852,20 +1860,24 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
>         return 0;
>
>  failed:
> -       while (i--)
> -               amdgpu_device_attr_remove(adev, &attrs[i]);
> +       amdgpu_device_attr_remove_groups(adev, attr_list);
>
>         return ret;
>  }
>
>  static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> -                                            struct amdgpu_device_attr *attrs,
> -                                            uint32_t counts)
> +                                            struct list_head *attr_list)
>  {
> -       uint32_t i = 0;
> +       struct amdgpu_device_attr_entry *entry, *entry_tmp;
>
> -       for (i = 0; i < counts; i++)
> -               amdgpu_device_attr_remove(adev, &attrs[i]);
> +       if (list_empty(attr_list))
> +               return ;
> +
> +       list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
> +               amdgpu_device_attr_remove(adev, entry->attr);
> +               list_del(&entry->entry);
> +               kfree(entry);
> +       }
>  }
>
>  static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
> @@ -3276,6 +3288,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>         if (adev->pm.dpm_enabled == 0)
>                 return 0;
>
> +       INIT_LIST_HEAD(&adev->pm.pm_attr_list);
> +
>         adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>                                                                    DRIVER_NAME, adev,
>                                                                    hwmon_groups);
> @@ -3302,7 +3316,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>         ret = amdgpu_device_attr_create_groups(adev,
>                                                amdgpu_device_attrs,
>                                                ARRAY_SIZE(amdgpu_device_attrs),
> -                                              mask);
> +                                              mask,
> +                                              &adev->pm.pm_attr_list);
>         if (ret)
>                 return ret;
>
> @@ -3319,9 +3334,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> -       amdgpu_device_attr_remove_groups(adev,
> -                                        amdgpu_device_attrs,
> -                                        ARRAY_SIZE(amdgpu_device_attrs));
> +       amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>
>  void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> index 48e8086baf33..d9ae2b49a402 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> @@ -47,10 +47,14 @@ enum amdgpu_device_attr_states {
>  struct amdgpu_device_attr {
>         struct device_attribute dev_attr;
>         enum amdgpu_device_attr_flags flags;
> -       enum amdgpu_device_attr_states states;
> -       int (*attr_update)(struct amdgpu_device *adev,
> -                          struct amdgpu_device_attr* attr,
> -                          uint32_t mask);
> +       int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +                          uint32_t mask, enum amdgpu_device_attr_states *states);
> +
> +};
> +
> +struct amdgpu_device_attr_entry {
> +       struct list_head entry;
> +       struct amdgpu_device_attr *attr;
>  };
>
>  #define to_amdgpu_device_attr(_dev_attr) \
> @@ -59,7 +63,6 @@ struct amdgpu_device_attr {
>  #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...) \
>         { .dev_attr = __ATTR(_name, _mode, _show, _store),              \
>           .flags = _flags,                                              \
> -         .states = ATTR_STATE_SUPPORTED,                                       \
>           ##__VA_ARGS__, }
>
>  #define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)                  \
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
