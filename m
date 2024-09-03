Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE5CCD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB29B10E4D0;
	Tue,  3 Sep 2024 11:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hU/UiXTF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93BD10E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7KjPkZaY6LPM2R/IvEHcw05+p3Okl3omvvBGG6T0MA=;
 b=hU/UiXTFoUOV/r3VTLKJxeVWdEhiWyBjsVYpsjBVhHg7uAgXEVtXMAYMzZfFwSsu4qeJ9Z
 lFFOMWZVGRutRZyzTTTXmCal7s9ruq9m5cpI7GRWOg/wAO7ejHHEIycUWGOMIgZ801C3Gi
 jn7v5E/J2PamqT0z2pqbnf/4l/w7xbs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-jdSpEBhOPWaTmyaK6v03TQ-1; Tue, 03 Sep 2024 07:30:43 -0400
X-MC-Unique: jdSpEBhOPWaTmyaK6v03TQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c90d24e3so1933157f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363042; x=1725967842;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7KjPkZaY6LPM2R/IvEHcw05+p3Okl3omvvBGG6T0MA=;
 b=RB0iBbAMAEh/LxYZnpI1G1/4y+TvBCKlTXdzsmzrYu/u040MXehsbxyhfUKCMNgkEO
 5P15bce9KN1gI3veaV74l5Vg+1BdLFKQE/caeDPF0NRYlAo+dCgwZ8ZGksfiURYyo67h
 NaHq+Sdk6b4IEmjXp1fP/w8ggKjfDeLEwLj19lllblZ6BmDqyh1O4ntrx9lmtTb/jvEk
 Wlo5VngaRyOgTuz1kJqxx+W2t9rrhny+COecsVLTAaP7pFQlrqlx96Ds5YfnG3grQ29k
 wRZdWvK+gwHmOgj8oxSUs7RR5t2WuNRzzK0Fs/zuH5SJhr1jSF1+UQk0qH0648JHLcVC
 4ADA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKCH7Z7PIijr9yH75B2moPXZyJGQxFNbqB6Nk6ELfUqZ6dTWeG8KGhJNxPH9U51cx+ynnBrpwG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHa7WqzkWh1THWPOD5Ru5v0RiJMJB3z3/FEc0RX0GBMVbc3Ije
 KnBOBB7C+xrv6VyAgxyvI3RLU+TZmxykNUJxpNCdGkgf/lXG8zAZohByn7zmOu2lmQVF2C1pa7a
 pGScnMz5LczBYT6Wzjz4Scf+XpeYzSjyaFfoJQShAHFZfEQMoGnh0EKE/ggzk1sajimgnVME=
X-Received: by 2002:a5d:4fc4:0:b0:374:cafe:c55f with SMTP id
 ffacd0b85a97d-374cafec737mr4142332f8f.20.1725363041820; 
 Tue, 03 Sep 2024 04:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaxU5bJuIzUDf8RSjazoPcbW/KJpDG6+5g7d7j21W0xhBI7SOXf/r+/zCa6XdnhnO6fGnIQQ==
X-Received: by 2002:a5d:4fc4:0:b0:374:cafe:c55f with SMTP id
 ffacd0b85a97d-374cafec737mr4142303f8f.20.1725363041396; 
 Tue, 03 Sep 2024 04:30:41 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4d391sm14089852f8f.3.2024.09.03.04.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:30:41 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH v3 39/81] drm/sti: Run DRM default client setup
In-Reply-To: <20240830084456.77630-40-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-40-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:30:40 +0200
Message-ID: <87zfopdlen.fsf@minerva.mail-host-address-is-not-set>
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
> The sti driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  drivers/gpu/drm/sti/sti_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

