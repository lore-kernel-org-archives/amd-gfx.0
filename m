Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486C2CD3429
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA47410E4C4;
	Tue,  3 Sep 2024 11:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bhla3hDH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7556C10E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWaiVxUDn5x4EDUb0RXQKucUIM8lh/m7gazYhUKWNcw=;
 b=bhla3hDHMY8MnruSNc8/u/w/nyr/nPa/Sm0fhEXgwrDWfoiZv47UDmYTMs2HGvdijRK78v
 XzhPFoohN1Txqtk3xft9Dh8Nl35xP8VChAafIsbD/8ONaLpEke0H7mC7bb4yc74sJWa6v/
 ulFwOUbCAmr1W36QHSqk9ygha/PKi20=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-BN0hLbkNPZGxo-pa-LD_bg-1; Tue, 03 Sep 2024 07:28:37 -0400
X-MC-Unique: BN0hLbkNPZGxo-pa-LD_bg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374bacd5cccso2480903f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362916; x=1725967716;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWaiVxUDn5x4EDUb0RXQKucUIM8lh/m7gazYhUKWNcw=;
 b=ullI9YEAhIe7NNI5a7Ohhih14cqkkpXRF7BVP0NdgRkssmgr355xZJNCPavjeYwqNv
 62LUTgdx2sldYm7f3uV1DGgUFbKWnpUenwTLEph8bs0T6A+VNGIa+WtaKHDKvAcWY5K5
 /6YiHnPTQWsga3jb+OqQEyssZ5FjVj0ax02A+yhLOTcgHvsML1w4LuY29PF3emdOyIqQ
 3ryFeNJJmO51nTUEDDPA8hv5zyIWVw47GhBCWIIIR0XInTWmY+WjVgSbv6t3P2HGF+Fd
 wl1lmuR7BCBEvITZvRL30pZoQr3CCCk2Kbi4Nz0hNblqYFurOczblNDd2XEb9Zr5rHO6
 bWNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO90+vjQg3++oAp3OCF8UQf8YbzT36YDfsvY0eOwNu2n7uV/gB3Hcapl5H4NlgYuXCT81ZY2Fr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+n7Q95sZ/uyqFIG+rgiNVYWJUgtBViFw9hhzAaQ/Dvj0cRTXp
 htWCSp5nBgztYsjiyh8Fuj0Lt1QrQA5nOqXxU2lflXN+ybGGMN8p6KvBDLvIRwvEvyqelGe0nz7
 1PJX5A2DTnDYmcUvrqHcx9GAhK4ZP067IypHMm28tEC14hJ9KlbeVGIb9ocstA3I=
X-Received: by 2002:a5d:6446:0:b0:368:445e:91cc with SMTP id
 ffacd0b85a97d-374c2659badmr6645346f8f.21.1725362916412; 
 Tue, 03 Sep 2024 04:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOC1T6h6rVXlfVpjA/pVe7KOeoA4/WKcQU1WD4uFO7ri9zXFh51Y6FFr5rxsYl8wc+Lnpi4g==
X-Received: by 2002:a5d:6446:0:b0:368:445e:91cc with SMTP id
 ffacd0b85a97d-374c2659badmr6645326f8f.21.1725362915923; 
 Tue, 03 Sep 2024 04:28:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c5ba7027sm7134412f8f.19.2024.09.03.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:28:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 29/81] drm/mxsfb/lcdif: Run DRM default client setup
In-Reply-To: <20240830084456.77630-30-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-30-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:28:34 +0200
Message-ID: <878qw9f02l.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> The lcdif driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

