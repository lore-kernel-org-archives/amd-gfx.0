Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C442C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E59A10E89B;
	Thu, 25 Jul 2024 18:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OoLkogsP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F7D10E89B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzcXK0I0MTTRY9FD2Z2yaZR5OmiyXPjz09LwCTtwjNgzqo2GzG9ThGH21IuP40zg99eVUq3cd6yF5a3PN2OscWAB9+rJjSX6VXqQ1Z5n366bVyeOeCfPMp+fSpqY2FbouYL+ejx4biH1mtuLuzZMdyCxwIW/HJTKHbJuHuZbibJPlP2DBvPA6lJoYtsQbPf35NWzQ5ss8IjNZrLBjuJwsMGC9KfUwbaO2Tk+kajE+Izs76f/ywWIDERUvxMLfaxA18uGCocDhuBlWv671d+ya0J9HNbcbqGoAevQh2TkxDlYzHSKKxuq4pM+iIJKsBrHBM39yycw/2gvXWzEg85ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJOgjHgv1se+BDXvu2ZVdpSOx3pKSS0MJdQHymEpxac=;
 b=HtY9GjI1l8n1tRSsCpDxEJJENbSgv4k7zIv7pUfUue8pTluBcOFY96V/X+hGkt1rNqfFBt5BAXvEoJXQ70kllgtE6COL9EmulAxyuZSSbGRFIL3Nmb+pX9ni8RSkZn0H2DODujkJXrOVA+bXzfHstREHvFJnr0Bzc5tDwVod+7TihXMohVaa/pZB9ivzybn/dUIcPA/FfDp1kv8Kcaap78vQ8kolVQq8lkQ+Lxr8cEaVD2YIcPf3PF10HnyUDg81y/3TTpkExYHkw95Uoxi0RNsy8QDvVwMycgiJLL4uvYCLh5QdeIgm34BHhZTKCwD1oN26tIHHIlcEUS58gAktxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJOgjHgv1se+BDXvu2ZVdpSOx3pKSS0MJdQHymEpxac=;
 b=OoLkogsP+wt49Fr8A18FgzztGfyKMcxJ/4C27a5PDQ/pWTX12miJZVVSlNLWY6r4/ojVWjf/Ah//RNzCia+Vd/92zvZAOLQzXuDQg4SCOZAgohNyIvBnp5xA6rRusc+X/0k9xnvfkg3azebKCmhxyEDjQTBiJCrWXFTFZN45r04=
Received: from CH0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:610:119::10)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:04:11 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::bc) by CH0PR03CA0372.outlook.office365.com
 (2603:10b6:610:119::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Cruise <Cruise.Hung@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 19/39] drm/amd/display: Add logs for debugging outbox
Date: Thu, 25 Jul 2024 12:01:03 -0600
Message-ID: <20240725180309.105968-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c980cdd-1297-45dc-d367-08dcacd42fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?83/XDuOeKTp7XpqbS67oon+c2Iu75Sjpm2Mg2yX4aEAIsOtCPhAQ6wj8yHTv?=
 =?us-ascii?Q?eUxklwsRJfMNoFx4kZbZeYAYmu0bnRYGwoG+NnD4bnH9LidsNvn/gf5+4qNX?=
 =?us-ascii?Q?QmIc8slXF3AToInMIlrYrdrP7mS1GGRN8P+6seh/hRdfkDWgGIbLSXGbMw0t?=
 =?us-ascii?Q?6m1g48L3y27KHKx68qNZsmSDj1EbCzU2nfuJXDVE9kwagsogNxaMLfG/Ie69?=
 =?us-ascii?Q?GNPuR5MP08QM3ywwlriy1OjAVoJFAq88azTRb8mugHJdDr9NnZwKdklQMFB3?=
 =?us-ascii?Q?VvU9olHZFvWv/89fEg1bDIGN27GlGIM5xW9OKijKZXZHp1hrqpKQb0f847mO?=
 =?us-ascii?Q?kd77hF30dGiBT+0flSLCxVe3Egyp+gnCh5wXn78npV1gqtbXLwnpwL9MAyJP?=
 =?us-ascii?Q?Pd4lNss5dFZrhpeXLx4yUXULQs86SMSaAoPADb02lw1K9PiiAdK09TL4dDC2?=
 =?us-ascii?Q?Go4sX3ukWHzfwGdseZtgJt4ljvlr5+2Xlli0UTfIiidFH28/dRwap+xv309W?=
 =?us-ascii?Q?mA2KGV330OAdlqPaOEy12J1UoQ4CZDTIpMyp8ReDnKf1xUJJBS7wBrH0qRIz?=
 =?us-ascii?Q?zRRXIWIms4fN6HGEV9ZShAX5miUQhGKa8/2a65Ci0jx/DaYl6Zbzpe+1rriF?=
 =?us-ascii?Q?A+5m2Ai1Kr0UU4Z1kFdquP3i1Y7LZDcx28PFfgkxhsVEWdCwvyghlXIlwKS3?=
 =?us-ascii?Q?bvofDpfLEdhoheIIm6308a7Zlr+Ix7qF9dNM0TTKwLQAQia38oUsrVPyPSks?=
 =?us-ascii?Q?LW8+NFqVTaW02UdhSCLrB8VW3efr8dC3v8+luwOA7pSEuVfs4zop+I6Uwsnu?=
 =?us-ascii?Q?TB0a2nEzzqa1/OqEbTXSHaecLxFGZJUCHr0bDbgaO4GDFBzYzh/D1OTOU+9V?=
 =?us-ascii?Q?xivj222cgI+ORK+A3tnoXKeCYUoZcwsU2pWeOVWScYIn9xafhXt0dsxFqo6D?=
 =?us-ascii?Q?JNoKvQ0M8pwS82+iK3XENmDh2q3NBD9XvrDprTJHqZlW2FU5cxikaFwLU0q2?=
 =?us-ascii?Q?yALUPfb+sD4eLG7WRdv5yqsSYKh7NxX6e9BdefGygAdZvHYZUQepGqPFFX8c?=
 =?us-ascii?Q?cOIiZZyV1aSoU9AMA6l/+iOtfh8CeVVF4GUkejdajzzXdKbG63LJaAVUFkJj?=
 =?us-ascii?Q?Rg22KH4LfcqAkzaJrOwe/kN4RFmU0shlOc2vSVu4XbDUiT1CuemaoXtX40Pa?=
 =?us-ascii?Q?xkG3Bnv4YI0fTvs0L4NSUPVRxmwPuc+F0YBinrlJlw+ipnR4+Cr/4Gw300iq?=
 =?us-ascii?Q?nec7vELL98J9qC9BNfbbsWaqNAZu+Qo05UXAiliKAbf167Ch3os/gAJBklSZ?=
 =?us-ascii?Q?qRwaKXp+30TMiZhwMZrUwzFbLKrXoOtU/fAK2A3u7e1e/HzDBvrHsXxnFHfH?=
 =?us-ascii?Q?Dg6E+niXwUcp2HkT+fCSd6xAePNtZrmEXZ5t/sksiuJECYgs6UUzcDzdE1Fr?=
 =?us-ascii?Q?E+8IBPlrXEVH7MkwcXv+C1DZ3NNtwAl1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:11.1180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c980cdd-1297-45dc-d367-08dcacd42fc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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

From: Cruise <Cruise.Hung@amd.com>

The DP tunnel AUX reply is received through Outbox1. Print the Outbox1
status if an issue occurs.

Signed-off-by: Cruise <Cruise.Hung@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       | 3 +++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        | 3 +++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  | 4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  | 4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  | 4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c | 4 ++++
 6 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index fb3391854eed..41270fade5f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -979,6 +979,9 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	DC_LOG_DEBUG("    inbox0_rptr        : %08x", diag_data.inbox0_rptr);
 	DC_LOG_DEBUG("    inbox0_wptr        : %08x", diag_data.inbox0_wptr);
 	DC_LOG_DEBUG("    inbox0_size        : %08x", diag_data.inbox0_size);
+	DC_LOG_DEBUG("    outbox1_rptr       : %08x", diag_data.outbox1_rptr);
+	DC_LOG_DEBUG("    outbox1_wptr       : %08x", diag_data.outbox1_wptr);
+	DC_LOG_DEBUG("    outbox1_size       : %08x", diag_data.outbox1_size);
 	DC_LOG_DEBUG("    is_enabled         : %d", diag_data.is_dmcub_enabled);
 	DC_LOG_DEBUG("    is_soft_reset      : %d", diag_data.is_dmcub_soft_reset);
 	DC_LOG_DEBUG("    is_secure_reset    : %d", diag_data.is_dmcub_secure_reset);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 6589bb9aea6b..cd70453aeae0 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -330,6 +330,9 @@ struct dmub_diagnostic_data {
 	uint32_t inbox0_rptr;
 	uint32_t inbox0_wptr;
 	uint32_t inbox0_size;
+	uint32_t outbox1_rptr;
+	uint32_t outbox1_wptr;
+	uint32_t outbox1_size;
 	uint32_t gpint_datain0;
 	struct dmub_srv_debug timeout_info;
 	uint8_t is_dmcub_enabled : 1;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 662c34e9495c..d9f31b191c69 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -449,6 +449,10 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
 	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
+	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	diag_data->is_dmcub_enabled = is_dmub_enabled;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index e1da270502cc..9600b7f858b0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -459,6 +459,10 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
 	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
+	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	diag_data->is_dmcub_enabled = is_dmub_enabled;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 916ed022e96b..746696b6f09a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -502,6 +502,10 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
 	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
+	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	diag_data->is_dmcub_enabled = is_dmub_enabled;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index cf139e9cc20e..39a8cb6d7523 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -444,6 +444,10 @@ void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnost
 	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
 	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
+	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	diag_data->is_dmcub_enabled = is_dmub_enabled;
 
-- 
2.43.0

