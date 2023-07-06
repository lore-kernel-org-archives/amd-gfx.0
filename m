Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD9CEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4B610E425;
	Thu,  6 Jul 2023 12:36:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E72510E425
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTSc9qZA4kuBtqyvt+FEsNxGbgpvBow/6dlmWj4YJDrEO7jH31qqmXnyo3wx+SYE8NMaXgqQ3EkxvSgV0ATC4EWlTwi1uR5BQmYOUOWnEB8nw4F4FiWDsUn3BbtsgLvY4PcUfzgn8K7FdUY/HooblEX/lhDCLtObJcSIEMoEfRa8Haz0aDApGoDsAp54dhok7UqFcZpZGrZMq2E3xyOUnE8ITtdIbaYvkhLgIVe6SNVtzf9nRue+5Q9BmuxyY7KnOK9bPglnTop9BaX2VEq2ml9Xr7+D/WSRuGK5rr//7kksccsLs8M0g6xthb8lRgC4Gqty8EJXynQCG2qwDKQ2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVP27BwcVy6xf3wO8pS+YulKZ7g3YhVJymhGVr/U3XM=;
 b=i/Yjwhclp2NtXOAejOCcuOgjoqOLHWD87XVTXm6oEtUNuGIgnvONV+6Kana/tKPEyCpOpseda3YKEmywOOeApK0SwcdUDAFFqIxMFq5AnW+BIGaN9W1Fo4kt3rb3X256rIUk2e6tEgBCE5IRbY/L4N8RYPfgYoz9TKY/n7tUxo+QPDQxjBfN3dZxyoI7sa18ykD1ceKmM8/06AxeHx6jhL21pXUhVzfW4Va+unCml1reedf3cS0mFTf8BYfVBVu2Xi3m+9XP+56pXDOkOLk/Bk/HT3+TwrwYqvOPBTnaHAg8CsVDQYLF1eG08Jf+6dC8/XQvNVU2+9odawRf2W3Z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVP27BwcVy6xf3wO8pS+YulKZ7g3YhVJymhGVr/U3XM=;
 b=n67yvLC3XTL7IlBFghSq6dK0CMdmZBK0yRNWJq7HshgC6lkFmUZ9fY+ep2bRB6T7w1IsHE00gol4htDkkb2so+JyuFnCz4C042l/ZPtQ0h2TIutg04p2Jfmb3phDHpeENOBPgT5jHVpAg1qKIhwadPk3QINrDc6xcK/WjSA9ivk=
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 6 Jul
 2023 12:36:38 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::98) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 07/10] drm/amdgpu: map wptr BO into GART
Date: Thu, 6 Jul 2023 14:35:59 +0200
Message-ID: <20230706123602.2331-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a54d2ba-88c7-449d-c11c-08db7e1da40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nxk2ROioGjTCH84iZbsrCulfhCwyBbV220LlhSALDIKIRtv+RN9C5nQc/WrGQJEsZmwtJhEub4+jFpP2V8u9/bKBr2YihqzvoGVfyfmajhye8HZgdGMXtviwn36/v3cfT50iZthvYgtWXXwJrDfq9aBxOIpXkU8SihquD92sPHf/hLM2KSuXYFeZE5GGkfYaFSgjX/r/rul5XAQnHplvORMoG9pRPeItRUmml0feifn65HaAb658cCFhCWO9yiQDIy2GO6DIuQ1n0B64lchOi/pLQqBDFerdpi2jR4HVzRgrX8IOlM0k4xm/Z2QfHuDynj87HYDq3J9OSL3unmXKSMF085EzbA6Xd/qKJq4DJOoLEP18CeSfJy1zRRvIBC2soHVW2znyb+O8eP1yPMICAOSKGmC/QPRYapQKtPaa/cZyZZGfQ6qnugwG7m4ApXs3/EgD8ex4reTaqcZoNnCqxAZH3fHNM7HBNfqKJsIvDoO2Fa2Szp1GC87oydHRx0LOO/y6WnG8FZjxlu9pQUnlrAUyYdHiYfA0RIY5TQ7YWPIXotdGXprkBYMQ9ajcNKnKULKSjX4dpnLkI9hNNMso1QZlDLIOfvS/Vl2dkQbbvB9KLZdmEWa9rqcf2W100bLrny7ylZtm+KE19wFqffMYWYkTSd1YIYaNwoCdO9FZtmKWt75LJi8eQFYCGyXUbjlQCNE49tn9zmf/JrlP9PzJKSNqP4mxT/KqjUPEtydZUe+4XTqL/e/A8YZInZfZcTAlh6EDi/EHGIVpKaDSGUqAcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6916009)(316002)(7696005)(70206006)(82740400003)(4326008)(70586007)(6666004)(356005)(81166007)(41300700001)(83380400001)(36860700001)(186003)(40460700003)(40480700001)(8936002)(1076003)(47076005)(26005)(44832011)(5660300002)(336012)(2906002)(426003)(8676002)(82310400005)(86362001)(36756003)(478600001)(54906003)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:37.3661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a54d2ba-88c7-449d-c11c-08db7e1da40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support oversubscription, MES FW expects WPTR BOs to
be mapped into GART, before they are submitted to usermode
queues. This patch adds a function for the same.

V4: fix the wptr value before mapping lookup (Bas, Christian).
V5: Addressed review comments from Christian:
    - Either pin object or allocate from GART, but not both.
    - All the handling must be done with the VM locks held.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 81 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b4a0f26a0e8c..afaeecb9940a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6491,6 +6491,79 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int
+gfx_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_bo_unreserve(bo);
+	bo = amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+	return ret;
+}
+
+static int
+gfx_v11_0_create_wptr_mapping(struct amdgpu_device *adev,
+			      struct amdgpu_usermode_queue *queue,
+			      uint64_t wptr)
+{
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_bo *wptr_bo = NULL;
+	int ret;
+
+	mutex_lock(&queue->vm->eviction_lock);
+	wptr_vm = queue->vm;
+	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+	if (ret)
+		goto unlock;
+
+	wptr &= AMDGPU_GMC_HOLE_MASK;
+	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
+	if (!wptr_mapping) {
+		DRM_ERROR("Failed to lookup wptr bo\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	wptr_bo = wptr_mapping->bo_va->base.bo;
+	if (wptr_bo->tbo.base.size > PAGE_SIZE) {
+		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = gfx_v11_0_map_gtt_bo_to_gart(adev, wptr_bo);
+	if (ret) {
+		DRM_ERROR("Failed to map wptr bo to GART\n");
+		goto unlock;
+	}
+
+	queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
+
+unlock:
+	mutex_unlock(&queue->vm->eviction_lock);
+	return ret;
+}
+
 static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 				  struct amdgpu_usermode_queue *queue)
 {
@@ -6537,6 +6610,7 @@ static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = userq_props->queue_size >> 2;
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_mc_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -6660,6 +6734,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* FW expects WPTR BOs to be mapped into GART */
+	r = gfx_v11_0_create_wptr_mapping(adev, queue, userq_props.wptr_gpu_addr);
+	if (r) {
+		DRM_ERROR("Failed to create WPTR mapping\n");
+		goto free_ctx;
+	}
+
 	/* Map userqueue into FW using MES */
 	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index a5cdb319193d..f530df3ebcc0 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -39,6 +39,7 @@ struct amdgpu_usermode_queue {
 	int			queue_type;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		wptr_mc_addr;
 	uint64_t		flags;
 	uint64_t		proc_ctx_gpu_addr;
 	uint64_t		gang_ctx_gpu_addr;
-- 
2.40.1

