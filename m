Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95955C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7227112D51;
	Tue, 12 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jD6I4e0N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49873112D45
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntEEWNPcyAM0cMtuapY7tL/QC2XpeRJAfGDmZYGugzFfymgOTOmNbHlBcQ/fRoUF8cwZHH1c5RecmMBbEdhcTPHebnQGkLmu2vm5Q5CDxJ9FLB9XPVsX6MeIafbxvyBDuJw3ieW8iFtLwhcb1E17bKvagqU0fJzXuPLzUEjluTtAhxA/BufzE4xOXEffNEJj4PwS+inx4QDLKNqAk4mQ2jJ5Zx3qNLbEtgKOb3BjUYm7TkhtCH0U6MxkkfmpIz6AkbGjQw9KLBovjRXfL3utDhpPUtouiHNIx/YRlx6O/NE2qDmCq36dbzmdkgB7GkTHQB2Ycxp/qLg017IAt0BZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+Q7eWzgqcgxd2LmE4+xK1ZENc1AGnRzn4uDfwBO3Fs=;
 b=N66gsY56q5ZMvfFRjieqKcbsByBXVNX6Njuzku6gNSqU+FU3kBhyndKjG0PemlRKyFDdBUbZ7IU4uO1XCd2rXhBklX+Xlil1jX17S7llqyDXxVk8j7SEAj9l6BdS3+OO8ixQ1KPlKNgnaFUQ+6gHizFn7sHOUDW/gtnUrXx47vT5pyYEZkh/E9gLqt9vR/4r4GsqWxREIHdjw3FMzZfOK2lwJBE3L8jRyzbPf1oEffiGACSEL9wSM07QnhxPh6zzis4QdZsCPBqcsRlNB8k+jlrTkFYJoVjfPn0LBbqOOrSF/TovG/plXI8O2MjiWdh6J30oFxL2d2WlQbetYHhw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+Q7eWzgqcgxd2LmE4+xK1ZENc1AGnRzn4uDfwBO3Fs=;
 b=jD6I4e0NEiQb0T2GdLQAzwWe/kZgS0FAAogFDHooWwDbVuoeEPM7bTEXyuQxVjteEQ3T6/YdwMi9EXmtPstd0Y/UY2eHc3vUasiZuGzUfobU3gZIOMew51lSRGAAATCxul5Glwi59sCeMySEpgTRa29YktR7ZfIkmQdHCdFrA2k=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:24:45 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::91) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:44 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 37/43] drm/amd/display: Enable optimized handshake for DCN35
Date: Tue, 12 Mar 2024 17:20:30 +0800
Message-ID: <20240312092036.3283319-38-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcdb8ae-39ad-4420-198b-08dc42764166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cOPl/cdCDbalQvh5PKRKhE7DJVSL4H9jjfj8P4/t6E5OTU5hzRr7/D3LrmnkovbuYDbxFoM+d8YrzUL4F2qRH2i1aIozfEz4A1gL3rTRUHf6MYyMuRkkvaf51JOsk/PoOqvBUpA+43Vm1eKXAe35bvqiO+L74gzBEVmThGbqijKvE+SSJR7tTuKHosKLB/NJkGiu9DLHE0iuQffpKDY6CeRtDP0YRq1iou5CKZINYWvgq0jnoK3w+XP6EcwCQsUdMdYoguLVs73P8AEuPVWXDs9s0dHP92fJIn9VNGhagTjXKFcAYV/ANhETnWDzX9W5q3E503l9U/UtsUvXNKlq5CkpD1TftlHcAKCYmUIBsbvX+9Xrpr+E0wUux/ymB66MFmtP9pOoyWhzZ8R2WOmCWvGVOqFpRcPDgGfxl9iGRBWx71M2NFVZmJR3JCzAfgKWx2efTXC9RD+5u8pTErheVWewSVH98QIejoZgS8CLRpOBp7nObfgaPbg3GgLqhlYmkyQPouIdCZQ4WzCtxVIeq6XdXHj+IyWm5radWllWc7T1jHM7DYCw9VBd7XWefpuOR2t6hOYDTSKl3tgFFOcyy5Rt5+M4f+R0FBo+8yfhlr8kMXz3HYrnVPKhcHoexBvBpBlvSogIAjZJsNVtNl/O28+FWQgnffsuONT0BmOrABPLm7Z1Pso8wNpUSozh67mjt+QEj0fWmmM75d/PMarON4WyVYiRWLv+T3CwzJtM54L60ANVUOZ+OEl61CiBVVW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:44.9614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcdb8ae-39ad-4420-198b-08dc42764166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To reduce the handshake overhead for static screen and video playback.

[How]
Flip the debug option to enable by default.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index a8f4023ff3b1..4ba234b01f04 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -785,6 +785,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ips2_entry_delay_us = 800,
 	.disable_dmub_reallow_idle = true,
 	.static_screen_wait_frames = 2,
+	.optimize_ips_handshake = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.37.3

