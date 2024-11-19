Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22F6D6C28C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 19:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C7110E35D;
	Tue, 19 Nov 2024 19:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lGi2df/j";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B937210E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 19:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkmc8X9HsJ66Gjm8qLNYWmARvvwZnTzz/lyhP6YoMQaqcu7O0+j3C21oVQh8VGLOOHsmhrEaDdfXTur3f3uaxOgOIVLfkPKle0iaaDhCeoEpjm9H2mlwuWNJtgw3Dqyj3I7mydskGhj9wQ345/QZ4h1ABgiLO/DrCR9Mi6FupoU8r2JkRFjwVPIADQYv/Lwr4SMq2DItA4xcN/ku+bzlZhA4d7gnGI+2jRQipfPG2W9hTvW5UsD9iqgKBRVjUwLmXREiqUOdiBj5As4wEykaZOsKTLGbJmCbzs3D/rryPZaERdEMEgDRkOzBdNMd1bBbET9auJ3ciJ5evGG8Aq1v2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mGXQzxyVm9M+zUKrIPB1j+OApz1xY/gYIiTUig8/do=;
 b=ba49FXGal0VBT4Eo18nM7pGMtKS5YFkboH8/p/Boi1e70fUYTE9T2bgDX0EAvY35vHFn+U9agL2EcE07naspwkLTzgpzvwNk661Th/ctSd6ntFrnng9YHCBXKUf+PuQdsm260Oogyw4VuxaYZOXXnnGmN3cVXGYSZcD9pJ6xgmo6o/FXY265g6zhkjb0xrLX6RcsQ+PBBkGLVnn4J3bM0e7/5PnOv0WQlT5Zj78l+1xJRJYBddeh+L35xZq6AbfDM5cofA6zPfKhdj1yssCbo1UDftvZPTu51iUeT7aMR72WCab6kI9FahXEqaIUHWkXEOZODid7rGabfMS5GmHusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mGXQzxyVm9M+zUKrIPB1j+OApz1xY/gYIiTUig8/do=;
 b=lGi2df/jkKubgnfGMSpovIWeSrKsg5Jv4oz2OSNHRrHVpBOZlloB10Hp7QdV9VciAhNacSyDy5xP5ylyQHlX9ckpVVwa0Zi3Nj0jjnspEg8Elv4nH/HhtjKST8PrZUzjX95tzHD3acihlT9ICgNCKjzXKTlUABFlb5neQlIji20=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:23:22 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::69) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 19:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 19:23:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 13:23:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Michel=20D=C3=A4nzer?=
 <michel@daenzer.net>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/gmc7: fix wait_for_idle callers
Date: Tue, 19 Nov 2024 14:23:04 -0500
Message-ID: <20241119192304.72501-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0bc405-0ca2-4095-8348-08dd08cfa09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE5USjkvMTNVKzFvTFVLQ0oydTNDRm5vV2JvV0k1VmJXZG9LWmNGdGNBcDFB?=
 =?utf-8?B?RG0yU29GdUVFZDVlYWI0YVgvV0pXTXRXSm8rZmNYNmpRek9XU1dmbWhYU0Jr?=
 =?utf-8?B?VHZlanlBdnplNzNqb3k5T0FTZTJnb0JmRmRnU1daNDR4WVJNRkREb2R4Qkdp?=
 =?utf-8?B?d1M5NXFLV1dlamo5YlpHa3N4WFJpWVhoRVRjMkxEcFM5WHJRdWRVdTFUc0d1?=
 =?utf-8?B?N1JzVWVHM0VZeEJVV0xybXRRaGxXZjBxaDAxQVJXcVc4WVN2QzQxMWFuOHAw?=
 =?utf-8?B?VXdpNElkdEIyZUFXM2xhZk95MXEvY3hqNndxbmoxWjhhWnFwTXJUM2pPc09h?=
 =?utf-8?B?N0cxVEZySmlCQTVmSWZsL1Z6TkQvOHFYVGR5eGQ4RFloWUk3VXZpdm04NnN6?=
 =?utf-8?B?U2NWT2pWVlVtNytOYlFWVmpDOTJGQUtjbGh4Qzc4cUsyREtjR2FXaDlwTlcr?=
 =?utf-8?B?ekxtV3RCTmt2WnJLVVliQlpkNHBKbXVQVkpTQ1pjeklsTXNFSCtsYk55cHlO?=
 =?utf-8?B?TEpCai9oNWVhcGozNXN5dGhsZXIzZE5Wb2dUd091RHlyMzBiMENXRkRVb1hU?=
 =?utf-8?B?RzdiV1RXYXh3TkN4alFlNzFPZ3F4SWh1SjNTSWFUZlhlNkhTMk5yTmtOQ0Zk?=
 =?utf-8?B?SnB0STFNbjlEaXpEVHQxaHo0SlFnK2VyOHBOdHNKdHc3cytvR0tRVWhDVzdi?=
 =?utf-8?B?WUYwWWd3OEVPRkw1MVFYTy94dlY5K3FqVmtPcE5VWHd5NzlaakY1eG52KzNQ?=
 =?utf-8?B?VXdEa2o1eURvOGt4ajh2dHM0dHdYcGM1cTVwWTZManlnZ29Na2NMOFNlV0JK?=
 =?utf-8?B?MnRCRmxVWTQzeGRPM1BCR2ZDYmpQdzBac3M3di9JcXQrL1ZTeS9hVHFCR2o2?=
 =?utf-8?B?bHdPZXRZZno3NE5VMFN2dmtyTHh4bGpQemhCMmc4MzNId1hoenZSb0tlc0xX?=
 =?utf-8?B?QmJ1ZDNVVWVKVUVvRzBDN3k2WU5WL0NUQmtWdmlGdjVNSk5SbFliWm5FVWJI?=
 =?utf-8?B?Rnd6dDU2dDZnb0VMN0x0TFp1MDZSd24yclpwSWdNMlBQYVNUeXNBT0xrN1E4?=
 =?utf-8?B?UVY3QzBWYzlYdlpVeWIxMWJiQks2ekZ0NFowTXN1Q2VqbzlFWHEzbyszZE1p?=
 =?utf-8?B?b0RxZmhvL0NCU0VoUktqa3RrV25MUGpBT2htb2EzRkp4dC81UlZyVnJUT3Ni?=
 =?utf-8?B?UEw0SWJpbWFoN1ZsN3VuZjZrTjNNVjFpTlBWMHpjWWRQREUrazJEaWtYRlZh?=
 =?utf-8?B?QmppYlQ5LzhxMUxMZGtUeWJzcEZrTHViVWVCYU1DVDZOVFdxTVNtWXlBRTd3?=
 =?utf-8?B?MXFaY2hQOUJQNVp0dXJMUE9MOXZuL08xZVRJd1h4YTNpelIvakNqcmZwaHpV?=
 =?utf-8?B?MXd4S3B0dXJTTWo1MFcwTnpRK2VIcTd2ci9pYTFCWGUxM1RUMmN6d3hmbEpX?=
 =?utf-8?B?bUo3UlF6VXd2T3RRUkdNbEY5ajNDK2lUNlBhRlFPTjBUa01peDRWbitvTVdQ?=
 =?utf-8?B?Y1BZZ1dDSFNsY3ZiRGxhVkpKWHE5VjE0U2xUdGtmNzhKaHFOV0JRNHlaa3Ji?=
 =?utf-8?B?U2hKRmVqWUk4cUFoK2hFcVRtREhHSkJBUklYdGh6Q3YzS2c5V29UR1BGUFFK?=
 =?utf-8?B?Zk5RSnE3ZUk5eWJFbUY4WTdWSnoxVnpXRkVRRm9lUVJuUjE4anVwWkhoSUI5?=
 =?utf-8?B?N2hNYXQwMTM4VGZXbUZBTk5TYTAzb3RIQXNsd1pmbVZFNko1Q01SWnhSSUJi?=
 =?utf-8?B?MVRmZmI5Y1c1MEJOc0ZKaU5oWnZSV1pkM1UyNWtZM2d6RUZXZndIYUxYNDJW?=
 =?utf-8?B?enh2Zzk1VVl3SlQ1emwyU0UwUVNtaW54WGUyUjh6Um9nRHlPQ2w0T29vMHhB?=
 =?utf-8?B?MHNNTmg3cGNjeC9KUVlOU25MZTJCVFBHUEVkR3daMmczTUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:23:20.0755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0bc405-0ca2-4095-8348-08dd08cfa09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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

The wait_for_idle signature was changed, but the callers
were not.

Reported-by: Michel Dänzer <michel@daenzer.net>
Fixes: 82ae6619a450 ("drm/amdgpu: update the handle ptr in wait_for_idle")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 8f6f2f067641..347bccd92696 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -87,9 +87,14 @@ static void gmc_v7_0_init_golden_registers(struct amdgpu_device *adev)
 
 static void gmc_v7_0_mc_stop(struct amdgpu_device *adev)
 {
+	struct amdgpu_ip_block *ip_block;
 	u32 blackout;
 
-	gmc_v7_0_wait_for_idle((void *)adev);
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
+	if (!ip_block)
+		return;
+
+	gmc_v7_0_wait_for_idle(ip_block);
 
 	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
 	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
@@ -251,9 +256,14 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
  */
 static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 {
+	struct amdgpu_ip_block *ip_block;
 	u32 tmp;
 	int i, j;
 
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
+	if (!ip_block)
+		return;
+
 	/* Initialize HDP */
 	for (i = 0, j = 0; i < 32; i++, j += 0x6) {
 		WREG32((0xb05 + j), 0x00000000);
@@ -264,7 +274,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v7_0_wait_for_idle((void *)adev))
+	if (gmc_v7_0_wait_for_idle(ip_block))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
@@ -288,7 +298,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
-	if (gmc_v7_0_wait_for_idle((void *)adev))
+	if (gmc_v7_0_wait_for_idle(ip_block))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
@@ -1183,7 +1193,7 @@ static int gmc_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	if (srbm_soft_reset) {
 		gmc_v7_0_mc_stop(adev);
-		if (gmc_v7_0_wait_for_idle((void *)adev))
+		if (gmc_v7_0_wait_for_idle(ip_block))
 			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
-- 
2.47.0

