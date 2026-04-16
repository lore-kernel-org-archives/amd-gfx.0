Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED7F8E4B4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 07:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215610E980;
	Fri, 17 Apr 2026 07:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KN2pJoBF";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CC510E21A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 19:55:42 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8a0323830beso67191716d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776369341; x=1776974141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EVDa9MmHdKtXRSXwqrzO68IZv3ECM4LIzStEaRjKsNY=;
 b=KN2pJoBFUyyPo1e/MtwgMPtqZid/8NrqmbLzTimWbAFkzBW6s4GfhnQKVJ194zt+jh
 yx7QS/bg/KLHIlWSZwRugOd2GYtMi+lfPikmyRCkGA6x/RId92Ef4L0B1WrK1D54tAGH
 SEHZfh6rnlAcJGM6Jkd/CGHBKQc10Du1ucLbn3Xqsx1Uy04vpQDOYI4igbCuJviQfk8K
 fQVDwJDggKgRsmmhEGXSfgOmbb2xxQT8ub/2NjyDaiSJDcIrfQXnw1BFvEcYdxOtnLBd
 39I8+Qg25yf/7PUl1C58/7ww/td1+hSWFZkGSsPwx8o6TfuJEukD4Kd7OK+jvQEnYUou
 KJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369341; x=1776974141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVDa9MmHdKtXRSXwqrzO68IZv3ECM4LIzStEaRjKsNY=;
 b=DSv2DdtrvvzoBbsQK2R2jnS/hi09YoyjqvcemNX3YJ7CyLbQDCk+5MnUekZVQpY5Dx
 TAx29CPFY9v4k2TKm95E6xa6+hBK1En1jmDB+ML+WChSo2M+Sn8iKaAO68y8Ri+423fi
 kAun4g5MLv7oS69zoPNT8Ex0+oUbljAjC+Hjpj7pT8GTFuLQcUDA5hSFj3uXGGX7efM9
 haxhWQ4KzEy9Nzzeps6P2rj37m7KF6KvmNCvOef/M5l/xVzv4D5GycbP3hK78Z/RpkwQ
 x7VxWL28UUbe7zYr7toRXfJYMoB4n0HExfpeBZ6px31DXPq9M1ZjffNuYHeKGYwK4zyU
 Vc2w==
X-Gm-Message-State: AOJu0Yx/vYfaxnS+3BpzIgf4/+p+T/aTRrNxoq4oTTt05o0GgN8SDQ0K
 6S8MdaJdCbbAlYwaZQSpel2OYZJtsaeKNIvZhGjuQJhwBVPiL3XTUGgI
X-Gm-Gg: AeBDiesCqeegA41cMiA/RF7SUKfzbI5ttS9LqAeCm2XkXXgyoDw9Rx7pFb7w+FFc3Y3
 42X4psc0R/FRUG+nqDoxCVoAnG2uaZN63he07v7LyTtDLl8JPDxVeNPzOiURp5x3wItcFS/xuCO
 94ja/+ov3O29vH7bZNObdvzGl+TVOOaIfedsyds9N7X4raskLaogMRXw0vYXyiIQgRrmPdf9xjL
 KfG2iZwgwojG/WSCWKFmthntVChmq+GlH1pkkXIOsbtGBsO7WmT6t4I1aRvbR6bgct35ri9QJK6
 zR7M47gRZew854s2TaKvBIM9Si9Jq9/TzZ08N9eSwAyKZgvIcRHkKRpx6J0rNFyRRjcLzMo/Ncd
 VK8AcbLNRMNj9siKfWbBlBevEXZ5b/PLfDECa8PfTpL7oKpIWCwe31qZWMw7OqcsG7JRYx2YfK0
 +ir5dB/qpDYgRWaNw9ZJ44b9uNkH6ZfSYqvYtUD44WK0yz8g5qPfdLOb87UKXV
X-Received: by 2002:a05:6214:3d85:b0:8ac:ae21:46e with SMTP id
 6a1803df08f44-8b025eb184cmr11397316d6.31.1776369341477; 
 Thu, 16 Apr 2026 12:55:41 -0700 (PDT)
Received: from localhost.localdomain ([104.39.116.151])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cb9eb66sm43769206d6.31.2026.04.16.12.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 12:55:41 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/radeon: fix memory leak in radeon_ring_restore() on
 lock failure
Date: Thu, 16 Apr 2026 15:55:37 -0400
Message-ID: <20260416195537.3632-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:57 +0000
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

radeon_ring_restore() takes ownership of the data buffer allocated by
radeon_ring_backup(). The caller (radeon_gpu_reset()) only frees it in
the non-restore branch; in the restore branch it relies on
radeon_ring_restore() to free it.

If radeon_ring_lock() fails, the function returned early without calling
kvfree(data), leaking the ring backup buffer on every GPU reset that
fails at the lock stage. During repeated GPU resets this causes
cumulative kernel memory exhaustion.

Free data before returning the error.

Fixes: 55d7c22192be ("drm/radeon: implement ring saving on reset v4")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 581ae20c46e4b..a5dff072c1ac0 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -356,8 +356,10 @@ int radeon_ring_restore(struct radeon_device *rdev, struct radeon_ring *ring,
 
 	/* restore the saved ring content */
 	r = radeon_ring_lock(rdev, ring, size);
-	if (r)
+	if (r) {
+		kvfree(data);
 		return r;
+	}
 
 	for (i = 0; i < size; ++i) {
 		radeon_ring_write(ring, data[i]);
-- 
2.50.1 (Apple Git-155)

