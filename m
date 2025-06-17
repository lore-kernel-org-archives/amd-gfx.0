Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B46C7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D89810E4A6;
	Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T0kAkKLb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D4A10E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlieF7Di4pDWmXFTpgk1TO9VRWKqrO3C8M23jXQYMECV+QbswYkSCfR3WZEkAsKcQ5+jfH3eyawmP6dfxGNvDDQKDqfFE1am7KUo2EDoddOM8IAbEkZueDolYwuenZWfYNqsg7TORS2knO4chMNn/z7famULH8lAPg2uGztFxFZFWsjhcqQElwk5cbZe7dqIcmeahJyDz73n4J52edMFNkSZvoXG7i1K8rJlqdWghIiJ3rPCLgn8g5ssGoes6l5uUTiiOkuqnCfDmzAohvxIXpf/NWJ5uPsrJGnC8PogkSkpi+5u3zH9hdU8o61js461fH9tQ1+NefnnR08hymP1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh/tyfDsa7/GKF14EnckStdgzqeCy64npN4uK8aiH/A=;
 b=jc6SS+msRNWjHS1mXByagNWlyPEVFopZ+3InqBs7IvBVn5iiLj8YD6MXhZ/f+ZQJdAD+XoptWQoyxijRr7fdXaI34+jQCtEHwpqCJU+EWe0rGMRskfiEI5MhJ8ZvgvFkaApmb6VlEYKBuEaapEY6Zat0fCKCry+xD3DSUdsIz2UgmsFQa+LvC0XbeZhe01b8I3N4GHzXaxggZJrNApjCrnyt/ej/grlebRaPvG+/JUhvK/jo2f+Lm5UbAek9EwaDZRQ1eqACSas/TQaFWKCr4pS7gT0QswfvQIizyFpFwbxr/dPKu6lDiPHx+0r37PUGqwC8c48UvzRpCoj+iNEz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh/tyfDsa7/GKF14EnckStdgzqeCy64npN4uK8aiH/A=;
 b=T0kAkKLbAuqaNGLidVuUnRQbHO9gGBkuFOj7RUgmwl3Oa974ryWWqycvqZ7vctjgyqQS2rmX2Gkvp58pdZChjsZPSk5poAvJrGeNmRywFH3Ak+idO4nds7HFmSBsoBUGdhuRAmtOiNLNnMNRw16AVCKobV1vMduBHyn9Aix5Adc=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:53 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::25) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Tue,
 17 Jun 2025 03:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/36] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Mon, 16 Jun 2025 23:08:11 -0400
Message-ID: <20250617030815.5785-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f5651e-9adb-4af4-436e-08ddad4c4a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqZovwpW9LF8JWgiLDNYZ/9A9G6SuLLowDdB+pytYVeyWx8/HXFU25pB3Y1m?=
 =?us-ascii?Q?xf43ZRagoZGVnZrcwwpVJScyM3UKEp5738TIAuLbvkhXxi4X0aqReJG0VgR/?=
 =?us-ascii?Q?d098SxbsouqXRt1LHPLf079TNb6qsaKD8SmTfq3hkeOadamH+iIDNF6nuqF0?=
 =?us-ascii?Q?pI5QvwkuR7zqGQhz5zYbt3Hd6j9KzM9J+GAiWrHMyVffzWUxjStu00RhCXvw?=
 =?us-ascii?Q?7fzLB0U75jwa0szzgUdTBuPR8VDCUSFKjP0/l0DjVDroGvIA8mjMm7hWHTFX?=
 =?us-ascii?Q?kyB7yBUL2sX8l1CAKljvY+6/UVK/nZ2OIcbF/W/Da+GWWdts+w0/Y5YjRS4w?=
 =?us-ascii?Q?8O3CwHC9Zvugu0JWDZdKxJEERUq7Tm40WypSYs6JYNCUFcr4W+Br4h0By3n8?=
 =?us-ascii?Q?TVo7avBO+tGTKN/tvWTcKWszcMDL7gOErr4vm+OMFQFhtzcz4OpTJOP20cOq?=
 =?us-ascii?Q?3X1k1RmjiTVB+NtajUwdLv7F3N7/8T6aHaHedS00MCk+r49cEsYO7pIm4Cbz?=
 =?us-ascii?Q?xkKyWWsM0XYXcOPJj46veYjrRqtK/I6Y0UHXAb/KI7H8jG8op4itB40I1Ya2?=
 =?us-ascii?Q?RojiW+Eq1/KZ7mbB11bqlGifqfE7wMMEebnToQsIHjs3zKpWm88q8xNgUrwD?=
 =?us-ascii?Q?IgdcodjUXscilVmwlmQheQy2R3YebUY5EXHV4MfmxZhJkVhHn5Z2b7O2K7nJ?=
 =?us-ascii?Q?YaLXcUJC0yky1mODHQboHHuaQD6SEZ/xXDc6fHppAqA6weo4keOOAzCC53NH?=
 =?us-ascii?Q?Ql8sGtgrUixekPghYaoB7+gHL05dReb615TqJiLrwoM7g9+36+0LQI+w8wAE?=
 =?us-ascii?Q?Qr/2C+jH3+9SFDeCWQK9zAvmickcPzKlxAHvrgS2w6AW3rAI+6j8PdMyZYOF?=
 =?us-ascii?Q?7tXbGcJ8hhuIF8v4aVsXFp+0h0SGb/h+ztG9Zn6Wohaau2AVFuyqEfMh2Xpy?=
 =?us-ascii?Q?v4MtcSpYir/Zn528J75ziM9/JbgEMYXQEKCUSYBYGOqiJB/e1S81ULhwuKzU?=
 =?us-ascii?Q?C6CWlVvnr2sMR7wImkRxqjKVmh5sKYz5q4JLeeAKeQU2sYaQaIb8x3YCLxhV?=
 =?us-ascii?Q?SiEoD71A1H6DMtkm0a/iOfgyOpEr8fpT8dtl0KWvVkfDvON848v0TLwltaVF?=
 =?us-ascii?Q?kmjuPDb5aztglGs664elLJrsCwVqd3KA95ZGBSNVjxu7qlI9Z7l01SN9r0wp?=
 =?us-ascii?Q?adNpFyStj+27RLOenjzPf0N6w2R98T56t3ZLma4oEHUHSHn/CkflisJL/yza?=
 =?us-ascii?Q?6FOV3CiuyZApYn1inYzJbVwFameen9PtD/7LDHCqA8YrTxblcRse63jo9sjN?=
 =?us-ascii?Q?TqdtAkwwHBYF8zJGYaFhe10iAQFK9VCMaiQoW3IiAVvNRJrtieYNv5Yn+Bsp?=
 =?us-ascii?Q?XX3D3WtZMTSL59m1szRE6oq4oX2AAJCkyPbTFLQvcZM1kMdmDsRPUrL40bH4?=
 =?us-ascii?Q?ckwIeMfGGrDR2vWAjwJ67/E/vMYqbWTtcnwZ64heB2ZdgiSm+eAOic5X346V?=
 =?us-ascii?Q?vT3tQpmSa0JhP94c5WASzCTmVPwddfJ2nciz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:53.0175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f5651e-9adb-4af4-436e-08ddad4c4a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 1de81a7541bf8..e293f71085e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,21 +1198,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

