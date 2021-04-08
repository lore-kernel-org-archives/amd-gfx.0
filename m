Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBDC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7048B60C3D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7048B60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2226E17D;
	Thu,  8 Apr 2021 05:32:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248BC6E17D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8VkV4cVko6kDIFMU8fx6LC2d/d/DwioDmxEdaBXONhawCqWOrpZ4l+q+NSSTUlI5bIcNUi2do2M3pMRwlLw+bjTkVPvZaL6c7T+BnWuQx5i8XxR5b6jpBr296yaRl2H68BMJxMSPnC043gvAgHj88LemizIw+0FeCzzXrID7Ht+IsdvCCjtRQUACDHcdBmkuH7/y7vkK3FyRtNuZOyQY8ZEZlLYWINfO820sYVRC9CRsMTV/AY7ZQEmgu2WD6ufDESgf8LiGlMClN5C/jRkjgv3jpgZwH7FevMkZYTlNsgqiehgqqTCPTka5OkMBHSVPHSBwxAgHv+8txzbUyRNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZXieAMMS1GTC028mLgdM3iaKqwyDI/xrIsqsQO5pXM=;
 b=mNhEd1npJdUCQLDfzTiQBIpsuB/tH0Eb2Ninzc6QjXsqoZnJW6bFjarEg1GclbuddDQuHMsUTCpwGR/Zq1+raqFCGkyeEm0faZTuguzY1rSd7nluNqZDRpCYk+nJe+aq3oXBnOrhrtB+INHRKfoFB5zF9j/tBRuDYsEI4AcKHETUUybTpF457AzwWw0u8+ToBVwMrsbIlFDCEgP1pJu02XDX7y9BINijge9IZLQnx9tpMHaUE2eChwG0+gvDoSr9FlyKhEa93Dv6PnHEyk1ed1fjypux/md6dbLPrsVyf2TwOLawbvvkhaaX7amrfLQslc9mTh9PHogZRyoRVM0rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZXieAMMS1GTC028mLgdM3iaKqwyDI/xrIsqsQO5pXM=;
 b=ru8c8aK0f+4oPwRW8VWPKAg+fhawr0e9EX3Hvj7zzfWUMV4kRX9xYu3gamUmQFzkcqE5LIIOn3Mgzk+NLYQ+JrWti5Hg7DH2WYM2vUAHBuGTOC9E3/cAURmLPM3Ast1Jce2Z6il0qdSs8Ixe5TjpGkr20B7i7YLXoe6LsKaAbvA=
Received: from BN6PR1101CA0002.namprd11.prod.outlook.com
 (2603:10b6:405:4a::12) by MN2PR12MB3391.namprd12.prod.outlook.com
 (2603:10b6:208:c3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 05:32:47 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::97) by BN6PR1101CA0002.outlook.office365.com
 (2603:10b6:405:4a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 05:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:32:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:32:46 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:32:45 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: change MMHUB register access from MMIO to RLCG
Date: Thu, 8 Apr 2021 13:32:29 +0800
Message-ID: <20210408053236.30762-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b30ff4d-f63c-4e76-7769-08d8fa4fbe36
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33919500957C2C5DE0F8A84AF8749@MN2PR12MB3391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6Y8I7OIGNBWcJ9wrDxB80Wy3I4kdGpvX84/H5+6Bd+qRwC5eH0Z5DLqOJ8mQ06zLqfb5SzYVyc0Xi0B27d8iHy9FsFSTHRWJUqQO4KoXspkE5o/TIX6x02rJKgP+h2VqrOOGAvhTCn0bIdGkerVPetLUR3yDSALMapNexQD1w1KoZFBBlqqBEdaQnN1Dh/w/Aks6fjPt1ElE0lXMAqyl+wCpgyKn8HCcB6RJbpuqME3DVFJP9FLml8xoHdfW0gXB6d3RCJU2w6Q05YUHutXffEQu00cDtkeqYjMG8ci5yEiO0sabI+X1YDcznPzsP5gAwhKuPQIgWaP50PSjv2lN40KQhIl1sArRiiWt51lTQ29mwyRMZKnaUlOFdN1UgXlCz8q8gpFRsZtK3uCkAvO02uDLm1ssEqJ1JONKCfQg2zc1zR2m65NXKtBm6JcOGaIkZ+SjHOmqk630Et2aeX5x0xDSZQam0TISe4eGemxT9XPfg+rjieMyHJi04TCvr/wmbxfZBBoOlAHuT0DCs1h8qXTUOdaVXlo0IwGufs0HedBSsz69DAvtM5TeOrn2P8B9nTU2nhNhsukqlEaphRcedbN/DuiiQG6CIPxsxOZ9UBRqn7EEtZoRT6ichDoijg55y27F99ss1xCqSwEGStNsb//kqjW39glN1pm5l96nhqonsi/q93z/yIeQC68DDjz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(8676002)(2616005)(8936002)(7696005)(70586007)(70206006)(1076003)(81166007)(36756003)(6666004)(26005)(356005)(83380400001)(186003)(47076005)(426003)(2906002)(6916009)(478600001)(82310400003)(336012)(36860700001)(316002)(4326008)(82740400003)(5660300002)(54906003)(86362001)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:32:47.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b30ff4d-f63c-4e76-7769-08d8fa4fbe36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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
Cc: jane.jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: pengzhou <PengJu.Zhou@amd.com>

In SRIOV environment, KMD should access MMHUB registers
with RLCG if MMHUB indirect access bit enabled.

Change MMHUB register access from MMIO to RLCG.

Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 12 ++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 39 +++++++++++++------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2bfd620576f2..42818c40d08c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -38,6 +38,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
+#include "gc/gc_10_1_0_offset.h"
 
 #include "nbio_v2_3.h"
 
@@ -253,7 +254,10 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+	if (vmhub == AMDGPU_MMHUB_0)
+		WREG32_RLC_NO_KIQ((hub->vm_inv_eng0_req + eng), inv_req);
+	else
+		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -280,8 +284,10 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0);
+		if (vmhub == AMDGPU_MMHUB_0)
+			WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
+		else
+			WREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng, 0);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index da7edd1ed6b2..e8ecdf383192 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -29,6 +29,7 @@
 #include "mmhub/mmhub_2_0_0_default.h"
 #include "navi10_enum.h"
 
+#include "gc/gc_10_1_0_offset.h"
 #include "soc15_common.h"
 
 #define mmMM_ATC_L2_MISC_CG_Sienna_Cichlid                      0x064d
@@ -165,11 +166,11 @@ static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
-	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+	WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
 			    lower_32_bits(page_table_base));
 
-	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+	WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 			    hub->ctx_addr_distance * vmid,
 			    upper_32_bits(page_table_base));
 }
@@ -180,14 +181,14 @@ static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 
 	mmhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 		     (u32)(adev->gmc.gart_start >> 44));
 
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 		     (u32)(adev->gmc.gart_end >> 44));
 }
 
@@ -197,9 +198,9 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* Program the AGP BAR */
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* Program the system aperture low logical page number. */
@@ -304,12 +305,12 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
-	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_CNTL);
+	tmp = RREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
 	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
+	WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
 }
 
 static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
@@ -371,16 +372,16 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
 				    i * hub->ctx_addr_distance, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
 				    i * hub->ctx_addr_distance,
 				    lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
@@ -392,9 +393,9 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
 				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
@@ -423,7 +424,7 @@ static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 
 	/* Disable all tables */
 	for (i = 0; i < AMDGPU_NUM_VMID; i++)
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
