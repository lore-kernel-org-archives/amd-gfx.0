Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047A4C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC0C10F23A;
	Fri, 28 Aug 2026 04:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/0WPqrG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB4A10E2D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7LFLsxxR+qDA/f61NRPceZujwzRVfTFU2G0bZRgysScZr3Pu10ewgnh9ig9vsA43+tE3emsi7uyJthmB2nVsfiJxs0oIz2J7UeIx7sBKRZzJmWBhVV0Z6hEA8O69p6b81dC5FDWjf116JPiSDs826i24x4GA5GlzoxRA3YFscsr8PikK75/waNkmaBLNwGlUKTkZFdvRj3HoeE+upciZ8DpSVF2cQw7iasPLpGi9O9O892lgjTjNSbmWls0SMbIRzfb/EnI+aO0DrpjPtXYjbOn9iz15VT+gHo4/I0XWHORrnDUEfxCpDONRhfu49PEB2vjknYXUKjhDhS5lWoAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eI1jRlepDYISBVwWt7Wo+qojtLrpowqxE4UpFiuL0Y=;
 b=qJN4slQQEp/ct6zRS2EsRkM92wbZE9vcxbpt6pkQA/XRlVUezmrBcKoLT3frsL/3NjsBpPVhdDHX4IfgkeDCEW2l4yPEjyPvxz2lTZ/UPE8dUTNepizoKcGO+ukeGSYP9SFc5UE+WcoZ+cvlwQ2QHnHrHxmLakBHTe+3g6oj9IjZQBjwTW4Xul/WdYo6uaIpD/wetzmx+8iWDTzc6uCT9/5pEm3FjxD9d242N8d9QBSGqAHRMBYcHTQRxjp73pXtvnXBLzG3jQg7XfwjRCTqD3lPXLNYiUQQ4elIH279o+4CBJ22YafrOMKXz96P1JifViZN6L0K+X110INk3+PzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eI1jRlepDYISBVwWt7Wo+qojtLrpowqxE4UpFiuL0Y=;
 b=f/0WPqrGuRDLJ54wfzwG0tqbVg38sS4BrPU+IAoDUY6oWh/a8Sl7kdPtuMQTg630ixpTzR9dxEAM5/XkK+nNIjTtJjSsuehK7Dkj9T4yVVp+x3hwrIw/a/ILp1SyG/Micko7QOIOD0KLfHsncPA8InQ6Xi8c0mCaoPqcMGms9KM=
Received: from SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:15:59 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9f) by SJ0PR05CA0053.outlook.office365.com
 (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Fri, 28
 Aug 2026 04:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 09/10] drm/amdgpu/mes_userqueue: add GFX MODIFY support
Date: Fri, 28 Aug 2026 12:15:15 +0800
Message-ID: <20260828041537.3464782-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e4cc26-3036-4bee-b6a5-08df04bb0fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Jm41L+5ta3bNv1zvhGF/ZW8qqsapqQh64+UOOwZb3wPvNTe3JF46tSr7XoYsYGsivMNRjdeW5sqxQgluX7eEGFatjdZpO/nzDgZwE5dUrRlPhz6Lz2RnPWgCYQUhcrzmTFU83NVE/3itCi2MlxUCWpgsnySsDFhNaJrT1rk8+WTOFXK0mMXORr8bo43OQbRMANY71CNQMx0VlIkKnol0A1nFoOztMaGqv31zvKhyg2Q+doVlHoYY6wDUhQmhAATBc3vbejHSYtwLFSDEFQS4BoUzycT2RxQAsGYgJ9ky4c0lU/EiKdF4ixZnKtlrZ8Yl/6Aw2JbePXO5Serhn3Yu0awlTAukJmu3H1jXP2J0D/F7KuxDD2+cMIdoUx5qgViq29PywIyzClwGIub8ujS1pRCKE6faLe5jNjyJpoDDBCYlTUeik7QWhBQiW4GBecv0v4fFkbAfp3EwJ0SYRuEouRmRRBGAFoWBJw1RArWJLyAv8QwtnjZU/PjNr0fHveCI4mOMjXgIWjeN7FQ4e/Z106STgwFHI9aNklXWTa1D3GwZfITeTYm3SYoVQUWCyxODblXIcM6xqenbh10Lrad8PhD1qKj8/ghGYzNmekGXel3BoXDhvOz14J0gcZSfWDYJIGdAFjWWxdrA8yKjmyg8u67kd7qV391qXtH+3k+Ad0qK37gV07Q+XVVF9RCXzQIlYUuVxVq2YOX2QT/Q1/GxCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vAruOms2KHbdJoRdpsjl3mXzK6reqdHctiR6HT4seOpyFG3g/VX6YykgBcnNRJ3I1asAxwfP8Am053qqrzlGMWyGfcCdfrNUH6rgH8uo4Xzli1Ss9AYtX2eHTWcWKp2HatXI0Sa7nCSSCqg12HTTdycz998fkLWfQB5hw64vEYRtDcOzF5JV3mBblxe8edDs9HcjUZVhOWxQDDJagbJcHX9FxvmQGz964G+yL2p9qVW13aoJE8bxX+NQN3q9+UbgjtdyuXbBkqgi3ZRVwLzfPbP9EYYIIMpiWl+HvCbsR84fRJfDLQA2LzaH7cVQDOYOOGlYld+zCyNCTRjYUtRs/9c8J7JnuFbbBQaZ+InjRo3KE3QAFZ9sm0V8wkZn+v1KcrHL1s99hiNT1QwYLu4R9cBd66r7q/q9bSOEAEdGtACcJkSUC6pgEPho+Bz/G3fp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:57.8237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e4cc26-3036-4bee-b6a5-08df04bb0fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
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

Add the GFX case to the mqd_update dispatcher, routing it through the
per-IP update_mqd callback like compute. Add a queue_percentage field to
drm_amdgpu_userq_mqd_gfx11 and plumb it through create; 0 marks the queue
inactive so it is not remapped, aligning KGD GFX user queues with KFD.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 55 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2742fa28dc6..3059224dd9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -573,8 +573,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		if (mqd_gfx_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+			DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+			r = -EINVAL;
+			kfree(mqd_gfx_v11);
+			goto free_mqd;
+		}
+
 		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
+		userq_props->queue_percentage = mqd_gfx_v11->queue_percentage;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
@@ -700,6 +708,51 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
 	return user_wptr;
 }
 
+static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
+				    struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_gfx11 *gfx_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*gfx_mqd_v11)) {
+		DRM_ERROR("Invalid GFX IP MQD size\n");
+		return -EINVAL;
+	}
+
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("GFX MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
+	}
+
+	gfx_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(gfx_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	if (gfx_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		kfree(gfx_mqd_v11);
+		return -EINVAL;
+	}
+
+	userq_props->shadow_addr = gfx_mqd_v11->shadow_va;
+	userq_props->csa_addr = gfx_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->queue_percentage = gfx_mqd_v11->queue_percentage;
+
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
+
+	kfree(gfx_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -749,6 +802,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	switch (queue->queue_type) {
 	case AMDGPU_HW_IP_COMPUTE:
 		return mes_userq_compute_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_GFX:
+		return mes_userq_gfx_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2de47ff7c4d0..da2016f42a2e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -449,6 +449,12 @@ struct drm_amdgpu_userq_mqd_gfx11 {
 	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
 	 */
 	__u64   csa_va;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue.
+	 * A value of 0 marks the queue inactive and it will not be mapped.
+	 */
+	__u32   queue_percentage;
 };
 
 /* GFX V11 SDMA IP specific MQD parameters */
-- 
2.49.0

