Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7B1C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB94910E678;
	Wed, 24 Apr 2024 08:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fo0V93Nd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD3D10E678
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V41TVTumq47QxlKzsBg6TmmQlsW6N5yG0W3RSIKyFgloV1tKSixWI4fTrrjFDZlQZm/JKNStegU+mpFHlVVVHVvMPH4+1kF3fH/b5DjPdmzqRY4Fgoj97Mg1lZrDptEQM/1B0sXxGi24YQEU9kJOgPVPxTU1K9CfpJoMFZlxQvW9d3XJl+o0goMZwS0g+E2kv429u/KROxvFMweEu/VzO4+2ObYG2FyhWKcr/h8e4mUkH7Rl6CXtwsY0UQZfFBi0PwLkXp19U45b4TFt8wK0zyXNoTcz/yFFCmLe7iaMVsgYrNtMMcV2mQFAdyyK8ZaNRlMFDZpIf53iScDrcS6Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsMi6RhA/jwg4hqeo4Ccs27GoHxbyV8/eA1JFL1urcE=;
 b=VK042tN+10OowRA4iJKOdy+zXmXm0HhxbIRTEMoy+0KULQwpMJezYjJI+qsh8Ji1zHgKsQOlo3XlzGbwVppnd9t516Kydgg1LB3i6F4S3XNSOBjarWb5adJvm3AZwP++4wmEvVfuwBgHn2fNckYYa2W5IDGAqQk1k5WOKkuERIvOoOzF3tVI6rT7oiTvmQedq2gJB0jHJZkeqIRJLWSbOWJTvUQLCdZ7cghYruxcmYQa5cG48YIt/fSHsHS2hf6k7Y+ZJu3dxzVpQk2cusJvRSM6DeTj74ytMjyNllxJhLEeQTlU43krjFOoi0CyDtSj+ptHYaBPKbDZpmtGXb1rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsMi6RhA/jwg4hqeo4Ccs27GoHxbyV8/eA1JFL1urcE=;
 b=Fo0V93NdiJGheSRdudvwGj6+Z71jXoGubo38Cyd7no0+jYso4oDK5ygFvsWblE3MW4uRo3LO9wCtsftf99dkVT93rO1tBwcS0B/4GNF5TVWpzXZtCvewuVtB2PoDN+9Eue7vp9d0B/4/Nx3pJgwU9FkYmf3+qdN37miGkV/38A0=
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 08:52:31 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::c1) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:26 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Iswara Nagulendran
 <iswara.nagulendran@amd.com>, Harry Vanzylldejong
 <harry.vanzylldejong@amd.com>
Subject: [PATCH 22/46] drm/amd/display: Restrict multi-disp support for
 in-game FAMS
Date: Wed, 24 Apr 2024 16:49:07 +0800
Message-ID: <20240424084931.2656128-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d3713-d87f-429b-3f0d-08dc643be004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LM+DzucRF9FwvQEo6sIRc45Mcj60RW9NA6NNVjD4bqUBAMid3OgcuNsBeP9f?=
 =?us-ascii?Q?+NEYQ8DK+a4Cpt5TZvhUcke1VRkmZQLUOqkD4OO1rHkUguDbAcyt7DFH5mJT?=
 =?us-ascii?Q?lnl3ke8Di4JBHgMklMiJXy9l5/rvmQthN3rjMJmUOf5NKX8oloNExnyl6nzV?=
 =?us-ascii?Q?6OQXRwmHfiMiN9gfh7Q/s26dfgi06wqpIP9N7pJs2z47yDYqUJGLtSURfS00?=
 =?us-ascii?Q?ur5/RkuyO3IEPjRCiSwt0XkiKRobLFZ0FdeQpVHJAOKNP381CE+atMN+pJ0K?=
 =?us-ascii?Q?ysdG+C6Wx17urlrZXUnU8t0yzS1oJPF8gfGw5U0HjpBjMyfmdmohmuvxsHZl?=
 =?us-ascii?Q?0H+J7iSkLmZLn0+iRBEew8zoiv0F+RFvQ/bvmFF/3Rcm/UE2oJUD33ygBEw2?=
 =?us-ascii?Q?PJ2uHR1XziZCDUVnFOrumH6vTpe2+RnPmsjM7Xb0f1WgNj5rOzZ6zjJa0vOn?=
 =?us-ascii?Q?mvWWPWB6i3yFp4/WUML87QsemsXr/ghXJwtLdq0Crrm0P8+aYP4LupMKqWvK?=
 =?us-ascii?Q?Gtne3oIsaKIF8sOyy8LNrq6sidWHvOObNQV3IetWeyNuxSf25eNsJoU57OQf?=
 =?us-ascii?Q?s0HvuRJIVoZBLXdXejmvL9wwlBBxWHA9RXCghEBVc7pDZR66OdQ5KNTOWssJ?=
 =?us-ascii?Q?W//50Cavg3jjOyin8gSs0gk4HfYQPx5A3ONuQGkRR2njhFOX16AzkLCM3AbO?=
 =?us-ascii?Q?vMwd/fPPGD4czsO55XqF2L6qh3F6tKKDe7yZynQLdWQSTuRIJwieMpCj7Mj1?=
 =?us-ascii?Q?lufA92aaG8stFjjit0r3kFlacJ1ewhyUb24MmYcCbLTiEi/lo1E+73/QIdk0?=
 =?us-ascii?Q?xgE1xiUg4ICtrIj+Rn4/QG0sEK+D2yZ2bVREswhR+JAFkHYdETfHuNVHFWJE?=
 =?us-ascii?Q?o80ytJ54rHrvQyxFlG831zmnrj0avMGUgoXzh3qtSNUtavJJIFGO4bAVjkP+?=
 =?us-ascii?Q?0/d/HmMySQBe0/SnLxGR4caapjDceoHacKdSvKefjJa3C6eDGLPKlJiGI0Pb?=
 =?us-ascii?Q?Wg/mnI6iJKF3ehA/iwMRTFeqgFq4d0qtuY26zzPyC0fuuTJmtd7c1XHWN33k?=
 =?us-ascii?Q?BA7RrGMTp+76n9Rt+71b1RRfxfPxPIwRGiZYUjvN2Ko97NClvknINJJlj9Bf?=
 =?us-ascii?Q?Fs9dA7DyXXdbR/giZu3FtzBJc370obcCQPxlT+b+5KTMYUbFtaMZOW2OOd4w?=
 =?us-ascii?Q?OkfLzMbF6VpMtfx7yfQ+Jec3X/wv5trjSQ7oBUIXCXpSneiUXpfEv3BqtyPN?=
 =?us-ascii?Q?VwU9D7A5Chh4ywpeMheMHGvnN7qrkn2oKo2VdnOQfH50kClapmXLvQaQtQZL?=
 =?us-ascii?Q?pANrUx+NRwDSaH2mV3ES8Ob1VlMssuB+hjVAyFH9zYXOYs6qanabTDwYxJ6D?=
 =?us-ascii?Q?brz04ff2g9CUQWyaZlOhPrImRmk0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:30.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d3713-d87f-429b-3f0d-08dc643be004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[HOW&WHY]
In multi-monitor cases the VBLANK stretch that is required to align both
monitors may be so large that it may create issues for gaming performance.

Use debug value to restrict in-game FAMS support for multi-disp use case.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 8 +++++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 4 +++-
 .../drm/amd/display/dc/resource/dcn30/dcn30_resource.c    | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a3ebe4f00779..3048d5a0e87d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -499,6 +499,12 @@ enum dcc_option {
 	DCC_HALF_REQ_DISALBE = 2,
 };
 
+enum in_game_fams_config {
+	INGAME_FAMS_SINGLE_DISP_ENABLE, // enable in-game fams
+	INGAME_FAMS_DISABLE, // disable in-game fams
+	INGAME_FAMS_MULTI_DISP_ENABLE, //enable in-game fams for multi-display
+};
+
 /**
  * enum pipe_split_policy - Pipe split strategy supported by DCN
  *
@@ -951,7 +957,7 @@ struct dc_debug_options {
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
 	bool disable_fams;
-	bool disable_fams_gaming;
+	enum in_game_fams_config disable_fams_gaming;
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 6472da2c361e..a8c36eda1d09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -580,7 +580,9 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 	if (!fpo_candidate_stream->allow_freesync)
 		return NULL;
 
-	if (fpo_candidate_stream->vrr_active_variable && dc->debug.disable_fams_gaming)
+	if (fpo_candidate_stream->vrr_active_variable &&
+	((dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE) ||
+	(context->stream_count > 1 && !(dc->debug.disable_fams_gaming == INGAME_FAMS_MULTI_DISP_ENABLE))))
 		return NULL;
 
 	return fpo_candidate_stream;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index fa1305f04341..1ce727351c39 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1996,7 +1996,7 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 	if (!context->streams[0]->allow_freesync)
 		return false;
 
-	if (context->streams[0]->vrr_active_variable && dc->debug.disable_fams_gaming)
+	if (context->streams[0]->vrr_active_variable && (dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE))
 		return false;
 
 	context->streams[0]->fpo_in_use = true;
-- 
2.37.3

