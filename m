Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D442CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE1410EADD;
	Thu, 26 Sep 2024 07:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTcjrZQJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27CA10EADE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ+/FwI5dVNuE2yYK9dI/UrVmEvLTlzXdLNcKLoItl+P/M3dvnWqwtvap5tGn+TV3VcPbegoaqZ4FjceW60iw21bAPhIHpLxVG19N4ET1LA45+B1o0EzDKMX2/iJsJlNaAEz9e09GWnVXvXIk97cRxmU1rA31YBwlODQ7uvvFGe0dMXNjIJc6b/A+WaaS/Wo+3wb8Wd87goztyTBHordzaSKsZUd45BrtoNd3BqDRd3ovkR4LYAX9cbnGEZLq3SYOgXDoFP4mopvCjBQMhG94C49fvgMJzVbYKNwKl2JiYz1ovdmBgHPv/rOrkbe5P8L371siz51HUsA27YQ9qIHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hIqOvL0ly6defDlhojshD6UT3HPJwh7kZChxsxsZtk=;
 b=d3YRcPCqN8ImHUTVoTzNr2NXT4sE1QGzaK3nBKKjNC/OShIpBN8xcAGI1svNQw7snIeieO1yxDhCOA+zvMqRFvkosspPuNwe5fItEYD6zqjn3DddovW9shXhvr2uYXqcn2pDYEwaRqhIMfa6iKFqmqBdbsOlJdssW4Yh53AF2UVT2bJR/qwkINIbQoKfRznRV0jptT0s2tQGrpcVGiXVlhJs9qj6dFRCAGFiAX0ztmrCxUm1ajN4C/Ttex+IBBWEvrJQbZjH4DgNhHR/Dtiq49TcXGqwhKQx7anwhYg7Qmku8aLZjpDbon9HAK+x2epKNb09OZWxcRTgc1bbl1gffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hIqOvL0ly6defDlhojshD6UT3HPJwh7kZChxsxsZtk=;
 b=nTcjrZQJkr6DBhhYsBEzSmr2JSsnf9Zku1ofGcA4SACa9bpI+siQg2ncMLF2TNc8ZOEWlgEYHL36PHDYFQEieWyTeWIvzr2G+5kEOxohDRy5n2lkkQe8XzV7j4tkDzePiN2RHOKxDTZy3oySgsJyNtaWFog2biY3SGMhbbCS0pQ=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 07:48:20 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::8f) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 07:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 07:48:19 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:48:00 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/sdma5.2: implement ring reset callback for
 sdma5.2
Date: Thu, 26 Sep 2024 15:45:36 +0800
Message-ID: <20240926074536.22211-4-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926074536.22211-1-jiadong.zhu@amd.com>
References: <20240926074536.22211-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: cd86e810-31a8-4a8b-b51f-08dcddff96e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+YY3E6pOtQGf5AcY6FQ8ez5UwHHPp8PGjhEZQTBQb6H7UowTPwR/BNJxwn9?=
 =?us-ascii?Q?DuwT4/GgPqQIqIej9Pq/uxy9gtsIJpADW/2Rk44J/rFbdXYEdOlnzvZ2srAc?=
 =?us-ascii?Q?7ijWpdyQXorLdr4/6QhE8c/I1Xbd+aW7u7Cnkg6y5IiJRq5WC+yPOQzxdmt/?=
 =?us-ascii?Q?nZ0cWrI+sfuBTy3ErWo+63kCitOISK41nnJ+TPm9+stFoSgi+PzIRpx/00IL?=
 =?us-ascii?Q?7t0c3FeLvas2UHBygQp34srHF2gDZchLSbrUWxQblmDdE862CYd4IYEwdJgD?=
 =?us-ascii?Q?pvA3kHfef1QaA/3s1JzYtV5/bu3CfVlJ3s/4HD/NgqDSwgl5qmuIZySd5xlH?=
 =?us-ascii?Q?o1S9+UqwLZPDn0LH9D0XL7jsHvV7VTIXuJym8sRa7z2epX0Pw6sf9pi+2Ecu?=
 =?us-ascii?Q?mWoDVG769uCRS+b+PWHuTNtgtIH4QztXWNPU5POzDvWV8Io9Pq15HIPh2/Q4?=
 =?us-ascii?Q?1vYkFF2kZhF8dxhmblEhj2nFqVi5tjlOuxMBE9W3fActYFWknD8jV6gX90Gp?=
 =?us-ascii?Q?sJxm2mfV4HVugnJMPQ7C2d4pGwPvOIn/ijhTVvKxOP96vWBtzBSQH+AMI6Vg?=
 =?us-ascii?Q?PzsDCEMkFc1Mg2HMttSp1Op+l0J/aNhdVFmCVyyaOW3LSyTsTEw82rRBqd6O?=
 =?us-ascii?Q?5HzQ7LIc69GQxpEcniC6cdnVX9DzaK2+D+a09aQ8npwlQm3GFRBxFH1EX6d2?=
 =?us-ascii?Q?I7WfUKSkUroKdFIUP47ENoo8RC+rCpIAoCVtK845E1ge1b/GP5VH0Sm/0vN1?=
 =?us-ascii?Q?hLH6sbu8bEnABoUFx3pUThz6UA3O5rqE2a7GHNAGeAdcythxq+74lPc8bh9U?=
 =?us-ascii?Q?bibJzO4oKt6etv/UQdc9Y9oPO650S1zru90ajNGxWX3spoC7JgzBKtWAe1qJ?=
 =?us-ascii?Q?03fKNYF4MDVUhY6aM9YMPnJ4m+nM24k2LjN4y/QyWWLrr2eqGr1xWhGo4Wwl?=
 =?us-ascii?Q?i04tpr5NnGY8X4vdSi/GLZgu93C3ENKUDSscWqr44znDehSuv0OBFpknsJ5w?=
 =?us-ascii?Q?EqTh2P0EFcvcbCxbDKp+QQ2U0nLwiMFD/dUq5m3yk/eJA9xnhjA5rA8psAS7?=
 =?us-ascii?Q?/6Ah8lc0TfyCzohklYzsXMWEKnGyi6wNsyrgVThrhLhxoEb/nFVFVLIDA2Ca?=
 =?us-ascii?Q?dZoqoieigh76qwQ0RC9VUO22WKIicdbIlc/B6uowOwKGqstbe/61nnVCy/EW?=
 =?us-ascii?Q?4Q3kLYHwhLzoqZlarDQAOcy8K5GQrlw9hRHqiicO0yfGDQ9YmEIlOOOw39Zx?=
 =?us-ascii?Q?AF26mhOPMSLwPl6fCwvAMlWXW/SiMtP8Wm/F6GqXXY/HUjejKdt23RogEHjt?=
 =?us-ascii?Q?ZxmKGjyNYtGNWLgv7CxtSgwBcFGJ2T1FD8cv9i7T54U4YzW5QDjdFOM09+xi?=
 =?us-ascii?Q?3yIqZH/XrHaB0PXCahxrUg1fkmeq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:48:19.7243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd86e810-31a8-4a8b-b51f-08dcddff96e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

v2: enter/exit safemode for mmio queue reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 37534c6f431f..8e8f8be01539 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1424,6 +1424,96 @@ static int sdma_v5_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, j, r;
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
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
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
+			r = -ETIMEDOUT;
+			goto err0;
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
+	r = sdma_v5_2_gfx_resume_instance(adev, i, true);
+
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -1859,6 +1949,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
+	.reset = sdma_v5_2_reset_queue,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

