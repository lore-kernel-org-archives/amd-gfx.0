Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DDFCD3429
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E6110E522;
	Tue,  3 Sep 2024 12:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Oyon66Re";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C197110E519
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHMOo9WHt2Js8QMS+ivCDnsW0bhD6c2SxEScDuVLqTo=;
 b=Oyon66RedPCpi0h5MiadmCDVOgAGGUQ+olA4BYGvzJGbcssx9LL83aXgL13RDjBtL79Y12
 w3h8JZKnHfuDLMC2EYb7t9U+BZj8T4oXMCZhGBlTVGbtWU/1qhXcjZJ7P/5Ys7YCmVcvF6
 Nd3C2GNttJRqgrRkdv5zXhNW9XrTyIA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-WmiMc4n9OvO0S4YfdBNuaw-1; Tue, 03 Sep 2024 08:05:33 -0400
X-MC-Unique: WmiMc4n9OvO0S4YfdBNuaw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5334c7d759dso5109025e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365131; x=1725969931;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHMOo9WHt2Js8QMS+ivCDnsW0bhD6c2SxEScDuVLqTo=;
 b=Nbm6hRDAHOvXyN4ympSzwmb5/qRpyAW4TbS/q0wMeYqyohjfAoVPT93XEAFZ+zdJEQ
 sCaVbbDCsmuvbvBtLqqu8qRcewY+5Ne/Q6jLGI9YkrKG64VjdN08CwtKjghLVMPwheu/
 MFucULLmJSeUVH0b8qOMP4YcpZ2f8TNSC4SDZi8CqHIP53YwBFl574E1amk6aQCqNTQh
 9KDmUWLzGLdGPr3e5GkvZ0STe/mc1vZa34hGD+yoSBF7YHQHFy4JtW/+/nfty8ysAT2U
 LGBAw9EyGYnan3D57gu1jQAzolycECAwyE+Gl74dIFncOeD0CgNNouZOU9EFw+SOonJo
 vefQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmJgl6pJLH0nKoUN3spbfhqI9BfdFg/lkCw1jxdl4Cs+Ud7z5AsAquATJjiCho1vf5gqM7Ml+d@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBAorq9vNCx/NkRzYYicZ9sahj5GH7N5RJLeDib8XSw+CZVGTJ
 3S6GkshoSEvY/ZeoDZzITx+aHE1nb23lAs/RdAFXML/OrwHP/RZfZ0vfERmaxsWdc0moW7bpKgO
 sGcht+2xII8tsVYFX4yiGHu2VJBZklWF03S/xr8yXkenMWSS89KzqcLkvO+hJp+k=
X-Received: by 2002:a05:6512:10d2:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53546aff5a3mr8192623e87.20.1725365131113; 
 Tue, 03 Sep 2024 05:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpghN3bq0VjJ2vU/J5Df8ul1O4uqOm+Qk8JhPzaDhtvMoqfngbzTsco324Pw6cFzJjTlVtzw==
X-Received: by 2002:a05:6512:10d2:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53546aff5a3mr8192591e87.20.1725365130473; 
 Tue, 03 Sep 2024 05:05:30 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4ddc8sm14049200f8f.21.2024.09.03.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:05:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 64/81] drm/fbdev-ttm: Support struct
 drm_driver.fbdev_probe
In-Reply-To: <20240830084456.77630-65-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-65-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:05:29 +0200
Message-ID: <871q21djsm.fsf@minerva.mail-host-address-is-not-set>
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

> Rework fbdev probing to support fbdev_probe in struct drm_driver
> and reimplement the old fb_probe callback on top of it. Provide an
> initializer macro for struct drm_driver that sets the callback
> according to the kernel configuration.
>
> This change allows the common fbdev client to run on top of TTM-
> based DRM drivers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_ttm.c | 142 +++++++++++++++++---------------
>  include/drm/drm_fbdev_ttm.h     |  13 +++
>  2 files changed, 90 insertions(+), 65 deletions(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

