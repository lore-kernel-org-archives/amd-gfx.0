Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D9CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 11:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51C510E0A1;
	Sat,  3 Oct 2026 11:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RW75a+r/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FE310E0A1
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791027436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHJZUWTv7rBEBUCND4bSkxxGBQPHEUSgPjoiGT34ol8=;
 b=RW75a+r/ZFCVTheiqwyJ8oYgxLXL6KbvpsXZd9Cqkz8HHw4xye7D0j+PEwnIEkInieWfLt
 Amf40Bj38zqTqCVOH8V3LVdQuQZXmIFyn4JU1Laj7fGqn3Xn6sIBxWLu1L7lSnSKM4sn/H
 QlMj44cJNGbP/9EQmorHs9Nlr63hHqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-qIfuG2XlNnW0H4xjCoVlNw-1; Sat, 03 Oct 2026 07:37:14 -0400
X-MC-Unique: qIfuG2XlNnW0H4xjCoVlNw-1
X-Mimecast-MFC-AGG-ID: qIfuG2XlNnW0H4xjCoVlNw_1791027434
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so237000f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 04:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791027434; x=1791632234;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lHJZUWTv7rBEBUCND4bSkxxGBQPHEUSgPjoiGT34ol8=;
 b=UcmN5tI0gyvY9T59hlymocuk0Wq/5bOvPlUClttrq7NoUWG5ar+ztVF6Am9qxdn+qF
 oIwjHBiWoemUzJs/JixyZKx/14m0CqoSKjtp23QAaSerDyJi7Y4eIrsdA+8/7ehjDBmu
 oOvc8DRQT9CHIrG7zEMqYYY3tFMvNH3To6sVc7LvgUUzxJRCIHfaWr4d6urJbiVx58rj
 kqbYUaVmBBnMnGRxk1i+LNOR6YKQfGibrfFsfBd7m2NrpC/RH+AN0ob73O27s022/Bye
 H5Gc5K+UT6nyoHXuluW93jU4kUYz11E6EQ/zDw6nnOnWEn0FmnzqgxEXK6RLEiBVM0QF
 B4sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRJFKjdUoqgU9GALC70i+T/UoK73r+cFZn5U2ovh5VGbjBpeQ6EZF2AQxb1tT5QWztTJsJxBDt@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKoZFD1R1s+QCnA4zk5rYM6SKr16Yz+SVpp35kLclSEr0TgjBz8
 hh0j6gJ2ar8ubkKTXYUL3M7MqeQAxR9IUw/xYw/5h8mcw+JAMjSqNFzYgurUy0ealUT3HrMbRuO
 pGRRrNT0up3LX0kKtNK+vu/1HdfeuTRJXCe2YM3of77KAUN1x/IpWs9EROiOBr/ODAlM=
X-Gm-Gg: AYBFou3iGkrtIWNMcU/hkud4nM1ZYFOKYdS9KScSnjvH7Uwe28n8MicLOONY4vq9pYK
 adhmSDjYijbrze+ir//USSQv64SXdlyxHGAabfVuzUSLQQWXgoM1UnnPZvD/FMomYH1061gHnWY
 IhgG+uUyo8luq1X94B+VM5G6sPh7/6d7c2hL+5jeC044xxQppyVdQ7yo3xGlfQvrB1eEeu/u+wN
 GryUw5v2094jYqEy3bMgOMnBWqohzNfGbLePTPzDf06kUT3ZUvEWreSIFhaP7ELhnCDE1Bx3iQU
 npA2sAW74jskMoxpp0102MnOfUiq4kYwwbAKi8wrZi8GC+EQvRiM5z+3RFZIeE+764BzUu749p5
 vDr7am9nI9zTxXyyYYAPaUMhQ68zTfn2LKZJofXg2SU9+2xrA3XMq996llVNL0i6uKQ==
X-Received: by 2002:a5d:5f09:0:b0:48a:f464:2cc5 with SMTP id
 ffacd0b85a97d-48c4800d152mr3245844f8f.37.1791027433669; 
 Sat, 03 Oct 2026 04:37:13 -0700 (PDT)
X-Received: by 2002:a5d:5f09:0:b0:48a:f464:2cc5 with SMTP id
 ffacd0b85a97d-48c4800d152mr3245816f8f.37.1791027433222; 
 Sat, 03 Oct 2026 04:37:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fab11sm11943111f8f.16.2026.10.03.04.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:37:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 01/21] drm: add connector LUMINANCE property
In-Reply-To: <20261002190030.211356-2-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-2-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:37:11 +0200
Message-ID: <xlv1ece7ggm0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FliBlMUc6-uixcsw3c9A2tWsEWyzBKHIzVRc8S4nOIU_1791027434
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

Mario Limonciello <mario.limonciello@amd.com> writes:

Hello Mario,

> Panel brightness is a property of a display, and thus of a DRM
> connector. Add an atomic per-connector LUMINANCE range property so
> compositors can manage relative panel luminance together with the rest
> of the display state.
>
> Keep the core backend-agnostic. Drivers create the property with their
> hardware range and implement connector helper callbacks to set luminance
> or disable panel emission. The atomic helpers sequence those callbacks
> around pipeline enable and disable, including luminance-only commits.
>
> The stored property value is independent of display power. A commit made
> while the connector is inactive is retained and applied on the next
> enable; disabling the pipeline does not overwrite it.
>
> LUMINANCE values are relative, driver-defined levels rather than
> absolute luminance in cd/m^2. The interface supports emissive panels as
> well as panels with a separate backlight.
>
> Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
> drivers retain their legacy backlight class ABI unless the new interface
> is explicitly selected, allowing the DRM UAPI and legacy compatibility
> policy to remain separate.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Thanks a lot for the rework. I went through this patch and have no more
objections on the core bits.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

