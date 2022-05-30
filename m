Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 13:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB79B10E9A3;
	Mon, 30 May 2022 13:41:09 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D5510E990;
 Mon, 30 May 2022 13:41:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 801C9B80B3A;
 Mon, 30 May 2022 13:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76FC3411E;
 Mon, 30 May 2022 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653918065;
 bh=AmtNEIONDz4TR6XNEOBdkvo95XyT+gqj55BrSboz7xA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s7UGS2yukqvS5QX9yU05toETgqQmkzDwWUktsmXDCQRZudXKGIL1kNL4WrptOLL+e
 93AxppO5zBWzB41ea+vRssTz0EpL574Nbd415jiTDn6KJ7SsMj2H/53Mf5YDjh50QR
 VTQ14UK8oB2K9btJPN09AKA0q5kFqv7jGwr/0igOGyUVRPiJ84aDRtkxQT2AnwrmAm
 ngRnimJlRk9F1KnYm7d57yTir6qOCp9qJqpH3sV/hFa+kt/5oTrttkXLuRlx0GPkvl
 dO6p764Yrrw6ppYAch1U/ZSNScuMS4epFuW7H1m87ddbG7iqI2oT02wfUZq0moAecT
 LTdSnf87yXA8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 047/109] drm/amd/pm: fix the compile warning
Date: Mon, 30 May 2022 09:37:23 -0400
Message-Id: <20220530133825.1933431-47-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, lijo.lazar@amd.com,
 kernel test robot <lkp@intel.com>, airlied@linux.ie, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 555238d92ac32dbad2d77ad2bafc48d17391990c ]

Fix the compile warning below:
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'

Reported-by: kernel test robot <lkp@intel.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index bcae42cef374..6ba4c2ae69a6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1609,19 +1609,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
 
 static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
 {
-	u8 i;
-	struct amdgpu_clock_voltage_dependency_table *table =
-		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
-
-	for (i = 0; i < table->count; i++) {
-		if (table->entries[i].clk >= 0) /* XXX */
-			break;
-	}
-
-	if (i >= table->count)
-		i = table->count - 1;
-
-	return i;
+	return 0;
 }
 
 static void kv_update_acp_boot_level(struct amdgpu_device *adev)
-- 
2.35.1

