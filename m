Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2932BE69E9B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7351A10E874;
	Mon,  2 Dec 2024 21:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v30dbS37";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4220710E874
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgTSmenYJ669nBq270UWoCR+27ZT723kVckjVuqmCi7xSmAWByvzsVJFXbpSXHdKv4o3A1LV16qVIxfaYOUDdYrluzf10crO/J2hUUxTbqJByAcksmNFJl2Wlzf8HAodop2ogwUCZocDmU+p3wWDEXoqhCHCH2G5i1rhhJqnUAKsAVgEUDcwBx73SPrAAYiAXgyPmJPHzJEif06esGZsAOUCS3JXZCc2fikQMC9s0i5vlTvCgbBeLcGlpZ942ZNGD3qfKkCUH5bzTIqGfmlp1TrK6PbwcN8aHw5ofobU3gLjAccsxVhi/OMsxKcF+xsw+494ogIy9oJrcK75nmhKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tqLWtiYhzhFCZarvsZk4jBaasM9Agu4OgmzeIZQvY4=;
 b=HVatadll57gV62Uyw/4+RGq+i9z9fJg9wdGV7GF//GWdGkRJYvinYklccBpl+ASXR0IlIUrqaBoxMM0vHUKy2O6Nd7yu9X6zVAgni9fT55iNroM+5mQNjtFl79Pzquh+lPPrPVRZw2ssdkBh1Xbwi+ZtvlBmtoLU/v8N6KOv9GrSgWBDRHc7+M1F4bj9vmtmtNHqwqI0R5cjduC86fFYvCxZ3ktL/SL2EPvA53cuit0k4p/KLQ7qrgzsn0YXHAC3UvsNX4hFMQ0r52gekzH1ZtAgVyUoNp5s+jqSpU37LpoF+YMwGWeCAXN9gFvYn8z+oZLOb0lFKgUO5k6akfa/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tqLWtiYhzhFCZarvsZk4jBaasM9Agu4OgmzeIZQvY4=;
 b=v30dbS37JzcZ7IMBR/NLgRg9Q0rU6aUwM3MoSH2tJrpXIgmKTn84YIyPJzVnFRU10osJChXBSlyLVAS21fLM26MRjZZTvPtV4bXjN96tatwmE7X3SCZFxc70MepDrvOoFzRj3U2Zq4eFPrxz5Yj0uXN8kCYDfCoLI5nfxNilsXA=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 21:50:21 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::84) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdkfd: add gc 9.5.0 support on kfd
Date: Mon, 2 Dec 2024 16:49:48 -0500
Message-ID: <20241202214952.1125211-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc0d55c-447e-4bb3-cb87-08dd131b517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3LvJ8aXmTtvXpZr8y0XHmPKZEXRUCgADwg3ny0QLtVKqHDape/dyEHf5nxcj?=
 =?us-ascii?Q?9K43fJvAiD5dBKGKpepR30gMiXFq7gPtdWqG9CcAyv1mXhh5jeQG3eUfOIht?=
 =?us-ascii?Q?LvnlXgjX9wVSyFbe8oqT7f1P147ukJziteiFAs+6rwuJdX8hg7T3E/E7/Vs1?=
 =?us-ascii?Q?IPLuGT4auRO8g4tPbwN6JP5k+8CmlrH2fsNtczBz+yoIrFsgLLouxjtcQG0Y?=
 =?us-ascii?Q?Fad6Fw/MDFSDF0JCdQusQLmoxXjG8SXPpCTlyPccz2unr0sKrMuJoY15o3Q6?=
 =?us-ascii?Q?V++IOTmetHt5YRlCax6TOdhbxYuLatAX9dMHcHHub6hwLnmARv9pnNRuZtvS?=
 =?us-ascii?Q?9em1eGluvGXnSopo8VUKp1ieF+YVPTrlixRu0Um12J8M1qBhFVrQEpoCbkaX?=
 =?us-ascii?Q?VqSQx7gyMv+OPrFkedgnui6WimWedcDxvQrjn8Pi8yc1laqG1AyVbSRGPYrl?=
 =?us-ascii?Q?UhCU5PguA/9qkCQG608H72gLoZOndzRSIJlx3bQOQLPhXWtd7gyniEZo8m6U?=
 =?us-ascii?Q?cGMC6eC1AHYkDOEhTLheiJpHc4ko/F3i35sFjIZGTJX9kDm8LesvKpPgumrC?=
 =?us-ascii?Q?0gbF8oIophtrI+lbK3r3Lw92lc3gCJzwDdmkOQ/cHEu+j4g2hYu0ywcny3Ez?=
 =?us-ascii?Q?8AD7klG/4My8lL2/SXBr+Hl/DQFhk0KzaGuJKvgAc2mmIsyCGf1fczrPyYji?=
 =?us-ascii?Q?jp/w44dmzsebJhvrU2Ux3zEMa9D325/NKQoH0D0A07AN/vj/l1Xj6oCEpoks?=
 =?us-ascii?Q?nJphqOc7lPBVRMhWVGz90tuo5rFZb6oDL8jY+BbSm03Xj/yUrHh4b4aVo0tJ?=
 =?us-ascii?Q?fNUTBF7I8Le3YIKYDJo1Oz8vPUWSDRKxQHSDIL1m4Qo3qMfI09v1HWRaj+dz?=
 =?us-ascii?Q?aZC2SJ4bLPzKgethjb24LLPuANAwxLj8344xxsCatbIJmMEU8Hn5bUj5qHNe?=
 =?us-ascii?Q?0sIg9SyWBSemn5uaztRF0KvXwmxdV3x65BhHItGZRgsLKBMB9x1xSsL9vhoL?=
 =?us-ascii?Q?MGvTiWBF4Z+N359OFYvchNJR4yireCKmHOxm+AKYn8Dlcby5JhbIaZS54a8g?=
 =?us-ascii?Q?4jwguBk14zGa7Mpu+AEx+kO8S/FSegkzyWUfKol9r+n5s47e6AgfZJ7e230D?=
 =?us-ascii?Q?lRn0jRqEsNVYw1B4+Qa1+HReMsEQ0NzJJQRlux48eV0w7DqkvQm831edoyyX?=
 =?us-ascii?Q?4s5mcvPalxHyMVuStElTeeGn5fwKwvpEI0Q3x8C9DEoFXntRxlE814LLWAfS?=
 =?us-ascii?Q?Q3mfPtQZF8wcJUDteiMjRlDlHokOnmn1zwTdmDUIYTqsJ5ouIkpMmCAOl6A3?=
 =?us-ascii?Q?2jk8nS7445Mlhf1IdUjAXGfb8U3hqv6On9oJCOmbB3ShXBcbH4t1O+CPiPMN?=
 =?us-ascii?Q?peMtnv9wekseO6lJ0V23iyGr1Fk9zTo/oKraGwcRTwACRenXpJJyHo/gPJ4j?=
 =?us-ascii?Q?Hx6Ng14geoupHAmqwrYIgzxxbn23u4j3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:20.7431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc0d55c-447e-4bb3-cb87-08dd131b517a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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

From: Alex Sierra <alex.sierra@amd.com>

Initial support for GC 9.5.0.

v2: squash in pqm_clean_queue_resource() fix from Lijo

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 +++++++++++--------
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 13 ++++--
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  6 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 ++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 13 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  3 +-
 10 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 7b826a136ceb9..b666598ccd0e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1628,6 +1628,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 			break;
 		case IP_VERSION(9, 4, 3):
 		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 5, 0):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config_v2(kdev->kfd,
 									*pcache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 924d0fd85dfb8..27aa1a5b120ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -79,6 +79,7 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
 		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
 		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+		KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0) ||
 		KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9b51dd75fefc7..b58f798bf2d56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -85,6 +85,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(4, 4, 0):/* ALDEBARAN */
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 5):
+	case IP_VERSION(4, 4, 4):
 	case IP_VERSION(5, 0, 0):/* NAVI10 */
 	case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
 	case IP_VERSION(5, 0, 2):/* NAVI14 */
@@ -152,6 +153,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		break;
 	case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
 	case IP_VERSION(9, 4, 4): /* GC 9.4.4 */
+	case IP_VERSION(9, 5, 0): /* GC 9.5.0 */
 		kfd->device_info.event_interrupt_class =
 						&event_interrupt_class_v9_4_3;
 		break;
@@ -356,6 +358,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 90402;
 			f2g = &gc_9_4_3_kfd2kgd;
 			break;
+		case IP_VERSION(9, 5, 0):
+			gfx_target_version = 90500;
+			f2g = &gc_9_4_3_kfd2kgd;
+			break;
 		/* Navi10 */
 		case IP_VERSION(10, 1, 10):
 			gfx_target_version = 100100;
@@ -515,6 +521,10 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 5, 0)) {
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex)
 					     > KFD_CWSR_TMA_OFFSET);
@@ -567,6 +577,7 @@ static int kfd_gws_init(struct kfd_node *node)
 			&& kfd->mec2_fw_version >= 0x28) ||
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3) ||
 		 KFD_GC_VERSION(node) == IP_VERSION(9, 4, 4)) ||
+		(KFD_GC_VERSION(node) == IP_VERSION(9, 5, 0)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
 			&& kfd->mec2_fw_version >= 0x6b) ||
@@ -733,14 +744,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	last_vmid_kfd = fls(gpu_resources->compute_vmid_bitmap)-1;
 	vmid_num_kfd = last_vmid_kfd - first_vmid_kfd + 1;
 
-	/* For GFX9.4.3, we need special handling for VMIDs depending on
-	 * partition mode.
+	/* For multi-partition capable GPUs, we need special handling for VMIDs
+	 * depending on partition mode.
 	 * In CPX mode, the VMID range needs to be shared between XCDs.
 	 * Additionally, there are 13 VMIDs (3-15) available for KFD. To
 	 * divide them equally, we change starting VMID to 4 and not use
 	 * VMID 3.
-	 * If the VMID range changes for GFX9.4.3, then this code MUST be
-	 * revisited.
+	 * If the VMID range changes for multi-partition capable GPUs, then
+	 * this code MUST be revisited.
 	 */
 	if (kfd->adev->xcp_mgr) {
 		partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr,
@@ -805,14 +816,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
 
 	/*
-	 * For GFX9.4.3, the KFD abstracts all partitions within a socket as
-	 * xGMI connected in the topology so assign a unique hive id per
-	 * device based on the pci device location if device is in PCIe mode.
+	 * For multi-partition capable GPUs, the KFD abstracts all partitions
+	 * within a socket as xGMI connected in the topology so assign a unique
+	 * hive id per device based on the pci device location if device is in
+	 * PCIe mode.
 	 */
-	if (!kfd->hive_id &&
-	    (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
-	     KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4)) &&
-	    kfd->num_nodes > 1)
+	if (!kfd->hive_id && kfd->num_nodes > 1)
 		kfd->hive_id = pci_dev_id(kfd->adev->pdev);
 
 	kfd->noretry = kfd->adev->gmc.noretry;
@@ -850,12 +859,11 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 				KFD_XCP_MEMORY_SIZE(node->adev, node->node_id) >> 20);
 		}
 
-		if ((KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
-		     KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4)) &&
-		    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+		if (partition_mode == AMDGPU_CPX_PARTITION_MODE &&
 		    kfd->num_nodes != 1) {
-			/* For GFX9.4.3 and CPX mode, first XCD gets VMID range
-			 * 4-9 and second XCD gets VMID range 10-15.
+			/* For multi-partition capable GPUs and CPX mode, first
+			 * XCD gets VMID range 4-9 and second XCD gets VMID
+			 * range 10-15.
 			 */
 
 			node->vm_info.first_vmid_kfd = (i%2 == 0) ?
@@ -879,8 +887,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		amdgpu_amdkfd_get_local_mem_info(kfd->adev,
 					&node->local_mem_info, node->xcp);
 
-		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 4))
+		if (kfd->adev->xcp_mgr)
 			kfd_setup_interrupt_bitmap(node, i);
 
 		/* Initialize the KFD node */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 210bcc048f4c5..67137e674f1d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -64,7 +64,8 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 		if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
+		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
 			qpd->sh_mem_config |=
 				(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 84e8ea3a8a0c9..ff417d5361c42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -78,7 +78,8 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 	m->compute_static_thread_mgmt_se2 = se_mask[2];
 	m->compute_static_thread_mgmt_se3 = se_mask[3];
 	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
-	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4)) {
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4) &&
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 5, 0)) {
 		m->compute_static_thread_mgmt_se4 = se_mask[4];
 		m->compute_static_thread_mgmt_se5 = se_mask[5];
 		m->compute_static_thread_mgmt_se6 = se_mask[6];
@@ -301,7 +302,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		m->cp_hqd_ctx_save_control = 0;
 
 	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
-	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4))
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4) &&
+	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 5, 0))
 		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
@@ -885,7 +887,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
 		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) {
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)) {
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
@@ -909,8 +912,10 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		mqd->check_preemption_failed = check_preemption_failed;
 		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) {
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)) {
 			mqd->init_mqd = init_mqd_hiq_v9_4_3;
 			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
 			mqd->destroy_mqd = destroy_hiq_mqd_v9_4_3;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index cac706dd66ed8..4984b41cd3721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -260,7 +260,8 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	default:
 		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2) ||
 		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 4))
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 5, 0))
 			pm->pmf = &kfd_aldebaran_pm_funcs;
 		else if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 0, 1))
 			pm->pmf = &kfd_v9_pm_funcs;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9e5ca0b93b2a2..800e4ae5b5735 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -207,7 +207,8 @@ enum cache_policy {
 #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
 	((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) ||	\
 	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) ||	\
-	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)))
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4)) ||	\
+	 (KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0)))
 
 struct kfd_node;
 
@@ -1150,7 +1151,8 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	uint32_t i;
 
 	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4))
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4) &&
+	    KFD_GC_VERSION(dev) != IP_VERSION(9, 5, 0))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee99..785d68b76f694 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2146,10 +2146,11 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 	irq_drain_fence[3] = pdd->process->pasid;
 
 	/*
-	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
+	 * For GFX 9.4.3/9.5.0, send the NodeId also in IH cookie DW[3]
 	 */
 	if (KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 3) ||
-	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 4)) {
+	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 4) ||
+	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 5, 0)) {
 		node_id = ffs(pdd->dev->interrupt_bitmap) - 1;
 		irq_drain_fence[3] |= node_id << 16;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a10005..1c3c0a686df29 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -131,8 +131,9 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
-	    KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4) &&
+	if ((KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) &&
+	     KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 4) &&
+	     KFD_GC_VERSION(dev) != IP_VERSION(9, 5, 0)) &&
 	    !dev->kfd->shared_resources.enable_mes) {
 		if (gws)
 			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
@@ -197,6 +198,7 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	if (pqn->q->gws) {
 		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
 		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 4) &&
+		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 5, 0) &&
 		    !dev->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_remove_gws_from_process(
 				pqm->process->kgd_process_info, pqn->q->gws);
@@ -316,11 +318,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	unsigned int max_queues = 127; /* HWS limit */
 
 	/*
-	 * On GFX 9.4.3, increase the number of queues that
-	 * can be created to 255. No HWS limit on GFX 9.4.3.
+	 * On GFX 9.4.3/9.5.0, increase the number of queues that
+	 * can be created to 255. No HWS limit on GFX 9.4.3/9.5.0.
 	 */
 	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
-	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4))
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+	    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0))
 		max_queues = 255;
 
 	q = NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9476e30d6baa1..52c6c5e9d264e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1714,7 +1714,8 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
 
 		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3) ||
-		    KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 4))
+		    KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(knode) == IP_VERSION(9, 5, 0))
 			mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 		else
 			mode = UNKNOWN_MEMORY_PARTITION_MODE;
-- 
2.47.0

