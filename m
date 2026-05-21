Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94400CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3140C10E547;
	Tue, 26 May 2026 07:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eda3QdVS";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57E310F334
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 13:35:42 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8379e010b01so2655634b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779370542; x=1779975342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIK/4TSUzg+Gt9duY3olQGpqAgCO2S6UZFsGeUBiZ8Q=;
 b=eda3QdVS6rlW6+i2X7zCdlDaDzztXkjLC8OQpnJDYazmI2Mon7IKMSV9TnRhKs0RVT
 9UVxMYNFeJFMrB5j2M6AS7aEk8UHBEV+iUeFfIZvItbyJ4hP0xtDnjpTB4twO9R9npei
 2QSw8HesKg/swV1wOweczJcNrFQcGIySBenJufJXPP/oRzkNCP3elIcGs7uwXv270U1N
 c8ybHarWK9vOlr/5oY+ckEH8kkwx0Pe+F9zQd4bOAE2NzFfmGvIDeqYiWZ9rPy1vrf7o
 ZRbfvaPVQJ9vyhDdA8K20UbMUvNY1usrwBrBGGV+XXSm5KKorBJ324Mz+ZwrgQTwU9di
 q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370542; x=1779975342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIK/4TSUzg+Gt9duY3olQGpqAgCO2S6UZFsGeUBiZ8Q=;
 b=m7KGNyp4z/1q8gQbnOSlg1/t6WlTf2FiGJTDVijC6/UkfknZ9ImgzHCSWb914NVbp/
 UTw3svnKiFoiQz+YP74dWblm2f8VwnHADdwnmJyTJx1r+mlsOIj2YjvrO6JGmhbtsy28
 +u21rLIalutX6iEqEXs4udY7H20TFYOt3xsfrf15cLE2A2MAOO7PXt9k44qWZg8fY7TY
 fcnJqA+fP2YvrbE4Qp9xXyoRmdow3dZZnW0W6bNo5otxtxTgnY1O0QPZlsXSvt6ISWkI
 jUzCA4cp+D1APCFSdo4wFWwdIrdRHBE0yzSI5RQkHJdc21YIe//HeX7R8OHJQUF61LMe
 SEoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9clm3g27n9bKi50YSvPTYOkjB+Hj09eb45BO+7PHWuUH78zqv/m/eDPiOtxINDPWe1W8xVZKnX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdxVmpZRn2P6sNy/qfTsD6XEsLPrK4AUURu299Ax2HYE59KWGB
 GUtWfYOJyro9xwBMmmWl76l7iyJGcqSjrT2ZLbcjoe8KmV9fTH4WTw7t
X-Gm-Gg: Acq92OH6rBkSqhwZkognR/18BnsFByMtP4q6chV7cMkHHjMY688WqfVtqoNBrKl4Aes
 AQVvnZdP5lYs0pjeckAURHaTv+kdUVe4MguX7QwD5is8c5o4cvSJJdHnfjlzi3+F78PSJUvgFs3
 Zb+MqDHRJ1fYqprOLMEclJdEh1HXNNyssPEnQvPDtDFQfJ1j9Nr1b5WOvVhxODfxnaVitjFQ549
 mXXfd5VZq5c9ASeoygf8toT3AeUUO5jQ/Mq+juI1403pySBZlh5WkKhh/g/wUIsxYgXum/UOt01
 85I7DmX60WUULfgQX8jGu/67DJHPFzYjC1qVSXB+Sx+rV7GLOlv5dKlbrG46RUX7UvEgN3EmJxR
 L7F4Kj39dUh+DYOnCFXxKxZ5Hp6rnyCyf0QBvSvi7Z+yz2PBszTbWd5ZP0hgipWb5js8zIypcaZ
 HF+QoLpf0TmiKZcvSN1nuY/h0GHnA1eDTLvbrxekN82Q1vA50BGexZ1VMgohc=
X-Received: by 2002:a05:6a00:950e:b0:835:3f51:72fb with SMTP id
 d2e1a72fcca58-8414ac893c1mr3157356b3a.12.1779370542273; 
 Thu, 21 May 2026 06:35:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84154b1bfc1sm1286174b3a.26.2026.05.21.06.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:35:41 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: remove dead empty checks in ring_mux
 ib_mark_offset and end_ib
Date: Thu, 21 May 2026 21:35:37 +0800
Message-Id: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

amdgpu_ring_mux_ib_mark_offset() and amdgpu_ring_mux_end_ib() read
e->list with list_last_entry() and then test the returned pointer
against NULL. list_last_entry() never returns NULL. On an empty
list it returns container_of(&e->list, struct amdgpu_mux_chunk,
entry), which is an aliased pointer derived from the list head.
The "cannot find chunk!" error path is dead code.

These callsites run on the software ring submission path, after
amdgpu_ring_mux_start_ib() has linked a fresh chunk into e->list.
By the IB API contract, mark_offset and end_ib only execute between
start_ib and the chunk's removal in scan_and_remove_signaled_chunk(),
so e->list is non-empty at the read. The defensive check is
misleading and never fires.

Drop the dead block on both sites. The list_last_entry() read stays.
If a future change broke the precondition, callers would crash on
the aliased pointer, which is louder than the current silent error
log and easier to debug.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 6e64a96fa285..83d62d9f76d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -495,10 +495,6 @@ void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
-	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
-		return;
-	}
 
 	switch (type) {
 	case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
@@ -528,10 +524,6 @@ void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *rin
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
-	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
-		return;
-	}
 
 	chunk->end = ring->wptr;
 	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
-- 
2.34.1

