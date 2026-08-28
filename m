Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F8BC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1D410F297;
	Fri, 28 Aug 2026 07:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ziw7GFXf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4720C10F297
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCs38nH/sy8++ncyYIW3t7zHgfx6eoKtjea3HSwznaLKFUmAE5Bg7z1f91UBIjvfNlP9CmXFOzwNTw9vMuGxS3xUBIWShGkv83lWUI3VCchU68JM7J0YoOnbka2PKZG3zRP9ayGuhAPMKAWTre796uORlztSSsBPFWhdeevaiD4Uyotoztxtqo1diZ0aQNSHz4RzFauTxbt+it1EOs9wBTp9mgWlBNhY33NTzYC7dF9sW70V3M5548hnOGGnDbn7cUhbpYai3ipS2I6kDH0F33YprA2Yi8nOGrmOgh4oFu4Yw9Wk7jWZCn9kQQRIy4WOJ08/bloUY+EVMcgrfFCA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPf7LlzqycBRMTIPC0MDM+rsxNmaGk91EVx11wNdvLE=;
 b=t8JAcEo1V2Mh3lK3J4rNfZBi89vuv6Dq/0V1dlo2cJfxzctf/YaKyS753jDSwykKmiUChyDorVg9gb2veMjZiP/EPGU7TUoWBlDMIW5Dii1VtinJyl2Ov4TlWN8nnX+zV6Yp7srUr/7kDPRwMIsnfKGct8tuxu/W12mtg6EB31ujVmH03sBHuFhJ+mSXSWKECb3SHxdQsEbVxj5gjjiCeB3bzoBjk1UNbf2fOQm9tLfvO6F36zTS4ISUJydfXvIMvunlbgZ+ARqmJuDm88gCL4DIOEC5Ef1rjKmjUxuWwFOz6r76ZCvrg8pEZj1c1i4WOzeilZ6DG0S9Gbr30chTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPf7LlzqycBRMTIPC0MDM+rsxNmaGk91EVx11wNdvLE=;
 b=Ziw7GFXfb9W1WsUeCoH3xHkzOn2zP8Sp/AcwDBXMhfjJnkjsHFyYvLHzoEnwxhyYOF5RUlZGOiCSs5xrqEN3jH7HmAHqtCFaod8jcFrnd3CRgQOrOiCy9qK9PR8+3SRFeZaEPzFd+CqPvlv9SN4YkIxfjvpaUrsdXlQm9D9m/N8=
Received: from MN0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::25)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 07:41:54 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::18) by MN0P220CA0007.outlook.office365.com
 (2603:10b6:208:52e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 07:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 07:41:54 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 02:41:52 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU reset
Date: Fri, 28 Aug 2026 15:41:45 +0800
Message-ID: <20260828074145.257673-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ee7eac-eeb3-4371-fad4-08df04d7d49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|10067099003|56012099006|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: s5dUQcireSQRmvDPZxDzrauJlQx6/ppRRZaESPdwGcE7T9Gwyq6ZDrrzjOkuG14IBnWTlBPvtDl5EOcR/l717zdbLHE2B2ldWWuj8Q5eiUMFKA1ppNDCMgyljXVQc43dK4B90QlLZKG6HTDS/6Bi9CyRxCvUZPmzvdmVhBgg2ee27I18eUt2Ikbn3wtrPzJA8xC+BpFIhZpadSUDGzLr14fozVXtl5SD9/Ybqid75TNLdRK6MKjMi6DFylXLj85PLvgX2EGsM+SYex0o7jh6O7OJl4lQDRWDJF6fe5oUi1NvF1r2ZfWOX7bcYH3DB8MxbdWstzqRdvgwPicACS6/ztN/5RV1tyFvClDo/TGyhRf2whhgpvmvyR51bEPiL7JbX6pyiVjLHxhR6Z02JO1aMT6EC+VjXQHmr5Ur54W6hNC6cb518Kvpqta44y17zB+l8KS1QwHymGH8LlgV31TW0Bk9nZ7wp1zB4qChqeO+sgo/LpDYM1rwlDCyvqUS91Iv2JJbg1+WTaO9AzarQ5RWrHe9E9aG7aUzLzbRjl6dpC/Z2dezTDX5uml/8ckBLcKNoeUJ7c2DOuO2XByUYWU+7dT7XR+dYxQfpxB4EuT82tzy7ekYHyoR8pOV7YPUWNG6Bl2wtykOJOdzGk/m5YLQtaSpgo6rLpuGEkR+wzAoRfCII00o5F1D1gZWry8f+qAayxOMun0gZC6tAiuMPdorzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NPeOl9waEin+cDtm/qGqiWH4BqgpnX59Nzeyg+iQtw7tpZh9jHdmz6oYAfGxw0SjqQBoOQKOvG4/P0mCSwwJ9MiryeX3RANT/tGYsGn47l3ZjMgBVy8/Wq9pUVlwQJmJzrAXHr1w+J2Vvc3QYuimJnC1oVnTp+jh5+Rn3fN3R8wudN8HqslwOhBryjsV7QPIhz/rvQQKuihFcU1KNQKwPzXnarILUied4PuwfXM4YJ80BXF7c90SC6MAy7FAo7duAscg0AROVuzglJtB0wKwDJL+uSE2d5hPnmswBSzyNQHwJP9RdeQsuwN6Do/XEWCuxxMSDrYoJLZo/oJ+GP5u5VwGQSjZgpyEiFnrl3UuMKD2UTLtSfq6LTV72RKvslF/I0n6OR0enmIuFQvUS5di872CQ7X10Hnsrw/49bgxrTBWVR4JJxELBhAPkBez+pyz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:41:54.0997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ee7eac-eeb3-4371-fad4-08df04d7d49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

During a GPU reset, evict_process_queues_cpsch() calls remove_queue_mes()
per queue, which fails with -EIO because the recovery path already holds
the reset domain write lock. The loop aborts on the first queue, leaving
the rest with is_active still set while the reset wipes the MES queue
table.

When the process later exits, process_termination_cpsch() sends
REMOVE_QUEUE for doorbells MES no longer knows about. MES rejects them,
the driver reports it as a timeout and concludes MES is unrecoverable,
so it requests another GPU reset.

  Failed to evict queue 2
  GPU reset(1) succeeded!
  failed to remove queue from MES, doorbell=0x1002
  MES might be in unrecoverable state, issue a GPU reset
  GPU reset begin!. Source:  3

Mark every queue as reset in kgd2kfd_post_reset(). This clears is_active,
corrects the queue counts and sets is_reset so the queue is skipped later.

Add a verbose argument to set_queue_as_reset() so the full reset path
does not log a message for every queue.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
v2:
 - drop the enable_mes check and mark queues on KIQ as well
   (Suggested-by: Alex Deucher <alexander.deucher@amd.com>)
 - add a verbose argument to set_queue_as_reset() so the full reset path
   does not log a message for every queue

KIQ does not hit this bug. Its evict loop has no fallible call in it, so
the loop always runs to completion and every queue ends up with is_active
clear, leaving nothing for process teardown to send. Marking on KIQ is
still worth doing: after a reset the queues are gone on both schedulers,
and is_reset states that, while is_active == false only means "do not
schedule it now" and is cleared again on restore.

 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 36 +++++++++++++++----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640f13dc..84bc04c4a55c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1033,6 +1033,9 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	for (i = 0; i < kfd->num_nodes; i++)
+		kfd_dqm_set_queues_as_reset(kfd->nodes[i]->dqm);
+
 	for (i = 0; i < kfd->num_nodes; i++) {
 		ret = kfd_resume(kfd->nodes[i]);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..350dcb8c21cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -75,7 +75,7 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sd
 static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
 						   u32 doorbell_offset);
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
-			       struct qcm_process_device *qpd);
+			       struct qcm_process_device *qpd, bool verbose);
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
 
 static inline
@@ -433,7 +433,7 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 		return r;
 	/* Proceed remove_queue with reset=true */
 	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, true);
-	set_queue_as_reset(dqm, q, &pdd->qpd);
+	set_queue_as_reset(dqm, q, &pdd->qpd, true);
 	return 0;
 }
 
@@ -2369,12 +2369,14 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 }
 
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
-			       struct qcm_process_device *qpd)
+			       struct qcm_process_device *qpd, bool verbose)
 {
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 
-	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid %d is reset\n",
-		q->properties.queue_id, pdd->process->lead_thread->pid);
+	if (verbose)
+		dev_err(dqm->dev->adev->dev,
+			"queue id 0x%0x at pasid %d is reset\n",
+			q->properties.queue_id, pdd->process->lead_thread->pid);
 
 	pdd->has_reset_queue = true;
 	q->properties.is_reset = true;
@@ -2384,6 +2386,26 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 	}
 }
 
+void kfd_dqm_set_queues_as_reset(struct device_queue_manager *dqm)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+
+	dqm_lock(dqm);
+	if (dqm->processes_count)
+		dev_warn(dqm->dev->adev->dev,
+			 "GPU reset: queues of %d process(es) are no longer usable\n",
+			 dqm->processes_count);
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list)
+			set_queue_as_reset(dqm, q, qpd, false);
+	}
+	dqm_unlock(dqm);
+}
+
 static int detect_queue_hang(struct device_queue_manager *dqm)
 {
 	int i;
@@ -2499,7 +2521,7 @@ static int reset_hung_queues(struct device_queue_manager *dqm)
 			goto reset_fail;
 		}
 
-		set_queue_as_reset(dqm, q, &pdd->qpd);
+		set_queue_as_reset(dqm, q, &pdd->qpd, true);
 		reset_count++;
 	}
 
@@ -2546,7 +2568,7 @@ static bool set_sdma_queue_as_reset(struct device_queue_manager *dqm,
 			if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 			     q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
 			     q->properties.doorbell_off == doorbell_off) {
-				set_queue_as_reset(dqm, q, qpd);
+				set_queue_as_reset(dqm, q, qpd, true);
 				return true;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c9f9f7a87111..8ddde9f75541 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -333,6 +333,7 @@ int debug_refresh_runlist(struct device_queue_manager *dqm);
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 struct qcm_process_device *qpd,
 				 int doorbell_off, u32 *queue_format);
+void kfd_dqm_set_queues_as_reset(struct device_queue_manager *dqm);
 int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 			int pipe, int queue, unsigned int db);
 size_t mqd_size_from_queue_type(struct device_queue_manager *dqm,
-- 
2.25.1

