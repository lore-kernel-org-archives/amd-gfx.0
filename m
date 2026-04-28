Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53292CD13CF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D1A10EF79;
	Wed, 29 Apr 2026 10:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTDlW4Vw";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E06D10E2F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:35:15 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d1872504cbso19427a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777394114; x=1777998914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FX9gjca0wE7x4ubEH7lGJVHSowFseyP1beU7HKsoxh0=;
 b=aTDlW4VwybctiCyXVeJPFKlLTA4V1iY4UMaWRKx0uymuXG9yl9RG6cJXDGkF9dRcc0
 DTg1qdszaMfd25uMeujuHVbytjS4+zahuExzIjh65GCsIqYjEPK6qocRP049ceL12ZZe
 B3pdSX7CSA5rjYRFONRXrlhyVZvrh/4qv40YF/1CbWQS5Bf3oHOy0P6gVmphIwOzBbBa
 uAcNZkJmYpzktTa9qt7me9wDKUf+UKz/+sKtfIg5s2QpwqVFem7THspsYT99Dv8xyFqK
 824l4deK2dfeIgz3qtr6oYU/NksJrXLpfkMK3mrPF/uSRNd73JijEzjCoI6VaxTCFYk+
 o0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777394114; x=1777998914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FX9gjca0wE7x4ubEH7lGJVHSowFseyP1beU7HKsoxh0=;
 b=qR2v2nM20U2YXy/lWCGs8EkwTJ94YL3tiWdFTxsc0pP9Xg0wPhwGUz8dS/6ylL2mgj
 mM1XfLae/pw3POtrsduSWkPDQnlew7Dm4QcV7Io65O+NbN5pXLAcPpIJvkexP+fEuJPc
 a3tVsN2KVZ1lwQMEqf+zoLxttOYlA2jb5BVQkogqwv+oU4TLjiy/9NPphYjHPYrx0oIz
 GsY+hVQ92Mt2hyIVH8s9gBEqXvwiVeTG8sZ1tX2Kvf+7mq+aRUNnVZpnzB0TAYuZsAhS
 2PTVuk5lBarKAjzfn6lUuSWV/GLP57QMUqcwCZ7bU7dhd4fmBPdp89ikjXdZ6ix5oZ/q
 bdYg==
X-Gm-Message-State: AOJu0YwFJNsYIJYHj6YhLyDBIrpKX93N1pE9rNEQpKvX5nEXWRCNVM2J
 xc4OSTpaYAeQJdOpCsWXsziLyWOSDScKjvESLP4vvPSssDqAX9LF99bnbPGitcI=
X-Gm-Gg: AeBDiesdByzhkssCYVAfGURtNZunVO/ne2YfeQi7FdH7NnqUMcJ7fy++56on2kKKtGq
 Ze/PQXxwzQm0VIHwJze+AUszFgKTCScJjfBWvi/EGGambjz8JDWsQ9QuHyWHoZsbh4ldN7wtsJ0
 DThwNR93xagghtJvK5Mr/fJJmShmDZo7qZpwv2zI5XhftplqcXM7BcLKjHSgh6VJ3F0y/P3BZvK
 7fysaN9bqCHxAmbTb3ghEO34SVM8YPps24BLeo4ldnnktMsSWGqVe6xLAJ0f6R/s4jrwjeNJgL9
 LbFWD7sFyTFlXSSRzE3EcYJxT8EKOc6rkF4vEud/htpL4Jwcw2kMeILbuo5AcwIOCQ7ifLxSHJT
 yKeFn4p3KcZ1VCnOOkpP5X8TP64VLWT9PxC+ThRijLoeeF2RoKy6ZwAZeDISTnIFhkXCZb0iAG4
 s+KDg1Q7t8pgdU/7+4tsYfdBMJv+SM+/s+NKPtmZEZuXGZtpGvSj21sdfEM4QFu85nRPZYEFdYj
 60HEIbw5aEZRA3sCDK7eeviTApcygyMzRY=
X-Received: by 2002:a4a:c011:0:b0:687:5a16:dea1 with SMTP id
 006d021491bc7-6965c3a6eb1mr1553345eaf.28.1777394114353; 
 Tue, 28 Apr 2026 09:35:14 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433efbf1d8dsm2232322fac.6.2026.04.28.09.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:35:13 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v3] drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check
 in KIQ
Date: Tue, 28 Apr 2026 11:35:12 -0500
Message-ID: <20260428163512.9504-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:25:59 +0000
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

Remove the BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT) assertion from
gfx_v9_0_ring_emit_fence_kiq().  The KIQ hardware supports 64-bit
fence writes; the 32-bit writeback address constraint is an
upper-layer convention, not a hardware limitation.  The check serves
no purpose and should not be present.

Found by code inspection while investigating related BUG_ON
assertions in the GFX and compute ring emission paths.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 47e81c33d..fb2a0f1af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5679,9 +5679,6 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-- 
2.43.0

