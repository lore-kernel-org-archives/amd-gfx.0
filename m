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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E82C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D4E205CB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8yxMkFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D4E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059D36EA08;
	Fri, 22 May 2020 15:16:26 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73126EA08
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 15:16:24 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id l11so10566412wru.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q0KdNJzs7Oj+hnBltfkrE4fKVkqnyfB6cuxEyxQw4xA=;
 b=i8yxMkFKPs7cKnXv71CmDvGrTWTd2EM7sClNnpXCb7e0XZGxAtbKRvhF9KGF+QHdjz
 00iY+Df/E1h0MkxUY1zgoPppsf1/EfJBBiDt6SiffQNXtnYYFW6f8MaqJkfpEFc57SYx
 ryJzX2ObUSnwKphwS+gtqPu8rCsYIytDzgksNXTo8StPBN1ERlY0OQyCMqcJoDnDFI2n
 /8x23+yb92K88GxkX9uDJe13WXTE355LzwEupqp0Ozj5njf3TmPk4rj9Oky/5H5l8UPu
 1ACDnNMLvB6eWTcDnRCYFySk03oOpfCq2T2Kpb6k5DFHJc5H4l196D0U9Y+XhUMfltyZ
 MLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q0KdNJzs7Oj+hnBltfkrE4fKVkqnyfB6cuxEyxQw4xA=;
 b=AjivrtR9+/UOwx3EcvwOXLLWWSVXJJ31QktP9qVWe325ZBOiWESKr0B8VXZ1M8V3FH
 /YrpuepYqK+CQiN0k/5gODkU++R9TaadaT33zkYFLp6rM40vYY6404upgIDyw2QOpxd8
 V4c2/dWq582yxquoyNJV4l5x9K/zbBTqprTVGh7psUdVeCQcRcnCk2p+gxcgSPyg9Nbc
 DYRnN/jV1uS2mmkTErg3n86unWG5+JadaHLiFEh/ucnH0MyWOJ2YVJT0GJ5M2T1QznmQ
 FaESgfQHslZ9NUQIJ9tWJuYdCaaY+N7EZNHiefry22nmYsTBwHbNrDZC2THafirFMugt
 61jw==
X-Gm-Message-State: AOAM531HykuIlsu29rcqYnw2pZxMgbVLtdm2/oyMXFEcCSmNU3ANPRTr
 2aFJZzNb3drHzluzzAYss8AKyMQzfKzBpDRJmaM=
X-Google-Smtp-Source: ABdhPJxWZ+oIxsc1yhQN/DfS7hlnb+Hw7H10Es8tTsk+bJlpWZ69FYpfGweGZAm73cneuIqaCZZOFgJrhNVQh4jbvbo=
X-Received: by 2002:adf:9264:: with SMTP id 91mr3731240wrj.362.1590160583288; 
 Fri, 22 May 2020 08:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145758.13348-1-kevin1.wang@amd.com>
In-Reply-To: <20200522145758.13348-1-kevin1.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 11:16:11 -0400
Message-ID: <CADnq5_NxA08DUs_3OXj1Qp3fV_0s30i9TerqH=URcrh0PAQ2-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix device attribute node create failed with
 multi gpu
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

On Fri, May 22, 2020 at 10:57 AM Kevin Wang <kevin1.wang@amd.com> wrote:
>
> the origin design will use varible of "attr->states" to save node
> supported states on current gpu device, but for multi gpu device, when
> probe second gpu device, the driver will check attribute node states
> from previous gpu device wthether to create attribute node.
> it will cause other gpu device create attribute node faild.
>
> 1. add member attr_list into amdgpu_device to link supported device attribute node.
> 2. add new structure "struct amdgpu_device_attr_entry{}" to track device attribute state.
>
> fix:
> drm/amdgpu: optimize amdgpu device attribute code
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 +++++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h | 13 +++--
>  3 files changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bfce0931f9c1..b84146339ea3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -995,6 +995,7 @@ struct amdgpu_device {
>         char                            serial[16];
>
>         struct amdgpu_autodump          autodump;
> +       struct list_head                attr_list;

Might want to call this pm_attr_list or even move this to the
amdgpu_pm struct, but either way, assuming you've tested this with
multiple GPUs:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  };
>
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 55815b899942..ac99aa0a16a8 100644
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
> @@ -1794,22 +1794,24 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
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
> +       list_add_tail(&attr_entry->entry, &adev->attr_list);
>
>         return ret;
>  }
> @@ -1827,14 +1836,12 @@ static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_
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
> @@ -1852,20 +1859,24 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
>         return 0;
>
>  failed:
> -       while (i--)
> -               amdgpu_device_attr_remove(adev, &attrs[i]);
> +       amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
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
> +       if (list_empty(&adev->attr_list))
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
> @@ -3276,6 +3287,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>         if (adev->pm.dpm_enabled == 0)
>                 return 0;
>
> +       INIT_LIST_HEAD(&adev->attr_list);
> +
>         adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>                                                                    DRIVER_NAME, adev,
>                                                                    hwmon_groups);
> @@ -3319,9 +3332,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> -       amdgpu_device_attr_remove_groups(adev,
> -                                        amdgpu_device_attrs,
> -                                        ARRAY_SIZE(amdgpu_device_attrs));
> +       amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
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
