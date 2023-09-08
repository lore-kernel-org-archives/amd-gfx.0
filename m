Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478ABEE8019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F95B10E915;
	Fri,  8 Sep 2023 16:06:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6261710E913
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSoTAzTSxBD1bwfbT5jnyfBF4fTwQ7SRSREsdEIvhkSlZzKCmbxqoRDWfC2zIVpgu55r3P1Dd+YEz8rgcy9sa0om2Tbwknco1ERLMOwNaWOhTClm41dH0DjnwLWOtd83BWPP78hTnt2RUED7widkJzU3f0aAvD60dSg/BqY3kzv83pLKYiTsrtHLxJwCrqEtFUljA8WyJxToYpynh8dXcp968VrpnmWR02TW2CaN1YtN3JB6y/lEiD60NYJY8lsgQ72GmzObjKebJS8QEtsrMs0FAZt2mB/twI39si//yrdlAbkCMoJEgKv6A8u/wYMCfu1TW92qL5vdV7/rqlvqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6WpW80RPSBUtll168DQZTw6C+0imZEGfTVfUkegaIA=;
 b=mlnKSTE1lEWnn8fY1L/StFIXAOACcDP9AQk4eL4V/Fe9jsAZFqs0LY1DyKqkJxh4j93mhp+MSBpJiSWRluqB3CnSfUeCr4ewgO9Ne2FQ+cpHhTLWKe7RqYya1SdtB9yUd+AIe3IOb05AuVZilYnOjmx8hveIhHgPEHES671WaJDzu2LwAbhc4z8ieXBbquRoIwkTL9VnGMDQY9k18h8l9TpljDzR/cfN94LhO1TuQPai/ZoU8BYCO0d+ga+HZ9EH+pkjIyVpMJZ3QXkI8p7+DRcuGJmbFrU3VjQuldJJpvgEyQ2/BDyzrtLCL4eL4XPje2joTCo9b04OhWepHLTizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6WpW80RPSBUtll168DQZTw6C+0imZEGfTVfUkegaIA=;
 b=niS8rv7FBrmSa97Ak2Kavk0eyJcGxeXsi/tIatKi3mpK9PSR1Ob2rrIVwEw3KafzFxuQBb6jVEJyuq6fiti3DQOA+ZKEc3M0Z7OKtU1W6Xi8MiUkx5P96AzawgPlOD++KX2N+BAyJAuAZgjx5DntaVmsA5yVEuID1YZq5c7U3Jg=
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:19 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::a2) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:16 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:15 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 7/9] drm/amdgpu: map wptr BO into GART
Date: Fri, 8 Sep 2023 18:04:44 +0200
Message-ID: <20230908160446.2188-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: dabc6cad-0975-4868-6f8f-08dbb0858873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m9IeUBC7WwmGvKjcETNyTu7PRtRXb89Mh1h4ld3VBE1m0Ay3dGgpXtxWUg6N2ZGPQ9ao/c2hTy3GRO6BUIpONi8LH3+WYMcBEjj17scvy4WUdmifybLBi9QftMoO4GHPxJushgv75c5j0kNhZmHBE8y7sNuqa44UJzz0nSxvkDA/9f249/4T0ZBYp9igFgZGNQEi81s5Oln54d9XBJLIAEwMdkCO5g22ga/Ll24/c1e0uO52v+dhtU/TdVJtBGePct3gxYV2zK5CxwB+OMTNPCFBZY1AbWOwIMJMPuIygHF1bqDebsbanZSmZmhxKOg2BBvB7BUpyNwZ3B3Cm3BmR58ZlppnA2Z9nfOlKw6PdfbPhIAzg7fIDscVaSb6xyrn3vFpMxjv0yCSgX+FA0+W7mHIf58+GxeznGFVqK3FnznZQsABbczf8NJHK8Q4e/5K04QaGo1yjKio/k32qtdVDFE9fNtz2dLWPxdz7wpkpdEFjWxnO1/USaSTmxynyX6/9GXVLS3z3zhN9sACyuiGn1wuM14ALLJp1PYCJ3l9gI7OFQi2RvJXuojRkZ0coyzCNhKpPiPEI5qlxKzowm/GW+lrnNrul2gAbn8bwd4i6Dm2vtV2OLe9W/YzX2rz/9j075EgAVS75j68sCRrNMjol+HhUIZxmZScbPfi9F+z7hpfYomYDqkrG9H7DSmJrbNhNG2UO9ObM/abHmtvFbyG3xRaPFm7j2h6gg4MiVYH4jGNp2fjGIh3WsvmNQjRV2BPKvAOdO13s61r+O2KZ/FQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(478600001)(41300700001)(83380400001)(336012)(2616005)(1076003)(426003)(26005)(16526019)(2906002)(6916009)(44832011)(316002)(54906003)(4326008)(70206006)(5660300002)(70586007)(8936002)(40460700003)(8676002)(82740400003)(47076005)(86362001)(36860700001)(36756003)(40480700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:16.8681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabc6cad-0975-4868-6f8f-08dbb0858873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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
index e266674e0d44..c0eb622dfc37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6427,6 +6427,79 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
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
@@ -6475,6 +6548,7 @@ static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = userq_props->queue_size >> 2;
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_mc_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -6601,6 +6675,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
index 34e20daa06c8..ae155de62560 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -39,6 +39,7 @@ struct amdgpu_usermode_queue {
 	int			queue_type;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		wptr_mc_addr;
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
-- 
2.42.0

