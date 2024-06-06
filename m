Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7888C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3209E10EAA8;
	Thu,  6 Jun 2024 21:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IgKO3I6R";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1845110EAA6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMV/Q/S5+Uk5Ljmd6GfIgucbN2s+P71qKEy9IeJYim/5qSBJQzkxhFngdRfv21TPT9w53sJhbWVr8aGX9+6yJX1zBGDuCE/ROUhftqUNV7glLVj8cTDF5HFTZk5PvnJMxLrbx1NdkMw9JdPp4nVgl9OjCosA6HdNA4KJQ81gKHGqKfQfXGktzy3RnKW6sDzGXtvcwts+fs3w4i+zTmrv6VE63WUmba8vSndR73jjWwRkt2Co4Ex61i4HIP6vsZYkcUwCMfbmPpGOLdTgHklGM80RPS8FcgoC+hoogCIzfcJLAImD5rP7Ea0rDu3fvFEZBfPxWXfFlMWxML8u0D892Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pW7hhQRq5tDxpsA3R+cmolHjBMvp+zU8OHzvgTZbLw=;
 b=XVnwdxEDp+CiCrMSWESqWiB8cqwNk2zJgb02SPx2+VBHopCgcNh7/T6hF8jAGPqvoejMBG90T/kgMKyIa4Wjjuc/0oZdE05P6mSebpOJ0RXkRyR3F6KXWVvVLPBfdHjtzWVJfmh2SV+Oqgm/k2Fa442av0Vf934CFMkLmCrHLxIjdCMOd004zLRGl7FpUWOXQ4vy0m0HY+hO1vMps4O5vga2qkCnSAr5KyFnAk6hmSGyY93MH4gT3fgjA2YOUrLLio40FYkBzPuy1cH4xpDQ8p6gn1XrKgbMwXUTfQ+t+4KeJxQrQTIEK/9r1YNkJZFDMto9GU11S4lRoOXLiiqUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pW7hhQRq5tDxpsA3R+cmolHjBMvp+zU8OHzvgTZbLw=;
 b=IgKO3I6Rdy0YJVcpp9/OoljknQivWg9WCXRuenYVYx4+y2+1rBbKEn5E/70ErHOBRWpxq1OFw9EzfnUVHnH7wQdHKt6YuUA7oJctkcxSwxxn3ge+vkT2Jswhw6EeP/PE4uUcNMwpbhRrU4XVHWOeyV5MhRwDFuBpCEjK/ZMWIsA=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 21:01:55 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::fe) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:53 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>
Subject: [PATCH 02/67] drm/amd/display: Replay low hz
Date: Thu, 6 Jun 2024 16:58:23 -0400
Message-ID: <20240606205928.4050859-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: e200207e-f5d4-400d-a4f2-08dc866be5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pP1g9gytDB8+iliv6P3DmGg5H/S8LxJfeC0JJ31dVH6nBgFIzXp5Ax3svHJI?=
 =?us-ascii?Q?d64nAHCdjYdn1NDe8CjZGY8Zfsk1u3eI5VghaIyGGPPh6gDkrodPNXW6G5Vk?=
 =?us-ascii?Q?7iKwguXcXjb0jW6jTitEDITgmmigexzoMCB+2G0LHVmkME4qKIrJuIqkLrGh?=
 =?us-ascii?Q?pNiH1zVoEivEOrbemIMzus3GOUqOUdaHAZfwhdmK5PiQnQk0fXIMpyY9NO9S?=
 =?us-ascii?Q?B3rexuHgxvu57yPsCc58h6bvcLc3LlRKR2oJ7cnPPlja+z0WIlL8UqO8boJH?=
 =?us-ascii?Q?ulY1vyYJaT/Qzg8WMTNCrnABfzGTpkwcmUO6brFBdDo+Ml3ixj7VJmAt1Cej?=
 =?us-ascii?Q?39LapXwNezAJ/6VQepFMhKiPaB5oAlcKJESDiNPOFQ8AZSGb12xlxtJVmL1z?=
 =?us-ascii?Q?WSOZ4NuyS0RomAyy+THibEPTdThmSVbbkQwallCp0WWeuLVI21/hx9lYcpr8?=
 =?us-ascii?Q?+EQKLfM/0qdL/pH9f7lErMdwgB+ET5rtwf8avSslZY78DRFrf61uu1lCZwZ2?=
 =?us-ascii?Q?GJh1W/uJM5DW4Bij2XzmvHXLgnWRtBhgP0Bqhyx8all1FTkhHg52iLpC/dPz?=
 =?us-ascii?Q?ASuN8+w8+K1oRcT/FuMV7uSLNtt3brd4/qX4u8UUOc+wQ4Ql4511Zj1o+f8f?=
 =?us-ascii?Q?chFdAh0z+5bXDCZJlmvPmqlTDZaCVQvBQgf09V3nATpHIyKJiYgqPhAjJ993?=
 =?us-ascii?Q?KlT4N8ueR3n4Z4s9pMFtxA7J+llxnstziGF7BZLIhGpin7qHmOssPtWmGRZG?=
 =?us-ascii?Q?EEXewFnrFapcTyW2shY5xNQnhgBoDPltQbCMXWlSmDXRL7w8Y+4M9jUGnHuF?=
 =?us-ascii?Q?LPnWEBRMDavz4+BvN1sGLGq1YmQeeDJz+plvCobmsKJ45Ri4sDXkmB3vdxPc?=
 =?us-ascii?Q?l7qTu6IUddq74eN6CA2GC1BtWZpQoAIGpHIOBU6xZWmN12H5YKDYvYDhTI/I?=
 =?us-ascii?Q?hov0fHpnELgKgUfJ6Sin9COBd/XWc2PpDUn5gS0MMdgE1KjTPBNT18am7hr9?=
 =?us-ascii?Q?lbexx9mN3/6e5lSMHfkSmHObhZZWSJWmZ/+csRIDPDzEujKtdNZVvhasRG1+?=
 =?us-ascii?Q?N+eRVeuwvyeBqngIUAWgctf9R50v1C2qHeq7hdAs9S27m0qIRkrgiIC8UAtt?=
 =?us-ascii?Q?K90Lcx0ROvKqgpNZG3eKSgPJLCjITrxNYoalzDeIaJDWhOjsd/qmAaEa+/oN?=
 =?us-ascii?Q?ms4xa+zlneWxvY3hZmc6A/RmsX0m+gZFmyAWOmmfWKxbz+rKS+5xeVYvnX3G?=
 =?us-ascii?Q?dzDLKKaaDXoxXnm+3AWvhi3U6QZpkuDGXG5ZOC7ghMVcmGrOQRbVbW7vwEFW?=
 =?us-ascii?Q?RYK0MK4khhkbZH4mL+XkCZROyRJNNQS0MpMU6Ti7+HJAyEmY32l/cGrd0vfB?=
 =?us-ascii?Q?xcf/N6nAyMAD+7hCpO2623vLT1kbD6yV5Nk4a+uFD+91mliacQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:55.2692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e200207e-f5d4-400d-a4f2-08dc866be5b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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

