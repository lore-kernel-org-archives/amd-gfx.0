Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6080AC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEF210E5C5;
	Mon, 24 Apr 2023 17:39:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E301E10E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUPLzDJ0D4HVDVX9XsMHpuLxaG0OQL21MoI1eN2xv9+6klgssPziwHirZuLkoEyDRR8ccpUZE3peRpzCemDPsmyI/L/eZjuMgmL6+moykgJUxvbBr9UbEbS7AOdGr3WZZ06FaFjMhvMm8b5cCGZca5yBU5v+Og10STbbXSZFpzwXsnByYN2mfOzMuYgAJZPl3ncwrD5JFnXPlxMqK1b9yBK+l7SSqKF8lopKPDclxkf4SzTBqE8XC4gj8MgFmWG0pIn99TVzeFwGAMQmpTMAlK9bvD0zni7jN2PwO6h9xVE0zd0KLqk7FCRYsMIBlgqPSOzTL3MWbUuf0b8k6MtS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6e9D487tyT6ykZoDAbtKNX/ScuXW3/Iury9GFlCzGw=;
 b=YOJ54uTlP1DpMUs3OFBm76zVU0LoQHAU0elVEuf4rrHZxiWlLKbWLQI0DH3Gbba+ZY1EY/stWAA1yII7yqJYpn9mXQx03UXMBDrF/wl/kY8DvVbLtRVvo3mwiSVQpKawO7OrTyiHOlYY0X86UAMIGG4pfpvdn5xTUjAZ1UYZPppeiRXmS3DYvwbkWuYs5lXnqNxr4ChFDpfp4pzORE0wywW8mDxbSYpzp51mMxLB9UQBqg7u+QxTE29Dofgfhr3Ok2q+78IUQgAkjZqq4ImkjKSYHt0SNUot0UySUO3nIjT9Ulh6U17qZqDI6YHgjr0pKws5g15pZvcBEiCjds0wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6e9D487tyT6ykZoDAbtKNX/ScuXW3/Iury9GFlCzGw=;
 b=4BoOShmIIGr5r4ATwVimdKKjyFqmAmgytSQltWdx4Mj15X80I0DyB2OEbyukDBmBgLn9ffLTOyrt9JohMbvXbpTkfLjbRb/kAi1RTqgN+5r/ExsFIscazBAjrFkMOE+d3eih8FTgEWzT/9gFKuxyJnkGnRTe08SvRy7qJbECpD4=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:20 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::6f) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:16 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 08/10] drm/amdgpu: map wptr BO into GART
Date: Mon, 24 Apr 2023 19:38:33 +0200
Message-ID: <20230424173836.1441-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 075a5f51-d340-4f4e-2b62-08db44ead57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSaqKMgQZLOahCjVKBokKu36kXHghCQf3Q2uFFk6ShGPubctDyzcWtkHANS97bUxh1Y0pItBQCs+bQcM7xt5XdQ7BoD9oLzAcpXBJwPt5MtGVelfwOdAyqqleJ/89WjzDPthX4asGl0wAwHSEQQHmCW15iZhNvsa7yfWtsa8HfzZOWbkhemP3oJ7JmewjvfP3HaJjynNMwlV7qdHpro6sazbItImX3uxJnxj+lXt9w59tSxrK2/QV6/fCrzkCeULZfGoHy+0UsTf5QjkGkq7J73ECG7Wt0wV3ZDkAgZYRmCWv684IotM9g5fdIeTbtSnn7g5MjPuBjd/KE0/0plm0wKSD9OMoYZQgTLXJN6aM+t/haViLFLjhLzShHQxmLTBA1tFmBC5BENAboa+drvQO3yOIPgt+xFOjOYVpgJBDg2QO0HHMmQ0LG66CDi/S0n+k47G/81uRJmschxuBjkel5HcCJAdyrjYj6COCfa59bYIQIDQspKhCgTF5BJEyDLxAzBASpgL7oc22+inkeIRqrS8R2MIEEncOI7glwPgVoFxaPjBMRSXw/dJgax0u+yxpj1ZYAJiokxsAoIHihrwpCSNrWimYveAbisBF4F/tNdda1PpXjt7HR7PqtwOV/eB0JJCb1VfY42OYw9T9cSLHs+18JCFKbQ0T9goPcCDr3tu9vSSV/6EYUf1R/E32Ad9wBOp0nUQm0FpFPUv9Z+GsMeebOGlfkhbo9sDsBUVwDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(44832011)(7696005)(70586007)(6916009)(70206006)(2906002)(6666004)(1076003)(8936002)(40480700001)(336012)(426003)(186003)(16526019)(83380400001)(8676002)(2616005)(26005)(41300700001)(36860700001)(5660300002)(40460700003)(316002)(47076005)(86362001)(54906003)(36756003)(4326008)(81166007)(356005)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:19.6502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075a5f51-d340-4f4e-2b62-08db44ead57e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support oversubscription, MES FW expects WPTR BOs to
be mapped into GART, before they are submitted to usermode
queues. This patch adds a function for the same.

V4: fix the wptr value before mapping lookup (Bas, Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 90 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e95fb35b0cb5..385cd51b6c96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -44,6 +44,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static int
+amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		DRM_ERROR("Failed to pin bo. ret %d\n", ret);
+		goto err_pin_bo_failed;
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
+	amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+	return ret;
+}
+
+
+static int
+amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
+				     struct drm_file *filp,
+				     struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_bo *wptr_bo = NULL;
+	uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
+	int ret;
+
+	wptr_vm = queue->vm;
+	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+	if (ret)
+		goto err_wptr_map_gart;
+
+	wptr &= AMDGPU_GMC_HOLE_MASK;
+	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
+	if (!wptr_mapping) {
+		DRM_ERROR("Failed to lookup wptr bo\n");
+		ret = -EINVAL;
+		goto err_wptr_map_gart;
+	}
+
+	wptr_bo = wptr_mapping->bo_va->base.bo;
+	if (wptr_bo->tbo.base.size > PAGE_SIZE) {
+		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+		ret = -EINVAL;
+		goto err_wptr_map_gart;
+	}
+
+	ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
+	if (ret) {
+		DRM_ERROR("Failed to map wptr bo to GART\n");
+		goto err_wptr_map_gart;
+	}
+
+	queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
+	return 0;
+
+err_wptr_map_gart:
+	return ret;
+}
+
 static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -81,6 +164,13 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
 		goto free_queue;
 	}
 
+	r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue);
+	if (r) {
+		DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n",
+			   queue->userq_prop.wptr_gpu_addr);
+		goto free_queue;
+	}
+
 	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
 		r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a45d68091ec..6eeae0206d8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6439,6 +6439,7 @@ static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = queue->userq_prop.queue_size >> 2;
 	queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_mc_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 11e8ad649f6e..0001ecd710a7 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
 	int			queue_id;
 	int			queue_type;
 	uint64_t		doorbell_handle;
+	uint64_t		wptr_mc_addr;
 	uint64_t		proc_ctx_gpu_addr;
 	uint64_t		gang_ctx_gpu_addr;
 	uint64_t		gds_ctx_gpu_addr;
-- 
2.40.0

