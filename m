Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24514C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 23:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F3E206B7
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 23:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F3E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555B26E979;
	Thu, 21 Jan 2021 23:44:11 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392FD6E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 23:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD6H1YqFNqr1nYuuz+Hi/hq53d1JdDAKYVhY+2Tq6l3SYntYMilqPIhJAErHDVl2WF3yg240KgqX5oKyhS5qdmigwb7iSVEwigcyMzIZhmHjLA5VefnwSEu68tv6LVbkH8g73g3edHT6cd9upPHZFx/67gyBwG1+L4+13RPdfODbiAFYxZKJX9zvyo7mJj/QUIY13LYiTfsQIQ4ITtkHujCWc0aptPGah0J/X/iZoLJk6M1rkQp5qhQ2L5SCh/kX3fUSRqfb7jFWOiGjV17s71mozrRDoix+JRPCWKsXjEmmH3LMoSFYfxehoxNAYRU38rE+9aOOhzhrqkU8aFIbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIdbtfBffv1H8H0R2WtTASzNghvjIBqElXCGzZDACZc=;
 b=CvUcoCJV2eCJipttsaqHQFcF4C57chcM0AngBMnUu0LNzPMnaMcUIvrIc4mz+yQGsE4fHCV2zzDDyD8IqgggbH6pTeJ3EWVvyvCkx7MpUa2xgnMiPE89adhwRjVRLD9BG6kdn1YvsMYotLsMTDUq69nqjaDQbV+HBMcP+T8mqvAI9qC3pJ2AJ5T2hGFdfuzxzgVdi/uTEnVkR5jJfdK0aOcqw7j8bDTupGH5nk4IBi+HS8e7sdTFmrRl2NutiLl3hT9r986hUcxp6qchhvDiM/1MTgimk8MEZPP+1aSU/mXqyu4MhKaA3hIgN2wbinQXI1sPnwEeSZeretTNrJHv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIdbtfBffv1H8H0R2WtTASzNghvjIBqElXCGzZDACZc=;
 b=iqzbDgevg6jl8w9sJSkftX7jYXZuWqIa9oetblru1fafvrTktBAzw2tlczBp+nBQh9AD8uQh9Fpduf8i0j5xO/pjnDi2sIsHvdXQyW4ckBdm0DnR8Ksr5NR3BIayMG9ck6gr9+WNWkomOYFHLRDmgf1S2GLwlKtEso3O49sUMGE=
Received: from BN6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:404:121::26)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 23:44:08 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::8d) by BN6PR18CA0016.outlook.office365.com
 (2603:10b6:404:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Thu, 21 Jan 2021 23:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 23:44:08 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 21 Jan
 2021 17:44:06 -0600
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use PSP for IH programming on Navi SRIOV
Date: Thu, 21 Jan 2021 18:44:01 -0500
Message-ID: <20210121234401.20425-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB01.amd.com (10.181.40.142) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd2fd3f-ac5f-41c8-095d-08d8be6671f5
X-MS-TrafficTypeDiagnostic: BYAPR12MB4598:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4598C0F6A6A999F0522BB99F87A19@BYAPR12MB4598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14zhO/1XfJMdopk1I7KvLNOV4Asj+nsVf8hL6QyV8jgeV5FfgEjDYPFWapIYATgJtQlXZ0bLI7QS3xWFd6o6tUcKp8bh0JYbHyVgW0d7EGVeQlVxeU1I4acscOgA0TKWd63jtkQpnf2tSWh9ZALhLwUQBwJLLwjmJEGwNQzRCNQ81aCAlEDhTO+UKZc6LsYcHoe+2FRCZ2bfnwcPAPqVgJpmzcHkPLGbCeO31tXv58zhFntf50PnYcK0Kg6vGk2IcK5W98dDRmrjn/YoLqz9AE4jXhWayTkXI6AHb5LTL/H56jOhKHkH2dNSSH34w0PGuH6syPex7xqaii84jhvVKaVzp3m7acXepHTQATqOynHsUP+IRtOxhqdLoADDOOmWnqosWjh7BaDyGcp289hCWgv7tHTWYKKMNHlEKner1ALmGIAJs+BkUk0AwQZmePROE0srzkujyJNbcur0IwivCRW74D4yfc+P0opI7GE4DlI1yApVVGkqLcDaJT7XxpIb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(70586007)(336012)(36756003)(54906003)(426003)(81166007)(4326008)(2616005)(316002)(6666004)(5660300002)(6916009)(44832011)(8676002)(70206006)(16526019)(8936002)(47076005)(186003)(26005)(1076003)(82740400003)(86362001)(7696005)(478600001)(82310400003)(356005)(83380400001)(2906002)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 23:44:08.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd2fd3f-ac5f-41c8-095d-08d8be6671f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New policy will disable direct mmio access
of this register on VF

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f4e4040bbd25..48933d6f1145 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -143,6 +143,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 	uint32_t tmp;
+	int r;
 
 	ih_regs = &ih->ih_regs;
 
@@ -151,7 +152,16 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev)) {
+		r = psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, tmp);
+		if (r) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return r;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (enable) {
 		ih->enabled = true;
@@ -246,6 +256,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 	uint32_t tmp;
+	int r;
 
 	ih_regs = &ih->ih_regs;
 
@@ -261,7 +272,16 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	}
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev)) {
+		r = psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, tmp);
+		if (r) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return r;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
