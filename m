Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFBAC61DA3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 08:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C5B10E593;
	Fri, 24 Feb 2023 08:33:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBB110E0A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 08:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgm9k0fP46ZZQ8u2GcslA8xo5uwP2ALbRrvLAUtLSKGejEepUSRYfNEKXYjg0uNnnxcW+2kmBIM9FCvIe/MTSbl6sm7/hOsQpzJAYBAUHINSJnClyhzhK0zWhOMRWrj+zPb4c7WE1R0w27YvEoRio9dAW0mnF4EtwRYtieV2GJY6V3qiC7sfexgxZPXXEXWT0U5nGIJOiUMyhH3MpP3vCIlgM7+G/yWwZjdLaeXl+lbdR5x2Wy11O6W+uR4/WjqTnamW8tV6tZFyOpqt+PNboGn0K4O/b7m1rN5A9Aw05mbK0UwrOo4Hq8Tdz40fOTnJj/Pp4RODOXqbFXBSNWCraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hlq1nch6OXIUr4plOetQ8meMuPGCtJl/8z6rm26IrA=;
 b=LWlDiFmddFm1Tdkr0bS2r58mKT3g72SWuzApi/PAZ95sZ3NBywVy71Uc4VRAMSM78q07wR2mAZtZXclAp9gDa5j9mwi42x6M+JUy68VXCWTJGeMbEcxfRuuWJvMTr0I8XqzH1mUdFygs2W3DOK9UWv07Wnv3x1SiFJQoKRSubR5r1MN0pF0M/bVrPlAuSEzLuh/5JIy2/RMRwlrLk0VR8if20RFlJLbrOsr7vZha+58BTZcUyvRbOGC9CIFUNDtrd818m2JC+MExOVHl1HY8xDtu86I7UBkQVsJIAkf5lTO6nxtcKXfxvTuHFxKVhu9cNRgh/sGybTwupiHguIw3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hlq1nch6OXIUr4plOetQ8meMuPGCtJl/8z6rm26IrA=;
 b=Vw1WJ2zydJsgGT0KGeDIPgaSIHsgLv/6hXags7O9dXSui97XVBJQSQu2rTFIYBPz6D41r0MYhHzNBEBXx6L2j3iglrwm/ms7jGXzqsREREFzkRvGomMWUZZIJZ3JlAhaeb6vIYZxTSyFdJ5/ABdwlOuLnRMZH/+F8xkjROJFdqw=
Received: from BN0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:408:e5::33)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 08:32:55 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::9e) by BN0PR02CA0058.outlook.office365.com
 (2603:10b6:408:e5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 08:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 08:32:54 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Feb 2023 02:32:52 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <Candice.Li@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/pm: add capped/uncapped power profile modes
Date: Fri, 24 Feb 2023 16:32:33 +0800
Message-ID: <20230224083235.3448477-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224083235.3448477-1-perry.yuan@amd.com>
References: <20230224083235.3448477-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fb357e-6c6b-4b49-53a3-08db1641b9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZ0OLCuz5CnwAvEOBcMpswwCMfhcV/l0gCcWB4TeKjipFdefuAPBi9GEc5wLOVjrJVP43lcUEzGJYD4gDpSOUGsZIrehugHhPp2zMiG2raa593qI4mREPCdmyYt358w/2lXRHntfGSavdmrue020a/urbcPf3acBWTDI42nm4EuQg1DQlCL50z4IOurre8Y971CbQT/JQwISBhy0jYY3VA3MDRgzh2U5f7X7YL8cT/N3bYHhleiZn2nIToywzB61pYoEGu4sBGI+Gno9UjC3Ra7PdDBh8jPf6lHnjHqcqGrrLqvGgVKsjm2ZZBH4vOOUVMtzQ/Yv4J1TGFBVpBGb3ilt7ZgPYQ5HRLm+/2b/46gaOaafa7oSB4wMZ7s4SectZtDmFwWWMmkXfj29sSqm0hookRe2+POtnFvM3DLhx1xivjWe0/6lmZPZa+wE1igz1n/v5ZbROeJ4rRFcpdg6JOhiywy7ACET3a3BONHtJL4MsldYNNXUDHgQKeXfZgMx5UAKQXCHUaS/Qvht49g33gHOI6Q6b0V/dsUkaV2PcwXVeLqukMM9RF20tF4dupiH2UTguNlAAP2kyIFqqR+0Ddy7Nd5DJi7WeeSK7Vxxu0bSuSHWyeHD92t0x85cwOlmo/EiN8lHUNggvjKXMK2RdFBkrh+JbmpxHCDw1XNFC2Zb4kz+E7s1NU2wtWJo25A8n6xTQ0eZxjEkIVNSdH5cgJhKosPqHvmuBRTZF532HV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(36756003)(82740400003)(316002)(81166007)(336012)(6666004)(7696005)(41300700001)(2616005)(426003)(70206006)(36860700001)(47076005)(40480700001)(70586007)(1076003)(40460700003)(5660300002)(82310400005)(44832011)(16526019)(478600001)(83380400001)(110136005)(356005)(4326008)(54906003)(26005)(8936002)(186003)(8676002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:32:54.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fb357e-6c6b-4b49-53a3-08db1641b9e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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
Cc: Shimmer.Huang@amd.com, Kun.Liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Capped and uncapped workload types switching are supported on Vangogh,
User can switch the power profile and check current type with below commands.

1) switch to capped mode:
`# echo 8 > /sys/class/drm/card0/device/pp_power_profile_mode`

2) switch to uncapped mode:
`# echo 9 > /sys/class/drm/card0/device/pp_power_profile_mode`

3) check current mode:
$ cat /sys/class/drm/card0/device/pp_power_profile_mode
 1 3D_FULL_SCREEN
 3          VIDEO
 4             VR
 5        COMPUTE
 6         CUSTOM
 8         CAPPED
 9       UNCAPPED*

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f3d64c78feaa..faa2e1dd6d2d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -160,6 +160,8 @@ enum PP_SMC_POWER_PROFILE {
 	PP_SMC_POWER_PROFILE_COMPUTE      = 0x5,
 	PP_SMC_POWER_PROFILE_CUSTOM       = 0x6,
 	PP_SMC_POWER_PROFILE_WINDOW3D     = 0x7,
+	PP_SMC_POWER_PROFILE_CAPPED	  = 0x8,
+	PP_SMC_POWER_PROFILE_UNCAPPED	  = 0x9,
 	PP_SMC_POWER_PROFILE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 236657eece47..c73b4cf017f0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -91,6 +91,8 @@ const char * const amdgpu_pp_profile_name[] = {
 	"COMPUTE",
 	"CUSTOM",
 	"WINDOW_3D",
+	"CAPPED",
+	"UNCAPPED",
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 768b6e7dbd77..81c675e4a1a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -472,13 +472,13 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return mapping.map_to;
 
 	case CMN2ASIC_MAPPING_WORKLOAD:
-		if (index > PP_SMC_POWER_PROFILE_WINDOW3D ||
+		if (index >= PP_SMC_POWER_PROFILE_COUNT ||
 		    !smu->workload_map)
 			return -EINVAL;
 
 		mapping = smu->workload_map[index];
 		if (!mapping.valid_mapping)
-			return -EINVAL;
+			return -ENOTSUPP;
 
 		return mapping.map_to;
 
-- 
2.34.1

