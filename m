Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6DACD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 15:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A839B10E19A;
	Wed, 20 May 2026 15:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bb3+xtAU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6044810E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 15:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDA1sCocqV12a+g6TkpVvk/dG9eQE2kDQM2juH3aqTCmGDPUQTwmrFoLg0GSwwT8v39NX3iCwG8I5aTkPZ+l3W8OW1JFP0/046l8L48xoZTeHtCZp8VKQnvIz4pnrh8ixSrSRVTU0fUkL0ObfUVErGLrLelgCJUH1RL3YCusEEHss/3QTIqA+s6MFo5DjfUhE3JbdWCeqUVP+HLpwuKKHSE5rhs4MwNO0jKdl3vXPOpsWB+0f6jGd+l/+Dfed1uYAH4QFviYFSagFYD36+E7t4MiadFCLm4L/i+QFa6SDZO/3YrI5LLZPUACh2gilC/XxvamaS6iJLMW2C9WAdUYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYPS8o9eVyyTzspsDlfz7MLdO7/RJsYEEv4bIPofVbs=;
 b=ijXYobesoZSmxl2g7s/cN1+Xh3Aa+o5rdx2qTmcYH3ic+YWZ6edvAfpSwlcwQL7qXb9H8ZL//HRBIuG9pnInF1MnFgkPAHugD9iegBvRjXFrxpCEIbOHbh0irXnwM+xoUbef1PtPGZ/xIVv4Q5hNCf2Fk7IurDWn+7A/CKZObZG7CacznghVydKdgJAZThx/0C6M1yK//A88dZa0GuR++TAqMdbEyHueu7SRUCajsc+vcMNuEim2yToEwnp3NCBvtLObJb1U/ntrxSq0xyq/A4jti8mreia3obQaym0UIXC3mAm5DN2UbDuV/Z5rlABWibkI32CIHrQVYmw8hCCJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYPS8o9eVyyTzspsDlfz7MLdO7/RJsYEEv4bIPofVbs=;
 b=Bb3+xtAU4y4YuCZ3r6CjYC6dCjsjzzedYxAqk0IUNvz5UyFGsKoAp3QV2n5cGVlr1Ygknue4Pl7dLoQ/axu1nBjIowmctIJ/c0hqVIepTEBe2X3DTE66Wd0yA9TBTHVOHHA99ywJoDbLWVfmqkEAwFPEaEc/kgdpW5vivJOAcAU=
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:46:31 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::ff) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 15:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 15:46:28 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 10:46:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/amd: Add dedicated helper for
 amdgpu_device_find_parent()
Date: Wed, 20 May 2026 10:46:17 -0500
Message-ID: <20260520154618.809699-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520154618.809699-1-mario.limonciello@amd.com>
References: <20260520154618.809699-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3745d47a-6f4b-414a-3dfe-08deb686f4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info: 2dJ8wpCt5e/pjtTDL5procEkOx3Mg3yTPWPbJbHGNjJLg4VnR+9+VfrMGPyavBa6N9ohsPgvus4M4xzmic6WPzIYIoiCx/3I93PTZF1avFPo22hCZaJQRKRBu0yPooLwVEfvij+72P7HcHXwfRB9m2YldcT19oqGhFnu0coL8283+/xslqFsXZHuYxCysdgfLkP0NgzSKBojoPtzy/kvcRLvHIaccThCk1SH3s+J1g5pAoTRskEOCxL3jIkbCEbnAfiTciOMIjWZWwez0eUZSVvK6LJzj/08rZw3nFLMGeWNZ6fvE9M43zvWTmwjcozndYGEFXVgRlMAjbCoBRB+HwyMIHYFee6XnfuJVroPqKrlQkPK/h48mHSX4Mk72t/K7zT57xq3UegMzwrE2Ey6R9dSQ0ONlqUtGG5zy09/YGIBTw2Xl0BvdDTwQCnwPNCnIZbHVFPQB4n8DIpuB3KrzyXwn5DqZtE94nIONC4l10/tJc1T6ts97rpN1XvL97hohvgyQ7avThtPmL1CESSiEYfh+KbhbQmNyhfc8/JWWDeCozb5jyQQwY1a6aZ8zk9ckS62iq8PNEsrbtDWpEns7SBy/GzB718oOtATCVlqX7o54OFGc5EoUr8oFCkzqt5RmfO3gguCsYZ+NrO5ZJjlke18aZVeNQxUAvoLDswjXy4ep6mabfifSG0vXXIhxsNg/b757AmeVGNO0YqvGZ1CwRPEbI5onN6pT1FSkf20tWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DBP00LN9u7Z3jFErkAaJF9/MTvJkvAbyCSqlAo55yM0HAIfEKg4K1fa2zBkbn2NcHJx7mQKhDiM/cZpiUYnVlfi7K/iBTlXOzSMbob7Ic12xqXsrLVOwrB7M3NQ4XkJCEFV7KVRYC1bQTFT8JT84jeQXtibQi/c+COKWxS/AsbJm9rxLRvfPsnQPbF1De0kNBuxpQhN73lMEfUAo7IMaKH0natUbmohnRUPWszrBz6eEXCKs5ERVEUn0MT/2DDv9Tvk2l9WrrOE/hfNX5SwxSBr3iwrBGyqdasFsRjQXcfPzJIDL40tQrYn08joWDX4n8SF/T2jkrevgRwa7sxY3OMgyMM35C3zCpXHWYE7aKdkgVCC/FUIhcpQVmJwMcqNPzaFUBE1/OGQVy8rt+O2xlz+UDJxYSv2n3ISFYqWVgNbktVnIv6PbDDAZrwYG4xCH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:46:28.0931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3745d47a-6f4b-414a-3dfe-08deb686f4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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

There are a few cases that code walks up the topology to find the
link partner of the integrated switch in a dGPU.  Split this out
to a helper and call in all places.

This does have a functional change that amdgpu_device_gpu_bandwidth()
doesn't cache the internal link but only the parent.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a3..b6a24faaf78dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1913,6 +1913,19 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
 	adev->uid_info = NULL;
 }
 
+static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
+{
+	struct pci_dev *parent = adev->pdev;
+
+	/* skip upstream/downstream switches internal to dGPU */
+	while ((parent = pci_upstream_bridge(parent))) {
+		if (parent->vendor == PCI_VENDOR_ID_ATI)
+			continue;
+	}
+
+	return parent;
+}
+
 /**
  * amdgpu_device_ip_early_init - run early init for hardware IPs
  *
@@ -5913,8 +5926,6 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 					    enum pci_bus_speed *speed,
 					    enum pcie_link_width *width)
 {
-	struct pci_dev *parent = adev->pdev;
-
 	if (!speed || !width)
 		return;
 
@@ -5922,13 +5933,11 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
 	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
-		while ((parent = pci_upstream_bridge(parent))) {
-			/* skip upstream/downstream switches internal to dGPU*/
-			if (parent->vendor == PCI_VENDOR_ID_ATI)
-				continue;
+		struct pci_dev *parent = amdgpu_device_find_parent(adev);
+
+		if (parent) {
 			*speed = pcie_get_speed_cap(parent);
 			*width = pcie_get_width_cap(parent);
-			break;
 		}
 	} else {
 		/* use the current speeds rather than max if switching is not supported */
@@ -5955,22 +5964,15 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 	if (!speed || !width)
 		return;
 
-	parent = pci_upstream_bridge(parent);
-	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
-		/* use the upstream/downstream switches internal to dGPU */
+	/* use the device itself */
+	*speed = pcie_get_speed_cap(adev->pdev);
+	*width = pcie_get_width_cap(adev->pdev);
+
+	/* use the link outside the device */
+	parent = amdgpu_device_find_parent(adev);
+	if (parent) {
 		*speed = pcie_get_speed_cap(parent);
 		*width = pcie_get_width_cap(parent);
-		while ((parent = pci_upstream_bridge(parent))) {
-			if (parent->vendor == PCI_VENDOR_ID_ATI) {
-				/* use the upstream/downstream switches internal to dGPU */
-				*speed = pcie_get_speed_cap(parent);
-				*width = pcie_get_width_cap(parent);
-			}
-		}
-	} else {
-		/* use the device itself */
-		*speed = pcie_get_speed_cap(adev->pdev);
-		*width = pcie_get_width_cap(adev->pdev);
 	}
 }
 
-- 
2.43.0

