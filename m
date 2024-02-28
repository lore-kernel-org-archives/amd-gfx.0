Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F280C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E8D10E60A;
	Wed, 28 Feb 2024 18:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0JKNOoZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752A010E60A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXgFxqv+MY+bQQLk432B5ZlsMy/QFaeeUTRQf1Tqh2DtdV0qC9035o/X8pMDTjeSDTgCFEtMS06IXJNRB5moHf6dTDWId7HTQhhhFW0m4SwsGWDGtDjXYa5yrhOVDgCYGjupSS6CzEdJweoaF3frffeX8nzNb83bsCFTZavi8CNUgbm7SLnOkUGfZSF1P6E41ivwVIB7KeRWAUWVf2sBeMsIoBPMjt2Zdholro0RxGLyfU/z3a00XAqgFGVuQwTznoIJmNsl7jKQlBHeXwV+4uzggfUD3U/gPLvY+HCMUaCBM2nRFWjxaBDLLrOw27h21P9hYr2LPA7YGQHhBIQTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYeZ47p5q3gG+wj8Z9YpxOoqrriSMoOsBktPJ18VFeY=;
 b=JoF3Eg7R1qT0bEJ38YAUAyxTUvF0H9YBujJ/y764Hov/q+MdpVkJ9OJhYVrc+9AeLCdTKD1wJKmxk/EpKsPaWGLw5lsVyXHgwYznI/v8Ywd6T4KxYsVMU1HDYTkXqnFU6bzlM0HsMrME2YbNIJj8dyLOxRMysjCaZzjlU/SYaZGXT9MXctqsL84MuNaLkrWYNnAJbBgP0uZZM5qrH0+SVUrbfiPa5wkOz4H6YvLxLxk6124GoQWSuXzGNw5uO+oyBWPIdgnxPSIbTPwMSMhEvzY/2LK9jJ0bBrQ2UM+6tdQiG62BiGralFkT/Okc33d4PAWuPSN5IWm2VuYsBvMcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYeZ47p5q3gG+wj8Z9YpxOoqrriSMoOsBktPJ18VFeY=;
 b=e0JKNOoZpMr8gibmWIC/nEyqGMMAsolDDOVJMdQAbO258WXVCt9B/XVi909CkKxnY9IPKcbV4K9H5piS7dXCetD5StURwLplg4P36fzGyxJmISpxJE+h3FRmlnfyEdBXuHQ866+iWurombvLxMtSPSprOy4i7XYXuLM/x1/RrNE=
Received: from SA9PR13CA0062.namprd13.prod.outlook.com (2603:10b6:806:23::7)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:46:26 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::c0) by SA9PR13CA0062.outlook.office365.com
 (2603:10b6:806:23::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25 via Frontend
 Transport; Wed, 28 Feb 2024 18:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:46:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:46:23 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 25/34] drm/amd/display: Set the power_down_on_boot function
 pointer to null
Date: Wed, 28 Feb 2024 11:39:31 -0700
Message-ID: <20240228183940.1883742-26-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c72f01-1001-4d18-f061-08dc388d913b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGLbOh5Omi9aLrFnWHhCCgk0ls4uT9Vv/jylzijj+1civCuFzeljBCyym0SYlHRkCTpy4vJoqWp3sUl7Jm4plHJVLs7g1tGi3pUHbhScT2ruvNrFdHoyb1aC74p9apOx81JzfRqgjSyEMS4XhIZ4ZGpHI9/e5nBOMP25sMld+F7sxFWP/5xarQvj4tbc2976/aYhjYoexIHYf1RjSFDsSLy/w+dU2HYS7nnAHTE8CchV5cxnqcaAoliPNSrBht/FpwdfhD67NFw9pG4Y0MyHyB9p+1zy4+FKERZTKhjtVshNkhPHpFtU+Sz2EahgLND0JdnHlLexdknMjKkeVf2vQMAqYy8Tf5Jc0RoIpPFdvUKRKSY7dBA7bUOyWgMrIfqh9np7UcJHPdx049MyFK5yUWNH/eFtIGv0zXjRaU5b+SPUfrqCFsxBuGixrrjJYCE2fXapmse71ZqP71Hm/Yd5cfmvnev6B0HWC8jNIHcL5EeqRYk6z+634ddreb1I2YdO//l8Pwvm7lHN7o5J4BgtaBLoTsHoVzGYcAUFhLpEeIiP9t2yx957ALcbDKRHz7GjElaGnhoQcBTK7Hfi8+yxc77JoNNxW67D7aRUT6coQdlCnkm7HPywFYFKYgZaPq25wBzQrnOSvL0OIkEH+8Quc1Pe7zYvxjoeSDX6ITKqnkka52PrTHlwJhw5oSKs4fEz5SK5ZuLTx1QbqCdyo8zpL66Cp8zOlgjdZi5mQNLhVWIYQrGRkW6LObVqfyHVv22p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:46:25.7155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c72f01-1001-4d18-f061-08dc388d913b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[WHY]
Blackscreen hang @ PC EF000025 when trying to wake up from S0i3. DCN
gets powered off due to dc_power_down_on_boot() being called after
timeout.

[HOW]
Setting the power_down_on_boot function pointer to null since we don't
expect the function to be called for APU.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index dce620d359a6..d4e0abbef28e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -39,7 +39,7 @@
 static const struct hw_sequencer_funcs dcn35_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn35_init_hw,
-	.power_down_on_boot = dcn35_power_down_on_boot,
+	.power_down_on_boot = NULL,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-- 
2.34.1

