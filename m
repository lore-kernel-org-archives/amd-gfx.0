Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B74C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39A161283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D39A161283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5A16E41D;
	Fri, 19 Nov 2021 19:44:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525B96E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4KVRhNYURv9div0+B0zlPWwiz7Ad4MOrPGehoFW0VLhYO1xYPuSq8VJSfW086q6jWwZ+S2eJWH5CIlBUBzaQIUE9sY7u4f0F4DhNHDXwsOB2BeiyJEqI1Qd/TnXd9FuJKh8UkIgh5hgOggaj3sPYt4uz6CY9mLNeJltyGXYzS5MGMfisa78Qgi8Pg5JVMxwjcYvmJ8Eq7+5OW1fwj9ysv1zIw8CnwMP2SJwRruejBupnuPKPY4gHzPmylIoR4CwZwYLRoHB2bqMgVtPhgQ2rCe/1kjYoo/B4e1MNwJKmGTPlKF+8isNuljY3r779MCuMFP4IEjm5JehW7f3vh+b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEWmDbX7jtIX2kxqYWc77qgExr7v+HwsSwsXm09lU18=;
 b=HSiBDU03fLjZ9VKAoLgOY4SwzMbcbCpWgI7BkZISjrnTTSnmw7kdY061XtYSRnLNgcIs4509D9gb5Azo6e6+4Zk+U1l6ZSUvLPtlvs88rgJ2zRJaBHoMHcK2FaLQvqPsrSdKUlpBltvSoI6xdBPKBvEmjCnEGlz0t7JB0dZjwa87RpiD59/JRAyE2G3vJKhOBJKK/j0IEQWBfkT8zmsmD0QwwkX8MP2+sZHYpnRJRWuTl/TjyTMMqWc0plPKXcZVa4Ut3rjyuELbNUvAGR4NYyD1OJqBU8+euEI6Mfs6laSargubKUny2QGLqNqFBp80OURTPOsc2Ymf7rSImD50vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEWmDbX7jtIX2kxqYWc77qgExr7v+HwsSwsXm09lU18=;
 b=YKfwNHbF6zobH2GzRBpbh0ejU+Qltsyqdvm7oVTmkkX8ACZnrQ+u+ggf/P/Be97PLdI+fkI1X76yLK+0+wXJQR+oQrvoSJXfAT4ZZ3wx931qNGTME0TPCJn3O7IvQ1yT4PmfCAOW0m5twFwArUK+E8QMuhjlPtpkW2CTNLJQBOU=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:44:00 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ef) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:56 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Rename dcn_validate_bandwidth to
 dcn10_validate_bandwidth
Date: Fri, 19 Nov 2021 14:43:31 -0500
Message-ID: <20211119194339.97573-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd217fc5-c1e7-45a0-30dd-08d9ab94eef3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1840951CFD860800A4B25E9CFB9C9@MWHPR12MB1840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW3N3GVnrnlpPAoaUzjZL8jpT0qU8DjGd27BUE2FsXmZRASpKgZs2VCB/O//ZWW3seDdAfVfad2g4Ddj/8Eke4oPvE7aPcR1IlGQ0t5bw5+0k8JFbbiAtvU2PHE+24KCW8MD9x2lxeMUwl4cGyy9hqY+OXclaA54G9wIvummzAgC87QpBwPUOG2EIi6zB+lxbxX0gcH0A87Oa7DXWk+ch7UoEK9xI0goNY/xSEqEo0644JXBJRmfavr5sYvcmB4VX15s4/6NN4dCbC91xXF6ySJoBVkr+j9qn5ZL6R/nmF9Qw6wrucAYW0TA+C8ZATzYxuYsx8j+GrlGq5KqG4e/MT6r/DQAWlEGNB3NEHLt2eF3y4+lUmQDA7nKNw4/bwsOW3fZs5WCnQhnO4KMptdttLpTkd1fB1vi4HxT+KZ5BNqlfL0ECNWDwF6DpHCHAoAMQj7kGntO5st7opCm6V8a8i2H6O5G+kGj4S1gWlHKjTJCWrsO8+4n1ilXXGwxfFF9nq+WMas2qOEv91nCP+2CmzGYXP0qZ6eGGrW9Z/BjYZKiLiHOGCJ+jcIMbDIHQJoeQDic0sXWOinwIbeCMIe80DpZxcSk6a9WDfb9YrUSBv3mo82wiNMxIqxkiU2xkkhOxVrZF/yFOPV7H8oJxSukAp77uOmaQjVPYPT4SKhb6BXtMW8vwXGxWVVPp+oCWPUYT85Ml1ztRTvGzEaISHV9ti1/kuK+LybiA1dRmqcyLLw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(47076005)(5660300002)(70206006)(86362001)(356005)(82310400003)(81166007)(70586007)(16526019)(36756003)(426003)(36860700001)(316002)(336012)(2616005)(508600001)(54906003)(6916009)(2906002)(8936002)(8676002)(1076003)(6666004)(26005)(4326008)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:00.0471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd217fc5-c1e7-45a0-30dd-08d9ab94eef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: stylon.wang@amd.com, Zhan Liu <Zhan.Liu@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Ahmad Othman <Ahmad.Othman@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <Zhan.Liu@amd.com>

[Why]
Rename function name so it aligns with other resource
function names being used by dcn10.

[How]
Rename function name for consistency.

Reviewed-by: Ahmad Othman <Ahmad.Othman@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 6b248cd2a461..c8b0a2f05b4d 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -763,7 +763,7 @@ unsigned int get_highest_allowed_voltage_level(uint32_t chip_family, uint32_t hw
 	return 4;
 }
 
-bool dcn_validate_bandwidth(
+bool dcn10_validate_bandwidth(
 		struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c50427bfab77..d342c04f5f30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2626,7 +2626,7 @@ static void dcn10_update_dchubp_dpp(
 		/* new calculated dispclk, dppclk are stored in
 		 * context->bw_ctx.bw.dcn.clk.dispclk_khz / dppclk_khz. current
 		 * dispclk, dppclk are from dc->clk_mgr->clks.dispclk_khz.
-		 * dcn_validate_bandwidth compute new dispclk, dppclk.
+		 * dcn10_validate_bandwidth compute new dispclk, dppclk.
 		 * dispclk will put in use after optimize_bandwidth when
 		 * ramp_up_dispclk_with_dpp is called.
 		 * there are two places for dppclk be put in use. One location
@@ -2640,7 +2640,7 @@ static void dcn10_update_dchubp_dpp(
 		 * for example, eDP + external dp,  change resolution of DP from
 		 * 1920x1080x144hz to 1280x960x60hz.
 		 * before change: dispclk = 337889 dppclk = 337889
-		 * change mode, dcn_validate_bandwidth calculate
+		 * change mode, dcn10_validate_bandwidth calculate
 		 *                dispclk = 143122 dppclk = 143122
 		 * update_dchubp_dpp be executed before dispclk be updated,
 		 * dispclk = 337889, but dppclk use new value dispclk /2 =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index f37551e00023..6ddfb0633abb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1320,7 +1320,7 @@ static const struct resource_funcs dcn10_res_pool_funcs = {
 	.destroy = dcn10_destroy_resource_pool,
 	.link_enc_create = dcn10_link_encoder_create,
 	.panel_cntl_create = dcn10_panel_cntl_create,
-	.validate_bandwidth = dcn_validate_bandwidth,
+	.validate_bandwidth = dcn10_validate_bandwidth,
 	.acquire_idle_pipe_for_layer = dcn10_acquire_idle_pipe_for_layer,
 	.validate_plane = dcn10_validate_plane,
 	.validate_global = dcn10_validate_global,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
index 806f3041db14..337c0161e72d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
@@ -619,7 +619,7 @@ struct dcn_ip_params {
 };
 extern const struct dcn_ip_params dcn10_ip_defaults;
 
-bool dcn_validate_bandwidth(
+bool dcn10_validate_bandwidth(
 		struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
-- 
2.25.1

