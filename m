Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D779C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 16:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D678810E9A8;
	Mon, 29 Jun 2026 16:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zNNRm8Hr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED0510E9A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 16:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smjxyTFPz6SzuI6sKdwphnU6uJ0DjIbAUASdzem2vT1fGmp/dfb8q4EUAw0S+DRv/csJNScQ7dltWdiFHQfraLjYYZ0SxtDlbtpzcxyH8ITq/BRrcHKAdZu/Swn+2h3iE1ogTcurouEcIfAsIqIhZDVrphLqJkxMF9KR/za1CYfBmRoxggS1GuAY8fJLwyRBy0xXMjeCOYsB3AxG/86M4aybsv7Cf+U9BHQl8uW2z3/xaKDPNHZjqPa7jbEbZ+fN2x/wKpVwkKFfYdP4sY/NQ01qpaVEC0xPRjDhsOoIGQtd7CGsgGQOFwmnTMIf4YqGw1T07xF3nQmXeMVk3aLKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5x+X49SbUohjPNhEZ1n4EtZXWTEFsh8cIHnq7Z0u74=;
 b=EILVg7gbh5U1yDMFuHvEju2zu3oBfBALv/fQKrhiy9Ixwk86CkNqGW2bnRXOyiX2bEmbbahBVUufyLEhnBiqphh4mMYSwBJOpb3RqHx5a101qnel2vc/lkIuurBRRKMI7upryWqAjDaU6ZRdI2Q3la22IVcPT9snGg0ASIRqaXFJfqqqaFvLUERXNeB/CllUfQVS3Hpe3GZ+qjOKMfkOF2wg8J+TJed3AWYAbHS9rNJseAHjEIIfwQ6ipYghoJnh/i5nbuETlJOH6gI1ZgtcYD6mOxjESClYuMosxbYekeSBc8amkml/mbF15TKAZ2eIB035ugldRiE6mIGbV87fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5x+X49SbUohjPNhEZ1n4EtZXWTEFsh8cIHnq7Z0u74=;
 b=zNNRm8HrD1yucJQlJ55NEyn0BkZA9y8xkoIWJSucZRO9jj7SiWlavDIif9/AgenWbUp6XxP3a+2UYAthmZq7Ron9Ebf+Ca3yv2zNDh+vn6mdkW6b+Wbbh2iYzBsH1TTuSCPHRx+I6KM1/CkfbAdNwpNN1nlsSlBG7jCgys9dWOY=
Received: from SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:51:43 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::73) by SN7PR04CA0212.outlook.office365.com
 (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 16:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 16:51:42 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 11:51:39 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Leo Li" <sunpeng.li@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix DM IRQ teardown races
Date: Tue, 30 Jun 2026 02:51:28 +1000
Message-ID: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: befc59ed-872c-4f3b-fcf4-08ded5feb289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: etkiqUGr7P3iedeq2nzr913a6M75LGUaENfCEECPfxZE8Tq8Vs2P0/bjoZECpdZpQIpYZMjuMQyyKPG6d+MwvS4GJNaG00Mx1Kx6NT/MQI4bJpRiyacMvmQ8w3tqnRe3qdHRpKGY4WancouJmQMnx3687PFjTvVYDE64tG329IJ/hHTgdkvDExdYV84czk/UCjMq0TtdQjaxmh7TvnDbdojzKmGd+ak4faxOm6ybf7iLTtBn0IvEP2qbBRc2d7y/RrZuK5pQfQ1InFZ5jjQ4a6A99NA6bSpa2GbyjEsC8kGBpo5Jo6mG7hJzCBWHeLAQjdRxViS89Tu7VVhSJ6O862y4Re5OvfVQyzqiZ/2s8PtV1+HbfEXyjAqHY+7ndZzOOf1GdLCyzW5djxV/GzvyGHeYF2opaARH0T5cLgYf+/IW1uJJZA6DV6lbv6b3M6rnkG4GlzDSrYEjeLNqkjNCyFfCIjq/nCqkwlOJPkachCRuoB8o3J4HYfK15ur/XrDWnVTqIwdDc6XxEgbqvAlhkJXyP42UdFi9YpV+pqXG3yYLGqlgMs/SH8n5HSELb+my7aq/4Jm9EVazjzhFGiJ0vAzE/T62/sG/f8H9PSOMy39AWuazV+GE95l40ODF5K7Se4c8IOkURAXLQbe1QevhpHtbnoTAjvGXZjknrwNspEoEhfa5UkKAMrMvQ5U9xkEvfrfMvIAtk50ApWJZN5OJOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A1fPMKj8X86xs0HptGKOO31bl9Da9yjZVi3KLzPgfUQL2SAXwgt/bzLBzc1qafzFoorIC3R7ES0cIO7H5sH9ArcSDKSXVEiORY/6bglybtY2yAJqq4iK8iBs8bcMVOKi/IikvX8iaaGVbPHGy1wISRuMVimE6UtfEHFrzUms4tPZwo23tH4257R2OfZKr2qsvHql7rsLngcEoQDnyUpvWURmXl5XBE/eQPFzZclSmt3TR2IcHKRRTx5jZ4H59InI8vq7oj+FGKKwTn9FXqzpH23bkj3sc2j9kPaog50oK4zGOLMcgJSruQPMXU9j+aqo+vLbXzr5SaXTdMjfnfcrHt0joGBUC5TOLYfHNVc6UPGzsV+zSJk+8FPxLs14dwrb9jcZ/QW77HzAQIhLfwXXHpY+F+K/s6sCv6qprw2Yq2YQ5z6M2E1bFHkXddEKvqE/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 16:51:42.6629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befc59ed-872c-4f3b-fcf4-08ded5feb289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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

Add an irq_fini_in_progress flag and set it before the IRQ tables are
torn down. Check the flag in the ISR and work scheduling paths so they
do not access the handler tables or queue new work once teardown has
started.

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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 164 ++++++++++--------
 3 files changed, 96 insertions(+), 79 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 909ee71d6d59..88687a7e01a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -340,6 +340,8 @@ struct hpd_rx_irq_offload_work {
  * @dmcub_trace_event_en: enable dmcub trace events
  * @dmub_outbox_params: DMUB Outbox parameters
  * @num_of_edps: number of backlight eDPs
+ * @irq_fini_in_progress: Set during IRQ teardown to prevent interrupt handlers
+ *			  from accessing the IRQ tables during cleanup
  * @disable_hpd_irq: disables all HPD and HPD RX interrupt handling in the
  *		     driver when true
  * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
@@ -634,6 +636,7 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 	bool force_timing_sync;
+	bool irq_fini_in_progress;
 	bool disable_hpd_irq;
 	bool dmcub_trace_event_en;
 	/**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c5467f34c51f..3a5de9364ed1 100644
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
@@ -459,38 +413,84 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_init);
  * amdgpu_dm_irq_fini() - Tear down DM IRQ management
  * @adev: The base driver device containing the DM device
  *
- * Flush all work within the low context IRQ table.
+ * Prevents any new interrupt handler scheduling, removes all handlers from
+ * the IRQ tables, cancels pending work items, and deallocates all handler
+ * data. The irq_fini_in_progress flag ensures the ISR and work scheduler
+ * do not access the handler lists during teardown.
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
+	/*
+	 * Set the fini flag before tearing down the IRQ tables. This ensures
+	 * that any concurrent ISR (amdgpu_dm_irq_handler()) or work scheduler
+	 * (amdgpu_dm_irq_schedule_work()) will bail out early rather than
+	 * accessing handler data that is about to be freed.
+	 *
+	 * smp_store_release() pairs with the READ_ONCE() in the ISR and work
+	 * scheduler paths to guarantee visibility across CPUs.
+	 */
+	smp_store_release(&adev->dm.irq_fini_in_progress, true);
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
 
@@ -498,7 +498,6 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	int src;
-	struct list_head *hnd_list_h;
 	struct list_head *hnd_list_l;
 	unsigned long irq_table_flags;
 	struct list_head *entry, *tmp;
@@ -511,12 +510,15 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
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
 
@@ -597,10 +599,20 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
 	struct  amdgpu_dm_irq_handler_data *handler_data;
 	bool    work_queued = false;
+	unsigned long irq_table_flags;
 
-	if (list_empty(handler_list))
+	/*perform a lockless check first*/
+	if (READ_ONCE(adev->dm.irq_fini_in_progress))
 		return;
 
+	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
+
+	if (READ_ONCE(adev->dm.irq_fini_in_progress))
+		goto out_unlock;
+
+	if (list_empty(handler_list))
+		goto out_unlock;
+
 	list_for_each_entry(handler_data, handler_list, list) {
 		if (queue_work(system_highpri_wq, &handler_data->work)) {
 			work_queued = true;
@@ -617,7 +629,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		handler_data_add = kzalloc(sizeof(*handler_data), GFP_ATOMIC);
 		if (!handler_data_add) {
 			DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
-			return;
+			goto out_unlock;
 		}
 
 		/*copy new amdgpu_dm_irq_handler_data members from handler_data*/
@@ -639,6 +651,9 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 				  "from display for IRQ source %d\n",
 				  irq_source);
 	}
+
+out_unlock:
+	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
 
 /*
@@ -678,9 +693,12 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
+	enum dc_irq_source src;
+
+	if (READ_ONCE(adev->dm.irq_fini_in_progress))
+		return 0;
 
-	enum dc_irq_source src =
-		dc_interrupt_to_irq_source(
+	src = dc_interrupt_to_irq_source(
 			adev->dm.dc,
 			entry->src_id,
 			entry->src_data[0]);
-- 
2.43.0

