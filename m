Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2CCC369CA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8842110E0F0;
	Wed, 16 Apr 2025 22:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMssxFD0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A025110E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDBQFk4mRHrOCIrBvGogOhnU5nlzLdn86qfhXiT0fZ0EdgDg+nT03dmJn3pTAU/lWYWOb1k76Sd99UZo5EBwZ1InnGegdQ9Gihg/8o6F87AU0gl57TvzYGscwSqXsUA2KGhTZnZjOQySLgBmylX/Uvrd0Mhc16oc3n3qTO14zVrCtcryKbde6x2itIWzj/krIdMqYpEqrFcLtHopETyjHJKCLRg+HtUG9rFusWIA2A5TDKz+j1ZoRqZe9CXnY4bwB2f5I2d1zQXYGkaQMoYCd/DPjRUDrISPdRxjhOohgq+0NsgYOwetxkM5uoS3ZRrF99r0aT+/TybkIMQsOMinxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97kG0WsWJsabXsJY8B/vW0wgH67lWhkxj9vow6FSUIg=;
 b=cP9IRkiaVoFDm8uAzyBeShVe+gtv4Oj4TIq+GqGbBf/QJUmbMlzyHlXslaJYGl7kqudLf8pHv6OSfpcvJ2oUvT0u9oCCGxyiXFc6ZiWZlxtxeKvjpGZ4TeeENri+U/HalG0tOTyCkHq9VRdIXD0mTi0ToZLAMwApQUF4rqOMuuvSWEUTkleipjpe/8P3rpx2kp7II5++qsi3S4xUJBDomON/i55yKVBNKm4d8IqOxLj4DdeyUaihRwDDQslWgvlToXjZKiL0GpofEL1N2vFAo39oAA411Ly4aeVM4mBB4K4dIX+Q/G6S7vRD0XS1DLsPMS0JAJQmzXyCpvh18CjbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97kG0WsWJsabXsJY8B/vW0wgH67lWhkxj9vow6FSUIg=;
 b=KMssxFD05gwrxG9GzQh+KnKv1/nMewKg/Ek8ahpyiWCHSLg32fXgt5FsJK/0QTfxYJ/PNOUdlwi9LAVRbG363k6ixRNDO9mQNE5qbXDAFgzNoa5EHJfh7o6louYlUWDDbAjXklRh4ryQBI/PBjVGRhC27htne33CDrgei0tSJYI=
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 22:21:03 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::34) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Wed,
 16 Apr 2025 22:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/userq: move waiting for last fence before umap
Date: Wed, 16 Apr 2025 18:20:44 -0400
Message-ID: <20250416222046.1142257-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 8642957e-e1f1-4555-7bd0-08dd7d34f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BZO42P+P8hLq5wEbk2p8itwSp4LuGLfKjaTd7vZAl31MRnv1SM6UqqUg2/7o?=
 =?us-ascii?Q?GCkdq3AuUAN9gCjqrUmu8kSlvuhAQb1+CEIRZWKHoSy4zp1fcENqjJqWRYOe?=
 =?us-ascii?Q?43mPUR+Hi2KBKZsZOBusp8PrAgBrzTVzYLn6/MFXiAAoJHuz2uQHIwS+Jofo?=
 =?us-ascii?Q?V7KB01cAFA85eXDJwXXajuXRjuNN3aX040E47l983VOG4XFCKRt+5b1ONB1D?=
 =?us-ascii?Q?3yTCAisxWH4wvzA85sPG3qWZyQIbFm173s6xosETye30ikjG35XswwHgOg08?=
 =?us-ascii?Q?vx+08MNJ3bz7BL4G9yZ57fgClsouPdYNZg0al04FrBB5UgpAAJ0O9zDIDWaK?=
 =?us-ascii?Q?UAaTb3XOx6lRFNO/LQYxTyJrtvAY7KMtR9oanb3DYMUDfegS2uSHTnddVNID?=
 =?us-ascii?Q?ddESa9+naEFZTL9NXtSrK1HDWj5E4UJ0bRikD4EsjKG2Hziu1INlUjnV4Eo4?=
 =?us-ascii?Q?1qOqUaB5UrWkcVdGFGPqG1J1XpS9KATx3IeomoAsOfXwUTUIgdhQsKc169tk?=
 =?us-ascii?Q?TUiGZzBLKQYPcQ/quOuo/ioHPvizvN1rQ7Uq+eLJviVwANJLj1zvfPH6S0C0?=
 =?us-ascii?Q?SzzNarmeMk3leFG4e/stYrv/QZxI00d4hjrGvArwqGasS1Xz4n57XmUOQy4E?=
 =?us-ascii?Q?q5QkBHRds+EhfV2TW/qGqK6ti+Ta00kNl8vPlWlTQxfYKvMSmMXqgLjDIDz4?=
 =?us-ascii?Q?l/MeTW9tDTejZRgEKyhp2vyqE3Ge0phPPINSfZ5lTGLy7Hqj/mJ4aUwaz5fJ?=
 =?us-ascii?Q?32/CaislQYAntwHHUZd1ND9rLTXtMQn2oteryToX6GALzUrrCQ2u+Xku4u08?=
 =?us-ascii?Q?91rP2sGBDg4GczBhS0BVpj/u7SRwhLK4uucZN987ei/dmvLeff7ajLBs7Cbk?=
 =?us-ascii?Q?4m6y/RBhuO8VQRMJHmliLWCRE7BX85zR3U8/8cJzy5o9+W/yR6WxIAQXeEZe?=
 =?us-ascii?Q?xG86jJ3B8z6EI3+1KqNs4QcYqfcRV1D3PFfkCFXu3CHn+7fjJNi2x1gwbu6X?=
 =?us-ascii?Q?NFV5bVBNVpWLE4o58J2cNS8rwQ+Ge7njv/Xlc5kW7KXkHIJe2uWuFacFV3bh?=
 =?us-ascii?Q?LYUBftF9Gg8ABTCir7AXWiez6RcEnEM+PoX2L90DKDrJF6utewNCsNILX5VS?=
 =?us-ascii?Q?MUjnWwbrTYJA3ZorNwgDfE6TBF0B/dCsvVIDg/oKQekUYbK9IFcRgVEKAYEH?=
 =?us-ascii?Q?2SThYy+PzGrg/aWRUQtSjf8BWGnxymlEFSYbcYroVyvke2va9caWJ2bCagKr?=
 =?us-ascii?Q?6TJGRSAB2Q6FWACWC7iOInRv6na5MeqdWzBUFfcEcJFgsq7m1geymOoB85i7?=
 =?us-ascii?Q?eSTjRRY6HsUbj3D0rezOumzla6YwIvPG+iuh2VQSLifM1mQaCgY0XorNjmTc?=
 =?us-ascii?Q?a6txTV5gIoqNc490NQ8EpSqdvSXG1/RcDZC3Nt60HgcAUKY48VGJrtoMnpZL?=
 =?us-ascii?Q?j29XTX+ock5eizOqw5eSa+ZSxAVFXB1Fq4MedbeLu0dlc6rgGWCtwgEsawMm?=
 =?us-ascii?Q?HkfbpW7NAWxd3+WulBYetCLTarkvOv7l/wa8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:03.4277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8642957e-e1f1-4555-7bd0-08dd7d34f986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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

Need to wait for the last fence before unmapping.  This
also fixes a memory leak in amdgpu_userqueue_cleanup()
when the fence isn't signalled.

Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 763532de5588d..a2b92b549c0f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -84,22 +84,27 @@ amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static void
-amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_usermode_queue *queue,
-			 int queue_id)
+amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 	struct dma_fence *f = queue->last_fence;
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0) {
-			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
-			return;
-		}
+		if (ret <= 0)
+			dev_err(adev->dev, "Timed out waiting for fence f=%p\n", f);
 	}
+}
+
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	queue->fence_drv->fence_drv_xa_ptr = NULL;
@@ -305,6 +310,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
+	amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
 	r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
@@ -779,6 +785,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+		amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userqueue_unmap_helper(userq_mgr, queue);
 		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
 	}
-- 
2.49.0

