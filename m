Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31880CD3429
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE14710E517;
	Tue,  3 Sep 2024 12:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dFW91iIA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4AA10E513
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fiZjoQDP1pxCas9l8KljpRaPLENWaMi4jehrGgSlHU=;
 b=dFW91iIAtx99Wx9S0eA8oIPAtRqF2zhgfZuICPCy7POYqhh8MrnG0ZjxGfyTP917s4c0C9
 3499/hbw94frmTiy7ICXg+Nx1sg74RrwdFuC1IzWzBAhGFHc8MIicB9olUp3mid9PqyS7h
 uobtvw2SNW/b1xOal/MizLQMsG8JiO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-432KY_dLNDOeROmtxkVq5g-1; Tue, 03 Sep 2024 08:04:20 -0400
X-MC-Unique: 432KY_dLNDOeROmtxkVq5g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42bb9fa67d7so50433255e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365059; x=1725969859;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fiZjoQDP1pxCas9l8KljpRaPLENWaMi4jehrGgSlHU=;
 b=TuCh4siKwwNxOc9XoC5PCklSmMLNa0fUehIC49oq8DN03fC5qPAIVMSKchByK0Untc
 ECsVE4xENzexZfhR01uOl0Hpcosl0YXPJf47mzpsOBA3sBa+fAFbwuOSkqbeFu37F662
 u7w1NtvJhutX9pko1engud7+Qm8M90GBc+Vk0rmM0lo1lwKinuWirItpqzjstIjKMQdR
 c6TcwTonn/n1aFRvwDT3KpHuW6DCcsHE9i+SXrDNvc0rKPE7TiLsaO2C5kiAnrcqzZ2O
 LCeE2fScA02aFbmtHgnwz7JqHTqVsOD7Ayx+b1SyaQHLp8o301AfRCg9K/WGBoQ/83H5
 th+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSRMX55FEd6srLaM6auBXuDRYSTqayN8S/5kWEAAif657ACKzPY5Jzvuxmb8cTHbb8fAGVGW0K@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5IdwUrDZ1paAsYnboi5snSp9diVNN3gZf3YGwDeuNNaX9qUPb
 s3XTeOT6CAc6y2q0n19kfdcKZtqy7LJ5+KOi+Acx+wiJTFem1G8vHXuQFoEUVYcPbRy4ylnXJ79
 zi5NvJioKEhKPnOZmZeuZex4HxN0DObK1OE60iJW8XbLXdGQRm1TcMR1k/RcfKAg=
X-Received: by 2002:a05:600c:474c:b0:429:c674:d9de with SMTP id
 5b1f17b1804b1-42bb01ad776mr149399625e9.2.1725365058836; 
 Tue, 03 Sep 2024 05:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAsxohFpaNmRsPtig4vIEqTLLJJ6A9qw2cCf0dEsQNkZ8aqk53IDxglqBJcoW1INXcnXT9w==
X-Received: by 2002:a05:600c:474c:b0:429:c674:d9de with SMTP id
 5b1f17b1804b1-42bb01ad776mr149399315e9.2.1725365058397; 
 Tue, 03 Sep 2024 05:04:18 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbf00e095sm129587485e9.13.2024.09.03.05.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:04:18 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 63/81] drm/fbdev-shmem: Remove obsolete setup function
In-Reply-To: <20240830084456.77630-64-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-64-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:04:17 +0200
Message-ID: <874j6xdjum.fsf@minerva.mail-host-address-is-not-set>
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

> The old setup function drm_fbdev_shmem_setup() is unused. Remove it
> and its internal callbacks. New drivers should call drm_client_setup()
> instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_shmem.c | 120 +-----------------------------
>  include/drm/drm_fbdev_shmem.h     |   6 --
>  2 files changed, 1 insertion(+), 125 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

