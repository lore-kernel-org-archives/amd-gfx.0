Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B670DC41513
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA2A10E8FA;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wDC/YrUy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F352D10E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrmLlgkqqhJJG0jICbICeqvJtsGEVioMfGDRcCYsOfnPdnNmv75CR01kh/u3GVkSIIDkwDmNkhRL/d8CsImtKRSVwnF/bDCh47WhE9wsSHDHBsvYDE/YKUKcGZKFT52lZdiRb/JOnR+3b8ZkvhmwoT3AKFdWvjYmD003+DqCW+E/Np/9umI82XIE4rsT1w36Lk2ihL5u7vvujlDZT8JrXySBor0MU+BJy4lCjuKpy/3cjj3/jIn6Zjpngi+2pjyU8AOjk9qdNHJSMRn1FTZ+Ny7kM/JFIM3CyJ0d3sNGOy/oj19SJJyPWCgWnGtGlCyUlBUQriSShkFy2GcEErRdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg9alPOwD/uKPCeEQQpU5VCQw0t+6qhTqXPvLC3SPj4=;
 b=BFMyNQ73zVDl8o7YtOXeuqEX0SImTfW7qKhbW3neRW7VSb3dWsOHWc1X4V6s6WJJK9zoorLgNyoeFiQWtG58R3epE5hM33KHKVsmk8ffgmechsNvvJujMFsSJFoFBQsE9LUP6f28qVGzcptV7sQwjChJp76Nx6eLR7a4w/e2RtnBQtq0o2iRa18GEDVaVqSDt+U4xGbv7VBIB9+l7KxwJlEtDBcVrM5UsQiaXc6F9s4zPbDOoJVbVgKxV8nagsINpaL5L5rUxJg8UfaXS1Utp/TaymxornsJCOXQsuol7cG5e6vVl5PfUVbxyxmlGFUSyWEMdox9Dyk9mb1/Olno9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg9alPOwD/uKPCeEQQpU5VCQw0t+6qhTqXPvLC3SPj4=;
 b=wDC/YrUy8RBNwX2Gh+8D5+OkXZo0w8WwC7gepDMolUQbV2sU5yP8PdT0q0MqiBhvpIz5OZFBJA6upIH7daYk0z6DrRyxFrGgXzQQR3zYwWf7rUpGhE/Rq7+unGJLaazKX5pjo6iW7ZJR5C6FiSB/rvE510d5nDE5mQ9+8HyS1nU=
Received: from BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:08:05 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::7f) by BLAPR03CA0050.outlook.office365.com
 (2603:10b6:208:32d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/34] drm/amdgpu/gfx9.4.3: add ring reset callback
Date: Thu, 18 Jul 2024 10:07:20 -0400
Message-ID: <20240718140733.1731004-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 4076bc73-55b2-4ab6-eac0-08dca7330b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNA/fGkH625w+4TrjgglR9ZQfaCtjA1J5HqnT28VWff0ro2l6QUMBKQ6Va6Q?=
 =?us-ascii?Q?RnIWz2snvZ4ZPoqGUyhkvrS5leVSfYvmPxzogr1YM3pVAcuBL/bsossZO/4e?=
 =?us-ascii?Q?+zhGLJJDss7gRULrF+BK11ycweTN8SE0YThW6YWgCoiTSiik9bY2cpbKnW7j?=
 =?us-ascii?Q?Voe9bcPAgD8gL2VE3eO+LJBb99hyN5Qh9LDr9fLr+bytAyctRSd/8aTr/tXe?=
 =?us-ascii?Q?MUig3IF8wRYU+BLm9hNo52Uj0kFUYyXVgks3KfA9XFOj/ADghjnCWbWQGyyj?=
 =?us-ascii?Q?ppkApmMV1a4CSc0sWtFnz1WSN99No+9+8uLMkTG64NrSeLKS0GG9UfT0bPup?=
 =?us-ascii?Q?4g6O2wZyh+VxymkdQssT+aCeo8PX8ecJPYTY+82VoX3wy/l9i7SqlZfgAoZS?=
 =?us-ascii?Q?O/m1x4rW9DKtEl+2FKJqKOkHUFNrzjqtMu72TgXnTieqQO5fyLbj8TpY4JIc?=
 =?us-ascii?Q?O/s0bLe+biwZS1cNANLLjOVIeCQIq1BSpqb02erMr9arKWTAz+BnA4JPuYgV?=
 =?us-ascii?Q?QUfhQU3tJkUJ1KELq2wsEdKBf1hRNRLqMDjABYdAW8Og6775wKXQPkom+zcK?=
 =?us-ascii?Q?U1awfsRG3ELBSptPE8BxKkWPMvOit+vUm6Bsd02RpZAbPheHVeBB3KZF0mj+?=
 =?us-ascii?Q?YceG6MH0h39wn2WJQPvS5HWmemluBFRWlcSGgHC4qlugSpkb2jQUcblJtzzG?=
 =?us-ascii?Q?OCVxYHKvzSvVEjUjDpWZyJJoK2MCgprjabsc5OZ2yXvVvQsSSs21Nlj3EJjF?=
 =?us-ascii?Q?e2OCrOWpum7rl7dIqP1BwIPH1VE3xfHKX9IuRLRUMAyZuclRK/euTPIYAjwz?=
 =?us-ascii?Q?G7QCyiWhqyjMsZFVwX5STBRv5vBqgfsEXU5ADAzNo+QJvl14XbHol3RWbkD8?=
 =?us-ascii?Q?ACSl+rVEJcDkvmN2VzjcJMQ+JfJ6QCVyqJ/3c5ajA8w6GNaQfHAygG8NzsHV?=
 =?us-ascii?Q?/48D2kkx8WECHFVEXe1TGcImHwNc94zPtHBdUXfBW7R9XpMQDAycFOfx9X+m?=
 =?us-ascii?Q?KJv0o5jBCRe4gnscVbyd11TNWnGVnzP0uX3DsgJcrCLOuuQzrezfgnd73V6E?=
 =?us-ascii?Q?kLc6+6n2fmf47NkLdX2teJ7gr0BD+i6Aq7veVYVzeyOC8XAafUWg81xvpTTH?=
 =?us-ascii?Q?k0LAgOGaPWwTd+HI1nb/Rw9nEQfnPSk/oRGOJw5sl8MAzhUJDGokMUnT8qLV?=
 =?us-ascii?Q?SVOAqJmoKc/3pVyWGVQ9Foo/+9Jk/Mn15GtwYihsY+nuKf3t7YvA5Fndqh0K?=
 =?us-ascii?Q?xkgoFGM1BL6gBh29H7q7HMv4qevgz12S/nE5gY16+PDBPTLtbrW7uk0dbBZE?=
 =?us-ascii?Q?HbVqCCCLvFlSnaw0w2OYRU8f+IYn52sxE/uv9VpcgeoCaHNbgGh2VhxaUjjJ?=
 =?us-ascii?Q?ML1i9uTRZwmhUvsVRF6Cf+wcP2PkMdVX/2xJ+2VIf1hEeUy9XEUopznuBxZ4?=
 =?us-ascii?Q?9lDn27o+aqIFdn7OsmCVxkexaP+Nl67I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:05.4886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4076bc73-55b2-4ab6-eac0-08dca7330b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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

Add ring reset callback for compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 98fe6c40da64..6cf90ebdbad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3263,6 +3263,43 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
+				unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
+				   0, 0);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 enum amdgpu_gfx_cp_ras_mem_id {
 	AMDGPU_GFX_CP_MEM1 = 1,
 	AMDGPU_GFX_CP_MEM2,
@@ -4235,6 +4272,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 	.soft_recovery = gfx_v9_4_3_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_4_3_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_4_3_emit_wave_limit,
+	.reset = gfx_v9_4_3_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
-- 
2.45.2

