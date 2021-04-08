Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4489C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D75F61130
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 05:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D75F61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373C489CC4;
	Thu,  8 Apr 2021 05:33:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE76E89CC4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 05:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM2pVipEpSbq28yDXuBkut47GWpjZwHoXmfa0salqgpu0Gzt3tX1e8aYB7kwgO1JuOpGpC2+UeCa36b6y1Xi3oZbtaL7xnFC3hdJhnBg+VPYozzLtr3zE4X+Wq5xcTQ6lv+XV35fY4ioGP8iStbHUk89C+noB7nrNvZEfdHK56qljQo8c/d4VC4lStdO+jG4QTKG5RR04yekZHYWz92pFAcc/rat9z2g5s0QMm0mkWK2cF3bhp5BnWGzjBdOkRySFUlw8lS/C45GPKrnPsj3k3P2E08Rtfzswex+6qaGek1B3tVjmTtOrEJxKA/DJ7FNXlftx3ajLHTLiEepO9ZudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzHqyqWkIqte1lWxuJNAScktqs0a0TTpFm3LTvkEfwQ=;
 b=EQNAozNz9WQ1zDReNks5p4H3EiVM4zivWFqMgWxNbni0RrUGjI62WNeaMMR6ktuJjKFPqqPYwmigNGisERSZhX9BSY6fHcRzJyovxipvRufCqnUO2oDiaztgN6lC8MbvioPiTuX1rDauzHXDO5rFCih5vA+D6Jb5Zf59oYGTzSfk+vvd6H/KRkQwHFF6qHsFCHKLQe4+U3PvFw1tfypDNQirgXpiBh8pOWMN+lrSUS8kJmvOm40wcEeqnya4RNMU3u1rZyx6dDIpSdckhkO9UEWxnLaayWb4rbiyjfLGK2IsLuPwpjjfe4k6ULZpBpHjyTQEcEP6WTvM24cHGzRayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzHqyqWkIqte1lWxuJNAScktqs0a0TTpFm3LTvkEfwQ=;
 b=QSrj5CW0kLDVeW1sDP6IJlyHuhZguCPElZnnk5xuNGr43H4I8YIIfc4jDAAxdxZ3DsLeH1aqa74EGTnRSKebrB96XJwVXlF+/Uy+30Wbch/F2Lv0BpulzFHzqInuaUfqnuuksMxjNnEP0VNKFkEzCs+2LKH1hNVRj0AyM1Xyvqo=
Received: from BN9PR03CA0842.namprd03.prod.outlook.com (2603:10b6:408:13d::7)
 by CY4PR1201MB2534.namprd12.prod.outlook.com (2603:10b6:903:da::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 05:33:14 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::5a) by BN9PR03CA0842.outlook.office365.com
 (2603:10b6:408:13d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 05:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 05:33:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 00:33:13 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 00:33:12 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: Change GC register access from MMIO to RLCG
Date: Thu, 8 Apr 2021 13:32:32 +0800
Message-ID: <20210408053236.30762-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408053236.30762-1-PengJu.Zhou@amd.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130f0ae5-d94c-4ad8-1160-08d8fa4fce85
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2534:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25342238BBD301CC595B8474F8749@CY4PR1201MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lCz1uCD+zvznoHFtu514mpcxeUEreLbBwat58qFnM9dFgtuR8My66OAEDt0UADM7M/e6RWWN0nBrZ66b/JlgAiMsAX0p1EmNwgGQNhQ4ok7U6JddHn+NQ/KX62fk0rH1kOMpHMcz2uamlFLAglzWh1RafR5RAr9vKxxjsEyLt1pC4U6a8UUCWheEEnfhSafV3Po5QEH7LjUJEH9OoGPPqdN9e0lcE/1JWYKsmijqvj1BxfK/yLDATuViKIRqZWGjrz7zD4OZ93auwqa7wjV5+dwj1r4osE5wKUmL0fYU376VYBUgQRqtCFMQh59aLZn6rpdp9RO/Oyatvh5TP0xf0jWMCuNz0YK46gFhY/h21EMtYmcr9XQkYNc3aORcmD1IKmomwNWp5k6GKlbL2+UeCWG4nEW49zZJ5R6cQrd/6u2vPpabqJs1aJzDm8iz0KXihod0A80RHai0iyQZIskJw8N7jtAfsvm8iV2MynsYx/dss+owcY6doFuJ4V7FkFoSlCyWek4Abqi4c4fWpTcpporfqYXwjiXOZ13knMaegn8NAgxwRiXoGjV6K7EDTZFSKn4PTn+YDDGwu+shfgL0oPw8NNLvflh4P5E58MwTeZH1+PLtbwsb94kSoGBPqs4ZsPl+UmenysrKK4BOyyZzYkI96JwZ4MHIcS72Ooh7lIlJue8OoObjipYJe+FmZU1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(70586007)(70206006)(8936002)(54906003)(82740400003)(336012)(2616005)(356005)(6666004)(426003)(4326008)(36860700001)(7696005)(6916009)(478600001)(86362001)(8676002)(26005)(83380400001)(2906002)(1076003)(186003)(82310400003)(47076005)(36756003)(5660300002)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 05:33:14.6663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f0ae5-d94c-4ad8-1160-08d8fa4fce85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2534
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

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 38 ++++++++++++------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 376c92b1f938..8a54d5f27671 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6811,7 +6811,7 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
-		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (!(RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1))
 				break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 2aecc6a243e8..30ff10953831 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -104,7 +104,7 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
 {
-	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
+	u64 base = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
 
 	base &= GCMC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
 	base <<= 24;
@@ -114,7 +114,7 @@ static u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
 
 static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
-	return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
+	return (u64)RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
 }
 
 static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
@@ -122,11 +122,11 @@ static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vm
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
-	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+	WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
 			    lower_32_bits(page_table_base));
 
-	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+	WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 			    hub->ctx_addr_distance * vmid,
 			    upper_32_bits(page_table_base));
 }
@@ -137,14 +137,14 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 
 	gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
 		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
 		     (u32)(adev->gmc.gart_start >> 44));
 
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
 		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
 		     (u32)(adev->gmc.gart_end >> 44));
 }
 
@@ -189,7 +189,7 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
 
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
@@ -201,7 +201,7 @@ static void gfxhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC); /* UC, uncached */
 
-	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
 static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
@@ -257,12 +257,12 @@ static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL, tmp);
 }
 
 static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
@@ -289,7 +289,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
@@ -314,7 +314,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
@@ -335,9 +335,9 @@ static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 				    i * hub->eng_addr_distance, 0xffffffff);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
 				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
@@ -366,15 +366,15 @@ static void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL,
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGCVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
 	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* Setup L2 cache */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
