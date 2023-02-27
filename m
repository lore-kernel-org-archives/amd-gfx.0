Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93790C7EE32
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 02:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2073A10E2C7;
	Mon, 27 Feb 2023 02:05:28 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F3A10E2CC;
 Mon, 27 Feb 2023 02:05:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 532AFB80CAF;
 Mon, 27 Feb 2023 02:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFFC433D2;
 Mon, 27 Feb 2023 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1677463524;
 bh=wAAPVyKKyG5I1xxb2A23aE/1rj+xyqdWzy3a5ibpvhU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=af5Fj5saaWr4sNtONxrrI7qnYyd0U1rfUWFZba3aiJNWbUdWn6N/iY5Up3c79SuZT
 AGDNPUDLubqUkdU3enB2Z7XnrrE30okY4UyKDoQnH8+2xnI/n/AJF29FYzzbfZRj9S
 kD4f09MCt61oEp5Fg0Zx3mK7oaxU1QIyr1ojKkMv8T1+kYeVgZzxy3o14mIwom3oZE
 z4eiG33od0GwBDow0qXEBHwYBOmnu03DbqnKQFFl4ECLY04YcxnOdAixZ3wY0SqXCA
 9rE2PQeNqRNncdpdBPHNm34cuquZvW6kP/pc0VXYn/YKuLAuWp02R4buAnC9ymiy5R
 TGtpEs5qjJ+Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/58] drm/amd/display: Fix potential null-deref
 in dm_resume
Date: Sun, 26 Feb 2023 21:04:03 -0500
Message-Id: <20230227020457.1048737-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230227020457.1048737-1-sashal@kernel.org>
References: <20230227020457.1048737-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, stylon.wang@amd.com, Xinhui.Pan@amd.com,
 kernel test robot <lkp@intel.com>, sunpeng.li@amd.com, airlied@gmail.com,
 Wayne Lin <Wayne.Lin@amd.com>, Rodrigo.Siqueira@amd.com,
 Roman Li <roman.li@amd.com>, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, hersenxs.wu@amd.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Jasdeep Dhillon <jdhillon@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
 christian.koenig@amd.com, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[ Upstream commit 7a7175a2cd84b7874bebbf8e59f134557a34161b ]

[Why]
Fixing smatch error:
dm_resume() error: we previously assumed 'aconnector->dc_link' could be null

[How]
Check if dc_link null at the beginning of the loop,
so further checks can be dropped.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9c4f22696c5c..6028e332e35d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2750,12 +2750,14 @@ static int dm_resume(void *handle)
 	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 
+		if (!aconnector->dc_link)
+			continue;
+
 		/*
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->dc_link &&
-		    aconnector->dc_link->type == dc_connection_mst_branch)
+		if (aconnector->dc_link->type == dc_connection_mst_branch)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
-- 
2.39.0

