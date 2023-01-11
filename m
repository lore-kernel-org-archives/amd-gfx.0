Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D3C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 23:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0649110E833;
	Wed, 11 Jan 2023 23:02:39 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9994810E833
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 23:02:36 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id ja17so12083981wmb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5DAHiUXNSqP8lsMat4V7Y9pDYdgiNXYeg0YIR9t8tw=;
 b=ijgJVYN6mmNTbTPFO5OqRoZJG72dUQWCDuNXxKwYGwTa0H+jMvm9BpIyRHatxnCL+G
 H98LSjPJpsNaGcsjI/aze5PgnnoHRW8kyHFa6VjVASmpy7N+Pq2lh2SPkWtTXdQsZZVJ
 4IHyqrcso5C29wuZwnx/ROG5bnhHvvZpFV+r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5DAHiUXNSqP8lsMat4V7Y9pDYdgiNXYeg0YIR9t8tw=;
 b=1IcD74w4ojDoht59+UebZeTAomPdU9p+ECOJeF0eHDFukqHCmmlIWHnO+BpsB/WkCN
 SmQs+YK2g/GYafPq/3kkDygZUYF1Cz7nT75xq6cmlkqFv9ch4sZsTIm9UP6/oYhIGU9a
 HzGjOhx9pJC613dMHx0dG1hGVxgqjbug7s9EAJ8NTScRyOwSc+HRh6Yp0cRwOSxJJ7ui
 4pStz9L8PzBeMJxg9ZJ+WWdM9yn7grwdHsVzOX55Bb3fUD4hk+M98EEOIzIFkbWnzyy5
 KdJnF4F+FPlug7OvPhOK2rlqo0nEj9sPuU7PyTrQ11uu25v7BNCOHQL0LAzdZQ63yUF6
 9erg==
X-Gm-Message-State: AFqh2kqQqYHBFIl+BDw0plJQjcuNPzI+q+1K5edFymQUy+GybV/JV1ii
 0NC0Ne08oLKipu7Vv08JIXXQgg==
X-Google-Smtp-Source: AMrXdXu42yEstUzQrpMN6ziaFxtpQwABY5sjgNZ43ZWdGx9iwmPJ1+C7GDfu3P+KAaFELhdK5tZrJg==
X-Received: by 2002:a05:600c:3d91:b0:3d9:103d:9078 with SMTP id
 bi17-20020a05600c3d9100b003d9103d9078mr52671943wmb.22.1673478155135; 
 Wed, 11 Jan 2023 15:02:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 k30-20020a05600c1c9e00b003d9b89a39b2sm22004350wms.10.2023.01.11.15.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 15:02:34 -0800 (PST)
Date: Thu, 12 Jan 2023 00:02:32 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [RFC PATCH 13/17] drm_print: fix stale macro-name in comment
Message-ID: <Y79ACEDu4ePaWMQr@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, seanpaul@chromium.org,
 robdclark@gmail.com, jbaron@akamai.com, gregkh@linuxfoundation.org
References: <20221206003424.592078-1-jim.cromie@gmail.com>
 <20221206003424.592078-14-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206003424.592078-14-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
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
Cc: jani.nikula@intel.com, daniel.vetter@ffwll.ch,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, robdclark@gmail.com, seanpaul@chromium.org,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org, jbaron@akamai.com,
 intel-gvt-dev@lists.freedesktop.org, ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 05, 2022 at 05:34:20PM -0700, Jim Cromie wrote:
> Cited commit uses stale macro name, fix this, and explain better.
> 
> When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
> onto BITs in drm.debug.  This still uses enum drm_debug_category, but
> it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
> This requires that the macro args: DRM_UT_* list must be kept in sync
> and in order.
> 
> Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Should I land this already?
-Daniel

> ---
> . emphasize ABI non-change despite enum val change - Jani Nikula
> . reorder to back of patchset to follow API name changes.
> ---
>  include/drm/drm_print.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 6a27e8f26770..7695ba31b3a4 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
>   *
>   */
>  enum drm_debug_category {
> -	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
> +	/*
> +	 * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
> +	 * the enum-values define BIT()s in drm.debug, so are ABI.
> +	 */
>  	/**
>  	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
>  	 * drm_memory.c, ...
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
