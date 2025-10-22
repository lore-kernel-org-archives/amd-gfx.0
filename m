Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0EACCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6EE10E6F8;
	Wed, 22 Oct 2025 07:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHcJAGEH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41C310E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+41p8cy3yZ4QpwHfU77xV7ZeimfbqIhojemTK6Hu2qMoKEvtmnyg7vwkUp6w7kxrPJpuOyXZ0U/ifnp6PtvQ8LQDFGDGYR1Drtjf7XLKA4AgQEZKBNp3vmhnrcWq9j8IL+wi5hon5sRPpKOQqLwRHO7kSpvLmeYycx/Litsqkqeu/YeaBRYX6RPcaf2aoNVr6Tw06Vui3WtZWNdr1KFCgI130855viW8z1LCt+c7KlD0qgx3aRgthaMXtRnkPH2gwaQ+Kt6Bkq/sbxylF/Adcg37aMvYUr8ZNDHf993WaWDwVKzUz6hiq0cXhZyj2CAtf+bElG92vgVYM//BeqF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jwy9hjlx3xO7RGaHIesmjfY3GOZ75iG8z4F2zLNkCw=;
 b=fqG+yg9goK7Aex4NCd4WYWkCeFJJmj28OcixudnzFj+yzolVJbEXytGh6OehoqmHPDvV7fHmrTZn4aPEGqNNARewF0jhF5dYGr2sr+MhKaBuKiw1xcnDvMz1RZ7vRoY/FzKyLHaFgLsRxLFTs6HxBVKRf0QbvMjwZffQJ59kkz27qHdbzfFwdjJ3nN8+5bu3q5hh6Q7cMwYDAqHW2GsKOnlHlpu5Mzz7w5a0TrwuMoGjP+XBo7X0Q1zAdguEVyjcdq2WIf/8UvLiKUyqo4OH9xCDSwGpOjEX/3ofoAwp0r1wguV9ONZlCKTe6VmP7wkfR4dwjNI2A5HrtWaZ98XNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jwy9hjlx3xO7RGaHIesmjfY3GOZ75iG8z4F2zLNkCw=;
 b=LHcJAGEHIzlpQwgxlTL+3TQoHIeW3a3fCC0myQgh2dZXJFlcXIvN1E3UPmwPN3gYBmqDLO/o8RpzJgqCwNvvemaILii/vFsMI4RPrbhoW99mGas+jGA5aXp4Xs2qEUSmfKvRcMgLkF0Unvp/+sOEydVUxtQTID1xysBmNLZlhQA=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:33:56 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::bc) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:33:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:55 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:33:52 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/20] drm/amd/display: Fix DMUB reset sequence for DCN32
Date: Wed, 22 Oct 2025 15:30:14 +0800
Message-ID: <20251022073332.666119-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 775a64d1-0a1f-4225-0d98-08de113d5bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66pc6GKN7GUWYqZzxQF319ABAs3i3RwIwvwTOp4BBhyg/LTUVo2VfAA946vQ?=
 =?us-ascii?Q?4xIXScP00/0HOOoJMBEr7ij3hdOGI3vxRH2sEJdb9fNN93uBphcVzsRcYftr?=
 =?us-ascii?Q?fsKNHqRLvR59ZRK4LSBclEddHzL/Kwd6oRR/F5nFUszr6qcZ7hBmcqUiZV7s?=
 =?us-ascii?Q?aieoEhQaYUsR2z8vHobOcBAHKllFq079jGjCwLmeoy3PCt+rBh4q+z212TiE?=
 =?us-ascii?Q?GZivd21nxiZQr9Pajv9SDh32l4U5LQZTIBm9wrT/c3/07xMRCoanbho5N6fW?=
 =?us-ascii?Q?ph74ipJh0dipR1mDmnm3JXDebtnSqOGXqjchUZooUd8bzQfaGqg/loGr4rVK?=
 =?us-ascii?Q?X/OxH6uV/4L1/TCE7L8I2ErQ8lCm0RIqs/pySf0i3uLHJ2zrqUdavJgVDJyL?=
 =?us-ascii?Q?XDosH8HDT3PZ2G30k1LgVbxFGUCSzWEVj2UxLB+b7ImHgC7ofJFcYaE2TL0T?=
 =?us-ascii?Q?hMKmQiGFpmAkFEA4nClOZOF7Ry5SCZmnV/PB5NYj9DzQT1wtpWUQ2hbBAX7V?=
 =?us-ascii?Q?FhOwmoyAwen7DQAlKs7vfThn8qgTVwazecD5hIXHQSpLmEzAxCgjKnQAhUpO?=
 =?us-ascii?Q?73VvKDE5IApLEA5FRhLufu0za96p19KWRc/Kf3B15C9YpiCy/OjwTHUqdcZ2?=
 =?us-ascii?Q?mPmoWp1Q3cz7YPVh5O4yMsvnSln7D7DZpAZZwuFESDji8GNL2I9ACXv+dxFq?=
 =?us-ascii?Q?FbRoadmrPvkPK/xG4tWHwMHPSBPom8Mph8eKWykOhxuZrH1LW/uXNsi7Jw7J?=
 =?us-ascii?Q?zVFErD1Le6OKczTs+iCckAR+MiOh32bL/vqklPQE/P4Q1VpCaPWh8bYa5AZ3?=
 =?us-ascii?Q?71uc8rLLwYwDKShb6PtDS+nEoNqtUIKWDPIqDdTlg68Z2RqFsZW2zTKyTjSN?=
 =?us-ascii?Q?2GTCQZUxCHLpXv79zziA/AedpzBNqYU3Kkby9S/fLrBeU5C0T5h9dwbA4meA?=
 =?us-ascii?Q?quVo9aeRC1RRhFx7fSS3VFtUMzTyxHPy/Jz/QmhiAQSsd11tkEQCItDIDNaZ?=
 =?us-ascii?Q?kF41NEO96/nBwdwFQkF972fsHac4kbvlyimzrmfpKxOp5sxZ5BxwVOLXKTzk?=
 =?us-ascii?Q?Bwdz0HayvLNboMQ64JWDZJFTbulgsFTQB3TLMqCtwQMayncT2Q4IcnFhWDMH?=
 =?us-ascii?Q?og5z9rvmdHoyNStsrsqrX8RNECJh3T39BQh6r16PGtwRKtxgAfEIdPeaJYtN?=
 =?us-ascii?Q?A8/DnnBUnpsyfmV519bz28cWaf5hIaWEOmd0Nhyvx/zpSTiXazAtz1rhLi9X?=
 =?us-ascii?Q?jGF1ajeXmM+Y7dALWkRHpSe5nAjHJLRPStAM6qzoavr+iRM11OHqvSNhTSQ2?=
 =?us-ascii?Q?aO4n2vY9OfkJQoL5dVtIiJNFnMAoi4/bBMWMzrUuFkECLpUyBjKLJSBqhPfo?=
 =?us-ascii?Q?D/yatLwS55jvKekeCkPZPij8y71ArJzBcrhpIOP+o79ZZNPXSO51U6bGBHCh?=
 =?us-ascii?Q?RLrV7122swchPCq08LvSqFYjcQVIrmBF/X8Ij+RGr7iw68gu7XSDOnV5mEqe?=
 =?us-ascii?Q?JrWKb3vq3zpXJwdrwIth1wPtqO4UCAP32vMn7Lwcg7+VuwZXkCowc81oWn54?=
 =?us-ascii?Q?Yi/PKsluwsPSUGmgbloXjA7PSDY7xhGQJa6FfpA6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:33:56.2836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775a64d1-0a1f-4225-0d98-08de113d5bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Backport reset sequence fixes implemented on DCN401 to DCN32 to address
stability issues when resetting the DMUB.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 50 ++++++++++++-------
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 17 +++++--
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index ce041f6239dc..7e9856289910 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -89,50 +89,58 @@ static inline void dmub_dcn32_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn32_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100000;
-	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
+	const uint32_t timeout_us = 1 * 1000 * 1000; //1s
+	const uint32_t poll_delay_us = 1; //1us
+	uint32_t i = 0;
+	uint32_t enabled, in_reset, scratch, pwait_mode;
 
-	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
-	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+	REG_GET(DMCUB_CNTL,
+			DMCUB_ENABLE, &enabled);
+	REG_GET(DMCUB_CNTL2,
+			DMCUB_SOFT_RESET, &in_reset);
 
-	if (in_reset == 0 && is_enabled != 0) {
+	if (enabled && in_reset == 0) {
 		cmd.bits.status = 1;
 		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
 		cmd.bits.param = 0;
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		for (i = 0; i < timeout; ++i) {
-			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
-				break;
-
-			udelay(1);
-		}
-
-		for (i = 0; i < timeout; ++i) {
+		for (; i < timeout_us; i++) {
 			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
-			udelay(1);
+			udelay(poll_delay_us);
 		}
 
-		for (i = 0; i < timeout; ++i) {
+		for (; i < timeout_us; i++) {
 			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
 			if (pwait_mode & (1 << 0))
 				break;
 
-			udelay(1);
+			udelay(poll_delay_us);
 		}
-		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	if (is_enabled) {
+	if (enabled) {
 		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
 		udelay(1);
 		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 	}
 
+	if (i >= timeout_us) {
+		/* timeout should never occur */
+		BREAK_TO_DEBUGGER();
+	}
+
+	REG_UPDATE(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE, 0);
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
@@ -141,7 +149,7 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 
-	/* Clear the GPINT command manually so we don't send anything during boot. */
+	/* Clear the GPINT command manually so we don't reset again. */
 	cmd.all = 0;
 	dmub->hw_funcs.set_gpint(dmub, cmd);
 }
@@ -163,7 +171,9 @@ void dmub_dcn32_backdoor_load(struct dmub_srv *dmub,
 
 	dmub_dcn32_get_fb_base_offset(dmub, &fb_base, &fb_offset);
 
+	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	dmub_dcn32_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
 
@@ -193,7 +203,9 @@ void dmub_dcn32_backdoor_load_zfb_mode(struct dmub_srv *dmub,
 {
 	union dmub_addr offset;
 
+	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	offset = cw0->offset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index b31adbd0d685..95542299e3b3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -81,7 +81,7 @@ void dmub_dcn401_reset(struct dmub_srv *dmub)
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
 		for (; i < timeout_us; i++) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
@@ -97,11 +97,24 @@ void dmub_dcn401_reset(struct dmub_srv *dmub)
 		}
 	}
 
+	if (enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		udelay(1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	if (i >= timeout_us) {
 		/* timeout should never occur */
 		BREAK_TO_DEBUGGER();
 	}
 
+	REG_UPDATE(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, 0);
+	REG_UPDATE(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE, 0);
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
@@ -134,7 +147,6 @@ void dmub_dcn401_backdoor_load(struct dmub_srv *dmub,
 
 	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	dmub_dcn401_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
@@ -168,7 +180,6 @@ void dmub_dcn401_backdoor_load_zfb_mode(struct dmub_srv *dmub,
 
 	/* reset and disable DMCUB and MMHUBBUB DMUIF */
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 
 	offset = cw0->offset;
-- 
2.43.0

