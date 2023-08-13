Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6DAC001E0
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Aug 2023 08:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1434F10E074;
	Sun, 13 Aug 2023 08:37:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B5F10E074
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Aug 2023 08:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkwFRZ8rYG5HxF1UL5HveeM3mW/xvBMvBpN/MwGBEJlbQU5DCrfyhbDdkpu0QPLYgQtGZ+BxV9QbCnjGeGdwijBiZullHE6tDMtLixzwyy+R5KJc/f1yrOmndCIyWJhjfom3ZPoOuR741rbyaDX3wpk0rAPFgRcLqJ52GNY3OQX8KdpBfKkUrw24v17BNDLfmn4ZWEBZ67PO0rbdV1qhDNKWPFK0HalWsUcfaX9NwzF6alIrdwHUNL0uS9DszuyYDAcM5NqUF1E3Yrvh7u4QSNHzZsJGQxNWEBthIBVTLIcNPUezanBu0gmbTFcb/ltaNhxV5gLhtpd5Ab+NSaFgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEupxu6i88mqjSxda08/x+SwhIOF6f6XpgNv46VbJHI=;
 b=lK433B5p/50r5lhGwN9VlidHM6+owtthx+syPzeUByxy1zTkom7yddMxQe5X8xHZ+NFPoxRsGQmtCM2pYwJWez3ye6sFvbvQxHZPPO4s2GEf0rdtDs8iibv4bDN+cTUHzljDqxRFndSkKrBaaGhPVU8sqq8QxfvWyc+GUx8hyMGYMCeTo7Gsa8bf70v6UWzvLYBwZr/bxVps5t3TIbV/E6XBNf6PA8qA6F1HxDrNIgqxAdwZTInJm0Yts7+Jq6VqphVKiXwQlqKdclhw7teOqSEKRhcI5E8aG/qSGRrAan8OjGE19bT7WP5om0MT+0YqtkqjSJaFpP6M7yBuHIjolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEupxu6i88mqjSxda08/x+SwhIOF6f6XpgNv46VbJHI=;
 b=cyHQAvwnk4No1jGN1MbqWl2WmAg+yAF7kFAfKMo5NW7jS5kyQ3TIHr3WqukMPEVk8z0SKf9wBa8pw3foK1ZYq5BkfP65xfjh9N9wBHL8OrVod9IWWFbutkkC8yJOOG0LVWFd/e7cMEKRQw2wf2EWkQnJGm41jT72kmKotxLYufU=
Received: from CYXPR02CA0091.namprd02.prod.outlook.com (2603:10b6:930:ce::6)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 08:37:15 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::bb) by CYXPR02CA0091.outlook.office365.com
 (2603:10b6:930:ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 08:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 08:37:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 13 Aug
 2023 03:37:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Fix unnecessary conversion to bool in
 'amdgpu_dm_setup_replay'
Date: Sun, 13 Aug 2023 14:06:16 +0530
Message-ID: <20230813083616.519118-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5984d0-5928-4bb4-6041-08db9bd87f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xd46pR9BCIomkcnPKEacolfE/Co9Vcxy/IciRvhf/1TDgvS67LyUDB5N1EVnmDitd6AvUfImYVc0QsnOfjz062d9hJKpz7Ldne9/q0cd2JvETb7DEMhGEJeISdj/TkHatFKVrRmEAoPC71EdHL6bcd1K3UYhfTJ70TE1z7r1svv41vQC5bxvbdEYCSo0qfB4lXZA4AGxGv9z8UAROy+Xr6IAuXMicDq8/LdslTOhvdqU97CgkeFk4bTg0BUjFWJeJwJaTrYdNAtnHD/i5n+th/PIpxqf2YBYo6kSpCJdTqrvUtgSPBeehdJgn/XTCD7hPGHqKBy1YkZL+P+07XNP08fWevUCXcC2QEorDoj7RxAL+Srdw+hciWVrN3WubYTIG14shBfU7VAbq7PYcfNk6rSIWGtVMuca67eDwvt+QTHt2RLHoQ4G0Gf2FEmnz2CrkcrwPaXfKlcMGT87jfku4Q1GirgrkZ8Lidbu9cOhPta3+n58jWx2KTTR02vI54j2LxUJpea0Ti8lMa7vjzv/joGCskLzx/R/Y5++pz8LvAlr2lbu//EFDh8LdfRjnpvaJM7L/M4EI3SaCRbLLE++KP4H9z0YdnldL7lGO2LWRCoEeZ97RSudzruIaclQ52XA71MoHFtbGBBZC/n2TZ8BUVQxKMHBIAdWcBkd2GvT27IxZLWFZ0y7qxXiFDcNOd8QdhoI/nBaZEp2vc0TdkbEKrYnESVPAVzOoaY2JP+7DV/tPJvmJ7zFZe3cPP4PoyhT/tQEBaPMfHDiSX0H4wmbGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(82310400008)(451199021)(1800799006)(186006)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(110136005)(7696005)(40460700003)(478600001)(81166007)(356005)(82740400003)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(6636002)(70586007)(70206006)(41300700001)(336012)(8936002)(8676002)(316002)(16526019)(1076003)(26005)(36860700001)(83380400001)(47076005)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 08:37:15.3269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5984d0-5928-4bb4-6041-08db9bd87f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:94:102-107: WARNING: conversion to bool not needed here
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:102:72-77: WARNING: conversion to bool not needed here

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 32d3086c4cb7..5ce542b1f860 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -91,7 +91,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	pr_config.replay_supported = true;
 	pr_config.replay_power_opt_supported = 0;
 	pr_config.replay_enable_option |= pr_enable_option_static_screen;
-	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq ? true : false;
+	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
 
 	if (!pr_config.replay_timing_sync_supported)
 		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
@@ -99,7 +99,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
 	debug_flags->u32All = 0;
 	debug_flags->bitfields.visual_confirm =
-		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY ? true : false;
+		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
 
 	link->replay_settings.replay_feature_enabled = true;
 
-- 
2.25.1

