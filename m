Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231DDCD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 18:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982CF10E822;
	Thu, 11 Jun 2026 18:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A19ybL3x";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2691010E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 18:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rz/9c2gLybEfZWHPHEeawIayEEgimMl0qnHzqR+AdQWzYypXHAJ9AuxMdiRRc9IRq5Pxu4NMInJnfJ0ALahBIx6iSgH9J2DfaDoXxJch/lhfFjNKSJ6xxMxkbNN9oDx39yukLgfDb7jE8lfkLFf7J6b0r+s23G9rCZfDgCyAkq0/vzFQjASn2kz8PS8p0ZIjmvsO96bz/u6xIiZOw9IYj3fWZEY9qdAQYWdWDeLnUebiPJvb40UYizQfeSfM7L6FdUFXR782gHvVBheQYWAxbTwETd6Ke8rZdj3s906F4bTMXzO9UygX21XefKpPn0d+6DLUmAe6C3GGM7SCCNewcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xq/LOS3aeRS5ca1CJ30r2/8GwLAz0pAGDaaxdaV10E=;
 b=lO6E/9RqiDmEV29NdBEF/W7jDkVP82s6cOw2ecnT6qVScrNTB87IMCvd5m6xSP3HxkjFgvMEw5Ym8kLr6B24KFEC7iUTqm/WCCpC/FA7++51bP3YlSHCfYYHaSR5s1LPKA97zUoqQYW/nvDJSgw3m7yyER2TEauvivvmTP7CmpKu0f1P6VCGSDOAn4GLMZnPWbXS5FiYePrLPOmHbykr7DHHaGgBNkyS486r5h2+kd9hyn3M0LPZ5emUwTgHkllD9OfrEU6um6SJchYVZNvyIs20JLytRqoUgAed5Hz1ayQV5FP1LWdr1NiBsx/a22gsdsmbohZtfgHGT8EPVenkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xq/LOS3aeRS5ca1CJ30r2/8GwLAz0pAGDaaxdaV10E=;
 b=A19ybL3xV26qsPge4X5DfTi5uL9epU2J9PfP0yFPjaRetbcTfPGpOfB9comjS+XaDwD5G0GY7S+phjWYH+u/Lq/P2Tak5wFWsU80YtYN7VxCtPAEwRAKkXIydUknN+ci2D3kJ2ZaCadaPZCcYdT/9P4EOuowtjgXaedd0zcS+tk=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 18:43:24 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::31) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 18:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 18:43:22 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 13:43:19 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: avoid race condition of mqd when reading sdma
 counter
Date: Thu, 11 Jun 2026 14:43:03 -0400
Message-ID: <20260611184303.141724-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 378e0414-b5a7-40a3-b2a2-08dec7e950c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: gnrBeZX1mqi/EqZhyWxNrnrgZogfqbTHmq76IUHvbqH4juVTJ0PvnZDSY4gexHsmyLB4PY0m84BGfRL+uGrLDcI7pV4IzvL3pPlKB4K6k5W9ecNcBWyiSd8m/mQqmTlz900nmA3wXHA0N7Obm06Wjk5D5U+4Yh2ATK+OJAWajMM8XjQHGQPkmYP/uRtcPOxdEkYHFIsPhZoUxizJ26VvY/8MP2aCU4/R9JjGe7pPCOaVbplc6AqlxO5berDlKcAmY+GrNqYUpl4Eh46j3EHxTFx0Y/Lf9ULTM9Hhn7hwH2YSin3UETk5IuhRn3q9bxKoMnTZFuj8A9HEYXOJGpp2kxCtecid1RvxesWUkIFDn8vJ9CRdiyfGC1b18BW5LsUW6VdMVg4E9p4jQqHIHYWD/MHsBxcX4cTjIVxEeDM+5L7aif83TbATeL8OlE8+4kzMjAnwGrjHS2uxnwnP8w1B+NtNtsXmqgTXFRmc5VFIXkJsY+nW35MFZlUENcms9f70vEf+IUn5VDi7L0B6kTbtocekvFAfUXGErEDSfbFsSHAEkOAoB0PTnIwg6KVPl9ShOJixKikyBnPfeTsiDwEKwIniglpymRSPBYVXNgoGUobbUsyHUswckW81fYfGz/KWrNp/20a5CUAGE6WuOueBuatpIl5gPrvXqxXQpGRNrtqRNz+oXrLy8aQ/LUXO0eHg/NkJm4QJAle5e9Mr3vpfAOaZ0veYkkbnpO4aYr63qNc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SxvSKsVkFoFoLa3CQON5ftQNCPnDbn8vgpF1Ct3QWPTRIfLVKo1sVCcP/Q5rebRi5+qPjIAep1vdjCNMQ9EZteYAoTpB+lnuq8KTTic09WJxBjWMCPmd1jbOyI0MsO3HoGCydjw7LWAuGDQNiwPlNdT5sdC2WnVM0YvYorR80UiIcoBjGScEDWXO6QNPDgLj3enTYqxGce+ZAbZktgM1jVs4K3IhYz6gEoBLFnVVmjj85g1uMLkRikJtaca+gm/jiQZKOuKsuErLaS+fxOXnUQhGN3bn7l6GRolkud1TSvIHOLzigjTuWggFqGLi0r0lp4U7b/SHgeVVIBhJgdNJvXxPPB9QUuK2Yj3ZopKdfIbfwUmAqx1r46HsXQOlJOK3+OkZzxQmbtcQxOoJuLkaaSRvQFqpAA2nGxTvS8D5olynKXzyZzZtNSpLVzyVRPmr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:43:22.8238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e0414-b5a7-40a3-b2a2-08dec7e950c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

MQD used outside of dpm_lock is unsafe because of the queue
could be destroyed during the window of dqm_unlock, moving into
dqm_lock range is the best practice.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32 +++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e0b885b2395a..1cf689cb5e2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -91,7 +91,6 @@ struct kfd_sdma_activity_handler_workarea {
 
 struct temp_sdma_queue_list {
 	uint64_t __user *rptr;
-	void *mqd;
 	uint64_t sdma_val;
 	unsigned int queue_id;
 	struct list_head list;
@@ -154,6 +153,22 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 		    (q->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI))
 			continue;
 
+		if (KFD_GC_VERSION(dqm->dev) > IP_VERSION(9, 4, 2)) {
+			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev, q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&val) :
+			      -EOPNOTSUPP;
+
+			if (ret)
+				pr_debug("Failed to read SDMA queue active counter %i\n", ret);
+			else
+				workarea->sdma_activity_counter += val;
+
+			continue;
+		}
+
 		sdma_q = kzalloc(sizeof(struct temp_sdma_queue_list), GFP_KERNEL);
 		if (!sdma_q) {
 			dqm_unlock(dqm);
@@ -162,7 +177,6 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 		INIT_LIST_HEAD(&sdma_q->list);
 		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
-		sdma_q->mqd = q->mqd;
 		sdma_q->queue_id = q->properties.queue_id;
 		list_add_tail(&sdma_q->list, &sdma_q_list.list);
 	}
@@ -173,7 +187,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 	 * count
 	 */
 	if (list_empty(&sdma_q_list.list)) {
-		workarea->sdma_activity_counter = pdd->sdma_past_activity_counter;
+		workarea->sdma_activity_counter += pdd->sdma_past_activity_counter;
 		dqm_unlock(dqm);
 		return;
 	}
@@ -191,17 +205,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
 		val = 0;
-
-		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
-			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
-		else
-			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
-			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
-					dqm->dev->adev, sdma_q->mqd,
-					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
-					&val) :
-			      -EOPNOTSUPP;
-
+		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
 		if (ret) {
 			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
 				 sdma_q->queue_id);
-- 
2.34.1

