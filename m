Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CCEECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D091A10E688;
	Mon,  9 Sep 2024 20:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gz5uuOZE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5D010E685
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa8umIbT2On8FlCzF9wEcflsPDGXxooBJU1qdccQK9AsiD9Df4g249wzQyoKbzfpyq+AQbUbNYAV/SKbma7+zkFjIqIy5VmKpzkG8XX6Yau9Gz/5JRJTHEyqBf/QQyWngO0p+xrMtInDsL5vaYDK43/ryKvoOFFEu7WSPVBddFaASe2LrylZP4TqA+oxLMu+LzFxIOQ5CtxkoH0VVyyf3+KAySnmz4fEuzQkytLLy0vcFkjRNzRPyApOI8I0XpSp6P5vw+uXYwesPoe4DKvKF/pcWRTWrRRYM7Lgap40Fmrb033AN6DcrSHr/ENZv/eflvxs3YsDXwaes7CZuW69vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Bru7XPp98rXbZ4ICqXhfneQQTjdJEukpM8zltRYY0=;
 b=mIQt5vMw54YGGQxJXLxa0R27CDlgYb7C3qUOscVFTQq98RQAc8UfgGWvKD1icVbyh/7hG7NYoAV+9BLVvHG/eEkklZfFoHNBddAlGRKv16bAjp2woEp1VOgI5DBVhx5luur6xdZWEmtJPVwfsScMsNT5QvKXwaFtEAECNnDV2571ytNRi0sjLb9IUBdEIK35YzXQnOjJLYc0UHvh1FgDFDNpXLglHII75+ebVfAIY/VAiOAGo7T20Y5A8D0EVp4RfjMt7riUHqlmyK8z7HwUL4LiDlaTFZoQU/JHqBVXVcJfEQyAeWH2crcqnPBXE6bPU5jz3Kx/vfLHCo4ew5K6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Bru7XPp98rXbZ4ICqXhfneQQTjdJEukpM8zltRYY0=;
 b=Gz5uuOZE/ONrMlKk1Z+Opgg1VpbMSc7FSjnfzZEREj7ubu1qgJt4XTtBKE5NRj4CA9meCN26XXNUm4ZonP+0etnYqMWhXADT7GF7z3fuSgrRr6sNMBJhoKmhmVIfb3tYDgOBxDIPuItDP2blEtGjC89uKvKvnbUds2jBYlEK0eY=
Received: from PH7P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::15)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 9 Sep
 2024 20:07:14 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::2c) by PH7P223CA0030.outlook.office365.com
 (2603:10b6:510:338::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:07 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 "Bas Nieuwenhuizen" <bas@basnieuwenhuizen.nl>
Subject: [PATCH v11 10/28] drm/amdgpu: cleanup leftover queues
Date: Mon, 9 Sep 2024 22:06:01 +0200
Message-ID: <20240909200614.481-11-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 286607d1-4c45-4f16-7e83-08dcd10aff12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uUxvV/nYUNc7eBAibRCObY9A8mCCJzTYKlDn76Vpi3Zrq7YtadStXU8MfWmM?=
 =?us-ascii?Q?K61ydz/8eAa3z4/7gpOiySejTbLae+xjP+xtez8FVbogbxwdxujF8bTk+HqG?=
 =?us-ascii?Q?y4DyxjwOFLa6GHkCAJEBieBuFYywp4kBv2xtBi1NYd/dWIB5q2In/sljGFAB?=
 =?us-ascii?Q?NT07ZOITH2OYc3D1r/zv7pI5lJT3Cp6tQPQI8Zw8IaH2fGxYQvJZnjp6qEOl?=
 =?us-ascii?Q?gueXmdqFvYubY7oIe7c46pTW6IN6/Kq5QyVG0FE7V5X7i2t5esgDuTPKC/Lh?=
 =?us-ascii?Q?GCfSSn1lbi72ySBs3ws+A2ISnpOhG3PJpZ7nD2SqSLEsiM/uFmawcXpGszf0?=
 =?us-ascii?Q?lvGMOaVi91hgOK3op/UdpiVf9bDUrBXb+b8MmXgAlvJOORT2iP+0ViSevw9p?=
 =?us-ascii?Q?i7MXYoSGrDFbwEblQIp24wMyqnGOOICMfthcRur5XtFPWE9gmtGVN5FyR4IJ?=
 =?us-ascii?Q?D3BjG2jSh8YanHclVrilHNe114B+jp/MnAfcjMqgja+U5xHAXmsU8KDxKPyO?=
 =?us-ascii?Q?efIT1TPTXv4PCmNryBJvDHKe3Ez3bNIhjt5g1G542g9ffUDXErzK4RKjU5hc?=
 =?us-ascii?Q?wwVJV2rpk/QjQtXYYrxTja5WoCoqcrMDbPuF9ool4DMQBoeOgarExlQfSpj6?=
 =?us-ascii?Q?OrHidKL5XO1zYFwe4V7PmdZecsMz5Xw5g7LpMhgA24TozJMgyRMQlU4oOHaw?=
 =?us-ascii?Q?Kr9gXzWD9w894n2JqR/X8DiQXiRoMboHr166zOU3yBfgcjQmQEEnWOLD8kDK?=
 =?us-ascii?Q?yKfyjrl6ar40Ix0ngc624EqJbHLywm1qmw2d9l7q/0n5EsP+hmChTxxRWHhW?=
 =?us-ascii?Q?pU2YFIrD6d6x/Mmced6+QMEXGV6AvTfskOPaMN++8gjyLeHS6JBx+rKcCj9u?=
 =?us-ascii?Q?sxC8F/xETOmYRZzFCkA7NwXa+xhnNJ+LT4IS7Iu5u5u8keJKxf18byq8wbSR?=
 =?us-ascii?Q?owllKlkdvMXPgY08Q+sMK1Lt/eWGqvy3WonGIPWp0q0P40+K+tG/NisFrAj1?=
 =?us-ascii?Q?bkFmAADVseiMZfhQW2JpFadaOdWT+nxxCw8Fzq0Xb8l37M1uPcUK0xJIB2yE?=
 =?us-ascii?Q?StXFFn2cAshEaBZj5xS2D+hshnepFXOVlaJki5pjcvOk3MpjGT0TbTKcSb7X?=
 =?us-ascii?Q?Fp64m/1AnrXnrYDk+klgDhZ3BSptra8VPxPuF/VFxbNT5no2E4vvyIbR8cZ/?=
 =?us-ascii?Q?4+yGqX3/e8+GJ29QGCgu6c/s5Z5XFtAXDEWVhXQyA6RHp2n00ec33jkPT7HA?=
 =?us-ascii?Q?wso5R3Z1VisFwYZ3yYhfI/VTHUiXCS4shIZqRBA5yOgaKLC60V2moBLkCu3u?=
 =?us-ascii?Q?V4hYxfg9RTJZCk62g7R7nypevR9PQK5ezMGHQurq0LxaVUy0E9/V9dYU1Zqn?=
 =?us-ascii?Q?26ycocKP3IJb33Qa4ln9fsHduKju2Inobjg9hrR0giSBaLh49KDhkfMtMqK9?=
 =?us-ascii?Q?4VJrLX1SXwuGOrypvCsGsBU4ft1bPUl0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:13.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286607d1-4c45-4f16-7e83-08dcd10aff12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

V7:  Added Alex's R-B
V8:  Rebase
V9:  Rebase
V10: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 3c9f804478d5..64a063ec3b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,19 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+}
+
 static struct amdgpu_usermode_queue *
 amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -146,8 +159,6 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -159,13 +170,9 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 
-	uq_funcs = adev->userq_funcs[queue->queue_type];
-	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
-	kfree(queue);
-
+	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 }
@@ -276,6 +283,12 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	uint32_t queue_id;
+	struct amdgpu_usermode_queue *queue;
+
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.45.1

