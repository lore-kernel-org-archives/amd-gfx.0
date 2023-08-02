Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09135C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90C410E4CF;
	Wed,  2 Aug 2023 07:20:08 +0000 (UTC)
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com
 [115.124.28.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3719B10E1ED;
 Wed,  2 Aug 2023 02:58:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4185161|-1;
 BR=01201311R171S39rulernew2018_352553_221103; CH=green; DM=|CONTINUE|false|;
 DS=SPAM|spam_ad|0.839017-0.000101946-0.160881; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047190; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6NpUjh_1690945096; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6NpUjh_1690945096) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 10:58:18 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in dcn315_smu.c
Date: Wed,  2 Aug 2023 02:58:14 +0000
Message-Id: <20230802025814.10569-1-sunran001@208suo.com>
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
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 925d6e13620e..3e0da873cf4c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -33,28 +33,26 @@
 #define MAX_INSTANCE                                        6
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
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } } } };
 static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0, 0 } } } };
 
 #define regBIF_BX_PF2_RSMU_INDEX                                                                        0x0000
 #define regBIF_BX_PF2_RSMU_INDEX_BASE_IDX                                                               1
-- 
2.17.1

