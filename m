Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7772C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE6360EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CE6360EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B396E507;
	Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0536E4F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiAqyfz/CItSt+i2kqcNg7wy22a78sHKiM1mLu09nwgf+w/1TnJotxVpmcXeyyswE/RAU6renRRLK0tUWbTiEIJnQEVY+CjD4l/9+sgQJMUd/TGWirGtGlABwj8CJI5y0Xap1d0rVwU3QtTCQurG1sv6FvmVHLAKaf3C7kMpDUVkQs+eS6AgFoQC+RDrrNOp0YEezw7Iq5L6q+Bq+6JsGmG5aj/3XuM3SqcoMmRlcrwz3EYaJ82M1AF73T9hqzHjkLmoqHZXOC0q0suq6YWBsdTxrWJDRRQd8oNI3za9ETIYSDSXZgMLTQ7AivZftG7BVLbCqOunuQLui+M/fhaRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzXOxa7Ghp/N0EPDcIozqpnUglKCfq+P9gQTQ4UaKjI=;
 b=iOYSCtyOOwFvEOaubw50Ba7BI6Q4sRH/4E2A2RCWN6BWxTTWE+3DrmYIUsGhNIRowmBQRaGAkeSw3gTZk78+Gv9ZA7tLUZbG9j0R/HC6bN5GsE4dhdq7O9NW71sC5VFbp6+RRQdfjQcaTs/LSGlGgv01zHHBRXpBiuunbNtE0KEVYmrOrDuptExGvZa3Bem/Q+03rpYaeBX8cRjArvHziQa83AhC79ZOhZK/u8c2B6bmfX3zy143UooxDO4/7RDV2BLhxTdL8wTgTc+E2Wu/6WAJtEGAdEnHoMlOVLdniFBUNq6JyiZuZt+PKEoxux4TCiLMAMiXBm/8UyAJQ4BGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzXOxa7Ghp/N0EPDcIozqpnUglKCfq+P9gQTQ4UaKjI=;
 b=l5uRy9IOEO+arQFxfvGj2ybL/B1t1J5n3h//RgWd3h2h4l9ZkbNNoKZjlWP5tCjokFPoyXJ5z2NptcmoO05CwoJBprcUjCdgyWGx7cmVDBkpc54Hyt4nIypoe/KIBdtfgS8B5X2CeSh0iTQpvbKFO7puwEiU9DZ1RY+szuk7qN0=
Received: from CO2PR05CA0078.namprd05.prod.outlook.com (2603:10b6:102:2::46)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 15:02:36 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::26) by CO2PR05CA0078.outlook.office365.com
 (2603:10b6:102:2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend
 Transport; Mon, 11 Oct 2021 15:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:02:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:02:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: drop soc15_set_ip_blocks()
Date: Mon, 11 Oct 2021 11:02:15 -0400
Message-ID: <20211011150217.165699-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011150217.165699-1-alexander.deucher@amd.com>
References: <20211011150217.165699-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b59b99-7c9a-4346-b50c-08d98cc828da
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53853F6294332B0B6A2E4130F7B59@CH0PR12MB5385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/ytymtbxIbe/WxES9BcWoIFudKB6XZGpcHOktZtCXWab6loCLJHwAkuFcl6H31gC42BtJytyTNpbaLG9zh5SMBafDx94AVi3wd46n3PC9E93P7l3IVhi/7lVFiRQStloiTZsI4X1v6gF1qeVoZUH+Wh6TkXkgiR8Y0vpnVIKAouyu0NHCukiImrwNaVlawOi+GJ5usvazLTSowCdeVZblxv3tEnse9jc0awVMDFR1qPMF4fAc+/5PCjIGx38uHmMc95psSBwAOljOxLaZGMO60h5WNk2qGVLBMrVQhg+1pQdQzrorxQnPsNVi3ujR976frAoNc52tC16py+GUwXwSLLJDQ6INb/wFczUDaI2xYC/jtY/3K/mRmwp2C0E7q+QJcB3gWBaOvTU+rkpQhRsDsKessZc8h5UgOzKeXr741NbYJ27a9cC6RBoCse7yf+9I/0aA3uZnwnPHJsqGU5ml1ILePEZNpTNlWUAbn7gy9fQpWkqueSu5dPUw3CAuB9VDK3sY6Jfjk5GVfyTrKnmpIV2yn0aPKtSsSnEFK5lAN5GUrmZsIwguwHN7g0OSFBRZJ9EFnxI+GAi0KhFPipKQduOG165YPeicHwGJaqzUXQSEICmZhlsKqE1BosGtdhPw39ztfOGW8dTpC04ioHFvNTz1T5Cmga0DXtYqgijSED1oVyEXGHzQT5zvXGFyjwVeBALFJoeOQP+Py+hjA4iZQROZGvvFw5IfHCpSPehOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(81166007)(356005)(7696005)(8676002)(316002)(4326008)(36860700001)(2616005)(336012)(47076005)(426003)(5660300002)(508600001)(6666004)(83380400001)(36756003)(6916009)(70586007)(2906002)(70206006)(186003)(16526019)(86362001)(1076003)(26005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:02:35.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b59b99-7c9a-4346-b50c-08d98cc828da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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

No longer used since IP enumeration is now driven by
amdgpu IP discovery code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 179 -----------------------------
 drivers/gpu/drm/amd/amdgpu/soc15.h |   1 -
 2 files changed, 180 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 74310bb4216a..b5d7f21018cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -780,185 +780,6 @@ void soc15_set_virt_ops(struct amdgpu_device *adev)
 	soc15_reg_base_init(adev);
 }
 
-int soc15_set_ip_blocks(struct amdgpu_device *adev)
-{
-	/* for bare metal case */
-	if (!amdgpu_sriov_vf(adev))
-		soc15_reg_base_init(adev);
-
-	if (adev->flags & AMD_IS_APU) {
-		adev->nbio.funcs = &nbio_v7_0_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
-	} else if (adev->asic_type == CHIP_VEGA20 ||
-		   adev->asic_type == CHIP_ARCTURUS ||
-		   adev->asic_type == CHIP_ALDEBARAN) {
-		adev->nbio.funcs = &nbio_v7_4_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
-	} else {
-		adev->nbio.funcs = &nbio_v6_1_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
-	}
-	adev->hdp.funcs = &hdp_v4_0_funcs;
-
-	if (adev->asic_type == CHIP_VEGA20 ||
-	    adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN)
-		adev->df.funcs = &df_v3_6_funcs;
-	else
-		adev->df.funcs = &df_v1_7_funcs;
-
-	if (adev->asic_type == CHIP_VEGA20 ||
-	    adev->asic_type == CHIP_ARCTURUS)
-		adev->smuio.funcs = &smuio_v11_0_funcs;
-	else if (adev->asic_type == CHIP_ALDEBARAN)
-		adev->smuio.funcs = &smuio_v13_0_funcs;
-	else
-		adev->smuio.funcs = &smuio_v9_0_funcs;
-
-	adev->rev_id = soc15_get_rev_id(adev);
-
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-
-		/* For Vega10 SR-IOV, PSP need to be initialized before IH */
-		if (amdgpu_sriov_vf(adev)) {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-				if (adev->asic_type == CHIP_VEGA20)
-					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-				else
-					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
-			}
-			if (adev->asic_type == CHIP_VEGA20)
-				amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-		} else {
-			if (adev->asic_type == CHIP_VEGA20)
-				amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-				if (adev->asic_type == CHIP_VEGA20)
-					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-				else
-					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
-			}
-		}
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		if (is_support_sw_smu(adev)) {
-			if (!amdgpu_sriov_vf(adev))
-				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		} else {
-			amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		}
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev))) {
-			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
-		}
-		break;
-	case CHIP_RAVEN:
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
-		break;
-	case CHIP_ARCTURUS:
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-
-		if (amdgpu_sriov_vf(adev)) {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-		} else {
-			amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		}
-
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-
-		if (amdgpu_sriov_vf(adev)) {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
-		} else {
-			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
-		}
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
-		break;
-	case CHIP_RENOIR:
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-                else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-		break;
-	case CHIP_ALDEBARAN:
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-
-		if (amdgpu_sriov_vf(adev)) {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-		} else {
-			amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
-		}
-
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-
-		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static bool soc15_need_full_reset(struct amdgpu_device *adev)
 {
 	/* change this when we implement soft reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index f9359003385d..efc2a253e8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -102,7 +102,6 @@ struct soc15_ras_field_entry {
 void soc15_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void soc15_set_virt_ops(struct amdgpu_device *adev);
-int soc15_set_ip_blocks(struct amdgpu_device *adev);
 
 void soc15_program_register_sequence(struct amdgpu_device *adev,
 					     const struct soc15_reg_golden *registers,
-- 
2.31.1

