Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF8CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D79110E4A9;
	Tue,  3 Sep 2024 11:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZujRTfTJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176A310E4AC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFn6JoF0nYLgSLX6ae98mppLG4Otb/JZ15e4mfDfaw0=;
 b=ZujRTfTJHrONbOoXv5MohoK/L/kHZL9YE1u/haGAncepJfaDZ9COjHI9WMfZUb/0vcTTQs
 9PaQ1uOUdPgY/OoITigOeno+CfH1btQXLtoO4+ctQIvtiJsLY+hts/KH7dhiCm8Od3wZIX
 PzYipL+NOcU8HkVsXYBmshdQftpHVC8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-J1msfVfDPWqiBDLtQSp-Ig-1; Tue, 03 Sep 2024 07:25:09 -0400
X-MC-Unique: J1msfVfDPWqiBDLtQSp-Ig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42c7936e564so27683945e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362708; x=1725967508;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFn6JoF0nYLgSLX6ae98mppLG4Otb/JZ15e4mfDfaw0=;
 b=I7ofzl+XQTLBZbtUlNeIPgF4dYFNuSybCm77Ba0lboUAstG/oHwhNFmIAaQGLz2iFW
 2KQ5VSy7BNJHdChyhz2Wo2WdTh5+JuNaP80ouijY6V8UYxNwClTIGJm9pvSCDiXii56D
 yJQpAgzUNtzCshMu7Ph/c1mwYojHwXvSGV13nS7T2aNLzPEfN7qQKRiPewTj2kfH0h8o
 XzU4Pa6DUDK0WG4gPO7kFBvosORt8W25Alhz6wJOoO+bSiD6ofJyNV9cu6qve4WKl/Ys
 mYUAFwXYEObzhfRgk9xGN423XDLpaJ5JFslXFvsQ+z+pKjNCKKkTqKlK7MET0BwjlwOX
 P3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUESoaukwkVYAPKPMxH3JEHPVrK+134PslRMddmFuRxf7Gp/ooK2ZUyWbwYFvrX5PK60WgP7r3/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywrO+/YCXJeWl/Vo+DIZNyhWfcMABP2I3an2F74rUM5nfd0UxB
 XLVTysZpwH5nvXwrYAWBqEx5wxJjpR+CG51yBCxnq7wUzxRg/985RCeCp/8i3GlhCUuM7JFJOuB
 EDI4KyEBpLt2sdNkm6FBrVGBfNGMKU/OY3ZD+EdgKkbpyTufCx/Mq+Fc/zwB3QOU=
X-Received: by 2002:a05:600c:5110:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-42c880ef921mr26586305e9.9.1725362708106; 
 Tue, 03 Sep 2024 04:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3cH0MWc81rircp2ansVoCb3NK3NEk+umLvTdA45IVUNkVz9xLI+VziTu6VQR/1xOKKJstjw==
X-Received: by 2002:a05:600c:5110:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-42c880ef921mr26586015e9.9.1725362707597; 
 Tue, 03 Sep 2024 04:25:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bc00877c4sm121472685e9.6.2024.09.03.04.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:25:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 20/81] drm/imx/ipuv3: Run DRM default client setup
In-Reply-To: <20240830084456.77630-21-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-21-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:25:06 +0200
Message-ID: <87o755f08d.fsf@minerva.mail-host-address-is-not-set>
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

> Call drm_client_setup_with_color_mode() to run the kernel's default
> client setup for DRM. Set fbdev_probe in struct drm_driver, so that
> the client setup can start the common fbdev client.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

