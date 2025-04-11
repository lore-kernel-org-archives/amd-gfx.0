Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7E7C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C688C10EC5C;
	Fri, 11 Apr 2025 18:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y8DOjNYy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2B810EC5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZRcYxlCSJ1kG71ntEMu9BlhB0bBa26V2fxY8lr+XFNM/Oa0BloMHk1UCPpsBOyLN2RRLwAQemaTMlCnKL6TqF1M1K1cnTfC2IwWR44rZsJ6guokV7cz7wlNh82oaNoss9rwgOjiIUdBmBFHFjMIna0AzOndGi3izB/BsQgIwvR+xLTdpbkcaWLwJINF5HiPJOwI0/ZbwJmNBuTaQJ/K/BcAkFlM7qai8TD/UgoUu/Lq29YvykabB4uW+7iBFYPt5ndds+8Kfn1VZ0FPRTRoLpEa1CVNr6a9hOYWMZyzmHJ8sw9UPhbb+9e+P1oz0VCr4ufBs4GPoknnKaWQlyfm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG0+Lhc+99QYZFI+cbwF5lbwzNMuo8gIB7ql2D211K4=;
 b=XapFqT2p4cJr8AiBQKfiE0Y2bGakytuVddEP2lj3ZEHFnFikcOSuBr7zH/l9amo4MhV9/l3jKUu+3q4viWZE9O9nGQ7wgMIHT5sjYL/OyZ+CFkizaQ7KMKYZO57y/TuM1Ts8TOR5mXslJbluBiGgWoc9u2ju0gJwp0XpKVEikC4CUfxigUiCdOuoGJvNhY3xFbXUekGPwiQXXNEiMti877hYR7xwgLGGo+/tQ2DooPHiMn6AmK3++D1ckMVP2eabgMkYOij64ZLdv7r1cFNIOFOTBOtal8KsRw1zqfmCMCZVu6yeNG+yySNVW16xBBgd4kzBB5gF9UqjTkoTqQRpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG0+Lhc+99QYZFI+cbwF5lbwzNMuo8gIB7ql2D211K4=;
 b=Y8DOjNYy2Fc9BtnD+Y6H/IDDbg6hUX7FuvlWMDzxowuDKPP+hDntBHnSHKn1+RoiEwziVUc14sno2eruQ5yt4WIQppGcypU1IbCmZE/Jg1E6LFWrO5cKKVVdisdZaS5zlsmi9HAWnlGNuFFxa9JbLEsxpWfg1PQfG4KFCJ3YwyM=
Received: from BL1PR13CA0299.namprd13.prod.outlook.com (2603:10b6:208:2bc::34)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:48:39 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::75) by BL1PR13CA0299.outlook.office365.com
 (2603:10b6:208:2bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 18:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 03/10] drm/amdgpu/userq: move some code around
Date: Fri, 11 Apr 2025 14:48:18 -0400
Message-ID: <20250411184825.2890189-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 16250828-746d-4378-4385-08dd79297965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T8Gd6UGtEolFF4FzIfx+oEg77WzlojQwYIeBlb+UyyexP2vVBJ+B49RnmiXq?=
 =?us-ascii?Q?E3CYvK1vzEEfa6iUoVtkg5fEPaOy7MfCDE4R12yGYDd3bCHimJl7QXMgCwa6?=
 =?us-ascii?Q?DhqKRB7rnjGrhpInZOD79bRHo2W8RryovECc0ZzWnWy0SsdJhnfCd3KIh+XZ?=
 =?us-ascii?Q?J+vjlLbbGWwS2Jo7XUpaTkGdiQulxrNszQsabezj4qRUkd4WQ4e3UbQ/jthv?=
 =?us-ascii?Q?lD6X6giM8Ak76Szxs/eOgaelWkLn2gj/gQFZPAyMkTLESMbgbV4Der7GUSkn?=
 =?us-ascii?Q?Lo6Rc1NbEspJJoUHbLI+uUmw8JbbThAoljbywobKapna6zM3l27RiwKHonQs?=
 =?us-ascii?Q?xCyL+9Je8m1XnftSlrPioZD5ianBzi7P8n5XjFOj0IQ+tcK15Tj5JUAxj8ZW?=
 =?us-ascii?Q?vBRrPrhCTGz3tePC2rE0HMs/6/61YmMzJ66aMuc54cYUWU4Z3IWutdvl/g2F?=
 =?us-ascii?Q?F0RF/zIkJmxWmiWZxXLzIF4pO3/3k7Ls62+LxfrKpPWLKKkv40dO/4U5AVkI?=
 =?us-ascii?Q?sOzvwoxFM7Kl3guTM9xhUNhZbgETnsVisp6AGyeDorq+YNIHPjdVeMJY5hvA?=
 =?us-ascii?Q?lVGmtrS9d83OsxhW9kqkayO/X0OcYe2k4GZqoPuXZY4k2gI9bRJp6geOh+Is?=
 =?us-ascii?Q?aLsfPzO7OJbFiKM16CWDbs4GIYjE1n8wrDb9srU2fO+feP/ibJjj0JQHbqj5?=
 =?us-ascii?Q?rpUMHsuqgXc+M/ZsRwM7gEoAN3+OjuQvmtTdaZRCsWCyl2egLK1cDGERHaiP?=
 =?us-ascii?Q?QqPo/J1RraVI74HngL+X7XbH0o3nn0b4Np1ExXCOQVmsrnSK9uqVqVQCk7zL?=
 =?us-ascii?Q?MDhRExUgrOxD0zQhfwst0pA73UJPvdTpGU8QiwKfFXfUH0vHBk7DmAk2jDWH?=
 =?us-ascii?Q?BENkJeRNeo1yComhAGRY7iFXjj2sr6883MZ1j0NT43X3th7wZVHx1yhCvaQo?=
 =?us-ascii?Q?XxhVbgo9RCOcY8qJwCmYOCd2yisENmo1kzs6PU/SmQ9VHbZ/xF+d+sjdO7Y7?=
 =?us-ascii?Q?7C/+IDrUmvHAA8x6fl3U3GiBm06yqj6xtny3QXWGl0NJF8IHXvMtxgvQkFls?=
 =?us-ascii?Q?/dBO2bxbXmS9cWa2wJfLEqzT1sz7IhdynrSWFxbTFAdZMxmmdhNdkGzAX5rV?=
 =?us-ascii?Q?2cDI/pgBQ+J0EM9I7+SBfNOykWQLXt2+FBq1sQMhE6vZu6lk2MrExSSMoYsX?=
 =?us-ascii?Q?VtXAGujUX+qT62A+l0KYNOSD6PPCpIM0fCPOrrdCadDlHq3+FC/HaAXZftvd?=
 =?us-ascii?Q?nXjHhgn1otG1Z/fyvjaCiXbaWJOvBBGRe6T2kDNvinzbHgqYkLnx6YIuH61E?=
 =?us-ascii?Q?PTo7SRahKglzAOiGOEEm/7LiOIXz7vEdaLjKgdvwHQXY9LexJdbGAE0EuQcn?=
 =?us-ascii?Q?R+PSAEB0kac7wfeEjIGTya3kzpdxrrKkUFzodM8nTnT4nhgI/QkxCQ67Rwt8?=
 =?us-ascii?Q?n2FkfddZNlJh8BUTc14EhUu/DSv2qejGi/FEfneObo3oguygkWpNiZCovQVq?=
 =?us-ascii?Q?mUPHz8Jkf9wcuCKFOIfZ/F8Q8Y7DLtD9YbVj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:39.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16250828-746d-4378-4385-08dd79297965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

