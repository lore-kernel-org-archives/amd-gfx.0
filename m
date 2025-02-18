Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB41FC02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFC210E609;
	Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XtY2QZ4Q";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B610310E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D91585C5A9F;
 Tue, 18 Feb 2025 04:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EAEC4CEE6;
 Tue, 18 Feb 2025 04:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854739;
 bh=1tMq3vd5FtWWtbi/6tPE48WALaUva5BlZVNDbJobdO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XtY2QZ4QA6HBh/5ZcX5IQayG+VU/LJQL49u0+DD+qWHDolBkdo8Fe3WowGiHhq+Xt
 goQEN+qEH04k8IvkZFq+4n9gfBCvAtD4XhL+YpGYXBsCTslbcuhNUGF0BKAw5oRdiH
 I61FDAAGLH2WIK+F1oGGABawh5kOs/gsa2yF7M/UZSA8KK/6mKbUWOg1WQ6s4ReHPk
 zV3M1rzJmSPNRGUUGxWcJX2wwtrgCVV6rAz/eYtKm530C4tMybXR88ALcBc5+KCxS2
 eC16sfBpMfy03TAb5NHKyQd4Nw9DuHkKPJwSk3rIl9O3YrXKPP1n+16wEp1Q1fqcxt
 K91yYLwiupyjw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Use scoped guard for dm_resume()
Date: Mon, 17 Feb 2025 22:58:33 -0600
Message-ID: <20250218045840.2469890-7-superm1@kernel.org>
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

Scoped guards will release the mutex when they go out of scope.
Adjust the code to use these instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 96091a9889747..e7a9e60a6405c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3412,17 +3412,16 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		if (aconnector->mst_root)
 			continue;
 
-		mutex_lock(&aconnector->hpd_lock);
+		guard(mutex)(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
 		} else {
-			mutex_lock(&dm->dc_lock);
+			guard(mutex)(&dm->dc_lock);
 			dc_exit_ips_for_hw_access(dm->dc);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
-			mutex_unlock(&dm->dc_lock);
 		}
 
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
@@ -3432,7 +3431,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		amdgpu_dm_update_connector_after_detect(aconnector);
-		mutex_unlock(&aconnector->hpd_lock);
 	}
 	drm_connector_list_iter_end(&iter);
 
-- 
2.43.0

