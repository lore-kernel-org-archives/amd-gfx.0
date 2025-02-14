Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F32C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE3410EC9A;
	Fri, 14 Feb 2025 15:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KDoUCFg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5DD10E469
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVY8mFVu7FA82fSpZMEmQ0GEs6WVDLT3v1ohwRPYQkjDzM4QSgZbuPBHDfMk639PV0LX2+2i4qCt7jTQtIh1gAPZb5bGkVvDsPrCLKcIww4nnqs82gZ0k2dVSHFGBNfNidnUEg0MiubawBB0y0hoNUd6n1D3CeAspnP8O1wi5hxCh30x0fgTePLY8qKMtMI3zQ7U285ipVgKjrzGHI5ICNT38hbP/Nupr+7p6uZ49ElllgWWTBZ6U3Kqtdyw8HwbUCir/+KwQOevrYKFOmdOUwcmr16S0wEDeP71D+0u4W33Wn3Se6LbSxGe4QICu6gDuDNoZlUy4dOtscGRQ4JACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylFGzORt7Khtw+bqS/zlKVSVBLnbyhzABG7yvNui/tE=;
 b=UBpZwZ4wzqKzfbNvmV41ViLiKQa47Y3ZyA5Xm/amWVWR9FMPMY2MgpZHyUlemGdUeNSUOvRy6UgmFU/6txnsySiWxHUtnY64IUNrJWLzMNhZbNN5wrOiI9bH4BaWX3gog1uIf78OEmQrBy2YTOGHwryswQz5S41CXVaVXBJqPPO+jt8ptob1oVe+6MLoirzYcrSq/ZMKFnrNaf0AArY7xFoMpn5KjD9Sk73NOs5tKcyfPK9JAOfRvK9c+Ag0fpH4+dtu1T8i93EBbeudqgyefjma23r7TWqWS9WD2qbuRYDsl1sZHMJWPkvgh6D61fcP/0kVSONK+3K8uY9CksD33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylFGzORt7Khtw+bqS/zlKVSVBLnbyhzABG7yvNui/tE=;
 b=4KDoUCFg2c8haZJ6xe0PzGQyTgEuS5bfZKm1nSdNIBL10aYb1/KDsQ9OrP6ShQqKKE7O2G4M0HHFxOQJSleLR1J4jZ2qwXz2a7utYSHIK9SrZ+m2WbXHaNLNXgUzSReX0vSasXjfLj7+p9jYL4DoNCTL8XqTin/GH7qdjTAHWPM=
Received: from CH2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:610:53::13)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 14 Feb
 2025 15:01:32 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::16) by CH2PR17CA0003.outlook.office365.com
 (2603:10b6:610:53::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:31 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:31 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ovidiu Bunea
 <Ovidiu.Bunea@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Exit idle optimizations before
 accessing PHY
Date: Fri, 14 Feb 2025 10:00:18 -0500
Message-ID: <20250214150033.767978-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 5680b63d-161b-4ece-6a7c-08dd4d0877e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DfwWo8vmyj2RaT3n2STYmrsmP7asv4MBSl81Pi4r80Im8fs0XoGXhrNFRaOe?=
 =?us-ascii?Q?P0jlJ9lo9HyrUym2nopZgSjt9qXKYTQA89k7lMZXVQsLwM4KFZt7XaSn3qZU?=
 =?us-ascii?Q?ABxf2IjJhqt/hfP4HY7INmVKmRdATfu9CcfrmDS/RFsG3Znyqb3GOVSxbSoI?=
 =?us-ascii?Q?umGRDM2tNvFEqdGjN4Pn5r9IEPqE+ltc4FVnCuvBZrvxeuEVxkFrlUsuu6Fy?=
 =?us-ascii?Q?+DkvUzSP/f6qlej1GWAVtEcjhRS0FG+p2arWKhUyYCtpQ6EQz08Mqv5VzbPA?=
 =?us-ascii?Q?WsMLZmvhGjGnp2rHe947RvZrTyPE/VZUjk03IsVhN3ERxXzEac7Y/4Ejf299?=
 =?us-ascii?Q?As2mqMP6/2d94hMiMkMlvwzfui7Atfy8/6IyYAvT0Ldzsx4qUuzpTXdPGQqo?=
 =?us-ascii?Q?bvCGAeXADKszSu5VM1hMOYV0d+8rQ3tPJWIP1rJ7rp+HB35bv/QIL6kTCIzi?=
 =?us-ascii?Q?Nw2Ntk6vwtM/yYW8GhObQp4y2YZZUiV4Ab5nxjxYxiYo71zThSDSmRvE+F+H?=
 =?us-ascii?Q?lswDm6XTPsmT/jEni7DeRoyA9XDI69QJ4FKiDImI4Rngi3XVNhT5U4J4NPzL?=
 =?us-ascii?Q?dtoqivltQ+dcFoBFI0Wr50S/klOQpyvhgC/+1ohjX1OOfOiCEiAXTYL39p+b?=
 =?us-ascii?Q?T56X3cJT4FRtSER5kODWr96ni5OIBDtXJ7rgNbutt3g6IMw2GuCmKNfHw2uk?=
 =?us-ascii?Q?4/CaRIHLl2qOUXi+V4NDe+MEYhPwkmO+WdbXm5GTBznqLJ94ZgNF/ukTjif0?=
 =?us-ascii?Q?RFaSKre74/aovfbW3Txkxr0gxSJamqBnoKNnJO7ddjd5ocjHvsVWRFw6Iw6A?=
 =?us-ascii?Q?NaxyIOqvyD3A2QoZkXJj7XYxrywS6m1X84decnp0EVQZ7l2C4CV0S0a7Ycv/?=
 =?us-ascii?Q?oPx5zrwddYLVSr29Gaxoa546pji23ZXrnMQVuUCFKDTH+h/gFHgu08HaLkFU?=
 =?us-ascii?Q?MU3MC6u6wCPrKSF3r8nGUX7hTevaoNn7jpy6NOuBcnXYfk0VTuYe3IiueniG?=
 =?us-ascii?Q?lqP1BFJPUL1OraXZT9+TGzrxHOitpbV+qX5ol/d0lpdM2qMbVAouuRJzf+yJ?=
 =?us-ascii?Q?7CZK4DnGx5e4vnKhoutJGt6oZqw4XCLEX+3d1++gfkGDzHToYsyzkO4OUfSv?=
 =?us-ascii?Q?SzJs+FS5LcxacWvTG0KkVaitQ/QZncWxUXbGs3SHE4TARon1H7qDdW2Yfiyx?=
 =?us-ascii?Q?7EuNN1DlO4sA9DLe9BiN/ZmfENdjKafCbUJn0H8kSJ6+fR8Zgtw31ERW0bOS?=
 =?us-ascii?Q?5Uj5erpBpKU9RyNLIWugcOwhwe9SyHP+gO8j5LNqsEIBDuMlPL5pIXS0KuMk?=
 =?us-ascii?Q?Qs2j/EB5iRmeh4HhcZ1hKcw53aZqXmG56nq1pUIyboFOambyCtAzqyMkwb48?=
 =?us-ascii?Q?xrfo+4AJ7dpSAHVsXQGxJ19Pwq/nwO//f5PxZ27Xw+6m99RhC7W7Y2Z4FGJj?=
 =?us-ascii?Q?JNoNYLqp+9Ri3uwLtYrulVLJLuMXLnWPmpuBVSgnXpqeutw6wn6PvgD/q6ko?=
 =?us-ascii?Q?hu1qFEjpSCAQaUs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:32.2166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5680b63d-161b-4ece-6a7c-08dd4d0877e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
By default, DCN HW is in idle optimized state which does not allow access
to PHY registers. If BIOS powers up the DCN, it is fine because they will
power up everything. Only exit idle optimized state when not taking control
from VBIOS.

Fixes: 53f82eb16293 ("Revert "drm/amd/display: Exit idle optimizations before attempt to access PHY"")

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7572448e5b9f..935d08d3a670 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1891,6 +1891,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1967,6 +1968,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1979,6 +1982,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.34.1

