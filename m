Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943ECCD3429
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627FF10E493;
	Tue,  3 Sep 2024 11:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RWlDFUbw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 376E310E494
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H24uYoqbfGl2vUBYr+//xmtelWdObhpGCRj8ekWugog=;
 b=RWlDFUbwKfQJ4D+WMECz9OTP+Ws0jfTGI0uUmRNQdv5Qu7/KDKiOZc52P3egwBA1VJRN8f
 Q4JTtW26ivCT+kHJN0sjo72geXAKIb4FOVtYZh0S+U+8DJmNih7UmrpAULYJ5lLlzUN/uV
 COv/xZ4Ub3SMOq47RlAg/hpk8kEsLBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-zCk90XjvNVCzHuijNY1jsQ-1; Tue, 03 Sep 2024 07:20:33 -0400
X-MC-Unique: zCk90XjvNVCzHuijNY1jsQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bacd5cccso2476490f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362432; x=1725967232;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H24uYoqbfGl2vUBYr+//xmtelWdObhpGCRj8ekWugog=;
 b=sa11aybeCYGq9zQzdFbofF6ybd6TnMRsHNgCS/kBAFodCbJid3KQXCSxmZMzFZHQOi
 FcUTmAQRNu6yCaoDVsCLkB2eywLsqm2eZeo6DWXvS/IX/XIKlX6sQIhWyUT+XKdbqddi
 9IvRHs5rZeMQ8AEcg1k/mEgNIbjBxyF6Db73xftcHvcrXfUFHV9Vy1dD0ZhOIVjOBvqV
 gZ/9YKowVTg2dgUUpCNSK0fH0O38Kx5931P0CjwLCBBMZqAefEEUIdon0TwhikkEvepE
 r3q4Vjq4vzhhsWtRE7xJuPPE05bZpL34eH49RNL8ACZedxySNNhsob1TSLJl6mV2H0k5
 iUWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUakE915g1l3dn0WlUzHN1NBFy0bztxNz/UggsI5KLSHayRM/RcMBogGTwuHo0MqZ4pW9zES32G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHZwik6PEVKcBg2ocC0H8tgp57RHN8L361HU6S1T/JdtyFbBw5
 3f8vkkrgDfsg69ggIDofNOXswkFf2Qj7W1oSm4FEaWA8teuQZjYAeULGgOpzbo6xmzwJQLP1hcV
 4qvznMW9Oa3x0I+jPD6FHWhvfCiex1l+oyJfo6T9j09porZC+ZjzfeLb+bswF87s=
X-Received: by 2002:adf:e9c4:0:b0:374:bad0:2b72 with SMTP id
 ffacd0b85a97d-374bad02cdfmr6548896f8f.11.1725362432184; 
 Tue, 03 Sep 2024 04:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbwpteDh/jYV60lwH9EfcQ38ojTrOG4EYTUpYCdQn17HGXGrVhhlQh31XG3MTmZZx8V6M3Sw==
X-Received: by 2002:adf:e9c4:0:b0:374:bad0:2b72 with SMTP id
 ffacd0b85a97d-374bad02cdfmr6548866f8f.11.1725362431651; 
 Tue, 03 Sep 2024 04:20:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e27364sm166897175e9.34.2024.09.03.04.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:20:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 14/81] drm/hx8357d: Run DRM default client setup
In-Reply-To: <20240830084456.77630-15-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-15-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:20:30 +0200
Message-ID: <8734mhgf0h.fsf@minerva.mail-host-address-is-not-set>
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
> ---
>  drivers/gpu/drm/tiny/hx8357d.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

