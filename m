Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C021CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AA110E4F2;
	Tue,  3 Sep 2024 11:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gAZVTy/P";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452D310E4F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4mDjfLV7OAnvVKb4h3wcvxirCud+mre7CyjFzqqSY0=;
 b=gAZVTy/PewzD29qSBjRySZlI6OOEPft3D6i1WF7j2P3dPY5dOOW9tvg53wDpleiZzHFRBC
 i39kYnsamhhYodsxYsDpi0B7gMTKKfnEYn6tS+Y0KLgcNs/WkXHfI5rOboTnTMzlmILVs0
 WvqrAuwG/CsYyv4Q/TKmTHUrkLtf9B8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-ieDpzblbNAeZ7oYCOZ5_7Q-1; Tue, 03 Sep 2024 07:39:30 -0400
X-MC-Unique: ieDpzblbNAeZ7oYCOZ5_7Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37496a7daf2so3533294f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363569; x=1725968369;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B4mDjfLV7OAnvVKb4h3wcvxirCud+mre7CyjFzqqSY0=;
 b=aG3D0OUjMCBLXcnMVznw8Cj55EuCs1m3cEqVYA3OQQaDNGsoe8BU+KTJDJB5dI4VTy
 aYxPIvlfCaFatbZVmWGZYV1b4m9ge1vcTAr3Yd6AjGR831DX/lBhvtiMCe/wsuzJZ2rO
 efmR19wgJMvWiAC67psYLsZLKJRslUQlIZIc/lvPFVuTennyNew5Sd8uEoz7LhWUB3ZT
 fpqvdeNdkgJr5Z0x3zs46SZ2cSMbMl+mu5AzkqC+D3BnBJhZ6mGFp4uc0zIWYNuniHA/
 PnQsmzkUM6ab47/qCcS/DbfB3H+mSvjJM8mb4RNZFUETtX7bJyjNEDlIAgDitIGovF+5
 hHgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKuWiI6F5gt0YelhV2wYpar15+cNxtG1tnCWsCkzK0apEyI1YlV7ESLQqYHJpBk2ee7kHeeb1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx0IU5CU7b8fnJl1WJr1P+aoePugdZgZY7Fo3SqExoNBZtYiyO
 /P8m7Php3D+Sm3C5qnAkcULix9bipeMIV2JBJyfbi5puq8k7MuEL3y5k9GSwx4FKh9DHYzw72Kd
 afHRFF8vq9MAuwJ8dBCuqjppd1saIL/xWxvLOW+IjgvL8+vOtNiiwF6jLPA/K07s=
X-Received: by 2002:a5d:6e42:0:b0:374:c56c:fbc7 with SMTP id
 ffacd0b85a97d-376dd15a895mr357668f8f.15.1725363568988; 
 Tue, 03 Sep 2024 04:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQSUDUfzSKG3LOW3MagIfuHvjKQDUVhkyVId3Miv17du6YGeJMV1X8eK/OXklKwkOqAbQaAQ==
X-Received: by 2002:a5d:6e42:0:b0:374:c56c:fbc7 with SMTP id
 ffacd0b85a97d-376dd15a895mr357651f8f.15.1725363568458; 
 Tue, 03 Sep 2024 04:39:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749eea50dasm14014489f8f.56.2024.09.03.04.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:39:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 50/81] drm/fbdev-shmem: Support struct
 drm_driver.fbdev_probe
In-Reply-To: <20240830084456.77630-51-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-51-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:39:27 +0200
Message-ID: <87le09dl00.fsf@minerva.mail-host-address-is-not-set>
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
> and reimplement the old fb_probe callback on top of it. Provide an
> initializer macro for struct drm_driver that sets the callback
> according to the kernel configuration.
>
> This change allows the common fbdev client to run on top of SHMEM-
> based DRM drivers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_shmem.c | 60 ++++++++++++++++++-------------
>  include/drm/drm_fbdev_shmem.h     | 11 ++++++
>  2 files changed, 47 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_shmem.c b/drivers/gpu/drm/drm_fbdev_shmem.c
> index 0c785007f11b..3bca333917d1 100644
> --- a/drivers/gpu/drm/drm_fbdev_shmem.c
> +++ b/drivers/gpu/drm/drm_fbdev_shmem.c
> @@ -107,6 +107,40 @@ static struct page *drm_fbdev_shmem_get_page(struct fb_info *info, unsigned long
>  
>  static int drm_fbdev_shmem_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  					   struct drm_fb_helper_surface_size *sizes)
> +{

I was going to ask if this whould be static inline too but I guess is just
a transition change and will be removed by a later patch, as was the case
for the fbdev-dma setup function. So it doesn't really matter that much...

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

