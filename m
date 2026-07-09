Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AA4C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB94810E028;
	Thu,  9 Jul 2026 06:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjCTr+vW";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9965610F3CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEfXvkX2N27CMGFJ4U4cKxiYtarDE45sDA3VztTsiAM7d1Tg4ByZLZsk83GM23kQX+KIzqtiuq5pTNcERbE3TjRsrrB2yd7GTrIAQGUtTzGFDQKL3vTrfwhhNcZcM6Ua9Q2euEUbTEtlU4y93bfSc3UlBwJa6MxSqTmB31D/NRMY8iMzHs+MuZc8tUq7ryDT5xVQ+jEv1qLP1LYdKG4UD07TkUaBSRMX1DYieZ0BOWbB0pYQaP60bos/0sW0MqZ1qgn/30D9Y6nldby11Tp1beD9AhXuoYYxTR8kIHokI7d89Lc54laSFlrMvxwzbo08ws8n6NgZKaSH2gIX34LtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr/k31jv5FfasurR6Hc3FeDBCutRnZ4jr3lSIgHE3g4=;
 b=Pbj0quaQMQSCYL99ng+kyhfmhKg5gPYeGpZdPcq4CWer2CEcnN4EROd4wmwQt4GsFrnNiy4jUG2FgPF+BZZtxYTbVwWX88WgLp/DnvU4CiIZubx0Y/AmKXBC9Uk2GJos890iLw1MbSOOmZLaCicemavOTWG3Zo0HOfMVmxByDhna0u5SZknVjYoinX1nI6ULFx+k3yAO4jzBxIeZB5sHzZIGm9EptmfN1rkRuitC+IbJ8PspHslwVUV4VxNLVFi/kjJeMNLNdV2eRi20+inS6THNv/Prqb5aMsTWl9DbL+q4NbJfXuDDvY4YZOldG0nVcc4ppJMATMgRGO6relqbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr/k31jv5FfasurR6Hc3FeDBCutRnZ4jr3lSIgHE3g4=;
 b=bjCTr+vWuJFqXewQf+I4VXKT/e2rzWAE4P7IYIm9nTPRyj3pBbZS6ieo4wyFt1lmq0ViPec7S8ydRRpY+XcfpvgewzoPCh98k0WxOOI/6Ws3k/oS1Swah9XwMHsdpWsXKkR136ctvfoRthvmtwYzLoPP/Okh8vMxTbHCCOm7dz4=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 06:59:14 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::3f) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: add mes gang contex alloc/free helper
Date: Thu, 9 Jul 2026 14:58:55 +0800
Message-ID: <20260709065856.472296-5-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f85da15-544d-4704-cb68-08dedd879621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lv0jT8JplD2X8ORoxvZuS0J29HZHMkgV3d884bZkLn1TUi3BsZvCvC+Xd/UYrzekJicuvSvBSIZyfBZideeCndS/5x3BovXppjYg9val+VEchfJCZPDktIAgFhowRyEfXUyQnLkQNHC9NQ+8tBtqlebkMDsJuSCaBeyrkGrLOhc2+84P1rCG1fuxZ5/miF7IbAvAdy2zzJ5zEkKvAoNVUow3DPLKGYYRFkEhyygRo9G6wprleCY1V/KoOD1r9m7bJluKiwrAn6CZ+0h0pb56CkwE0lHo0+k1vt6UDaFfrwSy89Qlz4EF5tRdZ9DQrN/E4W7DuMT+b42u8A5M3bTnjmp7wAaGk2UTDsuNhugFdoyFrzMwlTMjErJfIRk4aEEG19Qse1qljpqskNgTJamsxkld40iHippU15lVmJRY8jeD4ii4x97ifnfqYrEn+y5aOGKXvTlyDXFY5ADpGej6jy8nwUgf1FY+FWWHTd9AEt9zko4f6jrN+myhiiDqnN6zu59rYzsRvwK5pwFTp7DihsHRBAvshqZs/W6NHQ2Wr4ZXpFPWzX4Ah96WbCHkkpfNfSyWPqNp227o2fmjkT2YcTRITn9aj2nqaf7sEpnMFRi2ISz18vAy3U/2iBppNb1t0Nn8WvjcWhhNjs8XoVLAOylc8b+rLr4rdO+xUa83AAnQ2lupev+fVHi31tCtzJ6suGbmnPP4mMrsnbrBiNw7Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5z2X7roV4JGOuDmO/u/baPVeBDIJweWl7G1ZMR3pabZUKegRlbyVnDXIGRy09mMDonEyeqf8semsYH/b6Pbp+UPQJcbuF2bLkva8YJAlc55LZj2hBSVTzrwkAEi39kq4snZHVAEXhkCknAQrPr1+toG6OOjd74oLHj/RTbn0lff1WJbpON3fAaZ86RpqKmS5AxdRX2A20XX7ucbUt4jzTlzRk9Cisa36g6whXIrDiQalrnhO3+NLWCxf7zIMpQpBc/wNPRJcj8Db3G20MD5vzUjCpb4Lcr6oFdSH5Zek4PfDBOxe7as17By7Tmwf3NuNR9kke3Mj6NVA/vJBM2003nHfjNgq72SDnc3jkXghboLVkRkUyp9SNeVj11lAtIdzzu79P10odg94d72mnXqEc5JW6vJr3ubSbDAKTI7GISc5oCEAkyIePPJ8lfXK7trI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:14.1031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85da15-544d-4704-cb68-08dedd879621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

Implement the MES gang contex alloc and free heplers.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  7 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  1 +
 6 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index db9c46ece2a0..56671f98b052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1081,6 +1081,47 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 	amdgpu_mes_unlock(mes);
 }
 
+/**
+ * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
+ */
+int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue)
+{
+	unsigned long bit;
+
+	if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
+		return -EOPNOTSUPP;
+
+	amdgpu_mes_lock(mes);
+	bit = find_first_zero_bit(mes->gang_ctx_bitmap,
+				  mes->gang_ctx_array_size);
+	if (bit >= mes->gang_ctx_array_size) {
+		amdgpu_mes_unlock(mes);
+		return -ENOSPC;
+	}
+	set_bit(bit, mes->gang_ctx_bitmap);
+	queue->gang_ctx_array_index = bit;
+	amdgpu_mes_unlock(mes);
+
+	return 0;
+}
+
+/**
+ * amdgpu_mes_free_gang_ctx_index - free a gang context slot
+ */
+void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue)
+{
+	if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
+		return;
+	if (queue->gang_ctx_array_index >= mes->gang_ctx_array_size)
+		return;
+
+	amdgpu_mes_lock(mes);
+	clear_bit(queue->gang_ctx_array_index, mes->gang_ctx_bitmap);
+	amdgpu_mes_unlock(mes);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 33a426f58e72..c67db2d6e122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -181,6 +181,7 @@ struct amdgpu_mes {
 	uint32_t			proc_ctx_array_size;
 	unsigned long			*proc_ctx_bitmap;
 	uint32_t			gang_ctx_array_size;
+	uint32_t			gang_ctx_array_index;
 	unsigned long			*gang_ctx_bitmap;
 };
 
@@ -280,6 +281,7 @@ struct mes_add_queue_input {
 	uint32_t	sh_mem_config_data;
 	uint32_t	vm_cntx_cntl;
 	uint32_t	process_context_array_index;
+	uint32_t	gang_context_array_index;
 };
 
 struct mes_remove_queue_input {
@@ -288,6 +290,7 @@ struct mes_remove_queue_input {
 	uint64_t	gang_context_addr;
 	uint32_t	queue_type;
 	bool		remove_queue_after_reset;
+	uint32_t	gang_context_array_index;
 };
 
 struct mes_map_legacy_queue_input {
@@ -636,4 +639,8 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue);
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
 				    struct amdgpu_usermode_queue *queue);
+int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue);
+void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
+				    struct amdgpu_usermode_queue *queue);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8bb0d3213abf..8333bab537d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -102,6 +102,7 @@ struct amdgpu_usermode_queue {
 	} userq_vas;
 
 	uint32_t	proc_ctx_array_index;
+	uint32_t	gang_ctx_array_index;
 };
 
 struct amdgpu_userq_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e1ff0f22a6e1..0dc10553dcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -150,6 +150,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	if (mes->use_rs64mem) {
 		amdgpu_mes_alloc_proc_ctx_index(mes, queue);
 		queue_input.process_context_array_index = queue->proc_ctx_array_index;
+		amdgpu_mes_alloc_gang_ctx_index(mes, queue);
+		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	}
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -173,6 +175,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+	queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.gang_context_addr = ctx->gpu_addr;
 	queue_input.queue_type = queue->queue_type;
@@ -180,8 +183,10 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
-	if (mes->use_rs64mem)
+	if (mes->use_rs64mem) {
 		amdgpu_mes_free_proc_ctx_index(mes, queue);
+		amdgpu_mes_free_gang_ctx_index(mes, queue);
+	}
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index db09f63ec1ad..c2129ea6614b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -338,6 +338,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.process_context_array_index = input->process_context_array_index;
 	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
 	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_add_queue_pkt.gang_context_array_index = input->gang_context_array_index;
 	mes_add_queue_pkt.inprocess_gang_priority =
 		convert_to_mes_priority_level(input->inprocess_gang_priority);
 	mes_add_queue_pkt.gang_global_priority_level =
@@ -388,6 +389,7 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_remove_queue_pkt.gang_context_array_index = input->gang_context_array_index;
 	mes_remove_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index dfc27be4454d..04005a03987a 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -360,6 +360,7 @@ union MESAPI__REMOVE_QUEUE {
 
 		enum MES_QUEUE_TYPE         queue_type;
 		uint64_t                    timestamp;
+		uint32_t                    gang_context_array_index;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.34.1

