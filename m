Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B004BC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7DF20672
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OXR+oUgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7DF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF5B6E1B1;
	Fri,  3 Jan 2020 09:57:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312326E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF/8d3ATyWedWckI66hO5lQvkBJoiM3NP3VioniY22SjfXj2oIwPJ4HFnYKxn0aiWkDjDIMHwWo2JJ+bP/79hFBXK9VGImYjk6K/1MBUYrQDiFSyXenkul42mDq8OysLD7AsawGo71g7fnmSEgUrIWETrSJN93pLRayWTUuqLhph9a/y8n2+q+8t1/2zh+vcLkjmabuG9WXM0nqSrfhc84TYBJ5ymRFZWemYZCDPTfwqON6fycvw7kReULkzf/vpOuRu5bCTx2WwhwB2JUBV2y9DgEkBr2rqiNPPXLbCoFZ/H9b/jnTP+g9TH5OdzleFzxha5DWTrSJlsEFMmYAUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WFPT7twxufkSjKKxaqeP3p6vLytwb9utxjeFhc/GzA=;
 b=Hh9p79G3p7d+fWXTFeDC3LbpLJ0QmuZYyA5yk8r3LbMG/ynrXY1oTD9MlCWHpBOQkoEwyYAxAddkCX4YU08mMAiSAzahq+xE/edFeVAG4hivYNI9W87rBPhETSRROpcUl1uKPaYD/Ly9zzY/+sF9ARrZDTVzAHFZjcd5VYEGMs9/0LeIlRwzT3k+RZsR8XQbiXOcED2sSozF8jU4ruoAyx3doWWHwLLovHV/0P/EkeDFUFHqVOMsubsMLB2QgDczG4KLNXIrl4x4YAZGKVO6gsNuYdW0FlSoNpxzk7T72+vJk3EvUh3wRLDssmPm4KM9l9+2+Rqfb7y1Y+1zdTm+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WFPT7twxufkSjKKxaqeP3p6vLytwb9utxjeFhc/GzA=;
 b=OXR+oUgyRm/yOB/DJiN2hnr77/xYRHnrVSVvvFrIjCS89hBxXHlcdvM2Z5vFYBfp1FwIWf7oMsLLE8nfdNXNM7RW9Xg2Ksfx6vda0bJ7KF30gc3Lg2vXIbjdt4rw9gtS4kciT4/bghlMipHIkuWWirhYngdOA4bg/CpM6RGFVmQ=
Received: from CY4PR12CA0034.namprd12.prod.outlook.com (2603:10b6:903:129::20)
 by DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.13; Fri, 3 Jan
 2020 09:57:23 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by CY4PR12CA0034.outlook.office365.com
 (2603:10b6:903:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Fri, 3 Jan 2020 09:57:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:57:23 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:57:05 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:56:59 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>
Subject: [PATCH 1/5] drm/amd/amdgpu: L1 Policy(1/5) - removed VM settgings for
 mmhub and gfxhub from VF
Date: Fri, 3 Jan 2020 17:56:45 +0800
Message-ID: <20200103095649.5068-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(1076003)(478600001)(316002)(110136005)(5660300002)(8676002)(8936002)(356004)(6666004)(81156014)(54906003)(81166006)(86362001)(7696005)(26005)(426003)(2906002)(70206006)(186003)(2616005)(70586007)(36756003)(6636002)(4326008)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1674; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6bdb2e-8dff-44be-e365-08d7903354a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:
X-Microsoft-Antispam-PRVS: <DM5PR12MB167471A92B4DAA7280554311FF230@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru6Wko87EPgFVYQtjoMm4k/6a/gsBeRYXDIgTTfM5ofV7lOXIDrXmp61ClE7FgoIi0wm9IYs0cOzce4wLba9oY3UcyKsoLfKf2yx+xhYea3c7az+Eq5+u2GqG2d8dvfs+rQkmCP7njcVFYPZn4VGd5rcXG84lvx44fgSg6ef8Wt2uB4uS7JNsQq0sNV9+jfpg5gCKCJ8opLOQqPXjbjehFH7saIS70Ud5j7S6+YdRNIlFUz80dKkt16Ue6Ty36Bmcacl2zvq+nc8UGB5HsGj8HjhjQXgDvukvz/Rn2vutO+DKeYKMFeDhUiGWFl4pLsmhvgBTWSsJUR5ajfLopn88Vlk6RGHTeobai7jKzjh0hAUHNcxvB5onuaaoL5GKn4QpkJrbgQsDvGe4UAHZbeXlbES5/AXPdDGnJvZt2f5UF1oyHwauL6tvWGKPFJxtvM6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:57:23.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6bdb2e-8dff-44be-e365-08d7903354a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 74 ++++++++++++++-----------
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 68f9a1fa6dc1..4f72626fbce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1308,11 +1308,12 @@ static int gmc_v9_0_hw_init(void *handle)
 		value = true;
 
 	gfxhub_v1_0_set_fault_enable_default(adev, value);
-	if (adev->asic_type == CHIP_ARCTURUS)
-		mmhub_v9_4_set_fault_enable_default(adev, value);
-	else
-		mmhub_v1_0_set_fault_enable_default(adev, value);
-
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->asic_type == CHIP_ARCTURUS)
+			mmhub_v9_4_set_fault_enable_default(adev, value);
+		else
+			mmhub_v1_0_set_fault_enable_default(adev, value);
+	}
 	for (i = 0; i < adev->num_vmhubs; ++i)
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ac61206c4ce6..5c42387c9274 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -128,45 +128,53 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    adev->gmc.agp_start >> 24);
 
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15_OFFSET(MMHUB, 0,
-			    mmVMSHAREDVC0_MC_VM_SYSTEM_APERTURE_LOW_ADDR,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
-			    min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-	WREG32_SOC15_OFFSET(MMHUB, 0,
-			    mmVMSHAREDVC0_MC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
-			    max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0, mmVMSHAREDVC0_MC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0, mmVMSHAREDVC0_MC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+			adev->vm_manager.vram_base_offset;
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			(u32)(value >> 12));
-	WREG32_SOC15_OFFSET(MMHUB, 0,
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
 			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			(u32)(value >> 44));
 
-	/* Program "protection fault". */
-	WREG32_SOC15_OFFSET(MMHUB, 0,
-			    mmVML2PF0_VM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
-			    (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15_OFFSET(MMHUB, 0,
-			    mmVML2PF0_VM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
-			    (u32)((u64)adev->dummy_page_addr >> 44));
+		/* Program "protection fault". */
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0,
+			mmVML2PF0_VM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			(u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15_OFFSET(
+			MMHUB, 0,
+			mmVML2PF0_VM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			(u32)((u64)adev->dummy_page_addr >> 44));
 
-	tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
-				  mmVML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
-				  hubid * MMHUB_INSTANCE_REGISTER_OFFSET);
-	tmp = REG_SET_FIELD(tmp, VML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
-			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-	WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
+		tmp = RREG32_SOC15_OFFSET(
+			MMHUB, 0, mmVML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET);
+		tmp = REG_SET_FIELD(tmp, VML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
+				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+				    mmVML2PF0_VM_L2_PROTECTION_FAULT_CNTL2,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+				    tmp);
+	}
 }
 
 static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
@@ -372,10 +380,12 @@ int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		mmhub_v9_4_init_gart_aperture_regs(adev, i);
 		mmhub_v9_4_init_system_aperture_regs(adev, i);
 		mmhub_v9_4_init_tlb_regs(adev, i);
-		mmhub_v9_4_init_cache_regs(adev, i);
+		if (!amdgpu_sriov_vf(adev))
+			mmhub_v9_4_init_cache_regs(adev, i);
 
 		mmhub_v9_4_enable_system_domain(adev, i);
-		mmhub_v9_4_disable_identity_aperture(adev, i);
+		if (!amdgpu_sriov_vf(adev))
+			mmhub_v9_4_disable_identity_aperture(adev, i);
 		mmhub_v9_4_setup_vmid_config(adev, i);
 		mmhub_v9_4_program_invalidation(adev, i);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
