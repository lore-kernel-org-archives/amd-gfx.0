Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA536C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A93460F23
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A93460F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0566E987;
	Tue, 12 Oct 2021 13:26:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EF06E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWpHWm7WqxdaEFix28wZJaFIBVxRIBiLT4GPoO9t7gnEXBeP3umSfyKJX6bd4YtbWuAIrGuIZUadyEDI2jBLoXMV48L8qkzsWcQAGPJ374nkPvj0Cv8UEzMh4ZMDCRW4Ai4x3wgGWEO76lNKLKCMJL5461gDeTBQJRVuSj90XK5mX/J2Wv0fkuxtqxL1lQ31Ygq/st51OQQLGg0kKt5jXiACNpH0fUIxujPBUp9T/G3ozg0CCjuAj0hFdI5bUqUbdH/bXr3TrO98p06CuWdOeRyNgsiltZU18arahfBu2r0Y7PGqjYj0zRf62Urw+BFGYFILXgKZ/8tBz1FjBkhS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aiQo2qJvWwmKIm2cCoGq4GtFXGaKu2Nh0+ZXEy16Pw=;
 b=H/R0rIzbLo1Dhf7Uy7IOZ6/f2vqDmWs/AXxtC5249YWHtP2RLbOeoBKGnnlH4M0gPFAmTuaEH0jZWQCEObZNGG9ZzFZ61Oa8yDHGT9aFsqN2oGM8oG22sBIj2q5TaNfymmPu4q8dlj1lzBCgX63F/LeddWlwKv4K2SR6LSUVxkOJ3epz+xFG6xKFLxrQIIdk69fFcE6vkKxVkb6ouOmiN47p0CZ/sJ4ZJQ5+1S0m15b+mYDPgGTJl+S5+d+ud3Lb+R6vcmHCXWGFMW61ehptf9MsMkPls8m2pNlB9v4t8QOdatmrRdJmB9+ClFQBCfsaEZlC4tgbMTBuzHOguCgOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aiQo2qJvWwmKIm2cCoGq4GtFXGaKu2Nh0+ZXEy16Pw=;
 b=R8TQYZCWC8BuFNtDSU74irVj6dKkj204HTMeTuhY/aAwIT6kh0xQpp18WaQLqoPvwFlKhPA9S0TYVLugXOUmmpAv/ikydnLQIGijHfEgzwSeBIEV31F4zVaQrNzdQw2/davfw4WGtL0/UdUvTWxxJMjK00RKDiOG8rZINodpjrw=
Received: from CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27) by
 BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 13:26:44 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::26) by CO2PR07CA0059.outlook.office365.com
 (2603:10b6:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 12 Oct 2021 13:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 13:26:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 08:26:43 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 08:26:43 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: fix null pointer deref when plugging in
 display
Date: Tue, 12 Oct 2021 09:26:42 -0400
Message-ID: <20211012132642.246950-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5784f79f-2c02-42dd-197d-08d98d83ef23
X-MS-TrafficTypeDiagnostic: BN9PR12MB5146:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51461E208E9283DFD272E4ED8BB69@BN9PR12MB5146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rexae6Wpj0yU/3eKdBho3aJ3LT7LDXOc7rwu6X14LdUiDfukM5He0gsnXSuk34Bb4fh4Trz5Optnf67Jou/NUbg2L8QDgaLvwM/1Go/ilPATV8eqiLIM5VKBomwFj98K0Gbk10lZpFJ4fXxdKaWmvzsAufcRpbFmW4pILCKGhyTDaYkudozVTBULIeMG+9uRb7daM7/ZsPRzivwKIlzEUF9J/b7LHxSBsI6pPVNmVMYQHfR3LrgRBecZ1WVGZ+fm8iSi0UBQWMQBnFHq8ZT3t9cZhkHuqcbW0SaiAUMTs1glsuPpjahkbawElqLK4DZd7NtRLmgEyx1L6Frx1yw4S8z8VjSF7WJdqPI0e/3Aj4X2BsFcPCbCHzJONEYk0WRTLYiivjAA5Wibdbnq9mLhJdH5jPzbTPT+1D/q/7HHrCPg3sF+z6T99Ex/aMxkp9ILDkPVzuvWEJNcmGmYq4gUNBs/2s7GEaC0xrzNwv+6gjP7MMXK8++/Vt7XBCQAcaNow66Nietmc9tGvm0SNtX5Hi98MEUul2Mj7juWHZaQSVlGjgysgcIyy5qZc/omT0FxUxCGE9ha8isan/fzxHPHE0oOiMb/BEyzIjg8GikbgOJv/omjj6COaGGFkItzAtd581ds223Yie0UWTzUBaKY1t8WcqmHEd0g7hiLqMjAfAqIsw9OP0ifwjO43pkY6kpkrDrIXahgiQGuZMHfaxT1dmXcSedfuTCFYLxtc5P/xodPMjphxw8Vhd+ABy5k8Hf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(336012)(5660300002)(44832011)(6916009)(4326008)(2906002)(70586007)(70206006)(316002)(81166007)(356005)(1076003)(8676002)(8936002)(2616005)(47076005)(83380400001)(36860700001)(186003)(36756003)(86362001)(82310400003)(26005)(426003)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:26:44.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5784f79f-2c02-42dd-197d-08d98d83ef23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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

[Why&How]
When system boots in headless mode, connecting a 4k display creates a
null pointer dereference due to hubp for a certain plane being null.
Add a condition to check for null hubp before dereferencing it.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 01a90badd173..2936a334cd64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -969,7 +969,8 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		/* turning off DPG */
 		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
 		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
+			if (mpcc_pipe->plane_res.hubp)
+				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
 
 		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
 				color_depth, solid_color, width, height, offset);
-- 
2.30.2

