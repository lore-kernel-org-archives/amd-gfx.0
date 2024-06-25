Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28EC3064D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 13:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F29410E1D2;
	Tue, 25 Jun 2024 13:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r3YMoZI+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE62F10E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 13:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGAibUhVrP8FmtvS45+VJI0DWD2GmPAgFfUMiZqNyREY4UrwheLWggxw8z7qx4zoNzKYR7iQ2BBrzxFlgkgcds22Z1GPwpCCfz+YH70rAA0QdcbNtXz0AJGgiobKpVXqEs58rC+RXcsQ5ZE4SAT+McxRRmpvPit+Yt53mb4J7L3zlaQfZwFjfbXBOEo5pkYikXCZV4p+E/Mydy9/ZVVBWJbkiJvxZq4DMYOAf6ComWAu73lqFeBZG4jKyEuMp0oQ/i1Wun7J67G+bz+79AlBVYCwqIwibn7eF1F7lyFGb+iYB22dMCFLIYpGXYO2A/mkO/Lcg3AxXcoridM5u5xs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muQiyvUBKRooW7mA8wjZt/NYA+NTDk04wZjwj70dLQU=;
 b=j5N4PQxiEcOccNhuez1dwSs9Z7Yxg9tvRKwkOEXVPH/awdvmhRHSSPYpQ/jlc9DK/seBfCqDF9ozLt3ajqXRj18sMufp/rX3DQjh4AzJuOkIKcO99cqxQ6yDyEb8+D7t0O3Dv0GODFV/5MLTw3kFZ7PsCj5ohGdWHOgDxeC6S51xdfZah9+mRZasd1zk7qE3Gue3uA3P5rdmnzNfYuRjMnac8tuPqOO1sY/ZuMsUGibip79tK3qYdLmaA+VJoPj5sbooYE4qQdMImgKJxB0LJb/wlFzBUQ+E3/LyxOys3Lcmk6KddTa5Sv1d+O8lFuzR8SKJEfCjRQLR7+TlxB7IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muQiyvUBKRooW7mA8wjZt/NYA+NTDk04wZjwj70dLQU=;
 b=r3YMoZI+95pLRamqOYKoy/9fvbkwXIqZ+qWY5n9OietvvcFtDBnwUOAyXbc7lK85QRzZqAY01ddoqcRSnBFEN7822mKHxzQhpclQ5IRDsJi2bgULvDVXj9lhfzBJmoSBMuQf7sFHP3J/LNNKGax9TmE/2PzK6MtlLh5oIm7tyRU=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 13:56:38 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::87) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 13:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:56:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 08:56:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <mukul.joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Use device based logging for errors
Date: Tue, 25 Jun 2024 19:26:18 +0530
Message-ID: <20240625135618.1221391-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6fbd8a-34e4-4ba0-4cfe-08dc951ea223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|1800799021|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ULeWYE//kqxGR1a0B2OUGxpbSmBVEGrDv3x5BqtowKCbKa6+w88mRb+t24HJ?=
 =?us-ascii?Q?FtNph4IO8GrPTf2u3BBVQLDdKFtN15ARopGAwHkhVCz0JsCXJ/dXZv2xcWAW?=
 =?us-ascii?Q?KMhdrlziQUuhMLrFbM8rXKfg3TPFziV2kbgR8kLKQG7ntVutaj4yq7fuvI0E?=
 =?us-ascii?Q?+dfQkszDAZy1kfrojW7NNnn0GG6Q9mA3OnF3VwM51RlOTbygkGVMqIZauy8x?=
 =?us-ascii?Q?F2FVJrJ+pC2LrSdLMEBjr9DchfBMd7Fvtovy2fKDQBxgOLwMZtRnpqIV9mjK?=
 =?us-ascii?Q?qNJ8EZzAkeAfu8aOF8EzPYmbUrqiRSTKMLV3lqx1RUhmmgSZarNt2IdZokZZ?=
 =?us-ascii?Q?yFl7d/ovHaKillXIjzXFvhYML/PT5ItzIq7DbVBZbvvA+KFBvOiVneK/eLAz?=
 =?us-ascii?Q?DJL0j9NEr/covqvF99tH8owcNddcPpzQwha7UjAJqLDq4dT+R7t3r3o+YMW9?=
 =?us-ascii?Q?a5ymu2jzeOGsd/pLg6bgvIPOXYgerWixjwbalUfitlztpC9wHDYyyPqCA9lj?=
 =?us-ascii?Q?Wn5f06CNlE/zY6IfdaTc9yv4jLTkMyhCcyUGCG0ZUvGt85g99qvfMPj+HMRj?=
 =?us-ascii?Q?ol0s3hEQiPMkGO7Mj1XzObJys6BAhSpgbVstZOC8SlSrpROWks07wZE88mzA?=
 =?us-ascii?Q?1Y61enLNitBQWbDgLmyNkgDmM9VrvZdlOdpwRHqg8DoDKvvGppQ1XXe6ERn1?=
 =?us-ascii?Q?peOFADCKatCS3md/DBDMYUweeXHdPVfFxS5/S/IbsQ8nhbF3AVhgUfO62ith?=
 =?us-ascii?Q?S1RGzmPNZHYckC1D9GGgYYCiERBLJ/uVCH6JLo2L09FV1bQKcWQ7CN1jHR7P?=
 =?us-ascii?Q?tYoDcmpGJrJV5OKTx6QSObqhQvbm5QOUgnhd7S9qQndHuM9CopUONnCOk4rw?=
 =?us-ascii?Q?NtxILgG/ayy9/xa6SU2RxqITgN6Mmwa71c0dbWTUOhSOCcr2Fx20jqoEmB8T?=
 =?us-ascii?Q?FngUNjJbA0ZmIRHxYnTlK1s3yqxfgxtCXKdn467DhyfaDDkpVCyw3xx6eM4q?=
 =?us-ascii?Q?Ef6ZTI+7ktMelSQ3GanIB10EqmGplfhtiam9hx/4wtE0b2DBDVh1FszmqxCq?=
 =?us-ascii?Q?jcKSowmDhQkpLK/yFF0NO5rxzNBqePqCSSJDItYPJNHalDf4Yazs97EGoHT2?=
 =?us-ascii?Q?pHo041UpAcRY3BTyEbWdLMoFpO3I9TQAfhXbw8iC3mUpIAZ1OHv/oG0e/ea4?=
 =?us-ascii?Q?faxNBCAc1iSccxI3EGRNeoeHUvUuzQm7SpAqldKbNednaL7TSCu+1MS8ymA2?=
 =?us-ascii?Q?c/N42iJc8MRur/HxUG5PmuALyNe+aAHGSR9+VGujFYHMLlPBNUTPPcVMshKE?=
 =?us-ascii?Q?2ghg+ODLFM4JY71w2m7K6StTCilJUKnpu1DgR7gNgDhcT4ydHSKo89BsxR6S?=
 =?us-ascii?Q?af/y9ETtV77K3x+FthBB12BPUfCevH2JNloL6qfki5XYqYKFnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(1800799021)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:56:38.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6fbd8a-34e4-4ba0-4cfe-08dc951ea223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

Convert some pr_* to some dev_* APIs to identify the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 21 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 63 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 24 ++++---
 5 files changed, 74 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 4a64307bc438..dbcb60eb54b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -380,7 +380,8 @@ int kfd_init_apertures(struct kfd_process *process)
 
 		pdd = kfd_create_process_device_data(dev, process);
 		if (!pdd) {
-			pr_err("Failed to create process device data\n");
+			dev_err(dev->adev->dev,
+				"Failed to create process device data\n");
 			return -ENOMEM;
 		}
 		/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 3ea75a9d86ec..4843dcb9a5f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -69,7 +69,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 		break;
 	default:
-		pr_err("Invalid queue type %d\n", type);
+		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
 		return false;
 	}
 
@@ -79,13 +79,14 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	prop.doorbell_ptr = kfd_get_kernel_doorbell(dev->kfd, &prop.doorbell_off);
 
 	if (!prop.doorbell_ptr) {
-		pr_err("Failed to initialize doorbell");
+		dev_err(dev->adev->dev, "Failed to initialize doorbell");
 		goto err_get_kernel_doorbell;
 	}
 
 	retval = kfd_gtt_sa_allocate(dev, queue_size, &kq->pq);
 	if (retval != 0) {
-		pr_err("Failed to init pq queues size %d\n", queue_size);
+		dev_err(dev->adev->dev, "Failed to init pq queues size %d\n",
+			queue_size);
 		goto err_pq_allocate_vidmem;
 	}
 
@@ -341,7 +342,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 	if (kq_initialize(kq, dev, type, KFD_KERNEL_QUEUE_SIZE))
 		return kq;
 
-	pr_err("Failed to init kernel queue\n");
+	dev_err(dev->adev->dev, "Failed to init kernel queue\n");
 
 	kfree(kq);
 	return NULL;
@@ -360,26 +361,26 @@ static __attribute__((unused)) void test_kq(struct kfd_node *dev)
 	uint32_t *buffer, i;
 	int retval;
 
-	pr_err("Starting kernel queue test\n");
+	dev_err(dev->adev->dev, "Starting kernel queue test\n");
 
 	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
 	if (unlikely(!kq)) {
-		pr_err("  Failed to initialize HIQ\n");
-		pr_err("Kernel queue test failed\n");
+		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
+		dev_err(dev->adev->dev, "Kernel queue test failed\n");
 		return;
 	}
 
 	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
 	if (unlikely(retval != 0)) {
-		pr_err("  Failed to acquire packet buffer\n");
-		pr_err("Kernel queue test failed\n");
+		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
+		dev_err(dev->adev->dev, "Kernel queue test failed\n");
 		return;
 	}
 	for (i = 0; i < 5; i++)
 		buffer[i] = kq->nop_packet;
 	kq_submit_packet(kq);
 
-	pr_err("Ending kernel queue test\n");
+	dev_err(dev->adev->dev, "Ending kernel queue test\n");
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index ccfa5a0a8f6b..50a81da43ce1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -118,12 +118,14 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * attention grabbing.
 	 */
 	if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
-		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
-		       gfx_info->max_shader_engines);
+		dev_err(mm->dev->adev->dev,
+			"Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
+			gfx_info->max_shader_engines);
 		return;
 	}
 	if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
-		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+		dev_err(mm->dev->adev->dev,
+			"Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
 			gfx_info->max_sh_per_se * gfx_info->max_shader_engines);
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index a05d5c1097a8..37930629edc5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -45,7 +45,8 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
 	unsigned int max_proc_per_quantum = 1;
-	struct kfd_node *dev = pm->dqm->dev;
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 
 	process_count = pm->dqm->processes_count;
 	queue_count = pm->dqm->active_queue_count;
@@ -59,14 +60,14 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 */
 	*over_subscription = false;
 
-	if (dev->max_proc_per_quantum > 1)
-		max_proc_per_quantum = dev->max_proc_per_quantum;
+	if (node->max_proc_per_quantum > 1)
+		max_proc_per_quantum = node->max_proc_per_quantum;
 
 	if ((process_count > max_proc_per_quantum) ||
 	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
 	    gws_queue_count > 1) {
 		*over_subscription = true;
-		pr_debug("Over subscribed runlist\n");
+		dev_dbg(dev, "Over subscribed runlist\n");
 	}
 
 	map_queue_size = pm->pmf->map_queues_size;
@@ -81,7 +82,7 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	if (*over_subscription)
 		*rlib_size += pm->pmf->runlist_size;
 
-	pr_debug("runlist ib size %d\n", *rlib_size);
+	dev_dbg(dev, "runlist ib size %d\n", *rlib_size);
 }
 
 static int pm_allocate_runlist_ib(struct packet_manager *pm,
@@ -90,6 +91,8 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int *rl_buffer_size,
 				bool *is_over_subscription)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	int retval;
 
 	if (WARN_ON(pm->allocated))
@@ -99,11 +102,10 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 
 	mutex_lock(&pm->lock);
 
-	retval = kfd_gtt_sa_allocate(pm->dqm->dev, *rl_buffer_size,
-					&pm->ib_buffer_obj);
+	retval = kfd_gtt_sa_allocate(node, *rl_buffer_size, &pm->ib_buffer_obj);
 
 	if (retval) {
-		pr_err("Failed to allocate runlist IB\n");
+		dev_err(dev, "Failed to allocate runlist IB\n");
 		goto out;
 	}
 
@@ -125,6 +127,8 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 {
 	unsigned int alloc_size_bytes;
 	unsigned int *rl_buffer, rl_wptr, i;
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	int retval, processes_mapped;
 	struct device_process_node *cur;
 	struct qcm_process_device *qpd;
@@ -142,7 +146,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	*rl_size_bytes = alloc_size_bytes;
 	pm->ib_size_bytes = alloc_size_bytes;
 
-	pr_debug("Building runlist ib process count: %d queues count %d\n",
+	dev_dbg(dev, "Building runlist ib process count: %d queues count %d\n",
 		pm->dqm->processes_count, pm->dqm->active_queue_count);
 
 	/* build the run list ib packet */
@@ -150,7 +154,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 		qpd = cur->qpd;
 		/* build map process packet */
 		if (processes_mapped >= pm->dqm->processes_count) {
-			pr_debug("Not enough space left in runlist IB\n");
+			dev_dbg(dev, "Not enough space left in runlist IB\n");
 			pm_release_ib(pm);
 			return -ENOMEM;
 		}
@@ -167,7 +171,8 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 			if (!kq->queue->properties.is_active)
 				continue;
 
-			pr_debug("static_queue, mapping kernel q %d, is debug status %d\n",
+			dev_dbg(dev,
+				"static_queue, mapping kernel q %d, is debug status %d\n",
 				kq->queue->queue, qpd->is_debug);
 
 			retval = pm->pmf->map_queues(pm,
@@ -186,7 +191,8 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 			if (!q->properties.is_active)
 				continue;
 
-			pr_debug("static_queue, mapping user queue %d, is debug status %d\n",
+			dev_dbg(dev,
+				"static_queue, mapping user queue %d, is debug status %d\n",
 				q->queue, qpd->is_debug);
 
 			retval = pm->pmf->map_queues(pm,
@@ -203,11 +209,13 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 		}
 	}
 
-	pr_debug("Finished map process and queues to runlist\n");
+	dev_dbg(dev, "Finished map process and queues to runlist\n");
 
 	if (is_over_subscription) {
 		if (!pm->is_over_subscription)
-			pr_warn("Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
+			dev_warn(
+				dev,
+				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
 		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
@@ -273,6 +281,8 @@ void pm_uninit(struct packet_manager *pm)
 int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	uint32_t *buffer, size;
 	int retval = 0;
 
@@ -282,7 +292,7 @@ int pm_send_set_resources(struct packet_manager *pm,
 					size / sizeof(uint32_t),
 					(unsigned int **)&buffer);
 	if (!buffer) {
-		pr_err("Failed to allocate buffer on kernel queue\n");
+		dev_err(dev, "Failed to allocate buffer on kernel queue\n");
 		retval = -ENOMEM;
 		goto out;
 	}
@@ -344,6 +354,8 @@ int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues)
 int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 			uint64_t fence_value)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	uint32_t *buffer, size;
 	int retval = 0;
 
@@ -355,7 +367,7 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 	kq_acquire_packet_buffer(pm->priv_queue,
 			size / sizeof(uint32_t), (unsigned int **)&buffer);
 	if (!buffer) {
-		pr_err("Failed to allocate buffer on kernel queue\n");
+		dev_err(dev, "Failed to allocate buffer on kernel queue\n");
 		retval = -ENOMEM;
 		goto out;
 	}
@@ -373,6 +385,8 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 
 int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	int retval = 0;
 	uint32_t *buffer, size;
 
@@ -386,7 +400,8 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 			(unsigned int **)&buffer);
 
 		if (!buffer) {
-			pr_err("Failed to allocate buffer on kernel queue\n");
+			dev_err(dev,
+				"Failed to allocate buffer on kernel queue\n");
 			retval = -ENOMEM;
 			goto out;
 		}
@@ -407,6 +422,8 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 			enum kfd_unmap_queues_filter filter,
 			uint32_t filter_param, bool reset)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	uint32_t *buffer, size;
 	int retval = 0;
 
@@ -415,7 +432,7 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 	kq_acquire_packet_buffer(pm->priv_queue,
 			size / sizeof(uint32_t), (unsigned int **)&buffer);
 	if (!buffer) {
-		pr_err("Failed to allocate buffer on kernel queue\n");
+		dev_err(dev, "Failed to allocate buffer on kernel queue\n");
 		retval = -ENOMEM;
 		goto out;
 	}
@@ -464,6 +481,8 @@ int pm_debugfs_runlist(struct seq_file *m, void *data)
 
 int pm_debugfs_hang_hws(struct packet_manager *pm)
 {
+	struct kfd_node *node = pm->dqm->dev;
+	struct device *dev = node->adev->dev;
 	uint32_t *buffer, size;
 	int r = 0;
 
@@ -475,16 +494,16 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
 	kq_acquire_packet_buffer(pm->priv_queue,
 			size / sizeof(uint32_t), (unsigned int **)&buffer);
 	if (!buffer) {
-		pr_err("Failed to allocate buffer on kernel queue\n");
+		dev_err(dev, "Failed to allocate buffer on kernel queue\n");
 		r = -ENOMEM;
 		goto out;
 	}
 	memset(buffer, 0x55, size);
 	kq_submit_packet(pm->priv_queue);
 
-	pr_info("Submitting %x %x %x %x %x %x %x to HIQ to hang the HWS.",
-		buffer[0], buffer[1], buffer[2], buffer[3],
-		buffer[4], buffer[5], buffer[6]);
+	dev_info(dev, "Submitting %x %x %x %x %x %x %x to HIQ to hang the HWS.",
+		 buffer[0], buffer[1], buffer[2], buffer[3], buffer[4],
+		 buffer[5], buffer[6]);
 out:
 	mutex_unlock(&pm->lock);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6251f37c312a..17e42161b015 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1311,7 +1311,8 @@ int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 		if (IS_ERR_VALUE(qpd->tba_addr)) {
 			int err = qpd->tba_addr;
 
-			pr_err("Failure to set tba address. error %d.\n", err);
+			dev_err(dev->adev->dev,
+				"Failure to set tba address. error %d.\n", err);
 			qpd->tba_addr = 0;
 			qpd->cwsr_kaddr = NULL;
 			return err;
@@ -1611,7 +1612,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 						&pdd->proc_ctx_cpu_ptr,
 						false);
 		if (retval) {
-			pr_err("failed to allocate process context bo\n");
+			dev_err(dev->adev->dev,
+				"failed to allocate process context bo\n");
 			goto err_free_pdd;
 		}
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
@@ -1676,7 +1678,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 						     &p->kgd_process_info,
 						     &ef);
 	if (ret) {
-		pr_err("Failed to create process VM object\n");
+		dev_err(dev->adev->dev, "Failed to create process VM object\n");
 		return ret;
 	}
 	RCU_INIT_POINTER(p->ef, ef);
@@ -1723,7 +1725,7 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 
 	pdd = kfd_get_process_device_data(dev, p);
 	if (!pdd) {
-		pr_err("Process device data doesn't exist\n");
+		dev_err(dev->adev->dev, "Process device data doesn't exist\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1833,6 +1835,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
+		struct device *dev = pdd->dev->adev->dev;
 
 		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
 					     trigger);
@@ -1844,7 +1847,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 		 * them been add back since they actually not be saved right now.
 		 */
 		if (r && r != -EIO) {
-			pr_err("Failed to evict process queues\n");
+			dev_err(dev, "Failed to evict process queues\n");
 			goto fail;
 		}
 		n_evicted++;
@@ -1866,7 +1869,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
 
 		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd))
-			pr_err("Failed to restore queues\n");
+			dev_err(pdd->dev->adev->dev,
+				"Failed to restore queues\n");
 
 		n_evicted--;
 	}
@@ -1882,13 +1886,14 @@ int kfd_process_restore_queues(struct kfd_process *p)
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
+		struct device *dev = pdd->dev->adev->dev;
 
 		kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
 
 		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
 							      &pdd->qpd);
 		if (r) {
-			pr_err("Failed to restore process queues\n");
+			dev_err(dev, "Failed to restore process queues\n");
 			if (!ret)
 				ret = r;
 		}
@@ -2065,7 +2070,7 @@ int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 	struct qcm_process_device *qpd;
 
 	if ((vma->vm_end - vma->vm_start) != KFD_CWSR_TBA_TMA_SIZE) {
-		pr_err("Incorrect CWSR mapping size.\n");
+		dev_err(dev->adev->dev, "Incorrect CWSR mapping size.\n");
 		return -EINVAL;
 	}
 
@@ -2077,7 +2082,8 @@ int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 	qpd->cwsr_kaddr = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					get_order(KFD_CWSR_TBA_TMA_SIZE));
 	if (!qpd->cwsr_kaddr) {
-		pr_err("Error allocating per process CWSR buffer.\n");
+		dev_err(dev->adev->dev,
+			"Error allocating per process CWSR buffer.\n");
 		return -ENOMEM;
 	}
 
-- 
2.25.1

