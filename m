Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B41F34C51
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6C410E3C4;
	Mon, 13 Apr 2026 12:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YeLB5pwF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF7110E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJMKZmtV7a7vjBPrN+rGL/c2dCqBIETwNBN8UEIEIos5/mYiyR/StriMjcOaS8y2M/AczM4tXanG8AXdfLCjmOclN1QJtcc5zK9kNSSk2xeJf7RKnuNXZAXLZ8bCiKCggRR69Tb0Ed1B3Y4+5Cv10/tUaBUMSw6glF959n3gALafOvCMZw7pvpxCm4412kK2CMg9cjOgxTbTDClKGfnR69gncjgX6WBcp7gsRxY0rH8GR8HaCMWt/qIJ4XR4Gw/ifDbn+W/ZwBtry734t+f2GQQqvjCSKZPZiir680JAkbW/F7Zya2YdmwiqSDDRq0HlUh4ro7RacfRlHzAgzOm9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLCEGsx6SMCrKyj5hhK27mLd6eaiWQwKR8LtMtyIYnQ=;
 b=UcntRto8C0FZIUzFrHbnm4VyCxn5NrmGvJ+Tjyl3QHR2mtN1t/Oxygh8k6Uiqrp0L0TwtC6LhWCyt4dAEGNHPRuz7HI2QMMqwEoQexTLmwTh4biKoAgo1bw/WIB5aV0aHpZcStx5mZI3m+ebK35EaO5TyLvFtUapKQfdGsiY8+bs+x73k55AHGF3HXURIrOVu5wf98hDUk4C4wI28ELwKD2CB7sqv7u2UMF43KAdZCy+xqht6TMDH5B8FY1wI3uelR1/geo4u3CFJ8g0y1RbQIEBXVWAgPoOgra1vJptyPd4JB64A+l7Me8T0BUCasaphsSOurYSPbcVYPSshLXssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLCEGsx6SMCrKyj5hhK27mLd6eaiWQwKR8LtMtyIYnQ=;
 b=YeLB5pwFDVJeMA4pmaBfkw94nLUrYK4dQXQJaUVCAF2n4Rz2Ecmi94oOj37mC3DTplPWjKuQ7wGzIkA0i0reIfnN52tqe8u+NFntHPYG3F6CTsntr5c6zzpytfunG/AC5HBtpivnc9bnm3fy0sXU6+1NTHuuFuVCE5MhO/etKC8=
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.18; Mon, 13 Apr
 2026 12:59:35 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::30) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 12:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 12:59:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 07:59:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: drop userq fence driver refs out of fence
 process()
Date: Mon, 13 Apr 2026 20:59:18 +0800
Message-ID: <20260413125918.3467129-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b7a486-bb02-43b4-152c-08de995c82ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +wpkDeJPLILCPfhmLm6Uf8dU2RWX8MKfpS3J5cYkxrEnVzV3qzMjPk95+Gd9fkuH77WA/fccmGTYxgE3nHlMBSRaIYJgLl2Z3dbFL4xAl+VkROxnI7WvzI3dtyDGJWbYSJ3DkEB3JUv5TY9S2hHKO4Zk2b9xGD4qiTxB1CagkJZXRhNRai5Nz2nnSrRkNqY3Sy7nPL9G4kXS8o31tO1Hsgh/QP+c8s4eMaNooi7ZDRn/RnSOVFlkBc/04daa+Nc1YI7vy4x7oktLQrSVaxtWWbAusG9g0zoD9KUhcjd4fP1hCx0bFq5DNKfkasXK7Mq7ojymofSM/LnEJhDQrHuTlS5VOqImp/BzWlSOpbtlDk/aVxN9mZ478PZFHs+633UdkbJMiZIdECgWci7kdwffIc7UsN24LJXx1AGMVIbwarzQE9r5Q3mDTb+tXvxOnTEbESv0qc77PEAwofPw3fT2nGqya+xmFckFt4zQUbxbqrWyab2drysDEN8Qet3saspIkjwM+jynlhoksjPO6JIKu4bEUEYrQJYYh33mxoluV2BStGB4biw1veuAfeee2/wPmjyyNVhQI8pXvnm7YSNTetMGMQt76XC+o+n2xcMZ+ElJeAjiwKBliuYxp89JPZ9jmDtXbJ2bG4XRsBwU739GaX8KKlGYqcGiaEdZO2ZQ3OJPT+o3kO5U3o4L0j5LnVvULC0iPnTmrZMsQlClU/GBzbCVfyeAE0Ly0KGA4UyXhqiCJyevYS73i6gJaw68KGhBmjN22/42G5TGydJqxCaK8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gwUv4xKebSOAJPxEKtdF+Q+z2mnDfFRFVQ+kwmBuF4LVNN3Xc/gJiYzsvyZ6LBBjIhwfYUuqx/t27xCpRrknnbZfJO9VXosbZ7/4HWhd69HIMUEIvhuoUGUci4oW/ADctzi1if8VsjZOYLt1I7P4CyDXg0WMs2IrNOEXcFK/p/9Jw60WRiO9muYLO1udD3mI+RhGKYw+z8ffmcZNVl7lw0WdX4lXkv57MjCJttpRXpbIGUef+g0hafbF981upCayh1fULvwhXuBRw68e4cy9Gw27P98GSZxa7PfcFm3scyEXu7mdunSJ1wVvOIAnYl9eSXK4XMJiDDo1VZC+7ocTxSXhEgtdm0At3DMAYXQSO3nllkyVkf8ADZuHY9ESO+7zK2uN4pubqrFcwUhgKfkk/pSIezGfJbt8JENYK7dsTzCy1Gfd4mbvf71m8Ixi4kkX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:59:34.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b7a486-bb02-43b4-152c-08de995c82ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
created, those references are transferred into userq_fence->fence_drv_array
so they can be released when the fence completes.

However, those inherited references are currently only dropped from
amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
such as it is already signaled when created, so we need to explicitly release
those fences in that case.

v2: use a list(list_cut_before) for managing the signal userq driver fences.(Christian)

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 56 ++++++++++++++-----
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3be80a82788a..ce3446a77c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -145,35 +145,56 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
+static void
+amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+{
+	unsigned long i;
+	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	userq_fence->fence_drv_array_count = 0;
+}
+
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
-	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct amdgpu_userq_fence *userq_fence, *tmp, *first_unsignaled = NULL;
 	struct dma_fence *fence;
 	unsigned long flags;
 	u64 rptr;
-	int i;
+	LIST_HEAD(to_be_signaled);
 
 	if (!fence_drv)
 		return;
 
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
+	userq_fence = NULL;
+	fence = NULL;
 
-	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
-		fence = &userq_fence->base;
-
-		if (rptr < fence->seqno)
+	list_for_each_entry(userq_fence, &fence_drv->fences, link) {
+		if (rptr < userq_fence->base.seqno) {
+			first_unsignaled = userq_fence;
 			break;
+		}
+	}
 
-		dma_fence_signal(fence);
-
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	if (first_unsignaled)
+		list_cut_before(&to_be_signaled, &fence_drv->fences,
+				&first_unsignaled->link);
+	else
+		list_splice_init(&fence_drv->fences, &to_be_signaled);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
-		list_del(&userq_fence->link);
+	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
+		fence = &userq_fence->base;
+		list_del_init(&userq_fence->link);
+		dma_fence_signal(fence);
+		/* Drop fence_drv_array outside fence_list_lock
+		 * to avoid the recursion lock.
+		 */
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
 		dma_fence_put(fence);
 	}
-	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
@@ -228,6 +249,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence *fence;
 	unsigned long flags;
+	bool signaled = false;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -275,13 +297,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	/* Check if hardware has already processed the job */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	if (!dma_fence_is_signaled(fence))
+	if (!dma_fence_is_signaled(fence)) {
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
-	else
+	} else {
+		signaled = true;
 		dma_fence_put(fence);
-
+	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
+	if (signaled)
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+
 	*f = fence;
 
 	return 0;
-- 
2.34.1

