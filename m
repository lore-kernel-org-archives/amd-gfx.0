Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905B10F2867
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 20:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A1510EECB;
	Fri, 27 Mar 2026 20:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UabhB9Uj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC6310E2D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 20:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtWJ6Rd5P8z97QVw82xihUzJzdK9/5EpR8AO/h418cEM+ozFYbvNILwmbfGAdFxEVeUwBokZM+wsyh9fvn0FqxgRCq2h07ugv2INXwE3CQcBz8hxS4ajgndBaBs0i0n9kLduh1GnGtrnaeimCMiWB9YEB0mByHfDVKhT2uTXAGW/IfJw6iJ2nFGFNgf3LpLFqzCjW9NfuqOtgms1GF/Co+KwFyjVX/M3qdmj83vv24R2zKbOJTtsBduEQSSvbt8nVa6vKd2I25PLVDQ7kE2E1yKcgEm2wwUylUH+Pih87+rukFBS13HpWkNwBZ+v2Bf+0ahB5jJiv+9zY3vxabvygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E8s+SA8FbooveZ80gei16UgovoMm+6R/OEsljsWaMw=;
 b=O8G9jbQfNU3HUjtY+PETuMvdO6yC3RGOBMJ/BqWc4RIuhOuhQesCS+Z0tnuw1SCjMEOksZDDyeHVofPMJ7KwmgAkaDuvVtf7+/U5co1S0bfEGgbmZ1MZZBbYiPtG31QwPXfriFLvAN8KS8HvQX+SVM6MH8r9T6buliLseroi5+CVOBavGFfmfjwjuvm/+Vyd2SzHzs3hH4laCUi46VeDHSUJamJoso72UXDnJPle07K8mz4uS3Adl3vc9+3OQPbVJl3GV2HzdnhRz7NSDaHTLTlYhPYyy0+k7wmKQJzfcqS/03y0KkZyGGFL18Zg7WvV8D/HcF5jxllCOTG83PHwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E8s+SA8FbooveZ80gei16UgovoMm+6R/OEsljsWaMw=;
 b=UabhB9UjIUZqYvi86/reBl2ivyhNpu9+jgZ5V2nT3TAUlD/qD4+3L/W8Cg/3CY43PDFAhLFWH4pEGg/BEISuBwk9/WvzcjKuAS8R/H9G8fxdvumOlpiHtf7wmnlANriZN3xTPoD77FhnXHJFwrGNbz/mn3sm75EiYD+siD3vmNM=
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 20:32:48 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e2) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Fri,
 27 Mar 2026 20:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 20:32:48 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 15:32:47 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v3 09/10] drm/amdkfd: Reset queue/pipe in MES
Date: Fri, 27 Mar 2026 16:31:52 -0400
Message-ID: <20260327203152.1578828-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327203152.1578828-1-Amber.Lin@amd.com>
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d4fd9c-4dbf-4764-959f-08de8c400297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VxuziQP5ThStT34CtFaO1EdQFjY0LGO24nuYnPrnPpllkCLvvZxUrIn5iL1n+r1vgOVyYxncLEjRs1vGwRMEHIzmzwn5adU9ic2Zj/0MdF8UWbOL2GqOMY/QCyDUYcnSrLxGWQugXoqvuBoYIZQ6euuLXfBv3r2m+QKjhNnr3xwbo1gh1GzN2O1XmLrhFW/2PL5O7Er8ECTv43ntr40HFj7mjwYZ7sjLbbmtXqjk8n9WFgHqdfbrBs3rIAp4Dcc4PYLdhCRGRFHQucwRIMWmArP+pFE2CvL6InC0ThamU2BZc/ZTROQ0uv7yAIZWNrcUMi0YQmZgam1nkAzRg1Pi8l4Z0DC0QSb5+bPOXwQClADIfuOzrM/6UarFoCXfUTikJ1/sKA8pefTofY51VzlZt9XpF57+GFZV8hsMKnawMQLnFM+Nap3JvLF4BsbNx+5gydrud5uRSqOO/4kTG3Fx6jD78hgIrWsEtQPcB5Q/iMayZGi9s3Il0DlUc2FJnHHj+CpRFUHOxtUUQBvv01VizMiZi5RO/BHmq3k6AYrrVzycaM6aDE9OLjNoT2IAWwsYuLUk5NWt4K6bmHJUXipPH6UgGfNsJNIwRLwZK5+gwiPmjzzkfinj0TjLnlp/XYv/b5VoewsiK9Irww1fOqq5NcE8qEaWAw41B3kNC4dL4N5H+i2zLxsTRBnvE0dly8MtJMbo8YCNOhGKclL8WXuAhLsQbxjJeHfkmFY86SEZuDnfL0ya404XMF/3r3ItL8vPWUBet0Q3c5BUBeqWEX//XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /nFTaWKG1ekgs4z9VLENAB89EU0RSMP66+Czzn6SiG1IDcDBnMh9U4if/u7Nn4iXHNqqRHIUIcpZDiKPmcjPH9S74HqaSNR8hBk72DxywqJKfPR6MagBtaXHqbYcMU6mP1MtiixJXVjIonpGbMVSGYRBwbbqSs0KRaUIHHJQoKNUY8WEMOBqDFK8ghlIeqOaiOE5veKimtTsgLOZeXRry07Apv6tFAr6a9C4FC4Tvd4DnHYg14yM5rN3JYvbGClLGhmPio/w0cbH/aM9G2A5qkmGHDelRupvVp1PpqNBbeaXL19M9/GXLpDs+8twGt/0DG7Mf27KqNb2xDI4EJglfyUkuwzkodRebQAO7emwLjqzxOUJZrde6GPqo97vRjsOJ/lqevoz40m+JlTlumjHZ4Pakl4gu8YaInESk65S9R9a6HEdmJ3VMvndBPZIWmXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:32:48.1672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d4fd9c-4dbf-4764-959f-08de8c400297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 5 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fb7fdf5d0973..75720d247b4a 100644
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
index ec8d7f4be840..2670741f3e53 100644
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
@@ -359,6 +384,92 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int reset_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
+	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
+	uint32_t *hung_array = dqm->hung_db_array;
+	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
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
+	if (!hung_array || !hqd_info) {
+		r = -ENOMEM;
+		goto fail;
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
+		goto fail;
+	}
+
+	/* MES resets queue/pipe and cleans up internally */
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
+			goto fail;
+		}
+
+		pdd = kfd_get_process_device_data(q->device, q->process);
+		if (!pdd) {
+			r = -ENODEV;
+			goto fail;
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
+fail:
+	dqm->detect_hang_count = 0;
+	return r;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -371,6 +482,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
+		if (!reset_queues_mes(dqm))
+			return 0;
+
 		dev_err(adev->dev, "failed to suspend gangs from MES\n");
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
@@ -1821,6 +1935,9 @@ static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
 	int retval, num_hw_queue_slots;
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int hung_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
+	int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
 
 	dqm_lock(dqm);
 
@@ -1870,6 +1987,11 @@ static int start_cpsch(struct device_queue_manager *dqm)
 		goto fail_detect_hang_buffer;
 	}
 
+	dqm->hung_db_array = kzalloc(hung_array_size * sizeof(uint32_t), GFP_KERNEL);
+	dqm->hqd_info = kzalloc(
+		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
+		GFP_KERNEL);
+
 	dqm_unlock(dqm);
 
 	return 0;
@@ -1910,6 +2032,9 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 		pm_uninit(&dqm->packet_mgr);
 	kfree(dqm->detect_hang_info);
 	dqm->detect_hang_info = NULL;
+	kfree(dqm->hung_db_array);
+	kfree(dqm->hqd_info);
+
 	dqm_unlock(dqm);
 
 	return ret;
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 3272328da11f..e6eca38cae4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -32,7 +32,6 @@
 #include "kfd_priv.h"
 #include "kfd_mqd_manager.h"
 
-
 #define VMID_NUM 16
 
 #define KFD_MES_PROCESS_QUANTUM		100000
@@ -285,6 +284,9 @@ struct device_queue_manager {
 	struct dqm_detect_hang_info *detect_hang_info;
 	size_t detect_hang_info_size;
 	int detect_hang_count;
+	/* for per-queue reset with mes */
+	uint32_t *hung_db_array;
+	struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
 };
 
 void device_queue_manager_init_cik(
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

