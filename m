Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0513112E04;
	Wed,  1 May 2024 07:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tzovca+i";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB8A112E04
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6rB0LM5pyxEkjCEX3uLIAWINr5u77YCK27bKeMdRvI2SvQzCa7S9K79Pdnu8uRLb6jvtY0SqDitWk5UXAmC3F1Eyx2T3bOk/BY8LCHj9/DDHe6B0unUZK05vrEqt5TTMUuJ4u1MAFL3ZmxQNe2THBCdEfKndB+v0tGWuQRK0uQAo9jJw+SvDJUFIGy9idtMj9NGbPU2xWWEEwIgWQU7GpLCI+0i3apM4TVZy2dAwa0xd6TUjaSqWeW3DDNb2M0Dy7BQiUTpNYhW1HEP5hl/ZBnCtfGHx1fkQfjhFgyUm4Wq4s6dUZPptu1bffZvlUto/KYHd2UeWmuzkYktBjUWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQL5+KLwOD67OsC9SKBrTpjCifh3fCrgKG37l2v8EXQ=;
 b=L9jNmiJp6rHs2dsjVA5L+uwYXwwRUTl8bDEZkPgfsUaEzGUOxMgumpZhjdfFz8hNiDTVz3pDrD9oAcCtEyTIRHSp4X82+WOIRSw+TBBqVeyjAinfw9Q2N+33Kq8x5ke6LHJk5fFI8qgB4e4SNlWFzzIYHQYWz0rT4dJXKZ3ByhEnkvUBhwhCwBJfstPQiFFDRKp+vT/X5lrHUBLpO/FsPqyLq+2nz6o/d5NkPKceXzvESzh7cs5k4gO+z757iWW9T+inpqBOKGSq/rK7gaeoYraUDfIoZ8W1+8r+2gEYKuFGa1D253PtV7/3TtCt5ToqFbJhX3Hv9gNQb2hyIryZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQL5+KLwOD67OsC9SKBrTpjCifh3fCrgKG37l2v8EXQ=;
 b=Tzovca+iZMBIfQuMP4abxoJZ5c++6zTtaelah9Wqt6ikIU6P1xwAxz+0lpfdYUC4gkV5rH+JWtc3P5ZmF87sSoXd+KpxBEKPZYp4GirSYF3ozo0V0blSBVwCk52QCa/tfuxZMfKjfcoC/ULQo1m7G6pQJ8GqRqAKtyBrdeavQ7c=
Received: from CH2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:20::15)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:18:12 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::58) by CH2PR07CA0002.outlook.office365.com
 (2603:10b6:610:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 1 May 2024 07:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:11 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:08 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Susanto
 <nicholas.susanto@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/45] drm/amd/display: Enable urgent latency adjustments for
 DCN35
Date: Wed, 1 May 2024 15:16:19 +0800
Message-ID: <20240501071651.3541919-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb6a2d-0f6c-40a1-a9c2-08dc69aedc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S55XmniYyoGYe1gum8ck3V86vxBCib/Rnj5SAhqBsnA5j3wb+m35snbg+hVo?=
 =?us-ascii?Q?f9MxS8ML18+eDA6ATY6PWjiLZa9Bq8wDILTRD/0T2WrU/HY86KIQf/m072OX?=
 =?us-ascii?Q?rn5dyAV12J7u63rK66jE9Q8ZVXlxoDOQ68pcODEShe2YWiIt+r1Oc3ey30Ng?=
 =?us-ascii?Q?BnUk1o5aLhqTRBLvkISTggj06qe3GZymfiXXCYhwBmfx7Q8RDqT0GGj/Bnvl?=
 =?us-ascii?Q?/VyrPnEq7Lj4GmCnESuRf7WcpZaO5unTXA0gdxAvoqladaQda5NTV7oJhnKs?=
 =?us-ascii?Q?D39XjwL6K7K37gPm0LqCj1+gOSSVct9GQOKYiuQN/zALY3LjaclnL5aMIhc/?=
 =?us-ascii?Q?6jhkycThgIrSKocqQbJIvtpYz9HG4nY3+SZUFZv015VgA1LOYHoeRXexEPFG?=
 =?us-ascii?Q?M0sxXhqnFDDfKPv119TgD09l62s272cq7/x4UPYx7v1niob8lLIRfDCcOlq2?=
 =?us-ascii?Q?5FewgLG8AaTmNgRUYJYofuI2A3P+zYL++5SwVrxKU9Msl7IaS0dn3PwFHaCe?=
 =?us-ascii?Q?d861wM5gHmNTYmHfpRQ/U829B+stuWgxTJuMWLPFnr8Kye0PN/x4Qma1Qw6X?=
 =?us-ascii?Q?Igg9xeKR3c0NkhI/JD91oCMrxoOfVRB168cr2i0C9I4uK7Z1HIcVXFi3i7Jv?=
 =?us-ascii?Q?S4aCYWTIZQJ6cCu1Let9+uKtd5L74D3ezADcLgRPdfrL37dMWbKisNyUHNef?=
 =?us-ascii?Q?dYRiPAu9cBFzLVgp50e4s9jQte0+sKPQcEAw/sWl5jl9Ny6U9NKxS2LodzlK?=
 =?us-ascii?Q?NrWwPN+PlTGEDrDVdxyZV+4p+DvJFagPe0VVZVKRl55LyR5zNLI53iFAbh7E?=
 =?us-ascii?Q?FWOjHoskqeB3NR96KrXB4V3LwATM6qa10LFpZhRTM8fsWmF3ozyshuN7RhpF?=
 =?us-ascii?Q?QEMrl3JW4Y+kLjRHR5a+enjwGXfBUHq4NeA5/C8SJdYL3EmbMH09mkGElIgn?=
 =?us-ascii?Q?FZjNizDz7OgIoTY15dI/ys+8vMAcuhtFVYfcc3FBu+b6J/lIDWB50Tzdw8VK?=
 =?us-ascii?Q?vAR83YEBeknNpiElaM/3ay9ZEalEgHwRuPEVgK/ICWjyJqtbRSvyJhLsXwDk?=
 =?us-ascii?Q?UPakt5yXK1cg16L1umBnSCFIhXMdF8zXmNZC1bmRTSFAyNwhWiO2KOpKYRTL?=
 =?us-ascii?Q?Ir/kNwfxe1rymuo4WD3PzFgOMOb8hyvoQE0vzy322W33m9g5ULF72H3YB9AH?=
 =?us-ascii?Q?NryYL1oeNu8yi/bj7c3JUxIzONm0aqaY+KdI3+WydDobVV/pGhxyYcrbS0Ej?=
 =?us-ascii?Q?l7rkijEHLi2zrecJqabmFOMM9PPK84R53zRmzgvolrDe7/W8hbMo2XHsFHxx?=
 =?us-ascii?Q?oF208XA5sz1F7mcOoJSx1wheK0sbWPvHMHrI4wVU/dObXTNVWqcnzOYXe9j6?=
 =?us-ascii?Q?pl86opL2tYubXDthMjEjMGrSX77E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:11.9059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb6a2d-0f6c-40a1-a9c2-08dc69aedc3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]
Underflow occurs when running Netflix in a 4k144 eDP + 4k60 HDMI FRL
setup. It is caused by latency varying based on the DCFCLK/FCLK state.

[How]
Enable urgent latency adjustment and match the reference to existing
ASIC that also see increased latency at low FCLK.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index add169162f2a..60f251cf973b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 0,
+	.do_urgent_latency_adjustment = 1,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-- 
2.34.1

