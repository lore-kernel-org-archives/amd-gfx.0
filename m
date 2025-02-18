Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B84C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0264D10E605;
	Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="twZ59IJ4";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1857D10E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 442A25C4C3D;
 Tue, 18 Feb 2025 04:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF9C4CEE8;
 Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854739;
 bh=OujrMVMj6cbt3MhYooscxcGRfAawgPPTi0cshRc2I7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=twZ59IJ4Pzs/79fpGu6KZYGq6OGPmFrfgtysCUL7J7Lc+igCkdNlnJ8eM5fb7wKt/
 Rk6htf4AT/rsB5te854O8ej09SLaP6o2xL7fZsJBb7ZP9hY6zzg7PWdyy4A4KZEiiG
 ibzPe6HI7pZvjws3TDhSsnQDaeIZ/8JOB/oGBgi4mehaymRaNxMznYaD8XV81OjUQx
 trLKyPithgRUXUJrQDutvRmC57TdGASSIL2102ZIOLvZNnBw2sxzkVYnK+NIzN/L/T
 kQQ4lFFp6P3MIkmUvg+F/Zs3EtugU203yo/gLi2tDPV3Exq6w4nSe5WN4xv1PK9wCX
 P/PHlkG39k0wQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Use drm_err() instead of DRM_ERROR in
 dm_resume()
Date: Mon, 17 Feb 2025 22:58:32 -0600
Message-ID: <20250218045840.2469890-6-superm1@kernel.org>
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

drm_err() is helpful to show which device had the error. Adjust to
using this instead for error messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be162a0cdc7d5..96091a9889747 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3321,7 +3321,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		r = dm_dmub_hw_init(adev);
 		if (r)
-			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 
 		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
@@ -3414,7 +3414,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		mutex_lock(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
-- 
2.43.0

