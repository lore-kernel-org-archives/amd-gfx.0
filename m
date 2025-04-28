Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD5C3ABA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3B810EA73;
	Mon, 28 Apr 2025 21:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHlIasTs";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D1610EA70
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/c1GY5sAlZ/1zw+KKmmOQBSoPbQk4gSS9itzLg47TuoqUcuzIl3/EOSOAkG21OobUvjAtKPu8Gsi5vXfL8KYMmp6skuoOnN+rIXWelBQO9tu70Qjfb0VhFqkGZqo90XojOFXYUwltbKyPprRlmR1dsBufQG0H5JuGoDSnixXcVXIEYbCiJMjfRhSzB86Bhi9aPzGnllaAsPMuU/NS4rXmjDBxIulHrx0cIrK+76luGTYzed1LAZDCz/XCiN9X1KIe3tY8V9luDcOTq8g1PZnXe7oMMfWbI9koNVXvYAG+VxTyHfjrxA6jKgfJr3Gma0+ulAEAul2rVEmmdrmRIUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fDlPXRx8tLzXEyW0Je7H+U8PQ9N8qugI6gdjB+ucxE=;
 b=lGqS+qgeiHG3+hLyWuOA1osjxNUz5RIxARgvRRKCurRVmPwLORmeswLUHxwbNo1IIKyspjCJWV09BgqphLGpfuFsVyNmFai4nVsWhZOp4fhz3jhdPrB6FsWNtECO6kgQtZnYDGkY8YslCZDgK1w+4GUM97dDg1ku/XAfvQm9E6zTBaMhKbm9mE/odSJMVWHgzXUT085jb9Z77NCwa8Ktg0iD97FSEzbodOU89+dNgHdiLvLi43yUMi0aO0UJ1tTqd7eStyA48u0ZXYdvTn0WSCStsLTJ521Xtaf9HjYJnsaHZ6N03NXIhz6yXpZWBLV4WiFOlKPRpix5E1P151FB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fDlPXRx8tLzXEyW0Je7H+U8PQ9N8qugI6gdjB+ucxE=;
 b=CHlIasTsxV6TvkQ8+KwbgOQWZKbcFgN+qUfV+soToHYQ2ahBL1Y9mlrB2FtByig3O7YRinQr/IZP2ynseMEQ+IrVjOeuYm2DVmTxYeXFRplDbqo0MnElaiKll3okpoep7HFvHpuxT4zhiQvH90RltQBEti2aNI0dM41d5ESiGMA=
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 21:21:13 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::37) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
Date: Mon, 28 Apr 2025 17:20:50 -0400
Message-ID: <20250428212050.1098434-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 54badc18-ffe4-4788-7080-08dd869a9acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?93/Y5L0KO9hiTxH8Y352+MC8MtX26x3vxQzG6tiH28e+XNrXTpKVG03H/ZTc?=
 =?us-ascii?Q?KOm5VMnkBmHuqhuPsi/Oe1o7dWk73R5cRmzJe4Adz0RrQrRMIz6TQ+806QF+?=
 =?us-ascii?Q?ME0UhW8AHrN0HQsJlV4FvwTOU0HW+paK7CHSh49D/i1oXHgjvIkr08fSDxJC?=
 =?us-ascii?Q?AzUqKH5I9wFNj2gVziD0jFBV3X403olrH81tnpciI2OwCBi9CqSuMpRXc+YY?=
 =?us-ascii?Q?7zXYBxhMu4oSjZ5XCnbnMrja9RyN+mojWRKi4NiBNHzUo8nA3s3sI0S+waIE?=
 =?us-ascii?Q?L5rmpCzopFkgiVcxnSdPNq/rdetHY9BvlDAKBVUjS6i3zUdVzMYwD2b7V+Ja?=
 =?us-ascii?Q?8/XPWtbOETkQqbjjSPp2UuVOuFNZwGRxVGMiBYHCwCqp9HD6NFF5EO5FnXr1?=
 =?us-ascii?Q?b9HpNknEWMbM2Q4I8DVIj66hM5gtnxFszOLbs+WCj988LLfNSwMRaThXZHGz?=
 =?us-ascii?Q?5MMyOcr6YgBRih6XjZG8rd8WckgD5ffO6y6H98fqOsJAGiLXCJV/ObFaG4E/?=
 =?us-ascii?Q?LFjq6+pm3KVBpfY3Tt6NHphy0h7Fo3apNFDLUfOehKzM2jPGPYqED1IAgAMZ?=
 =?us-ascii?Q?P9o94b33KvRLS4pRlr7qdKUGkmMxtTIGEQbBsSRGUlKidWvzcO0PkgSCB7r3?=
 =?us-ascii?Q?5uyr2HomheoJ/fDrDYdkBJiw7ZwgQa1i6XmAIOcWSOW/NmTnKyl+TU00gzmP?=
 =?us-ascii?Q?NG3NOx0Dr0bdJWjXgH41dwzha+0XEEo9Y2HWulS/UHZFRroP9JjVFtx/U0Xh?=
 =?us-ascii?Q?CLgSXIpGmQOGVPR8IQJkhqUfN1slvOlrZr/LO8GW1r+KZHGbCbpvxVE99fye?=
 =?us-ascii?Q?CMVs7S3fObj/puKRaAyXR+pUJke8XEt7KnYxtdnHstYnn3qhdXiq5H+pzkqc?=
 =?us-ascii?Q?pb92+SZ4TSDxm0tonumzRuQ2yMnp9Cew5FPqmOC6Nzah6W+BTseOHijM9Ax5?=
 =?us-ascii?Q?Tb9WIPHuWTR3rMccAXB1J2IIVm83VSUWnF0n1/+fDC9SUK1z9aqNomQSAcMQ?=
 =?us-ascii?Q?89fTQU5hpn0x79KTRNk1I+zyHnDtDWOgao6QgUMDrJuwecIYKX1/dQj9Oe1T?=
 =?us-ascii?Q?3GKMDLjuG/DJ0kS4Gh/ErztX0u2chH9833NLrZ1IoHQSMW0Wzds9Lpq+nkSd?=
 =?us-ascii?Q?hHu1Y6ythlPP3p9LMd1R0HNG9oWRD+6EXsK2sWXf/zblPmOYi3eF3hnlO8q+?=
 =?us-ascii?Q?Vgcl43sF4wL8IuzO4FzeeC5mKXUM3BMmHEjQQQwoAjIsmEMNEY2LaMTzKCkw?=
 =?us-ascii?Q?tq3WOn9QpuTarXf6Ax3b6X0hQcgUashkdWvKTaVjKjDE13z8+IIF58zZmR6q?=
 =?us-ascii?Q?vFjc109je638UE7f/g296PYQ/GErs3A7xDuZMNgP/+Y4o9fYP5qKtmp9uc6x?=
 =?us-ascii?Q?nHuNZQPc038QANB8+mktkb8FdZa+s6LVgV7LBWMffBORZ4NekTA2ULZH9bID?=
 =?us-ascii?Q?ykw5HQwJrq0qku0mh9aD8ADU3eIo8a9uwqxAXKzRgY1UIiHSAkuVDC/OEWt4?=
 =?us-ascii?Q?ByAnxWOzw/WTbfncS0UYxIAC7PVDxOAbz3Gs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:13.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54badc18-ffe4-4788-7080-08dd869a9acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
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

Gangs are sets of userqs that schedule together.  You
specify the primary and secondary queues and the scheduler
will make sure they always run at the same time.

v2: handle setting up the gang again after unmaps

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 95 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 +
 2 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e56fae10400db..e42b8cd78884c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -92,19 +92,39 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	bool gpu_reset = false;
 	int r = 0;
 
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
+
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
+			if (gpu_reset)
+				goto reset;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
 	}
+	if (secondary_queue) {
+		if (secondary_queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+			r = userq_funcs->unmap(uq_mgr, secondary_queue);
+			if (r) {
+				secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+				gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, secondary_queue);
+				if (gpu_reset)
+					goto reset;
+			} else {
+				secondary_queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			}
+		}
+	}
 
+reset:
 	if (gpu_reset)
 		amdgpu_userq_gpu_reset(adev);
 
@@ -118,19 +138,40 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	bool gpu_reset = false;
 	int r = 0;
 
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
+
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
+			if (gpu_reset)
+				goto reset;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+	if (secondary_queue) {
+		if (secondary_queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+			r = userq_funcs->map(uq_mgr, secondary_queue);
+			if (r) {
+				secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+				gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, secondary_queue);
+				if (gpu_reset)
+					goto reset;
+			} else {
+				secondary_queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			}
+		}
+		r = userq_funcs->set_gang(uq_mgr, queue, secondary_queue);
+	}
 
+reset:
 	if (gpu_reset)
 		amdgpu_userq_gpu_reset(adev);
 
@@ -561,6 +602,53 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return 0;
 }
 
+static int
+amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int primary_queue_id = args->in_cg.primary_queue_id;
+	int secondary_queue_id = args->in_cg.secondary_queue_id;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	primary_queue = amdgpu_userq_find(uq_mgr, primary_queue_id);
+	if (!primary_queue) {
+		dev_err(adev->dev, "Invalid gang primary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((primary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_COMPUTE)) {
+		dev_err(adev->dev, "Invalid gang primary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	secondary_queue = amdgpu_userq_find(uq_mgr, secondary_queue_id);
+	if (!secondary_queue) {
+		dev_err(adev->dev, "Invalid gang secondary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((secondary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_COMPUTE)) {
+		dev_err(adev->dev, "Invalid gang secondary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	primary_queue->gang_primary = true;
+	primary_queue->gang_secondary = secondary_queue;
+	userq_funcs = adev->userq_funcs[primary_queue->queue_type];
+	r = userq_funcs->set_gang(uq_mgr, primary_queue, secondary_queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -611,6 +699,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			DRM_ERROR("Failed to query usermode queue status\n");
 		break;
+	case AMDGPU_USERQ_OP_CREATE_GANG:
+		if (args->in_cg.pad)
+			return -EINVAL;
+		r = amdgpu_userq_create_gang(filp, args);
+		if (r)
+			DRM_ERROR("Failed to create usermode queue gang\n");
+		break;
 	default:
 		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ca11f7748d031..40510b4d824b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	uint64_t		generation;
+	bool			gang_primary;
+	struct amdgpu_usermode_queue *gang_secondary;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

