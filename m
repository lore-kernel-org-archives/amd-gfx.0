Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CCAC02194
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC4110E1A1;
	Mon,  3 Feb 2025 21:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRC4s6H9";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DAA10E1A1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0MB+w3h06DO9BPZ3XDLruR3ycseH7hXFxmg6SdbV7AxrMw7NGkaWEkOIurfE6nNdve96SQfYKkf/4+L7DOplMQqFJktck7zTVPcJLMIfz3qxjnFiEiahQ4UnB7bVZtqX62222lLxSh8k1c22O1yKUzjxErSCUEXh9q4era6taqMPupaq93LNjnocLiwC40TRRZJDFvc3rR5DGvTNbRPoW3HMwDriqcEK97bN6+Z4PRXzk/wHcVsSC64waAviLxzVJnBVQffeINpACb01pM1H05PCHraR6zecM1QfSaFu8YjbzYvSlfafAYKbnuRTVNF+yrjQ0NGrdcHZbhV9kSM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiDAcHNCNLFl2XVX0hcpd+4CPvgm8OvibTw+yWDA5b4=;
 b=c7OkAnjWWXPTPHJwicKQziX0MLiLrpjD8pyNfr5iQy1crgGR7341/VYBtKU3N0PnGPGBQWiO4lbm8zxqOlPmfZKpF71igl9Rk6AZI9/0jElSW54iQEfugYxQae1507R85loFCQNit69kN67fRAbyuSgc4pSofpZtD9j1OUTlv7QC0YyKcUYiLn3ROQQ6fJC3c/oC6HAquJHJX2FyyjY8kHQZyEszQHle/2QuP2ye2RQOH7qrtnNRul//m7D01aqyhInnSuRpe0rqujY/KsoEUDvgzFBx3FWrIvyJMQy2QxGpZA8LCHjBdV9kvmq7pyG8PYMavxQmUuYw9YuBF4krag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiDAcHNCNLFl2XVX0hcpd+4CPvgm8OvibTw+yWDA5b4=;
 b=RRC4s6H9CTGCLVmCf995eQVdfjJo0Qx79BvhginhjIauVplkH5w1FmZdQETGqn9zm+7r7CJjrkkEXDsvutJm648U21wQB1Px+F9SvJwJXRTy59l+2w8+RUYakdzh4FA4eOC1a6tzi3414OCGvxO9CMcvAFnsCrRkYrN6wliBYvg=
Received: from MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:44:05 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::21) by MN2PR06CA0005.outlook.office365.com
 (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 3 Feb 2025 21:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>, "Sergey
 Kovalenko" <seryoga.engineering@gmail.com>
Subject: [PATCH 01/11] drm/amdgpu/gfx9: manually control gfxoff for CS on RV
Date: Mon, 3 Feb 2025 16:43:38 -0500
Message-ID: <20250203214349.1400867-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c62802-a320-4e29-5886-08dd449be13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdzWXppMWV4cFZQZzJmSUJoY3lETHpXUnBUdzNrNGxsSUJheURNdlFMNDdW?=
 =?utf-8?B?Nnc2eGhKS2tJVWQzcUNpWkV4UG4yS1V3dWhHMElZOUNzUERFUUI3aC9iazZZ?=
 =?utf-8?B?Vm5FVTdrcGxpTUFjaHFsVlVLbmhZT2VSOTBjUkE1ejRwT0pHTmxUZlprN3Rs?=
 =?utf-8?B?eFU1WlhNMC9MeUNwVDVabDRYZWNpakl4cnZNR2NJYW55WU9PUzVQcDQybytF?=
 =?utf-8?B?RVFtMmxycUgrYUdjTE0vTCtXcktWREVzbkdnQi9GZk1uS3lvMVQ0KyswalZM?=
 =?utf-8?B?Mk44bnNVM2tsU3hsNGF1Z3N6ODE4V1FNa3FtR2dKa291ZzdkaklxYVd0TjNX?=
 =?utf-8?B?WnZGRFFGZFQyVkE4cjk0dUZkUTNRd2hmSjBUZmRwNGdUZ1RFaGlJeWRCRWJm?=
 =?utf-8?B?b3A4MEJZL3NlSmhpQm9jd2dWMy9BbEZma05KeURpVnp6d1NaOFpnYXlFRCtr?=
 =?utf-8?B?S2RSTkhVK0JBSEh5YWtxanRLYVV2Tm5uNk1DQ3BWS0kvb0V1bHRQTkkxYlQz?=
 =?utf-8?B?Lzk3akMyVlR0WDFTMTB0OU5rWGFMajRwQmFNWkxkQUJwT3JLZ1FTdlpxdkhm?=
 =?utf-8?B?KzBicmorVEhtd2JENDFncUI4NjF4NnYzWTFoai9JNG9iWkpGbEV4QU5OUGNO?=
 =?utf-8?B?MFEyWjhqbkx0SUpnV0ppdERKUzRNL04vZ0Q4cDlnak9qc3E3V080aEZUVER6?=
 =?utf-8?B?d0pyUHpMakxpN3Bqc2Y2djV5bWE1UWprM3QyTVYvYWZIUkZWMnEvS3doVmQ3?=
 =?utf-8?B?c1lBSWlXaXhacml1UEs3MGIwZUZONjU0TTZWNEVUUDNycnpaSW1rRHIyaFVD?=
 =?utf-8?B?bXprY0wzSHhKU2dWY3REMEthbjU1enJZd0pOS2N1SVRiVjBIbUxyLzZsWUhQ?=
 =?utf-8?B?OGZKVWNKWXYva3lRZDF1UmtGWi9TTlRIcHpNZ2ZVOEJsMDgzTlU5cldtM0du?=
 =?utf-8?B?N0QxNHZmOGNVUE9GZTd4K1R4SWdIMk54YXFETzFPaHBNYjNnV0dLMHlYYlEx?=
 =?utf-8?B?MDNjbGRQY3BnaHp2U0lRNWhtWG1PYmZJTWRlVTFJM3MzUnZFOG41S1FZRlhZ?=
 =?utf-8?B?WFQ4SXZqSE1MWkVGZUwvSEwvSzdqVHc0NTQ5WFF5SVdIOGFsSlR1SXpCM3Nq?=
 =?utf-8?B?dkxMTi9RRjQvVUExSnFGek1oc2ZFRnBVS0d5NmZiRm5JWEpvbHZGRmZmRi9k?=
 =?utf-8?B?VDFjTXQzdjRGUXp5Z3FCS1lEcWgweFFmbjY3QmJvWW1pc3F1eXNhK05Nd1BD?=
 =?utf-8?B?eTRGTytjNDRKaCtTSEE5ZmZMZFlXNzhxYUw1TXo3TEl4Z282UGhwZWlyOGQ4?=
 =?utf-8?B?dFBWWjBxRXdFSDh1S3l0bXhhY3oyWHZwK2FlWGhtVE55ZCs4Y2lWdUVVbElX?=
 =?utf-8?B?M09XdDFZZ1l6K21FUDRVNzlFYXk3WGg5Nms1QTNqY0wyVnQxS3FJdFJuaGlR?=
 =?utf-8?B?UXhNbU9tRXZ3Q2VySWpzZ2V2UDh3ejdtNVEzS0FiRkcwWkxMWUpRWjhRUzlw?=
 =?utf-8?B?TjlWamRlcEc0TWMwZHZ1RlpSMitpK3FvbG5wdytVMWUvaEE2VmNSYWw3bEZR?=
 =?utf-8?B?QUNlSWlKK25rWCtQMW1CaEJzc1I2MmpmUmMvRlZlUk5COEh6d3FQN0l3ZEdj?=
 =?utf-8?B?Y1RTUTNRUmwyM1JYT21GRXFJMG5RWERwaDBvQzI5eVRoRVZNRjBCeDk3TUcz?=
 =?utf-8?B?UmRidTZkUy9DYUpGOE5lUzFncHNVS3BXbHR0UEhsRllITTJUbHFOSnJjM05r?=
 =?utf-8?B?TUNGNWt0YnVRS0I1ZEdkY0RSZC8wSTJRT1FFbS9WNVN2TEhpbElRSDRyOTV6?=
 =?utf-8?B?WTVWbkZwNjFrY3dLQUMzelpTRHBMM3pDNkhnbkVnVXRIVnBUWjBkUEJ2dkpV?=
 =?utf-8?B?bEdCRnQ4c0d1c3hBdHJCZWlEaUhGLzNJbDlzVzkzU0pHOWRXaHBmRW1jZmxP?=
 =?utf-8?Q?wQqQOuvxp8Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:04.5301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c62802-a320-4e29-5886-08dd449be13c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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
v7: adjust order

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Suggested-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-January/119116.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 36 +++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6aa713cfa2f3e..a666832ecefea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7443,6 +7443,38 @@ static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ip_block *gfx_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_UNGATE);
+}
+
+static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
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
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_GATE);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7619,8 +7651,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
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

