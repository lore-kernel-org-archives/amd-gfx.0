Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17443C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90A761CE6
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90A761CE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563A16E9A8;
	Mon, 17 May 2021 14:39:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E7E6E9A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV7dQfjHZSBz04TufBqt/VIf0I+TW8sQoJ0mvJDRSIov36xdIeArHlJrWReAHAtenXyWqPIV1jvtOjDLSAAnCZkCPpAyYynh5SepJz5Zoo1oTqJ5u4RB4L77Uz7BrSe5qhE7nfi9bw7cNBvdsqQkOwdH0DSOTO2wI1s1+jENvUVdP3hABAxwTFN/LmqdzhjrjvBDRnAVbdAWEu/kdCGD4jBG2DcwoA8CP8ui3GOawnuq/gkADIrgDjQVCPO8NTSoV4MkBnEDPkMQjyvPB5druTjKHLJcCghzZnF1CbDwefJH9vQ4hBp5YEsrpSh+pW4Nhq9wjSbukTYN84CBJQs1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P3bAhp9Nzbp9HANPOZmGk9Ni/hAP64r4Iz8tLYcrnA=;
 b=A0z+S4qhpr+0fjJcHSfrtwz356XnzIPJ7sUytI+dKU1t5V+TJnF5LUE4WZ/B45gmDbVEOJJJJIOhUafg8VE8OF80uWviJonTUv/KivNWUL9lPmSuKbyRSGBEgoBTBmYppwyzKz+rrwmjZdETZn8WHl3OFFH/bK7mYFig+E5+OkHl0yEcgLa6e9TP/8QCk9yFPJm4lgwFt4CWClmd8sCcUJjpGjO0ADOS1ddEFkHzW+A0FX0+Q8ak0urpM5hsJ4efXySvxn5Bpp92C0eJz+j/NNIRiVcf0mKZdwuYx6OJtWj3TfkKIAGas3uCK43AZXiByBbUz/12WthQcNMgohUeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P3bAhp9Nzbp9HANPOZmGk9Ni/hAP64r4Iz8tLYcrnA=;
 b=Ygr/nInkFnJA5nx580QlIlSFCuCKPM3dv0nHdGqd2cdSeixlnJrumZMr08SwKxzLv7ZjKBPqoSjD2i09EZ+X7Pv551a2k4yykkP11lrZw0icWp9/EvPuFLQqZ6SLwA+E/zy0+AC4Ku16V6mY8QaBTMyDvVDiRJAMgt6GIBm5eNU=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 MWHPR12MB1261.namprd12.prod.outlook.com (2603:10b6:300:10::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.31; Mon, 17 May 2021 14:39:29 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::63) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:28 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:27 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Date: Mon, 17 May 2021 22:39:09 +0800
Message-ID: <20210517143910.2125-9-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70de91ae-3384-480e-531a-08d9194193dc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1261:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1261ACAB6AF515ABE904CC0FF82D9@MWHPR12MB1261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69oAyR/0C+064S9yI3ECEZk6C7+eiAjH5ad+PgEYL3yeSo4YQScFwz/xRzwTkIIToLiVxe0SNXleeajPzpIwF7qs3lDKdCZ0DhWqQ3tTmhVM1CnZStCb/7/obujB2vuVbZnOhgalUo0lRC4B4PMJJW4dGYxvIOhVxXw8AKQpbcp0fXd3940DipHe7UzaCmf5zMnu2qrRbhtVbAubpNHCyC4wp563tesehxAqPt+bza7V8pYtgMBNFVFWO8cLQ7T/BcPwpPqTxAApXEXMLLy5HDlDIww+iJ4FCMGvyNaKLOStN3Lo8TeFqAb7FoESsRMg7SMw0lAmnGFD8VWlE9457zi9tKAdIu9fqFm587CrJyo+BtOdTlSGKPrFJJX3ENCfwbUz9sQVsaofxofiuEyc8GxWFlRgYHOsS7EIlfyTScklmTpmljyxfanGQSli5Zkz6DbK6uzar8DYihcw7vR9qZwzJ8Wuh6RpTRiPHc7y1GWkhhQUGZGokarYZSH4m81GTzm6fkm264PvRZ91mTf9mTYXhhDGwlZvitV9tAKBgtTFbz+a528p68x1ChfFP7G1BDmolyiwZJCaz0e45FOtr+bc5eLhqHrQKoscENpLkoww4X7pvYdL52K8Q9fmTlt2ScxHLLp68mzaYwqwwrY1eTxQ/Zc4abNAjoBZuQaAtis4tvChDW573ERxQ4knUQ9S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(46966006)(36840700001)(6666004)(2906002)(478600001)(1076003)(81166007)(356005)(82740400003)(83380400001)(36756003)(8676002)(8936002)(86362001)(7696005)(36860700001)(5660300002)(54906003)(186003)(26005)(6916009)(426003)(2616005)(336012)(4326008)(47076005)(316002)(70586007)(70206006)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:29.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70de91ae-3384-480e-531a-08d9194193dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1261
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
index a9ad28fb55b3..b9c9c4d4606c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
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
