Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4278DCD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C2710E51F;
	Tue,  3 Sep 2024 12:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BiVwh+Sc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287CD10E52F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zx4hxQtRMdOzrygXNdwQEDskzaynxlUA2aQcUcONdUA=;
 b=BiVwh+ScsdhggeB/RdB3+G3JoPbn3JtVOTgU+nmq/WEHINBE+GGl0LbltdHKarKNLICNKX
 l5rqu8MEwqmQeMzi+OlN6gtKcq71DSZtDzPI6LiaXMIzNBVJZCmUA26Vc1+IMA1/ljyqPg
 9YDudoBlp4DvU+EE97WP9mgydREFqg0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-oCZwlqE9NAa4B-lFysHx5w-1; Tue, 03 Sep 2024 08:07:02 -0400
X-MC-Unique: oCZwlqE9NAa4B-lFysHx5w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2f3fc9d8c00so52378831fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365221; x=1725970021;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zx4hxQtRMdOzrygXNdwQEDskzaynxlUA2aQcUcONdUA=;
 b=t/A8rdHIINHuSPBuXIAMjz5YPixCkORExnwYN9oAznMlCMQBuRZaUAQbeBfxGIn8ov
 lJMJbi+bt1kEVedC3rieZkECHTpYYZXTw4FzlG6XpyMqIVxqn6i9PUEAjU/qvaI1dE1y
 ZXJ+bK0YHBZwX64PSzwil8aA/xr/1z4dLYlbMVxF4/T93acCadnLfcAWZhNdr9t5Vzf4
 mfJZcfCzTJ0npuPMZ4bJgWS47jPmGn5U0ux6tVW2I76nXfdkDeZskjuQuCsMd5/VHPmL
 MYjUzkwcQ23qKeGOv/b/QfMpPk8lFq6i8BPCbK6mksJvZHn4pHG9cMqVT14mzUfholFz
 +XPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmYomzPQqALjCFwm9Yrib1tA7MDZrvVPFuwSqQYmyVeZQkLXh6MigSoyvyiz/6nWuxij/tIpD5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq5+A1Rv4JoPvx1FwjloEbnicYryFrQuPJBjmPShQPtYVxPhFf
 z4AcRQJBS7F23H+5QUVRtr4e4AE+NVwn1k/rqxdUxO0AG05zPvjKFW6IOcuT/LVFiqntZgQkA+O
 E4vcro4Xzr4Lr1C4QpNQau7qoklmcdZfdygZfDzwi+ExMuWF3EUEqJpe601SLa+o=
X-Received: by 2002:a2e:be07:0:b0:2ef:2b53:c77e with SMTP id
 38308e7fff4ca-2f62655044fmr76802071fa.7.1725365221308; 
 Tue, 03 Sep 2024 05:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYL7VU+pPWXFbZvZO3luoy/PZCZxgIoqNkVLPQzNR06jKjtB+IuiohUKE273yPfAVbpvuDQ==
X-Received: by 2002:a2e:be07:0:b0:2ef:2b53:c77e with SMTP id
 38308e7fff4ca-2f62655044fmr76801781fa.7.1725365220740; 
 Tue, 03 Sep 2024 05:07:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e273e3sm168566335e9.30.2024.09.03.05.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:07:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 70/81] drm/qxl: Run DRM default client setup
In-Reply-To: <20240830084456.77630-71-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-71-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:06:59 +0200
Message-ID: <87seuhc55o.fsf@minerva.mail-host-address-is-not-set>
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
> The qxl driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

