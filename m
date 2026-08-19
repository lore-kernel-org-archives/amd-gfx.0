Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B426C5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 20:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA76510E1C3;
	Wed, 19 Aug 2026 20:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2U+Vkazk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB4810E1C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 20:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbmUhK7AFB5uBeOL1S7f4IrqhdJE//rL43lJvBPgm6d46HLC7tjM6VKSxtq/lMHugN0qHBZueE5fFJy15+HnOfYzSTjd3/Lf9Vza9QB8T6PizPHo/AHU5InQhrBcin21OmzdZuihkiXnxGHXhzpCDQP5ZflLl9CdrVNm4xT0ahbNBXNxxbBn6n6k0CQu6lFmUBX0dN6PySHluqllcWu2dX/qme3vNcPuBOoSMDZN4UoDvNQa1ViiJSvIy44Gu3uNZGxxJg/iFSFWqikjUq+qVDF+42+thfZYG9lZ99i8etX3ggJM/meYRFUTwd+5WhOLepq8BbJEiZujBSlf0L8vvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6phRmRDZYWEThPMp8KOBwtm/3hEO+s9AqbZr7xW6Hw=;
 b=Nu/jv+XvFW0TUyraSzjw9pHwmcEsVDuOQAmgycMvAn4DS701IvYr3gzGQc3ARsvtLZQi2DbfXIC4b5wVM6eLsS0/tymANi0dmWb352CiqLL0oEnsEwM9RkPHP9s6lCJdugS1L8iwFd+huuhT3DNct7+u+zmUNb09cQ4I5hxqWHyWTtAGIJ3i8fhSyFkzI6yAGJUmlOHFR+fLSELmhf9c4Zin9otMx/oRHEslCsTru1I90d0CTUDqpMyD5Gs3Bfs1ClhpbWHWtnllNyefJWatCDZnCgFTz1lsAfIvMpze09KZ5onaCRt1VI/ICftFefZcZxQgE3nvajBvgC6N/iFSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6phRmRDZYWEThPMp8KOBwtm/3hEO+s9AqbZr7xW6Hw=;
 b=2U+VkazkcZHAtsx7NaEdJ8bxSt50wY0xbi0nF9qDKTU895mg8xw2Qxuo5YdDhkfjhSJApDuuqrT01DlJwFEwfsflWr+P8IJZNs04xgZ0WfIl7MHFJXv0kKe0HbeCSKhnOC1crC9UAR0pEn4D3c2Wg6UbMrjYlteiCtDS3NRNhFI=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 20:15:07 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::4c) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 20:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 20:15:07 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:15:06 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, <Alexander.Deucher@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/userq: create the same workaround of
 oversubscription timer
Date: Wed, 19 Aug 2026 16:14:43 -0400
Message-ID: <20260819201443.282689-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819201443.282689-1-jinhuieric.huang@amd.com>
References: <20260819201443.282689-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: ae49aa41-0d69-4821-a42e-08defe2e9048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZXW5P+EMOc8rUlFjWQZcp1/kB4otmUlUPJ//j/WyrBUd0uJ+NiIouX6TuPTNy3VAt8TPiPcT9zE57wsVSdSSRTWwHBp5becQYfbz7DvvrT94iR+dhcD/ytOPDMlWNEkHNP5QyUlMR9PucD1UepdNyZr/iYxJEZKdtpXXhJ4GUnexnxdph+38haj4/xsJSL8NbzoxXEvlN0l/PgymUbmxHSndNN9W/lBEJihP+Vy8O//rLHRPpJuUbq5yuyabxLYU37AwVvc8aOH2R9fWPOz1CayvZJRaZMfqkBkkJDqemUdJhN266qVrz0scdSTW7mRk9HuBswqO4mb2vaVy1hYV/0z1k//L9l4PdG1sC21FWEuBhv1i95KXvRFnpOgu3vAEa+VVIoUi4KJMCUu0rruvpKn6jUM1R8Vq4VmbNSIm4NNqmCaqHHkQf9DGTlngANRmGQ6Ltl+iFQWoHwxC7+BV373SY9e8nZ/lL00H5plEAzalRHp/BMVlPul/JQSYSKPHPmnOj73lStRSOFQgqojLrcq/3x2kLUJasGe3qSxmwm4oR/jLs4ySI+3OqBnbi8yzIpEnbz7GOWNAyaUXmRF98bsOCKikyhZmjFL5pvQqGEfwnsfaQXuXIh/G88SlSKOLzO6gID6FPxnmxB86y9lTZ7yMEINzShdIWyFblySdTZPNty9RUuoKXW8P3iBpkmxQYfgkrZnCtQ5aR40sPyC+4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fCdiF9WHVE8Mrt8y7HQrcLKlO6MnFkg7nzT/Ts1cEWWB9unx2n+uO37NHXRGzITZVPoqJBiZwp3/ZlmeBV+2TwZBYo0VoQUh+KlrPA5HvyDueuVqaeI3QX48Kv1HVHsRyPaOgQx8EEivfgRGG2DDwJDGPcfkuj2bk1G2UuLCe5neuBQM04AMz+JaaVyZhvlgJCuURh4rkbTUQz/veUNCd/Lh6zKUxBc3uHqqZk5FrDNwkFnLIJN9QSQtOW841sgmUT3T4XOik2vTRZoNXWS98LLDw80qnAiPGVd4rQ1swPzAkwZgzttKvAp7nFj/PEJE1AFLaBr1K5tnl0H2CVp8rQ0W0qpM2cpmZ/teM0lk2FZAYJs+FDIpNwQb1ipcRTYhbHzI/0/vkufa2dfJX0pGNo1vpwgSvk/3ujc947P8YuqDlf6S/IYafW52bTvn3UU+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:15:07.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae49aa41-0d69-4821-a42e-08defe2e9048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

removing MES oversubscription timer will affect both amdgpu/amdkfd, so
add the similar timer for amdgpu userq as well.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 70 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 +++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 421d937c1188..b2c64ec8e0af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -101,6 +101,8 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 	return (total_hqd_mask & ~reserved_hqd_mask);
 }
 
+static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
+
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes, num_queues = 0;
@@ -123,6 +125,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		spin_lock_init(&adev->mes.ring_lock[i]);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+	atomic_set(&adev->mes.userq_hw_queue_count, 0);
+	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
+			  amdgpu_mes_userq_notify_unmap_work_handler);
 	total_vmid_mask = (u32)((1UL << 16) - 1);
 	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
 
@@ -288,6 +293,8 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	int i;
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 
+	cancel_delayed_work_sync(&adev->mes.userq_notify_unmap_work);
+
 	kfree(adev->gfx.mec.mes_hung_db_array);
 
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
@@ -1163,6 +1170,69 @@ int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
 	return r;
 }
 
+/* Interval for notifying MES of work on unmapped queues during oversubscription */
+#define AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS 50
+
+static unsigned int amdgpu_mes_userq_hw_queue_num(struct amdgpu_device *adev)
+{
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	unsigned int n = bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
+	int i;
+
+	for (i = 0; i < num_xcc; i++)
+		n += bitmap_weight(adev->gfx.mec_bitmap[i].queue_bitmap,
+				    AMDGPU_MAX_COMPUTE_QUEUES);
+
+	return n;
+}
+
+static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
+{
+	struct amdgpu_mes *mes = container_of(work, struct amdgpu_mes,
+					       userq_notify_unmap_work.work);
+	struct amdgpu_device *adev = mes->adev;
+
+	amdgpu_mes_notify_unmap_queue(adev);
+
+	/* Re-arm if still oversubscribed */
+	if (atomic_read(&mes->userq_hw_queue_count) >
+	    amdgpu_mes_userq_hw_queue_num(adev))
+		queue_delayed_work(system_wq, &mes->userq_notify_unmap_work,
+				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
+}
+
+/*
+ * Called after a GFX11 usermode queue is successfully mapped to MES.
+ * Starts the periodic unmap-notify timer if this pushed the device into
+ * HW queue oversubscription.
+ */
+void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
+{
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
+		return;
+
+	if (atomic_inc_return(&adev->mes.userq_hw_queue_count) >
+	    amdgpu_mes_userq_hw_queue_num(adev))
+		queue_delayed_work(system_wq, &adev->mes.userq_notify_unmap_work,
+				   msecs_to_jiffies(AMDGPU_USERQ_UNMAP_NOTIFY_DELAY_MS));
+}
+
+/*
+ * Called after a GFX11 usermode queue is unmapped from MES. Stops the
+ * periodic unmap-notify timer once oversubscription clears.
+ */
+void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
+{
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
+		return;
+
+	if (atomic_dec_return(&adev->mes.userq_hw_queue_count) <=
+	    amdgpu_mes_userq_hw_queue_num(adev))
+		cancel_delayed_work(&adev->mes.userq_notify_unmap_work);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 0291ae14a1e7..5160b227943b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -29,6 +29,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_doorbell.h"
 #include <linux/sched/mm.h>
+#include <linux/workqueue.h>
 
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
 #define AMDGPU_MES_MAX_GFX_PIPES            2
@@ -90,6 +91,10 @@ struct amdgpu_mes {
 	uint32_t                        total_max_queue;
 	uint32_t                        max_doorbell_slices;
 
+	/* GFX11 usermode queue oversubscription notify timer */
+	atomic_t                        userq_hw_queue_count;
+	struct delayed_work             userq_notify_unmap_work;
+
 	uint64_t                        default_process_quantum;
 	uint64_t                        default_gang_quantum;
 
@@ -646,5 +651,7 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 				    uint32_t index);
 
 int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
+void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev);
+void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fae709f134bb..5a10af16e0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -171,6 +171,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 		return r;
 	}
 
+	amdgpu_mes_userq_queue_mapped(adev);
+
 	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
 	return 0;
 }
@@ -195,9 +197,13 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_unlock(&adev->mes);
 	if (mes->use_rs64mem)
 		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
-	if (r)
+	if (r) {
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
-	return r;
+		return r;
+	}
+
+	amdgpu_mes_userq_queue_unmapped(adev);
+	return 0;
 }
 
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

