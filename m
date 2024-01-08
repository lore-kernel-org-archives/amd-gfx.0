Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359FEC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 16:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2A610E065;
	Mon,  8 Jan 2024 16:19:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C5310E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 16:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvctzwmx/JA6LR2/TxFfk4AZjO9wfWITqjBj4CbUR2H1cVKVNu1S2j+ZMURY4xUA8bTm6YI7VmH/hiY160cG4eES/YB6C1BDRxRueDBpWjkz/J5BST5h+OdXpq9k352l8bxV2I1rS47gKxmAr8CfAsCDDrGW5Xk2bcu8rHr9j7pYhQUkoxKPUhMCRUNuRZshYooIjGkfqGYkcvZHgo3OenB+WKoX1ekd6icrqkcYRuT8IP6vbreYFH9wpRMQrE+7cstwNPunAKqOHvDjddxeH5vd3rRLkd+houxHxLJgohDVSbYRawJqc/uEbDKcTTSZvwDuILwGU4YwIQa2jRwVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTtv1NUXRiOUhdw8eWB6QQlZz+9n4jw6NeEySxySZcw=;
 b=mZ8C2DKThKsG/UzxqazeowDWLIrudNmm+90JVCGK8ZAcngU3XCTLb7pcoDoiGgDcXDQO3lueE6VoBzIdl5dx09gXDBuPn/CpufdqUmOt7m3OnOSHndXZp8W0hXPTmkHVIxLo63CnSJRycI6ryOKIvqfgNgx4lxwcLDxAWY73UovbM0OqpmI55l32j58GXiqOS8W/USMfJCdF1uxxhGZaPy1rmfp/r3wrmJLt9DcneB/AurfsYYuVJU6m4VB6qhk3NiA2UfBILJX68m8mLqJpQZMyfTRvumkDrg+A3WxFIyxjW5uakaWMGz5r8y4L9SKpasrSTLmeaCMMuDK/DLRy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTtv1NUXRiOUhdw8eWB6QQlZz+9n4jw6NeEySxySZcw=;
 b=QHMDh1AXgSB9yxYOApMyL2OeXeqviFvwR1QfsYWzu98avgfL1N1fyFnrG3rUuk0jO8/Z8ewtgBTWbTQfzdpNve5mP2BukLo+RqlyMwL5yp5OXxhq+d3StTkBV8Z+TMB0SfCfYB7N6ZW2csckebfXER1u+5OJ4vpAl/UO1vGE4Bw=
Received: from MN2PR19CA0053.namprd19.prod.outlook.com (2603:10b6:208:19b::30)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 16:19:38 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::5c) by MN2PR19CA0053.outlook.office365.com
 (2603:10b6:208:19b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 16:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 16:19:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 8 Jan 2024 10:19:35 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix variable deferencing before NULL check
 in edp_setup_replay()
Date: Mon, 8 Jan 2024 21:49:20 +0530
Message-ID: <20240108161920.3973404-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 46311996-013e-4e26-2852-08dc10659c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX7VT+zpshy+uL3Qebav+7DiWVf5QfJp1mk1ghnNSoSJK+KM7UKrIM6e7w31PqxTik5XwmmM7dbyiVKn4nMUP36LA/F5m2uulypz+cHZ8uoDn+rBOJTCSUB8L6YDeFPwNMP3K8/LmNy3JdTlzKCdLI3NgUusxncFqbQFns64w2QoFOVbx0rb3j4RKVqZ4lmrZYp2jh4ZYM2aWs/Bj1vFPX5euwrR1q7A0AsDyG2l4ES/ZI6i6ySnqMo7T8LQBUhKpfqJpcZkVdI1IX40WNHiDbofduA5eaapKee2hYDMsi9INJgd+g+CDG9pkoi4KQ1jliYZxj3InRXjYJgUTj+JF4QT7IDx1ZaRoAZx5RgPjFG29B3JGZD9SAzXvytYyVKQvAR0RnSDnrBePYwOTFaESvTtXx/KCaaUsV4SdkZI5k1jsjV086XGFUKUwrSqe7eb7QvmemRjmK/enYmhY3xBpXAu7G8Tz2pGrn7Cb+duPIuEfHZA28toKRYdpTvAHUd9/xtkUb+4U0CfBVRC7xvBaojOp7TZWWLCyf9YaN4DUhI92R+utdAeyupNuw3L2aUrheRJyVZfFUHUpKhJ9QuhQ68QFA4AaQae9Pl3Vm78fmVoqtGo/lrX0HaSzimhcuaAzem8xKORY6L8ONQT3Pm9sD7j2SCRQkG7pYrLcl5DKdfXnlfyld9nn3asZ+zgWmsLhSrLHTkDy13FpHamllJFGcSeKyVJGmBT6zEAvFiolb6vSCnbi1p0IdHKVTzeG+cFMw+nW/7BtCHSZktbQL6Jdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(426003)(2616005)(1076003)(336012)(478600001)(26005)(6666004)(7696005)(16526019)(47076005)(36860700001)(5660300002)(83380400001)(2906002)(41300700001)(316002)(70586007)(54906003)(6636002)(70206006)(110136005)(8676002)(8936002)(44832011)(4326008)(86362001)(82740400003)(36756003)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:19:38.3274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46311996-013e-4e26-2852-08dc10659c89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In edp_setup_replay(), 'struct dc *dc' & 'struct dmub_replay *replay'
was dereferenced before the pointer 'link' & 'replay' NULL check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:947 edp_setup_replay() warn: variable dereferenced before check 'link' (see line 933)

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../dc/link/protocols/link_edp_panel_control.c        | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 7f1196528218..046d3e205415 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -930,8 +930,8 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
 {
 	/* To-do: Setup Replay */
-	struct dc *dc = link->ctx->dc;
-	struct dmub_replay *replay = dc->res_pool->replay;
+	struct dc *dc;
+	struct dmub_replay *replay;
 	int i;
 	unsigned int panel_inst;
 	struct replay_context replay_context = { 0 };
@@ -947,6 +947,10 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	if (!link)
 		return false;
 
+	dc = link->ctx->dc;
+
+	replay = dc->res_pool->replay;
+
 	if (!replay)
 		return false;
 
@@ -975,8 +979,7 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 
 	replay_context.line_time_in_ns = lineTimeInNs;
 
-	if (replay)
-		link->replay_settings.replay_feature_enabled =
+	link->replay_settings.replay_feature_enabled =
 			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
 	if (link->replay_settings.replay_feature_enabled) {
 
-- 
2.34.1

