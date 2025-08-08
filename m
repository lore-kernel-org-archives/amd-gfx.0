Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A62BC87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 04:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAB610E05F;
	Fri,  8 Aug 2025 04:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FISLa74Z";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6665610E05F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 04:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isc0aVzfZ9NfEPb1sySWpTKas5U8eLAlH4P25zbQ+BEnjVlLS2Auky9xZNillWjDPPdiceytdwvwsdj487XpHFnK7syRzfuijpN479D5cmIxHUrkvKxAB+u40dcilYZBzFfN55P1GAklf5Z5e6wS1k9PgO0pMiA4svuME9s2Umb02wR9KCJYAviSr2VIEe6ggVXaJ5xOx0Ow+qhfzF9tPBglrRv8IGD+i2bUPjsf2yR+a/AzhTPs9FQfYa23fduvCg79iisuin+OGbjkX0wJesQQv+L0r7ijldjjZw9pp9arvORM6mq5+XA3Xl5nj/ZVK8HQrmF3v1MqpUUWsuPiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY3vIN45N4QNgv1WP6QC0oXzZZP1n15DOfOcm/rfnu8=;
 b=go0AYR15t0PWQ2DcGSTacpLwVc8JYuO6RpVhyziuIb0hfJwjzsl+2dY6NgUbiznWWwb+87mB53hhonutDdldGeSd+1PSe6vLE7H81hEBrSXgf+42iX7B6UCJvmXDOr4iCgnMpPp2xKqEn/e2ITEp+0PyXabgvOU7mQRZSQcbB2ldQhfHUKSC72DxLDtoFTs/Ai+lPmFY2B4VWybme767yiIRFSv3GO96Rd/1hrqjRxHSrKD37PUJz8s/kdEUVy6BKTyPM2Q0Vb1rIEedafu+9j1BmAy1qswwgqNzIVcxYDoOimmrnMXBwPoIbuyjKj2jbZR7WjBxd7BKQWqCK5EoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY3vIN45N4QNgv1WP6QC0oXzZZP1n15DOfOcm/rfnu8=;
 b=FISLa74Zpr+JR+ALBdXlLeSjii+rWyvfjJY8qxz3mfJAtwZa5c+PkEZcebpBkwyr3AfbD/UyUKhqmL4AzzB0YEiYAfyC/XTnkP1O5mhmut7S88ZaGxFZC0lRYnlYmmvQg6w4TVKy03kbJgmpFVsC7U//QMbDT10vkLM8nimTQVo=
Received: from PH7P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::7)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 04:59:31 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::72) by PH7P223CA0005.outlook.office365.com
 (2603:10b6:510:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 04:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 04:59:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 23:59:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v4] drm/amdgpu: Save and restore switch state
Date: Fri, 8 Aug 2025 10:28:55 +0530
Message-ID: <20250808045909.1836770-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1474ff59-d68f-40a2-0e8d-08ddd6385c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdS3auNrzOp3JXYGdDHDP0VvprNY0qql5dL8iEWoW6EqkxBho3EdPkVocucd?=
 =?us-ascii?Q?X7Y6XM4fzx2Xv27ZxjNshLX//VAsQ0gVCXmcXYkbPilg8El4nRIwdn50jDkq?=
 =?us-ascii?Q?YmVk4jL6mq3j3on8R1b5Ml9hC1Dk86PCyez2GQX5UYhqfIAnJCegkr00cZ+K?=
 =?us-ascii?Q?plOneYl0akHzPNMnCLVjxqyAbaQB1RiGuNZGkJUYxl4cEFp6vdAi45qtcRim?=
 =?us-ascii?Q?V0YhQQNwpR45CelPIw8YYz4wZevYbBU4H9Y8Kdy7VZnbTCgwM1uqummmebXu?=
 =?us-ascii?Q?6bHAf9ajdg16wsh7RNJWlCOJAVAYMNdGtCYbvTV3csCxJBc+Dc1LgyzpUQj1?=
 =?us-ascii?Q?yBDeO8wf7qzWB9ZR8OiRkpVcDStaqLIYjeMk7t74OkrLBUGJSXCyW5fmjkNe?=
 =?us-ascii?Q?pP8SCZFIbLuZbPuYpzHyx4i1f7EAGqTFO1hssnfw2+QKJyuAytn9oPMhCW5Z?=
 =?us-ascii?Q?rLhe4t4YgOF1Xr59plAGKsxauTd3RnRljpN6Ir2MtNSZLTnT04vJI/NH1tUL?=
 =?us-ascii?Q?yZbvtPKU30CcoTmhmhxwsr8/hYWz1A5MoUJceRAMUn483Sz1kcqQ/EXFO+7J?=
 =?us-ascii?Q?2scqeSjW3rUKvMZfYwERlrMreGcGadmVy3FAfyL1SYBOH8avLJh0Bs2kTPrC?=
 =?us-ascii?Q?re3/pNRA7Qt4fMpllNnexzu0PyhM0SRWYfyIv3f2L3JUGVtLqWKnZp4LPQpu?=
 =?us-ascii?Q?ZOD69dVPxYzST04/d5aFqHIe6zHoF9MrwPcCXOgNXEP4k7KRKb5g/PqfdlEx?=
 =?us-ascii?Q?J1YW+BfbF1P6wj5tNvVoeScP+pDNEAUMQjUjNFYeOmpucTTT4+SUUix20H+h?=
 =?us-ascii?Q?ZCFNRO0FLNSihV6ml0jJaLz0n75L/3qzr3Y4Hcd+JuClGWttL/prMn7ALa7a?=
 =?us-ascii?Q?1usxIV0sA9ZYsw64/6VyFkZGfwkd/LqDDmvBUkVS22hcZbzSnMyf8PyY3eD5?=
 =?us-ascii?Q?iBeWmNY5kOIhoVd+Ak6KShen88zOsS/ck5xhGpFJx3Z/JTrXxZuzzCPhwSM8?=
 =?us-ascii?Q?aci+ZWEa5HokDSsjNdu766kgRJwdqjUc1WK5s7QEDDzij83IFKgjB5KKSDcQ?=
 =?us-ascii?Q?5x0n/6giufNM8PRGLtALcycAFQxuwYXYLbW7VcvR+z6Y9gg71k15rqRYU1cu?=
 =?us-ascii?Q?5Pn6ZbZpRKIh6dQ4YzHt6C67slntS9WNKppSkAds40vkWIGB6pXs5mYoFa+S?=
 =?us-ascii?Q?Lf1JSxdmj/hcEYutqjwVwzV6tx3CW8pbUNZZ6LH1ekMLByfg/em1DWprF8pr?=
 =?us-ascii?Q?J8B6p0RLfuIQXQzY7VpoSOWR1seBtu50IHCy4+t6le3XL3zg1y1DWHA9c+tK?=
 =?us-ascii?Q?dIrfEVhUiryzPtVui8Yl4INd9fsqglw8E+Qop/FjETRKE2sYIo70s9yhVb2l?=
 =?us-ascii?Q?el5quSPZJpzawoQjZDmvVkU20YW2M2OWp8fhycJAiPp3jx4RZv4QV/sipetV?=
 =?us-ascii?Q?cRFaU0UjJdZZgIlrcVpcbrcoL9SX8XQWAme+vDSu1JmrFNSa4rNPi0OAp7RS?=
 =?us-ascii?Q?CKGPmS615h70tVV0GJwese7hVXXBQfU3zLbg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 04:59:30.7116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474ff59-d68f-40a2-0e8d-08ddd6385c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

During a DPC error kernel waits for the link to be active before
notifying downstream devices. On certain platforms with Broadcom switch
in synthetiic mode, switch responds with values even though the link is
not fully ready. The config space restoration done by pcie port driver
for SWUS/DS of dGPU is thus not effective as the switch is still doing
internal enumeration.

As a workaround, save state of SWUS/DS device in driver. Add additional
check to see if link is active and restore the values during DPC error
callbacks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Use usleep_range as sleep is short. Remove dev_info logs.
v3: remove redundant increment of 'i' in loop (Ce Sun).
v4: Add timeout for wait (Kevin Wang)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e4ecce1c4196..c8fe3e34e784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -918,6 +918,9 @@ struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
 	bool audio_suspended;
+	struct pci_dev *swus;
+	struct pci_saved_state *swus_pcistate;
+	struct pci_saved_state *swds_pcistate;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 26706fab0de9..0e8c17f328e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
 		BIT(AMD_IP_BLOCK_TYPE_PSP)
 };
 
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);
+
 static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
 					     enum amd_ip_block_type block)
 {
@@ -5027,7 +5029,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	adev->reset_domain = NULL;
 
 	kfree(adev->pci_state);
-
+	kfree(adev->pcie_reset_ctx.swds_pcistate);
+	kfree(adev->pcie_reset_ctx.swus_pcistate);
 }
 
 /**
@@ -6985,16 +6988,34 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct amdgpu_device *tmp_adev;
 	struct amdgpu_hive_info *hive;
 	struct list_head device_list;
-	int r = 0, i;
+	struct pci_dev *link_dev;
+	int r = 0, i, timeout;
 	u32 memsize;
+	u16 status;
 
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
 
-	/* wait for asic to come out of reset */
-	msleep(700);
+	if (adev->pcie_reset_ctx.swus)
+		link_dev = adev->pcie_reset_ctx.swus;
+	else
+		link_dev = adev->pdev;
+	/* wait for asic to come out of reset, timeout = 10s */
+	timeout = 10000;
+	do {
+		usleep_range(10000, 10500);
+		r = pci_read_config_word(link_dev, PCI_VENDOR_ID, &status);
+		timeout -= 10;
+	} while (timeout > 0 && (status != PCI_VENDOR_ID_ATI) &&
+		 (status != PCI_VENDOR_ID_AMD));
 
+	if ((status != PCI_VENDOR_ID_ATI) && (status != PCI_VENDOR_ID_AMD)) {
+		r = -ETIME;
+		goto out;
+	}
+
+	amdgpu_device_load_switch_state(adev);
 	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
@@ -7096,6 +7117,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	}
 }
 
+static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(adev->pdev);
+	int r;
+
+	if (parent->vendor != PCI_VENDOR_ID_ATI)
+		return;
+
+	/* If already saved, return */
+	if (adev->pcie_reset_ctx.swus)
+		return;
+	/* Upstream bridge is ATI, assume it's SWUS/DS architecture */
+	r = pci_save_state(parent);
+	if (r)
+		return;
+	adev->pcie_reset_ctx.swds_pcistate = pci_store_saved_state(parent);
+
+	parent = pci_upstream_bridge(parent);
+	r = pci_save_state(parent);
+	if (r)
+		return;
+	adev->pcie_reset_ctx.swus_pcistate = pci_store_saved_state(parent);
+
+	adev->pcie_reset_ctx.swus = parent;
+}
+
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev;
+	int r;
+
+	if (!adev->pcie_reset_ctx.swds_pcistate ||
+	    !adev->pcie_reset_ctx.swus_pcistate)
+		return;
+
+	pdev = adev->pcie_reset_ctx.swus;
+	r = pci_load_saved_state(pdev, adev->pcie_reset_ctx.swus_pcistate);
+	if (!r) {
+		pci_restore_state(pdev);
+	} else {
+		dev_warn(adev->dev, "Failed to load SWUS state, err:%d\n", r);
+		return;
+	}
+
+	pdev = pci_upstream_bridge(adev->pdev);
+	r = pci_load_saved_state(pdev, adev->pcie_reset_ctx.swds_pcistate);
+	if (!r)
+		pci_restore_state(pdev);
+	else
+		dev_warn(adev->dev, "Failed to load SWDS state, err:%d\n", r);
+}
+
 bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
@@ -7120,6 +7193,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 		return false;
 	}
 
+	amdgpu_device_cache_switch_state(adev);
+
 	return true;
 }
 
@@ -7555,4 +7630,4 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 	}
 
 	return uid_info->uid[type][inst];
-}
\ No newline at end of file
+}
-- 
2.49.0

