Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832C1C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 08:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E63010E87B;
	Fri,  9 Aug 2024 08:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="DuaxmFf+";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE6210E87B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 08:48:02 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5a5809a3bb9so185100a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1723193280; x=1723798080; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X5AwRwVwTZmkq3oGoDJtamdAtUPilZp0Mb1FEZtX/Us=;
 b=DuaxmFf+Phv8S9HiZgkrru8s81TJ2A+HifXVjq1a8dCIZomnGTiEp/5oTwlw7FLJs8
 3Ozx4MH45MLijTG5vtKkwn1SCVDbgf/RYS6G6KPzKv1QHR2KnDLPGAjoxiUc0LTU4zBp
 5nwJNEPuqR3bWqt3SS25NufSEWhd7oa61Q3zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723193280; x=1723798080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5AwRwVwTZmkq3oGoDJtamdAtUPilZp0Mb1FEZtX/Us=;
 b=TdOMBENKQJezuqUARtMwDRxHi156Q8ISk5IIDd6CuysYd+RqMTHGXKyE9l4IPTcVPz
 cPE3cULhxkKkBw8xXlkK0hcTmKJ2cyoHUYJZMCU6GZ9pbvW+855LC3qTBpbHkd7OwsUh
 /i2tHz7iTvFOqlFBGpUz+4Tm5aZRvttSYlhvojKCAm7tCpl5BV5q3ngcDKvcXRnWJUPP
 qhdbCEUx5f2bwXMA1UJKiu+1yeVkbkCAIf9QeQGHJs5T1vfHt0Rg4V3pEFbL6iBXPdtL
 m2YNODRAYDp95rFnitNLAjVKgC1ZTGuJ6SMRmIpNFBsd1hLg4Ycr2kGvhPzGpyUjjgN6
 cBYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm6o2ZFGofjxU3528VQ9vELZ94nkUnlHXQwG87fXJNqVG1azoKorPv++k08i4kGmcDw84OHRnn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZGMnXnJgepcRVYUOMnx0j0cnktVWnZdxgQfKgCupveFeU+fBv
 XqdvYoU3Pzur+DSHiDdvaFLheev64IoMlHHntPuRn9iaMHVEv4xGbfCdRQBaC24=
X-Google-Smtp-Source: AGHT+IGrDlxJnCmNLqrjUzch8tJq3bfI6vWVJONzmqgEemt+YVn9Bzggh5dLbbui/xxZ9iff2V0O1A==
X-Received: by 2002:a17:907:2d89:b0:a80:91b0:f501 with SMTP id
 a640c23a62f3a-a80aa5cb79dmr40237966b.4.1723193280365; 
 Fri, 09 Aug 2024 01:48:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437bbsm815788066b.121.2024.08.09.01.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 01:47:59 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:47:57 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH 5/8] drm/nouveau: Implement switcheroo reprobe with
 drm_client_dev_hotplug()
Message-ID: <ZrXXvcKeN2w3lZs_@phenom.ffwll.local>
References: <20240807084539.304014-1-tzimmermann@suse.de>
 <20240807084539.304014-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807084539.304014-6-tzimmermann@suse.de>
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

On Wed, Aug 07, 2024 at 10:41:37AM +0200, Thomas Zimmermann wrote:
> Replace the callto drm_fb_helper_output_poll_changed() with a call
> to drm_client_dev_hotplug(). It's equivalent in functionality, but
> use the DRM client infrastructure.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/nouveau/nouveau_vga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> index ee637f1fe03d..ab4e11dc0b8a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -58,8 +58,9 @@ static void
>  nouveau_switcheroo_reprobe(struct pci_dev *pdev)
>  {
>  	struct nouveau_drm *drm = pci_get_drvdata(pdev);
> +	struct drm_device *dev = drm->dev;
>  
> -	drm_fb_helper_output_poll_changed(drm->dev);
> +	drm_client_dev_hotplug(dev);
>  }
>  
>  static bool
> -- 
> 2.46.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
