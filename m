Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E7EC4829F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BA010E3C8;
	Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3Fd0vkl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2469A10E2D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThZe6MIDPqbF7jS+fua9qKMKUmrVOwChwF2V5Nhp1395p3kBtiaDNE2ywgFQhDDktkVfqQTUIhNzzGWsY5TyTTKK5Umz/PoBlLQ98IKYWDt1yJT06RRaEqV926uLCpvUsXbMuuqJbVUAKXw6ReYQPy6fRgQlIRcjXjDF88mlLO8jn8JGzfQij7ADeILlA2LR7nPW9iOXT83qkgdHLecWTMCeO7kHV9GE0WS1dQyvmNKhaMPK1jS0Itr4038eoZKlTfYsxIg+8NzYnEqsyKTy0TgUv5PrTEQ2mR5vH2jmVgB2RjX0BmvZweBsfdXh0jXE5PG20aXvffjCDKqeDk1aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI6YI94+eaquJeBRg6atvElEpKihLA6hHAyxMOUqh6Q=;
 b=QBU5/Y8Y7WU9Xclzo/xrukkKZ/eSyc66FxtQPJ4ZAULqWVTOfNICBw9xYupMmwG04I+cMkxWL5lHJABs2/nB0tdXEOiI6PpC4DqL/zbT3FSreYoctStFxVAdUH40sbLRrrJL+L+bNhZKmMnT95jukI/m64z23sh3Sh0BJ74p6Lhf4AwDIxP1+c09BEL/3oMcqTukwhm34RFK+cqA7wz1zPPvPQl7bUr6PgRuanzpR0utDLy0Qn5Qw6DruaM+o6z6iEcIrwepwsuVUPly/stIgqj0l9iONIF1m8fjnBNocV70w1PLeH3rJZNLspXGL4cZ/QvevYaVFnragcgF74dHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI6YI94+eaquJeBRg6atvElEpKihLA6hHAyxMOUqh6Q=;
 b=M3Fd0vklDzodazFN9lbCsQWYsAqg8mdneo9eTCX8X3vIEugfJF8B4KErNsN3YwDTI7SOxeDjqCmQvWnX6/IBRMup9ctrMt0dr2MWP+vItbSLJwDLLhg4qG6HQebgLAyYWisicx2Wj0hGo7eCYDxmt08CHHk1EIDi0/l5Mgntqn8=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:52:13 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::a2) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:10 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:10 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 03/15] drm/amd/display: Preserve original aspect ratio in
 create stream
Date: Wed, 7 Feb 2024 15:50:38 -0500
Message-ID: <20240207205200.1608684-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: ab46a80f-9ac5-4f81-6777-08dc281ea924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX1A+hkq5RvS/j3cwEGCTSdtKQZIc3GwCYyjehmEdBk9VWAT4KDQWFxJEuKexXsTSRph3DVpxOXw7f2lBmUzryINsDvnAYwWDmk22zsRRyWMiB8Syp01CjjTl7Pe9DGcS9eKf/J2V3lpPb0gs3tpWgsK6P7i0hKR0bxoBAPHRQPlmeIYJFhHkoRciEoL32AhzwEvUviDD+8JmbOHAoUw36qddmFKRvydMWNYfSGhzRho6npqa+e3rayfaEcCVLaExnMPAc1MIKVf0sCh3P1AD92Z8gocRwZ8V1jbMwlH3aaYBwpo37CWc0iDHnjYbRL91i/chSJE8aFnWHfVwmXU/49pIg7HW2D8gOq+wSpoyu7fiN7w+ZZVjteVAms6//bBtI3KrKmpysL1AMK+7LO3EAqx4W6byTgrfQFP78z6WYoV5biiH7qe1mHA3GPg37/vMseVzEU/ow6ehnb3kK8W/v/MjUju3r69EPy1ZIVpypaftx5larodjigXW4E9Awd4WbvRI1c8rYGvRRtFs/WUxNyuBSrtRgltGUjzZbY++lus6pBJsRWx0KMnyofBri4erzMof/fbLWRUtvZo0UZQNXVEPrXWtuRGWZR+2xBEbcY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(26005)(6666004)(70206006)(426003)(2616005)(86362001)(478600001)(8676002)(336012)(44832011)(2906002)(5660300002)(70586007)(7696005)(6916009)(54906003)(82740400003)(4326008)(356005)(81166007)(316002)(36756003)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:12.2414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab46a80f-9ac5-4f81-6777-08dc281ea924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
The original picture aspect ratio in mode struct may have chance be
overwritten with wrong aspect ratio data in create_stream_for_sink().
It will create a different VIC output and cause HDMI compliance test
failed.

[How]
Preserve the original picture aspect ratio data during create the
stream.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3a5e730be24..fccc87ad401f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6228,7 +6228,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
+			saved_mode.picture_aspect_ratio = mode.picture_aspect_ratio;
 			drm_mode_copy(&mode, freesync_mode);
+			mode.picture_aspect_ratio = saved_mode.picture_aspect_ratio;
 		} else {
 			decide_crtc_timing_for_drm_display_mode(
 					&mode, preferred_mode, scale);
-- 
2.43.0

