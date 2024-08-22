Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C97C531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 06:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E7310E760;
	Thu, 22 Aug 2024 06:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="T6LKT4Hs";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4185610E760
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724308743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opGg6/BWhtL5WACV1y1lk17vbvidiAf6fU2jwHA8Plc=;
 b=T6LKT4Hsvi81XslR4/8m3WKhfOxPBi0h3HwGRK+dZEl8OHfT/+Qpg2djsr8q5hfnZ8TdDa
 oy7lACuYvAng4SPrTG8lSKDsSA5WrZP3TTXt7SnWEGfStrqt8HgXgcOIfX2xTgFnqGUEzY
 FvaoxpeHK6f1u7IriwyY1e9VBK4hagw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ZUh7lZgfNauvDO3s4XnxMg-1; Thu, 22 Aug 2024 02:39:02 -0400
X-MC-Unique: ZUh7lZgfNauvDO3s4XnxMg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280f233115so3137895e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 23:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724308741; x=1724913541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=opGg6/BWhtL5WACV1y1lk17vbvidiAf6fU2jwHA8Plc=;
 b=e2BxggdEDaSkF+rnEzyVO3FdJMWU4diGoe/lPUVABMEJTyoLVldD8C4e2tjDPIQNda
 0XS1MWjSfwM0CfrPr2sjkhWyLxT+XnSK4jBPNgux9HbTPK/Lia43rqkDDw+cIpxEr0VK
 ERBJC5ofNLXtSMLwMoIZPhQZyCG/yWeZ0KZfqpCGzBE9HB+luJSDCntq/Bme7hhfmiXr
 KO+i/SunCsZ/dWAh4AeVmxFU0hgXzPdquPaANFX6V4E2V+2luN6u/3F2ECxTE+OZAmH8
 QIxRiWA54NeQrk07KFyXykbOYvLgf5IHUnROGQC1Ib1izCFaoZ+TiK6TK0MhF0E6MdbL
 Y/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyumCyu08FFVrGrUuFfC5i91sqGLJ3SeDlYVZiOqy3TwnoPZqhIYbdR3bziA5v4YSUNizfkyc5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEYo+aVfV3dQdye2n8JH+3bPk9ANR9XPkXRiPnhEMUGwT63dR6
 sO+C1GXOUXkBbuJcYhbT3Pukk8O/Hrlt/DgU56sy03Dc9yWjN3/4QJ/+IG3MeSZxFX9QWHtiwKD
 5JXy2JMCuL6p+7rid7Ztnv4Jmu/QCDu9Ptb6fsKomY/EMDvQJ3O9s4PZsGj/SgyFrsy32mP4=
X-Received: by 2002:a05:600c:4445:b0:426:629f:1556 with SMTP id
 5b1f17b1804b1-42ac564e997mr5432185e9.31.1724308740906; 
 Wed, 21 Aug 2024 23:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNSJ+B67xvaGtjlYSDRu+Bj+yxQk9e7g47HD9d837R1mmSh16JUoPKQQQ2x1Jtyx01W4ZulA==
X-Received: by 2002:a05:600c:4445:b0:426:629f:1556 with SMTP id
 5b1f17b1804b1-42ac564e997mr5431995e9.31.1724308740507; 
 Wed, 21 Aug 2024 23:39:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed8b8b9sm48526185e9.9.2024.08.21.23.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 23:39:00 -0700 (PDT)
Message-ID: <0b93ac2d-b1dd-4ad4-91a0-0f3c49365190@redhat.com>
Date: Thu, 22 Aug 2024 08:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 56/86] drm/mgag200: Run DRM default client setup
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
References: <20240821130348.73038-1-tzimmermann@suse.de>
 <20240821130348.73038-57-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240821130348.73038-57-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21/08/2024 14:59, Thomas Zimmermann wrote:
> Call drm_client_setup_with_fourcc() to run the kernel's default client
> setup for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.

Thanks for this whole series.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> v2:
> - use drm_client_setup_with_fourcc()
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   drivers/gpu/drm/drm_client_setup.c    | 2 +-
>   drivers/gpu/drm/mgag200/mgag200_drv.c | 5 ++++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_setup.c b/drivers/gpu/drm/drm_client_setup.c
> index c8ca5afaa47a..5373a892f097 100644
> --- a/drivers/gpu/drm/drm_client_setup.c
> +++ b/drivers/gpu/drm/drm_client_setup.c
> @@ -64,6 +64,6 @@ void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color
>   {
>   	u32 fourcc = drm_driver_color_mode_format(dev, color_mode);
>   
> -	drm_client_setup_with_fourcc(dev, fmt);
> +	drm_client_setup_with_fourcc(dev, fourcc);
>   }
>   EXPORT_SYMBOL(drm_client_setup_with_color_mode);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index 6623ee4e3277..29087e2398df 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -11,9 +11,11 @@
>   
>   #include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_client_setup.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_fbdev_shmem.h>
>   #include <drm/drm_file.h>
> +#include <drm/drm_fourcc.h>
>   #include <drm/drm_ioctl.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_module.h>
> @@ -129,6 +131,7 @@ static const struct drm_driver mgag200_driver = {
>   	.minor = DRIVER_MINOR,
>   	.patchlevel = DRIVER_PATCHLEVEL,
>   	DRM_GEM_SHMEM_DRIVER_OPS,
> +	DRM_FBDEV_SHMEM_DRIVER_OPS,
>   };
>   
>   /*
> @@ -314,7 +317,7 @@ mgag200_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	 * FIXME: A 24-bit color depth does not work with 24 bpp on
>   	 * G200ER. Force 32 bpp.
>   	 */
> -	drm_fbdev_shmem_setup(dev, 32);
> +	drm_client_setup_with_fourcc(dev, DRM_FORMAT_XRGB8888);
>   
>   	return 0;
>   }

