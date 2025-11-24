Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F6FCFD31D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBB210E1F0;
	Mon, 24 Nov 2025 08:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4utOHv1N";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4C010E1EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 08:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUGRo03KNBLAqkSe6BcqqI5zgWG6Dq/gCX34r2KH6rXyOm9mWspz8Upo7iDnHzY1B5dr4kfNT1RJLH9fHiBD4sS03WUerZi1n9gTluo49GjKVdOATCQpbJwJ4Bqv1SuTmruc5zGNiaTYjmZvjg1Z4BwOqfS12Ae7oCGZLRSCbmADagloVCIS+lh0pcNOuWQVOZAQAfyiNKiWA32rc0s5gS66SDPcMeaHYWaUPhZrxRO5dmiw65lzsIWUn0SpFS8dc4JHiGmBwwY4zQmKJea4iH5ac+bn7JzvNPomv3nNYQK63K1lhw0ZKNKdFJ1+5u+NHNBLEUkK+nGwLg0VV/Uz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC2zExCE5UltjubmQjwOjBKzhqCl53Byu7tZslG8jjI=;
 b=sqXnf1wpKa4S9shEyi97m84WbNsvAeo7ZZ060+mval51jsxsy6TbWu5L6AbwSw/mzj/ymFAUECh8cDP1HvnDPjcMmyxCKPoMzx6AsM4ifKajB2EtgvfQ4TCGeTD7AApTY6caVpZYGteGH4sPOrrlJASPnvGZQaB25C7n9DNUEvi7Z5IVF9axyAe+0OLjnYIX8Kr+Rkx7iubA26DoqsZW7AZAwv3GoNewaMHiHhxF+4vUaEUuln6xBVjQqcCU5hqUy9Lpkb7HrDuOEt76LJg/f9iDqEIrizqdNrQJHcc1Tt8jpvWpUtyNKxapf1BuymrftMgA4gn39wGvCZtztvRWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC2zExCE5UltjubmQjwOjBKzhqCl53Byu7tZslG8jjI=;
 b=4utOHv1Nrera6hqwFwWajINfTbIzoZfyqTZaX/otx3Caf4i7LgHT5L+Q7Q3BmYpSao5QMHqKA/VZcPfPMLOjhZ1n7bTZKkvWQi9JZRy/dvqal1BaqbkCt7UrmHiUTc3bZW5ACnNzc2XamiMAoRZLvjv357edyjHmE2XI7lKUVRw=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:58:49 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::94) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 08:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 08:58:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 02:58:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Clean up userq helper functions
Date: Mon, 24 Nov 2025 14:28:16 +0530
Message-ID: <20251124085821.2759840-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251124085821.2759840-1-lijo.lazar@amd.com>
References: <20251124085821.2759840-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b30bed-2250-46de-8bac-08de2b37aeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7LcxcP29d0TnmGg4YRWxH/jIM6JnuHEW0+8CJldnMRnuphrD4CeU3pmK7WYn?=
 =?us-ascii?Q?263fXK8hx/R9IPJDqQ1d7ipUEHgYdQTlNI5lss7Inyv2f1Ev4yxAzLo7FxWM?=
 =?us-ascii?Q?U1K9XN26x8Py2SQiekAsTh3763xuyqUa9dRzwbudSPXZ8rq0mVCchp3ytg9J?=
 =?us-ascii?Q?AB2ABrWL63zD4kJbzH2Anm0pyoSTl7a499QJY2+REi2Wrx7pz4/VqNvNbZBY?=
 =?us-ascii?Q?bFBC80AIyXHU4LEaBCMUNxLm3q+p8IRY20kmNfaskzpF79g/r9WXwFGjFbkj?=
 =?us-ascii?Q?3nn3Mm6WLBSXreDjeYO+CrOFb58Tf5yfQKzYIhN+jb0dwunwieCBfXteCSp0?=
 =?us-ascii?Q?/5iDefTwC8OkBgOrSGkkJ4p4vS7x74T8O1EYjZDgo3XDSxR5AGENouGo7ox3?=
 =?us-ascii?Q?qCm3+M3KVuQdeKHg5ZnuelcM/xjWx+1RgmAJ2cfDHVJAal085pOjg8XTDCdj?=
 =?us-ascii?Q?Wwa53A9+ItmYCqt2+OHRp9FLirMjuqLhRQ3lqiegdj2kz1QexBY7oLBNQnwp?=
 =?us-ascii?Q?FLLOnO++DbLx+eWhp87tgx7U+I9/K8JsnqaBccQAf/UAO7zkWph7vbu/K1FV?=
 =?us-ascii?Q?rV3H4WVXpLxeMCikzYNrdrzWnNZ0bbI8Kq1sfeDkl+IvH0zosTWhYwLQgksF?=
 =?us-ascii?Q?JqokqnXex6ATCxl60Mnig6edcWysonwj1JVglFBdWlPx54P3+QX4JwK7Ru+t?=
 =?us-ascii?Q?CF+UvMM9jhBWBwVtn+vgOCLTnrRGZIP++HPOTH+2/fDmcQhBNrF7u8wigZLt?=
 =?us-ascii?Q?kS4joVNqela8m6++I+nQwGfi7UleP6M6MC8iDcxMuglIPiJ1tjepNBNsSsyM?=
 =?us-ascii?Q?6Man2TAkZd4oy+3VvhDkYktBDkIL6M8HAcO9WQUrGcIurgtBbqpcBKFINJwG?=
 =?us-ascii?Q?Ey8geVl38VG+szlHoj10Kf28QOhnhPm9MCkWcW0t4Gha2CvpALPgr8D1yfsL?=
 =?us-ascii?Q?nXmmVRWK5M6xVp9hxo/DQq73XVpcHXhJ/UYjeafGGToNKc432U1oJnL8cZbo?=
 =?us-ascii?Q?Gi9f5PwZuXhTWuOHISn9AidjsX0FgERj/975tiwKs2CUnnrbwRyFMZttD+Ad?=
 =?us-ascii?Q?3NkHU44RKnRx1HgeyN+EwD/3h0vhsVrxhnS/Q4hB87/GlqWVPt7jqcRRla8y?=
 =?us-ascii?Q?qWbXTpYf/3HQatZV+/O8XC7EKyZj7HKNN3cNb/jnlY5TQJ5XgRcZK6UjWHFc?=
 =?us-ascii?Q?0ftPl4rBeNFjuMOwTzYRKFyeUtbgssUVM0t5/AnvMEz+zP9MW15JqQlHW0HI?=
 =?us-ascii?Q?21daHcsegwMwA5kxuioHHllAutyXEhXw+zVW+kjROTTU2uiFq+Nh+fPaHJjF?=
 =?us-ascii?Q?a8rViCVConfiXesDSQcWNg/C7aY2IZILbPTTuSktAPZ1agSucjzRm8r9pknb?=
 =?us-ascii?Q?0sfqOmNNSopwoKXU5KlsbqkfTiGDCfDRImPSAIBXc0OKpsb8DmBbZ0CGeDlI?=
 =?us-ascii?Q?lnr+QKVApLqcmorvIun0KvTMR1WjwwUowDk4vbSTqlkZnmQp4Vb8mZCy8/5D?=
 =?us-ascii?Q?r9w3XJVlGIi8AuR020j9uI0FjruL7BPPeM5itUQtl+gfsNwdEd3slXHiu9WB?=
 =?us-ascii?Q?1o+q9xsoJlrDQxViebI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:58:48.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b30bed-2250-46de-8bac-08de2b37aeb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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

Remove userq manager from function signatures. Get the associated
manager from userq itself.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 68 +++++++++++------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 923e3dc32326..f765c481aada 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -272,10 +272,9 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 	return r;
 }
 
-static int
-amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
-			  struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
@@ -298,10 +297,9 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static int
-amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
-			struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
@@ -319,10 +317,9 @@ amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
-			  struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
@@ -346,10 +343,9 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static int
-amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
-			struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
@@ -368,10 +364,9 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static int
-amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_usermode_queue *queue)
+static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct dma_fence *f = queue->last_fence;
 	int ret = 0;
 
@@ -388,11 +383,10 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	return ret;
 }
 
-static void
-amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
-		     struct amdgpu_usermode_queue *queue,
-		     int queue_id)
+static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
+				 int queue_id)
 {
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
@@ -585,7 +579,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+	amdgpu_userq_wait_for_last_fence(queue);
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
@@ -597,13 +591,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
-	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	r = amdgpu_userq_unmap_helper(queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
-	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
+	amdgpu_userq_cleanup(queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -795,7 +789,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	else
 		skip_map_queue = false;
 	if (!skip_map_queue) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			xa_erase(&uq_mgr->userq_mgr_xa, qid);
@@ -932,7 +926,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			continue;
 		}
 
-		r = amdgpu_userq_restore_helper(uq_mgr, queue);
+		r = amdgpu_userq_restore_helper(queue);
 		if (r)
 			ret = r;
 	}
@@ -1168,7 +1162,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
-		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
+		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
 	}
@@ -1270,9 +1264,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	mutex_lock(&userq_mgr->userq_mutex);
 	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
-		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
-		amdgpu_userq_unmap_helper(userq_mgr, queue);
-		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
+		amdgpu_userq_wait_for_last_fence(queue);
+		amdgpu_userq_unmap_helper(queue);
+		amdgpu_userq_cleanup(queue, queue_id);
 	}
 
 	xa_destroy(&userq_mgr->userq_mgr_xa);
@@ -1297,9 +1291,9 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		guard(mutex)(&uqm->userq_mutex);
 		amdgpu_userq_detect_and_reset_queues(uqm);
 		if (adev->in_s0ix)
-			r = amdgpu_userq_preempt_helper(uqm, queue);
+			r = amdgpu_userq_preempt_helper(queue);
 		else
-			r = amdgpu_userq_unmap_helper(uqm, queue);
+			r = amdgpu_userq_unmap_helper(queue);
 		if (r)
 			return r;
 	}
@@ -1321,9 +1315,9 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
 		if (adev->in_s0ix)
-			r = amdgpu_userq_restore_helper(uqm, queue);
+			r = amdgpu_userq_restore_helper(queue);
 		else
-			r = amdgpu_userq_map_helper(uqm, queue);
+			r = amdgpu_userq_map_helper(queue);
 		if (r)
 			return r;
 	}
@@ -1355,7 +1349,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 		    (queue->xcp_id == idx)) {
 			amdgpu_userq_detect_and_reset_queues(uqm);
-			r = amdgpu_userq_preempt_helper(uqm, queue);
+			r = amdgpu_userq_preempt_helper(queue);
 			if (r)
 				ret = r;
 		}
@@ -1387,9 +1381,9 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_restore_helper(uqm, queue);
-				if (r)
-					ret = r;
+			r = amdgpu_userq_restore_helper(queue);
+			if (r)
+				ret = r;
 			}
 		mutex_unlock(&uqm->userq_mutex);
 	}
@@ -1439,7 +1433,7 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
-			amdgpu_userq_wait_for_last_fence(uqm, queue);
+			amdgpu_userq_wait_for_last_fence(queue);
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			userq_funcs->unmap(queue);
 			/* just mark all queues as hung at this point.
-- 
2.49.0

