Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B7C98311
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 23:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E5110E3E4;
	Wed, 23 Sep 2026 23:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQvL+n+H";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B816F10E3E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 23:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0iW+30AbKQqXozl3BPxrQXS9JzkDjVwebtGY8UqB2XuAv3IY7ss+0eQOK6G6w3tx1cqwsxhjQWuqyCwtUZPJjeZ6CcBIoyEIZ0beAbKlDu9nMKLyB1ldtjJeEvF31cLke7CWFYjxUZSE9HuyTm2V42y/FI3MtGcGIaZo1zDxcv+ttyzD3ddqMt0Q5AcfZDV35ShEzC63nZ2VvC8XrvDqTWlMrQdsrsn1wPL7+ETkWT0dbk9eDLMmzUHsUcxKCToCO7wxH3LGL9TLMeCyfsGYtNOA9OnPJLnphPvgPPKJq7cU3nc1KCMtCS/5WBMp3cMIITW/MbopgmFP90l6VcuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqcwXkKXSXsB8lllTWI3a8ve3LWlTCTScAd3AROom4o=;
 b=Bk3rmQlBPaeOGTms5nD41Kt+FoblobCPKQ61CF6hxXkaYFWnZviw6fTRm/R+N9KZfaOdrOi37ALcCsq/yjNvTueTRdjb5NuhXtVo2MJ6obMbFV5vqVVAu7brplZQ10Fj6Ozi99eWOXEi9UJiroZ2vd/DwifRWfhHz6RSvv4r/4jSz87fWA8WsHCq3URMzZLx/kSB2yfhOQr+KR+iAUS+YIzhhr++b45oc08uRYzGWfFDJsCqADrvXzjlgB2NkFkokKwLHr6oOvVTsdHwq+mwzIHvO0pMYfAI32Q2nGhyR+kHq3sLPJ6Uvv/F5cHV1pZkdkVvgHYbbgqLHDTdfz2bGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqcwXkKXSXsB8lllTWI3a8ve3LWlTCTScAd3AROom4o=;
 b=MQvL+n+HKx02UnwhxZ1k3NME+24jr37/Wgm3ojCVdVUXXFEWANjcv9YaYWgDqpePXxAwZJYhbYXk+n6mQphMqFEmTqa0GlvDb09ALypkOmDwFz/tV1pYoz+v/HuP3BCZt3UHOEXAjGNEidlSC8WVbF6JlEYfkoI69TYK7y2Tz08=
Received: from DM6PR07CA0077.namprd07.prod.outlook.com (2603:10b6:5:337::10)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 23:47:00 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::9f) by DM6PR07CA0077.outlook.office365.com
 (2603:10b6:5:337::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Wed,
 23 Sep 2026 23:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 23:47:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 18:46:58 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 18:46:58 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH] drm/amdgpu: reserve fence slot before userq eviction rearm
Date: Wed, 23 Sep 2026 19:46:35 -0400
Message-ID: <20260923234646.101279-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a860c8e-83ed-45e2-b223-08df19ccf607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|56012099006|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: dYjDuUFlvAqgBieXZC9YBSjRdhSSm9AFrTLOC8Lp89DTi9gxOBWKZg87m6R9Gl/7mckcsebskHZBPVzTZpKP+qzO6LcGVawOxrb5u0Vqpyd+ci0MyIrjnxs4nhz/2gEMKaLAosdapD5IEMNLv+o7j1mhbFM4FBTnnzgpYLxHDfxcLy0th9MB/j3+25F7XB68wFvl7o5H7AY8RZNMvtkEcgjkqcB3tIHN4JJYUiGnn2630PmlsKoscfFSoJuAjxLfGaelli+fQiyxeFuQxBuAJnLRXIZthVbdhdlQwk/fxlqUW/7OMVwfFuJshI9HydXyp6hll6XIqfl+ZFPhbtseByljqbp2ZhH9LEdJsL2Mtmvvl5VD0UVmVknM//vA9bb1KbSe1SAVJz6umcO6NnegSXIyrQfHlxBjMoLjODVfX4E+9mXWN6belme42t0f2fJvIzdQgjSYSWFQh/yTQS8uVlZglNZC7ldT5u3kH7zXGN2C6+fmG5ykn9xpSUxk+Ps0GedfoSLNYCn5xnl3CM+BuWP/VPt9w8syH92kkOED0oDExuLtmhms/tP6bj7cpmPBMl3JjzzpJdqFVt5riAk9336nxhmJza5siUkBFhF3FIQ69Y49jtMSCmtoXcqiRDyx0xSc9UXqhguEMBoNSbDAZE+O6Lr09yviMvmzmOLs40GMfXUs560bQCnS0lpqJcZ2xYFaqbvYKRLDqjIQTDns3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Qbov6ytwh6gys78XURpXJcgQIAy3P9aNClEl6ghoSlCtcyICCrS7TQ3bHeOfJNIoQas+7ykSOP9ZBgYprivwHn2xZe5ig3IvM2cOzv+9GpVa2sqy1AKueE/7ttpC9/fdkgprhJJQZOHbNktNw0MRa6edouQTPmUYA7vaBitj5cE7JwBSpHROov/tuTTFZku1BagChXiXE9vpeKFi32PqSavfz4RowB+gJh95MqGNij6NpoMcQD64SkoYEnwGmPeAmmP/ygCGx2lhKH3wH/9mT3HA3R/7dwaLY7AnZHLIfA2IIaYdT5Tg+6m/yNAGrcusH+sbB6FabsBCG36+HRPRuXk4piXNLqezKOR8LrAzLy7geXNBx41RyzWNgHCFNwc4nCxRY/IIzC3GAfznnDIagqjrL7bfpE3HJfTe47co1X7eKLOqz9reQc+JjW7UZxl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 23:47:00.0808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a860c8e-83ed-45e2-b223-08df19ccf607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

During amd_deadlock userq reset testing, the restore worker reached
amdgpu_evf_mgr_rearm() with a locked reservation object whose fence list had
been rebuilt after validation. When all previous fences had completed, the
rebuilt list contained no active fences and dma_resv_reset_max_fences() left
num_fences and max_fences at zero. dma_resv_add_fence() then triggered:

  BUG_ON(fobj->num_fences >= fobj->max_fences)

while adding the replacement BOOKKEEP eviction fence.

The v1 proposal attempted to call dma_resv_reserve_fences() from inside
amdgpu_evf_mgr_rearm(), immediately before dma_resv_add_fence(). This is not
valid. dma_resv_reserve_fences() may allocate memory and replace the
reservation-fence list. If the replacement eviction fence has already been
created by rearm, that allocation can invalidate the newly created fence
state again. This is the ordering problem identified by Christian during
review.

v2 reserves the slot in the restore caller, before rearm creates the
replacement fence. After validation and GART work have completed, the caller
still owns every reservation through the DRM execution context. It refreshes
one slot for every locked object, allowing all possible reservation-list
allocations to finish before amdgpu_evf_mgr_rearm() creates and attaches the
new BOOKKEEP fence.

The reservation remains caller-side. The eviction-fence helper does not
reserve memory and only consumes capacity prepared by its caller. The initial
caller-side preparation is still required for WPTR BOs and VM BOs, because it
covers validation and migration fences; the final refresh is required because
later validation can rebuild a reservation list and discard unused capacity.

This v2 supersedes the v1 helper-side approach and the intermediate
caller-side allocation commits that did not refresh capacity after
validation.

Fixes: 91a358fe99d86 (drm/amdgpu: dont pin wptr bo instead use eviction fence)

Reported-by: IGT amd_deadlock test
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c6..a1b6ce8b348e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1034,6 +1034,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_bo *bo;
+	struct drm_gem_object *obj;
 	struct drm_exec exec;
 	struct xarray xa;
 	int ret;
@@ -1210,6 +1211,13 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
 	}
 
+	/* Re-reserve the rearm slot after validation may have rebuilt the lists. */
+	drm_exec_for_each_locked_object(&exec, tmp_key, obj) {
+		ret = dma_resv_reserve_fences(obj->resv, 1);
+		if (ret)
+			goto unlock_all;
+	}
+
 	ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
-- 
2.43.0

