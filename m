Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233A0C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E0310E609;
	Tue, 10 Jan 2023 16:57:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A64A10E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdjEijP/yY2v/sLjImxjYJbMX34O3s2kqKCfX3izuD5F/WzMKhSBn+RkiVRnHUuv5U29qiC4dzyIrQKXhZN2X4tFjCo8F560v++isXTZYma3UkV8YJbWlyf2QDgPBNWXEoQsXfAzTGo7+9xRzMW2KmOyLaUoW73PCcHWZTTKNxU5RimjXk9gmMd8JvDJmRDvXfJwEfOMvSSqfdZYrt+HA3u6UDjxZVcMBGfa4s12PzGyAd5whA03QH/rUzJ24vDnqodoxTBKbvVOQcNossbKL6sq6ZbX+cQF4NC9H4W8q4GepImkDq3qKUAHWSqymo6bKJTv36P5rq3tALmSIn2yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaGhJ26ZhMzJDJ880HmjkvLTul9vQorV7BPmvmmeaYo=;
 b=TUccW44IS52hloKv5ygSV5pkVDo+DuNyDpJ8His6OiSkFvDcMCN8mVcB+BwS/uQk+Ouf9VzbHdZHACx0AU9CvWefTGjpeQCptP3nMJWZ98ixf7Sn3MmQfj7mkNxMgwIhA0ZJPujgiSl8ZW896t9olvWIUGpKYW3c+wjDMyV5FSPk9F92B77Tn0h0OZ6GFp2qFPAtEahktwUU4+ts2bIJI1RBtPXHHoe74sQ2S8zkcEA2aNznyu1rhBPQv9WYV/AiVHuuRtBcnaP7NLNtxqFXw0lj5p6HikxdmnZFC7KXGEdX3r3sFgQqLD0pUU5CdwzBU3ojrOvl5ubB02Wyp7AHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaGhJ26ZhMzJDJ880HmjkvLTul9vQorV7BPmvmmeaYo=;
 b=iFgwGLBf0hGmFG7o0RQHt0D+1uxo2uhEPB6sgsJkgGlkMYmNwRDEX6bYAMJ/+J7VZostUjAcY/4c5LhRsAAeUjPj/ENWMMmMk8THX2ylI61wJ3bHBPQtOw/J9Z8EDEr+zraZh52JZ4qOwLozu+mfI/Fvy0rmkPYSQIf39jLkjt8=
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:09 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::48) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:09 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:07 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/37] drm/amd/display: move dpcd logic from dc_link_dpcd to
 link_dpcd
Date: Tue, 10 Jan 2023 11:55:06 -0500
Message-ID: <20230110165535.3358492-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BY5PR12MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b5723d-3cc3-4d9e-2e53-08daf32bb663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZuZBxASnvJ2+sHrfS6VK8Umyv/xdFznbDBz5XljVray3Wr2sPPm6p1vnXRRToDrFG/xDaVK2iI6O9YVzHw8DPmFxnz7A7Kgjxa+t/luqaqDnNX++kAd/NLzf5l+Z0aSACz/nqnG+/AkXE9wk68cVJbi3PHyLycAS5qvx7JYvoolM5jaRVLLEBwnIAXyCn2fF8jNe+Wrdk1CGYx+q+Plxqi8enACE8q17LFpQ2uQuyUjEuNaXmaeVuzyQUjca4U5+xxrABFkOH35ct2sip5iTtLV9ixlbzWi2nDrFfWKcU7SsAhZtISm5rAOzpSO/mtVqLInsfgZrvi2NPA4gEQ61qR//dQtYr+y6WvDs782I7cd8M3sGAhMtKGbTQzkN2CoXlIx2AOCOwd994mvlMcQzU2OziIF0919TdG6W9rz6FcYAEr3ffGhMHxlBmCInyknf+D98G2DVNoWaEsg5hEDAuUzGkY8x9ezQBVrz5mqdoCLojYOafhdxhd7Kt1KRhkByZEeL90e6Ko5EqNtCa0kZD9mVmknK0CAukU5pevAAZJGYco/ly8OOQb7bxSouo2UvrQE3iTs6rzCCgyDq/8PS6cpovMDBG7J7ztiptK0NYfFKpgKBgZgPmEwv1M08DU3+pJry1zBtgwFd70cOh0Z85Kng36f4ny44c2GAOfQRn1bLtYzc6PGuVKux8Cf01LbZs9+5ntid8VqSxeaYWDN0fdQRpnS//evke2aaXr48Ns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(30864003)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(54906003)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:09.4036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b5723d-3cc3-4d9e-2e53-08daf32bb663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Moving dpcd logic from dc_link_dpcd to link_dpcd as part of link file
restructure

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile             |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c  |  2 +-
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c |  1 -
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |  1 -
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_stream_encoder.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c  |  1 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c  |  1 -
 .../display/dc/dcn314/dcn314_dio_stream_encoder.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c    |  1 -
 .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.c |  2 +-
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile        |  2 +-
 .../dc/{core/dc_link_dpcd.c => link/link_dpcd.c}    | 13 ++++++++-----
 .../drm/amd/display/dc/{inc => link}/link_dpcd.h    |  4 +---
 18 files changed, 19 insertions(+), 24 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpcd.c => link/link_dpcd.c} (97%)
 rename drivers/gpu/drm/amd/display/dc/{inc => link}/link_dpcd.h (95%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 4438f3c16636..c5b7bcba5a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -66,7 +66,7 @@ include $(AMD_DC)
 
 DISPLAY_CORE = dc.o dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
 dc_surface.o dc_link_dp.o dc_debug.o dc_stream.o \
-dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
+dc_link_enc_cfg.o dc_link_dpia.o
 
 DISPLAY_CORE += dc_vm_helper.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b5572f5202ca..b20dde4b05d5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -51,7 +51,7 @@
 #include "dmub/dmub_srv.h"
 #include "inc/hw/panel_cntl.h"
 #include "inc/link_enc_cfg.h"
-#include "inc/link_dpcd.h"
+#include "link/link_dpcd.h"
 #include "link/link_dp_trace.h"
 #include "link/link_hpd.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 815652da4126..9f2f10a957f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -50,7 +50,7 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 	link->ctx->logger
 #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
-#include "link_dpcd.h"
+#include "link/link_dpcd.h"
 
 #ifndef MAX
 #define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index d130d58ac08e..e1db05966d83 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -33,7 +33,7 @@
 #include "link_hwss.h"
 #include "dm_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
-#include "inc/link_dpcd.h"
+#include "link/link_dpcd.h"
 #include "dc_dmub_srv.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 358431f0d98a..833a1c37cbe4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -55,7 +55,6 @@
 #include "audio.h"
 #include "reg_helper.h"
 #include "panel_cntl.h"
-#include "inc/link_dpcd.h"
 #include "dpcd_defs.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index fe2023f18b7d..c1d4e66b413f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -57,7 +57,6 @@
 #include "dc_trace.h"
 #include "dce/dmub_outbox.h"
 #include "inc/dc_link_dp.h"
-#include "inc/link_dpcd.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 484e7cdf00b8..1527c3b4fb19 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -28,7 +28,7 @@
 #include "dcn10_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "inc/link_dpcd.h"
+#include "dc_link_dp.h"
 #include "dpcd_defs.h"
 #include "dcn30/dcn30_afmt.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 20c85ef2a957..c2066a5057e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -52,7 +52,6 @@
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "hw_sequencer.h"
-#include "inc/link_dpcd.h"
 #include "dpcd_defs.h"
 #include "inc/link_enc_cfg.h"
 #include "link_hwss.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index b40489e678f9..cacf3f5298b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -29,7 +29,7 @@
 #include "dcn20_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "inc/link_dpcd.h"
+#include "dc_link_dp.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 8c5045711264..7360b3ce4283 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -51,7 +51,6 @@
 #include "../dcn20/dcn20_hwseq.h"
 #include "dcn30_resource.h"
 #include "inc/dc_link_dp.h"
-#include "inc/link_dpcd.h"
 
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 165c920ca776..3b354f0db2a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -46,7 +46,6 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "dc_link_dp.h"
-#include "inc/link_dpcd.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 0926db018338..9c9875368bea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -30,7 +30,7 @@
 #include "dcn314_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "inc/link_dpcd.h"
+#include "dc_link_dp.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index a0741794db62..edc2c08939b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -48,7 +48,6 @@
 #include "dce/dmub_outbox.h"
 #include "dc_link_dp.h"
 #include "inc/dc_link_dp.h"
-#include "inc/link_dpcd.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 7d09c62a405a..f01968f6d182 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -29,7 +29,7 @@
 #include "dcn32_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "inc/link_dpcd.h"
+#include "dc_link_dp.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 6c4b47f90d49..906a43e85f6d 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -32,7 +32,7 @@
 #include "core_types.h"
 #include "link.h"
 #include "link_hwss.h"
-#include "inc/link_dpcd.h"
+#include "link/link_dpcd.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index d1b1bb3c5352..b905c53e738b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -24,7 +24,7 @@
 # PHY, HPD, DDC and etc).
 
 LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o \
-link_hpd.o link_ddc.o
+link_hpd.o link_ddc.o link_dpcd.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/link_dpcd.c
similarity index 97%
rename from drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
rename to drivers/gpu/drm/amd/display/dc/link/link_dpcd.c
index af110bf9470f..5c9a30211c10 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpcd.c
@@ -23,11 +23,14 @@
  *
  */
 
-#include <inc/core_status.h>
-#include <dc_link.h>
-#include <inc/link_hwss.h>
-#include <inc/link_dpcd.h>
-#include <dc_dp_types.h>
+/* FILE POLICY AND INTENDED USAGE:
+ *
+ * This file implements basic dpcd read/write functionality. It also does basic
+ * dpcd range check to ensure that every dpcd request is compliant with specs
+ * range requirements.
+ */
+
+#include "link_dpcd.h"
 #include <drm/display/drm_dp_helper.h>
 #include "dm_helpers.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h b/drivers/gpu/drm/amd/display/dc/link/link_dpcd.h
similarity index 95%
rename from drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
rename to drivers/gpu/drm/amd/display/dc/link/link_dpcd.h
index d561f86d503c..27b08cdbb4a1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpcd.h
@@ -25,9 +25,7 @@
 
 #ifndef __LINK_DPCD_H__
 #define __LINK_DPCD_H__
-#include <inc/core_status.h>
-#include <dc_link.h>
-#include <dc_link_dp.h>
+#include "link.h"
 
 enum dc_status core_link_read_dpcd(
 		struct dc_link *link,
-- 
2.39.0

