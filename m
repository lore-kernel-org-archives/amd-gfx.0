Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41938C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07DA1130BB;
	Wed,  1 May 2024 07:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvmIoodw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92DF1130BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo0bPnaiK/+yI80mQeF/7g3w83G8XVWJuUtpPqnMCcw9yiqZwsqNqmHWt32VKybMnJZ3TSUZ9s626Rnuw5Kbglg/QjTK1CxY1dbJq1JmciXkdTgIsD5sdAkFbLlUQ9rpDEW0eKclXM+3Ry8mrKbFhCWiIH8KER9yEfjVzV69uaNEnU0xKHEgeZjexUwPJq136LJJm1RLxHcjRUO5HVBFqLFmiqwqNTk0dslT1S5noRzjZeIESpJ2CaMLuC+RiYNcGCO8bHbwONNGVTXXbA55f6Uzwv2GtRZMLqkibfXYfmXZx1mv7hSPhQmZJ1cYDb8ltGYBAzeVjpGJZE8CB85/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSIpjQ+Ts4kCRmyfs3O4ard20L7coOF1yelxNK9ioA8=;
 b=JB/2Jxy93Y+3/pg9cyurDubrYn5E6M1d1qkwzORUh4Xk4DCVgHJ0KRo1t8RidjvUjzZ78L1Tu2DukjegNItN0FoHPghDPOIBinZmqN+FMNRD5NWWNAh+OARcB125Fn52l2Y0VLb6Tu3uAkfVRNtR/CyKqGWwZnoJvLJS8ZWcn5KI9UaXuL094ljEndoFW3YZhwMvmHYmX6JLEmUc0fHmuz82PxAP1xc9Q4dndx+XkFGJhvvfIrUHoRXhQkuydEynnOLljF0L4JXL03iNi58LC2SH2/38jpQtkYyC5/SkSagSSZeKLuszuwDEZogSb34hJfHOOVf+8l56NQZnqtqPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSIpjQ+Ts4kCRmyfs3O4ard20L7coOF1yelxNK9ioA8=;
 b=vvmIoodwXwSUqwzAfI27qtbrR+/oACPTy5bLHOWdv4yuqv5+6zxO3LJyfuGK0AFWrcPTrEUlOQGNYMX1HAg/NMsCcAHZ704Af5rro6B2qak3j+/EmpcasIwKidbJC0/4/wQY77L/5tGEisWmHtD7dej6dYnncjAS6wk31677kX0=
Received: from CH2PR14CA0045.namprd14.prod.outlook.com (2603:10b6:610:56::25)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 1 May
 2024 07:18:56 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::d8) by CH2PR14CA0045.outlook.office365.com
 (2603:10b6:610:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:55 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 20/45] drm/amd/display: Add array index check for hdcp ddc
 access
Date: Wed, 1 May 2024 15:16:26 +0800
Message-ID: <20240501071651.3541919-21-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: beaeaa77-dee3-41ec-785a-08dc69aef6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BoiQXrqmGyogcHSlEuLp8tBbeOisVSRzzDadXdv8aU1T0fHiLxvqBj7TwMwC?=
 =?us-ascii?Q?4+6c5zsAbCSM0c20JrUCthz3bS7fzv3IPMcS8w4y6e094cB1MGKY0ukFAIVY?=
 =?us-ascii?Q?0J5qBWcBvoanboDy6upwm+P4PAfLr0vGhDww77Pfmq64Qrl2EuSC4uAcBeCd?=
 =?us-ascii?Q?Ejfo4M+1vyEW948I9tpTmf1x7HxG3y14bfuIaNmGinjQNLLKJbeG1Zvkap/K?=
 =?us-ascii?Q?3D3OA7BdjWDMVxfG1FU5GNFc/gC9PZS9xnC5UhIBoPjRF2cWcoJ5KtvCeIPx?=
 =?us-ascii?Q?kkWbpEWqygXAq2F27kq6AzzSlmaxUAqVwAxpkheCcn6kh7jio4g08hW/wwLc?=
 =?us-ascii?Q?k+7+91Ca1ubPBjCe8TACfe/ysYYL7+mEu8etPTMSX68zhele/bglQ6tG5fEA?=
 =?us-ascii?Q?HI+ozh0ti3g1BagrLQkpe+upPuXKix8897U+QnnndBcwZnazb6Y8HOBJFDY+?=
 =?us-ascii?Q?X1Gu9GnknpJSaqsjFacRd18yRLOvOSu/nP1bP+FV0P18xdRODiTNIkMzoFEI?=
 =?us-ascii?Q?2MlzIieEfNHARSISabXYNUSg7Tv2A+WtABu3JitB+RLDJqOKSj8NEzKzyuDq?=
 =?us-ascii?Q?xnDaxCL8bpe15MSVj5mCSunEagH1cEPiMie+B1zG76GTlTJHul2Rxm5eoGzq?=
 =?us-ascii?Q?wayLd23Zd5EXWpl9qQcBm4IR/mNx0oH0bHDMS8xCkYqV/S2tm6q7szxk26zu?=
 =?us-ascii?Q?Kf51c+z4eyLw9WAM2nOynSCI2lDrvA5bRm6+NLCAltj1cAYfocgtQ+Yazagg?=
 =?us-ascii?Q?nYnrGjfYu6W+/FZmBTLuP20pkhrKVIcso4NSuapUNDOOaRdPcNUBj+G+1Dzi?=
 =?us-ascii?Q?OjfMGBqGXaqQ3MbT//+4oboSrJglbnBYxTTWao+ARJKIKsqqrMUCB0K8GWWS?=
 =?us-ascii?Q?EThkdph9cTze1XLjV+dMRgHU+h28z2m/vPobwwDqbsnM2077c1TrY+99EvK3?=
 =?us-ascii?Q?SAyqNJMPwgnLPrksQdO0iruujXv9gmbM7NLdwSuHNp8R4d+/Zo5f+Yq+c1g+?=
 =?us-ascii?Q?cklXtNCxGlQnni35s+L+/wY2a5DWoKG+eypiMTku0aLGnFStWcBkVfsFajY0?=
 =?us-ascii?Q?lE09uxBxttVdrtJ19xZDAqOEChtUJUxwXOhlohfOOzjNPjQ8teTbhTxHj6yg?=
 =?us-ascii?Q?5Xwsvetdw9q9ZkJDZaxVTRnmiZnOJxfXfqbPlQZguv58WoK5D/HXnK8GWk6E?=
 =?us-ascii?Q?E/BqpC1lKy3xpsRgjUV2IkcioQQAxgrA8f5Mv25Y7nkO7iEcxt+fp2iKChJn?=
 =?us-ascii?Q?nyBwuFsamjEAqhQHN6LinALdNFtXKEquXrl2dmlwoN6WALTWKTyPwx5OuE4i?=
 =?us-ascii?Q?Zr/9pmu7qYBuRDh11H00+vepVU/wxMtyDuBoig8/MkIPjMnzEsouTiyjMRVh?=
 =?us-ascii?Q?a0ndxqG1fK08LJ4yvsDHz7O235R5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:56.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beaeaa77-dee3-41ec-785a-08dc69aef6ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

[Why]
Coverity reports OVERRUN warning. Do not check if array
index valid.

[How]
Check msg_id valid and valid array index.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 8e9caae7c955..1b2df97226a3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,11 +156,16 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.read_dpcd(hdcp->config.ddc.handle,
@@ -175,6 +180,11 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		success = hdcp->config.ddc.funcs.read_i2c(
 				hdcp->config.ddc.handle,
 				HDCP_I2C_ADDR,
@@ -219,11 +229,16 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
-	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID ||
+		msg_id >= MOD_HDCP_MESSAGE_ID_MAX)
 		return MOD_HDCP_STATUS_DDC_FAILURE;
-	}
 
 	if (is_dp_hdcp(hdcp)) {
+		int num_dpcd_addrs = sizeof(hdcp_dpcd_addrs) /
+			sizeof(hdcp_dpcd_addrs[0]);
+		if (msg_id >= num_dpcd_addrs)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
 			success = hdcp->config.ddc.funcs.write_dpcd(
@@ -239,6 +254,11 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 			data_offset += cur_size;
 		}
 	} else {
+		int num_i2c_offsets = sizeof(hdcp_i2c_offsets) /
+			sizeof(hdcp_i2c_offsets[0]);
+		if (msg_id >= num_i2c_offsets)
+			return MOD_HDCP_STATUS_DDC_FAILURE;
+
 		hdcp->buf[0] = hdcp_i2c_offsets[msg_id];
 		memmove(&hdcp->buf[1], buf, buf_len);
 		success = hdcp->config.ddc.funcs.write_i2c(
-- 
2.34.1

