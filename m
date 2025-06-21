Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95248C7115C
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Jun 2025 14:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F9C10E2C9;
	Sat, 21 Jun 2025 14:13:37 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CEE10E071;
 Sat, 21 Jun 2025 03:28:00 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bPKY83ygLz5Sft;
 Sat, 21 Jun 2025 11:27:56 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxde.zte.com.cn (FangMail) with ESMTPS id 4bPKY43qvpz4xCtT;
 Sat, 21 Jun 2025 11:27:52 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bPKXz3SVLz8R039;
 Sat, 21 Jun 2025 11:27:47 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bPKXv1QrNz51STR;
 Sat, 21 Jun 2025 11:27:43 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
 by mse-fl1.zte.com.cn with SMTP id 55L3Recj078408;
 Sat, 21 Jun 2025 11:27:40 +0800 (+08)
 (envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njy2app04[null]) by mapi (Zmail) with MAPI id mid201;
 Sat, 21 Jun 2025 11:27:42 +0800 (CST)
Date: Sat, 21 Jun 2025 11:27:42 +0800 (CST)
X-Zmail-TransId: 2afc685626aeffffffffdc3-be099
X-Mailer: Zmail v1.0
Message-ID: <20250621112742498q_NLTyjSUQoBWFl8SFHu1@zte.com.cn>
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <harry.wentland@amd.com>
Cc: <sunpeng.li@amd.com>, <siqueira@igalia.com>, <alexander.deucher@amd.com>, 
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <fang.yumeng@zte.com.cn>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <mou.yi@zte.com.cn>, <xu.lifeng1@zte.com.cn>, <ouyang.maochun@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IFVzZSBzdHJfb25fb2ZmKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 55L3Recj078408
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 685626BB.000/4bPKY83ygLz5Sft
X-Mailman-Approved-At: Sat, 21 Jun 2025 14:13:35 +0000
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

From: Yumeng Fang <fang.yumeng@zte.com.cn>

Remove hard-coded strings by using the str_on_off() helper.

Signed-off-by: Yumeng Fang <fang.yumeng@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
index af21c0a27f86..509bdb1ca9bc 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
@@ -24,6 +24,7 @@
  *
  */

+#include <linux/string_choices.h>
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn35_pg_cntl.h"
@@ -236,7 +237,7 @@ void pg_cntl35_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	}

 	DC_LOG_DEBUG("HUBP DPP instance %d, power %s", hubp_dpp_inst,
-		power_on ? "ON" : "OFF");
+		str_on_off(power_on));

 	if (hubp_dpp_inst < MAX_PIPES) {
 		pg_cntl->pg_pipe_res_enable[PG_HUBP][hubp_dpp_inst] = power_on;
-- 
2.25.1
