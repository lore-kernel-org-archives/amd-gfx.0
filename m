Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F29C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D7110E69C;
	Wed, 14 Feb 2024 18:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JdGDFgir";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596FC10E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHPtkZ8+OHwSIR2Y4CdX5565gr1WfbSYJLvAcbQgkuRxuGpU3QHEKvAuN7zsNBbjvN0jNULqaeJ9YQZ+Ei+Y4nWXXLD0D6OQSA2YbGY8vPjxD5JBYKTaN/Isvb1bmju4r74BjF/R7BwKKt8rNBTgUeY6C5j90ctImtWaWGbRBlzmCUhSD4kPtSeKwQPijT52f0m/2UXY0cM26q4camvPYl2qNWU+lTREdJiNnqrhFvZJP8bOON3ydYaaoukYJlijusFnpt4zYXIdnv8CvTF95oLMvTK6z/vnmqq6jIxe+ub5umaZ4iwLrOa6k8K1HWIEXSq7wFpziz2YNHRGgYnInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLmi745IG/tndSi4Oq4x18m6m8YaZV056lYwCeaQmyI=;
 b=aifJCiSntc2plfwwUvijqGrLRrNKYjx4H/2MrewLitVctlcjXEVYFF0zrwsqUjJ9a8jO8yLHPWdq4RNUh4hwZkDX2PZuj9YhMU0z3KB/Vl8+/z0qGP4zeI+j8TnI8VUAy14Z7Z2X3ZBx69Yt/BSG8nXAEMPG+mm7WeuAPnFAwT/SA5rfxChItaS97kjKQ5cTeveQvgEAGZRN7QyR5Gkr3IoSQqDKBIzgbebta1NjaPaXTynjVZEFswC6EwgqOcZSCpF/Go9d8UyKh3QoXb9uDYXlk78X9CIIAzA0DxZBKGFIflCPSuAhgBd4MNP64NLyVQ4xGAas/bbsmAzXwkaWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLmi745IG/tndSi4Oq4x18m6m8YaZV056lYwCeaQmyI=;
 b=JdGDFgirNuAyMPVxgRAzXHW5AhVWdTHg7FkOcUTWaYjjsRVoxoY1F5v8lCcaXLpHzvO51/GfQ2xOvHbx4wFM3lUH+YwW0lRyJCGS5+U0r9fxcwRPiOVPN98ulsuWh5qaSxeSBLHH7j9Jw25lRVVYbpyNKPlTff4C6vRwcE/rTtA=
Received: from BYAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:a02:a8::26)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Wed, 14 Feb
 2024 18:40:50 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::2) by BYAPR03CA0013.outlook.office365.com
 (2603:10b6:a02:a8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Nevenko Stupar <nevenko.stupar@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 13/17] drm/amd/display: Remove pixle rate limit for subvp
Date: Wed, 14 Feb 2024 11:38:44 -0700
Message-ID: <20240214184006.1356137-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7cb5e8-b770-419f-6361-08dc2d8c7791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHO1VewK66pjEsbLxbEcG6gfBzreo6zcx8w7WD7GCWkGJ/ECQxo/Ik/j5MejukVfXp7TtfMIDlf84mlVlzQ9tJ1B/Im51ZXTAs3jJph0l8bDENwf251/SGcjmwSAy0lZr3HCeqEl7FxEOP4VNA244JlGZp9S2FSH3uWi83k0qq9tyiYSumYSH/w6iB0H5Z4141ASDiLS9dBBIhSo99ohVwtsg4GMRMTEsccaLUQYDj90tDktZOAcOgKQsqLJfrW0IObE6aGftTi28hjhGoTMLlwP7QpsTFX5UzvnqgBdmDrWafyOetyI7Y1mPCJmp29tAurxwutS5GOcRcaQcqtObwfXDceD6c/sknoV9lBG0o0edsdAQPNkV073GvSAyCwQf47FaJbPa26cAARtqHJJONLaBU/6zVVruNjWEzVfxKuWbnGB9bPgT/Yn9C4w1O0+2ZxbU1eBHqTshWa60n2yG+++cETIjxuJM5N8uaAlolNE0QFG08LQnv0JtZGgWaD79CgMrLQCg5hwB3g4Ft+UGtSrL/2Xpcvi8RFHp4O/ezXHqjWglWlUMZxuX86HMiCPcBmFjNuyumoaj0rHnC3u/xL2irSZcDO9LdEcDnZIkAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(356005)(86362001)(5660300002)(316002)(70206006)(6666004)(478600001)(2906002)(6916009)(70586007)(4326008)(16526019)(26005)(1076003)(426003)(8936002)(336012)(8676002)(2616005)(41300700001)(83380400001)(54906003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:50.3674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7cb5e8-b770-419f-6361-08dc2d8c7791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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

From: Alvin Lee <alvin.lee2@amd.com>

Subvp bugs related to 8K60 have been fixed, so remove the limit that
blocks 8K60 timings from enabling SubVP.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a0a65e099104..b49e1dc9d8ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -623,7 +623,6 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
-				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
 				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&
-- 
2.43.0

