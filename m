Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11411CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9833E10E4DB;
	Thu, 19 Oct 2023 13:33:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5928410E4DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heqgFsssC8eWNnIpxKtfgrm5fOMmORCXhwlJIXUpF8ryy/SBkjIUKu7G83as0XHy7H+fGQ7h/mMJHMr0m4+NnD0fl2yeZc/tU5dU5guI9leWvBh3Xk3qXWaXFr3Mz94q53ZhRaBk2+kS9nMNCAntdyllulcicLhZBU1pQnn3agyeZpRlyK+yWmtGd6Rq/DVpNU5GuS0u9JwhqStHP0TnWhMjALegdWV/w84dOcrZIX01AEdBk1EPSUnSdAgyz+CgqdRDM9d4+Ww1o6521SK8gnYPjIM55yirWBP+s0nsf/CIJEsJOjPUVDRry2kEJL/9z2lYGnCC/JCpCXYJD6jkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWjxLdLWYIcwIhKuLQmOyJ0u8kmiRSbJuiBJbQfju88=;
 b=LMZF85vqO4SIfeZfUnRZ2ta4xwVVPgEyGt65a+n6hPhPRCdIwUQz4weUnMqkJajbR2rF2qKq5ZRQhKdnGla8df+5Ou+paX9WES9eW/GzZZom6scyuqlpRxRiwwitWJfU8JBq1VyylFT4OVHD8Z47LzTtSbH/wFip7YISjEWf7j5cxCx8jcuqpV52hsT6glpSDU4fmQmIxk1E/XudC1W5IEpv2dczywgDr7kLN8p6WNvquP4FwcbgmFOMc/1ChoAnFGIqZ129LImemRpmoLLkw5eB3QV572ffZ4pxI4MWtXsFH+cupquK7GI/os3VlkpADdN7gC/s3ANFO1eWfxonCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWjxLdLWYIcwIhKuLQmOyJ0u8kmiRSbJuiBJbQfju88=;
 b=lE2kWkc39WHzeqG2JDRVFjzk4NFY/8GvCqjaBKmjMBBVxKYGHMfBqWcNnYyBm/6lBW/r74PkX8S0PbAli6IbzSjmsNXJvnMF387Nr/cLA4qKTEWjG+vIPaKXrBNe5j/0MQ0xoTKs5eGHfxMQ8PpMdMzm7LRG958RjFItVslodAA=
Received: from BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) by DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:32:59 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::4b) by BL0PR1501CA0003.outlook.office365.com
 (2603:10b6:207:17::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:38 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/24] drm/amd/display: Revert "Improve x86 and dmub ips
 handshake"
Date: Thu, 19 Oct 2023 09:32:02 -0400
Message-ID: <20231019133222.1633077-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f7aeb7-704e-435d-03b1-08dbd0a7e955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJuwOKiNHzoLs/s+Ww50Su9u5AEzU03E1eP207w+mcM94wD1B7AQOXkg7j6vmU0c+nM0LpodgyALvdGbo5b5dgsxk8uvET0LNp/U46/QP9j/bFeUMzp6V80Eun3SbJsII5HtGdMPkZj+eGX/qgjrBPljNJVDd7RvnCFk7S8w8bguuX+O75eeYqaGUVWUzS/dD8EQuhSigjDcnK/peqvP5dZzkWplEwekM+v3VToZn7v9d0so/UNnM/Vys58PPpzJ+ijeMirR5UqbvgwpWjkl2n96LHxfP645GlnFbwpGvHXdKyb/PZtVlk3Fik+UkfFSVvxaMUBZbJV6By1SyVe3ryCJ0HMxViMDWI6AIJkLQ3M7/EV4vhBShue4db84ZnZ6UYc4VGbWBle32MTJGyzuTwAWhnQPTkoS9o5Ej+OsPtRZ4OivylyRpHi9g0suiq+3wnhlsg39cEtFfM4CUyAduNGMFlwIjfyPTTNR1cNW7MEN9mmB2NtQuzg3Dw5AJfKonPiFd3qW6+/fIFcijoKpMSlBYTYzLeybVUDsWhGGCzgbAIw9txL/FlXapP0qhydUOw5OQHIjeFWL3a+gTW05lShZRVrKjI3JrAHLLEA7s7Lh0IULI6EXeSPW9c+xaJ4WL2PfuGmUDkDY6ofIEkKzNY+WBoQ2FQhmBlP4EWbosxbUO4Y9Ng6uQ6he3ajtgIprzn3oNzouXLxRcK40LaryO7H1XZd6GLbZNSaGoJ8A3LkSWPSlRL4o0AVQ0Ajga/vx6TtNExTsM6jRVnlsRdKhjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(336012)(426003)(356005)(82740400003)(26005)(47076005)(36860700001)(40460700003)(83380400001)(41300700001)(5660300002)(4326008)(1076003)(478600001)(8936002)(8676002)(54906003)(70586007)(70206006)(6916009)(2906002)(86362001)(30864003)(2876002)(316002)(7696005)(6666004)(40480700001)(81166007)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:59.3493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f7aeb7-704e-435d-03b1-08dbd0a7e955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

This reverts commit 8316378d272ed96f60177cc9a8beaadb8640f745.

Causes intermittent hangs during reboot stress testing.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 37 ------------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 14 +----
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 57 ++++---------------
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 -
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 30 ++++------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 -
 11 files changed, 27 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index f80917f6153b..302a3d348c76 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -808,34 +808,6 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
-static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc *dc = clk_mgr_base->ctx->dc;
-	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
-
-	if (dc->config.disable_ips == 0) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	}
-
-	if (!allow_idle) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	}
-
-	dcn35_smu_write_ips_scratch(clk_mgr, val);
-}
-
 static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -855,13 +827,6 @@ static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 	return ips_supported;
 }
 
-static uint32_t dcn35_get_idle_state(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	return dcn35_smu_read_ips_scratch(clk_mgr);
-}
-
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
 	dcn35_init_clocks(clk_mgr);
@@ -949,8 +914,6 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
-	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index b6b8c3ca1572..b20b3a5eb3c4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -444,9 +444,9 @@ void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *cl
 			enable);
 }
 
-int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
+void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 {
-	return dcn35_smu_send_msg_with_param(
+	dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_DispPsrExit,
 		0);
@@ -459,13 +459,3 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_QueryIPS2Support,
 			0);
 }
-
-void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
-{
-	REG_WRITE(MP1_SMN_C2PMSG_71, param);
-}
-
-uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
-{
-	return REG_READ(MP1_SMN_C2PMSG_71);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 2b8e6959a03d..38b7a4420d6c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -194,10 +194,8 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 
-int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
+void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
-void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param);
-uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr);
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f16912a8791d..cc1cae4d7329 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -975,8 +975,6 @@ struct dc_debug_options {
 	bool replay_skip_crtc_disabled;
 	bool ignore_pg;/*do nothing, let pmfw control it*/
 	bool psp_disabled_wa;
-	unsigned int ips2_eval_delay_us;
-	unsigned int ips2_entry_delay_us;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4fd3f09432be..a388f34c6d04 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1100,64 +1100,31 @@ void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
-	if (allow_idle) {
-		if (dc->hwss.set_idle_state)
-			dc->hwss.set_idle_state(dc, true);
-	}
-
 	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	if (allow_idle)
+		udelay(500);
 }
 
 void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
-	uint32_t allow_state = 0;
-	uint32_t commit_state = 0;
-
 	if (dc->debug.dmcub_emulation)
 		return;
 
 	if (!dc->idle_optimizations_allowed)
 		return;
 
-	if (dc->hwss.get_idle_state &&
-		dc->hwss.set_idle_state &&
-		dc->clk_mgr->funcs->exit_low_power_state) {
-
-		allow_state = dc->hwss.get_idle_state(dc);
-		dc->hwss.set_idle_state(dc, false);
-
-		if (allow_state & DMUB_IPS2_ALLOW_MASK) {
-			// Wait for evaluation time
-			udelay(dc->debug.ips2_eval_delay_us);
-			commit_state = dc->hwss.get_idle_state(dc);
-			if (commit_state & DMUB_IPS2_COMMIT_MASK) {
-				// Tell PMFW to exit low power state
-				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
-
-				// Wait for IPS2 entry upper bound
-				udelay(dc->debug.ips2_entry_delay_us);
-				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+	// Tell PMFW to exit low power state
+	if (dc->clk_mgr->funcs->exit_low_power_state)
+		dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
-				do {
-					commit_state = dc->hwss.get_idle_state(dc);
-				} while (commit_state & DMUB_IPS2_COMMIT_MASK);
+	// Wait for dmcub to load up
+	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
 
-				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
-					ASSERT(0);
-
-				return;
-			}
-		}
-
-		dc_dmub_srv_notify_idle(dc, false);
-		if (allow_state & DMUB_IPS1_ALLOW_MASK) {
-			do {
-				commit_state = dc->hwss.get_idle_state(dc);
-			} while (commit_state & DMUB_IPS1_COMMIT_MASK);
-		}
-	}
+	// Notify dmcub disallow idle
+	dc_dmub_srv_notify_idle(dc, false);
 
-	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
-		ASSERT(0);
+	// Confirm dmu is powered up
+	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index 534223dbe595..588a259c11f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -118,8 +118,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
 	.block_power_control = dcn35_block_power_control,
 	.root_clock_control = dcn35_root_clock_control,
-	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 99d55b958977..4e03c9d663de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -746,8 +746,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
-	.ips2_eval_delay_us = 200,
-	.ips2_entry_delay_us = 400
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0e218f9e2a86..12821cb9ab6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -650,10 +650,18 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	// TODO: review other cases when idle optimization is allowed
 
+	if (!enable) {
+		// Tell PMFW to exit low power state
+		if (dc->clk_mgr->funcs->exit_low_power_state)
+			dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+	}
+
+	dc_dmub_srv_notify_idle(dc, enable);
+
 	if (!enable)
-		dc_dmub_srv_exit_low_power_state(dc);
-	else
-		dc_dmub_srv_notify_idle(dc, enable);
+		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
 
 	return true;
 }
@@ -1187,19 +1195,3 @@ void dcn35_optimize_bandwidth(
 			dc->hwss.root_clock_control(dc, &pg_update_state, false);
 	}
 }
-
-void dcn35_set_idle_state(const struct dc *dc, bool allow_idle)
-{
-	// TODO: Find a more suitable communcation
-	if (dc->clk_mgr->funcs->set_idle_state)
-		dc->clk_mgr->funcs->set_idle_state(dc->clk_mgr, allow_idle);
-}
-
-uint32_t dcn35_get_idle_state(const struct dc *dc)
-{
-	// TODO: Find a more suitable communcation
-	if (dc->clk_mgr->funcs->get_idle_state)
-		return dc->clk_mgr->funcs->get_idle_state(dc->clk_mgr);
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 14bbdb0fa634..7c0ff7b163a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -79,7 +79,4 @@ void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
 		bool power_on);
-
-void dcn35_set_idle_state(const struct dc *dc, bool allow_idle);
-uint32_t dcn35_get_idle_state(const struct dc *dc);
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 452680fe9aab..d45302035e3f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -418,8 +418,7 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
-	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
-	uint32_t (*get_idle_state)(const struct dc *dc);
+
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index fa9614bcb160..cb2dc3f75ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -262,8 +262,6 @@ struct clk_mgr_funcs {
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
-	void (*set_idle_state)(struct clk_mgr *clk_mgr, bool allow_idle);
-	uint32_t (*get_idle_state)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
-- 
2.34.1

