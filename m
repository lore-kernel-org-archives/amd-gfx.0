Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A346DE7B5E0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3921610E355;
	Wed,  4 Oct 2023 09:24:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCDA10E355
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdfzTDUBAo/VqXD754reWtO1QYi0URqjmY+z6BU+Ht+b1/Ov++BcuBzNGwfSNTArPBITejkQ4/51juwdxnG9ghfteDx/w1yGG73ruyOKkCGZa3uWV8Fsxs4yWKOB7SV3/dKCWlbrMLMsj/yWrdNRpJj+P2vjw5qRPW7cQT+3lCzte0Wsc0fVWFngC8OTppyvAsH1DmAZMfjqkxtxrX+NKOvocMCQLoYnYoHSqXshPkdTw35LU0VGwjv3NzKrm1ObYDMozxFJIt0uta9JCylFWbvK1a1RJ8QkDOV7f9BWnDDOXpeg4CfLchXSiaukctA9AnYFsihxD2MKQIGNVI5rFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6OoLeH0FMi7vRyPVrNHRZldc36a4z+7O6LL9Yy9pew=;
 b=OsdgYPkd1FLhg8GojYV5VoCbm2QOurIBNhrntYOU6ksjFULy7aPp1Gx6Q3bmRBv6lsdRfjKt5GSQs9WBt5FSy+nduGQ+1AN4BxsDNAI53egpTA5KyjEXMZMLHyXSgOqq+pxDA8h0b3fv64LCwDzB99nDwvuU5ZnQHnxtm9xT50PspBfDl9+GDsRbG2GM5aUUAIYuaYzTuax4F2p9hagToDZYXod1NkZgCUdePoVn3EUY393nzFPlrFeZ0da5cEIgWgyqf1rCYa4w0hqCeWRYT6JBvs5qn5Lw7F5TLIjCR+srBkZgILAvNU8oUl9FbJtdQVUmKKrOzazGCsNG6Z7Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6OoLeH0FMi7vRyPVrNHRZldc36a4z+7O6LL9Yy9pew=;
 b=1eRwCnUVOxrILNbxWTjhcmWFxRYboEGqcgReOE5dAHlrIuGSoIyXY5b65pi6kOWuaP3WqWoKhqEqR4op/0qOvZabwrT6scGn/QzVy3Uw6PQ4OiPb1//Bc1GMrEiD5SaZi5NhuMIWMJYO80qad2Q/g1cstqB8+ZJcpYi+/U7jG0w=
Received: from MN2PR01CA0014.prod.exchangelabs.com (2603:10b6:208:10c::27) by
 CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.34; Wed, 4 Oct 2023 09:24:30 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::fb) by MN2PR01CA0014.outlook.office365.com
 (2603:10b6:208:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:26 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Revert "drm/amd/display: Add a check
 for idle power optimization"
Date: Wed, 4 Oct 2023 17:22:56 +0800
Message-ID: <20231004092301.2371458-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH2PR12MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c263e3-fd44-4dd1-3642-08dbc4bbb677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVqXeIl33QMYanUpbQygjZKoleYTwKZYTWNB/WQ9sp8PkOj6Gz8FsBxB+vcB4bZ5fOjQX2yiIYSTmSoP6eyJmwxx8OTWIaX878nVSZRvJzewBbtE7TQiDsTDQq882z10X2tDCt3kAJa8QS0YZYidsMnTKmyyeCOC9CjH7f8zCv+luO8s8aA1XqJhMk3HBFdFrITnVXPmCFEbKoCDK74Ag4BWq473bOW24rOaDOCDszatXf6Fpflt76VXkyGqHAN2kG3fvtQfco9EvE1ml29JX9iclW5mpQQ42XoCsKcuqJ0hBvNC6rrKP81urzh2Oyouy//D8Spfal1gx9Y0u3T46mSFO/LjnzAUg0fRh2TEr29S1ykRMD1JWPQbsLZNzR/+jnCkgNG7yRKK1qgnR+eJ5idBHhgMERuHpOQQItxG//W00XGgzwFY5P6WqwYjaiP/C5m6/B10h7KIMkOkf//sivUbr1rmDvY3YG17YgD4R766K6gSzcVfeAV5D0B2DQU7qmOq4tYkbg9vbpuI8Ze2/Jsbznrggk0e5Ffk92eSYOjB7aIHGPMYAicrbD33txcancaIm3CVRgkwnRgtMeUZhIyp9pczacgHFIxJKCDWPQiC7SWqQ4KrRj1sPn/KATdLvYPvzFwhnjfRCulC+6vLRVuD+XwinzepOmm8wFDdXkd/hQV41b2K/5mQBkPV/qelBkH5PfIfDK6L45CjFPIB7+4Jk5Pti0rB0jrrUUPcuLu/vTmBRuf6uTYBfI+47pE1mOTyOKC1JhoKkQTmtpYVCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(336012)(426003)(2906002)(36860700001)(40480700001)(40460700003)(47076005)(6666004)(82740400003)(356005)(478600001)(7696005)(86362001)(81166007)(36756003)(26005)(1076003)(8676002)(8936002)(4326008)(70586007)(54906003)(70206006)(6916009)(316002)(41300700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:30.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c263e3-fd44-4dd1-3642-08dbc4bbb677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

Revert commit 0ca0151b9902 ("drm/amd/display: Add a check for idle power optimization")
Because it cause Freesync and S4 regression

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 +------------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 623f4ac0bf42..bd4834f921c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4872,8 +4872,7 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 {
-	if (dc->debug.disable_idle_power_optimizations ||
-		(dc->caps.ips_support && dc->config.disable_ips))
+	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
@@ -4887,23 +4886,6 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
-bool dc_is_idle_power_optimized(struct dc *dc)
-{
-	uint32_t idle_state = 0;
-
-	if (dc->debug.disable_idle_power_optimizations)
-		return false;
-
-	if (dc->hwss.get_idle_state)
-		idle_state = dc->hwss.get_idle_state(dc);
-
-	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
-		(idle_state & DMUB_IPS2_ALLOW_MASK))
-		return true;
-
-	return false;
-}
-
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6c51ebf5bbad..41c77910f046 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2359,7 +2359,6 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
-bool dc_is_idle_power_optimized(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index e43e8d4bfe37..b99db771e071 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -352,7 +352,6 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
-			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
 
 	default:
-- 
2.25.1

