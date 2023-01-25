Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA2CC27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF35710E0DC;
	Wed, 25 Jan 2023 09:25:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6879E10E74B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674638710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJl0EBn4HtiAr3IA7OgQLEz430pat4/3/h3H46oRT3g=;
 b=KO/F8P4vq8StqgMN5WTrUy+yBRODcTmvXLkNdiWJbBvY+PrQxM152TJ52cTrRMGmJgp3hd
 Mq418D+5UWJW/g7TONCkcO1TCMq3/FrAUDBt9CPrkiXfrSZDdhtjHIFV6w17aWUi8qd2gu
 XGMkU581WKYiDI4LD9T4aRRWm3FgGkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-_E7SKel_M_G-e5pHWCa5UQ-1; Wed, 25 Jan 2023 04:25:09 -0500
X-MC-Unique: _E7SKel_M_G-e5pHWCa5UQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 q19-20020a1cf313000000b003d96c95e2f9so332260wmq.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJl0EBn4HtiAr3IA7OgQLEz430pat4/3/h3H46oRT3g=;
 b=v+sXbVk+E2Eus5zEDaeZxIyHTYMAhz/ncvESDP0pQCSzlDq1RJbxKjyZzjoyC9Qtpq
 fpYoVQJPqrZKcbY1cj75/DueC+3vypJwXN6GEEX7yeUdphjAuKobJV8jC1fQt/UiFxIt
 ZF/OJg6UzLOsSCMmWUbTcYi92Y1VvkLkuGyUfZJ11IM9AMad8DTmTaS+52XHvPEsoIak
 h7fjoFq61e8aNWW8n5dVB77J+3FCtbnBWKtRMooT1Ae1g4L+mWUPQ0A7dBI2dXSxQx99
 DQUTNn96u0tTzw+N9eSmYdLJ4PkrIvYpleoNy4tW+90GrUUy5rzVdD+m+5JnvUur/y4i
 QUwQ==
X-Gm-Message-State: AFqh2kpaWZfEWfw/CKsKdBW24nDHkdYGUoovCAYTcjFUbClQ8MyCoK9N
 HLcfVXHCv2y5TL4UTtnywzouSLXCQudngqjR9PAl6Mwe300hwx1VxCU2bHSQEQdqfdDKpGTUCAk
 z21sb6Z0lIjy52S/C02LiG/jjbg==
X-Received: by 2002:adf:a38d:0:b0:2bf:9527:ce62 with SMTP id
 l13-20020adfa38d000000b002bf9527ce62mr13001327wrb.60.1674638707871; 
 Wed, 25 Jan 2023 01:25:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvA3fpsEqb88MB1qU578so/hL+p+6J8snUbZz7AHyqAc1so8GvG1XEiL3HmPZITj9u0u/0ozg==
X-Received: by 2002:adf:a38d:0:b0:2bf:9527:ce62 with SMTP id
 l13-20020adfa38d000000b002bf9527ce62mr13001312wrb.60.1674638707672; 
 Wed, 25 Jan 2023 01:25:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 q8-20020adff788000000b002bfbda53b98sm534384wrp.35.2023.01.25.01.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:25:07 -0800 (PST)
Message-ID: <c0377e71-12b8-a545-dc48-704c223f344c@redhat.com>
Date: Wed, 25 Jan 2023 10:25:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 04/10] drm/fbdev-generic: Initialize fb-helper
 structure in generic setup
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-5-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-5-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/23 14:40, Thomas Zimmermann wrote:
> Initialize the fb-helper structure immediately after its allocation
> in drm_fbdev_generic_setup(). That will make it easier to fill it with
> driver-specific values, such as the preferred BPP.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> @@ -456,12 +454,12 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
>  	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
>  	if (!fb_helper)
>  		return;

Maybe add a new line here?

> +	drm_fb_helper_prepare(dev, fb_helper, &drm_fb_helper_generic_funcs);
>  

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

