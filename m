Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D268CD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1023C10E49F;
	Tue,  3 Sep 2024 11:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BrOCpz8l";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A488310E49F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pSNCLSbIMoFviNER5g8TfLmLnq+IvKF9riHz/S803E=;
 b=BrOCpz8lZquVzVXMXqjUKbte4FB0jrvJInA2XW7VnpPvmmkzqKy8oj03/MELb4AQcSrshi
 buDYsAIxJsH8+jofzSYKvI64/C024ykLic5kM9TxlPayUUxjwojplOgC9hYHgfzcPwCM4x
 l+1ryAmVJvNWtkia/QBSpTFaO+CViVY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-B_RtzN0oM9e-JfcTXGXMOA-1; Tue, 03 Sep 2024 07:24:13 -0400
X-MC-Unique: B_RtzN0oM9e-JfcTXGXMOA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c581ce35so1374280f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362652; x=1725967452;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2pSNCLSbIMoFviNER5g8TfLmLnq+IvKF9riHz/S803E=;
 b=GZHhOla92AscVmXOTDUn9mFYci+YIvzHR6No+GyWPGgwkoqF74p5cLw0cG4dxjnkc7
 Lq8GHmbtwSBoMMMkGhmUAhM9T6DB3LbPJIihOeb2IwwDqgG9p8vrPEu/3hn+WbePnUcK
 n3xLCiWi24teC7SrXMPwmH2dFq5Ck9KuLCC/6iydBD/+80Qp1vE/JpaTAJ1Nv185znv3
 J5HXsQCBnWDC6V3bLH5gVdfJP4NkWmiHT70Z93+fMT7k3f5OeptZsjnwx1Vk0N5Tw7do
 Zwoy0D+wphVPShsSpnkwK+3kGb5Vy7wHi3kEegx1TlBIsJRE1ZzYedSjBsGQucaCaVgd
 jz8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEeKWyIUjzM4aXjg8tgGMlp69bfUe8Aq5/sWAzKjr0HvWd/Ja3ZmYusRVbmvFhd14oJjbS7Fk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+WNHqmz2iURZWlHKfovHGa/UIn/x+N5xtdlEPirczJ64CNTvM
 tZTceVmUaZ1HfRG9DJNqldA6OQ9cFQmIog8hf2EEUl8TWb/9MvS2ul4o3W3fsJlqUd1ItW1zCpJ
 0012a41GSg8fOXC1/3+I5fi+pPEroZkx3SfSaspb4Km5Hi3NMrlDbxTDofE0Mit8=
X-Received: by 2002:a5d:66ce:0:b0:374:b960:facf with SMTP id
 ffacd0b85a97d-376df005691mr261409f8f.58.1725362652554; 
 Tue, 03 Sep 2024 04:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfMTx0LxlS9Vbxx5qqNkZNnc83gbfH8tZBpkVQ/eip0g3zytayB3JyreNf5DmRURM4ZJWCVA==
X-Received: by 2002:a5d:66ce:0:b0:374:b960:facf with SMTP id
 ffacd0b85a97d-376df005691mr261378f8f.58.1725362652054; 
 Tue, 03 Sep 2024 04:24:12 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c554f0c2sm7431928f8f.43.2024.09.03.04.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:24:11 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: Re: [PATCH v3 18/81] drm/ili9486: Run DRM default client setup
In-Reply-To: <20240830084456.77630-19-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-19-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:24:10 +0200
Message-ID: <87ttexf09x.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
> ---
>  drivers/gpu/drm/tiny/ili9486.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

