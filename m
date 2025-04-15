Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C16CC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C000910E7D0;
	Tue, 15 Apr 2025 15:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2vaP+0P";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F7C10E7D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryzsXgrA0Zbl3WNCYDw3iEvtM03o9YtduRVpIThu4xtTME8Pw5iQ1uQKDXA/xcTWhvRNw/+SeISpDPpnEXuLcdOPcqpkTetmWzjWjfrl493YA70v7rUWgIT9Og6bVK2OWQzHEDySymNLzNLHl9nnQ9e29j+I2BloEt/VNBxtw4C0QawZBRwf2ouiJQ0f/rk2aTCemmR0oQ7hB8Y5UN4/QQG5s4UgxW8Mw5iqBcnXl4TOU3/t0qb5K10gpc95A3uQUv0J3w7XbKgVE0LUk+dspi6zqLcw2CRt/nuCBJgNh2b1Lzu4bxXwtzP6yzrOlaXQ1Qg39rTaC3cKXE/x/D50uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWLAtWp7QsUT2ZdNYiF4Hxfr7seOYetxaU4c5vdBxz8=;
 b=yILaTS1cAmz/mKnp+Bzjckf2Q74rJE9gtWMGnrZRBUAodwQVRZCNu+4T7cAakTkxV5rLsgAkvhmHdTEC488HyBGtCqh7uVf8MAFWn1emdDj1iZ7/xEt9mPcG+BZWIMmb/hgtHP0QG5Bcgw79igstg75UL6yAdr1C2Uke3iO74dpj150o5eE5lcF7vvmQ1mPBHJWN8PMZ8M3QCMCbd8ZjYXYH3+lCh6Dw5dobhnUTlcAkjkaWrv4ziidTWngN1Q1rNUcbdaL6Zt+WEH0AXw0TBbtEHS1nWUBoTwoudUu/lwoav1EFZUXu+zsZFa5DyvprWLJFD0J06uhkkWemgWexoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWLAtWp7QsUT2ZdNYiF4Hxfr7seOYetxaU4c5vdBxz8=;
 b=I2vaP+0PAYAY1ADXYInZ7Jc7iis41G6UYNksbUAEmGcK+WmPE029Grka2MKeLtDhbyvnCxpj9UFPAu4S5y0tKLeXF/7OwKSDAjq9IAhpHx1sR4B/eCIR+tKJgGF8GpV9/OkmZgBWYPTp426E8WYsGviT7i3r6G68nhK42RAMfC4=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:59:58 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::2) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 14:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 15/22] drm/amd/display: Use 16ms AUX read interval for LTTPR
 with old sinks
Date: Tue, 15 Apr 2025 10:59:01 -0400
Message-ID: <20250415145908.3790253-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdbfbcf-c9c3-490f-30da-08dd7c2e3059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PEdO1OXea2Nrjdxlbdha95yWxu6K+U1fdoFle8ZFS05SyH6YIUMtKMzePsfO?=
 =?us-ascii?Q?al/HWPbTZCzhwDusFmDsN5guevsbI4c/TDOcJcF0auJLGFCu43vvWBhmJ+w4?=
 =?us-ascii?Q?cRqeCY60yd1406h2RxuBCCs2oXYJbBOcLESQ4ZLk4xDp5LVzudtqiquEYr0K?=
 =?us-ascii?Q?NmdFHvXV1vMseuUDzpOtFu3nYw/fjRj89MYuiUuTJlR65W2c/rMb7W8NFghN?=
 =?us-ascii?Q?y1XoeJ+DEZae8fJ+ZH4Z5OdN81FrMLxIS8H2YybuIDsbMbN8hGj8I9sAi5t6?=
 =?us-ascii?Q?Exk1VnLa9RVS9cdqV0l2pfXPl5aJjRlMf6TslIOmc1BKP2RBcsO7fpewxYCN?=
 =?us-ascii?Q?Y5Qf7Pt1dmxnvjXzNp3dKwmujxSJdsaPyX4czcdhPTt9GQssZLXnAmgaGeJD?=
 =?us-ascii?Q?zID+HxsJbucHb3KX+h9/NcLosn1FpwjcbVvmqS/GlKBAnmynXPTaRrEUnyuv?=
 =?us-ascii?Q?80RpOAmuvbugCK5ytjI6IZnixiI6ZZODHxGpqLNfhVKNnNpqy7wHQr4DycG6?=
 =?us-ascii?Q?erF/lzLofajllESPaaVjzbVm/CENpvAW+A49Yiq1zbCEfOlncn2zg6giFQgq?=
 =?us-ascii?Q?PBOnDVr2aMgeJFBsfWSS6dSB8B831h8byI5HXFq+g6z9Qw9luIAKzTkxHmWU?=
 =?us-ascii?Q?yqLbvYc5l4uZfMtMpTOqUIpyhyZGi27lBl3h31gP1Vi3v7wDqKZgB1CSybf1?=
 =?us-ascii?Q?CgnMhpobcUu7GT6frpyEQRfaiK7LuNurincxtQfYfgeuwrHOzEYmsUgXfkY2?=
 =?us-ascii?Q?/C48bYQvyn1J736vmqAKu07uax4HLlwtGS+anSl1pp3U3fLwK7P21zUJjwrW?=
 =?us-ascii?Q?UoFUoyEnoFEsDxnnqVaKMXTEOgL2PoL+5Kx5tinQhUOkeD7LVhlOInpzyxqx?=
 =?us-ascii?Q?iRoYSB15vCiULD/3FRstEAzp6cFXEeOMRXChJi+MmBzgsFFISlZ9F7Ua+akg?=
 =?us-ascii?Q?o08Cv9jYVeO4i65h3hQMo16KO9He8dR9/cgTcxTqGFYpy8XOxU2oAtH6El1M?=
 =?us-ascii?Q?g7FLEiH1EmFWdaR+Bf88guKL3nhqcfp69ayskqfPgTI3uGz0n96npaSac2Oz?=
 =?us-ascii?Q?ImfIzomVHH5BnFTWtSvJCy08hl2fgy7iBTldkDt4iTvP/wCLarjtevcntO+L?=
 =?us-ascii?Q?xK14ldfC62yzHk1qFFst9tqtK18kJDxu/yOZ0++eJ2f6H4lPto9VJED3o5B8?=
 =?us-ascii?Q?6UQhhTLXOE+37w1SH0kXNL3z0wCsB/Fe8CJnUilkVV4jMb8uQA6QShC/4rDQ?=
 =?us-ascii?Q?43sB8Jgxq5iLzXyMy2zjYyha98OozPYkGl6B4oDrVHPGB1BRFWYXUSp2tXC7?=
 =?us-ascii?Q?FLWl+6hQtrMDVLjDXz1Wf4Cg2cFUpsD/mb6yx0fodU2pBJb2NjXqvQLRcfth?=
 =?us-ascii?Q?nD7MzctShMRU+Jb2ynDQw9F8JjTBhTCgj97V6pdeET+pRCzrA8mpz0Q5PD+r?=
 =?us-ascii?Q?lu6Nr0+72ZS/r7qZcu6+r0ll7JgtnFY5bFXJnzXxeTMENS0Oaf9I3Td2EfyM?=
 =?us-ascii?Q?u+uyTXXmq9wk1XvVEGZLDs8czvKDSn+uV+Fk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:57.7344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdbfbcf-c9c3-490f-30da-08dd7c2e3059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

From: George Shen <george.shen@amd.com>

[Why/How]
LTTPR are required to program DPCD 0000Eh to 0x4 (16ms) upon AUX read
reply to this register. Since old Sinks witih DPCD rev 1.1 and earlier
may not support this register, assume the mandatory value is programmed
by the LTTPR to avoid AUX timeout issues.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../link/protocols/link_dp_training_8b_10b.c  | 54 ++++++++++++-------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 34d2e097ca2e..5a5d48fadbf2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -35,6 +35,17 @@
 #define DC_LOGGER \
 	link->ctx->logger
 
+static void get_default_8b_10b_lttpr_aux_rd_interval(
+		union training_aux_rd_interval *training_rd_interval)
+{
+	/* LTTPR are required to program DPCD 0000Eh to 0x4 (16ms) upon AUX
+	 * read reply to this register. Since old sinks with DPCD rev 1.1
+	 * and earlier may not support this register, assume the mandatory
+	 * value is programmed by the LTTPR to avoid AUX timeout issues.
+	 */
+	training_rd_interval->raw = 0x4;
+}
+
 static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		enum lttpr_mode lttpr_mode)
@@ -43,17 +54,22 @@ static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 	uint32_t wait_in_micro_secs = 100;
 
 	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
-	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
-			link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-		core_link_read_dpcd(
-				link,
-				DP_TRAINING_AUX_RD_INTERVAL,
-				(uint8_t *)&training_rd_interval,
-				sizeof(training_rd_interval));
-		if (lttpr_mode != LTTPR_MODE_NON_TRANSPARENT)
-			wait_in_micro_secs = 400;
-		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
-			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12)
+			core_link_read_dpcd(
+					link,
+					DP_TRAINING_AUX_RD_INTERVAL,
+					(uint8_t *)&training_rd_interval,
+					sizeof(training_rd_interval));
+		else if (dp_is_lttpr_present(link))
+			get_default_8b_10b_lttpr_aux_rd_interval(&training_rd_interval);
+
+		if (training_rd_interval.raw != 0) {
+			if (lttpr_mode != LTTPR_MODE_NON_TRANSPARENT)
+				wait_in_micro_secs = 400;
+			if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
+				wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+		}
 	}
 	return wait_in_micro_secs;
 }
@@ -71,13 +87,15 @@ static uint32_t get_eq_training_aux_rd_interval(
 				DP_128B132B_TRAINING_AUX_RD_INTERVAL,
 				(uint8_t *)&training_rd_interval,
 				sizeof(training_rd_interval));
-	} else if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
-			link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-		core_link_read_dpcd(
-				link,
-				DP_TRAINING_AUX_RD_INTERVAL,
-				(uint8_t *)&training_rd_interval,
-				sizeof(training_rd_interval));
+	} else if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12)
+			core_link_read_dpcd(
+					link,
+					DP_TRAINING_AUX_RD_INTERVAL,
+					(uint8_t *)&training_rd_interval,
+					sizeof(training_rd_interval));
+		else if (dp_is_lttpr_present(link))
+			get_default_8b_10b_lttpr_aux_rd_interval(&training_rd_interval);
 	}
 
 	switch (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL) {
-- 
2.34.1

