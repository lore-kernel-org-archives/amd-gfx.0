Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BA5C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31FD10E724;
	Wed,  2 Apr 2025 09:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qdq7xoC3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDB710E724
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnEfGI5JpSRfpgGocvW2RIFiPomabc2SLF5NUfWDMN0XX1vMspkwNjw6Z+I8Buclx4z+nt2dFH9gRupLWBeheNOetAfFJRxgd1yogVWnhDKn0O/kRviLY8Gx4qUcZDoZo8Gqz79ebcEP74xyJTlxBFoLoVogmEyHfucGkPT4aPBm92P9cZjEk0pXjA8QbqW/Apdroh+MXGpSI3ArG/meNeC2isCxQRXNh8MjQ+Skg5MbvkO+rtnwcZhwLCAQNy7NKHSbA+6dc4Vqnx+cTUojK7gk2eVWgqopwGf7sETu3dR/n2DY40+qPDlvtVk3/rqD9s2qHVyJ2bUYYjilRPNv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il+gghEVyPiixXYKHc3iiQMIbWfYGZFv4tQDqJbDpk0=;
 b=Tn6WPHMnSem+obtCLhvRpzIhOGWVWJofuD/kjdjuqd9ndjQoFplijBGUeeb0f2wPm15dHzWe4d+tj4C+uszTTMi6g/ETmKVhd9Wq9auL2rRbkSqbmNdiAK27EUZrp4zEaLnrW3pogvKHbdjJXMxPn4xx61zhfV+WW3kPff7R+QE6Qsepwt2a/coPYxkJ5bHLELCYhqt1Me40JENscQmw5CPXsyEsyiZpTWi0pelSP/hW69lnIhySi2Qa9aQKhOvVVtxx+8HDZR+rbRiT8Tls1BNp/zDPRbnGjvTnHzHHNb+AXsIuU27Q6NxHaCcnAdhyTYkhjeKRsiGOdAcO0tERdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il+gghEVyPiixXYKHc3iiQMIbWfYGZFv4tQDqJbDpk0=;
 b=Qdq7xoC3tLs33gRHGtEFKFCwqDNMV6h51fjc5AmDg9KzeWNs8AeCT7w/SZukPRH9r/st3YFVxzks8Gmzz8uMsDCBg9olAZ4aYCQUcYaJxSoS41HG1veCOHQsEW1RYTPar38NSeySTgoCktOlT2ufDtFQD6/r5D28H7/ZrcjXlOY=
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:15:03 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::a7) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:15:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:15:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:54 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v3 7/7] drm/amd/amdgpu: Remove deprecated SDMA reset callback
 mechanism
Date: Wed, 2 Apr 2025 17:14:06 +0800
Message-ID: <20250402091406.1641643-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: c337860e-4f73-4fed-f3e6-08dd71c6d9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QOV3niqWRKsOFkbDy0RysCyJWw+PC3uyrR9qq30RaQwRJlsowky2SZoAMfvb?=
 =?us-ascii?Q?hF0YgQ5f/Un/CRsmvfuhAhwqhPBmAcrz6HA9xEwPRLJult6mZ91nYd751yl9?=
 =?us-ascii?Q?dgTI7atsBZjck6hBE7WmZSNufKCIsUODLjeNXAhc5Q+DuuX3kQXpGQMYJgH/?=
 =?us-ascii?Q?U2EjAK97OE+dT2UZMHUVCyE57Jef0vZQxKIz3PUNqbZ9evVp4bQosqX+C5Ma?=
 =?us-ascii?Q?ZooHxK5i87qilsjDarNLkMVl1TMdOavB6BfpjwCkaCwNOFMPnyvvOhe/s1Ms?=
 =?us-ascii?Q?xjVN8ZJaeMjJcXy6R0iRpyma9hi7aWtCy134TZ95xTJRQj6yEoRXlwK/TEs6?=
 =?us-ascii?Q?XqQpeWeE9rwazJ+aAtErxDOy9oixU8bOd8CKJTsRiMOBTQIaFcGMwS6lECiA?=
 =?us-ascii?Q?yzWW05UwJGJgkmyoS872M5mfVnMHSTkVtjw71on13PoXxO/t4tMzjLA6AQ0T?=
 =?us-ascii?Q?QwksBx1BnAOKGOUvwjDy2Cr2Vh4XlZI7qXWpGiDpsjCFD//pSwk+u9IG+GnN?=
 =?us-ascii?Q?cqZWbYqdLrmsoY0D6pDl2/EXUTRdgzF/T14cBEuC4RZvlzeyuikV47Wfk35R?=
 =?us-ascii?Q?guevhi95g+z3z8KSczbliSXszg/4MqFLQ0DKceoU0ZS+/MU4kWqmb+wW33Br?=
 =?us-ascii?Q?Bp12VO+FwvYkUEQm7f17kEVUUpJzA6en6tsJtN4tTV2D0Q/cgErzxwVTc7U9?=
 =?us-ascii?Q?1ixKY0pAwbkkaNGQh6z7JRtdRsoZGGdggbMRCEoqP1EWgaJ351tBAaAaV46O?=
 =?us-ascii?Q?6sxBAXWrx+P8KxDRfqk1KHTTpL0fgL5R9mw5BQHrIBLv0eDcR4pnMfs0R3BL?=
 =?us-ascii?Q?4ps9TsafWGQqCcDKLOlZfWulBNDCq6xVvRzb3xZwSP9qdOTHF9SY/4Nx7TgK?=
 =?us-ascii?Q?pGkBTxcolSTyxpoTO2zG4FR7qUWmz0fNsnzFFWNd4rImlTmcJRVMoia+u9Wp?=
 =?us-ascii?Q?JSn5Yv3wBCRVU0cMbdXrF0vZGAA3YGNgxefvT+97azG85i0WcBhVFs+NYRPs?=
 =?us-ascii?Q?UqLAI5mDyFWCw5BzfaNWWU7NtfqUi48bZZuQ2DHfCFF2nOQS8IwCicGgjChb?=
 =?us-ascii?Q?9o9S1B6hY9bJEd8X2kOCbcn8g4gDgguDCVX1zEO4QdxbHDRaWhE3u9eeR04E?=
 =?us-ascii?Q?GyfS/+kCAUn1XDbQugHQHZdgFu8DlZAgWOjWdQmJp2gjwz9zHnNf2+5wAGN7?=
 =?us-ascii?Q?SybA70TygS5Q/Kokp/byVDWUIfXzyxL/c9harMJ2s1jEX9FeOxbKbxeb7hr3?=
 =?us-ascii?Q?o3dsLlR4TDLpr6Q3jUYe6jOq5a7Zwqlyj7HZ2NspdRplGvL+y674Ff8mZw9V?=
 =?us-ascii?Q?G2F4b4+4bIht4OmAFhGzZhVEx0wIMD9nqVGr3z2xezI5b6P4vRaAWhyPB/NZ?=
 =?us-ascii?Q?f2xvS7p0SaOXwn6xwz5y5hqn6K4jmML6aKnru6AuHCeza8H6I3kgiJopuBCp?=
 =?us-ascii?Q?n7W0AssG/fYgPOHLp8ac4X8UZ3FGv7Of4hSK8FsACp4i6zGIkurd7bFf2fHm?=
 =?us-ascii?Q?kEXBsYdvSNRn/JA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:15:02.5156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c337860e-4f73-4fed-f3e6-08dd71c6d9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch removes the deprecated SDMA reset callback mechanism, which was previously used to register pre-reset and post-reset callbacks for SDMA engine resets.
 The callback mechanism has been replaced with a more direct and efficient approach using `stop_queue` and `start_queue` functions in the ring's function table.

The SDMA reset callback mechanism allowed KFD and AMDGPU to register pre-reset and post-reset functions for handling SDMA engine resets.
However, this approach added unnecessary complexity and was no longer needed after the introduction of the `stop_queue` and `start_queue` functions in the ring's function table.

1. **Remove Callback Mechanism**:
   - Removed the `amdgpu_sdma_register_on_reset_callbacks` function and its associated data structures (`sdma_on_reset_funcs`).
   - Removed the callback registration logic from the SDMA v4.4.2 initialization code.

2. **Clean Up Related Code**:
   - Removed the `sdma_v4_4_2_set_engine_reset_funcs` function, which was used to register the callbacks.
   - Removed the `sdma_v4_4_2_engine_reset_funcs` structure, which contained the pre-reset and post-reset callback functions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 24 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ----------
 3 files changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 26d7c0aca9a8..e8c7aadf9923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -531,30 +531,6 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 		return false;
 }
 
-/**
- * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
- * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
- *
- * This function allows KFD and AMDGPU to register their own callbacks for handling
- * pre-reset and post-reset operations for engine reset. These are needed because engine
- * reset will stop all queues on that engine.
- */
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs)
-{
-	if (!funcs)
-		return;
-
-	/* Ensure the reset_callback_list is initialized */
-	if (!adev->sdma.reset_callback_list.next) {
-		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
-	}
-	/* Initialize the list node in the callback structure */
-	INIT_LIST_HEAD(&funcs->list);
-
-	/* Add the callback structure to the global list */
-	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
-}
-
 static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 {
 	u32 soft_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 47d56fd0589f..419531cc8207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -103,13 +103,6 @@ struct amdgpu_sdma_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
 
-struct sdma_on_reset_funcs {
-	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
-	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
-	/* Linked list node to store this structure in a list; */
-	struct list_head list;
-};
-
 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
 	struct amdgpu_irq_src	trap_irq;
@@ -170,7 +163,6 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a8330504692d..059b03d2aeef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
@@ -1351,7 +1350,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
-	sdma_v4_4_2_set_engine_reset_funcs(adev);
 
 	return 0;
 }
@@ -1740,14 +1738,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
-static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-};
-
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
-{
-	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_engine_reset_funcs);
-}
-
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

