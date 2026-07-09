Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624ABC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 03:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F152110E67F;
	Thu,  9 Jul 2026 03:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsbKZeMf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3358D10E67F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 03:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muu5fCRA9AQ6ZPpi1hJ1h9zNQTYRmRuqzR9WpqzQqJ7+NlSYOtc85IeaHJSPV+4OTShyHc+7Bvc1VsdOVqMEMJbQ2vBY9EzW3oep3NNs5UZF57GAaFEkQKycnpuuwaTFWmL6c7FMDdnH9AzexvqCodWfHs8JoHOYcTf+8P6Hjpr0hC01d6IMCWk5Cve1hPhNe50k+zevabq8z+MJ5JgLTgQQPo6rWZNRLSz7PYvy+K2lStvMrQCXVqBWPAgHkA77U40YqPCDlv/C90Oe4A8wWSJVw5IFerJZvfd5x/bicT/+WoPtS0G36XyxOMGWkkIfeaqKRJg/35ErfHVrlG90UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zueXx82MSZc9aEnamv91TQL95ZK8CApovmt4ziP4kgs=;
 b=qqadU57akaU51pj1y3bAia5ns0lmoSpwJM9BMu9ntK2v61MqUloDkBS7VXd+OHJrYe4JHH0X30v3yof8vrZ/V5NrD+2afRn+HIfBLwqgvbn1yw9C/TpXwqS3wUwS6Nim2IsW32MXyKIhAUU/FTAzichZMvwrN6RGHfdhFcJy2gKVajW+pyWLo5zZANCPXZzGVMjOF4fqsr1Zf+GcCyZEgjtSTS3Mpw9wcmkDcEOmVnUkhZ1k69ZWkuEgsrhLIfH2L3QeVnX088pFRh03uT7zThVJj7eN0Ktgqte5iUosL+3hSkM3/nxg9MONurnzZ3LZl6+CkicqjLKFadiK4KHQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zueXx82MSZc9aEnamv91TQL95ZK8CApovmt4ziP4kgs=;
 b=rsbKZeMfFkunqYbCxwR4idxT8z20rDWHiknlzoc2sbvhH04ZytgjMwsN2HnEM0tH3Y9MFfKQlJRxqGpFSF8HVExsW86k9s37AZscyZkvSveGX0huIdlF2erI6+slpooQEGMa+n7wdVZo+w7oCfShG2Sl/Xx7IAuvJK2kpcFnhQc=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 03:19:04 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::a1) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Thu, 9
 Jul 2026 03:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 03:19:03 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 22:18:59 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>, Geoffrey McRae
 <geoffrey.mcrae@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: Fix DM IRQ teardown races
Date: Thu, 9 Jul 2026 13:18:34 +1000
Message-ID: <20260709031835.3395558-2-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
References: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: e36ad4b6-e02b-4116-b264-08dedd68d3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|11063799006|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2QjeztDmXqoDAfutEkwMZSfeHgiX9fpZoayHqkpfuUuu+04vOqTImvAC3mYlKkEkeIp1v0Uf0QNEZDNZj+kKOdWXGSoN8Iq/zeCOMeqfSmw64N4iFGbf6PtphG6yE6goXQ3GDJMnmHi60keUeHNLkL8rauUcbl/vOrMRHBO+e3rX3Uw9RYQ4gXmldfOAZxyf/mbbz4SsQKi/SP72gODDgv89NSeEKCU1j1AD801DTpa4hiGWQu4BnqHfVCBOlL/4cctm2gbfeSXr21aZfY1CSRdY44aUHVnpIfNWw4G/UUWVJFJekm7fmw1gbmoVIK8jkutivvplYJA0+MxWkmwh2OPqHd0O2wfAvaH/LV53NJ1fUup/r66OmF/9TC2ce8JDLiEPqMrgzXDILdCoqAAuQb/NYF2u7qVM36DuGCvfJg/eTDNDb6xQl6ZfQmqRw6/H0RPBf69/1iP2NXuz0l44CluntmAilERQkQAxxe3Vjkrx7b/1FH6+Nssa8ZQs8k5+R8IcpnbMuKWl4jFO9hAKoxw7B6lrM2lqTfk/RMkBG8jS5KRWjr//7pEjeLX2yIdYUSOtAzWCf8wcO65o0CySQKsgyP1xni9GV7lpFTsW9IasHIehoTmG9qpH5kD9t14W5UZMghek6jK/f+SaKl3uBR7V4hf1iay2CRfaXVeGi/oWp1RjPFm79PUMHsdGLZbPiEN1q9pVMTHkMeEZwIxFBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /AVDF/XzTAMJpohPm6JOyqwB85U9A/u395JArgPSeMspT4pOFMhigC8W06oIMn/b04bsMTaYdS0NiEFFH1A/hUOHEc29m5CHbkbxgBvOlhDC5nl/lmPNfVVsRfGkiuQGSmGRDFHzdFGO2BQLEnF2xt5Xyn7AfLAwBIYIH5wYDNLiMqL2srAkQymFlUTIaB4I+vovqxiJMJA60IT5od0MdCwc8i5UYpa/vDgcRWk5GHtKv2G0ZrICVAODYlucaldNGKq9B/s1j+UA+mTwm5ZR5eEopiuf0ehiEbYoq6v33kFOwCmtOBAMkhjMC/CAKw/0jLBC08JiINKH4TScaMvwAJcbk6jXvK4GY4iPrL35vflTzYQnv5zyqOdWd9X0AWJgJwuxyeTLPfRDbZyC0f/LaPchO7Q/v2I+UkMTmazT5+ezmjBAex8B7Y7UTnZlKX8X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:19:03.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36ad4b6-e02b-4116-b264-08dedd68d3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

DM IRQ teardown can race with interrupt handling and low-context work.
The IRQ handler can still walk the DM IRQ handler tables while the
teardown path removes and frees entries. Low-context work can also
remain queued after its handler has been removed, leading to a possible
use-after-free when the work item later runs.

Rework amdgpu_dm_irq_fini() to detach all low and high context handlers
from the IRQ tables under the table lock, then cancel pending
low-context work outside the lock before freeing the handlers. Also
cancel low-context work in remove_irq_handler() before freeing an
individual handler.

Fix the suspend path by disabling HPD and HPD RX hardware interrupts
under the IRQ table lock before flushing pending low-context work,
avoiding a TOCTOU window where new work could be queued after the list
check.

Finally, call amdgpu_dm_irq_fini() from amdgpu_dm_fini() before DC is
destroyed, so IRQ teardown happens while the display core state is still
valid.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 141 +++++++++---------
 2 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..9c5e963337cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1010,14 +1010,11 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.hpd_rx_offload_wq = NULL;
 	}
 
+	amdgpu_dm_irq_fini(adev);
+
 	/* DC Destroy TODO: Replace destroy DAL */
 	if (adev->dm.dc)
 		dc_destroy(&adev->dm.dc);
-	/*
-	 * TODO: pageflip, vlank interrupt
-	 *
-	 * amdgpu_dm_irq_fini(adev);
-	 */
 
 	if (adev->dm.cgs_device) {
 		amdgpu_cgs_destroy_device(adev->dm.cgs_device);
@@ -1523,7 +1520,6 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_hpd_fini(adev);
 
-	amdgpu_dm_irq_fini(adev);
 	amdgpu_dm_fini(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c5467f34c51f..20fdf0578119 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -195,6 +195,9 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 		return NULL;
 	}
 
+	if (int_params->int_context == INTERRUPT_LOW_IRQ_CONTEXT)
+		cancel_work_sync(&handler->work);
+
 	kfree(handler);
 
 	DRM_DEBUG_KMS(
@@ -204,55 +207,6 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 	return hnd_list;
 }
 
-/**
- * unregister_all_irq_handlers() - Cleans up handlers from the DM IRQ table
- * @adev: The base driver device containing the DM device
- *
- * Go through low and high context IRQ tables and deallocate handlers.
- */
-static void unregister_all_irq_handlers(struct amdgpu_device *adev)
-{
-	struct list_head *hnd_list_low;
-	struct list_head *hnd_list_high;
-	struct list_head *entry, *tmp;
-	struct amdgpu_dm_irq_handler_data *handler;
-	unsigned long irq_table_flags;
-	int i;
-
-	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
-
-	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++) {
-		hnd_list_low = &adev->dm.irq_handler_list_low_tab[i];
-		hnd_list_high = &adev->dm.irq_handler_list_high_tab[i];
-
-		list_for_each_safe(entry, tmp, hnd_list_low) {
-
-			handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
-					     list);
-
-			if (handler == NULL || handler->handler == NULL)
-				continue;
-
-			list_del(&handler->list);
-			kfree(handler);
-		}
-
-		list_for_each_safe(entry, tmp, hnd_list_high) {
-
-			handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
-					     list);
-
-			if (handler == NULL || handler->handler == NULL)
-				continue;
-
-			list_del(&handler->list);
-			kfree(handler);
-		}
-	}
-
-	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-}
-
 static bool
 validate_irq_registration_params(struct dc_interrupt_params *int_params,
 				 void (*ih)(void *))
@@ -459,38 +413,71 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_init);
  * amdgpu_dm_irq_fini() - Tear down DM IRQ management
  * @adev: The base driver device containing the DM device
  *
- * Flush all work within the low context IRQ table.
+ * Removes all handlers from the IRQ tables under the spinlock, cancels
+ * pending work items, and deallocates all handler data.
  */
 void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 {
 	int src;
-	struct list_head *lh;
+	LIST_HEAD(low_handlers);
+	LIST_HEAD(high_handlers);
 	struct list_head *entry, *tmp;
 	struct amdgpu_dm_irq_handler_data *handler;
 	unsigned long irq_table_flags;
 
 	DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
+
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
 		DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
-		/* The handler was removed from the table,
-		 * it means it is safe to flush all the 'work'
-		 * (because no code can schedule a new one).
+
+		/*
+		 * Move all handlers from the low and high context tables to
+		 * temporary lists under the lock. This prevents the ISR from
+		 * finding them while we process them outside the lock.
 		 */
-		lh = &adev->dm.irq_handler_list_low_tab[src];
+		list_splice_init(&adev->dm.irq_handler_list_low_tab[src],
+				 &low_handlers);
+		list_splice_init(&adev->dm.irq_handler_list_high_tab[src],
+				 &high_handlers);
+
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
-		if (!list_empty(lh)) {
-			list_for_each_safe(entry, tmp, lh) {
-				handler = list_entry(
-					entry,
-					struct amdgpu_dm_irq_handler_data,
-					list);
-				flush_work(&handler->work);
-			}
+		/*
+		 * Cancel all pending work for the low-context handlers
+		 * outside the lock. cancel_work_sync() may sleep and waits
+		 * until any running work completes, preventing UAF.
+		 */
+		list_for_each_safe(entry, tmp, &low_handlers) {
+			handler = list_entry(entry,
+					    struct amdgpu_dm_irq_handler_data,
+					    list);
+			cancel_work_sync(&handler->work);
 		}
+
+		/*
+		 * High-context handlers are executed synchronously within ISR
+		 * context (see amdgpu_dm_irq_immediate_work()) and have no
+		 * work_struct, so there is no pending work to cancel here.
+		 * They will be freed along with low_handlers after the loop.
+		 */
+	}
+
+	/* Deallocate all handlers. */
+	list_for_each_safe(entry, tmp, &low_handlers) {
+		handler = list_entry(entry,
+				     struct amdgpu_dm_irq_handler_data,
+				     list);
+		list_del(&handler->list);
+		kfree(handler);
+	}
+
+	list_for_each_safe(entry, tmp, &high_handlers) {
+		handler = list_entry(entry,
+				     struct amdgpu_dm_irq_handler_data,
+				     list);
+		list_del(&handler->list);
+		kfree(handler);
 	}
-	/* Deallocate handlers from the table. */
-	unregister_all_irq_handlers(adev);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
 
@@ -498,7 +485,6 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	int src;
-	struct list_head *hnd_list_h;
 	struct list_head *hnd_list_l;
 	unsigned long irq_table_flags;
 	struct list_head *entry, *tmp;
@@ -511,12 +497,15 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	/**
 	 * Disable HW interrupt  for HPD and HPDRX only since FLIP and VBLANK
 	 * will be disabled from manage_dm_interrupts on disable CRTC.
+	 *
+	 * Disable the HW interrupt first, then flush any pending work. Since
+	 * the HW interrupt is disabled under the lock, no new IRQ can be
+	 * generated after the disable completes. Any work already queued by an
+	 * in-flight ISR will be flushed below.
 	 */
 	for (src = DC_IRQ_SOURCE_HPD1; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
 		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
-		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
-		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
-			dc_interrupt_set(adev->dm.dc, src, false);
+		dc_interrupt_set(adev->dm.dc, src, false);
 
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
@@ -597,9 +586,12 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
 	struct  amdgpu_dm_irq_handler_data *handler_data;
 	bool    work_queued = false;
+	unsigned long irq_table_flags;
+
+	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
 	if (list_empty(handler_list))
-		return;
+		goto out_unlock;
 
 	list_for_each_entry(handler_data, handler_list, list) {
 		if (queue_work(system_highpri_wq, &handler_data->work)) {
@@ -617,7 +609,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		handler_data_add = kzalloc(sizeof(*handler_data), GFP_ATOMIC);
 		if (!handler_data_add) {
 			DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
-			return;
+			goto out_unlock;
 		}
 
 		/*copy new amdgpu_dm_irq_handler_data members from handler_data*/
@@ -639,6 +631,9 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 				  "from display for IRQ source %d\n",
 				  irq_source);
 	}
+
+out_unlock:
+	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
 
 /*
@@ -678,9 +673,9 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
+	enum dc_irq_source src;
 
-	enum dc_irq_source src =
-		dc_interrupt_to_irq_source(
+	src = dc_interrupt_to_irq_source(
 			adev->dm.dc,
 			entry->src_id,
 			entry->src_data[0]);
-- 
2.43.0

