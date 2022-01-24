Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ACFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67A410E2A9;
	Mon, 24 Jan 2022 03:21:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A68310E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0clq1TvIqC8zhnD+NLYKqQj7ILqg2qwv3CSnKDI4k02jULV1h4wdklB6HwDItKALchzZS1lBzzW3ujlcKlqF+hVquaEC2RH0qz8/5AY90bB88lQrxeC1SX4ar7+WbVXNnkimvdTIJVpHYwMUeTzlEGoblJfJADP9FmoftTnSznSMJLfdHa6y+wB6DjJVQOnyAi1Ons9hy7+hzAq45siOa4zwnRZw0ooyjAnwAQUtW48jJCYpcC23/BMBHOf5NPrPKn6mq0KGLiCsOMj8gycAXcJYKCsuFQImE9mnKEJnf0jVtplMNfE2BQP7EahQcqcHbtbOHZRCltjaTe+IegRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcFt7eNAzVv5qZlyJ8BxVh+6bYnEpL5AzjIEJ6nPjkM=;
 b=BSGGzHUc9AT+yOtxEdldKyihBGd6nIA8kRR5biBe8kCKQ2rY596bAm81O8KFGFWyyrMFlQ9SBMUBMKsbNqQN61ykgnfGqV7jrLx8fTvANJMDxiVml4R0LJeRDwBvuj4qfmblFEJp2741fezcHaBr79L1iWo7zPoye34B6UQPQ87KIgZ9yPz6iRixga+CuStqPSXL/BC71vh1fhA9rXZq0sIozJsFFZ1CZrQ3vBkxtgjN4+jOJXXruAIykOrx6v8DwkQueg+yIa/8kf1L1yKVLQJ0G0Hxe1rL8af4RWy7Dwa+IaphghK4B3BusiYf51XOnuxYQHmjSXqNbtL3mwQ9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcFt7eNAzVv5qZlyJ8BxVh+6bYnEpL5AzjIEJ6nPjkM=;
 b=fGOs7zXAd+1ijncEa2dahDzx+ByRho81/spFxuSgXbuUIlIv2VXGj7XolhoNJI8J4n0n860PIQR5dzzPApPXL/pBUwwzPtzEHqQBNV40oieoZ5PPNxIXf9lgBVVt0X98EwMFpzMY6EyDP5rkDHdowy1opeOcfaLWOEHN+/LwqOE=
Received: from DM5PR1401CA0019.namprd14.prod.outlook.com (2603:10b6:4:4a::29)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 03:21:14 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::ae) by DM5PR1401CA0019.outlook.office365.com
 (2603:10b6:4:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 03:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 03:21:13 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 21:21:11 -0600
From: Tim Huang <xiaohu.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: convert to NBIO IP version checking
Date: Mon, 24 Jan 2022 11:20:40 +0800
Message-ID: <20220124032042.1974371-1-xiaohu.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907c6d3a-118b-4e47-c3ca-08d9dee89388
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5462D6D485E2CC8662E08FF5F65E9@DM8PR12MB5462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t2/qs4QPbvQpUtwD3X5S/IqH6n42wDMkeRR145LLLOruNgv8cp7RP9713LdjU8QTTi9A0oF5Fng6mrZeQVJvHQGSaDWHafuPSvQ6MLuV/+1l3vYYbXicPWIOTs9/uKCa/dL3KISUP+4I9GHMexNlZC4hCo7f1R4LO5pgIboYB2GtGm3G0nyeAM5Fh+hoFXFgnZUo6R25gbJ8BrheNTKrODvAOcibtAIT3J+YGhmNcXmCZf4tsMUXKDo72gLjUyxwQd0R3V1jj/sm+gL3WkSCU4v7xzqgflftNOo4N3/JDk3guTbK9Dl5ToBLM5TgYfPFZ3aIm1kdkp6q5Hu+CsHQeFxOxufoE5y/Ee54nHChs1nfXE49fjosRTkPAyFic9T3guhTBFHyJoMAZZ4OOUfqGflkLECDdT03W71L04p59xfK8KTcKCrI0zCqHrZCIcP72LUECg77mKvVL6enOI3gPl3mGZA9HhCERoV+4/WkYx/YvhnEyM1pq8L3RLx9kzKa2pLtVTuKcKbZOiCVDeqiL79w0iqjfx7OAuFftV1BzGdf5PmQOHXtgu6Nqf+vW+L4z/xdRqVI2Nor0DiO/RA563p742ItEK4VcGlwHGMaHXF0RX6ii0l4HcKeyDqFIUyVr8HfAkDIZyZUt604GlCDwqVARkqprjy7JqJJD1HkydwtxbO6/aUor669srl9ReP1/9ILmpIFg4DotNDNKnZ49FE0IOEVxIyMUfcUl5b+RyXnGVniYCnWtbUPdxnm4WfDzpjpMz+12ypOdnCUhMXC2qJ2il9OAi/Ru3olhzPCiY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(1076003)(6666004)(2906002)(8676002)(40460700003)(36756003)(47076005)(6916009)(356005)(2616005)(81166007)(54906003)(8936002)(336012)(83380400001)(82310400004)(26005)(36860700001)(186003)(316002)(16526019)(70586007)(508600001)(426003)(5660300002)(70206006)(7696005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 03:21:13.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 907c6d3a-118b-4e47-c3ca-08d9dee89388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron.Liu@amd.com,
 Tim Huang <xiaohu.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate IP version specific features.

Signed-off-by: Tim Huang <xiaohu.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 48 ++++++++++++++++++--------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 3444332ea110..70e341d884d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -59,10 +59,15 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	if (adev->asic_type == CHIP_YELLOW_CARP)
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC);
-	else
+		break;
+	default:
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+		break;
+	}
 
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
@@ -72,20 +77,25 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
 
 static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 {
-	if (enable)
-		if (adev->asic_type == CHIP_YELLOW_CARP)
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
+		if (enable)
 			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC,
 				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
 				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
 		else
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC, 0);
+	break;
+	default:
+		if (enable)
 			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
 				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
 				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
-	else
-		if (adev->asic_type == CHIP_YELLOW_CARP)
-			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC, 0);
 		else
 			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+		break;
+	}
 }
 
 static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
@@ -249,8 +259,10 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 						      bool enable)
 {
 	uint32_t def, data;
-
-	if (adev->asic_type == CHIP_YELLOW_CARP) {
+	
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
 			data |= PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
@@ -260,8 +272,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
 
-		data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1));
-		def = data;
+		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, 
+			regBIF1_PCIE_TX_POWER_CTRL_1));
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
 			data |= (BIF1_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
 				BIF1_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
@@ -272,7 +284,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1),
 				data);
-	} else {
+		break;
+	default:
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
 			data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
@@ -285,6 +298,8 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
+
+		break;
 	}
 }
 
@@ -352,7 +367,9 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
 static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
-	if (adev->asic_type == CHIP_YELLOW_CARP) {
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3));
 		data = REG_SET_FIELD(data, BIF1_PCIE_MST_CTRL_3,
 			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
@@ -361,7 +378,8 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
-	} else {
+		break;
+	default:
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
 		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
 			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
@@ -370,6 +388,8 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
+
+		break;
 	}
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.25.1

