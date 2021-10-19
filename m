Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 10:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF75561052
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 10:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF75561052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371B56E14C;
	Tue, 19 Oct 2021 10:03:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5A6E14C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 10:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCgGqnYy4XnMYDpgkwpOoGLFZFe2elhuokZMBDio7d7abIAS0pgHUzeR55L29M8XV2JixqaNLQ1B5gGzVvEnlXeGMcpWgvaqe+HmEGd6I2E4gAM8qCM6qcWL7c9dh3IPmC/f9AyapOqkBBqd7yven6ukYpvjnNLernVY7pA8W4G6+Nu3ZSxHF9bX0LOwNM7uVcFwxIQLWL9RvAt7DhVOc3jMIvfz5dSN5ajG00VTSa2szWDI+i5wBzNdwYOVjjsAF4yYqdWrxWsdr+DNLDDLVLpWPVD9a0tP3Qsbx9QY2mTTiHags41fx8Cfqixl5DrFUzmrVOL8rrlVW6+2Ib85rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2FdSo4mflab1sUsl7GpMvVB6qdP0+tinGKWKHMmnOM=;
 b=N+TYjWke/sLK4lJ1UEIKQQ98sVKFXSAskD9I/vwvBcfwhAc/BWeOMGyEJ6lI70Wl3jl+tjCf7c0hCGetMnIAWTR9D7bxle9zSLblfl4gwZddItvJv4t5zo+Fdgj64Lg8qIYh6i+hAyVqjjiY41Baupmg7O8/Fcc6kWPRG8/Wbw+AyDBTSszWBrgSEeAbFOWCSPk4j7NNd4vbtBq7S4+9luSAv7G96yi5QmDK7yE4pPR6z6hsLpm41rY4KhUIddFing/A616oJkZp77gNYBeYZWSaSgkHFNF5x1EGdNXT90P/SgESAL5OMYufmkTWkbH2pZzaQnuYM0QwNJiJFLMe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2FdSo4mflab1sUsl7GpMvVB6qdP0+tinGKWKHMmnOM=;
 b=VTS3PGYC3MI3xBuwUYdUPexhOUZHdHyqtzjJZPdgZH1n1ox0CGf5lytNPampnMrYr+0b9wQKV75OAmgMy095DwxHW3vq0qjEMOptFssNNC7gK3D7ThLejl4ldR+64jMNTc4lqCDGDRX30s+VU2/OmNU256Y+GdXzqzmpnfa+5NA=
Received: from DM6PR11CA0042.namprd11.prod.outlook.com (2603:10b6:5:14c::19)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 10:03:11 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::75) by DM6PR11CA0042.outlook.office365.com
 (2603:10b6:5:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 10:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 10:03:10 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 05:03:08 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>, Huang Rui
 <ray.huang@amd.com>
Subject: [PATCH] drm/amdgpu: remove grbm cam remmaping for gfx v10
Date: Tue, 19 Oct 2021 18:02:47 +0800
Message-ID: <20211019100247.533120-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16070348-e57b-49a9-9190-08d992e7a86b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25425E1148F41863EDAA8F39ECBD9@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0o/KYUK7foUxgGoesldG+metMLVJVNtqskhC9qx7VDxoFFP7svT1rEUIOr1R1ZAGWnT6aRNTbx6scAyvoIraJL0x4bIi7U8YZ3iCG59D2tGbgqcvZsz5x4z1ahc529cLlZD/S74uV+UwJUT7oSG3pFfNZ0gPWQXZZu3n08nmGMbcD1jUCe3zmU+nLAV2gETFsdVQQB5x9N47BVnx9ksrizC7bG35VHwQ3sZez5RuWDG22FoX6kZH9I5oZdpmc4WGgNvTNHiGvIWh8mSU6xuON3XN1VDKbexEC+YI5pvgL+UAJpzrIzH1bLUaXQewLpX6QvIHEGcKn/FCEuH3v44zkiCnl89+vDZzz8+TAajSuI1BSb8udXqRw8ybzQFH84GChCCBOJy+snQNP3WtClQN+JfKNibhqwFM+V3VtU3t1XuPZuZ5BWxCXE6x+tZcD5vHaipa/EwzlqunWIoqG/+rsAUQwqLWMoR3+Wbql42ti4xYVUxRu3orNJTWNNQp8GhmDHiStc53Dq0opYESsUwEg05LYq+mIvgAAmGxRlILxmAOFOYF4zQop0dx4IFUTmhvQiisU2pF3F9ze5pJe1s/zJn1OuE1EQY7S9My98fxkCDc4/z5bCZLYnoLBNq3bm8ca4ctlPItFqMlMTba/zxSnIj/iZzYQw7FC8jdnaP1xM4sGRYFMadVv1x69okgw+MkOhZ5trrP69XAZ6WVHFm/52MccQ/TS2WcjcHMsTqCTU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(5660300002)(7696005)(36756003)(54906003)(82310400003)(4326008)(16526019)(186003)(316002)(36860700001)(81166007)(70206006)(70586007)(8936002)(426003)(336012)(6916009)(508600001)(86362001)(2906002)(83380400001)(6666004)(1076003)(2616005)(8676002)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 10:03:10.9558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16070348-e57b-49a9-9190-08d992e7a86b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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

PSP firmware will be responsible for applying the GRBM CAM remapping in
the production. And the GRBM_CAM_INDEX / GRBM_CAM_DATA registers will be
protected by PSP under security policy. So remove it according to the
new security policy.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 201 -------------------------
 1 file changed, 201 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 71bb3c0dc1da..a53036a05d7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -270,25 +270,6 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
 
-static const struct soc15_reg_golden golden_settings_gc_10_0[] =
-{
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_INDEX, 0xffffffff, 0x00000000),
-	/* TA_GRAD_ADJ_UCONFIG -> TA_GRAD_ADJ */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2544c382),
-	/* VGT_TF_RING_SIZE_UMD -> VGT_TF_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2262c24e),
-	/* VGT_HS_OFFCHIP_PARAM_UMD -> VGT_HS_OFFCHIP_PARAM */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226cc24f),
-	/* VGT_TF_MEMORY_BASE_UMD -> VGT_TF_MEMORY_BASE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226ec250),
-	/* VGT_TF_MEMORY_BASE_HI_UMD -> VGT_TF_MEMORY_BASE_HI */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2278c261),
-	/* VGT_ESGS_RING_SIZE_UMD -> VGT_ESGS_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2232c240),
-	/* VGT_GSVS_RING_SIZE_UMD -> VGT_GSVS_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2233c241),
-};
-
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3809,9 +3790,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
 		break;
 	case IP_VERSION(10, 1, 3):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_10_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_10_0));
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_0_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
@@ -7297,181 +7275,6 @@ static void gfx_v10_0_cp_enable(struct amdgpu_device *adev, bool enable)
 	gfx_v10_0_cp_compute_enable(adev, enable);
 }
 
-static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
-{
-	uint32_t data, pattern = 0xDEADBEEF;
-
-	/* check if mmVGT_ESGS_RING_SIZE_UMD
-	 * has been remapped to mmVGT_ESGS_RING_SIZE */
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 2):
-	case IP_VERSION(10, 3, 4):
-	case IP_VERSION(10, 3, 5):
-		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, 0);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
-
-		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) == pattern) {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD , data);
-			return true;
-		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, data);
-			return false;
-		}
-		break;
-	case IP_VERSION(10, 3, 1):
-	case IP_VERSION(10, 3, 3):
-		return true;
-	default:
-		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
-
-		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
-			return true;
-		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
-			return false;
-		}
-		break;
-	}
-}
-
-static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
-{
-	uint32_t data;
-
-	if (amdgpu_sriov_vf(adev))
-		return;
-
-	/* initialize cam_index to 0
-	 * index will auto-inc after each data writting */
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
-
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 2):
-	case IP_VERSION(10, 3, 1):
-	case IP_VERSION(10, 3, 4):
-	case IP_VERSION(10, 3, 5):
-	case IP_VERSION(10, 3, 3):
-		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
-		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_Sienna_Cichlid) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		break;
-	default:
-		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
-		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
-		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
-			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
-			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-		break;
-	}
-
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-}
-
 static void gfx_v10_0_disable_gpa_mode(struct amdgpu_device *adev)
 {
 	uint32_t data;
@@ -7506,10 +7309,6 @@ static int gfx_v10_0_hw_init(void *handle)
 		gfx_v10_0_disable_gpa_mode(adev);
 	}
 
-	/* if GRBM CAM not remapped, set up the remapping */
-	if (!gfx_v10_0_check_grbm_cam_remapping(adev))
-		gfx_v10_0_setup_grbm_cam_remapping(adev);
-
 	gfx_v10_0_constants_init(adev);
 
 	r = gfx_v10_0_rlc_resume(adev);
-- 
2.25.1

