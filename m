Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33D7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C7B10E352;
	Tue, 20 Dec 2022 09:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DCA10E352
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671528004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
 b=gZ3lDI9qnsuG+b1qQt42AFhgJIkevqnLOsTZnUU0sqDbjXEeFzcR5bYpzqhlzO9/dit5FQ
 39bmvN9CRif6PAw2LzwpZqk9JPFUIvjEC7Zw26PH3KHEhy1UPo3OIzkXo2ta2KJW8+ZKQn
 axQ2YoBtqjYHAT7NaSU1TB/T0T2DZ5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-F9mG8WPVMfO2WZDatj-mHA-1; Tue, 20 Dec 2022 04:20:02 -0500
X-MC-Unique: F9mG8WPVMfO2WZDatj-mHA-1
Received: by mail-wr1-f71.google.com with SMTP id
 r6-20020adfbb06000000b002455227c5c5so2088592wrg.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
 b=Fkwk9pk3a84NgbmX3UTvSoWHpFtdu/0gCjjUYQ4t32FqzaSJGFKUZ7UISjH+IcVTbi
 fPNB4gcuHkR/sLiyRLVP/GeDVAlT8UVQkSO6B7DdfMUchfHKQtoOS6M4MLum9GkSKoLL
 xOzfrTOQ0HDTXxuk+f+2uzqQ33Q0TxjMV6Zm9nOmwY3iHZ/n5YAcNJ5V/1x63pP207Qy
 V0w+KymHmhhtdDt/ozoq3Xr4HWRYSZSpIKTJ82RzaSducV5EbwcHoHgjbRBtV7FW5ZRC
 gdrJtQ4TTuc+XmJOKnYW/RB7E2TBSuapQLgJdHkes3fBl6ZrMwU6L557LCaeM5r+Ri68
 P22A==
X-Gm-Message-State: ANoB5plV/1cAFjNlquX5TEYtUS2Z3Jmql7zmZLsfJuP9xLEjwG8sOUm5
 8b6AifpcJFCxNO0rVoZlC0QXB9zUfmnXuSAMFxnThe6gmMPs80ZLD2gnsg2w5OHpftMesrmgyMD
 TZ89iPqRxGYWn13UF0gJcx3ATMA==
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id
 n5-20020a05600c4f8500b003cf93de14e8mr33662649wmq.39.1671528001147; 
 Tue, 20 Dec 2022 01:20:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YfyRC8GN1CmHHU+h6zQnG8fHr/grTiv22vuNVltDRj2C7JBfNLZj3eqwiClNyExLknW6NJw==
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id
 n5-20020a05600c4f8500b003cf93de14e8mr33662634wmq.39.1671528000916; 
 Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 p16-20020a1c5450000000b003d07de1698asm21890206wmi.46.2022.12.20.01.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Message-ID: <bf88b4bf-4c81-29d3-3518-ef149f93265d@redhat.com>
Date: Tue, 20 Dec 2022 10:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/18] drm/radeon: Do not set struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-6-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-6-tzimmermann@suse.de>
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
> not set the values in radeon.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

