Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C00C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECADB10E36C;
	Tue, 20 Dec 2022 09:44:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BE710E36C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=bMNfBpnQ0R4k+ZK8hL0B6FvdIHuE2a82b6uq5TwyVbtjv66Bs6gClwvEX1W6Fp3/8xwXD2
 dqhZCRE0PLbY6sGXEU4B8doc9gx/9iHlNxoiEiwYCKyUlTRJCUDkQO3LpaklI1gpIPUkiz
 d8HmCBKJ4wvs+IM57SvO4ncgFUGRrYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-3NxKRgZRMrWqwwfiedDowQ-1; Tue, 20 Dec 2022 04:43:56 -0500
X-MC-Unique: 3NxKRgZRMrWqwwfiedDowQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so2409376wmb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=63gZOcIbu90JT7XdR6wCytB8wiBbj0JjTOBX6cuEa/1xwlkSL5bZEfBOswoUfN+R1o
 GRKXVb6fr9yEdtTOAV0SErZIMrTaRxw5IpJYs+Tpc188SVrP3IlGWLoU4acp63xsVZcF
 8W5ZPF0QC+ZLwsbLmMib98pBzmWbwk1M9gcC7IZcziRWmtNqsw9yBHLS5yo9h3ziTq5b
 VabweZklYiMXTl/0vcq5exSSOKXa+JJCkuFzh+jJz8/PVN7xSuj5C2KhD452vzVj4r60
 rRop3HsKkBa9yC4j+r1PU87i8ReANsPsrOFLkTj9Kgb1JB3gGBQhnG/j6Q+nsLgFWlBZ
 C0WA==
X-Gm-Message-State: AFqh2krZMWEAy/9PEqR6agUyfmOrqhvQHRQPwoPpvybpIosy3NCK586i
 yAVprDhRusroDLkfb6DkazC8nUWYo75F1TQZmMLL5jAjYwDxBgJR3tg77r8ccSKuyi97BEissSo
 WkyGbvZSt8J1yL7rftjEh+dsvSQ==
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id
 p17-20020a05600c431100b003d23e757bb9mr994925wme.34.1671529435451; 
 Tue, 20 Dec 2022 01:43:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvfI2fbHCkuQqRJ76jLZpFV0pKFd9I/EWHnHADcWJc2WmgvjMGHFvYEzSGe6w+l7QXDUqu6sg==
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id
 p17-20020a05600c431100b003d23e757bb9mr994914wme.34.1671529435238; 
 Tue, 20 Dec 2022 01:43:55 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 y7-20020a05600c364700b003d33ab317dasm17144094wmq.14.2022.12.20.01.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:43:54 -0800 (PST)
Message-ID: <c9a34fd2-3dc5-18d7-20b4-b5c9e69ad039@redhat.com>
Date: Tue, 20 Dec 2022 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 16/18] fbdev/vesafb: Do not use struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-17-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-17-tzimmermann@suse.de>
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

