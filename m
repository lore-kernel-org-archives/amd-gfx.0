Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D71E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C8510E315;
	Tue,  7 Jan 2025 16:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtDSXlmh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE5E10E315
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC9dc1V/C/GzkbWL37eLbVI17hksNuqMKX38YW5Wuj9wL2oZm8U4Gh5lwPzP4gtLGH0ZfLlYjiYVDCw/tsvL6AD/0QHsoz8ruU2uVy8ud67BOywoGlkyySG6pfgOETTBh66QPbcZpBKJ+SrZuZHvn+y378GDvc1MrU3fmIPV+vKs28FkvntZTi+IQFMUn5+S0aSka6V1YtY5XZOB/za9wANxZCNrwj/BzknkD2Kx4JF9n/wpBU6VuqEgY5HOZMUjtCFwMrgjGjp9Q48fT0Wr8/k9wdNLM6+K+2QL3QEtW/MavumlqkX0xWUH41zCFyyURV9+CAG0tgjbaD7rPJKVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECGr1Gq3BaGUzV/w6I+xYTGW0iVQzhsowj2dqwDA5io=;
 b=kaVhr1YuAF6r6qsITwuIRuhT1Gkxdc9TxwGOy6/NAQueKypzndVtAQGT8fw42WYhseiWHi4EAPy+RQC8ox0EapHxLIu6s8D64O8h6N/UBatWe9eVAEARz87i93n9n9g5ZmaO7bUtVkX92Lq8F4WtvykmRkThHjQHtGSaGvaTlEGuxzsmHPdi4HjVzgSSuuBSV0O/GycjKwEGv0Z050LUCx9bexMZ7uD+sYV49OwrZXpD6AbFbl8Y9IkKK2yLKRUGCHSY0GWKpqN4bMcR8edrwzmx4H9aQvX+AP2PrxZrrP4x5Z2QYwufMdE55qb6IgyxrGOywqgmW3pvQlof4FPQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECGr1Gq3BaGUzV/w6I+xYTGW0iVQzhsowj2dqwDA5io=;
 b=WtDSXlmh814+c9aabw+C4/SRb70snKDznfBfUkTdjahDfmmLEeXdO8UsCOf4d/Us/jEjEBCf0KtIew+jYE0b7Gu6So4BqBnGQOkzRps2/rnXQMwesnFJpcdtX59iULX6ml0xU0/lOtJYfIkNqvF275OOWiz7DuBXbGnCxCv2Wm4=
Received: from CH0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:610:e6::21)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 16:10:41 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::f2) by CH0PR03CA0286.outlook.office365.com
 (2603:10b6:610:e6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 16:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 16:10:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 10:10:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: cache gpu pcie link width
Date: Tue, 7 Jan 2025 11:10:22 -0500
Message-ID: <20250107161024.73371-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f614c9-5b2d-4e8b-ba80-08dd2f35d53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bPc2vGBgV7CcXTZYJ/YU7wj0V1rSQ0s27iWiq+KEGR5t+RvYjTVaV5QCcMzt?=
 =?us-ascii?Q?kgfhPM7Vixi85aSTKqgj7YYl7ETTu4gHL6TgqJsqTxSxu7qHBqrFI5TJAf7v?=
 =?us-ascii?Q?XV5t+ZLnHzqTBG/oEpZrPJUAU+Apjuz5eIbT1CmEPF28FGVb2gGmKwcJQCbp?=
 =?us-ascii?Q?8HRYUau6blDeUip4GU/dhpMMhpzKGbubi7G4tpl/eS/s+cUZjNNCuqDIMXE7?=
 =?us-ascii?Q?aNMbxDVXACoS9WF0NF4BcqXpFPz8YuYbmhHd3esST3NyXbtX2joBABL7Pduq?=
 =?us-ascii?Q?YHWRIJeV0dnSv5Fifl7mVF6qU5cSOhYNnlCqRSI35EBg9OWyZZXFq3geg9s5?=
 =?us-ascii?Q?5rZUah4IMSpzgrS1rl+U+3RwOlVPt3G6cEpL2r6GJO8hL/HX1/r9q0EIlgjM?=
 =?us-ascii?Q?PnC2NAaj//BwTzUO8ddu2QdRNmm9D43DzVTXDuDmu28pUFRS0jHQCRhUnKi1?=
 =?us-ascii?Q?NFimrqQnnBDsdKyv8w+qGCFUwnKrR88UVvKPuv7F1XL4Kp1DEVos/SkNfWxa?=
 =?us-ascii?Q?9j83b7DCEEKR7DEtkU1Gy5S3I3jCssBeAOKJUOo3qhPkDp7l5f7ypTyG5b8s?=
 =?us-ascii?Q?HkevX+pNY/ooTS7HmywFkuo/J8uxrK98NYfemmTve1+a3iFzeRB/X3b8VhSS?=
 =?us-ascii?Q?eWw6SQjI9KWhoGH/I15udBIHqA0Ya4FinP+zw2suExRAiwCXIX4j5XH72TNf?=
 =?us-ascii?Q?o5+Z4zvYJp3tfDrXzi975IFwEJPehXxT1Yk6bs7FN17YnrabFVt11pEdWlge?=
 =?us-ascii?Q?lD6+TrA6W6IlS3iLUCx+yl5Lp7HgJ5xrCLAe2YyePLRmC84tu2gAj/jpApsi?=
 =?us-ascii?Q?bt3b77VzGKgz85fNe/JnjGy0L4O7mnqUcXDCd8BDLF7lFTBE1S7m7pCo58s2?=
 =?us-ascii?Q?gvgoX7p8+Zb7u6UMBMHssRjnpGUcIK9BlvhDqWCPRSAVx3HfuXQQlZSYzehF?=
 =?us-ascii?Q?TwowplUHAG9yzbSTrohHMCLg/KmR7T8x2hQGoWiaoxy3BGm9cOnWtW7AQliV?=
 =?us-ascii?Q?n9tVsYoxJqnu9xxXPYShYSIV4GwbTlmY2Xav7qy+Vir4MAN+r7WEiuQoEakq?=
 =?us-ascii?Q?VupqncWarXd/CyTierEBDunMxBz+rj6XvdkiJQJzaMMexJhbcvhWoBylXg96?=
 =?us-ascii?Q?Gnq41Z2aXDPw2uPCZDYEsbjFSSZkHsf1RJ020pN2YGXqsz8my/jM5LBs5fzD?=
 =?us-ascii?Q?ph02lqmha2cbsHqCGw6W0FhS6uKslDp42w0FKZQQfeDPDlFuKNKVaCreB21O?=
 =?us-ascii?Q?hnsrhStDVErEQfIvJxXZG3x18MIlB0rHbNirjj/i2z4NNH484bOz33CbFYvn?=
 =?us-ascii?Q?Dn5rkSzKar0RjG4Cp+anGTjX2zqtK9WeIHckhtdKGrXUFuX11XQPUIpHG0yI?=
 =?us-ascii?Q?A+SihdDHUP5uafvWBPw04gnn+0xHESNjpwrjOO8/y/tT27Lp4x1SMRJI9BMr?=
 =?us-ascii?Q?EO+vbeLs+FI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:10:41.2840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f614c9-5b2d-4e8b-ba80-08dd2f35d53c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

Get the PCIe link with of the device itself (or it's
integrated upstream bridge) and cache that.

v2: fix typo

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3820
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 152 ++++++++++++++++-----
 drivers/gpu/drm/amd/include/amd_pcie.h     |  18 +++
 2 files changed, 138 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 90eb92c4c2800..72aff70464ed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6162,6 +6162,44 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_device_gpu_bandwidth - find the bandwidth of the GPU
+ *
+ * @adev: amdgpu_device pointer
+ * @speed: pointer to the speed of the link
+ * @width: pointer to the width of the link
+ *
+ * Evaluate the hierarchy to find the speed and bandwidth capabilities of the
+ * AMD dGPU which may be a virtual upstream bridge.
+ */
+static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
+					enum pci_bus_speed *speed,
+					enum pcie_link_width *width)
+{
+	struct pci_dev *parent = adev->pdev;
+
+	if (!speed || !width)
+		return;
+
+	parent = pci_upstream_bridge(parent);
+	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
+		/* use the upstream/downstream switches internal to dGPU */
+		*speed = pcie_get_speed_cap(parent);
+		*width = pcie_get_width_cap(parent);
+		while ((parent = pci_upstream_bridge(parent))) {
+			if (parent->vendor == PCI_VENDOR_ID_ATI) {
+				/* use the upstream/downstream switches internal to dGPU */
+				*speed = pcie_get_speed_cap(parent);
+				*width = pcie_get_width_cap(parent);
+			}
+		}
+	} else {
+		/* use the device itself */
+		*speed = pcie_get_speed_cap(parent);
+		*width = pcie_get_width_cap(parent);
+	}
+}
+
 /**
  * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
  *
@@ -6173,9 +6211,8 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
  */
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 {
-	struct pci_dev *pdev;
 	enum pci_bus_speed speed_cap, platform_speed_cap;
-	enum pcie_link_width platform_link_width;
+	enum pcie_link_width platform_link_width, link_width;
 
 	if (amdgpu_pcie_gen_cap)
 		adev->pm.pcie_gen_mask = amdgpu_pcie_gen_cap;
@@ -6197,11 +6234,10 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 
 	amdgpu_device_partner_bandwidth(adev, &platform_speed_cap,
 					&platform_link_width);
+	amdgpu_device_gpu_bandwidth(adev, &speed_cap, &link_width);
 
 	if (adev->pm.pcie_gen_mask == 0) {
 		/* asic caps */
-		pdev = adev->pdev;
-		speed_cap = pcie_get_speed_cap(pdev);
 		if (speed_cap == PCI_SPEED_UNKNOWN) {
 			adev->pm.pcie_gen_mask |= (CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1 |
 						  CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2 |
@@ -6257,51 +6293,103 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 		}
 	}
 	if (adev->pm.pcie_mlw_mask == 0) {
+		/* asic caps */
+		if (link_width == PCIE_LNK_WIDTH_UNKNOWN) {
+			adev->pm.pcie_mlw_mask |= AMDGPU_DEFAULT_ASIC_PCIE_MLW_MASK;
+		} else {
+			switch (link_width) {
+			case PCIE_LNK_X32:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X32 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X16:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X12:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X8:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X4:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X2:
+				adev->pm.pcie_mlw_mask |= (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1);
+				break;
+			case PCIE_LNK_X1:
+				adev->pm.pcie_mlw_mask |= CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1;
+				break;
+			default:
+				break;
+			}
+		}
+		/* platform caps */
 		if (platform_link_width == PCIE_LNK_WIDTH_UNKNOWN) {
 			adev->pm.pcie_mlw_mask |= AMDGPU_DEFAULT_PCIE_MLW_MASK;
 		} else {
 			switch (platform_link_width) {
 			case PCIE_LNK_X32:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X16:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X12:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X8:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X4:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X2:
-				adev->pm.pcie_mlw_mask = (CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
-							  CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
+				adev->pm.pcie_mlw_mask |= (CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 |
+							   CAIL_PCIE_LINK_WIDTH_SUPPORT_X1);
 				break;
 			case PCIE_LNK_X1:
-				adev->pm.pcie_mlw_mask = CAIL_PCIE_LINK_WIDTH_SUPPORT_X1;
+				adev->pm.pcie_mlw_mask |= CAIL_PCIE_LINK_WIDTH_SUPPORT_X1;
 				break;
 			default:
 				break;
diff --git a/drivers/gpu/drm/amd/include/amd_pcie.h b/drivers/gpu/drm/amd/include/amd_pcie.h
index a1ece3eecdf5e..a08611cb80411 100644
--- a/drivers/gpu/drm/amd/include/amd_pcie.h
+++ b/drivers/gpu/drm/amd/include/amd_pcie.h
@@ -49,6 +49,17 @@
 				      | CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3)
 
 /* Following flags shows PCIe lane width switch supported in driver which are decided by chipset and ASIC */
+
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1          0x00000001
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2          0x00000002
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4          0x00000004
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8          0x00000008
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12         0x00000010
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16         0x00000020
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X32         0x00000040
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_MASK        0x0000FFFF
+#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_SHIFT       0
+
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X1          0x00010000
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X2          0x00020000
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X4          0x00040000
@@ -56,6 +67,7 @@
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X12         0x00100000
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X16         0x00200000
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X32         0x00400000
+#define CAIL_PCIE_LINK_WIDTH_SUPPORT_MASK        0xFFFF0000
 #define CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT       16
 
 /* 1/2/4/8/16 lanes */
@@ -65,4 +77,10 @@
 				      | CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 \
 				      | CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
 
+#define AMDGPU_DEFAULT_ASIC_PCIE_MLW_MASK (CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1 \
+					   | CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 \
+					   | CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 \
+					   | CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 \
+					   | CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16)
+
 #endif
-- 
2.47.1

