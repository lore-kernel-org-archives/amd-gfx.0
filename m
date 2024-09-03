Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D31CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7920710E4D2;
	Tue,  3 Sep 2024 11:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Q8qeVLgA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D1010E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxxrRERlM1KKjx6cIQxxpxez8ndiAEATgkodVQZqsO4=;
 b=Q8qeVLgAUmT+IXruPFCkOFs1Eax0CtxdkvMRGxjV5pEiLk26BUrUZRlb8+LsslOpU07ynq
 uHr3u7PWy9AvsClLxOoU2iugWhAQanawwO2TlxDtaWNJSIOX9zRqbOAEp+lHM+5F2Sz/Ka
 RKFA0SSUkqR4nhaM4lpCy25VLJ4GxtI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-TrGIAv63PZupcWfD3shgig-1; Tue, 03 Sep 2024 07:30:07 -0400
X-MC-Unique: TrGIAv63PZupcWfD3shgig-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42c881282cfso9396545e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363006; x=1725967806;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxxrRERlM1KKjx6cIQxxpxez8ndiAEATgkodVQZqsO4=;
 b=vreWV1QXQNLib+uuqMFWklfPz2qSwJJ2bQnUwX0sABaKjABxZ+nDKozQubeNwW2Lmp
 +/E2dMiAcl0bCnE8vcNIGWggpae4N8Hsb8PjviK8Jdc3uAjUFIIKzcyudHJ6UgffUxXj
 fvSGfo1B4tE9Xrm24ROPunOgE/ngJ+SDz7lwRLS0s8ihxyT//Ye2uyBtohKaR8YGC1ta
 ZSrN0AWCjtXNEbqXFU1J6Z/h9Ni1jcf6Kzv/iUxbZ9iCDjvjmUtd4CT9cmgWLPIrl9gJ
 eEp2sVTTfkckp3+mT3+Hm1/fTpCOIaIcUCMoTzPwJlAJwkVku0w9s+bnUOLI4KiYC5yV
 aYvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMMXquk7nZvbJJd/NmIHCXtMzXpH99/7QicVGziuh0kBHTGPofGMSB42gE8Far3lLvY7KViSGd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmHX3+aAIqygAW2pvCGu9cJCxQoBiDZ7qAWKtp1GRik5YcrONe
 HAD1hLU7/itLJNfJsMd2BWGCg2sxR5FL6HtjEFfNwXBZYmuHloXfipmyt9/ixUNmfee7X4SIxAn
 SwOdO5YxV/HWTXFYSIrUH6L6LCLCaKzJekIxI6dc4+KbKztSxQjjvS3Ih/k1iIZsKwQbf51U=
X-Received: by 2002:a05:600c:3c90:b0:428:1a48:d5cf with SMTP id
 5b1f17b1804b1-42c8de798b4mr4038905e9.9.1725363006017; 
 Tue, 03 Sep 2024 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvAYpzgdPZsIwkrEWFvZvdn75hpa0fqZPHsIu48fvr3XJmd4Ap7A23CN95pFqKYIWUbhWWg==
X-Received: by 2002:a05:600c:3c90:b0:428:1a48:d5cf with SMTP id
 5b1f17b1804b1-42c8de798b4mr4038695e9.9.1725363005569; 
 Tue, 03 Sep 2024 04:30:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e27c70sm168136785e9.35.2024.09.03.04.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:30:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 33/81] drm/pl111: Run DRM default client setup
In-Reply-To: <20240830084456.77630-34-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-34-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:30:03 +0200
Message-ID: <8734mhf004.fsf@minerva.mail-host-address-is-not-set>
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

> Call drm_client_setup_with_color_mode() to run the kernel's default
> client setup for DRM. Set fbdev_probe in struct drm_driver, so that
> the client setup can start the common fbdev client.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/pl111/pl111_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

