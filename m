Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59132C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C577110EC92;
	Tue, 29 Sep 2026 03:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="147Vkeh7";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700A610EC90
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi2l/qDFDIqijWX5M0JDhr/PnRMBl+qlo8UHnjp8vMR03YLyAyrYQrxM22hGB8/geWasZSvwb529cjIFiGAozs9UxlFq52xNLMDc4tA8jMUb6s23RH5i6RUgge+CX8KdpdtrF8Vmrp0QTbyVq0XxJIljPv1fKjEyC+lnl+uG5AnKOQwZgIAvPc1pCeNsLF7rgU9VQrVTFI7Q4X1TR0WUmjx7rxoPZpcv4Ft39Hhind1lZiVFduY3ONamoOx/PKg8NIhB4yaH/Cca914yh6jAl8WF9rQfsHbxZyBBAF1cVki8wyfYZqPjITaIcWCjekbAblIsKARGzi0QEc2ZQltmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWlF7c7eC4D/rsSqxftnb/vaFKLpmgWDP++C8wLy8R4=;
 b=qeC6HFM8JvxmJrSQkpkJLe3kbgFqjeGD/rka9hGQceqQiplncv25jrYGHp6yuXRlwe5zobIikh/CNxl27fdc+1uTaL1YwEJfiXKHp+GU576e4xUWxUEB7J4LD3V4iGzyYSYacj4o3Z0Tt9JDks196GS53FotilP2NHD1ExEuQYiSelLHjkJgUX3Lm2tqvGtLq16fc2A0SGVBzcmL0e5qXJUNDAIlsG6rI0U6vZBlRKo7Tu6atwPwiayjdD5+x/41o986t1i2rV/zTsbeVw7VmNmZyoPLN/no6dUIBEIlcafFDLHiDBEI6OlnuaXWQp+FFy+rk0l6dab5GjNzxU2cnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWlF7c7eC4D/rsSqxftnb/vaFKLpmgWDP++C8wLy8R4=;
 b=147Vkeh7t4Mv0iqmOmeuzFKsyJG/Pv9o8yuop6yYq5rYwstwvtiMJbpEBK1bz25dWV2/qLk1LNbR59vP8EHZJ7rJ+wkEkYPaPdjLZmbyfO57WOxB6E9SFxkQ1P4Bk7Id6eHwOV4Z9yyYJGo/44j+Wtvm9Wko0cpP8mcf91vgCY8=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:22 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::8) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 03:47:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 13/14] drm/amdgpu: prepare all locked BOs before userq rearm
Date: Tue, 29 Sep 2026 11:46:49 +0800
Message-ID: <20260929034650.2393125-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f80475-95bd-48ee-ed45-08df1ddc5e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: TMWs56qZo6SNFq7FNIUHZReTJJ+egNKcIbZRcX7cjoMNnV+xwDZYYwEmXP1SvJacYC5bRk1xL3tLXyAOYlI/RUZ5y4aMCf8HkvajVC1Uw6pgjaf6Hb+66QL0TbIC77T5ITwY8BIFOwlRROrNuUCSxWdJ+HjdiftIpmn1Wp/7rEoj65pymmK/o6+XPopMqVO2JMqU61SLQCAIka3iJQ5kKW8z7yd55Qu0Ia22hGoZVk51GFDGyyYPmOPLZQ5IGwan7csFk+b5q4mMqOn2OmH5C1FxqBDtBonKMVj/PKYcaz4if49ADhShf0k7u5pzbuB6RQOcLoiWhbP52lRqqgaM/NaT3Bp/ZalJnr5bl8CZnSuHEUyG0NjZW799TW+ew5OSIRotAmAeqjXPRfL5mcS8dEy3CmNuPGmCsHcOusG5Ur3WtLxLYKDQkQR/qPs/nlxbbn6O21iYsiZflXKKS8BWTxDDHfpc7TdkiZHJqLsFgieFdHHOl/AaWqr9OP5MEjMasCE79gsZrUlB1kQCqJ0ezjaH8bENIVluPY1WSNeXs0aV1I2PqBipwMZvrezsfb5Sb8cjQa7qIBMI3hoH2pzZ1Gi7cxjQsJcEJyQpggWGQEdZ1ZZ/Jx/vhKfOVb1ZC0PLTvbarNirD+5Q9hNR9IJFSaIxirnFhac5srgiWJyQKyQU7B6t/APww771o+DlwL/cObDnwzC3InHv+wT0f7BCVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzort4/O4A3HiTgQElZL0tUv0Ul7oUeMAaD7Lw8r9OfMfRoQlStviSDfj5NoaBBmiK9IBxOG4KpdWTH1h1uhXYQo0ZpNCNduxvHmoeWn9hkNDJUByQfp5p5R5RaOrQBfdd7j0VHiRrUJR76MMiSQ8t5g+z48FCjpev3nv0Em0qgpaMWrkcG86igM3jv0j2V5XtML2ZZT+ivSDoJ4o16CdGI6vHK8sVrcTfCUkRD1OOWgB4lcqlXobgIJJopdcQ3ZG2d99+RC+xfXHFxDO76WnJJa+uAUs9ruIk0TmvYQuaNvLU2KdsjrqZGgLIe3urUeF4f+pevfPWlh6CkzktU7A8nNi5NgiHQ7/r9i3/1Y2uqsZMv0VxJbOkE4PRaeX880Q6lrgIz7bULiZFXTg4PKoodoeI4md7nRTIRqPuwRG+5nAchQNvRxHRT+9K3YY9qa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:22.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f80475-95bd-48ee-ed45-08df1ddc5e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
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

An individual BO can leave the VM idle list while drm_exec backs off on
contention during userq restore. The retry prelocks that BO and retains
it in exec->objects, but the restarted VM-list walk can skip its
drm_exec_prepare_obj() call.

amdgpu_evf_mgr_rearm() still attaches an eviction fence to every locked
object. With CONFIG_DEBUG_MUTEXES, the preceding unlock resets
max_fences to num_fences. If ttm_bo_validate() returns without moving
the BO and no existing fence can be replaced, dma_resv_add_fence() hits
its capacity BUG.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 26 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f0cc49213c01..8b2e25770bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -159,11 +159,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(evf_mgr->ev_fence);
 	evf_mgr->ev_fence = &ev_fence->base;
 
-	/* And add it to all existing BOs */
+	/* The caller has validated and reserved space on every locked BO. */
 	drm_exec_for_each_locked_object(exec, index, obj) {
-		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-
-		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
+		dma_resv_add_fence(obj->resv, &ev_fence->base,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e6ce9d12bdb4..0f509e67ca1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1105,6 +1105,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_bo *bo;
+	struct drm_gem_object *obj;
 	struct drm_exec exec;
 	struct xarray xa;
 	int ret;
@@ -1184,7 +1185,21 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		invalidated = false;
 	}
 
-	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	/*
+	 * A contended BO can change VM lists while drm_exec drops the locks.
+	 * Prepare every finally locked object before updating PTEs or publishing
+	 * the replacement eviction fence, including prelocked retry objects.
+	 */
+	drm_exec_for_each_locked_object(&exec, tmp_key, obj) {
+		ret = dma_resv_reserve_fences(obj->resv, TTM_NUM_MOVE_FENCES + 1);
+		if (ret)
+			goto unlock_all;
+		ret = amdgpu_userq_validate_vm(NULL, gem_to_amdgpu_bo(obj));
+		if (ret)
+			goto unlock_all;
+	}
+
+	ret = amdgpu_vm_handle_moved(adev, vm, &exec.ticket);
 	if (ret)
 		goto unlock_all;
 
@@ -1255,6 +1270,8 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	 */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
 		dma_fence_wait(bo_va->last_pt_update, false);
+	list_for_each_entry(bo_va, &vm->individual.idle, base.vm_status)
+		dma_fence_wait(bo_va->last_pt_update, false);
 	/*
 	 * The PRT bo_va is kept off the state lists, so its PTE update fence
 	 * lands in prt_va->last_pt_update rather than vm->last_update; wait on
@@ -1281,6 +1298,13 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
 	}
 
+	/* Page-table updates may have consumed the earlier reservation slots. */
+	drm_exec_for_each_locked_object(&exec, tmp_key, obj) {
+		ret = dma_resv_reserve_fences(obj->resv, 1);
+		if (ret)
+			goto unlock_all;
+	}
+
 	/* Back off without publishing a fence if recovery owns the hardware. */
 	if (!down_read_trylock(&adev->reset_domain->sem)) {
 		ret = -EAGAIN;
-- 
2.34.1

