Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763CC61164
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763CC61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1588B6EA6F;
	Thu,  8 Apr 2021 10:22:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91366EA75
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqmLiSpqphNsPM5N3ZtV3cqmFS5cKgVuXpgfucAD9L2GJidBHqt7zaZdvx0v0MBer2cpFMM9FJj24zUdsF3mi7jGZ0SnD88FkW+OvSYOGKVMC9Q1ws9j/qQ+G937LvyjOFInZD/HFpYOf+drrwLoCrft73NII2kf3kfOKPUsmRXt/lctOJ6ZWb6hQjbLZopk8RPJ2CgQZU7WgZtledZafxThYnVU9JPolARdWh0Qaipekok6lepmxHsJgblxsz38dLa+sSAmCFibuBYsod6Fi6ptwvFNovNYp3Fv1MxaDa5nygo3M+OJAzyVjivlo0FkrnHupCTCOjblyDlVZS8qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QPJZZSjF2T3Q0i5JAhhdoBHnCk6eN7xmTXhD0l9FE4=;
 b=XlxaW9GR8d8TJkQj/8rKhHeKrO5JEDslu0x46Nqxn10wyHupuMjESlmL1puV7wnjAJxKM9ZTeTDXIbd8AxXn0QhhnYWgsFM4jEHCD3FEh2KhYz4KYyTZ8C5lQXXFWGMOOYRrkCWS46H6KesDWDMNUak00vCfLnag7pTMvFfRzk1pKk60d8ODKZ559bGHi1TJotZGHTuJWYlqfpPOFYceZynCJz/TfexF6/28JXv7YawXWklw2E2uAP/XYn5WUBg4izY6Auk4XsQJYFJ6REaMDe3YGGRzjiwcl2toGEG+K9E7pY/ugSyKCn53t9QmXuZRGe1RBkp8050WZ5kLLmsyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QPJZZSjF2T3Q0i5JAhhdoBHnCk6eN7xmTXhD0l9FE4=;
 b=4eaZP7F9NL8uuncTE2XyVe/qIY/TMyUJPeLp65R9bDHr/alG7RWUbVHPXYdQQpJn/PjbGimYkhxlGmdpl3Uh/O4acSQoylCl+/hmNordcVozfVorrka9DxnUCI8CPFLNBfDWO3uucIIt0frDH9Vt7ywsGoKzTMSk+kVoE83JaDA=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by BN6PR12MB1828.namprd12.prod.outlook.com (2603:10b6:404:108::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 10:22:20 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::f0) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:20 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:19 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Change GC(GFXHUB) register access from MMIO
 to RLCG
Date: Thu, 8 Apr 2021 18:22:03 +0800
Message-ID: <20210408102205.911-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8c4064-b960-41eb-1a13-08d8fa783194
X-MS-TrafficTypeDiagnostic: BN6PR12MB1828:
X-Microsoft-Antispam-PRVS: <BN6PR12MB182843E0B79C377F7D75A4C5F8749@BN6PR12MB1828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8sWuuqTtAcNObnXFeCimraDQiX4WTHrcDmmybP0h3sglKyPZnTDkUuogtyAWlXb9hHGGUVhoMVBtkVJSyRJmOnArXKiqjU3A+ORoKLNwtfoOoNgsioRJ6fR/caRFmJa0DrhW+rIWBCXaxBOMnQxdQGC077lTNpRJOQtPnRzjDXdN6eRw4kYlVMc3nxq5MWZkkn0RDSso0EgbNRnj0UIRabKB+Nye8AOSXxUqdQlGifZU/6eZdOIGKMREbUj+2hftj/yatj6apePe2Vzc2fj0vIwENwmEg9a8aHT9sFjM2bUqKSGqxpuH3v7dyNUcbJs3hrOqkLtHJLuJQf6TgXVM3mYwpmPrvmWNTeVVya9MMUY08ODiAy0pNXjaKCnreYBOca7aHWZf9jEBAlk9tfndmFbQlEDSm5xSdh3JRWkf3EV1Lmd5I7+8yQdugjmSX94Rs8ZGNKhfJZzXhAGkZL4msgpt3TQ2WNZC+dzjCgjHqQ3eAsJyUT5t4r56CtUdR7Ns3h6G55C9a6Hlz5uQZHaS5gXddeskglhA4jAJCZ+RVwGxVioxuneBQDmBFlCV5jOjgmvxpthF5hE7Yh0u+lMXaL2e1M7QwAiL9ZXiH9dXwUFWI2GGBPnvSbII2dg7G75Rpg6gXRl6iNdfEuTLcUyOv1hwowC+tSnYIcW1t2NN0hy6jjkyhrLAZ8f30HaU6B+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(36840700001)(356005)(81166007)(47076005)(83380400001)(186003)(70586007)(1076003)(8676002)(86362001)(8936002)(6666004)(2906002)(336012)(6916009)(478600001)(82740400003)(426003)(82310400003)(7696005)(2616005)(36860700001)(316002)(36756003)(26005)(70206006)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:20.7294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8c4064-b960-41eb-1a13-08d8fa783194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index a96be9acb9b4..f71644f25df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -174,12 +174,12 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Program "protection fault". */
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
 		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
+	WREG32_FIELD15_RLC(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
 		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 }
 
@@ -213,7 +213,7 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Setup L2 cache */
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
@@ -224,12 +224,12 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL, tmp);
 
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL2);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL2, tmp);
 
 	tmp = mmGCVM_L2_CNTL3_DEFAULT;
 	if (adev->gmc.translate_further) {
@@ -241,16 +241,16 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 	}
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL3, tmp);
 
 	tmp = mmGCVM_L2_CNTL4_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL4, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL4, tmp);
 
 	tmp = mmGCVM_L2_CNTL5_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL5, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CNTL5, tmp);
 }
 
 static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
@@ -267,18 +267,18 @@ static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 		     0xFFFFFFFF);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
 		     0x0000000F);
 
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
 		     0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
 		     0);
 
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
 
 }
 
@@ -393,7 +393,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 					  bool value)
 {
 	u32 tmp;
-	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
@@ -423,7 +423,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 				CRASH_ON_RETRY_FAULT, 1);
 	}
-	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
 static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
