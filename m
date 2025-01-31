Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50127C02193
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 18:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B0A10E42D;
	Fri, 31 Jan 2025 18:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZ60xwRd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DC410E42B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 18:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfN1rLn9byIdrtV2tJ3SyLfbWPpq+9Xm5awdHCb3nFBJrZqWibR6irYsKxC6iEoV2IpUTxbil6EO7mem8iLyl0Al9l05wo+5T7pjUBqtcBepJrV8y0SddYwQVCbhWGydueUdemo8di7mzNAS5EDPTa8VItNwGK7CLxWNaUTtFLS3OCmEsOX+O9TwfN89hWJDYdwIVH0CXQe22dVoWp7u1ZCtoCsxStYXoxTPjB+gZlJ2bCGrblZ10kfRyxYMCWFSHvRRbOLU7D61a6SU/uSXD8z/ryHIsFb1T+PY5wlHKLPV3jccnPb/JTrkbIhVV8uQ0AlzrjL2WBlUBYTRBfsdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB6v4pDshmD1UuOtYFTtKDbSJXiHzaKcdEf0yYFwxXk=;
 b=NzfTv0GiqICPggHVFyNElBBZmsK4VhDMTDBZPv8uOtVa6ok85AQoOqrd6H8YVwXNlMXTv2KmfdND1INNiPCIoqWSssbMBZG4Js5gQG9SBEcF2DGgr7jPK3NjBszE/mFrZJevYJqVMMRqfGZfMMxqMZy38cgXWSUuA6Bbwre7wIbEGpCnNeQarbREO4KFfGxQOy8ohfaHnxVVFxuwZ1tm1AWsIuZRyYS2kd6BtVgLO/MAWeKAFCliBz1ojF9KR+dlh9OHSe/529RYUnhl3Uqk14XkYixI7UkWSdlUAo+9U0nLiPVT16csTD/trYz3+ZB2XaInXBOIMk6wlI3baUOkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB6v4pDshmD1UuOtYFTtKDbSJXiHzaKcdEf0yYFwxXk=;
 b=oZ60xwRdtd6/LFIQYEcesaqPRCeQxAfL/p2c0mFNsAZl7kGQlw29LJAjJLSAtFfb1MxXgIw9pTlLkvK4RaCOb9G6bEvHCd0aYLVq0fJe2Iz1VLEcHtg6y80FGBpici+2hO2oWepSPkPTdr6pGV4bklvpTg5Eng95rnSkRAv47+Y=
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 18:59:20 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::b) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 31 Jan 2025 18:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 18:59:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 12:59:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>, "Sergey
 Kovalenko" <seryoga.engineering@gmail.com>
Subject: [PATCH 1/4] drm/amdgpu/gfx9: manually control gfxoff for CS on RV
Date: Fri, 31 Jan 2025 13:59:01 -0500
Message-ID: <20250131185905.2074016-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c87af1-a466-4258-7142-08dd42295e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzluaFRqWXlkR0Zxb09yS2psZnYxRHl2MUVZMlduOHk1N2hvSE4vKzFJYWkr?=
 =?utf-8?B?emkvbnRTcnZCV3g4OWhPcDNMcVFIK21VVTlnVkRmaUduQXBFbVdRY2FEeTdK?=
 =?utf-8?B?MTRpeGJKclBYME0wMFlWS2tVZ1NpUDNOMGhPSHVva1NpYkNzNlR5dmJiam9x?=
 =?utf-8?B?eGd6L1o1REp3amNPMVRlR1BBRVgvZXVYaVVSaGIyTkMzTDNGTHUyRDRyT2lr?=
 =?utf-8?B?d3VxQXZDSW9qSTVsVWtIY3ZvVTNjRGYybEtwdVZjeDhCQVhydFNpSGVtVk5F?=
 =?utf-8?B?bjBDdjBWNUpubG1HZ29UT0tQS2p1dGJEQnJqZENUVThtbm9HazNibjJWOVV4?=
 =?utf-8?B?Y21qWUd2bjdEcWoxT01KVlNpaXMxSEVlN1BBWlMzLzhaSGpDUkd5bUJYMmNZ?=
 =?utf-8?B?eisxcjNveWVxd0EyRXlydTNHT29nTm9GQ05iYm9JcWNTN3RoTWl4Z3dvQ1dM?=
 =?utf-8?B?dVRBVWJuTlVFZTAvYjIrdmJhUlROYkVIZUc4VldVUkwyRXdWTGRrTVVKUERK?=
 =?utf-8?B?dnRSMHdheVI5YkZjUVlMeXlTalZ3K2ZuRWpCK2J3RHdlVCszZXJRL09VRE1Y?=
 =?utf-8?B?bUt5a1VaaUdUOWpLVkFqVW8zbk1TK0t1V1pMTXpxZmVRTUtvMzJNbHY1a08x?=
 =?utf-8?B?YTNwdHJ4YkFpb2VTSUxOVFM5YmVvTU9SU0V1ck1kenBxaS9yallHajEybzRp?=
 =?utf-8?B?NkJKL2xyOEUrZFJ0bll0SVFZYTJaQmt4WlpjN1RJMUY1ZVFjMzN1NnBVVlpn?=
 =?utf-8?B?NUVldXNMa3hPL3lpTHBYNHNzakFGQWdrR3Qwd2U5dmNFL3RoL3poL1VRaFZ5?=
 =?utf-8?B?SjNwRFdGdldFbUtIOTBtU0R6b01xR1lobE9zbjlLMHNmakdVZEJpN1ZZMFRY?=
 =?utf-8?B?Ykg5RWpEeUd0K2RLREtDUmNoS1hDWHphUXlkNFh3YStUR0RleldRazR6Wkhw?=
 =?utf-8?B?LzRVWmpxenI1QkQwU3dPNElqMlZyQVU1ZERBWnRPUFpMWS81bmd6Q09kMzIy?=
 =?utf-8?B?NEpYSHZpS0gyeG1jK2VNN0RtZ2c3enVZUGtseUh4clNXTm9UZzJYQUUwcEZJ?=
 =?utf-8?B?dFEvd2xZN002RTIwcE8wNGRweDE5RmtodTRnWmVKeUk1aThoUnVIQjVNK1Bt?=
 =?utf-8?B?NHVXVGtJTFhLZlg2R0xTRlRuRzYybENGdHZaajJRUURXN0hxOS9nZFN4dytP?=
 =?utf-8?B?Tm85L3BlbmpIWFRMQ2ZZWTFKN0FhZEl2YmxpSisvd2IrZ1lEdkNta0ZqYjVX?=
 =?utf-8?B?TW9oQmp3Z2ZqWUhRZTBPMlh5SjVjMjlnMU03TTE0UERMRzF5dHNoL2JBdEk5?=
 =?utf-8?B?bU9sWExjV2JHREJNcDZSSWZ0K3RxYWxhWkplclA1Ynd6bzFUSjdwc1IxS0Iz?=
 =?utf-8?B?S0ZRZDBRSkpSRW92QXFKaWdFaFRaVUw4SWVpR2RlUkhNaGZnRm82YmMzazA4?=
 =?utf-8?B?WUVZbC9xdTQvMVBBM2I5UkNMcncxMmMvY0FPeEs0Uys5UkZheUhmZTRvVUJM?=
 =?utf-8?B?TVN2WnhJTmRwU0VSRTdXQ3p5YWZiNHJ5MjJDd1dSMUlGNitxWHd3OWJWaDBP?=
 =?utf-8?B?QU5oWjZMU0Q2NUNtdjZ0aTNtOCt1Qk9DU1ArenpBL3BBbVNTRk5aTUJDbzdD?=
 =?utf-8?B?Z1ZreXlOMzk2Q2pEQ0VEOHFUS2lQNlFUcmM4OXAxY1BxUC83M0tzWXZVRFhz?=
 =?utf-8?B?dXYxNjk5Y3daeWVJNTR3U3U5SUFkKzAwRHM2UVVISHdmdHM0dzY0UGpNY2dv?=
 =?utf-8?B?VHU3c2pGN2dtVU44NEZKVFF0UHRyRE1xOWNIUkY3Z2kxTndJUjhkbzVnZmtz?=
 =?utf-8?B?aVVCNkQvMHJTdGFFMUNoNlpxRG9QcThzeDlWa2NUUEVBQTdjSU1MSWFYbVlH?=
 =?utf-8?B?Z0p4c21ONHl2NzhGWWI0SWtQbVJTakpZQ3pSajNzOTdhYjlsaWN4M2ZicFBR?=
 =?utf-8?Q?HDpJysvpBJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 18:59:19.5842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c87af1-a466-4258-7142-08dd42295e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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
index 6aa713cfa2f3e..82e254c526705 100644
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

