Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EECC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB28C1129D0;
	Tue, 12 Mar 2024 09:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cA7D3em7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A38112A08
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp/1YDF2D7pAwGhveB7aZ5qtlZKz5xzr33mjvlIUY8dgr5SBkrn0aL85zj6R/zPHqdCOmDg3kgqjTjkOEwAK68Bbo9y8jSUZk1qGn2WRa/apnFvvzGz4HCjgdh4i92NPXmQCNLbdzaWVich8T/+P2ltf1Ou3dwiyTdMiod4Dn13KjNd8JHaEaGDQC2ENbTqQAavf50zI97KvnuPUJjSHZivG9BP0SVQL4Q/ZJBgWZp0sTflnKQ4tvLknW1Vd8MHXO1DyEW6vWCacTBE0U3tq1ijDozmbuP0wiG1c71kGnJd+ov/i+gmz7dPT1HmqKXb2k3vUrsl38uRe/u2+siLnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ4uRQEYRN+bmm1Lt2GYyvLjRXce/TwTxlrRofeHNhQ=;
 b=QRIYcVoDNX9sx+PZBKaIvNRltYVMLuKB5RDB0si3pPg7u11XvLR9MXOXv0N8KySJu7+yZchQCW9EzccllLexZ1z1d26m3CFAHXV0PqOHcQ69ln0FVfb2d731URjvTB8XTH0Cdjxo++CpY6L65GdP/1OoJb3OI2k3tP6PSqfRKJC62TfZOjE3qhCkiCUjnsUAWzoqweSC/+iI42iCk1o6mPWcI9Y/H8dP/fgEkB0e10cpFF/wQmHdNmuCsqzNqZNxObZ7Ck2YOPRlJoKs+oWwOdiTar1irVoxlb1rlrlI+qKmUchDbha4ZkYROKNhRXxDvgwYHJIXukjbkF1jE2R9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ4uRQEYRN+bmm1Lt2GYyvLjRXce/TwTxlrRofeHNhQ=;
 b=cA7D3em7VsVwWJVOgaV0mvU6pxUflIQnUg/G8bklHV+q9gwQvwESAsAy5/kmWb2DPAuyIn++ItTer+vURdI0uoAmKn3Z6dpUyJ3EkqT+cQo+OY1BQH3qWdFJki5ABy8XoiO0ZZE8565mRSnPoIyVXeRLKGbG1WISZ0Hfb9AWFg0=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 12 Mar
 2024 09:21:54 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::fc) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:52 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:48 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 09/43] drm/amd/display: Remove legacy code
Date: Tue, 12 Mar 2024 17:20:02 +0800
Message-ID: <20240312092036.3283319-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: fa680559-d2c4-4f62-dc9a-08dc4275db5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j12GBhqnMbbjuz5bFx5U4KJ3c5YxT29W1p0z1HI5uKTJw5ZhlxHgZ7DaTtRMB+yghZWUgYruqM/gJUoxLnGHPPnKHVwO4ZddkNES7T312PGU2S328RnSsN+WBItBobXCDxUrlv5EjyH/pD+JA0xREsTRwLadpK2rLNcCMtHdpaszSgBeRtUkzByNedh02fHrHbnhoUVMWPsSMyqql+aEG9CQTNdRgWxczFRR+xBiHK/bg8r+8fIaB6a5uRh6bjdK4AN9BikQNO+01P7adiPZ7rM60EjevzYom0Qn3pABWG6I2o+e1uSYjkKWTtI2vhLTWzoPccVfQ+d30EdWHiKvosjS1+yvLkNLBCqu1+G/XCDEkf7JeAVCnVMhSlDdMsBOEzu0+VtpnkcH9mQ+7GUcLbjLfE848+Xv8ANX37OmpZ7+lIAX6igEvmgisclrEQzhD7h9xnPME4C2G5mmKgufo3wMi4Esn9s8Na8bW9Otq+JFlCnz8gsT5RSNvIyzarGC5omzYSzIff0GtOPlkmxyBSZDzlD2EfuP8iYvAz+eUcoWgIHxcX/BR00Rc52UNm8igCeHY6rxYy76tcemJuMfW0qkIqV+6KzN6zZVPSb6DbzDlo15OG8+9IMBVpQ4fnJ0ALHCTlPHDo39E416BYpLRlFQELEkBvcNxBzEgLtVM6m15q6kU11mBePJnOEZn1yD/CUu0YJRJ8ZmizpWgYnUw974t+lKvuDbN0c3MaXXE9QwTtawEHELZYwyaeNF37YT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:53.7330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa680559-d2c4-4f62-dc9a-08dc4275db5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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

[Why & How]
Remove legacy code which is unnecessary.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/resource/dcn314/dcn314_resource.c      | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 9bd0d72e74c7..3bae606ed700 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -929,24 +929,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.using_dml2 = false,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-	.disable_dmcu = true,
-	.force_abm_enable = false,
-	.timing_trace = true,
-	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
-	.disable_clock_gate = true,
-	.disable_pplib_clock_request = true,
-	.disable_pplib_wm_range = true,
-	.disable_stutter = false,
-	.scl_reset_length10 = true,
-	.dwb_fi_phase = -1, // -1 = disable
-	.dmub_command_table = true,
-	.enable_tri_buf = true,
-	.use_max_lb = true
-};
-
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1939,8 +1921,6 @@ static bool dcn314_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else
-		dc->debug = debug_defaults_diags;
 
 	/* Disable pipe power gating */
 	dc->debug.disable_dpp_power_gate = true;
-- 
2.37.3

