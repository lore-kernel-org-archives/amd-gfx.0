Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3CCC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BAA112CB2;
	Mon, 29 Apr 2024 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9lQ9Vv5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7AF10E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNbjmEgwhJfkADjv4UlJwCgPF5JYBkVHWkiyJIir7ZQkz7mo73e6hRQrqJTf+hp2YKUgvlPOGoQrDIUwarNJkN1J3/ehCgBjcSEDJ3RljOG3qqXNIXGjYvbJoJMkGco0WAofmdADRrOnJNDDD+fjJ8BUC8ilSLAQrBnEUqvzXGF4zTvaM5zeb1g0M9QoyJp/wmNvNNLsIgGcOfqB5hWUbZP6WGsDmhZmZep1tg3ZG9rYhJalH/RCZ3spcDkG1uMj8jE1xG9DySrRuJWvcG+CiQkfrVIHL1jJ2OjvPVXy/b8w+jqhbdrMURcH64AgWDK7d2BnCRVGGKbyTrY9TR20vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7ABDCYVQxDnJEatux25/smAGKRKLRN0U94uquUgL90=;
 b=hc9K2q8d424xmanUYABG5LCWTO8mhKJ/Woz9mi49pTb6gzcO5WR2bzRofH+TtPBvw5mc2QwtnWmhHZ0ERtd41Sr0DuZTdax4kw7W9jp6FVzQZL210P8EtO0VHBTmqoxVWrje9kShWaLO47nuSHF0vdGPks9EyldhBTCoGc93j1WNS2Z7Qd3t7OPeME+MyHkc2I0Yf+v6gn7HbYp5if2u3EhEl+QDrtWzUXt0ePhdu//GioUuV+/rkf05op2RfiIoE+B2430PQE4QjG2DLm7kLTEVsuejVb79ib0rAeAlI/yL02f84lxD8LEKjdTb3RnoDUifZOlpsxIV+hNCF0CFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7ABDCYVQxDnJEatux25/smAGKRKLRN0U94uquUgL90=;
 b=O9lQ9Vv5HwVRyWTOePZKysdtzMQL95re8tejPyXXdt38+FrlvTw8CFbiphTdHcsWmJpTk0rFFp0BdqbCF4aiZlwuj2r6dXZ9OhmgpbbzpVhJFmaxVQwmkCotkUoPp1JdzeV7iJbfdg8FTsCIYuxbqddjOzfJi5J216Y3XUTVA8A=
Received: from BY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:a03:1f4::43)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Mon, 29 Apr
 2024 14:34:20 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1e) by BY5PR20CA0030.outlook.office365.com
 (2603:10b6:a03:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 17/31] drm/amdgpu: skip imu related function if dpm=0
Date: Mon, 29 Apr 2024 10:33:25 -0400
Message-ID: <20240429143339.3450256-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: e797e0a5-278d-49cf-ee3f-08dc68597454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?paZL7kdjs1BvhlaaB5szUMxOrlAewKzQ5AUHHgQbJu0D8GoJ9L4icJhgx929?=
 =?us-ascii?Q?PJ4OabKKdmLXMqj/4+cYVf6oXh3P0zI6rjaCfrLjawLSJKkWUnw10Isd+CTr?=
 =?us-ascii?Q?SImfnUvHyz6tzSjVV1zdMx/01kXInkLZFSBbAhqzBlwwmWAcNlfgPjkhj8sw?=
 =?us-ascii?Q?6kVLzGZ3G7QmCe0VDfHYr49dDQ89q/T3GLOJTFpRvpOiystsdHRGpGdG4/qj?=
 =?us-ascii?Q?2pcytMgPTL3y0Lc40TtXCflUhMV0SWOccMsoTff28EkfNWGD3h+LoRypLiLK?=
 =?us-ascii?Q?bVwjwRK5RUNAWaRuIcvOh5oo1Uca4kZmHuA6oF2h8nQhbk5UmldBlKHJI2Jm?=
 =?us-ascii?Q?6cgnCk0NEs/DBOh0PAu7mYP+I62QVKfFflGs4u0Cewmt1MiJ9gRPtT9bWATs?=
 =?us-ascii?Q?L1IKncY1BFYDMM1uAUGENyQJUJ40NOuF26OZB+xN4b+PtzrOibbKm0LPOZcR?=
 =?us-ascii?Q?pZ6sdDj2utEvgvFSpFu7ZA3DIGQnYim3o8wlHVP43+B6fhNJ0a/4aNdKQsee?=
 =?us-ascii?Q?8pUnddlnqHgu30RN25Hv0eL41Wvo/Z52QUwrxXX6EEj70MW3d/om6a1BDwB+?=
 =?us-ascii?Q?NOe7zoM9dAIwCI30G/hbpDiuZpnOGv6Wo52kuk4SR7yLCRQl4WiHI0F2V4n8?=
 =?us-ascii?Q?5+thNv6hL0nrek6DAlIvxeJVWtMil6PoGj1AWeAm0T3vQfb61KcYuMkSUfIW?=
 =?us-ascii?Q?ESfP1qJIVffwp2PRz1r03yt5d5j6i98o6r8r2WxdwnvrJe5Sv2zkHPtB4u9Z?=
 =?us-ascii?Q?2SKLKw3iPX6ApmI4Ij9ACekWmzr2wZyyl7OlytByLEdv6myjUk0G7B7z8GDb?=
 =?us-ascii?Q?9PdQZjRF7AD4/ao7ym26GPdewarFIVIqLa58FJBQWrL0u798FEawGH04iSN2?=
 =?us-ascii?Q?MuayHFvaCadzZn+2isFbYkfJKPuw9qFNip5I7i2d5wHUNM5U0QHNCWrSWqmI?=
 =?us-ascii?Q?X7dVctN7bIlYvgcyjhtHVAcuhaouU419m/NQ/zBDFScHIZJfRLf7WI6VZeUp?=
 =?us-ascii?Q?lGfd3W/+fm1rFS9Jbh3D5tYspRPl64ff3snG6haeteVzqbZF9h0lq/GIs8gQ?=
 =?us-ascii?Q?GPWitmJSNIRvFysgperoZtSG67Kv+e1zC4YBwqyk3LyUUStiPu+YK6WizT+X?=
 =?us-ascii?Q?nZ7r+M7qkEBtoCr8Vqe8hLFcQuDjTHxBUVgWdnp8WCo/K49tCmC/drk7TlJT?=
 =?us-ascii?Q?6sq9vxd61cQyo/zljcraHZd94k2Cft0m+8AXPvf1iI6o142jw9m3c70SaP64?=
 =?us-ascii?Q?xwzWgvnhRJS1krsSNZiMaHPYb83eEWf1oE5s3NvXIsuVt3Q9LMVNu5jnOUEE?=
 =?us-ascii?Q?+vTdRQDerAydAH2Hnctq/JdYWivtu8B62+RC2o2FGhiMMkUHYKymj/QlyjsC?=
 =?us-ascii?Q?SBri1k/Xc4qxMjMYOCS6KmHCTn7h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:19.1618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e797e0a5-278d-49cf-ee3f-08dc68597454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
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

From: Likun Gao <Likun.Gao@amd.com>

Only execute IMU related functions if dpm>0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1253053d10339..f3f8601d6e184 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1076,7 +1076,7 @@ static int gfx_v12_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
 
-	if (adev->gfx.imu.funcs) {
+	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
 		/* RLC autoload sequence 3: load IMU fw */
 		if (adev->gfx.imu.funcs->load_microcode)
 			adev->gfx.imu.funcs->load_microcode(adev);
@@ -1149,7 +1149,7 @@ static int gfx_v12_0_sw_init(void *handle)
 
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
-	if (adev->gfx.imu.funcs) {
+	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
 		if (adev->gfx.imu.funcs->init_microcode) {
 			r = adev->gfx.imu.funcs->init_microcode(adev);
 			if (r)
@@ -3215,7 +3215,7 @@ static int gfx_v12_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
-		if (adev->gfx.imu.funcs) {
+		if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
-- 
2.44.0

