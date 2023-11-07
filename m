Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591D0C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 21:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43DB10E6BA;
	Tue,  7 Nov 2023 21:29:10 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C153110E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 21:28:40 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-daead9cde1eso19576276.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncf.edu; s=google; t=1699392520; x=1699997320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5GrfKC2IvsZBEgQFQYe2RhJApLNUugeSPWTjf04uUac=;
 b=jW0dtq3xrp3B9qkZxYmlxqJs9D/XZR11aOSwhJ1DDQS7kcEFBJ8NOwodxFRmma11X5
 g17EmP+5mmzam3ZM5HPmpPMt6fSvV9x42UsgbTXw7vodEQ0r3dO6xn57GWOgRdyAsOaK
 nrdTghv0yOgY+XRh+hTtN494sr51VOgGCPRL97gNRRSeKU6lbWaTzGdTkm9oT0CNNItQ
 5LOT8J3gCejZIaw4omTU/YntQ9sFipelUg2ix6aRL6+PvN9lCqqdTKJ6X7BQMP5boquB
 wgit4DQarRpdF9XcQgq6pvAg1I6G2dRd1bzBk+kbkKdKb+Bm080k5fQzmzi+uMoLeX/i
 ee8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699392520; x=1699997320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GrfKC2IvsZBEgQFQYe2RhJApLNUugeSPWTjf04uUac=;
 b=IroMTEJkLDMhv3PuRiyXdtIPrxEpo77E1T8opSDScnRfD8W1O0TrQuX89G7Bi0oZ8s
 XwldkxWqdhky/B6f4oSbkonRb9vhvPgV3KjE/HJcNNQwPfswSTdI9UWYjqhtkT9vboeh
 ZfGjF/cvaVIntMpKkArN6gmDM0WiJ8M7DkVHi9LdUeWWa7lWCO+YiILl/avqrZofecsC
 ukJunbtk5cBUUJXmrpTnu0vPsZqpKvCCQhPJFATMnXW+7wl5mD7HMPAe+6BXuRaUikrm
 IRMEmEIYUHY+vHJnknRF7QmIMltqSOm/fZrTS+bsUv/1AZcnwlWQdGOzzWyqOdA2CT5S
 sWHA==
X-Gm-Message-State: AOJu0YyNs8pOT9kZVtmXrQ9G1EfzxK3qPkZfrz3bKjvklTlIJIP2nlfu
 WF4I20lrDioa5UI7PHCSqkVtNGLnY8sfOOnPsbHXJg==
X-Google-Smtp-Source: AGHT+IEVGxWjSPfH29B0f+BhNDDfe9GVs/2MnfzycBPjOvD0xg9LpfAOaj+zUSsjtvyDbSoQfjhDcg==
X-Received: by 2002:a25:97c8:0:b0:d9a:6b46:f49d with SMTP id
 j8-20020a2597c8000000b00d9a6b46f49dmr9749055ybo.59.1699392519826; 
 Tue, 07 Nov 2023 13:28:39 -0800 (PST)
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::4174])
 by smtp.gmail.com with ESMTPSA id
 j186-20020a25d2c3000000b00da06575fbc8sm5657649ybg.2.2023.11.07.13.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:28:39 -0800 (PST)
From: Hunter Chasens <hunter.chasens18@ncf.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm: amd: Resolve Sphinx unexpected indentation warning
Date: Tue,  7 Nov 2023 11:28:30 -0500
Message-ID: <20231107162830.36856-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Nov 2023 21:29:09 +0000
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
Cc: linux-doc@vger.kernel.org, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Hunter Chasens <hunter.chasens18@ncf.edu>,
 alexander.deucher@amd.com, airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Resolves Sphinx unexpected indentation warning when compiling
documentation (e.g. `make htmldocs`). Replaces tabs with spaces and adds
a literal block to keep vertical formatting of the
example power state list.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 517b9fb4624c..576202bf64f3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -989,12 +989,13 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * Reading back the files will show you the available power levels within
  * the power state and the clock information for those levels. If deep sleep is
  * applied to a clock, the level will be denoted by a special level 'S:'
- * E.g.,
- *	S: 19Mhz *
- *	0: 615Mhz
- *	1: 800Mhz
- *	2: 888Mhz
- *	3: 1000Mhz
+ * E.g., ::
+ *
+ *  S: 19Mhz *
+ *  0: 615Mhz
+ *  1: 800Mhz
+ *  2: 888Mhz
+ *  3: 1000Mhz
  *
  *
  * To manually adjust these states, first select manual using
-- 
2.42.0

