Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B845BC25B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 14:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C222310E110;
	Fri, 24 May 2024 14:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cUJ3id4g";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D1D10E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 14:40:07 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5238b5c07efso8500306e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716561606; x=1717166406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WH6KUlbPL+B3gQ9mCS2eVnURxTZb11LDTySySNvAbWI=;
 b=cUJ3id4gY5RgCJZd+w4UiLUwkT55xhE6b9lf5N4vbXTj/Gj4hoQkRGb2f0JRImISz2
 Yw4xrsiEUE+z0Hl6edeEQHBPu6rn4LXai0sVhc8QT0r0H9IdGbSoMy9BNwkzWNtpKI4p
 5P9h0un6WctqYyVA5hn2oBaR/UauMvZXL/+1go72G5JvSUax2zMrJ2okB8tCAx10YCNV
 m3CHz8HcRyrfnMrTv9qqR939rWknI8gUUkdpJKMo45514ln0gU/NnSZX4Sz15baLyVuO
 bSTe1XwScy63Ndf9s6vUxapgTKZoXgCMzWGunEn2//o2glxwPnizvHS82MQ+KX7eEALO
 oCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561606; x=1717166406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WH6KUlbPL+B3gQ9mCS2eVnURxTZb11LDTySySNvAbWI=;
 b=S2p5hUi9S1CDd9DDT5Vwx9y0IrOX1LIwvQtwT2oiAsVj+uIcesOvuhjMhd8bEDkD0I
 0g9KVK9TyR97OcEoRY1QvxHduM2LM+8aNtYGTgd65ZZjDWtUBL9Zn2OgaMAu49v50jct
 g65OaAHbIpJkgmNTaZYcFozr5nDQW2e1XFoNE5FBg0wePH2J563wcW8hS21qLmD0TJ1E
 866mtohLjTdx7gJ8ZedZ0iU7R0IkZwXJ082ntY8wY3C6eGhPmclj3iyF2UXYAcP8RV4X
 Je3sL+9mtd9ZZKHwMEaub2bRBFIzs+EOfCEnjS01Ma11ofopRJHcwNN3RmfYrtRhCsUn
 pS1g==
X-Gm-Message-State: AOJu0YwhEuSHrNYZHe06HqA6IGMTsDjhyzzBhLt17rsK8bcUbQdkCSLS
 KQQkerSUA15ktCQdDJby2kiWA+QVs3vh+eeQ+jklOQbM+GE/eDvByDpDGVcC
X-Google-Smtp-Source: AGHT+IHlAk+FfLD+q55UOb+YnFIJYiMFQLxnL/SgHVMzxHBlOz+qezpXX1RbRxjJ6LRupZZ3FyAvAA==
X-Received: by 2002:a05:6512:31ce:b0:51d:348b:80bb with SMTP id
 2adb3069b0e04-529666db64emr2030347e87.55.1716561605662; 
 Fri, 24 May 2024 07:40:05 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a090185sm1744162f8f.47.2024.05.24.07.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:40:05 -0700 (PDT)
Message-ID: <446d5066-42a9-4517-a3ff-86b51a30ef63@gmail.com>
Date: Fri, 24 May 2024 16:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: Refactor sysfs attr functions in AMDGPU
 for reusability
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20240523091840.714634-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240523091840.714634-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 23.05.24 um 11:18 schrieb Srinivasan Shanmugam:
> This commit refactors the sysfs attribute management functions
> (`amdgpu_device_attr_create`, `amdgpu_device_attr_remove`,
> `amdgpu_device_attr_create_groups`, `amdgpu_device_attr_remove_groups`)
> into `amdgpu_sysfs.c`, which were originally in `amdgpu_pm.c`. This
> change allows these functions to be reused by other modules like gfx,
> pm, etc.
>
> Additionally, the attribute update logic is now encapsulated in the
> `pm_update_sysfs_attr` function, which is located in amdgpu_pm.c. This
> function is specific to the pm module and is invoked by
> amdgpu_device_attr_create for each attribute before the attribute is
> created.
>
> The `amdgpu_device_attr_create_groups` function has also been updated to
> use `pm_update_syfs_attr`. This ensures that the attribute update logic
> is consistently applied to all attributes.
>
> This refactoring enhances the modularity and maintainability of the
> code. It also increases the reusability of the attribute management
> functions, allowing them to be used by multiple modules.
>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

While at it you could fix some minor coding style nits. See below.

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c | 112 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h |  99 ++++++++++++++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 150 +++++++---------------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h    |  59 ---------
>   5 files changed, 256 insertions(+), 167 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 1f6b56ec99f6..8c782e26dfcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -81,7 +81,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o
> +	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> +	amdgpu_sysfs.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
> new file mode 100644
> index 000000000000..bbdf3e8966d5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2017 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_dpm.h"
> +#include "amdgpu_drv.h"
> +#include "amdgpu_reset.h"
> +#include "amdgpu_sysfs.h"
> +#include "atom.h"
> +#include <linux/pci.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/nospec.h>
> +#include <linux/pm_runtime.h>
> +#include <asm/processor.h>
> +
> +int amdgpu_sysfs_attr_create(struct amdgpu_device *adev,
> +			     struct amdgpu_device_attr *attr,
> +			     u32 mask, struct list_head *attr_list)
> +{
> +	int ret;
> +	struct amdgpu_device_attr_entry *attr_entry;
> +	struct device_attribute *dev_attr;
> +	const char *name;

Please declare ret last here.

> +
> +	if (!attr)
> +		return -EINVAL;
> +
> +	dev_attr = &attr->dev_attr;
> +	name = dev_attr->attr.name;
> +
> +	ret = device_create_file(adev->dev, dev_attr);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
> +			name, ret);
> +	}
> +
> +	attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
> +	if (!attr_entry)
> +		return -ENOMEM;
> +
> +	attr_entry->attr = attr;
> +	INIT_LIST_HEAD(&attr_entry->entry);
> +
> +	list_add_tail(&attr_entry->entry, attr_list);
> +
> +	return ret;
> +}
> +
> +int amdgpu_sysfs_attr_create_groups(struct amdgpu_device *adev,
> +				    struct amdgpu_device_attr *attrs,
> +				    u32 counts, u32 mask,
> +				    struct list_head *attr_list)
> +{
> +	int ret = 0;
> +	u32 i = 0;

Don't initialize local variables.

Regards,
Christian.

> +
> +	for (i = 0; i < counts; i++) {
> +		ret = amdgpu_sysfs_attr_create(adev, &attrs[i], mask, attr_list);
> +		if (ret)
> +			goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	amdgpu_sysfs_attr_remove_groups(adev, attr_list);
> +
> +	return ret;
> +}
> +
> +void amdgpu_sysfs_attr_remove(struct amdgpu_device *adev, struct amdgpu_device_attr *attr)
> +{
> +	struct device_attribute *dev_attr = &attr->dev_attr;
> +
> +	device_remove_file(adev->dev, dev_attr);
> +}
> +
> +void amdgpu_sysfs_attr_remove_groups(struct amdgpu_device *adev,
> +				     struct list_head *attr_list)
> +{
> +	struct amdgpu_device_attr_entry *entry, *entry_tmp;
> +
> +	if (list_empty(attr_list))
> +		return;
> +
> +	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
> +		amdgpu_sysfs_attr_remove(adev, entry->attr);
> +		list_del(&entry->entry);
> +		kfree(entry);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h
> new file mode 100644
> index 000000000000..ab2fa7070941
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2014 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_SYSFS_H__
> +#define __AMDGPU_SYSFS_H__
> +
> +#define to_amdgpu_device_attr(_dev_attr) \
> +	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
> +
> +#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
> +	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
> +	  .flags = _flags,						\
> +	  ##__VA_ARGS__, }
> +
> +#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
> +	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
> +			     amdgpu_get_##_name, amdgpu_set_##_name,	\
> +			     _flags, ##__VA_ARGS__)
> +
> +#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
> +	AMDGPU_DEVICE_ATTR(_name, 0644,			\
> +			   _flags, ##__VA_ARGS__)
> +
> +#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
> +	__AMDGPU_DEVICE_ATTR(_name, 0444,				\
> +			     amdgpu_get_##_name, NULL,			\
> +			     _flags, ##__VA_ARGS__)
> +
> +#define AMDGPU_DEVICE_ATTR_WO(_name, _flags, ...)			\
> +	__AMDGPU_DEVICE_ATTR(_name, 0200,				\
> +			     NULL, amdgpu_set_##_name,			\
> +			     _flags, ##__VA_ARGS__)
> +
> +struct cg_flag_name {
> +	u64 flag;
> +	const char *name;
> +};
> +
> +enum amdgpu_device_attr_flags {
> +	ATTR_FLAG_BASIC = (1 << 0),
> +	ATTR_FLAG_ONEVF = (1 << 16),
> +};
> +
> +#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
> +#define ATTR_FLAG_MODE_MASK	(0xffff0000)
> +#define ATTR_FLAG_MASK_ALL	(0xffffffff)
> +
> +enum amdgpu_device_attr_states {
> +	ATTR_STATE_UNSUPPORTED = 0,
> +	ATTR_STATE_SUPPORTED,
> +};
> +
> +struct amdgpu_device_attr {
> +	struct device_attribute dev_attr;
> +	enum amdgpu_device_attr_flags flags;
> +	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +			   u32 mask, enum amdgpu_device_attr_states *states);
> +
> +};
> +
> +struct amdgpu_device_attr_entry {
> +	struct list_head entry;
> +	struct amdgpu_device_attr *attr;
> +};
> +
> +int amdgpu_sysfs_attr_create(struct amdgpu_device *adev,
> +			     struct amdgpu_device_attr *attr,
> +			     u32 mask, struct list_head *attr_list);
> +int amdgpu_sysfs_attr_create_groups(struct amdgpu_device *adev,
> +				    struct amdgpu_device_attr *attrs,
> +				    u32 counts,
> +				    u32 mask,
> +				    struct list_head *attr_list);
> +void amdgpu_sysfs_attr_remove_groups(struct amdgpu_device *adev,
> +				     struct list_head *attr_list);
> +void amdgpu_sysfs_attr_remove(struct amdgpu_device *adev,
> +			      struct amdgpu_device_attr *attr);
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 57e449bc2379..c16748f5baff 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -28,6 +28,7 @@
>   #include "amdgpu_pm.h"
>   #include "amdgpu_reset.h"
>   #include "amdgpu_dpm.h"
> +#include "amdgpu_sysfs.h"
>   #include "atom.h"
>   #include <linux/pci.h>
>   #include <linux/hwmon.h>
> @@ -2368,7 +2369,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
>   	return count;
>   }
>   
> -static struct amdgpu_device_attr amdgpu_device_attrs[] = {
> +static struct amdgpu_device_attr amdgpu_pm_device_attrs[] = {
>   	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2594,104 +2595,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   	return 0;
>   }
>   
> -
> -static int amdgpu_device_attr_create(struct amdgpu_device *adev,
> -				     struct amdgpu_device_attr *attr,
> -				     uint32_t mask, struct list_head *attr_list)
> -{
> -	int ret = 0;
> -	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
> -	struct amdgpu_device_attr_entry *attr_entry;
> -	struct device_attribute *dev_attr;
> -	const char *name;
> -
> -	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> -			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
> -
> -	if (!attr)
> -		return -EINVAL;
> -
> -	dev_attr = &attr->dev_attr;
> -	name = dev_attr->attr.name;
> -
> -	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
> -
> -	ret = attr_update(adev, attr, mask, &attr_states);
> -	if (ret) {
> -		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
> -			name, ret);
> -		return ret;
> -	}
> -
> -	if (attr_states == ATTR_STATE_UNSUPPORTED)
> -		return 0;
> -
> -	ret = device_create_file(adev->dev, dev_attr);
> -	if (ret) {
> -		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
> -			name, ret);
> -	}
> -
> -	attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
> -	if (!attr_entry)
> -		return -ENOMEM;
> -
> -	attr_entry->attr = attr;
> -	INIT_LIST_HEAD(&attr_entry->entry);
> -
> -	list_add_tail(&attr_entry->entry, attr_list);
> -
> -	return ret;
> -}
> -
> -static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_device_attr *attr)
> -{
> -	struct device_attribute *dev_attr = &attr->dev_attr;
> -
> -	device_remove_file(adev->dev, dev_attr);
> -}
> -
> -static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> -					     struct list_head *attr_list);
> -
> -static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
> -					    struct amdgpu_device_attr *attrs,
> -					    uint32_t counts,
> -					    uint32_t mask,
> -					    struct list_head *attr_list)
> -{
> -	int ret = 0;
> -	uint32_t i = 0;
> -
> -	for (i = 0; i < counts; i++) {
> -		ret = amdgpu_device_attr_create(adev, &attrs[i], mask, attr_list);
> -		if (ret)
> -			goto failed;
> -	}
> -
> -	return 0;
> -
> -failed:
> -	amdgpu_device_attr_remove_groups(adev, attr_list);
> -
> -	return ret;
> -}
> -
> -static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
> -					     struct list_head *attr_list)
> -{
> -	struct amdgpu_device_attr_entry *entry, *entry_tmp;
> -
> -	if (list_empty(attr_list))
> -		return ;
> -
> -	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
> -		amdgpu_device_attr_remove(adev, entry->attr);
> -		list_del(&entry->entry);
> -		kfree(entry);
> -	}
> -}
> -
>   static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>   				      struct device_attribute *attr,
>   				      char *buf)
> @@ -4520,11 +4423,36 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +static int pm_update_sysfs_attr(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +				u32 mask, enum amdgpu_device_attr_states *states)
> +{
> +	int ret;
> +	struct device_attribute *dev_attr = &attr->dev_attr;
> +	const char *name = dev_attr->attr.name;
> +
> +	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +			   u32 mask, enum amdgpu_device_attr_states *states) = default_attr_update;
> +
> +	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
> +
> +	ret = attr_update(adev, attr, mask, states);
> +	if (ret) {
> +		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
> +			name, ret);
> +		return ret;
> +	}
> +
> +	if (*states == ATTR_STATE_UNSUPPORTED)
> +		return 0;
> +
> +	return ret;
> +}
> +
>   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   {
>   	enum amdgpu_sriov_vf_mode mode;
>   	uint32_t mask = 0;
> -	int ret;
> +	int ret, i;
>   
>   	if (adev->pm.sysfs_initialized)
>   		return 0;
> @@ -4561,11 +4489,19 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> -	ret = amdgpu_device_attr_create_groups(adev,
> -					       amdgpu_device_attrs,
> -					       ARRAY_SIZE(amdgpu_device_attrs),
> -					       mask,
> -					       &adev->pm.pm_attr_list);
> +	for (i = 0; i < ARRAY_SIZE(amdgpu_pm_device_attrs); i++) {
> +		enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
> +
> +		ret = pm_update_sysfs_attr(adev, &amdgpu_pm_device_attrs[i], mask, &attr_states);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = amdgpu_sysfs_attr_create_groups(adev,
> +					      amdgpu_pm_device_attrs,
> +					      ARRAY_SIZE(amdgpu_pm_device_attrs),
> +					      mask,
> +					      &adev->pm.pm_attr_list);
>   	if (ret)
>   		goto err_out0;
>   
> @@ -4580,7 +4516,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   	return 0;
>   
>   err_out1:
> -	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
> +	amdgpu_sysfs_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>   err_out0:
>   	if (adev->pm.int_hwmon_dev)
>   		hwmon_device_unregister(adev->pm.int_hwmon_dev);
> @@ -4595,7 +4531,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>   	if (adev->pm.int_hwmon_dev)
>   		hwmon_device_unregister(adev->pm.int_hwmon_dev);
>   
> -	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
> +	amdgpu_sysfs_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index 3810fedba609..093c39a5d715 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -24,65 +24,6 @@
>   #ifndef __AMDGPU_PM_H__
>   #define __AMDGPU_PM_H__
>   
> -struct cg_flag_name {
> -	u64 flag;
> -	const char *name;
> -};
> -
> -enum amdgpu_device_attr_flags {
> -	ATTR_FLAG_BASIC = (1 << 0),
> -	ATTR_FLAG_ONEVF = (1 << 16),
> -};
> -
> -#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
> -#define ATTR_FLAG_MODE_MASK	(0xffff0000)
> -#define ATTR_FLAG_MASK_ALL	(0xffffffff)
> -
> -enum amdgpu_device_attr_states {
> -	ATTR_STATE_UNSUPPORTED = 0,
> -	ATTR_STATE_SUPPORTED,
> -};
> -
> -struct amdgpu_device_attr {
> -	struct device_attribute dev_attr;
> -	enum amdgpu_device_attr_flags flags;
> -	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> -			   uint32_t mask, enum amdgpu_device_attr_states *states);
> -
> -};
> -
> -struct amdgpu_device_attr_entry {
> -	struct list_head entry;
> -	struct amdgpu_device_attr *attr;
> -};
> -
> -#define to_amdgpu_device_attr(_dev_attr) \
> -	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
> -
> -#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
> -	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
> -	  .flags = _flags,						\
> -	  ##__VA_ARGS__, }
> -
> -#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
> -	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
> -			     amdgpu_get_##_name, amdgpu_set_##_name,	\
> -			     _flags, ##__VA_ARGS__)
> -
> -#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
> -	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
> -			   _flags, ##__VA_ARGS__)
> -
> -#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
> -	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
> -			     amdgpu_get_##_name, NULL,			\
> -			     _flags, ##__VA_ARGS__)
> -
> -#define AMDGPU_DEVICE_ATTR_WO(_name, _flags, ...)			\
> -	__AMDGPU_DEVICE_ATTR(_name, 0200,				\
> -			     NULL, amdgpu_set_##_name,			\
> -			     _flags, ##__VA_ARGS__)
> -
>   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
>   int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
>   void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);

