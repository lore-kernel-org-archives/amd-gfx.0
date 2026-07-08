Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761BC44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8665510F25E;
	Wed,  8 Jul 2026 19:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSx49MPW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A3E10F25B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaTNzx/+/CxspLTFBQ/52R5tygsxWqwezKTVMME/8W6R/ebqrrMskTLYZcQmyUBOS68SJ6brC9JIWhHz5ME9wC1nVLUaw2j2lr7el3tRjzY5xEut1wBmNoLwaqKGhcvMoiSt845+x/tJfnQda6BDJeGWybXxvbD7Pwm0mZlrK0MFDqhjztI7zo0w3XjB7Xp3XdG3Jwa+giF1aCWOcPjfXJYU8eFyITXnISjCnQXN3uPipDw23l5Cnk6tOO00IGbBwqkNg1x8QqQq36x2hOmoMTKj8/n1lg1HOu6L60ZNz9SQjcexxy/oihUzlbCU/DhdTJk5zKU0XJvf85/fKBmvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPO0EFWWna9U20zPWL1mKyjRsWDFlWPYZi1CQ2fXP0g=;
 b=W2O2wnuisus0dxjRMXZepZ9ih6AHYaOw3RbP5ivjZiA6PfMLFdi6mdQ7jfxo8/oVFqpmqRY9sL7gFhY2IQ15JUaohH9fYY9BaNA09488OQN7E9542RphsZefyxv11DKGJel98FYJKZZ/VzzdmunOgS5n7A/tYyfLBy/3uBQuInk886h2eajHO2DcKJ5nH0O152jbLHEStyGFe4y07ihMJe6WESXFJqimIXCWnL/aMYXr4282i9I/NZARv79MCMYL13IYD0QJNZqOp1w2ktprmoJgNGkPdRsMTFj22LUIMUx3LYOaZvDicwcvHRBX/30vLP4SwsweXmHiveTYIzoZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPO0EFWWna9U20zPWL1mKyjRsWDFlWPYZi1CQ2fXP0g=;
 b=RSx49MPWs8rJkxEY7hBEEeuxdbEKJXhb4nKwIWHVqt/ZU3RFzAT4Md81bexa2hyZ52M/sjj/Zk+31NGkRzTO8zbQbiXsUFaVEdBk2cDl3tkKjkBV1ABFfwQJZhXF8RKPamyENnkQTo/7D0ciaBgcZkLFqWKzFIpjJwwiqWG2k1o=
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 19:35:32 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::7f) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:31 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:29 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 1/5] drm/amdgpu: Fix VFCT bus number matching with soft filter
Date: Wed, 8 Jul 2026 14:35:14 -0500
Message-ID: <20260708193518.702584-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708193518.702584-1-mario.limonciello@amd.com>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6d4382-59b6-4fef-e279-08dedd2812e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZLkNVzovrMoTMLUkrAA2YL5EorfBWsNLSk62fBiPf9XNMvAwOuxhMKe7bfArJWURAxogzfqEGNrYCl+fOeYTYcFRtNQJ6JCQKdO/eSRo2QvvKS8cRLMjrqlrmnjbPpjK6+neDTe6TgD00nPGQz4bgzGMWp/Zgohd+NARLKGKD0qzSrOG0pSYHR5JvKYCaqaQCq/L0cK41xFzoyfJ3g79nKy5FC1cVDuWNP63aqlzK5MPI6geLTViLU4okMUKEHIs0CU85ppT+kE7u4cZS9CVUrhpoSZHBOADL37jBDsW8b28AJbA4wWGi0MIDwClRQu+MP0BuazZcHRTlktoMc7ILIHQY0P5xWqO5chMOynmkNkaIKI5MegSm5BVejxMNi55MxXvoyMbRNgM3VAW2YUoszLybRkMHJEwAC9RUO+FNtpa5be/1mmeNZs6TmhGW1Ia70ZvE0UlZN/pOoyFDZrErcQboiy6xCKu3jQpkldP05qOmcXnqQSSYbEPQaG+m9Hed5ziuEJ99crOzv1FiqTMUOkz+tcgweSNsUPg0N6ejt+ZV+nOu4Tm2bfikuTZUxr6EcjildMPx05uzB415Bb2waZGR+9OPGvVpT0ilTns4eobxgOsXj0EsushP3Fvy/vu8riz2J+xf6tSsrKwlN3ELvOdufeVIKFTnSDhW8u6DM895lEkVtKimQ7J313Rkytv1SUQiRmJySOGQguiDus9ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kdX6uqS2Co2r5ex6YlwhCowN8Kk4IBn8TYJLJ2u9e5ITTukn+SdwMGnZ2OTtjkRHu4cCfgqIoDVYfYX/jAyNr63UdgFtpInfnFR2qmSOHS1ve02fMUGSG5vGP4GTm03YPp9fYEWi8stpmyJqXTvu0dnZ6CBuRa7xFmPGesbDX06HtonMNHpI4T3yc+BB4utyU0qZksMfcYflRY1vbWfFJ5qD7OQLsgXDT8rEPaKZ9gLi3vq0FulYP7q0SJnAqdLUiTKJ+08CDkgt49Er9E9HHv1hEOO2qYAAMrkrpEcsQah/3A7uplk1vINNLJr0uSHJM0/vNfpCjVW2x2XqO+o8G6xAWvB/BYDE6vtzH9CaCTxRY2pBZMkeb996MuPBcZAs+z2PZdo5zvFx3VW8jTZdbwKSeNmJdnwCwxRsZuVZRO46/2P+ngFrKt21lea0AX99
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:31.8390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6d4382-59b6-4fef-e279-08dedd2812e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On systems where PCI bus renumbering occurs (e.g. pci=realloc,
resource conflicts), the runtime bus number may differ from the
BIOS POST bus number recorded in the VFCT table. This causes
amdgpu_acpi_vfct_bios() to fail finding the VBIOS even though
the correct device entry exists.

Introduce amdgpu_acpi_vfct_match() which treats the bus number
as a soft filter: vendor/device/function identity is the hard
requirement, while exact bus match is the preferred path. When
bus numbers disagree but device identity matches, accept the
VFCT entry and log a dev_notice for diagnostics.

Reported-by: Oz Tiram <oz@shift-computing.de>
Closes: https://lore.kernel.org/amd-gfx/20260621173211.28443-1-oz@shift-computing.de/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++++++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 3ebdd792feec1..d8fd047295d9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -377,6 +377,45 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
 		false : amdgpu_asic_read_disabled_bios(adev);
 }
 
+/**
+ * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
+ * @adev: AMDGPU device
+ * @vhdr: VFCT image header to check
+ *
+ * VFCT entries contain the PCI bus number as recorded during BIOS POST.
+ * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
+ * resource conflicts), the runtime bus number may differ from the POST
+ * value.  Match by device identity (vendor + device + function) and use
+ * the bus number as a preference: exact bus match is preferred, but when
+ * the bus numbers disagree we accept the entry if the device identity
+ * matches.
+ *
+ * Returns: 0 on match, -ENODEV on no match
+ */
+static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
+				  VFCT_IMAGE_HEADER *vhdr)
+{
+	/* Vendor and device IDs must always match */
+	if (vhdr->VendorID != adev->pdev->vendor ||
+	    vhdr->DeviceID != adev->pdev->device)
+		return -ENODEV;
+
+	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
+	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
+		return -ENODEV;
+
+	/* Exact bus number match - preferred */
+	if (vhdr->PCIBus == adev->pdev->bus->number)
+		return 0;
+
+	/* Bus mismatch but device identity matches (PCI renumbering case) */
+	dev_notice(adev->dev,
+		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
+		   vhdr->PCIBus, adev->pdev->bus->number,
+		   adev->pdev->vendor, adev->pdev->device);
+	return 0;
+}
+
 #ifdef CONFIG_ACPI
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 {
@@ -413,11 +452,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 
 		if (vhdr->ImageLength &&
-		    vhdr->PCIBus == adev->pdev->bus->number &&
-		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
-		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
-		    vhdr->VendorID == adev->pdev->vendor &&
-		    vhdr->DeviceID == adev->pdev->device) {
+		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
 			adev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
-- 
2.43.0

