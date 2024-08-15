Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC5C5320E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813B10E349;
	Thu, 15 Aug 2024 00:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJG/RY0y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D346210E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXMFZ/XE0ACHQb63ycxvg9TtF64UYqo6q0+5fpbY76EgkrtpXQ50HHFW3CZYlZA4yneWDBJjKqr+Q2Ow+v0eA9rpJyGjOUisnRiHC2IojdZna/TcQBk6XubSHsSSasgvsdNvFUiUY5ftorphxL3z0N8LHMSzi1p/ByA5Li07cEPdE2uI2CKueV6O57paDTycVrmmma4535j7RY7Fj3x7h/dwR4bUhEgqo+EApW6p9PwwIhXd3FV+JDGd7owiBS/q1TPT/TiIeU+W3/ZBaibQNMUDNkS+qVrPAqIWM6ACSbQzf/wVYczezxnrpWC3BueTQ3bjPF5eSTkBH72IJpI1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ypBvmHgnCWo07ZMu8ByKI9Wx7Bd59uQulw+iw3CW7s=;
 b=PhjnYgB/YaKF+sZCpA2Ba5pStJ55lqKvfW7Gn044ocHMZoxbroeqM5w9VPWnGNQwytxreGgUfxjemZ3RasgXd0XEbTdN6B4dYHXuI0vHB83wff8HsY/0qgYMtjNKfXEAV/m+o0N67IKfcG7jAuwMKgRYPpX93ZlPTRdXm/qxOuQpgfSleOfVL/TQgiPCUNJX042tVjIZ7wmID1zdmqxzqv40tglTt/8a4oWlcVVbJj1iRCFoOgFqFWHdXf1/veaj8dPJji5YffC/3ufzbZLLQJhoRuQSYSuFORgiSfeRPyHzLZxw3XbMt5/pfnUOqMgmUfB1f9/U3RBQoxyXNOsvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ypBvmHgnCWo07ZMu8ByKI9Wx7Bd59uQulw+iw3CW7s=;
 b=kJG/RY0y7zJ1vAmXPu0xilIiuE71KMqIIm/0BzZio8KBFFqXE5NeylxYSQd+6o0MWsvS4XyXXErQJlg87Xxj9r5/Hz6BiOHKLrr/aRHEU8GJA61d/IgdTBwdoqTs3hnyJ6kolzF7d4oyZRNzmScbiFCjZ72KdcDD7mMNMar0rkY=
Received: from MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 00:05:30 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::d5) by MN2PR04CA0005.outlook.office365.com
 (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 15/17] drm/amdgpu/gfx9: Apply Isolation Enforcement to GFX &
 Compute rings
Date: Wed, 14 Aug 2024 20:04:59 -0400
Message-ID: <20240815000501.1845226-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: d056eb91-daf5-43ec-ca18-08dcbcbdf943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnlxbDhpSFNBeW1mYXE3NTF1N3FoZExPZFlpVlNPSHVEUXVhenRLMmpNd2JF?=
 =?utf-8?B?QmxKUXgvYW5IUmJyOUE1QnBVWitGaDArTkxSU3ZwNC93R2lVbDZnUkRmRWRQ?=
 =?utf-8?B?a25rWURrWk1jUTEvR0pNSnltU2JaN0pxY1EyazUxWUszR1hhVG44Y1c0bGtM?=
 =?utf-8?B?OUIyTVJCaERpWDduUVhzMkVBWERISkhETVUwS3hUbmIwRUhLT3IzUENkSEVU?=
 =?utf-8?B?UWRXcHhYajVaOTRFck9kVWdLeDB1dnBqRUc0Q2lkUGcrK0M1SFNjcFdWV0tY?=
 =?utf-8?B?T25YK1NNa1d1Y3FZcTB2Rzh2VDFVSTlzM1dOdThHYTlXS0NiVXlUZ1lVWmxQ?=
 =?utf-8?B?VDBIWE0zVFV5dnhJbUNBRnovTktJeWZKUlVtUFQxQ1NoM082aHBlM0d5UUNI?=
 =?utf-8?B?a0Q1MXNRODZQQ09VeksxcjBEWkxRaGErOU5LdW8zZFVuQVByMk5aWEVyVnJy?=
 =?utf-8?B?WVV0T0wvbWVHaHU5NW5SZW9ycG44Wk5YdDRBR3RRS2kzWElZbEI0MUJuMmsx?=
 =?utf-8?B?SXRNaVJBVWpvbjRlcjhPN1ltRUtsc3NhQzV0dC9ydERWVzVXS05jL0JnUkZI?=
 =?utf-8?B?ZStpMmtTUWVhay90NjdFUUFpc0k5OXNhSGNpSWk2ejAzWVJjN0VuT2dBRWJ5?=
 =?utf-8?B?UFdkcjI0Tk01Y1FtVS9JN1kybHNEWFhHdjVGVXRwTXdhY0twNGtDcVB6UDEr?=
 =?utf-8?B?VFhiMXN5ZGQ0Y1hOS2k2bkh5ejVzeTV2OFdOeEhFQlZQV252UFhUbWd1UlBh?=
 =?utf-8?B?ZFhrMlJQdWttVmdvSzRoWmtKajQrR1NwdVBjZnRaRklkT0tMbGQ2ZE9Yai9R?=
 =?utf-8?B?VTE2T3I2c0VKa1ZPbW9EU3FzNytIdS90eFNUWG9BbExPemVtSVRqUnNkS0Rs?=
 =?utf-8?B?STQ1MC8yQmhiS2J3VkJ3WlV6QUpudDNUTTF2OVpSbUhtbWJDem55OTdzNzd0?=
 =?utf-8?B?c1AvSEZpUFIzTzFGK28vMzA3cExKVkp5dXZqalozWitTZC80MUVOWXkydGls?=
 =?utf-8?B?V0M0VDBiZWFrMEJXRlJHYlV5VHlZSjlhVHhCRjV1cm01blV3bXJEQVpKYTJw?=
 =?utf-8?B?RTB4VTMxUnhzRGk2NEpMb0VoK0NCajlVTm1XeFRpWVBqdkZNVjMvdlZGVzhQ?=
 =?utf-8?B?MHkyNnpCVHN5WERBTXRZMnRJajB1cEk1L24xdkl0a3NvWG9yanBCQitZazA0?=
 =?utf-8?B?SWZqY1NpU0pXRXQ2Vkc3UENmaTBjRWJGdVNKSFVDZ1gwKzI0QkxJQmFCZjla?=
 =?utf-8?B?SkRTRmFxSkw3V09lWTA1MG5zUWFoK01OemE5YjFaRGdscTB3Y2Npb2NyM1ZI?=
 =?utf-8?B?UDlncUJocWdxY2dGMm1HMnRoRVplVWdCeG1XUVdHejRNb1BqU2ZyWVU1VTU2?=
 =?utf-8?B?QVg2WXg3MUtadXRBeGJUOGJ3NFBoM0dLKytrVnpxb0dWaGRaZlFXdEFnb2p6?=
 =?utf-8?B?UERKYndPOEUvdTEyQ3QxZm9WejlMaXJPR00waVg5VHZzbVFRamFOTlA4Vk1D?=
 =?utf-8?B?N0tMc3VqQThqVmxYNDRoOTFZYnN1Sk9kVSs5d2QyRlJEazlLSzlzVXBnQzRT?=
 =?utf-8?B?TUc0N21RN2J3UzZoaUVYa1ZEcnZtMjZJTEZ1ejMwN2xXL0xiMmxJeVkwZ0RZ?=
 =?utf-8?B?dklwQ1ltSzBQcys0SngyZlhCa1ZDQnl6Sk5HTE43V2dWdWFYa001aXdzLzlJ?=
 =?utf-8?B?S085UDhkK1g5VUFBUUdhOHV3dTliUEhvVzF6TnpaS04vRWhHSXp5VUNxb0ls?=
 =?utf-8?B?UDQ3VTdUY1AxWHR1N0kzT2ExakFNMTJoaUlFeUNoRkdEYm5WdWluVUE4VjFY?=
 =?utf-8?B?VXQyR1o3VFNCaDlaa3hRUGRPT0V3eTRBVHcxdytpZThtQ1BxbXUzNm8xUmZG?=
 =?utf-8?B?cld4SXcwUmVwQjg0S2ZRVXNNUWZxOEcwdjZETG1EbndFTXQ0WHhiMm9SaXpF?=
 =?utf-8?Q?iGe1tnJKCpBpBj8V3h8gJ0Ld2T9P8nWe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:29.5953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d056eb91-daf5-43ec-ca18-08dcbcbdf943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit applies isolation enforcement to the GFX and Compute rings
in the gfx_v9_0 module.

The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
`amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
called when a ring begins and ends its use, respectively.

`amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
begins its use. This function cancels any scheduled
`enforce_isolation_work` and, if necessary, signals the Kernel Fusion
Driver (KFD) to stop the runqueue.

`amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
its use. This function schedules `enforce_isolation_work` to be run
after a delay.

These functions are part of the Enforce Isolation Handler, which
enforces shader isolation on AMD GPUs to prevent data leakage between
different processes.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3045b8b0796d..21089aadbb7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7470,6 +7470,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
@@ -7528,6 +7530,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.patch_de = gfx_v9_0_ring_patch_de_meta,
 	.patch_ce = gfx_v9_0_ring_patch_ce_meta,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
@@ -7569,6 +7573,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.46.0

