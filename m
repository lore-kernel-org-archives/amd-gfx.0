Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0835C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8BC10F3D2;
	Thu,  9 Jul 2026 06:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Db26PAw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F3B10F3CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt6SBRwTqPJ+A01Z//Bfygn/sqL1DgpCaWy16k0/Ajd8477+l3gR9Fv8Zq4bOXrVhkHLYzjV/VBv1Cawv/Y2KpRhiQ2+T1TYofOr3GCVN3VV17IP+Y7D6FF2PPwjedJbxLvI6LosZKklzo8gMcLwW4hvVD4Ygpvo07+1go0r7UbcD3UzGM8oGC0cs/ibX57ntswRSSNDSNxFa8nt27Ffx8qXgamwA/qntE9XICjZEbMulGtQor0XN8DjTSLkm6gbjTKxhRge7HvoWNmo3fMFVg9B+ccp7DRWwVe3UvstnU2NAYeTXlpZSYcgemEObKqmbe00h8a5Fww2eDSfp1uSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEMyNOlVU8phaLKWNQJCx1LYXXFBeMcLjDc3HFE+cN8=;
 b=uXdshviAJq+7H5jWw+op6+fNbNmfFiUilLdUhsOnyHGJ880MG9788wQECk1eGDEv4HD6y1hSKn+Jf8ZgW79k5GiyBh2ghOx0dpmENsCGHXtywUzXsQvKzJ4rfp3/T8Xm3U9fUokODHlljansvJGaFeGsYklwlAbwpvGJ5T86p8S07K0wv9Md/nK9Dangj6dHKdJDQA4MZXn5aBEj374b3QtY1nhqg9p71y8cDo4Bs3ynbhRaIxl4dXEOsei1HKig6LCCAGwXR4aI2RlDkFflTJ/WVfaxv4JvjUwytLHopUHVRk3WFr+7XsroKvmAIMSTLIgcyzlXuQeUFNJQwxqLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEMyNOlVU8phaLKWNQJCx1LYXXFBeMcLjDc3HFE+cN8=;
 b=3Db26PAwT3THzDSZMDwZdSg3SW98f4oUI0IyoT5iFPg7gUOl+VPdVVZIuy2BF0s1byNx5BqDQKaUNwZZo65sXnmwKZoCmq4pKdkXWOh7oXC89YdI9ct08JacDkx/S7uVuWDZpIY40TDJCcu0wj7sWNC77VtQBD9T2I4a9J8ZlPQ=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 06:59:13 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::3f) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: add mes process context alloc/free
Date: Thu, 9 Jul 2026 14:58:54 +0800
Message-ID: <20260709065856.472296-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709065856.472296-1-Prike.Liang@amd.com>
References: <20260709065856.472296-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b49802-c3be-4569-50aa-08dedd879573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Dn3Y5eu4LT3XCjPFyQxwH8r7xYqhS1jJzsLjVGv/NsI3e9ZMmUvZWk++228shYyvovLXyvC1iCuGhLa5tH8uBfLMGLVtY40Ln67eFxdRNREEs0Y/j3lGxiRm5ayELSjfmLGSFQPRkJutRe01VDpPzt2TgM7NmI/PJr8xzJifRsqKp/gSqrTC0EYT5S8y2w96MxuGiahF9XQaaQLjH2AVaN6BzmE2uCxohduRMUSDQdoNDWyiMucI3heb+VnsyeUyjlSdrmP9VTi0s7Qe4ylDNZws/Dok5IBxQY7bWDdikv7Z6l5GvP1mmS9ecEsqaOmuhUO4UOTyuTeOfZ6gupfsSmTNPFG1VzZ13WZ1Os0SP1lbTybFcZjE9k8eb0euNYtMLAivflrjF6rScg02kdrdEe3qyW9NvYI+9VklSXeSd9bxBfihCmi/T20dXD+CBJbq3FXtUVNxGUaqD05YQr1c6DE8Cx+mihOPyQPcL0aT0wFoX1ek7j/AzRcB6IJuLmppY0pWfjzWOAQh0G5LeM6KXlgeILmE4+C8yN5JtY9lZ5wp9m/6fRJpEKinwBEFhtcHMEFZoSZkniNweu0xI+2HSFlw79SZOh/J5hlgwpS/tXqhJu6fox/mUAmuLQKgHfNAdiHBjbF25bkxbHIShG9psSJ6KtFcgo5b8oE8Fyu3CPuk4WyW/ihreLaL/gsdOJIRaOU2nsKkp3cjoeUqU6l8Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gHSRpE8cRCxQE0T7JJBfVZCGs0i92MuyLtTCaj20RaiYRUlbeiiLDlwebOuPfJoBJJwGi+QmJTSY4qLW47RlZtzFeOzehFuz4rfNx7yhjUCc4LZ2oSB1Xt6ls0CL/qg1TIV5bgHLsjLYg2GCQ/NTbxDmsLZgxo4hkvu1VEPQiJWMy4ZauLkluqzWYnNssUDRTxF2nVSmIII1JbPKmS+ZkdFM4WZ1D1YZ2LPAJi4njJhIw4A2ZijKaa0JZBCjVDSvEql69XT7qtKwuO4S5ApsuvBHF7T9aiFxpVeu6W24q0kPZTPXysm1Ii++o6jSDrck3x21oxDjW0G15xBAm6hTzEKo26Y/L9hXM56T6O4F9VW2NOq79On/IPHfHwI6LaqoKfb5TLNDLPomuFsnIVX7r7VvOtY1KPpKcW/4wWydDjpbmmvuMlqtYvgJ87dxqxQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:13.0177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b49802-c3be-4569-50aa-08dedd879573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
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

Those helpers allocates/frees slots from bitmaps for
process_context_array_index processed by MES firmware.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 46 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  9 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  1 +
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f65f2a30154d..db9c46ece2a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1035,6 +1035,52 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
 	return 0;
 }
 
+/**
+ * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
+ *
+ * @mes: MES instance
+ *
+ * Returns 0 on success, -ENOSPC if all slots are used (caller should
+ * fall back to system memory path).
+ */
+int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue)
+{
+	unsigned long bit;
+
+	if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
+		return -EOPNOTSUPP;
+
+	amdgpu_mes_lock(mes);
+	bit = find_first_zero_bit(mes->proc_ctx_bitmap,
+				  mes->proc_ctx_array_size);
+	if (bit >= mes->proc_ctx_array_size) {
+		amdgpu_mes_unlock(mes);
+		return -ENOSPC;
+	}
+	set_bit(bit, mes->proc_ctx_bitmap);
+	queue->proc_ctx_array_index = (uint32_t)bit;
+	amdgpu_mes_unlock(mes);
+
+	return 0;
+}
+
+/**
+ * amdgpu_mes_free_proc_ctx_index - free a process context slot
+ */
+void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue)
+{
+	if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
+		return;
+	if (queue->proc_ctx_array_index >= mes->proc_ctx_array_size)
+		return;
+
+	amdgpu_mes_lock(mes);
+	clear_bit(queue->proc_ctx_array_index, mes->proc_ctx_bitmap);
+	amdgpu_mes_unlock(mes);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5c50bc9616b7..33a426f58e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -279,6 +279,7 @@ struct mes_add_queue_input {
 	uint32_t	exclusively_scheduled;
 	uint32_t	sh_mem_config_data;
 	uint32_t	vm_cntx_cntl;
+	uint32_t	process_context_array_index;
 };
 
 struct mes_remove_queue_input {
@@ -631,4 +632,8 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
+int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue);
+void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 61e5f8a06eb2..8bb0d3213abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -100,6 +100,8 @@ struct amdgpu_usermode_queue {
 		} va;
 		u64 va_array[6];
 	} userq_vas;
+
+	uint32_t	proc_ctx_array_index;
 };
 
 struct amdgpu_userq_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 0bcc5afc9e84..e1ff0f22a6e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -121,6 +121,7 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
 	struct mes_add_queue_input queue_input;
+	struct amdgpu_mes *mes = &adev->mes;
 	int r;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
@@ -146,7 +147,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
-
+	if (mes->use_rs64mem) {
+		amdgpu_mes_alloc_proc_ctx_index(mes, queue);
+		queue_input.process_context_array_index = queue->proc_ctx_array_index;
+	}
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
@@ -165,6 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_remove_queue_input queue_input;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct amdgpu_mes *mes = &adev->mes;
 	int r;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
@@ -175,6 +180,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
+	if (mes->use_rs64mem)
+		amdgpu_mes_free_proc_ctx_index(mes, queue);
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 195dc3b4058d..db09f63ec1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -335,6 +335,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.process_va_end = input->process_va_end;
 	mes_add_queue_pkt.process_quantum = input->process_quantum;
 	mes_add_queue_pkt.process_context_addr = input->process_context_addr;
+	mes_add_queue_pkt.process_context_array_index = input->process_context_array_index;
 	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
 	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
 	mes_add_queue_pkt.inprocess_gang_priority =
-- 
2.34.1

