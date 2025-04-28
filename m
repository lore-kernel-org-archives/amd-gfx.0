Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81101C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278F710E570;
	Mon, 28 Apr 2025 13:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R39U9PBf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A27610E570
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLlQJQEtK4/JSX4y8l68JNhnm2byQ+jZNyCIbja78C+IT96X/zaXDY7vRwsC3dZOJwF6JqHDJAR5PfojZ1GtNXa8soyx1fQM8+wzLNZmTTpSiOmCPa53r8IhkWiPduftlNr2JiA1PcWA1a97THYgHSNHoFNc6ovObGg65NY23UKaIKUGFso6J5OKIU5URCqkK8GBCpINCFcHBA5yYew/RmMy1jdPbZ1qLbgODZCcK0KjiDmpU3dUQYxUJJkD4QUlepZaEOQb/VPpD0pYHKJ+yifyAWBnS8fLEvjyIotYu1/4tYAXiTz5rS/ZxVTUWbTqXaxAZW5heoSFka8mdSTZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1I/Y9gr6hjTD4ISYae1H1i2BP2hcmGpT66RFheTTow=;
 b=mM03V4jJldbMmuF1DauqlrI4ZGzGYEk9oRrhjuaoQ/lvlSr5RbaJ+Bm17VNFa44+/9ueGlTF+XidQ2QqM34aIJuSj2MlZr2U+08P39Fc8zqVPmzy6HNqoZ7oo2rxpY6fYSjxeGFeY1lF17NSj3FHMpqHw7tUJZMLj1LVTKPubF7PMdC6qC0fHTPWDdWaKK/bGRiX7j3DUDKXN1jnb+l19IWgqGO/g20vIK8QB6GXobN0Ti7VUnciD+tonT0OKtZ5LXDMVQsRIYarS9WkDipRlNBhO5rQPRHFYqgZ3DNRNZLHsvPpSuEzHxwLRGgu9FIzhgugcf1XEaDduYF0CkGtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1I/Y9gr6hjTD4ISYae1H1i2BP2hcmGpT66RFheTTow=;
 b=R39U9PBfirbIqRd2ci6wOmKtCgiy9B1P7ILc/dDU1bXn0XmBzzWG9aLzceju9lUJgaXMeYpgE41cq4RRL9nAhOj2dyvctSh0s+AO7EMLAl0LHFy/vz6X7v37OgfZYGhM6bLaP2ghbUyueqfCAxzAmqvTO6VmNzPPuteEmsAOVQs=
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:56:59 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::76) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:58 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:55 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Austin
 Zheng" <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Call FP Protect Before Mode
 Programming/Mode Support
Date: Mon, 28 Apr 2025 21:50:49 +0800
Message-ID: <20250428135514.20775-20-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b3e679-4d60-42ab-9bf9-08dd865c8ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?on6Hd3Ht4p8Q7jh1qvGqpnN/Ix1X0KxH2VhdhnGVDPrfxMAvlUvfpYPxZhjE?=
 =?us-ascii?Q?AavQU0+vlkzVLfHpJ3g6ltLkxDN8OtQNuVx2LJtE7hgFHHSSGy7zwgGOjxKn?=
 =?us-ascii?Q?zP2hZfU/cubfTkAN41FlfrXEx8lgpSoUmzw0QyemmS6MT3Y5FoCldDorL5yr?=
 =?us-ascii?Q?DABomTjOAAM6fcvZ6aKaKqvs/FgiQ/gMTzb1OYWYM5gVESJGcCM3jVIeRaXO?=
 =?us-ascii?Q?1BXJyGVf8o9WxvQs5laLHTOv18vczUlZK6gBtcuDYMWCcYd6s38GEpfW9KWo?=
 =?us-ascii?Q?HeaFtgPTeObygQDiU+67IA1tdDbcZrV41iKxFiFAPQV3N9ZV+FbFDcDtWPTF?=
 =?us-ascii?Q?2OSNRCsR0hKbx7F8OdeebdgtJxc/UoU/9wsaAMHQKRGUIpuYsdsn6JZoDW1m?=
 =?us-ascii?Q?8Ay2eM6a0QLetDFbzcHnl/8y/wa4mgksmCitP0ndx4kfeMXbWrD5UoNJOkkv?=
 =?us-ascii?Q?6z1V6qCVGqMBqPj21Q2DnHz7uQQJRKPbkTn1C8ixJMire1m84QRf6R+0/20b?=
 =?us-ascii?Q?fqA+muWpeqD7WBx/xV8+Ydd1ry8YnnG8+VbVuMKUcCbfaPPbnLcusKFe/imb?=
 =?us-ascii?Q?1suUzUw3l7NXt80Io24XzAxWbdqWe4r0oQ0I+AlWMeP81G+1tpXiwAQr/05F?=
 =?us-ascii?Q?GWLNFhwJJ8NFftR8gEgZsQJMlX7yazGrKduXN289+pLm8hslrYlQvk/pcrhB?=
 =?us-ascii?Q?OxKzeLzj3D6IfMexzJMq9jqmKe27S0DwDYbn0cywE7KsoKNiXvjqve6JBXnk?=
 =?us-ascii?Q?u37jZbDMJHaWpZ5xPnWqSEdBGtXBG+ISTv3WKgEouEXZvlls/C/AR1aM7vy2?=
 =?us-ascii?Q?c7e71PDqLXN65xa+ziA+bxUmyiHWupW1GO9SXU4mKepQvTJzudTM/mUTZ8DF?=
 =?us-ascii?Q?h60q0RitfLZCzD6+flVxJ9W6EbkucRk17zqw9tjGoaBNliJ0UzmZC6R5ZIRC?=
 =?us-ascii?Q?nuQ+Eek7qnc2m03OyBu9gx8QjityHj5G1SmvS3CvGnD1RIP9t7gJ96EYXxSX?=
 =?us-ascii?Q?zP1dx+uueXPxholeDelbSNFV2Ob/WThBdZBbRv6Mo96UZ0+rj55ec9g82gyG?=
 =?us-ascii?Q?sw/BfjgqdN4EnaLyjQbzm4IYLg6OsQXB+M6tokw8XGeJNgsYhR0AxcaroWV2?=
 =?us-ascii?Q?D32VBvOPCuqkSyFxs5dazTkSvHWvJ53prTMZpSLRwrcH20TfUbcX8Yj79eBz?=
 =?us-ascii?Q?Zs+DeD+7ImJf6o4W2jkEzuKtti/UHZs4ggf8U5Sj+GpZwfUBHMCvTnqlRi9w?=
 =?us-ascii?Q?/JwcrFZGMXueRVIlIw6NUvQHWPuZ6t+XFKF5wZD1m6ccrFU6zXYpplS73UI8?=
 =?us-ascii?Q?5Dkz8HniTsqlT8Ur0VLENlUUc5GRaUTs2MdQfUX/feDM8ZvWXYdVtkzR7uR5?=
 =?us-ascii?Q?Bjr5L2NnQI8gLE1j57Z9/WNpAdBmE+ZaDJ5PF+lbXuSP3hORz8QjTFWoyksJ?=
 =?us-ascii?Q?k0Tv3x6P71BL5Fmh1TNY2qQRw6hjr3mqFCz6p52v8wEpE7nWI0goiMUqa9Hl?=
 =?us-ascii?Q?7TdGwt91F+qv5La5p0Qcq9AIwsGWAY90iP+j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:59.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b3e679-4d60-42ab-9bf9-08dd865c8ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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

[Why]
Memory allocation occurs within dml21_validate() for adding phantom planes.
May cause kernel to be tainted due to usage of FP Start.

[How]
Move FP start from dml21_validate to before mode programming/mode support.
Calculations requiring floating point are all done within mode programming
or mode support.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 5d16f36ec95c..ed6584535e89 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -234,7 +234,9 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 	if (!result)
 		return false;
 
+	DC_FP_START();
 	result = dml2_build_mode_programming(mode_programming);
+	DC_FP_END();
 	if (!result)
 		return false;
 
@@ -277,7 +279,9 @@ static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *co
 	mode_support->dml2_instance = dml_init->dml2_instance;
 	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
 	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
+	DC_FP_START();
 	is_supported = dml2_check_mode_supported(mode_support);
+	DC_FP_END();
 	if (!is_supported)
 		return false;
 
@@ -288,16 +292,12 @@ bool dml21_validate(const struct dc *in_dc, struct dc_state *context, struct dml
 {
 	bool out = false;
 
-	DC_FP_START();
-
 	/* Use dml_validate_only for fast_validate path */
 	if (fast_validate)
 		out = dml21_check_mode_support(in_dc, context, dml_ctx);
 	else
 		out = dml21_mode_check_and_programming(in_dc, context, dml_ctx);
 
-	DC_FP_END();
-
 	return out;
 }
 
-- 
2.43.0

