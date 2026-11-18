Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEC606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fTroLp0p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1005510FFA3;
	Wed, 18 Nov 2026 19:11:07 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECB210FFA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e87D9Qf3HeEGHLz5uBNRl2D3oPg6zbesrwMgwep6GOzmHmDKnZSDPWHPOx0MTAyYEy46ET2wB40x3cSZH7JoiPfooKNDcNiYgjQBSM245pVyVUaf9uYQ7RS/DS1KnutXu+AcnlfAZTT9Jn1VakD9MmmNyxC88Bm9fSMx1Yv4pBuJ/FT+qz97jZyHpsrg/Uz5uYE8rO3bBDnpkRDHX7aaD8zQoK2pLrLNQVFejUmPTSqQB1eY7prmNjfoNXLhOJS4g2lmoBfqTlePq0wBbTbhdfdVih4KEOMlHQQZpesMmF15qTlH+5fsf2M9Yz4RBu+U/y4bHt9/rdLixWLQEQrzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st3ahb48ErsPP+DO6xkdX4HGK4YanwcPNp7by+8f8Y8=;
 b=f+XYYNQKVjwy+JqnktrEYY9QjRxgwoiR2jVRbnXQPf6jczDp5lGZF5ZSffykj7sqO16bdQHj0ovCV1rERyl3FAFR+xuVa1apkwzzZLhn6UJwRmp/vZV7eDVOi/9nGxqjdRgfq1q62KLpk736+vQ/980Gy7zl9ldrOZCSnXIi3zCog3nx9VupgBjhUnF4tngBMLuwTpKb8yW7r8disnFuYEInysLsHlTwb5dYibCsxio1iAxewc28sqvdz1QCKTzeJbIsLmbKXMrHb+sqo59BJLNsLuCwOKmifxQjy/OEIhJWt3xFKDCx8dM7yDqlGP0fLBDo8jqye+s44g6W6JmtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st3ahb48ErsPP+DO6xkdX4HGK4YanwcPNp7by+8f8Y8=;
 b=fTroLp0pdaOCtyowzih1mx7jEm3+p978hsKK+E6A4x3YzP4M743UBRh+rZz3t1EKARYxmvL9ekV30qtl2Fz7KSMV2/OrMO+pYBQQyxuhVhNvzuVeQ6UKCRWJe8Ihojfx02F4IwvL5dmABn6DZ7vEV6qetoCpzvHY+PHGBKngWxY=
Received: from DS7PR03CA0135.namprd03.prod.outlook.com (2603:10b6:5:3b4::20)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:08:52 +0000
Received: from DM3PEPF000265B2.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::4e) by DS7PR03CA0135.outlook.office365.com
 (2603:10b6:5:3b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 19:08:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B2.mail.protection.outlook.com (10.167.23.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 19:08:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:08:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:46 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:45 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 10/10] drm/amdgpu/object: get rid of amdgpu_bo_fence
Date: Wed, 18 Nov 2026 14:07:35 -0500
Message-ID: <20261118190735.1863676-11-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B2:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: c5030ce7-88e1-4943-d3d6-08df45a76204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|261009223027099003|261022105027099003|261021123027099003|261026140227099003|261028144727099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TOSnPf1kNAe6Zgdw6t/UU/TammRcBXavBmf7cbIX6PTW4XSu+E+D1xDou0dURjBwlcvlsJ47VwSFpzq1ZvVkxW9lVIJ7FYvBkoJI2+QTmEeTJnIAUTmiVMz41PXJLh5V0iy/5PhmAnbeYQQoRuzCTEdll6QRlGaYr8JdysItieXNV4QeCNYE5C8CFC4Bg4WBftZVLuaNamKFeEpf5kZH7C3YRzpgqRXNUKloIb7xyoNVfFreDvVu9nBHsjuuqTTBPRzMsk1XxuBDX8z8/v5kCc5NoH/doHnqLEBVFu+blj3qoA5AMo605ZbWxkLeTLplxybSi+VIuZ1ho2G5Wh907VQSYI19gopadCmF2G0R2k4+O17v9V4YdUvg8Mb5xB8Bp41ZENzGwdeJn5JqwZTf3vG2xF5FE35JuGGgIrCA7tKQh5D7jrgHPEnBoqRFYk5BbHPgXqXHmLIq+A4VsQVEKhaY2w42a8Pp0q8SSFHNQg4xhhGhNU8cBUkr/jurkY0Y3rObjgE9eQmuhVvYWuXUR9y0HPwfnkSEt4xkhkrVw5aDR2vi+il9FWbscH6v2sCUMGbRsr0niDs7C8bW9Q2qqzFKKEGdl+2XDPoWpzogjM/Y5/PNWUUlmiiABsC/BGs94RYTzBRzoF7VoKBEUXTW6Luz6J6qu9x1r4si8M6ditwpXSTlpKSQYM6Rf8iNt2xDHwr2074Oc7o3Lor/zuQYaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LCoz9kkyow+p43VLDgJxeEyX398WKH2rPMKjK/oGm4N55PKJA603WqNynNhTYcCLzYvgu5H7rcpclq0Qq6zRWIljtj3Nej8sVox5Eha29+c61sxSOrVYU2q+avSkxuw/iReJFdbWBQMMytt5eUAI3FfqS8mT6F+G/HjQRvf5ayRyARB9my9MI8r12KnrXx9jMyFs+yRLElqham9dUeH2phVIyHVeKR3astvUkBeyXlzFfcnoII65uBVic/xkkByb/j4+LIyWHuSKN1Whj8D7kdsl3OqzLy0AQAdLfHx5bcRE1AXN58Vge2Uoy7rAisM/quJ359B1Mt6n2zSBvrWTWuPCaM6RBLiFlfeU+EdFKfofJkd0uYOrYp8Q6mIaDdbP5Cn8sTSM17MyCIM21ZL23SLP9AxDJFYXQKm8QUTED8sjQY/AFZX64WS1wF3lTNg8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:08:51.5419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5030ce7-88e1-4943-d3d6-08df45a76204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

