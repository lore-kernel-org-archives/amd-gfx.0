Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D01FCD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1494210E572;
	Tue,  3 Sep 2024 12:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fxJ46ba2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4851110E572
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725366093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BELKt6Ttgttp44KZLo39NaUCnuGWPJGVPDpp4SZgL/I=;
 b=fxJ46ba2d54NWMJXB9BJq9qyMFh0bZ0mf1a5x58zLoYMrDAYHioU+BwoKz9JZxoblMyACk
 +B1oqTYxBYI7RLhkWS1RxVD/RhoyIPuUIzq4vNVwFf3G8BpyDdAnH/DGU2L4Ru6Gj/8BXA
 ARhP5nNDoCh1W1BJtl/zYt69UC67/wA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-9YSrC1oXPb6RN8_Th_8XLA-1; Tue, 03 Sep 2024 08:21:30 -0400
X-MC-Unique: 9YSrC1oXPb6RN8_Th_8XLA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c4c48c87so1534166f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725366089; x=1725970889;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BELKt6Ttgttp44KZLo39NaUCnuGWPJGVPDpp4SZgL/I=;
 b=RcWvGxcSdQjDTfaQ2/EmTr4g17++CHCjMj7Swv4RmouSP1++GXpQzJdNqpm+oAZP8P
 paNYZCjpEhlETzYcqG1HxdwJ2Dch4JKkAYd6LvR2AH9R5zN6w8mYCzXnG4zi+c12x9wQ
 JQImDPAHvaC3EhewQCLUKxIaXheS3GYNxrf84qnb2sBFmYB0qwxPii5CMjZ9FFs3iJvu
 TBZx4OP/3Mm4d4fISERF33BR7a/6LTlHQ+COYLpVnTzW6Ui/9avSAhJljVTmFY4tLtBM
 +bHIqT/D4cLm2FYRxyaQPMIpRxd6+npbsDrxii27YzJJfsdmUT8LDczA2avQPUkVUqWk
 wAXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWx4Itc6KAheMGA9Pj/Ohr/ovXbtHvmoozx4LeTOQ+8xeuo4j4XYJyIWUvykK8l6IczdIeBMXc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzSMMzKW2no99CFUUkP14ATfzYBARp8ECFbLvNygg+EgzpOhac
 z6pLj/DXZYH/9oC2T69vrBuH7oRSZC0w6JqGsNVWU9GhFMTwnxD/vx+CkFZ1bgsW6CJMaC2dQsN
 3q+XuJ9vG+4Q+A+xIwzcHN/FOeRtam6ZQ1kNzUol8RmmzoUCLWcBTHxHm588RUmo=
X-Received: by 2002:adf:e444:0:b0:374:c1de:7e64 with SMTP id
 ffacd0b85a97d-374c1de81d6mr5378319f8f.42.1725366089286; 
 Tue, 03 Sep 2024 05:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF8EjxKd2aOIdtAzJFfWCYf1w8V/EizPUPJu8WLhb/9BPY/tZjtvJP/yhzDFusXvOdur9h1Q==
X-Received: by 2002:adf:e444:0:b0:374:c1de:7e64 with SMTP id
 ffacd0b85a97d-374c1de81d6mr5378299f8f.42.1725366088831; 
 Tue, 03 Sep 2024 05:21:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c958c471sm6157477f8f.25.2024.09.03.05.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:21:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 80/81] drm/omapdrm: Remove struct drm_fb_helper from
 struct omap_fbdev.
In-Reply-To: <20240830084456.77630-81-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-81-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:21:27 +0200
Message-ID: <8734mhc4hk.fsf@minerva.mail-host-address-is-not-set>
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

> Store instances of drm_fb_helper and struct omap_fbdev separately.
> This will allow omapdrm to use the common fbdev client, which allocates
> its own instance of struct drm_fb_helper.
>
> There is at most one instance of each per DRM device, so both can be
> referenced directly from the omap and DRM device structures. A later
> patchset might rework the common fbdev client to allow for storing
> both, drm_fb_helper and omap_fbdev, together in the same place.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.h   |  3 ++
>  drivers/gpu/drm/omapdrm/omap_fbdev.c | 42 +++++++++++++++-------------
>  2 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
> index 4c7217b35f6b..d903568fd8cc 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -32,6 +32,7 @@
>  #define MODULE_NAME     "omapdrm"
>  

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

