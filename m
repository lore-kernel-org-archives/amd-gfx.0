Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C96C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 05:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E446115A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 05:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E446115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8056E9E3;
	Thu, 24 Jun 2021 05:31:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52BA6E9E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 05:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ8sAtRHQlDJD8Qfe+/48DbGPN4A2CmPOCHcXDpw4KxyYH132KX8+K9kBIff/pYALoLcEqHm/z/z9eVhNNwkGCCET9bLhgpEdTzkRyaOQ3HOvYnwH2NJL6o+jzWh5V620acEbuHEjThpyt91zgYV9BKL8J1R3uXmdIrB7XFW/g1S4qm3xlQtaAQP5s3vh52ZWNNIfyWSiufGJ+KFCYNI3yvxfCWkiTgOjPDz1zGd+hE2lo2Megai8PpsHUd2dnKHO9keoZ06Cxwn7lNqKSmP90CuHQjuUOxAWNrhYhNZ03rX40V8lNJmCjX6KWc9M+KhFfU3jrpKWUMTSZHWNE7GbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7562Q7Iy5r7hNzFbUi6lK3sfPPvX14NtGh2JPOi0I=;
 b=Pqfa2z+N2t4SQ+noMWDn+a1SEHCLcdw0rd5/xQZFsg7Ge461VrGJYsY65hWOmwbVa0lldHRf40AOy+EXPfNMLV8/lN691kh1ATuaZU4EyUmM9Br4gqb09lIQA2oxn4n37aMAgjGAVnOaUTw3s2xV0U2ylhKNVSHcfdzqckPwkwlLJreU9wEPby67j43Z5LoCjDu+N6klKJ6OPriATATcWzzEYgQ6sP36ugQ+FrLYJvH+QU7g5vLZBAFQH5RNrWy9Fjs1okN9ROIGcJymoU26c0qRLSgUTr4lvidtwMCIrX5iKqHKNKaailEsmNf8WLmxvw7bKyLVHPjwu5jQYmpclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7562Q7Iy5r7hNzFbUi6lK3sfPPvX14NtGh2JPOi0I=;
 b=gPqvJ06pUv+TuHX+mmE0jfwdGSniqHc7UBx5qUgxWrZpj4hEWcfFZYa4C8hXmwOUXp9NnLquLl3sfzzk/IswnHvcUrLJEXLGp/JLfrmzFDcAFEX16vygyAjHqq9fcOzjQEFZ0NpTXfJBpjmLXlH1EAxZy/V2aKzOBGhvLxnCaA4=
Received: from MWHPR13CA0034.namprd13.prod.outlook.com (2603:10b6:300:95::20)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 05:31:42 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::6e) by MWHPR13CA0034.outlook.office365.com
 (2603:10b6:300:95::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Thu, 24 Jun 2021 05:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 05:31:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 24 Jun
 2021 00:31:40 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 24 Jun 2021 00:31:39 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Restore msix after FLR
Date: Thu, 24 Jun 2021 13:31:32 +0800
Message-ID: <20210624053132.3458-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204abd81-8560-4fcb-6116-08d936d15923
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30180839ECAD29AEBA365EE2F8079@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXOgxcAPkIUTrDHfcdD6hNHssdVxpcrOlIoS6s2yPKe27tPcHn9o+1k4ONKubExPySrn6ezrkzvG7W0nDdh34IitybqTVSnYOPPO4a9BDbU4xDRSS4mHOyZrG5anH8vJJfStHszm4ZjVKUn9J6YJe3OyyKOrlIv33zHRt3SP3Lenv6Gg+RETLOXvayDHl9pnOImI5pbQfVAhOARp9ecSUVffGqad9xyX6uHstQo2iN0AZct5xja7WXmAqZdDjvf4QN2bVeUo/WglxglV6JkTQoMPgNduxwBnmkrKp9lyPEC+oK+8c2jzTwDRH2Cuac1gRjVBBnodGwceaLB11I6J8jHIjdrO0EOyG5hT+BxdtKmLO9CTuX4G0IT00G6FpCs/vTWBs7EQL5MwIdm4cGfxXYFCX/tnkmmXQ+KA5F236Vx807HfFxa2COhWM8W22obWwYr9SYMGrGh7pcXOk3jx0xp1YCVkqBixwBoOQ9H8V4PlbXuhb60l0GvTdGKaLbi3YaIR9Hwz6mCQVwzD/IZFzmvNm6mbnagiKSxIvhCbu/nxaRWbPxots7o1+71O6QT3OcbauKFnuLtltVVmEjoOGKiUn3M9kgKLtlCZbQHl+QqVpu8Q+TyQziZvycVnfwhEERomIT8CM1D7kVMIGfi69d1A6mxkrsgsNciLEh86tJ3n9+TnIAw/hOQLMYTjxCj/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(36756003)(7696005)(54906003)(26005)(47076005)(186003)(426003)(2616005)(86362001)(316002)(336012)(4326008)(2906002)(83380400001)(81166007)(1076003)(5660300002)(356005)(36860700001)(6666004)(478600001)(6916009)(70586007)(8936002)(82310400003)(70206006)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 05:31:41.9522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204abd81-8560-4fcb-6116-08d936d15923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
