Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1F3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 16:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E836810E283;
	Mon, 19 Aug 2024 16:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JePKcp8d";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47D310E223
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724085638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aiAlEMlkVSgDq4kg8Uhoyt8PHhKwhvjGwHD+aR8CT0=;
 b=JePKcp8dkfVWJ+IAUVtjfx6kG1siE536Jj43jMe9RjS8/a3uinuWAw/8MLrkFKCvfdK5o5
 m+77eM1k3kAV7vhJBlTGY0SsYELf4hvVR8GTI5SEObzoLAgJL8TC+gzsieKWXumfF9UDUI
 8h9ZKKwWIJq/T9uSBWcT1WXRIVFAkmM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Yy873TuwOvKD78rrH7EipQ-1; Mon, 19 Aug 2024 12:40:34 -0400
X-MC-Unique: Yy873TuwOvKD78rrH7EipQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d1da888717so4612955a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724085634; x=1724690434;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6aiAlEMlkVSgDq4kg8Uhoyt8PHhKwhvjGwHD+aR8CT0=;
 b=UF0JUAgLYqhA4PeJO/qzeY6n76I/DbecCY9lTQFkC1TS0Axt7V8TIIeuPIQAMFMw0Z
 ntuHMUrqcaHaYUcKo9BFSWA/hT0PmCOnpbgghfdZjQGTYk+qR7AYxhLxb4jCc2T+CVUJ
 i1trGbJ/Fw/5sTfn6D4wRYvcr5l85i0Ub/1KtT9c0okohUWFc+NNqoAplMWuRjevY0UH
 0HZf+ExWTVx2/21jeFBTbRK9i/3f3dTfN4yOHsTNsa5Sxv3VxH4jHmrpwLbRyKYisiWZ
 DWFyMfrvZ7p2otPpcMehEzOeCy2IADV3lBlqTFcA+OnqPC2NFEdjH6YnpcjIRuk6TAq1
 L+XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp/cmjmBRNiH1sGcLl3+m8LtOak3UvPZO2PZr3wtuG+Xgln6FXgk8YkUVy5Bw/oC6KBvqk67AWXS201zim98AWvIJEka4xKJXHFvpw/w==
X-Gm-Message-State: AOJu0Yzg4EwZjd+PT4pcrW7dNpDU5jjYJzlOFiCm0LpaCRYir6YfUs0G
 ROML/0QBZODYA0bcPzxkmBPfIZC5V3h8apEUT4A8h3/FNOoN6wjSsJ+jhL/+7drRWN/83+rqqrh
 jPt+/tSWBgZgivU5m1PKWULOin9MEaS/4Slb008gX/W2WDhmAT1ul1Ju7izyPfJk=
X-Received: by 2002:a17:90a:bb86:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d4063e87e6mr8810666a91.31.1724085633792; 
 Mon, 19 Aug 2024 09:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr6UwLRtlBXjaOWivmxZxfUPO4m8tw0lWZ8JSfXwSkB6KBvIXRvb1qTy/OQw15401HlQn4nw==
X-Received: by 2002:a17:90a:bb86:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d4063e87e6mr8810646a91.31.1724085633478; 
 Mon, 19 Aug 2024 09:40:33 -0700 (PDT)
Received: from localhost ([2803:2a00:8:776f:3d96:6be:69c7:46c2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d427efec73sm3604053a91.48.2024.08.19.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 09:40:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 57/86] drm/ofdrm: Use DRM default client setup
In-Reply-To: <20240816125408.310253-58-tzimmermann@suse.de>
References: <20240816125408.310253-1-tzimmermann@suse.de>
 <20240816125408.310253-58-tzimmermann@suse.de>
Date: Mon, 19 Aug 2024 18:40:27 +0200
Message-ID: <87o75oa2kk.fsf@minerva.mail-host-address-is-not-set>
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

> Call drm_client_setup() to run the kernel's default client setup
> for DRM. Set fbdev_probe in struct drm_driver, so that the client
> setup can start the common fbdev client.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/tiny/ofdrm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

