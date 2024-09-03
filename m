Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74CECD342D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F6B10E4E2;
	Tue,  3 Sep 2024 11:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fh0ht9fB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D67A10E4E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6Z3wxXNuqkdNQKBlR4V5hxpw8pNzMmDdZpwiBC57Mk=;
 b=fh0ht9fB0pQMTmaRFrBvqK2XzKzffcECjPe3O1FX8dBwoZ1ATDT34N+8nWqXyheQEV8HzU
 65JyTTSVUgt2uCrbTUWnh6klbphaob2IoqNEkyq0J6DEY1m9tSDCkCRTYQWZYnyV/bIcgT
 aFGgm29arWEWLxdTD1wesF80XyaLYl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-CjwUfxQuPhaEl-GTAdWYIQ-1; Tue, 03 Sep 2024 07:31:48 -0400
X-MC-Unique: CjwUfxQuPhaEl-GTAdWYIQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bbe9083d1so35568585e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363107; x=1725967907;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G6Z3wxXNuqkdNQKBlR4V5hxpw8pNzMmDdZpwiBC57Mk=;
 b=quZT+FV7LiabXIbIqm9/25xsDOrjyX6M4sQBlqsd4U8k4Xrzm/J3Xlhtg5nsIEFNxQ
 KgOa1Pg7kjEktkIFUIXdHcsaTaafcdPOZJTR7BlCMqCQ2hvtmlHnZTMuVgeHGIDuDDIC
 66UdCrW5Ju1BQsd1VuPG+uV19XMyfAT8GXqNGB8c1UcHhVA65Ad+YR2O2LgXfEZHBIIp
 xPVknQtnH0Rx7XZ88GIVtz/6+wS6Sjrl3hjCzW8bYgXiUENnQqH3Dm4cwSzx5E0oZ2UV
 hznkj8kyIFM59ekItgWlcW6ljVRh2ENlncTg1VVRYHw6uPRrROWaETaKENV2eOLROnjv
 rn2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfHIrNdRXIsQsikOousS/R3CYsZPTJgrhhNWDmMxYkcdZm1aXWMDrMyzFId0qK6hpu3Xg86Nri@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVEvWi+bVPr9xMX0Mt/41fT/DW9MVQpH+/4vEJXViZA/LDhkEp
 qxkxRrJymUfmXrzrtDenIiPJQo2bznL1nE+ERXXS7+91yGxJtk8XMFny7OZ0m4JJZuMkyRCz6gU
 5Mf1b8WNe299Wks0xpoZJaWkDr9xMYbm/UUwwbspQYNouGMgB4o/4j2PSpdx9mWE=
X-Received: by 2002:a05:600c:4ed0:b0:426:654e:16da with SMTP id
 5b1f17b1804b1-42c7b517656mr67767365e9.0.1725363107472; 
 Tue, 03 Sep 2024 04:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeMOyjzQgizDJPCm6Kr9tFNsJyk2nqnC/B+gZS4uzByo92kWKPWlduCmztovidAzuV/DZW6g==
X-Received: by 2002:a05:600c:4ed0:b0:426:654e:16da with SMTP id
 5b1f17b1804b1-42c7b517656mr67767215e9.0.1725363106992; 
 Tue, 03 Sep 2024 04:31:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c7e62b1esm6705752f8f.36.2024.09.03.04.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:31:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 42/81] drm/tidss: Run DRM default client setup
In-Reply-To: <20240830084456.77630-43-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-43-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:31:45 +0200
Message-ID: <87ttexdlcu.fsf@minerva.mail-host-address-is-not-set>
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
> The tidss driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jyri Sarha <jyri.sarha@iki.fi>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

