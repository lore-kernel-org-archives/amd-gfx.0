Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46F7D5B16E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0CC10E0BE;
	Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sIM8bw6I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69BEC10E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DD7626017A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDDDC4CEF1;
 Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761155;
 bh=l0LJ9gQfJCSEYvSDKKNESGwz+f+ZKpwo32dWLI2d8Go=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sIM8bw6IGRLiSK9urqN7dlYACZt+qAAtoUw/XBA6/wGONQYGZixsKyD9GMOXQw3UH
 0m8I7/GmFXtKBWg93KB5RiAyGpp3d7S3ejgr4qtIT+8DwE/VS9T5a9xLKT3yycWXJc
 gczqBh81VA9oFzBn0VY9FBhXD/OE2bxHORZRW2hjP2kBvpUX6UvUbk8aBXX7kAU3SL
 Mqv6+tqpCGcLaoO0wy5v3ZGydgWz6btgPYvyCRbZZJWsTAsF1RnMUbW4eVAWQb+Isa
 HakFVqcPfbR9lKaD9CZ0VdaJcMQSOa+dz9erW+7GFV81M2rEWGCLyQY6YKmPThF725
 L8A8I2GK2nTKg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 5/9] drm/amd: Drop dev_fmt prefix
Date: Sun, 14 Dec 2025 19:12:23 -0600
Message-ID: <20251215011227.161597-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

The `amdgpu:` prefix in dev_fmt() isn't needed because the core
already includes the driver in the print.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa71df36f4b38..ee7e232bb3406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -34,12 +34,6 @@
 
 #define pr_fmt(fmt) "amdgpu: " fmt
 
-#ifdef dev_fmt
-#undef dev_fmt
-#endif
-
-#define dev_fmt(fmt) "amdgpu: " fmt
-
 #include "amdgpu_ctx.h"
 
 #include <linux/atomic.h>
-- 
2.43.0

