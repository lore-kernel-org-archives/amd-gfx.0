Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40136D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55AC10E67A;
	Wed, 10 Dec 2025 07:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="livFMQUP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C8A10E67A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMSgsWfOGpUQD7r7yxhsHoV2k5FfW+QBcV0lbdOp38b38J7jzkrXY5A2harC0ttCXqS66jgedF3xoBFJf0/+hfoggU8KjPgALY3XSwDK8AmdLzbMFwU4QbXF8h1cp9VeOefbVVYYkdCZzjHbJSDTs7MfO07lI3T0+cFYZQ1OudfoG5bTemBASYQEd8X9T3EOL3153+Yo88/siVvyhr2UDHxRbKdcpbBL/E7Kxd1witQqK6x/pHdHONhbgFECQ+IrTIh3q80Ooaj+vvakrB1tfmvzh3ia8fomGFve9r1fYyLJvvcTZ+rToVszk0zJbZ+WQpEvjGSCvk5krVUQK3K7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M5N67b/fe8ARDiXerlOU3Ho+jTVmEoMR5ySTZn7TGI=;
 b=q9mL7Z6WFb7yFl2IF5ULwid5BwNJ3zTWNo1OaEc73BvVyXUDXd3TvsolkY2HJCLTYSt3ee8Swt/YU4mcmO+Rq6GccxnCN1+cjBm3XhuK7M5wFy/OYkZ+0kL4byKttQUcb57Of4DT3ZIooNcmGih9ugzbe15trryE0kQKTVXkhs0s/LJ42dfuwd9Ip6ONMYtEWhqWnV9R7A4FcDMwgKpRhE8K2vnH2Wk43qlALmmYyr4tyUH0y0Hals7Nk8KSzOKRxTfT/3HKMmRO7poqeiVErxJ0To7RkZrmNhuvqiyKza1WWHsX2AdQspn1T+b22GQ38niexzOXtnl0yLA8r5C1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M5N67b/fe8ARDiXerlOU3Ho+jTVmEoMR5ySTZn7TGI=;
 b=livFMQUPA2KwXPkh6wQfdJP7+JrARbSLnGEUl2/sGNc1863hov9pXEvhPQ9KNj+ePXS9usO51And8m4euHcHJhncDKigRxuOA2RUusjoEPn34Y31D4lotl3+dCLI5BrrCwdQpqd72TtThoBjcZ2snnH9MQLpGVkAMqLIUTnKEPI=
Received: from SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 10 Dec
 2025 07:14:30 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::d7) by SA9PR13CA0049.outlook.office365.com
 (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CU info calculations for GFX 12.1
Date: Wed, 10 Dec 2025 02:13:58 -0500
Message-ID: <20251210071415.19983-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: c64fa9b2-4df9-4fba-d696-08de37bbc305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRpy4cS9DNwZfKnrEO77TyPXfAugwjYrVUCewx25hH4RKwThJfNxzGqqHCJB?=
 =?us-ascii?Q?OmxfZYbJ370ieGjKls1RpLj5VpPuvFKqPpQnoiCODLy9saBtapS3UutrJHLd?=
 =?us-ascii?Q?qb6C/4NsXNHpshzClhn74LW4/+88qTBfAEPFv2V3CyK2cxqpg5vIppvDnrLt?=
 =?us-ascii?Q?/2fDypvXZ4uBMAt58A1tE6u3XMaTPu/59kjoI+EY3Uv1aCFsR8VdcW2gUjBu?=
 =?us-ascii?Q?a92QXMnfIITEKYjVmgornAgABbg6wFqsS/kr8Ti2ZGvVdfjvx7HqpHTqhSc0?=
 =?us-ascii?Q?busHmbw5ObPu3iANDTD5JP1g0wPF3e+N7LONPADWrPO7h2oIJAFZr4tG3DGC?=
 =?us-ascii?Q?oiQdpfMa6xSozhHGwRh0YV4ubNJQkHrn8PNwOpGJLy3c0Ojy1zj0Aa/4rIQU?=
 =?us-ascii?Q?wSDZdG6cnh3+03wy/DRrBbqaBIA8ur5pG3qqwu7JVlhzWMRb+awS6jJgV1rG?=
 =?us-ascii?Q?GjU1roPwgfUX7eOwx2yRZd5G+U+fKdwIE7AlqL5Vco6OA+cr0y1hXRuQDpA9?=
 =?us-ascii?Q?8yODX+jolV3eEZZUF1bZA63WShhmORlSVKdan5+IsXiURMch+vuxO6uIWaWh?=
 =?us-ascii?Q?RuO8YgdmPN5D8TNpPJAvm0YpluHzdhS+9pFkdLM2O7iIJ3/Y8F9PXU05UBMF?=
 =?us-ascii?Q?/oOLVsRkO7ODziuX8uvzRrLgJQxN2gUI7zcJHQEMlgVuEOnZDwQNw1DmASYp?=
 =?us-ascii?Q?2QlmG1w7zcCj3+5ITiUEt53VljUKr1W6LNuJYOoNrO9wCsMh+4cY0y9HDyD6?=
 =?us-ascii?Q?EX9dqW3iHHEjGQli7UShsUzTyTwD+sx1BtGsn6c/rz/sZeEv81W+reOgBqBP?=
 =?us-ascii?Q?bYSmh6mv2YxArbArzHy3m6E3zpktS6U4+/kP8kw9WMBqMIN68qkZ3taojoBH?=
 =?us-ascii?Q?3De0jM/UkKEtxp6aLQlDLSG30ZmSyjtedVFPQQEHO2dfi5GmnROvV//T1E5q?=
 =?us-ascii?Q?wiAwJrpWKHB4Mfy1vVqmJx9RytzFw6IJsidD25SMNRM5x/nW2lLlVrF1tG6T?=
 =?us-ascii?Q?LfJ3zYBmmbPKDOfnLaBn6zp5BBgpVZTXpjV1yz15a8gKKMZGSW1NIv2IF7hK?=
 =?us-ascii?Q?mW7u9B4OMEeiI1r4cvhyl99OgOc7r/eBihzY+m+VMu8E89oa6YDy8l61F5QS?=
 =?us-ascii?Q?ScEEKqRV0Pe4BMaSYV1FWsiiHtwjlfVi2ODgbwbgV8qhXObQYBo4u4tTsdFI?=
 =?us-ascii?Q?yRvH1z682zTmVQ9hTXvUSs4kR7QplR4dVWqhTmOX2ERpA30YnaLIX2hA0CBW?=
 =?us-ascii?Q?YUOOOglgh1bU5d4XWz0SfplD6VsA/gUu4Ls9cZo37uFmxJbr1UQ9hL7Lhn+C?=
 =?us-ascii?Q?RhrVYMXB8U+FCKYx7bAJF17Dkud/jTDLFYfc/+aB5fVHPwZamF2MJtuPwCL5?=
 =?us-ascii?Q?AwwdKUZ8WuAfA5TSojPNQJEcF5voY6mR/drF8O652R3hm6aoCj2sTaGJZcMI?=
 =?us-ascii?Q?kaTf/Toz76trwiv5O/hEq8XsEWe2fiK9ksbB+jNSIrnx/zn5X7PupYwyL6tD?=
 =?us-ascii?Q?2CISO37SnNuNXvJdtUhXO8Sog/aMrhwOqzoYOQgNZtMjOK+H4wDm39ZwjX1V?=
 =?us-ascii?Q?67lvW9nwG++Wy6NuOj0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:30.2898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64fa9b2-4df9-4fba-d696-08de37bbc305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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

From: Mukul Joshi <mukul.joshi@amd.com>

This patch fixes the CU info calculations for gfx 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 78 +++++++++-----------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index a8f020a375c92..f5a7ccf9e02d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -46,6 +46,7 @@
 #include "mes_v12_1.h"
 
 #define GFX12_MEC_HPD_SIZE	2048
+#define NUM_SIMD_PER_CU_GFX12_1	4
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
@@ -69,9 +70,6 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				       u32 sh_num, u32 instance, int xcc_id);
-static u32 gfx_v12_1_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev,
-						  int xcc_id);
-
 static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t val);
 static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
@@ -3804,7 +3802,7 @@ static void gfx_v12_1_set_mqd_funcs(struct amdgpu_device *adev)
 		gfx_v12_1_compute_mqd_init;
 }
 
-static void gfx_v12_1_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
+static void gfx_v12_1_set_user_cu_inactive_bitmap_per_sh(struct amdgpu_device *adev,
 							  u32 bitmap, int xcc_id)
 {
 	u32 data;
@@ -3818,39 +3816,20 @@ static void gfx_v12_1_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGC_USER_SHADER_ARRAY_CONFIG, data);
 }
 
-static u32 gfx_v12_1_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev,
-						  int xcc_id)
+static u32 gfx_v12_1_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev,
+						 int xcc_id)
 {
-	u32 data, wgp_bitmask;
+	u32 data, mask;
+
 	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCC_GC_SHADER_ARRAY_CONFIG);
 	data |= RREG32_SOC15(GC, GET_INST(GC, xcc_id), regGC_USER_SHADER_ARRAY_CONFIG);
 
 	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
 	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 
-	wgp_bitmask =
-		amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
-
-	return (~data) & wgp_bitmask;
-}
-
-static u32 gfx_v12_1_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev,
-						 int xcc_id)
-{
-	u32 wgp_idx, wgp_active_bitmap;
-	u32 cu_bitmap_per_wgp, cu_active_bitmap;
-
-	wgp_active_bitmap = gfx_v12_1_get_wgp_active_bitmap_per_sh(adev, xcc_id);
-	cu_active_bitmap = 0;
+	mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh);
 
-	for (wgp_idx = 0; wgp_idx < 16; wgp_idx++) {
-		/* if there is one WGP enabled, it means 2 CUs will be enabled */
-		cu_bitmap_per_wgp = 3 << (2 * wgp_idx);
-		if (wgp_active_bitmap & (1 << wgp_idx))
-			cu_active_bitmap |= cu_bitmap_per_wgp;
-	}
-
-	return cu_active_bitmap;
+	return (~data) & mask;
 }
 
 static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
@@ -3858,12 +3837,23 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
 {
 	int i, j, k, counter, xcc_id, active_cu_number = 0;
 	u32 mask, bitmap;
-	unsigned disable_masks[8 * 2];
+	unsigned int disable_masks[2 * 2];
 
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	if (adev->gfx.config.max_shader_engines > 2 ||
+	    adev->gfx.config.max_sh_per_se > 2) {
+		dev_err(adev->dev,
+			"Max SE (%d) and Max SA per SE (%d) is greater than expected\n",
+			adev->gfx.config.max_shader_engines,
+			adev->gfx.config.max_sh_per_se);
+		return -EINVAL;
+	}
+
+	amdgpu_gfx_parse_disable_cu(disable_masks,
+				    adev->gfx.config.max_shader_engines,
+				    adev->gfx.config.max_sh_per_se);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
@@ -3875,27 +3865,13 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
 				mask = 1;
 				counter = 0;
 				gfx_v12_1_xcc_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
-				if (i < 8 && j < 2)
-					gfx_v12_1_set_user_wgp_inactive_bitmap_per_sh(
-						adev, disable_masks[i * 2 + j], xcc_id);
+				gfx_v12_1_set_user_cu_inactive_bitmap_per_sh(
+					adev,
+					disable_masks[i * adev->gfx.config.max_sh_per_se + j],
+					xcc_id);
 				bitmap = gfx_v12_1_get_cu_active_bitmap_per_sh(adev, xcc_id);
 
-				/**
-				 * GFX12 could support more than 4 SEs, while the bitmap
-				 * in cu_info struct is 4x4 and ioctl interface struct
-				 * drm_amdgpu_info_device should keep stable.
-				 * So we use last two columns of bitmap to store cu mask for
-				 * SEs 4 to 7, the layout of the bitmap is as below:
-				 *    SE0: {SH0,SH1} --> {bitmap[0][0], bitmap[0][1]}
-				 *    SE1: {SH0,SH1} --> {bitmap[1][0], bitmap[1][1]}
-				 *    SE2: {SH0,SH1} --> {bitmap[2][0], bitmap[2][1]}
-				 *    SE3: {SH0,SH1} --> {bitmap[3][0], bitmap[3][1]}
-				 *    SE4: {SH0,SH1} --> {bitmap[0][2], bitmap[0][3]}
-				 *    SE5: {SH0,SH1} --> {bitmap[1][2], bitmap[1][3]}
-				 *    SE6: {SH0,SH1} --> {bitmap[2][2], bitmap[2][3]}
-				 *    SE7: {SH0,SH1} --> {bitmap[3][2], bitmap[3][3]}
-				 */
-				cu_info->bitmap[0][i % 4][j + (i / 4) * 2] = bitmap;
+				cu_info->bitmap[xcc_id][i][j] = bitmap;
 
 				for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 					if (bitmap & mask)
@@ -3911,7 +3887,7 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
-	cu_info->simd_per_cu = NUM_SIMD_PER_CU;
+	cu_info->simd_per_cu = NUM_SIMD_PER_CU_GFX12_1;
 	cu_info->lds_size = 320;
 
 	return 0;
-- 
2.52.0

