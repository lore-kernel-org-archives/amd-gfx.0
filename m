Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66365D73E87
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16AC10E33F;
	Thu, 29 Jan 2026 20:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDptvSN8";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD7310E2B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRpiDg65/4j4kknqJLKJzLKenYOYXP0pJ0tc7czMamO0ravFaIb4Tl5k3NiNLg8jbxnylQbqe9Q8DAcmUwRKXwGrU2vfyY8ks0mHfkYJqJDfvvdRjlYO6uoYgcHEp1djlUv1zp9RArjdUwd+DEch1nnqMZICBI8BwsWozdIbuZpDg2z76rTnCclUQgg2JgoMPQcoe4ijJ8HxZmFl9rHDGuRcsqGomY1JYxzZODdI/xmghyUvj4eJ8E2ZAOJ9VduGA5LNole3FNtJDkuo6bsV0h/NKMQC+P2UV8ogQDxkXQ265ujR2PyZXeCJako+OmgMx8bLn75Oc/npwtI4ICF81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=fr2Mc5hE/Xu8oVkKA6B76/5OXVgN6qbe8YtATrw62M0hQXwY+YxLLUphu0oN79rTlMZSc8HmIzP6Xq7MgSerrRM2M4Dpq+GtbK74Nodn/3AnOoBBbWUpmNAxCNMFtCF+P4PdCBM617mL3hJiqJiG9Qhky8FfIbuni0oysxTc9Bgz6GsujxGjUX6dc0RrpYhxTuSijVJMgX25DBBpZHrQibvT+Ms+U1V4fry384HFCQS3H8DqPyMi7EBlALvYf921+3uFQ3jBE1h30M5npkyW7BEZiaNmK/RFkj06C9PC5eO0ljrLUFXj/vAf3iWk+0H9zlpF5EsbagihAdWMjfsIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=jDptvSN89FlxTRadDG/QlKCakKGf1ctkRlCJCdtjTtgs3RbTkLnND5eJPRrtCOjSdMrsh29Rh/6/jybcKFRFCSLU6C6qpN63lrjVckUxl4+oqQ2xIOTW4Rm0fj/vfMviidOpAdqLrGMBTY0aH3SUDfT1j8ijUwSChDt+/xHZMrw=
Received: from CH0PR03CA0393.namprd03.prod.outlook.com (2603:10b6:610:11b::21)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Thu, 29 Jan 2026 20:38:00 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::d8) by CH0PR03CA0393.outlook.office365.com
 (2603:10b6:610:11b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 29 Jan 2026 20:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 12:37:54 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:54 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: simplify VCN reset helper
Date: Thu, 29 Jan 2026 15:37:27 -0500
Message-ID: <20260129203731.21506-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b194824-37e1-4074-e80e-08de5f764a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Vl3SEIT3zfGYBbq5Dexql6NOrDP2igwHouoJN9nw/giNz9D6AdjheKvyBbH?=
 =?us-ascii?Q?zVzWOUSnutlG6TdIfGf2krWWIX4P+bLzR08y6aY8T4nCh7pOFG7sIKSGfPAa?=
 =?us-ascii?Q?4c0Q+LC6b1OjgZi5NhwEo6RMue5DNpKhW0qgv7nUJazpfb3o1cP3GUoDh2Q8?=
 =?us-ascii?Q?1RQK1zKR+tBqmjaMyA4CnBSRJIArV8CZSq/BQLKrniKrOBXI4Ml/IWHODj82?=
 =?us-ascii?Q?i6Id4vygoJNROMqGQ318ZXlYAedv6zlhcqBDN31dxM75L1HSlpP83xLRgm06?=
 =?us-ascii?Q?xoSWODrBUa0ljk9qjAzKjq+Bp1Ajk2pcY/bmT1UzgdYwpwKU+TWzVtevQJNS?=
 =?us-ascii?Q?h+bYFrt1UlyB/K/dEE6X0QPJxD61up0BDQCbz9rQ0kHwRqmW/q1Sk35Pe4gR?=
 =?us-ascii?Q?SvZAK5sl7E5eW71c3D59WYDnclangSTCiDgUgEIVQC05yqRxD1EPx+uK8LcS?=
 =?us-ascii?Q?1bPDg1xy9a44IS/Iz2ngV9IVQXI+w5WjHlmFzIvAgMmwE5nJ5uzX30/NNgzx?=
 =?us-ascii?Q?eCmJ0qn7n1cI8YU3Q24HY9VtdnmkedyDCeTExfDmMx/orKRgJEG2ts2WRgBP?=
 =?us-ascii?Q?IXWUsjamR3X9CxGW1y8yuWxCP3VUSSTb3lMNk3KPYKisxGPaIzOogL9wKHry?=
 =?us-ascii?Q?K0Tx3Fb4Mr40aj4R937CtpHQsFV4WMzmPoT2ne4i72wdVinNrl5PtYSwVHQG?=
 =?us-ascii?Q?n7ykB4VcxeTQq/G72hxI6Xa/IdoZFgOkRRfbIuTRA9ZN94H5YSTjpNyOzMVC?=
 =?us-ascii?Q?0dusLGQatUUwKJgF9+WdUCmF4L3A/1AMukm+KRP1GncLUTcy9+jDkgn+Dcuu?=
 =?us-ascii?Q?vxtKBadHyXwhCm/Qh/geKUbV/E7XFuAkLeiKTTtWF2ILUuAsJjuRCC5J7R3M?=
 =?us-ascii?Q?FWC+gHRGeTmBhtE5AeBgyu5EDOzhGPIq1JzbUVPnUo+8nmQ9SNxspFg4h8he?=
 =?us-ascii?Q?T+5iR29WtpoFpyJ0XQvuWtNi90g0O/z4UH6lnxOV/xhNETcjakdHYJH9ql5O?=
 =?us-ascii?Q?kJCaPc8K9HgrwI+/JmjIcJ+cBxuOCd4we9ZzQXYb20nL/S8dPRYpsaaSV1EF?=
 =?us-ascii?Q?rACvY/3LGJVdXcCUZ5D1fR/n++lYlFOPHJk7TaCjCg4AFhaODDwEfwm8Lins?=
 =?us-ascii?Q?94hblFYNm8atgAQVW0qjmYKMDfP4n33Ya/V6Zhk9XvNU+dwpMJ5eaFb5vUAI?=
 =?us-ascii?Q?sG3o0eZkoQxkFIJFFlOwc7m9NCk/Cpo1+y2rt/q5t30XtZrNbiPPOsbpH2NR?=
 =?us-ascii?Q?gXJJrGrgaTryw3wewTXyEXoqEOzIQfmjEUo7nSbAw4xqf3Yj6jFEDdd9rVtc?=
 =?us-ascii?Q?QzwHw1EKlSx6Ktu3c9vD1E0Dis0bDvbxFK9tqITOfsIqNFjhCHk+DsE9YS6w?=
 =?us-ascii?Q?cjUqnEC1KxuxgcPgo+vdZFnWa2gYR3LQ9tjYUUf5bMsk8IqweU1gH2zgT6EK?=
 =?us-ascii?Q?dKxMspKKtC/HtGspAjV7pS1Nv9KMRXJq77yGzKqqhv1SjZXMIarmoqBfQnap?=
 =?us-ascii?Q?/2e/yESKHK/FXqVmPfKXF9NQRMjrfQ+/maIQ3TNLS5CFl8oh2aqhn/l6Go43?=
 =?us-ascii?Q?o6fGd7iGBCGhJrGj8gynuziO0ZQvBsJ5kXCFQRppa1qNH5TyofGIz/8InavF?=
 =?us-ascii?Q?A+s2jpio7YUytS+394VrRFdyVtPMVocnn87M4awKyyu6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fZ9/ZdLjD98g8RGg24qQuiPoabnylNa4bNvT56NqSELhxvAK8rGOH1St9m/eyUN4UzgTHXjq1M0YYwiDivPJxsvpVLanwIBeig7PFY/hsoUniIagkYHZp5u0bbFUIxzXuKRElH5SDRLnVoS2ahoWAYXCNl86M5BIB9dGEn2uZwCH1H0T1803uUC/32fa0+E52L5LPamoWTPl7s4myg7Z8jtzWLCS9kO02xYRwcp8A2aJJ19lu4SKmkQrQQpOaxo5Gk0ku51h0sEL7MldH0ckj5voUIQWBL4nlsNyeeYEKjvusZmDmSxwFiOw1tY+w6rq9f1RsKeC118aWGROACVdXhoaGF9ygfWbVR2sJVdz7AAnajmXa3TylKl7X5Fk4d5F/ydZrq/KS5AIqNcx9DvHALOvU5fM+BqkmuhdyF9+XQBTt/fpD2D4PGywDwrc4Tk8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:58.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b194824-37e1-4074-e80e-08de5f764a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Remove the wrapper function.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.52.0

