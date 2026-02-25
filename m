Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E5FD45F1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 00:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25BE710E378;
	Thu, 26 Feb 2026 00:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjLQaGpx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB20910E378
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 00:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnOa8jkr+iQPOHvWrCRN0+cZbJvk7OEO8fufVLYieB8/PUSiY0EKrOqiOvwaVRgBQQIbI8sVMhfJ5exrpbofRqb1Kiu7usCfDYW+4/ap1hekjL9XJ1prwiT4rgrUp+qvxcysBTw/XSyqApHBwXU2MrOxetHBmAN7JggiDvrTyE5Vt52Qi1/SX/CbEmsAkI5xMzRHJLHqsF4+YuC0499BYIQrC/5D9DWvqvxentMmu8NVx2vvElZmxnH9ch7MCUlhE+a9/nbMKij7vElyaYmkKcTDswgt+yyTqLQU5ms9uI1x1Qzn0ZGx93kM0pEzy3LZB6tc4KR1Fj63lV6SFgkbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKc9Kwq58zP/DpP7jkNCjWZk38u3tZL32EU3Jm/plqI=;
 b=hBORPK6o9yojHkxFrXCK31JITg0uPugCL2RsImaqF4ssmhoQkAFbJrzQDY+9Wxd8GvWB21ZWyNrWJwlvF673EtA5JqSlaePlKli5p0y8uJGl3kTF+kmvHnhZEgSP+CiQ+VadzwinHYJSP1GwmyozBuX5jx8+YbTuKHMVXFlCg2Oew5hr4hdaXNuiZWNToEr5UtfEwWRe97JoD9g54klp8bloFia0jPbvjkdO5J6T+rY90iKPbl1lH241R7hkNEIndehjxuc6yjNVCQZ422mn1dx8uCB5aSqm1FhC8OPLsvg0hXp3Jeg7qf7ru1snf60ZEbf5dsXt9fgmRGD2xoRaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKc9Kwq58zP/DpP7jkNCjWZk38u3tZL32EU3Jm/plqI=;
 b=FjLQaGpxoPhpK7D3X8IxZm01Yb/jdn5TcHOqtSlYJmUpdXsX5VAFmGxj0AZLrqJgnGpJzyIz49o4sqsQoVlefbQi1ScIiYHqzfi1RVLMCmpjCH4rPq9QtmH5orfAJDN7ME9WKLS/hcsz1OBF+yVGQ7knGMzDkzJ+hUOA1Iqi1fo=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Thu, 26 Feb
 2026 00:02:36 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b5) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 00:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 00:02:35 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 18:02:33 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 5/8] drm/amd/display: Remove redundant initializers
Date: Wed, 25 Feb 2026 16:57:44 -0700
Message-ID: <20260226000048.68030-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226000048.68030-1-alex.hung@amd.com>
References: <20260226000048.68030-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dfe074-85f6-4b0e-7a8c-08de74ca58a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: FpX1C1vppGqvcIX6PkHV9RkdCJZFyaVLT01QL2US9EOrvYbvqXTS1o3f6V/jdcU8ezHJnVRCovNrHB04CJYd+kaJO4kQm1Ki7/OCjdeay9XVNRNg+2Iz8rTO1559kqwD04bbfBrRGB6yahaA/VU//OPjfPHwOlIhYEkngHWi6gB2AFkDLBf6VzL8SlgpXBFXwuTRYZTIr3ZI99kUbKxZ06AnyBgLvZ/N/F+qQlE5Zv3kIqNLaLNnAJZUVCj8eUqySidurzroXYidJT2yWcVGQdEMGCNbTeBiSVplOMZ6PIit2KIB+7HcT8bfqmjgO/rh98epFAPUJ9cz/tHZ6nEjacMN9RFS5VKpIFcGEWSq5E36wZx40bRZtJ45ABZgYODhWmZUHlTaOJN4K6pSOoNYVTAsVzX3Vh1iEwZ95EyfjlNwwQIZuqekIAnjScnekcN565BSeJX7xDPKRGOafnBv804WS4aCTd+/qUYNzW5/97QRotOm7vQ+sSIYsJytIuzB/xMrOuBZVBPYOtDFBKRsGhU9AF3Lovqn0QNv4fpDGE5VntYKVeejEB0LtYAcDyI5FvjyA1Hdl/vr9d0AI6us3WY5NY4kYyklV75ldrIhfCgdXCpImFM++4kKzPg3B5F8txJFnRKhTM4FQ3dq3SYi1cWNo42hJDKcDmc17Fi2ZqkegxugUeTj7GkesShR/XK8DHfdfmbo0qtod2DK+F2n1J1yfFYb+OQyw5GD1HQorstLMwDOZWzixSMUk73mBRbd6FwAr2vDnB0MTZ79KQckztqiTNLf0mrmkM4rzKX/jjsxmJlKLN7rXXAHXwKRuGV5E5XZ8LOswxt3j5nz5N8rpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kAbbTH7JoAkPpx/wS5gKSZiqf2JSX1Wb84lKxF/xG/YHrWwrehrv6QTqmWPfvCxlpVZrmFHssO6VFy+umUiCBuWQU/3umA3rDxJwusIqZhICxmLjrc1LutflK7/HnGijEASEDOHg+ajiyD9qtUKeMkYo2mxfWAc2SB9rQmmZkwn7XnbGusZAUEfrWmUNi4SaP5dKBDge15gGkFUCtTqEyignhb6/pY0MxZJUSbWbITxU6VhjTJdcBh5g2moyOyGcMWKmHpaLVnwjK1aD07E0v1KUJwuLDHZiOuLlHdHVXwzAgwRF0TGZd+3gHewZtur5dCWsFOy6y5/4mlNMAwnign4tCwE3lJCc+Mi5MCcjOXUUmaIz7tpaTThLlPqJIxn8Y7LuwRP6rmUqEnqNEr24QZL7Q65LegdGFPDuBCL1lT6nD8TU7wb5rLI12wTXsj1s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 00:02:35.1713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dfe074-85f6-4b0e-7a8c-08de74ca58a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

[WHAT]
Remove unnecessary default value assignments for variables that
are unconditionally assigned before use.

Linux kernel code style prefers no assignments during initialization
when variables are assigned unconditionally as they can obscures
the actual data flow. In addition, compilers will be able to catch them
if variables are used without being updated later in all conditions.

This is reported as UNUSED_VALUE errors by Coverity.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   | 10 +++++-----
 .../drm/amd/display/dc/resource/dcn42/dcn42_resource.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
index 19df8b47248b..d3cc624cd758 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
@@ -105,7 +105,7 @@ union dcn42_dpia_host_router_bw {
 static uint32_t dcn42_smu_wait_for_response(struct clk_mgr_internal *clk_mgr,
 		unsigned int delay_us, unsigned int max_retries)
 {
-	uint32_t res_val = DALSMC_Result_CmdRejectedBusy;
+	uint32_t res_val;
 
 	do {
 		res_val = REG_READ(DAL_RESP_REG);
@@ -180,7 +180,7 @@ int dcn42_smu_get_pmfw_version(struct clk_mgr_internal *clk_mgr)
 
 int dcn42_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz)
 {
-	int actual_dispclk_set_mhz = -1;
+	int actual_dispclk_set_mhz;
 
 	if (!clk_mgr->smu_present)
 		return requested_dispclk_khz;
@@ -199,7 +199,7 @@ int dcn42_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispcl
 
 int dcn42_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_dcfclk_khz)
 {
-	int actual_dcfclk_set_mhz = -1;
+	int actual_dcfclk_set_mhz;
 
 	if (!clk_mgr->smu_present)
 		return requested_dcfclk_khz;
@@ -217,7 +217,7 @@ int dcn42_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requeste
 
 int dcn42_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_min_ds_dcfclk_khz)
 {
-	int actual_min_ds_dcfclk_mhz = -1;
+	int actual_min_ds_dcfclk_mhz;
 
 	if (!clk_mgr->smu_present)
 		return requested_min_ds_dcfclk_khz;
@@ -235,7 +235,7 @@ int dcn42_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int re
 
 int dcn42_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz)
 {
-	int actual_dppclk_set_mhz = -1;
+	int actual_dppclk_set_mhz;
 
 	if (!clk_mgr->smu_present)
 		return requested_dpp_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 9f2f4d61d323..8e41367cf238 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1811,8 +1811,8 @@ static bool dcn42_resource_construct(
 	int i, j;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	uint32_t pipe_fuses = 0;
-	uint32_t num_pipes = 4;
+	uint32_t pipe_fuses;
+	uint32_t num_pipes;
 
 #undef REG_STRUCT
 #define REG_STRUCT bios_regs
-- 
2.43.0

