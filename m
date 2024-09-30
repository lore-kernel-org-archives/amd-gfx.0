Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83176CF6499
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 11:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3380610E3FC;
	Mon, 30 Sep 2024 11:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cuk6zmdP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8708410E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727696989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRHusF2u13MvXHMTKgH6gtL/plFCBlz+aey7QHJzopk=;
 b=cuk6zmdPxCZSFq2A7WzwqPNTm8bqHm9w6/9nvmPjg7uSwQCvWrrKAsn8zr6dICIzg86K4o
 SN4e2DV9HicjQCUmx4Kj0hp3GIyHFg723pykwFn859ykQBSd7tPY4r5pv4VkaX9ntcV3lh
 8xHO3x/uuG4NdTCQeh1BLEU9zQhxgxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-MX0HvK9vN9C8Qybjn0xP-Q-1; Mon, 30 Sep 2024 07:49:46 -0400
X-MC-Unique: MX0HvK9vN9C8Qybjn0xP-Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cdbe8a6e8so1050354f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 04:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727696985; x=1728301785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hRHusF2u13MvXHMTKgH6gtL/plFCBlz+aey7QHJzopk=;
 b=cZM5PyAt6a06Lp8kMWBly6P6RZSJzB1Yx3gEnKQmxWUDz5caGafhs4DV+53DMBc5f2
 o/6XjfDHrxQv7OZCDiUSFAkNLXeXvvJL2SLAngZlpv1kl3CNmKqgeay6rF3iVVf/bRr0
 tTG2eqnps5GuWnEkCjXHJueq5wpO1ncA3g7jLHFP9SCzO3NHr2H5jdM5JMKqzWHKrFzU
 tm2VbDvLpgXplttORkNPJFzCtzC3SAOtmxLLHXJx4ltaJsvZdMO4iJObqFCceIC1WFMk
 diIlSZ5njniYHmZs7aHJMUPEkPfwwbKJPW+x2GEwnXUZR0Z1ODR8EcOSy88LiPniJ5zJ
 zAjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5UOiTuLg69jjFC3nD4eGv96HdyISYkDv0f/riI80VJK0S1VpMfCU112MsLL/gJ4v4XSpftwOw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAy5nexD1uMgBBXgPmYIeVuQu6TyScplUe9JfzNWAqIvdUJk3F
 RXvQXte53ecRG/sY4zSa78U3NpTfIm/+D6vx/zbWhAP9vuoCq9adk58l4Yt6PPLiL0SutG6Vj78
 y1+cKfYEF8CDC5XE9Kzk6eil7HKQ0ot/ISrrrcSxzfeV0lsv1jsV1Z6ZarX4RAGA=
X-Received: by 2002:adf:e44c:0:b0:37c:d225:6d33 with SMTP id
 ffacd0b85a97d-37cd5b10603mr7648025f8f.55.1727696985235; 
 Mon, 30 Sep 2024 04:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSGiGfEDOq94l9bERm0mGRovZs/S+44uf5VGWQUgGYf4IhIky78bVci0l0GCqb8jHV0O02A==
X-Received: by 2002:adf:e44c:0:b0:37c:d225:6d33 with SMTP id
 ffacd0b85a97d-37cd5b10603mr7648003f8f.55.1727696984799; 
 Mon, 30 Sep 2024 04:49:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6596sm8910891f8f.63.2024.09.30.04.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 04:49:44 -0700 (PDT)
Message-ID: <50d1f4d1-538c-4e4d-83eb-4b85f7642eb7@redhat.com>
Date: Mon, 30 Sep 2024 13:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm: Select fbdev helpers for modules that require
 them
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20240927144252.31813-1-tzimmermann@suse.de>
 <20240927144252.31813-5-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240927144252.31813-5-tzimmermann@suse.de>
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

On 27/09/2024 16:37, Thomas Zimmermann wrote:
> Fbdev emulation for SHMEM and TTM requires helpers from the fbdev
> subsystem. Select them from the modules that use them instead of the
> core DRM module.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 1df4e627e3d3..88b2ba55fe16 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -11,7 +11,6 @@ menuconfig DRM
>   	select DRM_PANEL_ORIENTATION_QUIRKS
>   	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>   	select FB_CORE if DRM_FBDEV_EMULATION
> -	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>   	select HDMI
>   	select I2C
>   	select DMA_SHARED_BUFFER
> @@ -332,6 +331,7 @@ config DRM_TTM_HELPER
>   	tristate
>   	depends on DRM
>   	select DRM_TTM
> +	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>   	help
>   	  Helpers for ttm-based gem objects
>   
> @@ -345,6 +345,7 @@ config DRM_GEM_DMA_HELPER
>   config DRM_GEM_SHMEM_HELPER
>   	tristate
>   	depends on DRM && MMU
> +	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
>   	help
>   	  Choose this if you need the GEM shmem helper functions
>   

