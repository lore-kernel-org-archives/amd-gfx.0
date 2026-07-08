Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1103C44503
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 19:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F45E10F25A;
	Wed,  8 Jul 2026 19:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzF88wyI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A04E10F257
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 19:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5ZXP4MtrNNrivfCEtO8mNMeW4vPKLtAQegOXm7K13VOXdbBpMa4n5ZNytNK8NcnRTxY3hYJnd0ybV2V/NddAjRYFoJO6OjjdncRKn/tzzug80QVAPOVTfT5brT+zOoXLLu5KwPnY24n3Xz9OGtQd2w6raQKpc2Tu1ZRF55aY21jGf01U8b/NerB74I9JASeSjJcQWc4rVcEiZ2wyM6aCf6h9ylAlPJ3+5GDkGwhdNNl0FhgRbvlE9wbW8YD3sgpAJb5ijqw55GW4tNthA03CSdWyI0bIe465MIvY+xT/UGfwzSlO/wCoaRcl80ZqfuCrp0VlMM68Cgi3eyaLYluxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cD8XSkyonIYIfiTzkFAc/tqRVFjKFotEgyF7gNw6bw=;
 b=rXDkzXRwbJVe1LtnB0+sl1GCJQGSoTVka4uWITflUFv+OIupF4LGGGOirXdakeFhxL0L6Y3GOe1/j1PyoLk2EA/IHrYb3VClil0ik9Xz+fpus4PB10PIv7K/415Uj4BkiXZSKK2qt+YsTk07aHvGeq2cPuZnwTAYRKQI+m+B6zzUzqw4D8BHPzFMAS8M3KKvcsn5UyizRWL1u2LQo1g49tgFM8xGEAfP+SDoLRUSrWyLhhhHNjWDsMWAjjCZdJE+Z1QhiTimgRm5kwSK6xBr7O4ft2lzavFH4XvH1rtIbwQI9DVxgRCiApnkZH1Nf7/3Xt5F7yMfETVKQo9yPS0sCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cD8XSkyonIYIfiTzkFAc/tqRVFjKFotEgyF7gNw6bw=;
 b=wzF88wyI+6zzWfjBwL7Y/a9XVBqDm97S1HT73BaIXJXiEaKww3KY5XBzljtaTxteW5/P5BM9OAyqzQWJ1xW5VKNjPTs05oPyyebU8vcAZaXQNu+xSzEme9zzXNMgz7GY7I/9i07YPQko/VH1o5hbpMjfVrjELdUwhZH85FFw8q0=
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 19:35:34 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::1b) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:35:33 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 14:35:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Oz Tiram
 <oz@shift-computing.de>
Subject: [PATCH 4/5] drm/radeon: Fix VFCT bus number matching with soft filter
Date: Wed, 8 Jul 2026 14:35:17 -0500
Message-ID: <20260708193518.702584-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b69b1a-74d4-46cb-5f8b-08dedd28142b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lk3QoUfXImXw7l95IOLFW6CWw4xSXqiMeLhRR1i18Ey5ifVgnwxiO4092YXtCj9MOBmZsvy6JxPeEuNrkS5FPVljNVIjadukPlZKaQ0i/f51SRpVWv63oaHn++WXIwTx2cWxZm3OgZuDGD9PDTMRIyejudh5zxlgCMSLArBAkquR8ZN54C/tVBc01qTvKr0RyjPq3Ii1L79RKtj1ri4HtRyZzzpkXpDguIKT8WlVrFV1sn6HC3bnZCEtAy2bOlwH6sXNoR6pBotoBkyIOmaPulGvM3I4YotQ14J2N8md0g63cNQKLvd4TVri5TIgj+dYWQyxj2qO+OqnG6q3T5fU/EOC3vQ3sqjMN/6MRlGd2RiaNHZ3jWiB1FZbH9AMvbEHMC4y514mpj1yv7EQdQ0TC5LoWXIJDQzQaMMNH9LGTBdryq9OZ2RlXttcV26/3GPVsdDXyXzJ3YjahNZ+c+qasaKOGjYriC+bgZJLHkHQX7L4c1aGS0EvMkfZ5reCVuNEWWV92wvHfER7Ny2tTjVklPRioUh59Fy9rxeXPmtThE7r3UqEqRVapTdpZVZCBUjH5wPHvHcVLzJyYe58esA13m65q6rZWDMqcDKMdQ3GK8HGyoqDDA1M/vZlfgeWFO/Un39ChX0uyi3AyOXgM09CvUVJP7yEWVkiuwQ++ZIwEcfdxHXCIypoESrwpPz5aCQ3nknh3Mqa/XbPb4+IVnt2Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u4YIZihrGcfx+ItPauuInoRtpB2F8/8zwh1HXsTlUD6Ih7I6s5RrBPi71aJ2UNf2QjygezIpvs72dHwh8wiN3jRTgQEl/Paq+0hvoSxIqHITFBNPxeaIkBq5YSKy+iimjD/OJ5yucx6b93oZmRmS4FO3Lms7LqpVhsELsRc8cFmg62tFCdr6CkGhW/zB/xdn71rRyBFj+KUi3ZaVv+Qm/6pnhWJsZQsMyPmWUP8qLUtuD21PghUi1PYkGEfaPVxWjkPeDLoeJ/5v+9Wy01I34+zQecg/9DJQkKA336K/Azuyz3wZgZ0ZF1QI0Uf5EK5zmQIo1vkQwsjdxajm0cLoyp121zh3ASEix3kGWTs9tHJBf3FUYN6FRSGCS83ia6U+2WZAAzJLR5LloNaxI5VS/Tkz8ytRTeEm4C+3yLulSyiQdxi2/t499i61xfJnFzq5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:35:33.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b69b1a-74d4-46cb-5f8b-08dedd28142b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
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
radeon_acpi_vfct_bios() to fail finding the VBIOS even though
the correct device entry exists.

Introduce radeon_acpi_vfct_match() which treats the bus number
as a soft filter: vendor/device/function identity is the hard
requirement, while exact bus match is the preferred path. When
bus numbers disagree but device identity matches, accept the
VFCT entry and log a dev_notice for diagnostics. This mirrors the
equivalent amdgpu change.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Oz Tiram <oz@shift-computing.de>
 drivers/gpu/drm/radeon/radeon_bios.c | 45 ++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index c6df799c3cf4a..cc10880af096b 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -596,6 +596,45 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
 		return legacy_read_disabled_bios(rdev);
 }
 
+/**
+ * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
+ * @rdev: Radeon device
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
+static int radeon_acpi_vfct_match(struct radeon_device *rdev,
+				  VFCT_IMAGE_HEADER *vhdr)
+{
+	/* Vendor and device IDs must always match */
+	if (vhdr->VendorID != rdev->pdev->vendor ||
+	    vhdr->DeviceID != rdev->pdev->device)
+		return -ENODEV;
+
+	if (vhdr->PCIDevice != PCI_SLOT(rdev->pdev->devfn) ||
+	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
+		return -ENODEV;
+
+	/* Exact bus number match - preferred */
+	if (vhdr->PCIBus == rdev->pdev->bus->number)
+		return 0;
+
+	/* Bus mismatch but device identity matches (PCI renumbering case) */
+	dev_notice(&rdev->pdev->dev,
+		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
+		   vhdr->PCIBus, rdev->pdev->bus->number,
+		   rdev->pdev->vendor, rdev->pdev->device);
+	return 0;
+}
+
 #ifdef CONFIG_ACPI
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 {
@@ -633,11 +672,7 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 		}
 
 		if (vhdr->ImageLength &&
-		    vhdr->PCIBus == rdev->pdev->bus->number &&
-		    vhdr->PCIDevice == PCI_SLOT(rdev->pdev->devfn) &&
-		    vhdr->PCIFunction == PCI_FUNC(rdev->pdev->devfn) &&
-		    vhdr->VendorID == rdev->pdev->vendor &&
-		    vhdr->DeviceID == rdev->pdev->device) {
+		    !radeon_acpi_vfct_match(rdev, vhdr)) {
 			rdev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
-- 
2.43.0

