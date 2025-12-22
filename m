Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A522E67497
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 17:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD9910E1B8;
	Mon, 22 Dec 2025 17:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WcGEHnOd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F3810E32E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766425404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mG3GBuEVPwNetHpE7r/70ie0gOHuvVJYQoZvD8wClRw=;
 b=WcGEHnOdHHXVI/YUM+F8H5rHe7lR/2yRcxez7hrSbqP6Grc/fex080c9OLVEiOxhE33PMD
 mTsBKXwEKRmJ8Oo85B0/LPrcSXYQNZmT3GRiG3oyfqXbD3xX2lppTSDjuwXi055tBMYbY4
 gP5D8DxqequYA5f2EMAg3CeG0kffPMw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-0MhvPAHoObuRK636tt0uEg-1; Mon, 22 Dec 2025 12:43:23 -0500
X-MC-Unique: 0MhvPAHoObuRK636tt0uEg-1
X-Mimecast-MFC-AGG-ID: 0MhvPAHoObuRK636tt0uEg_1766425402
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630753cc38so7247824a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 09:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766425402; x=1767030202;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mG3GBuEVPwNetHpE7r/70ie0gOHuvVJYQoZvD8wClRw=;
 b=rMFJulo1+tpbsh+XEJq45/AFIspQTHfovVpPcgGEG1dgJNyaYNF8to98Max51MKeSe
 53HJ5fkya/DWOM83Ebuq2xLtF4Gc/x12+bXAqd9KaVC2nuaysxGkmIqNIbZXFMLnyOCT
 jVd8VZYkT2J7HgzdDx2lsJGJy6+7UQou6tN6BqjdW04nQGyoQ21Qz2w3lfbBuaJ/VM0g
 GDW1plhVW0TfV1qw+yG6O2c28wyTIgvV+B18SvVv6t5JAmnT3ZBkdj5qtwX6fGM8snUA
 BMzu6nPrvVR4rjKnbRKjtYoNCeKGTLO+Azyy+ieZIPBmBowR27viziac9pk4Z32TSuxm
 QHrw==
X-Gm-Message-State: AOJu0Yz2x1hSKLw0iVAWrtwfo3y254YtE3iGjamD3hlhbcK+akFFrI6B
 VaXNIMHhgdmVYqvu0VfYwfNxdFMXtelJFI6jTdr29RdsSLmJMlkgAnlzFeo8Xyt0iLJfhQV3ugy
 1v9KzSl/YviR9a76kzL44Aogw/WGSi1D/R93uzPCB0oGvIlbRttYw6vpBGWruD3n1iME=
X-Gm-Gg: AY/fxX5nr+lHZD2TUj9IBZj2tsyTASyd+EzUPogmyvWrPE1JBYXpie5ZB3Sl2h7oyOH
 grvrMKdNsvWFonmdolsAmqKUL+xf9v74NX8AL3NnOxo5Y2tJfzvzdYuEt2vjF/rGd3yFKpKwAka
 zTc2uZmD8H676V0odQhH/YLccEhc977Oldq+Pr/FNVnarUz7cZl9bVHLFJUNkNIcO7w6a1vOTak
 R1R2u2lJnmu4IpCRWO6Pi41B6ZatTmytA9gm43uqz4bdyI83UJBFUhl6FmCmiQIP8bOMJEr8uFb
 CJioq9fKhVYxZUnpy1HtrCI3DAq5EDlxEWUL9d3Qs9FGMhiMOobvCkEjO1VpCI/RfYBPneZ6cza
 AlDxTT1WXLJ8hIw==
X-Received: by 2002:a05:7022:3c88:b0:11a:6424:f40f with SMTP id
 a92af1059eb24-121722fd1e7mr9423127c88.36.1766425401716; 
 Mon, 22 Dec 2025 09:43:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHGeD8sn5NdEFT/L4992/tLVF5man9MpIOwm0i4U9mIbJtZc6sZ3neUr1VFBGLEiHQ9joHfw==
X-Received: by 2002:a05:7022:3c88:b0:11a:6424:f40f with SMTP id
 a92af1059eb24-121722fd1e7mr9423091c88.36.1766425401034; 
 Mon, 22 Dec 2025 09:43:21 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b1e4:8e00:b6e2:5e18:4823:58ce])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121724cfdd0sm47629542c88.4.2025.12.22.09.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 09:43:20 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Mon, 22 Dec 2025 12:42:48 -0500
Subject: [PATCH] Revert duplicate "drm/amdgpu: disable peer-to-peer access
 for DCC-enabled GC12 VRAM surfaces"
MIME-Version: 1.0
Message-Id: <20251222-fix-duplicate-amdgpu-v1-1-18e928420d15@redhat.com>
X-B4-Tracking: v=1; b=H4sIABeDSWkC/x2MWwqAIBAArxL73YJuSdBVog/LzRZ6iFYE0d2TP
 gdm5oHEUThBWzwQ+ZIk+5ZBlwWMs908o7jMQIqMJiKc5EZ3hkVGezDa1flwYl0r3QzaVIYHyGm
 InL1/2/Xv+wFZ1N7WZgAAAA==
X-Change-ID: 20251222-fix-duplicate-amdgpu-44017b1535eb
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Peter Colberg <pcolberg@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eWHBjYoEqbcdNAXySimZ1I9ja5Es7tyUEg2khXidg7s_1766425402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

This reverts commit 22a36e660d014925114feb09a2680bb3c2d1e279 once,
which was merged twice due to an incorrect backmerge resolution.

Fixes: ce0478b02ed2 ("Merge tag 'v6.18-rc6' into drm-next")
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e22cfa7c6d32f286de94c6e0947c20db41894b68..c1461317eb29877446e69562a58e17a77203a79e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -83,18 +83,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
 
-	/*
-	 * Disable peer-to-peer access for DCC-enabled VRAM surfaces on GFX12+.
-	 * Such buffers cannot be safely accessed over P2P due to device-local
-	 * compression metadata. Fallback to system-memory path instead.
-	 * Device supports GFX12 (GC 12.x or newer)
-	 * BO was created with the AMDGPU_GEM_CREATE_GFX12_DCC flag
-	 *
-	 */
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0) &&
-	    bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
-		attach->peer2peer = false;
-
 	/*
 	 * Disable peer-to-peer access for DCC-enabled VRAM surfaces on GFX12+.
 	 * Such buffers cannot be safely accessed over P2P due to device-local

---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-fix-duplicate-amdgpu-44017b1535eb

Best regards,
-- 
Peter Colberg <pcolberg@redhat.com>

