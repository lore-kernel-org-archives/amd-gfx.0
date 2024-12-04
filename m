Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35E4E77170
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 20:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F24310E575;
	Wed,  4 Dec 2024 20:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E81QQxn0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8056F10E575
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 20:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omfLBJMb2p188BxdLnylRrBHQ+9m6B6Bj+Q/F9bKcSEjpeKIkOxFwcnc9NdjzjnQI3Ro9MVXn6/N3XSVeUSpqN0tWz4X9DWbLDdlOot7TnOa/albJCpFGAbJzYU/zWFz2Bj56YWMMFV7MfMhXQbT2ARfvdVdWmrVYRGl1rTJCdM2d+FSFIzq+PdTQ0ts/rJpHS5ISDT5t3g9/vva8HCZNLSS48yQ8u5eemCpaRIxbMN8M88+B6XIltix+WbhVkAdVZWj6GfnzWXf4tjkyxX9VBVtruSV1MgxfY6xfCi72xnfG6l1k53Z2rnsf85G4+JcCKDbKTDcqNKRNJAJ1UZ/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEcBPwlnle7//AgU37rY9N5CMIt0MVq813knE23pIE0=;
 b=a+qyWlr1ebShAQn8tP55sP6VSB9c6Edt8D+6XTHdITsVXMHGNtETyZWYaaX4TE40f6CkWvj64QITcdALDHf2DQVBt8R22xQkTf7hb43/p3aPcTEoDzoDFjDiSdZc86kvmCoNXaRGYBDNjBUQq3p1cd1Z/VAK7kZDAGOuWAUGQn93M8SokzeNZMpBSKFjP08ESlS82fmMy/4O1wguuZcySeG2wwdPpkYfuV2dE6O3f7hz7yGNBudUTWaKATL/9m7WETgqLST28B9WjixcgjcF6d2F2974T0VPI8QOF5xjjGnM7zVRU3p62wRxf6UtFtSCmDyfuo8XwFsNdrAehnpngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEcBPwlnle7//AgU37rY9N5CMIt0MVq813knE23pIE0=;
 b=E81QQxn0XiEIYvp0fKl/ctECy8e43TcxLJAPrXhGGlaagHh9E5qHnlxaiAJzG/c8/msjThZCkbMUw+hRov/Re6BbuUkAbAuEDEa/Y8WZ/UNx5UC8PvjkA7uP3PyIyOiSQK154G38NFmCE8HPCamUcjyyhqRxTOWPrEvrNs4lSyA=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 4 Dec
 2024 20:28:03 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::b) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 20:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 20:27:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 14:27:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Remove double checks for
 `debug.enable_mem_low_power.bits.cm`
Date: Wed, 4 Dec 2024 14:27:42 -0600
Message-ID: <20241204202742.95271-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 481d9529-d5cf-4bc2-a1a2-08dd14a224fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ax0lIluT8H32+Y0uzTR8qesnEDpFH1Xe2ZnbFVgmNksCsZsLybkS6kL6bmDw?=
 =?us-ascii?Q?jzbYhuoBSmO+I4l4ePkOzjtQfOxLTMO/niFaQiQw4ndJgL5ZvQ4bu4xLxmll?=
 =?us-ascii?Q?zXe02iu0xYxskVwX3U2n61yg2Oe8oBOBypSDHnAumwECssVdiN9SFTQDdcOa?=
 =?us-ascii?Q?3jL3n7U0KlCzeZbPVuL1aohA/0w2+sFulCBivlhjdNGueeRDVEzhYfRpe55O?=
 =?us-ascii?Q?Gix1ioKGMWeFO0xUQwBR+B1fmXj6/DMK39aheZq2lgvrNj3/FJaBtmCnyLaw?=
 =?us-ascii?Q?WytEcb5iLziwBuLTOflSv0XOXWeQOeagstE5NudHVH8iA/nTQK2HPbx5G+V1?=
 =?us-ascii?Q?/J6e9ZD8KuhlsXVAlphBgEne9ihSZIP9dCFs//XKO0dLr66QwUUwAlYCObiq?=
 =?us-ascii?Q?vMW0afIx/5zcCwLTDYEae+WWdZbTv5P52eD4ntfkh+afIgZwEuSGw/Ng/36J?=
 =?us-ascii?Q?yF69mOHegy83Y6pISK/azeCVj3AL9Ory80u3Tsiuyci57BvbShnCLLl477mY?=
 =?us-ascii?Q?s1Wpg3F8o2bzTahPZAbHTtoj4bgTz6WEMysJHdf9MMiEuW6UhkhSSmKd7vkf?=
 =?us-ascii?Q?abFjnSg4xFnQ9STJ6HSyN1zaNoHRlxncH4NPvPpSCHSxkpQUVLdi0Dtc0qgC?=
 =?us-ascii?Q?yeHZG/MlBe1SUFyiXJHjYARXxrmFmJ8LWSAAU72D9qlefT/vvU4tOuQMetFp?=
 =?us-ascii?Q?6rrxuVOvlVb2/G562iYTV5us/YpWEwrXxI55VqLWbgfoHH8Xr5PgehX06LW9?=
 =?us-ascii?Q?fzXM0dm9gFXE6/aucS9Wrfy05lUfpRWuwvH7QwI2ROl/x+Gy8nsdh4wqQkfY?=
 =?us-ascii?Q?EeZru6jG/Qw3PDfQ2tU5fl/qbZUFRp4o5YmDr18+s8fVgcVduxeJH5SnESqD?=
 =?us-ascii?Q?kI8yV98605meeheQ8d8h7JtQirYqnK3ZZZyFMPZlVWxbxi8GBCjYZPJdA6MW?=
 =?us-ascii?Q?te0BFxPhcp2VTqGxjxOcK7b0dHgMQPF9R/J7/7k9ggTN06vSnY6m7glQA+UP?=
 =?us-ascii?Q?jGJnyLC8PdE4lX1eyx8hpkeOlqrbppzhTSztV0EGuZ35UohjJ+CG2VSPLfy7?=
 =?us-ascii?Q?3jAqER9ZseulfRPtcS2THF66e5d9mIMHwa/vWBSXJnt1jn/fYfjCHdlwgZOn?=
 =?us-ascii?Q?y3sZXzGTM6C4TFAaJjzsOF517eJS2wnJ7sIwx2XDvekdG5emQm+rr2f/fh/Z?=
 =?us-ascii?Q?cR/vWW2sN5Wh+X4bM4J21aE4YD7dFqWnL+2ZBvRm6P6O2N8iSN50ygO6356F?=
 =?us-ascii?Q?M43o9ugA15CSZSXSKgrkTBFPr537eErTeg3TrhrXaJwraBp629XyeVrYR/hd?=
 =?us-ascii?Q?MZWdPaXoFWCg0ocb6H66+tZGWGyCrCizxd1l/lYnkSX1K5ed+90zT2l5o6Xr?=
 =?us-ascii?Q?54fdAW1gYAKoi2ueOZ2gBEcFlwWc56fy1sjD6+5RSckDrn+dAnoVRco7bLJ5?=
 =?us-ascii?Q?Wl9gf3hq+ckBJhJsSFw9ETWRnVCtAQ4g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 20:27:59.3647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481d9529-d5cf-4bc2-a1a2-08dd14a224fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
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

A variety of the 3DLUT handling functions check
`debug.enable_mem_low_power.bits.cm` both in the caller and function.

For each of them reduce to just checking just in caller or function.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 31 ++++++++-----------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 40acebd13e46d..53565b60cd847 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -589,14 +589,12 @@ static void dpp3_power_on_hdr3dlut(
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		if (power_on) {
-			REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, 0);
-			REG_WAIT(CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, 0, 1, 5);
-		} else {
-			dpp_base->ctx->dc->optimized_required = true;
-			dpp_base->deferred_reg_writes.bits.disable_3dlut = true;
-		}
+	if (power_on) {
+		REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, 0);
+		REG_WAIT(CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, 0, 1, 5);
+	} else {
+		dpp_base->ctx->dc->optimized_required = true;
+		dpp_base->deferred_reg_writes.bits.disable_3dlut = true;
 	}
 }
 
@@ -606,14 +604,12 @@ static void dpp3_power_on_shaper(
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
-		if (power_on) {
-			REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, 0);
-			REG_WAIT(CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, 0, 1, 5);
-		} else {
-			dpp_base->ctx->dc->optimized_required = true;
-			dpp_base->deferred_reg_writes.bits.disable_shaper = true;
-		}
+	if (power_on) {
+		REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, 0);
+		REG_WAIT(CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, 0, 1, 5);
+	} else {
+		dpp_base->ctx->dc->optimized_required = true;
+		dpp_base->deferred_reg_writes.bits.disable_shaper = true;
 	}
 }
 
@@ -789,8 +785,7 @@ static bool dpp3_program_blnd_lut(struct dpp *dpp_base,
 
 	if (params == NULL) {
 		REG_SET(CM_BLNDGAM_CONTROL, 0, CM_BLNDGAM_MODE, 0);
-		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
-			dpp3_power_on_blnd_lut(dpp_base, false);
+		dpp3_power_on_blnd_lut(dpp_base, false);
 		return false;
 	}
 
-- 
2.43.0

