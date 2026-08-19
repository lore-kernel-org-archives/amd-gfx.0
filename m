Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EE9C5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 20:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF33F10E1BB;
	Wed, 19 Aug 2026 20:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hVuGVvW2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED2A10E1AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 20:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpE7Lc2ozgMEmPBkFtwf2hoIJSlOjB11y5aSAItHs2FQMMjTUZpb4OsXi3ZSXKOUIqf5bML3//CrAWl+FhfiPFKb7OfPgaSQ/Qj7GE1f/LDllmL0OkmUB6Buqd1Ty8a0X0Fo7jcNJZ6Bz3VWxc5ZNNmwaNpsIb7VyKg80+QzZ5B2/W91Ai5xsH0GwTeKVga82zj4h7wb1F3LEwiRMYqHMSryv5N9yjdUdFgQq1ZOAWpSXGU1nwvcK1WYFPDGHhhYTBjqyW2nLfGGVVsCBpAnp4sEk4QEAYyqixcs81KoahFznRTmAgWzo3ph11lSd7w7wxY/UcoB0SXSuY3V8uXbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33O/IX74VS898zXvFY/iX09AdWFt47mhbNtic3ytx3c=;
 b=cICIxkwYzJ2eK496vv7UtUPQimWud4rR4FGpY9YHjQQcWWbk/MzgwmLB8iWEU971u0vOphiuJt13ocCFER0MoHc4VhO4XACSr+TXWT/l5+MsKExh14pVvBnLXUpt8XhMI+WAxtVjOG6ip5Qgxtb2mmMk/5KIu/MqcHDATWPoaI5ZAg+ns5xDv6HovZ9soAlcu11HacxcLf3xAfrOCZZK98C51+N3JFV7sBdxpoo7RfCGMjVs5NMKWNlP5kjBw9n1jnkQduKh7Hu2oVqGIWbYjXJPWCH0UNiAbKXBgyTRcE23JhSayL+mUpC61Dh6nNEC63MkoJkSoiGZcBx1AZJQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33O/IX74VS898zXvFY/iX09AdWFt47mhbNtic3ytx3c=;
 b=hVuGVvW2VG4/R13aAoriwGwI3p/nv3gnnSfOAYzyTDeFW8nA8g/ukAfvz1DamhUrcCRxJxKi+LvZ8luRUdQMp1eyfUtDKxOWqiaXmqaqJFEvaSnpmGXnrVWjcQZdqZ4Jq093Kuulnzu3fGYzqobn81tYNVcCXSFE4KMgTQQl1dc=
Received: from CH5PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610:1f0::15)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 20:15:07 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::5d) by CH5PR05CA0009.outlook.office365.com
 (2603:10b6:610:1f0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 20:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 20:15:06 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:15:05 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, <Alexander.Deucher@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: workaround 100% gpu usage issue for gfx11
Date: Wed, 19 Aug 2026 16:14:42 -0400
Message-ID: <20260819201443.282689-2-jinhuieric.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7d7b9d-37f6-4ec5-c21f-08defe2e8fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ILY6Wr8TzxQxWVsMuAsESk0y0HckUtS4MNH7m2GOH16wuZ0bkSTIQXi4Z1WNV1CCC+osBufFDXUxFh6odAXbkV3vlThWzCHudBgshnmYAx5uFgWVOdOtRyFFdw4DZmlyNhvt9KDUZhF22KpRevnmLqrl9VlIugvqrjN+M8LcPmb8BXEHTBcKK/soDNuRalumGiFXsojz5G0nPBUyW59xdQiYJCYkjbuTATQIxJqvE2tCGTLMXrOjaX+83i7xs/8Iq21Cb4RDg1CDwJqPnUMIHNROMMEzBn1sq53dxQJOV+iG6BMRv67XczqrMNqGM2entbyX/wPoRx5SSTEzlI8UkRios+XhWls2VP/9dd0i15ReY6E6buYNbXLQdkdDq+S0Rfaz02//yG/bpLn9QkDeWN2niLV/ap1ri7nZLvdT8Hnz+IycbPX0+U+/bApLnGSUuHkYc+Yv3QpcEJukNnCVkNa4h5DcaqMSmMGMbYLfMNsY+9QRNrQNnIUz66lFiOzOLhOK6n2N6XBHk+VLkbxkWW5NOi/2tDV78NfahbxhQtJI6CDKFYXP0mZ7BY1/+d3N2erB22bzYwDx8M7abGRoMhCG6Yozx7F40/iH9YJP+UvtioaBc5FChJ+tOGGSzJ4QLZQhNWWq/Vp1uQwSQxVXcTLAChuHTT1BU6M9IzqF3X2krRQBSCbIspQ0bDvXcxGoIoLAZ8M3SMRTceLYF0jf0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Slgx02Fg0fEAz4axU6gDvMFgvUJ1bG9S+13QpADnQxitlQKUJRcRMgGY9F/QYwvXJvNKBPYGfzIVgRqbsnYjKaoFzz2IUxhoyRTRuTMXAmZhg3DcK3SWSpoPg0ff+8rXnG0TCvk58b62KQLN88zoZyiJkUijkt8DFmhrgQ6dePXVaMP7dTfuPQAtvh0Sy79j3yU1MK6GfVQji0VQcNQ0UyUL+Le5EsJXXDl3ytBRfmwMWDSYmZ+cNBOI3iQ0YXi3jJEDEtboI5EvIXJBWmfQP84e8MdwlSir+I267AhmGczCRZxx5GSnfjBM3KWAcqycU1U5TkypLUx8EXGiefgCPNt1OFkTcHIRiF21nisli7krYUOZwKSAuEpxspiIvz37iiQ1sfAb2IbiqufWU8rsdmGwHMQlzZ0yIQfSS2JdSlLvsz0svyyVqshAVfZPRUFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:15:06.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7d7b9d-37f6-4ec5-c21f-08defe2e8fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
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

the issue only happens with oversubscription when gpu has no
workload, the root cause is mes oversubscription timer, so
disable mes timer and make a similar timer in kfd to resolve
the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index df71e9447b35..33ff1afd7c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1024,7 +1024,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
 	if (adev->mes.use_rs64mem)
 		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..45e039c9f31b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -47,6 +47,9 @@
 /* See unmap_queues_cpsch() */
 #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
+/* Interval for notifying MES of work on unmapped queues during oversubscription */
+#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
+
 static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
 				  u32 pasid, unsigned int vmid);
 
@@ -276,8 +279,16 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
+		return r;
 	}
 
+	/* GFX11: start notify timer only once when oversubscription begins */
+	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
+	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
+		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
+				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+
 	return r;
 }
 
@@ -354,7 +365,16 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
 static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd)
 {
-	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+	int r = remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+
+	/* GFX11: stop notify timer when oversubscription clears */
+	if (!r &&
+	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
+	    dqm->active_cp_queue_count <= get_cp_queues_num(dqm))
+		cancel_delayed_work(&dqm->notify_unmap_work);
+
+	return r;
 }
 
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
@@ -3194,6 +3214,20 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
 }
 
+static void mes_notify_unmap_work_handler(struct work_struct *work)
+{
+	struct device_queue_manager *dqm =
+		container_of(work, struct device_queue_manager,
+			     notify_unmap_work.work);
+
+	amdgpu_mes_notify_unmap_queue((struct amdgpu_device *)dqm->dev->adev);
+
+	/* Re-arm if still oversubscribed */
+	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
+		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
+				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
@@ -3319,6 +3353,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 
 	if (!dqm->ops.initialize(dqm)) {
 		init_waitqueue_head(&dqm->destroy_wait);
+		INIT_DELAYED_WORK(&dqm->notify_unmap_work,
+				  mes_notify_unmap_work_handler);
 		return dqm;
 	}
 
@@ -3335,6 +3371,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
+	cancel_delayed_work_sync(&dqm->notify_unmap_work);
 	dqm->ops.stop(dqm);
 	dqm->ops.uninitialize(dqm);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c9f9f7a87111..21cf3c16f3f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -281,6 +281,7 @@ struct device_queue_manager {
 	uint32_t		wait_times;
 
 	wait_queue_head_t	destroy_wait;
+	struct delayed_work	notify_unmap_work;
 
 	/* for per-queue reset support */
 	struct dqm_detect_hang_info *detect_hang_info;
-- 
2.34.1

