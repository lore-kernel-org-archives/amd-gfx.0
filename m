Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC3DC2D0E8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5823420663
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oKEu8KLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BE46E202;
	Fri, 27 Mar 2020 19:38:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39A76E202
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeYvF9mnwclNvcWUTJkFP2lMSlcUo3ZeQq9MHsFj6eshN7xgBfRjegLVQhlGso3suXvc3C7/b/vBGu99iQyOe1QJe/JUry6g7nKC8FMaayZw0MFaHd14Nm4M9MIrUDRlDz7ISZu1NxgwGRId57hZLFt7p65/BMqKThizh7jCxrm5jsV4yBNEZENgnZAIYz2bS74MAlwQ7LoRV7CNdmYFtOaG4v9hkAtF49AM1hNYgMx840J8wlm53WmH4cT0lgigo2JMi0/kjy8+gpNfizkdz/nPRVrklcQC1fO2l2qs9Zs4jR+9nyLsDPl1DNgIhcDPLKhQALud+nbwmoZHDxMB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fbwCfkZDA5WbZPME+7djqfktEPLXdINIlEKWJALjTo=;
 b=nvTYeMGtSyr1A2Bw0ZjUsUCnJwr51N94ZnoEjfnpshI0MP8UnRnTkIvVQxgcMs5JuqEY1vX3AjJh2eZkKcIs050B2bNEakgznSCNiNxWoW/KsKfBUDSzlmgn4gonbIeqhcCHZktezBI+f83+wWgJBXCLpHZ5lD3LvnUhLTULCAkAu5/jcANPH4iLQqnPSHHS4A/6Bd0rvDi005odi0N7lD/pC0UKjM/zVhxt+uV59riPwla2JighrFUh3kqLA+xZtHgMb9k4WFo/ZaW/di58CT3s7UKnsNNtZzA8nSSelr1KB9Lqr/sHdXM1DYLJdwriRjWoYfn/h3KrgfGJKioy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fbwCfkZDA5WbZPME+7djqfktEPLXdINIlEKWJALjTo=;
 b=oKEu8KLMqEm5GpDWNd5AunPLliRHojanNcTqf8BT+Taj/j8VfzeM4GiMLAmzi6I1P22FjB+gSJCoyGsFT1nGPxTJgFG8JplxUqEa++AoMk7axKF3fmgd378jiX3KE8jMrUnCkzmKyie/7OGM7bu/K2Ea69+fKXWXIpbLStWKLSU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 19:38:17 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 19:38:17 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: call psp to program ih cntl in SR-IOV for Navi
Date: Fri, 27 Mar 2020 14:37:45 -0500
Message-Id: <20200327193747.8520-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327193747.8520-1-alex.sierra@amd.com>
References: <20200327193747.8520-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0201CA0011.namprd02.prod.outlook.com (2603:10b6:803:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 19:38:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20f7859b-8448-493e-c6e3-08d7d2866622
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:|SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441391CA641528D8CE4B9FAEFDCC0@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(52116002)(316002)(7696005)(6486002)(2906002)(16526019)(8676002)(956004)(478600001)(44832011)(6916009)(186003)(66946007)(5660300002)(66476007)(81156014)(6666004)(8936002)(2616005)(26005)(36756003)(81166006)(66556008)(86362001)(1076003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4413;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij0euzDLGx0FkxbG2Ab14+LdvqP8/Yb/ODrlkbUnMqOYXZPcWO7JGxBVFWeFql+T+UbZkrgE8znPLQ6xZ09C1ZvyJ/cIK101GBcCkmFaSlT9l5r1GBhFnDFfmBsPNVem3fTCA2fbpHBxlVrOa/XgdNU/mpBoKEvjcPtdq9u65NdESZN9m79fAtjsXgV7dofXehAmKQKgj88EaJpPGL93znOOs1JRSq4EjGcyKte2wVkkiuilmsYDBpksNHPGT8yM+/jxZPSiHLbK3TuvA+HYocjAEXaFna1DQLY60XUQQ/lPdMF5az6chc0Ccny2xHbOz+a9E+eCGxeTifBL94fRiWnbMi0gqlcm7eB6cSdDCXV06fWAhWX8COfqsAohu+wCGmErchFC7+f40XdH7dkdg0+cftK181hP6rq6cbkjHEZVA9FpD/s4KwMRtvci7odv5RDmn6ZV238NihNfzVBHTwRnJiTaz0VH4S+auVZ8KAA=
X-MS-Exchange-AntiSpam-MessageData: QzxrZfATtNyAL/DnpVuKq2OStV/brjDyE6qMndARBhCjcNGAOY81P2UeafYIH5Q8Y3B+OPoLoxqnXU5gVCDRU0I9Vuo9uQxFwM1eBAsyBe80cuF2OWEFoQI67hOnqx07CHQlO5GTMAyeCTu1zhDzaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f7859b-8448-493e-c6e3-08d7d2866622
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:38:17.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRQggYvNLgAsjhL/xsTKFJA1cT3wNZnTPqoHajY3gkfPAybwNwahW7CP/5wo8fEJmJDIG72dhdaV52+nLkEHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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
