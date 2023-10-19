Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E82BCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBC310E4E5;
	Thu, 19 Oct 2023 13:33:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B4110E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV3TZqUTn8bjJ1IGnCYEQ6Fosw3mxzXWU5w/oPXb9KRdbmwOBSc324RbsSLKrSCYbyT7UzkQOup2hpI3IH4RSM56WdNcUuXlM19gC8ij0q6XhQM76ZMYvajVZ1rbPDASAVHFN/6qfhqAR1SmZ2StEEiU+WxbQgqzxRNi+L/Fn/Wh3x5bnVfBCXYUJQE2ozX7eB1GIuAv1MaglBqH5IKNSytSngt8FtkibWNNXK4kcrcwa902g8DKObSjroAuMXjKIbwDJ6pxzmIL0zRAqY9uQv+44d+xbGWGddK2U10Uh4aphBDoUTX0Mo0Nr2KQRDicTbQiNEq/YAev48IV6utLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22L0PyPJcdxeMve8d653j9qbPmhZgmvDXV80s5Q2Nrw=;
 b=NoCm2vzDiIQTIc2RiPEQ9IUMbPhPPR6ylf1szL08+Vxw2xrNJJ4GwTJRIw6K+LvNqGptEkt5Joi9hOw6sD9JCUvWhMDSKXesMo4543ke07oG7oAhn9ozOZ7dNN6WvQUYrAUZrMZcAPZYuacRhvy0XDyf+9P2+udd1mgc6EM2Bv+sjhlTVsDsrviQ6BZEN7sC6xLxzO73TzmQ+N7389m9T9Wki8m4suiH3h5vZ3gNuwo169s8LP+YepgMQMXrlfLpghSfxwmzLjZsrOIcd4nMABOTWUvBH1tt1HfBiGXq0tu5S0nAkgqy51yUPrkdHpq3JP7Eh+yKZpLwHEMEZaG4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22L0PyPJcdxeMve8d653j9qbPmhZgmvDXV80s5Q2Nrw=;
 b=WTmg2OP8X+0yoRbdx1P7u9y8G5mVcpfNNjG4yyOSikaKY214EByy5c6tdRmMPBKHHWvWT2TrNxTfRsYbOkXUplSdfFj+hi27OB1qi5dyg9JZPpDPeaPzTYyj3UGLtErpycykTqlpFAkEmoVODRrjAI9/Jx2afqM3hUFivrML8bQ=
Received: from BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) by LV8PR12MB9111.namprd12.prod.outlook.com
 (2603:10b6:408:189::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:33:09 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::1e) by BL0PR1501CA0012.outlook.office365.com
 (2603:10b6:207:17::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/24] drm/amd/display: Fix IPS handshake for idle
 optimizations
Date: Thu, 19 Oct 2023 09:32:08 -0400
Message-ID: <20231019133222.1633077-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40a7b3-8a1b-4282-6054-08dbd0a7ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm/xoROVyz8+M3+xvavLPBeIYq3r4xFRmiK2XwHVOhTVhut7Zy851C/Da/qh/9qCADde5zQ3g2GbZZR4aV28OaPf6uzJUGGIRNbLFbRWWzZIxhJ7xlU3a5Hxp3zPaKc2NYwCgixTq7NtomLfW+crttumFyfF3GeprEyf00I30GTemhrdJ9lsj/qBRvffjXCCmvm25ifBDI5U3anPmSPO+jtX84pU65vswGa8YYxKRxKfNj8e6zKAFGJu0vFahtUKc9G5aSDtcVJXRYtbwqFczgDXldIiddg2RPQ/eYt9PwCtGs9FPXG4sQeDk8RCjmgKkfQlxF17zMBRKCMEck9440u+G6wniFE5MzoLqG+OhjLXNYE7EiEmvVF0Gv7nibS1Eum6Tkl1kkDCNDaYRKpY5sJtG5rJk+lhRIIB+GybmqsPOysR6uHgGEER1PufJyxl+bkNDi1FzyvejJMwYa4vL+fjithcOX9dj3AYduBeqSahkp5WnDe34RKXWkX1TXIORkyDnDRyrJXfP+Pn2Z1Q1l9bAmUZwk9yaNnrRcADg1q7qz0wu8xLM/XBVKElHj3SR8X5Fs6XmlAZWQW4E6JgPfhAKzE5HtrZSkVc3tD88xh9QoydrQZ36WDmkFSNPkxV3myb5Gt1d8mI8Nmg5xIkK+QMO/Je1NLk2eWhRhOGTGJJQpm8EntNOBHhE9JE7aQoyuVfjn1Jjpy7Tn4QXMGWkNJwmic+n3AtCj5FFqFYaICw7EVU52rpzAxydOMkFu1ujW9Qvpi34qIvJMm0numCwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(30864003)(40460700003)(2906002)(40480700001)(70586007)(54906003)(70206006)(316002)(6916009)(478600001)(8936002)(5660300002)(41300700001)(36756003)(8676002)(4326008)(2876002)(86362001)(47076005)(36860700001)(2616005)(1076003)(83380400001)(7696005)(26005)(81166007)(356005)(426003)(336012)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:09.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40a7b3-8a1b-4282-6054-08dbd0a7ef22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Intermittent reboot hangs are observed introduced by
"Improve x86 and dmub ips handshake".

[How]
Bring back the commit but fix the polling.

Avoid hanging in place forever by bounding the delay and ensure that
we still message DMCUB on IPS2 exit to notify driver idle has been
cleared.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 37 ++++++++++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 14 +++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 73 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 30 +++++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 -
 10 files changed, 141 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 302a3d348c76..f80917f6153b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -808,6 +808,34 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
+static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
+
+	if (dc->config.disable_ips == 0) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	}
+
+	if (!allow_idle) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	}
+
+	dcn35_smu_write_ips_scratch(clk_mgr, val);
+}
+
 static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -827,6 +855,13 @@ static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 	return ips_supported;
 }
 
+static uint32_t dcn35_get_idle_state(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dcn35_smu_read_ips_scratch(clk_mgr);
+}
+
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
 	dcn35_init_clocks(clk_mgr);
@@ -914,6 +949,8 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
+	.set_idle_state = dcn35_set_idle_state,
+	.get_idle_state = dcn35_get_idle_state
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index b20b3a5eb3c4..b6b8c3ca1572 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -444,9 +444,9 @@ void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *cl
 			enable);
 }
 
-void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
+int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 {
-	dcn35_smu_send_msg_with_param(
+	return dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_DispPsrExit,
 		0);
@@ -459,3 +459,13 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_QueryIPS2Support,
 			0);
 }
+
+void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
+{
+	REG_WRITE(MP1_SMN_C2PMSG_71, param);
+}
+
+uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
+{
+	return REG_READ(MP1_SMN_C2PMSG_71);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 38b7a4420d6c..2b8e6959a03d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -194,8 +194,10 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 
-void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
+int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
+void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param);
+uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr);
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e3b8c71e2c31..47b767fb1ee8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -975,6 +975,8 @@ struct dc_debug_options {
 	bool replay_skip_crtc_disabled;
 	bool ignore_pg;/*do nothing, let pmfw control it*/
 	bool psp_disabled_wa;
+	unsigned int ips2_eval_delay_us;
+	unsigned int ips2_entry_delay_us;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index a388f34c6d04..ba142bef626b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1100,31 +1100,80 @@ void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
-	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	if (allow_idle) {
+		if (dc->hwss.set_idle_state)
+			dc->hwss.set_idle_state(dc, true);
+	}
 
-	if (allow_idle)
-		udelay(500);
+	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
+	const uint32_t max_num_polls = 10000;
+	uint32_t allow_state = 0;
+	uint32_t commit_state = 0;
+	uint32_t i;
+
 	if (dc->debug.dmcub_emulation)
 		return;
 
 	if (!dc->idle_optimizations_allowed)
 		return;
 
-	// Tell PMFW to exit low power state
-	if (dc->clk_mgr->funcs->exit_low_power_state)
-		dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+	if (dc->hwss.get_idle_state &&
+		dc->hwss.set_idle_state &&
+		dc->clk_mgr->funcs->exit_low_power_state) {
+
+		allow_state = dc->hwss.get_idle_state(dc);
+		dc->hwss.set_idle_state(dc, false);
+
+		if (allow_state & DMUB_IPS2_ALLOW_MASK) {
+			// Wait for evaluation time
+			udelay(dc->debug.ips2_eval_delay_us);
+			commit_state = dc->hwss.get_idle_state(dc);
+			if (commit_state & DMUB_IPS2_COMMIT_MASK) {
+				// Tell PMFW to exit low power state
+				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+				// Wait for IPS2 entry upper bound
+				udelay(dc->debug.ips2_entry_delay_us);
+				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+				for (i = 0; i < max_num_polls; ++i) {
+					commit_state = dc->hwss.get_idle_state(dc);
+					if (!(commit_state & DMUB_IPS2_COMMIT_MASK))
+						break;
+
+					udelay(1);
+				}
+				ASSERT(i < max_num_polls);
+
+				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
+					ASSERT(0);
+
+				/* TODO: See if we can return early here - IPS2 should go
+				 * back directly to IPS0 and clear the flags, but it will
+				 * be safer to directly notify DMCUB of this.
+				 */
+				allow_state = dc->hwss.get_idle_state(dc);
+			}
+		}
 
-	// Wait for dmcub to load up
-	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+		dc_dmub_srv_notify_idle(dc, false);
+		if (allow_state & DMUB_IPS1_ALLOW_MASK) {
+			for (i = 0; i < max_num_polls; ++i) {
+				commit_state = dc->hwss.get_idle_state(dc);
+				if (!(commit_state & DMUB_IPS1_COMMIT_MASK))
+					break;
 
-	// Notify dmcub disallow idle
-	dc_dmub_srv_notify_idle(dc, false);
+				udelay(1);
+			}
+			ASSERT(i < max_num_polls);
+		}
+	}
 
-	// Confirm dmu is powered up
-	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
+		ASSERT(0);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index 588a259c11f2..534223dbe595 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -118,6 +118,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
 	.block_power_control = dcn35_block_power_control,
 	.root_clock_control = dcn35_root_clock_control,
+	.set_idle_state = dcn35_set_idle_state,
+	.get_idle_state = dcn35_get_idle_state
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 682bf93049b0..b47d53b7f4eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -746,6 +746,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
+	.ips2_eval_delay_us = 200,
+	.ips2_entry_delay_us = 400
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 36d2b91aa337..b1bd9194ba55 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -646,18 +646,10 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	// TODO: review other cases when idle optimization is allowed
 
-	if (!enable) {
-		// Tell PMFW to exit low power state
-		if (dc->clk_mgr->funcs->exit_low_power_state)
-			dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
-
-		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
-	}
-
-	dc_dmub_srv_notify_idle(dc, enable);
-
 	if (!enable)
-		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+		dc_dmub_srv_exit_low_power_state(dc);
+	else
+		dc_dmub_srv_notify_idle(dc, enable);
 
 	return true;
 }
@@ -1191,3 +1183,19 @@ void dcn35_optimize_bandwidth(
 			dc->hwss.root_clock_control(dc, &pg_update_state, false);
 	}
 }
+
+void dcn35_set_idle_state(const struct dc *dc, bool allow_idle)
+{
+	// TODO: Find a more suitable communcation
+	if (dc->clk_mgr->funcs->set_idle_state)
+		dc->clk_mgr->funcs->set_idle_state(dc->clk_mgr, allow_idle);
+}
+
+uint32_t dcn35_get_idle_state(const struct dc *dc)
+{
+	// TODO: Find a more suitable communcation
+	if (dc->clk_mgr->funcs->get_idle_state)
+		return dc->clk_mgr->funcs->get_idle_state(dc->clk_mgr);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 7c0ff7b163a9..14bbdb0fa634 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -79,4 +79,7 @@ void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
 		bool power_on);
+
+void dcn35_set_idle_state(const struct dc *dc, bool allow_idle);
+uint32_t dcn35_get_idle_state(const struct dc *dc);
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c43d1f6c2a06..452680fe9aab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -420,7 +420,6 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
 	uint32_t (*get_idle_state)(const struct dc *dc);
-
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
-- 
2.34.1

