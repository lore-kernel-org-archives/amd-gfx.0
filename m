Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D56C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC30710E0CA;
	Thu, 26 Oct 2023 14:20:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5908910E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt4/rVGXvp5ywdYrgKO5LbpzcN/qJxNj9g1tgtSzfDmxNbbk5DG9Bjtse4/lZvFtx018MWADVPB48am+5QyGACxZZ9csuVOp5ZUFhIq8T4ZVdBri2l/WNY0EmOv9PDqVL8bcLY1EWSqeXf5QoIQsF344303mNVo1mU8Buxfv0bXCrLiXt+ZIaotWi1jZX9F2nuOZIT7BRqKybhDLAAllTlYSD6Jp+6nguz0BKmICZHfsJ23Xon4nN4/gJIeU1KHbpmJMNIzgOcsa6m2aNQukyyQXgLWvrEaYbvg5AbzVEK+JZ42m3O3TR0ohLVsYkeDJ5haAd6CQR5uplyDk0dBUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NaxVustLjeskknmi62UNecGHc/6KLRBXu31lo5swgw=;
 b=RL/8i3b4TqNWRLzJV/b5puWI9qIfhz/IvECzMZ9p4r/PnT9ftA0uyUbDm13N2KEN2NcmMz0BvsMUMQd7Gqgqh1DkrsouWQtB+cX/Ikeh2x1U0gm5TZsin9nn7Ox8LR0bd7ANRHNGS5Wo1qy8XdG3We9LZqpL8iT+9k3W5yuqyjRDETLU0fYGr+E6Osnv70eMDuWncw5QMvC0OIE5rhQ5dwVC2F409nOI1F0HNK+Fp7WJnWX22eczylXcRBPKM6SYi9AuJphWAtfQLXA8DgmxjxOOdT2i5q8NZnENjDI1DPJfSXUHMysz5jckwrJfb+rez+qnxWJ8IvmXSvHbCZObLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NaxVustLjeskknmi62UNecGHc/6KLRBXu31lo5swgw=;
 b=fPfbhdq2WnhNnbZ9vHhR3ZFt9/Ap9dB3P8hL5x5hmu6bGfyQYuKZ6TzCOfeF/G/x1PfQNSRHqcqUfBFtz2F+rxY5rjfNSTH3PQHj9/wG4KoEx/IUmNPyQLA2bGwrzDjDgqV5mW/h9YXZtlHvoREk4m1e3jaz2JITqTk8Ojds8Jk=
Received: from MW4PR03CA0064.namprd03.prod.outlook.com (2603:10b6:303:b6::9)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:20:29 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::df) by MW4PR03CA0064.outlook.office365.com
 (2603:10b6:303:b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:25 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:24 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/25] drm/amd/display: Avoid NULL dereference of timing
 generator
Date: Thu, 26 Oct 2023 10:19:56 -0400
Message-ID: <20231026142020.67861-2-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8df95e-ba71-4d94-c8b3-08dbd62eb4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2Jb2+i4fTMUHqVjlgq69OEuH2xL2RVNlJbGh6GR3aeo9uIZEt/J017GlxSdlVetkVkTI3tsP59IDbGf0k50X0GzPl68+lXGKX7BNQTEDhYY9l2czHE7Ir9BMT9ZR+zH5NTeBkWLpWdtR3q87PCzvEXbqvXWPX5jXcRbQfoUb646j7ZWp9nZUTd+rgKGspqFMHP7pTgqtA1BDO+Nz1nRRh9gAFcqlMquxeYGbJIiXtaXUY6RrfAx74VIM4sdmn6YR2RNlVOiPSv+EMg64adQ786qdBBYVJe7JSszsZIMI+3eiYP/7dVO+FsZ330TaxQgitWjRlfcPsjxO3o4oNmYnyDCbxDyFhjX9BC+bX6Gls/mFTr0U/sxOYjZFG+8Jk/2fbAiObZn7DDc3jkxjInxBD1+bscqsHJ1EM9Rio70zAbWgB3S5KrJmKzFTbpN7J1BTXctRzkx+sFwkuJ5mXeAleHo6g37JbhSjwKsftuzucgbpuX4MDQwjCRiLw/JymhV7B6gAYd3PgmkS4dtP/sUhUrxFW+hiotI98vtSf6r3A7qmEHmFHi2M0PLKY3BMZgzhMl1GbsLYG6itLZYtaaBj0n2GXU0WXQBTv+XTqEeczG6RkhP94uw58Q5JSXt0y9Pglxuzm+4EIYpWQP6VFwRYLG59YZPgWD2wK9d0U1Zgk5ATuQBAUoXT78nUDm4ddcQVs/JH8spGFDiSWJLvUoJhGh/60bsefUSHHk561/iVIyK0KAUGvE8S+XbU/9JwgGoryJi6gh0QOdM6NQZtijB2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(26005)(41300700001)(2906002)(36860700001)(36756003)(40460700003)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001)(6916009)(6666004)(1076003)(70206006)(81166007)(82740400003)(54906003)(70586007)(40480700001)(356005)(83380400001)(336012)(2616005)(47076005)(426003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:28.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8df95e-ba71-4d94-c8b3-08dbd62eb4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <wayne.lin@amd.com>

[Why & How]
Check whether assigned timing generator is NULL or not before
accessing its funcs to prevent NULL dereference.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6ed40b6c6178..4bdf105d1d71 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -533,7 +533,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -592,7 +592,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
-- 
2.25.1

