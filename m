Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA1BCDD1BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 15:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9BD10ECE2;
	Fri, 27 Sep 2024 15:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DkKdZ5jm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10ACC10ECE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 15:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiGtMQQKrYGcrQ3Ei6tkwXgqkxKHxZMeTFFjpxjaBzP1yELuHTj8g//Yn16yZMDrB4Wi9pPW2xqtq5tg6Ef1q3BpAFn1ViqoyDInCCPGHg48YoGYn6hFn2vZSruum4U7DfUoukChm0cVRl2y3CGDzP9XaNrdD2BPRJCWzso5ow7Wh4pDsOuAfe4yskj3Uq8X4jMM2VOo3iTUh9+54FPh0eXAOcYn8rxndHIXeh6ZR3LdbNG9Na5jPPpRg+8TB7f6s1/U2OIySDbNP+lxhO/GfH9c4SnjqXeapbjodojBkBZmW9XsatVv3BERY71RwlnKv7nKvHt7SLXz/Bkvh2yFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qYBK8apOINtz8iunsCgD+AeQojPHSyt5RSexTOifR0=;
 b=zTjompnSZAEQeC73YsJPt1nSDCVa5U295kD0YQf68hOV+JQTrPlV0Zjqbq2/FsfhBwVy3csRgHqoYCDhs8+FAGZe2YCPip+iczFnp2XJXf0AJoyPcxkD7mODSuT7Y+HlwCS1BBWXq1M8i8cJAcXbTL+G7bB4g5Rw/J65vH8OVDhwrECKwZ6fMPjbn5osE4o5SeA98oKYMOQFw1QtkaEB9V85trylwWTOHQdMdEP9dkaftUP1P+qcjVTdyG+4hDS6Rh0WlnBwiugmfkh0L4qAjMRlRyxU+Nnq5CLNVXZwLJp53GNNz7so8YHJ3aJ2V+4F4jpcQ8dKrgNl/7CtuW5cOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qYBK8apOINtz8iunsCgD+AeQojPHSyt5RSexTOifR0=;
 b=DkKdZ5jmK4+75U1RrQZ+GJKf93Z16Nc5oL1S1pWx8bCs2cAN7U49zflY70Nsfy04oRlYMD9/H5vxmFMYwnZyNSfczE4kcDnfwBV0vMa3z1zAvxGwoYESql2qUT8n2FXLfKGAYJRv10lvPJfqdL2PtK4mBY7COYzdOWo6dB4HmVE=
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 15:38:06 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::42) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 27 Sep 2024 15:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 15:38:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:04 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 10:38:03 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Paul Hsieh <paul.hsieh@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Add logs to record register read/write
Date: Fri, 27 Sep 2024 11:37:10 -0400
Message-ID: <20240927153720.99916-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927153720.99916-1-Jerry.Zuo@amd.com>
References: <20240927153720.99916-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e024561-4cb0-4ad5-3b98-08dcdf0a618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Y6GNiooxeoB1lvEjp39i4vcy1dQUwBYN2Qz6GOZIWFtINwW6fMxMcMjP1x6?=
 =?us-ascii?Q?KFh9UZCKooaqTTJrGNLFdlaOEaKL3ej9BNpZFZHRz09HgHCIYFXSvOHfJN2q?=
 =?us-ascii?Q?CgbeZtrPnAMysstKA1/+anuvQhjtyrmt7bbTjBOi1mF/+3xdFZF27boEwBm2?=
 =?us-ascii?Q?5Mb0skbYPzJFan1Rsr0TTt90mO3OZrBFGsTUEjb3VtVjwG3dOisudKca/BvW?=
 =?us-ascii?Q?camlc5UZqVqCFsZQx0Kmy/nIqZsuCn9MH/3PDsonJM/loogHNYagezKDbEnU?=
 =?us-ascii?Q?pdo8uXv1bCnNnntMNWhs/99YG28BBC369oM5ue2BjzwaMbUMu+Akd5ds5/C1?=
 =?us-ascii?Q?XAj8H+6MCf50vwC5CWyJZwlP4yjBYuyAIt0RDw9AoyxUWiSg4+HUK4GFejfS?=
 =?us-ascii?Q?tfS+0MCQeXp5wXhUe0Phtj2aZURYigZc9CgHVqUr1RMUFKJJq05tH7zcYk/u?=
 =?us-ascii?Q?K7H61teFP88VX/B87vEYcod8umSy9xFSovB7bKNsgHt0tLB8j1UPe1nphjUD?=
 =?us-ascii?Q?2xsR4rcKd4AHVarf9vkvevIg+DHug+cwaz94xkAFAFAzlWhc8DIxUN9TmBmf?=
 =?us-ascii?Q?6rQyDqiP4TvIJ+9f2wGvBUWqrdfiZ1r8u37kLLDtSdFPtmmLjbDIHSmtZ3vF?=
 =?us-ascii?Q?fi3miTDrOrKGjfomUdK9u2gtzm6Zlp4NgOh2szfOZgO9lfhDuj9Uefqh4nOU?=
 =?us-ascii?Q?zSZmm+PBiJAohfJaOq4aLi7M7vpzZU1wt0syVnPm9936YfWv984UvSHVJ0Ta?=
 =?us-ascii?Q?29NRjwpRK1tdMTFL5rATYCidmUtyUn1BanSpvCDrbcRPh/XkiQ4q2sOV8Bd+?=
 =?us-ascii?Q?UA5mmvfmV+tpPiCZAEuXNKITEMlz7Cyhd3Zb8yFNBmAAhGxUKvmsaFqu822j?=
 =?us-ascii?Q?wqVi0LiPVcVw9yLgFQZMNb9EWWM9uoy8JzcUfgcsNNW4voUuckYo8uvMnaiW?=
 =?us-ascii?Q?Lm16Q2LogLLFaqp9/rwhZXh7d2xd0K670z6VelEt+uEn2Vbmhk7/37Imr60a?=
 =?us-ascii?Q?kXb2ExIkGHv/6mi3PARuWK++EGr0+nrp7rwxubntieWdsblTZUMTh3X2FBw9?=
 =?us-ascii?Q?zeyR4cMz5z0opaWOYDg+rxSvW/SE24sxWR0v9IOq2N3vVzPSkHhJmJ4Qv7QG?=
 =?us-ascii?Q?Xi+HuHBCDTtWQ5+DPTq836TCYzsQnVPPsyhtwxym/aQiHznQohDQZ1B7fpgO?=
 =?us-ascii?Q?J0riA6iv95ZmM4DNytyIVLIuPFkP6qSeVTi68FKvLw9FLzinEIEGFKvWCWp6?=
 =?us-ascii?Q?C/TaPcOoH/PkASsCU4lwrJWbKRQIBKEho6dGXxF627on6LtJ+ZXU/mICfTDV?=
 =?us-ascii?Q?WiQ6yRbLpjTtXnGcuxuM18CtSdS0IY9LdF7BKZEUuxnSKu4LSaGn8/wSfeaM?=
 =?us-ascii?Q?lsfLIQuW3LC1y6Q1dqChL+trR+7X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:38:05.8208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e024561-4cb0-4ad5-3b98-08dcdf0a618e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
There are some issues which customer only can provide full
dump for analyze, without register history, it's hard to
debug HW status.

[How]
1. Put register read/write into WPP log so we can trace the logs
from full memory dump.
2. MALL doesn't add into WPP, add it.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/include/logger_types.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index a48d564d1660..4d68c1c6e210 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -61,11 +61,13 @@
 #define DC_LOG_ALL_TF_CHANNELS(...) pr_debug("[GAMMA]:"__VA_ARGS__)
 #define DC_LOG_DSC(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
-#define DC_LOG_MALL(...) pr_debug("[MALL]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DP2(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
 #define DC_LOG_IPS(...) pr_debug("[IPS]: "__VA_ARGS__)
+#define DC_LOG_MALL(...) pr_debug("[MALL]:"__VA_ARGS__)
+#define DC_LOG_REGISTER_READ(...) pr_debug("[REGISTER_READ]: "__VA_ARGS__)
+#define DC_LOG_REGISTER_WRITE(...) pr_debug("[REGISTER_WRITE]: "__VA_ARGS__)
 
 struct dc_log_buffer_ctx {
 	char *buf;
-- 
2.34.1

