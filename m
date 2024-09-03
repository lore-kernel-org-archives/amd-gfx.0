Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C90CD3420
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3624110E4B7;
	Tue,  3 Sep 2024 11:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UwiqGrh2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DA610E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vdWgGVoYLM430WyC+dlybsR86ICY1TW+TxFH6owfPF0=;
 b=UwiqGrh2nzeF4EPUJSs3WbSAZ8wFOaZ+E5Z3RsrtMuXdYoAxaj9IW2PwddnlJHYql9Daj2
 MhUC5KYNe26olFA5GHeDFWnErqkEM4wx1JD7VhpRRQXRrzmR+pHT+AZU2c0ZMYfc+5z8c8
 dbW32yBpjNui8ozQGWx0WJjNBrbIILQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-_RzAmV7LO0SdoerRHdKz4Q-1; Tue, 03 Sep 2024 07:26:19 -0400
X-MC-Unique: _RzAmV7LO0SdoerRHdKz4Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-53349c739d0so814075e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362778; x=1725967578;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdWgGVoYLM430WyC+dlybsR86ICY1TW+TxFH6owfPF0=;
 b=KBns/upPNKy/lt3NZHUvDSvET3kluhirfFPRxnGqKvAozitGqXqQqyzrP8BDELZRCM
 Sb/jhoWBHpLFMqt/BO8eBn9InqpC3DIu2WYs8SqvCa57pVt2Aq0PXvib7EaToQvgEapF
 qAa6VruaF1mtEs5G2RkpI2zNfCJhDhL5tGrlYeIKeT3fxBFuRt7+wPATUCZNc0ApvBEm
 xAT66mX8osUd3hWBtbFnfjQiTvZD5h7sX6UCeUJAUc247yBk42GqQwOISKMhtQVJ0nJk
 GwlhXgwPdudLvjALVwI9TdtCdD5ocr/kJYYmaGjHSchf6cNzb4WpUVCLAIpSQ2cHnwJA
 q7OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0dL5PqBPXeskoJ5MU+j6rrxs9/XM5WvOSqU/Ci729LpqGdsBuJHSfhz1G4xL34iXS2xnTgVv1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuErdhtqdY+csdPtUMmFJTD1boP26RLLxe9Q+RtWGdZmp04AN3
 y5z9CJf2dZWE4Y+lXCb+vD1mbBLkfIhiUk2BmSCHEuZncjBkCc27idQq/VXtyMAX6Qic5h7nx1i
 PWXlXo83HxiOUkdF92yBABa15M/N6tvVFFnzqK30xoIAu2Pp/JcPQEBDPEmeCq3A=
X-Received: by 2002:a05:6512:1294:b0:533:4477:28a2 with SMTP id
 2adb3069b0e04-53546b04544mr8808337e87.16.1725362778302; 
 Tue, 03 Sep 2024 04:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHwRLJHDZdrQkwQWAm+tFo/D0GDWaihGfGc3BFYX5j5bYPJbZDKSAndVvvzTOghOv1AtRVHQ==
X-Received: by 2002:a05:6512:1294:b0:533:4477:28a2 with SMTP id
 2adb3069b0e04-53546b04544mr8808321e87.16.1725362777673; 
 Tue, 03 Sep 2024 04:26:17 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba7b4271fsm200957535e9.29.2024.09.03.04.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:26:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, Edmund Dea
 <edmund.j.dea@intel.com>
Subject: Re: [PATCH v3 23/81] drm/kmb: Run DRM default client setup
In-Reply-To: <20240830084456.77630-24-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-24-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:26:16 +0200
Message-ID: <87ikvdf06f.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
> Cc: Edmund Dea <edmund.j.dea@intel.com>
> ---
>  drivers/gpu/drm/kmb/kmb_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>


-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

