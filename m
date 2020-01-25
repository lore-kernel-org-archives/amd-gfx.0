Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3703EC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 08:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D86420842
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 08:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D86420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5606EA49;
	Mon, 27 Jan 2020 08:23:59 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A976E90D;
 Sat, 25 Jan 2020 20:26:16 +0000 (UTC)
Received: from [82.43.126.140] (helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1ivS0T-00022J-I3; Sat, 25 Jan 2020 20:26:13 +0000
From: Colin King <colin.king@canonical.com>
To: Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: fix spelling mistake "Attemp" -> "Attempt"
Date: Sat, 25 Jan 2020 20:26:13 +0000
Message-Id: <20200125202613.13448-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 27 Jan 2020 08:23:59 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Colin Ian King <colin.king@canonical.com>

There are several spelling mistakes in PP_ASSERT_WITH_CODE messages.
Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c | 12 ++++++------
 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index a3915bfcce81..275dbf65f1a0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -128,20 +128,20 @@ int vega12_enable_smc_features(struct pp_hwmgr *hwmgr,
 	if (enable) {
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return -EINVAL);
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return -EINVAL);
 	} else {
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return -EINVAL);
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return -EINVAL);
 	}
 
@@ -158,13 +158,13 @@ int vega12_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 
 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return -EINVAL);
 	smc_features_low = smu9_get_argument(hwmgr);
 
 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return -EINVAL);
 	smc_features_high = smu9_get_argument(hwmgr);
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index 0db57fb83d30..49e5ef3e3876 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -316,20 +316,20 @@ int vega20_enable_smc_features(struct pp_hwmgr *hwmgr,
 	if (enable) {
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return ret);
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return ret);
 	} else {
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return ret);
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return ret);
 	}
 
@@ -347,12 +347,12 @@ int vega20_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow)) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return ret);
 	smc_features_low = vega20_get_argument(hwmgr);
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh)) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return ret);
 	smc_features_high = vega20_get_argument(hwmgr);
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
