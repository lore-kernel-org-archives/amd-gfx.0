Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F2DC83F33
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 06:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33EA410E295;
	Mon,  4 Sep 2023 06:05:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCBE10E295
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 06:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYtP/VMUuKz2dkBbmV8YbRDEFrX4exf7QM881zgQOEzXraRk9Ti0jTk/YPR5eitud77W+nk4CtoVg20lQzG8413saNjt91OwVwabbnP8wflBgNSGm0ldu/MCDCsPeJPhVeOhec0T3HfHWEPJr1XX/DP6rltrfWFN90fSNgt7+vHze3ZF2ivhRdAvIfqnJtZG56srkhqF7Xfl/f4smbOVt3k0ydGdkYpZ7SNc/cmODAYrYBQOiPgjPfxxINImiiiWg4u8fQlJEaq3WF8HzCM9Q71FksjB4eHtGp4zmX9xYISoM6gwh/0MZkJ/HPyPYU2e+yVJyMbgn4Gc8OO9OGq3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llt3tIsrUP1zgdJmNmSDnxeP1BnLXm28bi8JiFYcjfg=;
 b=Q9p2G4gDDM9uWo+kmLXdgvNeY7hrLZmSsjZH4BNn193UpHS026hlCOJoU7i9MPo8u1GdXWZVxegMGVEfUX09VeL+97i71uxQdUJ6CU7VO/4ZTAAzTWa8cqqxfa51iQAs5nz0LAySB4ZHn2yEWdRTvoQwA/Y5KK0T+4KcFCIQg7dvyNyjYIjndwh0MsTCkbxgMSENup7rEQ3Qri8NKr8X7Z/swf0J9Kq0zPwzK8B/w2sA9hERFFKHSly2mXIwzjr0iZ30pRcpK/KZNgfAwFlfu0Y0iAL+E1iF+4rMFvnogFgI5VyaK9hxlB4rvc4qb/rmF56GCt6Dhqlzv5uovLVlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llt3tIsrUP1zgdJmNmSDnxeP1BnLXm28bi8JiFYcjfg=;
 b=tNm/wjqiobeDNwMjbg+GrpDbelNnRyDJgsKVtyHqNIRTGRlqBizrK1m22rRVtMPRYouxX74QETk8Ppmk0uEgcR63W1Nk5oXy1qFQLR6wqXfFPo/0VA063W2iRVgb2u3gdSxH74IzgXLhgeYZzeWTHnMshO1ZiynkLqcZcknGxgk=
Received: from PH7PR17CA0035.namprd17.prod.outlook.com (2603:10b6:510:323::16)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 06:05:41 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::17) by PH7PR17CA0035.outlook.office365.com
 (2603:10b6:510:323::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 06:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 06:05:40 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 01:05:35 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd: Fix the flag setting code for interrupt request
Date: Mon, 4 Sep 2023 14:05:01 +0800
Message-ID: <20230904060501.2942018-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: c7227fdb-8093-4710-fd0e-08dbad0cf7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdKmeogqdBsQiyyAUHWoY4X91m0k5pYlfG3JD8t9wTLheTXXXaYnyD4nJX0vMnOOwMhkVdLXDVA0DlkOZ9P7CdqF2kvmBQReywsm5GbWiAg3nxIwoMc+RbqGuJiCRo7Sk/lK5Ws3nN1+i8F9yBflxmIERdI+chQMsPMUpTdjlI9cXpZ8eq8yK74IX2sUyLcAXDmp3MJMuA+kzjsukXYLPycUjvWqtAnNmnKCBByZyNMCNzcf9H5N3lJMiXDYfg/SYEFFcIbSQiFmY2r0bW/t+VxJsPgrGBXL6PkPHKOnxsGTEewj6oNK3W7csLDOcwfDbOKPTyNRV9mDBa0XHQ2K1SYmLbXdv7bknQnQHpbfL87SLJOoVXCdAimFRjnieXHLjUv7G3ddun8SKVUiaV6gfkUS1D/jbfMSjrFWxKPkwN21jXfCQQb604ZYOvdtpaTN/Z362pF/vq/cjPC3tE3VyvyxoKT81UaRJjaKQmD50CDsmc7Tg0Szf/uOhO3r/CTKi7AD9Cs9uUws9aAPXUw9wpDBclPkfFJwy7pCDlRy14Grr5UXD1edl/sajkwx2+vWHngpKn6iawnh2O825R8cVEE/LFTXovzJOxNw3/bKpnAx+TxlbWAa2+NBCFiO26rV2Hc1rDA1WpuLNQSP1lvnZXGNpy7VoW7B6BPd+jwRFWBzs0VpgAiD1UMVDb1oXfQqAXsuwizZWdi2Me1431h7Rb9xmJe9zJ9pbxRWffj2eq7d7fkPKX3Qg4fkY0oWOevNybdgIFKNpfSW49ONYf6qsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(41300700001)(40480700001)(83380400001)(478600001)(6666004)(2906002)(70586007)(5660300002)(70206006)(8676002)(110136005)(54906003)(6636002)(316002)(4326008)(2616005)(1076003)(7696005)(40460700003)(16526019)(26005)(36860700001)(336012)(426003)(36756003)(356005)(81166007)(82740400003)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 06:05:40.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7227fdb-8093-4710-fd0e-08dbad0cf7a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[1] Remove the irq flags setting code since pci_alloc_irq_vectors()
handles these flags.
[2] Free the msi vectors in case of error.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 43 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index fa6d0adcec20..17043a1e37a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -271,28 +271,28 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
 int amdgpu_irq_init(struct amdgpu_device *adev)
 {
 	int r = 0;
-	unsigned int irq;
+	unsigned int irq, flags;
 
 	spin_lock_init(&adev->irq.lock);
 
 	/* Enable MSI if not disabled by module parameter */
 	adev->irq.msi_enabled = false;
 
+	if (amdgpu_msi_ok(adev))
+		flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
+	else
+		flags = PCI_IRQ_LEGACY;
+
+	/* we only need one vector */
+	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
+	if (r < 0) {
+		dev_err(adev->dev, "Failed to alloc msi vectors\n");
+		return r;
+	}
+
 	if (amdgpu_msi_ok(adev)) {
-		int nvec = pci_msix_vec_count(adev->pdev);
-		unsigned int flags;
-
-		if (nvec <= 0)
-			flags = PCI_IRQ_MSI;
-		else
-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-
-		/* we only need one vector */
-		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
-		if (nvec > 0) {
-			adev->irq.msi_enabled = true;
-			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
-		}
+		adev->irq.msi_enabled = true;
+		dev_dbg(adev->dev, "using MSI/MSI-X.\n");
 	}
 
 	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
@@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	/* Use vector 0 for MSI-X. */
 	r = pci_irq_vector(adev->pdev, 0);
 	if (r < 0)
-		return r;
+		goto free_vectors;
 	irq = r;
 
 	/* PCI devices require shared interrupts. */
 	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
 			adev_to_drm(adev));
 	if (r)
-		return r;
+		goto free_vectors;
+
 	adev->irq.installed = true;
 	adev->irq.irq = irq;
 	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
 
 	DRM_DEBUG("amdgpu: irq initialized.\n");
 	return 0;
-}
 
+free_vectors:
+	if (adev->irq.msi_enabled)
+		pci_free_irq_vectors(adev->pdev);
+
+	adev->irq.msi_enabled = false;
+	return r;
+}
 
 void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 {
-- 
2.34.1

