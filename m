Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE21D42BBA
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 18:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7D010E610;
	Tue, 12 Nov 2024 18:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vKFa8hTH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B8B10E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 18:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dURh3BZIjIobmhxDcuAA0nmweuS5HtERJXGlu6SwWqN45SnqfH3tZD+gpRj7lAJlTCCz6BiLhF5NeAGxPA2ndmnxH8pzx4cnrzB+fptxTnu/FpYXHZrOiEiv6HyaZ7b75YqQ1qwih8qw8NpIOvHiXwOH4kG/qynDIhrWmKFSvzFEMb1o2mUB30IC44w6V07y3ju65/S3uAJO4ExEEEsf4ps75/r+4jS9fvpvSk/vv76JhC5uAEtgLPxwe1k/LcMuK+F4P1AMHUPo0CdEAKPEZG2l07htYtvF9W9BENe89xAjNBE8sHTd4/GRFO1xV49un94FfnXnfaIpCfdt4Zxj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwdWhcrhopxZAAwzONyWGMxk95vQYQaJs0VoAEPfhio=;
 b=N+6lZsVJkRXheQJudKFgR4qjfQOS9hZ5dmKCVdK9jQ+XjGvVjxFue6wZ6l2pltqE0EqI3ObSx6SRYoxNDhR6L2pwXqyzlaJpMLPUaJ6hwI47Akqhk4/LQsDwoDZc8x0luI3O0FUv1w9WQGO/QJoI+ZpIcXL+GT29tfAZnc4gEd/7uiMntZO7nYO56CvG9VoItezzpH7hxZR2SnexaSz0JbgoxvQ1KLeb01GwyD22JCqinxskvXX1M5D70IsDE207dBXA6AIjGbXMehHOklMsbl0/EGXoYOMKEpSmjZdVoji7c309iAqNiMdBe4BHee1JOLzf5cjnDhaau63D+HReYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwdWhcrhopxZAAwzONyWGMxk95vQYQaJs0VoAEPfhio=;
 b=vKFa8hTHV3kmdH2GTCCKAKnej7sJPcXlUqL956UoSkqg46hZQbYQjYRd/luEKkueQI5jEBNr53Pq53wo0Xpa/JB8qMobUXDwHASB/wlPTCIHZJaQRU5dBPmvJberc5f+get52CvMdVfswrYitisG3XgHJ4+Fu3Rky5Ld7WLQOZQ=
Received: from SA0PR11CA0198.namprd11.prod.outlook.com (2603:10b6:806:1bc::23)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 18:22:34 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::49) by SA0PR11CA0198.outlook.office365.com
 (2603:10b6:806:1bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 18:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 18:22:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 12:22:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 12:22:33 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 12:22:33 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Differentiate logging message for driver
 oversubscription
Date: Tue, 12 Nov 2024 12:25:49 -0600
Message-ID: <20241112182549.88964-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b1fcdd-f089-40d4-7728-08dd0346faa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y5ZQOdArSywcnWKwjk5u3E/eaDNMvINeg067CQnDAmy2+79ghPuWm08FPl2E?=
 =?us-ascii?Q?kRYd37eCFFAORNSsB06FNd0fTKUNEdrzGk4/TodOqPHMgMcM+2pExuMhO35/?=
 =?us-ascii?Q?pYkBjYCifaSfSuy6K234OOgcs9GqIUITcJr/vmbH3BrRdkKq10gVSB2UCt2V?=
 =?us-ascii?Q?ZjFcXAAXYYnMzz92RmwubFv+bEYFa4ULO9Rn78Mu0jNavytTMQOjIoUh8dtv?=
 =?us-ascii?Q?aN8uNNOQFWCKWl9//AXpCXouZsqzCCgYkzJUZHuOS+zp0kUS64EJo2fT0og6?=
 =?us-ascii?Q?t4yURirTTeX2KX2d/6hccrVOnjoH6aXAEsAbZ7SCPoWKMObkemkCmp2Atw/g?=
 =?us-ascii?Q?DvcUYbymvTAGQzxWbe2YblBmMxL5z1MMg6RynuE8o360AVssU4Rbe5T/t9Ov?=
 =?us-ascii?Q?/Rhu6V3Gxk/WEk7AAf7RHUhMSyAyR0J4bdHUjye1clSjVJ56diEFHHQP/QgY?=
 =?us-ascii?Q?ZaluZEmmhMxfHkHbLx8ny6fMNC/AiXGBTs3/s6MaRaeQbSy/DfFKt3F34k0K?=
 =?us-ascii?Q?cihVSiUehPB2DRDQ333R/YVJUx1TkMENY7zcj4ZmvtyCbNdTYb5WbJuA30Yu?=
 =?us-ascii?Q?JJPwxWulakkDtZmShIGXzSYMiOCS9wCCcCp9EW83H6VgkadK3LVSJtKSOMtD?=
 =?us-ascii?Q?0TuQxyXi3kPL/AZCjdaLuYz0dbwnjXd0JlgdTLyvkaljqg3e0X0DLU9gcU7b?=
 =?us-ascii?Q?WzM7J1IobnuvO/NoIdOEuGPPAmRhScqIUpwsiBK6o3lU/5DKBhDLVbcFFmoD?=
 =?us-ascii?Q?YJ7IFktTYcJbUFXwxItkhMFbf7K2ez71g0mhiq0RdczrclpwD5+EHPXA/Rig?=
 =?us-ascii?Q?kg9lQ2Hl/S9vd2bXtqQV3uuYdSR9rh/ZG110S7s+eBg6a0Vj7eMbaUXv567U?=
 =?us-ascii?Q?prJnEQkecJVuXP8Hob/vrcYDTGpaXd0lebYPp+8e3KSuiyaT60gMKPC27jee?=
 =?us-ascii?Q?MLRwt9qCfsExSNyS4u95ry6dkuvWSwxEF0I4PRH+P3m22B6fNaBjmLjkMk7M?=
 =?us-ascii?Q?0+A4ytsdURSaYCPEZXtgh2DmGu5PeaHwY6b44lsArMPvjO9CqySH6nrm1lXr?=
 =?us-ascii?Q?MPUvJcRjsV2DpOwIPcv2mOCwybRVIizvtmJW4qmNEFai+HVcQymSYEUwwvSh?=
 =?us-ascii?Q?MZzpA2Vsu/NFaQY0Y4yYJLy5taNpKwt0BLtYTgL2/J5UUNoZjlLFMUNQaUWi?=
 =?us-ascii?Q?VQq1o9c/S44zzCB7gdfRjIdSs80PkXbgJaFs+FquWVh30gkAN36fudNr4xIT?=
 =?us-ascii?Q?PpXZmwNosD/sOnYrw2+7Mmch6OskmDYv0u9KDAAeQDB9qf3lpJtr9wOfVQdf?=
 =?us-ascii?Q?rxh0O6jRTLAwo/ljbpEv8hX2xaD7O9QTrwzt8EKJ/Kitb4kO4FdzUD4zWayW?=
 =?us-ascii?Q?0l0gmUMmRVbsB18mtgaGJ6XVRBi2sfDR/RA7zgwbhnp7MmbV3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 18:22:34.3570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b1fcdd-f089-40d4-7728-08dd0346faa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

To have user better understand the causes triggering runlist oversubscription.
No function change.

Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..1848578dd5a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include "kfd_kernel_queue.h"
 #include "kfd_priv.h"
 
+#define OVER_SUBSCRIPTION_PROCESS_COUNT (1 << 0)
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 << 1)
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 << 2)
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				bool *over_subscription)
+				int *over_subscription)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	*over_subscription = false;
+	*over_subscription = 0;
 
 	if (node->max_proc_per_quantum > 1)
 		max_proc_per_quantum = node->max_proc_per_quantum;
 
-	if ((process_count > max_proc_per_quantum) ||
-	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
-	    gws_queue_count > 1) {
-		*over_subscription = true;
+	if (process_count > max_proc_per_quantum)
+		*over_subscription |= OVER_SUBSCRIPTION_PROCESS_COUNT;
+	if (compute_queue_count > get_cp_queues_num(pm->dqm))
+		*over_subscription |= OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
+	if (gws_queue_count > 1)
+		*over_subscription |= OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+	if (*over_subscription)
 		dev_dbg(dev, "Over subscribed runlist\n");
-	}
 
 	map_queue_size = pm->pmf->map_queues_size;
 	/* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				bool *is_over_subscription)
+				int *is_over_subscription)
 {
 	struct kfd_node *node = pm->dqm->dev;
 	struct device *dev = node->adev->dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
-	bool is_over_subscription;
+	int is_over_subscription;
 
 	rl_wptr = retval = processes_mapped = 0;
 
@@ -212,16 +219,25 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, "Finished map process and queues to runlist\n");
 
 	if (is_over_subscription) {
-		if (!pm->is_over_subscription)
-			dev_warn(
-				dev,
-				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
+		if (!pm->is_over_subscription) {
+
+			dev_warn(dev, "Runlist is getting oversubscribed due to%s%s%s."
+				" Expect reduced ROCm performance.\n",
+				is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ?
+				" number of processes more than maximum number of processes"
+				" that HWS can schedule concurrently." : "",
+				is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ?
+				" number of queues is more than assigned compute queues." : "",
+				is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ?
+				" cooperative launch is more than allowed." : "");
+
+		}
 		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
 					true);
 	}
-	pm->is_over_subscription = is_over_subscription;
+	pm->is_over_subscription = is_over_subscription ? true : false;
 
 	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
 		pr_debug("0x%2X ", rl_buffer[i]);
-- 
2.25.1

