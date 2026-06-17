Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF67CD98F8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C4610F0DB;
	Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FnomFT0f";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3554D10F0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so570725e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723683; x=1782328483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE5bBgmES7rwaSOezENZK+CxpRoTyve64ifUIPh/IjE=;
 b=FnomFT0f5Y+R7FHEciI3pdBuE0ytHuHB4Hy0Kx24nu6z52wHHeWb7u0GxNgOv4aTm7
 GHrxykUT6kRsMSIJ+RgMJN2ux5Tu5fjdPA2A+CvxI8SgUGx5/J5BFGyFwc8qmfCNzNcF
 j6CBmblFMwjg8U44EJ0hQI1DTDeX1Asp3i7nXf8SzP4iAwlTKbf5bg5PjWRTo1fkQy9g
 lS7op++epaqFOYCHc5htb8r9JWvh4jtEIdHmfb4rlaEQqlmtJAJYlME4O30pW5fQyQRX
 zzXvcPELgN+A1IS2pGH6dpBvA57miyWgjC/G8r2ah5j7LApunVpAsymdWUMWpfVu5tl3
 xLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723683; x=1782328483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LE5bBgmES7rwaSOezENZK+CxpRoTyve64ifUIPh/IjE=;
 b=V+lHHXfMzjGjkUIM3G5ezvLoQpdwP+cJswUkUoCr0Ok5TlnlRfxYfiwCw5aOB5PHdP
 XEDgyRVosuJtJqjZWhGCKEm0b/EwNBH6sV4/U59cAfeXNgIrh0BsAeJLbzUH6MZ261k4
 AKkWAQctxfr7JT3GyOFKf/K43Z28sAKHaC5hWA3bQexsSHO+Hfj+J+gbI9T5QUaNEDzL
 MqqDPhjosbbSwvXsj96r6j27l9Kv2FVVLoyEZQ22iyCQNd+slEFQSlzW/FAWaxMIfmlr
 K0bKAIyvbgnGrGxHCC2mTrCo04aprBEW2/2lj/f8prKlMAkt5cg5pVbs3had7M6RErbu
 q+lw==
X-Gm-Message-State: AOJu0Yx0rVwIBUBkeQAAfqkLUcU9zVFBaKHNjauz+ZtxGe6yxVsUno9Q
 Rc+oboXIqyNINyVuHI56599jncoZNAMw+JjZBHHWQeQvDE4TgKLwrsYFKZIjMg==
X-Gm-Gg: Acq92OHPvxJxk/EYzVwn77f1GCw1LT6sGyrN35F6snP/8mNCTE+cTiu9o9RJfeopV9x
 h+YD4m69PnKPnaKVmDtaAXDTePQl1z3AAlSsQArSPnS2upusck1DyS0lWBbabVPMvEzzNpFDjqQ
 bgTnw/Bf4FtzHWnpxFdsyS/5jsSw9wiiEftRZw0+3EPli9MnFpH0vMS0ecQqbRNfNVx+YRzgkC0
 MEhpZN1gYPDt76lGyo4BtoKR80/ncQSY8o5oH7CcFW3FfWCXZ74QqPcJFog+Ny/df9KyuRYTYq9
 vrFkigub8PS71h3NaLg1ECQs2iTiACF9I1BHxbb/kXyZbAd17ogqHS8ox+lo5i9dgCsr6I8eBaL
 ZYGn4Cf7fs3wAo2PMLTMxkILE+tIbdOkfwRnQ61N4tbE3BicL1OHxcDaS7VylP7CnDHkZ2Mimqb
 DqbeE441HkW7G1JBA4LRhEFKHsfXzSdGU375XKn18R/htr63lp22GfPw==
X-Received: by 2002:a05:600c:3148:b0:490:b5d0:598e with SMTP id
 5b1f17b1804b1-4923412f0e7mr76768045e9.21.1781723682574; 
 Wed, 17 Jun 2026 12:14:42 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:42 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/17] drm/amdgpu/fence: add helper to extract the guilty
 fence (v2)
Date: Wed, 17 Jun 2026 21:14:20 +0200
Message-ID: <20260617191428.1784083-10-timur.kristof@gmail.com>
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

Add a helper to extract the first amdgpu_fence which has
not yet signalled and is thus guilty or at least collateral
damage.

v2 by Timur Kristóf:
- Don't clear ring_backup_entries_to_copy

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8a54da1267b4..ecf7991b2a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -832,6 +832,36 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	} while (last_seq != seq);
 }
 
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring)
+{
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+			rcu_read_unlock();
+			return fence;
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+
+	return NULL;
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9276a3bb69de..71cd9bb12f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -589,6 +589,8 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence);
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring);
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-- 
2.54.0

