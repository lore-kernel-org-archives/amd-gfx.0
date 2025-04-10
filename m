Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623E9C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB60410E387;
	Thu, 10 Apr 2025 18:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GM/eQ+0r";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3772910E37E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbSGtf+2JzaS5rxosFQtKAD2uPeFNqrvzAVu6RO1/8BNZWeQmj+1lNxyxZO5bMOwXH2VGI+NJxdjh102fs23rYhdtYyju5vlIJbUmDg8gMLTJbiPKY6Z9UVLUbcYkPUiOQkPz/XgvvHB03CzzFy+QcAlr0r2LkRg6iUKleCx7W6/M6+PFatAp6a89eeDb33kqFmiAQ06+vVBSfTdrWaBzE0KPMxZkx0MCoAECXhfKMiQKll8H4c91LO6K1qcryso6//YCkBYQj4aubV2UqSmXp9jxGWB7Oz4KdsL3OFUzBOKEtYMPQhO38Kb1oCdtcKs1YNFeWM9nksXiYlbbsB1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHQqOC8x4xSrJjMlnmg0LjanQe/ZQnr7o95s5bLryyg=;
 b=PLydix1lmEfh8YC1gswAV7gQ5Xir6C1DcDlqAqvCEtYexmx43kuxYI3skROvGeW94bwnZqbLXdus8TWzk7gmHPP8n0XS9HTowAwtmdurW+ruy0aHfiRj6AfMP1UzXa4DL2krS1RgRg4p/iuA0YWIutW8zo49jghAxNXCdfv9U0KVhDe8mLhMo4L3nJoXrPBQN6qBkMKLRwICSOquPLOveUHGPqxdIxhWuKmhXootSjVQJ2t9meZt5z0fV+zCxm8HkDRQ17ieVhxRWU8zXH78RArE48CY/s8wL01FvSHCczIkX43dj1KztwJ3m/8GB2pmtPiY9d6Ribep+5xHGUhWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHQqOC8x4xSrJjMlnmg0LjanQe/ZQnr7o95s5bLryyg=;
 b=GM/eQ+0rkAldKKE/ScMFECm7vDJuQybA5F9EdTkLUwmdavVPrBxn9CgiK/FQOlZTdU35b2yCxPGivljbVPERoaHkV4Rkv4Xr+bW7edhQSdT9fLiA1dXchMRK6ffrUvzoZgHY/Y7Az3WGVzo+XhPaXbVBzbC8lwopG1f+CfhJWDI=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 18:11:53 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::55) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:11:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:11:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/userq: rework front end call sequence
Date: Thu, 10 Apr 2025 14:11:31 -0400
Message-ID: <20250410181138.2287932-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cdc82c-e315-40ee-a569-08dd785b2c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eSK8RNrH5HiEZpccXSApMezIRjVxkDAo3mxIA0eKL19uBC48YWYrt3htsXhv?=
 =?us-ascii?Q?EVMaerLEG/RRYZ/PN8vjeMV4GHP9nHocwO/fQPKxV6ImW5enliwre2Ms5yyw?=
 =?us-ascii?Q?sIIj/Dhuclu0NZyGPbbE9lvm1LbxjxYzwfqBDGvyGOA24EaTdz4LrlFE8pvf?=
 =?us-ascii?Q?TSbxFMfIySPlNnm3zsfR6AdSIwWB5h379fcG455afFkuwWgIEDkTkFRkYPEG?=
 =?us-ascii?Q?iLwjfSicBfbVidcgDE3v29NKZiMayNH4qNgHvt3z0jM1UEKEEkrQ2AItTlxD?=
 =?us-ascii?Q?4MsiBWoeEt7tLUVc5k+avcANUTNPVTAe4honPr7jG2BdalJ5YqfEUZBiNrbj?=
 =?us-ascii?Q?1rymqfLQAE9XpkRAjsSabfn+wm1WPBuaVv+77uZril8mcMpA5fPkNw4NQIl+?=
 =?us-ascii?Q?jnvgOQLkwgFZxD4L9rXFebMSg5RZPArLbQ0NEIoxN12XT/0X/UbglYkCMQYh?=
 =?us-ascii?Q?ViZWbKb5btSvHXfV0jAwfdfxz/FMrGSODh/Y/23uyM0wKIUVCr5FNZSkFVR3?=
 =?us-ascii?Q?ikIx03TUl3DSLkKts0Hhto8W51ByKj0KXnmbr58713ZkQPx77HRp1WHq+Flv?=
 =?us-ascii?Q?yzMJYV0ygOIAdTfeXPPpG5Tv+5rLptb0Lts3JBTSUaxnHSUp08wYJGpIo/VX?=
 =?us-ascii?Q?hMwXrDJPCcHD8FYNg+29mKLQ1I24ziBZS7ZaroilNgxkz40RumAmeNFWPaQo?=
 =?us-ascii?Q?2lpGcmJVlR10rPLptMreuLyH3VxZnVMJtHbSH+oTcKOr4JR3IKnGa7pQ8Y1k?=
 =?us-ascii?Q?l5tRBvlhKHFpC0Q5kJNZyaCObFTrP6+SXcsEq263ROzQzW0tyBcjoRApBoqW?=
 =?us-ascii?Q?3iwtPF9R/yQsdURHxQ+kruXG4hsO53q1wnBlEH0hmnioXl9w6TVVZIKK6np+?=
 =?us-ascii?Q?D2R03QyOS4/ONjMdzmJq7/0jUywTYq9dFjLx24EFF4dZZl9Q+MNIKe4eN43v?=
 =?us-ascii?Q?33MjvkzeMa9r1CJINj48X8UgAfNNL4MJ2BpTYFIpeud4mJ5hoD6XWcJTAC8a?=
 =?us-ascii?Q?hyJgKiXohaCwFkj/gHH78lvsOVQPBMLRqMID9+y7hpaV4Lz0cT5Y2T+M+8J6?=
 =?us-ascii?Q?mdZ0Kx0ARvjtlb3/PznuD2vqHe0j6ei5M4BqY7DqCJLoTw3Kj29+C8/xZ8xt?=
 =?us-ascii?Q?pUxah+77+8TRBWgPbP3hueyNkogJaUpnvpbATHh5Kn+aK1mNuM9IR6jJLUIb?=
 =?us-ascii?Q?uGh2SbKH97Y+6B1/71WB8c5q4ttcDm9kfaTk4CY+YRO+IbQWf5FUHDkdo092?=
 =?us-ascii?Q?jXN59UeBd06jtbvq0nOGRpSq6YT7CrGey+SYjK3Y/591t9KJbGH+0/YZfyMo?=
 =?us-ascii?Q?V8h2JhdDP3ath21ioi93rv2FNHGMTP2IIovIsJ3OwvmfFobPjwR11hnKfX/k?=
 =?us-ascii?Q?L+6lWlETBcKPaGgk+s5h8mxplv+VY+ULz4DT9Q5zN9m9uofgetjXf0imU+e5?=
 =?us-ascii?Q?VoMjhMa+MN7zpxQlQUNd49iFaHaY8olOkgw1LAIKAvtuYtPIfVmR16LeQLGz?=
 =?us-ascii?Q?bHHm6NNzKh6G5Ps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:11:53.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cdc82c-e315-40ee-a569-08dd785b2c07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640
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

Split out the queue map from the mqd create call and split
out the queue unmap from the mqd destroy call.  This splits
the queue setup and teardown with the actual enablement
in the firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 10 ----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2be1e54b78997..c3873041ec942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -263,7 +263,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	int r;
 
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -274,12 +277,13 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	r = uq_funcs->unmap(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
-	return 0;
+	return r;
 }
 
 static int
@@ -364,6 +368,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	r = uq_funcs->map(uq_mgr, queue);
+	if (r) {
+		DRM_ERROR("Failed to map Queue\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		kfree(queue);
+		goto unlock;
+	}
+
 	args->out.queue_id = qid;
 
 unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 94fee99bd2a08..abd32415d7343 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -321,13 +321,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_ctx;
 	}
 
-	/* Map userqueue into FW using MES */
-	r = mes_userq_map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to init MQD\n");
-		goto free_ctx;
-	}
-
 	return 0;
 
 free_ctx:
@@ -351,9 +344,6 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 
-	if (queue->queue_active)
-		mes_userq_unmap(uq_mgr, queue);
-
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.49.0

