Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4E606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vV/s4xKo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772CE10F898;
	Tue, 27 Oct 2026 23:22:34 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44BA10F898
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3RlOuRAuE7tjPNZHJCP8nYMCHxz9reRDJxSIG+dIsp/BwobNTp6oodYUliHnzvWC2x2QNwLsUF8DKtozxd8EnFvVIgoiysPaAl4DHfVZIWKfA+y8+aq79lb2xpwqiQHG94gbCFVJY7nX5S5P2CbD9DPSmQY0IcUuSx9mG7m8qbKl6vZlkim20i+fP4rREt5vcpsl0sNaExMSWD7xAO/PEInnlmgpkoo5R894OxHJphB1Khpyb14+SW2B6U6fh/p6nnjCd/pO2b81nxe/vxUyt9NZELx/uiXD6B4uZf0skhcGWDtI1qxDzfcwS7LlNzZOmW7kfXZNYeNPwgr3WQMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOEjJm5bmqhNPeqkbHv1bdA+GUj7EnztIX+yZWO6v30=;
 b=kEjNSVl7SDvl0NaTZYPHF6GHaC15D2JtHEGkE6VL37karbSY8BpO1O95LfvZdCiUaWWIJAJeVG/X6GhCP6kn0yzTPwH/Lz8CDgY9WwnEL2SFhAQJQiLOBMNKbDBlXeLkSfmQt2Zq09AwsTQIIwYkGMUQrOIEOQxj0M1R4gq31/0CyraQ7nN6w9kNAZgCamFN8AaFMDMpMEvFgTAX63BbSPKFm0f19oFHXc4WdullR7xmXyn0il6TF8TRmM+R8lq32mTaeMQLZBVYok3ys8shzxOMrEzzMKDD2v5qV9a3Po6emTbbpFSHYB05Fx30z/YEy6XIhiBRJ+En8jswe878lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOEjJm5bmqhNPeqkbHv1bdA+GUj7EnztIX+yZWO6v30=;
 b=vV/s4xKolR9dHfsNGhgwWWtK8JOBpxh+x9INN8J8XOLTHEBydDfmfQP9GDK6z8qyQMuB09wHZR+bL4DXbqcVq2WA7GA4EWU89oLX1rISQDSvY3/8WqySf7YZ71eLG6TqCA1EmOrcsu6wjCDP3tJorf23AxiQxNIzHD6W2k1n21A=
Received: from BN9PR03CA0711.namprd03.prod.outlook.com (2603:10b6:408:ef::26)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:22:24 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::58) by BN9PR03CA0711.outlook.office365.com
 (2603:10b6:408:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:22:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:22:24 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:22:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 09/28] drm/amd/display: Support replay frame update interval
Date: Tue, 27 Oct 2026 17:17:05 -0600
Message-ID: <20261027232005.2879750-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cf7d8f-8d67-449f-b2a1-08df34812863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|261021121427099003|261021123027099003|261022075727099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: AjIkSLH+FvyWcgZ0/dVOYD41b3nzZ6Myyv8E/h0kmSMcpTdw8ZwpcgJHHHGNySAcDG45UtRgDEcIPGCN1GX2PKzwbURYfISbvBE7G41iqVAegw4ml3JUGG6AV1HfHGV1B9rtkbnBiB0BxnjNg45kWbhHqRt5LLT1c1F8i+T09Yzl5vJ4TOZk57jdkkRlr+3ihUnlzWBEmJtTu1PhrxVcyqokYXGiIh0A4B2GwRC/1N3wRHTxAnq7Z6ug90JulgLZ3O40CmRzCcZGn6qkMdU+kxItVz/B2s5miueFUUTHqGf/CIymA3ylFAGi1etryBJedNb88k2yulgnoDkA3C4SRAxKd1idI7YiUMduKvWfp8hBAXL+c9K4anL9IV8d69nrHPLmMHTJmEOb8ulX2S0CAD9w582YGGVK1DMcY4PcKZ7gIcCr7sgKpfXDzUFJaPwXjKJhJcAVjJZkjXRNODLOPpvYfCacOl3jnlJ5QjSF0lU67W7nsNWRLSbWNZInazSiPgcC+rgo2vLcHkcISuQlDmXalS02/66itZDG8GYpJ46u4YKM6ESPXxGr0jmX4Q40A4tZ0rvxIZ8Xt/aFGeY9DFfhu5J8vEO/OwLSaRnPvZGKzwE5ynrgAa8z828fSv6xWiRRCfLv7GcsRmOAPi/ZQ5ioKw4sSoDnveTbfDoDTOQ/tqitlysj5AFsuMADTEIUOd8w2rn5nAxsU8hMssN0LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qCVX8kxY9/S4rpXsi1l6zgJYA+QfIPdfm/kGdpHFu4Z4g0hQgs4k+Nn+ETyqyVaMPYZMWCD3B3AZhJFJXW1s0Wpe0ub5BPYlIqRcuSuVpCEjv30zLXes6uBUlCEdfMYKZfOYHHZIhG+IMxW4M9ZaXJuNUaadSPFOMkzCMIlejWg5L+ztwi5Ebjfg4qST79wU7D22lrRHvaIpaxvQtsHAcgunSUUpTzlLpf1myceNVdFajY8mUr0G9hI/u/pz5KxTZLGNY/5T4X8Rd60g17lA2gAuTQlNBCjU7C7GA6D/U6+S3G4qDLa3R1O6IDmyUKQFPdXjA5c3NbnX7AE53G/aFrJ8N7+AdRwe7nu2WunzCyUXH7PSmbAS4GxCBQR9cGHohuaP91B/s3mR642aUbA1iINWhOeX4UqXZZq3UIckYcC15ClEXHZdUQS797KI3F73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:22:24.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf7d8f-8d67-449f-b2a1-08df34812863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[WHY]
Allow a configurable frame-update cadence while display self-refresh
is active.

[HOW]
Carry the interval in per-panel configuration and Replay copy-settings
data, replacing a separate interval command.

Cc: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h        | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 45fa52011a7f..8975f9085daa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1351,6 +1351,7 @@ struct dc_panel_config {
 		unsigned int replay_enable_option;
 		bool enable_frame_skipping;
 		bool enable_teams_optimization;
+		uint16_t frame_update_interval;
 	} psr;
 	/* ABM */
 	struct varib {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index e6adca240ccf..365c428eae72 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -171,6 +171,7 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
 	copy_settings_data->replay_timing_sync_supported = link->replay_settings.config.replay_timing_sync_supported;
 	copy_settings_data->replay_support_fast_resync_in_ultra_sleep_mode = link->replay_settings.config.replay_support_fast_resync_in_ultra_sleep_mode;
+	copy_settings_data->frame_update_interval		= link->panel_config.psr.frame_update_interval;
 
 	copy_settings_data->debug.bitfields.enable_ips_visual_confirm = dc->dc->debug.enable_ips_visual_confirm;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index fa17cd395e5c..cdb4a77f92fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -41,5 +41,4 @@ struct dmub_replay_funcs {
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
 void dmub_replay_destroy(struct dmub_replay **dmub);
 
-
 #endif /* _DMUB_REPLAY_H_ */
-- 
2.53.0

