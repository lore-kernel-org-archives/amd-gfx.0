Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08810C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A859E10E60F;
	Tue,  8 Apr 2025 08:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JnKbSDnu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFADE10E60F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwFbDVYJKcn+V5L2h5nkOYIDTgkvXDX70KHuaDqmcu9k318l7fnEeH1pO1qYUlAF7+nwAEzqgIB3ES/j6q58xNNtKLWnLhWx4uM/OhlW7qTHlLPoIXjhToe2D4ddne/jAAE/seZ88y4wulliiA13O97ZTo4H3nS5D4/shrpO3r9hXieeVqxLjOtHSHAMiJybpylgUeoT4xb/d9f7J/03uH78LNAFZZOcmR4JIn00M4wGLwGsfUcYHzw5RUFqlPgHyiNlMWWhz30clJU0qwSwFS0RCxIWbROOufH774X2TWSOEtFOC2HmpHvzwwTV4sCdcz4221YkLyCjHrVceLLA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO5fqEqLuSxrw4gZFe285QiJOoSnC/Jp/kFMfXE1klA=;
 b=RummWrun+a3JwgTjIm58kw42bnTHf/4qZX7MO8wlOOsem9HkvgQqtoqRwE2W8SnZsootD2DKb48iwvJ/Slr+yr80/xiL5dPdEl3J7d7WJtMNBA+lWc6p0i0OIRzrk6cuOiUmMiCRJK0L4No4WmpmxNiAfmZsI8O47yS5Ye27bRwg23txuj5LuXVl37YXPhRRa0y5G9lDYZ3GTzTBNiuEyXQT+knuKU2EvNlI42Wk6Sw5aZYCm8F0onvzAv5ERQ7BbYqccPZ8FFcMbITIteS2wYrroRs6GvALUyBmtT1MbsbH3HxDsFEIKzfcCiuZBYgq6ZTE1GxR+gAXCEgZpZD2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO5fqEqLuSxrw4gZFe285QiJOoSnC/Jp/kFMfXE1klA=;
 b=JnKbSDnuwZoh3g8x/maMdnYMN4kvJ5Ber1E0cckZ5as5xbWM3pLyF6UCxktCt0F+i9FIQv5MRCwH3HWHZ8wcNtJpNVR6bS1p8t/+bdRRTopCkbpQuitlhk1tQ/DjGp8r2UWIZt3GPK8mTrxiX3YW55RO4jiWrZS3sxJEXqhibYk=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Tue, 8 Apr
 2025 08:37:14 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::95) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 08:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:10 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:36:58 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [v4 3/7] drm/amdgpu: Optimize SDMA v5.0 queue reset and stop logic
Date: Tue, 8 Apr 2025 16:36:29 +0800
Message-ID: <20250408083633.2300420-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 084b9488-41ac-4e72-a99e-08dd76788fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/J76KAz9JATX5qT437sTWBD9PrJA0W3SDJ+U5ygLvsIQMekpwtDXbynjmKgm?=
 =?us-ascii?Q?pMuex6BGZhGXBHQi+te/fNc46pqjSo1WoWTLfS1udEeyU1eKsm5LSwxXr4n4?=
 =?us-ascii?Q?atgbt/JOb53opTkssLw6OL1bVo8jj/8vNkLAY5Yv6XyLF/USF5Bj6jYk1fRj?=
 =?us-ascii?Q?Yg7tSVBXXod7OXCSyri8ndmLtey4lpo8cWnvvfzaCwtEvJIGFJvFJbsXT1Xp?=
 =?us-ascii?Q?NCI230jf2MsBwsO84p+ZgW13Hgtj8noRwP6cSqY0LQ2RIqVdK4nmBM6ehtvz?=
 =?us-ascii?Q?mILLTU8jpWXg+ZVpcf7XrB/oDztcqhczBmWnmI2sOvJ0B3EbjhyKh/Ld5z0K?=
 =?us-ascii?Q?4Ko/FqprdJJ4MaLMSgczqlV84LuBQLFG3nqhNqEMjzXQy1KNFdNsirhZShvl?=
 =?us-ascii?Q?IVK/uiSbpJldMnhvVogjsjEyQmd+4Hyt9vrO7qLLQna+kyskSh7k0UKWfSFF?=
 =?us-ascii?Q?fWtFdkrXh6Pr/TMYuaOEP93Tl/+wqLiJU+GZHWyQnJ6DwkhLamTUF+4o4S6B?=
 =?us-ascii?Q?uSQCvyIERPNcyqUlV4MohYFMjy3WBbJADeTqJtbgbIuXJYNZYcuVQmCBYfWI?=
 =?us-ascii?Q?BtJtGWYenLJj6YgGtVRMky595y53LQRzOsdDJuP5HXgRniaiI33XFOhh4KHy?=
 =?us-ascii?Q?jgpq3zbHhotCfIjBUBVjUupcEjn+765R0eMImaQ10/l7NSGuIdzMU0nZgG4w?=
 =?us-ascii?Q?UEagJlg4H51XJpijjm0WwX8alI3zUGmpZmTA1+6Lfmy6ULK23cBqBx/mhoFQ?=
 =?us-ascii?Q?2KKekc8jp/OGXFiqYAqN1Q+kW5eKRpbkeZeg8c4xeu1p1n0npbmflcuF7I7Y?=
 =?us-ascii?Q?D6/RvLYDeTmgVn/QOz3y7ISsUyQ62QyDB20Zge/hDS0BXSm+hDmVQVhbj6tP?=
 =?us-ascii?Q?inA7/dCU3wOQFo/nH5qF9JDR68yQFT1LrRDRFfDe//Y6ZJcU7w/jxlR40dJZ?=
 =?us-ascii?Q?bp1ct12gSafv8UtNWrrUFXsD6crmroMbMK2+5hmCEcv7ack7CZbyOf/4ysqx?=
 =?us-ascii?Q?AcNmMWsiiHtdSNYgw4y5zJjbER0ca37+pMvGRNG7NkwoAnKqzDrNIwDo8joM?=
 =?us-ascii?Q?56/BdMYmqwpZX6RUDVg9RVfzcj5iarLaQvUaam21ePlrzOIt4XCvT5xtzlBX?=
 =?us-ascii?Q?KupmAylWitDF4bnZ/R+rJSAip+ImrWSw3gfHUXPM3YoNPThij/hm8h1j2pli?=
 =?us-ascii?Q?jTopIzMGpBK3NcVytW58EpUXoQetLKcPC7/6LBiiaR+5m//y6zwNEf/xU3+7?=
 =?us-ascii?Q?PuS8ciH2Fnnytd4TO9Aefjt8QXglox4acI8F+g+gfPUEYwIRGhDcvAlKgp9d?=
 =?us-ascii?Q?OpI0iIxcEZL4cSRMHsmYmnjQ0+IzdVENDXVwtMxZeOGDMiobOnQd4W5tfWSx?=
 =?us-ascii?Q?E0zsNG/vHC8l61s4DGIYOA9sIVJ28w8PWQjjAi7/Kv1Tar9M/InJxN2uruip?=
 =?us-ascii?Q?/RtgUlobl/atdSwZFLE5ytQ+24kUg2V6DC0oG7Lg7WzKl92FP3qJ5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:13.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b9488-41ac-4e72-a99e-08dd76788fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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

This patch refactors the SDMA v5.0 queue reset and stop logic to improve
code readability, maintainability, and performance. The key changes include:

1. **Generalized `sdma_v5_0_gfx_stop` Function**:
   - Added an `inst_mask` parameter to allow stopping specific SDMA instances
     instead of all instances. This is useful for resetting individual queues.

2. **Simplified `sdma_v5_0_reset_queue` Function**:
   - Removed redundant loops and checks by directly using the `ring->me` field
     to identify the SDMA instance.
   - Reused the `sdma_v5_0_gfx_stop` function to stop the queue, reducing code
     duplication.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 65 +++++++++++---------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d516add85dd4..38eee309b27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -555,15 +555,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v5_0_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
- *
+ * @inst_mask: mask of dma engine instances to be disabled
  * Stop the gfx async dma ring buffers (NAVI10).
  */
-static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
@@ -655,9 +655,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 f32_cntl;
 	int i;
+	uint32_t inst_mask;
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
-		sdma_v5_0_gfx_stop(adev);
+		sdma_v5_0_gfx_stop(adev, 1 << inst_mask);
 		sdma_v5_0_rlc_stop(adev);
 	}
 
@@ -1535,40 +1537,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	int j, r;
+	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	u32 inst_id;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
-		return -EINVAL;
-	}
-
+	inst_id = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
-
-	rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	sdma_v5_0_gfx_stop(adev, 1 << ring->me);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
-	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
 	for (j = 0; j < adev->usec_timeout; j++) {
-		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
 			break;
 		udelay(1);
@@ -1576,7 +1563,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	/* check sdma copy engine all idle if frozen not received*/
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1584,35 +1571,35 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 		}
 	}
 
-	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL));
 	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL), f32_cntl);
 
-	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_CNTL));
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_CNTL), cntl);
 
 	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
-	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
 	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
 
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	udelay(50);
 
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	/* unfreeze*/
-	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
 err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-- 
2.25.1

