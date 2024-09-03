Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E23CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE57710E557;
	Tue,  3 Sep 2024 12:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CcxDh/q3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C3310E556
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NAq91MHu1YedLn3F02fhYw1UruzCX/irseYvT1RQybQ=;
 b=CcxDh/q3IFF5Gz3TrdoajCHKXXY/uvvEVLAZ+DdKEbjQFuI7OjssAytCRlb2teM3juE9zQ
 W6pidiaSIck4GcRBivkbCocABS9hSeneAwYM7RbRp6GZ2Cdo+VAHohbHL/I+nRGvhkz0ZK
 8YWyT9bniBichuaTcyZdx7gnlROEq3I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-okTzOdBrNMC-8BwtEDdZ5g-1; Tue, 03 Sep 2024 08:15:44 -0400
X-MC-Unique: okTzOdBrNMC-8BwtEDdZ5g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37496a7daf2so3554288f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365743; x=1725970543;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NAq91MHu1YedLn3F02fhYw1UruzCX/irseYvT1RQybQ=;
 b=WX/HOK6sfBiXg1N+tFNeV4pEOOAslf6eMGxT0/onyIzM0G52Zy/AAdqKoZHSSxpGCX
 8xr6nH6da8nYBVDPNizEKgvv4sMgWZVXF/1hyQ7L3gUfafLjfnZq/WFKTy+gT2QEAnob
 PDGBbAEFd4pqJz52v0vxk2K7q0pf/Hu5FUBlF3i2iWFjjlkFbfVJcY4XpNTdaWMgexwG
 1GlZkb9pGPmwRuEOz2ePEKHMCECUVODwuK39/dv7fc4BnJVkRXnGyoh48HZTMDtOrwOT
 VTDItndgisUeLdmcfsnFqhAoAQRDEPn4Rur+70G91esMyMgcIRM0DtBC6CXmFadhoL+s
 5hQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFyB5urzNSMCpQxeTFJuJlCRhG0fg6akmD3wmEJ3nJspw1Z1FyTRskmdCIqAD69/EIiza6WuMQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmAJ1bHObVjYb2oH4G/FTw8Gh9oUcT86WYKGqmyG59bRGsJs7o
 1Bwe50JmaDu0JLZe+j7cKcrdBSKX6hcI3Je9g37J0crli4xD6pdjPwtRa2nWQktix9BDdCRW1Da
 myqlGia2627hUOU1A2pTPAM2ypTNjCZTphwtl85HdWxGmqEzdP2zAkX0hCFS6bpaXBvX51bE=
X-Received: by 2002:adf:fa51:0:b0:374:c1a9:b97b with SMTP id
 ffacd0b85a97d-376dcc8b8e5mr467035f8f.8.1725365742995; 
 Tue, 03 Sep 2024 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrOxGUesKlUZWk0uC4i7YVs6JItUFj0a5y2fMikJdW7sd9iJpSVoWROtdMbdcImV5AXcDIYQ==
X-Received: by 2002:adf:fa51:0:b0:374:c1a9:b97b with SMTP id
 ffacd0b85a97d-376dcc8b8e5mr466725f8f.8.1725365742564; 
 Tue, 03 Sep 2024 05:15:42 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm11081760f8f.59.2024.09.03.05.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:15:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: [PATCH v3 76/81] drm/gma500: Run DRM default client setup
In-Reply-To: <20240830084456.77630-77-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-77-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:15:41 +0200
Message-ID: <87bk15c4r6.fsf@minerva.mail-host-address-is-not-set>
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

> Rework fbdev probing to support fbdev_probe in struct drm_driver
> and remove the old fb_probe callback. Provide an initializer macro
> for struct drm_driver that sets the callback according to the kernel
> configuration.
>
> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> ---
>  drivers/gpu/drm/gma500/fbdev.c   | 100 +++----------------------------
>  drivers/gpu/drm/gma500/psb_drv.c |   4 +-
>  drivers/gpu/drm/gma500/psb_drv.h |  12 +++-
>  3 files changed, 19 insertions(+), 97 deletions(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

