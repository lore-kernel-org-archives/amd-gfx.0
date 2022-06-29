Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86ADC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 14:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F0910F1CD;
	Wed, 29 Jun 2022 14:16:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A8610F147
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 14:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVzHg90jhlZW3eR09WwfSDEAkaLMKSsBAb0fPLs+HLUfQ8E4hV/vYei8Y1nBuTFpt7Qbkztfj4IYNnBYAMpzNuyfKesa0ZWXEhQ2Cu2TciDEpo6TcANDzT7ox89rKJ6akE03dU5YYB3DGlm0yuNyDAy3wUbWIJplJTgundmgsCmSt82SOw+YDdrcX1C7LlYcXoQEt+bNdda2sdJEKj8vVYhyGNvXspXPE4lJp5borY7f92rbpqGD3zFXl+BkrxxiIy3CoYnZ8Aoe+JlEEFwRJE4wuDjmO5j1Hs3xA9NQy+2/YVSsluKkwlXU10+z+sPgAGu746G/p55SmiVf3cmPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/hWwjO5/y84EwvOtgmeoAXfRDCNb6AHI4q1zOx753s=;
 b=gSJaHttnvoXyrFP59XY+IKEBOxPmeW2npKKGh8nOyQ6BQ8R3gFk7A0O9nBMpgu2PYD37MjbwabJRfzmHRT0TAX8o9P1HIkil+GLvmrvaq+5lawgH5hBV/okzKqIXc0wX7BlZPlvL9PEeqtFzixYgvccG0pg2LGjgCGFTKpIDY+dC/0cIyzj8WwtZvUtvN3hmHarzoMVVW3VXSV/RSsHW5z6aiJ2Rqm5Lrki5BFw694HGK3cikGcsHmCc0BQPKRwshfVX34sIy6munNtB63uo/MTeXHUc9cYxFsPtnbuqzG7ToQ0PGVFZWUQ3fBQi1bIts7m4q3kvCprFxjm3UiS6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/hWwjO5/y84EwvOtgmeoAXfRDCNb6AHI4q1zOx753s=;
 b=dA88G6PVs6ebfxZa3yNsdXErEVltnCTJ61Pa24xSkSru+cCgpzNSVvLHK2QiLwz4eQbyewK/mhFEr0rmKF695ObCh2T4XXMAWMbv5JLIpWyT5M5NRQwFcnM7Q0OPTUoT3iAhJesQ4pXI8sMyYcPyRLVV6W4HS1/Rcl358iV0GvM=
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 14:16:13 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::2b) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Wed, 29 Jun 2022 14:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 14:16:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 09:15:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/display: disable prefer_shadow for generic fb
 helpers
Date: Wed, 29 Jun 2022 10:15:30 -0400
Message-ID: <20220629141530.2501360-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220629141530.2501360-1-alexander.deucher@amd.com>
References: <20220629141530.2501360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535b35e9-c73f-40af-6051-08da59d9ec54
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBNLCELc98lUY8fYiXuHGJW8zYjbYM6bEV2ospU/uA/7M05dLRBGEwl18k/hwq/aoWUeCZgzOkxPYAuPMz0tXRMc3rOEX971lOU7Yvov6zSuwnLukPoYXweG4JuN9hg9klJ967+SPbqsnychjH0vXkq2ptfvJX4OGwltJ63qfkDY+DXIq6h7DTj4bprU0QLgknnZwnqMTgz4SS0nRV+JQwIpTOt7KLV4MwF/zUcaN3Tm14s7PyDv5+WIC3q51+NovjArmrstQ+ibKpqxdltSWBF9L+rICpeqrFnRvqGCmwQepmsIMP0BshG+MazpzebDH+mzcRJtUS4Qq8oA4ZhZuebAbdBomREAXd3yF5GnMqIovRh1vEa0bDSk5eANSPrPZBXL6NGiFg6qkc+ajd3Ea4wmEyPnXae7V9V5TFUSDKrbVYFSowVQccRWvhQ+bLnVl+LNPojHZ7OP7NBlyKdy7InNnI0ByDE2ouwxeeLuCE+rtoP6VbTca9UEnUd5qM+XC+Tn0dnWCiCAma0xneZT8R/ZcEkeB2Z5/yOnP+ukFqbPvcMg8hCy+Ltkg+rsn5w9tB/LdEvgHH7kb3t7/0n19ZUnn0f/wV8FaPHScdNouhtURl+YG0WaMYcAA6AwPTUOQ0hnl0Xv7Ia1Sj7JeS2TG/jt0ZeJwdhZAjm3dxJgJLLm37izL56TmatKAP7Q5kT6Wenw8BwyELGPKbk9jSCktEwf2ngSb1t9LzNJpir53lgTHA+g2ckECCvYsrclW53oXhsahtOgp0dROvwCOQ8MbehuPfwJjKZ80ZFgJfrmdz9S+JGdVW3kY5RGf3UTeOZk2meeKfJFv6yM1qoF9zXISnPDZqelZRvU7YxLO74HvdNk8GCicqvt6zxEQWPHCeQLF/Yv1mWXvB7ygdI+ZqqSHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(40470700004)(40480700001)(36860700001)(82310400005)(83380400001)(36756003)(82740400003)(356005)(40460700003)(81166007)(86362001)(478600001)(70586007)(41300700001)(336012)(426003)(47076005)(2616005)(186003)(16526019)(966005)(7696005)(26005)(5660300002)(1076003)(8936002)(2906002)(316002)(6916009)(70206006)(4326008)(8676002)(6666004)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 14:16:13.3137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b35e9-c73f-40af-6051-08da59d9ec54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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

Seems to break hibernation.  Disable for now until we can root
cause it.

Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216119
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 576849e95296..108e8e8a1a36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -496,7 +496,8 @@ static int amdgpu_vkms_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = YRES_MAX;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 288fce7dc0ed..9c964cd3b5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2796,7 +2796,8 @@ static int dce_v10_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index cbe5250b31cb..e0ad9f27dc3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2914,7 +2914,8 @@ static int dce_v11_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 982855e6cf52..3caf6f386042 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2673,7 +2673,8 @@ static int dce_v6_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_width = 16384;
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 84440741c60b..7c75df5bffed 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2693,7 +2693,8 @@ static int dce_v8_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9195d6a8a51f..fb1e983e0549 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3818,7 +3818,8 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
+	/* disable prefer shadow for now due to hibernation issues */
+	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
 
-- 
2.35.3

