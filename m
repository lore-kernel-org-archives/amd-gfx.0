Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D88C54E60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 16:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9962410E3DD;
	Thu, 14 Mar 2024 16:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MVGYrdYO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E23C10E3DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 16:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvHh/D4qjcrGkp7oSoM1bRHxTYTpMvs3m4l5YaG8HJC5jW/utGQ9tZLnXJifJegZs8MgvvFf8wdXZfW/y/duMvmAvgifO8y5h+c3WuH0JiSKJfWfLXw2dNaZddiYcO/cEENm/xj9dmD2mAYMcgZUzucS/b/j7Yqbk496MeiXn+BZvu8/MBYuXfGJHozRGHCbF86GwTM3VVatpGa8xziwGjjEUeDbPrhzr/cnWi5ezhHk+CCt75/R+shsKnbKtSN1Ei9XXHWeL8ZOmYSQg1EUfa6xowdtE3baJiE2SIML8MdMs6CMAACLRXv1u1Y/f+DscW+BdQb5UE/anFfCigEbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bvHta5+gzpPiAZMeffP93J8j+eUaE+t9JYYiTHhLls=;
 b=bhSritdL1J5LPhYFd5u256f5moEE7g/wtbhXK4Zy70vwnyc56U5RBi5yVee7Cf/Wy0siS9IkftS2WWZ18xturGlKBA7OuFj595abUqw6Bodo03gi7P+RRYx9qo3n4Lmmd0O4s3xbP58afLRJb7W6h7SGRh4tUgxIdamV1qXLYDnEzmJFbNycCci4coD+Cw5eKeWU20S61DZmbJPjFeeBeiTIpPfzm2r46iMzQnzaYte5m3+I3YuQ7BRZUFuMZpq7Z3SPQqtitddd/dY8SEeC25BQteYfWw/FS5HeLXgG/vElR4/wsFEuCWN+dTfGGMj8e4+KK5gHkRgZPVFZaN7zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bvHta5+gzpPiAZMeffP93J8j+eUaE+t9JYYiTHhLls=;
 b=MVGYrdYO1c2fS3sRWEY5Yh6u3AaQ5ndopJW02Wt4jdTUBMyry3I2WrTOure78/Z4M29sui89FNvuMUXu841YSacQATUHqGwXJdTkQIS31zTOb/FFDrHMpuDZcwVHusbnswf4Hm3s0h49JaREwrtE+uspqIvFNM0QCWqQbzQH2ME=
Received: from MW4PR03CA0037.namprd03.prod.outlook.com (2603:10b6:303:8e::12)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 16:01:15 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::aa) by MW4PR03CA0037.outlook.office365.com
 (2603:10b6:303:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Thu, 14 Mar 2024 16:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 16:01:14 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 11:01:13 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Jay.Cornwall@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Jay Cornwall <jay.cornwall@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Check preemption status on all XCDs
Date: Thu, 14 Mar 2024 12:00:29 -0400
Message-ID: <20240314160029.623784-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240314160029.623784-1-mukul.joshi@amd.com>
References: <20240314160029.623784-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af3682e-82d5-4b2f-b3a1-08dc443ffa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQqizTmfTQHnp6ax1d1k613Xbl33G8rpUOfud92F6uAnN8InksxViXqelpGdWR3LCKG0FY6FBqf3RXo4tScYHybD6zAIvgl93sTGyW9OpU+2uI95w6AZ5Tmwa/TBg+rihNlt4DfKvsHyallhWKPD0DlKUU+mw4LsRCEHOrOo2ZFvH9ZmpM8fCbiEWjhwuOgnHlTOlR69+hIXwYTebHS/yZSD38LgnM5+L+Kgb1m6fio92eNnq+QbztdRA89+I+3lUrU4Uz18SVAxcLw/kYBgJV9sXh2FjX0MIxSaIVctcHxvzw3qvFOId4RiU5VAu3A6qZ4f5jnOOGNhHWuhzl8qPAN5xsIK7FFZCI7iucF57dBvs/iTvrQRu7+5U3vHMf37d9YceEM7hYNbYII7PY2Wu7itUjUCQWjhfXFFZVeatR2fiMvQ8EupmbnNCYBFMQWpWFwvWBVoqijxfiMm0c2+H+WhLmnQMF46a0V4zZFsaoZBWDRObT3SKKGGwNd/5xXCBSo/LYFqbIdAOmpVIR7uXOXIvXpiBXT3o8YDTNNQurcGD4+Vzmg7ljmlUqJYsqkDS+7L3LrSWMO2WIs5/nYb5iNtCTC1UPSzojsXRzDopgU4DKUtFR9036GWGs5I+WphhAAb95Bz0e9sg5BEKlmINWSRlUrt5XcjOZWB9wB4SwnZB37s/LzluRtD4lKe7jwzO1X5gjU+hvVZuiLR1tGBajzUnQNBZDPnxX8ret1skbPSqzVBJr0geKBRuaEX14kZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:01:14.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3682e-82d5-4b2f-b3a1-08dc443ffa20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

This patch adds the following functionality:
- Check the queue preemption status on all XCDs in a partition
  for GFX 9.4.3.
- Update the queue preemption debug message to print the queue
  doorbell id for which preemption failed.
- Change the signature of check preemption failed function to
  return a bool instead of uint32_t and pass the MQD manager
  as an argument.

Suggested-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 18 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  4 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 ++++++++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  4 +--
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1ce398ab0b3d..151fabf84040 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1997,8 +1997,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 * check those fields
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-	if (mqd_mgr->check_preemption_failed(dqm->packet_mgr.priv_queue->queue->mqd)) {
-		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
+	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
 		while (halt_if_hws_hang)
 			schedule();
 		return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 050a6936ff84..cbec8c87c984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -290,3 +290,21 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 {
 	return mm->mqd_size;
 }
+
+bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
+				   uint32_t inst)
+{
+	if (doorbell_id) {
+		struct device *dev = node->adev->dev;
+
+		if (KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3))
+			dev_err(dev, "XCC %d: Queue preemption failed for queue with doorbell_id: %x\n",
+							inst, doorbell_id);
+		else
+			dev_err(dev, "Queue preemption failed for queue with doorbell_id: %x\n",
+							doorbell_id);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index ba3eebb2ca6d..17cc1f25c8d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -119,7 +119,7 @@ struct mqd_manager {
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
-	uint32_t (*check_preemption_failed)(void *mqd);
+	bool (*check_preemption_failed)(struct mqd_manager *mm, void *mqd);
 	uint64_t (*mqd_stride)(struct mqd_manager *mm,
 				struct queue_properties *p);
 
@@ -198,4 +198,6 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
 uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
 uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q);
+bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
+				   uint32_t inst);
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 8f9f56f7a8b0..05f3ac2eaef9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -206,11 +206,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct cik_mqd *m = (struct cik_mqd *)mqd;
 
-	return m->queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d4cf7d845928..2eff37aaf827 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -224,11 +224,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v10_compute_mqd *m = (struct v10_compute_mqd *)mqd;
 
-	return m->queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2b9f57c267eb..68dbc0399c87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -278,11 +278,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v11_compute_mqd *m = (struct v11_compute_mqd *)mqd;
 
-	return m->queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7c93a0932677..6bddc16808d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -316,11 +316,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v9_mqd *m = (struct v9_mqd *)mqd;
 
-	return m->queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
@@ -607,6 +607,24 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	return err;
 }
 
+static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
+{
+	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int inst = 0, xcc_id;
+	struct v9_mqd *m;
+	bool ret = false;
+
+	for_each_inst(xcc_id, xcc_mask) {
+		m = get_mqd(mqd + hiq_mqd_size * inst);
+		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
+					m->queue_doorbell_id0, inst);
+		++inst;
+	}
+
+	return ret;
+}
+
 static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
@@ -881,15 +899,16 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd->check_preemption_failed = check_preemption_failed;
 		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
 			mqd->init_mqd = init_mqd_hiq_v9_4_3;
 			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
 			mqd->destroy_mqd = destroy_hiq_mqd_v9_4_3;
+			mqd->check_preemption_failed = check_preemption_failed_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd_hiq;
 			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 			mqd->destroy_mqd = destroy_hiq_mqd;
+			mqd->check_preemption_failed = check_preemption_failed;
 		}
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index dbc868e0363f..c1fafc502515 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -237,11 +237,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct vi_mqd *m = (struct vi_mqd *)mqd;
 
-	return m->queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-- 
2.35.1

