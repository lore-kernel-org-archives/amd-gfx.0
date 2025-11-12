Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B8CD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D769410E11E;
	Wed, 12 Nov 2025 18:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6pXXkM0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539EA10E11E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLZkw936P94U7henl9WWRqMYvwFTrSBWwxn8kuU8u6LEVW8rShittU0dm4G1eNG65zkedeO0EQngXwmDeELuZ1XatN+Zl/aMMEOFfvkoe7c35+1DVkS8jY3v3lZW1G3sdZihxAITLM7b0c3o+zqA1rQscMakqVGw3cYtJnV/OgfHmv3CzKmudxIdxPr+QtoGljohXr3n7lDhvMMqdZYwnzGObpBQV/NP/X3qQyDAVQGjbutJFDqpxbhqCL/Xgl6MtVR0ZSh9gRuNBhXeJcjX89xqJkYLrrRzpZFlnVUYgc4G6UBhhYuAqQIBKV9FZp0beBkQiuQTewZvUyzpCq2Kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1A0Uxsnuuh/DMQxF63EwxKpzGiTQl9sHK+37JdpxL8=;
 b=gjj77b20b4VFOAHk78T4Wrw1qa8qODwBn6aysBJC7JY1sLjyq4GMbstfsza7QU24sMt0EUAb14fTQFp3xboZIXop92oQhn0cx6Qg/PLUfSA8BNVfibDB1LxQYay6ogmswhwaGJObH8JOvUO83Eial3MlNjohlvGavtfrjv1gRihexWftIqgB5Oye1osynTyAYVZu2Tk9VOjE5oROXFrZi5+ViTS+AdwnSBbfCDX629z8CJ9GqI3UMBl8ddeyaphGsK9wNxniieyocrBqk9wmvyCcgWv2vgrCi1SZFYS3nqmo6pm66AeS63DLfDJtTZcaWPDwvy7YZ6ANWhBDx/+GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1A0Uxsnuuh/DMQxF63EwxKpzGiTQl9sHK+37JdpxL8=;
 b=P6pXXkM0acDE3ymKG0alNtA7kb2KGaDJc/QuBn4GTMZV6+MR38Azb6YSdYnom52kscRzgxZ2IzEO99NhMel3JEHfKJqwYdxwoZDeEmai3/2VeFQ3XYduF4HbT77rbh1EVHz0uRuE7G9Mr45RLfBRpreCyX/8KTOZ3/porQnview=
Received: from BN9PR03CA0932.namprd03.prod.outlook.com (2603:10b6:408:108::7)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:22:27 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::24) by BN9PR03CA0932.outlook.office365.com
 (2603:10b6:408:108::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Wed,
 12 Nov 2025 18:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:23 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:23 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:22 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Add panel replay capability detection
Date: Wed, 12 Nov 2025 13:20:20 -0500
Message-ID: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b747cf1-f9e0-4bc1-a828-08de22186f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Ah5FrcY+33CdjW7NDXCbl6+0JJNEmIbDoOkMgy280s8UzTS9NwezlNTtx3g?=
 =?us-ascii?Q?QbGNuvsT5p4jrmwViQJdNYOz3bT5a1UD5aLH6JSZkQDQBWm5NNjPIWWIaRHB?=
 =?us-ascii?Q?T+taEwJyw6uETjrfIQwIfORT2wQJN2YNENa4dAUUGNEii/RE1egfQ6YHx/kw?=
 =?us-ascii?Q?OAmFERBUyU88Xn8WXLvGl3YWR0xHcZEcnJ/p+v+dOfZi7R2QWE++DE6ujNbg?=
 =?us-ascii?Q?FrPZE6BvDqqnP/vPvkk6/BhEuDnC9aVaSABinPIOE/iBe1bCTUcFW6zuL9DX?=
 =?us-ascii?Q?rgwFI4Yc8BtV2TX3xjgMRhggt5Eca2kKLdvwvRb7XBrt0mmKyOEDuu767ubs?=
 =?us-ascii?Q?N6X4ZN91GyZ2JOOvN/RgJwVekYDspoLeDfb2HAxNsppPfDybE1FWj7WwHL4t?=
 =?us-ascii?Q?tWHJHPPrOhe+QyZH2duNSmr+qlc3WVrszKRxazhQGlCqXVJse8/mn1xa/XgA?=
 =?us-ascii?Q?fycKtuQ2TxdbmjVu4QOwWYhTVqJ+eJUmYSe1BKSkvELKt1aswMavQwB4jEYt?=
 =?us-ascii?Q?KxPEIpwAHSj/7t6Lvura65qb3L+fqMLJUY5mIPPlZ+uJsz47Grzni36upC+M?=
 =?us-ascii?Q?wsVDQ5n5UkO97dqH83dB0RxfPomDlD0M0TOwsFaAk41ItqfERWVd9z0pTkkq?=
 =?us-ascii?Q?EKdpla4gq5wBOFeIbXsD2IV21fZ2iplHC2JuUTUZCKpMRTKpVn+8xUTpqSYQ?=
 =?us-ascii?Q?mCMhxl7hRwCBNX3lc7TJYhgoaQW6/Dzn0MlOrWKGoFRiKZ5mfxaPUYF13qT+?=
 =?us-ascii?Q?hojET3FZvSeqYyGfAa2RxWY6uDszwZAZ9EqBPPE3PQGf1yxKOG3IdbIwGTQe?=
 =?us-ascii?Q?AcWWeYmcM+4jYl44oNVnIY+cvz4El2VD19TYA/dlRA1af8hJBqPqiLBU1G5J?=
 =?us-ascii?Q?wLnj7vtcIUSZjXNSNglh9H6I7gT51cL/ubhUH8xkonntXJ+NmiVuQqw05Ycm?=
 =?us-ascii?Q?2mCExO7lJuKqsYRsxtAh1nw/EL+9y3eSeLxuFcfq4wDto1kTAmIUN9Yv8RdT?=
 =?us-ascii?Q?Cz4/tCIqM9GwKDGuJaQRBzljNUSZaMfzTFBdn4EPuCLmFa4QdHpOwgoRaORW?=
 =?us-ascii?Q?qwk+GotHUnMzWq0xgYHfFxnpaN2Q++KQMG7zSnGitROq+Ry0bn+GdqTFz+dB?=
 =?us-ascii?Q?1rlmFabnIr1M7TvDWPyNJ7vDUJcJAWYTSAn6VLDTwuNtFN2JhsP42I/lDR2y?=
 =?us-ascii?Q?wZ/Lp3mSCyWuwllfdQO6AWkD+/h/6mRVy9ovvF4RyFn5EWE6FEwYs4KqPEbF?=
 =?us-ascii?Q?eXBW5Hunae3e6SlZhf0avzgKWmJKtjeAby325TZCcw/pCVrMriR7SVQFBam0?=
 =?us-ascii?Q?Za1kjo6qA/G/si3eUSQ6P/jj/Dt7LpVR5zF4/6nrd2/qh6EEn0AUV/L6BFvN?=
 =?us-ascii?Q?Ib81NcJOGv4tDxPeerIN0LLI7e5s+RD6Eko85C+naPhtanJGVoSpjjBob0ca?=
 =?us-ascii?Q?Ctk1py0FanNTwxjoFaz/w09pH5sA1R1bYKP1bq5e6gT7aKBffWsAWquw8isd?=
 =?us-ascii?Q?FKLQhbWF8JGxM3HjiH9osEw57vQuBBwtPVoeCE7d5grO4ch62WFuBfRGibDj?=
 =?us-ascii?Q?4RoEZlK4Z/sofOBeF90=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:27.8079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b747cf1-f9e0-4bc1-a828-08de22186f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

From: Jack Chang <jack.chang@amd.com>

[Why&How]
For supporting VESA PR, add flow to determine the support capability

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h         |  9 +++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c  | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/link/link_factory.c    |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1b4dc9f5435..0da36b5f5556 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -303,6 +303,7 @@ static bool create_links(
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
 		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+		link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0495e6cfcca0..f46039f64203 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -941,6 +941,12 @@ enum dc_psr_version {
 	DC_PSR_VERSION_UNSUPPORTED		= 0xFFFFFFFF,
 };
 
+enum dc_replay_version {
+	DC_FREESYNC_REPLAY = 0,
+	DC_VESA_PANEL_REPLAY = 1,
+	DC_REPLAY_VERSION_UNSUPPORTED = 0XFF,
+};
+
 /* Possible values of display_endpoint_id.endpoint */
 enum display_endpoint_type {
 	DISPLAY_ENDPOINT_PHY = 0, /* Physical connector. */
@@ -1093,6 +1099,7 @@ enum replay_FW_Message_type {
 	Replay_Set_Residency_Frameupdate_Timer,
 	Replay_Set_Pseudo_VTotal,
 	Replay_Disabled_Adaptive_Sync_SDP,
+	Replay_Set_Version,
 	Replay_Set_General_Cmd,
 };
 
@@ -1128,6 +1135,8 @@ union replay_low_refresh_rate_enable_options {
 };
 
 struct replay_config {
+	/* Replay version */
+	enum dc_replay_version replay_version;
 	/* Replay feature is supported */
 	bool replay_supported;
 	/* Replay caps support DPCD & EDID caps*/
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fd8244c94687..16cc3bf1b6d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -387,6 +387,21 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_disabled_adaptive_sync_sdp.data.force_disabled =
 			cmd_element->disabled_adaptive_sync_sdp_data.force_disabled;
 		break;
+	case Replay_Set_Version:
+		//Header
+		cmd.replay_set_version.header.sub_type =
+			DMUB_CMD__REPLAY_SET_VERSION;
+		cmd.replay_set_version.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_version) -
+			sizeof(struct dmub_cmd_header);
+		//Cmd Body
+		cmd.replay_set_version.replay_set_version_data.panel_inst =
+			cmd_element->version_data.panel_inst;
+		cmd.replay_set_version.replay_set_version_data.version =
+			cmd_element->version_data.version;
+		cmd.replay_set_version.replay_set_version_data.cmd_version =
+			cmd_element->version_data.cmd_version;
+		break;
 	case Replay_Set_General_Cmd:
 		//Header
 		cmd.replay_set_general_cmd.header.sub_type =
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 7989baf3843c..5229f2a9a794 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -787,6 +787,7 @@ static bool construct_phy(struct dc_link *link,
 
 	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+	link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
@@ -868,6 +869,7 @@ static bool construct_dpia(struct dc_link *link,
 	/* TODO: Create link encoder */
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+	link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
 
 	return true;
 
-- 
2.43.0

