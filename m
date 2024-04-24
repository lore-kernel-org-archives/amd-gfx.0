Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89AEC10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2F6113960;
	Wed, 24 Apr 2024 08:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqFGo6zK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50447113961
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql1O4cOreEHX5G6tXcrxjfXRLLvt5wH/cf0E2R2IxFIjPBAwNLSgBZrvTQtywUaNwh9uTcviZ1/z6GLi/XADYcoPaqE8DC0vOv284AZ9jNSBf8JB3fv6iG84Y/f0rAI++0IrfA9tNhQD1sMKmgpPxvWpi+bFfK7b3L5fmSD8X1F9WmnvUnP28LHSahdooRxPff9RnKAaYhTh5i68cMJ8WRuAWRobJGdpTNWN/Xiq2bQKkV70++5CQw8mZ1Rf9164KkIOwBcHc7Ec7BXwnHb/IkasbLvE01ukV/5ECeN0pwuEN6Nrb9LfxxeAcctQLMhk+nr8dEc6uKrswp3TvST2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmWJadPWmiNhV02DPrmSmlz26vyFk3JkyYdMqOP14is=;
 b=fSpsfZj7B4EhCzaMS52uod8v/H0SWbVm8Lc7rMK6HT7J6FGcKhejWoQJ9tMmg2++dZ9odh8TV4jU859+fIMtxFHwF48hZbydar+nckapvqvk2XEbl2Sm3p6cjpm7XCxf7ERnIT6vBx7OBhUYu3qNUiPFNBZZuQDdQCmIrqef+JPBM77LrxjVW1AeGCB2CynBGD4YyeOIKNPgnxJyrP0p/y78rS5fjqz5NlzJDOOm8tI2JivFBo/Wq5ZlQkyVy3wrapC3qh6dORXVNYe0j5cXbNiS1QAwJYXSJCyra57aY20t/+qx47NEWQW4W51DvyWLp1JAc379y5YjlldRFcfoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmWJadPWmiNhV02DPrmSmlz26vyFk3JkyYdMqOP14is=;
 b=YqFGo6zK69XF270VgHaTOVuFALIC1YUDv6FmrHyAUDiN5lNaoaFoJ21jHAS/QvCVhysBMJeoS9WztNi+JbEA+DrREE6Yc+HnG7YlW5Ca4NBsZbCL2bUegYdVwXizZK6bv88FEGVm1+9URYuHsRrqotrOcYgb0dT5Bynb9VeE/tQ=
Received: from BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 08:52:05 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::4b) by BYAPR08CA0072.outlook.office365.com
 (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:52:03 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:59 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 17/46] drm/amd/display: Update some of the dcn303 parameters
Date: Wed, 24 Apr 2024 16:49:02 +0800
Message-ID: <20240424084931.2656128-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1864c6a7-3a09-4f4a-8a47-08dc643bd0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ty8Q7cgDH2QDJ3c8QoZ7LWghtXzPGipPUou/iEl+3qeprfhnFea7zzH6ZiZy?=
 =?us-ascii?Q?dKguwOjHGpjmVjIN6dRyY8VC36g0bnBb4fIv+bsr6UzTyyLtm8pvaNFixFFh?=
 =?us-ascii?Q?L3rLTW6ZxEMNEKvyLWuIk+vFRpHZYkAr3Tzm2lPpXPyCFw22rvq/xuj3uive?=
 =?us-ascii?Q?MvnrxP/t9EgT0MkWdCH9vBm5yGiRan1LeArT7cXJykDzqoHRKQLJoaaYMpL/?=
 =?us-ascii?Q?2Nc2NWFG/5N73qQAw58uYMX6lTqVqQIemuaYtt24UqfivV/AxXn1jdwutYdD?=
 =?us-ascii?Q?+ZMbMUtY6OUcR/BaTHGk1MfWQKM9Exc8zf0jZ3XA6MHTObtJFNawnLINNeeG?=
 =?us-ascii?Q?W4GIGrA6Kv+1weiUZLZqizQxF4qv+dyMHXqrOV9f6x8AXfz5KwoNR7GpD08/?=
 =?us-ascii?Q?gCiwvkoOEOm8GJOkGX+/8e8s9D9DQCQ6Kh3/sML68HrbXwF+CoLkv1+0uY1S?=
 =?us-ascii?Q?Orxkr/97YbsWK1c83bHzt9z41jvYTltxsH60d0LcMYsRfb4HAFt/FPLLLyhQ?=
 =?us-ascii?Q?4u4jYz5jWJ1nmGETIKxMCYCcOK5Ok6MlRQGy4DRJg4H8lncOgVI4b49edgof?=
 =?us-ascii?Q?LdkMcy2Q9k2S0qUq8v677FTyGGgjwb9Ak/odxOvRYZ3TKLeTlF31wBM+GixV?=
 =?us-ascii?Q?HCxo4Zw037XVgAMaiFwg/KTK4mJt3g2VBxjoT3y4+WhHGKOtgFb1K+pC4B9a?=
 =?us-ascii?Q?oYKjm61zVchbBCQvnzMqgZ/WcOBLHwR1JF9HC9Y1IC/Ao82ZjolXZveq0qkt?=
 =?us-ascii?Q?vuCXZdBA+6aoos6oVwZXwGBXvDrW2FRLLlQZrRvRg6upiEyrc5FJXxfqQVRS?=
 =?us-ascii?Q?7hw/1ih9H+LYI+hOo0YWCjoh6cPJ7XRAgBHqi+s5J5CwziqqLIDGzloxtENE?=
 =?us-ascii?Q?qaV/u2o7AdDRpaJan87D9TTkAv7k91nZMos6II/paJwfX3YfyE6LXxB1q/cE?=
 =?us-ascii?Q?znkZjV9mKAZs3zqj0Pm5ojGd8im7sXagvg0/PqGKhwKICZ+0nBhmUklSptgg?=
 =?us-ascii?Q?CRgXOg62PNQh5jcRWKO6Gb/fg+XIEzWOiT+mWLqPeRUHAo9IoAETZiKUl5ec?=
 =?us-ascii?Q?Zl5bgDo+oHOiX8qWJEXltC66ZY36xQXjDGR983r9weyEo0UlNpY7aGLcizCV?=
 =?us-ascii?Q?Q36yq8y3wEPM1OrjQeWYxxHTsKoGy+7YRnZUfebkszVvgxVJoXETqV3MYOmU?=
 =?us-ascii?Q?dXkgHdxW7c/6UePoZPP4O/4V+SriUKnZtvSsHr20OuAK4tOl/dYt+t2v7fH9?=
 =?us-ascii?Q?NDbpqYxZ5Uu0uUP70XKFYGYPuSxRnN2uzRTekUq0FHYse3yZa5QD5kX+zkVv?=
 =?us-ascii?Q?EpX36KhWK8uyiX4bA+rUxfyIKecshZXN31mClwitwEdGtF1xs/xzs3yho3oR?=
 =?us-ascii?Q?jF8Kecg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:04.8364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1864c6a7-3a09-4f4a-8a47-08dc643bd0df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Adjust to update some of the dcn303 parameters.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/resource/dcn303/dcn303_resource.c  | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 25cd6236b054..d2bc66904217 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -97,8 +97,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
+		.use_max_lb = true,
 		.exit_idle_opt_for_cursor_updates = true,
-		.disable_idle_power_optimizations = false,
+		.enable_legacy_fast_update = false,
 		.using_dml2 = false,
 };
 
@@ -145,9 +146,9 @@ static const struct dc_plane_cap plane_cap = {
 				.fp16 = 16000
 		},
 		.max_downscale_factor = {
-				.argb8888 = 600,
-				.nv12 = 600,
-				.fp16 = 600
+				.argb8888 = 167,
+				.nv12 = 167,
+				.fp16 = 167
 		},
 		16,
 		16
@@ -1171,6 +1172,8 @@ static bool dcn303_resource_construct(
 	dc->caps.cursor_cache_size =
 		dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.max_slave_planes = 1;
+	dc->caps.max_slave_yuv_planes = 1;
+	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
-- 
2.37.3

