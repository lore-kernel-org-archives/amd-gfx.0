Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18090C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B820110FE2D;
	Wed, 24 Apr 2024 08:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DSJoH6Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A22F10FE2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcYqwFcJRRIeCy2ZBoQwyT8NJvig7L2NtBgH6G9FTBZ/DZntCPEADwJ2ba28DJYjGsYKgbjULSEFQ8Zk73b97a1cayjnIb0DszRUa5iwrtacX0JLe5ohMjaSB9bPgkB+tJN1lij0iELWW/aBeH88+bJ7NJAo6+rQ6GBS3TxUCymA5H5zrSD9eqlLUwbDsD6wlQYde4Mn3YdmRicCqpDM5LB9ReuNiFV5+ri34/PXOGoUbDmAw/IVpxlqmSsamRKa7CWjiy3GtEQFLzG5nUG27YqZbQZjkXn6HWpVIdBl3DOFJwp8Toyb0P3B8GhUTtzl6qNbom4Je+foLeOksmsUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/MXmpB3bQyBPAKLLI+2kdoqW+TBeUE6bWtQqujQgpw=;
 b=MAvzqtqNSUs6sYgFGpZN+9n5JrhA2kEjbk2zMCtCZqiog6uyFvf/vah25bd1ZKZ6fXHGp6GZebuQ4xQWBdL/mqLnyX8bIXdoq0Z9Mdcv78pgVahGt5KgjNAGnrzt4YAP/adwQZkis31tQvoDBLUnAti6EptGLx7cnSb9tx8wSX+n1GWWNOF/g7jwzMrCFRBdCn2q9Zoj2TaIktjkT9aWitettjTX3Fqh0HvWnFOF9A7T9dRnMQroL1RNlQ5yoN9N1zcuYcPrgeQD012MmstLBofn4ttf9crDF4lvmi8u5auwVU6LovFAdQRp1pgsS+tXlyYITZw3DZcoWzdE6Q6VKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/MXmpB3bQyBPAKLLI+2kdoqW+TBeUE6bWtQqujQgpw=;
 b=4DSJoH6QIev4n4ie+lJ/zTgjh0nyZbCEEc42k77liJkHmUCbA72a9kBSv21xkZRe9aqHmk1DdBew2XMsoA3o79MZB6nKi1GDFIz4yz/mcI6i5kler0m2blTmlSfJi6FI/5YyNMFUbj+2GW7RnqJPVpa29Q7IOEqr8zn81C+PY4I=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:41 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::fe) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.36 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:40 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 37/46] drm/amd/display: Fix uninitialized variables in DC
Date: Wed, 24 Apr 2024 16:49:22 +0800
Message-ID: <20240424084931.2656128-38-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1253b71a-91e7-47ca-7c89-08dc643c0a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RElRF4Ri/6ELkFXR2EOlOkY4MZo3cAwDArdriIvPkBtWo/QcL/6GhtwOLQ/v?=
 =?us-ascii?Q?EP+vpyoW6ey6HUTNDFDla/hKm318wSsnLsP2KA9/Zgbfhg82sTq9t5kY2uaN?=
 =?us-ascii?Q?0zc+YuaTC7s8lJfJJJHiKmP9gqiWJkjJnOYKMbp6Q1Fqbmi9lamZ8ZwX9uiA?=
 =?us-ascii?Q?JqYeObVxSKgzoiYIaX5LyBcMpPZbleoNr+H2PnPDBd7U3J06tX84fdrMlBLg?=
 =?us-ascii?Q?dpvnu224AH7qmjnneyk0oKno7vbODPNsYuyxW8xPRRGTjk3/5xhLwGgHfZHD?=
 =?us-ascii?Q?gc4c8mt+gmnxbWSL4TS13XxSa2m5BduSD5az6756vIc/lWuQM0HyFT2YmUUX?=
 =?us-ascii?Q?57y30NfU3QXtIAJnaUp/jQx7K0ugEZnyZAsLnOCvtpLsYGYZs6niRw1Huq0n?=
 =?us-ascii?Q?yf05wuOXRJ4irvdQc9EF86IoeWAyJnegAKWYBpA64xYCpvVhVf0AxMuqgvXm?=
 =?us-ascii?Q?sH0fOeaXUfhKOLsc6hWsIviOsSplmYoDIeuUQzZeS04ECZwSSkV3S2qecOu0?=
 =?us-ascii?Q?1w2rs0wEPmOovyRiQiAxHvgHX0/Ay2aly1JMPynLQS50HztQZU536e8eZB3j?=
 =?us-ascii?Q?+qFSt2IBhWhVrcGLIknwbQiI2AqKwGvTXqNF/fU/yW5AJHB970NQindlqaxK?=
 =?us-ascii?Q?jViICtYDFfEr4KRDEU5M3yWPCRzMHT+YlvPbuXi7b9yCor4Eq7JTekoLjSNt?=
 =?us-ascii?Q?WoivdwbZkcD0PAB+gF9BwLHtz7+1nvCGlPLJt/d0Tyu1U8cnxMQzBJfZVjtC?=
 =?us-ascii?Q?K59YN0ftTd0EwZD7SNTya8y8mTZURf/tLin8DKhBvObBTpZQrRhgHFVvpwPO?=
 =?us-ascii?Q?vdo/Y7uJm/p9CMRIRGlgUyz6p8JeWPf6Xe3GQjSbEKNT12OiK6ibJ6WlXV6L?=
 =?us-ascii?Q?qXEZHNrnbg4RTtHZ2j3PKcbUqkNgzKmAzRBBobsFGwP/eqqszcMdWypf3s06?=
 =?us-ascii?Q?FxQ6/KlqEQNI4Oq7lDXODAH2F1TIJ1Pn/Op0lTX67YniAqhuRlwnDfWzc+H1?=
 =?us-ascii?Q?2N1bO5e63C+zwKobuD5mJihV97nCQ5/0tjHx1l2iAKBbseryQHuZ9xk6ZdNI?=
 =?us-ascii?Q?BqDDCuCAHIkiXuGyJ/L10o0VWO0xNvGTQ9TF+I/cjTfN2VxlCp5F6tdp0PUq?=
 =?us-ascii?Q?4EHopKjkJq4BrS778/wTkNJGPWMXC8mM8t+QmzOBr9pB9fpIWT+dcyLQVhfg?=
 =?us-ascii?Q?eSJB+eVfRKFG4suVc4J6p3y1wim9ISioBY1ppu/3u9Q/7EdmnIQqs7BDGSln?=
 =?us-ascii?Q?pRTvhz7o7OcHRTJE5cp6X0yQy/CifJ66y3P3+of/9c466CKuA0E0ut5YFiEa?=
 =?us-ascii?Q?9OvvWSQwifcookMKqabr3Elci1IfpyLQV9SIRVf3smupWNIZz/gDTBAnKb8b?=
 =?us-ascii?Q?4Z9STVPXU/cdc/xtc9Y9DKG1MTBF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:41.2057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1253b71a-91e7-47ca-7c89-08dc643c0a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

From: Alex Hung <alex.hung@amd.com>

This fixes 49 UNINIT issues reported by Coverity.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c         |  4 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c |  2 +-
 .../amd/display/dc/dml2/dml2_dc_resource_mgmt.c  |  2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c  |  2 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c  |  2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c  |  2 +-
 .../gpu/drm/amd/display/dc/gpio/gpio_service.c   |  6 +++---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c    |  4 ++--
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  6 +++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c    |  2 +-
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c  |  2 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c  |  8 ++++----
 .../dc/link/protocols/link_dp_capability.c       | 16 ++++++++--------
 .../dc/link/protocols/link_dp_irq_handler.c      | 10 +++++-----
 .../dc/link/protocols/link_edp_panel_control.c   |  4 ++--
 .../drm/amd/display/dc/link/protocols/link_hpd.c |  2 +-
 18 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 71f211bb4ed8..a8eb286ee4ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1310,7 +1310,7 @@ static void disable_vbios_mode_if_required(
 
 		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			unsigned int enc_inst, tg_inst = 0;
-			unsigned int pix_clk_100hz;
+			unsigned int pix_clk_100hz = 0;
 
 			enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
 			if (enc_inst != ENGINE_ID_UNKNOWN) {
@@ -1796,7 +1796,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 
 	if (dc_is_dp_signal(link->connector_signal)) {
-		unsigned int pix_clk_100hz;
+		unsigned int pix_clk_100hz = 0;
 		uint32_t numOdmPipes = 1;
 		uint32_t id_src[4] = {0};
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 263e21756481..ebbeb37f36a6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3084,7 +3084,7 @@ bool resource_update_pipes_for_plane_with_slice_count(
 	int i;
 	int dpp_pipe_count;
 	int cur_slice_count;
-	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct pipe_ctx *dpp_pipes[MAX_PIPES] = {0};
 	bool result = true;
 
 	dpp_pipe_count = resource_get_dpp_pipes_for_plane(plane,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index ebf6e9458be8..3aeb85ec40b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1183,7 +1183,7 @@ void mpc3_get_gamut_remap(struct mpc *mpc,
 			  struct mpc_grph_gamut_adjustment *adjust)
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
-	uint16_t arr_reg_val[12];
+	uint16_t arr_reg_val[12] = {0};
 	int select;
 
 	read_gamut_remap(mpc30, mpcc_id, arr_reg_val, &select);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a2ced0bc772c..507cff525f97 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -901,7 +901,7 @@ static unsigned int get_source_mpc_factor(const struct dml2_context *ctx,
 		struct dc_state *state,
 		const struct dc_plane_state *plane)
 {
-	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct pipe_ctx *dpp_pipes[MAX_PIPES] = {0};
 	int dpp_pipe_count = ctx->config.callbacks.get_dpp_pipes_for_plane(plane,
 			&state->res_ctx, dpp_pipes);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 2d5d64276cb0..f2a2d53e9689 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -234,7 +234,7 @@ void dpp1_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust)
 {
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
-	uint16_t arr_reg_val[12];
+	uint16_t arr_reg_val[12] = {0};
 	enum gamut_remap_select select;
 
 	read_gamut_remap(dpp, arr_reg_val, &select);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
index f43fa29971f2..31613372e214 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
@@ -274,7 +274,7 @@ void dpp2_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust)
 {
 	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
-	uint16_t arr_reg_val[12];
+	uint16_t arr_reg_val[12] = {0};
 	enum dcn20_gamut_remap_select select;
 
 	read_gamut_remap(dpp, arr_reg_val, &select);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index ce1b3cf7e1bb..82eca0e7b7d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -445,7 +445,7 @@ void dpp3_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust)
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
-	uint16_t arr_reg_val[12];
+	uint16_t arr_reg_val[12] = {0};
 	int select;
 
 	read_gamut_remap(dpp, arr_reg_val, &select);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 3ede6e02c3a7..663c17f52779 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -128,7 +128,7 @@ struct gpio *dal_gpio_service_create_irq(
 	uint32_t offset,
 	uint32_t mask)
 {
-	enum gpio_id id;
+	enum gpio_id id = 0;
 	uint32_t en;
 
 	if (!service->translate.funcs->offset_to_id(offset, mask, &id, &en)) {
@@ -144,7 +144,7 @@ struct gpio *dal_gpio_service_create_generic_mux(
 	uint32_t offset,
 	uint32_t mask)
 {
-	enum gpio_id id;
+	enum gpio_id id = 0;
 	uint32_t en;
 	struct gpio *generic;
 
@@ -178,7 +178,7 @@ struct gpio_pin_info dal_gpio_get_generic_pin_info(
 	enum gpio_id id,
 	uint32_t en)
 {
-	struct gpio_pin_info pin;
+	struct gpio_pin_info pin = {0};
 
 	if (service->translate.funcs->id_to_offset) {
 		service->translate.funcs->id_to_offset(id, en, &pin);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5920d1825a4c..0d3ea291eeee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1537,7 +1537,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		struct audio_output audio_output;
+		struct audio_output audio_output = {0};
 
 		build_audio_output(context, pipe_ctx, &audio_output);
 
@@ -2260,7 +2260,7 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
-				struct audio_output audio_output;
+				struct audio_output audio_output = {0};
 
 				build_audio_output(context, pipe_ctx, &audio_output);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 469f4a52f4f5..b3984e8cab64 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2186,7 +2186,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 	struct dc_crtc_timing *hw_crtc_timing;
 	uint64_t phase[MAX_PIPES];
 	uint64_t modulo[MAX_PIPES];
-	unsigned int pclk;
+	unsigned int pclk = 0;
 
 	uint32_t embedded_pix_clk_100hz;
 	uint16_t embedded_h_total;
@@ -2277,7 +2277,7 @@ void dcn10_enable_vblanks_synchronization(
 	struct dc_context *dc_ctx = dc->ctx;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
-	int i, width, height, master;
+	int i, width = 0, height = 0, master;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -2343,7 +2343,7 @@ void dcn10_enable_timing_synchronization(
 	struct dc_context *dc_ctx = dc->ctx;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
-	int i, width, height;
+	int i, width = 0, height = 0;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 7f7b6bf76a8d..59f46df01551 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -170,7 +170,7 @@ void dcn201_init_blank(
 	struct tg_color black_color = {0};
 	struct output_pixel_processor *opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
+	uint32_t otg_active_width = 0, otg_active_height = 0;
 
 	/* program opp dpg blank color */
 	color_space = COLOR_SPACE_SRGB;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 7252f5f781f0..804be977ea47 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -66,7 +66,7 @@ static void mmhub_update_page_table_config(struct dcn_hubbub_phys_addr_config *c
 
 int dcn21_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config)
 {
-	struct dcn_hubbub_phys_addr_config config;
+	struct dcn_hubbub_phys_addr_config config = {0};
 
 	config.system_aperture.fb_top = pa_config->system_aperture.fb_top;
 	config.system_aperture.fb_offset = pa_config->system_aperture.fb_offset;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 9ab475a87545..1c8abb417b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -479,7 +479,7 @@ void dcn31_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool p
 
 int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_space_config *pa_config)
 {
-	struct dcn_hubbub_phys_addr_config config;
+	struct dcn_hubbub_phys_addr_config config = {0};
 
 	config.system_aperture.fb_top = pa_config->system_aperture.fb_top;
 	config.system_aperture.fb_offset = pa_config->system_aperture.fb_offset;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e490dddd0424..16549068d836 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -726,7 +726,7 @@ static void set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 
 static void enable_mst_on_sink(struct dc_link *link, bool enable)
 {
-	unsigned char mstmCntl;
+	unsigned char mstmCntl = 0;
 
 	core_link_read_dpcd(link, DP_MSTM_CTRL, &mstmCntl, 1);
 	if (enable)
@@ -804,7 +804,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 	if (enable) {
 		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg;
+		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
@@ -1580,7 +1580,7 @@ static bool write_128b_132b_sst_payload_allocation_table(
 				break;
 			}
 		} else {
-			union dpcd_rev dpcdRev;
+			union dpcd_rev dpcdRev = {0};
 
 			if (core_link_read_dpcd(
 					link,
@@ -2124,7 +2124,7 @@ static enum dc_status enable_link_dp_mst(
 		struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
-	unsigned char mstm_cntl;
+	unsigned char mstm_cntl = 0;
 
 	/* sink signal type after MST branch is MST. Multiple MST sinks
 	 * share one link. Link DP PHY is enable or training only once.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 289f5d133342..a01d0842bf8e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -992,7 +992,7 @@ enum dp_link_encoding mst_decide_link_encoding_format(const struct dc_link *link
 
 static void read_dp_device_vendor_id(struct dc_link *link)
 {
-	struct dp_device_vendor_id dp_id;
+	struct dp_device_vendor_id dp_id = {0};
 
 	/* read IEEE branch device id */
 	core_link_read_dpcd(
@@ -1087,7 +1087,7 @@ static void get_active_converter_info(
 	}
 
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_11) {
-		uint8_t det_caps[16]; /* CTS 4.2.2.7 expects source to read Detailed Capabilities Info : 00080h-0008F.*/
+		uint8_t det_caps[16] = {0}; /* CTS 4.2.2.7 expects source to read Detailed Capabilities Info : 00080h-0008F.*/
 		union dwnstream_port_caps_byte0 *port_caps =
 			(union dwnstream_port_caps_byte0 *)det_caps;
 		if (core_link_read_dpcd(link, DP_DOWNSTREAM_PORT_0,
@@ -1172,7 +1172,7 @@ static void get_active_converter_info(
 	set_dongle_type(link->ddc, link->dpcd_caps.dongle_type);
 
 	{
-		struct dp_sink_hw_fw_revision dp_hw_fw_revision;
+		struct dp_sink_hw_fw_revision dp_hw_fw_revision = {0};
 
 		core_link_read_dpcd(
 			link,
@@ -1242,7 +1242,7 @@ static void apply_usbc_combo_phy_reset_wa(struct dc_link *link,
 
 bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 {
-	uint8_t dpcd_data[16];
+	uint8_t dpcd_data[16] = {0};
 	uint32_t read_dpcd_retry_cnt = 3;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	union dp_downstream_port_present ds_port = { 0 };
@@ -1408,7 +1408,7 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 
 static void retrieve_cable_id(struct dc_link *link)
 {
-	union dp_cable_id usbc_cable_id;
+	union dp_cable_id usbc_cable_id = {0};
 
 	link->dpcd_caps.cable_id.raw = 0;
 	core_link_read_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX,
@@ -1475,7 +1475,7 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8];
+	uint8_t lttpr_dpcd_data[8] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
 
@@ -1931,8 +1931,8 @@ void detect_edp_sink_caps(struct dc_link *link)
 	uint32_t entry;
 	uint32_t link_rate_in_khz;
 	enum dc_link_rate link_rate = LINK_RATE_UNKNOWN;
-	uint8_t backlight_adj_cap;
-	uint8_t general_edp_cap;
+	uint8_t backlight_adj_cap = 0;
+	uint8_t general_edp_cap = 0;
 
 	retrieve_link_cap(link);
 	link->dpcd_caps.edp_supported_link_rates_count = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 7dc7c25ac398..659b8064d361 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -120,7 +120,7 @@ bool dp_parse_link_loss_status(
 
 static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 {
-	union dpcd_psr_configuration psr_configuration;
+	union dpcd_psr_configuration psr_configuration = {0};
 
 	if (!link->psr_settings.psr_feature_enabled)
 		return false;
@@ -186,9 +186,9 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 
 static void handle_hpd_irq_replay_sink(struct dc_link *link)
 {
-	union dpcd_replay_configuration replay_configuration;
+	union dpcd_replay_configuration replay_configuration = {0};
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
-	union psr_error_status replay_error_status;
+	union psr_error_status replay_error_status = {0};
 
 	if (!link->replay_settings.replay_feature_enabled)
 		return;
@@ -280,7 +280,7 @@ void dp_handle_link_loss(struct dc_link *link)
 static void read_dpcd204h_on_irq_hpd(struct dc_link *link, union hpd_irq_data *irq_data)
 {
 	enum dc_status retval;
-	union lane_align_status_updated dpcd_lane_status_updated;
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
 
 	retval = core_link_read_dpcd(
 			link,
@@ -320,7 +320,7 @@ enum dc_status dp_read_hpd_rx_irq_data(
 		/* Read 14 bytes in a single read and then copy only the required fields.
 		 * This is more efficient than doing it in two separate AUX reads. */
 
-		uint8_t tmp[DP_SINK_STATUS_ESI - DP_SINK_COUNT_ESI + 1];
+		uint8_t tmp[DP_SINK_STATUS_ESI - DP_SINK_COUNT_ESI + 1] = {0};
 
 		retval = core_link_read_dpcd(
 			link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 689c5fb44e86..ad9aca790dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -321,8 +321,8 @@ bool edp_is_ilr_optimization_required(struct dc_link *link,
 		struct dc_crtc_timing *crtc_timing)
 {
 	struct dc_link_settings link_setting;
-	uint8_t link_bw_set;
-	uint8_t link_rate_set;
+	uint8_t link_bw_set = 0;
+	uint8_t link_rate_set = 0;
 	uint32_t req_bw;
 	union lane_count_set lane_count_set = {0};
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index e3d729ab5b9f..caa617883f62 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -35,7 +35,7 @@
 
 bool link_get_hpd_state(struct dc_link *link)
 {
-	uint32_t state;
+	uint32_t state = 0;
 
 	dal_gpio_lock_pin(link->hpd_gpio);
 	dal_gpio_get_value(link->hpd_gpio, &state);
-- 
2.37.3

