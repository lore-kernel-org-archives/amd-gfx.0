Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75B3CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0060A10E42F;
	Wed, 18 Oct 2023 17:42:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331310E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPyqkPle0PwbymHY/Vtav3wsa9YnxAGJlaJuV+xR600PmiU7+jrsxcQdvlpIooaPzTHUZiZp+SDkt7qs3Tz8V3lE9US01tfOEc/slZVxtmFwXOeE0gANGU/7+QpYaaKRAMkSn2TPcKSWeIdGIqUiVL7zBQUQxzqyNmQLhre0Rx9PeuDnTgxDEue/51FrqoYLuMe9gWkn0Fy8dg+VJ7lTGkEsCi0bS6nJroNy9CkBtoZBsjV212hXOLkz7RTRGJSPr4VbLjk3rI0QC8DrmUMWK2sWFOK1F3zZbxI837FAm72KSCq8vaW9GVR2v22niM05WHNx5/cSGggSpZ2lwMfIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22L0PyPJcdxeMve8d653j9qbPmhZgmvDXV80s5Q2Nrw=;
 b=WoeXoPeR3u+Y6XDsq+YjmICYEJ4gnaEuedVDK9ZadjXqsneVi0wr9oQ+kdBhTyrNA5h2xTSefNqvLQ00pvU0vCqG9tsTWuhLbHlcamL7F/2lKxeFamhTg/SxwnytwHR8uasiacSlhoLBM5eQ5xfEzKtpEkzKFvnIMfZbXqZchkKfEo727Z62+19Ra+zqhfdAxkiOi3jI4KRas/KTTPYXAwarrUTpNNHDaPOX7UxLpUokw57TbIr5z1eDERgEXHqIeH41TdZ84nEtMQIlZWJZgfQRre+tMmc5DN6GUKUC8iEdkCj9iUGRWgqFR/7hWCj8MqsMr++KrUGnH41HnJymoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22L0PyPJcdxeMve8d653j9qbPmhZgmvDXV80s5Q2Nrw=;
 b=Xus196Pz9RjdAa9gKfUMQN0w9WPe5Ba7jIC3dbMHmTNOojUZ+EGNTNbZsBIZXgDg+P4brwN46WFf52+wwWocpo0r8yQwe2egCTJhfITTQ90mvBoX9dRsn1hOhknYw2w2qJK40miTpmJ2NR2omM7NeSCzmB12xwv3d7JF01VvBp0=
Received: from BY5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:1e0::27)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:42:35 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::84) by BY5PR03CA0017.outlook.office365.com
 (2603:10b6:a03:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:30 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:29 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/26] drm/amd/display: Fix IPS handshake for idle
 optimizations
Date: Wed, 18 Oct 2023 13:41:18 -0400
Message-ID: <20231018174133.1613439-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b58f1e-abd2-4b20-13e4-08dbd0019cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLchgvyrQpC9EGtxP9/rl9Sst8XYz0fj/Bc/2g1A6DXtmO1tvqXiYiLFOp+zEJ7viz6+/we9diPFXUxDOL5ZrnnegjqYnkLADsauGUQjw6fXLli4i2JtfcZREPGmxFaxmlK5T7tms9YU3M2iFptQivxXO8mkVFb8JYZSQ4rShTPp1+Ls76Pjjwo0buTCZ48PRiaPPEOCIOEWkM4AO6lmj58eR8umibDYCTtJnK0dGsMnM9d4BziYKpLr3vwTmGomVXM0IkhTb1ck+KwD9Q58UZO/15fGTPq3NdbH2rZGDEAmJV7Uvm/PUejAKRtm8srvJEWl86glmf1lQ3EHs2S8Fl+CCK2EDAoEM2OmPg6MUBnSVpCwSD2FNqZ6vVjRYXQkvo75s0ro7kf4TNz3mz/atPD0B+PE722xb2awXh9bDQN13KOpR/6PKLaw+L91q1iSF78nT0EBf4LdnRda79a6H5Sj8qZK4VANWnEsjheqHsUbH237in63LnEMuTUf3guAUQ+bzT0y+AKLdURMzEolrBxrD1f2TMz0OnzBtYJvMC71FSbxow4pUsALS+ttubfo31lHaQ2W62BeA6H/woJcBs2SoUmtFz/fPKa4LyV99asN6hi4kOrzqlYNPEQEc59A8gMiRyKCghGHbtDUnGkamzhVIsCq7rQFk3YX50p8b7aJh6MG67/w/JVHHZRHxc92FRAKU0fYdiYlgb8zC4mKjXInGrvBiRPxNJi5CvCfs2LI/3wLfGlUQx4Lh9S7h5zGpSFe02w4Py/aErroZvNVww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(26005)(2616005)(1076003)(7696005)(6666004)(8936002)(83380400001)(2876002)(336012)(426003)(4326008)(41300700001)(47076005)(8676002)(5660300002)(478600001)(2906002)(36860700001)(70206006)(30864003)(316002)(6916009)(54906003)(70586007)(81166007)(82740400003)(356005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:34.7706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b58f1e-abd2-4b20-13e4-08dbd0019cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
 kotarac@amd.com
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

