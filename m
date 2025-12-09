Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BED1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B58A10E4D2;
	Tue,  9 Dec 2025 08:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CwDzuSWl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D69010E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJfdsQBksNhYz7nfwqsklltukrAxu5LRYkFG9N1Wl2NepUCPlGnwd4t/DOCFrt0Tv9dm6XvlPUvVI0UReduaoChMf+aLz8/zwItu3GeOCaEhJFEqjVuoj6tcYblGdNg2nAvUoEg0X2pwM2HQIcgUGy1WaG+g50Yme//PAui+XLAD6dcD2UBkeEP+vqqU+420r3QcJhcs4R/4ufarw3mc+BjYH5wwVPjuGIXoL+9C4gySnkKij2YOWVFMHpqucUShIv9bnFeJJqnMWw9Syl4wMMivqHdlIQlOVH9rJZRIONlTO51fqjFTL45gN8ay7Deu6PdPrBYYJz8PpwiIdDwEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37uGG4ZZqk2mKrk1Z0jOiyx5f9EQAXnmk8p3Xx3AH0M=;
 b=BT4e91Z7Wyjt24M13UVJnwJHdhzYIIbsFlDx+OZSY91MB1zGHnv7HNyvkJMR9QtgWqxpTJngfKM8qWUGn9QP49xQLBnqccdK8fBQkwZ6Y5sQTxcyQ+74IAQpQDNLgFyWuFNvyAt6PomZtQ8H4HqmO27ZTGaFJiGsH4Hl1KC4RSV6HkCTtHX3LH6FvPYGAGtoMwn4U7pCU7YIxVEsA/EGsTa7KRyQrtWXKZVXoLditz/TypBslr17ewPjVFSpdC8B+fdCCcmm4BcUZpJnv0bL7DEirwyWDevK44FuY88RpoK4jiNBk8JX8NNeVrKxVJxczHW5FqY+dqJHSPU9O3FTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37uGG4ZZqk2mKrk1Z0jOiyx5f9EQAXnmk8p3Xx3AH0M=;
 b=CwDzuSWlqjXrj4e2Qr+4o8kks/nFpMYPFgDdCtj2mzPVDH9Z8Vgbu8MvoUUgwTODL/qtumyHKRvtxc83DgMquah0hXevkDrxVU7rUKCO+oW02i5UMJqZ0Pf3sxUx66hL6lCcSdOPNnB0yndo8pncULSBJIpvVyODiwRa8aezIZo=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:57:56 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 08:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 00:57:54 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:51 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 06/15] drm/amd/display: Fix presentation of Z8 efficiency
Date: Tue, 9 Dec 2025 16:55:09 +0800
Message-ID: <20251209085702.293682-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f96976a-a844-40ed-90b5-08de37010b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yhCKd5LTjZrpWEnq4yeco1s6o8QhI0uhqvDjxSLQAtPrkcJ0B6kE1OCTYFYv?=
 =?us-ascii?Q?7xmh6+VyMJQ0T26Y3CNRLGa+sYdP0gY2tfkcx9idiemB/UQDZ2rjzyeS/wP/?=
 =?us-ascii?Q?7G6EaTSBAABSsDCaTxFX3wmxuUGjXHUcykeZzVrrpu0hLaQauER3FNnxRIJy?=
 =?us-ascii?Q?vJ+HnmYqazGXePuYcPULO58WemyXpwj3Nes/Ph/xSYXbA4yZQSeZODX7/+K/?=
 =?us-ascii?Q?O3mse+UXNIE2yb6dZRwGMpvjMa4oX7XBYrT43dknRafAgihjIDiPYjqcS+i5?=
 =?us-ascii?Q?K20QnfullXkhkNvy4Ems/GXIyOlhug/ddugjVllQI+H4udFYhVtYvqyqKgpR?=
 =?us-ascii?Q?SYh7tZJGcqtnXmB5aBkcGyHSF981ppkZAVh+iEaOm8Y37yv5nhCJHORYAkgp?=
 =?us-ascii?Q?8SL0xMJMRvH51Nosfvy9hbYzut636UK36iqqGCKa8CNVP7gVDx/QVXvSxMiy?=
 =?us-ascii?Q?XK9MdYKZWivkrVqXIEVo4nKOJGS/Znf6EVr7A0gQaNU4fcZsRSfNJVeka1LM?=
 =?us-ascii?Q?HHnAgQX3QW2OXqPBHSPZcOS6D+E/lKbBp8pdEgJ7KtB+skDMdRBzJ3+uckmB?=
 =?us-ascii?Q?GoVSIlH6eRWiDBbNfQe5UiCaJm4whY+M326jFOQg/JHrC/V3IXlijP2S70cq?=
 =?us-ascii?Q?tE+DH6OOIZjMRIrqWexMQ9D4Z5vGY7+1lflw0QN2owMCISmpPFtGtSyiUL6l?=
 =?us-ascii?Q?S7ETatmgxn6MXQpn9EL/1xfKrEJMao54Bzdkh0rPPqEdUYzgbATl5NnuUsMD?=
 =?us-ascii?Q?3xMYoyDa8eYNdrdvmdfiBomLJUbbwu322xLQOiKD5XkjhpjUKVV031pMouO+?=
 =?us-ascii?Q?K943WkEenpcruzZfRSvkLVk/VjQcJ+Rp7UjwOcR6b2MjEyYxauoLMqSwQqWV?=
 =?us-ascii?Q?Bdfxd+yiKcFCakeV9nX594D3mn75A3nUYcMCMEWz0bXiB5X4wn1H0wPl1nNS?=
 =?us-ascii?Q?/zk+Lh4GKrTVBGmgqY2ikiWSJqYPRHl2NZeR8gfi/KmtWCH+Bn/tNs3nMCvd?=
 =?us-ascii?Q?URpQNFx5h+PUsePWQorS9HRwTeEk2no8E1Vvh6bj07UfG175LEQiCVtBdPtu?=
 =?us-ascii?Q?WYCcp2KRrJQv1EhDwhylCPUJmlpjCPCZjZpX90ayg3uWRJTuD3FKCuS9Mnd8?=
 =?us-ascii?Q?2NNotNXQ5dW8+S4mIR5gJALUOLIXD1wBoHO7yA4SRAsuHMU4sNFZ7kpaK3+e?=
 =?us-ascii?Q?35ak+kPnn4DmyAoJvXrA4WHozRJ8AEvWiXCrih4oFeIDuJOF0WCO0rmj4HzK?=
 =?us-ascii?Q?k6sCfZeBFmf8im+IRODshiEHDmVUZQesUFi3BQ6saFCo3GUmeX1m0hCZWhB8?=
 =?us-ascii?Q?Hb7T6bxdHQpGMFAIIXhPw+UEeJLMD5BVU9k1HdAN/HinP2JDyVuuAz0i/kwH?=
 =?us-ascii?Q?ya4VFDqOQ7iM3+wpuCEZZvO9tOKuAxnf13fEns97avqRnmyhzw0VzzlRTyvP?=
 =?us-ascii?Q?ekkm3jVe7fg6XsSE88xByMP2SazomLF9GbjTZQfqtl1DqAp/jHFqOa7tXnbe?=
 =?us-ascii?Q?uYEyNxL6CCp65ezNHGB7WiPET4xUHKWT4ndCV0zhh/+LjSyJWblZdc9z2EtY?=
 =?us-ascii?Q?5S1/YcT9II9L8mavvOg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:55.8481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f96976a-a844-40ed-90b5-08de37010b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Should differentiate when vblank is or isn't included

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index a02e9fd6b5ca..01b87be24ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -326,6 +326,7 @@ dml_get_var_func(stutter_efficiency, double, mode_lib->mp.StutterEfficiency);
 dml_get_var_func(stutter_efficiency_no_vblank, double, mode_lib->mp.StutterEfficiencyNotIncludingVBlank);
 dml_get_var_func(stutter_num_bursts, double, mode_lib->mp.NumberOfStutterBurstsPerFrame);
 dml_get_var_func(stutter_efficiency_z8, double, mode_lib->mp.Z8StutterEfficiency);
+dml_get_var_func(stutter_efficiency_no_vblank_z8, double, mode_lib->mp.Z8StutterEfficiencyNotIncludingVBlank);
 dml_get_var_func(stutter_num_bursts_z8, double, mode_lib->mp.Z8NumberOfStutterBurstsPerFrame);
 dml_get_var_func(stutter_period, double, mode_lib->mp.StutterPeriod);
 dml_get_var_func(stutter_efficiency_z8_bestcase, double, mode_lib->mp.Z8StutterEfficiencyBestCase);
@@ -13198,8 +13199,8 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.power_management.stutter_efficiency_with_vblank = dml_get_stutter_efficiency(mode_lib);
 	out->informative.power_management.stutter_num_bursts = dml_get_stutter_num_bursts(mode_lib);
 
-	out->informative.power_management.z8.stutter_efficiency = dml_get_stutter_efficiency_z8(mode_lib);
-	out->informative.power_management.z8.stutter_efficiency_with_vblank = dml_get_stutter_efficiency(mode_lib);
+	out->informative.power_management.z8.stutter_efficiency = dml_get_stutter_efficiency_no_vblank_z8(mode_lib);
+	out->informative.power_management.z8.stutter_efficiency_with_vblank = dml_get_stutter_efficiency_z8(mode_lib);
 	out->informative.power_management.z8.stutter_num_bursts = dml_get_stutter_num_bursts_z8(mode_lib);
 	out->informative.power_management.z8.stutter_period = dml_get_stutter_period(mode_lib);
 
-- 
2.43.0

