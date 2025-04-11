Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4CC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F7C10EB2F;
	Fri, 11 Apr 2025 08:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0Evvigw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA8B10EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj+ZqncoR2phc+p05N0JrCMBY2L5m8VJYEoPOd3YAE8sbCUpicroXen+jXwK6G1gmU2EIy6hV8PrEY6Qs6PB0JC5K3x555sU9RZVmNN5eh6gWspl3G/V8INx81uNJmJjQdMh5XYWUFuar1z2EQjd33uVZXpLj7Ox2GWJn3nhFoAI/OWPJ/L6z2VRu7bEKnWGkb3MozjwF2M86YrIv1sG83lc1MWKt2Q6WVvFWi0d83rhgLr9yEqUbIKjJRu8KS5GMB6PGyAqR1uFBNNwStJSkq/fBzjLHNDXaB+4WRTzkprM8T49ySkbHnIW1luqaXr6RFWbOoD8JRPNMWpP1Dif/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caXDalqYf6FG4Dd6kYomwt9uSbTxQLX0ppjsSAwp3x4=;
 b=duf5zu/HvCHZ14wDB96wpItqGOg6Y2NW9vP7zgunlJ9tESeCXLTy5w4ccw5JvGHNfMIDQZ/NNlcoes17hafKozPbUAzcA+m8whiFl3OjM3cRAhtqMVB2DqdJeWcZbKnCCidjO9AZ1pAgxzQViNKqgp2kN64I+g3Z4rwWAQXZBWEbtmmtCrSUUr5qC1bhD/xzahDzaptN1hfRes6Xz7yzvNG/le/A26H5T1IPDRhTz/qi/wtQtA1JJSoySNLogbItt5NSx/eMK74y92xaAyoAf6QbdkxVUxmmtKBzK0wqwCHbRuA7KhZmrHsvdxXAloD8J0QnIdJz2eQK7k5Eu04wXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caXDalqYf6FG4Dd6kYomwt9uSbTxQLX0ppjsSAwp3x4=;
 b=h0Evvigwn+HwklCJeYkzzB3aK7Ik/aqOH2xpR+9gsYBnsR2FprjAsrSx6xAdYChy9c/bUpDnHJxWRDeAdf4hN0Gp7U65kPD8Wnu9UwsLwxYCvPpLp5b3s0XFjFMKzuSGo5f6OxQQB00Cdk5w1WN4Gel+zX5RjYoskHjHqXTLonA=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 08:29:47 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::af) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 08:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 08:29:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:29:46 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:29:34 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [v5 2/6] drm/amdgpu: Register the new sdma function pointers for each
 sdma IP version that needs them
Date: Fri, 11 Apr 2025 16:29:17 +0800
Message-ID: <20250411082921.3228498-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 45daf5fe-511d-4ec9-31bc-08dd78d304bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f88epI1D/No1iVl2QsA1R2JBtLxZxnKGQ5tJ9qiwJf40kxppY+/pzH0ZxiIM?=
 =?us-ascii?Q?I2Pp5T88D6XEX4LhqVCRSYGahzkGi7Z/LNFmpPMVaMeJluOd0uT92oeBT/KR?=
 =?us-ascii?Q?kmRby70D9+y42O34bAfJgnDKt8n2zhC64bQ4R0lGPNWrbB7+g83+LMLI6Ap/?=
 =?us-ascii?Q?EqbXJvNnwl10qnyxkros9oYFHwy69xu/UNVWnssmLlArnGbxQv+TzXGV43CX?=
 =?us-ascii?Q?a52nnl1uR9Sb7WkEWl37hOQuWVRoPLjMBV7FBfEhCjiNtloB63O7+pWqG/zO?=
 =?us-ascii?Q?uQqz/3MJ9QXkaLLbCZ+S//cGfSkJN367GcsKAGFq7lXcWUg5BQwsXNRHIReK?=
 =?us-ascii?Q?o7FN36T2/FGNDVTQLSCLOJZymb9ZcDSmkMXYcSsMZ0PD8Vmsio5bUbGnNGpq?=
 =?us-ascii?Q?6DkwdTRi4Q4c0GZCm+qOu8aM6IPOdI80cFl0QgYyC1azpG/yv0DBGExIVJIy?=
 =?us-ascii?Q?uDjkxWw2tpfSB47k2gRrWO/gVA48x8kNMC7HgG2fH+XWcAydoHo/m8q80p5X?=
 =?us-ascii?Q?ViuBxjB2psZ5JLPfy5kBaeEAUNGv2lUa/IVBsf1SoEGFGhZLIY10EORCsspw?=
 =?us-ascii?Q?n1ovA62nqrmwfwHLtGWNBnuCAiYUoNDGEJn4aubHqYs6l30myRMnnnh5bizn?=
 =?us-ascii?Q?4Tx4oVWRQvz7EpcOYVrxAOjjQYQOXibC7EQidT2YnrKOb6LWhwfI12+6zaYt?=
 =?us-ascii?Q?HrIj+Ld/8k/D5Nc4Ptc0Pgx3x1NdLp50Lal6vpoJ2sc0Kbo7teNMY6HhqoA7?=
 =?us-ascii?Q?mSST2hmbRx6fA3vSp66JXTplqs0vwX81DWJDz7e2EL2cEV2RrS8Rz2hHxWmq?=
 =?us-ascii?Q?hfwB8z5z/7YjoJTRLs1syPJA+jVg5FtntO1MD65V+9vyGtEp5GosPmTZ58fl?=
 =?us-ascii?Q?1JZNQr/sDjaxWo6WJk67HEFAP02IdvWchUQtu+VJ0ntNxjj4a1zKySBv70Zj?=
 =?us-ascii?Q?z+MyoXQbwMjaWrL94UuAqibYQMDzvs8G1XbYqvFMNZ9EZjOUdt7dLkWbw2eT?=
 =?us-ascii?Q?54MtfWxuF++dRwIuaMuL5mt48t3hfLLlTzWst4Ppv0k2s2ZZ6g3YoCTN68vT?=
 =?us-ascii?Q?cdK7AzGhqh4n/qY7ONl50Ow9stUAguwhggO8ZVcZoYnURpQlgjc5WlLF2iLh?=
 =?us-ascii?Q?HZTVqfsKBoER8ggWtnRnty5cxQ/ZI9gYgMbxcLxDkbU5m+CQHxnFUE+xECoM?=
 =?us-ascii?Q?VPDIuhesGSrOuD08AqtB0puQb/7pbaPFax5Xy9BxpEfe74htlb5LtXufqQ6p?=
 =?us-ascii?Q?dHe20zxBCSbig0ye5B1C3ExMjBB3JWBlwFQEJ7K2P6dzSVWK76EA5Qvt3i17?=
 =?us-ascii?Q?2YZBrMsfXZ53NBmiS3BhIAXhOp+JR+piRokadHkZIyA24Mk6ciREbRrjebmG?=
 =?us-ascii?Q?SCLKQ+qR8wQ5Ft2mRqLiGAI3YI0kXI2rixJz/bqcKdq9Xno9MlmKruO1NPG2?=
 =?us-ascii?Q?JQju3Gr4nKyDxjXq5m7aU+Elb2V++YM5ZIOwjxcMmx2RiRDtHvyuqdYsEE5N?=
 =?us-ascii?Q?RD3I1NgFR+hg0LdZhCcB8J//SxxAH+1RT00T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:29:46.8768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45daf5fe-511d-4ec9-31bc-08dd78d304bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Register stop/start/soft_reset queue functions for SDMA IP versions
v4.4.2, v5.0 and v5.2.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 76 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 92 ++++++++++++++----------
 3 files changed, 125 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..c663c63485f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -108,6 +108,8 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
+static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1333,6 +1335,11 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 	}
 }
 
+static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
+	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
+};
+
 static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1352,7 +1359,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
 	sdma_v4_4_2_set_engine_reset_funcs(adev);
-
 	return 0;
 }
 
@@ -1447,6 +1453,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		/* Initialize guilty flags for GFX and PAGE queues */
 		adev->sdma.instance[i].gfx_guilty = false;
 		adev->sdma.instance[i].page_guilty = false;
+		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
@@ -1678,11 +1685,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return r;
 }
 
-static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 instance_id = GET_INST(SDMA0, ring->me);
 	u32 inst_mask;
 	uint64_t rptr;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1715,11 +1723,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 	return 0;
 }
 
-static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
-	int i;
+	struct amdgpu_device *adev = ring->adev;
 	u32 inst_mask;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+	int i;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1740,8 +1748,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 }
 
 static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-	.pre_reset = sdma_v4_4_2_stop_queue,
-	.post_reset = sdma_v4_4_2_restore_queue,
 };
 
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e1348b6d9c6a..bef80b318f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -112,6 +112,8 @@ static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v5_0_set_irq_funcs(struct amdgpu_device *adev);
+static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring);
 
 static const struct soc15_reg_golden golden_settings_sdma_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_CHICKEN_BITS, 0xffbf1f0f, 0x03ab0107),
@@ -1323,6 +1325,36 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+static int sdma_v5_0_soft_reset_engine(struct amdgpu_device *adev, u32 instance_id)
+{
+	u32 grbm_soft_reset;
+	u32 tmp;
+
+	grbm_soft_reset = REG_SET_FIELD(0,
+					GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+					1);
+	grbm_soft_reset <<= instance_id;
+
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp |= grbm_soft_reset;
+	DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+	udelay(50);
+
+	tmp &= ~grbm_soft_reset;
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	return 0;
+}
+
+static const struct amdgpu_sdma_funcs sdma_v5_0_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v5_0_stop_queue,
+	.start_kernel_queue = &sdma_v5_0_restore_queue,
+	.soft_reset_kernel_queue = &sdma_v5_0_soft_reset_engine,
+};
+
 static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1365,6 +1397,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
@@ -1505,9 +1538,17 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
+{
+	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
 	struct amdgpu_device *adev = ring->adev;
 	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1562,30 +1603,25 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
 	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
-	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
-	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
-
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+	u32 freeze;
+	int r;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze*/
-	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_0_gfx_resume_instance(adev, i, true);
-
-err0:
+	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 964f12afac9e..4cd7010ad0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -113,6 +113,8 @@ static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v5_2_set_irq_funcs(struct amdgpu_device *adev);
+static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring);
 
 static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 instance, u32 internal_offset)
 {
@@ -759,37 +761,49 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
+static int sdma_v5_2_soft_reset_engine(struct amdgpu_device *adev, u32 instance_id)
 {
-	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset;
 	u32 tmp;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		grbm_soft_reset = REG_SET_FIELD(0,
-						GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
-						1);
-		grbm_soft_reset <<= i;
+	grbm_soft_reset = REG_SET_FIELD(0,
+					GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+					1);
+	grbm_soft_reset <<= instance_id;
 
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-		tmp |= grbm_soft_reset;
-		DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp |= grbm_soft_reset;
+	DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
-		udelay(50);
+	udelay(50);
 
-		tmp &= ~grbm_soft_reset;
-		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp &= ~grbm_soft_reset;
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	return 0;
+}
 
+static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		sdma_v5_2_soft_reset_engine(adev, i);
 		udelay(50);
 	}
 
 	return 0;
 }
 
+static const struct amdgpu_sdma_funcs sdma_v5_2_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v5_2_stop_queue,
+	.start_kernel_queue = &sdma_v5_2_restore_queue,
+	.soft_reset_kernel_queue = &sdma_v5_2_soft_reset_engine,
+};
+
 /**
  * sdma_v5_2_start - setup and start the async dma engines
  *
@@ -1302,6 +1316,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
@@ -1435,10 +1450,18 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 }
 
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1495,31 +1518,26 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
 
-	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
-	preempt = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
-	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
-
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
-
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
+	u32 freeze;
+	int r;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze and unhalt */
-	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_2_gfx_resume_instance(adev, i, true);
+	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
-- 
2.25.1

