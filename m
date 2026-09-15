Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60EFC88E7D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 17:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F83010E30B;
	Tue, 15 Sep 2026 17:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BwSzfAzX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577C410E30B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 17:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDLGcuGglCFQNa2WIgUEXkkDYk3LRQ+xjVeZWGZ0n1Ttzs6UBNNUBmaM9uaW+v1O6VLa0orGIx46rIgB7xHTTvT4Rr3Il5M/E3c3AQe/puD2l8YqjF2Kbu2vEp/kiEUea3KHWZvMcG2EUc9EsRswdpE5PM9B2n96ZbNOL2db0E55IdcxJgDc8FZyUaBNAUqANT4z1vUF1ZOBAH3CXYou6bspffZdBQqm8wOQPI/t1lyfXc0TMEWdUDlRNxGYai0ZIPZf1mq+w/0wUTdSoxzScC5NdjMxqoLNez3UrgwJD78AcJK830aOe2qO8utVymcksoW7C0bJ4T5rsQZ4Ck6F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIa28jOqbF7pEIyq9KTKiW+y52QXykCZfoIhiRAaBzA=;
 b=aqL41r/n9KxiCM/4e357m8Vz0gzpBZ90EycX0Jh109tXzXJYerU7ZtPIiTb133TErhrkdiG1zc1D91vuZQbNkh8SQSOJ2NjUWerbQkkS+C532MVqtjCLKpovfWLtrLxCI7IG/nEImaTQu7WgDj25SwpQjV0aOVlGCTbNAqNKEHxnIseq73VeRBmORG2bdESUI+bCahOfbZAb66A/b0TZ9b3Chkjq0lyFl2LerjZ935VEUx1rcJ3MMarnLAKg3mKd0bXiLfC8Q1Ne6ptEWpvlcCatXTSNUjPMKIAb/Ucsm1fmAbKksh2sfxXOqWn2kDnXKlkl4j2SXd9kTVTE+0EbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIa28jOqbF7pEIyq9KTKiW+y52QXykCZfoIhiRAaBzA=;
 b=BwSzfAzXuwA09BFLRKRGqJNq5FwRQ3sopQT4FZxLvpNhAewIfkmyCarw/KRl9AF3pUE25SuuvrVPwB2qvMmGt3Q+CSNT+yxYLr8cvYP4y2f9/j3XBfux/MA10s/5Dl2V7bHtWaIR7dKXtoaig/1WmlJ97qXnoPF2UQzK+neXrM4=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Tue, 15 Sep 2026 17:56:05 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::49) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 17:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 17:56:05 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 12:56:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Reuse cached PCIe link device
Date: Tue, 15 Sep 2026 12:55:56 -0500
Message-ID: <20260915175556.2160918-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fcd476-67ca-44de-07d9-08df13529d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|6133799003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qgTTx8V1cKhajBXYdK+OOR48vgMbsXLyZX/ftihTS8PWqpgTOS3LFmba7aXaq2B+5PqIUvdhl5cd/b8SDiJTBoTxBRTqj9gUbWh5ZP2sTmAOW8E/M9Lr5o3wh1TVnBPThyx7xljWYi4NskkGoDO/dRgATKEK+3WfS+03K8eYqKP93UKyTt0lvmcLRpMtgKEIqp4eFNYTm1l99nbR1ZbQzNFYju7+OiSc1udpfRGdXBIS0k6qfiYafr3mt7vU/hTRUxY6IVTcCatZc5VHekWwq2zuiE2hYR3VcWIj0/S1d3c34nwdMq+eU38G4XelQhNL/vhvURiS71onwI/vtQw7RNh9GBP3sYZBp5owOar+rKnzG3jQGczU8+RPPkIj9/39A0AxPc/D8+znGls2IY5utpSNe74LQEsQFfoN68vC09fJMjhiPpBnBbWEoJRdrKqJsJO2G4aXbqpepsm/3Tei0YbefJChanyh0Gz874BIqWGAtHyakKpb9fV2L/oDDDp3NfM8fdo58DSh288We9rLHX/5BlF8EW+rDyPeeDN/C/ZSjff7v926k5aThVWbkZY0CLjmIkABLjljWtlR8Wx0oesJ6UreYk+47UNRkFRk8pWBzXqwwphD5T+O4HGZwecVUyg4whDy+u4O6iCM/csYKeupU18uBqFNKtayeRSyiGNBlEqbNxtIRXl8Q8uLBB/b1+FmewjSoLsHjcl64kfq7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GIfqK4jw2WgxeiC6649FF7eUSqMEDDejOPFlfdgfd0zDLnYK78fFwRgq24zTLY4AGHp1y27hznItMV9DTlPGnVZtX/jVEYT192AVWqQIiBsVB3UmGBq4EUVZm6wffybOpZctgGgnR9wJx2Im31X6XQb+1RZVrX/Rog5JbyKMQIDkCchEKeX5qBTkSzvtyUL+kHQzNUa2ndKTbJMt5xgiPo074OxOBwPwXKanA+sDrJ2Q2ervO5rm8lpZ+1D7NdHnaS02gfbx8/1MX7TaWHnSAeovEqBV455DviWiAlblagr3W3W2aB5n7N6w6RjlESu0t9nA90nbU1+/141vzXg4ysP3Eopv9sXc83EB8HiuoFnbn45EtWE+beyR74/6C4O94NnAbvjlVTZgPEwapM1esPOvt5+cSHuh5ACkkqOGYvTMgCXZGNJQu7oXLlEvuLHE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:56:05.2248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fcd476-67ca-44de-07d9-08df13529d16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

After "drm/amdgpu: Fix GPU PCIe link capability reporting" there are
now a few areas of walking topology.

Use the cached GPU-side link device for ASPM queries and switch state
caching instead of walking the PCI topology independently in each path.

Validate the internal downstream/upstream switch pair when initializing
the cached link devices so all consumers share the existing topology
checks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 ++++++++--------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d277516fd55e..07121d4aed3dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1353,31 +1353,6 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 #endif
 }
 
-/*
- * Some dGPUs expose their display endpoint below an internal PCIe switch.
- * Use the switch upstream port to query the host-facing link.
- */
-static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device *adev)
-{
-	struct pci_dev *swds, *swus;
-
-	swds = pci_upstream_bridge(adev->pdev);
-	if (!swds ||
-	    (swds->vendor != PCI_VENDOR_ID_ATI &&
-	     swds->vendor != PCI_VENDOR_ID_AMD) ||
-	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
-		return adev->pdev;
-
-	swus = pci_upstream_bridge(swds);
-	if (!swus ||
-	    (swus->vendor != PCI_VENDOR_ID_ATI &&
-	     swus->vendor != PCI_VENDOR_ID_AMD) ||
-	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
-		return adev->pdev;
-
-	return swus;
-}
-
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1413,7 +1388,7 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	 * the immediate upstream bridge. Use SWUS for dGPUs with an
 	 * internal switch so that this is the host-facing link.
 	 */
-	aspm_pdev = amdgpu_device_get_aspm_pdev(adev);
+	aspm_pdev = adev->link_dev;
 	parent = pci_upstream_bridge(aspm_pdev);
 	if (!parent) {
 		dev_dbg(adev->dev, "ASPM: no upstream PCIe link for %s\n",
@@ -1961,15 +1936,26 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
 
 static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
 {
+	struct pci_dev *swds, *swus;
+
 	adev->link_dev = adev->pdev;
 	adev->link_partner = pci_upstream_bridge(adev->link_dev);
 
-	/* Skip upstream/downstream switches internal to the dGPU. */
-	while (adev->link_partner &&
-	       adev->link_partner->vendor == PCI_VENDOR_ID_ATI) {
-		adev->link_dev = adev->link_partner;
-		adev->link_partner = pci_upstream_bridge(adev->link_dev);
-	}
+	/* Skip an upstream/downstream switch internal to the dGPU. */
+	swds = adev->link_partner;
+	if (!swds || swds->vendor != PCI_VENDOR_ID_ATI ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	adev->link_dev = swus;
+	adev->link_partner = pci_upstream_bridge(swus);
 }
 
 /**
@@ -6428,16 +6414,10 @@ static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
 	struct pci_dev *swus, *swds;
 	int r;
 
-	swds = pci_upstream_bridge(adev->pdev);
-	if (!swds || swds->vendor != PCI_VENDOR_ID_ATI ||
-	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
-		return;
-	swus = pci_upstream_bridge(swds);
-	if (!swus ||
-	    (swus->vendor != PCI_VENDOR_ID_ATI &&
-	     swus->vendor != PCI_VENDOR_ID_AMD) ||
-	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+	swus = adev->link_dev != adev->pdev ? adev->link_dev : NULL;
+	if (!swus)
 		return;
+	swds = pci_upstream_bridge(adev->pdev);
 
 	/* If already saved, return */
 	if (adev->pcie_reset_ctx.swus)
-- 
2.43.0

