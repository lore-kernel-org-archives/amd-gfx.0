Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5119BCD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE14710E4D9;
	Tue,  3 Sep 2024 11:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="icA1LDHX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC5A10E4D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsgjyVAoZiwX/0plI8r6xhrkXgx4B8n714qF3W8WxEQ=;
 b=icA1LDHXfDhJPx6egvlxbTUlYG8/aEMOoKtaMxNvlQXo/cYtbKQMNtJrE0e+oXyxoA1KxQ
 Ixw0erSmT1FjryYBnTbO1B84ey8rzjVnPVM2+b3bYNGw57v8fZSgdUuvpVv4hVrqrprKxT
 l17kEb4FDQ7IWhZMU7n3aW1ikgyBgCw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-usYU4t5tPk671qjiA4DCjA-1; Tue, 03 Sep 2024 07:31:28 -0400
X-MC-Unique: usYU4t5tPk671qjiA4DCjA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42c7936e564so27733895e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363087; x=1725967887;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JsgjyVAoZiwX/0plI8r6xhrkXgx4B8n714qF3W8WxEQ=;
 b=SfKwkXCsYJWUHUQOShEGB45RIRo5Z2ZykUQBVaOwhyJf0u5n5HgE95LO6mTt96hX8m
 G45FLIbVjRBsOCQPbAMDPch94GVXB7RFYlVew6j8Pb3zAHpM91NfoM1pLPtbBXvM09GW
 wY3W7N6WIwkti9P1bgRDhi46etiB2/G/hwdn3zLjKcellBBIiCVhxu3NvacX5CZhVVsb
 qWgagPFdYQPsXg4SAFQzmBUXisRfDV9MwrzaVtza6EKQeXb+J/AokoTOyPn+pTlFTj7r
 NQ/MvXcw5TMhi8G1m4GBk+qKRWcubVUOqoMq5rQIUTahQ/22j0jxp1aMdvr3C9i3uF9O
 Txxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbArAm19e1QDwZowZZdq8StbG1mgUIyk5Mfe/1nCCM8z6O+P8szlpRP4spfwev2c3Wg3RIg7u7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFwtqE4qtVgFx1Breybr60Gl08xW4gEgRvMK28igm43PsnAbVy
 JNEceDgu+33LrM4uedg0Pqw/tmsKK4t3XXRhD1AUTDW5RqvLdQt6P7UL24EnVh1ajjrmTEyO+04
 p6lUxPgrSlRoKZQXRszK4+ESl193VjiB95XLeBMBnYyUIT8hrSAg/ZkaTXqyPG+EXxOb9WZg=
X-Received: by 2002:a05:600c:3ca0:b0:426:5e8e:410a with SMTP id
 5b1f17b1804b1-42c8810319emr24400875e9.24.1725363086972; 
 Tue, 03 Sep 2024 04:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5maMqjeo2zbQD/i+Rl7OMnLTPEPO4OhEAVhbI0hhGbDze6A2VsY4Z4sxV6OhxoUjaVqcBwg==
X-Received: by 2002:a05:600c:3ca0:b0:426:5e8e:410a with SMTP id
 5b1f17b1804b1-42c8810319emr24400635e9.24.1725363086472; 
 Tue, 03 Sep 2024 04:31:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274b6sm168609195e9.33.2024.09.03.04.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:31:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 41/81] drm/sun4i: Run DRM default client setup
In-Reply-To: <20240830084456.77630-42-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-42-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:31:25 +0200
Message-ID: <87wmjtdlde.fsf@minerva.mail-host-address-is-not-set>
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
> The sun4i driver specifies as preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

