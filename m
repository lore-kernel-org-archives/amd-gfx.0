Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251F3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 18:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16DB10EBEA;
	Thu, 10 Mar 2022 18:06:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAA510EBE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 18:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrFr65REXuOZSfRro5oWhU3AO1Ng6ZjK2R5T9lkjCFRX9vs6KK2q8lHdeQgap8peA8sjI0uWV3Eo2+Ahd5ozc2J4oay19tTN0rK9ZmAt3CnnUArcZIjQ6MNML7HgUMBzIprLqNBtAZXx6bo0qIG12W4w3pfszDEGjpN5uIhQUEfBYDBlazZQsZyPQLdPswxeXxDRx/Vs75P5iXFYTAVaGlY4nkpVI6DzzE02M01wscobxJgFpM5Qu2jN730cYYpOT+MTAJ1JafeR9UiBR0XKUkSZPiJleR7N0dNUbRs0W2cqWr4it5kV5rR6UX/rwYKpNfDbbniB6cZ/9JRe6D2AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVVtgbyMsWBmxB8IvzkADnRV2JAyS6w7G/Cnl0Rj9h8=;
 b=oOvOX1oqwK56myp1nYZuQ/X1xHZwB3t+wQ5sxbiH/K8QzsYsSk3HKbZRzKATLJCXIEmUoDCowUfTXbdMq/ejyrzRoe+qQoSPxOd8eQl4R0aCB+Io2uK51mpEvVTJkauQXlIaOAd48etDFQ2FEE6rU4ixAmL6Wcri6Roh5TS/WbZV1is2svKP4a0sKhC/j47Xyo6f9s8C3jUuiAbLtOn8gFp9Y+hngjPAKcM69QNMKYSUZevOe3ZXafEfv22Gp36VBbsdDtGtZbpXZGMpf1Z+emacjjUybMbA3RjyYaZ0Ipkg5iA8qt1u+a1zVorRyDNOAkofrrZcamXf26NfB2NSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVVtgbyMsWBmxB8IvzkADnRV2JAyS6w7G/Cnl0Rj9h8=;
 b=ToypudjG4yIIbr7C0ql1Wh/rcW7R39P5eaNojJUmvm7FRiKioz6dJ31vV04NQimE1BzG46DYmxlZaZzECKabS5Myp7hDrFoe3B/jPZVYIREWWlnLm3hd+y/sUWXGaoVYBTg6TpV0AXJOw46NkDmDiJaR4sypJMESD0BXRpREsOs=
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 18:06:30 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::43) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 10 Mar 2022 18:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 18:06:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 12:06:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Date: Thu, 10 Mar 2022 13:06:15 -0500
Message-ID: <20220310180615.2245997-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 041c2a58-6d33-4ab6-84df-08da02c0b3f9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55375B8A9AEA198E17F6590BF70B9@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFoVTXULwvIZXaZydRF+qNW4yRbNHjDl0VvM6D8U31/ddxC3Knm/ztqOL+aFubaVCDR6NFWzhKO3h3lFJDsgwlmmvnn8EBDSQsIQrVetAOHLlXZOlh53yXaXXyDipwjnD0r2c1aLaTZQTG2LBSD6xtkyqcrOpFXMFebHHMpmDw7mDyPvZHHRL+mdZCPkwz9nHfqgCgfU4dJufn6rTD5EVKYV2FsnCK/IHUHA5UV09Njst6L9tydHr5tYNL7WeYHPEbJ1FygavlovintR+mLpRGlQI8MKp5fHmmZ5i8Zr9cW66tNCWXF8GLH4Q1dc51vzUREz1l9UXYZETbm75fQgkASerVdL9aLRBcngiFz8k0T8mJlOR5IOMO6x8UCa2FnV9CQUfsAIdGUEJO2z0OP7ymyphOf/dvhtOuG07Oi/P9rixn74TXsDszJDY7t5vBJnKM9EhNCHyhZgvSgXgLRCdsEO5ximDz+F/z0Bzo6zRQ+0wT1P19gTqp4i1rt6Ihz4BinoaDbsBlwQ/9fansdTBmSJL/DVwdAmB97FjFT8/NNRi/2MhBSDYufHqD87pbsbDpFls+QPTo/I1kaR5aNNn69VSjL6JX872YXBcDITZ//Hyt/n6AkVmRlEbB/KaC331B/icg33BVz7V0reFv5n5lFupBV65t2Nm+DQs6XaAxkXPykO+adXEJ7DvBTNWulrjp8EeydnQau9h0pKZkbeIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(70586007)(81166007)(6666004)(356005)(1076003)(508600001)(6916009)(40460700003)(70206006)(8676002)(2616005)(7696005)(36756003)(5660300002)(83380400001)(186003)(16526019)(26005)(4326008)(86362001)(316002)(2906002)(8936002)(82310400004)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:06:30.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 041c2a58-6d33-4ab6-84df-08da02c0b3f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the GPU is passed through to a guest VM, use the PCI
BAR for CPU FB access rather than the physical address of
carve out.  The physical address is not valid in a guest.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f60b7bd4dbf5..9887a60e8eae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -814,7 +814,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU) {
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 344d819b4c1b..979da6f510e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -381,8 +381,9 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU &&
-	    adev->gmc.real_vram_size > adev->gmc.aper_size) {
+	if ((adev->flags & AMD_IS_APU) &&
+	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
+	    !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ca9841d5669f..1932a3e4af7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -581,7 +581,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU) {
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 431742eb7811..5fa613d41799 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1456,7 +1456,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	 */
 
 	/* check whether both host-gpu and gpu-gpu xgmi links exist */
-	if ((adev->flags & AMD_IS_APU) ||
+	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
 	    (adev->gmc.xgmi.supported &&
 	     adev->gmc.xgmi.connected_to_cpu)) {
 		adev->gmc.aper_base =
-- 
2.35.1

