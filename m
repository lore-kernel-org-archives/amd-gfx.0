Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B1FC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 22:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3A610EA16;
	Thu, 16 Jan 2025 22:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y1CAY2Nj";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D55A10EA16
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 22:00:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 642255C596F;
 Thu, 16 Jan 2025 21:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CEEC4CED6;
 Thu, 16 Jan 2025 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737064829;
 bh=PTyTvxG4y0KIEsgpGYLmrFdvZAJE76iS0uoCsRaTvjo=;
 h=From:To:Cc:Subject:Date:From;
 b=Y1CAY2NjkedKq5/dWj38Bhv/29PwuWITexYELlrcp5XxQbMiU+zUC2WWd1oKww8Ni
 xv+WempQ22oN+irh6C3xQOq4CsSQ8CI6G2gJnPpHOIrzVrR+ab4wbCWTy++ywjbXlF
 o8+7toXk8PsexcmqVfsC35gE6+hR5KfuUj9S49sYyrqd61M0wLSpZL6zWwDrOZuSCJ
 94fmQDFsFVgMUCW6RYMvqpQBk3oS8UkVaIL1D/aFcPpVAhsCejHikhYo5suAe6dks7
 rRaViPN2nJ6gGRqg65XQ12/eRkwPag9FJM88bx1bKFi6IOmWDHZI/dNGKJqzvNGjZs
 H6fi3/hcl8vpg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] drm/amd: Clarify kdoc for amdgpu.gttsize
Date: Thu, 16 Jan 2025 16:00:18 -0600
Message-ID: <20250116220020.2425025-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Effectively amdgpu.gttsize gets set to ~1/2 of RAM, but that's controlled
by what the TTM page limit is set to.  Clarify the kdoc.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b911653dd8b6..680b272a83c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -282,7 +282,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
 /**
  * DOC: gttsize (int)
  * Restrict the size of GTT domain (for userspace use) in MiB for testing.
- * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
+ * The default is -1 (Use value specified by TTM).
  */
 MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes (-1 = auto)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
-- 
2.48.0

