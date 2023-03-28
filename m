Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C3AC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C3510E936;
	Tue, 28 Mar 2023 15:18:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC0B10E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGIthZ3JH0JtZXkces4x3wtIbYkABug348gxb9aDCickzyHyoeEnfLsHp/3c/rQsBQg/SQK0rOsK1Fj6xSderLVjiPIaQZGRno3JSr49SE2UIe7qP92bKHE5VhxNk6TctcG2S76dHdXC03UGxpzq6ApfTqGANUWvv2VLgcFfQChbdPLqY+ujGJoBYMyZtZ3f4WWH+5ATpn0uwX8no+FjLxAHlHxrqUz7NbmPp42+3Oy3XzTLMGHTYnkBAOOx+iPMej1gGA98AjEY3J/0Hpses7uFYfWACCH3rMe3MScWOBwXetyO3czXtByG4hpJLhL07oq/4NfQMQXvXJTy4o3J/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cebBhEblsRtZpvh4EFv9zaOtIlNg1AXfiNVyMICDXGY=;
 b=jk7XkOE01vrsdPMp3dGvlf75rey7HTMva+PxlMV3kTMbMRVnOdxe98tHW4ZLL28m71S0x1wdp8NH87ScQIt99xFaRqeGAOUT58nkxpPWg1rbcpxOl49eni2BmfDplu4FUqvJddQM11r9hPKcD8DUCLI5vf6idzhRGRfTxGjbhhZC6Z6HGsZ4jf7OCO/fzRweim6ypNJprcnlh0ADwV/yokbkcKr0J+N5AIxJbd5F3hljuZDh1T6ugrnC0CTvCFvkeqkwApvH6Mk29hcBtXcifPU8IrsrWW1LwMnSZb2RYeZzTQJsDnEsQ0tybOlBUdNrkWKsuzNv58NBxYKEfwxJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cebBhEblsRtZpvh4EFv9zaOtIlNg1AXfiNVyMICDXGY=;
 b=LYnXwl8pX8qITaTdE4/nyaqxAA/M2vILPxVJO51W+6kZ1ou2xgrQhVTvozPX3dYSGMbcYPa/Smo/1A6UAc4wUg8lICzmA7ijKPbY5fBqR88BqnXvJBNOmIk5srTBO1FO6tGJEltsy7UVldNdTp03yvoYkHMqKCa9+PSqW/G4Sjo=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 15:18:41 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::cc) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: add the support of XGMI link for GC 9.4.3
Date: Tue, 28 Mar 2023 11:18:23 -0400
Message-ID: <20230328151824.1934600-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151824.1934600-1-alexander.deucher@amd.com>
References: <20230328151824.1934600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 268f9ef4-e298-4677-7263-08db2f9fb6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /g7jqhIXTXzzh/3KHk+xHOVhSIQOBhyviBMVJiFZ9bBg27zs3hmrkhaPkwfFWsVm7Z9xsSNzlv7K8dWX4ccQx58av3qcwfpXA/L/BROik4BVLhuku3PnnxKtkjYcyfKYChfhQDMLrqwm9GIJHhKG2L1nMhrTA2xBXNO5e4hKXBNiBb29rn6O1lALtRsqN6KPjHTvifMkN15RP0GsWKaaxk6KHR90wFSNMh+LgLwEaQ9k2ajjOYq/8w4Bb/5AENvKk5bWYtDyS1tGhh2iP2l6IbhmLuLFRNcm+eRvLO3jW6SM+oAAD2+4hA5N4kEfDq94GPy/guJw8b5n2jjiGUNWkq6CLwvS1vF8VPVZN9zDyN9o3DwrlKrVQn41/Xb68LN8i/eDdrpXQe31ap+QQ8qxNvOU3b+NMTbrfHM2sed5W9KwyYS0Ow4MIs7zIyVkgPUdBbBaXuwZ0NoeWvNFEnrHzNgcFal5WRe4Yz9aprUCuRGXyyDJJ8/5UUPrzg3YzDciJOaLMNqhpvKW2fffK25nTxryj/bEvdrAOIpZCjtucoZ8mQX1/Yy22W5WKJ4xQzseXCW9sDrLxnzrvsXLQeLWme+c1WhEwwUsS6HhQ15RWntRsjZdepQroYjjn74n6new8K6InQ+APgj0qLESum2MryszAy0pLR32OvKuUGZgXHVYZ3Lb8rsdE+tORg64zX5ER6IQ0fUAz0Uxi6cDcJkqDW9Qnyo40VyvCFLk3PgJwi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(426003)(83380400001)(336012)(2616005)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(81166007)(40460700003)(82740400003)(478600001)(40480700001)(54906003)(7696005)(70586007)(2906002)(8676002)(6916009)(70206006)(4326008)(16526019)(6666004)(82310400005)(186003)(316002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:41.6335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268f9ef4-e298-4677-7263-08db2f9fb6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

Add the xgmi LFB_CNTL/LBF_SIZE reg addresses to fetch the xgmi info from.

v2: move get_xgmi_info() to GC_V9_4_3 sepecific source files to utilize
the register definitions specific for GC_V9_4_3
v3: remove the duplicated register definitions
v4: enable xgmi based on asic_type as XGMI_IP ver is not available
yet for IP discovery

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Ack-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 41 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 ++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index d3424ce97aa8..1bb17d95f720 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -528,6 +528,45 @@ static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 	}
 }
 
+static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
+{
+	u32 max_num_physical_nodes;
+	u32 max_physical_node_id;
+	u32 xgmi_lfb_cntl;
+	u32 max_region;
+	u64 seg_size;
+
+	xgmi_lfb_cntl = RREG32_SOC15(GC, 0, regMC_VM_XGMI_LFB_CNTL);
+	seg_size = REG_GET_FIELD(
+		RREG32_SOC15(GC, 0, regMC_VM_XGMI_LFB_SIZE),
+		MC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+	max_region =
+		REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
+
+
+
+	max_num_physical_nodes   = 8;
+	max_physical_node_id     = 7;
+
+	/* PF_MAX_REGION=0 means xgmi is disabled */
+	if (max_region || adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
+
+		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
+			return -EINVAL;
+
+		adev->gmc.xgmi.physical_node_id =
+			REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL,
+					PF_LFB_REGION);
+
+		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
+			return -EINVAL;
+
+		adev->gmc.xgmi.node_segment_size = seg_size;
+	}
+
+	return 0;
+}
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
@@ -536,5 +575,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.gart_disable = gfxhub_v1_2_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
 	.init = gfxhub_v1_2_init,
-	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
+	.get_xgmi_info = gfxhub_v1_2_get_xgmi_info,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 44573689a5ba..7d2d1d4a6e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1402,9 +1402,13 @@ static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* ARCT and VEGA20 don't have XGMI defined in their IP discovery tables */
-	if (adev->asic_type == CHIP_VEGA20 ||
-	    adev->asic_type == CHIP_ARCTURUS)
+	/*
+	 * 9.4.0, 9.4.1 and 9.4.3 don't have XGMI defined
+	 * in their IP discovery tables
+	 */
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		adev->gmc.xgmi.supported = true;
 
 	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(6, 1, 0)) {
-- 
2.39.2

