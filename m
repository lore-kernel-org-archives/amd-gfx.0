Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1A4CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0C410E560;
	Tue,  3 Sep 2024 12:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AqSPS4HY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648FE10E55F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725365820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agFMB1xAtcWm4AXKS6Y4zMlSOya0yRuTuGxykObZEjk=;
 b=AqSPS4HYG2udou2frLBnwKmyu8iSnGnVia0zXXWE9OCLy2fgg+1+lDI3eWzNjQMlyrS5YY
 Jr27sqfC7Hq/JwMBTBcCzIyE+mYtXUcl5r5VrXGVUQvacZ0Z57RmqEJE5Kj5GrlSei+TcU
 3sEa4gxfSEBn03hs+obcCEQmiUgSmLg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-3joEgc1MMtSx2d6wUExp1Q-1; Tue, 03 Sep 2024 08:16:59 -0400
X-MC-Unique: 3joEgc1MMtSx2d6wUExp1Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42c78767b90so28959615e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725365815; x=1725970615;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agFMB1xAtcWm4AXKS6Y4zMlSOya0yRuTuGxykObZEjk=;
 b=a36cEasZiMmDQzvpWOszeeZ6uYtUprjzHud1h2H84DZp+LnO7ipG7I7ff4co6H6W6N
 O8+FNbHBaJFNJmQgAx/aSnhdL+1OJUirsNVuiGLS2WRv3eXHWMU2uflddZ4y4LqBxJNH
 nrjwrhVStXktRHmDQey5cMn8WeqLWkdIVluEmToguv6O/Zu+EepXEs4KfNYLlHpfT+g5
 yQyvELDPlovnXXnzo6gZwiOEX7m+VaM6QZ+cKnUicHdttrJ/nSPWmlQEsriJn9Y8RTYO
 /JIZfj+tvcNPsXiLjJdUG8X1RRm/js0D+g1wkyZOCSeb95OmUD6o9apEL7ZaFAcJEY1n
 SCrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlWwhkMM+i9DEk1RcmEkucnxSck79KmN/0b3Ppfde1HhwR22Qv5tKr2jMTD6/I6lSPmC6PmAlX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIZ6/3dXl56nx6iiSWJjxpqAoq6ixndFVgV1jGv9ZA3s4HEzre
 oivxf/tI9H++tg9CGJ/vFZ5nfSUDhOD34wwbvqg8XYYskvTefkSa9r30UzbcTZkK5ikNXkbQv/m
 10ETeMy85Zhu3/aabC9Ol3NnnPvY0rNxoGel8AYJPGqMN1rmJ40Ssaw6eWyqKAY4=
X-Received: by 2002:a05:600c:310a:b0:42b:ac55:b327 with SMTP id
 5b1f17b1804b1-42c880efb88mr26637225e9.12.1725365815302; 
 Tue, 03 Sep 2024 05:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4j1HQbJZ4tQ+5HUrU1wf3ZhSaYNsES3j6jps+inrau18KybLARTHZrpwsf2i8vLhskKlqcQ==
X-Received: by 2002:a05:600c:310a:b0:42b:ac55:b327 with SMTP id
 5b1f17b1804b1-42c880efb88mr26637005e9.12.1725365814792; 
 Tue, 03 Sep 2024 05:16:54 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df100csm168841155e9.20.2024.09.03.05.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:16:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>
Subject: Re: [PATCH v3 77/81] drm/msm: Run DRM default client setup
In-Reply-To: <20240830084456.77630-78-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-78-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:16:53 +0200
Message-ID: <878qw9c4p6.fsf@minerva.mail-host-address-is-not-set>
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

> Rework fbdev probing to support fbdev_probe in struct drm_driver
> and remove the old fb_probe callback. Provide an initializer macro
> for struct drm_driver that sets the callback according to the kernel
> configuration.
>
> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> The msm driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c   |   4 +-
>  drivers/gpu/drm/msm/msm_drv.h   |  13 ++-
>  drivers/gpu/drm/msm/msm_fbdev.c | 144 ++++++--------------------------
>  3 files changed, 38 insertions(+), 123 deletions(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

