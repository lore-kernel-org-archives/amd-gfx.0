Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC767C43600
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6A361440
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6A361440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0656EDA8;
	Thu, 29 Apr 2021 08:14:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7525B6EDA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+VLX3HFj9c2h046O2ed9D7l9di9SLUStshuowBNJtu+Y0kcwVWJD2ekTfcOcnQA1PuPue1XhHO7PKsQHCxlyPR6l9drxlzApcpHBfOAptzGsUcnzT2u5XpVQxt5TnSonyNx/g7Kfw5DmjcpGNBAjCG+5KcUH9U0W/BbkL+U7eGkkeWUCPwKMhp29TyJnmSR1fw0HDfm5CRqwT7a7mZeJg2SflVQyikl3LMIGcRUJ1xOO8pgoAjt2LN6cyNuUenw6A1AySA1lndlynZ8xQ93EZXETLVypnWJrzXKoWhPQgErF1Kx5ud0zVN/ZhcUTZeJOBW0kKgj5YwTxnsuUvOGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X21GpuVXE+Mbp0xn6lakvjrrELLmyCUhk2wajP/bRx4=;
 b=S14cKT4g2/AjFLnw6EtIZSpJ+6twULXqGpYTta1j5ChO8XPPNYDFTrFzjoPwzLNBszU7c+MxiGUKOY6NrnfJDtAPgABzD7kbodStLvAcjU07+aHofRNaTmZphB3Cvxu2CW+fEdzP4ojZerhyDLHyYSedsXg7/41DISQcfsVkoo7Nskf+PcJ6hHesujlzBkHPE1eb1+6pDGekU8u/RI7NqZMNKGRiw1GMKEvI0sSCLiJL04HUwIGSrWHc58yn4ajJQ+bzCX2i78fwJ7m+K/g266S03M4PtHZStIk3DyIegxMWRNFN1uakFfM1V5NMzuMzKmF35RBQ8mBr2irtFz+dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X21GpuVXE+Mbp0xn6lakvjrrELLmyCUhk2wajP/bRx4=;
 b=MJZ9/HaUjLdkTPD1b24ov0uCpilMNBVTbJmwwn13xe3KDH/cBddysI7+0fZEwScp0ngzb9jSFjaJtfJa00G9JEDNwSarNphVoOStdZYQsInikLQHEMm2j4svKv27NmbpWHh5UKLfrV7iKX7YYh7J9rPni8D4oQMXQ6Nw8w1k3ow=
Received: from DS7PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:3bb::7) by
 SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 08:14:16 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::fa) by DS7PR03CA0062.outlook.office365.com
 (2603:10b6:5:3bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 08:14:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:15 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:14 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Date: Thu, 29 Apr 2021 16:13:42 +0800
Message-ID: <20210429081345.24217-9-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ea51bf-4ce9-44cd-c750-08d90ae6c809
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5501:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB55013C62DD79176C9B8E1DBCF85F9@SJ0PR12MB5501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OToMfMX//Dam25e5plaWxguKWj2N2nk1/w1qDKN9nOZ1myz+EPFuvcyXw4CrZz947nFbcERGP+rpDQm72E4N1lFD2eLNQpCvLrdddRs0HiEyxvh/JynJDmYwtY11MEUF1+ljBZCUZoTh5Rzto0T1rZxDCKOViU/grOruWm4tIBohyUdX1Uyu9pR2p88kujlsPXnCw0bZbOpI2oISYysjvfqO2SzRIGGzSymhLzwB4e88UYz1YNjoLSBBCYO74tuMDbBAOUiErVFi1CQ6hfmAZN7/XJNtRY0qAz8lxFA+49Bx+E7ZOvBMXu6kftwGuk96BFmGhFhu4006h8v8qSMQCZoiMlhMGmmGjPTpyvWAG6Dfyuyp+kXYRS5nBRsl5x3eRYJ0Mb/hAspQwUfUL9OKRlrSHeEl0N67vkgQ/0PjSmMSLifQCKVFMzY9DB7lIgRQ4qUSY0yi2uQMOdahEd1drWtd6w42FVSE2MEzIelOzhWjqsF+waI2GomTJSAvnLfo70kMaG3V5tDjjKFeHosP9GSwjVUONj+XXhlsW1H6DRB5fpZWVp9MGWJPdUUp3dVqZjvCzooTpyMb5bbcAq4/DeE/kp5c6IF0aMHWl6nygV7eTIIAM1VF0symLs1F56LQh59OtS9EEr9xeLZlnXLoq7AtkqFweJjekIcqf65r4G2ZwnsJOpX+l32c2wa2jd1D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(82740400003)(26005)(82310400003)(8676002)(47076005)(54906003)(70586007)(1076003)(5660300002)(36860700001)(86362001)(6666004)(2906002)(4326008)(6916009)(478600001)(356005)(8936002)(70206006)(2616005)(336012)(36756003)(81166007)(7696005)(316002)(83380400001)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:16.3546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ea51bf-4ce9-44cd-c750-08d90ae6c809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: Victor <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use psp to program IH_RB_CNTL* if indirect access
for ih enabled in SRIOV environment.

Signed-off-by: Victor <Victor.Zhao@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f4e4040bbd25..2e69cf8db072 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (enable) {
 		ih->enabled = true;
@@ -261,7 +268,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	}
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 04c97c74455f..8c3882b25b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -738,8 +738,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
