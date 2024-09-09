Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B93ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C566010E683;
	Mon,  9 Sep 2024 20:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZvollT+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A12110E682
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Quw3SaOjbmFNaxvnrzij8lBHP9N0K7yGe8NBm/H9vZLeQPMueWL+jPc8d9382t3Qaz5wEA7eNQt+23yOXh82Zr57UXsmV1kt9b6mpv1YoLNkKP3Zk34cg/PKva7TQ+BO1uUaDDUhKWSemn+0yHe8amSgnjcn7OfStJc+JhZvUENKEa5CKvMbnU7/8aGt+UcvyL0c2DtC6/zBRfUlzTdaIPDN/mzMgnR5W6AYvLw4x3k9Ew8R/LI5KOERxEEcRD13PWYbFeDF2sItNYcEVqGlT8YeHfGr331XIzD7J6l6qwlXVl/d1+x0f9aHHOQp4W2D3Os8GCNjpBPGQF8MB64+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbCXtUHRjUsICj8RTdCVUIf6qDRAGXSPVQoT9co4cII=;
 b=fRov2AxwPIPSZ4ZIQC33Fx7rTt+P7PABfyL6fdav2n/mTm8dPZGx8MxqiJ1LHtI8aooxmIBed4DZVTnXIxp+FVLyYrVyZSI3z8SlZCeRDvz+NV7Z/89+DVY7bp8yBvyn4Dx5YoEgtnEqrBdz90VWKj/50iZOchPrca0/fTjC5chk5blZ45ork/B7QzZAZXn2TE7vOImQNFqBPylARvYefA8rm6N8i99srIAPe70EObrTH75c5wXUvbURIMjedIOTYzJKn5rA2zboGo3SPdUK5rJz5co+XRdbcIIj7nbEPcjU75HJyG2ZZ0QgkwbjpxS5QrKHMWiOvxEi4t6mLkm+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbCXtUHRjUsICj8RTdCVUIf6qDRAGXSPVQoT9co4cII=;
 b=KZvollT+nXQkc2A36byueKmBLSB+43Ir8C3lVACWf3dZqPaMPp/IspqLKfQMHowoM5S0VtC4vZaanuQnX5kHM9Jm5REBvg/quwWYhFUGIZ/J2aY3QlC2Ofun2Ndho5sL7oCljHxmeHLPo9qQ2QwGQGB1FYX/VAxywY0/IcYhj3M=
Received: from PH7P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::32)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 20:07:06 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::82) by PH7P223CA0020.outlook.office365.com
 (2603:10b6:510:338::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:05 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:01 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 06/28] drm/amdgpu: create context space for usermode queue
Date: Mon, 9 Sep 2024 22:05:57 +0200
Message-ID: <20240909200614.481-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e0d812-7510-4314-8ad9-08dcd10afa52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UW4PB8hW84Oo2j/CTZtPDOrDWUFL4xAMMYI3nI7xNJ/r93JnirQSPiXaBf40?=
 =?us-ascii?Q?lEja+RDSCnWq7986fC7ORUgvRuXCRu9y+PeP3zYe0/86aVf8wLq3G/o+ectO?=
 =?us-ascii?Q?20rmANiV7wqdC86ay4FFaD5xbpVviD4+86F8HR6GnbKjZ3AdIOmf4S3oRG1+?=
 =?us-ascii?Q?xTTypQd5Oq0NQeTja4xCCGBvvF5cUY/jXCVD5fgDgZ97sozoL21/DaUZOzex?=
 =?us-ascii?Q?iiG88n4KL5MmrQkk+lthQePT3RknGbyuHqm7zViJy3KczNsX3t5rK1WQjE74?=
 =?us-ascii?Q?fev5Buv42kg26xutw7/pFaHXJsQGUscn18Pd8jChHOy+BcRzCEtpgVUULYIM?=
 =?us-ascii?Q?YZTW57isPcoDOsJ12i+XBWFdWV8qW9FhXkRmrkF6vF6fSzCsHN/3TQHfvP+F?=
 =?us-ascii?Q?W7r298z5F9hx6ayskbDjTL2d3nyPZghLR9NqcpyAaNsu1DUzmZE9A8vCiW9G?=
 =?us-ascii?Q?wQEphc5c91F/MLOPKq3GuT13ScE7ORxdhMpnyEJ/FokW+SWBM9fEnvOttUXj?=
 =?us-ascii?Q?mhlKZ6cdlWtlHLUXlbQJShySRBtdQh4pNKLZ/WAwsE9kQGLgp3Nsmh/zFOeW?=
 =?us-ascii?Q?ScpJ2x2KC6d+X0zf4AYEDfSQhCOzfVrz9eI5JSv3qe3G/gOoNvtmmvY1jK23?=
 =?us-ascii?Q?w8fQO7IvwnnaMjc6A+yQumDfQYnqlfWlQOK0j3UBjykXrifEc9YkJnIbC9HA?=
 =?us-ascii?Q?ULqAN2Umq2kEeaTKpfrTW4ns2HQG0jBFBd6WoXf57ox98cQ+LOCp+TN4eK/p?=
 =?us-ascii?Q?JkUMnfP1kzCoE9vXTrS6cpSeh+CnotNVyRLYiE7VaBtGVMCl5qHHoTJfXs7v?=
 =?us-ascii?Q?9aIhCGJyOtTIts9RaCtnhZYMiLYrUUMUXgeUt3povDxWEg7rgYd+Zc1Ohm6i?=
 =?us-ascii?Q?ufNvX+f2pQq+HsRyO4s3YM6tRFF5PzwPZ2U8xBgbbiE2N71Q6P0Z1WYauf5U?=
 =?us-ascii?Q?yLhrAEx2LYz5uwJAN/hS+x1GGwi9XH4Ho2TzqKw0FE17Or9kwzTsF1qBw/Jz?=
 =?us-ascii?Q?eeqyFnoZGYHaPBfXYGT+7JJH96iFdVaBaSIad4kezcrOl+00HffHpMRC3dUH?=
 =?us-ascii?Q?C16QCkzbsJ3rvctdSzVS31xAwb6CTy0F0FFzL2JqCcS1srbI46z3Zw2b5lZB?=
 =?us-ascii?Q?cg5z7aFFS/vtXsfMtXa6+/aj0MKJXk6MGMXQWPkoAGE9n+XjfIHo0DqCN0v5?=
 =?us-ascii?Q?unPWWrNCcN0c6DQ6VXRTIPlfIMPxbz6iS3UHcz8ZfW2pIT0oDAJplTUPrcrg?=
 =?us-ascii?Q?qcLlzPCUDS7BIFUnwaibiKyWIssCC64rKOBaQ0JGPmfkZpg/0aQoGmHd/JVC?=
 =?us-ascii?Q?jTw+NsSBuMFXFxzJXXQukG972ifNN4qX11snxmEEh6sqolUPfVVoiWsiuyvq?=
 =?us-ascii?Q?VJaHWufngAnzgaqZ05c9b1fQH3bp6gQhoeG48+k0uu1FGNBl+ALR0ej1+gK7?=
 =?us-ascii?Q?nc8iFVQ2voupl6+1v7BYdQZ4Azl9/erW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:05.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e0d812-7510-4314-8ad9-08dcd10afa52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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

The MES FW expects us to allocate at least one page as context
space to process gang and process related context data. This
patch creates a joint object for the same, and calculates GPU
space offsets of these spaces.

V1: Addressed review comments on RFC patch:
    Alex: Make this function IP specific

V2: Addressed review comments from Christian
    - Allocate only one object for total FW space, and calculate
      offsets for each of these objects.

V3: Integration with doorbell manager

V4: Review comments:
    - Remove shadow from FW space list from cover letter (Alex)
    - Alignment of macro (Luben)

V5: Merged patches 5 and 6 into this single patch
    Addressed review comments:
    - Use lower_32_bits instead of mask (Christian)
    - gfx_v11_0 instead of gfx_v11 in function names (Alex)
    - Shadow and GDS objects are now coming from userspace (Christian,
      Alex)

V6:
    - Add a comment to replace amdgpu_bo_create_kernel() with
      amdgpu_bo_create() during fw_ctx object creation (Christian).
    - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
      of generic queue structure and make it gen11 specific (Alex).

V7:
   - Using helper function to create/destroy userqueue objects.
   - Removed FW object space allocation.

V8:
   - Updating FW object address from user values.

V9:
   - uppdated function name from gfx_v11_* to mes_v11_*

V10:
   - making this patch independent of IP based changes, moving any
     GFX object related changes in GFX specific patch (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Acked-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 33 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 63fd48a5b8b0..2486ea2d72fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -27,6 +27,31 @@
 #include "mes_v11_0.h"
 #include "mes_v11_0_userqueue.h"
 
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+
+static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue,
+					    struct drm_amdgpu_userq_in *mqd_user)
+{
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r, size;
+
+	/*
+	 * The FW expects at least one page space allocated for
+	 * process ctx and gang ctx each. Create an object
+	 * for the same.
+	 */
+	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+	r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
+	if (r) {
+		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -73,6 +98,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Create BO for FW operations */
+	r = mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		goto free_mqd;
+	}
+
 	return 0;
 
 free_mqd:
@@ -88,6 +120,7 @@ static void
 mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index bbd29f68b8d4..643f31474bd8 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
+	struct amdgpu_userq_obj fw_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.45.1

