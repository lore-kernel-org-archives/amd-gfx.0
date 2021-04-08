Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8457C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8820661164
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8820661164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D876EA78;
	Thu,  8 Apr 2021 10:22:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD736EA6C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf9ysnkwQo7sGah+lere4Kkl6AZxX2XF4B4OeB3L5adk5H6x/TZTiKZgHvhFXqUzbkFrOtk42H7VtIYeuD9N2t4lFQLAPxQdx/gE6FzP+ivhou1fxXP8fVgb3BpJiLwWViclQ7Jkt7YbgJKklo16BPeIHJ2DgujodyJLfXwKCMC7sidADrTmeiCstDwvb91P/Lf420vrkYW05iUJLskuqofdT4qWmB3N3LS6XJ9dbOaMR+TcxaasvgUOsH3ilKnYPaIVZ/exewWLOn4JGBEQ7q/E9nwlfplOzeqrNLycG0waJ5Vqf9+9gNjAmE9MXkbOOfMR6Q2DTs0hme/A8GYAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDoDiocF8RGmGILBiiujGdNlkdqetDaqqNstlIOi+fc=;
 b=FDyWutmyBB6XoDOqvJHfUM2VzHOfnh1S9cXn5HMTQq3kXKXGOOJ1OA/yLv9oHGvQ5NsVkZsTy13nDSBY+MpVjylMZI2gPjNwPg6FEKBtp1o4EIsPlHzv7qsLvTJkYiBbdRYVl3TUhkNmcJBE8EKh7kIv3IUFPCKZ0Vu1sGxbJWKNn+3jgFM8W/v8y7mJIHnjeAHnfEULBx8SP28c3twNdWhOQ7wSoBP3+d9zLWMNvLQNcFYEHdqv9M12EP0oRuArwNaaC8OjfnfNRtB+hAsWzBspvp1Q8GV5j6hkV1FsubxQR07BBeNFoL6oSXpgNOCHfWDvsBYUr8P6CdrskwBQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDoDiocF8RGmGILBiiujGdNlkdqetDaqqNstlIOi+fc=;
 b=3cvRlrEbtubo4IPEj7viIyGv+iKsjq/gKCRtl6p6Z8aOvWqC6XxzWhvtACK27aitR3ue6lH+7aFE1WGM7hrunnqLhiy3f+nhvqQ6GBPqweGRsxz229fplyN1X8PRrCrDbVr7INaG1r6NvO9C+P+HGBKmxSXofAq9pJ70vqvTVjg=
Received: from MWHPR20CA0017.namprd20.prod.outlook.com (2603:10b6:300:13d::27)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 10:22:24 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::3) by MWHPR20CA0017.outlook.office365.com
 (2603:10b6:300:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:22 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:21 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Date: Thu, 8 Apr 2021 18:22:05 +0800
Message-ID: <20210408102205.911-8-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abc8e10-551e-435b-bab6-08d8fa78335c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4853108073C4CEAF272C11D8F8749@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KC/vOo8Q6ZhgNwbwpKbj7SB5ufm+AKVn/c3sOsk4Wng69fZxCTsZ6MR6dt1CMUWMXsAeyllXxS4Id7uSlhSxlmvwVbvRAi3mC0rLn/8SZF/KNtzinr6dDGHydOk5bcvKxoZogq+03hFb8NRnoNXBH7Dwwo7e5gdTVIbBgD1T1WZXycB9goLasNP8z2iS0PVu0ug79lh03Y0YJzmyIPrVETyB1m0Qzkm/8VK/Z58A/p1yoT9xGQc2aR/x2syQxn5Ydjbk+v2fvLnZKW5IkMBZDUykH/qWjtkfn4iGWAQbU6Yp506SLPn0IDQUG/lVz8WV+o+cFfxEDMtUBLabNumdhVA3/d9DhOiTdjwDHeTIlVw2iuj5wh52xf6GWaL9ctPTjkFaWhzBwiSmmVpbWFPHDxfWVYYZj4SIHbEn25o4G9c5YUKRxCMxhgh8mCYwezfHo5yLSWhsFessct7StTLbtqq3K7L/G/yBOP7wRGRCrL0SusayH665gj/RmSkul33NEGcwTzNGLxwOS/cGDBSIStstIRRnymrV+ET/9ad8VrSU7fEWwlROQHopWZQmfcLXLwXk+L+ak3B58K5wZenqIDRHGQIrld9CZbSKh91n7AnEwrsDAXFQLe4WvCm2VmA842Fy/tweR07HtnYwUKIap2r0EuvPdADT5gAuSUL7qvumM5ABJyjvnRxYtQUZZc/F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(336012)(6666004)(83380400001)(47076005)(70206006)(1076003)(2616005)(81166007)(36860700001)(54906003)(356005)(186003)(36756003)(70586007)(86362001)(8936002)(26005)(426003)(316002)(82740400003)(2906002)(8676002)(7696005)(4326008)(478600001)(5660300002)(82310400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:23.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abc8e10-551e-435b-bab6-08d8fa78335c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
index f4e4040bbd25..903772b37759 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,14 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, tmp)) {
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
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c848b9470f66..0fc30afb4d61 100644
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
