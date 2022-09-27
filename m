Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F4EC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8A10E362;
	Tue, 27 Sep 2022 14:41:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E1E10E93B;
 Tue, 27 Sep 2022 13:41:48 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McLMQ0fqhzHppR;
 Tue, 27 Sep 2022 21:39:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 21:41:45 +0800
From: Yuan Can <yuancan@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Jun.Lei@amd.com>, <Charlene.Liu@amd.com>,
 <jerry.zuo@amd.com>, <agustin.gutierrez@amd.com>, <Nevenko.Stupar@amd.com>,
 <sancchen@amd.com>, <tales.aparecida@gmail.com>,
 <chandan.vurdigerenataraj@amd.com>, <aurabindo.pillai@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Remove unused struct i2c_id_config_access
Date: Tue, 27 Sep 2022 13:39:08 +0000
Message-ID: <20220927133908.103658-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 27 Sep 2022 14:41:36 +0000
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
Cc: yuancan@huawei.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After commit 5a8132b9f606("drm/amd/display: remove dead dc vbios code"), no one
use struct i2c_id_config_access, so remove it.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 5d70f9901d13..d380cf98b844 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -50,13 +50,6 @@
 #define LAST_RECORD_TYPE 0xff
 #define SMU9_SYSPLL0_ID  0
 
-struct i2c_id_config_access {
-	uint8_t bfI2C_LineMux:4;
-	uint8_t bfHW_EngineID:3;
-	uint8_t bfHW_Capable:1;
-	uint8_t ucAccess;
-};
-
 static enum bp_result get_gpio_i2c_info(struct bios_parser *bp,
 	struct atom_i2c_record *record,
 	struct graphics_object_i2c_info *info);
-- 
2.17.1

