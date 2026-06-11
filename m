Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0D5CD98D4
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3609310EE1B;
	Thu, 11 Jun 2026 10:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="W5P8aYKS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C794E10EE1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
 b=W5P8aYKSblK3mjJytCe0Ph6MGhk/zYy591McbqpHdtgc5kRUjVo6Uibuz314zqoR8ND4AG
 QZ1jdRPlTX1qhVOO9F9cdF8bZ5grbi+hAWRyio/5e2OaC1xV11HkTD+5kOQc+/i2izSCKz
 Lv5uu5PjTZJCM4Xe1rB06/6F5cvl1TA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-vQ6Z2PiOOouSKQoJXCCWKw-1; Thu, 11 Jun 2026 06:12:56 -0400
X-MC-Unique: vQ6Z2PiOOouSKQoJXCCWKw-1
X-Mimecast-MFC-AGG-ID: vQ6Z2PiOOouSKQoJXCCWKw_1781172776
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bfd70b0fso78222495e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172775; x=1781777575;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
 b=px51jGJbc5i6v2tgPETclDK69cn7F4C6btIuaERVGUhb3l+dvVbPP41od3UiNuq9Hf
 FNoUweWDK6P8o0/mzLbmHy4tGLlmPCx612kWei+MYo71q2T4W2wRsCGjLQIsdhMp5sXs
 tB4/6Pr73hs0/wiLItK3A518So9jxqaRZEcMwfZtHvcfZ4L5GBIGrZbBtrELkr40w99C
 1ljesJ3hevKBiJ7oA/pvO/ezC3GyjrDVtlSd23axKZQtogs/8nucKISagmNe3rvv0ku0
 qpxQxRDVhS3jFNnT1eHi7KWyLtqv/+FOsBejeYaqcHURl1cK4zVlKDDlV1W9g9NGmthe
 Kejg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xtvQOj89UdmzL4Ne1ejp9i5HJLuIZ7I9Xo7xZi0B6eg/Hg/Pdc8Zg9VcMroFpnbBZa/V/H8Rf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmuIBmTNIIVKWSgDWn5mSaHl1mexlmiutfbDkI17XtMLlV1sjJ
 6mrhMc2phIZDX74X/Uo7u7KBoNAwSuZffKJKDULG9grcyN/gwIfPb5Dwd2EP67kICvcRUVMjIDi
 gkR+5x3t7V2qYiPqOIw9SmTpIE+JVWn7Zw03w9OYz3lH9E7MUdGSYEezr/MUaTs+3Bs8=
X-Gm-Gg: Acq92OGazjJOqNNRcroOP1Ul4h5k2TA5NBD/HvqBf64/576Jenj3qLaB2QeRq2Xik9y
 BbGWtmbapKaRYljWZHqYszHOYZndP05EgKY6N0V0+qO9ETvw/4Ep07t4UchkkxUqC9nqwZMVuNQ
 yMiyZJKTRi6YQAVcAPmIbh1CcErQ8we9XjUOQC2Ys951bBHZs3POg3SMlpHkj7qwAt7UPyc3xIa
 x2Fv4+zwM9UIcdFcqpqadXd4IjlY8DSSmlhvrw+RG0xraQyIhaKcjdrShkbCRuTi+RDSXvq8FlW
 mVJBxlWHoWdYdiNtCgFlp7Fd35aW3IbP6qsnRaZ1AMRppBwg2Vn1xKZRfwWfSQ0gCsO+BjCtG4Y
 6brgxmUhBqelhEfrYjIIcnVfD0CTVFfhW1veTX/sIMNOiOiBKvdobgyy7rLWLM9bkgRekvQU4UP
 bB3qaCUr7Dr23B8mo=
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490e5639bf0mr26218645e9.24.1781172775420; 
 Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490e5639bf0mr26217975e9.24.1781172775016; 
 Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm38051805e9.14.2026.06.11.03.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:12:54 -0700 (PDT)
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
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/15] drm/vmwgfx: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-5-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-5-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:53 +0200
Message-ID: <87pl1x5qsa.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e-sGjABAJkoqzYATFq4ju0YJucaIcwuq_vvvXNYAyhM_1781172776
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
> will then do a full display update.
>
> Test the flag in the primary ldu plane's atomic_update and do a full
> update if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vmwgfx does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

