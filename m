Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D260EC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626E510E3B9;
	Fri,  1 Aug 2025 06:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dO8S7sbM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E9210E3B8
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMUY8RpIXWoVrsQzpxgHrddmFulkCoZkn9dn0fd4v/mia0wUYSOAk2VuADqMrXMxHlGKfHWUGW3EfaMi6ZWfpgAAcf964ju3T957OoMyMVkKPySaJ1yvuQ6qoxqPzvZiE7/gIP6aunFDY3SLwrA7gNUMcRH/tSj3My90/DU2gYCdbcX4mI/ukSsxHYuVaAToukcnIfa5Zo82E4PZpPzTkFfVAeuNT7dhR3RekXYs8EyjvwBHHH8AJgC0yeKE+CGUO8pJHPj5jVF5UyDULCjtGPOtE1pEc3j6QsY1S14q5vJ3fKwUJXpg5YWA7lMoKKDvIcqkkJr0KrMS/ocDtPiLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=kgI4Thiiq0tEiXnJNJVCJe6IYRbRQlop397r8/KCeK9Tsvr4riMSxnJQggv//RnEx2kIqTvj8qRy594rKJicGR9Lk3iDurc2NrXeOXFXuBab3XIEN9yJfvBmgoikbHEKzDOD0Yg1zD/JHBXORF8DJKsnJ5KRYRn4DPJfhk+sWFmNpc3d8m/Flc5DHWxqt5YV3K0xZSXga29HVfYCa120y9QGGflPCDmctFmkF6U9XgMx0/AXvC1bvw5KH4Jp8X1V/HNMNgNJXH111t8I+edbi+5xYkPKCmAvRRWQsR0vlHSEophuRczktPBgTr6I8TpxEQMLhMHvZ0BKbjorh4eNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=dO8S7sbM/bqpkjjLh1AlC4X/8sGZGqf8eh1vimPKNMFLBJCQiPB/wTaSsphoB+pOJyuRBsotoswswdFACdvDkXtOL+7DGM+pJxwGrcE9M+Tn8MpJ20GVVXLQW1ZlfGkSnZyvnhv8+IJehsGV1lvpQez5mfnJIK2q4+6AMLGu0lw=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 06:26:48 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::61) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 06:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:38 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 10/12] drm/amdgpu/userq: add force completion helpers
Date: Fri, 1 Aug 2025 14:21:08 +0800
Message-ID: <20250801062547.4085580-10-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb5d49a-9ede-449c-f6c5-08ddd0c46477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hheVQ1dhM2jbfKPpyNvO9HfPS2RdkyminRtND0Nc6hP5kS+ClI619R1qqrpQ?=
 =?us-ascii?Q?JDUNfJ6Xp+AkNxLUeA0mBuAxxGhLWAmVn/o3AlVy4z3fumBwIEIL4qkzxZAL?=
 =?us-ascii?Q?Y6q5Fehz/chHWDzqbdWj0sOgfHEVK1DZeTMSv7SRHX4vBY/W89dID+YSRkxS?=
 =?us-ascii?Q?DwW0++SWMSB7dJOXrir26ucipimqNm3V5ET4p1zm+V+a/1O4lzCn3FiWINcS?=
 =?us-ascii?Q?IYlse0pdPfHrGNDHWmymU784lmZNfNwPxyL+BIsBZT1D8FPkoOqHJHNHKmrh?=
 =?us-ascii?Q?cFx0+UFw7zygJkBM1WUyH/zpkwhyZR1+WkRfCei+21IKOnLFfUMz3/58YDZF?=
 =?us-ascii?Q?NeBWbajl4yBP4US4HmzBDG/hIrd8a6vIGbg5Cu833kP2rx/2Jgmn742Gxwhu?=
 =?us-ascii?Q?4fjVolUEP6yCpt/l6XzJ73gfMLoS4csddvct8lr5iwr/w6AwmYKgLHhJhOSb?=
 =?us-ascii?Q?WZqsD548Kw8hEBzD/X+l6y6KFv40Lqqh68IPbkupbcaOvu1zkmFyoUf1ppKR?=
 =?us-ascii?Q?KP5bBhGENbkFVJ52QsooYi0321fbVm+/Ou6hwKtT3v+hLOsAqxxGcEOULRu2?=
 =?us-ascii?Q?akKqa1XmAbmqgL9EEcYm1tsDNFO6K70qQJmEv1i+y+cT8Yh4uNTEHl89cO1J?=
 =?us-ascii?Q?YSrh8pYns8PzUZ4/VPFJf8VoijAyx+3jA6g/P4/Dg7zTufjyBPF3Yv2hvo8Y?=
 =?us-ascii?Q?4xm5R1vfzARBKPbx0YG7gEE9KKBzoVJNROrE7Tp6HEz7mL/1lhAoc737h6Bk?=
 =?us-ascii?Q?Ccc3WH21FHCIIzQUdZDqBfftrp0Svfofgcob65NwQRvK7hTLAnK5vEtYOaN+?=
 =?us-ascii?Q?a5Lds2Ba/1MN26D/iJTSA8cYhEwNh52fKcNEGKdh0DX9MULJwEzYyVdlvETY?=
 =?us-ascii?Q?wQjSNXv2aTqbuUkUDQYZu63qKKbyMgYVPMsX1P0yi+OZUgB6fLrwYUIEGSiR?=
 =?us-ascii?Q?2nvjoNkywETKgfNOdi0JUAlgRqMNVvnGKYljVBOAt8Nz1CoZ2nuDOKLdqKQY?=
 =?us-ascii?Q?kO34Dd6jfi/GAUNIIBMRz+f1ohHNxt7MPMCYChm9iiAhBl7BZbovKLwghYH3?=
 =?us-ascii?Q?yJTrtaGosKmhxXS67lcYB/+MVjctRAbuKPF7yr9cPJilOShQKQgzx5tfvdhB?=
 =?us-ascii?Q?qa6Mq+kapAzUs5kQcM+1qMN4to1IHnZiJJXGJP9ojloliDxTjeGyTBnpR5MT?=
 =?us-ascii?Q?utKcMEGu2wO7MFZjXndcZH6lrb5pRxwaO/Zdd1Hi1wD61YkHs6mhRuvGdQK0?=
 =?us-ascii?Q?eFiblUsdMbEqwg7xruZEnNt+X7rxccZ8YO0BkcpufFfmkFk93PHpQ/qwT1yi?=
 =?us-ascii?Q?awhA41DPNG4ukFAR/PhOxXScKgiXJdy7hC943K14RyYggXtfoh/K0jOwv05Q?=
 =?us-ascii?Q?3bJUJDdDEuQ9lrlYTWpUyUv6Jaaia1NIoZUUYGeW7+tjXSBmGw0Dy1EsxIjZ?=
 =?us-ascii?Q?Y7jTobkFNUq5gzigjBpkFeExAGld/XdxR8DHV8K0OSNSjhUjM8GGnGndxHfB?=
 =?us-ascii?Q?wmNJbDEIXoYmJxQoro+KYB/5Dw2Q9yS3ET8D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:47.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb5d49a-9ede-449c-f6c5-08ddd0c46477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

