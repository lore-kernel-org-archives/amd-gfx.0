Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52508C36013
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80B010E954;
	Thu, 27 Mar 2025 20:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rh6rrZWp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D896E10E944
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DC8444085;
 Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F9C4CEDD;
 Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107957;
 bh=NiJl+VfeLxmII/fYkPhCB8qDYf8d3H525ZPYEKwvEL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rh6rrZWpQBP1C/pCtaGkLacCVunenGua7wRILCkfLPsBaylh83v96aauGfsl3Y6ic
 JWhOkPlxTdfdlxg+nVG60s7E4K/kwjvG+Tf5f0WveLnoMgsQgUCtoiZ/vngBglpZvk
 tZpgIYDNQ1aBXyL4hAIGAsHN9PRRzoJX0IK2m9+YA7bi7TSw7RdBUPo91NtnwR94Du
 vXkD5F14GTqYRG5S3QUBE4i6ij0Cb8vw8cZSQVOF7D00sj6T+OELlhu6r+DID48zkM
 DESPEOFzL0V0o9xZypP3Bhk5tYdikqHhsJ5vVYdrAicotBE7GTMfSQmh/Qt0AMpegv
 Vx/7LWW7rKS1Q==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 14/14] drm/amd: Drop 'amdgpu' from pr_fmt()
Date: Thu, 27 Mar 2025 15:38:58 -0500
Message-ID: <20250327203858.3796086-15-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

As the driver uses drm_*() macros to print messages it's not necessary
to include amdgpu a second time in all messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h             | 12 ------------
 drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ffca74a476da9..f987e7f1a8650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -28,18 +28,6 @@
 #ifndef __AMDGPU_H__
 #define __AMDGPU_H__
 
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "amdgpu: " fmt
-
-#ifdef dev_fmt
-#undef dev_fmt
-#endif
-
-#define dev_fmt(fmt) "amdgpu: " fmt
-
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
index cea65093b6ad8..9c849341f7cd8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
@@ -28,7 +28,7 @@
 #undef pr_fmt
 #endif
 
-#define pr_fmt(fmt) "amdgpu: [powerplay] " fmt
+#define pr_fmt(fmt) "[powerplay] " fmt
 
 #include <linux/types.h>
 #include <linux/kernel.h>
-- 
2.43.0

