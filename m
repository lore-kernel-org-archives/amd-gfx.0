Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10D7C10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806D82078A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jf3QzZFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806D82078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA2D6E550;
	Tue, 24 Mar 2020 21:58:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38BB6E550
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 21:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf2QUJMLDJNR/qVAZ7CCa9NVRIgrLva3uUfE8Iq3wZGpBJ1zCfZk26X+OmrkRpdC4SrmOuYdkzBs8alYRFI9hnL1sR6A3GuBBSmlHi6uFJs5L2e2fp+O9HEItwupLu57EiNSuAH534Kbnll1oLzfvN5W9vBo0fbbjuHMRC50gmwGtTqMtvYINaniIsYWen1dgtwJXm5aUWVyObpEF2H0snyu+DKqyxeCzRXRTjnblRiGd2biDktOahYYMLdz+2WPhTG06cxiwyYr0/WniIOpwdJQBQiMT+dZ6GwOHzI8W2oNobEa3J4XrOKXezkvf9xgZS0Xf/9xDvJW1fZGrLZ7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHfItaMVD/zBSQPNYCQTN8y9XbygtMkgdomqKErKBuY=;
 b=O2bKfZvGT4pQ4TyUiaZDlsCoxuw096ZVeGSbiY0b54GKmr4itQQt/VUVH+57MRkZNwSxbD1nSvvZbDwbVNlhGKUngOpSf2tG6YCC9saqTHhDjfACnam/+zCdaixIjBec9635o5zGxWQpIb9uNcYyN+6PcwNk0AFOtb2SGVe7aFjpjlpDaka9/IdWGV85DY/+eXplc3dt24EM91TgiHchysZjZnYw0I/shp3B4iPK6Kcv4NR+NPwz9qFptvpU4stBJwkd96auRVh+OQqdaxdJfuFYBUkzJbUE4ZzFICxEYGfLmXtyIDXkJYWj8xKqH0/aZZOT/95cHss9OoEyKTDjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHfItaMVD/zBSQPNYCQTN8y9XbygtMkgdomqKErKBuY=;
 b=Jf3QzZFURHbmm1WSo+2Txs21bCZOndtHaBM1/DGtQv3Sb95Vm5aF5FCp18ofT8dY+RtoZNwjtuZ6PURsYh7lWIOQ7fk4H9v83xr+wUGhSnJAA12ortJDavErD6uTSOCRHmV8OgrENsseA0Q66bjBNsjYHWwGjhXo6oLZj2Pbq74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 21:58:07 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 21:58:07 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: call psp to program ih cntl in SR-IOV for Navi
Date: Tue, 24 Mar 2020 16:57:47 -0500
Message-Id: <20200324215749.29169-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324215749.29169-1-alex.sierra@amd.com>
References: <20200324215749.29169-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 21:58:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11130e30-2a4e-402d-f400-08d7d03e6f13
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:|SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4383B393D1E2A6A501D8BBB1FDF10@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(8676002)(16526019)(52116002)(186003)(81156014)(86362001)(66556008)(26005)(7696005)(316002)(8936002)(66476007)(81166006)(66946007)(44832011)(6486002)(478600001)(2906002)(956004)(36756003)(6916009)(5660300002)(4326008)(2616005)(6666004)(1076003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4383;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GuAs+7VpbMG+npNcZEoltD8fxJnL2cMUc44bcIx2Y2UxZmnUxltn18K5daeIAQz/hETwJ6eDxUaAnT/IjgR9l4MwMC8b47XUa95zg8y0FYKNYda6BzL6Ty2fGZ1XgWBs4mGp8yUSbdA5oo3WidDBEvcA0WG6Ddw5xRqEt3u4eG+DbA7zrg9nQ7+ZBx/TVsqndP64oYKqXlra4gXPWARQ5Nik7siaufdl3Q7lTEphsJ2Quu/MC5nbeqC/H3Y+9YZxVVroHgCIQrdDoOTiejWzlp74X/X2WEDoLo+M98m5lcW5dcW4zHOOgh9TBWYSWO3JUg/xSl/fN4eOmdw/mSC5ftdUeRHzcd5ACO/LTguhfZOXljXGmZ7IMzuCMBGo6PJYvz9nisGTd/JQ1zryLjm1/4H2RM0rPV+q1BbtNtqR/Ox9PRkPXN6iw68a/p+wZ8zVULRBH4mQu+6TDJ1OPP1MXNB4lY5/tJyfr/tnlKAC18=
X-MS-Exchange-AntiSpam-MessageData: 8sj4WBf/lafrgb5w8mKKRFbOlYbpn2/Zh9mThgsMRVG+B31WGm8xXNwrgZk+nglJyvpMHOS6wTgmsxxcILuMg2hBYVzQKZKgD7memUOGAYQMLoPOquWMCJLAtOpUk3fDOMktZ40Z6EV+HWHsY3X0FQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11130e30-2a4e-402d-f400-08d7d03e6f13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 21:58:06.8921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQmc9cx8bQ1kpJ1xYmepY590tYi4O2Mu5CU4CLHr+7+boaORpZoSgfuLEDfmBIiHk7SndQ5NpEqRQWfTjOPQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

call psp to program ih cntl in SR-IOV if supported on Navi and Arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 90 +++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 0c0ba572d7a3..4ce42635787a 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -49,14 +49,30 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
+
 	adev->irq.ih.enabled = true;
 
 	if (adev->irq.ih1.ring_size) {
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
 		adev->irq.ih1.enabled = true;
 	}
 
@@ -64,7 +80,15 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
 		adev->irq.ih2.enabled = true;
 	}
 }
@@ -82,7 +106,15 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
+
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
@@ -93,7 +125,15 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
@@ -105,7 +145,15 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
@@ -187,6 +235,14 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih->use_bus_addr) {
@@ -197,8 +253,6 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-
 	/* set the writeback address whether it's enabled or not */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
 		     lower_32_bits(ih->wptr_addr));
@@ -227,7 +281,15 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   RB_FULL_DRAIN_ENABLE, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return -ETIMEDOUT;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
@@ -245,7 +307,15 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return -ETIMEDOUT;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
