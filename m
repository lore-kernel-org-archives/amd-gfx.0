Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248E2F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADEA10E1D9;
	Wed, 22 Apr 2026 03:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c77qWxhU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D383310E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql93E+QXOX0Acs9MT7PxUsTd+ozRGbAwcbcHQa1E4BXqhNxyJBrITr5QBqjNfKX/hXH9YbcIdO2wAP4f8Qg8hezOdP6ceRF+UMpaw/K55ZbUM06YvfDUvB4FsiOf9hQgNYSFdQSUXWZB/xDROx4wkg5jK+xFP9eLFuvkubO4C7vsZWxWAp7OJI8RmU2Kv4J3wzNfsonuGZEMTRRoKh2JoTxGBheuDZQmHb16WDhyZRNqcdoaxjhRCQ42BkipIpWg2Q4ZROxrWkA0Y+LbmdHhv+nY6nSvCUSDYiRAD6zuo+BWJpF8q4BFeAhIK3KsgiC6tQcA5p1rIiKVkb16UrUtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcyzbyAoJLh8KYrcgYzE/TDAFKAX6OSSuWUVDYk+vWs=;
 b=Wfvjf2s3PZx/EtilCQ+V137efguWrfVNqVaayY3iCBNJlsUmInWjYKWtdFFPkVM1GEvmD6TGI50Io0qvApr426d6ODtLSTeAa8vN9AYJEK2L3lN84BV9UB70yXwbl5wsWW7fu59EKocn2nKv+I6e9xyRgTi0t5CbKQ3vOvwgOTmZgBcQDTnp/1OZnTNKujIuSWPyP4MlRMhfoHOgzfc1xrT7ZFNAldEH3DEHiG/eJIwMijNUP5d5hcImfyOrSwnA0S9M0Gr/r2O1IvZU86gAWVgtWYEPaB7ceRRDVxnNwiC23zB/+57reRBPB8TXwD4jU8D0xOcHA7qZ1EoNgohy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcyzbyAoJLh8KYrcgYzE/TDAFKAX6OSSuWUVDYk+vWs=;
 b=c77qWxhUahbXEb38hUWT7TtZn6kulUjwAwXMTZ9hAM+qTUpkSAd8K93q4XjQzXePtjKIKCcNrTQpTuLGojRSyDyvEhVAFPO0RPmWDmjGFNqNTNa7ZV9sRrwO6583B5cbnwvPPUoDySs0KvmTlQejk0WtOY/M9AYRQp2y/+Jyp5k=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 03:56:35 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::4) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:34 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>
Subject: [PATCH 03/14] drm/amd/display: fix dual cursor shows on extend desktop
Date: Wed, 22 Apr 2026 11:52:41 +0800
Message-ID: <20260422035611.1870316-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb3ca3a-aa69-4051-4a73-08dea02325b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6VPu28Nczy9dWgXbO/ifmhOu2bujLT4JNJvaeot7fE0YjeJ6xw5qaCYcrM5f66WC4jeY/BddebC6qLlAyLmGCd8vY4JXl7ODRAjsB3Su7CJa5Re4r+BsIyybb9X0F3q2ZWp8+ajX7dcmfLCeAhw/bOtgs1nSaBv09wWkyQZ1fAXONyOK9Er2JUJWJ6vkP+1eD1QgAUck9XWmq0a8JwyetT1k1gYv9R9MSnGtC+FENeu/fyc9zdNORKbVbhih4b1UqtU2vU1KjBBBxUSpdH87gl46mNBBFFREKGwSsupeNunJYgo/Sff+mfzhwhcbZ4//preC8/fLhFj/OTON5h4GvkYCMSm46VEsftVxxRvA7QxyFlzW/zZqbxSkwaYZOhUTrzQc5m6L55FKFRKH10zuEmWa+Ct2GERxwF9jHNg9XWjzOtgNK+B4JoCmO3GrTlzYIYGsvKhubjkU+cvkHcE//PR2lO906j7hpeEhxXAL3QmJXkMVRNnlmtrI0QdgPMGIPKX+U7AZBjfkjlJGzmlB9IRueavC0ftAREtVJvZgcbJlv8mBDGnNnnnPMG0ntTkc6wJAVWf/sAZWnyvwC7u07Me3gUxT6VuCmKcurCcroa8zD3qYP29Yxxgz+/RUXJsTAg1KCDzsbr9b48oWyGJirtQjRGgp4pdwSZsBGhJgkOardyjKuzg/hyZ7K9MV8s+6gOfbavGa4LYGreX/YIx24c78nykMYcjAPPzxX1gNsysDI6uWKv8W/6GkgmXcxEZNoRTD1+c2O9v271FhrbBcSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7KmmIO4cUddOSox6bUNEBnpm/M+jGBS+1uyjThV0aC5rRUnT1JaiIA1fhq0gAIV3xFs1SPC4Wjf0wXicc/1Tw2d3h1C2hv9mAkrLfgOZQ9m2Gx8Tqzsj+lr4Mm7ZH0u1ONg6/44FPc4JB6PA1ZyMfoGZzfS5atkwuhBOkjICMxQbfDUZ6f51OBJdjPbPMvCG7yTSsEUBDKyid21ddR+IVHnlkfO0vuiBeu0S+V+qt7ZdrjQXT5Hpf+1qy+bLIxlJI0lG3p5de+rzRCTApoLQ7/E8GgYWZ2yBogP1qoJG8RDCTwWgiKVy/QEg2NlzX6OV9EiYLuedPfLINPU+7k17RIBFvNSzyyZ/3vkBtdM6ntgYNumqnEkxa1msdDtU4t0jnLiIdJfQ+ur8S0/iom1gV6W2kaOe9doaunvXX8r5XeqXYqbpEPYGceo10hiZlUB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:34.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb3ca3a-aa69-4051-4a73-08dea02325b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why & how]
when dpp pipe power gating disabled in driver, disable_pipe
did not disable cursor so next time as long as this pipe
powers up, it will be visible.

port dcn314 logic: disable cursor when it should be pipe pg.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c    | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
index b5d7ed5dd511..f60e084068c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
@@ -280,6 +280,14 @@ static void dpp42_dpp_setup(
 		dpp3_program_post_csc(dpp_base, color_space, select, NULL);
 	}
 }
+static void dcn42_dpp_force_disable_cursor(struct dpp *dpp_base)
+{
+	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
+
+	/* Force disable cursor */
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, 0);
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = 0;
+}
 
 static struct dpp_funcs dcn42_dpp_funcs = {
 	.dpp_program_gamcor_lut		= dpp3_program_gamcor_lut,
@@ -302,6 +310,7 @@ static struct dpp_funcs dcn42_dpp_funcs = {
 	.dpp_cm_hist_control        = dpp42_dpp_cm_hist_control,
 	.dpp_cm_hist_read           = dpp42_dpp_cm_hist_read,
 	.dpp_read_reg_state			= dpp30_read_reg_state,
+	.dpp_force_disable_cursor	= dcn42_dpp_force_disable_cursor,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 894d48fcd7f8..71d6f7db93a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -904,6 +904,13 @@ void dcn35_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx
 	if (!pipe_ctx->plane_res.hubp || pipe_ctx->plane_res.hubp->power_gated)
 		return;
 
+	if (dc->debug.disable_dpp_power_gate) {
+		/* Workaround for use case when disabled power gating set to 1 */
+		/* Force disable cursor if power gating is disabled */
+		struct dpp *dpp = pipe_ctx->plane_res.dpp;
+		if (dpp && dpp->funcs->dpp_force_disable_cursor)
+			dpp->funcs->dpp_force_disable_cursor(dpp);
+	}
 	if (hws->funcs.plane_atomic_disable)
 		hws->funcs.plane_atomic_disable(dc, pipe_ctx);
 
-- 
2.43.0

