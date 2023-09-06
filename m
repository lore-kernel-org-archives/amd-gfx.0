Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6FFEB8FB5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 06:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68DA10E04A;
	Wed,  6 Sep 2023 06:55:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775F510E04A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 06:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1vreYyOewul0+A3xa9S+abb4hFK7Vq3nf+qgNi4AhgOgrpnKFisMYCVAstibBf2ERAO4AtkzDfVOQW1llCiLMiOr3M7wQvrXXF3+v3prEv0RajzeHQauPHh820zY2kW2QII6b3ojFec9iW4ImxoQ4lNLYjWOIUHRj8+sf2g31xCkN7jTNt4C3rU2NfmVsj+I3fs6r2pJJSPTn/BCFth1MhGCGGDh7APirEvY5egssp48l5YKfEEox6RfFmh6bAddWWSBJw7d6Ac3fLmVE+v1QxlfSx8/hl1VPIjKGesPaZ0DSXG0eAEFGlufc/0wCqF3eJoJjN/mdxQA0l9zsx9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w4H0W7JxBnqZFQTaasPTEkuPcPgI3hX8i9sln8cpGg=;
 b=ZHhLqIzr50RVd8TsTYDAWbfO4yf+xDiebl4E1JH28bSsxM3TB6Ez2krkVviDC3F+1q3mgQ9v8yc4kWeMlHAGZTwM6anT+eJi8FCs4O6O2rR+P1AfqTQwYJ4dq4rnll5znjqjm9tSLYxZLz7nVIphxcVV/9xHQsNlbT6/H9Q+7Z7bSD4coz1hJqKSsQLTXReX03shuN31p9gHw2QTv4Su8cJUtnmA0E1laGx5szAkSAwCZ6g16jlX7VYB354gxerWlldqN+oD8CG9QdCUFaW6M6NVtfG5DJIAyElHRAo/31cEaAmKPEvIKn0MNZDKWrGgr8i/M0XiZ2QV2xOHANIukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w4H0W7JxBnqZFQTaasPTEkuPcPgI3hX8i9sln8cpGg=;
 b=Qp1dLtXOQBUuClAwGl16Wo97STLvcZSpFOX7okQwt3gMwQuTTFBaDU1SOPlSw3X6CtF+MIDBwYaX9oyIwjqdcR/vvghpBAXgg5bekLTBdLociIJYCG3UYIWdnKgrT4Z6LJBbPKq70N1CIdDTDuOY+7b1TGFWCdvsBwdx61pl4QY=
Received: from MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 06:55:55 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::ec) by MN2PR06CA0016.outlook.office365.com
 (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 06:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 06:55:55 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 01:55:53 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amd: Fix the flag setting code for interrupt request
Date: Wed, 6 Sep 2023 14:55:32 +0800
Message-ID: <20230906065532.3340082-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 2156f262-4948-499d-9a5f-08dbaea6511e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAmiGSYVHJ3uScTBMx3Jy46/u4cOg+lg/tFkloQKKsK0MDUTsXp+9fwYh0sDy/Xoati5K/EI6iCN/s+Nrlwmz8ho4NGZtieJpTeaMbLdnyIjYYbo13TtlcyBoN2ydBhA3zd0iqpOUtrEPtF6Zz3jhhXnUYVNztr+Orjb9yUWdkC/uDMQj2uaWS4AQ4pJhjNoZg36C96wTS39IBh/bzhKEBUn0BAsmpamOqgxoyfsnLgDxXC4BmSDpCHKHg1sj+AnhgE88lBOvDGNpss7Zezka2PMzvOX1koYALf01+r9l8XQOpsikwXlv+DFVuUdQoJ6C9vc0GKFcCiAwhOQcP58Z6gV333TYTSnso3YEwq/6KznUUBI37j1MQZoD65FoPRLiqOwV9WxBBPhys85o4k3906qkXuzZ9MUYtj/ot36UyqegjymBp5U6o1Ner1Q2kwOXHz+DIMywd6Bdg/+sCbtvfHFDLC60WZIqsT1UBwGBmybf+lip6rKzkIGj3XzKHJp5mSQ0/H7FeKZQR5cuEmjVRMJpKMt9j35e40nVe47tbr6jwwTIDASLMxaPXs/HhysG9b3HYTEr041gIqTzhVYuHmxEGGwrbF1xexR4nHUO7BM0Xo9wdWK0cbPORa5WS3mPEUZKE1lDUVsLO25HIZLbVZi0EeDEusDppqsg8D6IjIcEc8ZW5WKZcly/hcbTBLK1E4ElCztNoQDWDyRUrfYyOwIyxT4fGFA4ld67SEj3OdOCShsRzKYXNRzS2nx5HNsM7tULCXhPebVgoM2m4ktBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(1076003)(70206006)(70586007)(110136005)(2616005)(316002)(54906003)(6636002)(8676002)(8936002)(4326008)(82740400003)(40480700001)(81166007)(356005)(7696005)(478600001)(41300700001)(336012)(426003)(16526019)(26005)(83380400001)(5660300002)(6666004)(2906002)(47076005)(40460700003)(36860700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 06:55:55.1352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2156f262-4948-499d-9a5f-08dbaea6511e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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

v2:
- Remove local variable initializing code (Christian)
- Use PCI_IRQ_ALL_TYPES (Alex)

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 45 ++++++++++++++-----------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index fa6d0adcec20..64c245015e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -270,29 +270,29 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
  */
 int amdgpu_irq_init(struct amdgpu_device *adev)
 {
-	int r = 0;
-	unsigned int irq;
+	int r;
+	unsigned int irq, flags;
 
 	spin_lock_init(&adev->irq.lock);
 
 	/* Enable MSI if not disabled by module parameter */
 	adev->irq.msi_enabled = false;
 
+	if (!amdgpu_msi_ok(adev))
+		flags = PCI_IRQ_LEGACY;
+	else
+		flags = PCI_IRQ_ALL_TYPES;
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

