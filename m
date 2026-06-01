Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F4CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FC6112DDE;
	Mon,  1 Jun 2026 05:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Itbu6KYM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93941112DDD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epxkT058UK8cN6K8pTpjbkEQZ2nbI8f8qU6ITYAZ6EdZ8krRsEPm8LFonKEhtZZScQQHy8MGObeo2Q6gP441WZX6aEltBy2PJ1GA3PeQqTH7+hgQy8Sv67N+dMq0JoHJDS/TzfKq87ptgpwHMZpF6Brj3SrNFoTPuEYolykhOodVlrETIVgqqmfeEfYDuZLoyYlV8aN0mM7HXARWiyXRgMPRWFaIbewmkuDsaB6cemhYLn25m5uK8TXQ/J3tLZ1+bSxSdJufsIvjXc5wjTC9p+O1MZK9BqunKfKtm6BuUPMyHWSlzpvPIj6bECdE8P2rCuU3k8m+I5Ww3uAGiuiaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcWxlKu5SPN8+eUA2aJIYgfeu9napHsn7vTNk2wuANs=;
 b=cgeoFB6dXxLJCwYGnQPU2psNrEOFwXcC3NSUQaSBC/GM5kNNiW7oCxnH32ijneiFnznqKBOdv+ZZ/t0uHXEk65MHa+hm+FpZnBhQW5E/SklZGecA26+3r5UOTncTbv/JntU/OlxR/yLes/YZp4RrGz0WNo5kOFi5xbwmVIQ5v53cYZReAtk/GA/3kkNfbpkZKWARYFWI5T1zBLgMe0PDY+r10581x+I4yPfVQcLjIsAKrs+ImWAmPr6rztD2Bzm5YkxEAoMmejDDPfuHTXE+TREwjAjYM3OFopCO1xmJTCLtW45Nk5BSRItUr0jCkfaxgrF0CSSO+c469r+n2sydnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcWxlKu5SPN8+eUA2aJIYgfeu9napHsn7vTNk2wuANs=;
 b=Itbu6KYMBfkxWZGqWVmUTw1kJY77bBpk5DKchPF84Tkq7zPINGDrQ4ZL63mFs4tRp5oiiZRMSvZZ1dneY0as7JBc2f+ajcGTo1+Lux13KE392LDmgkzxx7kofoP45Pd2VzuoWH7T5+QUP8XLloP0XHFdpstSxcX76XnJtI5Mlsw=
Received: from DM6PR21CA0028.namprd21.prod.outlook.com (2603:10b6:5:174::38)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:55:01 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::22) by DM6PR21CA0028.outlook.office365.com
 (2603:10b6:5:174::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 05:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 36/42] drm/amdgpu/userq: add MES userq reset helper
Date: Mon, 1 Jun 2026 13:49:22 +0800
Message-ID: <20260601055034.3700921-36-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 32477283-909e-4682-d1da-08debfa251ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZFiz2YVThJTVSQHSUsycxn5DHc95vkjkdYDUF9Mrgy/F94st25dElTGyIGvAg49uenHkNqoSN44716dzSazruyYJxRQ1dXLwRRbYD9dNx9iMk1izxCn5LKIink3R0XAuF4Tt1k152+/svQ/p8JhfZS3Cg2HoxzcROm8jfjpSpcIN0fCoTC5MSssMvvb3Pkkw9z5k42yCPr+P4qg190ub6fESblS/tDxtJFK+GiaTR1aUQcn1v4Tq9WfugrN/2Bt5+IZJsDSMxfziMEQ0WhzXmzcYOIImYfga7bh5Fn+S8Hn8tUPJjZprzgjT5m8TTQRD5Z45u7FNe/rVwe6AmYTQr/KgZ+SOhx62SDrE0r4r1BiMx1AaayvC9NlHS8X1jZUWQ+M+X+T3OtuB0ocHtKlzXDObS9sQs3bIj7Gujkgf8QkxTbdfLHdejpxCegc8rGQnnYhv86V8zUox7Lz2z7z6Yb/zi5nfmdm/cPKo0f0vhTKRJWFVDOc0gvHs7cDQX4kEllB7t/ryMB5P1J7vqrad6eU98TKVpT3aF/b8anDTYvemjBT1M+QrsmAE83RhOgLmYz7LR6tFvX8D5pEqZfQM2nq/7BfepEWai9o8yz7iXbXeNPok4JxrXuVfRGkcuVNEGxSc5ByxNxdaBVIqXxtLrGXUEyVsZiKILxaRQ/+X5iNrsL0HVoHbNS0THvMn9eN5tygqpI4LEIqkK+5O/V72VDWMbJ2Au3EFH9fSc75Dnb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zkbeFzthM3YLxnXk37etixvdNv7smb/iwiutXGXbmX5d3jsgEhbD7gGOxXSkeZQc0MVHyBg7qug61tyETmr4zZkssvFoOCvYBDsfDt2qMDM47EcBoedjYgKalNLpvT4t0JFHND0V+RwR+aSLqrjArb42M6F173/EH4tfOZeWSjfbrAaMDq1Tw8RyUbIsGKqYuDAvnTmkFfSUm0XzbjCcfvkIe43rjoQAV0BdxW0TQI0aHKCs5C6veGE+76rxprxDRzVG/VyKXuB8fwyOo/LBn6kBJdp1z00WzyEy+WK1Wiz8hhF3IMclkm6r8z8pp9pNwecrsVF8LisXIaF0lrD8xUWlOJPAT5uZQW6s2u09GMmEx8XyAVmQK9KMsYLJ0t1xhZdCa/QTSxbpqfFO1LSckPJQqTSREZtqmgJO71daSbRTN0v0p5MLNG8WO/KHsMRJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:01.2730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32477283-909e-4682-d1da-08debfa251ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

From: Alex Deucher <alexander.deucher@amd.com>

Will be used by the common compute queue reset handler.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 39 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h |  9 +++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index cf7e2ab66d10..5e6a146109fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -177,7 +177,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
-static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
+int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -197,6 +197,43 @@ static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	return mes_userq_unmap(queue);
 }
 
+int mes_userq_reset_queue(struct amdgpu_device *adev,
+			  struct amdgpu_usermode_queue *guilty_uq,
+			  int queue_type,
+			  unsigned int pipe,
+			  unsigned int queue,
+			  unsigned int db)
+{
+	struct amdgpu_usermode_queue *uq;
+	bool use_mmio = false;
+	unsigned long uq_id;
+	int r;
+
+	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
+		if (uq->queue_type == queue_type) {
+			if (uq == guilty_uq)
+				continue;
+			if (uq->doorbell_index == db) {
+				uq->state = AMDGPU_USERQ_STATE_HUNG;
+				if (use_mmio)
+					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
+				else
+					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
+				if (r)
+					return r;
+				r = mes_userq_unmap(uq);
+				if (r)
+					return r;
+				atomic_inc(&adev->gpu_reset_counter);
+				amdgpu_userq_fence_driver_force_completion(uq);
+				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 				      struct amdgpu_usermode_queue *queue,
 				      struct drm_amdgpu_userq_in *mqd_user)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
index 090ae8897770..a473360d6a8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
@@ -27,4 +27,13 @@
 #include "amdgpu_userq.h"
 
 extern const struct amdgpu_userq_funcs userq_mes_funcs;
+
+int mes_userq_reset(struct amdgpu_usermode_queue *queue);
+int mes_userq_reset_queue(struct amdgpu_device *adev,
+			  struct amdgpu_usermode_queue *guilty_uq,
+			  int queue_type,
+			  unsigned int pipe,
+			  unsigned int queue,
+			  unsigned int db);
+
 #endif
-- 
2.49.0

