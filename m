Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3827C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9140310E5F6;
	Thu, 15 Feb 2024 20:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaGCjx/F";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3260510E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6fI9/DCdnIXi8sRGaWzoaW4P4GfT6PM0Aeq/Hbav447O1J/rgp1qBLkyKf/HUx9LLiQd/zK+9forU2RszAm0oo+rFvgyc5aE+zgvotjh1tz9+XE95Yozlfk18SODD2k5P4jpeowTop/hKpBtul9dDcnABb4J3nRPWRwy4qgbGr5zeuAZ/cqBanzXyNIRFYo7GNn+3mJVa000ACfK9pTUs6ct8MmfygoEBFUIlcy4LIFf6lJ1tG9hRhf5MirqZAursSEZRDMD7AS8Gq9XcOnDMjCYEfp///LrqImyGSD+A+W+2GAOl+uWfPke505IdHTYRRYxmeBpiFjsYtCmlXQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLQqPHbh8AfwGNnsRx1TOXPnl5rvRtOWKdljbhBWJ6A=;
 b=JXCCVX1EkXWpMN4fa5odcpGUjdSn2D69PEo2+h9dEIsw0Gjp853hBAVKM8mDhQP8oaJINfXVRSl5GyORMuT3IIuQTG7Ju8/4Nxo+p6qXTLT1zAktqkFCtbbtj+s/OB7zubZK82DE9O6ZoPNVZZclCECG00C7bvgu5J9AyJ/ke5dYCWvu+3v8w5Fki2lpiQfli/zEqQy21PtWZx9b8oFJQiMbrbojyAl2yHdvM/TXz23Kik3Md48h7gg2SdiF/CBfbqiYLGEXiz0ojXreHHMRiouHTca10CcEgg12beHrm3ju65VuA8n9CtaABwRyCAKkurCRaMRFzrgt+8bOanD/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLQqPHbh8AfwGNnsRx1TOXPnl5rvRtOWKdljbhBWJ6A=;
 b=UaGCjx/FIDC0giA5OLW60glqxKMc6w/zxF1NuevN4dJMD0MAup9Bldo8wYZ7JmpbY8CKF4RVfFKJxaVS1m57Q8VOW2pOOzZX/+ArOdGXZYfG2kc67+MO1Ymkex0/6CD8UlXb7RWr/3pfX3auDMOKrDwdnFSHC1yIW3HpIfnJioE=
Received: from DS7PR06CA0018.namprd06.prod.outlook.com (2603:10b6:8:2a::9) by
 CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Thu, 15 Feb 2024 20:40:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b1) by DS7PR06CA0018.outlook.office365.com
 (2603:10b6:8:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: initialize gfx11.5.1
Date: Thu, 15 Feb 2024 15:39:51 -0500
Message-ID: <20240215203955.415314-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH2PR12MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: fba69f40-8cce-445d-8623-08dc2e665496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aN1MqRbZr0NN9bBC/I2iOT5uOvByIgXPZcXqN6K3imBe88jz3sd5IC3tQbUHus/4n1dG/fo/HqxdZ0felP8hXVYROOGTDj7Rtqdp/Q78M44u1IbZUP0L73QdrvdZeL7Ktowaga9LItayLLQMZrMTQMa/7P7wFVVWKlVgfv+XwmTMfG/3LMDLxEfN81Pfc++yxfPU0gJKbsHAR6tLAHwQJCiW2mel7WOurJn5CN8LkIL4UdfYDnJR5kyPq52jEm2YkVwg9JYMQsETa/mpg/MCoiGk0oIv/SVWdxys5kFL0SnqamJ20PXKNeVzprqi9Nhl8UVs4J5E9DV40nOanClQ/cDmawBzTwP8V0pPbdiBW89bsO1uBDCc2SX7FfM1GYwyBVkEIo9mAxd4UtV1wlGLLMz45Ud2sXdE2aAduGPxNB5jx+aij9G8F2K2dc7P0F5KLfZdS/0PIpPT1ee1U1DX49EeeuBI4z0W/KSjUpwzXbmHAQSHmfzVNVzi4nh79C+Sae2dgo7j/NyoM2WNo6XjGN+hyUDbVUoTg+8RkMCXAMBZ+GgMJglXhuy2l6s8Uen6ecyC/dye9RHzaxZ2G07hHDHDM8ytWTUTHItYVZSdTFi4f3bMHRg6Q31seAaogZFPgGmwNBGHp3/rC4ivczPXjVErK8E3Qm+U1m6yWF5wAvc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(36860700004)(1800799012)(46966006)(40470700004)(82740400003)(356005)(81166007)(2906002)(5660300002)(16526019)(4326008)(1076003)(336012)(2616005)(26005)(316002)(6666004)(70206006)(70586007)(8676002)(8936002)(54906003)(6916009)(478600001)(41300700001)(426003)(83380400001)(86362001)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:21.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba69f40-8cce-445d-8623-08dc2e665496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
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

From: Yifan Zhang <yifan1.zhang@amd.com>

Initalize gfx 11.5.0 and set gfx hw configuration.

v2: squash in CG, PG, GFXOFF fixes (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 83a03cd9d404..c0f6ce4322b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -911,6 +911,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1350,6 +1351,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -2592,7 +2594,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 			    IP_VERSION(11, 0, 1) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) ==
 			    IP_VERSION(11, 0, 4) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5086,6 +5089,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 4):
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 1):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5121,6 +5125,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5152,6 +5157,7 @@ static int gfx_v11_0_set_clockgating_state(void *handle,
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
-- 
2.42.0

