Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D816C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 10:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D3A10E731;
	Fri,  4 Nov 2022 10:38:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ACA10E731
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667558291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M88yz4GfmbUNq4mWECugnsnJkV6z34uCwDqL3DFZ74U=;
 b=MrQOvOT4UxP3Qtv+fB8Cl9dUzB13vT4MHUxpeRqO0M7dcIyiaU4vcp0tqFUwRxc4Zx0M6i
 k9OUEBmsW29X30aW4lcmdjH20oEtmDRuouU+eN3LVO6xlLHVgWaX6tKgAgwghsiX6W0bxS
 Zi9nCwZOieaNB5Pyewd7sZ5c+c0b+pk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-2xPNrmU0NhOv3hNNoMCShg-1; Fri, 04 Nov 2022 06:38:10 -0400
X-MC-Unique: 2xPNrmU0NhOv3hNNoMCShg-1
Received: by mail-wm1-f70.google.com with SMTP id
 z18-20020a05600c221200b003cf7fcc286aso1553116wml.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M88yz4GfmbUNq4mWECugnsnJkV6z34uCwDqL3DFZ74U=;
 b=Jd8+GF4hf65yVoS0ebO+SSvwNEKLbfPJuiEb99nEJPmjpcMRxXMQAYCwZ72QlHRRXy
 M1HVWlQdkbWAG8se1bqXAncUnHvpvkLl4qq6d9+H1IK1tjV4HDX3tzYTYGl4KAVjSc6J
 830fxHkG/qYWq12c/ikbIGoyFlfJ/qLvoSMQHUmeHhuUyCg/fN6YbCaAzF8H2RFm21JB
 IAEqkilpXcJPv3f+iAoMpLAMMPLPkZQO5gdYwoWi1L2valapiZHbkY6DEOdSnOFKagII
 MHWEo7+TcF6orOJcdURo+O5yLhnxKNBSqtAVrg0+BrMcqwPoMAekcF1mI5V5p+UthZWM
 48+A==
X-Gm-Message-State: ACrzQf31zP2cWf0Fu01wzSL1iaPbFfJCLWdDzqEIhDGsez89ylEWCQSc
 +bxZWYJjS/Tp11j++i9StfWRyLX8SS63SY1IO403L4T/96+9amFNMT9Y53Py8Ny29qNnsB+5JsY
 KpGLjw+nX76SaGN4Lmjb7wKmrmQ==
X-Received: by 2002:adf:bc51:0:b0:236:8fa1:47ea with SMTP id
 a17-20020adfbc51000000b002368fa147eamr218076wrh.77.1667558289570; 
 Fri, 04 Nov 2022 03:38:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6s9MOXnwXonR8VOapq6d4n3ZU7IGA+EIjACuJbvHHOLIXD7EQUkeJV/V+5P7qnQBQKVLAVkQ==
X-Received: by 2002:adf:bc51:0:b0:236:8fa1:47ea with SMTP id
 a17-20020adfbc51000000b002368fa147eamr218064wrh.77.1667558289372; 
 Fri, 04 Nov 2022 03:38:09 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c1c8400b003b4cba4ef71sm2534442wms.41.2022.11.04.03.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Nov 2022 03:38:09 -0700 (PDT)
Message-ID: <1f5e6de4-3fe2-7933-f8c0-5f13564595cc@redhat.com>
Date: Fri, 4 Nov 2022 11:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 23/23] drm/fb-helper: Clarify use of last_close and
 output_poll_changed
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
References: <20221103151446.2638-1-tzimmermann@suse.de>
 <20221103151446.2638-24-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221103151446.2638-24-tzimmermann@suse.de>
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
Cc: freedreno@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, spice-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/3/22 16:14, Thomas Zimmermann wrote:
> Clarify documentation in the use of struct drm_driver.last_close and
> struct drm_mode_config_funcs.output_poll_changed. Those callbacks should
> not be said for fbdev implementations on top of struct drm_client_funcs.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

