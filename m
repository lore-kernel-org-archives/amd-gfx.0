Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0682C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5AC10E1B2;
	Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oo/137yW";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E9310E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6DEE15C4C3D;
 Tue, 18 Feb 2025 04:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CACC4CEE8;
 Tue, 18 Feb 2025 04:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854737;
 bh=YEQuIabpH2RrdzWGDeDe7cJYul7Ir9UDk5LhQxZDffI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oo/137yWyX68ssIbBFiMACL0bZaoDoDgxjXXD0IVgeLrnwupY09OCHyMOMmPsgo7G
 S4auoUPaRj3Hx5kb9fWvDJID4RcoB7OxhhGs/Crh61sTQPXgY73FJTF2bGLV119eMl
 vkAvJSqZnVUP7VtStRi2AlyGaqT8stZQ61KqBp4NXYAplcg/fnQmCfwiNW+LSdUtG0
 g7oYXI/4Sb/hNxcl8KcnQqZqjSyHotLZiTiiOXo4abb4fqEMxDrZchN+oUrcMGV4wQ
 md1cDc0kJ25Xw3qyASebo4Ia7ewgnkl0sMOJ5pAOWITuHuKcB3Y003vdHA7gWh7H3r
 bdPk1CVAHSI4g==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Drop `ret` variable from dm_suspend()
Date: Mon, 17 Feb 2025 22:58:29 -0600
Message-ID: <20250218045840.2469890-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
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

The `ret` variable in dm_suspend() doesn't get set and is just used
to return 0.  Drop the needless declaration.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b26ae1dd1fd78..0d78cabeece70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3087,7 +3087,6 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int ret = 0;
 
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
@@ -3105,7 +3104,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 		hpd_rx_irq_work_suspend(dm);
 
-		return ret;
+		return 0;
 	}
 
 	WARN_ON(adev->dm.cached_state);
-- 
2.43.0

