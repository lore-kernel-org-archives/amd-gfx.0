Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8128CC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 07:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283C810E7FC;
	Fri,  1 Aug 2025 07:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/G7m42M";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFFD10E7FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 07:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAF8/3EpGXem6XBUD8E7ymKyrFU28qtEHQAFqUEpj/svay8PhAcx4n9kDiwFdXBEwxYMU9TDqKyap3cLu2/X39Tx/+oSKCPTVVifcDEen6y9mJeGaXDRfXW0fe7TZiLX1noU/db/0lz8DKVnz1HQXV6Be1w805XCCAN7mUHl/BnzEQmCUME2HV1ASRbj/P69TOe3ElS9VWjco9ybhhOYLrTM6KvHFicixDVPCVVwx0SVdrmR9MftXD7uGYviKie9239gpqq+ac3Y0ez2qaz6saKmTsinzW/AXrbUSgN25gM/V/DE8CUTsq4GAcrrZOCjXbvrixOlxGNc+yq/A2C+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emK77gEje38KVh9owS0prpLDD4dKKtgvQNn9zfEYoCs=;
 b=klpuUT/Z6A+QvrPoXwLWMEwg+GNiRiN1zU0HkozBqpEnmrCp/RUWVF1zR+T/AHtEVDhaWpJZ0xm8cxF+EXa24jobyAelhl7IOT+DCW9ESFcYrvmasp7ukiOHHvbmyM9aej3hK6EeQoQlMZj2Gf9NewCWxfjcHG2bPDIZz3ocoBnki7gyh7vXmnCrDasBEXZ3d8xZ3zFutxzMimkxBlx415QxIwLpVk4pwb+egp7k+ybRkP9+fBpImCZ/PO6krTUNjFMOGYcIIiZiBPkiINRbsFYP1ECJWWB7HekbBr4nIE9OL+J9R/Zgb6AGy3lAFmiyGnuWtQLAdosgjxXWMVXk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emK77gEje38KVh9owS0prpLDD4dKKtgvQNn9zfEYoCs=;
 b=v/G7m42MLytnWMNT+668JrIRq4qaULnZBdyfrY4LhnFPGMDO5XpM9Pw+pWRZvnaZEMxGEqx1RBr2Jr08lvqZlBw+LCCz1CbCt4h86ZNDpt3mLNT7rqOjNOAPQbWPwOwEmydf+dfqYdHrODSpw3fyiUWimy8Qv5cugOE6au6QUfw=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.14; Fri, 1 Aug 2025 07:27:10 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::a7) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.5 via Frontend Transport; Fri, 1
 Aug 2025 07:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 07:27:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 02:27:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Save and restore switch state
Date: Fri, 1 Aug 2025 12:56:51 +0530
Message-ID: <20250801072651.1703020-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc42c94-0367-44c3-33a7-08ddd0ccd36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q4rBk0N6KcTHJObJWG8rN6Nmn3zFvA3EGXQ61TmBizFXvkSZPuvQoT0DDbWc?=
 =?us-ascii?Q?haqeiePV8OszLkI6cFyB1ya5XQfcqpnYHaBbariuXwS+VjymHrR7fuou5Nvy?=
 =?us-ascii?Q?gHERLqcSRLgsTyMU1BfvP980/TmyXKBk80OSiokkVY8EJ8JpFLDV41LMaEKD?=
 =?us-ascii?Q?3SusDFFLccQEdkEbG2LmiVdggjE7GDtIQ9UPWGQXkOghCxzAeYRbmzkAQyXP?=
 =?us-ascii?Q?Q0pUTYeFE/fO/nXaH3LtyZ+jYTSHmtZxwneYZr+1tP6ewGTK0Ci1HDZAhBi6?=
 =?us-ascii?Q?RWuwtafB5BtiOtO+wTpNUK8OiwTQWR//TcRKPbxGhorxwv9+uVag6+bX4X36?=
 =?us-ascii?Q?BogInlnDZGyOGqMruErxMiXLGa8yDtECrcbAGYZrQGa26rlCn++QCCBT1t8e?=
 =?us-ascii?Q?OD3jVKpz19sVuwLllh/vkHz8DfFQJRhS5SXn6Lv5PMQOYwNlJEK2nbx4iivD?=
 =?us-ascii?Q?Qr7IHfz4lza87DiB0rjh22JFnmpDDWuYMI7WkjMG5bTQImRjFhgvhAp01a4m?=
 =?us-ascii?Q?DF2yppENqSABwZwqK5LhmXjJqG9kAv7v7KAbbf0lrnvPK1eUl1GvLwvMgk0F?=
 =?us-ascii?Q?3go2ZALB3o52ZtDoZ/VDxCHD+cGp6ZrpbyS8Z5oct8KPqF7VbhMi3x+IZ1UR?=
 =?us-ascii?Q?AyU+9euyZkSI+f499P8YWFP1J7lCZOp4QpV3Y/kO5agmEiBMNu4vATvxAVXl?=
 =?us-ascii?Q?y5APjatbJMAkgP1xrfXAzdlKHg7UpADcGkPHJbgjHkJFg/Z1UOeFpVLvPENK?=
 =?us-ascii?Q?egRhleC+DJm+Y6x8kVnsHqfXe+9ypRNVnF4nrkPC9FHOa1KwW5yMmGm/Bbl3?=
 =?us-ascii?Q?iuDYP9/tjV+RnjmFgv08kUQS/EyTtt56W5kql+cqSrcPvEkO3r3um+QZYojj?=
 =?us-ascii?Q?4ksIeNBsTlpP7WVtFbmd8oAiC7mi9Trn1kmV5LBJ68vnrd80g4btv6pmkm0r?=
 =?us-ascii?Q?z4ctA7yUHVu5qGABAJ53XHSV7zVrZH6XYJxc6RauoPSGR5o2Ge291S6XSVi6?=
 =?us-ascii?Q?Tuxa1b2/kukQ+lyvQFT5NKJm18+YbX847lpfsnERE9oob2x4ojSkF9Vybhcb?=
 =?us-ascii?Q?STI+5wo6dil3nu4FQbva1Jc6/CtWiQWvShC1k2D/3d7rARD4rZcrKqmChcyv?=
 =?us-ascii?Q?G2U4ke9Qtz4Etom0GFyoVCfsgLfpT1oIQl2yXL47SvEXpCpuK+0wEE3Ch3Lr?=
 =?us-ascii?Q?knzJ5PFI5oEc96QUlxSCyAjgiKVcVwMwQOhOHQnYQwQlgBxtQBKZizpPga47?=
 =?us-ascii?Q?b2Fk3rx5iaxmT3dvxsrIU3pWjaVAtS4wUMWvt9DfVhCnVxdNHjj+QYMuR9RL?=
 =?us-ascii?Q?t4fhiCy5g6jFC7Zb2he3Bp/ZXNw6dMdFh4KedtLEKW+6uF9jsC2IfCQWuRA4?=
 =?us-ascii?Q?qy0RhyAfXAFc82uwYWwKCLoxK8mYTXCSIDspLY5ISrPFrOEMzGJ1lobfnhnG?=
 =?us-ascii?Q?wQdNnZ11VLDG3zkqiyHqPs3/8w5UvheAoH3mytC1zKeBnv5cB6L1YtNZ802Q?=
 =?us-ascii?Q?Vz20AoJEF18PmwtFqwODCHz6Rfbb6Jp9lhlz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:27:09.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc42c94-0367-44c3-33a7-08ddd0ccd36a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 +++++++++++++++++++++-
 2 files changed, 78 insertions(+), 3 deletions(-)

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
index cfd72faec16e..962c57a3ec93 100644
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
@@ -6963,16 +6966,31 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
-
+	i = 0;
+	do {
+		msleep(10);
+		r = pci_read_config_word(link_dev, PCI_VENDOR_ID, &status);
+		if (i % 100 == 0)
+			dev_info(adev->dev, "read status :%x r: %d", status, r);
+		++i;
+	} while ((status != PCI_VENDOR_ID_ATI) &&
+		 (status != PCI_VENDOR_ID_AMD));
+
+	amdgpu_device_load_switch_state(adev);
 	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
@@ -7074,6 +7092,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
@@ -7098,6 +7168,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 		return false;
 	}
 
+	amdgpu_device_cache_switch_state(adev);
+
 	return true;
 }
 
-- 
2.49.0

