Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B6CF64A1
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 11:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B36A10E3FA;
	Mon, 30 Sep 2024 11:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Uc+OskoB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24EC310E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727696959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5QUfWuM4AxHV4Nhg2wLgJ1ISnomnLpsdCPN4rTHl5I=;
 b=Uc+OskoB6lVAPzKFr9fsudiX0FDwbqN+SV6dnglKSToSLRyflSznOtJC/5JJAe2vQ1CKQ1
 k7BlU2Z+UN29TY9RaFUNZC+imTXK4+k/HNDzdLElI+GtUbjvnbfoxv1srhtNmAJ46RhODo
 7hW3b1ynlpQYd6yQpvifS1o/YSoZUps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-8IStBGpZPEqpis4wKzsfog-1; Mon, 30 Sep 2024 07:49:16 -0400
X-MC-Unique: 8IStBGpZPEqpis4wKzsfog-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so33240785e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 04:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727696955; x=1728301755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5QUfWuM4AxHV4Nhg2wLgJ1ISnomnLpsdCPN4rTHl5I=;
 b=nZrM+omrXJ9JOj/gaJU6DSB9e58nzDAbhbVyFALHL0l70LhWUJswvSMIJEgYCWuKkk
 mZYG7TQTcjtAwyB7yJbsKNoCKaPjpbyYGfMbTX4+0s0iJ5qdot9z3S0mB9TD8U8M1IO0
 ztwhJ24dnMqjOVUfpKz9o3MTdWl6VoWDxh910EE4gMGFeVsWZqlVGVr4m5U1GPd0oyKv
 l+qZ8F03ZOIcgi2PM+iA/XB0K4joDDRr7RHbjfScWGfo3rf2qvaQrgTWpAQ4osq2NW6I
 uF4xic1kPq0m0m0OEX1mH7dbyHnKfgYXoE8Qw1qHuWLQO/wLIL2RrRn5F+v/jNHc1a9Q
 lJqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3B/c6NYJmVv1Kpb91RnHH/dEpmOxu6a2fjg1hxUHk5I+OJuYZGThHQB2ny9RktfBqTKUk0eqt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDJSmXknlZRZvfvh40t4Xf+MyVIM8TFL03ItCWv/lRJP8GvNlp
 Bhj/ppopg6NAOKEe6p/kNfTZJk/NmF0dU+0pDhkVq2mJ4R27FSVzlwqLTGy7D9s3ZdDJDK8Ap4z
 I6m67C/7Yw3TOME6BBi+lcART1j+QovEUlWId2Wnn5Wx45EFCEQXHL6KTbb28hRA=
X-Received: by 2002:a05:600c:35ce:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-42f582a7448mr93543305e9.0.1727696954778; 
 Mon, 30 Sep 2024 04:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyeUPLPrCr8h0lFWa9O57ZYJpsC+mEtNMCYufiH0sQ0b5pQXL66KUXqf2xMa4fZBRCcefeUA==
X-Received: by 2002:a05:600c:35ce:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-42f582a7448mr93543105e9.0.1727696954376; 
 Mon, 30 Sep 2024 04:49:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f2534sm147516465e9.19.2024.09.30.04.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 04:49:13 -0700 (PDT)
Message-ID: <c0c71ac8-f195-40d9-b5f4-bdb4b97bb7ce@redhat.com>
Date: Mon, 30 Sep 2024 13:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm: Move client-device functions in to
 drm_client_dev.c
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20240927144252.31813-1-tzimmermann@suse.de>
 <20240927144252.31813-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240927144252.31813-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 27/09/2024 16:37, Thomas Zimmermann wrote:
> A number of DRM-client functions serve as entry points from device
> operations to client code. Move them info a separate file, so that
> the other client functions can be moved into a different module.


Thanks, I'm not sure I can review this, but it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   Documentation/gpu/drm-client.rst |   3 +
>   drivers/gpu/drm/Makefile         |   1 +
>   drivers/gpu/drm/drm_client.c     | 121 ---------------------------
>   drivers/gpu/drm/drm_client_dev.c | 138 +++++++++++++++++++++++++++++++
>   4 files changed, 142 insertions(+), 121 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_client_dev.c
> 
> diff --git a/Documentation/gpu/drm-client.rst b/Documentation/gpu/drm-client.rst
> index 58b5a1d1219d..6d8142f159a1 100644
> --- a/Documentation/gpu/drm-client.rst
> +++ b/Documentation/gpu/drm-client.rst
> @@ -13,3 +13,6 @@ Kernel clients
>   
>   .. kernel-doc:: drivers/gpu/drm/drm_client_modeset.c
>      :export:
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_client_dev.c
> +   :export:
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 3894f43f6d47..c50443756457 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -42,6 +42,7 @@ drm-y := \
>   	drm_bridge.o \
>   	drm_cache.o \
>   	drm_client.o \
> +	drm_client_dev.o \
>   	drm_client_modeset.o \
>   	drm_color_mgmt.o \
>   	drm_connector.o \
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index bfedcbf516db..549b28a5918c 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -10,7 +10,6 @@
>   #include <linux/slab.h>
>   
>   #include <drm/drm_client.h>
> -#include <drm/drm_debugfs.h>
>   #include <drm/drm_device.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_file.h>
> @@ -172,99 +171,6 @@ void drm_client_release(struct drm_client_dev *client)
>   }
>   EXPORT_SYMBOL(drm_client_release);
>   
> -/**
> - * drm_client_dev_unregister - Unregister clients
> - * @dev: DRM device
> - *
> - * This function releases all clients by calling each client's
> - * &drm_client_funcs.unregister callback. The callback function
> - * is responsibe for releaseing all resources including the client
> - * itself.
> - *
> - * The helper drm_dev_unregister() calls this function. Drivers
> - * that use it don't need to call this function themselves.
> - */
> -void drm_client_dev_unregister(struct drm_device *dev)
> -{
> -	struct drm_client_dev *client, *tmp;
> -
> -	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> -		return;
> -
> -	mutex_lock(&dev->clientlist_mutex);
> -	list_for_each_entry_safe(client, tmp, &dev->clientlist, list) {
> -		list_del(&client->list);
> -		if (client->funcs && client->funcs->unregister) {
> -			client->funcs->unregister(client);
> -		} else {
> -			drm_client_release(client);
> -			kfree(client);
> -		}
> -	}
> -	mutex_unlock(&dev->clientlist_mutex);
> -}
> -EXPORT_SYMBOL(drm_client_dev_unregister);
> -
> -/**
> - * drm_client_dev_hotplug - Send hotplug event to clients
> - * @dev: DRM device
> - *
> - * This function calls the &drm_client_funcs.hotplug callback on the attached clients.
> - *
> - * drm_kms_helper_hotplug_event() calls this function, so drivers that use it
> - * don't need to call this function themselves.
> - */
> -void drm_client_dev_hotplug(struct drm_device *dev)
> -{
> -	struct drm_client_dev *client;
> -	int ret;
> -
> -	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> -		return;
> -
> -	if (!dev->mode_config.num_connector) {
> -		drm_dbg_kms(dev, "No connectors found, will not send hotplug events!\n");
> -		return;
> -	}
> -
> -	mutex_lock(&dev->clientlist_mutex);
> -	list_for_each_entry(client, &dev->clientlist, list) {
> -		if (!client->funcs || !client->funcs->hotplug)
> -			continue;
> -
> -		if (client->hotplug_failed)
> -			continue;
> -
> -		ret = client->funcs->hotplug(client);
> -		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
> -		if (ret)
> -			client->hotplug_failed = true;
> -	}
> -	mutex_unlock(&dev->clientlist_mutex);
> -}
> -EXPORT_SYMBOL(drm_client_dev_hotplug);
> -
> -void drm_client_dev_restore(struct drm_device *dev)
> -{
> -	struct drm_client_dev *client;
> -	int ret;
> -
> -	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> -		return;
> -
> -	mutex_lock(&dev->clientlist_mutex);
> -	list_for_each_entry(client, &dev->clientlist, list) {
> -		if (!client->funcs || !client->funcs->restore)
> -			continue;
> -
> -		ret = client->funcs->restore(client);
> -		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
> -		if (!ret) /* The first one to return zero gets the privilege to restore */
> -			break;
> -	}
> -	mutex_unlock(&dev->clientlist_mutex);
> -}
> -
>   static void drm_client_buffer_delete(struct drm_client_buffer *buffer)
>   {
>   	if (buffer->gem) {
> @@ -584,30 +490,3 @@ int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, struct drm_re
>   					0, 0, NULL, 0);
>   }
>   EXPORT_SYMBOL(drm_client_framebuffer_flush);
> -
> -#ifdef CONFIG_DEBUG_FS
> -static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
> -{
> -	struct drm_debugfs_entry *entry = m->private;
> -	struct drm_device *dev = entry->dev;
> -	struct drm_printer p = drm_seq_file_printer(m);
> -	struct drm_client_dev *client;
> -
> -	mutex_lock(&dev->clientlist_mutex);
> -	list_for_each_entry(client, &dev->clientlist, list)
> -		drm_printf(&p, "%s\n", client->name);
> -	mutex_unlock(&dev->clientlist_mutex);
> -
> -	return 0;
> -}
> -
> -static const struct drm_debugfs_info drm_client_debugfs_list[] = {
> -	{ "internal_clients", drm_client_debugfs_internal_clients, 0 },
> -};
> -
> -void drm_client_debugfs_init(struct drm_device *dev)
> -{
> -	drm_debugfs_add_files(dev, drm_client_debugfs_list,
> -			      ARRAY_SIZE(drm_client_debugfs_list));
> -}
> -#endif
> diff --git a/drivers/gpu/drm/drm_client_dev.c b/drivers/gpu/drm/drm_client_dev.c
> new file mode 100644
> index 000000000000..3e41fd1f0771
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_client_dev.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +/*
> + * Copyright 2018 Noralf Trønnes
> + */
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/seq_file.h>
> +
> +#include <drm/drm_client.h>
> +#include <drm/drm_debugfs.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_print.h>
> +
> +/**
> + * DOC: overview
> + *
> + * This library provides support for clients running in the kernel like fbdev and bootsplash.
> + *
> + * GEM drivers which provide a GEM based dumb buffer with a virtual address are supported.
> + */
> +
> +/**
> + * drm_client_dev_unregister - Unregister clients
> + * @dev: DRM device
> + *
> + * This function releases all clients by calling each client's
> + * &drm_client_funcs.unregister callback. The callback function
> + * is responsibe for releaseing all resources including the client
> + * itself.
> + *
> + * The helper drm_dev_unregister() calls this function. Drivers
> + * that use it don't need to call this function themselves.
> + */
> +void drm_client_dev_unregister(struct drm_device *dev)
> +{
> +	struct drm_client_dev *client, *tmp;
> +
> +	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> +		return;
> +
> +	mutex_lock(&dev->clientlist_mutex);
> +	list_for_each_entry_safe(client, tmp, &dev->clientlist, list) {
> +		list_del(&client->list);
> +		if (client->funcs && !drm_WARN_ON(dev, !client->funcs->unregister))
> +			client->funcs->unregister(client);
> +	}
> +	mutex_unlock(&dev->clientlist_mutex);
> +}
> +EXPORT_SYMBOL(drm_client_dev_unregister);
> +
> +/**
> + * drm_client_dev_hotplug - Send hotplug event to clients
> + * @dev: DRM device
> + *
> + * This function calls the &drm_client_funcs.hotplug callback on the attached clients.
> + *
> + * drm_kms_helper_hotplug_event() calls this function, so drivers that use it
> + * don't need to call this function themselves.
> + */
> +void drm_client_dev_hotplug(struct drm_device *dev)
> +{
> +	struct drm_client_dev *client;
> +	int ret;
> +
> +	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> +		return;
> +
> +	if (!dev->mode_config.num_connector) {
> +		drm_dbg_kms(dev, "No connectors found, will not send hotplug events!\n");
> +		return;
> +	}
> +
> +	mutex_lock(&dev->clientlist_mutex);
> +	list_for_each_entry(client, &dev->clientlist, list) {
> +		if (!client->funcs || !client->funcs->hotplug)
> +			continue;
> +
> +		if (client->hotplug_failed)
> +			continue;
> +
> +		ret = client->funcs->hotplug(client);
> +		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
> +		if (ret)
> +			client->hotplug_failed = true;
> +	}
> +	mutex_unlock(&dev->clientlist_mutex);
> +}
> +EXPORT_SYMBOL(drm_client_dev_hotplug);
> +
> +void drm_client_dev_restore(struct drm_device *dev)
> +{
> +	struct drm_client_dev *client;
> +	int ret;
> +
> +	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> +		return;
> +
> +	mutex_lock(&dev->clientlist_mutex);
> +	list_for_each_entry(client, &dev->clientlist, list) {
> +		if (!client->funcs || !client->funcs->restore)
> +			continue;
> +
> +		ret = client->funcs->restore(client);
> +		drm_dbg_kms(dev, "%s: ret=%d\n", client->name, ret);
> +		if (!ret) /* The first one to return zero gets the privilege to restore */
> +			break;
> +	}
> +	mutex_unlock(&dev->clientlist_mutex);
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
> +{
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct drm_device *dev = entry->dev;
> +	struct drm_printer p = drm_seq_file_printer(m);
> +	struct drm_client_dev *client;
> +
> +	mutex_lock(&dev->clientlist_mutex);
> +	list_for_each_entry(client, &dev->clientlist, list)
> +		drm_printf(&p, "%s\n", client->name);
> +	mutex_unlock(&dev->clientlist_mutex);
> +
> +	return 0;
> +}
> +
> +static const struct drm_debugfs_info drm_client_debugfs_list[] = {
> +	{ "internal_clients", drm_client_debugfs_internal_clients, 0 },
> +};
> +
> +void drm_client_debugfs_init(struct drm_device *dev)
> +{
> +	drm_debugfs_add_files(dev, drm_client_debugfs_list,
> +			      ARRAY_SIZE(drm_client_debugfs_list));
> +}
> +#endif

