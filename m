Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 08:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C334A112D18;
	Fri,  8 Jul 2022 08:54:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F0B112D00
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 08:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4KvFVHioj7RLLdinUYu1Om83rwtmoKz3ojtIno3oi8KLtQoDUkrCZnQg8z5GZIgMKwql97jBEf0JQlgX2R+1LdTdJmDJZplFG1CWXFQyO55fzJ2tEkUYhTvH4oETZTrsZdm7a8lS9WOPqhB3fPCsXvfopmyZNgu3onMEc03OARI/KODLDPQNp9oPxt9KP9BYOCsOhcvjdTubVM99/2pRmv9FjuFKoF4LhVOeK3P2DRQSzNsFLwXrMkKakNoJrt/h1ez6GuqOE0X7MtjDPhFr8a6iAQnytlxc+QIF+Ers7HkB4rWSx2KVQsZHWrbXEEL28/rK5tqx3Dw9abYY8MznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL3P6dbOs8Y3eXu07shxakwpeHK/z7mP4+lDcUx2UXU=;
 b=YI5aMf27J3RDiu79RqcCdGbDXEJyHdyQTJpbWNYiWtCg2brgjgEy7Jqun0AHtQd+bFHzKHApeJXBehCCigpxn/P2FKeVQ8IAs0yV4hyPpgq6LT07AubpEmXTZnjxibbivE1aBXK3SfxahC2zv7yhJtnSB9xqgmzVCgXhTxn6RI3jQoWL/bhSzZLt4ikEdj7euDIz6yFDDu8blW21ZCb4tQbCloc4ljs57EB3PZQdrGmG3u+IlHbNIpvR9vFMGrxV0QthHovJ8RnP5Im+0OipQ3S8XwmGECir0NuGkku5NGqBd7x+f/eUTIyEPNOxrOXZTVmCB+61AwMPtQ9RbhIIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL3P6dbOs8Y3eXu07shxakwpeHK/z7mP4+lDcUx2UXU=;
 b=QnQWuUCXti/1+kW7+cowzE5BTkudKUjQ5ohNGNM8v8oEMlVGanF1Vg1cBY3IyNRcVFBu5qFbufyVV5TCZIrZwrvXea+iuQ1p2thb3D5LezrzKfSyc8E1UbiaQTNClHJeHLOnGL5LnvMUtRlFnnD4F9pfBlCPA2tlSxqx8WVjCYI=
Received: from BN6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:404:13f::29)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 08:54:52 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::a8) by BN6PR14CA0043.outlook.office365.com
 (2603:10b6:404:13f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Fri, 8 Jul 2022 08:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 08:54:51 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 03:54:49 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes: fix bo va unmap issue in mes
Date: Fri, 8 Jul 2022 16:54:25 +0800
Message-ID: <20220708085426.1857392-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708085426.1857392-1-Jack.Xiao@amd.com>
References: <20220708085426.1857392-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00f28db-3906-4ea3-d3cc-08da60bf8544
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56GYqRLuguCtLpEynk+lR61Xi4tNz6pFn22IjHjiia6hSaV+eUDCuvQoANuVXrvHEq6snW03HxCqqt8nmuIPfue3UUlbFGiy7j1mrfYtUv/QLIOm2VDjhqQQiJruKETXtlMd5C/53/p4rxUL6VNmaEbytZ25a8/79wdPKGQ3LtKzzGSRnV2sWMF1fXaSW6Er7NPNL0xoCMTHyh+jbLuu+bPeTNhuKEbBCTWK+trrBVUUQqFqu3Ui+Ty6hAT13XmVg8s92zzl1SA1rqyT8i6JIfQ7++4oJqeIYVkFYvXSznZfc1vfgn35yG1WhEMHQS/bL9rJ7f6vtXIF/quij4V7lODOlYPUknG/PPdRefifklxc5msSzUHrk5MsWig5CSx8FxG2AS+07yTDnZmYUMXehLBIDMcHWv6xmR0opz8wwiGmZDeV4exa/Esg57Zf6kyHS21W8qQFZnslI02HqkAa8diyuyqhfCcDOtxSYG74OGMvl2IQLqVZO8949U03824DlMb/PxtFlEiHFnnDMezRee8fEyd8uwzgMOsHblfLci33B2xNfKKfqQWuYST9RSMv3pv5Q0UZ814OXekp+5hxXwgXXrpKNAxU91An/t6rRdzmAEmAXHee57bjLRZWhbx4CQTJfnwM/yEgNnNY/MoUyp59L8cZy+h8DfCJYXYcU4xCD7K33Uy9y/MlTLBuvHrzxS9ekCLnJs4UN+Qbsx/D5fea18F/Jt0HVkISNw06LB1njlRF1nLtY9UHopUXaroq9Zw4KQ0t43A5QmkdpkzDB451s7X/re9E6WdXVqpNgNVeHyzv4N/YBJFSePFLrpn6xD4jaJvScEW81c+wVYFw4O8vSksRSebN6f1RlGlqU1KsD26n5AIWYv9ltP25wagdDMmJOHT7iH8zxQGpcOH+hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(6666004)(1076003)(36860700001)(40480700001)(36756003)(34020700004)(82310400005)(2906002)(6636002)(316002)(2616005)(7696005)(8676002)(478600001)(86362001)(82740400003)(5660300002)(4326008)(336012)(47076005)(70206006)(16526019)(70586007)(83380400001)(426003)(356005)(26005)(81166007)(8936002)(40460700003)(110136005)(186003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:54:51.6621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00f28db-3906-4ea3-d3cc-08da60bf8544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need reserve buffers before unmap mes ctx bo va.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 59 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index db2138b7a858..de80161fb27b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1174,6 +1174,61 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
+				   struct amdgpu_mes_ctx_data *ctx_data)
+{
+	struct amdgpu_bo_va *bo_va = ctx_data->meta_data_va;
+	struct amdgpu_bo *bo = ctx_data->meta_data_obj;
+	struct amdgpu_vm *vm = bo_va->base.vm;
+	struct amdgpu_bo_list_entry vm_pd;
+	struct list_head list, duplicates;
+	struct dma_fence *fence = NULL;
+	struct ttm_validate_buffer tv;
+	struct ww_acquire_ctx ticket;
+	long r = 0;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&duplicates);
+
+	tv.bo = &bo->tbo;
+	tv.num_shared = 2;
+	list_add(&tv.head, &list);
+
+	amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
+	if (r) {
+		dev_err(adev->dev, "leaking bo va because "
+			"we fail to reserve bo (%ld)\n", r);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, bo_va);
+	if (!amdgpu_vm_ready(vm))
+		goto out_unlock;
+
+	fence = dma_resv_excl_fence(bo->tbo.base.resv);
+	if (fence) {
+		amdgpu_bo_fence(bo, fence, true);
+		fence = NULL;
+	}
+
+	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	if (r || !fence)
+		goto out_unlock;
+
+	dma_fence_wait(fence, false);
+	amdgpu_bo_fence(bo, fence, true);
+	dma_fence_put(fence);
+
+out_unlock:
+	if (unlikely(r < 0))
+		dev_err(adev->dev, "failed to clear page tables (%ld)\n", r);
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	return r;
+}
+
 static int amdgpu_mes_test_create_gang_and_queues(struct amdgpu_device *adev,
 					  int pasid, int *gang_id,
 					  int queue_type, int num_queue,
@@ -1335,9 +1390,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	amdgpu_mes_destroy_process(adev, pasid);
 
 error_vm:
-	BUG_ON(amdgpu_bo_reserve(ctx_data.meta_data_obj, true));
-	amdgpu_vm_bo_del(adev, ctx_data.meta_data_va);
-	amdgpu_bo_unreserve(ctx_data.meta_data_obj);
+	amdgpu_mes_ctx_unmap_meta_data(adev, &ctx_data);
 
 error_fini:
 	amdgpu_vm_fini(adev, vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 02daffbda02d..3730df05f6b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -352,6 +352,8 @@ void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
 int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct amdgpu_mes_ctx_data *ctx_data);
+int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
+				   struct amdgpu_mes_ctx_data *ctx_data);
 
 int amdgpu_mes_self_test(struct amdgpu_device *adev);
 
-- 
2.35.1

