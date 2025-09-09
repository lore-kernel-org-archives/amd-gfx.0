Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9991CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485D610E743;
	Tue,  9 Sep 2025 14:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQ9ZYDy9";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7145510E743
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:49:54 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24c8ef94e5dso46281935ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757429394; x=1758034194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1b9Q1H2YLDiueM4jvmZhWt3i+2uNYRbT9T8oBmMZroU=;
 b=AQ9ZYDy9Ut1ZlA1g3mNzjTt+43AODGjbKPX33izDdjWumX9U0iHjjqZbBmHWghVQS/
 LPUV1n6g/sK7uW2GLGfJkD5bhwED+lXmIxtjLBAuGZHq6EPiHODoLa+hZSt6J/734ic6
 o7SYF41YLJOD9khcHzl1phhDtVhuCJ8xkKnOwQq/bRv6Hhh4PDTIiQ+N3E4iziVAN+3r
 zBtHGHs/XDAovXhM+Pa+51kBmgconvPDX4wLTiGP1F/1w/z2NY8krVM+KwZi/KS1WJ4K
 ATx9j0AZoMBllTw9GyOM+TIj8iwIS0VrbXNHsXQKyuXcbtnGoamnCOdNMNE5zwFTT2Wv
 wGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429394; x=1758034194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1b9Q1H2YLDiueM4jvmZhWt3i+2uNYRbT9T8oBmMZroU=;
 b=A29uA+4fdAOawdzCGtHxXe1U4WNrhlOLXRUDQk1y/YTeOmrkIKXz3pohMVvDB9WKXX
 G2Mw7HUNsnFiB/kmRIfSYOhRQowB4zCXLo7sQLF3e370guAw/ey0467H+Cgj4xDcSd4m
 5s5i/90ekBS4XP574jF/Mk3mK26QNrSqVz8AJ6XxaOQq/NdRowKS+dTPIsTFsjUzsUTm
 NVpBFS9+MDl9b6KIe9NF9kw8JE2mCRpFbUmoivOpGTTtGgZ1vxbLMy/HzvNUeoF18gHU
 Zt+ASXpvUTVU87FPzBnnZD6oorJByIeGLGYI4vlZOj6Qp88Ny2K2AfXfVUBU4crV5agy
 5I/w==
X-Gm-Message-State: AOJu0Ywl7I2AHMl0OcOvAg5HvCVSA2SbsEEP7q4vn9cXgI5adTs3Fpdy
 7x0rUOjb6PjhCpcC+CWOYwdxe6K58Y6yakx5SxiltLZFjxCVyrt/PYF6501z1w==
X-Gm-Gg: ASbGncsYrZOjTKEf28ZUa2/kYLNktdTuQKXd8YxiyKs5mwZvgZg8gv8a0vV6cERvstw
 XOVx7Z9I1mrLgf8g3CDoZ7d5V6OmGT34KxSaVbyLwVJzP4E3j8b7fyKMMk8YH7+D1YEWTPp4QTW
 4TAZyjPn/vilBZkWgHk/VG9oxjYWGby22wjgozPXQ/swPlyAP2I01OQ6qlHZriZq0nc1KRsuzR5
 pEw0rgyTZuq/7hWaIZmmeAp6RMIZHXQGpkr4NjFVorzMgL2C3TnL7o8suIIgUluJ16+KL16imd5
 rpwPNY6JcuCYzHRb0pYhqN95MWeOYXGMqL+jK1iSZK1tn/Ui4feLn5KQZT0G7N3YfmRyl2yyJ5J
 O2kt9iMMmzgx8yPuDxLnEbHRrKIff4zY/cRUHKc3UKw1yRLfupCNlRo3HHlO4292+dvHz0VnY42
 4yQdJppQkaVCrq7GYtuweXDUjUs+E=
X-Google-Smtp-Source: AGHT+IEcz59Ow74VvyjAugtrnwVJKe06xcVqQXLyQ+8kvXQYRNxzs6Xxi9rqKVuSlFgP69JwGiZv9Q==
X-Received: by 2002:a17:903:41ce:b0:24b:26c5:674f with SMTP id
 d9443c01a7336-24cef5270demr222859975ad.19.1757429393873; 
 Tue, 09 Sep 2025 07:49:53 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a3449f7sm239455ad.88.2025.09.09.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:49:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 3/3] drm/amdgpu: Use memset32 for ring clearing
Date: Tue,  9 Sep 2025 16:49:37 +0200
Message-ID: <20250909144937.22452-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144937.22452-1-timur.kristof@gmail.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Use memset32 instead of open coding it, just because it is
a tiny bit nicer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 12783ea3ba0f..20133ff43af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -481,10 +481,7 @@ static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
 
 static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 {
-	int i = 0;
-	while (i <= ring->buf_mask)
-		ring->ring[i++] = ring->funcs->nop;
-
+	memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
 }
 
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
-- 
2.51.0

