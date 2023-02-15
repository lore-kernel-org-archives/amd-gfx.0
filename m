Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526E9C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E157C10EB83;
	Wed, 15 Feb 2023 18:44:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8396510EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGhADJCroZTVdhUAifjLFf82LT+himaotnVq8A/Cn9dPCJNhRaEQKErZU1o591ntgDdWQaJhTNpCpjY1kOeDbZgtWKjTpQZXKQEqno419fXv8QokPmZflRxQuGDv7LkXRd7zzrovRI51W355Du557w/sy9Tq3CGJkzuTSzxA7OnUT6/4MIoE3ZXGF7Yg3JSiZ3dJdsANwm/jcjVvwdNF7RvGmvYp3S6quzYPTfIgPPkiu6u07B2x+KD2+LmrqRicSEHEjO0eh4DnorsR2Q5zfGXU7Q9c4xVH5U3stzeYA3OMf0ga4lwaNCrcp6LbKFjOP7LKpKIW9f+oJIF80/0l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYDxK7EFIn2Hpq4dRLBbq8baYnU47MyS8WFmQSb041E=;
 b=UBsNuGVbq+a+MjYapY7AS+qbTxfILzFv4fxKSfS0FZtdYOqF9EU0NOZ3p48VJFjhssTN7nl3ltP9POKZWWEbVuPmIBuIWtAd3co8NleWuIuI3on/K2EPkoBhw8shuVKyQgCiR2Kh8BmfEqRvR0hhr6DohdCJ843HNtM2SXGVlqw0AqPmyrq+qd3+BdevKplNd61iQvhZ35jkXK2hlXxHGCc7bBNlQH4O8w4EBmywaTtJDnGV7BosbpVmUR2FCc9g+rVaJtDZD9M61wRpu+C6vufXFvyIWoJKnjNExIvnEprUOvhvOIIZ8Ro56c64pVPUDUghc4uMYzzoW0V/DWGp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYDxK7EFIn2Hpq4dRLBbq8baYnU47MyS8WFmQSb041E=;
 b=l4wpeMO2dV4URukbNmOWPlTXEeFgSDMuPjqorQtq+gTibO8nBbEQxmkx0jr9N+mQzuUA9X2Ixixam9cXXq1Yqi9bYLgFODSSJc5WMVxS2ZJY1Bmx6WzwSVORz51XXVvCY63s3w28qUSpgyUyELGD7we4wHjeusfKjSmLB+GHjkU=
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 18:44:42 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::2d) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:42 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:40 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 8/9] drm/amdgpu: map wptr BO into GART
Date: Wed, 15 Feb 2023 19:43:56 +0100
Message-ID: <20230215184356.2205-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 729aa05a-c1b5-4a4c-242d-08db0f84b34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SjQKrhqVQfdCeX/AIXyqak/8GqYG7AHdtPSeTOjGd4827V1sFxCmSiZjiJEqZHYn5qWIF+W+hEkZ7AGZqNI1szF3nI2MqP3afza/castm38u/TGHNq1/IBWGWfeN5gIMP2HQlF/lp+1YIxANvgtNUoO9z9nscTEGH+xPWw3I9p8M5m5e5BYZdDykdb6TJasc9c3VKZP/l25YaAVEawMnl9zqoGxTJr8KESiKoHPKOJWocFDkWqhp2/E15kKB2mVpJ/Gp4HJSNxhrHt5XIE1F0bxmPWx1JVHJtabjdpnA4XRXBZqirsdDRlB8PYP7cCsUtsinXw+TJWKklEGt8+UzkdYz/323r6dgcUfg7LHNyQWdqYwv7KwxCITVQqnRk+UZDOzhmd2v5trtAhz9FEhpVc/7qPoInZtS/AqDcsWlK8DDy5ZsXhdR9cc4UFe//yD1HeNU671oc6rHVJ6irqnmKCTDjRE7mgJzuXzZxuTDfPVGVUFDeEJ8ts7+o3PtqIjLgAye9QGAUvnnoh5A+Afkhm9P+qRp1H73WpkH94Vhdi6/2wTeE+ILihdBqDOdH5lt+m1vPmcGWvog16nf87cfR600uVO3GsdFMj+QIQ07Su/fISy0abGblIy9jiEO4IRfFBIayg8tCEFwhq4AtvOxpko2jetNj4iZ4H5V3tfZ2zCkGRUXz2wiw3VFlPPRahEZ7e/X6X53BoiKKW2/QjdegIF0Mt0wFwH1isknou+YpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(54906003)(70586007)(70206006)(6916009)(4326008)(8676002)(316002)(40460700003)(86362001)(356005)(36756003)(478600001)(81166007)(1076003)(2616005)(82740400003)(26005)(16526019)(186003)(83380400001)(47076005)(336012)(426003)(82310400005)(41300700001)(8936002)(7696005)(2906002)(6666004)(5660300002)(44832011)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:42.0683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729aa05a-c1b5-4a4c-242d-08db0f84b34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian
 Koenig <christian.koenig@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arvind Yadav <arvind.yadav@amd.com>

To support oversubscription, MES expects WPTR BOs to be mapped
to GART, before they are submitted to usermode queues.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 +++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 963e38f654a2..33c21eb0f747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -43,6 +43,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static int
+amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+    int ret;
+
+    ret = amdgpu_bo_reserve(bo, true);
+    if (ret) {
+        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+        goto err_reserve_bo_failed;
+    }
+
+    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+    if (ret) {
+        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
+        goto err_pin_bo_failed;
+    }
+
+    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+    if (ret) {
+        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+        goto err_map_bo_gart_failed;
+    }
+
+
+    amdgpu_bo_unreserve(bo);
+    bo = amdgpu_bo_ref(bo);
+
+    return 0;
+
+err_map_bo_gart_failed:
+    amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+    amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+    return ret;
+}
+
+
+static int
+amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
+				     struct drm_file *filp,
+				     struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_bo_va_mapping *wptr_mapping;
+    struct amdgpu_vm *wptr_vm;
+    struct amdgpu_bo *wptr_bo = NULL;
+    uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
+    int ret;
+
+    wptr_vm = queue->vm;
+    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+    if (ret)
+        goto err_wptr_map_gart;
+
+    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+    amdgpu_bo_unreserve(wptr_vm->root.bo);
+    if (!wptr_mapping) {
+        DRM_ERROR("Failed to lookup wptr bo\n");
+        ret = -EINVAL;
+        goto err_wptr_map_gart;
+    }
+
+    wptr_bo = wptr_mapping->bo_va->base.bo;
+    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
+        DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+        ret = -EINVAL;
+        goto err_wptr_map_gart;
+    }
+
+    ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
+    if (ret) {
+        DRM_ERROR("Failed to map wptr bo to GART\n");
+        goto err_wptr_map_gart;
+    }
+
+    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
+    return 0;
+
+err_wptr_map_gart:
+    return ret;
+}
+
 static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
     struct amdgpu_usermode_queue *queue;
@@ -82,6 +165,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_queue;
     }
 
+    r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue);
+    if (r) {
+        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n", queue->userq_prop.wptr_gpu_addr);
+        goto free_queue;
+    }
+
     r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
     if (r) {
         DRM_ERROR("Failed to create/map userqueue MQD\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 1627641a4a4e..274e78826334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -58,6 +58,7 @@ amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
     queue_input.queue_size = queue->userq_prop.queue_size >> 2;
     queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
     queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
 
     amdgpu_mes_lock(&adev->mes);
     r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 8b62ef77cd26..eaab7cf5fff6 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
 	int queue_type;
 	uint64_t flags;
 	uint64_t doorbell_handle;
+	uint64_t wptr_mc_addr;
 	uint64_t proc_ctx_gpu_addr;
 	uint64_t gang_ctx_gpu_addr;
 	uint64_t gds_ctx_gpu_addr;
-- 
2.34.1

