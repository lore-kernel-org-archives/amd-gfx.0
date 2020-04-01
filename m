Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0A4C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941A62054F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="onjxkPiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941A62054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E9689D3E;
	Wed,  1 Apr 2020 21:01:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38266E9A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 21:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRem8IZ9VBTS9o9vOeEx5iyBS55ELznawA1ae/XaQWCR9IeAgk4tvstnL7pi81l20gpcOdRaGVMwlM1jJMgOUrjgAWaxtXrthGuJWHH89kGC3fV4Baxr61Hdvi0EhzprweP4EfSTU3oyu9kLEFhRnx3UAv7SFoHi5Qb7Jbz8cP0/iLabVw/HM5oLy29Zau1pTwMxgmIoNDJmYXXJXYgEznFmMew7Jf1c9oLgXmCSR/46FOxPfHYV3RkoIqSyo5tgUiktuCpBWFOOq3T/602uXYvywCuEvwEjLPzyaeds7Jd8t6ZTX2LXVI2gLR0JuRMhEdow8uUhzL2I+eUky83SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo7qVd/r6DIOFGet8uEpAHfQUdax8CD0/s1iKbjVSLg=;
 b=LhDabFIZqmGaSU/Xnd2WjgU0XsH3R9zHr6RyvJkDDW6DzkmErgzfV3jnjCgiQwUkGfwHnfpR6Macp/EnH8Ubm3qIk3p1s2GMdratCVPARfbgmIaCWAnh4s6mVygQIhO32TdXq6gLlxICJl84tjwNKH8mgJfpPiLEp6Dp2eTI+qwWsQxlIo8L46tzvpK3uql3MT+OiIl11RBM5As+9L7z7EmMZHGqM28Ok4cJjq+/MEmP7D4YpbdYv57sA0uhBg8xXAJx1cWp1P7WxAa0VVfA8U0RiclZcqAunuMn64tYV6d13vksg5nOl0gklHcfhQZewtl2IH6Z44PUNF9BkvWV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo7qVd/r6DIOFGet8uEpAHfQUdax8CD0/s1iKbjVSLg=;
 b=onjxkPiBr83sKvGXiv52VBphFqZhhue9/fVSlBSC8fshpRjhuglwm+YdVbFPGes36Fo+h3no2bG8xXD0lEC3k5KUyYh3Gp697u+tUJ4ABZo7stZM2OMS86YztcWx2/Q7oL+L3cl5gBi2VLHdK/HRnG1n7K+5CkpO5Q2Si9B66Yw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 21:01:08 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 21:01:08 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: call psp to program ih cntl in SR-IOV for
 Navi"
Date: Wed,  1 Apr 2020 16:00:52 -0500
Message-Id: <20200401210052.10420-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM6PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::38) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 21:01:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd4227b3-b61f-4c13-3b0f-08d7d67fccc7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:|SA0PR12MB4414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4414E1FEB018974887F31A37FDC90@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4576.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(44832011)(8936002)(2906002)(26005)(5660300002)(16526019)(36756003)(86362001)(66556008)(2616005)(186003)(478600001)(4326008)(66946007)(66476007)(7696005)(6486002)(8676002)(52116002)(81156014)(81166006)(1076003)(6666004)(316002)(6916009)(956004)(309714004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJF+AGZZs0w1cz+In0E2D+lOCuGQJBU/M5Y00ogrOH5VkH8rNcjh3imRl4J8/uj5oOEqCWiboRJNxY6pftME34EXnIrI6PT1nssIs5aV7yq6Mkat5WU27SKpi+DmOq5Nma3atHgQDDZcqhxWgDIPuuUXUBi1GZaagh0LbqKhwB5d3bsV7d0AJqAYAAxZYVeUxY8ZD67349iYOBaU9JPE3UFaEMVvyJbZDEXdcXZf7GkirqeSuzXplZ/ND7XxkorHltUyUwlIYI3cdBKg8bYFx5wpWVz30P/gFwJsYMuWASvn1h2ZyPdqgfpzdp2tX00juKc3+3wJML0RNxMt2BnohWCBEeVESfwhiM0fuwW/Aw3ui8MRrjFtNR2/pd/aeBLaTFNA0HDrUe+fT001COTBWP7VT/2RZZPfoWyxS73tauO4hAEwRCFcIDqhr6qriDDNhKPo6OtcIPd8Q4drV9Co5dLzGPajvqN2KlxDFqF83C5YPwei28PaVGOKLVqoViu8
X-MS-Exchange-AntiSpam-MessageData: rADtqiVyPFdT9mWVWKC34XDNn9KxAbuovlQWyUhL5p8O11a9xqTRQiD1d1j5tRht7iPTWAsvdmESk24c67YaTiYKGKL2+NOPkofjVWfPXRm7N29rJDQJZnhdQeRaWKNqONmni3F+GVztOwwMhlatZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4227b3-b61f-4c13-3b0f-08d7d67fccc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 21:01:08.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7dMfqyl6sa/gwB3j9xWPGinRr+HAmBD54+xa5H/HNBvynzEYn0lX+2YlShKXgxc6qzOuUwC4y3ya3l0pn5bWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

This reverts commit 9e517bb84c282c1f06edded20f16f927426d2e40.
Navi ASICs don't require to access through PSP to osssys registers.
This on SR-IOV configuration.
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 89 +++-----------------------
 1 file changed, 9 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 6fca5206833d..4968259a22c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -49,30 +49,14 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
-	if (amdgpu_sriov_vf(adev)) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
-
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	adev->irq.ih.enabled = true;
 
 	if (adev->irq.ih1.ring_size) {
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		adev->irq.ih1.enabled = true;
 	}
 
@@ -80,15 +64,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		adev->irq.ih2.enabled = true;
 	}
 }
@@ -106,15 +82,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
-	if (amdgpu_sriov_vf(adev)) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
-
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
@@ -125,15 +93,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
@@ -145,15 +105,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
@@ -253,14 +205,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-	if (amdgpu_sriov_vf(adev)) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	navi10_ih_reroute_ih(adev);
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
@@ -300,15 +245,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   RB_FULL_DRAIN_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
-				return -ETIMEDOUT;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
@@ -326,15 +263,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 
-		if (amdgpu_sriov_vf(adev)) {
-			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
-						ih_rb_cntl)) {
-				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-				return -ETIMEDOUT;
-			}
-		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
-		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
 		/* set rptr, wptr to 0 */
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
