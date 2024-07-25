Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F605C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B7310E8A7;
	Thu, 25 Jul 2024 18:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPrLkZF+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0619110E8A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLiNTT49dH6WVTY8jK4Pxp20xGvgYYip9JqbsWQ6+H6Rx+BolhfiCTCZYPLjntpavG4DYRAnP5vTAYY+PLZZpYbyPqLWJWhnvA+Ag4DHkZn/xL+ud8rmBdIKsM94z47ZUrvS3XE3GakyL/DKrEoPtK0p1xYXVBJAkOWKWUpyi0aEmiXbhngs0XSqDzyYuKKFEECmB+zLGEuXVjffGeFFwZscYx5zkzRf0QWa1pMw3rvtWmry3Tf36enHvUbqFf23gXZu70H3S8/pbmx6eE8KZ8ki3cMIZSYwu/ealakik+3lK2lgBmH8V1GuDiEMwCaQsFtBGTZZVY/3H2ELphZnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzT6tHg65HWm6SYpIjKhRhpxiCbbZWF+hzVWMNettB8=;
 b=KbgH7Hisy95D/SdFHOUTzaoThdPkBex1RqbPSewZDDtGa8CTPjIDH6qhylLznj6NFRiKlu/28nBTZ/3n5+3hqF15r5PIxhud2nXiV3N//g8b1RwEy182wTEVE3KHZh6L1SuNA+4OPNR9D5TBx9DPjTINZHIDTBjGW0rFVoBqUuRjZ82xXAX4Ga1mNgPsZ/QsHXR/nNDykoabs+Xfw/hxKHt67yHz2gxiu9mq2F7SZcY9jdS1pCbG/58COxotAO8xxTZ8pUV+5KcXC8YdeCJSr12YmMTbvkzvjryhxsoQTk3zVy3OR2qHjxueQHNgLarXhjSus7renSvnlzFTmcNnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzT6tHg65HWm6SYpIjKhRhpxiCbbZWF+hzVWMNettB8=;
 b=WPrLkZF+uIBKpbIrXLuqz5qP7whtf1FLqe7ZxIvhkVN5kWl61od7ewM1xgNIhNd9BV/ulHCQdHQuCgvg1g+kHHdtXaJCPjyiNOEvYpULzyi7S3gsWawfcujTV5R6YB2jxmwa2bo1qMKMnSRQeEa4LbTVaEgYGb4EZXDWY28l7do=
Received: from CH2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:610:4c::16)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Thu, 25 Jul 2024 18:04:00 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::b5) by CH2PR10CA0006.outlook.office365.com
 (2603:10b6:610:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sun peng Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 14/39] drm/amd/display: Reset VRR config during resume
Date: Thu, 25 Jul 2024 12:00:58 -0600
Message-ID: <20240725180309.105968-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: c411becb-7492-480a-737c-08dcacd42979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w3zoUb3k9swBol5ruW1w9aYViyRaVC4t/wrZjWtrWrjOjFyt7FknUPQFIHOZ?=
 =?us-ascii?Q?jTpYMkR7wVtojpn/EFlbcL60vONdpgby3WKFC+DC65ed7p8soxXtUV1eX/gQ?=
 =?us-ascii?Q?3389tt8rJXV4vdSgrS8IxG5+OA+Ay42/wBR8HTkI75uys1BzIWFfu1qeEUKl?=
 =?us-ascii?Q?fmhvr4T6e3y+eLab6RLblhEv/MRoGN8v7OjoDLkD/u3dVlutEO5pnK79h48A?=
 =?us-ascii?Q?+SeZg6Gw1XMgxbKOd1h3oy2Nd39pEO/fv8t4ftNGrJ7YtokFVygK0JCSM9ox?=
 =?us-ascii?Q?So6Fxz3Kki5NOu5HFFcoswAt5xSai8orA45oxJe5bN+P9LN0I2xZ/z3ysWGI?=
 =?us-ascii?Q?NcVqIwqEZC+pJjwgwgQufNLWdpPHwB1YgbeADSZ5orxRQjfcbnvucKEnR5sX?=
 =?us-ascii?Q?Fd1RPGN7VS6ph9NvKaaseo2zoAsGfI0yU3NKD2WR9PvuDkq3Tqn28IfphXd7?=
 =?us-ascii?Q?5zF7DRyKBOvijWhV692QVlSvBDGoF/ZmwCwx9k1EfEhQA8aXvx1XBmUutBuR?=
 =?us-ascii?Q?ZYJzoM3dBOdYlYY44WQ5IWN60wdikz3sJxQ2uxq3A7kJ7OWs0m5GF3bMTDWt?=
 =?us-ascii?Q?gdxlMtUjrNPMHFqeQCknKDp8YB8baQMPcovF1K8brnh9tjdZTZc4R+bqk7Ev?=
 =?us-ascii?Q?jqPJp1SBhulNk8t9YOy7flmt1NbU1EZTQfcaN9ovyEEmBB+v9wdsZVSJxRab?=
 =?us-ascii?Q?adGGrT/w+borxCDEpnE8+aZIMLYhhXaW3l96LraFawXm25x4KpnzscObXkr7?=
 =?us-ascii?Q?0seWkaunS3nItcI9Kmpfgr1IxUWWh4sykagjUspwO+wvlUolTMlWQ2QaZfg4?=
 =?us-ascii?Q?AC26B1HBiaq3yzQekKSncVpDQAKsetHMOhkm4kui0mvC4huTg2U9yi5Wzht0?=
 =?us-ascii?Q?ldH5+t8D4Rmbb+I6S6UOCY0no9Ucavod4lPJXLPuFkUMb1J262seufcdz0fU?=
 =?us-ascii?Q?EFBTf12ePwYR6MX/Ovir0QZl1SWASgEs48pwSwDkANe+nnxPL9CyCdlCdO4T?=
 =?us-ascii?Q?gAd9aQiCS4atL4haYx5tg5UxHKdvwDiaOMekgH+h+triqWLtHe/+l2+rJ3D4?=
 =?us-ascii?Q?3o9ij0WxskQdEw2sJPv7gU+ToaFqUUxEjSAN/Zdj0LYVnP8a0QSrjTJp3s8w?=
 =?us-ascii?Q?RRnODWJm4CsSz/X8P8cJRfgrbQiXNch5n7mHV6i+5jZ/8f9bZkcrgq1dZv7t?=
 =?us-ascii?Q?Juqa5/fu4ZhGiTdZRESVCJfmPCRVzqAD0LY/FAEJZFXe4fv1+rI64a5qNxwT?=
 =?us-ascii?Q?ooml546umbL2tDuqiClrWKZZfLnRrbwxKXJDe23nPKxS+rjKKPk4NNcdKBRC?=
 =?us-ascii?Q?bsLDQSv2FobvSyFpXkpu2bXk44VnT4Yzr9tOrvVNPC/n+HWaEPxQE2VNsvuw?=
 =?us-ascii?Q?r/oNVZEylFTP5sK2DryzgpqBQawbaaw3/YMRdRRpvxNOh7sjR2GMLXJPkDBT?=
 =?us-ascii?Q?1iMapOCgW7wZqt1e+cHycH8A2vIvkbP8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:00.5824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c411becb-7492-480a-737c-08dcacd42979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
After resume the system, the new_crtc_state->vrr_infopacket does not
synchronize with the current state.  It will affect the
update_freesync_state_on_stream() does not update the state correctly.

The previous patch causes a PSR SU regression that cannot let panel go
into self-refresh mode.

[How]
Reset the VRR config during resume to force update the VRR config later.

Fixes: f8ebe6341a6a ("drm/amd/display: Reset freesync config before update new state")
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f2d5a180f293..293f93d1976c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -176,6 +176,7 @@ MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
 static bool is_freesync_video_mode(const struct drm_display_mode *mode, struct amdgpu_dm_connector *aconnector);
+static void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 
 static enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
@@ -3213,8 +3214,11 @@ static int dm_resume(void *handle)
 	drm_connector_list_iter_end(&iter);
 
 	/* Force mode set in atomic commit */
-	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i)
+	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
 		new_crtc_state->active_changed = true;
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		reset_freesync_config_for_crtc(dm_new_crtc_state);
+	}
 
 	/*
 	 * atomic_check is expected to create the dc states. We need to release
-- 
2.43.0

