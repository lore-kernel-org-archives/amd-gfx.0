Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC100C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE5410E0BA;
	Tue, 20 Dec 2022 09:24:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EF610E09B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671528252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
 b=NqHjdVkyXrabLYecQ7zyu+04hEaQxoKC6HHkvgz88Xvwo9w5ffLD+xcZuXN4crYA2Ca6gG
 A/RCWXSzpGbEsJVInkrFXZAqaIHSS7Nn1nYC0CI3+0M3/4/aqXvq4Gy5qaO4NwbvNaCNgX
 xaOOPs1HkzGQtV5J0ReFRA7K/x10oNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-ihg-WtZYN2OoogXP5uED3w-1; Tue, 20 Dec 2022 04:24:09 -0500
X-MC-Unique: ihg-WtZYN2OoogXP5uED3w-1
Received: by mail-wm1-f71.google.com with SMTP id
 c7-20020a1c3507000000b003d355c13ba8so2675720wma.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
 b=h6JaD89EPbkZ11ZHbJrVOxOG4TEvsWxET4WNeU2aU+kQrq0rOLmBtPwdYLrwYzYXkv
 ejKH5agn/PxxxwtPJvwPfbru19Ap2pObORLmJyECso9R8pTN8wA8g30fjrJKCFniK3Bk
 affOfEyZJtH9QZUZPnv4vqdzYP5ny0TN2xKO/EJ7HzoV50hwAxjprB9ltyzHWIqRpPy7
 5n75TiaASe1buU/q/oqxhvtDiMK04wwIWouSiC0I+AIhHU6tnxFJxZsUvgaP9QXEpKIa
 XpTaOGG0Kfvo6taaDO0M4EBT2OF+n1OAe/25TD9Aej/MfVsiAYSUI64/xdnDf7dL+WBC
 EcLA==
X-Gm-Message-State: ANoB5pklEF4T5eaiuArhn+S8ZnmEeMeK8nJ3Ej80+v/PT4izao/14ang
 mJUC6wuoL1plgjRMUeUONZhcedVSTq3qlZtWNlLi7ejHdBqmB9r6xZBDWobDs3f3d8WcUqmhbQ+
 VLta7Jj16g9e+15hNmYx3V4EwdA==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id
 p18-20020a05600c359200b003d1bc322447mr34442424wmq.21.1671528248082; 
 Tue, 20 Dec 2022 01:24:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63KxuIxT0M/bl3iLHanyFrnj5hgoC/KBz3bLt1CmA/PA7eDrziJ0q3Lz1WCcHGowxEUJxpPQ==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id
 p18-20020a05600c359200b003d1bc322447mr34442411wmq.21.1671528247925; 
 Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 k18-20020a05600c1c9200b003a84375d0d1sm24663667wms.44.2022.12.20.01.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Message-ID: <e807855d-cfaa-ebab-8aff-7a3e78b1967d@redhat.com>
Date: Tue, 20 Dec 2022 10:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/18] fbdev/clps711x-fb: Do not set struct
 fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-8-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-8-tzimmermann@suse.de>
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
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in clps711x-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

