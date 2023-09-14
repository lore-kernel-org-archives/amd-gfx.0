Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB70EEE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABA610E315;
	Thu, 14 Sep 2023 02:02:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E41410E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cttwk0dqcRq32epDgXsNL5ndJTYFGtPFjfwwpa1eHcbtnPM9mvgvywmZCNRLI3MjW4VGhzknrVwKbWFIXOzWIT1RxJFXjTNhInJyXwnGb3cJqImdQryw/WBWZE+swlq70V4XUqYR+QLKiZ67UpLL3naShALqx1smwPGkHfzgV3w6f1/xP94jeyPmHN2IOYJHScxebVDr0ioeHRGg7R9afHLWrXwDQV5eEBI3kpvKAg5bvpEfTzvYLLboSpMyL7NCrysQH94VP9Is8J2Kc/1RYaYWgadTDDIJ+GTHJdW7R9pcf7btIS9TyUcXdCkmMS1fAbgr3JVLAOr2MLuRcMFyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omeEXgjarVC5ZiFlL2V83j6KFzWQexFfXB+Y48LDB2M=;
 b=RWybcwZJiUlBdOAzFyVQsjeuKh+2gzjZsQELQauxakcUZrx+MrL5WnmuprCIqi996F/SUtX8hIcyzIeZm7EiVnC3zvFmSKZ3pD0252rEaoWMOkym9Y/udHM7Q59OcocCHDVr2U+ymO9g9FXQI9Wah49cU6HLRAGSiVG9RU4pXBLNSVpamsaCdwGtVy8ukyC0YZvzZ7GYZ540wmFMpMXND8jl9x8MhgE8GnRcQVi4RGQZZo0PiSTvRyTFKMsWxfxYLzliUE2Q5OP/T+AX+1EOfJlJVpsOjZIwGesFz7r4QorA/HtRaoQifFwGEVFSqHmtRgRotJEeP4iOwM3uv9C9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omeEXgjarVC5ZiFlL2V83j6KFzWQexFfXB+Y48LDB2M=;
 b=aXppvkhm12FCP2kYRqWmLglveI64c1UMlHC9+HttkBYtI5M69CQlrYrDMYGPzUdLM1/cPegHLtRueT0fkcFzr/M/UVfhRfUqdfN3a9uP1VPjOO5RX75ngdRJMPRDYgJNSSKEFbmHLmcxexgpAAIvwldDGbU+bVM2PoT7C9PBZh8=
Received: from PA7P264CA0162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::16)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:01:58 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:36c:cafe::c6) by PA7P264CA0162.outlook.office365.com
 (2603:10a6:102:36c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/28] drm/amd/display: fix some non-initialized register mask
 and setting
Date: Wed, 13 Sep 2023 20:00:12 -0600
Message-ID: <20230914020021.2890026-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a37ffc-fae7-4c81-f2fa-08dbb4c6932b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1160aj/1RMi56AoP081X0BBHHXBkUUT0NjFqpGn9xy4Qt9UeEd8Oq9J/X+asU+2zPdfIJZI7S8JR7EZBX+uJxNHH47zfW97fhR2DRE7tbhXIm9MAVUrvWewptP7JasxZHkeGIlo2z/CSZEcrAbb4UbyguCFoeH6QXEuMFQokCi4oMB3fm32/tEo96V98HsQ01IItS5/cE8mxmnsLNzWrlphXAMFQpF1rFs/U+KGIMgKpmCzHJT8AO04oWTzwmjEV2PE1EEFGmyhAdYIcfTKkaZg6iDik3DVJ/S8S9YlVrKt7PctrzYG3J8D5QC6deDDJhdFIpMw0NM2gI0kAuXhDsJIYhsCbx2VLmDFac48HBUujiAiG6z2Sx66zwhepxrODC8XdLvNicbfmB8r5Zhi/r033yqTBuziEQt4mdkt8AMT1F0UXjQsngTOf17vA1aPvTi38OuP8Y8GLLihdJp4Mv6Yphh6OXfVlsGaqrFmYo1Mlvctv26IMynhnmRSl1xfZanulWE8dsRJGMtLmPkSaY480XcJX3EQC7fh1KE7va1pRpqSfmg3IVT/wP0wHcmdMmia3m4U/s+1+akJ8jvnroeO5AjFjayXu5GdQEJ8eIOdzRLLKguY3kd9JY1yfTL8BWBlS8ks78tLU6CJjixXsigTEyAjj1NISZpbRpZl/79WDr4OaAce52FDV1cPlUThrrGEw0GSJ0eKBITU0hEVO8NTS9BLNdmeHPolfOA/iVyc5ScceTHIR2sUSvTwgATYob3yzuvcbYg2fM+3i2zKorQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(86362001)(36756003)(40460700003)(356005)(81166007)(40480700001)(36860700001)(336012)(16526019)(30864003)(1076003)(2906002)(426003)(83380400001)(2616005)(26005)(478600001)(4326008)(5660300002)(8676002)(41300700001)(8936002)(47076005)(70206006)(6916009)(316002)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:56.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a37ffc-fae7-4c81-f2fa-08dbb4c6932b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
fix some non-initialized register mask and update goldn setting

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   8 +-
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |   9 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h | 151 +-----------------
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  13 +-
 6 files changed, 33 insertions(+), 160 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index 5ddf2b36986e..4201b7627030 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -177,6 +177,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_SDPIF_CFG1;
 	uint32_t DCHUBBUB_CLOCK_CNTL;
 	uint32_t DCHUBBUB_MEM_PWR_MODE_CTRL;
+	uint32_t DCHUBBUB_ARB_QOS_FORCE;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -199,8 +200,9 @@ struct dcn_hubbub_registers {
 		type MALL_PREFETCH_COMPLETE;\
 		type MALL_IN_USE
 
-#define HUBBUB_REG_FIELD_LIST_DCN35(type) \
-		type DCHUBBUB_FGCG_REP_DIS
+ #define HUBBUB_REG_FIELD_LIST_DCN35(type) \
+		type DCHUBBUB_FGCG_REP_DIS;\
+		type DCHUBBUB_ARB_ALLOW_CSTATE_DEEPSLEEP_LEGACY_MODE
 
 /* set field name */
 #define HUBBUB_SF(reg_name, field_name, post_fix)\
@@ -396,7 +398,7 @@ struct dcn_hubbub_mask {
 	HUBBUB_HVM_REG_FIELD_LIST(uint32_t);
 	HUBBUB_RET_REG_FIELD_LIST(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN32(uint32_t);
-	HUBBUB_REG_FIELD_LIST_DCN35(uint8_t);
+	HUBBUB_REG_FIELD_LIST_DCN35(uint32_t);
 };
 
 struct dc;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index a0dc2e0c79c1..f8e63bd541bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -66,7 +66,7 @@ static void dcn35_init_crb(struct hubbub *hubbub)
 	REG_SET_2(COMPBUF_RESERVED_SPACE, 0,
 			COMPBUF_RESERVED_SPACE_64B, hubbub2->pixel_chunk_size / 32,
 			COMPBUF_RESERVED_SPACE_ZS, hubbub2->pixel_chunk_size / 128);
-	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
+	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x5FF);
 }
 
 static void dcn35_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
@@ -319,8 +319,10 @@ static bool hubbub35_program_watermarks(
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
-	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
-			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0xFF);/*hw delta*/
+	REG_UPDATE_2(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0xFF,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, 0xA);/*hw delta*/
+	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
 	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
index dc7331dc3b65..d57ed580305e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
@@ -104,7 +104,9 @@
 	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D),\
-	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D)
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D),\
+	SR(DCHUBBUB_ARB_QOS_FORCE)
+
 
 #define HUBBUB_MASK_SH_LIST_DCN35(mask_sh)\
 	HUBBUB_MASK_SH_LIST_DCN32(mask_sh), \
@@ -135,7 +137,10 @@
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, mask_sh), \
-	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh)
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_CSTATE_DEEPSLEEP_LEGACY_MODE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, mask_sh)
 
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
index 3addd66ed01b..a8879c3db447 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
@@ -26,9 +26,9 @@
 #define __DC_HUBP_DCN35_H__
 
 #include "dcn31/dcn31_hubp.h"
-
+#include "dcn32/dcn32_hubp.h"
 #define HUBP_MASK_SH_LIST_DCN35(mask_sh)\
-	HUBP_MASK_SH_LIST_DCN31(mask_sh),\
+	HUBP_MASK_SH_LIST_DCN32(mask_sh),\
 	HUBP_SF(HUBP0_HUBP_CLK_CNTL, HUBP_FGCG_REP_DIS, mask_sh)
 
 #define DCN35_HUBP_REG_FIELD_VARIABLE_LIST(type)          \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
index 39d3f342ba63..7e7a5f4b85b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
@@ -26,114 +26,10 @@
 #define __DC_OPTC_DCN35_H__
 
 #include "dcn10/dcn10_optc.h"
-
+#include "dcn32/dcn32_optc.h"
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_5(mask_sh)\
-	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
-	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_OFFSET, mask_sh),\
-	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_WIDTH, mask_sh),\
-	SF(OTG0_OTG_VREADY_PARAM, VREADY_OFFSET, mask_sh),\
-	SF(OTG0_OTG_MASTER_UPDATE_LOCK, OTG_MASTER_UPDATE_LOCK, mask_sh),\
-	SF(OTG0_OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_START_X, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_END_X, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_START_Y, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_END_Y, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL2, OTG_MASTER_UPDATE_LOCK_SEL, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_X, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_Y, mask_sh),\
-	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
-	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
-	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
-	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_START, mask_sh),\
-	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_END, mask_sh),\
-	SF(OTG0_OTG_H_SYNC_A_CNTL, OTG_H_SYNC_A_POL, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL, OTG_V_TOTAL, mask_sh),\
-	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_START, mask_sh),\
-	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_END, mask_sh),\
-	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_START, mask_sh),\
-	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_END, mask_sh),\
-	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_A_POL, mask_sh),\
-	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, mask_sh),\
-	SF(OTG0_OTG_CONTROL, OTG_MASTER_EN, mask_sh),\
-	SF(OTG0_OTG_CONTROL, OTG_START_POINT_CNTL, mask_sh),\
-	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
-	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
-	SF(OTG0_OTG_CONTROL, OTG_OUT_MUX, mask_sh),\
-	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
-	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
-	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
-	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EYE_FLAG_POLARITY, mask_sh),\
-	SF(OTG0_OTG_STEREO_CONTROL, OTG_DISABLE_STEREOSYNC_OUTPUT_FOR_DP, mask_sh),\
-	SF(OTG0_OTG_STEREO_STATUS, OTG_STEREO_CURRENT_EYE, mask_sh),\
-	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_EN, mask_sh),\
-	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_V_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_STEREO_SEL_OVR, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_MIN, OTG_V_TOTAL_MIN, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MIN_SEL, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MAX_SEL, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_FORCE_LOCK_ON_EVENT, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_SET_V_TOTAL_MIN_MASK, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MIN_EN, mask_sh),\
-	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MAX_EN, mask_sh),\
-	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_CLEAR, mask_sh),\
-	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_MODE, mask_sh),\
-	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_OCCURRED, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_SELECT, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_PIPE_SELECT, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_RISING_EDGE_DETECT_CNTL, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FALLING_EDGE_DETECT_CNTL, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_POLARITY_SELECT, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FREQUENCY_SELECT, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_DELAY, mask_sh),\
-	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_CLEAR, mask_sh),\
-	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_EVENT_MASK, mask_sh),\
-	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_FRAME_COUNT, mask_sh),\
-	SF(OTG0_OTG_STATUS_FRAME_COUNT, OTG_FRAME_COUNT, mask_sh),\
-	SF(OTG0_OTG_STATUS, OTG_V_BLANK, mask_sh),\
-	SF(OTG0_OTG_STATUS, OTG_V_ACTIVE_DISP, mask_sh),\
-	SF(OTG0_OTG_STATUS_POSITION, OTG_HORZ_COUNT, mask_sh),\
-	SF(OTG0_OTG_STATUS_POSITION, OTG_VERT_COUNT, mask_sh),\
-	SF(OTG0_OTG_NOM_VERT_POSITION, OTG_VERT_COUNT_NOM, mask_sh),\
-	SF(OTG0_OTG_M_CONST_DTO0, OTG_M_CONST_DTO_PHASE, mask_sh),\
-	SF(OTG0_OTG_M_CONST_DTO1, OTG_M_CONST_DTO_MODULO, mask_sh),\
-	SF(OTG0_OTG_CLOCK_CONTROL, OTG_BUSY, mask_sh),\
-	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_EN, mask_sh),\
-	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_ON, mask_sh),\
-	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_GATE_DIS, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_START, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_END, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT1_POSITION, OTG_VERTICAL_INTERRUPT1_LINE_START, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE, mask_sh),\
-	SF(OTG0_OTG_VERTICAL_INTERRUPT2_POSITION, OTG_VERTICAL_INTERRUPT2_LINE_START, mask_sh),\
-	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_EN, mask_sh),\
-	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
-	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
-	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
-	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
-	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
-	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
-	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
-	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_OCCURRED, mask_sh),\
-	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_CLEAR, mask_sh),\
-	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_AUTO_FORCE_VSYNC_MODE, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL0_EN, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL1_EN, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL2_EN, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_EN, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
-	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
-	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
-	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	OPTC_COMMON_MASK_SH_LIST_DCN3_2(mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_WINDOW_DB_EN, mask_sh),\
-	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
-	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
-	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
 	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC1_DATA_B,  CRC1_B_CB, mask_sh),\
@@ -143,14 +39,6 @@
 	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC3_DATA_B,  CRC3_B_CB, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_START, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_END, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_START, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_END, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_START, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
-	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
@@ -175,41 +63,6 @@
 	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL_READBACK, OTG_CRC1_WINDOWB_X_END_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_START_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_END_READBACK, mask_sh),\
-	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
-	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
-	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
-	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
-	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
-	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
-	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
-	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
-	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
-	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
-	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
-	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
-	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
-	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
-	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
-	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
-	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG3_SRC_SEL, mask_sh),\
-	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
-	SF(ODM0_OPTC_MEMORY_CONFIG, OPTC_MEM_SEL, mask_sh),\
-	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, mask_sh),\
-	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DSC_MODE, mask_sh),\
-	SF(ODM0_OPTC_BYTES_PER_PIXEL, OPTC_DSC_BYTES_PER_PIXEL, mask_sh),\
-	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_DSC_SLICE_WIDTH, mask_sh),\
-	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_SEGMENT_WIDTH, mask_sh),\
-	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_START_X, mask_sh),\
-	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
-	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
-	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
-	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
-	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
 	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh)
 
 void dcn35_timing_generator_init(struct optc *optc1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 47de1fadf364..7fa1172b98d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -579,6 +579,14 @@ static struct dce_hwseq_registers hwseq_reg;
 	HWS_SF(, DOMAIN18_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
 	HWS_SF(, DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
 	HWS_SF(, DOMAIN19_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	HWS_SF(, DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	HWS_SF(, DOMAIN22_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	HWS_SF(, DOMAIN23_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	HWS_SF(, DOMAIN23_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	HWS_SF(, DOMAIN24_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	HWS_SF(, DOMAIN24_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	HWS_SF(, DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	HWS_SF(, DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
 	HWS_SF(, DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
@@ -587,6 +595,10 @@ static struct dce_hwseq_registers hwseq_reg;
 	HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	HWS_SF(, DOMAIN22_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	HWS_SF(, DOMAIN23_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	HWS_SF(, DOMAIN24_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	HWS_SF(, DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh), \
 	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
 	HWS_SF(, HPO_TOP_CLOCK_CONTROL, HPO_HDMISTREAMCLK_G_GATE_DIS, mask_sh), \
@@ -1834,7 +1846,6 @@ static bool dcn35_resource_construct(
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.40.1

