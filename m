Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F876C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AAFA10E0BC;
	Tue, 20 Dec 2022 09:35:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBCA10E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671528938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=DQf1sAgvUmpbBb6WOSRRbstBdpoNhZQhOIcRqeC6hgW5b5k9f/Jh3aJaO/xQ4YMy4l7sFU
 YHGeKo2rKM5V2vI7UphsUha9T02uFy6utgjEoRaTjdLvdGLeggGvZL29EELsUHh1pWBhqQ
 1jugf4K7spOmm+PAZvAfgI2hebCEm7E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632--82ybJRJNiGv8wrF4F9VBg-1; Tue, 20 Dec 2022 04:35:34 -0500
X-MC-Unique: -82ybJRJNiGv8wrF4F9VBg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so6294147wms.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=G2U2ozZcAVqy5vXpqBn1d+4uopXg0bhg1AiPtRM0T4+kRw7jTuTl4ZKXVkR3MTvMBO
 iT9jvUth4e+WLcW81z5mGQPVizNFgh2kwxbuL4Mo2MZVr+YTIPDIMav6+LuFdBtOEBy6
 hB5SYzlfWPg5lZfJTQpcypDJgHeIqbVPJkOkyMDQskLugupnQK99HviQf3Pi8iXhZPFu
 8q+mNdwqsH4EtStcd8lyJhECATwEwzdrT8a/l/8K6LIhDPhlOHQnzZoq4BuzDZTB4zH9
 1eS0l+bZdpF6K5LMxxrmTiTNqb0LnRCg3XXHRdc2wl3HYtqar3QoqXcw5x5J4NowkNSD
 btJw==
X-Gm-Message-State: ANoB5pkgTmYA2x5CKHot9hLfWNdHR6BXlznc4FazoVdAMF+ueM9E2t8B
 W80m4gKaHuNxyVofm88wgJpQmeB26fWGserZgOy64Z5YIj2csUXIZpx8S30FoKS9XWexZPbKJ/J
 bm1+UHaw7AtAk0ytMpTMxp+2WWg==
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id
 b12-20020a5d550c000000b0024227131fb9mr24605039wrv.16.1671528933090; 
 Tue, 20 Dec 2022 01:35:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5UgRh9FZeAQW/rgYS4tJcqcpMr2W2F1LauhongkzEysTbAsUBQfYpe3JzD17C7VFjb9x9qPQ==
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id
 b12-20020a5d550c000000b0024227131fb9mr24605033wrv.16.1671528932912; 
 Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 y18-20020a5d4ad2000000b002365cd93d05sm12313762wrs.102.2022.12.20.01.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Message-ID: <c8c3d52d-896b-b38b-00ac-b1686fc4ecaa@redhat.com>
Date: Tue, 20 Dec 2022 10:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/18] fbdev/efifb: Do not use struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-12-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-12-tzimmermann@suse.de>
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

