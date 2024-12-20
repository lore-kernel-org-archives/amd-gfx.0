Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F601E7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D1A10F06E;
	Fri, 20 Dec 2024 21:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sSO2/KLb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D33810F06E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW1HzK3x+wxspntROOF5PWoetEaIVTXG0RD2fB8hwZTVzqmQz6Mf44lPsbn9N9OUzBNKpY/jrhPLEClVrnlJ+uKL3VWlDjIbNtoVdEHQNqHOtxhNxf2c/gIJigu/F0HYrVMi2DQl0B4dztyb+tQBRROAiiWBhiAzmn85zHXTbFsML+9mB9XCpeMQHFXTN+negSioIucPmyTnS8Yqj2Qrl4oucKY02DNPyHOfOmSpn6oNPFC7v0HSUdVFGHaEQKpl/eLhtcn5tLmPa1I9lblqo7WW6x8BthJ7VgW8ib4u26XZ9XM08nNc0XeliZ63qcf+isZcKTozCyOq2u/Kjir7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGrlkNc/kLDqtJHV0DfjMrPXxhLUY26rulPJp8JChmU=;
 b=yU4KhFh44RY/3r0/2C2Y/mUBMDhpe6ep0rCSjTy2+c1EdX510C5K0/BWRssLaxutggO0ewvFphY0lj8iL+JwT46aXuGFhLNeCmsby1CT8azw7YGTM9+0gUJvN7Oh+x3yF2A122gJyobUxyt06ddLZ/npFne7Kt5JSeHAHl5CynOZMWbc09anXhNhUEYCBPWK2mDumwJsYFAgTXq0+sX53NyiZkFT7gnvhLSGZxOe6m1E1V6e6BnjLegcoSKrD4Xrc8PqwzM4dWpJYemOiIJVJEmEehdAqjLdLiK2obNE+O3I/A/+1qq//B6+7l9/ICCiTCLAKg3qOS/EaNhwcrM3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGrlkNc/kLDqtJHV0DfjMrPXxhLUY26rulPJp8JChmU=;
 b=sSO2/KLbuVBOoCgXoQ3/CiPMoa3aRZ0r3d5ppLGamgr6zpIWyfmmN/yINGNRsGzd1HTjL6D7R9ij7xUnmvqcTmuyrzeULKbeamLFgjPLTUSGoSG8cPDWze9XcadtuqnZR1eJMHeRcGbffWmWF41GDNiA0SQvDwAa6eazTq8QNLM=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:54 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b9) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 21:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:50 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:50 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Michael Strauss <michael.strauss@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Add expanded HBlank field to
 dc_crtc_timing
Date: Fri, 20 Dec 2024 16:48:33 -0500
Message-ID: <20241220214855.2608618-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0843be18-e993-477d-bae3-08dd2140608c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfAPDs8lR0RrtPfgEjveGNNFpVcREvlmbJjWh8e/+U/L+qiNgOgDSYwiZi+/?=
 =?us-ascii?Q?G5APRUv4IF9lmdIEJ3hofWpjzQKIeb/49LsxDZYiDxbjBrb7At6hHRCa/jqN?=
 =?us-ascii?Q?jDUuIuswWmurxh5Q12Si3y0G9XRvYzWLY6T2X1Vy1MIyy2qrSarzVJxfRT+1?=
 =?us-ascii?Q?y3YNC5UCYf5ETZ23J8lCsVUi32KVDfUw4MLS8vte8sZK65twivxtNIcFaP7+?=
 =?us-ascii?Q?N+ZkJ/FaYVpf3f+uK+hRPjJC8aswaYV/pi0JgZ4wZLDOm2dMHphHnjPhU/vh?=
 =?us-ascii?Q?j6sOuU4iBd25r9XZPnkeT+EJ6lOG1O7F9rZT+BL26+zjD1C87uD1FYtLWm3C?=
 =?us-ascii?Q?ckRBi1Y5ydmAUpLfH//wiWAHyPa9qWS+zA4w1JlJgcZcZ0QmOqKbLXFM52lA?=
 =?us-ascii?Q?vqN+LnFhIP3SsIJC/v5gVQvKVPEbAn48VanmhXpBWlysRFz+H6i625s8pcCX?=
 =?us-ascii?Q?anZQ47HPsy7xzhocmJcTtMo796yjBRlwHuRSrNakuKHt5pD4xYtlu+Zi9HDo?=
 =?us-ascii?Q?5vl/Z5+LLgc976jQULGStu2Z6LH4iFHQ4l9RBE62kJSnY3LBs8dzL20cGPm+?=
 =?us-ascii?Q?Xt0AW6gIileIfmWgcZ/LpafI6wZ5UlOp9OxhEHT8Uq3CyfrlLdFYpH+xXIAZ?=
 =?us-ascii?Q?cn+5OROmWauLoeAYyAeQipUpKEFndRiMZJXsAU53Xw5sCPFaDHXV+hqYCjv/?=
 =?us-ascii?Q?5XQe1kcVUC/zbBFCfpqAmV22wjW/OEhSJzM5T7AW7n8TxQ/WHx3Epq568Fnt?=
 =?us-ascii?Q?vY5m/AsWsSSEb/N7mkCeXdj4iOE9vai4kPVionm5chS3HVf3aaCvVRQVykvX?=
 =?us-ascii?Q?Pw14Z5Yok641gLZuVaUph/MgR1Z/l+RS2cPtmcbZ2/yRHVd99ZCyFlaPk6qu?=
 =?us-ascii?Q?y3qwvhw2ghGi/XRT4YPGcanjozBv9XZfIr/TYR+fmnksH+q1Dm0yoFiLLdgj?=
 =?us-ascii?Q?Nffjb6ZCJSWeSk3Tnx5YpUQf2bPdQRNGShAPlYR16ol9ryDaShXl9k0NWhCe?=
 =?us-ascii?Q?xkfg8IAO76CKuA4Rl1alDUXmZ4wMVe6ZyY+zbQF7PP5SKTAQNkz6iPxe+pYx?=
 =?us-ascii?Q?jZsdF0NF9sYhuIOt4yf9o0GJX+bQRh+HR6bAcKEEpiioZN2NDWaGrXz07rA8?=
 =?us-ascii?Q?XZgZOYDjRHIrAp5URnkqsbpPF5opTrhw0icaxLYjdqyrV6ZwI8AFu6AlUNCn?=
 =?us-ascii?Q?5aKE7QZRSUXFpUmvkZWMoS8rw7JWc3PW8M2sKzo814UMsNH2gTJXPqnV2h0I?=
 =?us-ascii?Q?Tq144Cow+pE25Y8dl23woWxEu9rYbX7PzN1L1ZTHPNjafeu7wwwiK1hpCh4P?=
 =?us-ascii?Q?Xicla97lorC/1ZTp+ty4y+folxYvIfwS0SJDYQZWePQ2szXw3vVJWdUkkcQf?=
 =?us-ascii?Q?cdrViHJGDlMD5LIVuIJZVbkzDhZJAnL7sgIKoLFJPCjTTcPgsmFVbId48z7T?=
 =?us-ascii?Q?y3g5/ATtVb76zdT+itH3wXlXV3uhyMPqyD77gaLZHr+25B+f6xG2AQabSGgc?=
 =?us-ascii?Q?cGhS+mqGG1IFryk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:53.6218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843be18-e993-477d-bae3-08dd2140608c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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

From: George Shen <george.shen@amd.com>

[Why]
For DP HBlank expansion/reduction, the HBlank parameters of the original
EDID timing needs to be notified to the sink in order for the timing to
be reduced back to the original HBlank size.

[How]
Add parameter in dc_crtc_timing to track the increased HBlank.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index c10567ec1c81..8a6e3dfa4230 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -975,6 +975,9 @@ struct dc_crtc_timing {
 	struct dc_crtc_timing_flags flags;
 	uint32_t dsc_fixed_bits_per_pixel_x16; /* DSC target bitrate in 1/16 of bpp (e.g. 128 -> 8bpp) */
 	struct dc_dsc_config dsc_cfg;
+
+	/* The number of pixels that HBlank has been expanded by from the original EDID timing. */
+	uint32_t expanded_hblank;
 };
 
 enum trigger_delay {
-- 
2.34.1

