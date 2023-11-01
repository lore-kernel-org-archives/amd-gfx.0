Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A790C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999D210E77D;
	Wed,  1 Nov 2023 20:09:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6C810E77D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2/O2+TDAL0z3np4diZEOAGaneUgoVa+3EUTTaZdDyJwwiC++QsyGv7NPFmthrDMXyv397oVjzt/Q5U58xoP3i4wvhaFRZBJT6NoHCktK/eTSTz9Z9A6jtvw7Zi+ki4FBbU7xqQEsr2ykeNtUT5nNEKpmbrNIVFUWKB5XBZtczaK9CAJq3zqIeYlei9S8PlQTKWzvs0/Fjbyd9yVFfBtyrWfloGAZ6klKbHwgLo1J2n23lk1+d/21a2rlPdCdzBdWq+prW+4LRn0pphXb0+4hDN7YgK8ESo5UfmLGPrE9H3coABulBRPRgloJC/mqJOP29AA2NZB13/zGmlFulWbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfyQ2ILdrTCiLhdq1U2BM7yb+ZfRTIDYNvvq7AE9Q+k=;
 b=CDeVjggZgNUdlt+5JcJb1+hLQ8S2x6Ciz5mFyS5xXAZSq/kBNPTJ3cdezSNSLE7YdMc/F9FY7w5DkZV9IjkPEse4Y7BdX132hpyanuxCUmn+JvkzlxV9HJGxeh4Akvn1wgLG2PdKL8XxmLSDVy34vxIimmtyyiQJhugJyGFeatmYXTbeqMz8DzMwKTvDHqBrKFprMUUOSB45K+eQttrjkSHNCuPy257dkEgH49e7Q4zF3mRht9ru9y1QwPO/40U1YkcMAKioz4TxcUwCBtZ+PacD/5wT433cdAHStbESpO5NP1F2fYhGP5zkFkJlHQRuBUnOpE8+H0aZ/RvAJ38KqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfyQ2ILdrTCiLhdq1U2BM7yb+ZfRTIDYNvvq7AE9Q+k=;
 b=2aPuhcXf3p9PHDTWErYrDCvQ+Fsw6ZE6rFgUuraVQqEvEJCCHNBxeqcsIjbct1hC9guY9LXMbQ7Ul9Rf+lgNj456FvL9ICfk/sHtQATni8i06ecItlJV3XXKuigrC2cMGMJt+EabQBeEUqjV5gGvNlQucfiNmDc1qZOYk22g19Q=
Received: from MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.32; Wed, 1 Nov
 2023 20:09:02 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::a7) by MN2PR10CA0009.outlook.office365.com
 (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:56 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:55 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: Disable OTG for mode timing switch on
 DCN35
Date: Wed, 1 Nov 2023 16:08:27 -0400
Message-ID: <20231101200832.995436-8-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM8PR12MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eb0008-391b-4406-b401-08dbdb166428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt9tgs9dn/prj+rK8mK708SL+ZT4bF2L8hD12c+wObI14DhKcBbwi/6FkD9RK9Om6Uq5gHjBFWBoRnhoHos2/l5A1DR00iuSZxt/33BNqpnZPPui8rXHjkjdJ09rhcvI3GsH2ysPpOWTs/kjE61YuO3t+TkQzatly4o7QwjATbZ2ASAsr88dSiZeK5EjlZ7pbOUtPddBdlGmZE23j3A7Y3xM3AhlT9UIpSzaAMHbgTGclKWH5OXnv+kB/j5grKW/V6Ie/OMFh6Kn1ExvOemCt7Bkb6vbOqbrPv6CpDzP1f9KJewF6QEOL5wylNrIRBeSAr2qqStRBT+erJ2FIsMo/ckT0s5hT+yqxaHI8IrVFVsI/FVQT18m2uFSysATn/DyABI7zckdSBmn5cJ1TxuMPsT7unjr5vHRvAswYlgtCMqWsgG5NYy1Q8uUCuwazf1pcJrnEFU2LgJczsXG1jEFCF+3Vb2ytDFwPcFtJd1jbtoiPQamVlg4dyCvEQcWX48jeXurewzvG4LOMXGjhB+NA6s3JiYZih/p3yCnVEEUAmgkTlghdU4fsbtmrap9TPrPszFTVzBYnXc2Ggfq02X0siyopo5uPP78FYFXWzXytk6jOiQ3FGTxk08WKovc1Uw4w9B0A/9rjAHtRHgI7X4QDJZQ7amYm1qTDIV9vaL+6gWTk+r5rAaBGP01EwbMBhqTi01yQ7CoIBdoF1Eq0w7r60cAKz8PkOio2rnMTHSYycV6L0psW6aR05pOFUrD2mt/Ama2j75NL2aaObM2AG1XLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(26005)(2616005)(1076003)(478600001)(47076005)(6666004)(36860700001)(426003)(7696005)(4326008)(5660300002)(2906002)(83380400001)(41300700001)(70206006)(8936002)(316002)(6916009)(8676002)(70586007)(54906003)(336012)(356005)(82740400003)(86362001)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:01.7022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eb0008-391b-4406-b401-08dbdb166428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why]
Doing a mode timing change causes a hang when OTG is not disabled.

[how]
Add link_enc null check in disable_otg_wa to cover this case.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 085ac191c94f..0fa4fcd00de2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -124,7 +124,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+				     !pipe->stream->link_enc)) {
 			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
 
 			if (disable) {
-- 
2.25.1

