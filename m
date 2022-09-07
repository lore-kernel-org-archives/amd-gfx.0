Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB46C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 06:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D584810E38F;
	Wed,  7 Sep 2022 06:59:54 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF4810E39B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 06:59:52 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id 29so13195602edv.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Sep 2022 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date; bh=qvR1N7BkwDYnsAvrsfaIO11nwQpKCU3X2O+a+Y27DUY=;
 b=JboZiw5UMpW3fLQ7FupCjwd6aK+mUdgjr5hh3TDItIM8ud3MPqItdIZvSBy6At4SrH
 PwHoYA4AU7ZjeZqaYWaA3JMJIRefSwml0t4qwc+ktxSSMu3EjO0DighbDKTn3xqOODKU
 8aA5FL4HALl1QQW2k4T0rKr+B9yknpX5DSbnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=qvR1N7BkwDYnsAvrsfaIO11nwQpKCU3X2O+a+Y27DUY=;
 b=Apuz1bQhoLnwl+QK4TJ7RbYPZe8NH2cBWFkBie3pQT3MoxTa6QglmNNycVQ8pF29cK
 5FjY6dMYyvy7TxbF1pdeHT3a/3P9OFXMxmKlHxe3aBrLdl7eHkTwSDllkXTHOKuZ1VBi
 b8blXPxfHUGtSllkgX3DG5NvmrVMel0p7lQHx2bXDuJ3n9V961a2ZGVEW1avTt2oOAQQ
 Z+87apJvHZHgYf/RBJFktoP2zYu8A4CorOC+QCscNnN8rUZuiQVNkcJMBeH7h4rA6Gsx
 n8SqqGwdkSsIpra1/S91QdB4okK2nKYg5oZqrhLm3nz/iC7eCLR68jVeFw6VzYVD88rb
 dL5Q==
X-Gm-Message-State: ACgBeo0Vw4PBZATzd7mX72aqcj341wAeJHbHCF9N90n+YToeRQMNdqSr
 YmZ5HxCC/yFZRp/BCzT9wO1nYw==
X-Google-Smtp-Source: AA6agR5JW86JYwYYzN91pflVev5axL6S1Bv3lsKRf4XqvatlwpwQmUIlpWFZiPfqhA85TeaL1Xn6kg==
X-Received: by 2002:a05:6402:5cd:b0:446:5965:f4af with SMTP id
 n13-20020a05640205cd00b004465965f4afmr1916771edx.12.1662533990421; 
 Tue, 06 Sep 2022 23:59:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 s25-20020a170906bc5900b007081282cbd8sm7824571ejv.76.2022.09.06.23.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 23:59:49 -0700 (PDT)
Date: Wed, 7 Sep 2022 08:59:48 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH v6 39/57] dyndbg/drm: POC add tracebits sysfs-knob
Message-ID: <YxhBZLAasKaBPEDT@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 seanpaul@chromium.org, robdclark@gmail.com,
 linux@rasmusvillemoes.dk, joe@perches.com
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-40-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-40-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
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
Cc: robdclark@gmail.com, gregkh@linuxfoundation.org,
 intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, jbaron@akamai.com,
 seanpaul@chromium.org, dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 joe@perches.com, intel-gvt-dev@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Sep 04, 2022 at 03:41:16PM -0600, Jim Cromie wrote:
> clone DRM.debug interface to DRM.tracebits: ie map bits to
> drm-debug-categories, except this interface enables messages to
> tracefs, not to syslog.
> 
> 1- we reuse the class-map added previously.
>    this reflects the single source of both syslog/trace events
> 
> 2- add a 2nd struct ddebug_classes_bitmap_param
>    refs 1, reusing it.
>    flags = "T", to enable trace-events on this callsite.
> 
> 3- module_param_cb([2]) - does the sysfs part
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

All the drm patches (excluding nouveau) I haven't commented on:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I think nouveau I'll leave up to nouveau folks.
-Daniel



> ---
>  drivers/gpu/drm/drm_print.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index c50edbf443d3..75d0cecd7e86 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -45,6 +45,9 @@
>  unsigned long __drm_debug;
>  EXPORT_SYMBOL(__drm_debug);
>  
> +unsigned long __drm_trace;
> +EXPORT_SYMBOL(__drm_trace);
> +
>  MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
>  "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
>  "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
> @@ -77,6 +80,13 @@ static struct ddebug_class_param drm_debug_bitmap = {
>  	.map = &drm_debug_classes,
>  };
>  module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
> +
> +static struct ddebug_class_param drm_trace_bitmap = {
> +	.bits = &__drm_trace,
> +	.flags = "T",
> +	.map = &drm_debug_classes,
> +};
> +module_param_cb(tracecats, &param_ops_dyndbg_classes, &drm_trace_bitmap, 0600);
>  #endif
>  
>  void __drm_puts_coredump(struct drm_printer *p, const char *str)
> -- 
> 2.37.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
