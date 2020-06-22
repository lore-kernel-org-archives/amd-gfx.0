Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E6C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43113206F1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GI9qkNrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43113206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D74C6E200;
	Mon, 22 Jun 2020 09:56:49 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BA06E200
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 09:56:47 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f18so2526533wml.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F7tRoso4okHgzloM/c3qrplngWYdvfBJ4ANn6S/Yhuc=;
 b=GI9qkNrz795/XotIC7DGPNom7/J3QoFtoLFiMwfSithOAX+bHMZyCdSNEyK42nAxLs
 ZbGGwh7UfxQIeYteIVDZAqyhPvntED264sIJaAHD8WLqgeAVKWlTCTMjmyauUrGARlOp
 o+k+xd3168iwAf00wJb3cfAnDfgJDvPhZ+gAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F7tRoso4okHgzloM/c3qrplngWYdvfBJ4ANn6S/Yhuc=;
 b=h8VfFekUoK2DrMlDIrtNm/ZfPGWBjsaILwUsQL7/V4lKBpNNYYc0dhjPgS4w6+fpr6
 ioRPr4zqqPei74Oo9LtTB3ts4wHJeu47qULtn9OSus5SxCp6U7dI2i21Ej6KB4vXJSXN
 Ps/Jn7Xc+UVk+Q4cXqVDIMYczwtAdSv2sM7MyF0l5mR6SuwhIjW3M3I64C7bK3zR4j8J
 e8E/ajRzLKcqUqxk98rf9m3yeUsc2ASaWRCZXF1BSXR1svq4Q+gpKuH7VlNlbqPEFy2H
 Pj+BZT6dAbfE3FtFRknEDrhPduFFO8boCFsxwaT6MFaQCxZBg0umkx4XH0cURiVT54xw
 t2AQ==
X-Gm-Message-State: AOAM5314HtI/4kOxjQh6JB/ioI/ewVUw6tmOs/VHQqON5G+3huXORH6w
 nanUxMEH2huVHYaaINcKsKgMG6Giwfg=
X-Google-Smtp-Source: ABdhPJxCL4sm4S5sIMUus72M9EfcShIJ7FollomcgsD0Mru0S9yrMPUxxMXfnEQZdFzL8Vpp1+iTTQ==
X-Received: by 2002:a1c:b7d5:: with SMTP id
 h204mr17599853wmf.100.1592819806471; 
 Mon, 22 Jun 2020 02:56:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c25sm4335675wml.46.2020.06.22.02.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:56:45 -0700 (PDT)
Date: Mon, 22 Jun 2020 11:56:43 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v2 6/8] drm/amdgpu: Unmap entire device address space on
 device remove.
Message-ID: <20200622095643.GH20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-7-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592719388-13819-7-git-send-email-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 ckoenig.leichtzumerken@gmail.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 21, 2020 at 02:03:06AM -0400, Andrey Grodzovsky wrote:
> Use the new TTM interface to invalidate all exsisting BO CPU mappings
> form all user proccesses.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 43592dc..6932d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1135,6 +1135,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
>  	drm_dev_unplug(dev);
> +	ttm_bo_unmap_virtual_address_space(&adev->mman.bdev);
>  	amdgpu_driver_unload_kms(dev);

Hm a ttm, or maybe even vram helper function which wraps drm_dev_unplug +
ttm unmapping into one would be nice I think? I suspect there's going to
be more in the future here.
-Daniel

>  
>  	pci_disable_device(pdev);
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
