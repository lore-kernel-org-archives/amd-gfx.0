Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629DFC55838
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 03:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC91410E83C;
	Tue,  4 Aug 2026 03:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qty5gSh0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E6510E822
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 03:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2axLRe1B/cBPYEFvkzDtTKd/dJdJHjnTItIHO6/aGjn4slbczjMbFPZqVppak5uuYP/m3ZfMvLnl2K+i52V+9vJeijhdy0q1897Wg9lXVJr5pzfJCYsjiyqr1JuGzOt+EiUKL9gsPlWWgX5CxfdXCtThUwlvXSqOKRnIL+/EwM1RQVBICP7l5/4r3n5x+7gDUQNXIdRIw1Y91xksDF9qxwFGArxBLVYEqUJu9DnkjS7nnlW6jmR8cb+gREwwda4h8OLo3xuAYFZZhf3c46+L3Iufa29JRTcYoaJZ92jQO0OBcbhZDGHfgBUtUWSoFrjU+AVTxr9vc3/AEhcoU993w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab2V3J+gcFWZu38/lw/GGB1nltCnaeGUcqCcBKYNaIg=;
 b=ghe005KMcmAqNuYZGancQzBZ8kB+AWoxKsz+a9hUheMK69ZfheQx0zWi/jPdwFDgn8IsvSSboElwy6VUzlEKK5ROd9H5Fx7LBELD/4a6+aeZ76CCQg6N6sjD+VwjYHh+35KLxPPXRol4KMl63Zc9TgXrIS38mOL7WQMaT2K/IFNB+/3+H+o0Gj4njhPIRZ6hXF4WmQnuuJB/C8WWfiAyMT9Apiem9cZeVzDLkAEoWpiApXTFL7n+l5UJ6jBvUicrXH/dKP25AbTlorGZ/WNzh3wO1q9idfzwLG/3Ivg986l5uLfJj1bxlPI3FgWGJigPT3YjKtU1zdUkatTWEh830Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab2V3J+gcFWZu38/lw/GGB1nltCnaeGUcqCcBKYNaIg=;
 b=Qty5gSh0fR/gLN2zaSrBb1AM6sbBBeXb+VG/2W0XiOs/i+ZuF0pW6ZqD8JEZYAQDtQ7l24I5zivtiEvnXKZ4UtdOXXNqTUK029HuuULwT1G0MsWNI9AfNuw+q2tBZtNtWHSU+eVEpuhWCWq9LDgS+8LluXsvAFKYhG1P+2SxeVU=
Received: from BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::8)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:16:59 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::14) by BY1P220CA0046.outlook.office365.com
 (2603:10b6:a03:59e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 03:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 03:16:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 22:16:56 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: enable rs64mem for kfd queue
Date: Tue, 4 Aug 2026 11:16:46 +0800
Message-ID: <20260804031646.308213-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804031646.308213-1-Prike.Liang@amd.com>
References: <20260804031646.308213-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6b568e-dc0b-4293-0f4e-08def1d6d8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a3GP52BL5RhTx/+NRccDoEs46tGQKCHfQVRbTJDZZnyGDxuJU4bEDe/NEaj7H/PuoEtrVBRrZfWsVJVwY7dWyKn0txCSrZNVgtV8pSjqENQ7bfUnbact/XafFfg5zJlt2Vcb/ooozFVamFSpyEg7ZOdjXy3GxeIao1Ae2eTfUJ4PtdB91lZApSlkJEVfk226cUF4o4GfWpPFcLTq6cV7o46S2KhPjvvb/iwTGK/Eq9Ld7zrVZjUhQac84VytK4z3eJLatnZEV4HnKj02W7KdSmzQpVCk8mLvCK+KkUq0k1HsmV7muP1YBa0slgKK4hViRH4k0zmXNkB2aq6TvIsf0wBad7kro/iXAIul/iMr2N9lser+RztpaahMG8Aq/PedkQxMxCdHHSNDXTeBks8KGETmEj+kVBbkr66XgJKkOJvidRrjxSf1rgj6RLH9TXEVY+yMzLJptmzsBILkd2IgP96qNxTOh4dyPATM1dEU8W7es3JBaDGui7NGd3xpt+no1Hm861WiaS6fOaEjXA17jPxaNaua5l3TP85mGAO/aA8MAJwzjASETOob19cvrsV+oolw26TQCHuzC4NXbRU6hjHag3SyTPlMxr8xSiZsNBnGyGnJHBIC2Q248Atv4mwDblImAOTMxrsCA/oOdNfZdqp244OIpvXErsSYwL1pJVMd1ywKp2iuoh/ktgM2pQmEBN2/f0jim13jjNQh2zHXTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: as/gjZC0+S84qWAOsVPNy6x0mbZGGvFbNnO1W9VIfTWLk/e5foMYc+z6OepE2tl5/TunnAi9s9wc7ikAzxRsId+N746nWauz3OD07yra2zlXcmEkmq41T0ykICQpPDQgjMqpt634IM8Sd7Trl5seLd9983BJYmY0Okj9ji1JvJjeGPNAl2rw+yoB/IjG88Bozc2a8iMENUb8NEB78T2inxwo/h6DB3uuKOb0OqdEX6xSCde9uTZ7g/EO5qRmTVioIFbi3BwE8c6i2ioC6okk4tZoL2cCDO7/kMOvWfzEhmCew0WEYr+NDEirLKleR5/7Q6uBNs5VG6Vg1GLKCHmgy/kH0hXjYKWSE9a5VffCe0pP1bC25F5XNumSxdNQ0MIFMjLkoIB+PalLT/AHd1joV8pq38/NpR16yZlTurm2dSgoxQKIZk1IuTsL/ShM+NO9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:16:59.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6b568e-dc0b-4293-0f4e-08def1d6d8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation in
the per KFD device process and queue creation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 ++++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 22 ++++++++++++++++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ea9d87450eae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	/* MES unit for quantum is 100ns */
 	queue_input.process_quantum = KFD_MES_PROCESS_QUANTUM;  /* Equivalent to 10ms. */
 	queue_input.process_context_addr = pdd->proc_ctx_gpu_addr;
+	queue_input.process_context_array_index = pdd->proc_ctx_array_index;
 	queue_input.gang_quantum = KFD_MES_GANG_QUANTUM; /* Equivalent to 1ms */
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
 	queue_input.inprocess_gang_priority = q->properties.priority;
 	queue_input.gang_global_priority_level =
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bcb929002839..2ea1cfd330a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -635,6 +635,7 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+	uint32_t gang_ctx_array_index;
 
 	struct amdgpu_bo *wptr_bo_gart;
 };
@@ -871,6 +872,8 @@ struct kfd_process_device {
 	uint64_t proc_ctx_gpu_addr;
 	void *proc_ctx_cpu_ptr;
 
+	uint32_t proc_ctx_array_index;
+
 	/* Tracks queue reset status */
 	bool has_reset_queue;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index eb508fe3ded7..0a7c1900da95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_free_process_doorbells(pdd->dev->kfd, pdd);
 
 		if (pdd->dev->kfd->shared_resources.enable_mes &&
-			pdd->proc_ctx_cpu_ptr)
+			pdd->proc_ctx_cpu_ptr) {
+			amdgpu_mes_free_proc_ctx_index(&pdd->dev->adev->mes,
+						       pdd->proc_ctx_array_index);
 			amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
 						   &pdd->proc_ctx_bo);
+		}
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8054e4fe0381..4b9f195b0ef2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gang_ctx_array_index);
 		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
 		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
 	}
@@ -282,7 +283,15 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
-
+		/* Bind one MES gang context slot per queue (gang). */
+		if (dev->adev->mes.use_rs64mem) {
+			retval = amdgpu_mes_alloc_gang_ctx_index(&dev->adev->mes,
+						&(*q)->gang_ctx_array_index);
+			if (retval) {
+				pr_err("failed to allocate gang context index slot\n");
+				goto cleanup;
+			}
+		}
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 		 */
@@ -304,6 +313,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
+	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_array_index);
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
@@ -386,6 +396,16 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_allocate_pqn;
 		}
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+		/* Bind one MES process context slot to the whole process
+		 * (per device); every queue of this process reuses it.
+		 */
+		if (dev->adev->mes.use_rs64mem)
+			retval = amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
+						&pdd->proc_ctx_array_index);
+			if (retval) {
+				dev_err(dev->adev->dev, "failed to allocate process context index\n");
+				goto err_allocate_pqn;
+			}
 	}
 
 	pqn = kzalloc_obj(*pqn);
-- 
2.34.1

