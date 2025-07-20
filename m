Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB1EC83F22
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 14:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A5710E215;
	Sun, 20 Jul 2025 14:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="ekh+DTKG";
	dkim-atps=neutral
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C61310E215
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 (Authenticated sender: ydirson@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4DE526012F;
 Sun, 20 Jul 2025 16:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753020854;
 bh=JJEyIvad6eNLdLCs4lq8S36RlFLon5KxGgYMzx2iImo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ekh+DTKGhj4Pw8Y7K38t0sCDfImf6fGVaDvT1+O6hhuFinlQjVmkAV3E0VA7QlJXA
 j1pKJOIgsF+nE6gZqtCvCs3ea/QgUs8Z+00K3RkRq/P7w3/INS/05M7Rhj3DjcFuKj
 Dg72iEGa0nYl1yjG2OJUdzyJrYliairAPKsvA3n9BKPvOoD/nGNqzHc6YDwhwJLWmn
 3WQW3/pfwqKTM4JL1qIkTtz/RS9eAdXvchxnBhAe9RwJhQr+1x0bdnCIn12UAR4fTi
 k3iZOj/my06T3HzUhuB1VR1pFyaFOghOzxTPVRH3Mz/hPxE8b8nBFZfPErHaKzdvfJ
 wVKENmiUqUhrQ==
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 2/3] drm/amdgpu: fix module parameter description
Date: Sun, 20 Jul 2025 16:13:17 +0200
Message-Id: <20250720141318.4845-3-ydirson@free.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720141318.4845-1-ydirson@free.fr>
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <20250720141318.4845-1-ydirson@free.fr>
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

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4db92e0a60da..f940068caf72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -885,7 +885,7 @@ module_param_named(dcfeaturemask, amdgpu_dc_feature_mask, uint, 0444);
 
 /**
  * DOC: dcdebugmask (uint)
- * Override display features enabled. See enum DC_DEBUG_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
+ * Debug options enabled. See enum DC_DEBUG_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
  */
 MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
 module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
-- 
2.39.5

