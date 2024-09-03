Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58CCD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D21810E4A0;
	Tue,  3 Sep 2024 11:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cymGvkPI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FB110E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbJNkV9u0ZGr/jKEh9pTFkh2fVXMicyQllArXRfkk5s=;
 b=cymGvkPIBxRw3aqFs05WwGnSI10AM0g4QnjKm0gVNHUeyhXC0+zyeVIi7wCudEB7rm4t4K
 PIhD3yogYtUmaUPGx8tLPFhBZDRyknjJMevQeV5zBunb5niOofLAr+BGUl+8Z2WT0XJeH9
 IvTLSLBNEfMdMCd+JtJ8FQzpxnw/B+o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-7wOzTkiXP32AqYzNKTsB5g-1; Tue, 03 Sep 2024 07:23:47 -0400
X-MC-Unique: 7wOzTkiXP32AqYzNKTsB5g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374b69e65e8so2535997f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362626; x=1725967426;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbJNkV9u0ZGr/jKEh9pTFkh2fVXMicyQllArXRfkk5s=;
 b=Htievz/bMQgiDfr0BlFUQo+RxXDNZyFXjmm7hwpfpP703JqHK7t7vInkUduYfozA07
 GdfoD1KvxkQr6jNUOWHWWBWKisAmgf08oopH3iyhBRk+nvST9DRGVi8cWpCwsQJZEw9e
 10vr8r8bnN81eEXwrSrRbri0khafbYzyuetKMxn5s5Fck1E9uhSRzt1+zsDbYeq+y+x6
 AmyE67+0nhTALvgDK3sNExEKShnxdq9Et4KIssppfYq+IPyhjqPGwALceUdku1SBv5+o
 4Xco8cHIQmbNQObgar1sbV88IFkWEcDmKEm6yZIJKSkBGcMEIvMrORlwHGGVEkqOtrQW
 HgJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVZvqY2dZzgS19zp6hQv45+Dw6jE4Q5gI6kqB0t9OqKV0H5mJTWafhXGXb51UggjAUoYqsB4io@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqJecoDsKcVk+h0U0A9SclYbJSUqWUWO2Gl1qJNhRUc9FmTnN8
 pniBWBHLoyTbRxRzU12ZTCM1U4z3zLyRI0DJ1K/rnaTLLAReto/8+kTfXNTewM5kUIHTrd46Py8
 LTLR8r+YCbTK6BjZBTRKx62MlzDg/8mn4G9DRllwscK/eqDB8D0wWY07qL8UipF4=
X-Received: by 2002:adf:f784:0:b0:374:c69b:5a16 with SMTP id
 ffacd0b85a97d-374f9e47a5cmr2179062f8f.50.1725362626239; 
 Tue, 03 Sep 2024 04:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSm/RqGjce7S7ZMEuf3IOUzOzr9uuowr5iGarnhEC2vfQARAToz2WJdH4ddi+cl3DwZjT8sw==
X-Received: by 2002:adf:f784:0:b0:374:c69b:5a16 with SMTP id
 ffacd0b85a97d-374f9e47a5cmr2179047f8f.50.1725362625744; 
 Tue, 03 Sep 2024 04:23:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374ba30d5b8sm10273357f8f.15.2024.09.03.04.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:23:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 17/81] drm/ili9341: Run DRM default client setup
In-Reply-To: <20240830084456.77630-18-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-18-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:23:44 +0200
Message-ID: <87wmjtf0an.fsf@minerva.mail-host-address-is-not-set>
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
>  drivers/gpu/drm/tiny/ili9341.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

