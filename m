Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A943C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C831B60EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C831B60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA306E511;
	Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A23C6E4F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuN9MFZnMs4+bEi9cCmxPlidnoGphORY5ORxd+504eiuAAZS3FpFFmBvoZuPWWwmCfTPxdPqofczor8K0rUhE/YETF2DYyK6/Ezllqef197L6M1NL0IdfRVR0256N+3j1HkOAKitVGPEZZZwt7pNVgZk2xAeYTVn5d64hc8fQnqXMx+uStBUa+uknjmh99HygVcg32qSxEhjM6Q6oXc985yiavOHsT+hUByJqci7gJcvbGz7N2/QEPMcR0Py9Lwxdb+6wHLjI1fG2mNzm6XKwwgh423472RM4kETbHivEitY0jF/Lvzory47/LQAdv0tgw5sUYdnUi+vZn7M7SxFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkjZfGST85YCJlQxyr9weNjNaVxiTO2dWu53TcfFxXA=;
 b=VW6CG9S+kJv2ljz864WVpfukhXa86Sou1XyxzYvuEbyYrQ1yBEslAXfUzxPV79AMPIaEUgx8blPf2hYjWxRh/MwILXYeHk8o8t5fTh0BMdlgf/o9xkPv2W8FFnya51Y33+UtLoZzM0PAjtxKPIzd3YmxYoxt3H/3BJZDdOH/wBljtoWgwgSzaHZEy7+OJ8VG+b1z5S3XDib0lQzsplNQM5aAqu1sJuCN0ZyrP04xgjy0M3gJrsTIToVuYHMn9M1fgM6UcTDNBCKnP6cAeFcQ4/Uqn3+rj7DRkVO6sdvQZaPmayxizzI9XFgujvkJVFNWxwIfH7uRLCo8J3X8GRnBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkjZfGST85YCJlQxyr9weNjNaVxiTO2dWu53TcfFxXA=;
 b=DS3owJp3NVMp2GUphuUV4VxEReQKKICdRfbzsKY5CVAnWK1Cu2x4eWcQ2cvqIaA1U3LQUA7JnSLa+JDqjHqCMODgS2GhnFsEg4na9JDbdNd2rLNwo9wpsrmKWqKArvk37mC1dktntAcDk883BjDbUN0Bd3bJK7lB1xSMvOApk/c=
Received: from CO2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:102:2::30)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 15:02:36 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::26) by CO2PR05CA0062.outlook.office365.com
 (2603:10b6:102:2::30) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:02:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:02:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: drop nv_set_ip_blocks()
Date: Mon, 11 Oct 2021 11:02:16 -0400
Message-ID: <20211011150217.165699-4-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 63cd64d1-bef6-436f-bcd9-08d98cc82962
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3414D00C89C3BBB5F8AD1753F7B59@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/SGce18hKJoA1hd4mVjp5DoZPfNAv0V7UhBWaBcSqVMTJjSqvDGlWeCU+ZS9TCp1YnrgbS5kVbjgedwJ7GgiXOOIlEHMy4uiQX6x2IaLjlxSCBeTtFIHYAXLHOj9K1b87n4rv4UE1f1pBxSwixM7lxXQykN6QjdpPwamoI7GAHUJpSMc50gWQ7HdqvvX5wCUKCplbBNh3x/ilZl3TfHulyuuYLXHWkmdXPnix7uuscXxaWzzJQa0KnTu/aH0KqI3TEywtLJud44ZZGnW3bdDZ1FMabRUZgVeIKfT7l1VA8J6MjVfSApXFbNeDHsaj98+m5KFCE41ic04wL+PmIMXBSh1zLJ4LpWE+AeaR5vbQVSlMCCgUCw1n3BmIP706nDv3RHKiXpP54+YkyjdLbhEgOOKDLaQ+3UKv/UAKAsYRBHP2RV3ffKiMytY2Mg9W+Jtfd9dBOI1gry7nkEdnHnQoij86ch/KRMS7oY4q905thBpDKAMraU0Fkv9bbJnzcGoW+KQbLXRG3lCmqWyNS9PVaS2sZmSVAnX+cXXlyEHOuYbN8MwrVnLjQfVPIiTFdfc7xnkrRgzvTGsEdiiku8+ipzt5x5MvjtlqXIdFTBtrFOvqM/L8SCbNdk9d/q0nco2Q86NKp23OcfIypvtnqBe9ORdGwH0COB2Jj/YRqH/wEKVa8qfMgHI4o20VglxzUyxCVeJdPKWdRkuhGktrUzoBW768cHYBYGqgOk0f7/hlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(70586007)(6666004)(8676002)(36860700001)(2906002)(426003)(36756003)(336012)(6916009)(70206006)(508600001)(81166007)(316002)(26005)(186003)(47076005)(30864003)(5660300002)(86362001)(83380400001)(8936002)(4326008)(16526019)(1076003)(2616005)(7696005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:02:36.3881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cd64d1-bef6-436f-bcd9-08d98cc82962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
 drivers/gpu/drm/amd/amdgpu/nv.c | 293 --------------------------------
 drivers/gpu/drm/amd/amdgpu/nv.h |   1 -
 2 files changed, 294 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 898e688be63c..90ae5d99e94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -607,304 +607,11 @@ const struct amdgpu_ip_block_version nv_common_ip_block =
 	.funcs = &nv_common_ip_funcs,
 };
 
-static int nv_reg_base_init(struct amdgpu_device *adev)
-{
-	int r;
-
-	if (amdgpu_discovery) {
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r) {
-			DRM_WARN("failed to init reg base from ip discovery table, "
-					"fallback to legacy init method\n");
-			goto legacy_init;
-		}
-
-		amdgpu_discovery_harvest_ip(adev);
-
-		return 0;
-	}
-
-legacy_init:
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-		navi10_reg_base_init(adev);
-		break;
-	case CHIP_NAVI14:
-		navi14_reg_base_init(adev);
-		break;
-	case CHIP_NAVI12:
-		navi12_reg_base_init(adev);
-		break;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-		sienna_cichlid_reg_base_init(adev);
-		break;
-	case CHIP_VANGOGH:
-		vangogh_reg_base_init(adev);
-		break;
-	case CHIP_DIMGREY_CAVEFISH:
-		dimgrey_cavefish_reg_base_init(adev);
-		break;
-	case CHIP_BEIGE_GOBY:
-		beige_goby_reg_base_init(adev);
-		break;
-	case CHIP_YELLOW_CARP:
-		yellow_carp_reg_base_init(adev);
-		break;
-	case CHIP_CYAN_SKILLFISH:
-		cyan_skillfish_reg_base_init(adev);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 void nv_set_virt_ops(struct amdgpu_device *adev)
 {
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-int nv_set_ip_blocks(struct amdgpu_device *adev)
-{
-	int r;
-
-	if (adev->asic_type == CHIP_CYAN_SKILLFISH) {
-		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
-	} else if (adev->flags & AMD_IS_APU) {
-		adev->nbio.funcs = &nbio_v7_2_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
-	} else {
-		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
-	}
-	adev->hdp.funcs = &hdp_v5_0_funcs;
-
-	if (adev->asic_type >= CHIP_SIENNA_CICHLID)
-		adev->smuio.funcs = &smuio_v11_0_6_funcs;
-	else
-		adev->smuio.funcs = &smuio_v11_0_funcs;
-
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
-		adev->gmc.xgmi.supported = true;
-
-	/* Set IP register base before any HW register access */
-	r = nv_reg_base_init(adev);
-	if (r)
-		return r;
-
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    !amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    !amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-		if (adev->enable_mes)
-			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-		break;
-	case CHIP_NAVI12:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		if (!amdgpu_sriov_vf(adev)) {
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		} else {
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		}
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    !amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-		break;
-	case CHIP_SIENNA_CICHLID:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		if (!amdgpu_sriov_vf(adev)) {
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		} else {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		}
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		if (adev->enable_mes)
-			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-		break;
-	case CHIP_NAVY_FLOUNDER:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		break;
-	case CHIP_VANGOGH:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		break;
-	case CHIP_DIMGREY_CAVEFISH:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-                else if (amdgpu_device_has_dc_support(adev))
-                        amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		break;
-	case CHIP_BEIGE_GOBY:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    is_support_sw_smu(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		break;
-	case CHIP_YELLOW_CARP:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		break;
-	case CHIP_CYAN_SKILLFISH:
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
-			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-				amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		}
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#endif
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 {
 	return adev->nbio.funcs->get_rev_id(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 7df2f85bbcd0..c6e9233afd17 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -31,7 +31,6 @@ extern const struct amdgpu_ip_block_version nv_common_ip_block;
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
-int nv_set_ip_blocks(struct amdgpu_device *adev);
 int navi10_reg_base_init(struct amdgpu_device *adev);
 int navi14_reg_base_init(struct amdgpu_device *adev);
 int navi12_reg_base_init(struct amdgpu_device *adev);
-- 
2.31.1

