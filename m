Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF65E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBC310E517;
	Fri, 20 Dec 2024 21:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5YwHXpc/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E4D10E094
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbSIyxUFR6SMVRYSERKzzyzGEyuLu10vPOoPgUfuKLKLAaLBDW2Tw2d9e8MuCVsp9vPEX745tcSkr9GcF88BVJaCOm+mf0MHLS+UzexHgBCvrTE7HTyOjLtg9rdd0UGqHcAUGisbCAf4AwZar9hbpr7yIlYaqgOza7jgl9cI037u+CgARreGpKK+I+ai7mh1qBBUFKYbkTQ4okezzbvcXxVwLDn5lsSfY/tuQnbCJ/g18A6xMLXIcvP+ph5PFAo11tJt4c6EP9uuJTnoSXwlXcXUAAWvqgYuJy8gfF+rq8afMxygX8yAopDYniA/eelUNUfXpVRITUSnNnRvekICDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBEL0z5zbrgEpazDFfo0oZpUpJOkDI3QZYpA0PAVVJc=;
 b=EnC75PusmpsVDfwNHwlncAeybrM9MhqKuK8NcZ7b2h1zRrkPcV+W/7N01j3GE+cfTQ0pL9n9TZ71OdnMSTTWHNoCq20Dy8DEffMSl31/PZ39SgDlsrbiyNwqrhBM8DqZ829Ezdrv8BMWDoAQuq9/ALBa6qa55znb4ENU20RgXRSH18alIPhgyvv9P5F0zrIf8bzDlPFgJQEopI65E3YdjGkQgoJh7F+7QUMxwos67K8VnRHiwHLz/aGOIfpUx8r5OlQLGoW1ZBG0RJ9Jsa3WR2VreYP4b5/3b+rfzrULrfd0icRFvOmfgP4ZkzxXfFSerOzv7vTDii2S4U4uGVUwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBEL0z5zbrgEpazDFfo0oZpUpJOkDI3QZYpA0PAVVJc=;
 b=5YwHXpc/iy1b9mDpW5q5CvLdqNxc2tWfA4IFXeEXFPfbQK2+sB6LoPyQNHVPOgjdYlAhX0Atf7Hv2m9LIHH9hWv6IT9RwBHcm2GfFVFAEy42DVhlNvWvzYYy+LYBtX9EJjcAU9GyA/m96wtAzqES0zedSymqso4VD6oUwT1YWNk=
Received: from SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 21:50:49 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::22) by SJ0PR03CA0129.outlook.office365.com
 (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:48 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:47 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 02/28] drm/amd/display: power up all gating blocks when
 releasing hw DCN35
Date: Fri, 20 Dec 2024 16:48:29 -0500
Message-ID: <20241220214855.2608618-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4529df5d-4b2a-4635-9d1e-08dd21405de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LphkDRGN/gwCzL12OFbIcHLlQ8zpPw9+Ibk8YscI28PdcXERSASXVz1c3mb0?=
 =?us-ascii?Q?RbUSVNSSO8SqBSUgnTkCldsq7HmasCHqNUMNqb0Dwob6VQEsePQVAfzVbqdG?=
 =?us-ascii?Q?L3xgwK0GDUiEe/EVrrI/7iBJqypW3eQ7urHh3UW5NjGkCGQKj7FcxHuA6D91?=
 =?us-ascii?Q?lEM6UbxDpOom05gniR7EvwLzrjRJHwA8NfPS3dy7XIwFUS6/BMnjaCSMj3Rl?=
 =?us-ascii?Q?tU8SVk8kpSiAtn8/zCl4kUp57YG05F/XWRwDSOYb1PxInhLO1M6axzavi2L0?=
 =?us-ascii?Q?UYUb3UNl7tSaegfNJ6xat+SGtNa7PDH0rsh4lUngCkmpSlLVi3MEVouS0AI4?=
 =?us-ascii?Q?9ibqi6gm6virJjw3tNEWe7VYDuBdMrqaqpGM0SsSkMdHj2DIKNq6QOHG+b93?=
 =?us-ascii?Q?CFedfHVrUdflGOYzAQBm5Vx7K+6/BZyNEsRngL6c8Z+RpPghMSJrbYnb1Gmp?=
 =?us-ascii?Q?Fwp1TuZp+T4ew+t9m4xhJlgfHaxgHL2R3tTyCHq3KgGyoHmP2GNoGVJf0k6O?=
 =?us-ascii?Q?/jFt5U4oQz0W4ubi6zc9jf3gGqDz2TR9mWOTPZHuFtEWzgVrJ6R/jMYNNTFz?=
 =?us-ascii?Q?56e6MfNkaq8b432f1mBM9YyVijMlRECRT1U463A7Esp6bVlc8H6QZS4gAGVc?=
 =?us-ascii?Q?7NWVRU699irrkjbyJLloK10Dpw35V4UWjYNaXBmqnlpD3iZNaU9nu8mIqYrM?=
 =?us-ascii?Q?MMSUBoZ9JKLH4DMEtrj/LdXRpC2XBNHMmRL3yf4J4SdtA4RhvBxCNotUZih5?=
 =?us-ascii?Q?9P4TbMx/aLx2pvaJZOiCBE9NwtARVDubgqGU0VaiSfFdi2gAJ2l+LzqmWhf3?=
 =?us-ascii?Q?ExUBSsnW6g4u+8P69MbhoLDR1ziDjCcgg+OtmPiC//0KrFD4PQBpFKkhzXpj?=
 =?us-ascii?Q?jWGvmhkS6b4S0vpZv/jzGkcdk/TepEFmemLlwxUWjZEcqWhHdaZvravGYMjh?=
 =?us-ascii?Q?6e006itaoAYSbJm4kfdJFTf9H2xlviAoUCYo1b0EuncxxEftwiWhcpErhcUK?=
 =?us-ascii?Q?rlVKUm78XE2kPqN80q459oGckO43jncCzrZOFG+UE9HAUmXEmWb817lGipD1?=
 =?us-ascii?Q?PvbDX7G/NArkrHC6gauO2rMv+EA/+TcEDW01VKnbWCxqwiOuyElCt8ZXDuLY?=
 =?us-ascii?Q?TzdO6GZADB7Ty8mivieAsgtcCmxb2tU6cVvR7hHT9IMPeP+ucmiW13lYck1Y?=
 =?us-ascii?Q?u4E7n+jV1Ievhvv/xd3imDQRAH3NQNUo76apNYFx2zZa49EU3iTWXx9kqKMi?=
 =?us-ascii?Q?rVCW1e0N3CpfIurgatavZqg3x9ZXF2ZVV7l++PBC/DY4OUyQH7NqAwD4iIBV?=
 =?us-ascii?Q?PbBGdd9h/dsXsYIj95gh8XpMMJ+6NwZV/oyQxeg9+8SMrKqcSxtuekLPNrwm?=
 =?us-ascii?Q?CsZIAbBL+IleIMGU4JvFBFjeye+tHJGvHp0JgDRvFNgcAgg2a7l/3i5faoDo?=
 =?us-ascii?Q?APUQkcTPtUC1IcuWjnIPG25WKOxM/0V4byjmdeo4QE103OyzCDOAuBG+k81e?=
 =?us-ascii?Q?hW8Q/kfkONPMuSU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:49.1843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529df5d-4b2a-4635-9d1e-08dd21405de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Driver disable will deallocate framebuffer to reset IPS state, this will cause IPS start with
INIT state to blindly power gate ONO region to break power sequence. All the gating blocks
should be powered up when releasing hw to ensure all the power optimizations are identical to pre-OS.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 34 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 8207fea4f99a..59fc1c114fbe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1596,3 +1596,37 @@ bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 
 	return false;
 }
+
+/*
+ * Set powerup to true for every pipe to match pre-OS configuration.
+ */
+static void dcn35_calc_blocks_to_ungate_for_hw_release(struct dc *dc, struct pg_block_update *update_state)
+{
+	int i = 0, j = 0;
+
+	memset(update_state, 0, sizeof(struct pg_block_update));
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		for (j = 0; j < PG_HW_PIPE_RESOURCES_NUM_ELEMENT; j++)
+			update_state->pg_pipe_res_update[j][i] = true;
+
+	update_state->pg_res_update[PG_HPO] = true;
+	update_state->pg_res_update[PG_DWB] = true;
+}
+
+/*
+ * The purpose is to power up all gatings to restore optimization to pre-OS env.
+ * Re-use hwss func and existing PG&RCG flags to decide powerup sequence.
+ */
+void dcn35_hardware_release(struct dc *dc)
+{
+	struct pg_block_update pg_update_state;
+
+	dcn35_calc_blocks_to_ungate_for_hw_release(dc, &pg_update_state);
+
+	if (dc->hwss.root_clock_control)
+		dc->hwss.root_clock_control(dc, &pg_update_state, true);
+	/*power up required HW block*/
+	if (dc->hwss.hw_block_power_up)
+		dc->hwss.hw_block_power_up(dc, &pg_update_state);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index e27b3609020f..0b1d6f608edd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -99,4 +99,6 @@ void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 
 bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
+void dcn35_hardware_release(struct dc *dc);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 5ca8db2b2d03..1e2cf8a391c8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -122,6 +122,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
+	.hardware_release = dcn35_hardware_release,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
-- 
2.34.1

