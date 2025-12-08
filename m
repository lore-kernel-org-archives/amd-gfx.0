Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C7D3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 07:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8501510E3A3;
	Mon,  8 Dec 2025 07:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eEVHtoW0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D404110E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 07:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWHdbn6G5qFRecJqfgJgP2JV7019C5Ky1lX0T/xQv4kM/WoDPbmnY0c7a4BM5NLA6wRzJmgFdTj44PqtEBRzywvleWRoDF4grpmZcMyClbUPICnr3koM3YnHCw5LKQoeQHgi5NGhMHLVaJ6t/RAwQ2L8j6dS1V/svT6dcIZR/Z1uSRn+Jt00I1RsCUgntYvgABKPvuPEeYI/ErUa3+6BGP2aaI5ecYpkLU5MKMvCBkvVcLP9DU6MEaPXir3U8nLQrJd9BV2yGK10UEB07AkeQEtkfFesTHD1OGyoPyR4EgHUaCmWGnnkPVzsMJIvSLJdCYwpQe9vwqpz1ZQdoGAMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+vNAmlgkPN60/njgTjuIMS63sLi8LrMdtoMh9kCHOE=;
 b=taY/DHF2Jmog8gFrt4j9wni/YIvk2R2ouba9fGDoq3C4vZnQZigrndRySM+sM2AHNa+DUtSdE1IDU5WtMlGViQmVDOutP9a3inI+T/6MGPN9WVjDD5hcEmn9yZ3lGa9qIvKpXcLEjTLYgP59KPHnZQh9+5DKaN+jddI1R8jbc9VA8MqX4yrhn6a07GVb4bJerlMUpvfQEKCQFgu5aEy1PH53l3ssgwB7ufO5JAc7rvVhX1HUVeY2pD+b6DZb8l84uuDLyaljE9B4yWJ9PeEHVT/dpI0gFkRF2PPQ+djq8mmfkdqZ64iu5nXDXsBu+6t+tbkwONfalA4qPt1fz+0EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+vNAmlgkPN60/njgTjuIMS63sLi8LrMdtoMh9kCHOE=;
 b=eEVHtoW0S65gg574kFrYl7pYE5/PGWkpWjE46qt2I5oIHH/Vc0YduQ927Z41GT9cQEMdFgbGziC+GWYtcG7+74cSVumXt0y5i3A2vh/qqeS9BPRFR6uTkYIlHBEkXZW7wN3dxNysGbpVK29FRASLGqLFYC2Deg/12fISqsGsWTE=
Received: from SJ0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:33a::22)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:33:57 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::9d) by SJ0PR03CA0017.outlook.office365.com
 (2603:10b6:a03:33a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:33:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 01:33:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Move ip block related functions
Date: Mon, 8 Dec 2025 13:03:34 +0530
Message-ID: <20251208073336.1381340-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 7366bd57-c73f-4d67-5e21-08de362c2592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R6mW3QaepjU3MisavMcOJ3yo0X9b+XahoK+i+/EnWHsOGC2ase6ha9oW5INg?=
 =?us-ascii?Q?RerkFumbFrH+D/XNqXGBjKr+4pvDAlUGDemkx23gdcMXRD3iW/CNA6IA9KdB?=
 =?us-ascii?Q?ghsQk/tW5m/KeXNkDTPaEMc9TQayJk+6heuos/KBTuPG6IZcir/xJ4GM70HM?=
 =?us-ascii?Q?moeXVYf2SI06a/N94s3NtiCqAJdYXq8OBghNETJuH1bM/kg0NMe1Ej/Ihgvi?=
 =?us-ascii?Q?MlvuZOhtEjig0EERflmzjP11iIyUzhaxjYp5ZJHJbUCFugWtj7v3HrRd0gfw?=
 =?us-ascii?Q?6isOxMrlQuSGHIb2AuFBnkdThnTsm8Q5WdF/SUtWhSHeUsT3S8GRWudavq6g?=
 =?us-ascii?Q?xzUxNW6aA/N3xKBC34GO79GYP2VGxxwobnNj86nuCPv+9ygOZHQgaFPd8Wkp?=
 =?us-ascii?Q?NWaw487ryus60Q5Nb5tE+u8ltGg28OuCWywncpLUd9B5xkTDycwnRt/3F5fG?=
 =?us-ascii?Q?ewNdAQIZoyb/vNGsG/9RfRyAxqJn+6ulYMhB1Wm6z9xxq39XYg+0CLgMglJp?=
 =?us-ascii?Q?PToJ79f1kJSVSRjZSOy4WxuOPHuK3RiVQANlXN5DPIAitVyiZV16Ypy8qwyT?=
 =?us-ascii?Q?7nvKhhKnxdrmn3D0g40cP4ZAx/qNAcmtsK2ob69P3v4eRdki8G0WlLP6TkLq?=
 =?us-ascii?Q?KC8Q7NwrhUMnfDbm2g4Y8tn/mQFVovINU3tvxxST8aGT9f3Alg//r5ZkAaTP?=
 =?us-ascii?Q?Po9eau6mThRIXmDrj9psUPr3Em6Pob6F9pYGuh1SXmT73C5nKzwTvpK2ZDCY?=
 =?us-ascii?Q?p4NixlETgvkr7OcMAmrupRZyTs6Uaum1ZNgooNieYfADE5mvlTwdkv0U6/ER?=
 =?us-ascii?Q?V8C/ehuCKJzdJiZ330ZEGs7xQ+Rby6BHFA86RWTrDkzaYPP8jCUUzx1uDlud?=
 =?us-ascii?Q?gGs6mkxYDww2Q+bwLRGd2uICIhNm2thOpZN2jOLW0i0f1hiZLorVYISOpaVC?=
 =?us-ascii?Q?M2LVnGvuT8ITl3TyVMoqnP9carQHUgL8PwPI648rlYIYqqJVH2dELfgdCFZv?=
 =?us-ascii?Q?XFeSrd1QKCoRbb0jIvgBoFDxuloKp78cFZzNxcTWxC8DyGPu3aCGy6eV3gzN?=
 =?us-ascii?Q?++4aETGbv42UGSq5CmHK1gpTFD307LUfeGAkBQ3ZDk1hvyR2dtzdDEr6Kr1o?=
 =?us-ascii?Q?xCLpjb2w5v+c2EgdV2zEl//KLOl+OHkRXsylcQ3LlTBAfQTcGY724LaqCM/9?=
 =?us-ascii?Q?5adnRXOMjnLs+2U6YhJLdrUCSNP3R9NJ7KNEpfm6DoqCCMfFvjEKGdEK9kST?=
 =?us-ascii?Q?VYoNwChvxRD5LAlDBZ1GysJ3PkkhTZQYI8bIqB14XlEerxxRT6MqAFq1lIfo?=
 =?us-ascii?Q?x41pW+bPp4+KeyLfJd6XmlSxDTcCxQeaNed1AyzFa2CSW/HJhxOJVN4AWhmY?=
 =?us-ascii?Q?yWotpOXsQlHET6dryp7JSHmcsiqQ9rAUkZ3H6iPSL5ccqWfsaTcSn8phXday?=
 =?us-ascii?Q?VW1n7n4u86otk/3z0m5jZgNZab7Unkj212jYFwQJwEDYjtyUOtaDUj0pjd6X?=
 =?us-ascii?Q?tNXxj77LnGHTiYy8maSDIxDnfgMv1elaxC8Ye53CvoP9hI6ewpy97ek10K5Y?=
 =?us-ascii?Q?TJjd5R5N5+WALkpf3h8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:33:56.8661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7366bd57-c73f-4d67-5e21-08de362c2592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

Move ip block related functions to amdgpu_ip.c. No functional change
intended.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 121 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 323 --------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c     | 324 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 125 ++++++++
 4 files changed, 450 insertions(+), 443 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa71df36f4b3..de8fb746daf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
+#include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -362,59 +363,6 @@ enum amdgpu_kiq_irq {
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
 
-int amdgpu_device_ip_set_clockgating_state(void *dev,
-					   enum amd_ip_block_type block_type,
-					   enum amd_clockgating_state state);
-int amdgpu_device_ip_set_powergating_state(void *dev,
-					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state);
-void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
-					    u64 *flags);
-int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
-				   enum amd_ip_block_type block_type);
-bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
-			    enum amd_ip_block_type block_type);
-bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
-			      enum amd_ip_block_type block_type);
-int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
-
-int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
-
-#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
-
-struct amdgpu_ip_block_status {
-	bool valid;
-	bool sw;
-	bool hw;
-	bool late_initialized;
-	bool hang;
-};
-
-struct amdgpu_ip_block_version {
-	const enum amd_ip_block_type type;
-	const u32 major;
-	const u32 minor;
-	const u32 rev;
-	const struct amd_ip_funcs *funcs;
-};
-
-struct amdgpu_ip_block {
-	struct amdgpu_ip_block_status status;
-	const struct amdgpu_ip_block_version *version;
-	struct amdgpu_device *adev;
-};
-
-int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
-				       enum amd_ip_block_type type,
-				       u32 major, u32 minor);
-
-struct amdgpu_ip_block *
-amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
-			      enum amd_ip_block_type type);
-
-int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
-			       const struct amdgpu_ip_block_version *ip_block_version);
-
 /*
  * BIOS.
  */
@@ -757,73 +705,6 @@ struct amdgpu_mmio_remap {
 	struct amdgpu_bo *bo;
 };
 
-/* Define the HW IP blocks will be used in driver , add more if necessary */
-enum amd_hw_ip_block_type {
-	GC_HWIP = 1,
-	HDP_HWIP,
-	SDMA0_HWIP,
-	SDMA1_HWIP,
-	SDMA2_HWIP,
-	SDMA3_HWIP,
-	SDMA4_HWIP,
-	SDMA5_HWIP,
-	SDMA6_HWIP,
-	SDMA7_HWIP,
-	LSDMA_HWIP,
-	MMHUB_HWIP,
-	ATHUB_HWIP,
-	NBIO_HWIP,
-	MP0_HWIP,
-	MP1_HWIP,
-	UVD_HWIP,
-	VCN_HWIP = UVD_HWIP,
-	JPEG_HWIP = VCN_HWIP,
-	VCN1_HWIP,
-	VCE_HWIP,
-	VPE_HWIP,
-	DF_HWIP,
-	DCE_HWIP,
-	OSSSYS_HWIP,
-	SMUIO_HWIP,
-	PWR_HWIP,
-	NBIF_HWIP,
-	THM_HWIP,
-	CLK_HWIP,
-	UMC_HWIP,
-	RSMU_HWIP,
-	XGMI_HWIP,
-	DCI_HWIP,
-	PCIE_HWIP,
-	ISP_HWIP,
-	ATU_HWIP,
-	AIGC_HWIP,
-	MAX_HWIP
-};
-
-#define HWIP_MAX_INSTANCE	48
-
-#define HW_ID_MAX		300
-#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
-	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
-#define IP_VERSION(mj, mn, rv)		IP_VERSION_FULL(mj, mn, rv, 0, 0)
-#define IP_VERSION_MAJ(ver)		((ver) >> 24)
-#define IP_VERSION_MIN(ver)		(((ver) >> 16) & 0xFF)
-#define IP_VERSION_REV(ver)		(((ver) >> 8) & 0xFF)
-#define IP_VERSION_VARIANT(ver)		(((ver) >> 4) & 0xF)
-#define IP_VERSION_SUBREV(ver)		((ver) & 0xF)
-#define IP_VERSION_MAJ_MIN_REV(ver)	((ver) >> 8)
-
-struct amdgpu_ip_map_info {
-	/* Map of logical to actual dev instances/mask */
-	uint32_t 		dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
-	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
-				      enum amd_hw_ip_block_type block,
-				      int8_t inst);
-	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
-					enum amd_hw_ip_block_type block,
-					uint32_t mask);
-};
-
 enum amdgpu_uid_type {
 	AMDGPU_UID_TYPE_XCD,
 	AMDGPU_UID_TYPE_AID,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a0213a07023..d93453c3b07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -313,42 +313,6 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
 	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
 }
 
-int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
-{
-	int r;
-
-	if (ip_block->version->funcs->suspend) {
-		r = ip_block->version->funcs->suspend(ip_block);
-		if (r) {
-			dev_err(ip_block->adev->dev,
-				"suspend of IP block <%s> failed %d\n",
-				ip_block->version->funcs->name, r);
-			return r;
-		}
-	}
-
-	ip_block->status.hw = false;
-	return 0;
-}
-
-int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
-{
-	int r;
-
-	if (ip_block->version->funcs->resume) {
-		r = ip_block->version->funcs->resume(ip_block);
-		if (r) {
-			dev_err(ip_block->adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				ip_block->version->funcs->name, r);
-			return r;
-		}
-	}
-
-	ip_block->status.hw = true;
-	return 0;
-}
-
 /**
  * DOC: board_info
  *
@@ -2265,293 +2229,6 @@ static const struct vga_switcheroo_client_ops amdgpu_switcheroo_ops = {
 	.can_switch = amdgpu_switcheroo_can_switch,
 };
 
-/**
- * amdgpu_device_ip_set_clockgating_state - set the CG state
- *
- * @dev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- * @state: clockgating state (gate or ungate)
- *
- * Sets the requested clockgating state for all instances of
- * the hardware IP specified.
- * Returns the error code from the last instance.
- */
-int amdgpu_device_ip_set_clockgating_state(void *dev,
-					   enum amd_ip_block_type block_type,
-					   enum amd_clockgating_state state)
-{
-	struct amdgpu_device *adev = dev;
-	int i, r = 0;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type != block_type)
-			continue;
-		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
-			continue;
-		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
-			&adev->ip_blocks[i], state);
-		if (r)
-			dev_err(adev->dev,
-				"set_clockgating_state of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
-	}
-	return r;
-}
-
-/**
- * amdgpu_device_ip_set_powergating_state - set the PG state
- *
- * @dev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- * @state: powergating state (gate or ungate)
- *
- * Sets the requested powergating state for all instances of
- * the hardware IP specified.
- * Returns the error code from the last instance.
- */
-int amdgpu_device_ip_set_powergating_state(void *dev,
-					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = dev;
-	int i, r = 0;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type != block_type)
-			continue;
-		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
-			continue;
-		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
-			&adev->ip_blocks[i], state);
-		if (r)
-			dev_err(adev->dev,
-				"set_powergating_state of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
-	}
-	return r;
-}
-
-/**
- * amdgpu_device_ip_get_clockgating_state - get the CG state
- *
- * @adev: amdgpu_device pointer
- * @flags: clockgating feature flags
- *
- * Walks the list of IPs on the device and updates the clockgating
- * flags for each IP.
- * Updates @flags with the feature flags for each hardware IP where
- * clockgating is enabled.
- */
-void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
-					    u64 *flags)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
-			adev->ip_blocks[i].version->funcs->get_clockgating_state(
-				&adev->ip_blocks[i], flags);
-	}
-}
-
-/**
- * amdgpu_device_ip_wait_for_idle - wait for idle
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Waits for the request hardware IP to be idle.
- * Returns 0 for success or a negative error code on failure.
- */
-int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
-				   enum amd_ip_block_type block_type)
-{
-	int i, r;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type == block_type) {
-			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
-				r = adev->ip_blocks[i].version->funcs->wait_for_idle(
-								&adev->ip_blocks[i]);
-				if (r)
-					return r;
-			}
-			break;
-		}
-	}
-	return 0;
-
-}
-
-/**
- * amdgpu_device_ip_is_hw - is the hardware IP enabled
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Check if the hardware IP is enable or not.
- * Returns true if it the IP is enable, false if not.
- */
-bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
-			    enum amd_ip_block_type block_type)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].status.hw;
-	}
-	return false;
-}
-
-/**
- * amdgpu_device_ip_is_valid - is the hardware IP valid
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Check if the hardware IP is valid or not.
- * Returns true if it the IP is valid, false if not.
- */
-bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
-			       enum amd_ip_block_type block_type)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].status.valid;
-	}
-	return false;
-
-}
-
-/**
- * amdgpu_device_ip_get_ip_block - get a hw IP pointer
- *
- * @adev: amdgpu_device pointer
- * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Returns a pointer to the hardware IP block structure
- * if it exists for the asic, otherwise NULL.
- */
-struct amdgpu_ip_block *
-amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
-			      enum amd_ip_block_type type)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		if (adev->ip_blocks[i].version->type == type)
-			return &adev->ip_blocks[i];
-
-	return NULL;
-}
-
-/**
- * amdgpu_device_ip_block_version_cmp
- *
- * @adev: amdgpu_device pointer
- * @type: enum amd_ip_block_type
- * @major: major version
- * @minor: minor version
- *
- * return 0 if equal or greater
- * return 1 if smaller or the ip_block doesn't exist
- */
-int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
-				       enum amd_ip_block_type type,
-				       u32 major, u32 minor)
-{
-	struct amdgpu_ip_block *ip_block = amdgpu_device_ip_get_ip_block(adev, type);
-
-	if (ip_block && ((ip_block->version->major > major) ||
-			((ip_block->version->major == major) &&
-			(ip_block->version->minor >= minor))))
-		return 0;
-
-	return 1;
-}
-
-static const char *ip_block_names[] = {
-	[AMD_IP_BLOCK_TYPE_COMMON] = "common",
-	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
-	[AMD_IP_BLOCK_TYPE_IH] = "ih",
-	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
-	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
-	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
-	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
-	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
-	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
-	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
-	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
-	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
-	[AMD_IP_BLOCK_TYPE_MES] = "mes",
-	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
-	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
-	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
-	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
-	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
-};
-
-static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_block_type type)
-{
-	int idx = (int)type;
-
-	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] : "unknown";
-}
-
-/**
- * amdgpu_device_ip_block_add
- *
- * @adev: amdgpu_device pointer
- * @ip_block_version: pointer to the IP to add
- *
- * Adds the IP block driver information to the collection of IPs
- * on the asic.
- */
-int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
-			       const struct amdgpu_ip_block_version *ip_block_version)
-{
-	if (!ip_block_version)
-		return -EINVAL;
-
-	switch (ip_block_version->type) {
-	case AMD_IP_BLOCK_TYPE_VCN:
-		if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
-			return 0;
-		break;
-	case AMD_IP_BLOCK_TYPE_JPEG:
-		if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
-			return 0;
-		break;
-	default:
-		break;
-	}
-
-	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (%s)\n",
-		 adev->num_ip_blocks,
-		 ip_block_name(adev, ip_block_version->type),
-		 ip_block_version->major,
-		 ip_block_version->minor,
-		 ip_block_version->rev,
-		 ip_block_version->funcs->name);
-
-	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
-
-	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
-
-	return 0;
-}
-
 /**
  * amdgpu_device_enable_virtual_display - enable virtual display feature
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 99e1cf4fc955..b5e6d9d6937a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -94,3 +94,327 @@ void amdgpu_ip_map_init(struct amdgpu_device *adev)
 	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
 	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
 }
+
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block->version->funcs->suspend) {
+		r = ip_block->version->funcs->suspend(ip_block);
+		if (r) {
+			dev_err(ip_block->adev->dev,
+				"suspend of IP block <%s> failed %d\n",
+				ip_block->version->funcs->name, r);
+			return r;
+		}
+	}
+
+	ip_block->status.hw = false;
+	return 0;
+}
+
+int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block->version->funcs->resume) {
+		r = ip_block->version->funcs->resume(ip_block);
+		if (r) {
+			dev_err(ip_block->adev->dev,
+				"resume of IP block <%s> failed %d\n",
+				ip_block->version->funcs->name, r);
+			return r;
+		}
+	}
+
+	ip_block->status.hw = true;
+	return 0;
+}
+
+/**
+ * amdgpu_device_ip_get_ip_block - get a hw IP pointer
+ *
+ * @adev: amdgpu_device pointer
+ * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Returns a pointer to the hardware IP block structure
+ * if it exists for the asic, otherwise NULL.
+ */
+struct amdgpu_ip_block *
+amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
+			      enum amd_ip_block_type type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++)
+		if (adev->ip_blocks[i].version->type == type)
+			return &adev->ip_blocks[i];
+
+	return NULL;
+}
+
+/**
+ * amdgpu_device_ip_block_version_cmp
+ *
+ * @adev: amdgpu_device pointer
+ * @type: enum amd_ip_block_type
+ * @major: major version
+ * @minor: minor version
+ *
+ * return 0 if equal or greater
+ * return 1 if smaller or the ip_block doesn't exist
+ */
+int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
+				       enum amd_ip_block_type type, u32 major,
+				       u32 minor)
+{
+	struct amdgpu_ip_block *ip_block =
+		amdgpu_device_ip_get_ip_block(adev, type);
+
+	if (ip_block && ((ip_block->version->major > major) ||
+			 ((ip_block->version->major == major) &&
+			  (ip_block->version->minor >= minor))))
+		return 0;
+
+	return 1;
+}
+
+static const char *const ip_block_names[] = {
+	[AMD_IP_BLOCK_TYPE_COMMON] = "common",
+	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
+	[AMD_IP_BLOCK_TYPE_IH] = "ih",
+	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
+	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
+	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
+	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
+	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
+	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
+	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
+	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
+	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
+	[AMD_IP_BLOCK_TYPE_MES] = "mes",
+	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
+	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
+	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
+	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
+	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
+};
+
+static const char *ip_block_name(struct amdgpu_device *adev,
+				 enum amd_ip_block_type type)
+{
+	int idx = (int)type;
+
+	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] :
+						  "unknown";
+}
+
+/**
+ * amdgpu_device_ip_block_add
+ *
+ * @adev: amdgpu_device pointer
+ * @ip_block_version: pointer to the IP to add
+ *
+ * Adds the IP block driver information to the collection of IPs
+ * on the asic.
+ */
+int amdgpu_device_ip_block_add(
+	struct amdgpu_device *adev,
+	const struct amdgpu_ip_block_version *ip_block_version)
+{
+	if (!ip_block_version)
+		return -EINVAL;
+
+	switch (ip_block_version->type) {
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+			return 0;
+		break;
+	case AMD_IP_BLOCK_TYPE_JPEG:
+		if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
+			return 0;
+		break;
+	default:
+		break;
+	}
+
+	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (%s)\n",
+		 adev->num_ip_blocks,
+		 ip_block_name(adev, ip_block_version->type),
+		 ip_block_version->major, ip_block_version->minor,
+		 ip_block_version->rev, ip_block_version->funcs->name);
+
+	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
+
+	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
+
+	return 0;
+}
+
+/**
+ * amdgpu_device_ip_set_clockgating_state - set the CG state
+ *
+ * @dev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ * @state: clockgating state (gate or ungate)
+ *
+ * Sets the requested clockgating state for all instances of
+ * the hardware IP specified.
+ * Returns the error code from the last instance.
+ */
+int amdgpu_device_ip_set_clockgating_state(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = dev;
+	int i, r = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type != block_type)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
+			&adev->ip_blocks[i], state);
+		if (r)
+			dev_err(adev->dev,
+				"set_clockgating_state of IP block <%s> failed %d\n",
+				adev->ip_blocks[i].version->funcs->name, r);
+	}
+	return r;
+}
+
+/**
+ * amdgpu_device_ip_set_powergating_state - set the PG state
+ *
+ * @dev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ * @state: powergating state (gate or ungate)
+ *
+ * Sets the requested powergating state for all instances of
+ * the hardware IP specified.
+ * Returns the error code from the last instance.
+ */
+int amdgpu_device_ip_set_powergating_state(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = dev;
+	int i, r = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type != block_type)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
+			&adev->ip_blocks[i], state);
+		if (r)
+			dev_err(adev->dev,
+				"set_powergating_state of IP block <%s> failed %d\n",
+				adev->ip_blocks[i].version->funcs->name, r);
+	}
+	return r;
+}
+
+/**
+ * amdgpu_device_ip_get_clockgating_state - get the CG state
+ *
+ * @adev: amdgpu_device pointer
+ * @flags: clockgating feature flags
+ *
+ * Walks the list of IPs on the device and updates the clockgating
+ * flags for each IP.
+ * Updates @flags with the feature flags for each hardware IP where
+ * clockgating is enabled.
+ */
+void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
+			adev->ip_blocks[i].version->funcs->get_clockgating_state(
+				&adev->ip_blocks[i], flags);
+	}
+}
+
+/**
+ * amdgpu_device_ip_wait_for_idle - wait for idle
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Waits for the request hardware IP to be idle.
+ * Returns 0 for success or a negative error code on failure.
+ */
+int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
+				   enum amd_ip_block_type block_type)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (adev->ip_blocks[i].version->type == block_type) {
+			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
+				r = adev->ip_blocks[i]
+					    .version->funcs->wait_for_idle(
+						    &adev->ip_blocks[i]);
+				if (r)
+					return r;
+			}
+			break;
+		}
+	}
+	return 0;
+}
+
+/**
+ * amdgpu_device_ip_is_hw - is the hardware IP enabled
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Check if the hardware IP is enable or not.
+ * Returns true if it the IP is enable, false if not.
+ */
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == block_type)
+			return adev->ip_blocks[i].status.hw;
+	}
+	return false;
+}
+
+/**
+ * amdgpu_device_ip_is_valid - is the hardware IP valid
+ *
+ * @adev: amdgpu_device pointer
+ * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Check if the hardware IP is valid or not.
+ * Returns true if it the IP is valid, false if not.
+ */
+bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
+			       enum amd_ip_block_type block_type)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == block_type)
+			return adev->ip_blocks[i].status.valid;
+	}
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 2490fd322aec..77d1c642953c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -24,6 +24,131 @@
 #ifndef __AMDGPU_IP_H__
 #define __AMDGPU_IP_H__
 
+#include "amd_shared.h"
+
+struct amdgpu_device;
+
+/* Define the HW IP blocks will be used in driver , add more if necessary */
+enum amd_hw_ip_block_type {
+	GC_HWIP = 1,
+	HDP_HWIP,
+	SDMA0_HWIP,
+	SDMA1_HWIP,
+	SDMA2_HWIP,
+	SDMA3_HWIP,
+	SDMA4_HWIP,
+	SDMA5_HWIP,
+	SDMA6_HWIP,
+	SDMA7_HWIP,
+	LSDMA_HWIP,
+	MMHUB_HWIP,
+	ATHUB_HWIP,
+	NBIO_HWIP,
+	MP0_HWIP,
+	MP1_HWIP,
+	UVD_HWIP,
+	VCN_HWIP = UVD_HWIP,
+	JPEG_HWIP = VCN_HWIP,
+	VCN1_HWIP,
+	VCE_HWIP,
+	VPE_HWIP,
+	DF_HWIP,
+	DCE_HWIP,
+	OSSSYS_HWIP,
+	SMUIO_HWIP,
+	PWR_HWIP,
+	NBIF_HWIP,
+	THM_HWIP,
+	CLK_HWIP,
+	UMC_HWIP,
+	RSMU_HWIP,
+	XGMI_HWIP,
+	DCI_HWIP,
+	PCIE_HWIP,
+	ISP_HWIP,
+	ATU_HWIP,
+	AIGC_HWIP,
+	MAX_HWIP
+};
+
+#define HWIP_MAX_INSTANCE 48
+
+#define HW_ID_MAX 300
+#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
+	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
+#define IP_VERSION(mj, mn, rv) IP_VERSION_FULL(mj, mn, rv, 0, 0)
+#define IP_VERSION_MAJ(ver) ((ver) >> 24)
+#define IP_VERSION_MIN(ver) (((ver) >> 16) & 0xFF)
+#define IP_VERSION_REV(ver) (((ver) >> 8) & 0xFF)
+#define IP_VERSION_VARIANT(ver) (((ver) >> 4) & 0xF)
+#define IP_VERSION_SUBREV(ver) ((ver) & 0xF)
+#define IP_VERSION_MAJ_MIN_REV(ver) ((ver) >> 8)
+
+struct amdgpu_ip_map_info {
+	/* Map of logical to actual dev instances/mask */
+	uint32_t dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
+	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
+				      enum amd_hw_ip_block_type block,
+				      int8_t inst);
+	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
+					enum amd_hw_ip_block_type block,
+					uint32_t mask);
+};
+
+#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
+
+struct amdgpu_ip_block_status {
+	bool valid;
+	bool sw;
+	bool hw;
+	bool late_initialized;
+	bool hang;
+};
+
+struct amdgpu_ip_block_version {
+	const enum amd_ip_block_type type;
+	const u32 major;
+	const u32 minor;
+	const u32 rev;
+	const struct amd_ip_funcs *funcs;
+};
+
+struct amdgpu_ip_block {
+	struct amdgpu_ip_block_status status;
+	const struct amdgpu_ip_block_version *version;
+	struct amdgpu_device *adev;
+};
+
 void amdgpu_ip_map_init(struct amdgpu_device *adev);
 
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
+int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
+
+struct amdgpu_ip_block *
+amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
+			      enum amd_ip_block_type type);
+
+int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
+				       enum amd_ip_block_type type, u32 major,
+				       u32 minor);
+
+int amdgpu_device_ip_block_add(
+	struct amdgpu_device *adev,
+	const struct amdgpu_ip_block_version *ip_block_version);
+
+int amdgpu_device_ip_set_clockgating_state(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_clockgating_state state);
+int amdgpu_device_ip_set_powergating_state(void *dev,
+					   enum amd_ip_block_type block_type,
+					   enum amd_powergating_state state);
+void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags);
+int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
+				   enum amd_ip_block_type block_type);
+bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
+			    enum amd_ip_block_type block_type);
+bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
+			       enum amd_ip_block_type block_type);
+
 #endif /* __AMDGPU_IP_H__ */
-- 
2.49.0

