Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF244CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7872010E4BE;
	Tue,  3 Sep 2024 11:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KuYZki7w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F6B10E4B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725362869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Six38zRCaVcSjI7X8SSQRqVfbWN9LoiIAfaa2uKesPo=;
 b=KuYZki7wgEkwOaViQkNGl9KH3jDkka6u/onOIuqjXUMsfb38S5IEGhZAHCfvr1lKgBVO8Z
 4KWKOmfZOC1V+CwPFQn/V40zE2mVUJhTUGtWYuGh2XWvpZHty7EChbfpClmnZlCZa/oJkh
 FnvkUyqF5OqxEEcMBY6tcP9CSucyx6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459--V0-cgZuO_uD1ei8wzCbJQ-1; Tue, 03 Sep 2024 07:27:48 -0400
X-MC-Unique: -V0-cgZuO_uD1ei8wzCbJQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42bac946976so48553285e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725362867; x=1725967667;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Six38zRCaVcSjI7X8SSQRqVfbWN9LoiIAfaa2uKesPo=;
 b=jbObejQxeqatYYgcTo322jtjpeESUD/l7L/O4OXwdjRVit9YCJB1nTvAosUBeESSoA
 yjSXc+MtB7NvZED2mvSMUgVvT2JhNAEl5rZMPvrM2VGZrxxnACuQVokGLMrK4Z7NXViX
 qgfOWo/EpAhUy5IfJZzpOFxCpARwFuoMeR3tmxkAzDNaFs4mVjspmJniOggDp6arl4Xf
 adC6blqonkJ86UCf61frHBjVsAZqbeF3Hwss8NrZNQSIkOU+C46hXFNM7uzTqtzxlJCi
 05UOvNvOKja+MHerD1HE5auw21Wcw3mVnhXHBdIr5jENiMQ5bPWoKV+jb2DxXSYkaQzl
 t2Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPm+o12zYlaM14bSK7Jm30qnD/DTYZnQBzAK0aEYSEB7m6cohzz276MtUT90KWa/69FL8KPgHf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzslryoS52ynBkJmJvfFCeATIFHSuCF7K7xIIHdikjL+mLqF3Il
 TC3gRiy+kt/rmL5bMO6zVT80FG4en/qipk9ixFIvEpmzetyXivwQV45csRSAdTHUiLhItAmhWBo
 FHTreu9QAO3N5YF2VkxXMPY+n6/g14sk/pSwfplKMOiZLGQ6CpV3/rNbeXAuNPEU=
X-Received: by 2002:adf:fcc5:0:b0:374:c782:8d5d with SMTP id
 ffacd0b85a97d-374c7828f39mr5378712f8f.10.1725362866997; 
 Tue, 03 Sep 2024 04:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp94tO1qK4mqf4zM7tEKst5ObXZnlzOtHmVRYL5VNue/xInqnwrhNf4Qo0JnEU9e1wjil+MA==
X-Received: by 2002:adf:fcc5:0:b0:374:c782:8d5d with SMTP id
 ffacd0b85a97d-374c7828f39mr5378690f8f.10.1725362866488; 
 Tue, 03 Sep 2024 04:27:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef7e109sm13887878f8f.67.2024.09.03.04.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:27:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 25/81] drm/mcde: Run DRM default client setup
In-Reply-To: <20240830084456.77630-26-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-26-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:27:45 +0200
Message-ID: <87bk15f03y.fsf@minerva.mail-host-address-is-not-set>
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
> The mcde driver specifies a preferred color mode of 32. As this
> is the default if no format has been given, leave it out entirely.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/mcde/mcde_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

