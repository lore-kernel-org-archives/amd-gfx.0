Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AA2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF27E10E1EC;
	Fri, 25 Mar 2022 22:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2774A10E1EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H12zYvJSH2WrUU8E9tPpL3CWoH1DbgsITZ4vtLMUzUgddnnMHzqxy3/+tzOr/Tg/irnWvi+8w6DamFQrKCyyno4ILe8lwqLDEuRrNfqeKQONHflMGfvSf01rl8V67hZovW9UV3ecQGeaekPzCZ3REf7cfKK1Z7HhDBvutpDsKh/rPbQ0m7KoPco1URZc7Hl9yCcmUe+zmp8zPkpVV8VKi3+aWHakEaUI5FAE0XOkM/qEkeQE58+RkKQFuMRkHoEnt+M3FMDnGSoy35sReQqf0sETEavHyMcu93vPs+smAMtmJdcDKiK7n2gNYuP4Pjrf29B6qjasHs17BR+Wd1pDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex7dgCLAHz9ew8dayjR23gGhh5UoHIFmbZfqSaC5Fa8=;
 b=iTZ/NmNRp0qOHEZwrOpPQ1kPrSHn6h6soMlVG44SlXZ1mpZsWlcZbd+Bzw/uiD1Kr9C/JoYKsRL3uyHru+k0Mw6v5y5KUDauVDmQ4PNeNaaCsgNo8YUV4jTTGqIRFl87+t3GvxF72/O+S5f2ww+SS39h73w3xGlyQgIOgnh4ZeWbjzu03GnFZWkmio6RBdAxrwEEsTnIb4FZEpBjIhvZ+ut2w5gxsEoaSATmNW7GY/+Z2/aC+XeBUA3Vqlqpxfi3XBZpaIgvKpxKR6b9p2qnW4ZZVEvTw5zBxAUMhbdwuFL7aVl5s6msUevpK17mQ8pl/6AW/QWsXKhL8rJENrWEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex7dgCLAHz9ew8dayjR23gGhh5UoHIFmbZfqSaC5Fa8=;
 b=WkH5C+M5TuSEsrOgXSHeTFWNQbLb2dztUIjvlMhurgm82C0zUELbrs9QJvEJVrqjqbxbUVOlEGTjN1mWLSH7j9sey/bEnUKe8pdarBw5LhwjtXkDmcCGLZChFgCPvyIbr0y+FqfNbgwWKljE3FFkHN3z67uAEaAurMmof/mg2eE=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:56:34 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::fe) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:56:33 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:56:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Enable power gating before init_pipes
Date: Fri, 25 Mar 2022 16:53:54 -0600
Message-ID: <20220325225402.469841-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac884e1-97d6-4598-f39d-08da0eb2b5b0
X-MS-TrafficTypeDiagnostic: MN0PR12MB5763:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5763DB616D87039B55C82A20F71A9@MN0PR12MB5763.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0oPRIV2dJnHI40bVdFEBDIxYV+7t6uEeHea/CfjgD1QRE9lbD8TqZsmen1YslpUmRXsvLaPH627iIbqyI7aihWRAVfb7PX2FA5IZZZhrKfHb1psOvRkG2jwg9jGiQ0oYUmEImxe0H4czGTQXm9UCxZ8tiprHTfYD6V+4wDuMtsULIiaStXrYGYhJhp5UW43YRVbP9Amc3oaJWxuMgJHzgZTKQRGKHkbAB4PZC1m9dPgN1so9iRMFWIE3hERlzI1O+N0jlTtvRltEkKxFJambFDAz2/NQLTiyDZ3eFCudL+VJ7yIf7pylH/+ApZ/meDM+ubbki8LTTnm/2Gk5kUY5QQXqpJAx0A7n5jGZgDmtincJZF2u7RveR0GW0hku2gvskIfY+/ygNkTCmNgDgYz9MmAQ71PxLl++QtNzhtM2+Lrl7j/OVL5FzBQod2wX4KrMdbF8iypP6FgZLuSBe0ZMoi5/4GEIfuWIWPEOgtDdrDDXHaQvw0b1hxHPv6TJ9lGOoVsSneLSmpp3f84w1LWOU/qdB4IjrmgdL4k27j7H8qU+5YRRttyJb7Zk1BjvoiOAabep1pMEKenFNiUiamvGpgkFr/C2qHdJH+oxg6aBS6X0yQOhlJDJlfXzO0N3RekuyZ8KApORla6TQ5F6kB5Cf+FuvU7NsH8U3PtVu78oTWfzjtZKx/ovlRy1DRkjb5Oj9+gwU/QS10sEQtOHNSWfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(8676002)(70206006)(54906003)(426003)(2906002)(508600001)(40460700003)(6666004)(36756003)(7696005)(6916009)(356005)(16526019)(81166007)(1076003)(5660300002)(86362001)(316002)(4326008)(336012)(82310400004)(70586007)(26005)(83380400001)(186003)(8936002)(44832011)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:56:33.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac884e1-97d6-4598-f39d-08da0eb2b5b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
In init_hw() we call init_pipes() before enabling power gating.
init_pipes() tries to power gate dsc but it may fail because
required force-ons are not released yet.
As a result with dsc config the following errors observed on resume:
"REG_WAIT timeout 1us * 1000 tries - dcn20_dsc_pg_control"
"REG_WAIT timeout 1us * 1000 tries - dcn20_dpp_pg_control"
"REG_WAIT timeout 1us * 1000 tries - dcn20_hubp_pg_control"

[How]
Move enable_power_gating_plane() before init_pipes() in init_hw()

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c        | 5 +++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c        | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bb309ccee3e4..e4247740ac12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1504,6 +1504,9 @@ void dcn10_init_hw(struct dc *dc)
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
 
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
+
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
 	 * pipes we want to use.
@@ -1556,8 +1559,6 @@ void dcn10_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
-	if (hws->funcs.enable_power_gating_plane)
-		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ed0a0e5fd805..f61ec8763844 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -547,6 +547,9 @@ void dcn30_init_hw(struct dc *dc)
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
 
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
+
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
 	 * pipes we want to use.
@@ -624,8 +627,6 @@ void dcn30_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
-	if (hws->funcs.enable_power_gating_plane)
-		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index b57f657c4e44..67c13654ab99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -203,6 +203,9 @@ void dcn31_init_hw(struct dc *dc)
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
 
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
+
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
 	 * pipes we want to use.
@@ -252,8 +255,6 @@ void dcn31_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
-	if (hws->funcs.enable_power_gating_plane)
-		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
-- 
2.35.1

