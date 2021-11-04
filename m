Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45404C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1560061207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1560061207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7766A7367C;
	Thu,  4 Nov 2021 20:52:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D56573784
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3aHnOmh/qSLZ4juwDxNTke4phcA7FBPJfllZKMaP+lox9rdYUSZ8WSunWLJRvyDE/EmJli/qdPemJe6wM8M1Zikc5XYtskgDHbCfC0QuIuBogsKpark95wqxEmRS7WwJ6yH/xx95L8jL2dEFYVaUcpTaR70Bl8EYC5XQyu+QeJwto6j0/L0K2vZ7wkBH3tLeH7NzEpWNH24Rie7PzE/6cx11FIvQWxVgZukhb+UUkGSwd7LmWOJkcIsaHa3lIjPFm/15ExHw6iuqnL1hYfBanBRLRkwI8N1yJKJM+sW/CSqS9b9BJdyjjB10REXrCqJ4mCVksfdlPl2S2hhX2kCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEw7P/suwNgRd/awVgci7Ppro2TsUBMIkDvvqoNXZ8w=;
 b=lNg+z6aTMDHbF8ZtSQ6jzr1OtUIB2B7yAKqpcVvn36en3/r2Qo9j2J9+60x7DZ0PX4FoqyhVITOUiw666A3VuXNd1hlOZNSUa/W+/wRQCfoWhoOjLatsfrh3c0CNd/sKdH6Id3ZR/nCIfwT0il3FROGaaMJq/uCzVsDwE9wVoaBiFnJEuObSxSlmajxTdVHBILAy5NflmhauL+3IxDd19FuG/k8hMrgNb7TjBalnc5bYbujclkyvZwqGwCUBSTzIcBOOyWX/hLEft6IQxCcwyCp9LDtdQhJSCbdW5S5eFFGqOAYcrGSw/zx+rH85o4R/iASCcUdInKCnEdq645tJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEw7P/suwNgRd/awVgci7Ppro2TsUBMIkDvvqoNXZ8w=;
 b=eBXkR4qUwTTAD48bqZXnO74PEuypSWwtcZs2BwfxLF/0QISah6uRJk4jgl9BcYZFxWaK2yMnnInsHUCyfIgvrZ8Ggrtm3qOkCe58xAKaLaiP8+AH9fZcB/Pph4PC0cJFHq9/OBjzIu3DX3P3p/S+0WkcAJB49n5jtKb/gILh67U=
Received: from DS7PR03CA0276.namprd03.prod.outlook.com (2603:10b6:5:3ad::11)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:52:31 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::c1) by DS7PR03CA0276.outlook.office365.com
 (2603:10b6:5:3ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:29 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:28 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: bring dcn31 clk mgr in line with other
 version style
Date: Thu, 4 Nov 2021 16:52:01 -0400
Message-ID: <20211104205215.1125899-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d276a6cc-a761-4bee-899d-08d99fd504f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4884:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4884A39752404E8AA1496DBEEB8D9@BL0PR12MB4884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AsLowCVTIfY7Uw6aKeqjTl+uCC4ONVpFZxxPE4QbMiLp4Pg3NGA2xpnBJLaHUXuglHXLyJaZLOyc9mcvs01HMwrFDKw7Pe8MsR16Pc4d4evaHYOWQNl8iCfX4dTcU6xjIOLuyO0J27GclER2bTWPUe20NC8oYvXasP8at8r8DVDJwha+df31eXl6kSg+/hS5o5FcK/eikxjTCMpctp1QvaGxpSdn9HeFphB9rbu3GZZfYOyHveU4I004FBKS7mNlyYFU6v5EVfTfuYF+3IXuD8mTU3EBJbRTPYMk5cj1EvkGxfIVfHIdJpPiR6sXOPi5H6WRvXnGktrNeQRFaEC9edW57QHPV9X0QH32+hJ7VRkHfqw+PAwlKsnwH1eaBdscBsVlCHGHHWsQ/gdCgCHggOQqU5IbdYLfgUeammcUKaVDlwF6SpSKpjNmmsQ+gTle9Qo5MlzC9keg4CH/Ve9srjJ8akqgKAIC+orWY4dCEnzCBfNxxR7ybt66dmBFgSbkXg+ZfrkMAahn/eJ86HdmfwONgAZHS/kwLnPeoq+ZwbIYSAwAZWD+e0OcimN7I4wWCQ1wI1P3bqk2sbEzQL8oLM8HavkIyZZGB0kCqp/xvbHMYUK0YrWWOx2cBATkr8wlHtXP9j5ZpGcSTmKe24NtQtXLXokAGsQcRjNhINdwOQnme3P+vi+7e9whx5BQuQBl9EVdyD9LDljvovKdIfMVNf5LBjWImpBwfcTs1CHYGo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(1076003)(81166007)(26005)(316002)(36756003)(8676002)(70586007)(70206006)(54906003)(6666004)(356005)(508600001)(8936002)(7696005)(2616005)(336012)(2906002)(82310400003)(86362001)(47076005)(83380400001)(186003)(4326008)(426003)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:30.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d276a6cc-a761-4bee-899d-08d99fd504f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 8 ++++----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index f4c9a458ace8..a13ff1783b9b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -66,7 +66,7 @@
 #define TO_CLK_MGR_DCN31(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn31, base)
 
-int dcn31_get_active_display_cnt_wa(
+static int dcn31_get_active_display_cnt_wa(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -118,7 +118,7 @@ static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 	}
 }
 
-static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
+void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
 {
@@ -284,7 +284,7 @@ static void dcn31_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn31_smu_enable_pme_wa(clk_mgr);
 }
 
-static void dcn31_init_clocks(struct clk_mgr *clk_mgr)
+void dcn31_init_clocks(struct clk_mgr *clk_mgr)
 {
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
@@ -294,7 +294,7 @@ static void dcn31_init_clocks(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
 }
 
-static bool dcn31_are_clock_states_equal(struct dc_clocks *a,
+bool dcn31_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b)
 {
 	if (a->dispclk_khz != b->dispclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
index f8f100535526..961b10a49486 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
@@ -39,6 +39,13 @@ struct clk_mgr_dcn31 {
 	struct dcn31_smu_watermark_set smu_wm_set;
 };
 
+bool dcn31_are_clock_states_equal(struct dc_clocks *a,
+		struct dc_clocks *b);
+void dcn31_init_clocks(struct clk_mgr *clk_mgr);
+void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
+			struct dc_state *context,
+			bool safe_to_lower);
+
 void dcn31_clk_mgr_construct(struct dc_context *ctx,
 		struct clk_mgr_dcn31 *clk_mgr,
 		struct pp_smu_funcs *pp_smu,
-- 
2.25.1

