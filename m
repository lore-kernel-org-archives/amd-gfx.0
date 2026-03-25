Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BDFFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C75A10E7AA;
	Wed, 25 Mar 2026 07:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VIirP/s9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDAC10E7AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci7M8v5GWaSY8gYlxpqOvQW8MOLcsCQl+xpepMDNla0FPodgKBvJaXdWoOxXwveTpg9LTmqAX4wMJgVBK7dtgQIM4550wWA8a3YOvgPeFN3BIo8OocVZCkg8jketima6trs653AMQpkfooBsScszbubH9fs0WaaMKPYIZfYGPsosyg0YQcr47VXTJ8kYSADxta7Qe64tT7BavWJzT+Vg5+5HuVuvHPeivQr55fG9sB8TKFMmvulxH7PAbgi2UnTAlIQvm4W0SZEE4XRZNG8pL3kuszfP9QHlmq0ft8kc16/Y1C7XlrQWhWqAsR6Kv5cWTbuICCeaXCmdsu1jbo9QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glxTyf1esgiR0YXN9S7Rdb8l1iSbvHKR+Zs9oKHpTz0=;
 b=sWIOn6qnJgyn6fIppcsAOyrf8QZmMos3998d+rdTTWZXu/dVeIDJDLMMfLy/bgvrNrnOsD7/phIZcofzlHYR2J6SdrnXuUfnicI2IZKkDTqg8LDY0oIJH3He7yaTZ01C9Kf0Kn83ZpYHa0NpxLNhEe1/tSc4s2jB+YJLk0bsg968jWF5g5FBtNGT4VMQKuRrgl7OJxokQi3zMXJiszSgy1d/V2dGQppoPlyEqXgBfnX7oyjuLm3qFSHvc7zTZPrpMElFD6Vof9l2AeiPcALvlnpwNzCL5xqsQi3a/EwPGcAhuxnxfNDJgfmdSURjgb1EiOqwfGrmdxIcjrxY3saRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glxTyf1esgiR0YXN9S7Rdb8l1iSbvHKR+Zs9oKHpTz0=;
 b=VIirP/s9lUfKifOakvXQG6ope+jMVU8vl6MjUQkdZgmQ9xfjNwSfnqB9HgVTCkZjDcb7dg9A6hWsvn38PfZX4rzwqCELbUpnD3TtCShOjTolkqbDunG85cqhKJArOVUYOCMzjKpNoEHcm7uUr+hepKqymmIeiN1gDft41RR1ILw=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:39 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9f) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:35 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: [PATCH 17/29] drm/amd/display: using cm structure for lut3d related
 info
Date: Wed, 25 Mar 2026 15:06:23 +0800
Message-ID: <20260325071003.4022594-18-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e853164-f430-4ef0-cb8a-08de8a3d7b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vbYYzpm9yJr1mFuXdSbMlA7Tq/qeVva9dtf6pZQMULkl98QwlDQ83rVOF/daltUP49Y0sBSQYbN1QW8lU7S6waz/6ijKODtisO/U5i4v1ZY8PsFLBAzo3r71q60lqh9vLq19pdvlmleURI/7SLbe8zSwhIYyAY9I+MMfcyiRIy4OBzFA259X5LrXLMpoUbY2EWruiPtizXjKMG+ZDweaiyasUwq3CAXkJ7k4Dp6nPDuyMNvF4I0wPcIhuBCLqSRNgRvi4JhVE4T8NHNwyLpK4jQepf5YElVgNW+SrgcxaMV4TbM2n8uNoXUOm+NZKu1Jd8UcTDvacU44TEA8rWWtTTCVR/P9Nxg3VG1ByzHn/Gb2Ikio/Iu4Hv3+fmVEmGsbr+ntsp35RD+XyDN9TxMyd9R33U/KkUbj8inRNa1iqoHM087kGaqaZxNTykQmwT8FHC+ZCdJtyqfPbCeazyKYhnCqBp9WGy1BGq5qihUEJSCc+T6hvCpnIIlnwr74GrLv5uqYwx6vfUhix5Y+0hUA2AW5E9vhXY5QWqhes9IkBnXAZnlcCvOAcV7qDxhgvXFYPh9K3Ij+5aP+o0BOTYfccd67AoI4dheKE1ZB51UosN8gyoML0Oi5sI2WPlyhwO9SmFnHvbAMIUFP/tTPEW19IXuUFOTzoKnr+D3GHhgyvpWDn8//T8lGnG+pVMdefGPm2pCz2qR51evFTWRVS4hJfPrILrcwiWf/U7HKH9QrYB8Sz6y2rPAuOeBI00ww0p1JKITBwgMJeQiTXPBZuffONA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dAdBBqQODOJ5rzPq0s9mwrV1uCKAfJ2/kAyRuuhbq/ApBVZONnOWT3N3nIWtwJh/U7dS05yQKBPh394jIkD/XgQ1fCuQu8PgDnxR0tS5O56zrWmEYPZ3hXuJ+uesPrrdtD6zDP7D4GBvDP9F+3WWKVFo+RT3LQ5F/SxqqjIt6n0d7QVHLuvAstgjPBgw2JmgFOgJ1QVj2TQ5NBD4e1wJor/z5iuOx0G3WagUYJCngALwPwkGMTv+rl/GH+U6VHbUBlZgo9n3NSmnSwU6895M3K+9xdE+AW/KcfsggiHTWdliiu2crwVda1tif+UdQhkQ2ZpReS1iQGXNjoGrc29ktCCLKs6Vtl0jYhUfpM4c2zYwknfbh02oaeIoJkY+Ne0TS9RfEuK9fQK4DRa7h4IIahEVvKCh/ej5R85974XuagqcYF8TID6J+mX6qEsPsrI/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:39.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e853164-f430-4ef0-cb8a-08de8a3d7b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

[Why]
Using the alternative implementation via cm structure of config
lut3d data

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 847fab508750..eadf84842ca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -601,27 +601,33 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 
 	plane->composition.viewport.stationary = false;
 
-	if (plane_state->cm.flags.bits.lut3d_dma_enable) {
+	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
 		plane->tdlut.setup_for_tdlut = true;
 
-		switch (plane_state->cm.lut3d_dma.swizzle) {
-		case CM_LUT_3D_SWIZZLE_LINEAR_RGB:
-		case CM_LUT_3D_SWIZZLE_LINEAR_BGR:
+		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.layout) {
+		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
+		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
 			plane->tdlut.tdlut_addressing_mode = dml2_tdlut_sw_linear;
 			break;
-		case CM_LUT_1D_PACKED_LINEAR:
-		default:
+		case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
 			plane->tdlut.tdlut_addressing_mode = dml2_tdlut_simple_linear;
 			break;
 		}
 
-		switch (plane_state->cm.lut3d_dma.size) {
-		case CM_LUT_SIZE_333333:
+		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.size) {
+		case DC_CM2_GPU_MEM_SIZE_171717:
+			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
+			break;
+		case DC_CM2_GPU_MEM_SIZE_333333:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_33_cube;
 			break;
-		case CM_LUT_SIZE_171717:
+		// handling when use case and HW support available
+		case DC_CM2_GPU_MEM_SIZE_454545:
+		case DC_CM2_GPU_MEM_SIZE_656565:
+			break;
+		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
 		default:
-			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
+			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
 			break;
 		}
 	}
-- 
2.43.0

