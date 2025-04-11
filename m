Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B814EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3BC10EB36;
	Fri, 11 Apr 2025 08:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qhamY7p/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EFA10EB36
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq9PzHvflNmpFQeMAsCVbnh2DreX/sHU6tXYOewND1Jf9vm4aC1rOopEVUiJqB2BL/yVjcfNp5jBvbeh4fffRR0dk6PVwuxeGFiIO/lgQygPQbPJBL0ezcfxPz+Dt+skiKaKeWTW/4T1aeAAEYfC1RNTEihKyn0/RA1rilNz7JK5SfAdc8tlaDcixthpnhd2ngMLY/YYHFflucCZY29GNh2JI7jeFf89AQvrARs0lTu+Ai0DxYVTdH1YQlQkxVVXFMD4rnxDElhR3Qs+jhMBSLpFZ+fvynugaEyOuSFupyuPysYVufAlRu+G8md6dWu9UbLcRh7FuKEJmdONaMW6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyEcIElmdPDNYG2XhVlc9x2O8b10pEPEp4EfTnoGd6c=;
 b=ZI7XtOY/mB9fFNloN4bJ/XhbLzdGJeocfRBfyVIQTRPEklXZygfz4a5FgdSldSru0gXeGcyn53MZa/3JJfL2DbOIkqch0fz9sitsDb35kOGNUV4p55skJSpCVGEnYzxi6zyxFQ5Y3KBFKajtdwfsmJuCTOvLEpbbfD0JZkyaEBNMCm8X53JJjVt7XRxfSwKpxS7+pTXi2Ym+t0EUho4R7Bo2BeeFDauS4kVoVteImx3clu2CQUOCc6UmRcWoZssA12MoRpNL8iwwbG8Negau8K4gGpk9EYr2z9IEXtQ8KIDjrNtKCAnpaTGhgDOu5VdKJlOHAs1BiC+Tf/w/z7ytCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyEcIElmdPDNYG2XhVlc9x2O8b10pEPEp4EfTnoGd6c=;
 b=qhamY7p/8sFvGPTE8txfWzofVBCspxWPKSUNS7tq52Tz2cyBTl2kjGGinIiWGrctKaRsW6WWK660j1jcu6ESsoE4Kru6O72Lq0h+uVfCxZ2i97FDrgUGRG0Z6CMRwbMIbuJYo/Kky+L7lNUkL2xn3ECKBQqbCZ/2Ju3gJiD573g=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:30:40 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::40) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 08:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 08:30:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:30:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:30:35 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:30:23 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [v5 6/6] drm/amdgpu:remove old sdma reset callback mechanism
Date: Fri, 11 Apr 2025 16:29:21 +0800
Message-ID: <20250411082921.3228498-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef7b841-b0e0-4968-0402-08dd78d32465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Zg5P40JqxaU1CgJEMF9eIinyknL4ZMMmYa7bZ5CjXcP1YwcsEIgjqA269D4?=
 =?us-ascii?Q?fXkqQpbgzt4j26VAmuTgS72LbvlPDTIAQHIqx2DSWhJaq9lSkGk4/oFkCcsO?=
 =?us-ascii?Q?K/nbNxOD3buEZp1pCp+FjZbrl9fEqtlDydeDV7H/+7SeGH7mEsAIEUUzf2WJ?=
 =?us-ascii?Q?yUJbHy9pp+sQdOH0gLaknMDMAwjzvgjAhCPyC8dGVlMKLMtaa3mJZJXca1Uh?=
 =?us-ascii?Q?n3EyXu1Vtv4odqwgQHfWDj/+p9NSUvdg6AqBCnc4HrwbQLbigUYu6JPusMVg?=
 =?us-ascii?Q?YgajO5YXEG494DigV24eojS+ZruphtNAomane87OLfGD0CIpzjNsgy/vSa4T?=
 =?us-ascii?Q?nPLNOllR0Z07RaVQepfKx17fspakxNRRQ08xVgYOO5sC97MRpSoCzeWUuvSp?=
 =?us-ascii?Q?j0A3H6+BCx+TMFRU8xMEa1al9AIR6pD8VeSc8lk/Sfu+GC4Vct4Uu1hamgv3?=
 =?us-ascii?Q?Z6MJSrWyrquLW960zZO7BCrx0C3wsJhliaXaNBUs5DxdWKHsEnuYXlKl2qdR?=
 =?us-ascii?Q?Rht9H0ciw2vb4+pY7YQU2LpjRLlfLKpUm0ylZtBAu/akaCtwxTArMdJyHE+H?=
 =?us-ascii?Q?E+J/jvVH/nDkMlung0ed4IqwFqjXaklBv6OxqTh76LW3g8HY9A5KAqxvo3P9?=
 =?us-ascii?Q?jXt/mf1L9UsccY50EhoR8VAfTkUV0gfmaz10GE3wwRhefHZU1lLO2ysqeyL0?=
 =?us-ascii?Q?5/UNWrUbaWe18A0TXTtwvQ1thTMuknYESl2TC/DSxHOz9Hz+qJD94RLX+AtM?=
 =?us-ascii?Q?TTfkV+tHQkkHgjT7rraKZygOraPu+3U+J/4xBdcHNmjz43/PBaGqiQxL7Lw7?=
 =?us-ascii?Q?ivnKU3Cs386gLViEYeDZ88R8bGbmIaQophdMWcMUQQhcru4SDdNg5nAuCGf2?=
 =?us-ascii?Q?4mnf7Ti0sAkEtwsq3xgvjBtNGteFtTm6TUah6C4ea/kZb88RyXCyizh5uKKa?=
 =?us-ascii?Q?aEfYgaopgvcBu0oMhvxK0wfvqJ8vOXEW+tgVrS4QdPabfFYU/YlSxjg1eHfM?=
 =?us-ascii?Q?LNn/MBJeZxCWhCyGE7dkXUxeY2E52k76OsCLZ76x6NooOgnVvWN1osd5v4g0?=
 =?us-ascii?Q?qyf75KHr5N8/EKQJKRdMR8f/b/eRRhxCuRA6mW945Gmg2pqSDvb1MEGMmkXe?=
 =?us-ascii?Q?dOQOkBFFvdDvRb1hitYB7er7H7TUF/4a4KNSkYCgh6IiPjybCnHNUuNi3oBe?=
 =?us-ascii?Q?0csGpcC26+DYp1UFxUCkIS1t6pswy+Jl0CjTeF9F6hazDumKMuFm856/OkMD?=
 =?us-ascii?Q?eMJD/A2vZnd5YQenrX3HT5MPy9zzwcyyip8PFBPkhrSOSaRXWhvIqRFeIDGG?=
 =?us-ascii?Q?t+G+lrtiHcCrICaLPDhrfvLr9g08gQ+4TD4raAkNdL1mrpNizl8zFwv9uR4M?=
 =?us-ascii?Q?jBcFTWxP/qw1yxccwUM1eec9Xiw16VInAF3Z55B9PpMPFetoV1fYLw74H4gh?=
 =?us-ascii?Q?Aimjy4H62CBZ6rb+6S363O45p0NaXPcXK5LE0e6xoB1ACFWoRSuMYPOtEBen?=
 =?us-ascii?Q?q/Ve1KpwEcYi6gWOrxid5ioNew/l9wPZKS+A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:30:39.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef7b841-b0e0-4968-0402-08dd78d32465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ----------
 3 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index b271a0626886..ac6d811f4824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -531,31 +531,6 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 		return false;
 }
 
-/**
- * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
- * @adev: Pointer to the AMDGPU device
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
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index a6c8f07a0da4..41cf29531652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -109,13 +109,6 @@ struct amdgpu_sdma_ras {
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
@@ -177,7 +170,6 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c663c63485f4..e343aaaea12d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
@@ -1358,7 +1357,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
-	sdma_v4_4_2_set_engine_reset_funcs(adev);
 	return 0;
 }
 
@@ -1747,14 +1745,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
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

