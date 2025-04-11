Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A250FC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E73010EBCC;
	Fri, 11 Apr 2025 14:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGUH2mIr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A56610EBCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD3LQqIbGejh1Wb7OwKJafS6QfL+dRAWXy022eHxg0pZz8nylzf30I5cTqlYmVkyUFSLAwnQHAVxt34HMRU6JuD6V6m0t98FikKbreRtTF0RVZEnuDHVGturbm1XrJlkkZvSGFmRecghuyp8L6yJK5t8MebNv6jzpQbqNw2kF8tgcwTPewuX9meDcwqYKXC5bKJKnkJ4fG2D/7Wl5DkxEbZU4u1BDm/RzxcKgomojCXlfNy6W4l1j7EXwmE/GcRjBi7SVAigUiGRA4c5kzNt1Y3t8IVjlfeLoPgYOxFgAW1BmnZ3GMjI/AY93YdXdlxGWs5TvPKJQ6d3vSzOwxJD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG0+Lhc+99QYZFI+cbwF5lbwzNMuo8gIB7ql2D211K4=;
 b=qoTzqXRZm1LiwatHeaLwVIkIuE+fH0lNPBgkpyYB1dktVl699EfIe4rLPJqepdAbvb4QOcWhzC7B3zqEtDGT0pF6pKm8Zle+Z06/G+D9BOr+4ZdmE5GLaANb6rQBA8qKDwHB+gKmoNlDF6KdStWtDbCMHC4XQFJfILhn2cIUOgSRtE1bKvEyz1WmVpIe5MNGWi0PruK7krST4AdwoabtbA9WspnZMRT/UZC6Mj1C32aScqNp/sme2DYdENtsV7f4MNiWH44SaJ8iUYE5zIuFkRkSwLqQWVZtNrh62o++tn8yZMYenARXcNKsS06+yY8IvMIwa3hYg20BtcymcW6vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG0+Lhc+99QYZFI+cbwF5lbwzNMuo8gIB7ql2D211K4=;
 b=nGUH2mIrkvAkm2SkiglBwGDVBjJ8TV5LeEFeq4daMsy3ysYBDKKEUdLaFfisITUf1YADYc4Quo+ujQajC7nU87YIHoym1mdqz+TSF/arWutQvSD+FgeZf6hv0DhIw1RgDrK7zCNClxjvGZYdw494kkv5j5cbx7ouECGqlH6hyL4=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Fri, 11 Apr
 2025 14:12:43 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::10) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/userq: move some code around
Date: Fri, 11 Apr 2025 10:12:22 -0400
Message-ID: <20250411141228.2722962-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fa34de-dfd4-4822-abff-08dd7902ecd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3caZGCZJVAOoPFnQeNhmG8g0kvvq4nHMMA8w05SY0nAkSxaei7qVB4OpOqJk?=
 =?us-ascii?Q?oROTQPoTQSSz9xpnC9z/nGWV0dYJFLcNqyxWtwCay+D0EGT5dByeeDNy/l2M?=
 =?us-ascii?Q?JxpPn+EefHFQFGaNekwlcWW0EdargvaNklHR+V5GRAtyODdpV6ppMbQOSALI?=
 =?us-ascii?Q?cGTEywmwhUN7CqfBm7PzMg/CtbpAx9WNkJi+d4+HCSXCANmg6AMsw0bQD90G?=
 =?us-ascii?Q?7sTTgSoiBZsqBBFijTSsEA2yzNNMbvb6rqCH1jR5rrxJuzdtNqcJaa2IYEYz?=
 =?us-ascii?Q?LUBh3j9XESvOLe8RRMejY4C32Kt94xjizjV+JoOMdD71/8sQgFmA5oUYTJyo?=
 =?us-ascii?Q?J4IQCFkk3vnXxEJjsgBViibu38Jsq+gh+uFRtEhB8DcP07ePdFzQ+7Rrq1j/?=
 =?us-ascii?Q?cweHIga3z47myjUZkdrzTQfAzFEbUrRxaugBiedIbNeJ92quhybtoZ3ZUfsv?=
 =?us-ascii?Q?CHb9L3emr5jAeHS+b2vVEy1UOofg42uBcrNc8k0e0xlWH2MNSNZsIQblZUXR?=
 =?us-ascii?Q?cNIaQ2E1q4oqmplDHkmWREcQGp5MFFz25NQLzo/yJhSRDOoC41k2G0WLLNrI?=
 =?us-ascii?Q?veqlwE+1BBbRwHJA94KpZ2EYnF8uMDL9lbdXmZQtAK5t/pBSe4vlwbohyQ/I?=
 =?us-ascii?Q?Ht/jE8jOXl3o+K62PyUFQEhHhoaUE/GACuC5fExTnw03ZJ2F9HnjQ996dHM6?=
 =?us-ascii?Q?DSzdMLSTY9752anN/C5wqqKcnFCQUCjaBo3rimjKWBi2Q4XeF8454s6thc+l?=
 =?us-ascii?Q?0MryL+U5cHOQgsrDG0qifEWEActVIMpx2L375hIILi7FW09dG6v8/CYZH2ey?=
 =?us-ascii?Q?XTJYahvyHHEBm83rHX+km2nVtdegOFKoirawM7cO9L01VorT9dNycfT9o8B0?=
 =?us-ascii?Q?8fSQvw4HSYN1cOqCHYZTQ+NYDguTtAWS8EN4ftU4K411HltkZo1LtVRY1mpx?=
 =?us-ascii?Q?K3DrlkrQQn13J2buibnvwrgaNQkvbMgej3qXcBYyWJMHV8lDOgRLzdt6jKm8?=
 =?us-ascii?Q?pOlVofnFSLfv6xEBVK75GWKqsSDRrLs4APJ2xdCQUcrjQC2/CbJEu4wywlx3?=
 =?us-ascii?Q?J9JBAMv4ctzcZfuz3JZgNNevBI/f3/dvLOf+57kkZeAR5tQNpvtRjaOS5fcv?=
 =?us-ascii?Q?NLDqTXrYpxpO3lvX5nm9tCxy4Gw4ATVzjGnUoCwd9jT2/vO8yvfMO2982qnL?=
 =?us-ascii?Q?5mkERKqZZ+QVR3Y9vCJgJrjJ8wdVJFWNguqI2eQCAnUK2SrbU07pwx/1gt+V?=
 =?us-ascii?Q?F5moxU1kMlC5M6o4zMrZSlP8vtKn5bs6R47Tgtt/A61FNBxms6Qw5cHBxSnU?=
 =?us-ascii?Q?RP2fgt/TDrOIEuysTxac6Zqvfe6/IM3aauRFIvbjLEoxxL0QaasapNSi4+GV?=
 =?us-ascii?Q?K+VYY46ckkPlR2SRv1lUKBA8zN8xDbTJ1fVZSot7Dy4jM9QTgpHQEUld/8cq?=
 =?us-ascii?Q?mXrf8V2PvM/0yaHgkBkMsIDE3kw9/aSRPLd7hRcqQN8MKbPx3wQQwjZn3Ifv?=
 =?us-ascii?Q?qfEhqbivG80qwbA+qhhX79/zLD14o/bzisrr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:42.6290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fa34de-dfd4-4822-abff-08dd7902ecd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

Move some userq fence handling code into amdgpu_userq_fence.c.
This matches the other code in that file.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 26 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 -------------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972a..ee73d7846c2ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -120,6 +120,32 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	return r;
 }
 
+static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long index;
+
+	if (xa_empty(xa))
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, fence_drv) {
+		__xa_erase(xa, index);
+		amdgpu_userq_fence_driver_put(fence_drv);
+	}
+
+	xa_unlock(xa);
+}
+
+void
+amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
+{
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
+	xa_destroy(&userq->fence_drv_xa);
+	/* Drop the fence_drv reference held by user queue */
+	amdgpu_userq_fence_driver_put(userq->fence_drv);
+}
+
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f0a91cc028808..7bbae238cca0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -66,6 +66,7 @@ void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index c3873041ec942..79f4df4255c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -28,32 +28,6 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
-static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
-{
-	struct amdgpu_userq_fence_driver *fence_drv;
-	unsigned long index;
-
-	if (xa_empty(xa))
-		return;
-
-	xa_lock(xa);
-	xa_for_each(xa, index, fence_drv) {
-		__xa_erase(xa, index);
-		amdgpu_userq_fence_driver_put(fence_drv);
-	}
-
-	xa_unlock(xa);
-}
-
-static void
-amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
-{
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
-	xa_destroy(&userq->fence_drv_xa);
-	/* Drop the fence_drv reference held by user queue */
-	amdgpu_userq_fence_driver_put(userq->fence_drv);
-}
-
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
-- 
2.49.0

