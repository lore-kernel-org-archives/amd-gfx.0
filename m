Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C03C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A2810EAC8;
	Thu,  6 Jun 2024 21:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xx/bwRuM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DF310EAC1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyMbiXvfu4P/aqx2rCCULsvDX1UpKWII56QBhrkxxucLkWrzNdl5uCmrQzI2Y6+Okrd8R0Y+OiIgd6HD/A+MGhgbuExNAAum4fKPb9GgntR6txe4pgvelQpDAT0V7p9iRaqEflsEbiJCxISW1+1diLKx7WN5JmkVswHHHmah41B6J2lYtlPIW+3WA2iAGjy1uUPBCY4fCupfAbcfBIxboPNclS8OpMDvpEnhDOz8rHRS4WZiqqGpCcf1VjDg/x0FisXBts5rJPH/LaVFEsHPrgs9HFi0vi1N9Ntz7piglwwSfyD7GPed43x9SIDGSLpoenBMxUPjjG+3DDdJqPPTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pW7hhQRq5tDxpsA3R+cmolHjBMvp+zU8OHzvgTZbLw=;
 b=OeI6GFBLKKZzsM1kz/oFrJ9Kcyjf8h8NLp7Fs7rzYFnbAHjYLFA9xoed/VblQRvdPX99J7kYwU4lsGVPjWZtAK2sezzoihfHy/MIpwPpTQFkpJQ4NABUVwJi719MDULFTuG2lT1na5ZqrMIuMJro/Bu4PPPcYDXxdjyBB5hCQbL6bDyjWhNLkI2nrbWblFqGA4B1NBvLKMrH5objb4dGZ6mNlLLCAdIjXsjfvCK/nn7Sv0ICQIQi9OlOWeL1T1/mfLpnBhARhXtnAnTVXJdEdzrwNzFHnSsoc3xg+qqHVGeb4Ll4lPmxBaWI28pnokIAAEW+uIca7h4p6unwsI7GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pW7hhQRq5tDxpsA3R+cmolHjBMvp+zU8OHzvgTZbLw=;
 b=Xx/bwRuMgLSZ+P1ZVykiUbibk46mot51g4rOwHghMetsCu4kp9CiuTakNEA+gS74Lhzow4r0ZuDhkjS49YT600j24WKMYmxJqK/aKAK+POv7P7HFjab/Up6M6bTkWtk/dGRVM+7d9FjyBGzwv1PzzFsK+OPPW3VgyBP6jo6jxxg=
Received: from MN2PR20CA0042.namprd20.prod.outlook.com (2603:10b6:208:235::11)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 21:56:55 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::79) by MN2PR20CA0042.outlook.office365.com
 (2603:10b6:208:235::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:53 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>
Subject: [PATCH 02/67] drm/amd/display: Replay low hz
Date: Thu, 6 Jun 2024 17:55:27 -0400
Message-ID: <20240606215632.4061204-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c55a529-1b75-4dbe-95a1-08dc86739481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G+sEWK9q7/WICjRCR6EKVJTMDmSkOTOU16GxDDyRUAufxT4gRpooKgOJU42J?=
 =?us-ascii?Q?OFLVHoFqZUW1DJ8oqGSsw8xaqelWirF0ZVP6xnkLfhX7tpIgXx9fnfuUOO03?=
 =?us-ascii?Q?ubo4de/ZIAiWNQbbBgQtTrpB9SaqfYrb5HKVfmACJvJh8ZBvyI7PYV3VZxee?=
 =?us-ascii?Q?YmmYfgCd+E+ZTmfZFN9Z48pKNOy3Mwq/sndrAUE71FtgNW6s6yZpJ/MjJYJ6?=
 =?us-ascii?Q?Xpd/bFbIzmjLmhFKjqP+IqpmycsXojlJzfgMlokbkWltUFCSHO/WJPwZDK29?=
 =?us-ascii?Q?upKbbbxoaHVq4YfMGO8swoFFkGKdzSJgUFZ1/ejlBbB1d1PaFbVigsM5py3y?=
 =?us-ascii?Q?ZzLP3r1TFsyUdC+ItR6N1d7HjBzGgPvSawzYCWq9o71niXI8l1SSOO1juluY?=
 =?us-ascii?Q?HEeH7HO6xEpa/KSAI0aUHlM4TqQViBR1CYECmLtMSHjmLRwxgPuqNFPHlyjP?=
 =?us-ascii?Q?uyAw+NNNwNpOfDriXy1gHVqkY7lxcvzRwGzrsTwpcQwyr5WOny8A0CNRBCIT?=
 =?us-ascii?Q?9LLqwOmfmmUxtFEzCryM/LKXaODsU8H/hWan8cr+6oc5eJdlrNHbNbNSCg/C?=
 =?us-ascii?Q?N9TFg4Ldbk7SisrewQVskMBJsMVVwjsqBi+tPyHpk4SialsMvzlMPQ2oIJlr?=
 =?us-ascii?Q?+P3t0BrQfRG7DvVdCgikd/o0PiBWb/vX0JV2w9ZxA94H+EOGX2W6SCu8iYi5?=
 =?us-ascii?Q?qZg1ddKHZzKuNzJwVu2LBjFNl91xKR9fJkysvSuAz+8amFIN4qtmJU7dUnCy?=
 =?us-ascii?Q?eHDUBtPKceRxO/Gn05SaDusJ8VWJUBx3qqM6s8h/tMwwCrPBiXKdPHhj4cua?=
 =?us-ascii?Q?pyvuqyVSaHPdCgV6CwlPf+dIzckooiO3AyITMZMkjThK6Mbh376IScX8ex8n?=
 =?us-ascii?Q?2MfgNsa+u58M+vPEz7wGXn4ljmXe963oeB7G/8cHXCFT+mQyPpI0j8OddsmF?=
 =?us-ascii?Q?2+liPO01j9OLDNjW+MhAyVfrYuCxrFcQ/VL0nbOwi+kCCTy0MbsnBxNEicvP?=
 =?us-ascii?Q?PgQ7mVxI/A4LYqBwn841iMB0x625wRLtTJ2tWN4t9Tzmy21UwiwL2nuM8ChR?=
 =?us-ascii?Q?fW7Ii1mzIZXOPPDsF7aARUmERaTphSQ2LkW0RkchenqsI27sC46JldmdtLgD?=
 =?us-ascii?Q?A1yEFblRFwvkBhW5GpRM3CnWXAhRHymNrhJQYtGp3+oeg0H/6JVEV1a2+z3m?=
 =?us-ascii?Q?mw/A9lrUqSUUtLg293EhLD/qOR4W/UBjZtBCPkZkjQARq7I6jzcjYrpTUh1D?=
 =?us-ascii?Q?MH3inkeEOwtsSPrS+vTt4Dz5TwqijqTE/cSZ7ch4w2KmM5X/ua+/5D93++RC?=
 =?us-ascii?Q?Tw0lLXWLoo2WR7MHV2j/zkygjsch+4HlURFTq1tCorvM5QPcJu8Q7G8ttTCR?=
 =?us-ascii?Q?mlC4DbeA101qiAqOQMCMhf8GOUpWQ7Z3mpAEypJCyVhuJ6Iy/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:55.0024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c55a529-1b75-4dbe-95a1-08dc86739481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why]
The original coasting vtotal is 2 bytes, and it need to be amended to 4
bytes because low hz case.

[How]
Amend coasting vtotal from 2 bytes to 4 bytes.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 34 +++++++++++--------
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  4 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  8 +++++
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index b9769181269d..fd91445d4d8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -216,17 +216,21 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
  * Set coasting vtotal.
  */
 static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
-		uint16_t coasting_vtotal,
+		uint32_t coasting_vtotal,
 		uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
+	struct dmub_rb_cmd_replay_set_coasting_vtotal *pCmd = NULL;
+
+	pCmd = &(cmd.replay_set_coasting_vtotal);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.replay_set_coasting_vtotal.header.type = DMUB_CMD__REPLAY;
-	cmd.replay_set_coasting_vtotal.header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
-	cmd.replay_set_coasting_vtotal.header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
-	cmd.replay_set_coasting_vtotal.replay_set_coasting_vtotal_data.coasting_vtotal = coasting_vtotal;
+	pCmd->header.type = DMUB_CMD__REPLAY;
+	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
+	pCmd->header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
+	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
+	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
@@ -259,20 +263,22 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
  * Set REPLAY power optimization flags and coasting vtotal.
  */
 static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dmub,
-		unsigned int power_opt, uint8_t panel_inst, uint16_t coasting_vtotal)
+		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
+	struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal *pCmd = NULL;
+
+	pCmd = &(cmd.replay_set_power_opt_and_coasting_vtotal);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.replay_set_power_opt_and_coasting_vtotal.header.type = DMUB_CMD__REPLAY;
-	cmd.replay_set_power_opt_and_coasting_vtotal.header.sub_type =
-		DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL;
-	cmd.replay_set_power_opt_and_coasting_vtotal.header.payload_bytes =
-		sizeof(struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal);
-	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_power_opt_data.power_opt = power_opt;
-	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_power_opt_data.panel_inst = panel_inst;
-	cmd.replay_set_power_opt_and_coasting_vtotal.replay_set_coasting_vtotal_data.coasting_vtotal = coasting_vtotal;
+	pCmd->header.type = DMUB_CMD__REPLAY;
+	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL;
+	pCmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal);
+	pCmd->replay_set_power_opt_data.power_opt = power_opt;
+	pCmd->replay_set_power_opt_data.panel_inst = panel_inst;
+	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
+	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 3613aff994d7..d090ec900c08 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -47,12 +47,12 @@ struct dmub_replay_funcs {
 		uint8_t panel_inst);
 	void (*replay_send_cmd)(struct dmub_replay *dmub,
 		enum replay_FW_Message_type msg, union dmub_replay_cmd_set *cmd_element);
-	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint16_t coasting_vtotal,
+	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint32_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
 		uint8_t panel_inst, uint32_t *residency, const bool is_start, const bool is_alpm);
 	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
-		unsigned int power_opt, uint8_t panel_inst, uint16_t coasting_vtotal);
+		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal);
 };
 
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 36c15ae43616..fe529b67369e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3004,6 +3004,14 @@ struct dmub_cmd_update_dirty_rect_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
+	 */
+	uint16_t coasting_vtotal_high;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
-- 
2.34.1

