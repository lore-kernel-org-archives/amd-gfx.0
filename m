Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE31C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C39D10ECBE;
	Fri, 14 Feb 2025 15:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iU0G68yE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E2410ECB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLq+30kvgN4BtRBPcUfgqCP3ClbhTCIj+/wVRXukhKy6KqtrQocdOQrsVNAuMf4STXxNpI6q7OEkndyo1jYMULEFUAqun0n8dMmlW8JqGSWoxTioHvpP7kC+8wfQLGKFgO8LXE0wPXvcNFOwuYxGSEmsu67hO0sX2p9KTmlWHVMTbcrFK1SAXzfqPVfxXEBPkQFZG9ijbPsLR/TdzIFiWfVBkrbmEOXbsFq8++Z4MR5JwWGAinHNB7/yp6lDoeeSkQ3QwyvCAZMrHTYGZWBJHOUxCo49VxF3n+R1FYQCMv4CwZiHp7qVM4+BK1LlbUXENvxEKJy/4EKzNMtQOfEdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1WA+fgASK/TAWOjrQmmdDJs7GBiPu8OYiF/6xWdbEM=;
 b=BNMosM/ohFp6i6+hOADiUZ7nSdlLfQ4EjxU/CwcfYL0otG+qRRsOBIAE1x9RBhbBssEwkTObrCgr7YZUMTXRuVeb31zBqhVBGywEI82lvzeAJ5+cyeqaGNkVfTTCtzvbgoelI8AQ/f1+dhZgkZQnua6Kk59XPItVmTNF1bMSwb+5e8rcrNN6osnMvFJSckB8QlMsmmemgAOqGXOC72nUoRxhskumcNR93l0PiTf6n48d1T+ShRq4q9+O9tPlFa75JGzQRylNsb8TUpzfe4aWEK47UiaOzGIUCK8CFBu5hMfjpF6uQdjCyCLUJL8R2i/YfpwE0f7alfK3a6GTkBKt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1WA+fgASK/TAWOjrQmmdDJs7GBiPu8OYiF/6xWdbEM=;
 b=iU0G68yEvGkD8+aHS9vfbTEkmNLFsDwlqouJ+wyH+ZKAKZ+f+LkYd/XQc1DIe8RkSTFYNXBaIa/wxvWtIcgEGVz06RJ+MLZGlWjX69jOQo0AF6bBmNu4OXZqTeGJjB7e/B64hsgUTprNOLjiPTBB9XvG+BwVD4Q/XEQJw2zj3nU=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:01:34 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6b) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:33 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:32 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Leo Zeng
 <Leo.Zeng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/16] Revert "drm/amd/display: Request HW cursor on DCN3.2
 with SubVP"
Date: Fri, 14 Feb 2025 10:00:20 -0500
Message-ID: <20250214150033.767978-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aa23bd-8a01-4039-7d98-08dd4d0878fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmBWrowZjuJSd//0M2pc/+qmhbr90+PG5V4+dOpG1wxUfSCgNdoYcFFSIOEj?=
 =?us-ascii?Q?E5HUl5QJ6Gk72VhxdzlY2cfLEJqsaJL2QMe9u7SmTUMejlwXENlq+NuwyWrZ?=
 =?us-ascii?Q?KFhsiBNIQKjRtrM4XivfOu/XJ05h8613YnwAkWq9wjzdmqnNylGNTuWWQqa8?=
 =?us-ascii?Q?oXAxS+4vQr8R6mvRiZMZW1FuwS0XPvXQL8BoOoUjshNAfttw17ITYwYMsVVy?=
 =?us-ascii?Q?8+l4tO2jjTC0cR5dmLBI9UwRnAUCo86Bm0M6a6vsvS7g9qm61vOqxe1qyQFg?=
 =?us-ascii?Q?rw/3stgLP/DZozLi2+ztu7kG3TYFpEyBuYHCb0GX0XaXl0sCOnWVxluUNh5E?=
 =?us-ascii?Q?W1rzXY+rtU90zsJH5GO8cTGNIdadUOA/NWOt4Uj/9vKu/oKHS/sALA0V96Xa?=
 =?us-ascii?Q?LQmKt5wDPAIwSwKBjTEC+G2alUuXMjZC1ieogPrNUVQQjSN/dOMXuYyftNpR?=
 =?us-ascii?Q?AitcUFp06Sxtv6gSYCY0xPK0z/+QEzalmhjPoKIbB8u/ATDz/rUdEHmIkIjr?=
 =?us-ascii?Q?JeUu/MOLok3OaGeoBbPwlcbW+vfAZwBqDkyNLaCguqpR1uKMvxPQs6CDmFlo?=
 =?us-ascii?Q?To/zxo2r9F+fHp2dtBOa5ynIOMquFes1Hv0yN7fLB4804Zo3iU51P8jctNWj?=
 =?us-ascii?Q?3gCHyqN1coiIsU/cSNr3FkBHwDltDo9QZ5uZ/BCzG8+Ww7VYmHLKRBHcQVnU?=
 =?us-ascii?Q?DBLFw2rQzn7UU1xhHzWnaYgQ8eUtBaoXcAhIMI5Zz2PcsMhnFNcRUyxNYip7?=
 =?us-ascii?Q?YqTMmn7k4HhfpE7UIlJ1mkiXIgpDgxFrcqO8w2S0sPhWZ0Z6oHXxbVt5v3ir?=
 =?us-ascii?Q?rogYSln48r80QNmwBiW15zfQhIjcTb95StHwdcQz/zlyh6DKj0qlQ1vhIGHq?=
 =?us-ascii?Q?djgctUrFPDRoRLOXb2B0kw+aan0Ze4/Z2SB+IE5bdIi8w5CSKouSn1wvsIVE?=
 =?us-ascii?Q?YwCeikVVImJ5q2wvD1eAFVetwHJUC/zl6Tml6bU7pGaXkUq0UO1g8YOgCqMM?=
 =?us-ascii?Q?I83Bxe5d9p1WFluVH45ckvaCgmghEYagGXaKjBd5yHmdQ4QbSzkxGiLaPlN1?=
 =?us-ascii?Q?XEnbSsC29FVIZ6x7kbGjPsr/c2ZrXWYCfczhM2tLN5YKjyBKRLlZdTbr1ic4?=
 =?us-ascii?Q?TFfz42hNsJKIKT5N5G+H8aShpjRi1r2mM4Zz+cGDV3/RAwtCFqnSDCNOYWTO?=
 =?us-ascii?Q?afXGnbiFZWu75JIkYdQk84qhlDLwz9uNUEMFxZSaC7KKXYqyEysW46vnqBA8?=
 =?us-ascii?Q?mZwkIDk2f2SKWjb+jFIGFk/KbwMm+ASebJ7+SFecFEUvwi3ZQqfV7QKT81RP?=
 =?us-ascii?Q?0T2aknPq4liqhYT67J5bxjXT57N5opabh2jQ4ejXdTFp2qcWtzchtb9iYY8Q?=
 =?us-ascii?Q?QSei9Ijqdow5aE1MVEOULg/LYkhC+gYVUvc1JNKnUFJ2BHiVGsdwJF9enlYb?=
 =?us-ascii?Q?7cxo0YbaX6+A0PN3WtHGq8IyK/VkTkyQ6NUiJ0KMkuWY5QQlp2Z/D2eeejt1?=
 =?us-ascii?Q?3QVuBQgnvVM7GIY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:34.0300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aa23bd-8a01-4039-7d98-08dd4d0878fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

From: Leo Zeng <Leo.Zeng@amd.com>

This reverts commit aaa44ed6cd8af2089d2bf6a2e66a0436fef9791f.

Reason to revert: idle power regression found in testing.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 56dda686e299..6f490d8d7038 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -626,7 +626,6 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
-				!pipe->stream->hw_cursor_req &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
-- 
2.34.1

