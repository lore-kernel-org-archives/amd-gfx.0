Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179C2C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3206010F690;
	Fri, 29 Apr 2022 17:47:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B87E10F59A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhDnUgqa7+B9d0v1MHn1issiKg23kxZ5iyupM/ikfGFVVgSpooHX0qU2Z9/tW8vvRQ8pEVKbGZWGjkyMHixP2d/vQjkhSTFiWcXtA0+B9maICtEDaaUmNz1oA2XBI+cEwB8k01QFtYoL3iMJtDS3kcH+sLa6JoZqhYO5ZleSRMn4mDSA92ahGEzszquLTOeeF6+POYh5hv67nBqZDZL7iUVOdYFIH5fg/gaY839qOowaQg0m4LmkxiQPlgpXZDHSDgkDWUl2s0vi2xsszUl5xgnOXI0NfQHi5OxS2awXychYK/jJ/H9wYSAtJaJxPx+0cQWpxxACvmxrRFLCFisR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSl4XYsC3J1/skdAR3kt6QuwCH8+LA3o214326rCUg4=;
 b=ViMPDFQ9LZ0IkshmZDNGz+T+RE9Otj/GfHf4I8dgURcEGgRdXBc0gw8ewYPrBnEi5cTdLOVhNVFSuW/Bgff8Y24DSjOS+XnVhIBtl+QpkiMPcPtjxdYoXh1llC/aXN+JS+vbuwaVa+gs8OvElVL0YY4hSZMLMFjDWY05eCNHr34tkNcVv90cEYVGXaGqW1GCaftHh75iC+y0vKoghRmPjW/dwNrMDW1/293MkiyDdYgiKohdz6gjq3Xj4zDR2H58UlqoCtdwzpdsjYPF7BvnPLCC56cbbjtjf7//EU0vmsStpOPFTiv3e8/Gmx05BaFHs556c6xfQbIuVksBRcQZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSl4XYsC3J1/skdAR3kt6QuwCH8+LA3o214326rCUg4=;
 b=4DX5gAREUgS/kmIGp+oHT9TVkOnjGB6cn3tUHAsJReENKtUPxJy8cqVQGGlbkbqVbcAuN4SLzvDOmRnBw1H+dOI7j2/E7Eeqf5+DfqheYh+fmJ4lRgAeC1kSqkpgF+JoR16gM8P8Ha7swD3T8zLkl5BUPv4DQgPaFz5aOmILwoE=
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:21 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::74) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 71/73] drm/amdgpu/mes: fix vm csa update issue
Date: Fri, 29 Apr 2022 13:46:22 -0400
Message-ID: <20220429174624.459475-72-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4720bef-9f07-47c5-7f69-08da2a084f91
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2504D949F98006E048D897CFF7FC9@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI+HI+YWIoI2eHDjJpgD0ji19YE8mpUDYqGnaVtniYXHO50kHz4ccqZ52pC4ZYCRFsfaWwALsRDlIL9jvupOWZVizlpqSsXf1dFUaSQlZWRZsYHmEg++d7jp57/9eqTJ08qF+Teat6B50ryV4qrJccV1E+fTlG57B+NnaCn9Hr7RDv++95uPgLjQHHjdrCa2LZIgsWLdxULlO7SGFczQZLiNnCAGTOCZgn8XvxHbz7XhZwPkjvr0nnVzZA0+b+lVgvj9efooC1KPjWDnG17NwTsDfoT+ik+D2WGyNTQOX1r8ISuNHDQ4TdEB7R0WDr5YQySAtaipBXG2WxnCejixNPzgPK7YAc3qF7vaLs0AT4cUSOUCzZ2MXHzxiTEup9EwrUUkxfHkVOgaBefun3z/Xf3HArJAmaqj1eBds1u5yM8ISVoKyCf0TomFJq/a+7fW98Eix9+AhkE/HkYbr/9hOAkcjASHzDdhGhKSx+NImR1ysCN/757ltNkeIy3Bami7N4A+yb/BQwxKZ+ZgmDcjti/wNRC0TI90p9ZUFqNSBVkFi59FEvSsKYeacwnn8IMVKGW8CwmMOxHlkSQ6/iAKFZnEGtBUhP8P9PRE9CPw0y5byhBMj5ukeK6AG0qTAW2vn34rRwTcggaWxRzhD/RQ0aRKTRARzx8rJky7Gw25whr+SgdLERKkVokyBpdqVUN6GHHoR6rNakfrUAsZv/mPsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(186003)(356005)(47076005)(1076003)(336012)(40460700003)(83380400001)(426003)(8936002)(8676002)(4326008)(5660300002)(36756003)(15650500001)(2906002)(2616005)(6666004)(82310400005)(54906003)(7696005)(26005)(70586007)(70206006)(81166007)(36860700001)(6916009)(86362001)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:20.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4720bef-9f07-47c5-7f69-08da2a084f91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Need reserve VM buffers before update VM csa.

v2: rebase fixes

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 81 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
 2 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c9516b3aa6d9..51a6f309ef22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -883,40 +883,76 @@ void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
 		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj, NULL, NULL);
 }
 
-static int amdgpu_mes_test_map_ctx_meta_data(struct amdgpu_device *adev,
-				     struct amdgpu_vm *vm,
-				     struct amdgpu_mes_ctx_data *ctx_data)
+int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_mes_ctx_data *ctx_data)
 {
-	struct amdgpu_bo_va *meta_data_va = NULL;
-	uint64_t meta_data_addr = AMDGPU_VA_RESERVED_SIZE;
+	struct amdgpu_bo_va *bo_va;
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo_list_entry pd;
+	struct ttm_validate_buffer csa_tv;
+	struct amdgpu_sync sync;
 	int r;
 
-	r = amdgpu_map_static_csa(adev, vm, ctx_data->meta_data_obj,
-				  &meta_data_va, meta_data_addr,
-				  sizeof(struct amdgpu_mes_ctx_meta_data));
-	if (r)
+	amdgpu_sync_create(&sync);
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&csa_tv.head);
+
+	csa_tv.bo = &ctx_data->meta_data_obj->tbo;
+	csa_tv.num_shared = 1;
+
+	list_add(&csa_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r) {
+		DRM_ERROR("failed to reserve meta data BO: err=%d\n", r);
 		return r;
+	}
 
-	r = amdgpu_vm_bo_update(adev, meta_data_va, false);
-	if (r)
+	bo_va = amdgpu_vm_bo_add(adev, vm, ctx_data->meta_data_obj);
+	if (!bo_va) {
+		ttm_eu_backoff_reservation(&ticket, &list);
+		DRM_ERROR("failed to create bo_va for meta data BO\n");
+		return -ENOMEM;
+	}
+
+	r = amdgpu_vm_bo_map(adev, bo_va, ctx_data->meta_data_gpu_addr, 0,
+			     sizeof(struct amdgpu_mes_ctx_meta_data),
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
+
+	if (r) {
+		DRM_ERROR("failed to do bo_map on meta data, err=%d\n", r);
 		goto error;
+	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-	if (r)
+	r = amdgpu_vm_bo_update(adev, bo_va, false);
+	if (r) {
+		DRM_ERROR("failed to do vm_bo_update on meta data\n");
 		goto error;
+	}
+	amdgpu_sync_fence(&sync, bo_va->last_pt_update);
 
-	dma_fence_wait(vm->last_update, false);
-	dma_fence_wait(meta_data_va->last_pt_update, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r) {
+		DRM_ERROR("failed to update pdes on meta data\n");
+		goto error;
+	}
+	amdgpu_sync_fence(&sync, vm->last_update);
 
-	ctx_data->meta_data_gpu_addr = meta_data_addr;
-	ctx_data->meta_data_va = meta_data_va;
+	amdgpu_sync_wait(&sync, false);
+	ttm_eu_backoff_reservation(&ticket, &list);
 
+	amdgpu_sync_free(&sync);
+	ctx_data->meta_data_va = bo_va;
 	return 0;
 
 error:
-	BUG_ON(amdgpu_bo_reserve(ctx_data->meta_data_obj, true));
-	amdgpu_vm_bo_rmv(adev, meta_data_va);
-	amdgpu_bo_unreserve(ctx_data->meta_data_obj);
+	amdgpu_vm_bo_del(adev, bo_va);
+	ttm_eu_backoff_reservation(&ticket, &list);
+	amdgpu_sync_free(&sync);
 	return r;
 }
 
@@ -1029,7 +1065,8 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 		goto error_pasid;
 	}
 
-	r = amdgpu_mes_test_map_ctx_meta_data(adev, vm, &ctx_data);
+	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
+	r = amdgpu_mes_ctx_map_meta_data(adev, vm, &ctx_data);
 	if (r) {
 		DRM_ERROR("failed to map ctx meta data\n");
 		goto error_vm;
@@ -1075,7 +1112,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 
 error_vm:
 	BUG_ON(amdgpu_bo_reserve(ctx_data.meta_data_obj, true));
-	amdgpu_vm_bo_rmv(adev, ctx_data.meta_data_va);
+	amdgpu_vm_bo_del(adev, ctx_data.meta_data_va);
 	amdgpu_bo_unreserve(ctx_data.meta_data_obj);
 	amdgpu_vm_fini(adev, vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5c9e7932c7a9..a965ace0fd0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -264,6 +264,9 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data);
 void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
+int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_mes_ctx_data *ctx_data);
 
 int amdgpu_mes_self_test(struct amdgpu_device *adev);
 
-- 
2.35.1

