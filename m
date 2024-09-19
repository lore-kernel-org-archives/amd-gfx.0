Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43ADCF3965
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B71710E75F;
	Thu, 19 Sep 2024 18:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GaMOckj/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453EE10E75D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuuoLYZO0ThjNqB9geNm696NSiprYtMrP5XEZPHBD/kuDhWL3vAmfMjlqrtV40CJp036NRTl8d5o859/BRged/9ccoTi9nHJgSlSEWdnFWmfYTI+rmcLhAwV1S8yP2TchZBonj2MwK1l68Dulex0Qlt9z8PQRJb1flnVDsE4V2ACu3gj2GeuU8HYoghzB6nn2EG95OBpEIZYaKXvx/9+AgCQUzKxRcwTGzLSqICqljQHn01rop8uWRqkaSf9IvDPFJokR292BxIFWhJiHc+al0rzPgpUUupDXRXhK7y5tqNIr/FUdR41ujyhZHUowQlf1ofdC+/sFhWf0RIfPdgLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM2dEANxK4xMui/NHNKFzKqJx3Ia24NHCzzQ/d6CrAc=;
 b=LJiSgBPvj7Y2m5z3FI7pRNWE3dQ3WuIgFSAaUazcbbVsLecXC+jK4h3z3h1NwfxD+30dKQOWs3y4QX/RFNtZGZR+ZAonmUI1ely2F5mQMYtL99Z8dul/Kle5APWVBC5r85vkCFyo/ZkiSMaSXt+ZcUzH9sli0wCE/TBHWzs5kA0WLQjVNSLI8n3VVgIJM2a95NazaBtvHoMt0jffqtWVjlFa2DcNZydW9SCS6/NXMswXg4xHrxB5n/wrxK0+HAhnGKDwy+izqjDSyc5p6le6v/eLS5CGYuJLGGwUG04OappdA9HSPc4CXkWiWsm95JfRHCwQzj+XJtdzh75FO4O+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM2dEANxK4xMui/NHNKFzKqJx3Ia24NHCzzQ/d6CrAc=;
 b=GaMOckj/47uCixEWCxKt1xtZStKo88FDq/LqgLnUR6JHRiynxOtg9QTYsgm5vwG97sTbVzVa+Tdz0Z6mMXcNM+vn8igr99wb/o5GFpyJ5DwuZY1P2zjDHcPB/XlDDMLH1R4ec8Ur8lUbZzIxbXjPZjTUeIgBp3S2v4NlMZblORA=
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 18:35:00 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::28) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:58 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/21] drm/amd/display: avoid set dispclk to 0
Date: Thu, 19 Sep 2024 14:33:30 -0400
Message-ID: <20240919183435.1896209-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc2d722-87d9-435e-4366-08dcd8d9c48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qmB/5tTvyFsV4E3G0DPm0uhhgkKC2x7iUDOak+x5cOrYGV0HpJ/hSwI73Am+?=
 =?us-ascii?Q?XSbkXhdqUqhmJ4Uv9hxmWRh8SIfBqU8Y8cNITT5LGk+0idKZqJ61akXfGBow?=
 =?us-ascii?Q?aemqnZN7bPpwsqpR/0vEEaZoPT1gV0anj6YRdC+jx5JoFUi5RfRAO4zwX4b4?=
 =?us-ascii?Q?ncf9jN/sAVDV2isqx36KDNLgl7Wmcx+OIbYTgLL0RVMtpwvwJ5oFUEJNWHWq?=
 =?us-ascii?Q?+AgtvAlzaAsHTqfGX6+92NFyvPnUQCQzD9QQiJlh1NYlDU3PJM2bhxjxQt22?=
 =?us-ascii?Q?rfGb95vtSS/h2+04IOB9/gkm1yZDQG2alw/2bTsTu3ycCg6AaWaRnAinOQdO?=
 =?us-ascii?Q?vgPIIN5kYRXiaiPgnfY2q8xWOpFCxleTgURErIuTmcUehVta3IlBvKpOHk3S?=
 =?us-ascii?Q?m+BJBs36UuBNZx59pbmWPZvVY/O50WfCUmT5xbTu4w23iIDd3+kZt6jDK+Fv?=
 =?us-ascii?Q?1BvakqaYOmFjOxQL4VYV/oN+BHa9Zb+rUlk6E4fjOO+DoF0olDaK9ERzyBev?=
 =?us-ascii?Q?bu/YG8ZLFGeULM8TXGn+N+qCJduP8Rwty/QPfnfioePDM5VttDsvNZZH8w1a?=
 =?us-ascii?Q?41wOmsIU4D9IVYs6zY5A8MBmY/Hb3iR6O6G7UYDMWb2yKDqKmvUkabbFNhJB?=
 =?us-ascii?Q?Su14I0shsUcwx20lU6UYbpuQeijwdYXj9JE4MHcIdYyL3wCM0TR8o++cDur2?=
 =?us-ascii?Q?QNoI94mudar7BcUpQGx1LmaWa6jG6rwyhtZG5U4orl2sWXgJqPelXYCEZXw3?=
 =?us-ascii?Q?SvdrUWFc+1R4pkwkk6PUhNpnqsXa8+e9ukGWDTZadt8HjnJ4dvcLJgq3p0/E?=
 =?us-ascii?Q?88C8cwPsfXc85mKwUfhySKl5ut1c6swS7nhmXhIOYwQo2j1Cwpeu3lzZMIEc?=
 =?us-ascii?Q?5M+lQlrUMPkq7P8BRegr0x3TUqRg/JqnVFZlUI3Wq1YzMgwiaibf/rzbRcVt?=
 =?us-ascii?Q?2dqeoDkeY4/qjxV+kYjuaIcguVnTnPZ8FBciDf+c1Un7ez5whpsX1gI5maOD?=
 =?us-ascii?Q?Xi+P4mr9NQB2VLwQG19rprR3NN4+PCHFAmy1Gbffz/8YuqSUcY3ZXghqDsR0?=
 =?us-ascii?Q?+4UIf6CXq/CVUenKBeT1Xf4jbYs+QnJp7hFOt+fCyotRaJ2RNUTAr/feAItD?=
 =?us-ascii?Q?zl87wZkgLSN/lkZP3z5wdDDonIKu6Ut9jY6EokqOStoJJoa5mhXDOCSVDZJw?=
 =?us-ascii?Q?Ab0BjS4+f+GlxL1EeRTQzUmuFy1jLT/TqJjcMyoGXCTUS2jHEqP6ambM1H10?=
 =?us-ascii?Q?dmKncPyYvjWc1jUpWmiVAHSebbMETNPsDmn3wbIf2K+kWVQUeES2UaWbhptu?=
 =?us-ascii?Q?Bicmuwb+n/zBrLEFhXxy+teC9W9ESMv+hi0P+esNGcXNq1sVWRqVlCBQfv2U?=
 =?us-ascii?Q?w5KeUjhOEHfzrLRBKe7Bmttec3hzcUD4NpgAB2T4blN7NPGE9dQugIv2y9GB?=
 =?us-ascii?Q?c2jkrsVs6xKjedf27iXKVS2SO7Fa06+k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:59.5481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc2d722-87d9-435e-4366-08dcd8d9c48b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
set dispclk to 0 cause stability issue.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index da9101b83e8c..70abd32ce2ad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -766,6 +766,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
 	.notify_dpia_hr_bw = true,
+	.min_disp_clk_khz = 50000,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.46.0

