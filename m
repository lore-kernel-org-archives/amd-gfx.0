Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE5C11D0C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19ED2467A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 18:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TbV/sKc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19ED2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48A86EE2B;
	Thu, 20 Feb 2020 18:10:01 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8EE6EE2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 18:09:59 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id e8so5704317wrm.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xDxwz2/yKNwMtFCP3/U101Ym2o1nJcRuFA46gL2IxLo=;
 b=TbV/sKc5aCZTXsYxFu0A/49N+OzwF6J+Acp3GgCvYy0vitHUcwvDHXoy3AveUQHFSE
 /gVjZB7pJ+KPHThzCdhNyYOo0dl0KXKTButkhQWgARJDuBxsSUFzKVXwGK5Y4jrllLgz
 8mQy41Y8XzqeX4mb0hQ5idmXZWnc58DA44lSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xDxwz2/yKNwMtFCP3/U101Ym2o1nJcRuFA46gL2IxLo=;
 b=dXiKRlZlwCekjbTfW3fjHaVp9aD1wfeAVf8t7SNfuMAGZmVQmKkjSZehxN8quqflPT
 3hjWpOFxcqcgSJaiaHSm1X838nfLG1G7CBUcYe749XpmX+iMSFR7yPOaJmdO2ru3nSJ4
 IzlnONmMXBeidDqiPt5KLIaCypWSZUu3k5zHrcfU8GYz4HFSFKdztfL8lNIUnMfl542l
 jfbbX4F5SB9pCcDuZKym+iERzbAVz8YR4uRAlu9aRJeNgugWxs1RTLgyunjov0VQVMau
 7gBVdq6yjOd70PhQqFPyyZ5f61xHZLE2E2PW3c/ZsOKCKVhA8YtfKIlZ2TjhrNllq2Sq
 hyLw==
X-Gm-Message-State: APjAAAVrmdes+BEfX8kA06W0SMEm3Tl3fx605qtN7T8fr+AAEDKwwXkn
 k0pa5bhHD8fJrYgsS2f1HQsT0g==
X-Google-Smtp-Source: APXvYqyzpU8hIRwkXXlEKJvnpazDtr1Nw8MAM8kfp8lLZurRUJl0JJ09BmFt5Ccz+GYdf2rv/kNGlw==
X-Received: by 2002:adf:e692:: with SMTP id r18mr43909745wrm.413.1582222198596; 
 Thu, 20 Feb 2020 10:09:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q3sm86108wmj.38.2020.02.20.10.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 10:09:57 -0800 (PST)
Date: Thu, 20 Feb 2020 19:09:55 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [PATCH 6/8] drm/vram-helper: don't use ttm bo->offset v2
Message-ID: <20200220180955.GT2363188@phenom.ffwll.local>
References: <20200219135322.56463-1-nirmoy.das@amd.com>
 <20200219135322.56463-7-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219135322.56463-7-nirmoy.das@amd.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, amd-gfx@lists.freedesktop.org,
 airlied@linux.ie, kenny.ho@amd.com, brian.welty@intel.com,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 nirmoy.das@amd.com, linux-graphics-maintainer@vmware.com, kraxel@redhat.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, sean@poorly.run,
 christian.koenig@amd.com, bskeggs@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2020 at 02:53:20PM +0100, Nirmoy Das wrote:
> Calculate GEM VRAM bo's offset within vram-helper without depending on
> bo->offset
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/drm_gem_vram_helper.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index 92a11bb42365..3edf5f241c15 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -198,6 +198,21 @@ u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo)
>  }
>  EXPORT_SYMBOL(drm_gem_vram_mmap_offset);
> 
> +/**
> + * drm_gem_vram_pg_offset() - Returns a GEM VRAM object's page offset
> + * @gbo:	the GEM VRAM object
> + *
> + * Returns:
> + * The buffer object's page offset, or
> + * 0 with a warning when memory manager node of the buffer object is NULL
> + * */

We generally don't add full formal kerneldoc for internal functions like
this. It won't get pulled into generated docs and generally just bitrots.
Just informal comment if it's really tricky, but the function name here is
clear enough I think.

So with the comment removed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +static s64 drm_gem_vram_pg_offset(struct drm_gem_vram_object *gbo)
> +{
> +	if (WARN_ON_ONCE(!gbo->bo.mem.mm_node))
> +		return 0;
> +	return gbo->bo.mem.start;
> +}
> +
>  /**
>   * drm_gem_vram_offset() - \
>  	Returns a GEM VRAM object's offset in video memory
> @@ -214,7 +229,7 @@ s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo)
>  {
>  	if (WARN_ON_ONCE(!gbo->pin_count))
>  		return (s64)-ENODEV;
> -	return gbo->bo.offset;
> +	return drm_gem_vram_pg_offset(gbo) << PAGE_SHIFT;
>  }
>  EXPORT_SYMBOL(drm_gem_vram_offset);
> 
> --
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
