Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37DACA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 18:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916E210EB6B;
	Mon, 28 Sep 2026 18:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ba5M3eSB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C32D10EB6B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790619034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFTht72VGYwnHy4rRuIiS5N5orHNND6LgvZVdS8G2Q0=;
 b=ba5M3eSB2aU1dR+veVcUzfFraM+VToN/iV7Wpk8dz1654estlF+ipPmSpkfiV7SNzL0sTn
 IlxU5CrReGOZ52vnu2CyWIFT6Vq6cnGlBH+MF7CbOHlW/x57wmC8uOoCUSs2eLoIOo7BR+
 1d96OCVGuIvm2DE2vmxxTX58BGEFmA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-CTZRhcj9NLScqhemk-uitg-1; Mon, 28 Sep 2026 14:10:31 -0400
X-MC-Unique: CTZRhcj9NLScqhemk-uitg-1
X-Mimecast-MFC-AGG-ID: CTZRhcj9NLScqhemk-uitg_1790619030
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so39972355e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 11:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619030; x=1791223830;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OFTht72VGYwnHy4rRuIiS5N5orHNND6LgvZVdS8G2Q0=;
 b=CC/WrmLjWUhKbyntGCBBYZ4WQymeg54ypq8jloe71GS5dI2IJhb71Ui7PcNPReZ0Lo
 wKJEYay30Lazr1Sc0Aq6Au2bQNABrtjdb8w2Su1rGvcD2TdhPt+ufKqWyFAEb98KYLD0
 Moo+erb8vygsIFxn2l9FfpK1o4yZDKADzSEjciPPF1ymtcnuLcvtHE/cc7nKRJ9kGVpn
 GaDfWMohWJ/RYdkBVMIadHH6gw0h0ezmlLuGWJgTHNffx+MFYPgvQIU5TTTarKqrrsLl
 s8sylfkG9RwvaR6gD/RmsBUdTK7y4LCCKVS5M2VhuvsGRk9AOfjOR0U5ZAYmyUP7plqR
 sd8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBysCUDDE1ZWxGoe6X3eE5xSlyT7/wBvphQJiyVDW8P8ZRSWnOtAg/+lP/40MxxGZPLTCrIyO6er@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnbjdOALzpxpmkBzObtxXFJT5Ua6Z9h5FM8DRGFCWOA8ky/qvm
 I8MbG8vgh1S2VNuAgELxkVFUq+e1bO7xDKRq75P7Apd9KVluaYJoWnrG4hZ7QYN0901XlIIRUNU
 bfrdU6+v8LbtkT7ytN/fwdAcJ8DDIkb4Ia4Aqzb8nYpOiR5rT9WZSjFyW8sekuKzlSTU=
X-Gm-Gg: AYBFou1SAMuInIY//LNxa2KEbGgdyA/BlC5A5gxpErHf/lz4Kq2VFvMt02WhdJvmy6T
 eFAqMCpL4MgEnqOYc+sl5MXcHquI5BGPmxrRf9m0slpF+IIr/sJ+tQVLafRCdlBtqc2o6JICmPy
 QTfBkl3JGjFMbUAutaeCqC8mDVC6x/UejaP47pHrX98NC+1cGQ5aarOZS92rsbxdZhPIT2l9NWM
 I2J6d61fPs/H6JzzoVt6mK9wzuQGdECb0uZe8rIZGVvrOl8IxqSOzatU2+Xn3fno2CXLOz+B5nZ
 cxFBEz4AakYYniE+o2rx1FEUTmeiKFzojl6j3cUY+liZeRZbvNo8EPLW/Ht++PkuYVMYXmICjzx
 7N+7WBH57Oq/lzqFERlTtdzoIOVumkBrMcckmqNuSYLow9nsP/7YvydAHcoCGU+oV+w==
X-Received: by 2002:a05:600c:4f44:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a0023f8d93mr91712435e9.2.1790619030022; 
 Mon, 28 Sep 2026 11:10:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4f44:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a0023f8d93mr91712165e9.2.1790619029624; 
 Mon, 28 Sep 2026 11:10:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm9652415e9.4.2026.09.28.11.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:10:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, jani.nikula@linux.intel.com, Alexander.Deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 2/2] drm/fbdev: Move fbdev helpers into client library
In-Reply-To: <20260928080323.23909-3-tzimmermann@suse.de>
References: <20260928080323.23909-1-tzimmermann@suse.de>
 <20260928080323.23909-3-tzimmermann@suse.de>
Date: Mon, 28 Sep 2026 20:10:27 +0200
Message-ID: <xlv1zex1dz70.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jBvOTPh9x9_ewZx84LYlL2H3THO1zG8h2vmSpRh1utI_1790619030
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

> DRM's fbdev helpers are for the fbdev-emulation clients. Move them
> into the client-library module. Fix include statements throughout
> DRM drivers.
>
> While at it, rename the files from drm_fb_helper to drm_fbdev_helper.
> The old name was too reminiscent of DRM's framebuffer code.
>
> The GEM support code for fbdev remains part of DRM's memory managers.
>
> v4:
> - fix the depedendencies from v3
> v3:
> - remove obsolete dependencies from Kconfig
> v2:
> - update armada und docs
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

