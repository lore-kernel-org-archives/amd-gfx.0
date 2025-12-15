Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6EAD5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1806010E755;
	Mon, 15 Dec 2025 16:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yoEjdsqG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013028.outbound.protection.outlook.com
 [40.107.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E7010E755
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVcZIaoraX0SW4emAlapzpI5Kk9XVY+czSKjlonp1TGZ6HtUvtsZhR9/NNXPjvhvYcV6plAG7dnwtFdAxMSz8vQ7mZ8xwkg96bgr3NkWq6nud46/bCLYqSmJB2f2lNHTusRbuyl1qdv5CA5NCl5XQw/I7opv6RFrFy+GV3zcQA6/ZumGi8sGfDph54uSj3tm2b5BjFKZMftW2yGcwgXSz2xI4oaAQvLjYZ/+8huASa+pG4uApXzb8FVn4I4ffIxYN7ttxMTeGC1ZApoRxpPci40q5/eCOTv68OlCdXG2l9CsTv+SKfM0vEVb/EdwN3Vt1VPUBh9bUCO2X06p2VAhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdYZK0kLWRR8gk3mO5JjyCSB6dOsRfgr9Bzc5s6RmC8=;
 b=zIP77QH/QqDkDAwXoGL63E7W4/fG+Ira7ExN+OcpqaC7GWn28QfJu1cI4xI4LUxZh+9jelUQuOK15y6JkW/4Vs1YVqCfXky6hMizibsKXVAOnMrP9LGZR2EH1whlAM3IygiMn+AAwqsUBDNyXSLyek2I1wq1zPxt1jmH2KRRGEZmMgyC8aI4s6zi17S88AkCftXdzzOzJVeiMCnGnpk+TMZFRHK5j0auT6x9pibsurCS7NCUv78wTzYOlaX/nYqIOqQ7GE65yh7HIGMr+Wh6YinfcvW7dD+g6jPodyP0X2QXkjeLlewuj24UEiCOoZs8kxvMWuUBRfyfy8zM2uKGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdYZK0kLWRR8gk3mO5JjyCSB6dOsRfgr9Bzc5s6RmC8=;
 b=yoEjdsqGaqDLueStZpD3oNYbooXjymddS94DeYB74/6C/r3DcUGwxCrhvemM1k5rohEji83vfjit9VSVfL9F1HFxhKwFZOXrgEBx/IK8umsMJcEcaGqK0772S35MD2mwTslpaYL2Yad8B3PReZ4ym4/Lm3KBGqZ29hWrb7UrrvQ=
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:41 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::49) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:07:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: always backup and reemit fences
Date: Mon, 15 Dec 2025 11:07:07 -0500
Message-ID: <20251215160711.11832-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbf795c-0b25-4245-29b0-08de3bf4369d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xh9qzKM9ewabvSfybAg/1x2izxyZqevY/AykKzuyPA1ug5LQbvexF7dGW94k?=
 =?us-ascii?Q?lEBjVRPrdT7ZF88qrtXmDzC6ci0u6IGUpWLX+FeYOWKNVJoJepWmC0/KoWHD?=
 =?us-ascii?Q?S++pwdvQ0iaAbZ+pyIuJ6CaDHccy6Ons4yCgQeOKeytqt/rDU8gSerWIyiy4?=
 =?us-ascii?Q?aKWhcxFGFRVQdQ7CecFfYy7NfyW+XYGzYEc5C3gVJrqjcOaH/dNiAGBY/vgD?=
 =?us-ascii?Q?EgARqjXv71/MkpSmuppAPTWv3WCc2mJRb5meRjpSXC8p1R/R+nyA7xcUD2G3?=
 =?us-ascii?Q?Mgufl3bHz/ExOacPjkfYh7z0dY6Tr02FTWckZrgFdtRuhOffdZjTeE/rEXdI?=
 =?us-ascii?Q?nWC8yNzr5gAnoXtYf0tPq27Eo1bm13qKBgLvcbEw8qhW9IDq45CgJUtoVpBV?=
 =?us-ascii?Q?gWWnHdCIQi4TuRVvBB7XwzBA79A5HrOR9RqrI5klKgG+UW2noGBbzsBl3XG4?=
 =?us-ascii?Q?/johqHNpZYc0wY+SO4tFWE34K5WwJb5l4Zhc4zqpjlrUoV147s3A/5SijXYy?=
 =?us-ascii?Q?izk+FCsFdIXgl59zbtGpEpAWv1YzB5H7IWxkFO6A8g9S9q+ghe91fIzIjhM0?=
 =?us-ascii?Q?N7/Y77DWIfq18/+pE/NDlda3Qt8kLUAHzd5YKcg6jOz6rXwi4P99OmFZmxDv?=
 =?us-ascii?Q?UGu6/JzPIUpZBBE2I/O+X+YDTvW9HoAm1vUFNyOKF8lqPINuxjjxf8QpHctP?=
 =?us-ascii?Q?Qm3jYdeYMzckioMJk+SSJcMdEzgr1FBUjaGxVGt4gIHFphkr0xYfVMoje8lH?=
 =?us-ascii?Q?JfDockYZ2ZXXX6D/h6D2mZ7ECAN8r7jkAbnt/iJjIMHiyu4F+o8goQ7UrJMS?=
 =?us-ascii?Q?uWFxWJ1xgvYkYMyGH9OItNwcdepY+i4USa4vBwYH+yMwrk/X/Qa/pI4fF5bl?=
 =?us-ascii?Q?Dmh8/9zA/25S/k3KOTccwslpTX2/wcEX3XAOa9f8cETB89/o7N7+dfL6hcMe?=
 =?us-ascii?Q?nk6EVUfsHv1HnjDqqgnbsusE5u3Apa17DXGmQGz/baWxpPYbZSY8crLIj7qh?=
 =?us-ascii?Q?cvaqkJrbfXttNaktMwIKFBf9YH1d0dk2iDXnKM7J1KrGpCApvIjAPltZiPBm?=
 =?us-ascii?Q?sc6l/8xUhv5YjUCyrL9Q9UG7ma6mqz6YPD9NFYKtbjLqh4Mia138luu6yud+?=
 =?us-ascii?Q?BSXffjHebS4R3MMD36oWYaktZPgTRnLwE7IiK/WjA/6rLJDAjzKo460ByCWK?=
 =?us-ascii?Q?XMHMWYf0pQ6/R2FxkiuZUOi9PZeh8ixm8y5qnw2WdAitlobiNjeyM+F4H2EY?=
 =?us-ascii?Q?3xDomdjlJqKfnigiJhovCXwgFRQ/CUfnKAAcyPiTUDEkSpN7hQQ8lxO4LnQh?=
 =?us-ascii?Q?06JIearBbjhicM5bAw7DOUamjGFAwGUHPQlQO03SFPAcm8IXae6tZqiIb4m7?=
 =?us-ascii?Q?uDQLceRGkJtYdyzQgXa/DWgyrANoq4I7e4d7Q6/Z3cglHI23jv0ON+ux0Srj?=
 =?us-ascii?Q?Mr5h9LLbNvB9seGbGS7fn/YSkZOsTJ/XodZ0sEXm1AYQNp8BjN1WdZ3/TnZN?=
 =?us-ascii?Q?rE7tvho3jzeYVR1PGl7b2eehAItL2lJZOP/XM/TSwwBJa55sFAe8WHl2Ml8f?=
 =?us-ascii?Q?7vH339xhqpRm51Iaj4E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:40.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf795c-0b25-4245-29b0-08de3bf4369d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

If when we backup the ring contents for reemit before a
ring reset, we skip jobs associated with the bad
context, however, we need to make sure the fences
are reemited as unprocessed submissions may depend on
them.

v2: clean up fence handling, make helpers static

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 334ddd6e48c06..3a23cce5f769a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -89,6 +89,16 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
 	return seq;
 }
 
+static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
+{
+	af->fence_wptr_start = af->ring->wptr;
+}
+
+static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
+{
+	af->fence_wptr_end = af->ring->wptr;
+}
+
 /**
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
@@ -116,8 +126,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
+	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_fence_wptr_end(af);
 	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
@@ -743,10 +755,6 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		/* if we've already reemitted once then just cancel everything */
 		amdgpu_fence_driver_force_completion(af->ring);
 		af->ring->ring_backup_entries_to_copy = 0;
-	} else {
-		/* signal the guilty fence */
-		amdgpu_fence_write(ring, (u32)af->base.seqno);
-		amdgpu_fence_process(ring);
 	}
 }
 
@@ -796,9 +804,15 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			 * just save the content from other contexts.
 			 */
 			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context)))
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
+			} else if (!fence->reemitted) {
+				/* always save the fence */
+				amdgpu_ring_backup_unprocessed_command(ring,
+								       fence->fence_wptr_start,
+								       fence->fence_wptr_end);
+			}
 			wptr = fence->wptr;
 			fence->reemitted++;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index d881829528976..87c9df6c2ecfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -146,12 +146,15 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the fence for resets */
+	/* wptr for the total submission for resets */
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
 	/* has this fence been reemitted */
 	unsigned int			reemitted;
+	/* wptr for the fence for the submission */
+	u64				fence_wptr_start;
+	u64				fence_wptr_end;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.52.0

