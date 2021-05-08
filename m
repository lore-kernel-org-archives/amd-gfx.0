Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F73C433B4
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED8E613F1
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED8E613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A806E884;
	Sat,  8 May 2021 11:52:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B366E883
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibR+kZRvBQxH78Nx+umOAN55o86yLtAe2neEYns7XmXAwTH1Ntn1NJ/QzJ25bgk/nfIyEAI+lHVWbjrcUdNUILVkmqt23SpaydtNAOb2Qvz79kpVkGgq8FxobJf8x6Y4/s4hPXEUz/SkDiujKRM07TaRvuSNZ2nqKlFQvP2W3Ccn6ELmyF15wdEcVDdqhaKHL85Jbm04gj6r4621WXy7j2f26rmWb5HcqNxzduIu8Jsohgm+up/TQcAHbzEg3bm4vMbeNKqY/hw/ftnJRwdF1ysmBnHFIj629UKM43ygn6Z0bEJQdIDt0JLRkG3gVRWYHotBraK1Jb5KsPEYwDy43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPPAQBBhs8PyHKBqZifSfZE04qK/Tnu5+iziXm+A1M=;
 b=Q0zdPf4n3g0Im6e+qsADR2IBcQ7LkRJaZG7HmteOIt1LIfHzGZiNxFH3feeK8oONbwJNJWC7IV8Tb3g1MgU3dgP46UIID4DRTaBMXuyDxepgMRv1JoR+9FzeMV7PNQQ8pPWQKwBziWJcWo0Fb//m09gIqMwdW8I8I0i3FIL9ZQL8NgorEY8pDgfwPu/fv56ZMsJGSqw9nV3Ef/o1xo/VwjdIUkIFsRqcG6p/GxzkJx30hC8VYfkxy7lroLaJ53bdfZNWIpz5y3rF9Io/MCQIKUWn0O688V37IQLQPkflEy4g9TW+VKRoF+i0+QbfsoDQzl8E1tRu3OcJ15USBRgnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPPAQBBhs8PyHKBqZifSfZE04qK/Tnu5+iziXm+A1M=;
 b=2nijSwumv360WbnoeEpMaf3/XzwyXemhKnhpGO0KOt29VnLIJopZogpbGqk+fNQ7fDCfmEZyX8CdwD7I4DoAtakiDMppLKyrLxLz+t32nhyezC7/dfDX88HWI8QijtcTVjEu/GOSV2vY6rEwM8xE3HdP4Al/p0ttdV/vRevNCUE=
Received: from MWHPR17CA0065.namprd17.prod.outlook.com (2603:10b6:300:93::27)
 by MN2PR12MB3311.namprd12.prod.outlook.com (2603:10b6:208:100::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Sat, 8 May
 2021 11:52:04 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::a7) by MWHPR17CA0065.outlook.office365.com
 (2603:10b6:300:93::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:03 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:52:02 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 09/13] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Date: Sat, 8 May 2021 19:51:41 +0800
Message-ID: <20210508115145.758-9-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a57595d-00cd-4735-2eab-08d91217b2e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3311:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3311629FE1157FD97C9EDE05F8569@MN2PR12MB3311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs4+GiUoncbLKz9rbEY4r7JA76pCyRpGRxPP8GJwf2yyWhktYho8MZOWU0vE5Jod/iP9Kf85dzW0hEl5HoXLpo1WrDHPbqn6IQu3Hx5XpnaxRTXeKEELx8FYqEe7OTUi5oUauBDWYHlJmFzhGU6bTilEl9FgcJvn36PFbYFbrgIeOEB6c2h7AFxeT7KEjmYnlWx51FMEr0VI9dVCoLAHYASaAgQiQ0kzuArBx8TtXSNBl9nlbxRxpw6dl8su1APUw/rm9pNJcucH8ckWAAUCka+fMXLB7E0x5pkjqX6ZxPezHqk1mTSJDsq5I0WSnM7524ScEbkGchc6vMyR5oQNfx8QQPjBlL1OOKIEG4BT+PFntaAkeD+Q2+woPoRc2t0PPHJYf3uzqSwaQEFH1C3ocx8klTd165Btry6Ly2J/usE2iuPZM5JmTbvtDxbT+L1MWc1h6YawICrVReBrpYHfMdtdo5AcUA7wr545jJ3YJaJHAl2nbWPeAaI7b6pHWtGnMCAL4Y+X/qOEKh6D3XAIfC0UjZ0yWcPCOfoXpn7YkObcyn5i+PU1xmUpblznFubJh0e8JQ99qqPGjElXDYEp4S7AVlLG9gdjC7ZMIToLuhzmy2Rd9efECrqsUjVTX8InB2BAFrZeJjZJnWArffuI2rf24zC3CXEkrGRS36TVzzmYR0QBCC9HmRXRq6XGXoLk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(83380400001)(6666004)(81166007)(426003)(8676002)(356005)(336012)(86362001)(6916009)(47076005)(26005)(4326008)(1076003)(5660300002)(7696005)(2616005)(36860700001)(316002)(8936002)(82740400003)(478600001)(2906002)(186003)(82310400003)(54906003)(70586007)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:04.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a57595d-00cd-4735-2eab-08d91217b2e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
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
index f2f0caf560f9..f0ba64ceb67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -737,8 +737,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
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
