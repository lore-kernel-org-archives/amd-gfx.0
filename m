Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37646C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9421130C5;
	Wed,  1 May 2024 07:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LPjCJWyt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387171130C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gql8a1Z2vGdzem9wMEdDyd6PPlH1ydtGfIZVBxIP9j97KU2f7RxJMHCvdLVOWWXJF6pDCnLBxU7+vn1Y0c7RwJGFz8dkRpYq2p0YsZbH2gqtjPy9wuP3qpgp0G5FkRPQZF6IK94juZn5ePU/LhKwXWKneGuxHb+vSOfzdmHkwE7Hpmki/h6aAuDrXhP1Ls2/pFy518tQKzse3QQovU9BAMFXjhgCICm35sUFnPnjX8ftk0Qj6+Xt1EPbglPZ8OLFiwlGJQM71dLQxbLn+7PU3CRa2lwlwZnc2N78FWrRd1i4gbkFlwTUi6yNz+DAzgFRRo41PUitU5nKKhXpuOlI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRPGWGcPUKBZDRBk7hfrro7X4cPdV+xMOqRE4ySrIkw=;
 b=GXnEcNmzeAu7Z8SGFY8xyifMOGRW/GzsmCD2DIeTnECBh8sJOCS+7vmQ0ZIOiz4zEppdUHDmcQxQ6NGyX5RP6HIahVBqVJjqJI15bUbb9m8v3owcy25HRk9ZwmwOf8wEf4eu1f4oEAYKLPJjyjPizZ8eX1RaJsVtxcU3WwssZ7ZQOysYYteuQTYU3fvZ0NI3T2AAFX0Ce4iPypGyjz/ajAJtYvaybh/2XfosE2vqDmVBZlne5utfgiYN1BaYhp4a+Dl3ay36tFPOkHBfBr/Lfb4dfkstB4tsWUwd/1bOoSgYm6kgJWn2G87zCoBUgFQDHQ4nAL9opFY7i29a2P8MlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRPGWGcPUKBZDRBk7hfrro7X4cPdV+xMOqRE4ySrIkw=;
 b=LPjCJWytC3h7mXO/b8dk5yvbruqQZ/5lKTRepGjTIKKOLnoP67ff+i6MhGdB8qCYtMRCx83ISvH8DneOQfnbWQwvJZTA+YKdkN0FkFcB1x+oTm2Vj3fHeibQu0GxygvpXW7Xi9YLYqS1Qlxe+diwv8faKwWs7svu3CD3gpnydSA=
Received: from CH2PR07CA0036.namprd07.prod.outlook.com (2603:10b6:610:20::49)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 07:19:24 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::6e) by CH2PR07CA0036.outlook.office365.com
 (2603:10b6:610:20::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Wed, 1 May 2024 07:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:19:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:19:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 24/45] drm/amd/display: Check msg_id before processing
 transcation
Date: Wed, 1 May 2024 15:16:30 +0800
Message-ID: <20240501071651.3541919-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a2f632-48ee-4379-f309-08dc69af0792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?znnqiJC3bSwNSJGo20kDaluSKntwLTyBbZhrIUIYZ6yz0KCg5jxf5yb6Jin4?=
 =?us-ascii?Q?HjV06Waq75FxgXYAVD7Qy9eeo2cBNLUy2lyGuLnoT1XVtvdnWUv66+H1sgKH?=
 =?us-ascii?Q?FdBWDsROXvdXg9DQ/dOkCq0Rso80lOHb2TL2dUH6187xMrhBJOdj4ryN9WFL?=
 =?us-ascii?Q?Qxzmch5n+0jZq/R3aQpnUEy63qpl/PS3b0WEfUkZFAg8zOB0bGxoiGO4s5CP?=
 =?us-ascii?Q?xKg2CDWvOBeFP5jouaTmHiIUIZ6PdHGZ328Bw3igIPzDUsHyNnZW2shOOlbK?=
 =?us-ascii?Q?9Gj+JOtwRJNw4OcNb2nQhhjL4XD1EDi5eyJ90mfIV+BND7m7i1l1W0D0q30i?=
 =?us-ascii?Q?Fc2C/FKHz90Q1G/ik+T+yRGnOniFO3tp+vQXvdzzzBNLtI/XvX7AhyqWynvn?=
 =?us-ascii?Q?ID0WNcSIoMeloLm2SFLUovuWURbFq9DvpthVV0Hc87VFQL+82ohR2GN4HsIH?=
 =?us-ascii?Q?+HeTCKTTo08NYm0k6v4fqOF+tNQ/w6kht3JckF2pt5pNTLLla0UF6944THe8?=
 =?us-ascii?Q?CfdAfNrCSgmbBMv0pLEGrC7nOeSRw4/1ragn3mO9MPLyB5jvXYIWeY7npOHI?=
 =?us-ascii?Q?+czXf9O6jrKuAk4Usq5JR/AiauRW9VZ/KKsDzf5G3DbQ0xUX2u9FZvcvnKO/?=
 =?us-ascii?Q?SNhyrJ+Neb0ivgDRg5O2xevyf3giuwgNNgGiOM4RZOux4gEetC2QP6kbstfP?=
 =?us-ascii?Q?SpWKTR8zm9SCacgGPAon6PPG00jahoT47sITMP0sfjUqybePPmd/NBEnMswA?=
 =?us-ascii?Q?Sk/FqyGkOwQUhEl+er4MsE+1QxRuBSOZ9UTSG32TgnEEl7vwUBXe+KnTG4kL?=
 =?us-ascii?Q?Jm3iJ++37NymBUFk/OL4028LFPc1IaAGSYXhLKVCzlmYlNDXnMTbTyDQotRR?=
 =?us-ascii?Q?6eN7ksecHS319pnmS8DOe72aTYgWwmucjKCruZSYrmZ63WoC87EGWLro1p8N?=
 =?us-ascii?Q?BQ3DF158xvkkteFB177isea7Lp7TxSu70iehKDpXc9Ft9xv7GuKpWd5C6Ahv?=
 =?us-ascii?Q?SzemUP+BzD+k5Q1RXfFe0B38Lj8co2w5a1+IHPLlVWZVpjuMlzmIRVTN7OXT?=
 =?us-ascii?Q?487PwZ8BqJ9rO5tMFmYCrMrXcLNocF78McuQ1vcy1cfmz/yTdoAzW5Lk4/Tz?=
 =?us-ascii?Q?SeTvKfP2PMHlRQ8QBqZlXv7QUx0HlN5Hjwm29t9bgsZV+wE44m0HewznvPK/?=
 =?us-ascii?Q?TPtVELI7V8a1RLLkcgjas2jFry3kKmiqhNRYm1wGn1kv25zMfuYGKEH6Cfe4?=
 =?us-ascii?Q?nwYKVmrJU0pCsaOEHeN+5HMWI4XOwaC/JICqSWwRSY9VJNuiov+mL+BLN/EF?=
 =?us-ascii?Q?kapoYHoya903PbY6NWZ7Od9eB/hDVMz7XH9x0Un2JynNDUvoVaGxxkfrEYNE?=
 =?us-ascii?Q?ICkIqVeoG81JPdFSopgiycpxmc+H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:24.5782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a2f632-48ee-4379-f309-08dc69af0792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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

[WHY & HOW]
HDCP_MESSAGE_ID_INVALID (-1) is not a valid msg_id nor is it a valid
array index, and it needs checking before used.

This fixes 4 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 076a829c2378..1313a7c5d87b 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -128,13 +128,21 @@ static bool hdmi_14_process_transaction(
 	const uint8_t hdcp_i2c_addr_link_primary = 0x3a; /* 0x74 >> 1*/
 	const uint8_t hdcp_i2c_addr_link_secondary = 0x3b; /* 0x76 >> 1*/
 	struct i2c_command i2c_command;
-	uint8_t offset = hdcp_i2c_offsets[message_info->msg_id];
+	uint8_t offset;
 	struct i2c_payload i2c_payloads[] = {
-		{ true, 0, 1, &offset },
+		{ true, 0, 1, 0 },
 		/* actual hdcp payload, will be filled later, zeroed for now*/
 		{ 0 }
 	};
 
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
+	offset = hdcp_i2c_offsets[message_info->msg_id];
+	i2c_payloads[0].data = &offset;
+
 	switch (message_info->link) {
 	case HDCP_LINK_SECONDARY:
 		i2c_payloads[0].address = hdcp_i2c_addr_link_secondary;
@@ -308,6 +316,11 @@ static bool dp_11_process_transaction(
 	struct dc_link *link,
 	struct hdcp_protection_message *message_info)
 {
+	if (message_info->msg_id == HDCP_MESSAGE_ID_INVALID) {
+		DC_LOG_ERROR("%s: Invalid message_info msg_id - %d\n", __func__, message_info->msg_id);
+		return false;
+	}
+
 	return dpcd_access_helper(
 		link,
 		message_info->length,
-- 
2.34.1

