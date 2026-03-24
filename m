Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A9EFEC0E6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA19B10E60D;
	Tue, 24 Mar 2026 17:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNi453ES";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F7E10E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPWSHrtcNJvjO+GKandHHAAAb79l+DxGaNRe0fMWtNBGwrVeQqxfiCr44eGux7wLKecD9gIaWmDCNDs+EmKMe5K2U+Gzb5HKvKU1hPRIOjC16zTEr6LKX9nBoHDUzEbjwUbXpkwDcG8VtShCL+ZzysyI1B8g5ijwf6qZu0XXww70raRttExhI7SsQIQUvYLLpngPexOm5zRx267BQWIruKGotLDGZq3q/wlV9zmBCoWCfscQJzDhyHkqVoaar54hLBn+L1wOblaedU1ffSOFX+DZ1yUSD8W823O/XiOAzDLoYwdSvxejb7355OQfbR4chsIRWOolYWrP7WD5+wzRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC6tWdjr4NbiUJ3MOH/X54bXH6baVIocA9DE48/wPCw=;
 b=mYOuTrdCwd9NMvnuz4c0d5epghlq2h3QZn5gDiRt33m5mlLDtydg7sp5vauw7svDyUorreCllfwGqU5aTSopsZJ1LztRS4uRTrOtRsAPAd99ogxaUbRDOP+X7l4LKYHmtyPdK2dWV8+XdjMKq3bMHKPYd5F4if3SnNn3MZqrklrjtdQvlbVzyNq0QshcaNfOudyq1lTF1EGv46hrREhv/oPorTcH4lSs30+UbKmF4mcnAT0NUci33WrI/OgGevaFelLeJYxItf+v/BQBlKRWppz5RDHzv2dhGKZjUvph5/iTMfh9N0fmXC+FCo6fUCz4N6bbfw7fHwtRHy3W8OTPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC6tWdjr4NbiUJ3MOH/X54bXH6baVIocA9DE48/wPCw=;
 b=GNi453ESFeMfqZMFmehnbp3lp4OBA1/JM0D0YgD8nzb5qd7KkdVi/l8CcnZAFIpmKegJxXyJ2lTlnzpF05IRNwVJBQ7lEVvOLEgUc7x4WQ1VYe36PeWoy7gEF/tLkoF+t2EzXd5QBZYJdaRtml/aErBoFG3xOSSaGJLfpea698c=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:52 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::aa) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:50 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:42 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
Date: Tue, 24 Mar 2026 13:56:51 -0400
Message-ID: <20260324175653.1325754-10-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: bab24a9e-b74b-48b0-a75b-08de89cedd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qdKhjjGO2CLn08vtFI8/nLl/W2xZVrIQFYl37VOgAwISgj7ECETXu9c9upUrw8DNSC/bIFbM254hCUTFA5nlcbe75FfQiuHvC9HRaxNvht5fTmgkjGkAnrV2m95RFjIe+VQs6u9NdwLh3Wsn44Nf4E6i2GMo0+yQKCFbKTeKSKVUUzz8vwaLkrhyt21SGfgrBRrKS91MSjc7qQvS7ihuOrFTO27kQjfieCq3Xv/cMeAaSSsLN2yP70Irvzt6v3a/KVf9ofN6DShcXVSi38/r8RNhhE87iO3t6hauzJTHkkx9XgzI7/01qE5L8eSAKKuZ5VPKDSixaTAXPtSn3IkMpBFAGfefew/9Hoaw1bzVe57RdiB9eRRjm+p9eqemyd8JzD80tYsfLddz2hjbOmwZuW4J0zq9BwOm6Yylt9GpD1uAlYnus3udflq14FYZemb1EV/kf4ecITTLhEpC2uqYUGszuMCcsaNole+do9Sc104yXQo/GRkHpUTWzQcRK8zNDZFgA2LuS6ef0dhJK4kQ2Sfa51Mx/8HHBvTR2rcOPUmC89bFKD9I/Y5hTnN+hfWfd1AdpemOM+0g/K6i8s6r97+NMIcMirt3+/kC/swZ7mjjRIyUHsqFgeWKZC2YLczoBX9IXwsoA5MUfg/cCsN4zoSGOFVhPtQDqWMPMlSL/eYGm6rMIgYdUkQMd3ijhAhKcd5qgLhKG0ClkL7p384PFSAevftggPxkceupz/GSI96Q9lcXYod8zii+gT88lSqx/kVKM/SGVMmOp9XbnEQ4oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Qr9F2PkJwIb7SJNFd9fxzpnA1104AWIkKSDF/Fxq2lnT6uZFM01cNuUD8g7GVgCj75Zn3cDtTxyFcIafUdUTFfJ/a558v20UCT225KClyiWCxAwz05aY/ekSGPxvP974cDirqY0KDeE5Dc6VLTVWCSib99ILiLfktcKVdTvsJ0iZCLQoXCGBPP0BLFUAZGqowDhrIGSRn8hQGG+bysXAPr8KiKxzE3pxOWDclA9fhMsxqmw8bs9sVSo6BUczCAtHqhQaGUSmUdMl04tvvl5b2gplDDmEctREPllj+JV60ETpQYyBnowbi2kx5gegbifMPS98UbtIyrFgEFGPfYWoCUIVQqsjq6R+HqbwIEX3odo0CftM2xHiBy8BQFSHRA++PtvDX9y8HQfHx1pYD6852UrcD7ymxel/JoDlj4590Pfi9FSf/FOOVJMP6tsJVpI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:50.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab24a9e-b74b-48b0-a75b-08de89cedd67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

When removing queues fails, KFD calls amdgpu_mes to detect and reset
hung queues, then cleans up those hung queues in KFD.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f3a4ae1fd521..7cf4b3d6fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 		amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));
 }
 
+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
+{
+	return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
+		(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
+}
+
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
 static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
 					    uint32_t node_id, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 643b4f8d757a..44fa4d73bce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 }
 
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);
 
 int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ec8d7f4be840..1c9c350bfffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
+static int resume_all_queues_mes(struct device_queue_manager *dqm);
+static int suspend_all_queues_mes(struct device_queue_manager *dqm);
+static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
+						   uint32_t doorbell_offset);
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
+			       struct qcm_process_device *qpd);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
-			struct qcm_process_device *qpd)
+static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
+					    struct qcm_process_device *qpd,
+					    bool is_for_reset,
+					    bool flush_mes_queue)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	int r;
 	struct mes_remove_queue_input queue_input;
 
+	/* queue was already removed during reset */
+	if (q->properties.is_reset)
+		return 0;
+
 	if (!dqm->sched_running || dqm->sched_halt)
 		return 0;
 	if (!down_read_trylock(&adev->reset_domain->sem))
@@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
 	amdgpu_mes_lock(&adev->mes);
@@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 
+	if (is_for_reset)
+		return r;
+
 	if (r) {
+		if (!suspend_all_queues_mes(dqm))
+			return resume_all_queues_mes(dqm);
+
 		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
@@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
+static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd)
+{
+	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+}
+
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
@@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int reset_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
+	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
+	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
+	uint32_t *hung_array;
+	struct kfd_process_device *pdd;
+	struct queue *q;
+
+	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
+		r = -ENOTRECOVERABLE;
+		goto fail;
+	}
+
+	/* reset should be used only in dqm locked queue reset */
+	if (WARN_ON(dqm->detect_hang_count > 0))
+		return 0;
+
+	if (!amdgpu_gpu_recovery) {
+		r = -ENOTRECOVERABLE;
+		goto fail;
+	}
+
+	hung_array = kzalloc(adev->mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
+	if (!hung_array) {
+		r = -ENOMEM;
+		goto fail;
+	}
+
+	hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
+	if (!hqd_info) {
+		r = -ENOMEM;
+		goto free_hung_array;
+	}
+
+	memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
+
+	/*
+	 * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
+	 * post suspend_all as reset & detect will return all hung queue types.
+	 *
+	 * Passed parameter is for targeting queues not scheduled by MES add_queue.
+	 */
+	r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
+		false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
+
+	if (!num_hung || r) {
+		r = -ENOTRECOVERABLE;
+		goto free_hqd_info;
+	}
+
+	/* MES reset resets queue/pipe and cleans up internally  */
+	for (i = 0; i < num_hung; i++) {
+		hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
+		pipe = hqd_info[i].pipe_index;
+		queue = hqd_info[i].queue_index;
+		queue_type = hqd_info[i].queue_type;
+
+		if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
+		    queue_type != MES_QUEUE_TYPE_SDMA) {
+			pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
+			hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
+			continue;
+		}
+
+		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
+		if (!q) {
+			r = -ENOTRECOVERABLE;
+			goto free_hqd_info;
+		}
+
+		pdd = kfd_get_process_device_data(q->device, q->process);
+		if (!pdd) {
+			r = -ENODEV;
+			goto free_hqd_info;
+		}
+
+		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
+				hung_array[i], pipe, queue, queue_type);
+		/* Proceed remove_queue with reset=true */
+		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
+		set_queue_as_reset(dqm, q, &pdd->qpd);
+	}
+
+	dqm->detect_hang_count = num_hung;
+	kfd_signal_reset_event(dqm->dev);
+
+free_hqd_info:
+	kfree(hqd_info);
+free_hung_array:
+	kfree(hung_array);
+fail:
+	dqm->detect_hang_count = 0;
+	return r;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
+		if (!reset_queues_mes(dqm))
+			return 0;
+
 		dev_err(adev->dev, "failed to suspend gangs from MES\n");
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
@@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 		q->properties.queue_id, pdd->process->lead_thread->pid);
 
 	pdd->has_reset_queue = true;
+	q->properties.is_reset = true;
 	if (q->properties.is_active) {
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, qpd, q);
@@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
 	return NULL;
 }
 
+static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm, uint32_t doorbell_offset)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (doorbell_offset == q->properties.doorbell_off)
+				return q;
+		}
+	}
+
+	return NULL;
+}
+
 static int reset_hung_queues(struct device_queue_manager *dqm)
 {
 	int r = 0, reset_count = 0, i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 27e4859e4ad7..6cb33f6d71e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -523,6 +523,7 @@ struct queue_properties {
 	uint32_t pm4_target_xcc;
 	bool is_dbg_wa;
 	bool is_user_cu_masked;
+	bool is_reset;
 	/* Not relevant for user mode queues in cp scheduling */
 	unsigned int vmid;
 	/* Relevant only for sdma queues*/
-- 
2.43.0

