Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2362EC3ABB9
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 23:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE24210E5F3;
	Mon,  5 May 2025 23:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S9cqElo+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5669610E5F3;
 Mon,  5 May 2025 23:12:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DCEC4A422;
 Mon,  5 May 2025 23:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5BC4CEEE;
 Mon,  5 May 2025 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746486727;
 bh=KIxa7bKrdNc9vhKHrc8LdMUtM53Ut/YsRCoVGbdw118=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S9cqElo+x3wcTnt4Hu/lL5js5u/R7Tge8aXQQ2+XtTDnvAdVXgn3dlgvX9cFtcRTu
 f2oa2BxL5gnyIwRdLhvz/aKcAoAIsz1gqNb7j7r4YShwhZTsNuCGOkaOpzNnjTkrrh
 i+vc68GUdgVELQ2/NEs2brZ5r/tM12tgjlfZgAdo0aml9vjUjSdQfbAA5nMgFkWfdG
 voe0QIWVRVkEJ+csHmxpEgBB9pNzt0fL9e/zJQUW/jnypGVHKkTlUHSPMPKPNArKGL
 8nO+2XkDWB5/EddQ/F/vFgCMA+PShffooJrDwuw5t++7MrA3HCnldprh3ty+GK92yp
 2mCojyPIux1Qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 lijo.lazar@amd.com, sunil.khatri@amd.com, le.ma@amd.com,
 YiPeng.Chai@amd.com, gerry@linux.alibaba.com, candice.li@amd.com,
 Feifei.Xu@amd.com, kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 172/212] drm/amdgpu: enlarge the VBIOS binary size
 limit
Date: Mon,  5 May 2025 19:05:44 -0400
Message-Id: <20250505230624.2692522-172-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

[ Upstream commit 667b96134c9e206aebe40985650bf478935cbe04 ]

Some chips have a larger VBIOS file so raise the size limit to support
the flashing tool.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a176b1da03bd3..ae6643c8ade6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -43,7 +43,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
-- 
2.39.5

