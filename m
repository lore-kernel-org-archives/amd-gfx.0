Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF0ECA1017
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Sep 2025 23:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8295110E0BB;
	Sun,  7 Sep 2025 23:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OruF6ahe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF8810E0BB
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Sep 2025 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NldmOeAzJSVXWsxfzCC9GFGbu9uiIcCri0VNq1LO+B8=; b=OruF6ahe/dCCum9KYKovA35cx7
 rM1yAiWIw2jMcFf6hB8D5EV6x5w8jD5Xa8WwTfZTzeiO8AY3Af6jr8AF+Xjs05kdopYfYhMtk9ACx
 VDhwR0Pq57T1pRfjaMHgDUdfTccS1ZiQkpF4X/y6ARN/QspRRGWCjI1QYVedB1i2eO/ZsJatkhFzJ
 USYJeg4SOhiq/Lhkq8hUGyyhV0h51UoH4xoh0pGqOYhZ/FYoW6JdFbJ9XlXp0l0eItA5EPN4aP+jn
 +9+TCoxSG4pE2UOu7BXAUPhr9vEHcW6Bo+c8tixh29B4ASh7E9eXLNMb4Hfv6yZmWTKoQtMFMtQrn
 a9eepMrg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvOSZ-0085Qy-RT; Mon, 08 Sep 2025 01:06:12 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: uajain@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] drm/amd/display: Fix unload issues in amdgpu
Date: Sun,  7 Sep 2025 17:05:46 -0600
Message-ID: <20250907230551.1804823-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
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

Loading and unloading the amdgpu module in TTY mode is successful at
first glance, but attempting to turn off the system after this action
results in a kernel panic. Sometimes, after trying to run load/unload
multiple times, the user may also encounter other issues. The easiest
way to reproduce this issue is by running the IGT test amd_module_load.

The load/unload issue was introduced by commit 3d5470c97314
("drm/amd/display/dm: add support for OEM i2c bus"), which added support
for OEM i2c. In the original commit, the new I2C adapter is registered
in the initialization function, but it is not deleted in the removal
operation. As a result, when the removal function tries to free the data
struct for the OEM I2C, it has issues. This commit addresses the issue
by checking if the OEM I2C has been initialized; If so, it also
unregisters the I2C adapter before attempting to free it.

Fixes: 3d5470c97314 ("drm/amd/display/dm: add support for OEM i2c bus")
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 242f98564261..6ce51f81ba44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3007,7 +3007,10 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	kfree(adev->dm.oem_i2c);
+	if (adev->dm.oem_i2c && adev->dm.oem_i2c->oem) {
+		i2c_del_adapter(&adev->dm.oem_i2c->base);
+		kfree(adev->dm.oem_i2c);
+	}
 
 	amdgpu_dm_hpd_fini(adev);
 
-- 
2.50.1

