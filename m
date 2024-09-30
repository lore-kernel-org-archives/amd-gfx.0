Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18EDCE8340
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 13:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D48310E4B3;
	Mon, 30 Sep 2024 13:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ixG9N8w/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7537210E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727702770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iU6oHSTtkrHoG6AEjnDSNeGcEonnUQr+lho5LZwZCqk=;
 b=ixG9N8w//pyd632xsbpOX5I8MWrzEnWZ9wY47WPvVaNq05oKHiEaWoNBA7/Qk6jdnZouO1
 d9Cg2Vv64V4LX72saO3USatXFF3IQVvwqAwsA9tMU8Itk338xd04MAA3Fj1s8yC8l09paI
 p8d8Aes5YyFpOBOpwvjLiDvpggj4iLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-6KQ2_WWvPYmLMwlwmllh1A-1; Mon, 30 Sep 2024 09:26:09 -0400
X-MC-Unique: 6KQ2_WWvPYmLMwlwmllh1A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cc9b5e533so1670594f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 06:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702767; x=1728307567;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iU6oHSTtkrHoG6AEjnDSNeGcEonnUQr+lho5LZwZCqk=;
 b=K4/n31HTUo3s+LoEXV9JKzaQUbM0LmyMUjh/zQTQOCQYh5IClkA3op7amOisLtzeJY
 Mf8DMKQQIuC+QdAOW2rNYg8dOe21DZkjJ8/JFPvR7CDckQ0BhIJLVz15keizWa69Z/5Z
 Gw9jcZhEZf8tgLPT+Gryd/NQ7nAmuSwZ3ojhf6DqKloCbUoRIwCnL6/svz834NDuVeto
 jHQEE1Q4TcSXJ8V8EYUE/ImfjkykcN2dQe6k9D2h1s+mJd4QhPagtIz1MM5mCVrRiBR+
 2PXu4zt8avg2+Ays50shCmaM8HXdTbLZhOS/tONdxkxoiZF8WHljnCjZJrs0kIx2c206
 oYwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY8M6bs2eovHKrF9FtVQfDBLd/FPRhOFZRj1XbHYBOT99pPv3hnyghgG9Neae8u9oGoUipdbf9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZPZSo56Mh3oYLCP2ubr+ONDJxgu1+hdcI0ThKaJ3aPIp6HV9d
 zShPaM1HD3BnmoQ/LWhd26G7/su615mZTxs1D15WKyHpmgVr87m2WxwQtwlGvkInTtS/I1ewKJV
 4buVBwQ1KgYT/CbYuXKDFBAyz6NDXrWr8c0O5H2Uq7Dv0Myhh6enI3k0Th1OQ7Ng=
X-Received: by 2002:a5d:5548:0:b0:37c:cfbb:d356 with SMTP id
 ffacd0b85a97d-37cd5aebe7bmr5906742f8f.28.1727702767558; 
 Mon, 30 Sep 2024 06:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC2V0F7vlRZz80HkueMTZBFg2rvllHK+Q0YOx0BGeDwQemdMjl0P56KLvckcpsgdHBb03bCA==
X-Received: by 2002:a5d:5548:0:b0:37c:cfbb:d356 with SMTP id
 ffacd0b85a97d-37cd5aebe7bmr5906722f8f.28.1727702767137; 
 Mon, 30 Sep 2024 06:26:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dec19bsm104420285e9.26.2024.09.30.06.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:26:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/28] drm: Remove DRM aperture helpers
In-Reply-To: <20240930130921.689876-1-tzimmermann@suse.de>
References: <20240930130921.689876-1-tzimmermann@suse.de>
Date: Mon, 30 Sep 2024 15:26:05 +0200
Message-ID: <87ed518e8i.fsf@minerva.mail-host-address-is-not-set>
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

Hello Thomas,

> DRM's aperture helpers are merely wrappers around the respective
> helpers in drivers/video/. The DRM interface existed first, but was
> later generalized for use with fbdev and a few other graphics-related
> places in the kernel. It is time to remove the DRM wrappers and call
> the video helpers directly.
>
> No functional changes intended. This series should replace one interface
> with another. Individual patches could go into the various trees and the
> DRM wrappers can be removed when all driver changes have been merged.
>

Thanks for doing this cleanup. Makes a lot of sense for me to drop it.

For the whole series:

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

