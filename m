Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A8CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A3110EA0F;
	Wed, 30 Sep 2026 08:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rz+qrCJC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7460910EA0F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWQmoDT+QU4zh9D6SlDv5MGTwRrvq0qix9z0m8osYb3FZpWMszUJFA99Dj35dmcsfHs/LVVWjbpSnbAD+l7DzYW2tDnAFj0A/dRns2GTCZBg5oOl1MeWcWTwqFPg8O8yolj5Z7L0sapPWm8qZ7rdYu2balbSBFD6bCFz9m7q7Qi9cPa8AA7bJgLRrLlv27225QorcQE0gdDcUtRQ0PxMtHr6H0AdY8Pzms6xzP9VCpsmjaCxob2lCkWTakZABliuSh/mLezoLkuctqMNFcydffGaPY5eioxUrmxYzu/IhWfR57pdc5/HUze1Dl2Tgmr9yMyHYmqQsKqZX2zn7nnTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E77hGbfy9xOtEUeW0mDo9P8GENn9XzYA70u6YFExNOs=;
 b=yftHLLBqBd3uFGiSiXgHAH6vsdg+HT9GMChoEa8V6zKbZvnGyM+ibG8SL5ajpYGj1+9uhLOuqitZxvo2QSxT52VtYoLbYt6ByGqgabm9HnvKw3IbpXRjX2wR/zQZOhDKXUQJcDr5dgJnX7M5DO9wvDOQSd/zYphS9REtyQl8knqw+QvLaJ26yOWmY38kDEUzZzdJOcD+2dbmNT+7R8Q29tWCpsrUSMrIFJbMJ9Q3ENKNntOz1xDNtI6kvlZrVdbU+G735jkDc5tKxdKxDb9Unn9/s62fSLcZZ0ZQS3D2p8FbiTG7BL4WmO3wGxmneew2IN6BKlJQ6r1/gYBRxfBQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E77hGbfy9xOtEUeW0mDo9P8GENn9XzYA70u6YFExNOs=;
 b=Rz+qrCJCtBBvUUE5xPGhNfv7d+1ILhK2Xh3aneG+BaYW3HpJr4xTXcyi27rypppSQP87KB620wrv5trxP3/UQC12DUq9TNAiMT1v313taBnE40wODLu1AzdR4YAUmKjeqljWXycWoB/J4KyqgiH3hDq/zN3tgkYk4zO5EUWtsuw=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 08:31:55 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::4c) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 08:31:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 08:31:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 03:31:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/userq: don't publish the queue before create
 is done with it
Date: Wed, 30 Sep 2026 16:30:43 +0800
Message-ID: <20260930083148.151311-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e4e308-9050-4ad8-f145-08df1ecd48be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wlehZWAI/x0s9pzpbEiHDOIpNqi4PlGzBwa6zJh3UXOF+FdMSwiWidvJhrPDQxYPntWOn4XSnmKiC/GfTD6WGk84+mg0HGu4EUbmt9OsI7k4eUh5WsryysA4A/52wT1oD3oAx3MjOBa9+l47qFWNBgGYQXBga0RgGiD9+tnIm35jw6Kps66Umpj96TqT5U7/Cg/QIVKfgTG2j1YAUu78fPv0sLwsUn7qS9xvBn063YZnYkvGAsGJ5lE2tycFJDFPf4+NjkR0lRT1T0FCvDJngzJa9nCMCJAjCiK9oe/FA/1ixzyhv8KkW5NFNBEha4spdDNUr+kHOLErzLxRs7kW/PJBDI1y28Pv2sQphqujfeVpgLkquOi453jDHkk3s1AFFrqmrWwy9LfFNSe/tztjZRkpaKAsUIz22RtuP/F0wc2jlEEOhMXUsTfw9gc/xJmkBsFXPPv4w4zKzqYGvlHyDXlOIEgmeVByFfwITAj0w6ZPpbnYpM0Yl1CFu04Pih4rqvvWYKCVzTSE2tx+79wPRzHt3CJMtb/fT9Ve0XstYm11ju5UtgixVp4ashmakKab7Uhv9Ayh60D4TKzuFK7aH3UwswhL9IVLwzzEwNQSTnQyCAET1AS8gjcYB7Lx3PvflqxvC2Il7B0n49grkz04aF0Fkalw191DwE6FEq5MUWJ/P+6GkxtnqDc8ScQh9h5LTRWJEX8vRGqojehoNiC8Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sYKWQo+7ZLkRBDKMslsWjDpGnhr80pI877g90Sy7c1TqO5GHpXrUuLI9mHbvtXe8yyYMHCBN4dKLF1uJVpsunygYhE1aat/f81LVntvdt4Hg4dY+2lFeNruG/Z6e4VtqdQRMnJz1/Ze2EGnNY/o0uLltdCz3Vxh5Qp5rOfFHmbGPD8aK5VV1Qi321He2ECQHkTz1Cr6Kh9BryFQYLsLPmAJV716l6kmDkO1gkGJwTt5y8eQ8bnoV45mlsKFov34Vf90oAkSig74S2GVgS90BenR22ssET5EdyoKQNy/Z/JO8Ha3WK4q+INquejmfcEpUL+6GVvkHOhmmlFY1WjoT2oX2TsnL3BOO1p+ZUb1kqjNi4QYsw7LB/s5Vjqoj9Yjcq+qv1uyjWDqLbij9Gwe1FNyyiL5B7XdN4gCIQXB4Po/Vxr6bnfoqqz7aSKiwD4DH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:31:54.7113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e4e308-9050-4ad8-f145-08df1ecd48be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
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

amdgpu_userq_create() inserts the queue into userq_xa and then sets up
its debugfs entry without holding a reference. A concurrent
AMDGPU_USERQ_OP_FREE on the (easily guessed) queue ID can free the queue
in that window, so create writes to freed memory and leaves a queue_N
debugfs directory whose mqd_info points to the freed queue:

  debugfs: 'queue_1' already exists in 'client-137'

Only reserve the ID in xa_alloc() and store the queue once create is
done with it. Don't let FREE release a reserved ID.

Fixes: 28cacaace5cd ("drm/amdgpu/userq: defer queue publication until create completes")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 63875761dfac..89e03d3a930c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -775,7 +775,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
+	/*
+	 * Only reserve the ID here. Once the queue is visible in userq_xa,
+	 * a concurrent AMDGPU_USERQ_OP_FREE can drop the last reference, so
+	 * publish it only after we are done with it.
+	 */
+	r = xa_alloc(&uq_mgr->userq_xa, &qid, NULL,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
 		     GFP_KERNEL);
 	if (r) {
@@ -790,6 +795,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
 	trace_amdgpu_userq_create_end(queue, 0);
+	/* Storing to a reserved entry doesn't allocate memory and can't fail */
+	xa_store(&uq_mgr->userq_xa, qid, queue, GFP_KERNEL);
 	args->out.queue_id = qid;
 	return 0;
 
@@ -924,7 +931,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	case AMDGPU_USERQ_OP_FREE: {
 		xa_lock(&fpriv->userq_mgr.userq_xa);
-		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
+		/* Don't release an ID reserved by an in-flight CREATE */
+		queue = xa_load(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
+		if (queue)
+			__xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
 		if (!queue)
 			return -ENOENT;
-- 
2.50.1

