Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D7DC79FB7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 00:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DC310E1A7;
	Thu, 10 Sep 2026 00:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02+s6/dL";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB2210E232
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 00:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krdbtqWuToz5oeiu+PVVDAbBBXOhsThGGS82NlzezNiLl0zPnquKjsJrWSDWj65A0PlZphiBGY9lD7q3AGLI0T3e1N1WHLGReL5Dvwvd2qWuKpz6QgD52mtpXN7HV42U/Prmx2dJzud+8T48hnZ3rzkZgr3H3wDkgPH7VYNlc8rdg0QiIoUoLZ1celVVSmgq9GcIxwb+hYOn7W9EeK3z+adDuscUxnq8uMs5LAXrJk6kZ7qo5tmhxvqSwhGVBhauf64EEasI6bfW2YMOcOHwnLhj1gsrDH7H+3KmJgLqDG4inDJ39VQmWEcuGZT9ZyDJ/8QRKVMleF0icUYDtqA8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTRhrfyUed4/U4ZRwPaPtIWW1aj6VZy3WiHe14Yjrts=;
 b=b//NW/A0HXUpI2fNBkKex+ViNx3nzIK82/PzwszyIrQSs49Yuxe5J4sM1AboAyOe9OdtvIj7FoZLwxcZU9oyIczXj/VecPwaNm4iPATTFDXkz/4jLgPxOodUUAkXmLSkQi49Hphe/0tMwuBm+4Qj97Q++dtkhku8HAxIRWJgEJ3pGZYxOZRGBvgIFZBAe1r7aSTvY0bnIyqSJPCQVTez/uz82o2lYYnqbnTv3xiTf2SCKr71T8+VlkOse96Iz2HYkTH+UR467SCPRKjhiGJiKj/T9/lrJs3vycA82BBnAzyYyQIykJk1vCy3Hu3VISL2rST2LtlLjxleW9o5/MvZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTRhrfyUed4/U4ZRwPaPtIWW1aj6VZy3WiHe14Yjrts=;
 b=02+s6/dL+xL9mMZlta+YmpjjW5o/QqGbml1OrMGlxOOXuqTNxQDkbyqqsAo2W+kCO3F9ueWSrZTRh6jspVhuy+S/9J33NklqQXWWcvdjo+gYMejN2udXL9ERauW3d97iJnw6sI/pomQXkRHZAoNPLNQIvGUwIRVpVThaauo4V8E=
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 00:47:11 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5a) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 00:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 00:47:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 19:47:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 19:47:09 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 19:47:09 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike Liang
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reserve root PD fence slots for userq
 eviction-fence rearm
Date: Wed, 9 Sep 2026 20:45:40 -0400
Message-ID: <20260910004701.94511-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260910004701.94511-1-vitaly.prosyak@amd.com>
References: <20260910004701.94511-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6280030e-864b-467d-6681-08df0ed50c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ix4RoZLd5iAsLeRYN8obLEM8IFwnI+C+rzpkpL4gy+kMh9n+nG2f1z29daoXKHDqJ52izG7Lh+VmlAtUKmPOiC6X5prmpXS/D386P3x7FJNXVsgSDiA3/jCwzVw7dR+4/aXftsFkCeUbocHCT17QH4bGDuUx15XJ70cEpyYsKdY2eike2RzLvDJsZL0tznwLAg2TEWMJkykqcAP5yyDdTQ8T8uOVJ5rBYKOYKCTcHN+2CtZ1KQeZtAudOPyMiQbtIEudb+nHdwPwvqFTOqa7Xtv2mZ+dH+AfnWdvr4N+7WAUcUxMGgCvUwJFGODI5mVta3jOtc/1BaVeiqx2xXudcNoI5TQE3m0jsC0ueXiCzAjdWQ3jjc2Z6SRYhRfrZBONMys3PC9JmqJhvNhkfelebIO46xyXpzd3R2KN7weyR9UKji+ILgDScV0UKzICOFcQ1X4MoyH/H2PA1PkyguzeLkcmcrVsC6e0fOSx8xwjqQwTkpXYrBmTY6SbQKHHUIwZPsvTXUvVWloDXz5sXTwXMoVT/UXkYj3GUde5tO+e6xecnK4znHvvBFyqZ+IKx06Dxc/88O4SnwxGpz0u9qorl8TVweMyxXFPI692dvkSfQAO/Y80eNLnxrxfc6A4gnJq4+fe+5kZ0gkfQ0XGbQ3m6aRQTrurZ15jft45IAs0+sDaiWoXiYg7Xyj96WRsxLvRSh3UtAOcGzn/2TMBjPLHlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AMs8DZQi47XSWjcQerbbn36jhK8PMPaQp4drEjNhoaEnQVFtE+j20K/mu5px1/vuIcJLrDQI2YuU800KmYvPdkGFF9nYZXD33yDGprWIvIBpmDuq20iPbIBj00ZEyaB+gi0EH8Yqz9YuIpROL2KYFXSoi4a2gNSEt5CfAJl7Dn/k0FPQ+IaXvoepBtwQTOA2rED0uamoQwP3EP68tkuAY2FkwLz8PuRQeHY888L47W6vvmHf/oRykeIoJ6v2XAUnnVi9PbluCYK4wPo5nBnpdGfNqM3vbXhgLpsfaxZItqkAP6pdMZrP/q7yHHoGDXhRQV6DrU5m3JCkb6ReB1N1ul763dYLMjgL1Sdwn6tPfcXHfInvOUo9eSt/UCruoL56+dlphX5yKlzXu6+TWbshWLZZ3FGhUDyJynSzL0H9FVveKT0j0fMh/HI5AqfACO29
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:47:10.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6280030e-864b-467d-6681-08df0ed50c4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Root cause:
- In userq restore/rearm, root PD was locked with amdgpu_vm_lock_pd(vm, &exec, 1).
- Later in the same drm_exec context, amdgpu_evf_mgr_rearm() attaches
  BOOKKEEP eviction fences to all locked BOs.
- In this flow, root PD validation/update can also consume move-fence slots,
  so reserving only +1 at PD lock time is not sufficient under stress.

Fix:
- Reserve caller-side slots at the actual source by switching to:
  amdgpu_vm_lock_pd(vm, &exec, TTM_NUM_MOVE_FENCES + 1)

This keeps reservation policy in callers, consistent with Christian Konig
feedback and with amdgpu_gem_object_open() where callers reserve
TTM_NUM_MOVE_FENCES + 1 before attaching eviction fences.

Credit:
- Christian Konig: confirmed fence-slot reservation belongs to callers and
  asked to investigate why +1 was still not enough.
- Prike Liang: clarified the initial variant was workaround-only and
  developed that initial version independently.

Cc: Prike Liang <prike.liang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3938f7b8ec4b..12fbff02e4b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1043,7 +1043,11 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 retry_lock:
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
+		/*
+		 * Rearm adds one BOOKKEEP fence and validation may queue move fences
+		 * on the root PD BO, so reserve caller-side slots accordingly.
+		 */
+		ret = amdgpu_vm_lock_pd(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
-- 
2.54.0

