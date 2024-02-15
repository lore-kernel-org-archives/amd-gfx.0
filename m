Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB27C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 21:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8860510E9BC;
	Thu, 15 Feb 2024 21:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rFOmPPH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54AB310E9BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 21:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDUGKT2u9UEbWBEq8ji+JrgcwYUSVtfhiWbQw3fQZ6nSkwptcOCpz1sVGBeEemGaHr1Rh0wy8/fm+glyckj0E1gloeEaRowzwPsnCVffjVMji93yyx03Ul6UnPcTljU2BbLXJfds/akHihOuhN2JhzgOZBWU+rVjK2Aczz8B3v1nI58asyDvB8SjafKcgXX3Z8x125+7lPNxCL84YKEHMiL3gkxd7+6Bz4sbEJnMCQcrO+Dm6H+T4DU2Ku/yLMnFycQ7+N9MhH/tVPXgZz2Qsi8ME90yMD9Be30Oe5eJb9K/2WcM7T39JrmugMTuTRDepaG2YMyO4DPVzLWAHiSxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU0g0Hmx6nI8vX0iAQ06RFo5SxQ6qhUrOJsq0NXZD9M=;
 b=oDEUD/oXDjOQIYtqSCVnFg1WwifrB52X4b4mk29LEYNWqj5ljG5xqGQvdPwXgNR5QLxScst48ZHVKCl0TbmKBUT/9Iy1IeM5r4ibCTgk6mk8hQBgHzzvBgHJ9B7VHg3NwHvKMbBTJkAoixcsjWSTWFNl9o1mhpAkLgKpTXj2wlLFtEooC4cN5DqxmRjhJFHyaYZEUWOUINUBU89HIl5bRwCW0PN3ru33hwxHu0vQisRhH36DLBFuY7aC+0VJK/DHPDpnSKu4w1xOUuUt6SCiM3hkGRZSXqGgo56U+3Gyp3n0OV6tw/cGp1LOLfVRb97Bi5gF938vGm1xCPVCfuOOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU0g0Hmx6nI8vX0iAQ06RFo5SxQ6qhUrOJsq0NXZD9M=;
 b=5rFOmPPH4OZFuIHAuor0ZuC3efEcNWbIIqgNZmfjJ8pfhZSUnWbsgmOQKaUBDnhH0v64evxhI7R9o0NqVgPZxsBTUb/rF8GrSo/NdtRrbxcGCpNVWlBGf9B2au+WI4mi61nhglCB39uh87GlEvNyAFn5hMMAMj2Go0nU3EeLm1M=
Received: from BL0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:91::26)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 21:49:08 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::de) by BL0PR05CA0016.outlook.office365.com
 (2603:10b6:208:91::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 21:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 21:49:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 15:49:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, coverity-bot
 <keescook+coverity-bot@chromium.org>
Subject: [PATCH] drm/amd: Change `jpeg_v4_0_5_start_dpg_mode()` to void
Date: Thu, 15 Feb 2024 15:48:47 -0600
Message-ID: <20240215214847.67525-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5077e1-6975-4abb-d667-08dc2e6fefd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFaBcYKj2HzgSTBuv1KObezgHR1GlYHfYCwokHVD7AnXAN9DmHwOLfD3q05Gfr2HljCCVbvuRF9wkJ5r3RoUSvZSaPNW/VngoVzQS4Nl6jQe3yyOP7d5H+PU49mJykQO7Q2sFG6pEctrLO/pJOLP7qvnoF3ismE+RVNWkQ8WOsq+xrtOZdKypw6RiEPqKP9dPH0JEEp3/NYt6VNyEaG7jaDoIfqAk3obyu5J7vtS7jZqeyBHQZhx/Wg+V/d3otRMsXQ/I/Jy37/BqPsP6wI1oeivVkZiEWguqTp1YPpkiEUrf2AEJD08ifm/bIy8Pi2q07Nd1SSjiFiA4ya7ZkdNEr0eRhxeivIcGUh53U50cTa8PRi2DmU91aN3Ha5xUtJ0fUm9A1gB89VZSbD1LHh0rTYokYkU9oy5XxgTAGPC2aTzaexophx+dQUYg9zBrCbP1O/1LngsSVsSEFey6TeI8hz/D4ERmVP8PL/DkG7eSGErrlZGJk+5yXp6R7oNPVDvk1sUqj8BPCabfkZshk116zxMRkI/o2LWwAj7rlpNue/3URaafAxQKYuiU68hVfC704CzB4QsX9zHdghww0tPiBF0c6Zb768uHsiKL997hKXHWsrRBf6rXXQgw8b175PzdL5Qv2yhTZYnnk5ECkMGmEtyimltBRve2wVfyEldfS4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(36860700004)(186009)(64100799003)(46966006)(40470700004)(83380400001)(356005)(81166007)(82740400003)(70586007)(70206006)(4326008)(8676002)(8936002)(2906002)(5660300002)(44832011)(336012)(2616005)(26005)(426003)(16526019)(41300700001)(316002)(54906003)(6666004)(1076003)(478600001)(7696005)(6916009)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:49:07.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5077e1-6975-4abb-d667-08dc2e6fefd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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

jpeg_v4_0_5_start_dpg_mode() always returns 0 and the return value
doesn't get used in the caller jpeg_v4_0_5_start(). Modify the
function to be void.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1583635 ("Code maintainability issues")
Fixes: 0a119d53f74a ("drm/amdgpu/jpeg: add support for jpeg DPG mode")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 3602738874ee..8d1754e35605 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -358,7 +358,7 @@ static int jpeg_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, in
  *
  * Start JPEG block with dpg mode
  */
-static int jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
 	struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
 	uint32_t reg_data = 0;
@@ -411,8 +411,6 @@ static int jpeg_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx,
 	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
 	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
 	ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
-
-	return 0;
 }
 
 /**
@@ -458,7 +456,7 @@ static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
 			VCN_JPEG_DB_CTRL__EN_MASK);
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
-			r = jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.indirect_sram);
+			jpeg_v4_0_5_start_dpg_mode(adev, i, adev->jpeg.indirect_sram);
 			continue;
 		}
 
-- 
2.34.1

