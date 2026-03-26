Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929C109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C9310E93B;
	Thu, 26 Mar 2026 03:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GT8s2sPx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0447C10E93A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui7PE5uKK83gB4XvFVooYD9FWaDtMjmFD1Qy8EfEFbSwvnIuFkZRgXrccIqJQlCTMyTTt/gi6/u3CiXFGikuV1SoYFrmdH5SlHJGzRc9xTpzXC3M/TH6Trkeb3rbi5UDZJH4mpfFD5YkW7E9N5FVBL79hhobmhLDT/gIRyI5lWM+tsS3DNd11VMIBDZjEy05PDwx0MCiZk3aAHRYzYLPpti2wXs1PGXvIHZWmHNVpWvNRjdQoXsXV50b+zKLWqBjmu3aQ+iVbAqTCxc/vc6yLu1Rzh4rTlcZRtXW9equS1sYkFM6QxKfMh/HfwDevxvGArxfcGzd0rDcwn/wy+FAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glxTyf1esgiR0YXN9S7Rdb8l1iSbvHKR+Zs9oKHpTz0=;
 b=Awaxb9oq30IDfbXT5P4hLznQAUMZcm05q6/yGCv17b5bFKAwa94eKljbBNWtCLSuraF2avycgfFHy715afYnEQfnrGONY9Q35sVsix1Tx8JpXbFrFEvmqAsjorDJwpXhq7S+C2KWpvd/eCWWuKgUS5AdEviqRM0MlRPJnrsen00Q4uVQQbO6/ETUQAul4xcl0dE8RGq/rWsghVcGvQAwrdV/IxhhZoXlPWlakikN1J5IFI/sCvW7krFdvFTiD8+4nCivX8u42sKDOiDTkLZ3AGO3lh3xxWrExtT5jT+Maj+5kshA9JUF3OtHETYir2TgFS46Bij0naJyKQK359THeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glxTyf1esgiR0YXN9S7Rdb8l1iSbvHKR+Zs9oKHpTz0=;
 b=GT8s2sPxzWYAVThf+D/ByB37wKePEBXYi7stQyqkUYdSZHjIFB1o3a2RckCLtbxbWQN9WS3asCPGZB29KRIWdIRC8DSAL9XRMYP/qZVcc+XixoBoSSTPgwca4m5VufRJXFNflHHCtxItpkwPoMh7rTdxWpc3pwCwDBfcdVqh5EI=
Received: from MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 03:01:40 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::dd) by MN2PR11CA0006.outlook.office365.com
 (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:36 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: [PATCH v2 18/30] drm/amd/display: using cm structure for lut3d
 related info
Date: Thu, 26 Mar 2026 10:57:09 +0800
Message-ID: <20260326030153.406612-19-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a75e14-8c5d-48f6-0cd1-08de8ae40067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: t+RgmSVr9Ya0jBSAuiHb0PFRPNuQTH+7saA7ARypXP1kWh0PHEXyVFdWxNGDk72eDP5NxUCQ5VyUgOu6TqyDMOYfj+cCxDpJSSQzoOlrnFtBHX7L6DMSvx9ae64W55dlxC/e9DmN3vPDrVqRNfIo4tmTnqGpRrZaXIyZQ98Rz8PQ3oaQB6E158P/Vcav7Gj7iY64ka7S+LjXmn8aShBxLTSWsGOEnWKzg9Ag/sh7C7inAGy+lBYs5IOaNlQzMNpYB6srNdRYBKjI5PlKXZXXdmxY7wjdQa0eEoATtFqQupAUT7WkezDDnvnq5eyl2WyXXS5shCpIeHUXLDSeoO82jl315p4T18LFslaYvHrFyGKpx2F1eFXqEOL2avd4AKNb1qxwy40ktafGstsMBGZOBK0Z0Rx8oOTCSI2hwApyFvW13VFVRqcUjaIMLaZ8VhwOxqteAxoqgCqSRSaMIF6yOlBEKVCPf0qwaR62BZS/KErDmcDZOBqeXdpPpBHORGJ+T2PBwey02GsA85af9R30cAW2FksToH2e5yCnsx+MAyw1bRNp4WM0GAUBSum0Zv6rGG8PUw6tcmeiu+NfQyyt616ey/ocka5tOSrRllubbZOOg6zMizm2L62DUy6LU54tKsjZpTZ87xrWc6juP+snoN33H+WIClP3R2pc/PMjjnKROMY7+HYat5zTatp2durhMipJ13YtuLyqhj26jKedy4Qdx3GCkVVEz06CM0qOvN4sKGH0onGWlMIuFOLJkk4ep9KSns3LJv08tBiJ9eMwFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tLwz2cr27BSI8lar2gL4PkphDIbx2PVTYuar+8pDU1bh6eCLpK2+cU4Kw1S/q4tMZOXcWWp3DFEiiclkMSGxzilQlSlCC0RVVZ9jM2zrzZRFBnejX71JPJEiQsLB5trr9MdhlNIX1WIDaQ0/3zWHlhWyIjCC4Ilt9y49V7xf9yN//f+YwmcUPjzupPCHgj6p/C+j4ZwXzzr3jd0BXvx47IyUQVjKGJPg4RlTqSXM9HMK/oeEV+CCSufgEikqmNXBjbhe1ymQEAOpBJ3ifUg00/aB+/fHMt0JpMfCOsHX+VqVQUI90EkvhN9NKlPOOtLwnsICewdf+R5Y2nrXYh15AQR95A2/fzzjHvc7Oa/Y2EVPShl11HgiBdlu+LDYfdWoXhyH3sdMU9tAIUzVxIMcd2VmdgkWh7TevtQWuqLeIfkLwjpASk4XTDHQFFD3aL1N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:39.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a75e14-8c5d-48f6-0cd1-08de8ae40067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

