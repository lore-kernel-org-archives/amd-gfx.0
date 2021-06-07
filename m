Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7643C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9060A61185
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9060A61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3849B6E9E2;
	Mon,  7 Jun 2021 19:40:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 543CE6E9E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 19:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQgcj70hWxKOR/MHyBIyaHoUlaQLkjktKYM2nxyqPVcX8MzYgXQKO4TNE20MCpNiTtI8YwiCDgvZbWN2I39ArF7YoOOjCu/HaVRFaGMbIEFZ8QGH0EQigTh96EhM04GvgqtX2wI/lBZmnXAcOSABv+NgnzBpi6jw8pgA+iK0z3IaEYhk2sHgwAagaAKmpyYlBdPBvV3C2w9dv0ftGRforgWzH0f6pD37N8B095u+9yuv9gTk2I/cAplQv+sD/NhmvUFPfPiaWShGBFIFmKNkSdPvUKQeeA+ZNq2C7FFHSKOJZBC0laxuw5worVw19ohuR69xCVjEfgmQ4P4dgWdiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCOCb9kfnN2HbcJY7U3RUOMkjjd6khtikEpsBxsmahY=;
 b=Zf6rO1GFZWo4q9SM7/gd+8TbJZYp7+NYYJdUK2TGnk6NdL3lcJ92wopTNZXs5ESufZxJTzlWcHwoA/VXqaOhruq2RePgGLXcvZZ9UHJ+3KNicjI4HzQHPBcLvKOOvE/H3p+oz6F1HGhUUaGCi0thHwlqWW3Wa03vvQMk4dXhoI6HsMpLtmQj2IdIU2tYAhYoMeAxxsoBOBYYUD6T6CtkLO4NdVd+YY0jK6vAVbl473OvOP7Ya4IeX0DjT7RnDCuGp5sGdyBBU2QDbL/2gJtsWAIqEPQr1peF5E3SXIapc4wFAEIIj/sklCUFZytBSlt6fqnwaYIbOfGgKugFduo57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCOCb9kfnN2HbcJY7U3RUOMkjjd6khtikEpsBxsmahY=;
 b=QZK8e1DZiU2aED+inofeZxokL3IhiLVBWtf706WmW0BFsn1vT2tK2RIehRMv2796YvbMJVD5dVDeIImRaL7pEJ/Ept7feAUNbi0jMc3LdbzU/ZvlvkErfnTBZlsgA3VS1S3fxw7ue4C1qMnMPGBZxaJT0CFNMpzlutX9T2k2a/Q=
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by CY4PR12MB1798.namprd12.prod.outlook.com (2603:10b6:903:11a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 19:40:08 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::df) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 19:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 19:40:07 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 14:40:06 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Emily Deng <Emily.Deng@amd.com>, Monk Liu
 <Monk.Liu@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>, Horace Chen
 <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
Date: Mon, 7 Jun 2021 15:39:29 -0400
Message-ID: <20210607193929.24239-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9c5b5cc7-4abc-9805-7da9-88abb9890fc6@gmail.com>
References: <9c5b5cc7-4abc-9805-7da9-88abb9890fc6@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96fa85a2-1c61-4a73-a610-08d929ec0e3f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17983A757ACED75A767F337087389@CY4PR12MB1798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU8UHlM0sgJ3AhxdPGoKN8CSx47CIi4wFbJcbY3HGI3BSRcD72164HzJpOD/VG428QivI/VnhtOt5cEYMl1cnyNvOcPXBKztLR/kAxUFg59u934yZZLhOim4D8pzZdvNzcBzyCw3zrmknc5lNos+wk3pijxuS++62Qyw+/lUkIpnt9ZyHSlhYaVEZRm/4ZMtJXpZyZoTmn5epxU+9B5MXJz7zadiOGKZWFe7Xj9RXFocNJUGRKNlnT7ivaqygakilQRUiK0ish6aP5n/9jdWJBC4gr5LfS3ZS/69P41+SlScaM98cMmrTkPu+ar0DB6xC6peD2uU+fQ2n4XeZ8xacOuzw4LHSZdKVyHZkHAfGJ32wVnlX5OnH0exJBapt7b9HfEtCnQ8gCdTEjI9W0E6d+5xkZJ70/KfPi65nc7x0MuMeOyuebnfZyAi6BmERHOFW8vazG36wt0gK9JkuzAw38fbMpFPT9qcLe9iamLzaeKGmYd22oIz7v9BCrBIeiuZGm2ZegtjV2q1HO0znqmDZo0q4QIXRGFc71gd/MZW8kPkYOy+NWlobDRTRVd+MaJZtAeD6j6tNjaK/Dmtil3/OVwNF8wWrqFy7nYvwaoXzhnfCZt+etNbcqaNExOgHysBmj1gIiLVqYRQl3U+e6qD8tWBffzH69CG40B7kHECFZ5DWYrecrnphArWffreo+un
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(478600001)(6636002)(6666004)(2906002)(5660300002)(336012)(110136005)(44832011)(1076003)(8936002)(8676002)(4326008)(2616005)(426003)(70206006)(70586007)(83380400001)(16526019)(82310400003)(81166007)(356005)(186003)(26005)(36756003)(86362001)(82740400003)(36860700001)(47076005)(54906003)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:40:07.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fa85a2-1c61-4a73-a610-08d929ec0e3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is similar to IH_RB_CNTL programming in
navi10_ih_toggle_ring_interrupts

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47ceb783e2a5..058b1b1271e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -683,6 +683,8 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 
 	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (ret)
+		DRM_ERROR("PSP failed to program reg id %d", reg);
 
 	kfree(cmd);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eac564e8dd52..376ea281c4a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -120,11 +120,23 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 				   RB_USED_INT_THRESHOLD, threshold);
 
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl))
+			return;
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+	}
+
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 				   RB_USED_INT_THRESHOLD, threshold);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl))
+			return;
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+	}
+
 	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
 }
 
@@ -153,10 +165,8 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
 			return -ETIMEDOUT;
-		}
 	} else {
 		WREG32(ih_regs->ih_rb_cntl, tmp);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
