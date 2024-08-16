Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF32CC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 22:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511B310E856;
	Fri, 16 Aug 2024 22:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ap0BkTmf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5178E10E856
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 22:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXioV8UY/6NBwjibuzfeyq25YwX3VnCX6Pzxs/Wnhqi8ARWtrHKI1myTQBLVM7MMvinU25a2FBziusVCzJNhcKhKC4be953yNCA9m/TGMxibV+RpAnLjGIGMaGZ69m9JCAd7jbBAkRt3UebY6bF9aEgBJr+qlSh4LbCNt832ffYBrn1zPpnqsm8mWxS/cEPucdrT+PYEQtNEnd27LHnv/Gx8LuYmN7/dr5nVKUuqfZB7NZEpQ+AyZLYExtsiQLsBICCgdcKWVnmpMf4wDMnn+x3YI4YNltY9qq3d3NhE25h1Nxp9nuSuU0beVNsXdkcKrJDJIYcm057ubKho/QeoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yECXZOYHOBYHDNBscO8Bg5NcJIjx0OvjYnaqzTVbPx8=;
 b=S6ffcvOqHJNrlLgp/xmCKV9mcCqhSPtnT+phXvJYzhrxloKGkeR2/CvjwXPoNKvV8/UaAbuOXUaHx595zo5JOo1azkP5j1J5GIa6fMiAy2xf9B339DfR5oW1CUIKtwaOhHMm9qLWrvfgzd8yj+dnexA0kLIZEN5r3QR7rIcz7r+wBJcI3kzZSmYKMXvds9KmzyjB6Zw4vYxJsksfUIZ6qUNXqwkE9ACPAKZAxhR2EqA0H1pgNw+jPf67ScAvFvdLrpqhMv0c/5N+oAztu+Iw2Zd9kjKbtd8f6SlO2a7Uzb7dCrfF8nVbYr98b3UvZldcM0t5P6G+8xn4PPiPllo+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yECXZOYHOBYHDNBscO8Bg5NcJIjx0OvjYnaqzTVbPx8=;
 b=ap0BkTmfHvZzIKVvzAvHw9n3ZY1uGLjeH/DUKlT/SmA76kPKQqa1EleLc3fMEU46VDHFMe5R2iiVe/CzaUPlb2NiGeEIajbCMizwVwgF3KRPNli6VAK7zLF+RlTqSJ3/iEjNOTQAduz58PSTbRvpxdz30FBgy3Jq5QttXYy0iVM=
Received: from PH7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::31)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24; Fri, 16 Aug
 2024 22:58:11 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::3b) by PH7P220CA0072.outlook.office365.com
 (2603:10b6:510:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 22:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:58:10 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:58:09 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 1/5] drm/amd: Introduce additional IPS debug flags
Date: Fri, 16 Aug 2024 18:57:50 -0400
Message-ID: <20240816225754.156098-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 464c54cf-59e4-4132-8fe0-08dcbe46e684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jzhITUYCfrewjahYmQkF3hrcTsg+B/sPSXdrwiCAIW4mIKwEbLGa2tyO8UsD?=
 =?us-ascii?Q?Oc+x1vsTf/QU+x9m3oCtc8/QJKmgeWbTiHd+Ad/Z79uGvICQGm+8Oycokt4I?=
 =?us-ascii?Q?9B6ai4OkrhD1JzdF7w8aa2Q6rN8y1oRwGHLa0e5wozNcHsktXGDpdTINcXeq?=
 =?us-ascii?Q?rqGs8d5tdEixd/dtRC8uYNNlXGntHK/cBc17oIDhscGB7BvS2wkz3PJCg8rf?=
 =?us-ascii?Q?CEFG4EcInF7lGhcTM6sTELazGBD27tgTpyQVZ6Y5vo2gP5z3UuuQI0i/3edu?=
 =?us-ascii?Q?MjBbb5olJ40Tplqxqcmh+bY2eIvXrq9Y2MsaGKAJMrbJrpzbhxujQLffVDCn?=
 =?us-ascii?Q?ThlUwyMGrugJxF5p7fPaVL3eR9TM96UBiwnVfCiwMOod0pruZWImxKCIFKcU?=
 =?us-ascii?Q?hyNGO+OMm98vhfPQiRQZB04hstAH1W30sqo8rFKEthWrAiSMbNwfEo4X+irg?=
 =?us-ascii?Q?aU36Meb+mbzpza3JIK7k+oMIpGMQmK4XZSArveJUfj2Zg1kjI3WdWFotYGoy?=
 =?us-ascii?Q?Us7p1BvId7hWNa6ajAq49gxVDu+qou71UIF1rRgOmFrOcn6RHCT4hrPC86K0?=
 =?us-ascii?Q?Oqd1MzRHj/1O78VkXnYmKMYg/ay4WKcOKFpReK4kbrI/tzfYg7pi2yODv5E8?=
 =?us-ascii?Q?xhx7nwREdFCbHkk/PmQytlotLTVyrJ6lmFTaEnSGa4mYBtea/TCQ2L7OpLR0?=
 =?us-ascii?Q?KjtdG/N8bWDcun970TGXOt4+EONzZ+My/VYpNvjTVMaB6PfisIh/Py1LKWET?=
 =?us-ascii?Q?YRgV/k1O4CoyelRuQFQk9ncEgEcRjRvLO26Uxhh/60Zum0y4PIaNlZLrHNem?=
 =?us-ascii?Q?/vW0SpWTQA0UiEJS71qqsq9Mmx/VRo3WDnc4cW5pR5c5zVNSPhaGuiRwvpRo?=
 =?us-ascii?Q?EaMBwxzS7jVUFYNzXDwH8w3b8LlQ66dnZ7Vx7AQUQmlxajFvBmokDlBpFAEV?=
 =?us-ascii?Q?uQbb+qRBSUXCZGN7PXANwaBZb9PqOfKM/CP51TEdSkSgbCWAxM/mliIQlZNl?=
 =?us-ascii?Q?MWstwDfoahmrOrLu1zqbsLqiegQCQGhOSlMhtEAEn+fb2FBbXqAxBVVYgmP1?=
 =?us-ascii?Q?xY8wy9f0ttmW3gHMTHPHUdEexhi6gyTUg/tFF6SUy1u9mA8jRwwukxWu64hd?=
 =?us-ascii?Q?/5u6SKpclZqoPKVE/d061gUHwuJmO5vyyBYCmirOGxapOZ5vfLwQyf9SCCUj?=
 =?us-ascii?Q?p9JHytPdioTOS90hl6aGEFuzU4HF0HzmZMZ4nMuGRjYewSdnYtj8Byrd3z+4?=
 =?us-ascii?Q?5waLNnmsm7FARIbzrO8lwCN4lKDdl/jJynWFX+N6eQc/zRUcoTJsP7JU+11H?=
 =?us-ascii?Q?Kv0O/Qn5CUIuwaDG+KGA/Z+G/Xn5cXEcagAfUqIqXMyF9kRhhMw82qYliOGk?=
 =?us-ascii?Q?+ATCQMPeQ+Bbftq0Ham5hNG89ohq/LqwKi5MNaTSMjb17CpXe8/hvtodeXtu?=
 =?us-ascii?Q?LQmJgrezpTLgVmdvxHGAYlzyWymFCx8w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:58:10.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464c54cf-59e4-4132-8fe0-08dcbe46e684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Idle power states (IPS) describe levels of power-gating within DCN. DM
and DC is responsible for ensuring that we are out of IPS before any DCN
programming happens. Any DCN programming while we're in IPS leads to
undefined behavior (mostly hangs).

Because IPS intersects with all display features, the ability to disable
IPS by default while ironing out the known issues is desired. However,
disabing it completely will cause important features such as s0ix entry
to fail.

Therefore, more granular IPS debug flags are desired.

[How]

Extend the dc debug mask bits to include the available list of IPS
debug flags.

All the flags should work as documented, with the exception of
IPS_DISABLE_DYNAMIC. It requires dm changes which will be done in
later changes.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
 drivers/gpu/drm/amd/include/amd_shared.h      | 59 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dd8353283bda3..a18ecf8607232 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1864,6 +1864,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
+	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS_DYNAMIC)
+		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
+	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
+		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
+		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 	else
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f5b725f10a7ce..6c12ca954a53e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -61,7 +61,7 @@ enum amd_apu_flags {
 * acquires the list of IP blocks for the GPU in use on initialization.
 * It can then operate on this list to perform standard driver operations
 * such as: init, fini, suspend, resume, etc.
-* 
+*
 *
 * IP block implementations are named using the following convention:
 * <functionality>_v<version> (E.g.: gfx_v6_0).
@@ -251,19 +251,76 @@ enum DC_FEATURE_MASK {
 	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
+/**
+ * enum DC_DEBUG_MASK - Bits that are useful for debugging the display driver.
+ */
 enum DC_DEBUG_MASK {
+	/* @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting */
 	DC_DISABLE_PIPE_SPLIT = 0x1,
+
+	/* @DC_DISABLE_STUTTER: If set, disable memory stutter mode */
 	DC_DISABLE_STUTTER = 0x2,
+
+	/* @DC_DISABLE_DSC: If set, disable display stream compression */
 	DC_DISABLE_DSC = 0x4,
+
+	/*
+	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
+	 */
 	DC_DISABLE_CLOCK_GATING = 0x8,
+
+	/* @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU */
 	DC_DISABLE_PSR = 0x10,
+
+	/*
+	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
+	 * if mclk switch in vblank is possible
+	 */
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
+
+	/* @DC_DISABLE_MPO: If set, disable multi-plane offloading */
 	DC_DISABLE_MPO = 0x40,
+
+	/* @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA */
 	DC_ENABLE_DPIA_TRACE = 0x80,
+
+	/*
+	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
+	 * does not default to it.
+	 */
 	DC_ENABLE_DML2 = 0x100,
+
+	/* @DC_DISABLE_PSR_SU: If set, disable PSR SU */
 	DC_DISABLE_PSR_SU = 0x200,
+
+	/* @DC_DISABLE_REPLAY: If set, disable Panel Replay */
 	DC_DISABLE_REPLAY = 0x400,
+
+	/*
+	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
+	 * If more than one IPS debug bit is set, the lowest bit takes
+	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
+	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
+	 * precedence.
+	 */
 	DC_DISABLE_IPS = 0x800,
+
+	/*
+	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
+	 * *except* when driver goes into suspend.
+	 */
+	DC_DISABLE_IPS_DYNAMIC = 0x1000,
+
+	/*
+	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
+	 * there is an enabled display. Otherwise, enable all IPS.
+	 */
+	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
+
+	/*
+	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
+	 */
+	DC_FORCE_IPS_ENABLE = 0x4000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.46.0

