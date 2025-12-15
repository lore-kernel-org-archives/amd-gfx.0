Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677FFD5B171
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3EF10E057;
	Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n94sFqm/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE3910E028
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 758AD4423D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E8FC4CEFB;
 Mon, 15 Dec 2025 01:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761153;
 bh=zbBgeHf6/cc34/T5ZK9okPVH3TyoSN19AtZcr3gKANE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n94sFqm/m1XXlSKmw18bx3x06+o/fMj0cuYN4Ne+HPJYgsXCh/yBfdfQvWerUDm4j
 ql8jIy7/BsCgOA6IRILRhkgm2lZsBNwPU8jYf5yr+HB/FYhQeMXw9GXGs982Ia4bog
 5tnAMcS4JueZbUIPPk7nXOhT5iPEcFEBJ5z+1rh/WOYJZPboMO+5QxowpUxQFIv3CH
 hfNjzxu+1QKuM9vI+K6uRDJm5TW+917aepxsOr2L636z7sxweeIjQUbznwDNGUQMRe
 dcGye1tq6BFy1dF47fV0HVmBE3AjPezqFkBtNway5E7PHR4zUzF3DXeTTBtjmOPGrx
 Fq5Jb/Vd5YFqA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 1/9] drm/amd: Drop "amdgpu kernel modesetting enabled" message
Date: Sun, 14 Dec 2025 19:12:19 -0600
Message-ID: <20251215011227.161597-2-superm1@kernel.org>
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

The behavior for amdgpu was changed with commit e00e5c223878
("drm/amdgpu: adjust drm_firmware_drivers_only() handling") to
potentially allow loading even if nomodeset was set, so the
message is no longer accurate.

Just drop it to avoid confusion.

Fixes: e00e5c223878 ("drm/amdgpu: adjust drm_firmware_drivers_only() handling")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16adeba4d7e68..f520f7450d795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3165,7 +3165,6 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
-	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
 
-- 
2.43.0

