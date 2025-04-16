Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1CFC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7121110E899;
	Wed, 16 Apr 2025 08:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhoMO90O";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C9C10E899
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQN3iBCIbbY7qS3q/VXqr79yDUV175HFumRvQ+pdDUk6XaGL0a9KksRj/xTgviTXTLd/kFfkiOqTWcGDQTcEfmKDLde3FcGUh3ZaPxqk9GBgIHjlx8RU0hRBUw1HR+yPvgnfwwbbI9Oa3usDhym99wUtzfF68BkzDB02AbUMTsVxkJ8dHWKVpLVqC/MfQlzjO+4JuMnxrEjNvSRdVRvde8s9N1FVUIxGmyHFwBI123CW5/ZlyoIbHV4mynVkb/7d+lfNMd6A3CuPu0IAI3vfLi2sKl/3V3DGVkvLGUxqQoJdJxgLtka/3Wnqhsn2e7RhsmzwYHF+rHorbqspJrhaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xjoI1vX+umBJjyuje3oifJyKVrB3DAKDTKrDJE+OwE=;
 b=Sb2PHveNRHdQI4dVRlO4lGNgMk1QDqybz1umgdHKDpWCnfoeYBG9lVe9W/Uoj0W21zPWLjtSaaX0hAGlFL6AyjiBnjKuAj80O7JvQ5EY0PdhaETVgoZxYAmHbHQAzBBYk0vC6PSTgMgzc3mOUd5lA053m5glP1pkptMIJaM/KtrBP1i7UG3am8wjO148Ibt0AvzwLjQtT51rUYAi5vXb5te9bVph1x2+gtcyS7mjm3WcupHttSET37JU8UIRUUrUEZLB8c9BKzpgeHdIKby+hMI1VnxkNKxDjLaJFr1aQCN56+0XlIUGT1PrXu6W6kB2FtPfuwVuuzdsZmLkluJKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xjoI1vX+umBJjyuje3oifJyKVrB3DAKDTKrDJE+OwE=;
 b=bhoMO90OOBW7Ad1g8QCDpQ3fbZ3ZtRQ8C9PI7+2/d4IvPnWFJGcwkb4g3eubMlUkXIkt/Fqf4rVnU96Dn6qUfa7gE5s3K714v84j+50m+c1LjgvbOkI3kE0c2YBkVwEjSI0ljXbObkeWGiGiFWLyM9Hm0KonZilI+JmyKkniqas=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::616) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 08:50:46 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::82) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 08:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:50:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:50:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
Date: Wed, 16 Apr 2025 16:50:29 +0800
Message-ID: <20250416085029.2278563-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416085029.2278563-1-Prike.Liang@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dba313b-57ba-4a79-3b19-08dd7cc3c7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7BQy/YwxZwsIm5U0ZUthRGtEx7p/weK7kyXGGttnouLor84gShNXcjda/XK2?=
 =?us-ascii?Q?DAlGLjJUwx+eDwmTeNI6SpDGYDvwTiyMsJRmmabJVj0+S3803GHTYkANANHp?=
 =?us-ascii?Q?srJZOtxwDFeNyURqMiw7g9LOGf2Abgy2gBFhC3EyBKTljT3DGPTh0U7zE1o7?=
 =?us-ascii?Q?Xv4+5p2aBSUaC78AOBGi97hL24p6EwCIcMck0DCrvECe+XrmIepwil2iW4hO?=
 =?us-ascii?Q?nau18oPv7/fZAmTiPdrO5cXc/e/SqkTiRV9Pl87HRCjNk70cnsgp1wlF0nQk?=
 =?us-ascii?Q?Lp4b7U7/EbKePIuyuJ4+v1iTjw+Y0JEWAatK5ymlwT8XrtABVjjZoeldWj8M?=
 =?us-ascii?Q?QtS+aMoIoD9oUuul0el1ixDVpvuCOU70jY12MfmSkbDdJo/yZVmnPMlqQmGG?=
 =?us-ascii?Q?vai39za26FYI6t5x9x6BUXFbN6iY0DylTNb0t/U07McyOSlfas6Xnv6Z2Jlo?=
 =?us-ascii?Q?0hSLMlOx3vnrx3g10aDhn+0T0hAXuyQYIUtWmaXFO+ScLRv+V45kkYOUbEqz?=
 =?us-ascii?Q?ysFljS9ZoPLV8yapjutyiYAiuySPB1kqymIG0xh9G7D5epK8xycBnPlcJS6h?=
 =?us-ascii?Q?zl7MOfjVT/MGjpGHJzTaA4l2U7JFoFEAxcWbeImhjOxhSP+l2hcllOuc1RWw?=
 =?us-ascii?Q?EZWj+9HnlcByD/04dQbWNruVueu76p1cCEoK63FfV6MIIqtoW7PzTjUjCoPv?=
 =?us-ascii?Q?CCCzqjdhpsDbXbMU+SsEL0nvDFGk8kStRf939ZBG/Q2KoYINtwalI6xbTlL/?=
 =?us-ascii?Q?N885tjp7ePbyLMFrwbYJxrgcVlRDOw93Ks7lQ9Cb/0bLcmVTTdqhdwW3NmtA?=
 =?us-ascii?Q?sQzLnDGtDhHQZJvk/ZkstZuol16RI62a5Q2t+qlPzAi6/6QvKNDdYQF9oaH1?=
 =?us-ascii?Q?qcgc5UJNLFGdQgl4vAVT83eV5O9UW73nrFbSouMg7pgBt689GvREaLszdr12?=
 =?us-ascii?Q?DtUpi4+LXzgW44u/5DLRupsQybenKWunqUlmPEPB3QwA5h2aBOdgpiNqXoN6?=
 =?us-ascii?Q?1Qn7rigvIb/clemdy6e9eJgZ8NNM4Sm4ciLadx/qiAGXSXT5ExsrA/Tgr103?=
 =?us-ascii?Q?czr6l/1ME7MfX4RmWgd7drxj4BDnNFXam6qA5PXriUb7gGlasdIp9W4Gg/hp?=
 =?us-ascii?Q?wQjjjnIBoESj6En9COeuGreP/WdhjT2agsB8+xfeqTh5zf2d72uN52En7bFY?=
 =?us-ascii?Q?mY7u2cikQYaldrnhU1J5zoizc9vH5IdUUY7W1KKjsIiEnAvlePycdeWzV5fH?=
 =?us-ascii?Q?KfGTMbwJ1Req4NsrBih45add9ITuADoDjmsp1TEbAJ5KvDFjP8MVta1elKJ/?=
 =?us-ascii?Q?s+5dCrqS7pZBdcO263Kw9v+q4rln+SBC/MGSvJ19IKJJaFoHyXRES1d/Wxrb?=
 =?us-ascii?Q?vdPGxJWGTE6d2ekxW7ekGXI+Y9Qne/Z/AeOigzNFydb1JpjekuMp/zjTQ0CJ?=
 =?us-ascii?Q?KF7YT/cr479ktosipM7iW2iejKmT4VTr4cIx+0B9sPjr+GnWqiT3G/NZGdV7?=
 =?us-ascii?Q?3mEwcOeJ6nmLBtTPSWY8KRBz2m/DEEmXe8II?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:50:46.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dba313b-57ba-4a79-3b19-08dd7cc3c7ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
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

Free the evf when the attached bo released. The evf still
be dependent on and referred to by the attached bo that is
scheduled by the kernel queue SDMA or gfx after the evf signalled.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 31 ++++++++++++++++---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index b34225bbd85d..60be1ac5047d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -27,6 +27,7 @@
 
 #define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
 #define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
+#define fence_to_evf(f)  container_of(f, struct amdgpu_eviction_fence, base)
 
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
@@ -47,7 +48,7 @@ int
 amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				    struct drm_exec *exec)
 {
-	struct amdgpu_eviction_fence *old_ef, *new_ef;
+	struct amdgpu_eviction_fence *new_ef;
 	struct drm_gem_object *obj;
 	unsigned long index;
 	int ret;
@@ -72,7 +73,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 	/* Update the eviction fence now */
 	spin_lock(&evf_mgr->ev_fence_lock);
-	old_ef = evf_mgr->ev_fence;
 	evf_mgr->ev_fence = new_ef;
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
@@ -102,9 +102,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 		}
 	}
 
-	/* Free old fence */
-	if (old_ef)
-		dma_fence_put(&old_ef->base);
 	return 0;
 
 free_err:
@@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(stub);
 }
 
+void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo)
+{
+	struct dma_resv *resv = &bo->tbo.base._resv;
+	struct dma_fence *fence, *stub;
+	struct dma_resv_iter cursor;
+
+	dma_resv_assert_held(resv);
+
+	stub = dma_fence_get_stub();
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, fence) {
+		struct amdgpu_eviction_fence *ev_fence;
+
+		ev_fence = fence_to_evf(fence);
+		if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
+			continue;
+
+		dma_resv_replace_fences(resv, fence->context, stub,
+				DMA_RESV_USAGE_BOOKKEEP);
+
+	}
+
+	dma_fence_put(stub);
+}
+
 int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	/* This needs to be done one time per open */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..da99ac322a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
 int
 amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				    struct drm_exec *exec);
+void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1e73ce30d4d7..f001018a01eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	amdgpu_vram_mgr_set_cleared(bo->resource);
 	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
 	dma_fence_put(fence);
+	amdgpu_userq_remove_all_eviction_fences(abo);
 
 out:
 	dma_resv_unlock(&bo->base._resv);
-- 
2.34.1

