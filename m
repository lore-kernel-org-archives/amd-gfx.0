Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A13C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D6310E345;
	Tue, 20 Dec 2022 09:17:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BE610E344
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671527849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8TwpXV0XnYsgvagPag9L7MpjXeefLJTkMJCGh9V7pg=;
 b=L7FagMAAEQY6cdZLFUwfdO3K4Hle4vK2vqdVo4m0nodHYg0qYf/9T3aRum8DBe2C81m5Go
 12BlHYW6MoeESA6gHTZL8QNuccENU1a3yqOBxeEN9JQmhqJLx4YqwIDkrTQeEgMTYnNFts
 s0dsR6wx9Os7GQn8I0TJNS4p8vfeIxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-vfrrn_LiOvuaQnBJqtqRnw-1; Tue, 20 Dec 2022 04:17:26 -0500
X-MC-Unique: vfrrn_LiOvuaQnBJqtqRnw-1
Received: by mail-wm1-f69.google.com with SMTP id
 i132-20020a1c3b8a000000b003d0f49bc21bso7780063wma.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8TwpXV0XnYsgvagPag9L7MpjXeefLJTkMJCGh9V7pg=;
 b=7uCDzxQPr9ngwwXR8DD52jy7KaUl6NBW7qvAhH44zVneWj1bEJAUvUTdpIXcEbMS0u
 h4+BWCO8O8dFwwp/08SCAfa8UH2UdeEM5j1KUULE2uoc7Wq4HXQ0EL7s0MYqDY8w6SEL
 iCeWET+xLVrnEGu9I5xVox+7o3uhHQPcYkaHuurN5tt4MBhoQb1geWHk3KP4FJskPrEt
 aQYTA9RsGGXSnCoe22sWbo0Hp6ll/k/linoR64WqIchHV1/bnIb8dq66auRMOmnhh87w
 CwSqXUMod/Wq9G0/KrM5/2J2jnY6IXR9wggExP+BrIcRngWwgZaXOFIpM/rDMzRqO0jD
 gFHg==
X-Gm-Message-State: AFqh2koA9ujeqi0Z7w2N23rQqsz4JVuGfF5mAwqeDgeUTjZbgHw0+KMa
 n/ijK7Dq1AuQAMwJCENVoMirnBy90pUyW5vsLV1shPKWdYRAOE4e31QVqIG3fSwpiMSaeUKgOkB
 DLZaeBXS6wgs2Yfn9znmUp2Fkug==
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id
 z12-20020a05600c220c00b003d23831e5c4mr995469wml.40.1671527845237; 
 Tue, 20 Dec 2022 01:17:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuuo6HgeH5yLW955AXoTEHdpszfHBedFCr5hOSv462STXosZPN5E6XN8VtP9mnawtIRXA48sQ==
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id
 z12-20020a05600c220c00b003d23831e5c4mr995452wml.40.1671527845031; 
 Tue, 20 Dec 2022 01:17:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c350f00b003c71358a42dsm30460043wmq.18.2022.12.20.01.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:17:24 -0800 (PST)
Message-ID: <4bb928f8-ee2c-7b3c-9390-7efb53c23b80@redhat.com>
Date: Tue, 20 Dec 2022 10:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/18] Revert "fbcon: don't lose the console font across
 generic->chip driver switch"
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-3-tzimmermann@suse.de>
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
> This reverts commit ae1287865f5361fa138d4d3b1b6277908b54eac9.
> 
> Always free the console font when deinitializing the framebuffer
> console. Subsequent framebuffer consoles will then use the default
> font. Rely on userspace to load any user-configured font for these
> consoles.
> 
> Commit ae1287865f53 ("fbcon: don't lose the console font across
> generic->chip driver switch") was introduced to work around losing
> the font during graphics-device handover. [1][2] It kept a dangling
> pointer with the font data between loading the two consoles, which is
> fairly adventurous hack. It also never covered cases when the other
> consoles, such as VGA text mode, where involved.
> 
> The problem has meanwhile been solved in userspace. Systemd comes
> with a udev rule that re-installs the configured font when a console
> comes up. [3] So the kernel workaround can be removed.
>
> This also removes one of the two special cases triggered by setting
> FBINFO_MISC_FIRMWARE in an fbdev driver.
> 
> Tested during device handover from efifb and simpledrm to radeon. Udev
> reloads the configured console font for the new driver's terminal.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=892340 # 1
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1074624 # 2
> Link: https://cgit.freedesktop.org/systemd/systemd/tree/src/vconsole/90-vconsole.rules.in?h=v222 # 3
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

