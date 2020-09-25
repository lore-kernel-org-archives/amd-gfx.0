Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62288C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 08:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D317920BED
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 08:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g2h20wbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D317920BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA856EC5F;
	Fri, 25 Sep 2020 08:56:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78EB6EC5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 08:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDtwBVT8p7d1MfJDAmqN+57znuQNGPaeSjg7jfY/yUSGYPFJh7oYqBNUOAOlfc+V93nOLsQf8xILMroPM2ObZVFASxGCAVAlDCzSmMo1MyBZjoPCeS8U/tMAEHaN2a92KT17qZcGTYaeJEckhYH2nSHo3jb4TOdbj5NzAQcaMiJWBDtWbXnagsM6g67RgiAYldad4tXVSDE22RwDKKLK2WOXo76PRLnJBPyovp4A9yyqORiiQu9QNb9fTe1V6suKBUbvDk3W4VqAbmpCe9LO/3o8GK6gJz4PJfTX9l/W8+hVCI5T8aHi6qE1KQmzredwew8mFqNoza1CJN9w2ySLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktwGdxXBQ/twoq0GxZuBn2dPqXs4l8FrDS6fSxkgL4E=;
 b=j4vwngplBRM3oqHxGBMvRajdKUWxFALdhmfv9v584bPjdXHCmt3HvI9u20LrroQeul6ECD1F4Eyno++B3IJxGahE2aQIt1CD6ACeH/6TxjlLuKRV8strZXA91fLcaPb9rz8GoMFRJT6zdo71Z1vaA5V+Ps0WyVRYbPdMDOXbdgpgtvhaZfi56oMo4110nQGa9pzQfzuQYYUaGADWoBMpiytuRN1K7Ogk+qgChliv0r3P9FvRjHPlhCyT+N7dpohO6J9A4CVAMe0J6sHWT+ZEf+ShNXTPI9aSdIinVNhtMrzKjGBKhXv7wbhU7LcbydWeNDDWyfaeA/4VFoxbaakPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktwGdxXBQ/twoq0GxZuBn2dPqXs4l8FrDS6fSxkgL4E=;
 b=g2h20wbMLZDyv1MfIEUImcF46ErZmtb2SR3Rk6uB4/u6Te4O4McA6+5/54YlfoBIPAuMQqbrQDuvWhgyf3NQj7hR27srqWoh8jP/GLqp8QB29aPaPrD2QMQlKZMeTV3XKh6KLnXswWGJOnIolN5j2b9/tt2O+DP7kfM+YZOv+48=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 08:56:08 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1%11]) with mapi id 15.20.3412.020; Fri, 25 Sep
 2020 08:56:07 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/drm: cleanup navi10 ih logic about older ASIC
Date: Fri, 25 Sep 2020 16:55:49 +0800
Message-Id: <20200925085549.2258996-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.17 via Frontend Transport; Fri, 25 Sep 2020 08:56:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60f027e8-0d18-4958-6176-08d86130d778
X-MS-TrafficTypeDiagnostic: MW3PR12MB4362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB436278D0CAFEDB951B4B42A0EF360@MW3PR12MB4362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcKIGkBSt7duffhPdLHXBnJ7gm2WoDq6MCkWbw5qAb/DL5G4msWYDGpiifSuJV3NqRunXg1YD8chc/uazOw7QGIl8qrA7jfOt84pWTJCJhdu2RrMS2z0925euuJ0cft0EK84jRdSVe95sTqMDuGQAJjFvFc+SS6JwzCshRYXDSDevqi+0w364SE8lo3FL+pcXH1PfzQwI6ejcWFMlfQ9ezDoSOnH3kZcOmXGSIIP3HlFsB9qxcS2RPn7WOHiCAd/pTqZ+cBAJEZIReKM4VV8e+UY6SLxcFnR6Bap3p3I7SExS0kYhMHbNob01HJDKrsSvwGaiDl1c8/qPgMa/P6dd/JZgOLe+jQI/3KLhMkkn4Fjb4Yan0Vw/O88F4bimhDYsNgW/LRlTRJcyeWY1A2H3iR7eoaNrJdRSiwQJy+Loag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(6666004)(86362001)(66946007)(6486002)(4326008)(83380400001)(26005)(478600001)(2616005)(44832011)(66556008)(5660300002)(8936002)(66476007)(8676002)(54906003)(956004)(7696005)(1076003)(16526019)(2906002)(186003)(316002)(6916009)(36756003)(52116002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HrEVU7p7Ch0WLSmmW6i5G0Kh5Bm6c4Cbm0gyb+HAiQNNUAGR+IroXWjtDgcWAijEikc3QHPFlmKoeOR5u/JIlZxBmi4RQ4Qn592ClMjakq1y1yBNWYxzyfZtdEZL9J8IWHBl3FfiJcNZX3Z2pRI3GD5IDPMOQpo9p3ybSjnn0424RukQzpxvxTucnuaqwFbv38wgLuY6V/BGoHV3fiUWp2F5CSZheB5H1RSDDOnBM5zcFy9Fgx7foPtcMscMnT2AOHq1YYJMFBJn5WJ2ygsWUbzqxw4ks18pH+nWu2arheufoKPYqS9IzkXhyoGx39LvYyjjeRm/JOtuBSQB8dEZHHpdFadQd5K7OtMkdqYQk6UnYmc3/A57yzfSh6ucI81Qz0/BPA+J+TfKGLlSMErm/F0xT9IfgAeP13u61qh0y4Nakh9BwTXg2PmiM2NK6yKuthecXlYDpNNzkFRGaKE3SJ6DwH8uDSzbFf7m/X4LNTS1BOBaMUrcfgfm2Z1yLrh7Nnd7oFu+qrxgGJOQQuSNhnUf+vX8XbC+5snojfa2bPrwJoBXdrdxvR0KwbYzYIN/JCHJJRIa7MyIS6mlPzrVxT2KcQv2H/CMf881xa7cHZ7wo1/SBztIzka9G/JCi3baa3j2tNP0Jd0HAupOiTMoBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f027e8-0d18-4958-6176-08d86130d778
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:56:07.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaMrSD7RUFLcT8h9o9vLTeE6Xpu5SOoS+kQYyOEP/EqrI6/d2CqbIvzg5kUleHii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

The ASIC which is older than navi10 will not call into navi10_ih
related function, so cleanup the related code path.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idf73b73f1f4f19031260c220798e5fffbb2cecd2
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 105 +++----------------------
 1 file changed, 9 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 74b1e7dc49a9..92b5dc2931b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -94,14 +94,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 
 	adev->irq.ih.enabled = true;
 
@@ -109,15 +102,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
 
@@ -125,15 +110,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
@@ -151,14 +128,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
@@ -170,15 +140,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
@@ -190,15 +152,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
@@ -298,14 +252,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
-		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
-	}
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	if (adev->irq.ih1.ring_size)
 		navi10_ih_reroute_ih(adev);
 
@@ -357,15 +304,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   RB_FULL_DRAIN_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
@@ -383,15 +322,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 
-		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
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
@@ -672,24 +603,6 @@ static int navi10_ih_sw_init(void *handle)
 	adev->irq.ih1.ring_size = 0;
 	adev->irq.ih2.ring_size = 0;
 
-	if (adev->asic_type < CHIP_NAVI10) {
-		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
-		if (r)
-			return r;
-
-		adev->irq.ih1.use_doorbell = true;
-		adev->irq.ih1.doorbell_index =
-					(adev->doorbell_index.ih + 1) << 1;
-
-		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
-		if (r)
-			return r;
-
-		adev->irq.ih2.use_doorbell = true;
-		adev->irq.ih2.doorbell_index =
-					(adev->doorbell_index.ih + 2) << 1;
-	}
-
 	r = amdgpu_irq_init(adev);
 
 	return r;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
