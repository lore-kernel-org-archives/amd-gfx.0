Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E07CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E041110E496;
	Tue,  3 Sep 2024 11:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="e4qM8i0/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7488710E496
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQTpGzPFQqB5gAShloE0zxFF7qqYRFvzMaH5N3OQkCs=;
 b=e4qM8i0/QDug9VCPJoIelXDgZF6XSvw9+/4VAy+1SjUN7NAyuH0yjXzVz+lanhWO2qo7WL
 uQPMPV+/YCMcFCib3IcsrOqflPQMZpBN/fPdW2M1zdQbUPc3y1Nl81ySZV5wsVnZBTU2X/
 mcV+1tz+D/lmQuoIQMuGW+zplNeVJNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-H43TUCyAPyi8DfiURicr5g-1; Tue, 03 Sep 2024 07:21:19 -0400
X-MC-Unique: H43TUCyAPyi8DfiURicr5g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bb68e1706so48013205e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362478; x=1725967278;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQTpGzPFQqB5gAShloE0zxFF7qqYRFvzMaH5N3OQkCs=;
 b=gdG8BIVp1kAOX+9R9nPlJmVJvssVV2b9L64s0AFPVrzUQaKMTvq+qMWtyGJzUPSgrR
 vZanILIPK/le8CStsrk33RnNooFWSMCx1cPtWUrHSIIPsg8HAnocRrgeYHfmzR5yYrcn
 qKbxXgGynlzsYeJLvxo1qHxwwmVmNnnrRcbj4PIGnWl8sQ92q3K3DXr7AM5jaVYlkwJs
 jgqE6f7wBWn9NOP1XacIWpbd7VVMn9uhXdqLPEJTGeXI2O/SYUsO9O0XL+Y6UmWwZZC7
 xqifZPcDIZdmaFSiVcWMtdOOsQ/Yib6nJDsyYVe7NwZP3U0ShRYCfcBMAyzJdhBRxs1N
 7KBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsb/du0cKvp4vPUtzqGahoRZsfPJRqFw2Xx9rqrY0K9mppbvhhdH0fjFXUsfe8XhEbP7q7H+BI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVK6aYwgF3Q3dlFCpQ9BXcvvW85muQBoSRhGDXNG+EI5tnB49p
 pZ6Cm2FqIb2MwkT5N4vvD0WgKRutwKYgbplDi2i4j5Y+qcnRqkvAVqs3/AmDionMcFI9POByqLM
 fOS0MyxAr9fTZTfxmdmwEdR74zMzVkv+Yj9Fhl9RhVNOFTZTuEcBK9ojxhnEwKHA=
X-Received: by 2002:adf:a30c:0:b0:374:baf1:41cb with SMTP id
 ffacd0b85a97d-374ecc67bacmr2268359f8f.4.1725362478470; 
 Tue, 03 Sep 2024 04:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbXnmNinNKcxIoQZ/xbsrsLu5CSXkPJ8NSjds5BWMTJG6QY5z6avZlP02srMBnOR8Wv7uPgg==
X-Received: by 2002:adf:a30c:0:b0:374:baf1:41cb with SMTP id
 ffacd0b85a97d-374ecc67bacmr2268340f8f.4.1725362478084; 
 Tue, 03 Sep 2024 04:21:18 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374be2edf08sm9391463f8f.6.2024.09.03.04.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:21:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 15/81] drm/ili9163: Run DRM default client setup
In-Reply-To: <20240830084456.77630-16-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-16-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:21:17 +0200
Message-ID: <87zfopf0eq.fsf@minerva.mail-host-address-is-not-set>
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
> ---
>  drivers/gpu/drm/tiny/ili9163.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

