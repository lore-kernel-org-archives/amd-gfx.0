Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B7C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C4061175
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4C4061175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F79A6EA6E;
	Fri, 29 Oct 2021 15:15:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075C16E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM+LVS/ueCuHaAA4JW3VykT27WvuX/M8ykCKXgJdCOjHRDOdAHElnWbqvlGJoh3P/xYKjFDPe0PQHN7H3OElORkdh0iCYK4lBynVHZKLY9ZvJSYmSH3aDPFk06W322pAi4s8BV3nPvzQcjpSpQZEJewpqDaoqBHSjHsCq7mKkPq+BCvPgRg/X8qaDJzqcteza4fGPIgGy3qczePC2LuR/eQFt8iJosY5cOVPemaRML9j/cEcl4iYjA5o9um/KD+z+b7dp0Zv5HXpRAGSMLF+1SaXRY7gllYlqoF7GJAzBB4nkiuk7enuxI0CHmAp3qgItoOqUspZ0oxIfKQa/FyFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgxktal3yzuZ0dd2pRDN8qAbwgsDjQjeY+CtVWHz/kw=;
 b=SyHAIzqaRBxXViwcf/RHcmRMNapx3B5imdor24eenw/TRx8j1ZmYL/QF+nj/tQAfSHJwxY07cV0eB5b6m+ESQ/vZo6I5ropspIicEaUKdeX9L+VPfS6CMdNSl76qzdNPgfHeDt6QoQ0apgmJqtKGXRk5WrldbC7/0XQbEeLCDxWyutJVBHEexnYOVOO3u7AKQ4tPq4YEqNroM8506luEq+w9SZnQ3xEAaiQddfzVRjXqNXteuyOxJ3LM1oPmB+HLXNyprzF84Ikb0WPO5UO8YRMIq69xVudd5kOO/MF0gqpJxjAG3YFXdzlzARjbhv6w9AWsMgagHNoaXRQXCtgFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgxktal3yzuZ0dd2pRDN8qAbwgsDjQjeY+CtVWHz/kw=;
 b=ix27VlSu0L4takh1q/eweTnXdvv3jdUffK1Y8Nb9u/9OIWfof3W7eyf7LNB2ymVjIZy07v7g/hoKqrqdtOE6oKEKVX9AgnJHwyr11TnZ0nmuBIwY8MAid8DwKiYcj/sWs+wNGkONY+XvQHCxFvkcYYRhoeMCNRV7j0KmqytwMp8=
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 15:15:36 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::fe) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:20 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Eric Yang
 <eric.yang2@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Add MPC meory shutdown support
Date: Fri, 29 Oct 2021 11:14:52 -0400
Message-ID: <20211029151456.955294-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 511e6e53-f22c-4416-062c-08d99aeef555
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27735DCF1110268AC695AB918B879@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0y+EKqo7SdfNy6Y1KA+15BXfXB4afPmng6N0lndiXZHVu8cFE77Kgoei5T+xs3sMRjvoz4Z/ESHprN2rE3gvJwkCP4F1J4cnhc5JfD6CPzgnPwxF5cKAnd3LD8Nvr7zfitv2/txr3KJPSKX+H3xf8rAVb0JFVROVSEnt/xawL7SXNJKZqzVSaEXNQho8qaDNiyfkTVdfjXcN5b9n18WT4/YZYF/aQULom2BTkivk2WgxYrZo6ERqBpWIfcEjtKQYZ0e0syBr0NJG/6sVN3bWzar5feyvb4SnJ0VLh6XJbOIjtH+hqS3oV1+gbE76fe4zl+v5Y2MSH3FdP8Jl6wDqWVSyKvGDHQ1eC9+JJjnd6u03CQNFbCKrmOQtQp/51Y9zzWcF1Igil1jOgsLQkUEkQY8D5ccejrWrT/B4IMswgUMMb9VnI9PBbkB9ZoEgsZz0cDqrtETQ4FDeD/YO+AdT/O/O19zd2EucnnulGKHfp32jdHmSxZcdeoDkxP49KV3qDwPChq6P5TTHfYTln69riR2gOUYHGZIt+Xs4BAINBs/lpilmJjdkXr3SS+Y7+2hM4/wgr+JRwheGMiwV5xAihqVU8BrfqfRxlscUvKBlZ5ykMnAarBO0XDkdzwXKsYL5Vebl8J7RLyWy7NTEdjxUAbZM1gop5KyTHuEOF/MMm8d2wLF7pHU49LNFxYpgzN1bsyjT3u/L0vTzLi4SRx47F/paGvHCHiHYBsbQ3stLioRLVuOzUoWeYKnBd76JeI7mCK7016Whs36VwLK813Rxrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(336012)(81166007)(36756003)(6916009)(4326008)(508600001)(82310400003)(316002)(6666004)(186003)(356005)(2906002)(5660300002)(8936002)(44832011)(26005)(70206006)(47076005)(83380400001)(2616005)(8676002)(54906003)(70586007)(426003)(86362001)(36860700001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:35.7830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511e6e53-f22c-4416-062c-08d99aeef555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
The MPC memory clocks should be powered down when not in use.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  7 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 69 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  1 +
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index a82319f4d081..95149734378b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1381,13 +1381,11 @@ int mpcc3_release_rmu(struct mpc *mpc, int mpcc_id)
 
 }
 
-static void mpc3_mpc_init(struct mpc *mpc)
+static void mpc3_set_mpc_mem_lp_mode(struct mpc *mpc)
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int mpcc_id;
 
-	mpc1_mpc_init(mpc);
-
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 		if (mpc30->mpc_mask->MPC_RMU0_MEM_LOW_PWR_MODE && mpc30->mpc_mask->MPC_RMU1_MEM_LOW_PWR_MODE) {
 			REG_UPDATE(MPC_RMU_MEM_PWR_CTRL, MPC_RMU0_MEM_LOW_PWR_MODE, 3);
@@ -1405,7 +1403,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-	.mpc_init = mpc3_mpc_init,
+	.mpc_init = mpc1_mpc_init,
 	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
@@ -1432,6 +1430,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 	.set_bg_color = mpc1_set_bg_color,
+	.set_mpc_mem_lp_mode = mpc3_set_mpc_mem_lp_mode,
 };
 
 void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 1b089893460a..5dd1ce9ddb53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -66,6 +66,45 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
+static void enable_memory_low_power(struct dc *dc)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	if (dc->debug.enable_mem_low_power.bits.dmcu) {
+		// Force ERAM to shutdown if DMCU is not enabled
+		if (dc->debug.disable_dmcu || dc->config.disable_dmcu) {
+			REG_UPDATE(DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, 3);
+		}
+	}
+
+	// Set default OPTC memory power states
+	if (dc->debug.enable_mem_low_power.bits.optc) {
+		// Shutdown when unassigned and light sleep in VBLANK
+		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
+	}
+
+	if (dc->debug.enable_mem_low_power.bits.vga) {
+		// Power down VGA memory
+		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
+	}
+
+	if (dc->debug.enable_mem_low_power.bits.mpc)
+		dc->res_pool->mpc->funcs->set_mpc_mem_lp_mode(dc->res_pool->mpc);
+
+
+	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
+		// Power down VPGs
+		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
+			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
+			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
+#endif
+	}
+
+}
+
 void dcn31_init_hw(struct dc *dc)
 {
 	struct abm **abms = dc->res_pool->multiple_abms;
@@ -108,35 +147,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
-	if (dc->debug.enable_mem_low_power.bits.dmcu) {
-		// Force ERAM to shutdown if DMCU is not enabled
-		if (dc->debug.disable_dmcu || dc->config.disable_dmcu) {
-			REG_UPDATE(DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, 3);
-		}
-	}
-
-	// Set default OPTC memory power states
-	if (dc->debug.enable_mem_low_power.bits.optc) {
-		// Shutdown when unassigned and light sleep in VBLANK
-		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
-	}
-
-	if (dc->debug.enable_mem_low_power.bits.vga) {
-		// Power down VGA memory
-		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
-	}
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
-		// Power down VPGs
-		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
-			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
-#if defined(CONFIG_DRM_AMD_DC_DP2_0)
-		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
-			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
-#endif
-	}
-#endif
+	enable_memory_low_power(dc);
 
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 04d6ec3f021f..f5fd2a067323 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -367,6 +367,7 @@ struct mpc_funcs {
 	void (*set_bg_color)(struct mpc *mpc,
 			struct tg_color *bg_color,
 			int mpcc_id);
+	void (*set_mpc_mem_lp_mode)(struct mpc *mpc);
 };
 
 #endif
-- 
2.30.2

