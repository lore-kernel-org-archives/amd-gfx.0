Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521AAC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 05:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E5510EEE1;
	Thu, 20 Aug 2026 05:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDayAMZJ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF32E10EEE1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 05:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2AgsTroa6Ee6qWZx1Ino87eUYUhMxOBzipsqLSJB74OMyC1U64ZUrk49CQhOEQL2F/U7TWDoin4l3Zpzv5yFCarkQwvsmtYBXj5vt2nC/y6U8xo9rGLfoNzSdHPld6WBEn+liKxUpvIVhkvT5l35f60uqzN9nF7Qu4C37/6X5oLazkvWCXXPBfvqNshWtF/OKJjqCJzso2mji5LuaHmND1tvl4XHlTVKBXWq6aulbnyi3VdKQPI29ndtkxa9mTcUacxdzZdzx3jjKS8ej7ZO0Vf0i6mG1Uqqw1RQ+7lMMYSXx57y0RS2MGDUgk1SkuhVadMOv7OIItJx0MK1M6jWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaLoM7KCZHu5eQNiCImrPSmREunWrQzItbaJgeAM3KI=;
 b=uZRW9I67cfzPcGPDdFPQPRpm19lmmp8i6U/7pfYwhvOe5T2DA033U60nPyiko5Mlw9XZEHqLxaZE/yGnQKfUeBUHGKnjD6uL1WiXpvkUQMg4BQwQpFAwsO9KqTuTz4N2O2o89T8Hd5ztgm81DpzlOsB0vGt4y/jTdWl72JxlefpV/9eg6DA3ZtEvCOdJYaAJOvQFtljP70WtqnjsTYC4dHsreGcvIfo2pjM5zifYd6BqwgnH5kLa7qlWPZMmjHk2KlvvIQETuKfyu2AALd7tHxrfH9T6cc/BhuLY6KYVVXCiXI3T6e5B7KwUqRoe/WVQM+SirUV0XJjiWQFVrWrTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaLoM7KCZHu5eQNiCImrPSmREunWrQzItbaJgeAM3KI=;
 b=dDayAMZJ99uv9/6747iWc8BxK6Mv1tq9n/uBGveoLQpXCfBlkk3WxZVi4HOshkzx0OZDpOFTfPXStktDHalNoYd1UGxw3GrXT0dNdJwPlS6HJkKBvly2VytkTKEH4eIPO6v9DhDGob5dgfhE776Ty3oLj5j9vkdxPTTkqQtj8CA=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:06:04 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::4) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 05:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 05:06:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 00:06:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 00:06:03 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 00:06:02 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu/mes_userqueue: add MODIFY support for SDMA
 user queues
Date: Thu, 20 Aug 2026 13:05:36 +0800
Message-ID: <20260820050600.1249902-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260820050600.1249902-1-Jesse.Zhang@amd.com>
References: <20260820050600.1249902-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 30070b26-4589-47ae-0dcf-08defe78bc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: eYBZtdBKTYy+d0rlr85rQJBov6E0fiVmGGVy7On7GEuesTEGYKFdTUwGhFs5GbU4kpZF02aeyaDvelcd4sDBOi4B5hfOoUy7CjiHyy4RUe2j6KOx74uld66YHYxA5RYpoHoeZPuOyuwDASbnl3g8vm3a61oiK6LQNtV7TMwYNZr1Jqi8WUhFfgfNVq/Jx6kEM3YSKvsVnqO0zyzBIuPpETJJNdlw899noVUSmPxOuw015efffguEc4mGOwfMKl8db78ZoNLdy01OrSlyz84udvWiuFhhwRHP9JPBtgyEArjdfxd3fZ1QKgK2NzOXDG2CJNmS5P9WrCmWzYuypPl4ZmCOWU5MvT+NB3Nksw4egVd4eVOP/Rf+LLZY104ezadvI6xff4fPVNe5BK/GsvW3LUnI6y2qquCxpiYRjIovvk8DTv5jYF/B+Maj9Y5UyefpP4/0JwcQOnC8EEtkIftC1oRwOtZWLREmWWturHJIG461djM21LH5T2XoA3rq8jrkZrkK/k9aP9t2w5leTD4IVtcNGzckkFxb5AgQcIPDf4PQMe6BX5lRnHmOsEfMGYaNZD+L2H1p4716cHxTjwwL+XCA3E8pk/sJ53IPjvgbwATA5SZrTLxmHTdYAv5i+iecW47R0iWtMB+/bqjBv9TXxuoq1QeRTqp9ZChZzkqPk68IVmNAzLDW9dpeS0Pz0QjLLG2K8uvtbs9nokj8Aw3ijw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uxWzXhTXpalC93DIBnKG2AcTcv0sHpnCgjLpbUsktJ8QrNgWjq+UKmT9tUm9MUBY82mklybisPvR6z8T4Gjv1We1vFg/h/vB5QtpNE+WjPRtTo7s8UMAvMIXguLg6YW3Iyw1e1vUZjFEMJOGNP/+t0dCt+Hlc92iriv6YDSCyoBdjO6RwGnd7Wb2HjVIgCjFyff7u+cM09ia9wGyaS6DBXJnboCknUgMzlMtPAI8vtBI897c5OfxwbSVctAPajlvVxb3pThr3wNn693005AQ+ty2B/qhq3mxZLRWv2pfnzrcB4yN4biUEZaYuDVLifHcgbmN72OvI+8aLB4ao+DGfYs4mDwSI1a0jFZPgufKy+mk5NbwNde/NLkK337MeidlFjayFDvjEA01DleGI7ErT76Kbd5XmSDiNdYy8TgLZXrejqdsDYRZiTrkfTBuEcGo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:06:04.0349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30070b26-4589-47ae-0dcf-08defe78bc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

Add the SDMA case to the mqd_update dispatcher so an SDMA user queue can
be updated at runtime; until now it was rejected with -EINVAL.

mes_userq_sdma_mqd_update() reads a drm_amdgpu_userq_mqd_sdma_gfx11 from
user space, refreshes the queue props (csa address, queue size and ring
base) and re-inits the MQD, mirroring the compute path. This aligns KGD
user queues with KFD, which already supports updating SDMA queues via
update_mqd_sdma.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 82bb4369451e..4f6d92031838 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,6 +681,36 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
+				     struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*sdma_mqd_v11)) {
+		DRM_ERROR("Invalid SDMA IP MQD size\n");
+		return -EINVAL;
+	}
+
+	sdma_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(sdma_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	userq_props->csa_addr = sdma_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -723,6 +753,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	switch (queue->queue_type) {
 	case AMDGPU_HW_IP_COMPUTE:
 		return mes_userq_compute_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_DMA:
+		return mes_userq_sdma_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
-- 
2.49.0

