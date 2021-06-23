Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA440C2B9F4
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 03:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954F460FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 03:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954F460FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9846E0CA;
	Wed, 23 Jun 2021 03:00:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217906E0CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 03:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNLTb54jwuvP1Vt70Wv13vvHte347eA1ZufGFuEKcsYT5wPtfTDoWqAg5hJOMkgb9l9g5eluk32pGEpAhnsGJkrAEk0ZBRydc8HV2mk2uaUN4H8/rO6HBdgf06MppGVbfNIDYTQF5nNJgCfAWCa85/itdNSy1x0uEdeWuES5qLQ0QvUxNBH1HO6IxdFwqRNKOHvXenhJMr5k8WAqNIEVND9onyHEwRL3KdSUCvWiF20S3WeaZdXSLRiJVBQ+vPep/BzkFW10Sb7GzN7VedCbrpW0t2LE17H7eS1XQY6p7XJaHFbJRr2UbsT1Mnp+qihXLM2rqpUfDV06q8C8gHtYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5yWG6I0YBjsm9JGcZCarpLJUwJY8ExLsyfkuXlt0wc=;
 b=CnvSQM/ya8eOQENtgG8P51JIOIGX8l6t/h+UdtHFaYD0AW9E34xdt4NyQHHYCLvMO/TxlnJN2lVDSGyB9VwcgXFKA4RdPRSfnFurWTM9mt80tYLNGkpW5qkn1NwJUkA5Hga5+DOg1r0NvlMaRur4faIWrmj+e6wKxyJEALaRx5dJbi17/1SXj+5icy0kqsHw4GIRHGVEU1fDp3D1Yj8lqrZXb/MYKKgUlRdD+fXIbeklccnXUPFyMetRk6RR6/Q8JCvH0M2APKXW4J6EbfmnccfOGzXDtg1C5lpYi3e7XU85McosKQclSUqXZmPu00mwC2zkviseFUAOucqJStoUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5yWG6I0YBjsm9JGcZCarpLJUwJY8ExLsyfkuXlt0wc=;
 b=do/Asg0bFuZiCRX8uyMGHbXdnXqzEAgeLIhg3BI3YhLBs0ZVifDoD93/6NUSRK3JlHcbqtZpZadqvjdE4OtTKUAt8BBehwyCdJu0kEDhpRAZxba5z+/5jrpfug3DR1brjf3Tn4Uh5Zy+NNw0G/FpVIr93pheLUg8j9hs1KOLLRg=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Wed, 23 Jun 2021 03:00:19 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::a3) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 03:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 03:00:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 22:00:18 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 22 Jun 2021 22:00:17 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-254814 drm/amdgpu: Restore msix after FLR
Date: Wed, 23 Jun 2021 11:00:05 +0800
Message-ID: <20210623030005.21882-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd0aee1-ebfa-4f88-675f-08d935f308e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2649A0C3480267CC929091D8F8089@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bipg8eWZB3LuzJASh8UsLU6oy9YnMVbWf0v+Q1w80Ftguxd1r0ahjU0XTVyStApedcTC34Kc2b4/i1+rPclfV96Xy2Rp9yNJ2L0vhTyWuncKs/4z9DV4e20pmJyuqFiFZqm6POtkxMbE7EoMZzWmdM1svr5HJspwLLJw4UxJ2C3rZLcUfwDVl/u57uoKs9Xb/VdUfCU7KdNGUwOtnidnpTnFZr3jaqnUxa1k6dpp9Y59y/3rJaNO/lyH4mhKn/YIA+trwOOQXCQOCCJyW25r1rbwM8B1cIBzJqgDJhLnrvJJRnGqI+KoWqgcHpERZSmlYxdWF65rStfuEU4nx9gOeGE2Gw5LhxDa1VR5wsaGcT4c2uRxqFuR47ivFSi78LKHUgUzvc5VdcwmesWNfJxU6RA9BLIYWMX/2nJrD8NNKMFjxYScJxQt5S/oDWIU2ka0kAh2Q09/SYMyJ2l96FKZ9gZFFbuFyLkICkjIK+8pLOQRAaBS4plyRmLtLfAMlZUuM9iV604IgpfyBUiDhTiwZtNx/Bm8Z9uwTLwxkUwC8XMa9q49OgurPYOjqs6Rx07PeV0vwCaMSL4b/cAEbPe+PG/fQAL+sbNDSgEk9E/5N35q+bSfdIZhXNj4c9Tj5JtO1+VReLu9+8NnN5Ixzz6d2Ms+qUNZeVBK/AWGmSCJG3RdpWrkXfkiM2hWNQGWNV22
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(6666004)(6916009)(4326008)(82310400003)(86362001)(356005)(186003)(81166007)(8936002)(82740400003)(7696005)(478600001)(26005)(2906002)(70206006)(36756003)(70586007)(1076003)(83380400001)(2616005)(8676002)(36860700001)(47076005)(426003)(5660300002)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 03:00:19.1405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd0aee1-ebfa-4f88-675f-08d935f308e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 90f50561b43a..ba9edafd4fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+void amdgpu_restore_msix(struct amdgpu_device *adev)
+{
+#ifdef PCI_IRQ_MSIX
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+#endif
+}
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	amdgpu_restore_msix(adev);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
