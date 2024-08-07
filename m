Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FBC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8536910E43C;
	Wed,  7 Aug 2024 07:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="op9xHW98";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE6F10E439
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJsJ7x9qhOKtND5wZM9C0GFKr+2a6Dx81hP1tf4Mk1tKS8OjI7g+qGIAiaeaCkJRBHEcm8hNHQmnM1LTTawYjhIFyH/P0S2ok/THfQHAadq1fsgevTOQmJrD6NEfLFDMin008J9eLXrGeDz7cLHClKG4AOkQ6bNa3eO+nS2RsUOcdx83XePebC7vSqTQDdXrcpotb+OZ5lBQKDGJb70rGQzGk5npsIVefoqCaexR61xBOlpOgIPoQDhBMPESTZ8Hk1I+Uyx522O8T7Rus9TeT3tpaFNTmagjCCMpezNbNBVCipO0eb0c3qNRIrlJJdYROasRcYYe0ENvh1EhZkfkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kgXzd1BvZf8cKu5P4EhqGrbqNXtDstr1HOIGmS0zeU=;
 b=Zo4K/2nUyaMsGle6B4FfXIpdc0blWOyUwnxzAEVanIrfBuSxDOGlwfLar1QAXWLmVVleK93wKZVd9kgt6zwnqBxq5RVnlxDSvBBN4GoRN+YfbR1USZgaK/7zGfRxafqeq3Dzg+Kz8AzOfjH0T3BQunTRt5yXiy9UpyheQ8Fqqc1xEHVPTfzFTNCy31UKNM+I23C7YX5OK/CcZJCq8zvapjns2P0MrWM4EeJhQNUgQop09bZV5ZKwDLOpmd6sKI/9fP+oHHMtkpHaQyaFeJAYdslhl00ZxcAusVKj123Cn1B8t5I4RgAdbeHjiiO5665vutujOy4I27mfbJRxRy3yUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kgXzd1BvZf8cKu5P4EhqGrbqNXtDstr1HOIGmS0zeU=;
 b=op9xHW98bs28ZzzER9EjkNjz9b5jz46sBE7trwbjZKjCU1rKowf8MwXkyeV3QCl0jRA2fskkZQdVh5lC5h4yG74pbo6ImvuwIfyNCvWV373MKlWj4DEzD7hASiMr+XoJVIUYRsJmbUCjl6bqtgXIGBUnU+o+7gC0iguRrhajp9c=
Received: from BN9PR03CA0795.namprd03.prod.outlook.com (2603:10b6:408:13f::20)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Wed, 7 Aug
 2024 07:56:34 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::6c) by BN9PR03CA0795.outlook.office365.com
 (2603:10b6:408:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:33 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:30 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 08/24] drm/amd/display: guard otg disable w/a for test
Date: Wed, 7 Aug 2024 15:55:30 +0800
Message-ID: <20240807075546.831208-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e92087-d653-4a4a-0a43-08dcb6b67539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nbtZXlIC3d6YNIJ+Eq7BrqT0MYLnB8/8BD/l2/wDEKelMd+5zV1M5hAT5WiN?=
 =?us-ascii?Q?6UJwhYnIWawindy+HyP8Qg50hCN9/Ih4TPj3Ua/wOIP1XbMoEJbgHQ7qtqdg?=
 =?us-ascii?Q?yGfHNEZcarPrNKO1Kx1dKNUaOwwg87wTrF4VZGickP5QjdlhZ3YACwanbSxd?=
 =?us-ascii?Q?AhrmEHs4LADzly1oFCLC8s7Q5oo7yagYSDZgbrvMRlz1AvBg8/cuWRfSfrwp?=
 =?us-ascii?Q?11mvcx/28aL8FURjuld0MeG4zEDZEX2siVfeU45XKU6S9lHq/JEglBW3sV7O?=
 =?us-ascii?Q?InMr42RqASirb5R2k+gNIAskhLrdl5L7PcCQGPReroh+cZaqfG7gC1FMh6fi?=
 =?us-ascii?Q?JFlbso0R7YyaDIpTNP8SbHlfS3+6favSGg+rL98S/CwFIwSreZWiAvHE/PIH?=
 =?us-ascii?Q?k6CiiY+tmacRN5pWdB72LscLF1B+v3B4ws9mXyNkSGLPjjYWZxe6XlMHvFpU?=
 =?us-ascii?Q?erECHIy1hvNJy5CMaKmoS3QuNVTtJvdfj4NU/RTGc1ak6JHxFGWS/bHwZLPS?=
 =?us-ascii?Q?NYddehWx5fvunfpA2u4E1ugzhSmGebC8yqrS3oWfCR4zSFJneteRSiosJOZq?=
 =?us-ascii?Q?orIs7lhwNZqQzt/yWwP+VvHW+ry5cvvZymf6iKArpaHNSayvAz9yQpIhpe/r?=
 =?us-ascii?Q?Vp4DUWaJ2JZ7pwRQijNd42IXVqFt4tdZjJkAi3yQDF72ms2HUfYpyAT6rM3O?=
 =?us-ascii?Q?8m2JETh0hV9/XlkKYn5kvxzf4EFeoBJB1YQePkcgIqQsPM7CAsx5+1rKQS4y?=
 =?us-ascii?Q?920lhobYGhgRtmJ9ucMtvjBhpu6otjp+yhgJeJhkAp7fjv9GLG9O89Nl7EDt?=
 =?us-ascii?Q?7bFCL9DulRJoWQ+ggOlS7Rxr+bpfJiXM/wbPmL8wir7JAAfpquE2ukHNjlIm?=
 =?us-ascii?Q?dV8cWejdVWvUiXEbCUj604BAGPv3Pu8J22xeItJdFDLO+8PYqubKEnlgtMyU?=
 =?us-ascii?Q?2rSc/YBHanXBmRQJl84k+I4K/N6SdpNa3n6vYCliYhCp7BeYV0YpCbeWfeco?=
 =?us-ascii?Q?UIrBxQfldKzKlMrLGG2faysJEm/ZFbRBZf1vAm499wxxNCOPdhcvpAohBRuL?=
 =?us-ascii?Q?UEKEMIE/PVmLbySLGxaQAotmPsoFjJURrfcIyljdG0gtBbFanYqwMmuFgwHc?=
 =?us-ascii?Q?05UFyvAu3vJv7dD9O5IXdXGuUdgvqREObM72LRbvwXPH1HLibHFe7bkhA5ju?=
 =?us-ascii?Q?1oxM3G63aACzIAzjYJdcuBqGTxY87JUxMgxwAaDP/OdeTTzjnsvn9hye1y3t?=
 =?us-ascii?Q?oOJ41eUjBncTMes52/5J/L0Eh1lxoZ7R801HJgCiujlVm361QgGJHhSeEF9C?=
 =?us-ascii?Q?sNUZ8iC1XpkHPSftl4bQq7ctNmYhTs+C2egpD30H2xgKo0p/H6td7oY6bRQI?=
 =?us-ascii?Q?Rj/fFr3khmne1D4lOkpbiBGNdMnHZGDMLsWnLlYf/BUtQ6Fu/Pa99AJGcmEi?=
 =?us-ascii?Q?f39p4J00nCGfRgZzaPSN4Jjhkt9jidvr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:34.5962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e92087-d653-4a4a-0a43-08dcb6b67539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why & how]
HW removed this w/a, but we will still keep it to avoid regression.
but return in test mode.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index e075b2720f96..e2d906327e2e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -126,6 +126,9 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
+	if (dc->ctx->dce_environment == DCE_ENV_DIAG)
+		return;
+
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.34.1

