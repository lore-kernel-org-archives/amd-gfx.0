Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1476606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kj/BojRB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9615310E3E7;
	Tue, 27 Oct 2026 07:51:54 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EE410E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ/AQLHs3EsH7/tonYZlVxdabyAXPa9xxoaH9Wv4HRKDZ7oabBd27Hm19KceaJb3/b+sbfELfFYYP6iGKewGnYmmah8YaHzuMANMRslcOQaIJCTRQJ6euOZEE92QO2DVcx6E3ro1QqAkkWVrZTI7yXT2QxYsIhn8wSPE7oXhZwQc8DLxSfaRDe53JZ8NT+VrimYQXTMEotVB/jCHmGPzPTN6aMr86kbC6fRi/ZPbDfdp45P93b3al7Xm9GKKLRghFYwn/9EZqtQmr49jLKovwnGa5B+nP/wrB14v9Luw4AnMYaUIYZ7iAOv4Up7eVhJeNrRMmDykvD0SppacTOSJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJzt1yllslY1R191i20QAryIYFj+NauLqX5F5uoKrY=;
 b=P4zSqMLDh1FABYmQ7cBaL61cpI9cnyAghA0DyljY96Wm3tjmcBOyCwVxDNYwVZadXJDpi1irFcQtL4S/CfvfJ8rJU8aMce6yDxhFTx6ql7Y/XqTB7cSu0JhQFSWWg5uUFMLjsYVw1mzeMTEBN2onl/bAQnpRqnZArFthznQHQtefsG0Aj/Kjw2bslouwz5UpWPZ0C2Mk/ZaPBv1xFEmisiayEBE6nb40wuikR7aZgPsjU/Z8hT/ti0eanpyxJQFUAlVWbMOPfi+LKD8JJ8XCy9KJXD9LR7CxoxQfJ67XtomgyLA0M2oU35Dy4KfSzdnG4Y3PFqFz8TEzczPIEhg3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDJzt1yllslY1R191i20QAryIYFj+NauLqX5F5uoKrY=;
 b=kj/BojRB6ey0A+TYOKmqy5Ooobj5+PZMU7nX23Q+mEDkIPboexzx47XQxa5Cu4cZ5Yjxty2kyKdIVD5xI/19aDjNgRJba+Dsn3vKK8oc6Bty3b/Ys94sxeqfyqxA/gto97O9IclTuyuvch+joeVaOvQaA7aaZ/yL+sUTci3zXy8=
Received: from BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:51:13 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::6a) by BY5PR04CA0025.outlook.office365.com
 (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:51:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:51:13 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 02:51:11 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <amber.lin@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add xcp to reset_mes_compute function
Date: Tue, 27 Oct 2026 03:50:05 -0400
Message-ID: <20261027075017.121456-2-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027075017.121456-1-amber.lin@amd.com>
References: <20261027075017.121456-1-amber.lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5af711-53fe-44ba-b190-08df33ff1299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|3023799007|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: xUY/0AmznNv3/Bk48GOF7NZ5ZaPsN3F/q3ypWhTfDX7+ZsgXRlQJrdrOpmnTSUogFjPLdE6ZgWNsXNTjv3+e0dM16Nunr72VQM/qI2kRCAqwFM+oo3TJFH1eYXGb9DKztNSb3UcSkbsF8PE0YeT5xcMNAAGu1xHdAL1Xpbx6WOH10CWPLPtQ8sTtFftLlZ39ikROEe9G+BGIPkZiknrldOkJZ6jMIDT+YBXlXokXmCTypF0JQq2wKy2qu0xwWg6cILyOp+NdgpdaBzrcXQKWly2JhqKhGr+dBecjxkfpvU6tnF/gMHtXs4Pf5Sv9fdtRsQnC3JEk2cL7NacX3B3csNztuTCkLly2lJg4jgsgN/+cN2ZbQlJH3WsLqaMWTvE7amReVJY1ZZOky6WsPTk8Iv1AU3VBh7MmNlMrFpNWyIGa6q/0BHxNwZMqY0sdXDag0lA3jU/g2Yk3k4RfafGrLZe653VJ77ABnGRAOPx9svX+HlwDqoATr1i3A8b18QxqmJj3ncBN8EmRA7iTE+EaXXV0Dq+pyPr/wRh5K0Wbl8qdOgIn7QSbxYYuA4/rvXb8ooiWp/eCXKrx5dVES3tyNzKbnBS9OVo4plTk5U/ThWZRtXegWuYKxn7uqknaMJny7j9rHWTKNioA2JDOxG+R47/esi8F16mAAF32e7VnPGityaozj3tu1CSGkvIcvPsFuFf0UFbCYyrEzXfZQl5YUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(3023799007)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0BOF0Je4l3yf/XpzkgnlAmcNEJcV/dyT0qWNnV0jhUBdmom0B2PN7OCu0BScGGDEKOhxEpp2wqAiCF9aCDOKH1vRWZL6p951mAaC1XiUriCTFbN75pGRhmBJHu+hA18jWTzIEbscRG1viuKouQGwZnfnk8MAwrBVPhGMWn3CLdSVKgwGoKVII1PSmnSH4pG+uI9cQxKHADwLwMPsBAitLxiWd/4HMgElyeQ1JiJJ8ISY2Z/vWpo7ulAUB1D+3bTmlcMoZFN12rfdMPsFf1esOMLFoZEVdbM9lz5k2SeKvlpnFroXP773ULZ6qQUaR6w9LmIB8XupJvXi6jVpjZd6KL4H+c5P2NJUTSx3DL3W42AFY4SY/KnxYmDvC2+8/EIrXT3NcBvBDvzbIVP3LWdTZOjNY7t+m4GXBzWPDb6UgtphmeWfLSOy3D2Eu1qYqbRx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:51:13.0295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5af711-53fe-44ba-b190-08df33ff1299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

Add xcp parameter to amdgpu_gfx_reset_mes_compute() so on an ASIC that
supports compute partitioning, we can identify the partition's node ID and
its master XCC. Pass this master XCC ID to MES when calling MES for
suspend, detecting hung queues, and resume.

Signed-off-by: Amber Lin <amber.lin@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 17 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0c1c8ae822d4..ef34f7b02d0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2470,6 +2470,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 }
 
 int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
+				 struct amdgpu_xcp *xcp,
 				 struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence,
 				 struct amdgpu_usermode_queue *uq,
@@ -2486,6 +2487,14 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
 	int n_deferred = 0;
 	int ring_err;
+	uint32_t xcc_mask, xcc_id = 0, xcp_id = 0;
+
+	if (xcp) {
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
+		/* master xcc in the partition */
+		xcc_id = ffs(xcc_mask) - 1;
+		xcp_id = xcp->id;
+	}
 
 	guard(mutex)(&adev->gfx.mec.reset_mutex);
 	/* stop the drm schedulers for all compute queues */
@@ -2493,7 +2502,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	/* suspend all will determine which queues are hung.
 	 * reset detect will return the array of bad queue doorbells
 	 */
-	r = amdgpu_mes_suspend(adev, 0);
+	r = amdgpu_mes_suspend(adev, xcc_id);
 	/* if suspend all success, it should no hang queue */
 	if (!r) {
 		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
@@ -2503,7 +2512,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		goto fence_reset;
 	}
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
-						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
+						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
 	if (r) {
 		dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
 		goto out;
@@ -2551,7 +2560,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 			n_deferred++;
 		}
 		/* reset any KFD queues */
-		r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe, queue,
+		r = amdgpu_amdkfd_reset_mes_queue(adev, xcp_id, queue_type, pipe, queue,
 						  adev->gfx.mec.mes_hung_db_array[i]);
 		if (r)
 			goto out;
@@ -2582,7 +2591,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 
 out:
 	/* resume all will enable the non-hung queues */
-	amdgpu_mes_resume(adev, 0);
+	amdgpu_mes_resume(adev, xcc_id);
 
 	/* Now CP is running again — replay backed-up commands and ring
 	 * doorbells on each reset queue.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..26bbec8f92e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -664,6 +664,7 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
+				 struct amdgpu_xcp *xcp,
 				 struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence,
 				 struct amdgpu_usermode_queue *uq,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..7dfe6e83f8ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -153,7 +153,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		int r;
 
 		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
-			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
+			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..fdc0620ca67f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6932,7 +6932,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL, NULL);
+	return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fence, NULL, NULL, NULL);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..ec5ec1fd8b9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5254,7 +5254,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, NULL, NULL, NULL);
+	return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fence, NULL, NULL, NULL);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ce67e56efa8c..0eb4081a5740 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -506,7 +506,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 	/* pass the known bad queue info to the reset function */
-	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
+	r = amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NULL, NULL, &num_hung, &queue_input);
 	if (r)
 		goto fail;
 	pdd = kfd_get_process_device_data(q->device, q->process);
-- 
2.43.0

