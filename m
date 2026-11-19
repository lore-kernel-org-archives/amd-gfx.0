Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23B606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j4cyZV1Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD731124D5;
	Thu, 19 Nov 2026 14:41:27 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C77A1124D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS4CL4uHaw9BoVPLhzgrYVHO0UINBN8s+o/JJ87h6WKj+nfHXBOdlDCq9AV85Dr3LvAq03TsHEvxvukWssEibBBGEr2LPTauOfHLC/EAkM+0/kyuuiaxhtghe1KkD1DgaeNHJPB6NcIytJvDkrOGow3R7o/bRpFXNgVIKhnnjN5QHreNK12i0ZiZLi5gFRT8GFy7zz8zZW5H9oritDgy/KqcfjeiOxip/QWbF/HZGl6Lm5ECe2jhNzx2eoqenTBa9J3suWEagqL38VAesO+kecPW3vwLqREsvmbKPqwSCitqG7GiS7EmHL4NXrJ/X0tyq8UznNUvwp9ocjOEu7SNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUIVv+UzGAk5f5g23EcP4ow8OZvQg7X8qbi8m/7xv9w=;
 b=Zftl/V7N728QCOxtCD4lK3Y5rCNpeVzdxUw7ujWiDou5cR1+gzvG34qUW6cjyfeV3X13bCkYP+WN7rZlSDDniOdP19J06327oY5aWjTuY4hUWn+Z7Xg73ZkgfPsxADCPawS/CBtwD3UMjp1NcP8glkVPzie6/UnZS3/jIIw1+E71OtcSGz1jAb1f7bOG2RM8MBB5eERpf+wrUPR2F6wAxFKZwOJnxbsKypSTlKJQmLBO2NreILXdwNXx4v41LIaNWJM07SQh5orJABuhyYLtr5WDXW2iEAp7ULvwhULzB6U20Rx1VNEYXLdDYyRfb+LUh+5qraAMeYhOW4lqdLP7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUIVv+UzGAk5f5g23EcP4ow8OZvQg7X8qbi8m/7xv9w=;
 b=j4cyZV1YvmiLVobnrpnyThbM+W7knywwqkqSKPiaX/XmLMPsSjK5Od2+OmoYmAh+fPpM0J5nlnNJrd//ZUThX2y7zv0TpJLxe2kvX6V8R/h2XXJc5J3D5+M+sjZzwZVwvr465m4LbT7wdnH/FRfjMtFj2DiY5EWGyUfnV5a1uK0=
Received: from CY5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:1c::24)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:41:12 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::68) by CY5PR10CA0024.outlook.office365.com
 (2603:10b6:930:1c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 14:41:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:41:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:41:05 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:41:04 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 7/7] drm/amdgpu/object: get rid of amdgpu_bo_fence
Date: Thu, 19 Nov 2026 09:40:49 -0500
Message-ID: <20261119144049.2057674-7-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3dbc89-549b-4b02-0869-08df464b27ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 90vkzyfUM0rgnruNLXAC7W8sb+/xBpDdqW3+OZJQN6rXjTstVEDtml336AgknoVXQWVxBtVWYZHLgSN18/1WTvulQ4o1bKCa/6LJjbtpXzJbQIKVq3qXY0dsYdH/tAhUcj0xVrITAhFCI8LL+Pfwf9OGw14CgtecptO9+rFurjAtLGJtCRXb8XEbcoBTMTYDbfGADzC2BWdoZYX/JwtTkylrtKANAnoMT8hXRIlfCV/9GeM/di3/97da65psKsAm0XP90mpwsyU/+lrmJuNZ3gQsRKIlQJ47fS4pc7WOt3tA/yzy/04oDzsmD5/yf3W6gcQfgSIvw9DBu2R2d/39LpI9Y00ZgBIfJfrLxiJD1goF49FXemqr1H/te6b1H5Up08TVWH5HgGsk32oLFVPtQ9n0x5kojadGsHsOOcvZWIw+vICzS9z05wEbhhYIw0qxm5jqn9nQrOUXivmTwDBnSDL1mQWr7KmX4HVuLYra6CmDPQ0Z5xXqvBUYSxUWnGuYeZyUzcCvfhT67usF9yq2n1mG/WXS+EqLK1rCm+pO/OzGQJjGqRgp5ui94c549L88/JNTaDtJh3Wcu2VDB6L5gEZh10zuKO/LUl8TWHGiBgIBiWo02DlJc1A3uKcqsAMETNXZgMfbwrdAXZjKdkqEhBfc4oEWJngMTVR5EWPdHDEDl7r1Vj2TBQsyZ64DcSgoy6OLYJed2CC00Tr6G084zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hj9KNmGHyubrTEWRIu0kimOeQkKjpSVTefOrEAn2DgYU3Q6eAKZ97nA8b3J6mqsXlT0e1bS48Xu5lfV/vxmrbN7jdMVJEo1uXCO1y3wiXHYjoZnbhdjeAMEYyoLOjViUoCBm9z/ynCWavDiYyXuZK4okfjuQM4joPJYicy1sZepPOkmkYH0MR7KXOjH13D4YXjWd0Z4gVQqGlCoCUzlOE2d3ItaYqy3hUAmDh+cxdTxLbhEd7a2Gt2TbnP4qqc6W6HN9BkSCbTWZA/fHd8t7Wk+1qorL6xdCY9cl8Uk4ggCN17mt5EqURAYFQKTmPK1mz+3TdSqyTBGbxpJo1J5NM/Ptn6zqW2wC6MeEyfMTj6bOxuZseI6YZSBXuAauWOGmXZEaDaDDg7Lrgw1GRY3B9p7lDcGLDqGMHxZFBEemZjh5oX4iDSXsXiURpelocJ1L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:41:11.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3dbc89-549b-4b02-0869-08df464b27ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All uses of this function have been removed, so we can now get rid of
this function.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4651f2d437c..ba9b5ed71cf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1463,31 +1463,6 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	return 0;
 }
 
-/**
- * amdgpu_bo_fence - add fence to buffer object
- *
- * @bo: buffer object in question
- * @fence: fence to add
- * @shared: true if fence should be added shared
- *
- */
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared)
-{
-	struct dma_resv *resv = bo->tbo.base.resv;
-	int r;
-
-	r = dma_resv_reserve_fences(resv, 1);
-	if (r) {
-		/* As last resort on OOM we block for the fence */
-		dma_fence_wait(fence, false);
-		return;
-	}
-
-	dma_resv_add_fence(resv, fence, shared ? DMA_RESV_USAGE_READ :
-			   DMA_RESV_USAGE_WRITE);
-}
-
 /**
  * amdgpu_bo_sync_wait_resv - Wait for BO reservation fences
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8e67a8e60572..33a1bfce79e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,8 +305,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   struct ttm_resource *new_mem);
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
 vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
-void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
-		     bool shared);
 int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     enum amdgpu_sync_mode sync_mode, void *owner,
 			     bool intr);
-- 
2.56.1

