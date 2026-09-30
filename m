Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260BCCA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE7B10E24C;
	Wed, 30 Sep 2026 09:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p83a9Q6+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDB010E387
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVQzoTJ+WPOpjTgoi565cyBBLRJhRTWJJhIec4ft7tK6/eM3eg7TRt+s7X/0jrj0SHRzt7VOKYLjY/wUR/C5qhRrjRyyFC3BZBOt9JgQ179fxDRNE6DRhUp6PsIeKj/XNc+2ax1wrxrflGFzqUynpCm+pewl2KU7JKcYpaWLZDVm9G7pxI3yLD0RPlwwhkVS2ZiEk6wcSrudewHAcybegcSgok56DIAgs/chxBAhi0xtS5QNCoLtFCADbZN+f4X03HNlvVqx1hIDsN0Gh1F5n8DccFFjESM53746aiqktjVsyo3FYh+AWc9HaamJS9xEFR/QCgkWwoZ4Stl/JXd4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1yZ0gC1DDr/mz5B4nku6gpva5FxRnQCBr5xAP2caVI=;
 b=ZUik8irECxpaPogEau+TgbHYYPZByXTZUPy99qdm0MkUxv7XSGPPflgS8q+mBR5QZEjypNB0E+Co1AoqQIYNWqAtT2oObxCgkj8FsDZ3M5V7bKnIaejozHtdhAHUDK0WM6y5rj6hd5AaN55PQxtmq71ymIYrGYdz8He9nnkFXrSuB7nmD1iQFjBUMGM828P9MrV3KDhoXZ9WVS60xFbmq/Ohk/S8M/kDr8S47TeaP1J4q3I0WWgOi3hCTzgn1dzVakAx/gz5HfBtN+VybN3zG6t4Sxy83l2LDLR4GVCxu68wRudZ13bmiZyvgImKpWQbl4uWI3fzcmfbK6JjlTyKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1yZ0gC1DDr/mz5B4nku6gpva5FxRnQCBr5xAP2caVI=;
 b=p83a9Q6+d9wphl2gTc6MH/r+JpgSzrLphdkkRI5gwEbjzKoh/COCxu9GQTZZcHADdv8NQP9JSc0KqkJ1bcsKVmleQ0IfU7xvYel6ToD3ccz4sNjOzDQvgMdCdbC6UJ/nTf9Hji4dmt8tFpf/CH99RgVoIZD3brMOH57FOa7zXV4=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:39:17 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::44) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Wed, 30
 Sep 2026 09:39:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:39:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:39:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 04:39:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu/userq: return the memdup_user() error for
 the user MQD
Date: Wed, 30 Sep 2026 17:38:11 +0800
Message-ID: <20260930093912.177219-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930093912.177219-1-Jesse.Zhang@amd.com>
References: <20260930093912.177219-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fce5932-1938-465f-de90-08df1ed6b203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kOUTKyJ1LAk9b+FnrNVWNDhf7kUGp76+w5yREUEMJGO4Zjv7AhbFWKv2tHwS2JboYwP3vEH5zJC51sPkMgjJIn4kU9kmKCLJPrPKRqF6M7+aV/6rwaa4xGkBzyN1aT5GX56gXyXRmGiieZ/xJw6g8Lhg/bauJqhX+9tu9j36tdGp2D0vb4mmuXDC1T+82vRkcosfLvZThyQ2ovBg4z6p+MddIPiPFFKKZyxuf9BsYvkxy7vHBRgaaOY1sBn4LfOihmHnN/Khw/wVWAx/5mvrcuUpZze5Gih+lP8eVYj963H8SkE00Elj1ncwhivSLJ/nMwiBYYNA/tFwflMf2WNZuKsrts2wT/2Mqy1EfVu6fZFVeBZl7w/Oo6WuP+YycRLrK3uo0+zjwOdWkalWI/oUtRd+FZzBrpBseNmdIzVALLGAhw7AXd+eLvguEeCJT1VSlEadyS71xrNQL/PJh/O5WRIAd5CFU2k1ILeWt8tBj6/K8CaFZzDgp3YHt/+hEOIWaWFn0e058D8CqjRBeW3IUMCVQMTkb5v9D+gLpmzU2aq7s7P2HCDUdG7iLedUs2TXkGdiXaeVMU8jZzYfn4hQp7uScGwF8WYYEds7W+3HaEwDJHjRdX/dZy2zCgO864ZqWVajODDhEVEw834WtMnja01OsroyT6t93LkZqOiBh2/9ZfQoIXjFo5gcgWL8CA6Hl+4L7IM7gCQqWqpM3oPr+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rf2wJz1XyxJh97mtTFVjLL44m2KyFEnPdQPZ2G6XdVWqq3GKlEEVMjWG67V1GuGrmBdR70o7Y8KbvtWgNIH0ppuuBuYw5vwcpy9a/0gyq05llPI2qXdiygA45R1JQg520K34U5IBdjPZlVxNVPZlJwzAL1VRuiq5e2Wbp3GAF6a2Cdorq9Dk7JHigPlJMeP+A4k9H/TClvAO4P9iDDUXfVc+8jUbov+4aRHUGsghLCD0aeXe8wBJ0qbEWw5MTtoTugWvpACmPHnk09Nu3/WuduA2MbPjCleYxu29XASqspFHF3gwAcVKOTT2IN65iv8Qq1LAHfHKldn5YXGg3Av1nXAh6gwVRU06qXQ0m7Lmr9u9dFcBLaT/tp6RBSURSpit4r3EmP40Xhde/IRy7Hez9fUf7gsX5xP1wS508mkBv0pD+tYjGhBdJCzplot95Fh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:39:16.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce5932-1938-465f-de90-08df1ed6b203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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

mes_userq_mqd_create() returns -ENOMEM when copying the user MQD fails,
even though memdup_user() returns -EFAULT for a bad pointer or -EINTR
when interrupted by a signal. Return PTR_ERR() instead.

While at it drop the error messages. Neither case is a driver error and
userspace shouldn't be able to spam the log with invalid IOCTL
parameters.

v2: drop the error messages (Christian)

Fixes: 2c695d7c0720 ("drm/amdgpu: enable compute/gfx usermode queue")
Fixes: 543b61453774 ("drm/amdgpu: enable SDMA usermode queues")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e6c167a39d44..1b76c10d1ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -407,8 +407,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
-			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
 		}
 
@@ -452,8 +451,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
-			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
 		}
 
@@ -497,8 +495,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
-			DRM_ERROR("Failed to read sdma user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
 		}
 
-- 
2.50.1

