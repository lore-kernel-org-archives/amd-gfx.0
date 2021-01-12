Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B41C43333
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7357E2311F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7357E2311F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A106E161;
	Tue, 12 Jan 2021 09:02:07 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8DE6E15C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:02:06 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id 190so1196295wmz.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rZz2K+xmI9KYAQXkeWraiWvHtNnjuShlY4VafGUK3lg=;
 b=IgGCJFvTXWnjCxp5A8MZH4yixnA/mor/V1N+X/j5Tzh52IfA3hnsK2/eeRKgG01Ho+
 b5coBGLmeV9a24ssSTZVpUZKUlmuC7+R6uRRxQRoUTDET1tztcNwX3FZUneoh2wReWK5
 QmeE4NOnL7fi+wQ0EkqDACfIx+vUSQJxsVVFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rZz2K+xmI9KYAQXkeWraiWvHtNnjuShlY4VafGUK3lg=;
 b=rKuhpPgzOvEwHq7nsNmgZxQHcMwY1+K8Z7OnLMFqspHXkc3ZPeYfLUFggYQUOXjY71
 F7+lnyJzZEhRMhCizv5b242YoFivw1GJG/Wc+QReaJ+mYQWXXm0Ljvz0Ins93J5yHvqQ
 lHVXZSqKrxJISU+HuJpxep7VRm/bMfvTpujl/UvBrFSuB0XJuUYBkRMUXk6+MxhJI34z
 7Ryi+1IWgGSJVuAS3otKu2jq3nKJNAqke6wLgPviVasBxLkpMyZlyJps6pAcyScEbEbN
 CzFgJa3cezXS4PYpC6+GvHkSSTLvoHD2e0Lhv0L55ikghrHgh0R9y11jfSs1L2rgQo4l
 csTA==
X-Gm-Message-State: AOAM530Rk1rCXUa29OSgpNomqUqSXBWp0QRr4wVg5fcUt2qwqVUUeH2Y
 ncocVe3HjH8Qi9iOmobxQDqlzg==
X-Google-Smtp-Source: ABdhPJy1qvHQ4l2ruCiangPZFDyO1qWSdxx0i9kHmcfz8VakWj32hrpkcKv7cGEHubZIlIismq9o2Q==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr2487290wmi.161.1610442125309; 
 Tue, 12 Jan 2021 01:02:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v11sm3726018wrt.25.2021.01.12.01.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:02:04 -0800 (PST)
Date: Tue, 12 Jan 2021 10:02:02 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/6] drm: Build drm_memory.o only for legacy drivers
Message-ID: <X/1litpudYSPhFMA@phenom.ffwll.local>
References: <20210112081035.6882-1-tzimmermann@suse.de>
 <20210112081035.6882-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112081035.6882-4-tzimmermann@suse.de>
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 09:10:32AM +0100, Thomas Zimmermann wrote:
> The file contains I/O-memory functions that are only used by legacy
> drivers.

Yay!

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index fefaff4c832d..ba0ecb7756c6 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -5,7 +5,7 @@
>  
>  drm-y       :=	drm_auth.o drm_cache.o \
>  		drm_file.o drm_gem.o drm_ioctl.o drm_irq.o \
> -		drm_memory.o drm_drv.o \
> +		drm_drv.o \
>  		drm_sysfs.o drm_hashtab.o drm_mm.o \
>  		drm_crtc.o drm_fourcc.o drm_modes.o drm_edid.o \
>  		drm_encoder_slave.o \
> @@ -20,7 +20,8 @@ drm-y       :=	drm_auth.o drm_cache.o \
>  		drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o \
>  		drm_managed.o drm_vblank_work.o
>  
> -drm-$(CONFIG_DRM_LEGACY) += drm_legacy_misc.o drm_bufs.o drm_context.o drm_dma.o drm_scatter.o drm_lock.o
> +drm-$(CONFIG_DRM_LEGACY) += drm_bufs.o drm_context.o drm_dma.o drm_legacy_misc.o drm_lock.o \
> +		drm_memory.o drm_scatter.o
>  drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
>  drm-$(CONFIG_DRM_VM) += drm_vm.o
>  drm-$(CONFIG_COMPAT) += drm_ioc32.o
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
