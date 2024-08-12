Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C484C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 09:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373A110E184;
	Mon, 12 Aug 2024 09:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="OwCWyDN4";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BF510E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 09:24:43 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5a25816361fso312551a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1723454682; x=1724059482; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qfDePbACNEJyXkn1NuDBaQVxTKPG+PH9QdgiWTsQFw4=;
 b=OwCWyDN4QDvPva7MR1CoL1V+5GOJrx5kPRSpK13qw6e2NqNckcJKbwv2y6Rac0Xn9J
 HbfrfiXg3yP6mZKQB9Gon+4JjLf2SlORzgxWSYq38+UQYaGtk8wF5i8T8uhrn8XIvGSj
 Sy5ecXYxRSpE/kQyQRwd1EY61rS0LFstlDdkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723454682; x=1724059482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfDePbACNEJyXkn1NuDBaQVxTKPG+PH9QdgiWTsQFw4=;
 b=Eax8vj3uDcRGdv6wkoDGDaLCGPhL45U1YH4xeqPuCJkvxzoiPnADdoRiObTgu2NSjg
 OCBtBlbuq/v+LHen3jTHiAo80BOeTCs5fXzsjYLca1M1vdJLF2pJZNXRcesUqz9XCZUA
 ranlBcwewLW0wwfnydpWOYXX8ERDfzWE/P91vdwopKgpGpmzPUwjKfRwP+gION+v08ts
 yRX46YFnbFHdgkhHQ6cf6GQaQI9iPc0sMmWfTkkVf8ctciS8nZ6hMvrpMOQBwqKmOqrf
 DX2pdwlSKnL/NVl770oINpdxcgKI+Mfx2WDqIjU+JvPTEzoEld8q24rtXduZ3VjCOjFa
 H4Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzCeWNeynJ9DvML8v1+gomEU4n58O4hK1bSUu4lrnph38THdIWd0f71mxXSJWXjkxvw7D9838G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyStyAW7Rh63PNOwufe+bQQSoyZsRzmqk22gNFbeLD4K2KZHnWL
 whH2J/sA7MfjCFWQJwuXTRe8bekXZX6krOrpRIptMlZDeByx8CKtVXJoMaS3l3c=
X-Google-Smtp-Source: AGHT+IFflcfI+5IHwTwpaIz9O/DP2+uKDaA2O+8e1r+0AW9GSXVSUe9eIaE5je3jaPNmlMVnVKDTQg==
X-Received: by 2002:a05:6402:5203:b0:5a1:efd1:ca1e with SMTP id
 4fb4d7f45d1cf-5bd0a535968mr4084768a12.2.1723454682034; 
 Mon, 12 Aug 2024 02:24:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a5dfeb9sm1958470a12.61.2024.08.12.02.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 02:24:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:24:39 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 3/9] drm/nouveau: Do not set struct drm_driver.lastclose
Message-ID: <ZrnU16ATX9b3hJAP@phenom.ffwll.local>
References: <20240812083000.337744-1-tzimmermann@suse.de>
 <20240812083000.337744-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812083000.337744-4-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.9.10-amd64 
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

On Mon, Aug 12, 2024 at 10:28:24AM +0200, Thomas Zimmermann wrote:
> Remove the implementation of struct drm_driver.lastclose. The hook
> was only necessary before in-kernel DRM clients existed, but is now
> obsolete. The code in nouveau_vga_lastclose() is performed by
> drm_lastclose().
> 
> v2:
> - update commit description
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
>  drivers/gpu/drm/nouveau/nouveau_vga.c | 7 -------
>  drivers/gpu/drm/nouveau/nouveau_vga.h | 1 -
>  3 files changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index ac7c60fb14d3..4a9a9b9c3935 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1303,7 +1303,6 @@ driver_stub = {
>  			   DRIVER_RENDER,
>  	.open = nouveau_drm_open,
>  	.postclose = nouveau_drm_postclose,
> -	.lastclose = nouveau_vga_lastclose,
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	.debugfs_init = nouveau_drm_debugfs_init,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> index 2525e08938b3..ee637f1fe03d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -127,10 +127,3 @@ nouveau_vga_fini(struct nouveau_drm *drm)
>  	if (runtime && nouveau_is_v1_dsm() && !nouveau_is_optimus())
>  		vga_switcheroo_fini_domain_pm_ops(drm->dev->dev);
>  }
> -
> -
> -void
> -nouveau_vga_lastclose(struct drm_device *dev)
> -{
> -	vga_switcheroo_process_delayed_switch();
> -}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.h b/drivers/gpu/drm/nouveau/nouveau_vga.h
> index 951a83f984dd..63be415d2a44 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.h
> @@ -4,6 +4,5 @@
>  
>  void nouveau_vga_init(struct nouveau_drm *);
>  void nouveau_vga_fini(struct nouveau_drm *);
> -void nouveau_vga_lastclose(struct drm_device *dev);
>  
>  #endif
> -- 
> 2.46.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
