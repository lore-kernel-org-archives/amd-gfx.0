Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24DFC3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 09:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6272310E9BA;
	Thu, 11 Jul 2024 09:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcRUfN5R";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E24910E9BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 09:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWc1c879Tbp+y6NIRuAh+jDF1qyoDa8W53mUwkAR/A/goZ1DsnCW6QRFg5BTN+yOWgBSoRphlOTkOHrTHzLphgC8WL+oa2tl6q08a6SiDtc1MZIHqkNntcDi3nmWy5+OZQilwXCo4NAT/0yeDWBpk/v3+1JSqmMWxG8onnYyvcG1WnYb4sQsKtMJXjQiaBw814oXyRpF5eVRJbqgizW0pzxog2EkrmMDeyMXi99ug5wGGBvLFDQV06IW/uoBZcVxA+S8F7KKEd7o1XA9wq3+rgfAM1PqxCma6ctB7M+3r4AQfCTwsnC3DM87sp79XM/ikPXT71tIdDQMZvQIPyfXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIvXK4Z4yLg6YUWc+qAXy8imz9gvCcvjc3jAzf9VZck=;
 b=nscRNXj6vfL3uGA0N7omWNpNncM3CWMQyYIoTqJlaq6IzjuLW/GIm0eh9+G1lXpEzWwWqnY8tee/pVCZHcY+qOfRFC8AeQ0EtL01epRzCZ+GE2IXay0w4o7VxEluTdvMFhp/PU3pcbs89YYAkowBVK1Un4LRHG8+uz7tMiBSMAhgwnD+gjLzVrS8gLICpoiFDohGJLJUG40LQ7Qvo/Cnt+VBnu4/DeHxkgTTHe2ikqgQhGGlSlAJg1FviccuD3A3o5Juq3SQ6pGR3Edh6hX8wSEBDBIdt3J4M91TgXATFkkflKUR+2HM+H44Gej0S9zNXu9ESUyYQxvOS26vO7bawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIvXK4Z4yLg6YUWc+qAXy8imz9gvCcvjc3jAzf9VZck=;
 b=KcRUfN5RhrgVQIVjRD+3EpVSEpIzZWOA85XjQBqlD6ghDi21ydj/DmP/SfQF3LyZtMXvhNInaIoQJmfpgLhKOLo/PdrIVnW0zokN66VycPcFxO4xaOol1a3xOzwG89RB2LWxXaHWYNsoTgRpc+xrtZ87Nv5cdUCg8DeYfG7f8io=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 09:09:58 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::4) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 09:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 09:09:58 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 04:09:56 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yuansmao@amd.com>, YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
Date: Thu, 11 Jul 2024 17:09:47 +0800
Message-ID: <20240711090947.478919-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 282a4028-162a-4a92-a7b1-08dca1893cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WAwakT7JMQF27u+a+rQbwjwoyoiPZMSThCFDaauBHrmOcO7bdz1YqpjBjG5X?=
 =?us-ascii?Q?FTS7wLXZW/K8xRLI4XTJ96zrm3BJrQBmYIS6qgL1gAOS/4qEYc/W7XK2K6kF?=
 =?us-ascii?Q?GD8xERWav5paxhpdqJ/jIjqkT7AtR46ZQyCipRAt6n7DYWkSJ/YeE3BHSdEL?=
 =?us-ascii?Q?f5hALppYeTmmFm8nSALCm2FfUu2JGt4mp0HNLoNFT9eVVuwfpAnizswREHRI?=
 =?us-ascii?Q?+mPySvi9qMrJ7qJrU+k3DfpNPNEWnZgDMIVDjQV1FMgV9PuIYzTjYCatPgfh?=
 =?us-ascii?Q?NPDjhPDPWIaaftT9BWcYon2inuGvqQFhiq5//o2SQnhlmhuCe0KXeXcmo51Y?=
 =?us-ascii?Q?NO5Rbo5N/sBvva3LTAnPnZgvt5ktqiWMKiu4HptVZUTz2CDgi6BhzB+WtEwp?=
 =?us-ascii?Q?OJWb6usm/AaO3CbdIiLo0h/zJfinTcMGBBZtJLM9EeQrlzqOziHsrC9muzvZ?=
 =?us-ascii?Q?L5f09D9gNnw5mQXVFTsqBpgPli2RVrHxu8ytRt4sJr1IL3vYDk6pnumFgQko?=
 =?us-ascii?Q?IeBaDn3qlAjBAMKBd2do8vlvqVg7cq/HtZpb/uyt1WlYGeIZDyT2NyWGW9F3?=
 =?us-ascii?Q?2BMBY1Ehx+aPK5jpnH0fJ34/vqUnOC9bInz/Ze/Ufb9xzQg3JacqSn6CvF6J?=
 =?us-ascii?Q?Ke+upbBKjuTZEJvBs+ZYAT9VCPNDEU6hk7WEQVldRrBXP7z580xp0xn4Refa?=
 =?us-ascii?Q?7qv591u0jvXQADkFdadDe/O58ZEKh2oehsDKn4B7yd2FGYJe1hOycdILnT+k?=
 =?us-ascii?Q?sbWw3xEJkfzIjY7qLWWPJPDd2ztkkJxX03BZoBNeeH45X3gOIz/HMo2FGx4+?=
 =?us-ascii?Q?bfH709fPOum5cJD3qfSr8OQX3F80Qvz0wioHYRzvSFhl28lCzxT6NPkOcCB0?=
 =?us-ascii?Q?ugcGstzq1rki1LXTe7rsSW/M1lhWJNWvq52BjyZr3fq3OCD/SQAVYNWi+fTn?=
 =?us-ascii?Q?LU2crThQixYUkyJvKABiNnpEa5sZZMXb7E4s0u4jHE+jT+D3uNwrJX3Hw7ep?=
 =?us-ascii?Q?6R7KC9EQ0h0ktcctIfmFv4kU16uS93mtLjT3iThNH1mGcnDv3c5VneD+ClIC?=
 =?us-ascii?Q?Xkm1mSmq8hdZGn2NVPmiv2Z84IfxDk6ikoRhd5kRKJ/lTaYG7ak093qalK3s?=
 =?us-ascii?Q?HdhnNcXMr7OYKATaxyNjbFbbQ8hsd1Nr0ciOwJiAapYh1/MMg65lGNswyqhN?=
 =?us-ascii?Q?0t0xU7Fdxf9RIQWrbw4LId1IBG+Oi1gF0cqVudOS78p7yrelhxDK2HksUzhQ?=
 =?us-ascii?Q?km3bPCrLAqEov/Bbj5rZQtIxuZdSRmkRBUJ4UzToAvfOqyXhnZKmbJdjpsBG?=
 =?us-ascii?Q?3600gYjv6umaIWvLEW/q7qZGfqlXmwEGXp7IpHouTpsxVPw5n4acdZeGy2vd?=
 =?us-ascii?Q?N3YkJuaPORtnfabiLQ/3evFsCHBvY7r8FTFQ71kJJgL70K5TwL3j/Uq13Ujh?=
 =?us-ascii?Q?A8Tf9hd069KfLhcG+OepIG1jJg9ZONIo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:09:58.3231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282a4028-162a-4a92-a7b1-08dca1893cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
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

It leads to race condition if amdgpu_bo is marked as invalid
before it is really moved.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 29e4b5875872..a29d5132ad3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
-		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		return 0;
 	}
 	if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA ||
@@ -530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (old_mem->mem_type == TTM_PL_SYSTEM &&
 	    (new_mem->mem_type == TTM_PL_TT ||
 	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
-		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		return 0;
 	}
 	if ((old_mem->mem_type == TTM_PL_TT ||
@@ -542,9 +542,9 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 
 		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
-		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_resource_free(bo, &bo->resource);
 		ttm_bo_assign_mem(bo, new_mem);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		return 0;
 	}
 
@@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
-		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
+		amdgpu_bo_move_notify(bo, evict, new_mem);
 		return 0;
 	}
 
@@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		return -EMULTIHOP;
 	}
 
-	amdgpu_bo_move_notify(bo, evict, new_mem);
 	if (adev->mman.buffer_funcs_enabled)
 		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
 	else
 		r = -ENODEV;
+	amdgpu_bo_move_notify(bo, evict, new_mem);
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
-- 
2.25.1

