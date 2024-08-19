Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B418C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 16:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3884210E281;
	Mon, 19 Aug 2024 16:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eVbYholp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C819710E27E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724085763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Md3KCJoK6feytlwXA33ydyo8XOfTQqPq8yxw0ziYE7M=;
 b=eVbYholpvaZNYFw+ilaVaR7C0+Hhf8emC8k44KTnbFTeVCNrXS847ATRAgl8f4wOYnXGVL
 6eegTkHoDwEmEYZCOdalyjJh8KIEj/siqAO0ob1LecYz2kU7KyC40FrJQ7NZWxSapttK/Z
 Cxo4cyk3EFc/w82Deb1TBfwlwNZjX88=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-nZUv5wEXMKmsNtdrf08gkw-1; Mon, 19 Aug 2024 12:42:42 -0400
X-MC-Unique: nZUv5wEXMKmsNtdrf08gkw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d3c976e426so4989090a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724085761; x=1724690561;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Md3KCJoK6feytlwXA33ydyo8XOfTQqPq8yxw0ziYE7M=;
 b=E0vXVpO8XP63j5xpx31F1zWjU3vlePN0xUq0jLLXwSHUxa+vbLH3ZRUzSUEOiEq4W6
 ++KdsgCivydizH1y/uL5BO5CnQ3RH78rZ7P6b//Thh36y7BJXUEz7/IPv5ZQSilt8Fdk
 uGx/H+D9QHSZr/4MJ4gpz8AhoH7ZXU+YuZM+P4IF0zKcSaLKJXAG3i2/8CNDHxWJTY7t
 ODuJFrVSeBotXKLTpiiWlkjMZX66MRGRx5U28fmHpQ5Qi1lQhf8jJv5tKlRVyefjQaid
 eVBQ3FSwHahvdX2z07SSZxjs28kUw84Y5nNJHPWoFh3AN2jsYrvkFz9rfIa0jNs1Lhpn
 XZUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVauCX4ARWb6ICuAhOOPWLPp+qDN9hesb5J1RbdvJljJtxNXQbnCQ9GSns6HSnyQiojXEzAinPhr103hWu9ff0bCw4UwECMNSf5MtU9vA==
X-Gm-Message-State: AOJu0YwWv8/x9crw1A12pkSwkpnGNN+8VZkQsEiyygmeWR5KkvQvhMWW
 9bzl2ns2gqR9J+Hx94X6aSOFPHQFSE1bgvh2no3WX0w/drymRV6TiFTBjQSQbSacMDrqOxDDJCZ
 1esSQCp3mM67Cr1iNUoIBJuMXko2UKY2R+d5Wz/EggEBg8LPbIu9zZiL+Ooc7izM=
X-Received: by 2002:a17:90a:fe93:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2d3dfc7b35bmr13719466a91.24.1724085761049; 
 Mon, 19 Aug 2024 09:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsNdEpvtSkAl5rzLqXEcAkgXsVKtNu15fJmALgqr6qS5TBLy4yzi6qcqcR03rEDCVVXij1Uw==
X-Received: by 2002:a17:90a:fe93:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2d3dfc7b35bmr13719449a91.24.1724085760670; 
 Mon, 19 Aug 2024 09:42:40 -0700 (PDT)
Received: from localhost ([2803:2a00:8:776f:3d96:6be:69c7:46c2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3d32853f9sm8430017a91.30.2024.08.19.09.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 09:42:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 59/86] drm/solomon: Run DRM default client setup
In-Reply-To: <20240816125408.310253-60-tzimmermann@suse.de>
References: <20240816125408.310253-1-tzimmermann@suse.de>
 <20240816125408.310253-60-tzimmermann@suse.de>
Date: Mon, 19 Aug 2024 18:42:36 +0200
Message-ID: <87ikvwa2gz.fsf@minerva.mail-host-address-is-not-set>
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
> The solomon driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

