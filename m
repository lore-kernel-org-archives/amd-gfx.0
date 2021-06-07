Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC94C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83096108E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83096108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EF76E8E6;
	Mon,  7 Jun 2021 14:24:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE656E8E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbaoX6dJk4ZLFS3ENN9+noFXa+qZ+SZJYE/pP7W8ZV8AeGxvMwhRtqo5lKGWHfcblClGjgowxF2qkvhThA3I8pnUoBeSy96PnkiT+hE+nzSiLts+f5wALcu3izkwHdb4dtJF5a4S6f2R2Ds5wg15EqqI/IyK0+XFO2TlkPFauxpS9mxPk19/XqKKdJTqS8NQUtXUnJEK3LoosyIn1EQzAmGG2v1IsfbASoEIVVSdwL/H+IcgrbTLXqpnj3GU5VIrc7EwPXiLteYlWt5EF1JGXO1MidUul9bJhrR5fcP7GFFNDXmWrE5cok6/9qOmIOeH98m2sQ4s8YliPw/BllcDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Amy35cvhGewsV+n7V/o9dYx/xUoN7/vb0qFoqDAg5I=;
 b=XAoaVR5Vf8yXnZC70pNrN8Oa13ZI/WYobzTE34W9HHmhlZswEmBYESlmyKIPgPmHOY/yzHb2X6MZM9T+3ZoHUY3bkDXmt5Qee/MZMteeT8YHO4d4KykE93YOl+IL8+9SDlZW1vvsz6WJaYFpZ/r6N0AnGkk254HDVpCPu9NLkRnEU6kD6qk6yk9mX0Mybs2c1fes3HfpbDNqBmUIN/CLijxa+j/DgLlJr2bZAaDan039T61Qs2Mh54Qck0VEIxMZTL3aK2sgkZJZ2oA7L6rFvgMI5NJ+O5KUHPyH4f8dFQUp2Y2uB6xhWz1EKNpa9r+wAf9/09lmNtcE3CpNvZZwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Amy35cvhGewsV+n7V/o9dYx/xUoN7/vb0qFoqDAg5I=;
 b=KMBOa3L/m2WXOD+mVvzWelOfB7vjZpikcx/RCWQ2rSg6jvDta5fyviQGxbAfLGR35o6kYs+UtoScjeSHLFPAtkx3wW5aKq1K/A12gRQN3GrT3jh2KaG8sSZL2ML5coDYMcb3NmiRilZnOVnG+Z0+BbfHd2RvvHf2f6GPaLYCdSw=
Received: from DM5PR21CA0059.namprd21.prod.outlook.com (2603:10b6:3:129::21)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 14:23:57 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::36) by DM5PR21CA0059.outlook.office365.com
 (2603:10b6:3:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4 via Frontend
 Transport; Mon, 7 Jun 2021 14:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 14:23:56 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 09:23:55 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou
 <PengJu.Zhou@amd.com>, Horace Chen <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
Date: Mon, 7 Jun 2021 10:23:43 -0400
Message-ID: <20210607142343.13509-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f046577-eaaa-4fa1-4e3c-08d929bfe2ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3823:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38233895EC9FB65619E3CB1687389@MN2PR12MB3823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFh4O+SzCgcKVnUD+XhXtuLgdsdYAcAmMYSEdtUONbYO0QcV9WFISuik1LORcNNzv2D372i21mXFJZegf70zu1r7VJONfhJxe8ZYGIHKfGKegPpw3bH+NEfE7hUSE4a3PATX1M23W9+EQcD951Vwm4YLZXpNoIN+FS+9Nfyt4mGbRdEAX4BWdehHh5xm/cqDajLBmVYtZ9AClE7tdcXYuYdgGhRI7MUhSNmnxCiIPPMoDKQUScVQWYbn8oAe03+T+hoeUX6hjzmhHHNnN1N35K+zO6KLmRkzQWlD5TSbHR447lcLW3pUIdAOOY2z8K3dRMbU+/0k/ER4OQdgg39nii1dCyymfhQQvVXs+jMi3r6KaoMwTt9CH1plPujNwEYR7qGm8b0kg9jZ6Q5998JdVEkZ1sKOAAzNymOr+LBVPkBdR0LhoE5uzbdIFSQDBCKl6Z+FJvd1Dd2sCBG1jS7yvxhleqsHCL0OK6FVyVYEYhWh/5fpX1mkXnk4/Yo9kd2zFjR01NRvRolRHYS1AgoRZRhD5ybv1iHVou0SI/wugoHJ7uv//B3htF1rFfkIz4XYsJrm6GXff/Po0H2VkJLLFEayZPvbOGAnEdec73JDYHtbv1GfeOdcdomVNwaiYzXj/iKlEt9lxKL7hx0/7PS0quCEHCw59j44U8EMD8G3BgCuurkhCWhpi1P+Uemo3F1Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(1076003)(2616005)(336012)(426003)(356005)(316002)(7696005)(82310400003)(82740400003)(70586007)(36860700001)(6636002)(36756003)(81166007)(86362001)(44832011)(6666004)(47076005)(54906003)(5660300002)(8936002)(110136005)(83380400001)(8676002)(478600001)(2906002)(26005)(186003)(16526019)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:23:56.9250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f046577-eaaa-4fa1-4e3c-08d929bfe2ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is similar to IH_RB_CNTL programming in
navi10_ih_toggle_ring_interrupts

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eac564e8dd52..e41188c04846 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 				   RB_USED_INT_THRESHOLD, threshold);
 
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+	}
+
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 				   RB_USED_INT_THRESHOLD, threshold);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+	}
+
 	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
