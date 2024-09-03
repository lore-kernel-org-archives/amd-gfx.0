Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA36CD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A79110E4FA;
	Tue,  3 Sep 2024 12:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ivxQwaAI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5605310E517
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725364830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wqkxl9KwjevEu+t1uza2Tm1mz4C/9rJUsakscGOOK3I=;
 b=ivxQwaAIEPL9uLoxxL+sNKQ3MiEDiM4d9D6q0L3XSXmmRKCiQvG2mHZKuLS6cKZt472pBM
 Wq+yvY+FoBM4rAA5wrZAkqdnjDhxojP2drEtzrgipMclRG+npiSBXho5oziPfO8uEIiIpR
 RH+ECSrqdkuFl46g3Jx4gjzzl5UohJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-azfDgP3aMRuDnyZCALYKDw-1; Tue, 03 Sep 2024 08:00:28 -0400
X-MC-Unique: azfDgP3aMRuDnyZCALYKDw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374cd315c68so1184479f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 05:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725364827; x=1725969627;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wqkxl9KwjevEu+t1uza2Tm1mz4C/9rJUsakscGOOK3I=;
 b=GL3GuL9g0OS4q3C8DwoQCB5ItM/MztRpDDC7b5OJdvCZZdyDGcllBNl4uIdrcilECc
 Orhdyk40MUG8gI7CeQ1dIP0xEaqEUihBShQlDtPdHzcmv5Rk/D+79ma7Wpf4qg4Pw6To
 icRIdnD7HuJxuyY4IJDWasgK3SMX1b1t2Cui++IqVze/AbGtKUbYyX5G4Dv4K/8vDXhX
 Pw+jZCGpz1IRjUr2UOftoFItrxr0nze8tj8wPrNyHX6vSSrM6vaUutUixhU5Ld/V0g3T
 7yxEd/Hgsw9lz+Ve7LVogfV/1HKET+AXBSjJgWAaj2flsjP0fIhQ51A8SlzAgkMnwyfE
 q5Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhZR0vggQBoJXusqgn2ccU0bwwaLJUrg2kE+rBFgvj9j3pIj5IlGJnDq4haHp5Np7Kzo+wvB2u@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKyLEFRsaBo+ecDKKBdZJhvFOsaJDvTgPNvZKgrgtk2bYcCCW3
 Os+yhR+Y/ZFRbWyFH+e9hTHJAF72nRuT8tE0WcpCTO8zD6X7eH1TX7Hq2523NptHQo0h1cCUErr
 rOsZm0xPgwsTnj4uJWn1NxV2LsYO63H3aV6RYBMANGrPT6S/O/ddezFoYRu1JOk8=
X-Received: by 2002:adf:e005:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-3749b52e4b2mr11567925f8f.7.1725364827053; 
 Tue, 03 Sep 2024 05:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKbVj02CwoguAfZhg3DQHVPX/ENKLjb8+BLnTX8X8+/N0+IHzNka7Y5ll+wgLPRMt/UdLgcA==
X-Received: by 2002:adf:e005:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-3749b52e4b2mr11567893f8f.7.1725364826511; 
 Tue, 03 Sep 2024 05:00:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639643esm208275255e9.1.2024.09.03.05.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:00:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 52/81] drm/cirrus: Run DRM default client setup
In-Reply-To: <20240830084456.77630-53-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-53-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 14:00:25 +0200
Message-ID: <87ikvddk12.fsf@minerva.mail-host-address-is-not-set>
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
> The cirrus driver requests the same client pixel format as the value
> stored in struct drm_mode_config.preferred_depth. The fbdev client
> also looks at this value for the default pixel format. Thus remove
> the format selection from cirrus.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/tiny/cirrus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

