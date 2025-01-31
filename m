Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F2C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 02:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D01F10EA0B;
	Fri, 31 Jan 2025 02:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5TeP/H4I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14A010E9FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 02:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgtiUxtdnR+bKmxplzMRoLV+qzPA4lFzjdZiOaYCCkBFxo4acYxaJd9mF4ZeJCzhAevNvfc5F9hwNQvMBiiFpAvSAvGLo1BEHu+P7aCGS1C0+W8d+6npOcm1Z31NyBYJ7Yam0/WtEF/hyn4r9pBtzBk5KO1T2jPQ+2VHKAiYNvrsmewIv4zx3l/lc93nqO/g+Dy34Wknw5cdPcVpxyVCi8282lFcBEYLtGJnteue2iqUoJncniVDxqPd4qvY3qwn+es2+i46A3jSuX0RDRiseYdjGjPIItAr8vyKP6nhFbC2eg151b4iKepLPUBskPPjYyVvZXqnD6lG5EEhHD2BkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w/rvYS7aR5ImfM5LGrnqjKIM8rOWtG7wYo1GT+UG2Y=;
 b=JfP9FCzalu9Ilj3Y6xIKk3m07omeuGlcoBc5p+r1SK7zMXNlpWSJH5f3bZ/NswBABfqv8rYK00nMGCNkWTdIZaje1pJG/LS7HV3wAD1rY+YmuAJw5gI7EjdwGhd8JXJogDoaOoP6MiXGdgBWCJ+rEa1aicSOIhT10+hl63xv6/vNvBdOFJZZKpu0db6wirn+UXRXeFAfDD+7ioEPumsyw6WSkH0vd4ChNssqGy4y6nnKePr28siNEsx4vHyvDQoGR2oavdkirlxSRiGeHvD1FItGv5YfjwOdQzyygQhyVc1xfWfMWCo0hir99Lfn0swQQv+kMThetGeUCT9iyHMszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w/rvYS7aR5ImfM5LGrnqjKIM8rOWtG7wYo1GT+UG2Y=;
 b=5TeP/H4I17nbvdVTxapop5lJ0RlfgKHX/qM/we2szv3O9fS7wtJkwQ1RDfUyMSDv0R95JKuzmiocTU1UGiZi9sLHChGiurryqLzCcsV8R1wqz4KCVTYuIl3yrMFgykGqQbGq6GJeUrlmWd0xFV1xg6NWjvZ5YdfHh2y0dH3t8sE=
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 02:32:21 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::e8) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 02:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 02:32:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 20:32:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>, "Sergey
 Kovalenko" <seryoga.engineering@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx9: manually control gfxoff for CS on RV
Date: Thu, 30 Jan 2025 21:31:50 -0500
Message-ID: <20250131023152.1188183-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: f8926754-7ce6-407e-6a14-08dd419f7ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aElWSkVjQTY0UUg3SURmdEFBQkF0TE5xWFBGR3NLZldXRDJDQkZVNW5GRGJq?=
 =?utf-8?B?OUM3R1Y5ZXpuRnk3T1lTRHRiUUlxMnVxN0hXMit1YnMrQWlDaXhmcGVnZk5i?=
 =?utf-8?B?OUI3cFBJUzcrRGUzRUhNUlJGZ0ZtQmZDeTc2UHgvVlJyS3lGc08wOHlqWW8v?=
 =?utf-8?B?Rlg2c3dYeXRLSzkzc25CeTZUSFJ0cjMyYktacE9VL2MybVJsc21nNEhlOUdh?=
 =?utf-8?B?T25IbFNFNDlFQi8wd3U0QTJieWgxakN3WG5MTUFMdUlOR2RPdkNiRmJBWEpR?=
 =?utf-8?B?bWRXOHc4MWtFQkkzU0s1U1FFMCtNVzd1a24raXI1a2k5c0ZEekZGK0ZOMkIz?=
 =?utf-8?B?VWVEMTkrT2p0dzBqZ3BUQ3dKNnJkS0ZXNFg5ajl5SlF0ZkdlY2E1Tk5lN0pF?=
 =?utf-8?B?MnU2SUFoSjF6NkNISkd2cFV3NXp0T25ENEFFUitTaW5HaWp4TkczbFlWZEdK?=
 =?utf-8?B?djAyeHFzOVV6UXRaRzFmNS81bFdyUXZ4MzliRzZjYjIwT0I1Y1FKdWV4SGVk?=
 =?utf-8?B?QVBGRlNUcURqdlhYendiY09ZNUNKM0JQU1BhQjZMc0JGbVNjaGk5cnF1R2NX?=
 =?utf-8?B?NC9UZS9PdkJGazM4aUNuNy9iYTBjTTFadkQvc0pETjdXZklTelc2aGV5MHZO?=
 =?utf-8?B?U2Vtdm9HR1NjVFJYemd2czFnaGllZk16dFJBZjVlVC90WUpwTGlma1M2Ni9k?=
 =?utf-8?B?MzJSUUFlL25Oais2NlR5Ry9tTjQxbjM0V0tmV3hpQmc2TnY4cnBVYjBBZFVY?=
 =?utf-8?B?NXAzMnVDWmFSSU1kTWQzbFpOSnVhZ2R0d0NKSWhHTjdYK21idUEvbzIvcFV4?=
 =?utf-8?B?UGtKcWZ5SjUzeGxKZjVOQlJRWElLQ01iUnR4aVpOMGxab3BsUVoreDg0Ullp?=
 =?utf-8?B?UGt3bWNTZjJYNGZETUkzVmROVjFUcEFjMXc2TjNPTHorNmFKWkpqc1hUV3NC?=
 =?utf-8?B?N2dOdHZZUEJnSDVmZjJ6d3VEODRDbUpDOC8xTlgydnova1ZkTXgxcnhWcjdr?=
 =?utf-8?B?VHpUQmRXVUYyZGJwTWZCWkZCVUQ1MHB1UTZwaHBXSExRcm5PVUFlYm0xdTlx?=
 =?utf-8?B?eDk4QmZGTEZsVGVDak94TkVYUTlBTm5SZzZEZHlGUVYxK3hDVEVIN0VaMFpG?=
 =?utf-8?B?RWdPTkVralMrY0tmZS9EUEtXdTJpZHFmV3hkZXA3QittQmFmTVNlNERIUTlU?=
 =?utf-8?B?RDlWSWt2dHVFVWRHWEhiTERtMVpoQ0M1bSs5MEhQMmFxaHp1R0ZnM0FHQnQ5?=
 =?utf-8?B?NzdQNDQ3SzRIdE5sWnNqM3NxUUZ3d0xKTG5pTElrY2lEODRvczB6aEhiRENj?=
 =?utf-8?B?YTF1ci82NWw2RjdNWngvOXJOY2JwOGs2OEJZNWZXYmtuQnpiZzlGblpaRDV4?=
 =?utf-8?B?bEVIaldVREV2NGVadjNVdEJFZ1lqQjJTNE9pYVNML29nbVROYXBEVXZ3b0Jo?=
 =?utf-8?B?cGhsL3RCMFRvVUw3UHJFT1lEeS9UdnRueGptNVhGUUY1dnN2bk43OTVHTTh0?=
 =?utf-8?B?NVR1dUp0Tnh2V01Vck5XTmV6aXordkVSK2VJcGdsaGRpZjdkbCtoR0RCT2pE?=
 =?utf-8?B?RytxbXlCOVd3Q25UMzRXclRacWhMdTZRVExkUzRkcmRyQkJkWjBNT251Zisr?=
 =?utf-8?B?L0ExNFgvNXV0Y2JSYjZ5TWlQVlJEUW1aem1mKytiLzZFMzV1RGNyMkZ4UzMy?=
 =?utf-8?B?THhQb0VETGJMbk5BMkkzdXBDaGdJZngzOTVPb2R1OGs4Vk8vdWJxVXlPN05G?=
 =?utf-8?B?R3NsTlVzMmRqcnA3NWhxaGZ5TzBMcHZRdDdUcU5CV2k3RHlyVWRsSndFenZU?=
 =?utf-8?B?QW5CN2JPa28vMUQ2V3hTMzhYcEdRT0plTlRiditsUTdtWWRTajZuMWZFbTI2?=
 =?utf-8?B?OTBlSS9LY3IvbWFLVjhBTUpoUkNzblNqMThOUHpuWkZ1TEIxQUgyczVGcVRk?=
 =?utf-8?Q?HQoHM6iNQc0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 02:32:20.6268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8926754-7ce6-407e-6a14-08dd419f7ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

When mesa started using compute queues more often
we started seeing additional hangs with compute queues.
Disabling gfxoff seems to mitigate that.  Manually
control gfxoff and gfx pg with command submissions to avoid
any issues related to gfxoff.  KFD already does the same
thing for these chips.

v2: limit to compute
v3: limit to APUs
v4: limit to Raven/PCO
v5: only update the compute ring_funcs
v6: Disable GFX PG

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Suggested-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-January/119116.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 36 +++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 874acb8631c9e..058f55f1e3fcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7440,6 +7440,38 @@ static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ip_block *gfx_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_UNGATE);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ip_block *gfx_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_GATE);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7616,8 +7648,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v9_0_ring_begin_use_compute,
+	.end_use = gfx_v9_0_ring_end_use_compute,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.48.1

