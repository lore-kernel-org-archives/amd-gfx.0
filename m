Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8236CF58D4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 06:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A30F10E7B0;
	Fri, 20 Sep 2024 06:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4PIpcvNg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AB310E7AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 06:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taf5KfGf4WnfjgusCKCThB4WtPHt6cWy+MGcO/TBSKUkBI4mgbEmeQZUQZ9NBVYMloyHioclzG1w+nkTLVx8WDG7+HQZIngbTL/Bh231v9hvkHf3P5b0d7KjpnZD+qtIJ++6+YTsJu7ywIA5M88wbvrlC/yGMbU4iwTiAqKNdRX89mqHHYUzfT/isg4XA9n2MdrNyb/xjmZGrimU7vikkPL98qAdz+PeBzRyUW5u1HLwxiHcgR2ZlQ+VguHjTNzP/84AxccWbQ0bK4DqJmOppY4Z07qYGMwIQkY2ML7acmK31PwZwRmd3+4e/cJd/qQBzQKmTZz0YiEDlByn3erK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKuvrKgyjk00Xxi+hKPXFZo/nf2r59EnNKQo55Vv+aU=;
 b=VX1xgoQBTKYyXYQCA5/Nu29fMvV+icjLez8tot0BaK0hFs+378BkK7ngkmfYBnMWjSf6/Pa04Gaxr34GEEZu4aauVipA3JmQS3E4R+7G70I5YLD4uObZlk9+FABVRpRoR42R+5A8IElldRn2FDAT1AylZc8Vdi7vQllBhy6RnynUhpKqNRiGhwmqqUwacxlETaohIexc8WOfaiiBWxIy+Cz4DDpaJE1lYRlVnxdTNyExL7qH4iAhmhefv5csD3c884fqpvCTJlOpmlUuYXzxPac2bU3cW4zoNEVyhT/erkp2KZn4D2WD2Do3ggGFgvV9QmxXCrbnMwu2F2H4zyflOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKuvrKgyjk00Xxi+hKPXFZo/nf2r59EnNKQo55Vv+aU=;
 b=4PIpcvNgvh1Zs15h0oRs1MEjkGwBw0n4V3Egqs8ZMax7UY5YyxiBg4WgsziJMtPLFjvvtvzpB9PH2vdPdjmyLaPHjhioqNws3EWTQfRLHinGXpFEWj2wjsa2mIcVqlmQfhOde/vcsRdzj3UEtekND5sOmWcJtx8F/LYF9jtoyhA=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 06:31:39 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::63) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.27 via Frontend
 Transport; Fri, 20 Sep 2024 06:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 06:31:39 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 01:31:37 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/sdma5.2: implement ring reset callback for
 sdma5.2
Date: Fri, 20 Sep 2024 14:31:12 +0800
Message-ID: <20240920063112.370961-4-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920063112.370961-1-jiadong.zhu@amd.com>
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5f2cce-af2e-497f-5e0e-08dcd93de242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i/bMJhux8fcx50dK8bkgP6F+cPTyEQUC7ptvRgE2C6GLe/0W3QEfjp5A6sWi?=
 =?us-ascii?Q?OcX35p6iTAm/t77ynrieqJfIvmvtCkgrGgapPtTHYcRoGDA79lkQgjuiEz2L?=
 =?us-ascii?Q?lrVlkI4xootrs1aEop7KHGMr6IODUL5EDFz2wr+yoN4exMBuWted8Mbgu6bz?=
 =?us-ascii?Q?m0AAjK00G5NVUsI5myZra/f+2kbS1jnU36MjV5O1KJ5JAgKlgSdA40bkiqjA?=
 =?us-ascii?Q?jCKlTpqYRc6JzdN/gbqPHGSnfQfAOgxpF08WvbbEyVWjzYMcsVoWiRzz7TIq?=
 =?us-ascii?Q?8bT9V47CTY2gfYBAZDpHBsk1p1IVg+knESGsItAzWXSdqfJb1Ee0iwmF11ix?=
 =?us-ascii?Q?6kQOh8a/eOi25f4SShU4MiJTrJNGlBGEH8f4nAkqX0QKQLB0cf+aLeXTsNA4?=
 =?us-ascii?Q?Hb8gg3cPNENeir3C+cd6vOdYVJwhvJ+3J6GcOZ1i9cjD417AUdmdnUl+wMih?=
 =?us-ascii?Q?XjqOs3vve/4HDMF6t58mrxx0Xdx+ZfijjJ4xa+2CC5poY554VmUHw6BmRpJl?=
 =?us-ascii?Q?sH3XpWJ5+JOEaQgAlSiFHO6pYLUpCfPaR0R9IPMQeUqnz9qSIYUkm9l4qvVT?=
 =?us-ascii?Q?SJDO/zG0enV0Tz67us8wM0lqN1WDUBPqA8uacBVaTpgt4duHIoktmAAPhif8?=
 =?us-ascii?Q?d6rTSVlX2Uh+gp76lI1irBelRAqvaQgYLvwcv63vfoTjCNyvItN+MCCeQHMG?=
 =?us-ascii?Q?8PqFqaPWEbQ++Hxwd8oBf2+PDnru7maFLT33oyEsJUgdsaAeOTXPapaAcjLB?=
 =?us-ascii?Q?XzxSK0538Beha0c+8IRzLHA+Ky6N6l3l1/Hq8K0On5bDgJoKUnVbyuF9t4I1?=
 =?us-ascii?Q?Lfh71wtiIurcacs/dSDc6OcLvAp4ElZ3t9UJItxwXBMwMxGRsfSlGO0G1v2p?=
 =?us-ascii?Q?Yy/rEmRfAEvhTTEg4G71iPDOG78LLqdFGIYKAR0uoA8QvcifWu8I3ZovqzYm?=
 =?us-ascii?Q?Nf7C9aiHIfgn1eaBwxedi7Qgvjcufum4xYTWmlY7Z3nrenRklFal2nuNtv1Y?=
 =?us-ascii?Q?0ycf5ARle8dmYUChpvR0Ov//Ey94Z1tjN65SgJlD70YFKB5vZzJ/R+bfqrMv?=
 =?us-ascii?Q?9Mcv+JyBfuMMQFVL9SerV8WbGKQ22NVt76okANXGgHUjbT7v3TnqsYaodWkU?=
 =?us-ascii?Q?s2o4Wp1DKoSGXxKmtCo6LMWPy0iZ8TJgQ4s6XxA6+xwTBd5vt513T5Fxlowe?=
 =?us-ascii?Q?R32+0+680C4p9s5S+B/weo69M37sdX6cYZ5f8DDudwETtcC+2rXw0HrwHdDa?=
 =?us-ascii?Q?YBOkZb25OWi+GreADCqhaOANK14qZyNfashhTRBQDiW3Jjxt7APWvFjHYdAS?=
 =?us-ascii?Q?dtGu8s4/jiDsRJIAvbodcouUHOcG97rJ0Vr5v/DJFhgHBR9lBicKvASA5TnD?=
 =?us-ascii?Q?HarqYfT/UKKZjUJH067Wdy43Mm5L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:31:39.1219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f2cce-af2e-497f-5e0e-08dcd93de242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via MMIO.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 21457093eae9..3c93a8954a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -597,7 +597,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
 	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
 
-	if (restore)
+	if (!restore)
 		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
@@ -1424,6 +1424,89 @@ static int sdma_v5_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, j;
+	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	/* stop queue */
+	ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+
+	rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
+	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	for (j = 0; j < adev->usec_timeout; j++) {
+		freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+
+		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
+			break;
+		udelay(1);
+	}
+
+
+	if (j == adev->usec_timeout) {
+		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		if ((stat1_reg & 0x3FF) != 0x3FF) {
+			DRM_ERROR("cannot soft reset as sdma not idle\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+
+	cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
+	preempt = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+
+	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+
+
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	udelay(50);
+
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	/* unfreeze and unhalt */
+	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
+	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	return sdma_v5_2_gfx_resume_instance(adev, i, true);
+}
+
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -1859,6 +1942,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
+	.reset = sdma_v5_2_reset_queue,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

