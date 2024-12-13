Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B2E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2756510F078;
	Fri, 13 Dec 2024 15:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47arVzZD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C02510F06C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riBKeEriq25cTuyZuFgajS1uuryacoa1lZMfAG4HMYUB0q7ghlchDGX0zmzzx7LflzfBBAjJ/+El2nUanM9b5luuRbMgCwypIgJcvjseaSWAUnLdk8A1sN/LeMizsej41/i34jPxUWCzraVZ72lhWeklG5KFWiuexcp9P/Kufw++driGET5H7KRNb5aedG9VrV0qOOemrzPRBxIIOSDJnFhw/sjvIikLkWZa3xvYx8i+5JnB2NCxTrV61RfHz/jwCZet02IPNPvQK00QaDqcp3Zb0nOfxPmBnqRmC2P/oWJ/dIVF7qyAg5PPx6+w7c5Foq9pa67IW6VcBLxwvCDRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRSKFQX3PkHYNQc9CLOKHQEUiBqZswV+6LfeC6WIiuU=;
 b=tAbeZwsvM01IN/CR9ZRleIEWM7Ok7ng8YOW7d1TchqCeFCLOej7oEZFygV/V0ljeVinl9t5cmpeyVdhjUdkICbnlEI+f7TNdWGlAh1alhqWpCzcLpw0BSdkGI67FnTH7QNhPBCG6pU/AjSqyOw13XQH6ADu7UYHD7DHi3agEgyxGh/HP7uwhOQHiQqSD8Vjng+t3PKrPhAm+5pNBnTRKE8t+9w2I4olCXjcHK2ftv2EOb16iYCss/bANHhMWj0pd18zcwOp3M4dKqJfW14y6lqkm9vWm61x79CUAqpqbhWkWJSc2AoTHheeZoNxJrIfOT75wAjVk9fSrUXtIRofsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRSKFQX3PkHYNQc9CLOKHQEUiBqZswV+6LfeC6WIiuU=;
 b=47arVzZD2ubxD/QAJgN7x1mCgS007BaaN9NAGk4eEI9L+7weimFrTy/tqQ5O3SWxhsbhjwCV5ycIqtliWYFSJpdCYtciNUZbcofWRR3LsI/8ljp/852uzUTFkjo8evUADq8FaWGlJVBMiomk56k8yR/XfJqeqwG38l9TXGVQIes=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:54:36 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a4) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:33 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 01/17] drm/amd/display: Update FAMS2 config cmd
Date: Fri, 13 Dec 2024 08:52:33 -0700
Message-ID: <20241213155405.393252-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: ab73e4ed-bcc4-4505-a122-08dd1b8e71e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Du34d3TFqotPE/iz/X8C8v1Pvhj1sTzr/kiD7pbz2eyobb0qq9kMMZwCWgSl?=
 =?us-ascii?Q?cubiYuNj8foeiaDJAR11EFGpnhfqr4wNCgU6wC3Lpn/t7H/JHPadI43kbHMt?=
 =?us-ascii?Q?xSYPchTPQiDvfxXNVXlZ9Roe+o7MIggaMijh0FKU169XffiPnsAFCDxpfgBC?=
 =?us-ascii?Q?FIJndNpskK57pBBvO+WJljKcYPjlaAfYujAczhFpOsctL54ilrQWVg7e99cl?=
 =?us-ascii?Q?WmATkTnoZvXIMl/YNmRVgWQdNa52/sltensEDZyzqJFJMJwM3NicYVxiwxgi?=
 =?us-ascii?Q?eCTh7C4ZRQ4y+L1Oqb0U6sUJM6dUOHMNljOywhboUQhNoe12EJT/UBB6v7QN?=
 =?us-ascii?Q?7ZiI0Tr8hbJjy+nGCjdkko9NzbOnQtC1a65arf0KqhiJMqXeVN+c+Kw5yy4M?=
 =?us-ascii?Q?dyVSWkh5hoe9fsT7cexraoA+tNIlSUi9QA6jzPpaU3JMLVehtaPSS67DNrfa?=
 =?us-ascii?Q?onrPit2dpIvWS8FNLxD6xdRTvZQrY77WhqSyAErSNGZ3xcB9VOmfLgn2qI0Q?=
 =?us-ascii?Q?JMCxUP/rlpieHOD1nyrM+WIpLuyxYJpC4mQIyc3bncOU8EUx9+1wMOImvvGH?=
 =?us-ascii?Q?u3a/hgaeiCUPUKPA1vIyz43P+oM+a2lkb+IAESXsYObGEpS65DQhEJqRqFSu?=
 =?us-ascii?Q?RnxxeYHmEbRXUIaHkW1Df3XpbOeev6Ef6pE7+GZeH/xCqOptuxQupS31FNUK?=
 =?us-ascii?Q?fSZzf0kfLhujSkFY9M4s5LphdxEHoeTekuqkbM0YJHp1JYLMh1fN88dQlQw2?=
 =?us-ascii?Q?FuzyoYZCH23J6f2K8kYZVIlI11SR8m1TAUp9pXMSsjdL6x3T7+PdMZ1N5AU/?=
 =?us-ascii?Q?NXi48RB1MzZacUbrHgMA5g41yuu8+0QCJdMK4SCHO1RVWROpLtnCOIcpOU+u?=
 =?us-ascii?Q?rSSntj6JNAv5eBfXh0JGJ4J/mjm5yhneWROCQQ4Jzyu/qqw8D4C58fwjXVu1?=
 =?us-ascii?Q?1If72dX/1X8ZGlsNZErgHNUbIu8Ohssy7Uix06bn2X/VaLS0GONhu3X9RTt4?=
 =?us-ascii?Q?mPtNew9CfylDo5IV3kvVQFpOVpaHO9KOxzWDJLIqVnlk1NBN5/RGTEh1jpW1?=
 =?us-ascii?Q?g7Zqk/Sv5p5qeo/EcuQTIMS2m+YTwFLITanByJm9kmVZqgxJDv1hX4IJ4b82?=
 =?us-ascii?Q?1lMIKmt1GVafXoCemMro4cDQCzrt/fYujRdOQl0coWXlVv6DVncdRfRaIB0S?=
 =?us-ascii?Q?h0GyzlgEs82y84hZ1RiAeBjF6cp2XJ2RLzGVabbsedN0ZUkD+chgZT6ufokj?=
 =?us-ascii?Q?Wz0bbE1LWaQGRLHbmNkNV4HdbDpDSBe68cZesBRsqLSsKP4LjaFfvTrm+K5D?=
 =?us-ascii?Q?LhWL4l9KXtYS09a5z+hPzNO8CtSBzVcrnbbLwT+JWEyrRrcJvIgGTrNWstiN?=
 =?us-ascii?Q?kP5PI1duAhgBPFiJCtQUutwcsltKNQ7qdktbp7pMmjgMUSJ1Y0n7C2uGrRv0?=
 =?us-ascii?Q?kCE7KFB6RmNkeklN/bEQhBWymVGJZy/v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:36.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab73e4ed-bcc4-4505-a122-08dd1b8e71e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

From: Alvin Lee <Alvin.Lee2@amd.com>

The FAMS2 stream and sub-state have been separated into
2 different commands. Update the cmd function to send
one command each for the stream and sub-state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 25 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 775c58637f46..4127a4a2f1e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1694,10 +1694,10 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 {
 	uint8_t num_cmds = 1;
 	uint32_t i;
-	union dmub_rb_cmd cmd[MAX_STREAMS + 1];
+	union dmub_rb_cmd cmd[2 * MAX_STREAMS + 1];
 	struct dmub_rb_cmd_fams2 *global_cmd = &cmd[0].fams2_config;
 
-	memset(cmd, 0, sizeof(union dmub_rb_cmd) * (MAX_STREAMS + 1));
+	memset(cmd, 0, sizeof(union dmub_rb_cmd) * (2 * MAX_STREAMS + 1));
 	/* fill in generic command header */
 	global_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	global_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
@@ -1715,16 +1715,29 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 		/* construct per-stream configs */
 		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
 			struct dmub_rb_cmd_fams2 *stream_cmd = &cmd[i+1].fams2_config;
+			struct dmub_rb_cmd_fams2 *sub_state_cmd = &cmd[i+1+context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config;
 
 			/* configure command header */
 			stream_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 			stream_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
 			stream_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 			stream_cmd->header.multi_cmd_pending = 1;
+			sub_state_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
+			sub_state_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
+			sub_state_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+			sub_state_cmd->header.multi_cmd_pending = 1;
 			/* copy stream static state */
-			memcpy(&stream_cmd->config.stream,
+			memcpy(&stream_cmd->config.stream_v1.base,
 					&context->bw_ctx.bw.dcn.fams2_stream_params[i],
-					sizeof(struct dmub_fams2_stream_static_state));
+					sizeof(struct dmub_fams2_cmd_stream_static_base_state));
+			// TODO: Use the below memcpy call instead of the above once DML is updated
+			/*memcpy(&stream_cmd->config.stream_v1.base,
+					&context->bw_ctx.bw.dcn.fams2_stream_params[i].base,
+					sizeof(struct dmub_fams2_cmd_stream_static_base_state));*/
+			/* copy stream sub state */
+			memcpy(&stream_cmd->config.stream_v1.sub_state,
+					&context->bw_ctx.bw.dcn.fams2_stream_params[i].sub_state,
+					sizeof(union dmub_fams2_cmd_stream_static_sub_state));
 		}
 	}
 
@@ -1735,8 +1748,8 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	if (enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) {
 		/* set multi pending for global, and unset for last stream cmd */
 		global_cmd->header.multi_cmd_pending = 1;
-		cmd[context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config.header.multi_cmd_pending = 0;
-		num_cmds += context->bw_ctx.bw.dcn.fams2_global_config.num_streams;
+		cmd[2 * context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config.header.multi_cmd_pending = 0;
+		num_cmds += 2 * context->bw_ctx.bw.dcn.fams2_global_config.num_streams;
 	}
 
 	dm_execute_dmub_cmd_list(dc->ctx, num_cmds, cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9bdef5ff0584..785baffd33ad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -540,6 +540,7 @@ struct dcn_bw_output {
 	struct dml2_mcache_surface_allocation mcache_allocations[DML2_MAX_PLANES];
 	struct dmub_cmd_fams2_global_config fams2_global_config;
 	struct dmub_fams2_stream_static_state fams2_stream_params[DML2_MAX_PLANES];
+	/*struct dmub_fams2_stream_static_state_v1 fams2_stream_params[DML2_MAX_PLANES];*/ // TODO: Update to this once DML is updated
 	struct dml2_display_arb_regs arb_regs;
 };
 
-- 
2.45.2

