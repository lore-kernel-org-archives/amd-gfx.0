Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 11:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BD56142A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 11:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BD56142A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56E76EE33;
	Thu, 29 Apr 2021 11:23:23 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DAD6EE27
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 11:23:22 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id n84so8431272wma.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MME77P409e6L4Lqp73Kfmz6ovDpO6MGhxVXUEs9x2GA=;
 b=ahhaL+yBd0njOg+bQZjElRymwkzm8hHU02kfzW8LytUqS7m68FUGGoYOU4SEPUDR2s
 SUx2pOe7BG1rD6v390gGVVJkzinfZQ9DDfx8Huzv9pbUOrNVovt6xSEoz5tZv70H1Gw6
 7VvsOKKpktPWLgVZIR97cUTvI/cNF6i0vFmMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MME77P409e6L4Lqp73Kfmz6ovDpO6MGhxVXUEs9x2GA=;
 b=ly8L98E20bfdiKl5GHJ6MbEnvK6YiMPvXdSCMOcslVP0Gv+qHs7Vl0gFepbXmEUuxQ
 Oqkgslf/+S7A1tyDZT5W5nBzl2HkfjEUZDr0AjmuFlkgHhN2HY9lCBx/U3I1qj0ibqiL
 cepUmAS7ve4J7OMhEq1j0+N76phQYRW2eGqN/Qbee+5kgG2X9VX6JHo4ZM3EYe7L+ozF
 xhpKWzOuf/H/OAdIQppn54VqT/sLK61Qr7n7N0Ntq3U0WN5K1U2lmecNvetowsViqKt+
 KuhzICjC3mVhqzom65YLk8YdOr2U0wSXWWj0kPxtVQZEb9Vsj3WTx0VVrRGJc1Z87WlF
 cS/w==
X-Gm-Message-State: AOAM530nbLJiZd/74mw6id24PJp4NkjxDyYNpuLgp71NMgNlBWVMnioi
 h2hVgPB00qnKcPigJVv8ZZxLgw==
X-Google-Smtp-Source: ABdhPJzSKV9BRDc/LcwLGozOyN6YQSr+Q/Ou/T5wmRppbd31xUIBnqsxvhkYwtV7GT5Rw+cgU/XCAA==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr2054224wmd.76.1619695401701; 
 Thu, 29 Apr 2021 04:23:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m15sm4282056wrx.32.2021.04.29.04.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Apr 2021 04:23:20 -0700 (PDT)
Date: Thu, 29 Apr 2021 13:23:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs  with
 drm_dev_enter/exit
Message-ID: <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: ckoenig.leichtzumerken@gmail.com, gregkh@linuxfoundation.org,
 daniel.vetter@ffwll.ch, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 ppaalanen@gmail.com, helgaas@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Alexander.Deucher@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 28, 2021 at 11:12:00AM -0400, Andrey Grodzovsky wrote:
> With this calling drm_dev_unplug will flush and block
> all in flight IOCTLs
> 
> Also, add feature such that if device supports graceful unplug
> we enclose entire IOCTL in SRCU critical section.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Nope.

The idea of drm_dev_enter/exit is to mark up hw access. Not entire ioctl.

Especially not with an opt-in flag so that it could be shrugged of as a
driver hack. Most of these ioctls should have absolutely no problem
working after hotunplug.

Also, doing this defeats the point since it pretty much guarantees
userspace will die in assert()s and stuff. E.g. on i915 the rough contract
is that only execbuf (and even that only when userspace has indicated
support for non-recoverable hw ctx) is allowed to fail. Anything else
might crash userspace.

You probably need similar (and very precisely defined) rules for amdgpu.
And those must definitely exclude any shard ioctls from randomly failing
with EIO, because that just kills the box and defeats the point of trying
to gracefully handling hotunplug and making sure userspace has a chance of
survival. E.g. for atomic everything should continue, including flip
completion, but we set all outputs to "disconnected" and send out the
uevent. Maybe crtc enabling can fail too, but that can also be handled
through the async status we're using to signal DP link failures to
userspace.

I guess we should clarify this in the hotunplug doc?

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_ioctl.c | 15 +++++++++++++--
>  include/drm/drm_drv.h       |  6 ++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index d273d1a8603a..5882ef2183bb 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -815,7 +815,7 @@ long drm_ioctl(struct file *filp,
>  	const struct drm_ioctl_desc *ioctl = NULL;
>  	drm_ioctl_t *func;
>  	unsigned int nr = DRM_IOCTL_NR(cmd);
> -	int retcode = -EINVAL;
> +	int idx, retcode = -EINVAL;
>  	char stack_kdata[128];
>  	char *kdata = NULL;
>  	unsigned int in_size, out_size, drv_size, ksize;
> @@ -884,7 +884,18 @@ long drm_ioctl(struct file *filp,
>  	if (ksize > in_size)
>  		memset(kdata + in_size, 0, ksize - in_size);
>  
> -	retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +	if (drm_core_check_feature(dev, DRIVER_HOTUNPLUG_SUPPORT)) {
> +		if (drm_dev_enter(dev, &idx)) {
> +			retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +			drm_dev_exit(idx);
> +		} else {
> +			retcode = -ENODEV;
> +			goto err_i1;
> +		}
> +	} else {
> +		retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +	}
> +
>  	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
>  		retcode = -EFAULT;
>  
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b439ae1921b8..63e05cec46c1 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -94,6 +94,12 @@ enum drm_driver_feature {
>  	 * synchronization of command submission.
>  	 */
>  	DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
> +	/**
> +	 * @DRIVER_NO_HOTUNPLUG_SUPPORT:
> +	 *
> +	 * Driver support gracefull remove.
> +	 */
> +	DRIVER_HOTUNPLUG_SUPPORT         = BIT(7),
>  
>  	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
