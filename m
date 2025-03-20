Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256B5C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 15:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC7410E658;
	Thu, 20 Mar 2025 15:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HwFtT3JQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEFB10E637
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 15:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opLcFa9Bytc8U0kkD11QoZXjKhHReZrWQQ2TPpsFSHtcuwA3if+nAnbjQkiR6t4GyWpZFEW8xzfHhTdpnB/wJr/a0ql2Tx1zUUH2VThm6V12wvFfeyfLvoRt0vCSE8Mup133yBL19O/n8mAHSZyNf3FeSO0MId+MfKJ06bt3zvCQF6LtU+aiBTeQn47rNeXbk41CwEKO4kEr+N6z6XZuA6kn3tUq+SVkM8266JMcIcvoJPNbnHaqlp3Z03LHN0nz2mtsflMCn5WEIjegdC/NUnNI3Zw4SBZTUOpvZ/cMYQv58Bst7MbOrdag3ArUIyEjHYY6GFFgAU8EC0lJ7xth6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrV2uTxqeZ7CkbbNAACGk9BoTq73431rvqwclI+1GO0=;
 b=Qq69Uo8M8vY9uvtM6dPXVZxGsCvp9Y/a7KCjinoG/GsTUrKYMriridQ9LV4MR+TCauKwiKrifvO34wVRbGpKPELTK8EKv32SkNxmAQjbKxiD5V0y13v9cXMsWhl/QxwhuHqN0Mc2CQyB8DrRYRvWl2J8NFCLab/vI9o+36/wBA656iYnvYhRe2kL8PjApcjT0Za7faa++6EHSVPbtlfi8zEa7sb3Oxmq4+FvEn6C/3P8vGjKSsHkYx4hcvziFDVt4wWIu8/R9E9l83xW2H3Gb4I9UZtz2SfvkJL9HK7juLxQLhvPAnv0pUpGH6POf6lGWO1nDDPNvNPIrJwdPd14hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrV2uTxqeZ7CkbbNAACGk9BoTq73431rvqwclI+1GO0=;
 b=HwFtT3JQCuAff3YMo4R2m108Hx8Eafc8RsKEZHdKIjqwbeAcUhMRC31iTt8OPXRVHXFMN0Fi1jAV8xB8l4YGaHcOhWMKsb8y3W+VzfGIZ0jyyfOcKCSPnnCVU2zHkJnd7/uKzt+4zqTCb5IXmYXK3qhTR3g1DU9i2e8QTzBUfJM=
Received: from PH8PR02CA0051.namprd02.prod.outlook.com (2603:10b6:510:2da::21)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:49:28 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:2da:cafe::55) by PH8PR02CA0051.outlook.office365.com
 (2603:10b6:510:2da::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 15:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Thu, 20 Mar 2025 15:49:27 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 10:49:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: Handle being compiled without SI or CIK support
 better
Date: Thu, 20 Mar 2025 10:49:14 -0500
Message-ID: <20250320154914.96395-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5c014c-f63e-41f8-b30c-08dd67c6cbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jYLPwvaUe0TIWt6kzibXRT2N/m22rj+i/Oz68U1bo4ez4Wuh8gjLy2MIH9EA?=
 =?us-ascii?Q?jdZH3C8cJH6+SrD+sw1yFm3DMCfu9wQBUfdntZIZY3+Hj9Jh4tn9z76e6I8v?=
 =?us-ascii?Q?q7bfBjng1QxrRcK+MQQFer8lmNoIR/izuzg6J2FsgJ0x71mKEMViibJuWFfJ?=
 =?us-ascii?Q?UBv6LPxwziqTXS11P0T3C2Jnix9h/oRjx+fzKcB5ZnO13CXbTJoAZijo5Agt?=
 =?us-ascii?Q?TLxpjdtCJAj9Rp53TCDwgAHJZH5oEIULEG4tPgjgkjNN7UP+QLgU/k2I2Umb?=
 =?us-ascii?Q?OROAAVHsN2vHoclFrFCrpb0VOmqiA5uuB0zFg2jKFLwAk0EwWttZm7FgXc98?=
 =?us-ascii?Q?rUdXBOkWgq5MaeNtf2FJIV4h8YjTl1S1KLSSA82zg+D1qbMRk9WZZlQ0FPCO?=
 =?us-ascii?Q?xOoqi2TeDuDTqmJSyI6NNTB4yo6SPgcG1CyWC9lUSWWRj1FXnhW1brw+uOkY?=
 =?us-ascii?Q?nfPcHc8vETzGA1nt656js2taKfuYMt+J3g1AksXmOE2L6I0XjOxZiPvtWmZG?=
 =?us-ascii?Q?g1AYad//kuyOfo/8BTTxOkQ4XOTFd7h2JM/pqgHyQRDxMAodDNbtk4XDyBO8?=
 =?us-ascii?Q?ZayNApAda51fEPdz5Ai17euuB4wASKmbkItNYKioc1meCSkZ+jaCESrfLkxu?=
 =?us-ascii?Q?1ArxywihMXWx2hK2/8oYy/WI48Ofj08UwlToofEHUM3EEEMqPj2lVIccPO/o?=
 =?us-ascii?Q?N75lFfI7EGgdsLiQcoAlD45zu4SV2T9jMxKN6Io9eDwXxhjhIahWb0NKJF79?=
 =?us-ascii?Q?WqJAds0Qe9kKuPbUcYGNgSeFpSS9B0sSNdcT0lsxfKqQPCV2KQ9OWCPzs2TK?=
 =?us-ascii?Q?JN0bj7uOCgeP0i6LqL68c7syXV9VjY7HO4r7U0LEQom5RG/XHC6WVk4TIYjF?=
 =?us-ascii?Q?Ux7PZLu2VrT/IV3T+1R6cxL4tkeUr8pQKCLvmIH4Ysolr8hQb0knvvvpP584?=
 =?us-ascii?Q?gvySDgwMojvc9+LHUpvwdfr2XpuN3wlQkz5QQvDYikq5taC9BFC7JXNqLOIg?=
 =?us-ascii?Q?svr+9TU3ytfJGN5Gz7ahsMT8VoWTCqpa8wahAnLzsPEB99+4Sg4kOPRny14n?=
 =?us-ascii?Q?YsEtjkngbj1eY/GK+hMql/CBselnMIczI8amHDOaWmAYOpmhL5ZCl/2+F8qq?=
 =?us-ascii?Q?Ehld3t3oD6QwAeS6iMahKoccrke0ghtJjj73SpWLee2TkUpZFD3qFyqSV7S0?=
 =?us-ascii?Q?HM0TbMxvO/uO1334idWEefedJrWHQoAtGpjLunwY/YBAiJOWbXrLFNiplBgB?=
 =?us-ascii?Q?ZuCkyYOcnu1ptc/vs+3C1NkptkUE2l7SKe6YLHArmZvIf5pyr2noWzdyDEuw?=
 =?us-ascii?Q?AkJAkP1FI9AQK+V9bub0hij2W9mD/p0aaAph/7Oa6pPtDrZcpjjNQLpaDLWS?=
 =?us-ascii?Q?p/HRDjfJli8z7TWobs+Y9DTXbdVOAaaD+w4CqaqeIOJbs+vRXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:49:27.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5c014c-f63e-41f8-b30c-08dd67c6cbb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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

If compiled without SI or CIK support but amdgpu tries to load it
will run into failures with uninitialized callbacks.

Show a nicer message in this case and fail probe instead.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4050
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 43 +++++++++++++------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81d9877c87357..4164889fb63a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1793,7 +1793,6 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 };
 
 static const struct pci_device_id pciidlist[] = {
-#ifdef CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
@@ -1866,8 +1865,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x6665, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
 	{0x1002, 0x6667, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
 	{0x1002, 0x666F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_HAINAN|AMD_IS_MOBILITY},
-#endif
-#ifdef CONFIG_DRM_AMDGPU_CIK
 	/* Kaveri */
 	{0x1002, 0x1304, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_KAVERI|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x1305, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_KAVERI|AMD_IS_APU},
@@ -1950,7 +1947,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x985D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x985E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
 	{0x1002, 0x985F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_MULLINS|AMD_IS_MOBILITY|AMD_IS_APU},
-#endif
 	/* topaz */
 	{0x1002, 0x6900, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TOPAZ},
 	{0x1002, 0x6901, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TOPAZ},
@@ -2282,14 +2278,14 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
+	switch (flags & AMD_ASIC_MASK) {
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+	case CHIP_HAINAN:
 #ifdef CONFIG_DRM_AMDGPU_SI
-	if (!amdgpu_si_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_VERDE:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
+		if (!amdgpu_si_support) {
 			dev_info(&pdev->dev,
 				 "SI support provided by radeon.\n");
 			dev_info(&pdev->dev,
@@ -2297,16 +2293,18 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 				);
 			return -ENODEV;
 		}
-	}
+		break;
+#else
+		dev_info(&pdev->dev, "amdgpu is built without SI support.\n");
+		return -ENODEV;
 #endif
+	case CHIP_KAVERI:
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
 #ifdef CONFIG_DRM_AMDGPU_CIK
-	if (!amdgpu_cik_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_KAVERI:
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_KABINI:
-		case CHIP_MULLINS:
+		if (!amdgpu_cik_support) {
 			dev_info(&pdev->dev,
 				 "CIK support provided by radeon.\n");
 			dev_info(&pdev->dev,
@@ -2314,8 +2312,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 				);
 			return -ENODEV;
 		}
-	}
+#else
+		dev_info(&pdev->dev, "amdgpu is built without CIK support.\n");
+		return -ENODEV;
 #endif
+	default:
+		break;
+	}
 
 	adev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_kms_driver, typeof(*adev), ddev);
 	if (IS_ERR(adev))
-- 
2.43.0

