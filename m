Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD85C54722
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 16:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E6310E207;
	Mon, 19 Aug 2024 16:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jEsy7iOi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EA510E223
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724085674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQyHttrBtLhi/oG6jgxpPMBUYcZOG59jM7Kv+K2onC4=;
 b=jEsy7iOios3uP4aXUb3H9I+9YAS+S4rKrykxysqDp7FSaTBf553vFgLSd+lug6cbaH/5NV
 qjldjLo4U3Eoz+yn2iAf7neXCs9FKQmAHmOkvpsmEotdB9Fbga0tXf3m7d6XQ1nE/ZySTP
 kn+t6B7C1LPaeK41yH69hACVP5CIHyQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-_8g9JAf5MWGtlCn8XKIceA-1; Mon, 19 Aug 2024 12:41:12 -0400
X-MC-Unique: _8g9JAf5MWGtlCn8XKIceA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-70d14709555so3491899b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724085672; x=1724690472;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQyHttrBtLhi/oG6jgxpPMBUYcZOG59jM7Kv+K2onC4=;
 b=O19ecz+nzLR+YLfFQMCwOriOk08nMnrBk7MxPfSP7nOIKklbGsdgMKaHlYVuDkrZY1
 RNbRc/otkz3MaJu0/aKJZpPIL/JJ1Q2d5T2u1XTYVlO/HWvZgeP39UDUg2yBozDK+DDo
 VlFLWDJspDfWPosytTeqdeUA7uIfuOeAeg7mJkv88A7+thWDg3pHqzR4Uiz8qbCNLb3w
 6f+BkFxTZTitRbit+cXDiMkD3iSqBtwWzVOX6Y330c/a8CkYnj2lRioFqGu9D7W5E+mf
 9sX7q8eaq8NKuTNqedmATvS3l3/60dGxgxIIMxBXbtTH0zx6miTmQalJXn5nzT9g3FLr
 xeOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRPulelfjn82BNgNggJhl67yozMsc2CjnlKodVsyJ1VwtyQGMh+k+7PaZXYdmXm80vIVJE1goCXO4r/e9dXEaNOcv8X7e+5eW96UArCA==
X-Gm-Message-State: AOJu0Yy8MboVtfTOvZi9dunGhzT3qDIptajysEza/Tn85Ti8XFZDa2rP
 hcKEvN2/yRsRxS5/jO3EA6IDBmEJ6AFsNFhoGoigS8Q2d/gMaw7EpJgy+zNwxEu0pfSzhEpuPHN
 b3Jveu0mpPKYfdOfrqL9tdMvbSbbNAqvIy7w8DXbnLaZ8pzF7n1eFTTd0Ehkr4gI=
X-Received: by 2002:a05:6a21:3944:b0:1c4:ce43:7dd1 with SMTP id
 adf61e73a8af0-1c904f90c9dmr11465765637.20.1724085671796; 
 Mon, 19 Aug 2024 09:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbLTAHBQpebC83mbq0CLnlglkWZHDsgxNbLZIw6fOMIdWWrAP8SjyYuTq6n8R0zn4nWNw7g==
X-Received: by 2002:a05:6a21:3944:b0:1c4:ce43:7dd1 with SMTP id
 adf61e73a8af0-1c904f90c9dmr11465743637.20.1724085671437; 
 Mon, 19 Aug 2024 09:41:11 -0700 (PDT)
Received: from localhost ([2803:2a00:8:776f:3d96:6be:69c7:46c2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127addcc5fsm6777501b3a.9.2024.08.19.09.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 09:41:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 58/86] drm/simpledrm: Run DRM default client setup
In-Reply-To: <20240816125408.310253-59-tzimmermann@suse.de>
References: <20240816125408.310253-1-tzimmermann@suse.de>
 <20240816125408.310253-59-tzimmermann@suse.de>
Date: Mon, 19 Aug 2024 18:41:08 +0200
Message-ID: <87le0sa2jf.fsf@minerva.mail-host-address-is-not-set>
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
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

