Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B68BCD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDA110E538;
	Tue,  3 Sep 2024 12:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FCjn/aZb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E2E10E535
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Swr4IS8dbgShAURYPvnCTpzYM2TD6Zc8Nzbs4EI076g=;
 b=FCjn/aZbq3IU6mc9taUpXCVGF6R8ylKCcKp7sl7TFF8U/nmuzrPSvOw3smnue9DVtl4Hlg
 dBh+W7umYlnx1UdwVgHEeQZJN78O/EtfIZyF25R/DTxIwkOI77iI/cNm+S56uAY/OTrnSE
 gB87w05UI7NzMjbjZJ0rQK8q7bcAjgE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-LvljCUFQMBaenI7eVLlypQ-1; Tue, 03 Sep 2024 08:07:23 -0400
X-MC-Unique: LvljCUFQMBaenI7eVLlypQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c294d841so2363376f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365242; x=1725970042;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Swr4IS8dbgShAURYPvnCTpzYM2TD6Zc8Nzbs4EI076g=;
 b=mxxhf8+INNV7voOlbZ8Q2QzUehQ06GiCGoMyB/FIpVHkNKyoNK/j42XtKhW1kl4j2w
 iLEraOhUD54uwfJGAlCjYHegWRTTEXizNMSw0H4/NkC9ljwnO0WL732t69wzgjYtMVLn
 CZeOAErikGjeVpQE8IM9bDlBZgn0EN4/gibZA9E3q7J+3S7xo8ixGoQuWFcD6/jCyNbK
 gsCZPXP339G6F3kkVIB4jxlt9S7upwfw2i94wu7cSnu+SukrWsaBzDVm6jzUP6dePwhz
 yE3us5CRpQs5A5vG88KHcVP/RJp5Ycp0kitiRfTbLTEsXZsIPdVl9co+EtaMrWlrm6ST
 jSdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzQhwUSL+D8/akKFw1EdYSoaT47qz/y/WUjZ61DwJDgt6Dc7o7LoSHLlaBmoKMWChr3sRTJHHx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJ/R6FvExhdwFyIaVTjUfXVlZdnENbpGmt638tJ7iLjR9Cf2MC
 qAgFyKieYI/+zTrrfIA9KvTwq019ZYAIjffQvSBFPmdyLt6RfXzJuQGNCQ3mN6iPPGsVnO7qUzD
 jiwBER5KYXz0BANIVqhe1HaRXuhiW0utBxTHPoN515Dkw36gyISd8tc5IXFtsn6M=
X-Received: by 2002:a05:6000:cc1:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-3749b526222mr13863883f8f.12.1725365241917; 
 Tue, 03 Sep 2024 05:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2NHKd/OZS0qGl6rQ/cQL7X9ho+DUsYgIVLhqFSVXN311ZJ1N/JkOGUvCE3TFPMHJvuHGT6Q==
X-Received: by 2002:a05:6000:cc1:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-3749b526222mr13863856f8f.12.1725365241536; 
 Tue, 03 Sep 2024 05:07:21 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c88c624f7sm27274635e9.39.2024.09.03.05.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:07:21 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 71/81] drm/vboxvideo: Run DRM default client setup
In-Reply-To: <20240830084456.77630-72-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-72-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:07:20 +0200
Message-ID: <87plplc553.fsf@minerva.mail-host-address-is-not-set>
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
> The vboxvideo driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/vboxvideo/vbox_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

