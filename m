Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9976CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425C210E4B1;
	Tue,  3 Sep 2024 11:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YSymu/4T";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531EB10E4B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9sC7HLJXuWub0EarNCELOa44xh6zW87AqTRwbOpLZOM=;
 b=YSymu/4TSk2Y6nHlbWPrdNZewJdgNmp4iqmEgl8/xThBaxJn1tmI/+aN/eqah4ScK5UUyu
 QV6rNHCz1zI1FhEDMxeiQk9QK+xgOKaJAwZlH486p1Tv1pyrOWEenonflqx0da+Fqg4JIt
 bQK+a9n43a1d0cVBw6Io6PDi1hlUIpM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-nuo8Ipa1Pi2bZdYbDgMrww-1; Tue, 03 Sep 2024 07:25:45 -0400
X-MC-Unique: nuo8Ipa1Pi2bZdYbDgMrww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bbf928882so34169285e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362744; x=1725967544;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sC7HLJXuWub0EarNCELOa44xh6zW87AqTRwbOpLZOM=;
 b=HboDR2fyMesRqK/iRCmI7LFBgsoAGZfHePw5i/uRmH6NiqKXvTioJB7i9JIaOFaGSZ
 bf8L7sE7gGpGU5Exdk+lMRtns07xyK9f9hsL3vO4SYotTRKXPn9K49GQC2bvqbUysFwH
 xa/K+V8ecH67Jbifou4I3BDEKqbGqXxnyPdVs3bHIOnRuVE4Ei3jMnT1uOYdKqiWZQQL
 G3Rujx3qEI3gNUawUyXUUcMJL6/tOUzOmETcUmCaAhhLCmG5bi8GqHR5x5ndtDNCzz2b
 nW8ypUhlqAu+dMPbwhW9+4PlQI+W2j/9QS0iHwBwUbHo9rkCtURGIz87uR/MyZoE+2Sv
 labw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIq8v3IEBWxSNcQZmLiK7WOwGzlGXu+6D3tFifZAZDWQa1f2LknEXQFF502OK6BULijhhEo8qH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQkIGUXHZ9xcUC0G+vJLqoFeznn//TSUOg78bv96vC61VeYcNK
 4SQcVPRcprvtNgN3XEYKwevs5RnhmEgGcmICM/JhDXCzOgElomBrF4tU7yWSAWgcXJZzLxdsczL
 fbzG5k8E9THNxXR24s+nnuCxNmxWqJKLybenWVOcB2DNh9YDy4iVLejg5ZRKabXs=
X-Received: by 2002:adf:f747:0:b0:376:27b7:da7d with SMTP id
 ffacd0b85a97d-376dd71ab0fmr356721f8f.32.1725362744044; 
 Tue, 03 Sep 2024 04:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA3yj2kCeHDSDWyAEM2Yi0qle8pXxFLZPw8+JMts+88BoPIGSyVA7+QhDZU1CF/5hz8VqrKg==
X-Received: by 2002:adf:f747:0:b0:376:27b7:da7d with SMTP id
 ffacd0b85a97d-376dd71ab0fmr356701f8f.32.1725362743587; 
 Tue, 03 Sep 2024 04:25:43 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbc36bd88sm139874945e9.24.2024.09.03.04.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:25:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>
Subject: Re: [PATCH v3 21/81] drm/imx/lcdc: Run DRM default client setup
In-Reply-To: <20240830084456.77630-22-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-22-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:25:42 +0200
Message-ID: <87le09f07d.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>


-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

