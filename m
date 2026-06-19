Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF28CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6E110F5F2;
	Fri, 19 Jun 2026 13:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZnznV99";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8CC10F5EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWKB96J0aMI8qChYEQgm7JMeqxp702SsO6/ML1wtQqA9cYJ/b839Ee67b7V7oq1E3jkABl94UYSjoAOVDmrHDDNbKGiExQt64R6EpAbL9MvoZhyYtJnIujS/R39Z1HsmzRQIt2IMAhxR4ZPdNVdjPCLIdzRj7V/iK3kLzlR6XEi0UQHNTmeruztBmbSm6w/iUCd/L49LGYzFMAvbTdBqIU3GQ587+5AjKTJ7eObMUxfXLa65ZOUI/i/9cxxCbv6KrFOz5qLmKPZtGaQ9R4+Ri8Y1drT94vB9FidIVzHXwyZ/AVopLTlKjqPqW7Hs78ACcwrXfQUk/Ei89D3w5YHDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuQBJp6vYRSL5T7D6nchGzNpaMCQP6jsKA921Mm4cic=;
 b=CRH7yxTjlXOrjlC1zrbQmu3CL0c+LB8+rfLkiiILrjWv+burs/IaWpN+EIi24fJs8Ue/9fY9nfk1MdA4GtLjF4KXgj/HupA6wK09JksXycXte/GlogoiOawm1cSVXGZ5qPyF96rivixgWXRfGx87JS4nS1NTHeI7i93Vts4b2NJnOTAwqAprGbWrCTqgtNcJt4w2ffp5HZpzXYrCP4iInFRdScmRTSs4jDbYk624fBRXZ4x1ssS/yX66O0QU4sDPNtyo3Hh2ibLvcMBYRYh5X5Gx4I5KF1ny47qx9bxKCajmc5y6Q1wLjpbWMT61ymBZHvRiBp68Od7HiTHA6JvHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuQBJp6vYRSL5T7D6nchGzNpaMCQP6jsKA921Mm4cic=;
 b=PZnznV99m4Po/kEUfCQbvcscjgxs5KHIpJjqyKg8nVsFxPJb4leXKfV9yw7BKQljnSrwb1yZueLPNE0ElPuHqAEPzY8nUMK0qoKuyVvg2itnze7ok2sW4v1TbAd+o7N7RrfGb/pzJj/D0smpiONsBCMrbuyBEwDcUjJzXVCcFXs=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:34 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::9c) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 13:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:33 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:31 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Update ONO PG Workaround for DCN42
Date: Fri, 19 Jun 2026 09:21:32 -0400
Message-ID: <20260619133154.116746-18-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: e3496b1b-ad80-433d-623e-08dece07386c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Eg7Fyfaeegtixhv3F8mRfQB6aYWSa/VX7uzESjguMLAAZl8Q95A6+QyalJ4yD5L0mgnuy83gU8cQFduJR7JypvIumh18/oi0TRO5NJa21FCf5F0V0j+SqCIKieFSUtESJRKVfos8MHBRghrFogX8G+Ij1CnFtwl0NP3dbfzKS3kb7kCgVrPL2EH637+fLAoy/2x7bFT3kvgRMoJWzxiSCxsWJqkhrO6XvhYNLAs/LKrrRKp/3LbMnyAU1fwjo2wDh6b1dqXPOvBAWDaM0DnPKgScmvYG0Uh3Bbjjgd/KLMYVATBRN96wRrMC4RTFmohSBofnicBTr48pR5NzBGJrQZPEfnDZbT1aLDG7rz5xyuHx/Xqz52DZQsWFPy+LCKG2MNJdl4R/sJqWOCRXB2Bi3gv5Mvt1ILh/kc3mSji5uAGbRrwZjh1GD7+sdKeSD4/mLV5pHWeXbP555WxtgBzsN/TXYYBgVnBHz8Hn5JiMALu8twdyfXpHI5Fb088QZv5lSq5Vl/KVWKNqnHLgnKBZttXOA8eCQ9uWAiQPdCq2xADnIH+nPYWrlGFB1hWpYJfz/ghJIDHEI02ZocXaQztx8d76XJqougumwFkyDbdJ/8z+haZQdT8ASQdVfiODlu5Mvo+AMjVsD/sApwjyLsFopdAP6qXyYc6rmOwcbRnfUs19RkWpM+xhTK1O9eWlKfx/MvKRSgxDbGSBzdDm+iMRpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ry8cTlDjNgCZWkHSyOZhsjQTDebyMdMMugDV6blWu+8VYy0Jzu9Ap4vpa+vyyL+aBRpvmxcri/b0rewoLmiK6YDfdMuSgEo1XXUghDnpQBOEuJXoKO+ZmR+8y+8erSCxkSjh+n7o53whKszyVm62HEZ23xz5zOnp4cTFx8XiGu7Q9JKL7G3KJvOqSl3mQuaLbQmVwPHH1a3hPQoNVn6429wjcEVQC49W+PwVXmI/TO9yuSp+ShSgnL1UwursSWWI9g7tUrX7MipKnx4Bj2Cirvu+Jd4M4+RhAop994nEAPO6B7RAwHXxZN09mriZnzAB5xd/e6nUal3hx3V2CGXqzZzT0rSMNxhKC1Zn9vmwXBuFQ9h1owYCBvUh6hAB94kY84Ht+5V3B3saGu01RVOQDWkfEkSjnlz0fuDuDMny3kr11IWvv1pVpOBcO3Wjc2p5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:33.9521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3496b1b-ad80-433d-623e-08dece07386c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
There is an updated workaround for PG Repeater issue in DCN42. This PR is
addressing the dynamic power gating use cases (Driver PG) to align with
the new sequence.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    | 18 +++-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  1 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   | 97 +++++++++++++------
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   | 22 ++++-
 5 files changed, 99 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 6cbc1f4ef411..616a896f0782 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -77,7 +77,7 @@ void dccg42_otg_drop_pixel(struct dccg *dccg,
 	}
 }

-void dccg42_enable_global_fgcg(struct dccg *dccg, bool value)
+void dccg42_enable_global_fgcg(struct dccg *dccg, bool enable)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);

@@ -85,9 +85,18 @@ void dccg42_enable_global_fgcg(struct dccg *dccg, bool value)
 	 * Fine grain control via bit2 of debug flag.
 	 */
 	if (dccg->ctx->dc->debug.disable_clock_gate || (dccg->ctx->dc->debug.iommu_mismatch_temp_wka & 0x4))
-		value = false;
+		enable = false;

-	REG_UPDATE(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, !value);
+	REG_UPDATE(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, !enable);
+}
+
+bool dccg42_get_global_fgcg_status(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t disabled = 0;
+
+	REG_GET(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, &disabled);
+	return disabled & 0x1;
 }

 void dccg42_set_physymclk(
@@ -339,7 +348,8 @@ static const struct dccg_funcs dccg42_funcs = {
 	.dccg_root_gate_disable_control = dccg35_root_gate_disable_control,
 	.dccg_read_reg_state = dccg31_read_reg_state,
 	.dccg_enable_global_fgcg = dccg42_enable_global_fgcg,
-	.allow_clock_gating = dccg2_allow_clock_gating
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.dccg_get_global_fgcg_status = dccg42_get_global_fgcg_status,
 };

 struct dccg *dccg42_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index a2b17ed11bdb..ebd3cec1a977 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -247,6 +247,7 @@ void dccg42_otg_add_pixel(struct dccg *dccg,
 void dccg42_otg_drop_pixel(struct dccg *dccg,
 		uint32_t otg_inst);
 void dccg42_enable_global_fgcg(struct dccg *dccg, bool value);
+bool dccg42_get_global_fgcg_status(struct dccg *dccg);

 void dccg42_set_physymclk(
 		struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 6db7c8753081..e756719308ab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -348,6 +348,7 @@ struct dccg_funcs {
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 	void (*dccg_read_reg_state)(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
 	void (*dccg_enable_global_fgcg)(struct dccg *dccg, bool enable);
+	bool (*dccg_get_global_fgcg_status)(struct dccg *dccg);
 };

 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 729c2b653161..94361e326c56 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -22,6 +22,45 @@
 #define DC_LOGGER \
 	pg_cntl->ctx->logger

+/*
+ * ONO PG Workoaround: Saved FGCG repeaters states captured before powering up an ONO
+ * domain so it can be restored once the domain is powered up.
+ */
+struct dcn42_global_fgcg_rep_state {
+	uint32_t dmu_rep_fgcg;
+	uint32_t dccg_global_ono_rep_fgcg;
+	uint32_t az_rep_fgcg;
+};
+
+/* Save and disable FGCG repeaters before powering up the ONO domain. */
+static void pg_cntl42_save_and_disable_global_fgcg_rep(struct pg_cntl *pg_cntl,
+		struct dcn42_global_fgcg_rep_state *state)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+
+	REG_GET(DMU_CLK_CNTL, LONO_FGCG_REP_DIS, &state->dmu_rep_fgcg);
+	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_get_global_fgcg_status)
+		state->dccg_global_ono_rep_fgcg = pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_get_global_fgcg_status(pg_cntl->ctx->dc->res_pool->dccg);
+	REG_GET(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, &state->az_rep_fgcg);
+
+	REG_UPDATE(DMU_CLK_CNTL, LONO_FGCG_REP_DIS, 1);
+	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
+			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, false);
+	REG_UPDATE(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, 1);
+}
+
+/* Restore FGCG repeaters after the ONO domains are powered up. */
+static void pg_cntl42_restore_global_fgcg_rep(struct pg_cntl *pg_cntl,
+		struct dcn42_global_fgcg_rep_state *state)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+
+	REG_UPDATE(DMU_CLK_CNTL, LONO_FGCG_REP_DIS, state->dmu_rep_fgcg);
+	if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
+			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, state->dccg_global_ono_rep_fgcg);
+	REG_UPDATE(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, state->az_rep_fgcg);
+}
+
 static bool pg_cntl42_dsc_pg_status(struct pg_cntl *pg_cntl, unsigned int dsc_inst)
 {
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
@@ -54,6 +93,7 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl = 0;
+	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
 	bool block_enabled;

 	/*need to enable dscclk regardless DSC_PG*/
@@ -81,10 +121,9 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, false);
-	}
+	if (power_on)
+		pg_cntl42_save_and_disable_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	switch (dsc_inst) {
 	case 0: /* DSC0 */
 		REG_UPDATE(DOMAIN16_PG_CONFIG,
@@ -123,10 +162,8 @@ void pg_cntl42_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 		break;
 	}

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, true);
-	}
+	if (power_on)
+		pg_cntl42_restore_global_fgcg_rep(pg_cntl, &fgcg_rep_state);

 	if (dsc_inst < MAX_PIPES)
 		pg_cntl->pg_pipe_res_enable[PG_DSC][dsc_inst] = power_on;
@@ -174,6 +211,7 @@ void pg_cntl42_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
 	bool block_enabled;
 	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
 		       pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
@@ -196,10 +234,8 @@ void pg_cntl42_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, false);
-	}
+	if (power_on)
+		pg_cntl42_save_and_disable_global_fgcg_rep(pg_cntl, &fgcg_rep_state);

 	switch (hubp_dpp_inst) {
 	case 0:
@@ -227,10 +263,9 @@ void pg_cntl42_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 		break;
 	}

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, true);
-	}
+	if (power_on)
+		pg_cntl42_restore_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	DC_LOG_DEBUG("HUBP DPP instance %d, power %s", hubp_dpp_inst,
 		power_on ? "ON" : "OFF");

@@ -258,6 +293,7 @@ void pg_cntl42_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
 	uint32_t power_forceon;
+	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
 	bool block_enabled;

 	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -282,17 +318,15 @@ void pg_cntl42_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, false);
-	}
+	if (power_on)
+		pg_cntl42_save_and_disable_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	REG_UPDATE(DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
 	REG_WAIT(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, true);
-	}
+	if (power_on)
+		pg_cntl42_restore_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	pg_cntl->pg_res_enable[PG_HPO] = power_on;
 }

@@ -466,6 +500,7 @@ void pg_cntl42_dio_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
+	struct dcn42_global_fgcg_rep_state fgcg_rep_state = {0};
 	bool block_enabled;

 	bool skip_pg = pg_cntl->ctx->dc->debug.ignore_pg ||
@@ -486,18 +521,16 @@ void pg_cntl42_dio_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, false);
-	}
+	if (power_on)
+		pg_cntl42_save_and_disable_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	/* DIO */
 	REG_UPDATE(DOMAIN26_PG_CONFIG, DOMAIN_POWER_GATE, power_gate);
 	REG_WAIT(DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, pwr_status, 1, 1000);

-	if (power_on) {
-		if (pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg)
-			pg_cntl->ctx->dc->res_pool->dccg->funcs->dccg_enable_global_fgcg(pg_cntl->ctx->dc->res_pool->dccg, true);
-	}
+	if (power_on)
+		pg_cntl42_restore_global_fgcg_rep(pg_cntl, &fgcg_rep_state);
+
 	pg_cntl->pg_res_enable[PG_DIO] = power_on;

 }
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
index 7e8f4f03ae0e..813fa5c81172 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
@@ -34,7 +34,9 @@
 	SR(DOMAIN24_PG_STATUS), \
 	SR(DOMAIN25_PG_STATUS), \
 	SR(DOMAIN26_PG_STATUS), \
-	SR(DC_IP_REQUEST_CNTL)
+	SR(DC_IP_REQUEST_CNTL), \
+	SR(DMU_CLK_CNTL), \
+	SR(AZ_CLOCK_CNTL)

 #define PG_CNTL_REG_LIST_DCN42B()\
 	SR(DOMAIN0_PG_CONFIG), \
@@ -63,7 +65,9 @@
 	SR(DOMAIN24_PG_STATUS), \
 	SR(DOMAIN25_PG_STATUS), \
 	SR(DOMAIN26_PG_STATUS), \
-	SR(DC_IP_REQUEST_CNTL)
+	SR(DC_IP_REQUEST_CNTL), \
+	SR(DMU_CLK_CNTL), \
+	SR(AZ_CLOCK_CNTL)

 #define PG_CNTL_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -121,7 +125,9 @@
 	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
 	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
-	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
+	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh), \
+	PG_CNTL_SF(DMU_CLK_CNTL, LONO_FGCG_REP_DIS, mask_sh), \
+	PG_CNTL_SF(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, mask_sh)

 /* Not in DCN42B:
  * PG_CNTL_SF(DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),
@@ -178,7 +184,9 @@
 	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
 	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
-	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
+	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh), \
+	PG_CNTL_SF(DMU_CLK_CNTL, LONO_FGCG_REP_DIS, mask_sh), \
+	PG_CNTL_SF(AZ_CLOCK_CNTL, AZ_GLOBAL_FGCG_REP_DIS, mask_sh)

 struct pg_cntl_shift {
 	uint8_t IP_REQUEST_EN;
@@ -186,6 +194,8 @@ struct pg_cntl_shift {
 	uint8_t DOMAIN_POWER_GATE;
 	uint8_t DOMAIN_DESIRED_PWR_STATE;
 	uint8_t DOMAIN_PGFSM_PWR_STATUS;
+	uint8_t LONO_FGCG_REP_DIS;
+	uint8_t AZ_GLOBAL_FGCG_REP_DIS;
 };
 struct pg_cntl_mask {
 	uint32_t IP_REQUEST_EN;
@@ -193,6 +203,8 @@ struct pg_cntl_mask {
 	uint32_t DOMAIN_POWER_GATE;
 	uint32_t DOMAIN_DESIRED_PWR_STATE;
 	uint32_t DOMAIN_PGFSM_PWR_STATUS;
+	uint32_t LONO_FGCG_REP_DIS;
+	uint32_t AZ_GLOBAL_FGCG_REP_DIS;
 };

 struct pg_cntl_registers {
@@ -224,6 +236,8 @@ struct pg_cntl_registers {
 	uint32_t DOMAIN24_PG_STATUS;
 	uint32_t DOMAIN25_PG_STATUS;
 	uint32_t DOMAIN26_PG_STATUS;
+	uint32_t DMU_CLK_CNTL;
+	uint32_t AZ_CLOCK_CNTL;
 };

 struct dcn_pg_cntl {
--
2.54.0

