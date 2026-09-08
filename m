Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F7DC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26A410E0DF;
	Tue,  8 Sep 2026 11:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CXn1w1oA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320F910E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ4vNJBf2y9swYECwAE7v3lmcfDYoOyffR/JT2lsj6TLkjlxhY9xDc3KE/6FFpANR0Fy/cGFgj91OpezgClDYWxqTooAqQ71o+M6nzniMgKU85sk92jo0lp1ElvbUFhWQpIJN1ftl753Me9Xn95i643PaMMtAiVipIkBx7rXyZXqhVOAY0c3C6cIkKyYE+byAHrQGfxwws3aJIpMuW7vP8sr3mPcOLIfCUgGDEcXE2QsyXndpQk3ayyDoA+uv1T0lCJGFSynknXKHqRCpxPygIB7ifxvLgizj+LlwqExvsJXbk1B8JrmpFUIAFgD7Ha9UFNb7RFDprgsqAZC8UMXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pigG3CYwBiZcEt6P4r2C72bN16do2Rco2nEITwATTpU=;
 b=rO8QRt2aSSKH2ZFBMr/EvoaXhzRnbJt7VquyBXc5cx8UcOjXgJhlT+gYwxlgaQWsN3eqRipHuV8m/0iwk8URhsE1JtL7SBdSZo57PYqY3cnYARiAjIo7NRkyVXOFpd5ZGgh1PhZo68eSOzjC1pVU5wTTXgi7pXrWlla+dGlzeilWvbIREhBnAx7C5HlW4Kazd5MXVjRtNcvxouCA6xk4FQ2JMrT05p/KGvA/4jaPwMIj0HdZMuGH1BIqLvTYibnvg2MtHidjk8DZ2t8vtcSlFsYdEmf5/A2Osa0HWcCLsJuVOKR02nKf6fUBxMGCPRLtS4nYKGf6wGKosvfuCXgLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pigG3CYwBiZcEt6P4r2C72bN16do2Rco2nEITwATTpU=;
 b=CXn1w1oAizIpGC4xNbcegyBdDhuXBW6r8kyIbN1EqM5tVAUFEwL+NZ3eUpLTbEjcVhnYeUqG3p3fbKRDdPYzgbwGzk7l3DeIMiYcpnYBYgthyrG2UKtnYQAZ4Wa8RFDsXU8kQRKz8O5Qld9G8MrQvUHFswRLlrV53yQuz/cGCCA=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:41:12 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::1c) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:41:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:41:01 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:40:48 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 47/66] drm/amd/display: Request DMUB HW cursor offload
Date: Tue, 8 Sep 2026 19:31:40 +0800
Message-ID: <20260908113338.2433445-48-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c002c2-7388-44e5-edbd-08df0d9e15a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cl5c5/+SR5xTIO2xW6+vV7cp87koG49Txnce2HU0BK5bSuGDTLoz3NSvetTGfii2ZJAkYLS2E9KT0b8PgqjG+knCRq2qoTR/WW3yNa4Q3SPwFUIdbu2q9jLgNyP3ivIYMuI4rFkUbIZCSjBOpdLazWHKb0TaINnLxb12KNVGPga6fpxindEpd3/ZpevjnkErZIOHhLUQCvqW6TIdpfS1H0vS6x/ypI3tKmfoK43rExQ4x6qf5bJMncoTYmGczJZXhvC2vzBJhyVs1Xodv7pglRW5+gZ5YSBfafhxm2P60z/VnuFyiv9Lm/XUqJSnHL45LT8CWt1w0jyWlyyzbKqtp4Yq1PR6vPnxst0gOB0CfuoSEU4235RYBqtMr6oueKR5pzh3mVYFKuWvofK/4OJzqIxY9PM08gkxnTGfiMIAJ6WFq54T3xvrgS9NbDUGVaDszQ5FgCS84BFNrjXlRDvKEckfCY2E/xV55UgDk0yK8CkskeDof0t1w528y1gGRk1KHpbpD8/VXP4j48BCtglZ2l1no0vqG1n5U2PxEfsmVPKbXjekGmjUeARiLh46d50hc9yxn0A+NuwevFmUz8thmM8E72pa2WuDWO9rAlfRgJuB/iFNRrf0gjg72lFFvMvrN8XwX1U2hBndU4Hj344cMH0AjtVmcLFVxHjIZk0XKRH/am+4PVDOh8EEInQuFQp+PBd6uu5if7qcWs7IC7SgCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YLsHMdD9ij3J4PmiY2aczvX6PlCkS6KXI4vzgPU4IUw+9mgAERFefZtyNHl7gAtF9bVIXiN68h1ocVhXIitGAx1iP+3azklrL6VOCyEhblzkSHp8vwPilwF8I7+wa+m4AJwtIn51TAzzAFRhe5vWzrBC9Z3WXN2vyJaot5NnADa/ZXir5j0TuMsXqz59mguFJxj8O/Idb/I3MndBOMxVkvPeFoYkq3aad+ZuAwmErP1336dgR10YwtRDGdilvcBACgX/isGtnknXV7oSU/pTKHYYSuWTaLN1CaI5M7YwobhEavQKNnExQYW0AU5h9x0pEXO0aAc5DGpXo/kbBfZb/v2K70NULjA4jIkxXkzsz8e32uHbQ53TV4G/VtO8g06SrCHlfkSArQAE7YEMivr6bzqDV+NuJKooGc+MVDtcy6zAqpVv8Iwv7GmfHp+xZJ9E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:41:12.8244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c002c2-7388-44e5-edbd-08df0d9e15a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

From: James Lin <pinglei.lin@amd.com>

[Why & How]
Request cursor offload in dc_config and initialize it after DMUB is up
(dc_dmub_srv_cursor_offload_init), which self-gates on the firmware
cursor_offload_v1_support capability, so cursor programming no longer takes
the inbox0 lock on alt-in-use streams.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c      |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c7fdd2844e5..24cd21a39690 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -608,6 +608,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.enable_mipi_converter_optimization = true;
 
+	/*
+	 * Request HW cursor offload so DMUB programs the cursor; cursor
+	 * updates then avoid the DMUB inbox0 HW lock during mclk switches.
+	 * dc_dmub_srv_cursor_offload_init() self-gates on FW capability.
+	 */
+	init_data.flags.enable_cursor_offload = true;
+
 	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
@@ -725,6 +732,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
+	/* Enable cursor offload if the DMUB firmware supports it. */
+	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
+
 	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
 	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
 	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index e23137034130..1e7071f8d53f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1211,9 +1211,16 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 void dc_dmub_srv_cursor_offload_init(struct dc *dc)
 {
 	struct dmub_rb_cmd_cursor_offload_init *init;
-	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	struct dc_dmub_srv *dc_dmub_srv;
 	union dmub_rb_cmd cmd;
 
+	if (!dc || !dc->ctx)
+		return;
+
+	dc_dmub_srv = dc->ctx->dmub_srv;
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
 	if (!dc->config.enable_cursor_offload)
 		return;
 
-- 
2.43.0

