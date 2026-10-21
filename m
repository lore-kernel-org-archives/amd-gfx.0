Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EB606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RKygc1a0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A92C10FDF7;
	Wed, 21 Oct 2026 13:16:19 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6376C10F9BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfmZ7BmT7zqweyTmEn1f+5jPGeY4q4Xs9idp35S/BXZK2HyWoKUqrFN3J7Jwt+o+1Zwq1C22L7b5OTK2s6GHKb3dDNWhA9k3GAi5goG/DZeFyhb0F72HCObAcmQdK6ekAvM87Kv4EHKWozmrCRi7E/vvlr4UDwOdqQsgkPsRKc5qmObDkUHXKfp31+P+5bNHF7FSorBZ/ooChPHmmu8ANQbSjR/wmFiv0XXzOX7cm51HfbD/Y8J0gL4l3nMVWg1Zo9XFzvEGRYgWzX4FnUeIBp3QDOnnc+oyeLnHsTPE7h1vw2fDFPa9sxIrshzZumwnsgD+pxeMuQpPZd9Xy/nsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ilgr7r5Y6sus0Ojg+LcfvZMlsmB34uggi3YYd6rqzRA=;
 b=Ujuks36evT8sI7yVweq5sNAmFiGOv3gnQH3izNF1/n+LlecPO1RUhjDrOC5k3N/wrIqvh/xEiEdsOA/tvtWSn+2fTWUMG4c3iD6hdqd+8eR0UEPAzYT+DPQ8iRE+cV7lYGtcWo83fnrM2JQm60RaS5oTXRIu6yhVQ14wRtsIqvvi6OUE7xqkzCk2lRunJVFNYknaRBCMCmZbsFLNJWshuHFQVgm4Vn7GV/lNlT5gavzylTGPsQNPso9Wb5d8BD+ey8fry9VOrOiW6IaRZe6oYaxp5Ka0sHm1LNfKASSAL87X8GYPvGpV0hY/9Fau7bAaf+EmUmOD7vp9OVObN9ex+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ilgr7r5Y6sus0Ojg+LcfvZMlsmB34uggi3YYd6rqzRA=;
 b=RKygc1a0DqG7h1Y6nr6tpxYM4tGjDw3uG3i8xhQ4c/I9NK+dWg6j4Mg/7YkZdum297HDPtSIZ3u1m5qQsKD9R/gGm5hlao4ae908CSRk1/8bcQ7mdJvggPRAue1BePeFJxKCw5lO7K/rE2/pm6oC98VlDG0XQbwYUx6A1J+yEGg=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 13:16:01 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::2c) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 13:16:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:16:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:16:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:16:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:16:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: don't set queue priorities for kernel queues
Date: Wed, 21 Oct 2026 09:15:45 -0400
Message-ID: <20261021131545.1962601-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e2193f-9abe-432f-1a44-08df2f75742c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: R8ZOvn+e+EqI7tKRNo8GgIQy5rif25nhxgY0zSb2C3Wz+CBcStnvANMq1gDl6WMgLTGdqiRRurDuBztRqzJxEb3hJvHGyRbjg+uQ9m0Sxw6idRllfXD2in5WF6woW3MxGDBkZjPZbsV5okrmokhMDxvdxihSdqofW6FQQXVtNzJdy2Wsa1yqmFAaKh5WGeFZg6kv/HChIKc8xQPOe1MKmAXHbTCjf5ip7dopO82LaGvpDcrbhVQzHc3hghYb+FJArwRbFtbNJYPm2c5Fd9jiPfgJke+pQTheJl6d+8T8hZCy6pi2oXyhCuduG/Mep489GrSMN1Ypd/wPrbuEEHjL9+6wkzrhrYrIIa3FA5mM5RH8rqn1HANbMjcGCqsPhIFoQuv/h5nTDEz78l5TaZDiGBvCGGYs+hVQPZFiM+Zfcybj1RBqcf6x801c6tQ37L+G8VvtQkMCPLmGr2mzR0WUBd88ukt/VVTrB4X8GlJi0sEwCFUeKaY7Zu70FBbCW0CcgmTA2Yls+J0GEUdAJqdx/GF6U16pgF4uEhKOtuByfWYSw09gLEuiHGulYqIImCSoDQ3dmlj30BIg+C5sH7TzfidhmBrqr4i4scUdJAUbgfwMJOJIQ98dXCzbgDmvVBiddu2k1iBEWNinYom95Y8NKk4s2mHIPqOECaR9EimR6OANQC0ld4XsSjVMgtO1CAdjz47bgp+jrvdD4He7QUECgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MI+nOctIhUgnGmlD07pmNi7vTfCM0hTYaSvLMWS2Xwrqcp/BUE0gjiwJljF4F5L3Wx44jKPWMFb0sn2tHzexGE2+3nGAADr3bBg0JK4bY4wsF56TeqNp7spqP93sE8oBtlYqx1FD+xIdXGhVixay443hTJbvQQr8JBS+zPhq0l3XnjFDH8vy94zudYnH75G8zQEv8B5k9HyxafKN9lv25SC1JyGmEXIAj48U9z0rUsbMWZrdvs3GfZBk/RrF4SRSJGtPgZbHGU8F+L/8t9XnO1lsNnsa00a2AgEupuHVbtl25RI6Iz4pMZtrCsfXjvfWKfkvfG2Hhy+qOhj/FwLoG1iU6UdHvIiHuz/1s85XqOHtwEQKV5Rxxj1ob6C/9jKoXXI0tqeyBGCr2yKt7idyzSgaIizGg6pJbPnU5Xcb+XgTE4/4Rbmn/btqVCoAFtM2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:16:01.6201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e2193f-9abe-432f-1a44-08df2f75742c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Align with KFD and don't set queue priorities for kernel
queues.  This can result in starvation of lower priority
queues.

v2: fix GC 8 and 9

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 --
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 2277345413165..4d472ce8cb710 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -830,10 +830,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
 
 	prop->allow_tunneling = is_high_prio_compute;
-	if (is_high_prio_compute || is_high_prio_gfx) {
+	if (is_high_prio_compute || is_high_prio_gfx)
 		prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-		prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-	}
 }
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 80f3172f038c5..0ad8b8614d927 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4396,8 +4396,6 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 020315156dad4..fe4454d0877b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3538,8 +3538,6 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2240f61c5e6bf..19f05af61557c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1756,8 +1756,6 @@ static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
-- 
2.56.0

