Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F137C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B4023107
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4023107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052FB6E104;
	Tue, 19 Jan 2021 20:39:50 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700079.outbound.protection.outlook.com [40.107.70.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BEC6E104
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 20:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfNkyaQKmAv/b6612aEUgAHkoaNQ0TT1M2adD+8734MVRuQid0Jl1jWvt+BE/IQZeFncv85DIx4aknqtR7M1bXFKBeOoDcgnQnUKNavd3voqrTd+yc1K1JT6gstZPvuMyhhsJ5YmkP9AUyiVLN+rMQzmuQ/D87v3MejZHoHnA+ju+9Jgh2X3geVx4ORHwNSgyFlscf27GngcQRNpqs6ljrvMFaKuYZvssrPkrLd39pG5U/4wA6uOQbc4rLLNQjA5ERI6kAJgtaTSpeoT6sX7YfYUqp+kwgHr7PWHtc0JYtiVEp/krjj5VppvOx5dJx1zei519n8FZk8DiOSX2BSxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tgE9SjFdjGbbBPuObw40g38aukRMs8o9BI1XWONM14=;
 b=YGydUD/iuA3gh55U3zVIZxD+HnzfFiZou7VijIzQmoPepiN75c39lnPikEyXFWyQIm2Af/rjo/IzMdlHAIKRpDLodANfctHaW/gzF3HP3+QWO0EWalHxMbqM3w4zrTctGPU40M3Zxm7wS04hWM30QLM1gaeA/i28C5N7ClF85FJiDnsk9Q6fHwNmLi2zspCWyuUS5WQQf/J4ZhAh4pLBk/+PKt/RoUlBZW/kxDQE0wlOM45eUUt0Xpe3eEZmkY2s884QhXuR3rEjbFruOEpGeaAdVbI3zT2M65lvDG5HOIXsS+GgQRWAWOGT6q7J6+yInNYv5LdH4cqY/KWmDH8/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tgE9SjFdjGbbBPuObw40g38aukRMs8o9BI1XWONM14=;
 b=GYb3fFuyHtxSYECBMuRshGw67SBnKGkXBMiCZ6V9Lfowx9Yq8EjGBM6ftw1iB/v7ZfJHL7PVuGUTtL2RGip5r3aNhQlOyksZo3p47Xuut5ZJJarOmCqPuP3o5kSWbGc+rtKH8AZ8h06j4teoGZpBRw3QrCZmtYR+C4Uiz1t7sWY=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by CY4PR12MB1861.namprd12.prod.outlook.com (2603:10b6:903:11e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 20:39:46 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::26) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Tue, 19 Jan 2021 20:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 20:39:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:39:37 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 14:39:36 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Enable programing of MALL watermarks
Date: Tue, 19 Jan 2021 15:38:08 -0500
Message-ID: <20210119203810.2667860-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
References: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8930df-9000-4f4e-3bb1-08d8bcba5a92
X-MS-TrafficTypeDiagnostic: CY4PR12MB1861:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18610EC627875A46B9A130D5F9A30@CY4PR12MB1861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVZJMPSuD8lgSW1rG5weGJZ3DE1EwwRQpcq5SqUuFm8UjBBhtNY2esK3ok6OfGdm59yXOkwUc1tmo1dtKOOsOrZQALaBWx3efyZ6PznShOz1noHj1vBDvuZzkctrQa8HtQnUsQX81fbOHelc51vgL06gAvVWbqh0zxxJq1MUxGA9v2fP4vMcrzIRUdDQswfvejc6XoqInWO+hpGfdSpHoG8XJAiRL/QvWSj5vRc3+VSsNtUvTNbXdmi80SOOCaVzYTxANSzHeFatB3L1V/GMaQbaD7iEbnbqMqWAAMbi+8eNzZKoVexiBwBiLYQN9KOWjwCwELjv8+iE8YIeJ7s+Piz51HKwajv2xdjlcl0q7JyOFsqCPEw6/K8Q4E9oMDqXkGIOBsrLZkNfRyCDiHnwFSW01kehVnOqdOSFh0d7Ds3yqr+wjSaRWxeBdoXLPVEQdymUOJxOr8X17AncedhvfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(346002)(396003)(46966006)(83380400001)(54906003)(26005)(6666004)(8936002)(110136005)(5660300002)(82310400003)(4326008)(186003)(7696005)(36756003)(70586007)(316002)(70206006)(47076005)(81166007)(86362001)(356005)(426003)(478600001)(1076003)(336012)(2906002)(2616005)(6636002)(8676002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:39:44.1967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8930df-9000-4f4e-3bb1-08d8bcba5a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1861
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

uncomment watermark set d

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index ab98c259ef69..c7e5a64e06af 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -146,15 +146,15 @@ static noinline void dcn3_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
 
 	/* Set D - MALL - SR enter and exit times adjusted for MALL */
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = pstate_latency_us;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = 2;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = 4;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = 0;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
-//	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = pstate_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = 2;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = 4;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = 0;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
 }
 
 void dcn3_init_clocks(struct clk_mgr *clk_mgr_base)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
