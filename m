Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B16AC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7226120578
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3rgBByF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7226120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235CB6E2E6;
	Mon, 24 Aug 2020 16:35:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250E36E2E6;
 Mon, 24 Aug 2020 16:35:27 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3537C22BED;
 Mon, 24 Aug 2020 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598286927;
 bh=+fTUKEyrtLg4Uiu2RbCq3/3bQ+IX0Dc03GZZYbNK0kc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C3rgBByF+VEIpXqmh69Hoy2v10zgXyL9H1sA5weMYM3OfNIZCRjUdFi5WIsibLmey
 AsjYDqmb8BAlEw3rzXmhi5//6Lb763PamQMwd6yYHzuQqVz3CpMZ+05qXMbqlMRzDw
 qn4g/vWr6lxu3/+WJfPriQiO6Q2q3DYVx4euPlKs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 17/63] drm/amd/powerplay: correct Vega20 cached
 smu feature state
Date: Mon, 24 Aug 2020 12:34:17 -0400
Message-Id: <20200824163504.605538-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Evan Quan <evan.quan@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 266d81d9eed30f4994d76a2b237c63ece062eefe ]

Correct the cached smu feature state on pp_features sysfs
setting.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 9ff470f1b826c..b7f3f8b62c2ac 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -979,10 +979,7 @@ static int vega20_disable_all_smu_features(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-	uint64_t features_enabled;
-	int i;
-	bool enabled;
-	int ret = 0;
+	int i, ret = 0;
 
 	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_DisableAllSmuFeatures,
@@ -990,17 +987,8 @@ static int vega20_disable_all_smu_features(struct pp_hwmgr *hwmgr)
 			"[DisableAllSMUFeatures] Failed to disable all smu features!",
 			return ret);
 
-	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
-	PP_ASSERT_WITH_CODE(!ret,
-			"[DisableAllSMUFeatures] Failed to get enabled smc features!",
-			return ret);
-
-	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
-		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
-			true : false;
-		data->smu_features[i].enabled = enabled;
-		data->smu_features[i].supported = enabled;
-	}
+	for (i = 0; i < GNLD_FEATURES_MAX; i++)
+		data->smu_features[i].enabled = 0;
 
 	return 0;
 }
@@ -3230,10 +3218,11 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 
 static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfeature_masks)
 {
-	uint64_t features_enabled;
-	uint64_t features_to_enable;
-	uint64_t features_to_disable;
-	int ret = 0;
+	struct vega20_hwmgr *data =
+			(struct vega20_hwmgr *)(hwmgr->backend);
+	uint64_t features_enabled, features_to_enable, features_to_disable;
+	int i, ret = 0;
+	bool enabled;
 
 	if (new_ppfeature_masks >= (1ULL << GNLD_FEATURES_MAX))
 		return -EINVAL;
@@ -3262,6 +3251,17 @@ static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 			return ret;
 	}
 
+	/* Update the cached feature enablement state */
+	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
+		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
+			true : false;
+		data->smu_features[i].enabled = enabled;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
