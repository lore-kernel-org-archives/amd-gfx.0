Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9A5C10F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 08:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488D810E20E;
	Mon, 19 Dec 2022 08:49:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263D210E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671439766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IktmGi/GH9m87qz738gkFkEcXhvUHauf4KIOhOQpfo=;
 b=fIbrYh59zgsbCBtm8OeWulT+FZOT4giMOdyKg6hktkHbd1KyKekULc5v/EPdvJniurbERi
 uOzqoGWZSDYBxdmBvAiHbg84cACMKWD/Jvfse8jU+lN/I03mdv84y9MfWZLsKrqkZpX6dq
 Z8Fe7pXKt5g7pcH26XTuRrhIn1A5ODY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-k3jRqu0yMM2ON0bKgBZEFQ-1; Mon, 19 Dec 2022 03:49:24 -0500
X-MC-Unique: k3jRqu0yMM2ON0bKgBZEFQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi19-20020a05600c3d9300b003cf9d6c4016so6331513wmb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 00:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3IktmGi/GH9m87qz738gkFkEcXhvUHauf4KIOhOQpfo=;
 b=jRcGuUbT5SL934Nh9eb5iQATE65B5xwHIXHPpBFQO49QLO4rTYgsAOYHodrVlXonQa
 zetBQlmVSNAltGVg3FXxABQkCW+cqI9ewpuWdArExCacgELQSyc+SokeuA6CoYBw+Ki5
 9XIbp3IWsi5N6SHFdGAD+nkfb4OlDyZikpSP7CJ1LJCQoUE73hp0WMwaUKCHITjnDHxu
 AGZgZ3UJePhHDFiBFSpWUIixAQsQaZz3Nua/qL5WQMwgytcl3uTyNw77KPykiVVN4YYn
 aZ7GRhCTST+kFY5C6M2H+PKnATHqI+rJTymA2n39m8Sv4I9Ddj9Zu40W+bDf/RO5Fyy9
 /8lQ==
X-Gm-Message-State: ANoB5pnMpht2PkvA4OgPrIXXeViTLLa+v+By5LhO/pbei6g5b5vL4U7c
 gPjBtpBfov+Ut65+qPHJ5CllicTKtu5qbrsSuCgAL/XTw6MvICOBj5VLraLmD7oqxh1HLbGh+ox
 rpmfbaTkcv8dBqH6MwFp+yHWdSw==
X-Received: by 2002:a1c:6a01:0:b0:3cf:d365:1e86 with SMTP id
 f1-20020a1c6a01000000b003cfd3651e86mr42747699wmc.31.1671439763823; 
 Mon, 19 Dec 2022 00:49:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5mBzP19fZOdLBEJmJRVSsZifpUbMwbq1/5C+qMXTEcf81BL0BpsCtpT5x/OuE2fmd/lVCHFg==
X-Received: by 2002:a1c:6a01:0:b0:3cf:d365:1e86 with SMTP id
 f1-20020a1c6a01000000b003cfd3651e86mr42747667wmc.31.1671439763587; 
 Mon, 19 Dec 2022 00:49:23 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 n15-20020a1c720f000000b003cf4ec90938sm11399798wmc.21.2022.12.19.00.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Dec 2022 00:49:23 -0800 (PST)
Message-ID: <c1f358fc-5784-b3b2-2d9e-bc896b8036ff@redhat.com>
Date: Mon, 19 Dec 2022 09:49:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] drm: Only select I2C_ALGOBIT for drivers that actually
 need it
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Dave Airlie <airlied@redhat.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 John Stultz <jstultz@google.com>, Xinwei Kong
 <kong.kongxinwei@hisilicon.com>, Chen Feng <puck.chen@hisilicon.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
References: <20221219083627.1401627-1-u.kleine-koenig@pengutronix.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219083627.1401627-1-u.kleine-koenig@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: kernel@pengutronix.de, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Uwe,

On 12/19/22 09:36, Uwe Kleine-König wrote:
> While working on a drm driver that doesn't need the i2c algobit stuff I
> noticed that DRM selects this code even though only 8 drivers actually use
> it. While also only some drivers use i2c, keep the select for I2C for the
> next cleanup patch. Still prepare this already by also selecting I2C for
> the individual drivers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Thanks for sending a v3 of this.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

