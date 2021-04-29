Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD89C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A7E61453
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A7E61453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CDD6EDE7;
	Thu, 29 Apr 2021 10:27:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1AD6EDE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4TIHD3PFBPsWP45o2/dWInNtKBDp82F7DjofXjir5vrGmCecG+trCnVtyQL+CqW7f+0YxEFVLGBzYnMnSI+EEjmltHgl0ewsyWNGx/5AtrfgcIWhKDezjg3Wz0XpYIt+WHeNaRgC6OpmRaY6SdVjhT3lKejid9qqzWuHPuzgUiVAYn0Iycochr5LdHtIF6s94+sa9Jt22rgwDgrY74wBlPg5N7w5eoX9CJuXDEE3/8wQ4Id4eoyp/SV24vdz4iUJPBfAcYKSfAM1bGqMkN4BpLNtI34tJCMWoSYMV8ntpARy7NvpRj+hTRIHlkjHYCb6ireOOsPGXAtjYogzGYfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPPAQBBhs8PyHKBqZifSfZE04qK/Tnu5+iziXm+A1M=;
 b=Fn8SkS8QDRBjAGtvMpUMRYA1KzNPu2/4oa90/wQu9Eu34TccKXOx9oGuLGwYFahDTS5UcTtUzT6eeNnM/Vhrk7MYLZpGwiuHhgrG3puyQuQS5Rk1N1THSzyfqsv1QefxiNEF7BR2ind76l47vvoKX4VDQBpLZpB4h4Qw+H3asc9NRrQ022oAox6xIDMP8/VR+6Lp1VZa7aA3I0wPoaPJUcYqjJuIiAqlcotOXjskS8Fj0YW66BoHnZrdXxgcFVpH52FdOc6dwTZnhVvNYG7GdhyPRt3qmzqjrJS9SAELr6eDX/AFv2m3JFN5dVetURryQgKpwIbafWHN0FBNm1TrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OPPAQBBhs8PyHKBqZifSfZE04qK/Tnu5+iziXm+A1M=;
 b=q+x60V4aPoxAzULeYbevH0m02vY7oLltDbSJ43DTXuVvxpqaJ8eMv6FJhJ+WqtkRN2dGaAeKCeS6eaybcfe4/ox+TS+Qd2h1FUQoqxPsEgiUQ15mcYOkD90SBwGUc4jsnW/Vj47TlFIOMbb5kpRfeL7OR+yjviUHsoAvuGcHlFU=
Received: from MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28)
 by BN8PR12MB3585.namprd12.prod.outlook.com (2603:10b6:408:49::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 10:27:15 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::37) by MWHPR02CA0018.outlook.office365.com
 (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:13 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:12 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/12] drm/amdgpu: Use PSP to program IH_RB_CNTL* registers
Date: Thu, 29 Apr 2021 18:26:41 +0800
Message-ID: <20210429102644.31172-9-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a25bac2-5077-4703-3adc-08d90af95ba7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3585:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35856F6EB145106FDBBD67A1F85F9@BN8PR12MB3585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T18T7mvmFGl9Ow7dZf7qYQP99Wu9h7KWWT0cOrQT6ApJ24cMBC4B8sFuYzYbgZixA8ImmkxAQPiAT9qLTGInIz2hXeeKR4JsAdP3SNqIQi1EhstKUFexQIg8RkbSbzsuPdGpUbVQR1F8kAaNvRQTjXwYJagibUqDE+eynPrKordRypHnuoG8OJ4orozmcrc+mm6C300NkgxwhwpzCvrKAWt6TN9E2Iio10HLMgDG00ZDjEXTxBkMudYg04y2yPw93zRMhVeQEud0xfuh5zqLlZOKQhmMKAy1G68hee3u0krKERUU3QUMPduOEpi9D4MB6Ujq7EBDXVx7ICVpflLSTuPkFWjJrwBYJAf6wSxb+kxLw33umhkV+RYMF7YspjzZu6akytTxSj6FA2wloyGWziZOth40B1V8Qiz+L1VH2X/EoZsDUT/1cyKYPcLL+01bJFY5UDF96oN15eRy4JOTUYAanR7UVHGaWrBB34dkrz8yqobxA7IPzjD0abKpwApjCwcY9hbyxEdbEoQ2XClXiyH1R2dHAonZi1LzySIpcACkKkSdB4NZCt9vQNz0qRaCyEsZGhXsDPP+OEe5HMWEy89jNudZAaG5suVQisZvIRPI5CaqRwRfKVkHGvMLo8VjGV6lsehwW0V3lZSROiBWR1lFnxatIPCEAZ53TilyPvpB83JoXsMwnBa/XhDwpdPe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(6916009)(26005)(1076003)(4326008)(81166007)(83380400001)(6666004)(70586007)(8676002)(8936002)(2906002)(478600001)(54906003)(70206006)(186003)(7696005)(82310400003)(5660300002)(2616005)(86362001)(336012)(426003)(82740400003)(316002)(36860700001)(36756003)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:14.8817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a25bac2-5077-4703-3adc-08d90af95ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3585
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
