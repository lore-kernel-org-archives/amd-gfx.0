Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E066C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 10:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0B10E471;
	Wed,  2 Nov 2022 10:02:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BA210E461
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667383363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYDm2f88uo7N+T5CuGh2kGVIDaWbYMjQLaRZ3nU/m+Y=;
 b=fV9a2JN5FB9uZgEvcqbFkfF4jZu2MFg1+1tPwGWxj1p766n45XZu7wLki/HQppHBy5Swoq
 yWotSu2roaJTujz3SlxI8a+4cWHdFpfpEqRtqrMNLCpP6t52SCAUxlEPwjhzpqf2bvB8vX
 FYIo+yABHJxsfh48E0NoXjMTkZBaUcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-1weUbE7uMh-8vW42TFWjag-1; Wed, 02 Nov 2022 06:02:31 -0400
X-MC-Unique: 1weUbE7uMh-8vW42TFWjag-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso7752282wmb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 03:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lYDm2f88uo7N+T5CuGh2kGVIDaWbYMjQLaRZ3nU/m+Y=;
 b=pk9Mt/MsDSpPg1ZyYc8PhRlbEcs/ZQis5q+Qa51JBcw54PHSVhV3VH6fXRUyHk4b7Q
 qh+xePYa+J9cuyCiiCDmFC9JkQnrF2eX1MsP5zmm6bdWASiTUetqu8WuDQ9aGHRot47W
 YCKdSrhLNj/YihPlnjUZEZTksZb7SPRKWu5s5Xv93V8r1yhI8bAoKIC61jIOuvUwCw4O
 sVUmLNWfgz6GbqIJc+8wt7i7AnMTTZhvyjSYDE+n+wlBMk6TjRZRWJq0Z/4aAW7s82pQ
 wgMMgO0SYXbvloKPyolvVqfGEg6frYllYoJjuc/LgaZ9MFwNcO7pj5oyFay7lTIvmuy9
 qAAQ==
X-Gm-Message-State: ACrzQf1beisibGL5JN33neeFbZWql3yNKqCel+T7QhXppChY4S8ySWNV
 YTnK0UKVkI1myaNqVsZhpQrhv8CcXhTk1P3xqvLatBH+yIeNlb/X0Y/U3GZtjGbuY81QU//Ipe2
 epI+hz8gEOjhjcgUDAo4jGTwf2w==
X-Received: by 2002:adf:f9cf:0:b0:236:6a26:c055 with SMTP id
 w15-20020adff9cf000000b002366a26c055mr14584885wrr.195.1667383350616; 
 Wed, 02 Nov 2022 03:02:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OHHkFmpcUlQhLx4VZSF/FNGP0hsrmpEExWtKIxFg2Jf6dmbAckk/gQVQTytU8dXpfU2B04w==
X-Received: by 2002:adf:f9cf:0:b0:236:6a26:c055 with SMTP id
 w15-20020adff9cf000000b002366a26c055mr14584846wrr.195.1667383350420; 
 Wed, 02 Nov 2022 03:02:30 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 fn13-20020a05600c688d00b003a3170a7af9sm1564836wmb.4.2022.11.02.03.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Nov 2022 03:02:30 -0700 (PDT)
Message-ID: <68309442-ad39-36da-b1ec-680dd4129a7f@redhat.com>
Date: Wed, 2 Nov 2022 11:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 21/21] drm/fb-helper: Remove unnecessary include
 statements
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-22-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-22-tzimmermann@suse.de>
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
Cc: linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 freedreno@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Remove include statements for <drm/drm_fb_helper.h> where it is not
> required (i.e., most of them). In a few places include other header
> files that are required by the source code.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

