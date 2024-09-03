Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6C5CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C379210E52C;
	Tue,  3 Sep 2024 12:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Rx3T54+l";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9603E10E52C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKH42MPBYmGRwEigr3d5s600iIva9uiUrOTp/Gc7qDw=;
 b=Rx3T54+lHUkqk/yocrmVZl4ElddWnpg1ws27Ew7vxtQBZbkhrnrOe8gy8vtmhm/n+b8w3M
 /1+2UxBPKhq0XoIkXGPzv9a2WeIXE8ouJeB+kbBxv+U9hXj3ROOHZDm6Y24uvKzGKU53HJ
 RwLVi0NfBv9xhnLuH+Zm/7J6Ez2Zoxo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-MJNUCoEsPGGXr26SUrdlnQ-1; Tue, 03 Sep 2024 08:06:34 -0400
X-MC-Unique: MJNUCoEsPGGXr26SUrdlnQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a86f0c0af53so453275066b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365194; x=1725969994;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKH42MPBYmGRwEigr3d5s600iIva9uiUrOTp/Gc7qDw=;
 b=WSiLmM+ZT0xHLpSCxoLrLvO9PW0f5ElUn0R5RXQNjD5m0XByNgyLmfJzUz3duDfAOW
 OLcoH5/dPPQSiN1Ahb+PwJghS5gQCU+HtccHxhMKusd9gsfT+QlRhZ4/y+iSAysZfCCt
 GBi5eIBkFs2vJKVmYUNmuUPutdBnHo2ZLnQDY75F1pYhoh/rHp1OOharuvSl1yAQtHQo
 A8TglB8mQe3Mpo3Ng4+mNsPbY3Jqg6m2ViwhLT2oICj6iEAt7/vZFmISSQGAyHSelnzr
 8L1YdphHxI2ScyslLq91jzYl5NXwXa3lWbMhY2LUZgHq8L884K0saGA0borHO/vfRH0r
 dRWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRLnDhJZPft0OqBtoZ7nNDGW5WvP43tjYVrq5rY0J7+6IM2wEjUXp/kfn/KD5gq6EmrVSJPaKm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFu4rGAcmbp7kytcFyhuyWDsRneox5frTHgcPcJiinM/Umzjq3
 UpyAtuN/W/v6bpnmNznNJtMMo9kc3T0oRVyQ+MgnaL7zJ5NHNddHKenDP7QK+GFsf6tDW4Ns807
 B9zL13V6jcczmh0UDvyeDDfKH5/XloxZKEZJr9YHdOvqsEE8zMOfCLRRGFTMo9H0=
X-Received: by 2002:a17:907:980d:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a897f83a33bmr1262521766b.23.1725365193659; 
 Tue, 03 Sep 2024 05:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKoeIshuDSdtf/JGgIl6tnQAFAZn+DDFBpQM9QN52xxGXt/DVTGdF5osqSdNpaEvBaP2lGVw==
X-Received: by 2002:a17:907:980d:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a897f83a33bmr1262519066b.23.1725365193131; 
 Tue, 03 Sep 2024 05:06:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f0acsm674520966b.73.2024.09.03.05.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:06:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, John
 Stultz <jstultz@google.com>
Subject: Re: [PATCH v3 67/81] drm/hisilicon/hibmc: Run DRM default client setup
In-Reply-To: <20240830084456.77630-68-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-68-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:06:32 +0200
Message-ID: <87v7zdc56f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> The hibmc driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Tian Tao <tiantao6@hisilicon.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: John Stultz <jstultz@google.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

