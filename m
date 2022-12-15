Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069A7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D969210E581;
	Thu, 15 Dec 2022 22:11:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBF810E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl4cIjqliNKEgifjHlWS+OQ5O2SZpH3+OZ6OBkzsOw+bkZEGV7yyid/xqvB4GW5KBi4Su6pVpSDtvHd9hcLVz+qKe2xEiQM9R++j+cvSE8ycMpoUFuHFDUccZh6oSBT/0UV3gpt12KUQodma2/4ICRnSORqLqgUP3faQoc4yXf3oKJhvbvTX6LWRqJU+zb/y+5Izabgq8yd7JtUWFv5E9AYxRiwfcdvmT72ZqpyqmH3PgMgcAoU/sel2boOKYmXS5ZoMR8bRYs/ZISqvhWOvIwtlDXDcNq2+fud3CqgJjykhCsUEAuifvIFZNtsSXgO9xGufNhsFNievOm13jNfiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AARJnFUFRdyTDsvOwG+2sDUBG+/wJDoZ96pYnDtnMBU=;
 b=IIHtbu4WHgIRbvaUU3BmjBibQ4bpDosXFBcrMXs5oGkPM7XJchdMYT3IANSOM2NAimyUOoCKIMNM2R3sGvFhVFK9ODzh1/sGulWP7JaQDnbqPRiVD2d1+oKv2dSrhzNXo0FYfyGN+uC+qgKw/AMiMtqwMjiAzDaLUodshVdT7uMeJSwcb3hBklkP5vmQWizyAMnyYKtXEiTDiS0LbY2CGAX+O3Bcs9ThecxfyoIl96wP56WIngSmphDhLaYS7Ya/DRN30VSHI4Cu40ublLUxNIUL9TPujx3Mdm0qxJbw4+oNfOv5pt1h6v/nlWYnJLvtJCJGGADTAWigDP9M5XM/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AARJnFUFRdyTDsvOwG+2sDUBG+/wJDoZ96pYnDtnMBU=;
 b=WfnzQHv+jGbHzx/+zpOE2IZ8JttQzTyhmP88SbG2R9pwiVy95qchkbbfx2wVCKVMgQcZoEW+hGs/Rxz7Us0eAtuZ+0FT4RyMhi2EkmdUIcCVzoSAPprYQHD5s7xQ7Gj/OIeJLV/lio71aCfBIDHWb600DjVXHgsGi59W1v/gnTE=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 22:11:15 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::55) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Thu, 15 Dec 2022 22:11:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/gmc9: don't touch gfxhub registers during S0ix
Date: Thu, 15 Dec 2022 17:10:53 -0500
Message-ID: <20221215221059.509565-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: b58c444d-8420-493d-5af0-08dadee94851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KVY5BgIobb92Cy9+/2PNCW4XaMBK148ZbgYhQg38cRyaf3Yvqp1ZxZh1qPCrsx1SNXnziWNTZjFxiRTN6Yq9Lvuk53RsqhmEjM21zPbkufbWtp6MtUNJC3Sgdc5ZwhvUxvkYklToZSEyzqddWUmvAzex8XeUT4VNQFLVs8AyYZL8XEwOWxNx5rKnPGbglKH3d1LRdOUcbnXarXLY1oejXCBqG+xBGJxhwmD33YVvfsr+xXNPENqGMMXM+L1/SkMqD98iz7/EHu4lnDQigmudqq5x/jjfapypSQ0uMMkz1VDcSGarMQ+eDVUwx4+Ix/eFXUAnOeH0BQKbRk//BpRDOKQmnpg5uYHjZktdWEcMzmQrSmipzkhdoSx3zxaFdNvNaySSUzd/epWHillyNz7urllmMpKmvjTH0Ad00X/bZNYi15hu/Ja6NUMY6XdKsuo7+PTndZvLFQD9m5R/i+Hjz+/qjxN1flUBs34U2ag/1zvygNhvu2ww8i8GTB7Or0RH+KO3JBhDzDHXMFV2ryOE1mJky+ZCTqw3lSBhj2DhcmrhHGLdzDfvgQDj5M2ktvE/DqWLsR2WFZKLJuEKofFLXZSc7C3s61CjDsiK1ZieqG/Gz3Gn5K4OQZ8zCBK7EG7DAmYWgHQJdmpUDxd0fU5gV4/1673gAYEXf1Izm9DXeD1slDIC/Ee1h9kCMF3+d6YzixuRB9mbpEZmRbyewxhA7R3IHWXeW3Ijp1y9dWWS6mUS/hTBFQno6akf7p6F1Zl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(316002)(86362001)(40460700003)(6916009)(6666004)(356005)(478600001)(2906002)(5660300002)(8676002)(4326008)(70206006)(41300700001)(70586007)(36860700001)(8936002)(81166007)(26005)(7696005)(16526019)(2616005)(82310400005)(1076003)(186003)(82740400003)(47076005)(336012)(426003)(83380400001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:14.7758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58c444d-8420-493d-5af0-08dadee94851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

gfxhub registers are part of gfx IP and should not need to be
changed.  Doing so without disabling gfxoff can hang the gfx IP.

v2: add comments explaining why we can skip the interrupt
    control for S0i3

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 36 ++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08d6cf79fb15..8f7fa468decb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -484,6 +484,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
 
+				/* This works because this interrupt is only
+				 * enabled at init/resume and disabled in
+				 * fini/suspend, so the overall state doesn't
+				 * change over the course of suspend/resume.
+				 */
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+					continue;
+
 				if (j == AMDGPU_GFXHUB_0)
 					tmp = RREG32_SOC15_IP(GC, reg);
 				else
@@ -504,6 +512,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 			for (i = 0; i < 16; i++) {
 				reg = hub->vm_context0_cntl + i;
 
+				/* This works because this interrupt is only
+				 * enabled at init/resume and disabled in
+				 * fini/suspend, so the overall state doesn't
+				 * change over the course of suspend/resume.
+				 */
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+					continue;
+
 				if (j == AMDGPU_GFXHUB_0)
 					tmp = RREG32_SOC15_IP(GC, reg);
 				else
@@ -1862,9 +1878,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	}
 
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
-	r = adev->gfxhub.funcs->gart_enable(adev);
-	if (r)
-		return r;
+
+	if (!adev->in_s0ix) {
+		r = adev->gfxhub.funcs->gart_enable(adev);
+		if (r)
+			return r;
+	}
 
 	r = adev->mmhub.funcs->gart_enable(adev);
 	if (r)
@@ -1911,11 +1930,15 @@ static int gmc_v9_0_hw_init(void *handle)
 		value = true;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
+		if (!adev->in_s0ix)
+			adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 		adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	}
-	for (i = 0; i < adev->num_vmhubs; ++i)
+	for (i = 0; i < adev->num_vmhubs; ++i) {
+		if (adev->in_s0ix && (i == AMDGPU_GFXHUB_0))
+			continue;
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
+	}
 
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
@@ -1939,7 +1962,8 @@ static int gmc_v9_0_hw_init(void *handle)
  */
 static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
-	adev->gfxhub.funcs->gart_disable(adev);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
 }
 
-- 
2.38.1

