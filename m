Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5D5C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 17:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA24910E306;
	Tue, 17 Jan 2023 17:59:47 +0000 (UTC)
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com
 (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C651F10E306
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=EhbUKCuhJhOF6x319qgWDx4rLzmMkP7HhMVO8AFeKwI=;
 b=ju1cyykZt3D3gt4DKPms5hJPyhpaY7duDcM4yK7ngFwz1sWKtHgeo6wJfX4W/d2c4qNCVh24lzlIl
 ucuHOL2y4xv53e0nj7N8OFHwUU9xIJe1m+RbpkFjjA6MapU2t7sxiynOd2yTEnecjMIOBYYw+RSWUv
 YqudBfHffmh7B3XGFR3+ehyj0yNkmAmWU2JEvQbGKzBO4t0HAZiB8IWJBWyfamZAZcY4g/IUwxHxQ9
 zv3oCfXQ+x55bZkuixj5EuXfkt1YsLufrUMBq0o8zcxAUKllqYV22SNXP1MUkzTxLuZu4WZ4pMwakA
 DSiWdZzZZBGdnSSFNXTdTSt6ISSjkuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=EhbUKCuhJhOF6x319qgWDx4rLzmMkP7HhMVO8AFeKwI=;
 b=N+m0cDBk693cXhN7msqnFgKWEf2+EYbs9F71HyHLk508RRzpbtzSEZYjDxHSI0FJMO+7WHRIX6uGx
 lrtEt3xDA==
X-HalOne-ID: b7bff03f-9690-11ed-a6e3-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay6 (Halon) with ESMTPSA
 id b7bff03f-9690-11ed-a6e3-cde5ad41a1dd;
 Tue, 17 Jan 2023 17:59:43 +0000 (UTC)
Date: Tue, 17 Jan 2023 18:59:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [PATCH 2/2] drm_print: Remove deprecated
 DRM_DEBUG_KMS_RATELIMITED()
Message-ID: <Y8biDpOelzNMXuQ+@ravnborg.org>
References: <20230117174447.21870-1-nirmoy.das@intel.com>
 <20230117174447.21870-2-nirmoy.das@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117174447.21870-2-nirmoy.das@intel.com>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 17, 2023 at 06:44:47PM +0100, Nirmoy Das wrote:
> There are no current users of DRM_DEBUG_KMS_RATELIMITED()
> so remove it.
Thanks
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  include/drm/drm_print.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index a44fb7ef257f..c3753da97c4e 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -605,9 +605,6 @@ void __drm_err(const char *format, ...);
>  #define drm_dbg_kms_ratelimited(drm, fmt, ...) \
>  	__DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
>  
> -/* NOTE: this is deprecated in favor of drm_dbg_kms_ratelimited(NULL, ...). */
> -#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
> -
>  /*
>   * struct drm_device based WARNs
>   *
> -- 
> 2.39.0
