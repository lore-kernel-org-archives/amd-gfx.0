Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EDCC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A2C206FA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jG11Qy3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A2C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAADF6E12D;
	Mon, 22 Jun 2020 09:35:06 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60706E12D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 09:35:05 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z13so4168844wrw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=56PznvIiJcuQgBejMIKzLS8u6VayrEALfsbNc2P7T2w=;
 b=jG11Qy3gBYVIjYgW/Ta42AM7TqM74H7MbV/H3v5ykd/cA+Z6OqD/rMdF20QWOeeLdB
 aFan9xX+kMgoYiPNm7LpqVxylru9BEFeyZB2rwaNL2uH/XWB75NgBTdWvOmz/v8Uacm3
 zwzBm8prcEE4D9Pi9hpG1uhrLuavB2t2wuOyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=56PznvIiJcuQgBejMIKzLS8u6VayrEALfsbNc2P7T2w=;
 b=djmJwRtTgVuQH/1nQVjO6FPRJVDn/K2DIodV15f+7gncaXui/fpekzlxozL5bqWHTx
 syivRgW4Xkw1wdProsqmTUn9lHSdedq1H6+i8CwqRyXLTsvm2tSCmClqtLVy7rlaheyx
 Wtd0EkjJnJ4uXckf0dyF6XSuXJp3A/GH7HYQSx4+JXB8QNf4JH2Bmg5D36UWSkkzEcga
 3EjtYHft5vnk3RnP2ta3ThmAtlIV53LRnCG9ZPZCn/6nrRsutVPJlaEmbTDbVYqSJVfQ
 0ze7ZPh74VmNTBR4jH1eCksZ8rF+96zisznzQ35gQeUsLbUoVqdKlUPyDqGjgTe8K2ge
 0E1w==
X-Gm-Message-State: AOAM5318lJ8W5ooB/ZQjzziqCI7uAwoyfaa5wIaIg6Jw/Jgcys9Q7Rng
 YhTyl8v6N6zSCreILGb1NdDKVQ==
X-Google-Smtp-Source: ABdhPJyNDS6iUQoaorC7cr4nACPTJGyW2marTjzaaCpG8lasCYmYuWFT1LcgSq1ymomiYYjn0dfEOA==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr17656682wrp.369.1592818504507; 
 Mon, 22 Jun 2020 02:35:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 63sm18592902wra.86.2020.06.22.02.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:35:03 -0700 (PDT)
Date: Mon, 22 Jun 2020 11:35:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v2 1/8] drm: Add dummy page per device or GEM object
Message-ID: <20200622093501.GZ20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
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

On Sun, Jun 21, 2020 at 02:03:01AM -0400, Andrey Grodzovsky wrote:
> Will be used to reroute CPU mapped BO's page faults once
> device is removed.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/drm_file.c  |  8 ++++++++
>  drivers/gpu/drm/drm_prime.c | 10 ++++++++++
>  include/drm/drm_file.h      |  2 ++
>  include/drm/drm_gem.h       |  2 ++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index c4c704e..67c0770 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -188,6 +188,12 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
>  			goto out_prime_destroy;
>  	}
>  
> +	file->dummy_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!file->dummy_page) {
> +		ret = -ENOMEM;
> +		goto out_prime_destroy;
> +	}
> +
>  	return file;
>  
>  out_prime_destroy:
> @@ -284,6 +290,8 @@ void drm_file_free(struct drm_file *file)
>  	if (dev->driver->postclose)
>  		dev->driver->postclose(dev, file);
>  
> +	__free_page(file->dummy_page);
> +
>  	drm_prime_destroy_file_private(&file->prime);
>  
>  	WARN_ON(!list_empty(&file->event_list));
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 1de2cde..c482e9c 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -335,6 +335,13 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>  
>  	ret = drm_prime_add_buf_handle(&file_priv->prime,
>  			dma_buf, *handle);
> +
> +	if (!ret) {
> +		obj->dummy_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!obj->dummy_page)
> +			ret = -ENOMEM;
> +	}
> +
>  	mutex_unlock(&file_priv->prime.lock);
>  	if (ret)
>  		goto fail;
> @@ -1006,6 +1013,9 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
>  		dma_buf_unmap_attachment(attach, sg, DMA_BIDIRECTIONAL);
>  	dma_buf = attach->dmabuf;
>  	dma_buf_detach(attach->dmabuf, attach);
> +
> +	__free_page(obj->dummy_page);
> +
>  	/* remove the reference */
>  	dma_buf_put(dma_buf);
>  }
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 19df802..349a658 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -335,6 +335,8 @@ struct drm_file {
>  	 */
>  	struct drm_prime_file_private prime;
>  

Kerneldoc for these please, including why we need them and when. E.g. the
one in gem_bo should say it's only for exported buffers, so that we're not
colliding security spaces.

> +	struct page *dummy_page;
> +
>  	/* private: */
>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
>  	unsigned long lock_count; /* DRI1 legacy lock count */
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 0b37506..47460d1 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -310,6 +310,8 @@ struct drm_gem_object {
>  	 *
>  	 */
>  	const struct drm_gem_object_funcs *funcs;
> +
> +	struct page *dummy_page;
>  };

I think amdgpu doesn't care, but everyone else still might care somewhat
about flink. That also shares buffers, so also needs to allocate the
per-bo dummy page.

I also wonder whether we shouldn't have a helper to look up the dummy
page, just to encode in core code how it's supposedo to cascade.
-Daniel

>  
>  /**
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
