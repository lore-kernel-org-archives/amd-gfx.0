Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDD5C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760D6112465;
	Tue, 28 May 2024 17:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYVfteCr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2B910FD7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6rcG5zQQK4MUqxuYU6jhfg1+7ODL0aYAgZUOYHdALrEm+UQpdDMje8OV5lnnh0G2VfgtrBttT31rBYVTpwk1EJ/wfQqfdXD1y5IG9hIoiZ7wR1Bd3qPvQXgWszIkVqc2OylAXccYyF2M0eOsB9oFI/m5MoK0DCg1ibOrVJSgmChhwXpaPuVuTyBsmJ0LUC5uqnV1BEXQUH7hsFAV6vhl8gRMq6T10b9MuRX+cP1uUJ5NR6zwINCr0ZgoXGqeW/faD0n+/ItH50+HLoae5E4hPprPyZTH/TVsRv/1vJ7rCI2o3y3VKXJQJX1k3klVx3A32XPJvvW7ViY87WLw0Zozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7nOdqw7wONQVrORLQPZmYE5S7BLcb4bHPO62af3JAU=;
 b=NgNYIeyWAlCQ9lsPpfSk1QfcbENhh+Fbwg5/RdD55Zw1fj0IqBRtyaivjDt0Wmx1MRPtXqYrvLyiOKk6aThcJphzq5olv7hMO3ytlS1bJg0bWidNrNID6C+SCRwnIolebY4FMmq9NS+paasAVywiZarXWnsf0lS55L/nItkWumDJoYFs/wvJrZGjPWoW6ct9aKqbJr9e1ic8SrjxxMLdiAkKKMRm3avzABpVXsWtcfy1Z1VlQVgPLXa98h0zyKneRcg4ChO/r+0LLwBy3e8y0Pp0/g56RtISfGHRdN3I4E0IPlOs+HzCRx9jFe6v9qumywy5LGgzMPDVzSmF+KhA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7nOdqw7wONQVrORLQPZmYE5S7BLcb4bHPO62af3JAU=;
 b=GYVfteCrErrwYX4puDxQSiABqmhrNZ91DLUpoAYsOTEUqiV/v7y/3+w5H2KUmyg3pG+Jr1uJzik3978tJPglUA9T5YFAV29kQ6CqNZjiyy6GuL1a213ka2Q+XhSjBjGTFd/N3sqLWD1Lk690ybOjEoQ3JXUQ9eBAtbU0qldsXVs=
Received: from PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::30)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 17:24:17 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132E9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 17:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:16 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:11 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 04/10] drm/amdgpu/kfd: remove is_hws_hang and is_resetting
Date: Tue, 28 May 2024 13:23:34 -0400
Message-ID: <20240528172340.34517-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: a5025e4b-f037-4b87-1b64-08dc7f3b0050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6iMsu5ghbXuukSJg0xlUSQRsmDu1aX8Ag+dzCwUMqA3sygAd/nZeFY7gziZ?=
 =?us-ascii?Q?ZfZ+9DbKXrF75rGbSjXQpoyNCqx3uhrNq/tvatHyBfXRD8I626a3628WLr7p?=
 =?us-ascii?Q?cER7HJNWjSJAIBlUeBGWhaqsR/Nzm1WIDFcM5VgRet9SRQ1J19aCie1C3nXY?=
 =?us-ascii?Q?CFQozPGnJmm/Supuy6M7eGXsM5nFa3TMC/XdP8l436zWIlJl1mZFJHPSiyrg?=
 =?us-ascii?Q?CA2wTFI6tjQI4I38TBTpaPf6a8t4GKZUUbwS8yVO3LZMF/eUzo+xPXZw0/Cb?=
 =?us-ascii?Q?GmpudqaSMXHm/xgR0+GAbZ1bivhnk4sQeTDrr0TjhgDlNM5NnhqhvbBEMChZ?=
 =?us-ascii?Q?p9e8ZTlVRCT+lrg/O4Vks6f4MlZP5YxLDmmbPbOc50ZSF5TxBfQDszxkgERC?=
 =?us-ascii?Q?MZlak8vQUtWVzhh7avsdqIi6jnRaq07MCxgQTkRJsM+5Hi+r33Ba1A3me2T/?=
 =?us-ascii?Q?1+Y2/0sPgrm+DXlo6WLkEgKNxyw+2Ruh7dkNQKHXSzc15j/ehV+t84pRnBqF?=
 =?us-ascii?Q?4laivqa6EKgp7dRh37CCKYWmbBYUcttvj3HY6w+IJWpQNTgs/+SxoGfioujp?=
 =?us-ascii?Q?SO/7Te2+EiNmBzOCfLpjGRhfg4xSXBC83LnS9buf0QGDR5nqp+P6JuDTDJ7g?=
 =?us-ascii?Q?VJ/izEOo+NzJ+njJDoOTusLwXAyJa2u1us4hwQb/pTKiGiAeooMWTHfnombW?=
 =?us-ascii?Q?c2+9TP5yc5CgMinrfmAQUBZ3qCPfEoYAh66oIPi5zryYK2MCe4ge9/cgD0av?=
 =?us-ascii?Q?tuFpY2eU/raiNN+uCR31PwbqVZWDUgaTjyIZlgjzDvp07kuEfKS98TmOkSJW?=
 =?us-ascii?Q?40avZdB/Os0RMoMb5QW7efRI8H91LORgUz8j+ico7Vspew3/WWGpBWdEmQmv?=
 =?us-ascii?Q?/OpDWZS8tW4j0ZgXj4649KrWV4kHCYII4e8Vw4kLqzQOiecNcy30W3DLGVS8?=
 =?us-ascii?Q?8WRpM0hCu9j4w3y30V+NV3Y224uDjpdUKo8SXUSxCOUTEDsCktsdMQ7hgGAV?=
 =?us-ascii?Q?B5bV8UBihCNl6K/SsUNTy0LeFovyQwH4+wV/1i0a3SgmlfMqL7q3TtOWHTh/?=
 =?us-ascii?Q?bM0v1aFesoW5OaXzVj3teTw8kbDrD0nI1s8/vfDRMEiLHe9lRtec8By5IhrE?=
 =?us-ascii?Q?ivxI/Sj+hEhaWFz/NVCj8Po4gGNBqT0YpJrVLfOTzlE2hoRvXLd5H//+3LwB?=
 =?us-ascii?Q?w+st8aVpuPEpCqT1Xr/o8zqlEDgViYM2YUzcdz40JVw+pK7YCYZansbZsn7H?=
 =?us-ascii?Q?PWv5RG2r24KC2Hx9emwCi5gsHLCgABjqhCQzH+HiYRQfRSHzzC0bjc6OY8ai?=
 =?us-ascii?Q?ND44XJjAHJZCfBYGYuq3DiGWCvF2UeUlzdHCfm2kr+lJ75jW9Aun/bOftlSj?=
 =?us-ascii?Q?t/4rXQ3taZ/uIXQix91H0G+y683H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:16.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5025e4b-f037-4b87-1b64-08dc7f3b0050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

is_hws_hang and is_resetting serves pretty much the same purpose and
they all duplicates the work of the reset_domain lock, just check that
directly instead. This also eliminate a few bugs listed below and get
rid of dqm->ops.pre_reset.

kfd_hws_hang did not need to avoid scheduling another reset. If the
on-going reset decided to skip GPU reset we have a bad time, otherwise
the extra reset will get cancelled anyway.

remove_queue_mes forgot to check is_resetting flag compared to the
pre-MES path unmap_queue_cpsch, so it did not block hw access during
reset correctly.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  4 +-
 7 files changed, 45 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fba9b9a258a5..3e0f46d60de5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -935,7 +935,6 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		kfd_smi_event_update_gpu_reset(node, false);
-		node->dqm->ops.pre_reset(node->dqm);
 	}
 
 	kgd2kfd_suspend(kfd, false);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4721b2fccd06..3a2dc31279a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -35,6 +35,7 @@
 #include "cik_regs.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 #include "mes_api_def.h"
 #include "kfd_debug.h"
 
@@ -155,14 +156,7 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
 	/*
 	 * Issue a GPU reset if HWS is unresponsive
 	 */
-	dqm->is_hws_hang = true;
-
-	/* It's possible we're detecting a HWS hang in the
-	 * middle of a GPU reset. No need to schedule another
-	 * reset in this case.
-	 */
-	if (!dqm->is_resetting)
-		schedule_work(&dqm->hw_exception_work);
+	schedule_work(&dqm->hw_exception_work);
 }
 
 static int convert_to_mes_queue_type(int queue_type)
@@ -194,7 +188,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r, queue_type;
 	uint64_t wptr_addr_off;
 
-	if (dqm->is_hws_hang)
+	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
@@ -245,6 +239,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
+	up_read(&adev->reset_domain->sem);
 	if (r) {
 		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
@@ -262,7 +257,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r;
 	struct mes_remove_queue_input queue_input;
 
-	if (dqm->is_hws_hang)
+	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
@@ -272,6 +267,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
+	up_read(&adev->reset_domain->sem);
 
 	if (r) {
 		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
@@ -1468,20 +1464,13 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
 	}
 
 	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
-		pm_uninit(&dqm->packet_mgr, false);
+		pm_uninit(&dqm->packet_mgr);
 	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
 	return 0;
 }
 
-static void pre_reset(struct device_queue_manager *dqm)
-{
-	dqm_lock(dqm);
-	dqm->is_resetting = true;
-	dqm_unlock(dqm);
-}
-
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id)
 {
@@ -1669,8 +1658,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	init_interrupts(dqm);
 
 	/* clear hang status when driver try to start the hw scheduler */
-	dqm->is_hws_hang = false;
-	dqm->is_resetting = false;
 	dqm->sched_running = true;
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
@@ -1700,7 +1687,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 fail_allocate_vidmem:
 fail_set_sched_resources:
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		pm_uninit(&dqm->packet_mgr, false);
+		pm_uninit(&dqm->packet_mgr);
 fail_packet_manager_init:
 	dqm_unlock(dqm);
 	return retval;
@@ -1708,22 +1695,17 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 static int stop_cpsch(struct device_queue_manager *dqm)
 {
-	bool hanging;
-
 	dqm_lock(dqm);
 	if (!dqm->sched_running) {
 		dqm_unlock(dqm);
 		return 0;
 	}
 
-	if (!dqm->is_hws_hang) {
-		if (!dqm->dev->kfd->shared_resources.enable_mes)
-			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
-		else
-			remove_all_queues_mes(dqm);
-	}
+	if (!dqm->dev->kfd->shared_resources.enable_mes)
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+	else
+		remove_all_queues_mes(dqm);
 
-	hanging = dqm->is_hws_hang || dqm->is_resetting;
 	dqm->sched_running = false;
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
@@ -1731,7 +1713,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		pm_uninit(&dqm->packet_mgr, hanging);
+		pm_uninit(&dqm->packet_mgr);
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1957,24 +1939,24 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 {
 	struct device *dev = dqm->dev->adev->dev;
 	struct mqd_manager *mqd_mgr;
-	int retval = 0;
+	int retval;
 
 	if (!dqm->sched_running)
 		return 0;
-	if (dqm->is_hws_hang || dqm->is_resetting)
-		return -EIO;
 	if (!dqm->active_runlist)
-		return retval;
+		return 0;
+	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
+		return -EIO;
 
 	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
 		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
 		if (retval)
-			return retval;
+			goto out;
 	}
 
 	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
 	if (retval)
-		return retval;
+		goto out;
 
 	*dqm->fence_addr = KFD_FENCE_INIT;
 	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
@@ -1985,7 +1967,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (retval) {
 		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
 		kfd_hws_hang(dqm);
-		return retval;
+		goto out;
 	}
 
 	/* In the current MEC firmware implementation, if compute queue
@@ -2001,7 +1983,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		while (halt_if_hws_hang)
 			schedule();
 		kfd_hws_hang(dqm);
-		return -ETIME;
+		retval = -ETIME;
+		goto out;
 	}
 
 	/* We need to reset the grace period value for this device */
@@ -2014,6 +1997,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	pm_release_ib(&dqm->packet_mgr);
 	dqm->active_runlist = false;
 
+out:
+	up_read(&dqm->dev->adev->reset_domain->sem);
 	return retval;
 }
 
@@ -2040,13 +2025,13 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 {
 	int retval;
 
-	if (dqm->is_hws_hang)
+	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
 		return -EIO;
 	retval = unmap_queues_cpsch(dqm, filter, filter_param, grace_period, false);
-	if (retval)
-		return retval;
-
-	return map_queues_cpsch(dqm);
+	if (!retval)
+		retval = map_queues_cpsch(dqm);
+	up_read(&dqm->dev->adev->reset_domain->sem);
+	return retval;
 }
 
 static int wait_on_destroy_queue(struct device_queue_manager *dqm,
@@ -2427,10 +2412,12 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
 
-	if ((!dqm->is_hws_hang) && (retval || qpd->reset_wavefronts)) {
+	if ((retval || qpd->reset_wavefronts) &&
+	    down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
 		pr_warn("Resetting wave fronts (cpsch) on dev %p\n", dqm->dev);
 		dbgdev_wave_reset_wavefronts(dqm->dev, qpd->pqm->process);
 		qpd->reset_wavefronts = false;
+		up_read(&dqm->dev->adev->reset_domain->sem);
 	}
 
 	/* Lastly, free mqd resources.
@@ -2537,7 +2524,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.initialize = initialize_cpsch;
 		dqm->ops.start = start_cpsch;
 		dqm->ops.stop = stop_cpsch;
-		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.destroy_queue = destroy_queue_cpsch;
 		dqm->ops.update_queue = update_queue;
 		dqm->ops.register_process = register_process;
@@ -2558,7 +2544,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		/* initialize dqm for no cp scheduling */
 		dqm->ops.start = start_nocpsch;
 		dqm->ops.stop = stop_nocpsch;
-		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.create_queue = create_queue_nocpsch;
 		dqm->ops.destroy_queue = destroy_queue_nocpsch;
 		dqm->ops.update_queue = update_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index fcc0ee67f544..3b9b8eabaacc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -152,7 +152,6 @@ struct device_queue_manager_ops {
 	int	(*initialize)(struct device_queue_manager *dqm);
 	int	(*start)(struct device_queue_manager *dqm);
 	int	(*stop)(struct device_queue_manager *dqm);
-	void	(*pre_reset)(struct device_queue_manager *dqm);
 	void	(*uninitialize)(struct device_queue_manager *dqm);
 	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
 					struct kernel_queue *kq,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 32c926986dbb..3ea75a9d86ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -32,6 +32,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers.h"
 #include "kfd_pm4_opcodes.h"
+#include "amdgpu_reset.h"
 
 #define PM4_COUNT_ZERO (((1 << 15) - 1) << 16)
 
@@ -196,15 +197,17 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 }
 
 /* Uninitialize a kernel queue and free all its memory usages. */
-static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
+static void kq_uninitialize(struct kernel_queue *kq)
 {
-	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
+	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && down_read_trylock(&kq->dev->adev->reset_domain->sem)) {
 		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
 					kq->queue->mqd,
 					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
 					KFD_UNMAP_LATENCY_MS,
 					kq->queue->pipe,
 					kq->queue->queue);
+		up_read(&kq->dev->adev->reset_domain->sem);
+	}
 	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
 		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
 
@@ -344,9 +347,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 	return NULL;
 }
 
-void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
+void kernel_queue_uninit(struct kernel_queue *kq)
 {
-	kq_uninitialize(kq, hanging);
+	kq_uninitialize(kq);
 	kfree(kq);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 7332ad94eab8..a05d5c1097a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -263,10 +263,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	return 0;
 }
 
-void pm_uninit(struct packet_manager *pm, bool hanging)
+void pm_uninit(struct packet_manager *pm)
 {
 	mutex_destroy(&pm->lock);
-	kernel_queue_uninit(pm->priv_queue, hanging);
+	kernel_queue_uninit(pm->priv_queue);
 	pm->priv_queue = NULL;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..2b3ec92981e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1301,7 +1301,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
 void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 					enum kfd_queue_type type);
-void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
+void kernel_queue_uninit(struct kernel_queue *kq);
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
 
 /* Process Queue Manager */
@@ -1407,7 +1407,7 @@ extern const struct packet_manager_funcs kfd_v9_pm_funcs;
 extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
-void pm_uninit(struct packet_manager *pm, bool hanging);
+void pm_uninit(struct packet_manager *pm);
 int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6bf79c435f2e..86ea610b16f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -434,7 +434,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 err_create_queue:
 	uninit_queue(q);
 	if (kq)
-		kernel_queue_uninit(kq, false);
+		kernel_queue_uninit(kq);
 	kfree(pqn);
 err_allocate_pqn:
 	/* check if queues list is empty unregister process from device */
@@ -481,7 +481,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		/* destroy kernel queue (DIQ) */
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
-		kernel_queue_uninit(pqn->kq, false);
+		kernel_queue_uninit(pqn->kq);
 	}
 
 	if (pqn->q) {
-- 
2.34.1

