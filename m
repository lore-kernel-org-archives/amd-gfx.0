Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2180C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9E261D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E261D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8C989F97;
	Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6A289F97
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofwazfKUKfrVD7cfcCx2iYi1ULhv5Lw0av5K33EP0nro1DbQGTRcfSU72l93Dl3xupBqZc/VvryDU2xLf+vLmQLjdRpSNaU4TeqrFIpWc4QVK1vUYlhPvps8cOrvjuSvcsWGryXTQeP7SvhOtJeU71n9TuJFOhzCnNs0lh5sZWfwR7BsdJr/yzjrzrb7ixf/X+Vy5YVk2d/GECDDg2UDIviAxaBf0dSTluwZIivnhjGQ9c4628LzOtNswpWBA+iIP4P0+LkosVC9IDN2lPJQRotnKQVHDw5k6KiybVHLyARkEoGKOIC2utio70+0d+8kEJKfHS7kmG5wtKb7kj5Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+dfX9hbDm93C+qokdQvrPIevrY/h79ULsj6Glqo5r0=;
 b=WoGn3lcM81B+lLHNQnJFTzulai5+creJeItC+bLa+25WqeelV4tQnqV7VnYlb+ZzZFeYr6tn3BCjVxyV3ov3nDAVVXXykOjPnlug5/ICYM51w3PhOGWj84rgXvBSI6CCrav2LHnECAQQHhaq+Z+Fyk/Rg9Ux2ZxTx6Q++pxvWeJHWYgm93qeGoEHA9WF7qsmjWoGjg7+J/VJXd7pWYNREqEUQ9X4OERk85sd1yvt3Z//vJuj0Jj7XCBAeOOYxb4FFCKm9z5yGyRnqvEhT2ofje1vqSpgzrQ9hV5gicYTovfnAOKxW14jG4xf2b6Uujs4FBoHPm6T7vU9PNkryFyE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+dfX9hbDm93C+qokdQvrPIevrY/h79ULsj6Glqo5r0=;
 b=l9Mx1TIZe7c5UnX13n2287Y88cRPstDwpddXbP+TkukuDSK8822h4krQu6aNvQxWLjom+p/wrzlAisMfPoYlvVN613YWO1Hkm6zwhm2HE5macZu/OYCiiGCq3HszzmOskypGLisUCOXceCuABI5gq2mYh9YSaLea7wP1xWi+4AE=
Received: from DM5PR15CA0036.namprd15.prod.outlook.com (2603:10b6:4:4b::22) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Tue, 29 Jun 2021 15:55:00 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::18) by DM5PR15CA0036.outlook.office365.com
 (2603:10b6:4:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: Round KHz up when calculating clock
 requests
Date: Tue, 29 Jun 2021 11:54:21 -0400
Message-ID: <20210629155422.26118-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31aea195-ce44-4363-9ed1-08d93b164013
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191A0FBF4D55093EACD0E6498029@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9emietW+s2gPetnqsbu9LWDSbqhcEA3B+saql88A9ciodxdz9cs/r4ipWPclTlDmSyigcMqOdcD+RsEpod6M1B54IkaxYZ/aeeaAYrcBJj0XxGz/G2RWbcyiM4y2pSbXWW67RCDYyYQ17vPLwo+W2KNIQ/x8p4M0zAw1ivCcSCdtbSDrCw7eDsA6sJruB8F+rjdqZP0XJbyATH1pPKkFRMAd/ixgozyfomLngYTVGSU0TpGPeJTFZA4AG4EOT01YBN/GziTMiROJAeEmdpos+b55MJbbMpI37nDeyUnHvKG2ouapM39+yPHZyQwqld+1jGovBRcyM/8nNBVi8MjwUk86ShfXqRtdOxq87180i4BVhoo78i44UzZJxZxmksVt2ZJe+x1mJhNi/YBop31INUXotnREtaSjcKBbfoc81uU3n8xyNiEpSZc/0CjiyCtRUtFsJmbT+k8Twz4znUdyBIBaqXXsRhb6RTLJEYq6ybGflfkRAzZPpYR1CU/u/LZudnxs+E4nr8rteA5FughB7NXGZWI49EWTVFcSv+GsHwfwEBXpkqN+0WQ5ozArqPZEBMndQZr0W4vX76RKJMPNxoGYHIaqmB4wwoQQBUmew4eO0YtxE/tpJqs7Z+kUjdBsRQ7xS4Hpav+aXWgBosVkRSJEEiNzkS/3NWVUYWQoF4SLbU6Nyqy6nCkcZ602KmCMPco92POrfDiCPaUiGnTM2QAsTjym6Tfaz/RRHnRySY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(46966006)(36840700001)(4326008)(16526019)(70586007)(70206006)(86362001)(36756003)(2906002)(8936002)(26005)(1076003)(186003)(6666004)(36860700001)(2616005)(6916009)(8676002)(81166007)(82740400003)(47076005)(54906003)(5660300002)(30864003)(82310400003)(83380400001)(478600001)(426003)(336012)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:59.8833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aea195-ce44-4363-9ed1-08d93b164013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Cc: Aric Cyr <aric.cyr@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When requesting clocks from SMU which takes MHz inputs, DC will round
down KHz when converting to MHz, thus potentially requesting too low a
clock value.

[How]
Round up (ceil) when converting KHz to MHz for clock requests to SMU.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 12 ++++-----
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  4 +--
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 12 ++++-----
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 16 ++++++------
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 25 +++++++++++--------
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    | 10 ++++----
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  | 10 ++++----
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  5 ++++
 8 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index e133edc587d3..76ec8ec92efd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -264,9 +264,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->fclk_khz));
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->dcfclk_khz));
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->dcfclk_deep_sleep_khz));
 		}
 	}
 
@@ -284,9 +284,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->fclk_khz));
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->dcfclk_khz));
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, khz_to_mhz_ceil(new_clocks->dcfclk_deep_sleep_khz));
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index dbc7cde00433..fe18bb9e19aa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -130,7 +130,7 @@ int rv1_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_di
 	actual_dispclk_set_mhz = rv1_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDispclkFreq,
-			requested_dispclk_khz / 1000);
+			khz_to_mhz_ceil(requested_dispclk_khz));
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
@@ -150,7 +150,7 @@ int rv1_vbios_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 	actual_dprefclk_set_mhz = rv1_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDprefclkFreq,
-			clk_mgr->base.dprefclk_khz / 1000);
+			khz_to_mhz_ceil(clk_mgr->base.dprefclk_khz));
 
 	/* TODO: add code for programing DP DTO, currently this is down by command table */
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 6e0c5c664fdc..eee406d11b1e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -253,20 +253,20 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		if (pp_smu && pp_smu->set_hard_min_dcfclk_by_freq)
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, clk_mgr_base->clks.dcfclk_khz / 1000);
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 	}
 
 	if (should_set_clock(safe_to_lower,
 			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 		if (pp_smu && pp_smu->set_min_deep_sleep_dcfclk)
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, clk_mgr_base->clks.dcfclk_deep_sleep_khz / 1000);
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz)) {
 		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 		if (pp_smu && pp_smu->set_hard_min_socclk_by_freq)
-			pp_smu->set_hard_min_socclk_by_freq(&pp_smu->pp_smu, clk_mgr_base->clks.socclk_khz / 1000);
+			pp_smu->set_hard_min_socclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(clk_mgr_base->clks.socclk_khz));
 	}
 
 	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
@@ -281,7 +281,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
 		clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
 		if (pp_smu && pp_smu->set_hard_min_uclk_by_freq)
-			pp_smu->set_hard_min_uclk_by_freq(&pp_smu->pp_smu, clk_mgr_base->clks.dramclk_khz / 1000);
+			pp_smu->set_hard_min_uclk_by_freq(&pp_smu->pp_smu, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
@@ -306,7 +306,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		clk_mgr_base->clks.disp_dpp_voltage_level_khz = new_clocks->disp_dpp_voltage_level_khz;
 		if (pp_smu && pp_smu->set_voltage_by_freq)
-			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_DISPCLK, clk_mgr_base->clks.disp_dpp_voltage_level_khz / 1000);
+			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.disp_dpp_voltage_level_khz));
 	}
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
@@ -502,7 +502,7 @@ static void dcn2_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc
 
 	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
 		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
-		pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
+		pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_PHYCLK, khz_to_mhz_ceil(clk_mgr_base->clks.phyclk_khz));
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 7deeec9d1c7c..9f7eed6688c4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -126,7 +126,7 @@ int rn_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dis
 	actual_dispclk_set_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDispclkFreq,
-			requested_dispclk_khz / 1000);
+			khz_to_mhz_ceil(requested_dispclk_khz));
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
@@ -138,7 +138,7 @@ int rn_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dis
 
 	// pmfw always set clock more than or equal requested clock
 	if (!IS_DIAG_DC(dc->ctx->dce_environment))
-		ASSERT(actual_dispclk_set_mhz >= requested_dispclk_khz / 1000);
+		ASSERT(actual_dispclk_set_mhz >= khz_to_mhz_ceil(requested_dispclk_khz));
 
 	return actual_dispclk_set_mhz * 1000;
 }
@@ -150,7 +150,7 @@ int rn_vbios_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 	actual_dprefclk_set_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDprefclkFreq,
-			clk_mgr->base.dprefclk_khz / 1000);
+			khz_to_mhz_ceil(clk_mgr->base.dprefclk_khz));
 
 	/* TODO: add code for programing DP DTO, currently this is down by command table */
 
@@ -167,7 +167,7 @@ int rn_vbios_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int reque
 	actual_dcfclk_set_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
-			requested_dcfclk_khz / 1000);
+			khz_to_mhz_ceil(requested_dcfclk_khz));
 
 	return actual_dcfclk_set_mhz * 1000;
 }
@@ -182,7 +182,7 @@ int rn_vbios_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int
 	actual_min_ds_dcfclk_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetMinDeepSleepDcfclk,
-			requested_min_ds_dcfclk_khz / 1000);
+			khz_to_mhz_ceil(requested_min_ds_dcfclk_khz));
 
 	return actual_min_ds_dcfclk_mhz * 1000;
 }
@@ -192,7 +192,7 @@ void rn_vbios_smu_set_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phy
 	rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
-			requested_phyclk_khz / 1000);
+			khz_to_mhz_ceil(requested_phyclk_khz));
 }
 
 int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz)
@@ -203,10 +203,10 @@ int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_
 	actual_dppclk_set_mhz = rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDppclkFreq,
-			requested_dpp_khz / 1000);
+			khz_to_mhz_ceil(requested_dpp_khz));
 
 	if (!IS_DIAG_DC(dc->ctx->dce_environment))
-		ASSERT(actual_dppclk_set_mhz >= requested_dpp_khz / 1000);
+		ASSERT(actual_dppclk_set_mhz >= khz_to_mhz_ceil(requested_dpp_khz));
 
 	return actual_dppclk_set_mhz * 1000;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 513676a6f52b..b98cc315305c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -280,12 +280,12 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCEFCLK, clk_mgr_base->clks.dcfclk_khz / 1000);
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCEFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
-		dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz / 1000);
+		dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
@@ -313,20 +313,20 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 	if (clk_mgr_base->clks.p_state_change_support &&
 			(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, clk_mgr_base->clks.dramclk_khz / 1000);
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
 		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
 
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PIXCLK, clk_mgr_base->clks.dppclk_khz / 1000);
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PIXCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, clk_mgr_base->clks.dispclk_khz / 1000);
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
 		update_dispclk = true;
 	}
 
@@ -392,12 +392,17 @@ static void dcn3_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current_
 	if (!clk_mgr->smu_present)
 		return;
 
-	if (current_mode)
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-				clk_mgr_base->clks.dramclk_khz / 1000);
-	else
+	if (current_mode) {
+		if (clk_mgr_base->clks.p_state_change_support)
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		else
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+	} else {
 		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
+	}
 }
 
 /* Set max memclk to highest DPM value */
@@ -485,7 +490,7 @@ static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct d
 
 	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
 		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, clk_mgr_base->clks.phyclk_khz / 1000);
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, khz_to_mhz_ceil(clk_mgr_base->clks.phyclk_khz));
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 07774fa2c2cf..6ea642615854 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -133,7 +133,7 @@ int dcn301_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispc
 	actual_dispclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDispclkFreq,
-			requested_dispclk_khz / 1000);
+			khz_to_mhz_ceil(requested_dispclk_khz));
 
 	return actual_dispclk_set_mhz * 1000;
 }
@@ -147,7 +147,7 @@ int dcn301_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 	actual_dprefclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDprefclkFreq,
-			clk_mgr->base.dprefclk_khz / 1000);
+			khz_to_mhz_ceil(clk_mgr->base.dprefclk_khz));
 
 	/* TODO: add code for programing DP DTO, currently this is down by command table */
 
@@ -163,7 +163,7 @@ int dcn301_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 	actual_dcfclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
-			requested_dcfclk_khz / 1000);
+			khz_to_mhz_ceil(requested_dcfclk_khz));
 
 	return actual_dcfclk_set_mhz * 1000;
 }
@@ -177,7 +177,7 @@ int dcn301_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int r
 	actual_min_ds_dcfclk_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetMinDeepSleepDcfclk,
-			requested_min_ds_dcfclk_khz / 1000);
+			khz_to_mhz_ceil(requested_min_ds_dcfclk_khz));
 
 	return actual_min_ds_dcfclk_mhz * 1000;
 }
@@ -191,7 +191,7 @@ int dcn301_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_kh
 	actual_dppclk_set_mhz = dcn301_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDppclkFreq,
-			requested_dpp_khz / 1000);
+			khz_to_mhz_ceil(requested_dpp_khz));
 
 	return actual_dppclk_set_mhz * 1000;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 66db5e988bc1..beea961749e1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -147,7 +147,7 @@ int dcn31_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispcl
 	actual_dispclk_set_mhz = dcn31_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDispclkFreq,
-			(requested_dispclk_khz + 999) / 1000);
+			khz_to_mhz_ceil(requested_dispclk_khz));
 
 	return actual_dispclk_set_mhz * 1000;
 }
@@ -162,7 +162,7 @@ int dcn31_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 	actual_dprefclk_set_mhz = dcn31_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDprefclkFreq,
-			(clk_mgr->base.dprefclk_khz + 999) / 1000);
+			khz_to_mhz_ceil(clk_mgr->base.dprefclk_khz));
 
 	/* TODO: add code for programing DP DTO, currently this is down by command table */
 
@@ -182,7 +182,7 @@ int dcn31_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requeste
 	actual_dcfclk_set_mhz = dcn31_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
-			(requested_dcfclk_khz + 999) / 1000);
+			khz_to_mhz_ceil(requested_dcfclk_khz));
 
 	return actual_dcfclk_set_mhz * 1000;
 }
@@ -200,7 +200,7 @@ int dcn31_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, int re
 	actual_min_ds_dcfclk_mhz = dcn31_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetMinDeepSleepDcfclk,
-			(requested_min_ds_dcfclk_khz + 999) / 1000);
+			khz_to_mhz_ceil(requested_min_ds_dcfclk_khz));
 
 	return actual_min_ds_dcfclk_mhz * 1000;
 }
@@ -215,7 +215,7 @@ int dcn31_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requested_dpp_khz
 	actual_dppclk_set_mhz = dcn31_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_SetDppclkFreq,
-			(requested_dpp_khz + 999) / 1000);
+			khz_to_mhz_ceil(requested_dpp_khz));
 
 	return actual_dppclk_set_mhz * 1000;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 316301fc1e30..a262f3278c21 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -318,6 +318,11 @@ static inline bool should_update_pstate_support(bool safe_to_lower, bool calc_su
 	return false;
 }
 
+static inline int khz_to_mhz_ceil(int khz)
+{
+	return (khz + 999) / 1000;
+}
+
 int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
 		struct dc_state *context);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
