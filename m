Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D36BC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B0710E438;
	Wed, 28 Feb 2024 18:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBl8kA8L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01AA10E28C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THK8P5a19JMXLHXqzhqO1Gv0I6lx9dOoLP+scw3skgTewfT4Dz6exaurChsUJ0yefW4M3n1+gFPBy8ZP6pqORo8qtGSCIQbEnZN6eu16XYTU0jZm4ZpJU+SycR8kYPpGEyp7eyFko85bRROnljGBt2CIFb8sTk+pHwOHSdMFvOrSrziBYuIijScpeZv0bcjvgP27f+b/ptBkOCC/IvVqIrdbAKPJbCzFRN3KrkKNRvK7zC9RNHOpRnuZedfOzjy/d5ezFqzTJKNnOpSAxkx8dSh8rdN9e3vfoDIMw2jBRgnwNjOMEdrEKna/JcgAQmeL+CBit5g9PhYAoBPhtYkWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7BArKNVSpKrQnTGn8w7bxdmxkMOgf78atOdH9wUy4g=;
 b=H2CdFPI4m828sg7MOFFhaBWD61pN/JfYKEuqp5VB0U8ku51740+JfC+0lRdqvgpmNr9ZgtWuQbP1aqEFPYG2qLrpMDwN2G2UEjgoLjieQCOT5LEW7t7m0kcXgIEzmweCAgRTfTRyZty9eC8KBA6vDa8VdzwKozIsIfw7qgCrgRC1ee7DVEm1zhnsEzxYh45FWZDzDHwPzByn1ueLpWnV+9P6uKocDxbruKVAumGehE2cIkvDaCvJzQr1BRFTH92I5w/QemPpje1CZDgh0eILm1Xi5ssx+vkixOOrkk6crmUNUfDk81vo82zaQhxUYtQqlJcxMqaOaFXPxGhEhpHt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7BArKNVSpKrQnTGn8w7bxdmxkMOgf78atOdH9wUy4g=;
 b=BBl8kA8LCsDtIAds3dI+KyjE2VQYKavX6HzXoYUkM5ws2gFD9X8afn4zgQd4UNoH8JQ6iehT0UJ/Svcwm+7zKGiefJ+zvLhxrtaa6MJ+uNeW7NeiZ6DeqjySrtqVNHWXJi1YOA0WO05wnl+75+Lb9jKn26K80rwGYi8uG7f9UFk=
Received: from CYXPR02CA0024.namprd02.prod.outlook.com (2603:10b6:930:cf::22)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:41:15 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::eb) by CYXPR02CA0024.outlook.office365.com
 (2603:10b6:930:cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:41:13 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:41:11 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>, "Alex
 Hung" <alex.hung@amd.com>
Subject: [PATCH 02/34] drm/amd/display: Enable DML2 debug flags
Date: Wed, 28 Feb 2024 11:39:08 -0700
Message-ID: <20240228183940.1883742-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b69f116-0021-4fd0-b6f6-08dc388cd771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXEdlogciNmuabqpvNrZlVku6cRENmjo2RIkgDw4iPEiP/sMpXe5PYUUXwc2ICjBYKOoOkerNWNOcb9Jh483Gp3euh0Tu8MyMrQWdJ/ec511OoMynEdw2F48DLsrWre8D7P9V3kkY/91zfXT7pSg1WHvq3JM8Ur1ReIXgXzeM3SkRjxBLTaePxGWmXCK+TNoV3qkPigNPlAuHZxE91dp0WGFL0fwIbXkLPfuxglv4W155OPJFS+RF1Mv0ICLup74rSFHO1ghCfYIrAw49N2ZvVyyOGeObMOsN6dPW82fCGAiRJfyHPci0yMSNMIU82QZAZ4093ojH++jlEi56ITZOMnoF17yzU9jQczmioJJHgJrCCaSb39Ym0V/sl2/CtHS3BLDKO74PPlhH7w7jG+Vax9IosmOmXFXod5HaNmiyr9l87z+bUmuwrtfp4kPRmafmJb4qkqDrNAbhxQkcRsTP5IY50NwCmh26y35WJ1TKZWplRDzfO8xqpxjgJWj7RwbDDSK3eGHF0JyAw+V7wDoxJt89xeVgtY+Oy8rX9hj9BPTK4GrmnJRbkmOBc/iYunHEFCCDwPXO9dD3D777FQLpYOWTUWsWWS7ZGawpVXnRgXqjhv8Ky92r6vS4bSMLzD3uQCz9WVdU85/E0PStUNCi7ZJmzqWnfIbItnPvLiNxGpvgTCgrVLfgeuJ4Hpu72CP/gh5nzK1XfJyfgdrAQne6qqEnghcG1Vik9zCv8h9clwQTdL+pSbX49W8ZJGpJV9Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:41:13.9961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b69f116-0021-4fd0-b6f6-08dc388cd771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHY & HOW]
Enable DML2 related debug config options in DM for testing purposes.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32efce81a5a7..e12f56ca3b6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1766,6 +1766,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
 		adev->dm.dc->debug.force_subvp_mclk_switch = true;
 
+	if (amdgpu_dc_debug_mask & DC_ENABLE_DML2)
+		adev->dm.dc->debug.using_dml2 = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
-- 
2.34.1

