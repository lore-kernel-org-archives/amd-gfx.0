Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5362606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EreqnY2u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7F510EEDA;
	Mon, 16 Nov 2026 09:29:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F72C10EEDC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 09:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFbznQG0d5IonVOFhnusqlVdFzPG48oiZmmSS9tPXTU=;
 b=EreqnY2uGsPcGB08CysgsQlx2r4/WZU1DJtu10NyBFowSXSRQwTr+DDZ5u4hEu8Vvrf2VL
 T2HA1h/5StAh4rLX6cK0x6E/6USu1TwtXzonLSXLJ+6m+hDOcsVfH/CQWfq8AAP6EgT9B/
 0TGalq8gj1Y5x0gaJwlsRwjRFpJ6+bg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-b8HfBW4ONJiNTFRGFINz7Q-1; Mon, 16 Nov 2026 04:29:03 -0500
X-MC-Unique: b8HfBW4ONJiNTFRGFINz7Q-1
X-Mimecast-MFC-AGG-ID: b8HfBW4ONJiNTFRGFINz7Q_1794821342
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso26054575e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 01:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821342; x=1795426142;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFbznQG0d5IonVOFhnusqlVdFzPG48oiZmmSS9tPXTU=;
 b=qL5awR6kACpPvFjOvVP745UMNruC5Ac+Yc3npF1TdX9iqpU9FbJr4gYPZjObSMsptU
 1v34bq4lQvoC3Ar4aZOqnTs0iF/3IEKEJcs5jf9647QrifbfGK1XYttma3fvHKm5hU9K
 ICE4cH5jwqOI4z/14kwJiBFXGBKcnzcCEZzUS+cLWjMfSejgyjht4BZ3tqBHetC/mufx
 A8DnhVBCOGoWc983/R692Rje/H9rDt4nQ4z5JqX9YL+MnCa9kVpbgRoHkV3BjHSJxwU7
 YPyGxejmVFUXeUjq6UrxRXLrZRglNXmesKm4WSitVzqSZrETJl2nzGr06Yw8NAm7lgco
 a/Cg==
X-Forwarded-Encrypted: i=1;
 AL+hErFdfFRkunrPs54gCGmv7eYVP9DJJlJ9O+QmbNR7XLz1+86sRYEEaDZF/RSkBhMe/e/x1PcenQSK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vqRQSSHemlxYvfcT704PSWkCAwpLLk2JW0oZG+NDJXB+pIxzo
 UrUmwRzTYvxDh2zFyZ+lYh/wUnzCiAeKqcXknngLlbCdBbcr9ykVwRljEe3LUA+hbloiuSjDmUd
 4tDPGFoSqHdNx4qbfS8a1pmN7rlTJr11XhbEQiz0a0YMbSdm8Mm+vXEJCvsy5DVom2tQ=
X-Gm-Gg: AYBFou2bcDNIvQg+DejqcsHqRWMzPuzln80U4ml6wD7DcrFtB3wwbk2GXJfIsza/H6m
 X3CrNiLKk0W3nWyiz4ZqzTXNbPDrPNIe1uqcFYv7CRZYoDtswrNm7wuhDueRBv58fUuzdh3H6Cd
 HEJL8pO53gUmM3H9ihtXoWbIQkkbQmBSJRz1oGwu8Aa8L17xg2U7zE7b6VJw3ZDrnuHHq6nFvga
 kUb44I+PQfs4OQlDyIpeCEwKMnUrfNt5MwO0HtZy1UVUjHB6CGH42BujVxHI10g+h0NaowSZKdz
 9uE4j0pZr6tDfSiArorem9KKYQpLEvWZDR9mp/yqGC6I+RtVtunvopFT4/Ym2cvCiamlPcmZUDj
 o0H530FZ0KhXwLvZ9lxvYxTqu+wL8Iy2o9zvIqdBP8c/fpfmcJff4H1nvqeol7yHwmOFitAa8vC
 tB0MMTO3DJfHNl4VPUc5g39mjBOQ6pKjnNGEw3Y0A=
X-Received: by 2002:a05:600d:41c9:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb60bd5507mr133776535e9.10.1794821341813; 
 Mon, 16 Nov 2026 01:29:01 -0800 (PST)
X-Received: by 2002:a05:600d:41c9:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb60bd5507mr133775995e9.10.1794821341249; 
 Mon, 16 Nov 2026 01:29:01 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb675200e4sm115370395e9.0.2026.11.16.01.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:29:00 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, Xaver Hugl
 <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 11/12] drm/bridge: add PS8622 connector luminance
 support
In-Reply-To: <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:28:59 +0100
Message-ID: <xlv1ld6trup0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kDkhrSueLyY1WEcqG9O3YtNoOURMZgaKYFcNcPskY5A_1794821342
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Expose PS8622 brightness through bridge luminance operations when
> DRM_LUMINANCE is enabled. Keep registering the backlight class device
> otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

