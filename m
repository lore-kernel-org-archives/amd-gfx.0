Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86D6CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1BB10E4A6;
	Tue,  3 Sep 2024 11:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZwW8XIul";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD06B10E4A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0gkkLunGIQ2kaDQMdtHzMdkTGKuWZFk1+nOKDyR4as=;
 b=ZwW8XIulNoas3pJAYIZGxrMKTjupOFwKyj5+pLMFIV5fHm37mTNEFn/wXSc07/7PMEXHea
 BVZXjtp+eZRpcXaiVGlindYDiCFj+w3D+0Ch70PlrDjI+fJ84GCqXVMG41DsnHLrezCt+U
 XX1rSlrLhcJn6i5aXsz1OQCtnTOnwlk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-W1rsRfesOZizqH2AT2GmQg-1; Tue, 03 Sep 2024 07:24:45 -0400
X-MC-Unique: W1rsRfesOZizqH2AT2GmQg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-53350003ef9so6359156e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362683; x=1725967483;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a0gkkLunGIQ2kaDQMdtHzMdkTGKuWZFk1+nOKDyR4as=;
 b=EIOaue8KKAUQG1Ru4teFPKpjp0N2eVO3iQ3RQdsThXHf+scopacCy6pD9juIc+abON
 tiqpP1q2ATlUaY3j5igK7HdkLW1qjxUC4dTvOHJ1+sHf9pK4XvT3gTJdrMMNNn2noYww
 fU5itfHkcW4FUFl/pp+UtQQyOXOAW5ongKwGVgIxn/wzVYw57l7meLlttgq+z/t45CQx
 URJcx3Mc0Q0JkMDW6AM3Xx0cEvXx9WhlYr95LcWYESfLhZIY+Ndx9VlfyxEwEEQPwMXG
 tKNgu9ikIHyL34haY2Y/cSo2Io7J/gPU5uIQvBnf3+71vaF1hT5vFsWMmzW7+WG1RwwA
 +BNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhWIb7L/rbIv41kYXIqPmHng9oGN+vY50ez/KouGtdbheQjsGfVqCJ1yjxmNul38ezYZY2Li8x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpPM2zm7EAjbwwfKhbLD/HSSwboJC1De/okhw+ZA6JLMUz8Ui+
 aUpfPSM6mf3S0ztfD5Ftr/PvFPvebVfIfL4l2zU1b4FfxpFovA+knT9lpRQGVZmivjvb7B4O0nz
 eRf7tA2RYv1RzGE+0XgPiVigxAZeAzhA6XE1iegyYqo/tTju81S4GFQdxL/zQnX/OGalMdzQ=
X-Received: by 2002:a05:6512:3b99:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53546b167famr9189249e87.7.1725362683191; 
 Tue, 03 Sep 2024 04:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV4RoPHMRrjPOqT1ox2wOnC/TMkJttXZQfXhIXmK0ZwIW9dx/0UkvKvAIAwP3zEiWjbdgR2g==
X-Received: by 2002:a05:6512:3b99:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53546b167famr9189216e87.7.1725362682612; 
 Tue, 03 Sep 2024 04:24:42 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b9d54f98sm10542803f8f.69.2024.09.03.04.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:24:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 19/81] drm/imx/dcss: Run DRM default client setup
In-Reply-To: <20240830084456.77630-20-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-20-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:24:41 +0200
Message-ID: <87r0a1f092.fsf@minerva.mail-host-address-is-not-set>
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
> The dcss driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-kms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>


-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

