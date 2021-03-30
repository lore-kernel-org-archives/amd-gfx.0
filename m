Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7DC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612C561989
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C561989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67CD6E2C8;
	Tue, 30 Mar 2021 04:33:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D125A6E2C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4eQXf3LKBWIdv9iW9r7QdKuhN6Ag9jy2Kr0sAUln5oSx2TLD+btuoV0hULNoG7gm7yAhYZYyEiPLGDBeoGTrZVbqPSxqfqMBDslyk3t+kDPv9xF6tzmQegsKAQ0uUI7UHMoCKlbMc+OT+TmoLc3ZlfTOSa03vqjqMssH5m1T/RNlBB9hAFdYYVEI8J9Gir0PyzMnPb3gnwmV5cwzzAF3z6uLyk/Vr1q4xJ+NReETiy4hlO3jrkOM0+Qs77JXXfTPKh6QHsvZ4cww2MhuMMpN9QzhlWy2S10+Cqye5nJDfLAhibAZe2aEX/lz7vVaiYIZl+jHlHW9u5l9DB8oUD/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNx+22sw6LohjrRqtXMdVurANP2TtLAh+y2rE490514=;
 b=LgNDw0lT6Tfb161Y0450XiTZJs1HbrXuz5hD9h9SYDRHBt8bDA36qFV/jreWJGipf/V2Fc+bAfjt3YIp4ek2EzLlJshgVP5EyQVPN3ZrxQFPncT+GIUKZGsRLDPRbKv6ePkqvGAopGyhUS5JjGYJXB47Mg215IyUgL2nSDgl7o0MT2Vi0XSA+9vFBTJuIXtaUSJlmW2qyJE7I2RR1BBqxd0+gVxbMDblQUeOrjuBspJMKO6plmTKTCk9PwCmNACy0yeSKZ7WJ3zr+KWP13iGTi5GY7T0l1wz+9pOyFn7lbdPdLEqUTG7l0f8oJZdPj8A8nwSILsc5WWI1fi2GoqWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNx+22sw6LohjrRqtXMdVurANP2TtLAh+y2rE490514=;
 b=tXAFJLJdaYCIPuV/s5dWnV7FD4EtpI5eFOTarO6RSvrCdWlTaYRNCfVUNZPxFETokzU7JwfXAzqwLMrgIYnGzDeSw73A+P9YZlvsIGgM3lAUcMb95g7/BfLm11+UZjR3s2yB72IdPIXO5B+JOwaHU2zi2LcyGvzuTP/g9KeGpkg=
Received: from MWHPR11CA0029.namprd11.prod.outlook.com (2603:10b6:300:115::15)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 04:33:31 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::a) by MWHPR11CA0029.outlook.office365.com
 (2603:10b6:300:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32 via Frontend
 Transport; Tue, 30 Mar 2021 04:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:33:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:33:29 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:33:28 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Restore msix after FLR
Date: Tue, 30 Mar 2021 12:33:26 +0800
Message-ID: <20210330043326.28540-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7040aaa-ee49-4010-6eac-08d8f334f89c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42992291EAAF82EF42405B758F7D9@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irl+8VhwxkzyIgQQubJ/0JCA2frLvzOgeOS1lCJcZCvUsGBhmOtIK3xqj9l9HPjGfN8ARDrpQ0br58kR84dp39XoXQFo9YQUNFzCqL2dF6CmMyrG6qCzxAG0xtvemwOIhpIHnxjIJsZpbac1tVZGXJScKB+YIzT1aTqjV65ij5b0/suHv+F4lpd79PmVtVFnyr0oJZGZh+nfnhjULEsYZsib9UUT3Zu6tmmHCbHq2qzI/E4FEdQptPK4F+fndfdQGLlbkaMzE2XAqX39744TW9J8XnW+mLBWznOjZ8uWqRtVvq5zYHilqY2lFIifH/HZfyQlDa9AXLo+zkBPird3Lf1b1baBrc6qm0L2MRxwxeOtbZE4uvvLEDy0rYvgW3vgTYtgan7f9bWTOiz8WU8u74tSg0z5yHwp3U3TAiSf2NmXPz8dChPBjyNzdtDCI2tZFyeW5WtSY5lyejpvSZ65mef4SSO/zubR89LT7dp9BaFXkdc8eKfo/fMgim68BwdIdNeUO97HCRisV0NvQIb7hAXfgEVdfb3K7w7lI3E1Rh53KsO0esJqmqSKCCElLGjAT8QpgwsknUbQQ2deU7G5nRxyL1awXbJMEu1t1iQcfGwtf2HVcDFkt8G6SkJYsQ3prF3nI/DXKKFUQs4ioKTvtcoCCxwUjE0g3FJpKiQIMiy5xgvQNW3S4xs/dVKf/54G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(70206006)(7696005)(70586007)(81166007)(356005)(2906002)(336012)(1076003)(2616005)(426003)(8936002)(82310400003)(316002)(5660300002)(478600001)(4326008)(36860700001)(86362001)(36756003)(82740400003)(47076005)(6916009)(186003)(26005)(8676002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:33:30.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7040aaa-ee49-4010-6eac-08d8f334f89c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Emily.Deng" <Emily.Deng@amd.com>

After FLR, the msix will be cleared, so need to re-enable it.

v2:
Change name with amdgpu_irq prefix, remove #ifdef.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 03412543427a..8936589bd7f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +569,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	amdgpu_irq_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
