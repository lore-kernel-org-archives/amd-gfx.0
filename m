Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5394BC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 12:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2B610E844;
	Fri,  1 Aug 2025 12:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOXYuZsb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C1E10E844
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 12:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhmAqGZ+0w2DLuC/bN6YR1vsjYCSAJnpZYZITtS5/SU8dnY0fPMVesPRU91Jtyj4lEkfae5dJ8rsa2E959uMHdQSWwdfDA0HbsCvKiBKALBhjrPBpA6XlsY9Zy4g8Fa/NenKgwMuoJ9WQS+x206w6His8gWWxU4tkslxa9t7PyBmzDidKh9I7TdKiXBa75taTnBDKZD76FJZIB4LFT7W7UTsgVoU8C74alMO7JiEislnIe6y3p4VUNhQ0c3OmxdftyQ47Zpip9DSYYdNJMg4rhNmKXnHQS8WIEMzVtvGIdqITx463cAYziTEQziKLgQnty/hEHs7xxt61kbavcUZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbgQHGwxMq/BkEp+cAUS2T2PzyRTG8mRXbU7q/Uolsk=;
 b=xEP8SGUO0D1NyoffiJW8NyI8CLJnri4xrw+muDwGbICEhyYXaiZwQOkMvN87OzEnyVOOr+n4tgpt6Ru8HqUnDlkSTvtEKLN+oEv9kWsaaH3l88ARODtKivVshmxgOl32R09n4r5dIT7RmTRU3u6Z3R1y3wUG+9g8zjYwCPzdgHGuruzzfo8V7r/8NSPQD+H5HSYhxwe6BfGvKofgGwOn8FUNLIJAeufVH+dmmiR01XSwthBFYC4srAa6yGtiDZh0uLM+1QDic//tyMWwjSqNib9zRHeTgX3hJirR8n8/ULr2+BJoV6szRhLk1Cyd9ageXDQRfKZyUQ4czOx5mAkaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbgQHGwxMq/BkEp+cAUS2T2PzyRTG8mRXbU7q/Uolsk=;
 b=xOXYuZsbxF/9OyaEq9eynNv29b0R1QGyNRQclhQN/Euvq99LckML/0L3TW6oZJugupAKVS+dBrU0qF3jpPikl/ibaN2kE6FF2DNgLRTmwmx4je0u1Zv+4RkIBc5cmi5Xc041djrFLaqDlw7sIFbsw8mZCB8Kyh6DozZ/QPolagA=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 12:40:45 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::1f) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 12:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 12:40:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 07:40:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH v3] drm/amdgpu: Save and restore switch state
Date: Fri, 1 Aug 2025 18:10:07 +0530
Message-ID: <20250801124027.1709925-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 640e4d28-2fa3-455e-1589-08ddd0f8a29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?esg8C/SrWuMOYvONlujfcJ/9AWGPOf7bCY2I9BBqi59sAkQR4gysDCP2m5hR?=
 =?us-ascii?Q?XFHIVxzozNqPoo5sBcvT6JzHMBi4+niYn5jxx9vuLt/TWMYTv5Mxbg/2Dunj?=
 =?us-ascii?Q?6wEgOdIyLtbyqRZzSBH1eUdHqVMewtt69X1PGwDbQWO/f1XAEQ6mXKilvePk?=
 =?us-ascii?Q?JZvMkyxB8awTXu0lz4Pbw3JmcxSiyYcLFRk9mGwrW8kjkqUhuazc6He6LP2B?=
 =?us-ascii?Q?mAQiEFDEqvwtiBPpk2sAneanOIYS0UGe1u8Eu5X33ijic32TAI9panatdhBR?=
 =?us-ascii?Q?gVFkdAOH8jRdsv/aA0TCW5TF34UZ131nrdDmrXrJ8YdBI+lejRO/1heZ/7ck?=
 =?us-ascii?Q?xSA5DET9CjUGEM1BaOPbCKuWBD1SJCLn4xP8r7SAuZa9725PpW2KQnQSY8Al?=
 =?us-ascii?Q?7MR+FnqLzJ4+gUUdS9ygQtQwAVd1J+a1d6+xVc80N8ppWqH2IcsL+OFyBu6s?=
 =?us-ascii?Q?XT7NChbzZn8EI7kNPj890SZPps/nDCdwWvh7daTilzHIgFUDzLfk8OCd+W0J?=
 =?us-ascii?Q?eO0ETmtXRk/TwfG/w9Qa9kMM9m6xPcIW0zRTSrr0JePDqVrGVqzawLGX4aCg?=
 =?us-ascii?Q?CxnhLDdKNCIGHVpdOjYQuvfP44cihPyxBXyPVti86TWy2CXC+5cqvgEoyRdg?=
 =?us-ascii?Q?gn4cpX2maWUW4IZpc2qTJkqQ5opcBFmYHqFfenvtwZvJNHBb/jS4FgNmyXLz?=
 =?us-ascii?Q?Eng3IOXTHN4Bo+nfRwt+bL+X32YA2q8UOntl7RtY4JKI6rFuXdOXdaAy3sxZ?=
 =?us-ascii?Q?UprDvI3CLowzwSCoADuJ/3JF5RAlJMrHv3Etwf+7jp8JbcbgN5WDg2fhV1wl?=
 =?us-ascii?Q?u649d9O7R0cvX74oc+NUIaldDib1BuxFSJx2kElB6/dSy275szg/R7+kBkyT?=
 =?us-ascii?Q?02qYfjkl0uHjBeas4aE0CK3kvn8VLWuwm5LAAIaZmw/zcZKNp/jR5TKBReMS?=
 =?us-ascii?Q?WNKMXZW+DRPe2wMicw+CqmnIv+Tk/Z6ca81ibmFJBXaFOdrLXMoamcokr8Kf?=
 =?us-ascii?Q?nKG2Sk1UnV8ozxqzjWgX1gLQG9CWRli8RZe3g0lfA34NCczZatchKKIR/wTh?=
 =?us-ascii?Q?vrejJwe241cQLmRIj7BVKUV2J2jKIBXWhYwF0uVq9oWiwZRRhLWXKPU+V57p?=
 =?us-ascii?Q?+/uclzlHUFW51njAhGbHOEn4+0/4DMYqvwoMIGyHGZhuXMA6j41RX4fgaMcb?=
 =?us-ascii?Q?f9/UbaSstSw34Mup+iTIiPx/IVKlepVmTcAkmoFLjDqnY3dCnbjalkOf9DZK?=
 =?us-ascii?Q?hQeiKcwaiXYmLUMgwJ3kTHtpbClcJIw2PGltHhng68AGunIh5XWFIyiWIuxw?=
 =?us-ascii?Q?XtLyIJODg2xj4ScXIoOqztg3BJeYrMMx1uEGS7pd2VM8cuCWgLG+5MgfmBsY?=
 =?us-ascii?Q?+uyZjHWEZPUmP96/Iueh+0l8ZVenqsi45LUTgXIuvFg6Ro1uLR1sdK5mu83n?=
 =?us-ascii?Q?RAfxnhToWS5SzvpnVW1qDWAkZN07niUXMBpZSBB1liaw5ja99MATR7WxyGcv?=
 =?us-ascii?Q?xd861L0vh1Q9fLlRti2UZ68hGEaW7C6df1Zs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:40:45.4777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640e4d28-2fa3-455e-1589-08ddd0f8a29e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 +++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3550c2fac184..96d772aadb04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -904,6 +904,9 @@ struct amdgpu_pcie_reset_ctx {
 	bool in_link_reset;
 	bool occurs_dpc;
 	bool audio_suspended;
+	struct pci_dev *swus;
+	struct pci_saved_state *swus_pcistate;
+	struct pci_saved_state *swds_pcistate;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cfd72faec16e..e58f42531974 100644
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
@@ -5006,7 +5008,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	adev->reset_domain = NULL;
 
 	kfree(adev->pci_state);
-
+	kfree(adev->pcie_reset_ctx.swds_pcistate);
+	kfree(adev->pcie_reset_ctx.swus_pcistate);
 }
 
 /**
@@ -6963,16 +6966,27 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct amdgpu_device *tmp_adev;
 	struct amdgpu_hive_info *hive;
 	struct list_head device_list;
+	struct pci_dev *link_dev;
 	int r = 0, i;
 	u32 memsize;
+	u16 status;
 
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
 
+	if (adev->pcie_reset_ctx.swus)
+		link_dev = adev->pcie_reset_ctx.swus;
+	else
+		link_dev = adev->pdev;
 	/* wait for asic to come out of reset */
-	msleep(700);
+	do {
+		usleep_range(10000, 10500);
+		r = pci_read_config_word(link_dev, PCI_VENDOR_ID, &status);
+	} while ((status != PCI_VENDOR_ID_ATI) &&
+		 (status != PCI_VENDOR_ID_AMD));
 
+	amdgpu_device_load_switch_state(adev);
 	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
@@ -7074,6 +7088,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
@@ -7098,6 +7164,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 		return false;
 	}
 
+	amdgpu_device_cache_switch_state(adev);
+
 	return true;
 }
 
-- 
2.49.0

