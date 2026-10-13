Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDCDCC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B1410E792;
	Tue, 13 Oct 2026 09:22:12 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8615510E75E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM5kEWWMhDr6g8qELb82p8IJNPxKiZ+Rl6zypZOdC0w4BFCokSche+wDQEtTF+iTQ84I7z4upZlYvFMhiA0bH2OgyqBZ4Y0EKwf3eZ5y6ywJrFBlQU2m8solWQMhsdBJJ6j3/84Kkp/7rqScHxZFDPJhM+FkO0fk3NCF7/zr5OORXT050wSdkRQeDR4B/gi7Ul5ym0Bf8p46hdzJSIDM0YcV0DPSPXURq+YTlZjrom512f7DvtBYtwU3Hep8EnPrDltj+4Gc0cnTgLDp+2QHrm0D7AotJ1ULiQP2OYrvpISogQnU/pdcC9r6SAejKzQ0gDQJTXKCqQkTok+1K7Nr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5WSzoaIL23E7Gls4lFqmOPW8G6YwwQk2PNe6wS92B0=;
 b=X1E3xtzA6zFwceedtpmLp9jX79wO+yLmSIjA8B1n5UL7Cz97fkX4r9M53qde7vurAL6eTxu0gI1lZunQIyxNATjpAEYX74y4KXRebjc4RRqzy/wNgfUuSeB2MZx/NuiFWu8pKsVNsgkAJLhgBUrx9eZPt77Z65CiJZiNth6F8/ZXQtSDZ/xzgQK1V2SnhBSTC0Y09poqe8vqs6G4Sz8MGoDtJzYGMLmTaLJfQr82pTLZMJdMuUa7v83rcBXisQpskmmt9gdH0bJxnVWnxvAShQqsTJUEZvy2HJLJEh5/kw1ITU4QJFPNKFUycFOT9TZL6JL135k8SBFnlL+QogzRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5WSzoaIL23E7Gls4lFqmOPW8G6YwwQk2PNe6wS92B0=;
 b=os6sKLDAjpWS4Ilc1DIlWzjj34TKcE/ARDWRiNpP1uuZ6nCGZ/+SQu6UlpnjlrVbkzD8yxCLsC7j2AXVIHIA1GhZo3hMx/GDudb/rhj+ll/TwuM6ogrhuVTePJY8sSrZBgcD7JZXY3vYbZzS354y/dORlXt7Cb9b/2/h6n0NySY=
Received: from CYZPR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:8b::15)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:22:02 +0000
Received: from CY8PEPF00000050.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::66) by CYZPR12CA0015.outlook.office365.com
 (2603:10b6:930:8b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 09:22:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000050.mail.protection.outlook.com (10.167.247.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:22:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:21:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:21:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 04:21:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: don't drop an SVM CWSR reference that was
 never taken
Date: Tue, 13 Oct 2026 17:20:42 +0800
Message-ID: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000050:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 18096a8e-4ff0-4bf2-731f-08df290b70a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|5023799004|11063799006|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: SoiWTn5xhE96+zOyPMzoV4rNxsun6dN2o72n2A6wceWYSHvhBydjcECA1uXCdUJ9EJgTjoPEWbJJbpLY4x+36iJpOVoqNqC6u6CeYNkDOYQwaCyDYqanrCO6zMufvZjRB/us9lOUyZDqNjfT592VuOxq/6y9/ritUgaqZCbMbbGN/bLnC6mP2QJQ2a5p3jcIOZUF4ZWYjLSYH7Zvs9XrTQuppceNHRGdw1tOPuX5unFWSCD8t9sZMoAw+Tjh95SOEKCF6pofP1ykgB9LozLjT1mGkeattA+zM7l0kMP1O9E5HYA5JKGxro3CrlNKXjncHOYg9Yya3AAzlcRNEmf0NV9tqf4JKTCYO166lbaTly7E0yoRb3RLDIZvH9QbqapVp3GKcEMWyq298dJL2dH3+ArooPua3GwVrGdEiPPksIlIBz5nt7Npe1d0aSdvR5KECUUY6TJruBGt4nQje0tLaYgRzS6nnrOImalv8NuuPqttz9qTcv6Xa0cadh+Z87gHPtayt9vcH/XMPooLJZkUky4hI5LEnZC4vUr7BNqsDry64pwoQZcVhEAysrk2v7sND6k4ypNDfHwix+jkwwMaVXHr9XAOVD33id/LxUpFy/uqzLeZFpWrK1Kb0IMcr7i/mHVV9blmVjsq2RMZ3FfKEeTdn14akSasY5JTPKvC3DO8PIK9Qg5MXUjSkWJ0qEZPTmfLhKaGCJnIdD49fFYyFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P51bHHIPDLYXVQUvEvMy5RZu4sJ1xGbMdAuJQbumhjDpGIIjXGj60rgCmAUMr2lJe6NiM+jaVSZBcabtklZolqXzBgljdDoAINvoA6ZtrHqLY76+9mfqvZY8kZksXp/nx0JrB3xlApe3gBn6dG7L1UcOMd5+YuOOzKu3+cGlt5hOC6FxjeSnAzqWjATdzierJb+MiriUDceYlb4mT99GC55Hx7JJB3gF6azyvEtXGkN95dPt+OOyEJWpF+KpP7zY+jWYYBwb+KMC3XrilMfgmz1AUDJuypoFPpzYZ+BlUz0noyVXWeLV7azP7AmW+lIgig+IO/UZFOxcvu/6EFAuOmTFxZnH3MXJyiDY35wUm8Yd5Z3wCwKS2ARINPmtC90a1CPa6QKzSAgskPMFsE7x1pBBf1mxgmelxJCDDKs1tmBYUGdnmbX3oeWvnDJXGDyq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:22:02.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18096a8e-4ff0-4bf2-731f-08df290b70a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000050.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

When kfd_queue_acquire_buffers() fails, its error path calls
kfd_queue_release_buffers(), which also drops a queue_refcount on the
SVM range at ctx_save_restore_area_address. The SVM range is the last
buffer acquired, and kfd_queue_buffer_svm_get() takes no reference when
it fails, so on every error path this reference was never taken. If
another queue of the process uses that CWSR range, its reference is
dropped instead, and unmapping the range no longer evicts that queue
while its CWSR area is unmapped from the GPU.

On navi31, with queue A using an SVM CWSR range: munmap() of the range
logs

  Freeing queue vital buffer 0x..., queue evicted

but after a CREATE_QUEUE that reuses A's CWSR address with an unmapped
write pointer (-EINVAL), the same munmap() leaves A running without the
message.

Only put the BOs on the acquire error path. The warning and the eviction
are back after the failed CREATE_QUEUE.

Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ae3e7c54014a..6010a5d7a7eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -230,6 +230,15 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 	amdgpu_bo_unref(bo);
 }
 
+static void kfd_queue_put_bos(struct queue_properties *properties)
+{
+	kfd_queue_buffer_put(&properties->wptr_bo);
+	kfd_queue_buffer_put(&properties->rptr_bo);
+	kfd_queue_buffer_put(&properties->ring_bo);
+	kfd_queue_buffer_put(&properties->eop_buf_bo);
+	kfd_queue_buffer_put(&properties->cwsr_bo);
+}
+
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
@@ -343,7 +352,13 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	 * dropping the VM reservation.
 	 */
 	kfd_queue_unref_bo_vas(pdd, properties);
-	kfd_queue_release_buffers(pdd, properties);
+	/*
+	 * The SVM CWSR range is the last thing acquired and a failed
+	 * kfd_queue_buffer_svm_get() takes nothing, so only the BOs are held
+	 * here. Dropping the SVM reference would drop the one of another queue
+	 * using the same CWSR address.
+	 */
+	kfd_queue_put_bos(properties);
 	return err;
 }
 
@@ -352,11 +367,7 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	struct kfd_topology_device *topo_dev;
 	u64 total_cwsr_size;
 
-	kfd_queue_buffer_put(&properties->wptr_bo);
-	kfd_queue_buffer_put(&properties->rptr_bo);
-	kfd_queue_buffer_put(&properties->ring_bo);
-	kfd_queue_buffer_put(&properties->eop_buf_bo);
-	kfd_queue_buffer_put(&properties->cwsr_bo);
+	kfd_queue_put_bos(properties);
 
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
-- 
2.50.1

