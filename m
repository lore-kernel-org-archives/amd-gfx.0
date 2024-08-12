Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B742C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E370910E125;
	Mon, 12 Aug 2024 09:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="NbM3+Q/c";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB39A10E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 09:23:48 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a688e726755so48471166b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1723454627; x=1724059427; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QdliwoBicYTW7oIiEkHaSLOzFyeZLdkNCBChomrwU0k=;
 b=NbM3+Q/cjR18hrWVzBghg59JvvvhK0nY95h8eI809RX1WUIQKHqQb0IMTAoadc3kl+
 JLLYVfcOIpbCVcYzjrew7kixGMJTuY11JV+7kTyQoXz3vqIuAcQpmXSVqmGfJEMPkgdm
 9YNCy9HTfbsIAjQ7bBFRQVRzNgEyK10+030B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723454627; x=1724059427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdliwoBicYTW7oIiEkHaSLOzFyeZLdkNCBChomrwU0k=;
 b=YOHbvvPBZKsBdQCJdAsRlApEarZqgwYSsIfh1mpgSELspYidUvcRgwrmkonlW5RlGZ
 AIbqHZNBE69sSNXHeb5b0vlJwRieJPkfgC+IivKKoBcWxW2qJKJcP2iDQk+CFP2aICGj
 W/KorV5lzEQtsyGs1TQEnBbPWtWi+C2tWh+crSBi0DZYJfIbsT2HJSgshyZxOkKscwaC
 TrYTv0AgAUdxvRoedgjOlv6vgGBEeMkoQH9XdWxYs7uC/KjT4W0w2Qxhoqj0qLoAIZYV
 lOLnlQAnYG6DuCnJlAdQs8VgcF/pupKJNy8BIIo/MUBEPFZtMFjx/5HM+xke4vaBFLhs
 m8hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSM9pdDxYzi5aXhExs56SADG0cBdpZuIRRkYwxa3POZdOQXDv4GIMiT5CRvHDl0Wo20DtzchCHuEnrfomfCfP4AqdQQNaIZmxtNxyk+w==
X-Gm-Message-State: AOJu0Yzzm4dIxzA/x7eBoquePHTiSVqMJ9We2mbvjqSQ1fjwALDrGzL2
 fMdolZH5Luq9aV9UJvDn3KeqiQ0sgiJx2jw5byKq4DfuFs7sCkNFDra67K6Q1Ig=
X-Google-Smtp-Source: AGHT+IFzb52e/X0DQjkZlhukRHYFg8Ep5Ss6f9A0BomckYKgO7DfJZH9YerL+hOqxAiB4ZdM31FYDw==
X-Received: by 2002:a17:907:96a2:b0:a80:a23e:fbf9 with SMTP id
 a640c23a62f3a-a80aa65f3b5mr376486866b.6.1723454627085; 
 Mon, 12 Aug 2024 02:23:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb0e1355sm213791366b.74.2024.08.12.02.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 02:23:46 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:23:44 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 1/9] drm: Do delayed switcheroo in drm_lastclose()
Message-ID: <ZrnUoPuYv0v-yx79@phenom.ffwll.local>
References: <20240812083000.337744-1-tzimmermann@suse.de>
 <20240812083000.337744-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812083000.337744-2-tzimmermann@suse.de>
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

On Mon, Aug 12, 2024 at 10:28:22AM +0200, Thomas Zimmermann wrote:
> Amdgpu and nouveau call vga_switcheroo_process_delayed_switch() from
> their lastclose callbacks. Call it from drm_lastclose(), so that the
> driver functions can finally be removed. Only PCI devices with enabled
> switcheroo do the delayed switching. The call has no effect on other
> hardware.
> 
> v2:
> - move change to drm_lastclose() (Sima)
> - update docs for vga_switcheroo_process_delayed_switch()
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

A bit an aside: The entire vgaswitcheroo code is still a midlayer mess,
where the locking is at the wrong layers resulting in the can_switch check
potentially being racy. But that's a different can of worms.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_file.c       | 4 ++++
>  drivers/gpu/vga/vga_switcheroo.c | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 714e42b05108..513bef816ae9 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -38,6 +38,7 @@
>  #include <linux/pci.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
> +#include <linux/vga_switcheroo.h>
>  
>  #include <drm/drm_client.h>
>  #include <drm/drm_drv.h>
> @@ -404,6 +405,9 @@ void drm_lastclose(struct drm_device * dev)
>  	drm_dbg_core(dev, "driver lastclose completed\n");
>  
>  	drm_client_dev_restore(dev);
> +
> +	if (dev_is_pci(dev->dev))
> +		vga_switcheroo_process_delayed_switch();
>  }
>  
>  /**
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index 365e6ddbe90f..18f2c92beff8 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -926,8 +926,7 @@ static void vga_switcheroo_debugfs_init(struct vgasr_priv *priv)
>  /**
>   * vga_switcheroo_process_delayed_switch() - helper for delayed switching
>   *
> - * Process a delayed switch if one is pending. DRM drivers should call this
> - * from their ->lastclose callback.
> + * Process a delayed switch if one is pending.
>   *
>   * Return: 0 on success. -EINVAL if no delayed switch is pending, if the client
>   * has unregistered in the meantime or if there are other clients blocking the
> -- 
> 2.46.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
