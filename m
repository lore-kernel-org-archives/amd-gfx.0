Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A8606D5D6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oCGzzdNX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CB910F6B1;
	Tue, 10 Nov 2026 13:05:11 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A37D10F6B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG2SRcwSM9fMgDE6Tqb0DhvTMyV12f2oGHUu3oaF2P4EgtbawHZUTwPLSt3X0c2qkn7FMGOHxtsz4tckzKwmW1Cmfxvb0WVJw/Nj3EKDt+ntimd7PRDlO9alCRMqSO7ivM+/L8JBKTPxhXiDFKIrMTbFRqpgKccu/9Rpa7vTYsRzt1CFHfCXUNOIqBXG5WWx2Q5VUqQA5nUEqjcK80gxUHNFKSgkDSNzz+W8viF4gGRWM6+96vv7pi9+jMrumxOywrOKqhynq36Fq7tpogs7pGyRlLbEXlj8m/P5jTxqbgZtkIWAW8FTp2jM/KNLPO9AwM4X/1sruYHRi3Elii3BAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaBHisOPdkbzmvarVP5MocmqNn3Zz5Ls5tgUcLwW8IM=;
 b=vomEnlTPcTF47Ca9NVP7poN8zeBWLWkrpY+tM0nFssWmBDpelx9gQqHYYxeoFJFSTYoR45fozab58WSZasevTwK0WNp0i5KT7qZOjS7/4lkGWbq9wnVU+fkNZQDAA3bjfLs4w8q+dzynESAR7pXP3nn8U56nKd13vuZtPReAPVYlHAlkpsmb3xqYUDdhzpGWeK1uRzo1DO76g24RGQa+RYiy76OO3YcEIctQF5nR6buW/6dXT0ijVqhb7icEmugOpdxjIhTxrOsGq+uou+EkFKsSUp0Qbjcs8o3il8Vi/d27HMKtDl5ewgXLnmQBTAJ9/g8xKglVvcretg5nI+F0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaBHisOPdkbzmvarVP5MocmqNn3Zz5Ls5tgUcLwW8IM=;
 b=oCGzzdNX9gVfojSIM8LhAEhwRGoiXsqFk7Ar9A7xEhdmpwVA+i0HxwQzMG92Kzc6Kc2KYdRgxgPHWRil22Vl2ZoTzMvdY19epZbhtI5FGnfXB9XhFR0BdofEkqV8NWDsZuqqzB3ihoebESgF0EUMrVNk9kjj1hqNoa3d8S0cEEM=
Received: from DM6PR02CA0162.namprd02.prod.outlook.com (2603:10b6:5:332::29)
 by DS0PR12MB379256.namprd12.prod.outlook.com (2603:10b6:8:3df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:05:01 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::13) by DM6PR02CA0162.outlook.office365.com
 (2603:10b6:5:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:05:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:05:00 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:04:58 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/6] drm/amdkfd: fix the MES gang context slot error paths
Date: Tue, 10 Nov 2026 21:04:37 +0800
Message-ID: <20261110130440.474374-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|DS0PR12MB379256:EE_
X-MS-Office365-Filtering-Correlation-Id: fddbe58f-7fe9-41cb-16d4-08df3f2b3a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|261009223027099003|10067099003|261028144727099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O3yPIXwWQw+xcRnMlKF9l+/caavAktDWAEINSaKHTR6cxf/ZFYbXNOfEH0+Nd7PcsJ7gRdlFfUSndhV3nDi1Hcmc09ug6VOBX7Q2jaaWy1dBd6VWw8/XYRGCk7ZIfg2/VdTdbTvldW+PSTnE8BkXY9R+u1VHb/nwHdn+hhF0VQwz5RoKQ+ED3cKbgea50GsBZQPXIswzVnpwWNjCr3obTphkr4MKMVkGZ3IyehQBzhdx/w98u4HhLmbnUbfEX4ZjuYmL073de2Lzg/u2bn3vzw6RtzzqAWCC1p0ZpL+5c9NsFDlyRaiYXkDhYkyaFZsyW5Beu41AS75JDeUqqbFrGiF+OfNBN7L7diM6+5D2y3hHJNW3F9Hbigm8tF01JQW68VxUZ21NJ6n6aJ6SGNMgFJea4G5v9q5sATsV1L25IFR6SfA+PjbFjLlgXu9LQKn4LN47ytOuFvr0dF4J6CTi5QvrPVarRHSFRKRYIuRrp9bD1+t85JfIyAFphkBu6x05uDZr+tDlCHvi/Vjuk1Pu+DT2j8CWOzGUm3ewrU9ronL8uTIVm/Q5p5QXhD26SvIRvJiz1aUHwI54bG6bXx2jip5w3dfRa+38rlTxfBI4moQe0wB7U3oDVslsoTrd1KqfLiMra9gyOXPLbzmHOpamSbG+Q9YpamidD+y1eW/YY29MpAKl9FmNeZ326vRQi58T4sJvO1l23Nj4cSk/FwGpqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bum847oOf0rIDpN81PbG3un0Yrf1/u/oz+EdSbmSIPyzBO1m6s+vOAXfTDLAVBluOoxHvW+ZlLD8Lc+NBufpE3okudrbBr1Zv7DyERxr6bV090lnMTtObVWu/agwoxtROoZfHxwUvLE07wYoe2De4WGR6ADWY8yzmaC5cWDJHXk79IFMg5eSI5jN6siWHTEyYNFx4E8d6mG/5ojp/+VDpUi1HIa4h5VqQb6B1JJvFWd7VTQL5hIw55zhcX+PfGRGHN4jgMWaCun7Td3SiakcxGnCa7bqOzGNrlxiTE73PgbpFc7epui/QdEQm4o8+Czil4FoT6JkqAcY4qSFhwcqnpcPMSooa5M4oPVTL7WufXhA9Q0c2t1iHqV/tJ7TcHjWUJqd4sEhW3kLGdvHda/BlE/l0mhcmZbNgy02piku11xzBbZ/QgbcQWDXGFXToZrX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:05:00.8772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fddbe58f-7fe9-41cb-16d4-08df3f2b3a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB379256
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

In MES RS64 mode, init_user_queue() allocates a gang context slot for
each queue after its gang context buffer, but two error paths don't
release what has been allocated:
 - If no slot is available, init_user_queue() returns without freeing
   the gang context buffer.
 - If init_user_queue() succeeds but the DQM fails to create the queue,
   pqm_create_queue() only frees the queue struct. That leaks the slot,
   and also the gang context buffer and the wptr BO's GART mapping,
   which already leaked there before RS64.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4646dfbabe75..6cc0365e9b11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -187,6 +187,13 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_free_mes_queue_res(struct kfd_node *dev, struct queue *q)
+{
+	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, q->gang_ctx_array_index);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &q->gang_ctx_bo);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&q->wptr_bo_gart);
+}
+
 static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 				     struct process_queue_node *pqn)
 {
@@ -211,11 +218,8 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 		pdd->qpd.num_gws = 0;
 	}
 
-	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gang_ctx_array_index);
-		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
-		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
-	}
+	if (dev->kfd->shared_resources.enable_mes)
+		pqm_free_mes_queue_res(dev, pqn->q);
 }
 
 void pqm_uninit(struct process_queue_manager *pqm)
@@ -270,7 +274,8 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	if (dev->kfd->shared_resources.enable_mes) {
 		if (!q_properties->wptr_bo) {
 			pr_debug("Queue initialization with shared MES requires queue buffers to be initialized\n");
-			return -EINVAL;
+			retval = -EINVAL;
+			goto cleanup;
 		}
 
 		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
@@ -291,7 +296,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 						&(*q)->gang_ctx_array_index);
 			if (retval) {
 				pr_err("failed to allocate gang context index slot\n");
-				goto cleanup;
+				goto free_gang_ctx_bo;
 			}
 		}
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
@@ -300,7 +305,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
 			pr_err("Queue memory allocated to wrong device\n");
 			retval = -EINVAL;
-			goto free_gang_ctx_bo;
+			goto free_gang_ctx_index;
 		}
 
 		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
@@ -308,15 +313,16 @@ static int init_user_queue(struct process_queue_manager *pqm,
 							  pqm->process->kgd_process_info);
 		if (retval) {
 			pr_err("Failed to map wptr bo to GART\n");
-			goto free_gang_ctx_bo;
+			goto free_gang_ctx_index;
 		}
 	}
 
 	pr_debug("PQM After init queue");
 	return 0;
 
-free_gang_ctx_bo:
+free_gang_ctx_index:
 	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_array_index);
+free_gang_ctx_bo:
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
@@ -486,6 +492,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	return retval;
 
 err_create_queue:
+	if (q && dev->kfd->shared_resources.enable_mes)
+		pqm_free_mes_queue_res(dev, q);
 	uninit_queue(q);
 	if (kq)
 		kernel_queue_uninit(kq);
-- 
2.34.1

