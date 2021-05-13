Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20770C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 10:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45226142C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 10:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45226142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3719D6E872;
	Thu, 13 May 2021 10:33:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317796E872
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 10:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMceSWuLeCrm6+S5G07mXUwhsLoJ1odQO0MKghNcvJ9+NGye0343C6PACMuSUSmqnICd11ZlJ/8BMFrd1lAvJWfLaQhqH9dyY36GKfiYR+91ZOSAYND7nCG5WiowYKYZrFnvdMsMnztHhRRszopxZGzdDkrV43hfOc1bt1rmTsYZZGAaS9/eymlxaOt8hlY5PCpfQ5vLm7jTCaT7a/wfODxbF7tgf8SdQCDSaotgfyNwJdyJIwwadQ41REUax1VBYpVPMeUri3zcSpJY1XUlg//nxrJ86nfivV51JNtUPrk6xXGV+Vh/Bjt2rla8xPmSJ+aJgn6fIC0kso2FJRYcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvfXVSuhug+YQFhvdtRU8GEOvAnk3dlRxBdUaBVua98=;
 b=A+Jfh7SJGAk1Tx0N8wRhHWWXeGhZxuliGMPC40ZN8sSlODhJ8+yuu2bFgl0doUYUkkyWQRSN+/E6xabX0TITuNagzZBykczXMmwTx/zf2fBYpJiwoRzAIysgMHCngYh7RV2YGwV/mgsTQFTUN3POfW1rBKM7r4z/W4QTg/5Q1weywsYdnjAybwK2lebqkAJa6mxqbmEgQvb5CbEQogHfdKykVfNZtM9fMsak2sGgjkUrq3ilBdc0ZvpFYwaVckWJpZFeqR6QeLfblCl7KAaemEHk/hCbIjWaQDsMt0+1Q6PAlfY/LKNFptRQBxih35pHE1H6bY3dcAz6391rduzi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvfXVSuhug+YQFhvdtRU8GEOvAnk3dlRxBdUaBVua98=;
 b=z4ENjpX5jUrd/KzjRBQzr+poazQpyayXSgKUdQwFMwoP+ajG5I40qzRXZkDuOxy229rMQPTntVyY1DLu2aly9L4dn+8/SkECio2sMiEoteYc7C9rYacft4cm8E6jQKTHwnwde0R+fzebScbc9AtHCyoPVbuAOPzjzZqKecGCH+I=
Received: from BN6PR11CA0034.namprd11.prod.outlook.com (2603:10b6:404:4b::20)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 10:33:14 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::22) by BN6PR11CA0034.outlook.office365.com
 (2603:10b6:404:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 10:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 13 May 2021 10:33:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 13 May
 2021 05:33:13 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 13 May 2021 05:33:10 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid
Date: Thu, 13 May 2021 18:33:08 +0800
Message-ID: <20210513103308.601043-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d73df49-782d-4694-7450-08d915fa838b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42042712BEC85B6D24D43519E5519@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: td11PddFuHsyBbmW99+5LSkg5kNcs2wezSD+/CViWxSkQrl9dt6Vd674SAZuKM2ZwtSx/RrPfc97yOiUqPk18KpXSCSg1bI+rWkqzFJgaTYq49aMDScN+YU5J0e7+QuB1Aw7cFsDdQmhgVjbcKOTwVWobKbrYNCy4EqAqYK1tnmgKgCiPehsT3G9a4kHAQts3u2YA/XQxLdvoTupWHf76eZRf2UcYz0IN2Sd2eYKc37+XEvRqWhtDHqrE5SkiAZkFh8Vxewf2MYRZ9IV4Bty9kRPqMIibZoUkGmpwBwllsjM/sjhLdOo4aqRi7yt2o1FTuHUm129hc9OCW3k1qBqHm8ThddAJFbhfI5lx7udWXB1NOCWDf6xiK/NTy+haOWMB2Ky6H0guT/nxABjj69D+1ehpYohjoXBUXcP1+pJyXCQFJuzPUPlROO4zrtqvfP2NZyA0fpTyZeDVvvBXNnBLu3lC8iBtHGAqqxOp3bvASYKhNAqcF41EpswyfuQZtKVknv8XQCJY/iHQyESOXzuyZX4umBu2m+p38icbRFHMKVOibFNBUkiRNZaD76MD/X6+rJzxrdI6FnN6hyNCyDl0/4VfHvsJESrVaD5j85Aacxv7vAhK2DcViVKu9BO2lTBYFotYVU17DpwTaKwKPpwJfvUTAMVi1YUEzKOcZYFgA9VvxEp9spDxXecCmz23iiN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(2616005)(82310400003)(36756003)(82740400003)(26005)(36860700001)(7696005)(47076005)(336012)(426003)(186003)(316002)(5660300002)(86362001)(54906003)(70586007)(70206006)(2906002)(83380400001)(356005)(6916009)(478600001)(4326008)(8936002)(81166007)(8676002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 10:33:14.2167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d73df49-782d-4694-7450-08d915fa838b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.

[How]
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 12 +++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f4e4040bbd25..5ee923ccdeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
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
 
 	if (enable) {
 		ih->enabled = true;
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
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
index 75d1f9b939b2..2ec5d4e1f363 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -764,9 +764,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		if (!amdgpu_sriov_vf(adev)) {
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		} else {
+			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		}
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
