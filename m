Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07AFC001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5287610E4CE;
	Wed,  2 Aug 2023 07:20:07 +0000 (UTC)
Received: from out28-90.mail.aliyun.com (out28-90.mail.aliyun.com
 [115.124.28.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE55310E47A;
 Wed,  2 Aug 2023 01:38:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4792903|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_alarm|0.0767665-0.000288784-0.922945; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047212; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6Jqo9R_1690940299; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6Jqo9R_1690940299) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 09:38:21 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in pp_thermal.h
Date: Wed,  2 Aug 2023 01:38:18 +0000
Message-Id: <20230802013818.8766-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
index f7c41185097e..2003acc70ca0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
@@ -25,14 +25,12 @@
 
 #include "power_state.h"
 
-static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDelayPolicy[] =
-{
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDelayPolicy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
 
-static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy[] =
-{
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
-- 
2.17.1

