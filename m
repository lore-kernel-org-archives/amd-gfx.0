Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A1C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 04:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4D810E900;
	Thu,  9 Feb 2023 04:46:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE7510E900
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 04:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq4ie+fJ+aeOsFMlfUJ4dh0dAYtrawtNDuD0wj5XEtSGQFHMj7HCjCVHQovVxhx1oN/V5SztDWspfOxYPtGZYpm742asUAPW09HZrzMGNAxWwiVyYQywcFX+xnjxOShGIZ8F6GiAp4hLozRLi/OJb6RjDWtpLQ4b4JKr0+q9xfmLcPWZN4JhGupiqNcClfXCFGvQGB/6Pkq6YodCGP++bEgDi2GttxKim7Ye4fKjvWM5uEa9rM9dy50P1A75tM/vVKvhfKurGyM4kE6SGGaizT6H8ai9mhUF7JF/6X6dZKPO2IwT3IV3qPDm3en2sgwzHUD3DpgU7Rl2myAiYKRxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X2JyNi6q/oquu8MWijTWZ5qZHueZM6gydwMJVeXUCs=;
 b=bgTFg78A7/bfLSltQqFhvBJlQlPvOodgbdT8tGuPeSwhAKLhnvUwKzN5PMB3otYAoRhTOXU2x/5mizxcgSuN9Am0wh5QSnO6J3B9l+bfpE38tipruVW3Yos3NrZJsVSg8vfBwJRPwHCVbScqpPeZRuQLB5tzDOyQ/92CP2S2u1oabnhhHQWEZNzo8omZYRXw529iX01SRGOiuyIc3fjpOKXtOPTmFIlyg9+kF8GMJM0+vqobJzpgwamXQx4emDVgk4EEkx4UPZOE+D7kogfFLoLM4eFmq5V5q5fg/5GYRJWi59+UlVG7Uwlf/FcFlUX8qlXNZC8SiN6GQAgFwZ35Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2JyNi6q/oquu8MWijTWZ5qZHueZM6gydwMJVeXUCs=;
 b=Ym3rZv2bHzzCfdtV+V592BJUw1kh6RE3tBI8UPq/B1jTTRzlFbPhYnZodaf6oWHQiJBXR86LbNvq75bkAVuL9IOUTNO/ALAiP2jx3zFlaG7g2WKcEdSwKDwPxBjgFMSyE34Nhmf4ed2PtGeHK09SX0xzMuBHZFMBHoFvPn7PRrQ=
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 04:46:37 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::cb) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 04:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 04:46:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 22:46:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Date: Wed, 8 Feb 2023 23:46:16 -0500
Message-ID: <20230209044616.560657-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209044616.560657-1-alexander.deucher@amd.com>
References: <20230209044616.560657-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9827432d-36ab-4545-f22d-08db0a58a0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qM1VKK3Dpfw1SAcNYkgzERz5WfBVmRolxtW8E1YjLS3bNfLbm/gipxhNMowzxrikkla8Z4wfo36IYjvWmrSq3Y3etGfjqIVbhsBRy1YfP6sk7IuIcj1cSYXHFQuoxhurmXaN2kaajAy+TmMR6EodFEbtIRdkc/sxgYu7V24dFWyeg7PGcMJS+EA1lmJ78uJbNPaiRziaSJD0R7P8MzBAYEZJrRs+ua8GtQk+HMB/H+UwD40o/F+2qrLWhA/PSEUoD52NRvcOnepOS/2deDDbD+DRKaxLxEXQjrKyt5xv7SSI+t17KDiaBufAGyq0AVXE1GyBLC5ss0BnLap4dPTQj/z4VJ2pW5B5PTMWRBb/5KaCCPME2PzzNqLnSaGku8ntVR+ApAJDEM85GyZY8DjuJovHjN4VAeE4omAPLZvcpymDy2tI+qKEVLSSPdJmaj0XyJwCvgylAC4DQYvBgt6YZhZ18icIZe+FPW+3o0UeIgXNvbZzay5mn8yxcrgV7g+n6DKHNRdzjepRGAblCLKNLfifGOc31VEkjPaXmvvWTmo26RWWkxgC2A0sK42qqTXMCy638Gqj4eyQDj7QvNXUArzefSsuIO9GH8Gf8AcZxEELQsXx34jcDVGu0VuWJkAEMiIA/o033zWxYmxMgbpjqWdoXA8OoZi6Ego8WUnge4sNzgXJgD4RJ03T5mUBNTp+FWCnyvqusQf2ALAvtJoS/GEzSXTPlJLEY32ULY5y1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(2906002)(40480700001)(478600001)(36860700001)(7696005)(26005)(1076003)(336012)(2616005)(186003)(16526019)(83380400001)(6916009)(8676002)(47076005)(426003)(4326008)(41300700001)(70586007)(6666004)(40460700003)(70206006)(86362001)(5660300002)(8936002)(82740400003)(81166007)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:46:37.1022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9827432d-36ab-4545-f22d-08db0a58a0a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use fb_start/end for consistency with gmc code for non-
XGMI systems, they are equivalent to vram_start/end.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ba4a57d8e6f..bf06875e6a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 	/* AGP aperture is disabled */
 	if (agp_bot == agp_top) {
-		logical_addr_low  = adev->gmc.vram_start >> 18;
+		logical_addr_low = adev->gmc.fb_start >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
@@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 			 */
 			logical_addr_high = (adev->gmc.fb_end >> 18) + 0x1;
 		else
-			logical_addr_high = adev->gmc.vram_end >> 18;
+			logical_addr_high = adev->gmc.fb_end >> 18;
 	} else {
-		logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
+		logical_addr_low = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
 			 * Raven2 has a HW issue that it is unable to use the vram which
-- 
2.39.1

