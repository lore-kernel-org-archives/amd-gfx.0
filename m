Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1349C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 13:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C696611AC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 13:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C696611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3579C6E512;
	Thu, 15 Apr 2021 13:21:26 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2666E512
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 13:21:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id g9so7270938wrx.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=evTMSPPWsjDSCt/BqTT+rrf2SHb4/im2ARce7/nHPGA=;
 b=HDObdOKIBZFbGI0noupV2rQFT7dEvhwUbLyO87HnYkZen0h9MSmx0q7ZZtAlYPpjrV
 XqX8jJ5KpYjDe/UeFC+mxamfz+goUrjHUoljsIflToASY441T2oJ/NcOdp8O+VLTSmeP
 gWhXODCwdtMPni+XLtgesuxHlY5XYv/NkRQJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=evTMSPPWsjDSCt/BqTT+rrf2SHb4/im2ARce7/nHPGA=;
 b=gql7S7xM4rPmQaD3ssYN03h38EXYh34LpGU4RIIy1VJRYLx4x0xj9ab+WvX8dUH13x
 z1eA2+pohihXxgRC81jRf4i2X6wb73t3N8HwARw0yH3hxW7PUJMIqhNHBVMym68/btLE
 PPZWy3r04uz1kPaXe1rwlmHtFCUjm2n7GA3PitDLbo4A3gs10OwjarDEhHpTXh55yh0i
 uEVxudZc5e4o6eSw/PizOloMRLc0C4jx0SmfW35RDPHgx9JBRkjFZXI19DSw6J+qTSsE
 Krd0BG5bhdtosyPL0OxZ+DWaILo1EDO61YKbHc6UFEk6Id1oLA/DPjDB90P4BkXzTH42
 nPJg==
X-Gm-Message-State: AOAM5331RnF1MD8UCKyZnU8J0fCAM1iLh7ugsJP4Zc3SdgvX4+w45i+J
 Wlh1K7ZF8NBbmX+5EAyMPK14TQ==
X-Google-Smtp-Source: ABdhPJyapv3SICSDUH7gbFUJPMlWnDA0q7t8TMzMLaKKqSfufxTyth1q/N7zr3wNvZtiBgPcxK1Vdw==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr3556812wrt.291.1618492883887; 
 Thu, 15 Apr 2021 06:21:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z66sm2884216wmc.4.2021.04.15.06.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 06:21:23 -0700 (PDT)
Date: Thu, 15 Apr 2021 15:21:21 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/7] drm/ttm: Don't override vm_ops callbacks, if set
Message-ID: <YHg90cqFr0gIqiNN@phenom.ffwll.local>
References: <20210415101740.21847-1-tzimmermann@suse.de>
 <20210415101740.21847-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415101740.21847-2-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com, airlied@linux.ie,
 nouveau@lists.freedesktop.org, Felix.Kuehling@amd.com, sroland@vmware.com,
 nirmoy.das@amd.com, dri-devel@lists.freedesktop.org, ray.huang@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sam@ravnborg.org, christian.koenig@amd.com,
 zackr@vmware.com, emil.velikov@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 15, 2021 at 12:17:34PM +0200, Thomas Zimmermann wrote:
> Drivers may want to set their own callbacks for a VM area. Only set
> TTM's callbacks if the vm_ops field is clear.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index b31b18058965..bf4a213bc66c 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -534,7 +534,12 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_device *bdev,
>  
>  static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_struct *vma)
>  {
> -	vma->vm_ops = &ttm_bo_vm_ops;
> +	/*
> +	 * Drivers may want to override the vm_ops field. Otherwise we
> +	 * use TTM's default callbacks.
> +	 */
> +	if (!vma->vm_ops)
> +		vma->vm_ops = &ttm_bo_vm_ops;
>  
>  	/*
>  	 * Note: We're transferring the bo reference to
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
