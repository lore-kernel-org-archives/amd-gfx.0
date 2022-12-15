Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B48C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AD110E586;
	Thu, 15 Dec 2022 22:11:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA0F10E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBwgaUXeV5cNbVIoArZI5p20C21+Yiu86VPkoLXyd6ID+ui8/f6l49svOLQkgDANeaTlF68AuralWPUgNlvwMUbSSEbnakK82R9rxSfcri3h8lv9zCgt2pIWFWIjX69ZrjzQSIifHbr7AMlDo3SPk10vI0NiYKdzUeOhIt4B6sIarCAQ8oygxVHraK/BCL6NoV53Ii8J/oUdtqBCY+kVUqsAihXdo0UVaJxQE2kfK/p2ZQVdrjhRNsczT0ryzuXeRHY4SQLDRd8qV5n+wSVhxaFsh/BnYmC3+kOLcDSDFsz1WpwVe/QRsceQJ38QvMZV3bcUNUzPm6TPECxGzSRDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=768tNi0F83SlDDpfYG5Pqjc0QlfFMtKkqEeIaHgZlsY=;
 b=gHSC1/NPWtDvDACcaTypdqr81vqRTRLhYHhn6nhSNlh8NiGuSa4bliqN2SjVA+tzPsadZ8UWWDUhStJlM13heGGb8TVn2l8hDwWnaHKQLUS/7RcilyxAEX4TtYbhvgwxO5b7d5EzkqfhWZnhRznJzk5ZNKoovGzIHExxiENlCLPC0J5p2o6Yndq62HIb8QYzzHWL0U0OpyfXDnhwH5l+VAKxXR750bJKkf2WthqirBsQcQVcAPu1aVdQv9OT4fPrSxILR0K3+SfSZtbIl+CwkOB7w/NUta4dhXMIOtzmvCppaaxAW8uVW39A01SzMa/wOeGRl+1/BgzOYY/fKvRklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=768tNi0F83SlDDpfYG5Pqjc0QlfFMtKkqEeIaHgZlsY=;
 b=qLOgJazTPR240YKBMhTmohmUpH4mO8ny9IYNqJ+BU0McAx67AV0hOiWTGdOjdHehlxdnReqAmFxEpF5PKeLiyN64AHdGe6OhC9bJFroSpCl19It/ZPobSLl5uhsQEaPl5emInA+Np/2Nka13v1GNjZujExk3bSBxSndXv9s/EWE=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 22:11:15 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::3f) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Thu, 15 Dec 2022 22:11:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu/gmc10: don't touch gfxhub registers during S0ix
Date: Thu, 15 Dec 2022 17:10:54 -0500
Message-ID: <20221215221059.509565-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 089e76ff-97a8-4630-6b29-08dadee948a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTvLOFSt//rEYWd679pGfMc/D3oID+Gc+ISSlX8iIkOAA8vC3RATsoMzb2II73uqT0hXsDLoK5z6SrsP+L0+DWn1j+sKXVCUC0ugcWG3366sbDC1774a5EMN1H1IoWBDvDazDr5RBxLorTEEM5x5AYf9MPP/svQe/vZvlEyo1dz1/8Kd+1+9SfxPMCm7aG1gvuIq8TK9grmNqfb4kXFbVf4CRktvIlRAlyao6CqsUrJn+aTW8CbHPBK3SlZb2QmVgIQnL8g5UGFIR/uibQB7j/GyQVg2ZkfZHZbr7GQ2wPQhhgvAMjZMGJYhZiHSi35ILZOA5IO4ISUKcbhS1pVy4J7YVILtXzM8JG76HIxDcJZ0OoyyW7JrIHpK0GDiXUk3fghJ+jy2qQUXZJLGJ92UOZP+GMv/l12yKx3rEqB/e/l0Nqj1yyWH0HjhDhwdQehULV7TT0fisLLM76YTV6n6vlL5ePDur/ZspKnLf8WPFNiQ0QYRn+iAB7e1gCI1JwVcyahP1ZoIKo0utFw5pMwB4ZPtMlrDVgB3Lz3yK3RMWEDdJdxs8lDgCW7H+1H6qD4+1tIO3lX2uXGdXGvfAb5j36FOW8+KK4Yu2I+YgZ1nzcVRCZ4WTaTUoQF6y6HLwvbt/R49IouVapq5OQ+q/6ohodD4uxbbBMiUWmAPDNd50uqTU2GxVXRC0hIXdlLYaqrjtmoCC6tcOKOZykN523bCoZVnxnlQmbCC2RxfGfptEFWCNRS4HV7qHRRTDy/2V51V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(8936002)(83380400001)(356005)(81166007)(70206006)(8676002)(4326008)(70586007)(6916009)(41300700001)(36756003)(316002)(86362001)(26005)(82310400005)(186003)(1076003)(478600001)(40460700003)(7696005)(6666004)(2616005)(40480700001)(16526019)(82740400003)(336012)(47076005)(426003)(36860700001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:15.3227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089e76ff-97a8-4630-6b29-08dadee948a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 36 +++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 21e46817d82d..808488831dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -78,13 +78,25 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
 		break;
 	default:
 		break;
@@ -1061,9 +1073,12 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
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
@@ -1077,10 +1092,12 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
-	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
+	if (!adev->in_s0ix)
+		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
@@ -1101,7 +1118,7 @@ static int gmc_v10_0_hw_init(void *handle)
 	 * harvestable groups in gc_utcl2 need to be programmed before any GFX block
 	 * register setup within GMC, or else system hang when harvesting SA.
 	 */
-	if (adev->gfxhub.funcs && adev->gfxhub.funcs->utcl2_harvest)
+	if (!adev->in_s0ix && adev->gfxhub.funcs && adev->gfxhub.funcs->utcl2_harvest)
 		adev->gfxhub.funcs->utcl2_harvest(adev);
 
 	r = gmc_v10_0_gart_enable(adev);
@@ -1129,7 +1146,8 @@ static int gmc_v10_0_hw_init(void *handle)
  */
 static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
-	adev->gfxhub.funcs->gart_disable(adev);
+	if (!adev->in_s0ix)
+		adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
 }
 
-- 
2.38.1

