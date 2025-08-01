Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DF2C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 11:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCA110E3D0;
	Fri,  1 Aug 2025 11:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EK6EZJp8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2124C10E3D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 11:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUHFiFN5Syv7Gocw3xrrJehmxhqV/4hxTecWW9lGrwbYWnzfFdmOmftSSJm/SRITOI3iNz/xgmrztZt2P3tbuXEcBgWyqksbtAL/66Rb4eLk16TGuDSMx8zzNGsFOVdxMdn86nUOZq0+MeSrFYUIY6XGAv1tE7+w8N72TTS2Wqio/teOagqywzDDczJDzy8OUSw/ftWJlqtqWDf/HZTVVLz5WwkQep+KOdj/VPcnaIoqStLyGgg4sb5BdK8nv11glK+fjZvW+9yJW9Yhp85ykkS6JcSHs1kK5J9XeIKPIIxJ67L0/KGsdE/Ou4b1/28jtywz/64ceA1+G7eHcRcy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEN2+aip5YdszcUQ7Goj/ujifkwMnPXXYESMBzMm1nQ=;
 b=FDmG0ZsGBvwWm3Wy8WT8gcAhydKIMw4WXdeOQjhPhScs2v3Wx5Ww70xoeCcJAzfXdxOlPYy0J1XmzC90sRPmyB5v7d9dyp+xWuEpXFg9WbGw7OuXs+UrW/U1nWJU1mJpciqHRZRj+20fqLimfaUSLDzvcFP4mkBVaqyiFgaMWCqFKWRa5EVWE2StsIetXVhyfsjk3YEnDMNDCwr7k955skUDE2BhZn8UNIzaTFgm6xjBMkLRY7N+1HsbaYpX+hKi840zfoR7oPWSzXz+zRHbTYGt24IVL0qawOpAt7ee284ifAMatA/8CcSd057I5kl9lOqopcJg55ngfp6enXY7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEN2+aip5YdszcUQ7Goj/ujifkwMnPXXYESMBzMm1nQ=;
 b=EK6EZJp8Y2CugcEQ8212Dz8w9vheNiQ0Nnti17CwYHEpflFNYzEdLqX9cawkEYWMaU6RUfNah3jdbUg8Kcuo9WNIN5ScurlWjy6HLe76IoPEde99nZM2co3AdfhrKfrPODilxf1EdPGhUpgLSrcy5Z9UthloQke1gIe6ytiA7+U=
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 1 Aug 2025 11:14:09 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::be) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 11:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Fri, 1 Aug 2025 11:14:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 06:14:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH v2] drm/amdgpu: Save and restore switch state
Date: Fri, 1 Aug 2025 16:42:56 +0530
Message-ID: <20250801111349.1709332-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 307a0f8b-3a46-4beb-ad52-08ddd0ec88c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9gvqzQbVpqb2J/CpcIz3CR9Q74ieB1jBY9Sjzvh16gj+FNmIuO8ZB1TlR5aP?=
 =?us-ascii?Q?rF9pNaycTsOxcU4mk3Wd95UZxhykdVn5b8QZ3POYPqjsLHSUidCR0pKscKBv?=
 =?us-ascii?Q?3elluYp8XLraPjovlTfOCWEpfZdo+NwQQnraoZQ9gFau+ZO+tCWBi9inTaJb?=
 =?us-ascii?Q?bG8U0bUw16judo9He2C+tK5YbTLAsKyQOmnc/IWHHey80J9qgyCjovSnIWY1?=
 =?us-ascii?Q?43Of28UwrVhtaoFTp021SG/aeoDd8ZVuhcMPDsTX23YAq9WHm9IyZtOW0jHi?=
 =?us-ascii?Q?S/dDgHH4v6CmGGUytMWYTLULujciVUWCn13H3RQU8Q8n2ouZj4NUuMBEWQQ0?=
 =?us-ascii?Q?O9Bqb2qKmzBvDzg7wkmVjnCH8quRutD+mS0SfU704vu6CBvmP2+qXP0EdeVV?=
 =?us-ascii?Q?Ab4EtoWQEhVsSDfZ/OtWZLviigh+wS5bMAe/AFy3K1DDZTevSeQX4uDSYEdP?=
 =?us-ascii?Q?hFDxbIIaFHrruV2s47nCr2yr6A7oId6u1F1yLmZGq5zyUN59VhngzUWTdEQY?=
 =?us-ascii?Q?Sg7WGq1r5JJwRIyhLh2I0sI9608t32lVmR4mLHpUxz2QsspjhF71l5kaLUIY?=
 =?us-ascii?Q?dj3qXI8gUcomu15m5bB4vLrmgx4qrLktsRZkIbIz5zSZcP7WV9pWQ6GDuRnM?=
 =?us-ascii?Q?6XUU93Ead4hYlUoEpSaeI/6pjf8GO+0xgzbSp6Ha5CWvdO9utIMk6gFky4zc?=
 =?us-ascii?Q?LG6gzJ1s9oLe31TPT6PGYZ+E+zvaC8BLmOyA7OhgeuzlCK999EzUNQckzTIS?=
 =?us-ascii?Q?SSwk1KVw9tNqBrR3OGphZ2XcBS9OXmeWeqAkBTCZp9tswa/CBzkN9GAqgRG4?=
 =?us-ascii?Q?bZLvjnIZNU8+tmvj7oPZt78jaWHpAPXnX+oIKtqa5FVZ5AKGdX+GZMydSHhT?=
 =?us-ascii?Q?c9ibcX+Dyru9WBrzIVx+7UCUcPawKqXGJ1XulaI/aWKjZRhRvL43uhXV+VNW?=
 =?us-ascii?Q?79BGPTrEaoUTdX14m3atijPwr1gALlS8G0c939gVMFUlr9ZRVsxbtjHmdVpk?=
 =?us-ascii?Q?GWwDlcmjANwT1it3n5yWyiZOsw6QAsUuFxfT0GHpVJthBOa+taWDIO+t9Qd8?=
 =?us-ascii?Q?coISKi5UWuF1lwGzvLnF5yD4hSeOhumRqN2WpbQSEuyRHTAvs4H7z00eCksp?=
 =?us-ascii?Q?jAwF2GvoB5L4NeNsO/wFPA4V2Yjn9tLqdTcoQ5UZv6xsU9E12WUU1Od4DsLb?=
 =?us-ascii?Q?msmyW7yLFun8rxpSPAJ3Fj3AjkYKzdwGhwFww/4Zef8Zj2y2TAgVBiuwd3Ak?=
 =?us-ascii?Q?52EyT08ltNhJuTh6h+Q2njyYgx2TYWjkt2WbUSUB47uMRaxu0pdlyzJ1dqL8?=
 =?us-ascii?Q?UwAr+6glmOkpkjbqaZYfze6lg4c9aqsFkNqGvcB9DDL7o0yoGcDuhc0uHX+U?=
 =?us-ascii?Q?/m5RYCGncg65IYnY+RJbiDijsGiQ6tJAdPCUI4EsX/w6HVq0BmswKRret2wZ?=
 =?us-ascii?Q?DW4uzEsAIDqm6YFiVv0pVLU/hFr53nZ8zmEYcTV+dK9EJbWyy4jWektdNxlT?=
 =?us-ascii?Q?lJkKIHzllpiKFIV7O/T87H1OfrTUFHFO64B3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:14:08.1633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a0f8b-3a46-4beb-ad52-08ddd0ec88c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 74 +++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

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
index cfd72faec16e..e7dd96058ed5 100644
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
@@ -6963,16 +6966,29 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
+	i = 0;
+	do {
+		usleep_range(10000, 10500);
+		r = pci_read_config_word(link_dev, PCI_VENDOR_ID, &status);
+		++i;
+	} while ((status != PCI_VENDOR_ID_ATI) &&
+		 (status != PCI_VENDOR_ID_AMD));
 
+	amdgpu_device_load_switch_state(adev);
 	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
@@ -7074,6 +7090,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
@@ -7098,6 +7166,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 		return false;
 	}
 
+	amdgpu_device_cache_switch_state(adev);
+
 	return true;
 }
 
-- 
2.49.0

