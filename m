Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74487CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5C410EDEC;
	Thu, 11 Jun 2026 10:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="V4wDati0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8172610EDEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
 b=V4wDati0cTd3kX5sMPsw3op3tmBPD0gd4A6IfmxwLfYgxXcXdJx89HZu5LWLlBs0Ps1Tr0
 5uExXAQbYeULw1ta3bFLyJDqOlAareV/IpqtUu1IhNRgb/I4NVnINKIhDKLEiF4o7fYn1+
 vlySgvoppTd5TWK78f9zWAqwIYx3iiA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-BPLlDdWePIeI4Xi7xBpSEA-1; Thu, 11 Jun 2026 06:11:28 -0400
X-MC-Unique: BPLlDdWePIeI4Xi7xBpSEA-1
X-Mimecast-MFC-AGG-ID: BPLlDdWePIeI4Xi7xBpSEA_1781172687
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef697092fso4890463f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172687; x=1781777487;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
 b=fgRh2lIBpKzX1kTAioCQfDxYUxWnKrPsJXst161RKQrqdmtwgCwUDuSGl9uPLgdoq6
 E5thOgQ1MYVhe5AuADP+tiiFlYLMu5DpKP339opjbDskhJQythtVtrBD+t3w4tWPaf7d
 fBhxSa/5dEJ+QEaDIgSsD9niaXhlVfHVHwJi5Rwwtbp0U8kXkaJ7OeVl2FA+x8ww4OOs
 E8ZHb56+iyaJWI2gf/sIM7C4VGQh3ecLjzdVHYhcaUF82Rk2KqQEKpWrEK4/56nv2/rg
 V0S/2jUNwYWWyQtmU9eIwjEjgnQYIhVrhCezFGQ85zGNgY73TNKGfrnkPXXP0Pc5wF4V
 PGTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AvBEU6Q/tOewf41z6WY7zD4XCfjwsWDsARcYel+pAcyRRy4sZzons13ldGOoXUo0VZpnLILZx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9Mqw2L56yy45fvXyQR6zDOttc6yfM8BE++rtOgJQ9VtkkvC1l
 A1BC58f/exWoNePlC3hcSjXwb6fnRs+KbyThqkgL5Aaujz1o3mEpbnLir+rU4GgHwXH0hs9cwN0
 +ymMTkqTZL/a2xt+55+xtlFjIadIPcreO6u/2XleVm/FVCI1L2/rryNmkUPKsw8ah4tA=
X-Gm-Gg: Acq92OE2phL2zGL/HrvafVXURMC+PZext2IxuB1qFXuaH5lvT+Ou/0cfv/nsEY492Sh
 W0ng/0MiqPk99SrOTbMDaVdEx4QVYdhD3uX9mXmZhLsJT318s+1d1InQeVrtDPun9aJsy8WtpM4
 aZSqCgqXwS9HKbU4RqQWFvQ+rJT3SnIDyi0A8x7qT3sTwpWOdL4iuX75z9g0Y8eQay6IxKfSkQh
 WFkYCbN1pYYIwPMkbleL4jcg/jzVZxBVrG3LuunEQEweiW5x0MmNb+xl4PLLRpWYVEm86qxTxvZ
 y0SIdG0CdT5GozJuGeGwT4yqAMm+NJsUH1MQMcyHS124MeobB1X0GGtl50bvKkZaNfa/HeOzVN2
 zO2QfNeQWKTVrl5uMO82PDqc38xY4x1OlnrHriUsfuoE8uBNA8dAC8R8s0JIsGMtI/9bK6WRGa3
 1VatywEqloDqroBBY=
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id
 ffacd0b85a97d-460677b28camr2150190f8f.40.1781172687243; 
 Thu, 11 Jun 2026 03:11:27 -0700 (PDT)
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id
 ffacd0b85a97d-460677b28camr2150129f8f.40.1781172686816; 
 Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4b18sm63288157f8f.10.2026.06.11.03.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v5 02/15] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-3-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-3-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:11:25 +0200
Message-ID: <87v7bp5quq.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wo7ME4HaNDkKLLqwZWXZme7fW273Cez4-t1tX3-YEDc_1781172687
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

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update. Commit 35ed38d58257 ("drm: Allow
> drivers to indicate the damage helpers to ignore damage clips") introduced
> ignore_damage_clips to selectively ignore damage clipping in certain
> framebuffer changes.
>
> The i915 driver does not modify the flag, but DRM's damage iterator
> will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
> right before drm_atomic_helper_damage_merged() guarantees that it
> has the correct state. The i915 driver does not do this elsewhere
> so far.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Same comment here than for patch #1. I don't think this is a fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

