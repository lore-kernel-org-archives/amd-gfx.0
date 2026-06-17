Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5988CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2806D10F0DA;
	Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1NF3SKY";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839A410F0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso87898f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723680; x=1782328480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjS3ffb+zpQ6GhNd1A9ZSUz6ZasMJ0w/uZwtD5oPVtE=;
 b=q1NF3SKYowunEtscWilanlFPq/4tQdah/r4zAxUI44vWONhKmu27+1BE2XbMWbkRfU
 63iI1G8OkmboYG454dJ3t+5No5WbFLxPCtqwFpbnpV8lz/qqr1oOrQLdQs3SQ7xlyF8e
 LuytkNx5FNy580+JWAiubtoichxoTusDJU7ls3CY1hhRXB04H6HOBjnVn1ksoT+DW94F
 4TcwDiK6PDLBxyOP+oMEJW+ekWg5WkbLeeVs/bvgj8qJcBowpbe8MdzAlbQiLzWFYQDz
 0ET/1eXWI6RvIjlZ7u+pTtWdFnoN8qExa3SJICJVo+IFK5FPRYN7zlimLXuIwzTOK7iq
 4ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723680; x=1782328480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjS3ffb+zpQ6GhNd1A9ZSUz6ZasMJ0w/uZwtD5oPVtE=;
 b=PQO6TIYa/GqDC5QvXSzl8Mwi1QuN4m7NifMdQqQa5FN60VAURAgon0yg+HekUYRkPT
 FZIsJVgPXH8LJoPiraPkr5FByJAILSz49ImKL7J23syh02PAgyY68f5lvhRo+MtNDLrg
 mHhHUJ3SDRod/Pn12sj1lXhC8oFtxx5/UV6mXsw51jU5ApZSKsrAc/GOVwyHmAtPCz6r
 TNn5OpuptjfZ6x4/syM09n7Rui9HQSo0KmKyABxxZltjaTiTbJHnKUvyQNgYJ65S8KWl
 eBYVQGAj/BKP0RcDzFFxKZ4D6Rco2PNlDpRCGBjmJ7xdd5T6txspAFkJKvi0P6HJXjR9
 Zdxg==
X-Gm-Message-State: AOJu0Yyt9S1m3y3WAkddrvbAnR+4fa+Tz5WRjb6CsBFfDnKgdnlZnqvD
 2FJElgFAElOHmmvxekm2X5ne4b3291C4YP5WD65Sc0oTTQbkMqWbQ4oMU0Tefg==
X-Gm-Gg: Acq92OHAu1hJ9K7S2IKDYa7hQzfG69TgV7LL4uFh/FFrv0gfYay6XzMicLEMDJ6ee5j
 pIwG+DxYgvP4jdE8+29S0A10BRvDZ5n7Nym4Cj4wQ5tNqcAXAPQNOjluFDWpsklAELQShz3HsUU
 e86yTC6UgNPZUmwh0F6LwNn1MqR4x5eDkNgY90grTPL5+AVhiCFscvWrZuaKTwgidG56g4ioc0J
 EO/KxpJEtqASoVIBeZ4qBgsZsGA7bo6CRuXhzRt1b6/WrfzIJOQjRB6AYltH1ln9tCpJ/jcc0R+
 lAArsNxEq4ix3N37mHyierN4zh5KN9k2Pe3eKgN/BJVu2PP3Wp/fPEG7WVRyiwdzQsD0AhlerkC
 VBhzQpuGcatipSTKdB/NsXjbc4b/kjV4ztNRHuLPtnRHapLpGMYy8kWyIA+1XBch1TVz4K5nI63
 xeb8vtw2MOBVLh59b7HjfbVW7j2PmJDybXL/HmrLcmjfOKpcUed+7psw==
X-Received: by 2002:a05:600c:6096:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-492333571f3mr93311595e9.0.1781723679912; 
 Wed, 17 Jun 2026 12:14:39 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/17] drm/amdgpu: don't reemit if there is nothing to reemit
Date: Wed, 17 Jun 2026 21:14:18 +0200
Message-ID: <20260617191428.1784083-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Deucher <alexander.deucher@amd.com>

Return early in amdgpu_ring_set_fence_errors_and_reemit()
if ring_backup_entries_to_copy is 0.  That means that either
the ring is idle and there is nothing to reemit, or there
some reason why we should reemit, so return early and
signal the fences (if applicable).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index ea69b1bac7c6..01333b56f24d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -727,6 +727,16 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
+	/* If there is nothing to reemit, return early and set an error on the fence
+	 * if applicable. If all of the fences are siganlled, this will be a nop.
+	 * if there are still fences and ring_backup_entries_to_copy is 0, then
+	 * we are skipping it on purpose.
+	 */
+	if (!ring->ring_backup_entries_to_copy) {
+		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+		return;
+	}
+
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
-- 
2.54.0

