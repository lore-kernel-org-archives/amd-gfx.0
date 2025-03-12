Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFEFC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BBB10E739;
	Wed, 12 Mar 2025 08:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vPZqCzpk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2682E10E738
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N68+LcdtOoTdVgmKw2HqZCdOupgS4U3ohIDmhBd3hiNs+XB10BzQLZi3NdC89y33ms/S1twwj6isK7cJ58r9L/TizE3xGFAGIMSxA+pDwz1cYwWMUE9QUf5dSs9hxc+EMqXRWcp8DkLyn8ONqy6X5LMvpsVWegexeZtaFAg/L2BAYM2/fSHsAKqkAuSFrnsEZZbNqIw+B3A5Rn/kbqChlbZgjUH1WTe1YUBPvIWQlf8m4efB17B4+nGUbgNsg0B839rSoLdEA2qYJPH5kIpAOgRNzpG7SxZCzfJDFoKQPSYx/doQ2axBCRM9oshspN+E5vM7zdza/bJnf8Xzs9L1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+qm3PyvHNZzl6cyyu5scPYbqpQV9Cpftt8ygu8CXHM=;
 b=VSgNtsZaCbIA2IeVLRSbahgXwn1cdTqS3TftDaDoKENAIS+L1PODnpOgDG/bQ4nCR4Y7G4QdmkYb/RvRWIttTRvUEzVVOL84gOtM/iXHOKLLcJhti97jaWahXzJo8sdLh3tHhqRx4lI8u6Z8B+efwIIxhq4huMn+2CtAt006qupxXxq+7NZfFHUqpeo80LrA9xO8vo53B7daRM2pLuZD9Gm3XLU1nLKfGCATak2jzxdVqSI742jErPbZ8I9xBAcmtEyLYZ/qt90178h4x3shvpH3W6RWu01hVJnQl3uV1qesgVviMIJ34DCe5OGxprHs7RXXsqPSBS7IDnsf2jO8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+qm3PyvHNZzl6cyyu5scPYbqpQV9Cpftt8ygu8CXHM=;
 b=vPZqCzpkHf54E0p/hrvBD7h48QjCWttap+221Ib6lFBzvOZIVuXDC39euhD2gxc4pCvWXhb86WCckVJs6jm2zPeOlUinyAm9H83jeRIxJFVWqu8Fd6naNsZwRw3VJBkoJH8VgL4Cx/3qHjU8GZFikC7jTZzWW0BbrdQUW9JzCYg=
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:01:06 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::e) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Wed,
 12 Mar 2025 08:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:01:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:01:04 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:57 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/7] drm/amd/amdgpu: Remove deprecated SDMA reset callback
 mechanism
Date: Wed, 12 Mar 2025 16:00:03 +0800
Message-ID: <20250312080003.3224976-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a9249-6d3b-4ce3-23bc-08dd613c0a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxH198ahEtsNCKcTAUfLFggLQFl7YiArYYqBNMe6z06Ft9N+w10FxeEUXTkq?=
 =?us-ascii?Q?3vY84Qb4u+O4ayKzRECRVAt8nAy7Sz+TfLGqc5MZqdthJK/lcEdKRGT5TlUK?=
 =?us-ascii?Q?oep8WSS5lK+N+febsZV7l9vOHsh9GXCTlkeKflIukv2WEKSJlhlUEvtQ2lQn?=
 =?us-ascii?Q?PK++SoKgVWsBEl4L5tErBg5ff5cRv4GrX7ezxn20kQlTZp+lrnUdBVUrfHg6?=
 =?us-ascii?Q?ZOZ2FVsJduPFSllXAf6n+Q1AHvSUKD89f0DgVvRS9wKlKpjF08UY6P21U8Xj?=
 =?us-ascii?Q?LgzRjTaG5YC2q6itTWivCXjb7Y23lhvQx+0Ca+3aRq+Icf8sz8JICWyaqNe5?=
 =?us-ascii?Q?cModTaHtKglE6H12iWrv7cOcGZM2wkNq8+AUthGcGtdPbaU4rz8CrCY7YKKO?=
 =?us-ascii?Q?Gcxwd5xDoPNEiSXsVtpyKAE9xEgE9EHoHAUZc1r/o4Lpd2InQU4FCftEwQYt?=
 =?us-ascii?Q?FkhcTCGeHwruxri3zbBEUpckfsdyVaTHc2oDlW8ZIDIcMlwph8hjeBiqlyGi?=
 =?us-ascii?Q?Po7n5Vxd8cB2f0jtvjHFsfpU8lXNJFxtRg5WstGVmJeBCg/el9nRGSt0DwSP?=
 =?us-ascii?Q?qtHNixOCh2HjHAtTNPRnV5le3Dc1Oos2BECdPrhFHZa07wa/lIlFbLHdyg1O?=
 =?us-ascii?Q?Z+GBkslZzmyxLrmB8NixI1Coa5F4fTszGmYQ7YA1chU+MLSivLNpNN7gA+TO?=
 =?us-ascii?Q?Cm7trudyCiR5nFZ3u3DaNzdYculwDWsBL7fBQez/AxTghHzdI6Ph5ar1RUbO?=
 =?us-ascii?Q?iw9rDgmQiTK3TPV9ZD+n+y4TvIp061RYZqGrh3asn7laPehEVMLindoHnGbV?=
 =?us-ascii?Q?85tN/M7vIKRtiDIv1NzDMl73YuXKOr5cCkph8sgkyC7GCtd5uZsROppnNvm/?=
 =?us-ascii?Q?O6elrRr6PuPz7R56P/LqidT9zBcX2z9G4rMvEq2MWcMVCaIUCoT+YdmgjwQ2?=
 =?us-ascii?Q?QmjxmkMddUU+1GOWiNAzNHd+R996cYSKx2pW4wrePqmNUlHno/OyHz8i6ZrQ?=
 =?us-ascii?Q?Sos5bOpVFMyNINMUrDMQskWkS6EkZsKRO8BYX3dhnOq5+oFiqcLBUX5ys8M7?=
 =?us-ascii?Q?CsudZMbPQQYbkbFHh36pA8Tf8ODwyHxabBn7F37H7eb9A6V6xI95PK2O0/H+?=
 =?us-ascii?Q?zih0bzZrTiqG0UOEEVEpbY9PuevuHtuZZZ28vTxExVO1pdR+8ZwlPT2PayRj?=
 =?us-ascii?Q?N5mWrfGRbjdhM80VMNByJor1XLEm7rA0Pn9sRB9qpH4muOmDIeZ+huKzPSLP?=
 =?us-ascii?Q?s90svaCKhTP4RQil6gDTUv6/6I8oAc9bp2wvk9P+47xzth2GVP2zj2q2CqZa?=
 =?us-ascii?Q?EmVSipUNI5M/8Gu9O3WFI7I0YDKqX9EJrefSdL7EBePznJFykokZWAUhc6LK?=
 =?us-ascii?Q?3Z/u9cVKA4lhNAB/5Pr+QcS8jDhkR2YwLVpcxiJBlJc19KBzCVXNzONbkRSs?=
 =?us-ascii?Q?r4yes89wYw+1S6ik61jHVZ0nnkK/NM+gDA7K/QlVdNAV+d7GeLFmhsegvJl1?=
 =?us-ascii?Q?jvsSTaKBfZmBTr0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:01:05.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a9249-6d3b-4ce3-23bc-08dd613c0a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 12 ------------
 3 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index c01154313a92..e88fa0f84bb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -506,30 +506,6 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
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
index 965169320065..1b6d304c6074 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -98,13 +98,6 @@ struct amdgpu_sdma_ras {
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
@@ -168,7 +161,6 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c1f7ccff9c4e..cb3148324e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
@@ -1353,7 +1352,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
-	sdma_v4_4_2_set_engine_reset_funcs(adev);
 
 	return 0;
 }
@@ -1728,16 +1726,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
-static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-	.pre_reset = sdma_v4_4_2_stop_queue,
-	.post_reset = sdma_v4_4_2_restore_queue,
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

