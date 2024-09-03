Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAAECD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC8010E53C;
	Tue,  3 Sep 2024 12:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f0+EJh0b";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6C710E537
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAf/TzZtq+rwzNtcBqcoWPNDNpw8IbIKF1x2SXWWyZs=;
 b=f0+EJh0bEfqtP20AhvQ5uchIpeCcH+Xof9NT/a1i5/CsqMjBGiWCfIBEgP78mhj6m5yrQC
 /mYF8LKyH5aTv7ADCcpbX90ZDP2Mf3qKcm4IE2Z+oMEWlGQGuM55z100LgJ25aRQmYsIs9
 ynmK8ONLXJQlK4PkAMfgMg5QveijLOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-QPNJePHBOaWDFLLKIcD69g-1; Tue, 03 Sep 2024 08:07:46 -0400
X-MC-Unique: QPNJePHBOaWDFLLKIcD69g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c294d841so2363612f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365265; x=1725970065;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAf/TzZtq+rwzNtcBqcoWPNDNpw8IbIKF1x2SXWWyZs=;
 b=OcNKL/aJ4bCqxmOQ0cssXPpSjn85K3dDwcogbbXVM9gUpiFOXbcLEigdvTJm2ryV1B
 h0ZvMJ4EAws5KX8SLH/1VCATkUS77TPPghsfDZbmrtBs9enaZAQk4Jv6sN7iFqom6WmZ
 Vk6JMLcfGl7Mxl/Vh+F4aLWvRNfydp42eUpwdW7rXiEwsIp16WWfJQUEOQ8bTUJ0jv30
 PvtXIatyKrZxqtV1UmTd5TE8yJqohrZA9FXT7xurXcdu7uQzJLj4sgE2xazYzt09ipqp
 1iyJd6unt+2+jsEdRskoKkpR7z+ss5tP5R4zbwNil4btP9d+V3S67jyhZFE73oLGj+YX
 l8xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUShYmVQVkNFQHyq3slTzRs71MsAFAkC61VnOt1lZa9IVtojaRzryoFy+jd/J05/VNNfOxAIFaT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp0j9y+/Blw4O0RbBxkFaOtsa4tM3k2tvRT6b6sdgOB2bLy+fn
 p4EkPXXKpXfEcLdsrpvH+oUVxwjy8jV8jMSYTYLkVGZtbYqrRShG4V51FetPmICOsrfYVOesRGB
 nx4lGZIcDjhZf18K5sacHnfsBuM0OKMk//RSSPXrZlDbYEbWH4iIzUwzQhewNo88=
X-Received: by 2002:adf:f4d1:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-374c1602776mr7846593f8f.22.1725365265440; 
 Tue, 03 Sep 2024 05:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZGf4oyMzQD1xP820+OtoZdwpD9efRDqC8p6dHAxE3oooeovG0mBCFinpOGmjQ84JGX0fEg==
X-Received: by 2002:adf:f4d1:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-374c1602776mr7846571f8f.22.1725365264915; 
 Tue, 03 Sep 2024 05:07:44 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b23f20d1sm11428477f8f.35.2024.09.03.05.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:07:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v3 72/81] drm/vmwgfx: Run DRM default client setup
In-Reply-To: <20240830084456.77630-73-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-73-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:07:43 +0200
Message-ID: <87mskpc54g.fsf@minerva.mail-host-address-is-not-set>
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
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

