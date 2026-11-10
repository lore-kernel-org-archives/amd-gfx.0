Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B1606A753
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hDo69iH6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3631110F6BD;
	Tue, 10 Nov 2026 13:07:16 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310B110F6BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGp5mGfqjMhIZM3/gdDviogxSFFWo+IuJ12fdYaWEC0BaPNgsQQ0cBQJ5rvxX3QVWPY6wkMxoQ08bKs4LUpT7k+ui+cgxjIOmR1RGGXe3C2PtH5aJNB77vwaZvWhdWq+srLLbaHQQyFvjUKBXT8N4TwiJe32CUNuztyZ9CiqkLERPoJs5wTi6xojvqE9jtePdAMozZcBYAiMlxH9bDPW+4tmA0QsWfCEMO9o3w9Yd5t32CeNQ+jNNUagw8RGwH34rwHUrSwqBH+VZniVskupzhAMqPXDy/NhN0soS0nTejxs4Aidwy8JrcNBqUiOFj46GR1gWOz/3vTZb+uu6D+tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1wVC8ne4ZT8BjUtIRG/MtsarYXWdE/VBgYYK7ExyMI=;
 b=mjqbSfeH4R+Bve4on/MXjoh/1qcerhu2Ggziz9evmJDi4ZebQGk7PZ+iF4N/VprW1aBmS0Kf3JLTE9ctHEY66nMCNBXAWzyPGlD/d95yl0IV0CqnQGzitSGPJIMF1Pn9VBu99aScxhHKvr4Rkf75mw8YeGWAuaUjPU/PA3BYu9MndGWGBpF70tdPBqvayHE5gKxHAj8TX71+mFn9W7+XTuuHkYBeU/BAgmPqePrR3jOFO457zCsA7Qxl4XT4Y9ys3pwNdN3W4FWqjBm/dFpOYbv30EUUQ3Ilt+iP7QwevOyq4MNp7ZhofGXlpciTEBRuJ2C7aeKuXunLh3+q+H294g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1wVC8ne4ZT8BjUtIRG/MtsarYXWdE/VBgYYK7ExyMI=;
 b=hDo69iH6wCrU8al0XCD1iHUsYP+VG7R74e6BDBOcrTtUdTXWDEMRbwwXujLAdNe/bAvWqaE/vJxnQp6WecgotVInTS48wm4vE5ICBUuCV5zLWak/I31wl3FxE0+A5oUKDh/flM0gBQr5h1PmpWTG5UKm8GeMhy0yKHVC8dXBbyU=
Received: from DM6PR02CA0165.namprd02.prod.outlook.com (2603:10b6:5:332::32)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:04:59 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::a2) by DM6PR02CA0165.outlook.office365.com
 (2603:10b6:5:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:04:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:04:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:04:56 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot with
 its buffer
Date: Tue, 10 Nov 2026 21:04:36 +0800
Message-ID: <20261110130440.474374-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3d6ebd-f1e2-4912-d47a-08df3f2b3967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|3023799007|11063799006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|10067099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: UUEDvILYzlMK4oT+VjoaT+36B2urJ+zrHjG+KZgz8UMzcYDWC0NAwbGguunmFotRHp9wTBGJsSJB5LSYRh0ccNg3v2+gBJs0y4q0meyRmE39AXJ0Ry+lGkZ57NMygbP+/jn1HLn9ewAtLfCrhPwmmsXPTnGAFUNXOWiVHWdQsBavXqNWGiMvtx6P3eCFE6kwFdgzD6UouoUBI3i8caxUMxtzULvtsqoSqk1HC4Cm/g3TIVq7RdU8TCLRtjXxwKhjAyH1T9CIh8tDP56Le4z3BWQ/zRJoDdEBeoSkT3I7etqg2ONN5fDqBNRIl6Mbjw+eXnvP6LPcbQN5x0qhSziQxt/QImIWsCKZF0MbX5iG4DQLrd4skPtjdYGCoQCAITB52f8Ds4usvE+OX6+KLUNEoOtkfn9ICD8S4EyZ0Rtf8zFb/LProdoDpCXyLjoBEC5Cv+VVSfJJ6uLmMQq3fxKqR+DfHS+kdAbQ+BM1crT0n6Z7PQa/Evl36kZaCHacUTG7OtVbAoAs6PhJEiPzbbL7h+RFquKJkJ4WrOJGCBhFFDdYjTKwuIfNI8yl61+6CB3SRj2WUsQvIF7ZPyfx+JLoVwz0171RUXNT6vkXIovW6uOqgMI0LCfzztNn0RiPYoD8fQby+AWytM/Pj2uO5gXZwam0phkVoYHhtCD24epZlobTcbg393Dv60e3shCfv+mkmwi7rxOLNE88lPJI8Z8kew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MY1NhG0Sdhls+IZ65x0yALiY5gyiF5n33ujfHdj7alu+D8tiL319h1CRTkBU3FaZSW515o/XpPEfPiNb6eXhudz01j7G0871ct7HKH3Xae+LSiqe0/IxuPDnHpeCp6jk6j1BOG5fg6TOmTnwHdDNLaYG0C1AFui/qgNpTwMoId84UTjbRGn+6Nyzjqs3enW1qb/G5OufBD8QE6zFYo57zQkB+gZ9GJk5NBcdvXGVrlvjHKRXj8CqylhyyM8EqEwu8KvRuSx4rDGnDrbFEmL1lGfJZCm2vwN1bhZYhxv5JImHs35pAlAxUD+Bq5sIY2jjFvVyWiEOiueketfJD4/wZrsbFdHSw986avJI0qyZOgXPFnCsCGBj5bJipAu0vpuTNvgRtg8kIT8pJPhDiZ4442GJQ4Z86VqgmKFzCJKn8OEVNPvzp3KkrzS3disDaqwK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:04:58.8532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3d6ebd-f1e2-4912-d47a-08df3f2b3967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In MES RS64 mode, pqm_create_queue() allocates a process context slot
right after the process context buffer, but only on the path where it
allocates the buffer itself:
 - kfd_dbg_set_mes_debug_mode() allocates the buffer as well, without a
   slot. A process that a debugger attaches to before it creates its
   first queue therefore never gets a slot: its queues use slot 0, and
   it frees slot 0 when it exits, while another process may hold it.
 - If no slot is available, the buffer is kept without a slot, and the
   process's later queues use slot 0 the same way.

Allocate the buffer and the slot together in one helper that both paths
use, and free the buffer again if no slot is available.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 35 +++++++++++++++++++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 26 ++------------
 4 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index cb830f985536..d5c87de519ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -350,27 +350,14 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
-	struct amdgpu_device *adev = pdd->dev->adev;
 	int r;
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
 
-	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_kernel_mem(adev,
-			AMDGPU_MES_PROC_CTX_SIZE,
-			AMDGPU_GEM_DOMAIN_GTT,
-			&pdd->proc_ctx_bo,
-			&pdd->proc_ctx_gpu_addr,
-			&pdd->proc_ctx_cpu_ptr,
-			false);
-		if (r) {
-			dev_err(adev->dev,
-			"failed to allocate process context bo\n");
-			return r;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-	}
+	r = kfd_process_device_alloc_proc_ctx(pdd);
+	if (r)
+		return r;
 
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
 					pdd->proc_ctx_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 158fa70a1a8e..0a4e8639c4b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1140,6 +1140,7 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *pro
 
 int kfd_process_get_user_gpu_id(struct kfd_process *p, uint32_t actual_gpu_id);
 
+int kfd_process_device_alloc_proc_ctx(struct kfd_process_device *pdd);
 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59a..102fcb401646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1204,6 +1204,41 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
 	up_read(&adev->reset_domain->sem);
 }
 
+/* Allocate the MES process context and, in RS64 mode, its slot together. */
+int kfd_process_device_alloc_proc_ctx(struct kfd_process_device *pdd)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	int r;
+
+	if (pdd->proc_ctx_cpu_ptr)
+		return 0;
+
+	r = amdgpu_amdkfd_alloc_kernel_mem(adev, AMDGPU_MES_PROC_CTX_SIZE,
+					   AMDGPU_GEM_DOMAIN_GTT,
+					   &pdd->proc_ctx_bo,
+					   &pdd->proc_ctx_gpu_addr,
+					   &pdd->proc_ctx_cpu_ptr, false);
+	if (r) {
+		dev_err(adev->dev, "failed to allocate process context bo\n");
+		return r;
+	}
+	memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+
+	if (!adev->mes.use_rs64mem)
+		return 0;
+
+	r = amdgpu_mes_alloc_proc_ctx_index(&adev->mes,
+					    &pdd->proc_ctx_array_index);
+	if (r) {
+		dev_err(adev->dev, "failed to allocate process context index\n");
+		amdgpu_amdkfd_free_kernel_mem(adev, &pdd->proc_ctx_bo);
+		pdd->proc_ctx_gpu_addr = 0;
+		pdd->proc_ctx_cpu_ptr = NULL;
+	}
+
+	return r;
+}
+
 static void kfd_process_destroy_pdds(struct kfd_process *p)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d3149e6d40e4..4646dfbabe75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -387,30 +387,10 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
 
 	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
-	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
-						     AMDGPU_MES_PROC_CTX_SIZE,
-						     AMDGPU_GEM_DOMAIN_GTT,
-						     &pdd->proc_ctx_bo,
-						     &pdd->proc_ctx_gpu_addr,
-						     &pdd->proc_ctx_cpu_ptr,
-						     false);
-		if (retval) {
-			dev_err(dev->adev->dev, "failed to allocate process context bo\n");
+	if (dev->kfd->shared_resources.enable_mes) {
+		retval = kfd_process_device_alloc_proc_ctx(pdd);
+		if (retval)
 			goto err_allocate_pqn;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-		/* Bind one MES process context slot to the whole process
-		 * (per device); every queue of this process reuses it.
-		 */
-		if (dev->adev->mes.use_rs64mem) {
-			retval = amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
-						&pdd->proc_ctx_array_index);
-			if (retval) {
-				dev_err(dev->adev->dev, "failed to allocate process context index\n");
-				goto err_allocate_pqn;
-			}
-		}
 	}
 
 	pqn = kzalloc_obj(*pqn);
-- 
2.34.1

