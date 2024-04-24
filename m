Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4DC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AEA11394C;
	Wed, 24 Apr 2024 08:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Erpvokum";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF5A11394C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLAK+fcwevC3o0rQbWGo5A7vyLef2JFmiJIM4jgOVzHLzLWPuNMpZMFS/XrDhOs02ZG6SI1pBO9OlUGO0InLV5ava7aXBRym/22O4hZtLtENFI7+vvdUE7WbQxtyCSneatO7itZIbfYJrxIixOZ56gHrJYxSu4I4iwwKoBkEmHUjsldqPjdPClP1NvjQjBzBj3+0+uvtwF8vQh6Pelx0i0+anXhGOQ7m8a1Vk05CN/CZdWF2s8EL+XtQ8KWK6I5x0eF3skWh4E2yb0Pe9dN357AceyfIi/bBc87MncjznWdUW3ddvZrDbVbRgChlxgsXR35TTjrZXYJcrMAdwXtzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+i2dCe3zX8D3e0nHDsAupAiae4PrgZ9xOamSyk0XOc=;
 b=RSXigJWj+jOCa846r0GSfTJHvUiXVrAJ3z8/H/LtYUQTQSOR1cs7B9T5/wR/H6jvaK9ZE75eirg4YaURR36OGlryPnVxsIEqfYJJxvmj5pTh7xwnbAIJnOfQaM7mJ+3mPb4OJE5CiGUUjVmgusqcQELg3V3Gms2QQ/rbKmsx4+TSxYWjG2w3AecR9fxflHf1X4bw7kBGHsVp2ELJ2GqIXBrPEKsxJ7/5zRGRb7RCd03jrLSzuYjsLnOL+nQMHROBPLUSva0dyvx6911lcL3gP1InD0d1zMtT5qNunC8j0o4mFZeGRoBxXKbzGg6AC+CVxMzpJCCq9Xt2PZPviwyZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+i2dCe3zX8D3e0nHDsAupAiae4PrgZ9xOamSyk0XOc=;
 b=ErpvokumBSjMnaRWU8CB0KYOGaUfvP5kQ5BQ2FpUkfeJXI4NPm+dO38U8mQaveg8zJst4th3lkW2K2JXBqGe7RxX+ECTRR4I2X2Zg6sp2hN/QBhXpNGHfWcQxV4SmcZrNGjvPrj7sJvz3T/N+TzxqBD6mSiCCIyLtgwcatbpqJU=
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:50:16 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::ac) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/46] drm/amd/display: Add NULL pointer check for kzalloc
Date: Wed, 24 Apr 2024 16:48:48 +0800
Message-ID: <20240424084931.2656128-4-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5383c0-cc61-4141-5a60-08dc643b901b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1R8XGlNeFRJGjPGQdTMgjIVP8E23ULuJHFWvExxx/oMalDZ5jwFo0ZV9tPSp?=
 =?us-ascii?Q?lskzpPlEnamZPUr9k40oyUqJ8Fe/x265wUsBtWKNZ363BZrbIEHgk3WCek/U?=
 =?us-ascii?Q?E+2AQfSoaSAm8E7oRzxFUfUeZFEfD8/fECNuJW6JyzkzBnay/r4oDhXu7le2?=
 =?us-ascii?Q?wTPQ3zrHTNGlgA+c24RQHz1JE0J1aeJY/eI0m0dyNsf6a+hqW89n+bebhiPH?=
 =?us-ascii?Q?LG6SBAoHP6R2HKSMNWmUTd6vF7s+RV91No/4uUMv1F6EmHXWpeW3c/xJGPYo?=
 =?us-ascii?Q?lgIf9hsQFdwXy7IN3CxeznOkYlpYHzOnvzDa0TEW50Pjn7AvJN9CSnQq5OrB?=
 =?us-ascii?Q?50mYg0FoDA0Jc2ne0W/r5E5GeKO6rR6OTdVvYsUuaLES3zaMOG4/pWfttrVV?=
 =?us-ascii?Q?guQjfoW46vn4e7rljjT7+hPNxFFZY1vENcKnVFnS2BnKMg4PEQ8xEoU6s6yo?=
 =?us-ascii?Q?/Pm1rQPk8sAuq6C0InhnqfWVXdmFCw/+BGzkkNYyRbe2vUJ9EECfXeYt1VUK?=
 =?us-ascii?Q?K6N3JuWP0xul8RE0qLjBnLsQJpzVAvrgal/l0f4EIW3Fmut/cQMdVKyZfnjg?=
 =?us-ascii?Q?v8zklznKBpzUIcUh88tln9+KqUQke96Nmchm3DHrOBOqYN+wzPWX4tqn+uKI?=
 =?us-ascii?Q?rSe7rYBxOgeYTYQw1WC7k7YbZ9ag1J7JK3x6JxG+7mUEJYTMwjfdAbghIKW1?=
 =?us-ascii?Q?BJBI+L4112/M7GQNmBHv+2b+NGZKshV/Ai+1U8QCyLw43GU8mp+7lcxPejJq?=
 =?us-ascii?Q?t3ed323F1PRpCyMyh9HB1PUDZKR1X+PCGxqKWrLb55D0lZkzq12Nfq3xb4p0?=
 =?us-ascii?Q?Y9vLpyvu4apRfxtgPDeWU11NJnihEWDWncmwkaQSC0WZc8wdD9jk0bKJVSCX?=
 =?us-ascii?Q?2ZnNwPCnR7FgwH+c1zti+D61Eb6QRnIDOubvL+CTTx1kfARDK8KL70DMhT8t?=
 =?us-ascii?Q?aCdXuDPCFYaW4uv2aqIroZVGppg2Dg9Io6IO33s2kqGNdLe8Fu50GsVRaHik?=
 =?us-ascii?Q?uklYLKrsC3DYPGCQJBlrsKqeXv7JEvFDx1UkhqDohO47yb/FBxfllO9BPrrS?=
 =?us-ascii?Q?fRodtl0eXocA6ew9BUZE2BbgKHEslVyXgZO9yfWl1uBpos1DSXLeACoH9efm?=
 =?us-ascii?Q?tDaI5Wsvpn8i+e8KnPk/vlzW3Il5KyOd+YAYTyxZ10j7H6WYA9gqUwOhjfIB?=
 =?us-ascii?Q?K5R6bDklW+YVRdQUY7AJwmq4tbcF0dXzy0x0qXVfRA2ePs7D4QHomilINmBI?=
 =?us-ascii?Q?82wtUHlwE3DtIoNHraFt3BD+S3gKTbl4l8aE7QDCy+CA4DiZSoj/JUb7I0vH?=
 =?us-ascii?Q?vdnLKLTSlCgjXC4QHLb+6mK2PKawFXxALIzBrbPQTMb6CYQ4by4z6h5yR6Ws?=
 =?us-ascii?Q?XZYXEENwUygKnV1Sfp5v0jAKv6IS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:16.3015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5383c0-cc61-4141-5a60-08dc643b901b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
Check return pointer of kzalloc before using it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 8 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++++++
 .../drm/amd/display/dc/resource/dcn30/dcn30_resource.c    | 3 +++
 .../drm/amd/display/dc/resource/dcn31/dcn31_resource.c    | 5 +++++
 .../drm/amd/display/dc/resource/dcn314/dcn314_resource.c  | 5 +++++
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 5 +++++
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 2 ++
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 2 ++
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 2 ++
 11 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 4cb0db0ed92f..8083a553c60e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -560,11 +560,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index d7bbb0891398..b9e1f3e0b31d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -1199,11 +1199,19 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index d9e98abb3640..fa1305f04341 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2050,6 +2050,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ecec3b69bb88..d4c3e2754f51 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1310,6 +1310,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1766,6 +1768,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 3bae606ed700..ff50f43e4c00 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1367,6 +1367,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1727,6 +1729,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	if (filter_modes_for_single_channel_workaround(dc, context))
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 515ba435f759..4ce0f4bf1d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1309,6 +1309,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index e808231e8478..5fd52c5fcee4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1305,6 +1305,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d17241a882bd..022d320be1d5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1305,6 +1305,8 @@ static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
@@ -1752,6 +1754,9 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 3816678b044f..e4b360d89b3b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1288,6 +1288,8 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 25ac450944e7..2df8a742516c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1368,6 +1368,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index ed98bfd9622a..982526c41d55 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1348,6 +1348,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
-- 
2.37.3

