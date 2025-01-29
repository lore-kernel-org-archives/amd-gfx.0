Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C08FC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE51810E728;
	Wed, 29 Jan 2025 02:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3aFF/HK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C31510E728
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlFrEnN3BLV4jKKFUE8HQ3OKMc3vflVvuj8IAo/wX3oMq4O5uPJ05bS/i6pTSK6/zhuJS2zbnaGtB4k3Tj/APrGgSWjuIgTdW93I3d84heaRMGIbLB0L2l/7nUrJ0/NPpV+3snYXmVB2kP5J4S14xvUFHC6mct7q5xSkChK5bzzHJvRgX2fIj/K14TaziEQSPx8ah0qoHOoustlWxbvNfaSV7qKfG6TJSI1T8dzadjGFoBrbyI95ay/PG8c24STxBm7uvMx/CZsxzCoYoZL2tmLu5t/rh0i2ww31iWQKRcvuhdCvOFFHbx5JI5hTt+loMWPy1P/YoBb0q9SOJHt4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOhUA5mJZQR/q1sCWgi72g6PrbxwTEdbmXhBhabe49Y=;
 b=cLyZDh7szyx5dYIG0D/XTfGgXd+9OVv4RNLFPE0tF+MF+GHnHSR36J1u7VZAZ9GEMCSOowRRFrUtw70+i7OQyX/dUXfKDnZ1R3AYJ5SXuMQF5+THGVWcE8GWkcOjjax0ybEu4Y7XR/nLFY5Luy1p8mc3lWFAQ1zTQU3Vi7ZJoq4d8RZJpnlfuFqIG6vRZ4Lv9/cnHnXRYReJTupfoDStM4X8jJD4Z9AqNlJyLzWQ1G+ytBzFEHpdO7SOGkiBfYU6G79iKMXCwzuEXVETYHeH/tcb/l/IEBrN/LCbah5fhzDD2DIX8dVlOwfB9jRQ/htFPsQOLhV5iiRwFLw5aI2vZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOhUA5mJZQR/q1sCWgi72g6PrbxwTEdbmXhBhabe49Y=;
 b=V3aFF/HKo1t/KHJDfs2JvFj9xGuOLOcbRB9+UmV5dA77h7EjGoSACiufdTuj60xgjpJAGIWj9Vyqzi3OlIzt2X1DrqiclvIBv4O3w7OkXzrX9Elz7gVuNj2w0l9bbvf9McKKCbDK/Fh9s6jNnWhBDIgNOifSo5Ptx4DTCDUKQok=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 02:56:38 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5a) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 02:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:56:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:56:34 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Brandon Syu
 <Brandon.Syu@amd.com>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/10] Revert "drm/amd/display: Exit idle optimizations before
 attempt to access PHY"
Date: Tue, 28 Jan 2025 19:53:47 -0700
Message-ID: <20250129025458.2120268-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129025458.2120268-1-alex.hung@amd.com>
References: <20250129025458.2120268-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: e10d6350-4d91-4580-70bf-08dd40108c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b645it4GnAsQq//mJnIYOuwMHHtHGCSQQ116KMRY3FRs1XhJD153OtQVEqfJ?=
 =?us-ascii?Q?NzDAIk7ZQTG8tHdxG6HLI2wsbqjuOs8qkQ8WmPlcYNafKqZQ6QVHDMcNFJRg?=
 =?us-ascii?Q?DRRAAlW7tijs+WQdfVnVQ8gkr65d2qdqML3VpbEPiIYb4kIluFe+iIcmiaP/?=
 =?us-ascii?Q?x7IRUne35yY11Zt7tnb8pCVfsYiC1KfYR1SLPpzfOmoU6qRVf7GYPJRNsn9w?=
 =?us-ascii?Q?BOGYYn1nW3TWu4jJWEsqzIV1BDJsPYT3NICjB/BespPRJ6PGzoQC8TKQ/gEb?=
 =?us-ascii?Q?sJ06rbc4G4y+NubFWkt6K6D9k9x3z/QNr2tGBbntmgEsMDqg1xNlQ2sQl6Tu?=
 =?us-ascii?Q?DZ0/injBW6H5iZvuZxgH3vaH0L/+wvNGse92MfFi7q3oLL/3iXvl6VgevHye?=
 =?us-ascii?Q?7a23NXx6lZIUYFrt894Pjc9vLLQo4GbOpVv20PnaVYHUBAavCcwVwccIIrHc?=
 =?us-ascii?Q?ceMnUlF7yvY256rf4YV+4ybXoXSfvn1j/Q6rXlAbzhQtCt+SdsYMofsu69J4?=
 =?us-ascii?Q?7KlrLFpIwAp/ZqdKKsj3TxPbNfnL9vVm6sWJwGzdL/+R5eLyuzcE154F0lmc?=
 =?us-ascii?Q?admJHNNJuIOrsAtHp/X6zS2+go/PQiYqjJ22KlqLJnhBv0hQWPMSLOqrHNS5?=
 =?us-ascii?Q?RcZGU2fFBC/8pxcbtpitUNIC1kUqxYMkbC//OOTybzgB0BPoq/Pbt+4tCIEf?=
 =?us-ascii?Q?UqEz1IOKr3h8CRyifVlVLKYQ12PZlfHFR/QwF1DsTRpGmQR7BbPhObBzk929?=
 =?us-ascii?Q?/HKQ72ZCAIbpq+kvV7c7js2zOUVZ/MK4oy1A4Nw50JF1NiV7mohA08X8AKvm?=
 =?us-ascii?Q?Inux/qayFTXA9PhY9CgQYfpkj4IYHhretlNnF11b7Wvyuz/V8I2xF8TrW+K8?=
 =?us-ascii?Q?36hCfU0tjUpcmGjD+xRkRJ42YIRBcoBazX/kJfyHeiORvjLD+AX+kAhi12Ub?=
 =?us-ascii?Q?wStPbbyFwESIyaziMlSmD42q9iBZklsdcSeG86cUQR8+a94oktl9IXr1csqM?=
 =?us-ascii?Q?l9/V3FeoVkMEjaXKeRhky6PoJO9OIWTrjm4D3qIyjwJlUJmUfavVaB+Xj4Kz?=
 =?us-ascii?Q?/wdb9zpVl4sipeA0y3VtDNy1QjLT+uSLROj3GWRM/kE7MeJxuyw2DBbsTaYM?=
 =?us-ascii?Q?Q2hYUNJzZus8nxlPNUU9dmnQfNeCWm6oqYG2N3Fw7YV59YCpENyz0d66oaNl?=
 =?us-ascii?Q?qOd36iGxPHd3fVxQUoFaNc6PVLYW7Qo2qB+66uJZFk6NQpEy6S5XF/0+aKLd?=
 =?us-ascii?Q?h2ZF+rulN2iCqpBSzZbHY0Iy8JkWrCxNwjwTWi77C1lFnWqx6pVWJ+45fDJI?=
 =?us-ascii?Q?+vspPFJdZA/QiK+9Vq9y4MGo1xQnSDe13ncjWJnyq5EeJ5i10pXUDEKP/3W+?=
 =?us-ascii?Q?kgt49/eXXWHN/Ri90rAkLzyqA0BKGwWuP1lVEh+bLKqzMczNCDEVnGWEnigQ?=
 =?us-ascii?Q?vpV4X05Sc9Wy7wmPoSih/kwzTp49v1IROBL5fQjZnfda7Y5NbOHqKMIEJRUF?=
 =?us-ascii?Q?Pc2G8R4IRRDwqIs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:56:37.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10d6350-4d91-4580-70bf-08dd40108c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
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

From: Brandon Syu <Brandon.Syu@amd.com>

This reverts commit de612738e9771bd66aeb20044486c457c512f684.

Reason to revert: screen flashes or gray screen appeared half of the
screen after resume from S4/S5.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 81f4c386c287..e033e6476fe5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1890,7 +1890,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
-	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1967,8 +1966,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1981,8 +1978,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.43.0

