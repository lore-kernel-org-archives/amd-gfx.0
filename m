Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266EC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 03:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED32A10E1C3;
	Mon,  8 Jul 2024 03:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8FDL4Hp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4283910E1C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 03:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqbaEcP8m3nRcAcFcOvIjui3xZGPif9HY84SzPCRe7jdKl5n5vlV2TdsgvjUdGxJ/2FIt2JJ+u0oNTNVC1zG+xbutP3gp7/jcZM2a8T2nb8yRVCj5p+T7tcNkGfr3WFNvxyD/vq7VTWXCoAir92oAjvI3Dgz92fXT4f7aRQq7I5jL27gGzSOZyNPn+EvbZM4JlLNkNpyKFAoFAeeao3mzadD/yUO7UKtfMs6hdCxWJW+fFAjNAO2mdLs/SR9sGol1r945ftcckYfzruYQjeC3QslISA5sdFAQh//0UhRf7yTVU92am3EALOO1K3VVBKaBzJZEvaHMH8IHtX+F+m5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3I9g/AiFqhcnZ9GMbkuOb8vU2Szk1eLimCMaDcFYwg=;
 b=RNjWkXsC+74LinzReI78UCSwuxmrzQEg0HOs1U36wNixiEjx1ugjWwSwJk3DT91E1FnlaQKFPcs4d8mF2kVsJ+b4rJKNvcwq/iXX6bgPHV2mjSklpZ9smlTU5aBv3Oz9V6f5X3ioHVZYhuMiyrHNbcN1QMSUAJhZnUlDN9Zcs1bZU4CTdoeXrgnlQ2ocDSHTehj1OLI4o3jMpeUxhXoCaouln6z8Z3Gvv+uaS3dX/gLZ4a8PGKz2zQW+XTP9B3tevOVwf0GOf96MYrZhH/NV9tjebW2t53t0CRJYMePso4+GvF6dsuorfC+Aa45eciWXxWdOGAbfWsaMXKTNT3eXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3I9g/AiFqhcnZ9GMbkuOb8vU2Szk1eLimCMaDcFYwg=;
 b=p8FDL4Hp5NRM3iWy9pK9E2gDrV9ZqNVWyge/uolH6r4619Wh2h6azCB45kUdg+EEtvZmsVWkfWYen8rYu69ZYmNSi7edbwS3pNO56YQJh3II93CJLNoB66TJDJHV9hrWiBQHeB8gsnTiKzkl8hEKr9AHqKS+TXA+O92eG8Pz/64=
Received: from PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::18)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:24:55 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::4b) by PH7P220CA0125.outlook.office365.com
 (2603:10b6:510:327::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 03:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 03:24:54 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 7 Jul
 2024 22:24:52 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id support
Date: Mon, 8 Jul 2024 11:24:38 +0800
Message-ID: <20240708032439.2944714-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708032439.2944714-1-kevinyang.wang@amd.com>
References: <20240708032439.2944714-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c68623-4964-428f-baed-08dc9efd892c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kg7dC1C81LGNNajXankLYxXJehgTPoVIrroG8JdSzGYrU+huX6BudohAVb+w?=
 =?us-ascii?Q?s+ygB0uCRKG8LflNfZ8MIAta9C3JOzxlFupdZiazmjGfBRwQwgMwCor/YUuz?=
 =?us-ascii?Q?M5VJHz5qQ7McuYAfJVaFrvLQpK90bdDwzDn5Cz1h6m8oy/Mp+TeKAQ1OKzPG?=
 =?us-ascii?Q?3x/L35YtfU7ynJ0o+C478P/LUwEknLUeeVPzfhCoYtJJQ8toF2aF2Mgjzh3Y?=
 =?us-ascii?Q?qWS5ZnYgqzU/Qwmm0+dLD5T1TDqwdyVdKJEIjU5WFnWkYN6yUFDtTYY5yb/m?=
 =?us-ascii?Q?6ppY2kX7/VUrzPV/20/HaDSX1AXVRNYHPveHaF3x9EGovyTsMLY1WKZKbH60?=
 =?us-ascii?Q?N0RjhAbcrCcwdJwJpgF4Wg5s/kzr34qT2PWI3eDzYX6I4m+yNkNVIZ8LMTes?=
 =?us-ascii?Q?uttBfcfSgH85AfonjSgvYGTceEWK7DeWwXpOhesIihFOQu2uS4NvF5TvqiQc?=
 =?us-ascii?Q?7KzFFm7FhA5NwrRdYW8uEFlz4TyjpsaAn4oQbaxmL/JB4XJNIcafUcnV7xox?=
 =?us-ascii?Q?E//sNQi+u/7YpuYnv858/b2LZn3/IZ+BfIPBZ09l5wh/SW1aoN/0v56W0FFJ?=
 =?us-ascii?Q?OF+KjB2K8r4WRH2upJoM+NANVfmSGOuKlyyC2zy1TN5XKQVuXcqWs+UFjMQQ?=
 =?us-ascii?Q?wEIhCCo2qvzAEEijqu6WV/HK+JsMprMh77kSLleMTyUqbzmKjcw/NmbFYE58?=
 =?us-ascii?Q?0CVf+oHj5xfE0sDluUzLd7aqSuFCdOEaD2ccoCupreaJBU9gGYFSI/AnhnNG?=
 =?us-ascii?Q?IwdGGX2aIf6b+Ih9oSh2lv65i8kyd9UsAA3sB+WEV0tscQqPhZPXZnJNzQag?=
 =?us-ascii?Q?c7wFXKW4oEh3utE+Rqvb9zbjelv/trWfyW4MnbbVrZLGIdDfpUEGNx1HnXW1?=
 =?us-ascii?Q?VFHxoFUqYEBBjSYWLkG+1usGzebC7f+lPom4pcljYiTW7AUd/KtGM9tLz4QH?=
 =?us-ascii?Q?wGY2uJNYcELaJZ4VqY3iisUN2QyHnELFNPS7ZtshPr854TEwvtj7F8kNmzkg?=
 =?us-ascii?Q?EfvjCk7Dos2FruGsS62qYJTk1dL+s2owHm2VQacJ9RE2a0wIqPMKzw6GeACi?=
 =?us-ascii?Q?z97HzORO167TOsbF1G7exeU9abLoVSF/SNVWGnuwMtc5q3JQnduUtIva83mQ?=
 =?us-ascii?Q?JWrpTKvieaxOn/KBOL85MjW5ynV1A5s6sFrHVGwsmaYD19OS1cLJDBgIEreW?=
 =?us-ascii?Q?aUMQMlhHq1pna05Yp9d2nDgaqFpJtudmHQecGuu78X6t2quvi08c6sF9Gf84?=
 =?us-ascii?Q?8G4uaG67lNyiwresc0AzHJWDXyOSqpRPkYSb7JpE2Tc3XkiAu1QLEohY9752?=
 =?us-ascii?Q?spGbxpX6huGp+ZvPU95bmmyUw8qBR6q06hYwXN6MhLkPT4HbtCddK85GyjHD?=
 =?us-ascii?Q?qNjBHwCRQwM4EzS+HqS4mhKSnH2Uq1Kkk9rX6b1BEQUfaFZGqtX1iCBZMamY?=
 =?us-ascii?Q?nQ6J3YI/t0KNNz0ThCA6JRxPRUAZY5ro?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:24:54.3686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c68623-4964-428f-baed-08dc9efd892c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

add amdgpu ras POSION_CONSUMPTION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c7e68c5e90cd..ca09316fbb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2076,10 +2076,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
+	u64 event_id;
+	int ret;
 
 	if (!block_obj || !con)
 		return;
 
+	ret = amdgpu_ras_mark_ras_event(adev, type);
+	if (ret)
+		return;
+
 	/* both query_poison_status and handle_poison_consumption are optional,
 	 * but at least one of them should be implemented if we need poison
 	 * consumption handler
@@ -2104,8 +2111,10 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	 * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
 	 */
 	if (poison_stat && !con->is_rma) {
-		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
-				block_obj->ras_comm.name);
+		event_id = amdgpu_ras_acquire_event_id(adev, type);
+		RAS_EVENT_LOG(adev, event_id,
+			      "GPU reset for %s RAS poison consumption is issued!\n",
+			      block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -2498,7 +2507,7 @@ static enum ras_event_type amdgpu_ras_get_fatal_error_event(struct amdgpu_device
 	if (amdgpu_ras_intr_triggered())
 		return RAS_EVENT_TYPE_FATAL;
 	else
-		return RAS_EVENT_TYPE_INVALID;
+		return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }
 
 static void amdgpu_ras_do_recovery(struct work_struct *work)
@@ -3985,6 +3994,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 	switch (type) {
 	case RAS_EVENT_TYPE_FATAL:
 	case RAS_EVENT_TYPE_POISON_CREATION:
+	case RAS_EVENT_TYPE_POISON_CONSUMPTION:
 		event_mgr = __get_ras_event_mgr(adev);
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 69eb5fd4640f..49ec8edcbe39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -436,6 +436,7 @@ enum ras_event_type {
 	RAS_EVENT_TYPE_INVALID = 0,
 	RAS_EVENT_TYPE_FATAL,
 	RAS_EVENT_TYPE_POISON_CREATION,
+	RAS_EVENT_TYPE_POISON_CONSUMPTION,
 	RAS_EVENT_TYPE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..8a10a0e42846 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -27,6 +27,7 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_ras.h"
 
 /*
  * GFX9 SQ Interrupts
@@ -144,9 +145,11 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
 	enum amdgpu_ras_block block = 0;
-	int old_poison;
 	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
+	u64 event_id;
+	int old_poison, ret;
 
 	if (!p)
 		return;
@@ -191,10 +194,16 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		return;
 	}
 
+	ret = amdgpu_ras_mark_ras_event(dev->adev, type);
+	if (ret)
+		return;
+
 	kfd_signal_poison_consumed_event(dev, pasid);
 
-	dev_warn(dev->adev->dev,
-		 "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
+	event_id = amdgpu_ras_acquire_event_id(dev->adev, type);
+
+	RAS_EVENT_LOG(dev->adev, event_id,
+		      "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
 
 	amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
 		block, pasid, NULL, NULL, reset);
-- 
2.34.1

