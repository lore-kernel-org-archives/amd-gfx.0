Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608F4C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B607910EB08;
	Thu, 22 Aug 2024 14:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VrhrU6W2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2BA10EB08
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724338270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qI7sIttUlfd6rK+jxE04yL0R9ETbDTbrKGTUq6cowac=;
 b=VrhrU6W2tJxVE6+ROaYgVEnI6eD8UhT9d8TCGhFp8yvOYk+uuz10MviMzf5yQzMm+AiGxn
 bk658ALToukv79DDlIMw2WE8d2LgUH0IQkx+JJmBKErcFszA5fHWY+a6OMTpGX61E8X4F7
 4B4ZJLEefA8DGR/SZ/K8z6v33X1Us0U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ESMTCNG6M7SKHOMpEseDeA-1; Thu, 22 Aug 2024 10:51:08 -0400
X-MC-Unique: ESMTCNG6M7SKHOMpEseDeA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d3f948347eso1835375a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 07:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724338268; x=1724943068;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qI7sIttUlfd6rK+jxE04yL0R9ETbDTbrKGTUq6cowac=;
 b=rsnczcnzjg1CnqWYx+l6nsNxOQEyyP6EsY7nY+RdLgCtiOlyVnpKGJ7jZAfOtluVWB
 F1yzT3gJz3zNqlFJk5El3I/b2tHuCRBErDVw8YF+KanVAwVF6tk22jzdEju7eazOnu16
 oYOme934A2Esnj0R0kuuF0WCwOekz/hTEQ2FJu7eNjzomG5pyin6GccW5jTAd6SXyfKl
 3JEXjfUlqmngUDWsfMfDf2C40BQcHxWiMi047SkFVbNMGyYEZI/xRi2zIC3qK7yEh+qM
 +kTC8ihMaz5bly0RLPbC/1jDctOBp5Nknx2N0GZ61HU7W6ptdKGPilHkPmdPmZ9K93Cx
 EzvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr+IiONAnkF2+QwxIDoeRJ5beY8+WS6AYOr0VNpcgVhNqTSn0tiuGEp2LYy8zWW3L4iSSVle/d@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygdODFVHoc2IET1WR9kGXin7dLBj43VKChYXReHPo3XBjmh2cm
 YeF+ESmJbddtKZXTvwE+giLYNNBzj8JPsczefixYbOp8O50pXs71n/OEvXkMb0k4G2wO5ZHDSq4
 RytVZpUDxF9RTBDM0a3qo+jjlKMCyeRZMeTZx/4lz35hfCi8zrZim4awjcW+WpnU=
X-Received: by 2002:a17:90a:fe01:b0:2c9:63d3:1f20 with SMTP id
 98e67ed59e1d1-2d60aa21cdbmr5119812a91.18.1724338267817; 
 Thu, 22 Aug 2024 07:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkSqoPaYwU/pzTrCfkc680+HlIjlYxmDe4h014NbVi6qWLqici8+WArvm4OgjHVpg5BubFyQ==
X-Received: by 2002:a17:90a:fe01:b0:2c9:63d3:1f20 with SMTP id
 98e67ed59e1d1-2d60aa21cdbmr5119777a91.18.1724338267398; 
 Thu, 22 Aug 2024 07:51:07 -0700 (PDT)
Received: from localhost ([181.120.144.238]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613af1496sm1921071a91.40.2024.08.22.07.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:51:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Helge Deller <deller@gmx.de>, Sam
 Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH V3] video/aperture: optionally match the device in
 sysfb_disable()
In-Reply-To: <20240821191135.829765-1-alexander.deucher@amd.com>
References: <20240821191135.829765-1-alexander.deucher@amd.com>
Date: Thu, 22 Aug 2024 16:51:04 +0200
Message-ID: <874j7ca9wn.fsf@minerva.mail-host-address-is-not-set>
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

Alex Deucher <alexander.deucher@amd.com> writes:

Hello Alex,

> In aperture_remove_conflicting_pci_devices(), we currently only
> call sysfb_disable() on vga class devices.  This leads to the
> following problem when the pimary device is not VGA compatible:
>
> 1. A PCI device with a non-VGA class is the boot display
> 2. That device is probed first and it is not a VGA device so
>    sysfb_disable() is not called, but the device resources
>    are freed by aperture_detach_platform_device()
> 3. Non-primary GPU has a VGA class and it ends up calling sysfb_disable()
> 4. NULL pointer dereference via sysfb_disable() since the resources
>    have already been freed by aperture_detach_platform_device() when
>    it was called by the other device.
>
> Fix this by passing a device pointer to sysfb_disable() and checking
> the device to determine if we should execute it or not.
>
> v2: Fix build when CONFIG_SCREEN_INFO is not set
> v3: Move device check into the mutex
>     Drop primary variable in aperture_remove_conflicting_pci_devices()
>     Drop __init on pci sysfb_pci_dev_is_enabled()
>
> Fixes: 5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vga pci device")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---

This version looks good to me. Thanks!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

