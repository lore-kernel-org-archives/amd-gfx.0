Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD45C04FE0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFC510E4E2;
	Wed,  2 Aug 2023 07:20:11 +0000 (UTC)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF6610E48B;
 Wed,  2 Aug 2023 03:03:23 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.5542499|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.208758-0.000138219-0.791104;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047193; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6OiUn6_1690945394; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6OiUn6_1690945394) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 11:03:16 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dcn316_smu.c
Date: Wed,  2 Aug 2023 03:03:11 +0000
Message-Id: <20230802030311.10746-1-sunran001@208suo.com>
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
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index 457a9254ae1c..3ed19197a755 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -34,23 +34,21 @@
 #define MAX_INSTANCE                                        7
 #define MAX_SEGMENT                                         6
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 };
 
 static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } } } };
 
 #define REG(reg_name) \
 	(MP0_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
-- 
2.17.1

