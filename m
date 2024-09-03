Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B1ECD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0C110E47D;
	Tue,  3 Sep 2024 11:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YpgCCYut";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 034D010E47B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725361993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNaLJCzc8McH6yKUfj3b0fV3lUF+xcAOFhE3bUUfh6Y=;
 b=YpgCCYut7DrJpuTEA/VQVrNVu5cw3suN0TSt9dEsKm2lVjV6ecuMEPA+zgoShhzeufkXpT
 UHeZnoZ2xEtJp/8zgLFtfG6nIgZExvuc1jpqskm+NDc76h8PCmNxDEcAd5NdY0A3x41Q5J
 TM1VOLLkOr+2eUCJssBSGK+ClSzQLOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-cRlkVNRkNiucfgdtqWJkwA-1; Tue, 03 Sep 2024 07:13:12 -0400
X-MC-Unique: cRlkVNRkNiucfgdtqWJkwA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42bbadffbbdso41269145e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725361991; x=1725966791;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eNaLJCzc8McH6yKUfj3b0fV3lUF+xcAOFhE3bUUfh6Y=;
 b=HelHZgzd17b2IRE1rw2Y2VanqeYO0MSsRTEU5T4taPCnHya5N3X0YFifxjuO+GBT4q
 ey4/N2Q89lisHAM3yyM8LOmDdEGyV4lPL33q7ikr1mkAQYl7BAzf5f3UrcqSCgMbgy2X
 a/NTf8MCSU6aL/ef3tvmTJSRdK8Wccj3vEpUciwi0Rih9KSqbJRj0puYErj7Oq6tcnXp
 2QwdlYcn4q4dhLAD7XqpB/hotyz5N9iyfsD2esbStBBVKKtGvXIAS+xN54/oOl4tgrrY
 lzH6+QVKRakTt8uqQUb2mVUFDFNhk0KtYNRVKVu8Pnq3ZV2mhPafRQKrq4ofKZCYhgLC
 B+/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMnP0wb76BuABEsCdTXQo7c8xBgZ9dMTdbHWRu2Nk8MtnqhIsbFrFOztXFIRVHhdgZ7+v0MnPO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycoOZ2gE9D+MYoLpHfVjmfmJRADt9rINQR6wKgpSH1NjBi1HHN
 Kr/sLSIhv5aMHiicptjyyoZ1s8zlnkbbUW8ijPeisLSew8gcVgjE8RHXLQ6RHF636k5uMCGUf3T
 9WQHDm1MFyjGrLxwXcdIJsAApN+/p8od1Gsn5fj8o7OagxBaotltaGT4cOZ6kL+k=
X-Received: by 2002:adf:e042:0:b0:374:c8a0:ca8c with SMTP id
 ffacd0b85a97d-376dea47175mr310999f8f.43.1725361990984; 
 Tue, 03 Sep 2024 04:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErKuUaZwDVmhsR7doTbtSmBnmM7k053hpSErI0ylM4sAqourCJsbqDohSz+3dvc+wiabrelQ==
X-Received: by 2002:adf:e042:0:b0:374:c8a0:ca8c with SMTP id
 ffacd0b85a97d-376dea47175mr310977f8f.43.1725361990502; 
 Tue, 03 Sep 2024 04:13:10 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm167087945e9.18.2024.09.03.04.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:13:10 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Alexey Brodkin <abrodkin@synopsys.com>
Subject: Re: [PATCH v3 06/81] drm/arcgpu: Run DRM default client setup
In-Reply-To: <20240830084456.77630-7-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-7-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:13:09 +0200
Message-ID: <87ed61gfcq.fsf@minerva.mail-host-address-is-not-set>
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

> Call drm_client_setup_with_fourcc() to run the kernel's default client
> setup for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> v2:
> - use drm_client_setup_with_fourcc()
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

