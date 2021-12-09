Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D73C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 19:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A201A10E295;
	Thu,  9 Dec 2021 19:59:58 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1B010E295
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 19:59:57 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 e17-20020a4a8291000000b002c5ee0645e7so1931607oog.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cjBven+10v96Fdrx5oTYyhF8txHwUBDpu8peJFL2fjI=;
 b=NlyXlIurBhFuHsDH7beSGX6yeqUFEc/1lHVuc5eBm7yEoABXnIjP/0zfeVcRecgt9N
 hY7Z/6OTkRv/WOxA6fl91x11LBD7yDjpKIKp2xmL2FLUCSMGkACs9MMwHJiKLOA5f8XL
 i8jfa/vHcUwaaWp3itMRCoGjyo6QJ/b372ac0ltmy9T3vBufNWkQJmb3WmAQuQ/011s2
 NpTD2aQHSHMzX17D1ZsFlhJZP09PsdbgeXudGJnB/uk6eRMttC1+FF5TZFt1GqdVmJMF
 tSWe0qlbXtTHSwpmzSkg+TLiUl3vDOOP3S6BaXNyR5QOPWAruk2uE1q24DvLnrPJoPwr
 RP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cjBven+10v96Fdrx5oTYyhF8txHwUBDpu8peJFL2fjI=;
 b=vLGAwcgZ6MPKrKT13S8BY8cmXh6/yJVyf1UhZmMhE5kXbLhE5gTmxuUUlju858kp9z
 CF4QN9d6N7cUprwnb7kthdxAJIrw+7Qq7+9ifLBmR1WBN0KELBlmyUN2/S8i++TRAzID
 eXgNtjJ3rx1jXqTWaNnDw/eq31kmTzDX01k7Qe6vyu6Q5w0W+QUVKLFC2c/dSWJ0xgRb
 Yf6nLBdu3fW0fBE/+ghiABXxcny5mLOSfzpzw4YC2H/VpuX2kOdT6puY7uR0/WrTKvwz
 90rgbqhRO2EJfe5QcdbpLsW4LobbeT4HpXeWePS752oiTT9TEklkjLOzSL2s6d0NW6V9
 oWqg==
X-Gm-Message-State: AOAM533dNsd7rv+QJYduEr1jC7gOXC1PTdy9gNqBG8qGf5kLUaavpaJG
 XjtvqvnMjoRkd4+bZqWFLpYGvjEf+mWaUyZrsdM=
X-Google-Smtp-Source: ABdhPJwezmJ/UlZTTvf6jyobLIlp7d37FUaBDfVEwp0qNawxivqx8WEXWAp+tvnUTRfXF5xg2yWpBnuQIpDyCPkPBlY=
X-Received: by 2002:a4a:8701:: with SMTP id z1mr5492422ooh.68.1639079996726;
 Thu, 09 Dec 2021 11:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20211209154715.20956-1-Philip.Yang@amd.com>
In-Reply-To: <20211209154715.20956-1-Philip.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Dec 2021 14:59:45 -0500
Message-ID: <CADnq5_Mh29hQR_dw_-6tv4M9qgp_sCGTbi2XxdhQ=2cutrGUMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Detect if amdgpu in IOMMU direct map
 mode
To: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 9, 2021 at 12:02 PM Philip Yang <Philip.Yang@amd.com> wrote:
>
> If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
> set adev->ram_is_direct_mapped flag which will be used to optimize
> memory usage for multi GPU mappings.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 54c882a6b433..0ec19c83a203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,8 @@ struct amdgpu_device {
>
>         struct amdgpu_reset_control     *reset_cntl;
>         uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
> +
> +       bool                            ram_is_direct_mapped;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce9bdef185c0..3318d92de8eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/console.h>
>  #include <linux/slab.h>
> +#include <linux/iommu.h>
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
> @@ -3381,6 +3382,22 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +/**
> + * amdgpu_device_check_iommu_direct_map - check if RAM direct mapped to GPU
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * RAM direct mapped to GPU if IOMMU is not enabled or is pass through mode
> + */
> +static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
> +{
> +       struct iommu_domain *domain;
> +
> +       domain = iommu_get_domain_for_dev(adev->dev);
> +       if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
> +               adev->ram_is_direct_mapped = true;
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] = {
>         &dev_attr_product_name.attr,
>         &dev_attr_product_number.attr,
> @@ -3784,6 +3801,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
>
> +       amdgpu_device_check_iommu_direct_map(adev);
> +
>         return 0;
>
>  release_ras_con:
> --
> 2.17.1
>
