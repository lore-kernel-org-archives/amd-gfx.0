Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B27C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2CE10E610;
	Tue, 22 Jul 2025 07:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPuYL8ik";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6F410E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmOB2BtkXYEVZ6MZlJE0JdmFSqeaM5l1rRITBRRqTFixisUPaYD+iKRqSqaFO5QbV5Z8AX+JOf8Yh5msUuvS1iUNNIdTCKmvTLoEnCJiEtQ8p/5LQuGT8M+x8s87vTHAh22sioGT+UPnMYrr/npsvKBzNycwfDj/X4WBE3ZL8l3w6aDi6dkmmmyzbEqmcPk8yk8xcMacCSYP5QBafNxDp1IuiCMtWnZU731H+RzjbvP5ju0glQQnuOxHPJhtVfURUEAWZAQDEO3t2ZYZmfVkd/DWNBDd9EX3ZxUNde/xmgjjGt9rzzbOVOpQAQmcJyVuPTh4dPOWsNgpBQRNbM79oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J3tF6A4PXhUvStuN6zUL3cjY79HMdl5WmSRDV0MQkw=;
 b=w0KgJ2l5gS4ONKaRmeMEn9EO+LFl3KeOmrMkJCf5AEBhByQJmgsDaVUYsAN88MVuW5gtnhyI/AcHX3oKmiQPt5/9tIDka6ll0mFfon7tEzv+dkqeK/HS8Sbj1h9xY0JG/g6+5aT/4rpga1KStmVLzibTqcBixCZt/bMhdpkzDmtTJkm3SpCUTEOKEA3KyQsMTRD8SqnXG4CFHr+2NkGJSdgbe4phBws7S8YaESSNixqovwu/2DFlJLlWeTFzlCx3DqFcpUfxXsvyWpUuT7Lnl12b8x8pAZckssXmQfdgtIj+7oJRIGEt0ugZyleRYcFNmO9Xdy8frshuGxqbR5ikiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J3tF6A4PXhUvStuN6zUL3cjY79HMdl5WmSRDV0MQkw=;
 b=xPuYL8ikDjOobmv1md6STXRK3+isCvRX+fA8Zj2h48HRN1nO6q2J6H5pPkAezSDMUGTabHjpL+oamLcMwQOfh51nobWBI7Qo4GEtE4du1e7/rZ4Lgucqitr/L2greQMrNOCywjghpP6dyAXDdrmzmqochzFQQkS/tbhauBaJyao=
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:49 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::9e) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 07/14] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Tue, 22 Jul 2025 15:46:16 +0800
Message-ID: <20250722074623.1464666-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac4393f-d28c-428f-3b17-08ddc8f3e9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7lqo5qacCOKcnh2tNbid/II7ux9S818pmRHj46WK8R624GBms9ltd34cfFNc?=
 =?us-ascii?Q?wBXCwleI+5JB1irBchwKtsFDEAOeepNElh+aMT5yaTb9eYNrxo2QKTQGDGdU?=
 =?us-ascii?Q?qxG5UIFJSfwvGOUhmKmLmBx0lGy3prw76z2hms9E0XZf4fv09VhGoDNBWwV8?=
 =?us-ascii?Q?Zvb/sy2UbLGuH3FTuRXG6FtStsrKDZNCgq8hB2Z9v0D7CxQP7pNxKEyU1YiI?=
 =?us-ascii?Q?r8PdckLrsPj3maADBMXZyNminGhXQJ0Bphsw6z0IDg8M1J7cECHUV+pa0KOz?=
 =?us-ascii?Q?IzaxY3wNm22SDTfhrbkLtE7V3OGycOg5m80G4xmeKC2RWfJuEL9u6wv4Nps2?=
 =?us-ascii?Q?6ebGyqpHcXLNjoUBdYENaF5t62/aA6WEqTL12FntEPzOXgN/VZsnIGzSx9Qx?=
 =?us-ascii?Q?WSle63SCdlVHzZEvHNbjM6FrgytwYyD197LUSzv0TmUD3LXBZ9MaVgk7VeKG?=
 =?us-ascii?Q?jIaAjl/SiFJcZDAyxCGThxSACXUKN6b2N5N6w6SbKsqw0mhDDCg1k/JaRbSa?=
 =?us-ascii?Q?GXSDqtW/rwM3RIbAESHjfF3vLXpeImOEN4Nl2jcJdgbLxsLQPwTMJPIxF+Es?=
 =?us-ascii?Q?ewBTUZDIebzdAa0OyqTWh7buO/7CSnR4tz/ZOrhawpH6URCRaAuOCIdPYpdm?=
 =?us-ascii?Q?8HOHq6pOx6twSGDGeo0g2H0bYaXdIC/ZQYQAeY9qAzbg4FMSVyCxJtic7nuq?=
 =?us-ascii?Q?hMZWCzgxQo3rh3xb/SSXyIb8/aDxBlySx9orDeXesK4VL6hHnksDbyjPzwSE?=
 =?us-ascii?Q?SjPk0obGm16Tl66E1XT1NHEGcVtT71SHql7l3TfHEG9E++JSTYpRIucnefgO?=
 =?us-ascii?Q?D8YMSP2N2rQwjccMiS/r/kIUNHanJKjZqdIch7e64qun4prdb+KjjegOHMWC?=
 =?us-ascii?Q?308odFgD0BKPmMWo2d6Wr4FWlHaCsSA1f42n2QSydzO4LkvsvzppH79E5jxY?=
 =?us-ascii?Q?wS7gA2R4adwTnJfNsAq16NK4fNZ63hIOex2SicMIkuo+eD8sSNYGKUkuiTcJ?=
 =?us-ascii?Q?Ko7BlUVf1Qoqw7wm86mnwqtcG8kIvJQpFOTi5hDBQ/RWxZe1d4aPqVw/b3c0?=
 =?us-ascii?Q?zI70LaPxhVZXWevRaL0FDJp/KeyXbS6X7M7HnzKhic5AG7t4O4vQkG3u3nAZ?=
 =?us-ascii?Q?ClBz/zz4OXrpKvfv1mhE5L9teEdOxpJJVUQzlRvD2NeAJnnj4swhdcDhDI6v?=
 =?us-ascii?Q?Zw1GmVCzJr4P7ngS6GFPTQxb/IQM2RWax9t8n5IxJf1ktHPA8O/nAtfFX+hl?=
 =?us-ascii?Q?EbO4/a2TiGpnaDEEqYa0c/sZUhEk7ntUWXmFINlnSGx0oKXiLfBsIXgVTBkg?=
 =?us-ascii?Q?fg53Ag63LoaMbHnaufEGh142qZOPHJbCkF0bwezqFY/GocjnjFK4JQgSZigq?=
 =?us-ascii?Q?sft73ov0OVCPONxiLk53YPnoSFP1LA3QA+KbuqGa5JsDyrlFrkb3Vnm8mU7L?=
 =?us-ascii?Q?gjJnHPpY2gbPDqBpVonYAzlJ6q6sQ2TxQF6LqPEgPlYNkxB2iGrbbtWovb2z?=
 =?us-ascii?Q?r8wjBvZgTMCWI+Pqq8TamcoiDvPHUMmfP2wd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:48.2303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac4393f-d28c-428f-3b17-08ddc8f3e9de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

It needs to validate the userq object virtual address to
determin whether it is residented in a valid vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 39 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b670ca8111f3..52dc64384bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r = 0;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto out_err;
+	}
+	/* Only validate the userq whether resident in the VM mapping range */
+	if (user_addr >= va_map->last ||
+			va_map->last - user_addr + 1 > size)
+		r = -EINVAL;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -399,6 +429,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+		kfree(queue);
+		goto unlock;
+	}
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 694f850d102e..0eb2a9c2e340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -135,4 +135,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..6e29e85bbf9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
+	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
+	if (adev->gfx.funcs->get_gfx_shadow_info)
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -247,6 +250,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -274,6 +283,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size)) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +307,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size)) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

