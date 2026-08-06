Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39F9C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 05:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A1210F0B3;
	Thu,  6 Aug 2026 05:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q75rpq2k";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9743310F0B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 05:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOZxQbH4L6+cjByHSMCVrhUQuoqa90v1ZnvgllBpWG8/i93pNy/yRo/nucgFjg3Kg9yoM1GSQEj5x1L4jNcRbYEP0JsT40/nOZ7lczyxnw/P6izSiFejsSujkRzbqos2IHcaZLl/hrKW3q9GpSziGzmNubCtfNITEx9c2R9X1k+7+siil/aad9jegqfzQo6qQoFOQORvkAIbOG6hnY5sEjtuFyeOYkFbG/CfRBeFbbGC8PbLCdbVGCg0Rvl9hk5elfLxVcZV6D+8B6+pYqqNZnAdLdNnoJ4c9rql6Jrd7UGJEiVIoLK1zfOtVrzeqmWBaZVpp8VwsVmyQq7SBGKjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vcuo3g6NxQLx9ss+01GFjPx5TalpYZ8W5TjxnCt4Lk=;
 b=r3n2BIxbbKeNlmlfDjC3y7O5IGPWvpoMokiA+HRMm/X0Q9u5v7UxoFXCWex7efwtdgwBlbINlmNwd1RhC7JaVFKI2UM16sitbydgC6jl7nGQJq4g3GvVRyHlhBI45UYrpwPQy75LJxb7Rcx0pdm4wHFI90/ohT8Pn+Wk+BnCyQCXWQ2Vu1uw57cSeiVbAXPQq76/hSAYHAjGJ6KQDplOmBWlQ5dS3zY7Mr8ZR7DoLikZE7kbPOspo57z5NeJOieI4MI89LB1sR/nEjggxk+n8yvLdWBQMTT3XymCuZXz5CGc5MfuQaxzxC4wp4D7Qkl8uczb5YOP1hoN8Lla4dmOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vcuo3g6NxQLx9ss+01GFjPx5TalpYZ8W5TjxnCt4Lk=;
 b=Q75rpq2k/ka6GxZ6vkOi84y5Lk9BYWqfsU0pB3tc5KdTttQfpjaNwlJ8c3wdQBLae07AZhjlal8hNSp6p7jPL0pRBp647UPCoOVu69v8LDXgrts6KTm5Q0FthJcXnrjiXlDX+1FVtiinjPCXBtbWM07uE8H30NzEKHxp8Hrj320=
Received: from CH0PR03CA0410.namprd03.prod.outlook.com (2603:10b6:610:11b::22)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 05:47:19 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::6d) by CH0PR03CA0410.outlook.office365.com
 (2603:10b6:610:11b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 05:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 05:47:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 00:47:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Date: Thu, 6 Aug 2026 13:47:05 +0800
Message-ID: <20260806054705.1580442-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a082ae6-372b-413f-e0aa-08def37e2d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: MOYrtIxJ7MGy5Mqcfmg8Y/gJI9uobN7Z2tl/MXht1/mdaprvY7PAJzZPgy1fSHgACO+nOml9mOY9KAdLEC6m7zeB5NbDdlXx4h5lZYtXGlVP451jLg2mEIfiga701eRQcSlfAY381zfqsY5U6x0GcMbfIPgzNT5sBNWyHh1wrzOHXSHdB6bKK4ifFBoItPgXbmwM1DNmkiteMdOcNqwY+ucpJdVidu/BRbWof3RK4uUfjpHSyZiPB1eXEmSJ45V/VWUP9BKSAPZJLo0kmT9Iz4Lz+I6PgO+fp7JGldzu8NN4vRFQFwv2iwZgSgdwPlFN1X77RPqbjQlQz19xmok+ieHlY5tzNlbvNRR7FWqALf7G6GEoFv3WWXyUMqkzyteLJY2wOWKmwuEUUKoholxoc3hX2nSwyZvBo6bOrG4EMLtkLyfFxQNAQY4CZdTEyBh6afYguVE2U3oEOrlnVbsgNQNo0Hlm9SluQpXjaD+ZGaniPMxOnd9/tKEkKpsNk0bTWw9L1UJtdRSCxWrmSlX5MNTVPufKPJDpwlGnP5Vgf6MD+gAfeHEqkFgTnkLkvAYC1jMpw7apoE+XryCD9R1NHDiP6HgUGvSLSnLkGPIU4095A4NH1YH9U3b1RODPV0HahU6y9aQSIkItGQawHAYUuT1/mn4pHYrKnkmWRdca0DJuvcIt7WSXekVd8wCEHelxc3BHwgeyilz77m5rt9zvSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 20Io2ebtlv7y2cmyoZJMb/tTOz00r4nkMRe3VoPAw23VtFVfGXCziE8m3pcuJnCcInfwOYzFZzPh1xoBBuT1RbjUga/NGLNQaypQCwlH9AsOcDvDgyM+A8htI0Lfh20GteJ+2U6djF08baqMBkn48bk66Fje4MrXoLaBfueZ0h61vE8g6yEFj26Ppko6rNgz5SGIU7kgzTJfx1ykTLOBtvgkM4shI/xrk8ZhWdwsZP1qoVSDjkr46ZPaa7i0yEukDYMNKaRUWy9SbX27JK8k2G6ekcEo3wSImJ63/KSJKbIxK8tw+LANGGtHS839wg8D55EwGeeQCdrTZkB7PcUc0vnSkN5liPozyBM6wImgcLqyWb/N3oaGkGSy6wmLSB50x2G+5CWyNamWv0lsJW3nNKGsW1yqG6MGvzxOaTxpVjbECKuJexd6aAW6zsIh3mNL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 05:47:18.7651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a082ae6-372b-413f-e0aa-08def37e2d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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

dGPUs with an internal PCIe switch expose graphics functions below the
switch downstream port. The automatic ASPM check uses the display
endpoint and evaluates the internal link instead of the host link.

Use the switch upstream port for the check and report the selected
link.

Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b9799033174..e68a5ddcae69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1344,6 +1344,31 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 #endif
 }
 
+/*
+ * Some dGPUs expose their display endpoint below an internal PCIe switch.
+ * Use the switch upstream port to query the host-facing link.
+ */
+static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device *adev)
+{
+	struct pci_dev *swds, *swus;
+
+	swds = pci_upstream_bridge(adev->pdev);
+	if (!swds ||
+	    (swds->vendor != PCI_VENDOR_ID_ATI &&
+	     swds->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return adev->pdev;
+
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+		return adev->pdev;
+
+	return swus;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1356,6 +1381,9 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1370,7 +1398,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 		return false;
 	if (amdgpu_device_aspm_support_quirk(adev))
 		return false;
-	return pcie_aspm_enabled(adev->pdev);
+
+	/*
+	 * pcie_aspm_enabled() checks the link between its argument and
+	 * the immediate upstream bridge. Use SWUS for dGPUs with an
+	 * internal switch so that this is the host-facing link.
+	 */
+	aspm_pdev = amdgpu_device_get_aspm_pdev(adev);
+	parent = pci_upstream_bridge(aspm_pdev);
+	if (!parent) {
+		dev_info(adev->dev, "ASPM: no upstream PCIe link for %s\n",
+			 pci_name(aspm_pdev));
+		return false;
+	}
+
+	enabled = pcie_aspm_enabled(aspm_pdev);
+	/* Report the exact link used for the automatic ASPM decision. */
+	dev_info(adev->dev, "ASPM: link %s <-> %s is %s\n",
+		 pci_name(parent), pci_name(aspm_pdev),
+		 enabled ? "enabled" : "disabled");
+
+	return enabled;
 }
 
 /* if we get transitioned to only one device, take VGA back */
-- 
2.54.0

