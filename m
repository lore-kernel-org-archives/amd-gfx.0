Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD4606A338
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X/mWr7SV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C58F1126B8;
	Thu, 19 Nov 2026 19:21:41 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F57E1126CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4vkqAVG+OFwTzUnVJM3Mku7fToLMGjO3uPeKWdgSHYD+mcfaJmnkjtbyB3GN3p0elgYD7M1oyaHzpHr51uXdbqqCaCbkGcBj2pu7b49cJz1TnlwGpniuaQSGP+Ueu7Np3h6H7zvDSLwrfL1hbaKZmaO71/gd+0XoO0OAFElmk5xniNa9rRlhBLt+PhkCtKAosUhOMd+hAvHoqvryiSnQC8t6WuIU14nAwNrEs31b1Ybk8uB8Z77xwP/O3EA1jCClxdm4JneDQFGW2clU6yotwPUCGdT6bOkTe9dYDK4QPhXV9+Q/La9cU2iYHabVMH8D5urZn+xp9iIjI95TfFY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtEYVFDdXNxsjVQBLehMt4rHF1J0qP8gHkzkz4nJKTM=;
 b=IsqVvI0bAT73OKVLUdeWIh3YuVV+WtdG1EUHG5yg9IQnSwIKK7TDn/cxt8t8riqOG7IOsqdMM4I+70YuHyAvjtxRAHzxaLaDySsJNa0wbTOYy2gqXBmEyVQaFBc5zOcLjgeuTXJboSWwaMQPmjxOMNdj8dsoFz5sCcw6PVQsNkxjIUPrE4Dql1u6Lqam+EcyIdujneaE1OoSYnhtMFIfEv4zw1lTH1HKYr5iWcLtexiz1MAnM/WPv34VT9Y63wqNr0uuLODjV7pXxNVDYb1Km1X3Ffxfx1/glhgXn6V81jrTlagqBatinvZBGTCR0oMwGNoMYCpGSlannaU3Nd8kFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtEYVFDdXNxsjVQBLehMt4rHF1J0qP8gHkzkz4nJKTM=;
 b=X/mWr7SVnwhz1VyjWHOZsvLrMWBs9mw4/xrbYvqyfE9uEgIhdN/sPtH6wnVqKza26O26D25FlAZJqy3yhOr7reHtOOuX4I78W3g5oIpvjwtUR9RqBALR/g1lRwf72X6lLh7Fn1LsMgG5ycAlY6RQyHCYcxrxhD2ADcavqjNNruQ=
Received: from CY8P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::29)
 by DS6PR12MB306834.namprd12.prod.outlook.com (2603:10b6:8:4c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:21:27 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::87) by CY8P222CA0005.outlook.office365.com
 (2603:10b6:930:6b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:21:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:21:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:21:25 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 13:21:21 -0600
Subject: [PATCH v8 3/3] drm/radeon: Match VFCT using initial PCI bus number
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-vfct-regression-v8-v8-3-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
In-Reply-To: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, <linux-pci@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|DS6PR12MB306834:EE_
X-MS-Office365-Filtering-Correlation-Id: a11172d2-4002-4065-8529-08df46724f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|261022075727099003|261021123027099003|261022115727099003|11063799006|56012099006|261028144727099003|10067099003|261021121427099003|261026140227099003|261022105027099003|261102123227099003|261026121527099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uzEYQVDb+Yyxgd7qbCP/4oPw1PXhN0bQfgfCjO1nREZIH2qq192azc8jHs8gf3OUl+n+ZJzguilNwE2C4+mH65gTx16vlMB4Ycg7cgewJYzk4d6CixU2kKOUP7dcyybRn1jpPU9phaIpAqTw3oLAJupYXieVskarIyNFsdfIO2mqHKastv5e6yTW6pw6uQwT7EvAWf0eUsh+hccU/z7c1gjS6rlPrXlRGO8MFOCdAaBXWrjpUAIdU9mvcTx9m8QTlHIhP9YzQy8OPgTswxy7pqi06hGZ63jtqRiAr1WNBIRaciHceSm80ldGUVxoIPGwRS0EQi4QM8AJgN109TMsQhy3kusyY7jpeE//BMU97YwFDfNnYDBsobhRSq7ZY0OR28XDm0YTJz9fUdP+Asw9S0LqbC8UMRimu53A+hyxMsbhiy4/Kaf2gNCj4EkwZz+Ktsf36mhI2YOErj34U2veXPjfpF9UM5S+rguhaKXRqIeAYdSD+jznPf5pnup2kr2sXpjEBC8cRdk/lvVKJvfK+FnfUaFtvjSBGIIX/VF7AfT7xqEEBFUs2M9Ko4FJVbtN6PXe42QKloafv31ND1DZPh6+260tU8w5IqSbt4bNzpADC8bV8jLB7CSkDQqtRNbRu4Vp3TzC9Dv6SmwaggdDT0YDsRTzbK9dkUOAshYGvlBUN2F2w0g87ZJ9BuAGMWvQhMhRsbxDr+RsB/XGlFsqpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(261022075727099003)(261021123027099003)(261022115727099003)(11063799006)(56012099006)(261028144727099003)(10067099003)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FpOAKdZyQ9bV0WjUiGDzCGkwGdiXkx/fqKMheIaJ03QFzma5b5fYs7KOgsmxbhrgGyevzpMDvE6IzIP6/8Yr5EW3OEihjFfsftqRQKOt0HPgHOQ3dPT5plAkceENZIzd80ty9MzPuC6P8qLT35/6RLi0Ih2cnRpKXfyFf7qU0VuhgZhgsvsXxVyUxZJiHPGH0Ijiqymatw4qdxxWlb/LDd5GWnFb4w28Oje8trTAY7UacIBJiqIDfKR7Ns1kfkI71xyHWlyFhfPRQAlBM6U9CZtXAqnNzrfzkPS/Sb2i9Vs9ZiNqc9eB0pyGciMOHFw9CCN41oux0ipKmv/wD+Zbw0rAbQ6i1w1ALCBlw7o21ZaU8bMs7stvASxiPiSZ0o/87W75J8bIYvuC0ipQ6xPRs6O5BqYknf5DGybxfbG97HYAIk/p2D7RqKVJ0thUcDaE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:21:27.4673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11172d2-4002-4065-8529-08df46724f07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB306834
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present.

Compare against the secondary bus number of the upstream bridge at
FW/OS handoff, which the PCI core caches before any renumbering. Fall
back to the current bus number for devices on a root bus, which is
never renumbered.

While here, return a bool from radeon_acpi_vfct_match() so callers
read naturally.

Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 42 +++++++++++++-----------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..869240588eb31 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -609,35 +609,23 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
  * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
  * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * value.  Match against the secondary bus number of the upstream bridge
+ * at FW/OS handoff, which the PCI core caches before any renumbering.
  *
- * Returns: 0 on match, -ENODEV on no match
+ * Returns: true if @vhdr describes this device, false otherwise
  */
-static int radeon_acpi_vfct_match(struct radeon_device *rdev,
-				  VFCT_IMAGE_HEADER *vhdr)
+static bool radeon_acpi_vfct_match(struct radeon_device *rdev,
+				   VFCT_IMAGE_HEADER *vhdr)
 {
-	/* Vendor and device IDs must always match */
-	if (vhdr->VendorID != rdev->pdev->vendor ||
-	    vhdr->DeviceID != rdev->pdev->device)
-		return -ENODEV;
-
-	if (vhdr->PCIDevice != PCI_SLOT(rdev->pdev->devfn) ||
-	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
-		return -ENODEV;
-
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == rdev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(&rdev->pdev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, rdev->pdev->bus->number,
-		   rdev->pdev->vendor, rdev->pdev->device);
-	return 0;
+	struct pci_dev *pdev = rdev->pdev;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+	u8 bus = bridge ? bridge->fw_sec_busnr : pdev->bus->number;
+
+	return vhdr->VendorID == pdev->vendor &&
+	       vhdr->DeviceID == pdev->device &&
+	       vhdr->PCIBus == bus &&
+	       vhdr->PCIDevice == PCI_SLOT(pdev->devfn) &&
+	       vhdr->PCIFunction == PCI_FUNC(pdev->devfn);
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
@@ -676,7 +664,7 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 		}
 
 		if (vhdr->ImageLength &&
-		    !radeon_acpi_vfct_match(rdev, vhdr)) {
+		    radeon_acpi_vfct_match(rdev, vhdr)) {
 			rdev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);

-- 
2.43.0

