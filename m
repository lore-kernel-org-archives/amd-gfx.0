Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A93ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3140810E088;
	Wed, 14 Sep 2022 03:31:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F2910E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GddEQanSRVJBzsUltxLfr5Zr4wHIhi3h/KBxLRPBZm5Al+PM8EzASbRbR2vvSuEqtMvGCeOxYPNo+9r63gWehr5lwyegfXWY4qfL7HABKykFW2cxBy9nyyTuKPf/I5DEzLtj0TNqkYNjcIJeD9717tir2XSfBED6eArwMqMSmjtrIlIxX8MF37JLYv9yMZd0l+z6zlEZ7aR4NeOl8oZr8gpP6otcMH5KfM3tcPxjwm1NzqI7bP0E1d+DVVTpHoQhOm7v3hY4Ey0xIaprAQg3Sa/FAPRDtAaMdAEbCaoXMGb2xLmjZCvLrM8dh74NVs8n3AboNjBObwVZgGl/dywZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=KDvKVtKx/4yn8AOxwjDhL01D7IViNaoddHFCglYVTZPW0dtqWrmnQzbJdMjo4R0VITpGZkZdxwLUAnJxdUY3CDvll2PU2To2PRfc4yQYmb+I0rvl8sjWI2SwhuelLAN8eBMMFV8bsuT4m86FgqwT4dubhwCEz3hYxlYwyQ9c33qqJ4qYAEsyWKU4/xtR43ZkJ0E3d3zWGTsBiKPW0S7qSlkDQezdCfFp216ZgVHNwe2Bdo2Yvkv57hHZZ8rIccToBkFmBQeF8+dbtNF5q0m2oJ5b+Wn4svSeMPeAsR3NYd6j0oLzYpHxdRvDNGbuVXWwK0dFd5/HZD5U2aMtETXUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11veMkwzeWkiqv27eLf9H3Ch5DFJlHO39KiiMjPio+w=;
 b=uI0c1hf6K6gvI9Dk6y5IoTW8efJ+Is6vGnYyGbdxdIpEDN6OpH3xv9XMa5aSMPzQqmoBnnTRFQQUTh7DaslNnxC1Dk+vx/d2ethIfuDDay8eKNLSYJVLMIiBBlz2CTkUVt/mhIb48fEblADUpsMP2HPtXMQ4O+iOZoc0OwoL4/M=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:31:02 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::54) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:31:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:30:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:29:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/47] drm/amd/display: Disable SubVP on driver disable
Date: Wed, 14 Sep 2022 11:24:09 +0800
Message-ID: <20220914032441.1075031-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e3772b-0081-407e-1f86-08da96018c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LadealeTLUiz1Gn3+uNKd5E1vHj84zlf6LKeYVO9SxMtgqFrH5tdJ3kMeg/JKPsD3xhN8puI3AJRuLa9rTp9V8boZFqyIAadYrca4NLBDCDbkacz+Uf0oGT72qE8N2Y06BCMscNq2wW7psKj0vZA7x+tsKfC7c2np+9To8xvIaAJAtjMpqxmO0931G9dKUe15MAJdpe0ScsVpT+48QeQBmTjhG+KbFeWyiSQjJ2baUAbjBniCYNdt/P/wn7WLTd4S23C51b02qEi1pdGavHIgyNBgjLJgE2eNfw7mrv8bhtPnWoH5hAbgZP7eQxEZYY7LEH5Nv4mQ9grGRZVmDcz85NgyJoQh/g38mQKuIzD4WopJ5tNOmgL6zm2kSPK+ueRDeXAYh5TQI6hKVlmnpARAqbvFINWkmaUtGKZyaRcfQ8fDR346pt8maM2o1fl91A/6ZVTGQck0W97eJvJkhnLEUxgyjYYh3g4OFoaeemFubu0ZA/+hOHHAxan8mzWPCA0Xl7jYhBKRWco3NMjDeF2MdlZtfVznNSnJkY8kFtLJ7GqaPMFswnvlMxpoGBuYE/o1Zrsp01kHsqOiHTgKG0zTAVndDDn4tb+FxrhpnvBeWG0+BKKKU3/lN+n6uJH6gPsG8KCwH7aUbnfgNnYU1/Ni/aRvkYGT9QCNvRYa5yIZUKLCDTmba9Jot5ZaQGMxyTtbTJl6qyla3kxHEs4RDRsIpbFbLUA1I23baghcudGIXZB/5xSr/0DuwOgfRU/M8bP15JELxIqbNoHLSpkmTWh7t6YQgQX+IqljGE9DcCSut7zW0R4yDkilkRWkLzg6WEh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(36860700001)(8936002)(40480700001)(1076003)(82310400005)(2616005)(6666004)(2906002)(8676002)(356005)(36756003)(81166007)(426003)(82740400003)(336012)(316002)(6916009)(40460700003)(41300700001)(70586007)(86362001)(54906003)(47076005)(70206006)(186003)(83380400001)(26005)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:31:02.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e3772b-0081-407e-1f86-08da96018c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- For driver disable cases in current implementation, if P-State
  is unsupported or still supported by firmware, we force it
  supported by DCN.

- SubVP now needs to be included in this case along with FPO.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 21 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 9f5b47b9a83d..7e438345b1a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -85,6 +85,7 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0
 
 bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *dmub_oca);
 
+void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, bool enable);
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index fb59fed8f425..4a1954fe3f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -939,13 +939,32 @@ bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, s
 
 void dcn30_hardware_release(struct dc *dc)
 {
+	bool subvp_in_use = false;
+	uint8_t i;
+
 	dc_dmub_srv_p_state_delegate(dc, false, NULL);
+	dc_dmub_setup_subvp_dmub_command(dc, dc->current_state, false);
+
+	/* SubVP treated the same way as FPO. If driver disable and
+	 * we are using a SubVP config, disable and force on DCN side
+	 * to prevent P-State hang on driver enable.
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			subvp_in_use = true;
+			break;
+		}
+	}
 	/* If pstate unsupported, or still supported
 	 * by firmware, force it supported by dcn
 	 */
 	if (dc->current_state)
-		if ((!dc->clk_mgr->clks.p_state_change_support ||
+		if ((!dc->clk_mgr->clks.p_state_change_support || subvp_in_use ||
 				dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) &&
 				dc->res_pool->hubbub->funcs->force_pstate_change_control)
 			dc->res_pool->hubbub->funcs->force_pstate_change_control(
-- 
2.37.3

