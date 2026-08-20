Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AB1C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B612510E1F7;
	Thu, 20 Aug 2026 15:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olkxvPae";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE5110E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRN0yebr3JTtIVKHLYeI6D0S3HzkU6ES83BLCQQxjdu3TDiiM1Am7XsEqv786Sj7WVvEHrEBaCRiM8RVxShoyZLo4jdUjN3gafivj7CAEuluctt3VoBi0XcX6SpJ4mVe4zz9DKpZf7NYHqnPhPWKpLBfbHlsrBCjgiM+SAxkx+8aXRyejV7/obg/poEL6kuNqnYS+AkUKAZVpYUaw2OGrQVefWKWcGTHqLv9eKzQgg5H9Q1dHNEolpTDf25Md6sEepYoXlPJ5Svc1xhdq1RSaAwKjms7ExrnyOzsGpE24vrSdYFfdbvHD9aAInHrSQyngVohNm+p4IK1Y0/TjRJ9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn9kyAkleyG2jVDC1DxPUdvJ9DZxcKwZtJWJaOQuxy8=;
 b=T3Ea1QAS0fsd73cTyMXSWyAbeI1pA0FgLK+RkrrpCp9UgOsjQlG3yqp0SNIZk77Kl3qck3xofD75OSJE1G2ELzYld+aC+5y/d/4KExxjPEIkgsCKgpg5QRDVrkyICAQ0u9EvVDT6JpRPOqpeXkQW23bxvgcl8Krd7hEA0a5Vp7TCSI/Ym0ahy7lJXxTR6EoLwSUY9YdY/Ll4zspb0G3L+Dtmyo+fcoGuwcBwTAuik2N2K4HJ1NkuL7/yhAfX8++8zFnHjPH8cRJtr6+4m2DhkIhRh3k2BnBPCy9UxGglLVy2bYLkeFj66NdSlAWEhkvRtxE4XUz+JpWkqCvQvP42hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn9kyAkleyG2jVDC1DxPUdvJ9DZxcKwZtJWJaOQuxy8=;
 b=olkxvPae4kNEraFmTAWlNDtx+LRIMoCwqnDBiHE/1f2/BZqO5eSZtwRUyhY3BKmRqgw+tCQ+60nfDjFB3n+dOaSB9dwraEqG4DhLr8VK048hsQPZB9erKjEVUielxJ0rfNBudZjDcGr6NCI+gs3y0kZ88gD1W3L6S47cs5Rtzgo=
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 15:36:31 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::16) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 15:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 15:36:30 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:36:27 -0500
From: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Sreekant Somasekharan
 <Sreekant.Somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: Enable SDMA queue oversubscription for GFX 12.0.x
Date: Thu, 20 Aug 2026 11:36:09 -0400
Message-ID: <20260820153609.2264412-1-Sreekant.Somasekharan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 417a3feb-19eb-47ce-f4d9-08defed0ce7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 35AtilEmmpCuVILHJajQZ4rOkJcDaj96eIsR1HKZKyC85oBwsfH6kPytkTtZ8SSFDep1M4XnQHZlr6QIJ3nR3JhObEMkdsUjShemfRLiSpSt25Ca5Yzi1xmOvgpiF8RO2nYmTJtFbH/0HDUCSjd/J3DNTKqhY+webqABLuWiDR9zX+AeQbxbcb0ImocXqSlybrpmcpaNGGpdms46ElDQLnX78rfpNxRkJQ8lbHhGYSq6IS+xPwjU0b6mfC87PFJyE9O7JXYImyh0BnXd0KeH9aCEyzfiQyUS1vEj30nv+8Vjj3y0N26M37JXBAzaeDavcgZSDKkgOdZ+EjfbPaeL4C2zG9pP2yd2bQbq1+6bjPNOvktIN4e90SJi9UIeJxQ9xIl7oHn7LL2fYqrP+7nspvIgkbmRNcPLpbt2hiEUMjmKPjihqe8u6Pc6dvKfQeCP/DsHuFVGAVf+c/NzURIXz9xCD2JXs48vRRU7OUnI5ABRotVztZmus5hyHPUPnE63q6RbgUh3U6NdJ5i8jdhuVu5L315Mksv8fqRg2Ca7jPzl/t4jPrPxGzLuZgQ4fm3PV00QsymZQOmzJUNrrdbq0R6PShjEjHRtbHZR24p8JjsMvBI05gvHXYu8OCIH9zHRNy1zx/kTSzI1c6O+vR0/9TIXC/bZUzx1SJGK+KMDgTMtI2ueQdzk0lv0G9MCXcV6v5+KLAnB4o7Zrt7uWtlu2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E/JmxBaqlYpq8bfvC7K+PmGEGb68MAbJFfkS5yP3RcY8s+5+dJzF8wdC7fIjVre3M8v/eUfkdx/Wc5SsxeK0TUtnqD4RxY7WlFuRqaVq7lSOLxpB5iJz1bhPX5A2AspTF4/et8L1y2+zgbaPWM0T96bzM8P68kxr/WyTdJT1Mm/OPtEQ9NBGDf82HyZKUL4Gw2YGcPDfRnpo+NPE+PHBPbNHEHFdr0gqUTQU/g6apZCRsQV5J0sx1Suh752PU+8E6wnBRUp+tfo85FjQchRChc8ARt4/lZKoRORQdQ7exN9v1DbyVviM2QNS0w9bA9CmfztrDbTJSrHcCMWZVoMhwsIikJ7s6vGqMF7xAHak+sZ9xXMCqhZPEM+P7yoPm3+xR22dsG3lZTAldCe2REAR8/Vt64JuO7rc0xMcr+fNvXL2rdMduq941H5mnQHUwbZW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:36:30.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a3feb-19eb-47ce-f4d9-08defed0ce7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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

When all HW SDMA slots are exhausted on GFX 12.0.x with MES enabled,
allow new queues to reuse HW queue IDs round-robin via a dedicated
monotonic rotor. Each oversubscribed queue gets a unique doorbell from
the per-process bitmap pool so MES can multiplex them independently.

Normal SDMA queues and all other GPU generations are unaffected.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 54 +++++++++++++++----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..10a672b87ca5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -556,8 +556,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 			return -EINVAL;
 
 		q->doorbell_id = q->properties.queue_id;
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
-			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+	} else if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
+			!q->properties.is_oversubscribed) {
 		/* For SDMA queues on SOC15 with 8-byte doorbell, use static
 		 * doorbell assignments based on the engine and queue id.
 		 * The doobell index distance between RLC (2*i) and (2*i+1)
@@ -583,7 +584,10 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 			return -EINVAL;
 		q->doorbell_id = valid_id;
 	} else {
-		/* For CP queues on SOC15 */
+		/* For CP queues on SOC15, and oversubscribed SDMA queues which
+		 * reuse HW queue ids and so need a unique doorbell allocated
+		 * from the per-process bitmap pool.
+		 */
 		if (restore_id) {
 			if (*restore_id >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 				return -EINVAL;
@@ -621,9 +625,14 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	unsigned int old;
 	struct kfd_node *dev = qpd->dqm->dev;
 
+	/* Oversubscribed SDMA queues allocate a doorbell from the bitmap pool
+	 * (like CP queues), so they must be freed; normal SDMA queues use
+	 * static doorbell assignments and must not be.
+	 */
 	if (!KFD_IS_SOC15(dev) ||
-	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
-	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+	    ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+	      q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
+	     !q->properties.is_oversubscribed))
 		return;
 
 	old = test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap);
@@ -1800,15 +1809,33 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 {
 	struct device *dev = dqm->dev->adev->dev;
 	int bit;
+	bool is_oversubscribed = false;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
 		if (bitmap_empty(dqm->sdma_bitmap, get_num_sdma_queues(dqm))) {
-			dev_warn(dev, "No more SDMA queue to allocate (%d total queues)\n",
-				 get_num_sdma_queues(dqm));
-			return -ENOMEM;
-		}
+			/* All HW queues are busy. On GFX 12.0.x under MES,
+			 * oversubscribe by reusing a HW queue id round-robin;
+			 * MES multiplexes the SW queues via their unique
+			 * doorbells. The non-MES HWS runlist path cannot express
+			 * duplicate sdma_ids, so it still fails with -ENOMEM.
+			 */
+			unsigned int num_reserved, num_available;
+
+			if (KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) ||
+			    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(12, 1, 0) ||
+			    !dqm->dev->kfd->shared_resources.enable_mes) {
+				dev_warn(dev, "No more SDMA queue to allocate (%d total queues)\n",
+					 get_num_sdma_queues(dqm));
+				return -ENOMEM;
+			}
 
-		if (restore_sdma_id) {
+			num_reserved = kfd_get_num_sdma_engines(dqm->dev) *
+				dqm->dev->kfd->device_info.num_reserved_sdma_queues_per_engine;
+			num_available = get_num_sdma_queues(dqm) - num_reserved;
+			q->sdma_id = num_reserved +
+				dqm->sdma_oversub_rotor++ % num_available;
+			is_oversubscribed = true;
+		} else if (restore_sdma_id) {
 			if (*restore_sdma_id >= get_num_sdma_queues(dqm))
 				return -EINVAL;
 
@@ -1901,6 +1928,7 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			return -ENOMEM;
 		}
 	}
+	q->properties.is_oversubscribed = is_oversubscribed;
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
 	pr_debug("SDMA queue id: %d\n", q->properties.sdma_queue_id);
@@ -1914,7 +1942,11 @@ static void deallocate_sdma_queue(struct device_queue_manager *dqm,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
 		if (q->sdma_id >= get_num_sdma_queues(dqm))
 			return;
-		set_bit(q->sdma_id, dqm->sdma_bitmap);
+		/* Don't return oversubscribed queue IDs to bitmap.
+		 * They are shared by multiple queues and managed via round-robin.
+		 */
+		if (!q->properties.is_oversubscribed)
+			set_bit(q->sdma_id, dqm->sdma_bitmap);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
 			return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c9f9f7a87111..81626e657055 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -255,6 +255,10 @@ struct device_queue_manager {
 	unsigned int		gws_queue_count;
 	unsigned int		total_queue_count;
 	unsigned int		next_pipe_to_allocate;
+	/* Monotonically increasing counter used to round-robin oversubscribed
+	 * SDMA queues across the available HW queue slots.
+	 */
+	unsigned int		sdma_oversub_rotor;
 	unsigned int		*allocated_queues;
 	DECLARE_BITMAP(sdma_bitmap, KFD_MAX_SDMA_QUEUES);
 	DECLARE_BITMAP(xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..5fff5e55fb09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -531,6 +531,7 @@ struct queue_properties {
 	bool is_dbg_wa;
 	bool is_user_cu_masked;
 	bool is_reset;
+	bool is_oversubscribed;
 	/* Not relevant for user mode queues in cp scheduling */
 	unsigned int vmid;
 	/* Relevant only for sdma queues*/
-- 
2.43.0

