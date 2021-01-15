Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5ACC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670A920643
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670A920643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4C789468;
	Fri, 15 Jan 2021 17:30:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDDF89468
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNb2qKTI0Km7TtzSUC7hNCGdY4ARn1k68+EgcYoCUAU9WriGRjtAGUq3toaJ9+pIvPe/ld8Rrjrt+F/bq7Yx2PrIw0T5IFOYF4tjaSiG4LoGBRIcgeQHxbY7iLmdUSen7mIKD8m0NHm3bma2AHiiJ+OtRpkGVJw3g96/acxjMIn82Sf2RUIDl1X1KmctiAICMJH+lTqffVEBYTtrUhl47Kl2NmwGa9WQfnBNIcmUB2Ani//WW2hvzVzAHNid+SQcQVc/TXu0Qo2ROIab989BDY+cg9dgmWwG5jRg9zMOyIFKRq9LNT43blcLaGmmz7WdmkONR1tckgTaZ8GUSvlKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqOrRH3TUrTWnYTPgBESV1d9f2QlAVrg57eXpVmMwBk=;
 b=XL/fGaIurehSaJhS4AQbGlFUj9SkFMD8H15KtTQf2oWi1jQIEesGiUrNqWKlK/dME8XLh4ABSnh8y/GBUeER2Iy3o44tQZTCoj6UuRTHnHsPgy9f/djBb/iyvg6oHo3ftjxppUW2qeeywgAslN5Vaf+32yivu224rO8gx8rcpI8DPAPM53AmiybiMs9qBMK68QDW3BQOHYrnY3DX+Ls0wfxhaPb2OqClUdsXi9lZGOgFuMMIjRT8jqf5TZ1l3Kypvhpytwn/5cG+GCD2xCPUlg+oTG5jCiYilSWgxXw4s9pDhjSRriVx18X+pPHeuGqnQwqQNF53BvPME4eR/cPYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqOrRH3TUrTWnYTPgBESV1d9f2QlAVrg57eXpVmMwBk=;
 b=fRh3CAUSIzRQ0HAZrraHfg+eI1vUeiCfODUS24UbgiBnt4y0xS3n28pnhiReR1CO/N9AH4C9hcaTbapIeiFqI4aBCM2P6MlBIn36Q4Pg1qPP2LMSgir2WETL62kw5YMBGudRJSh77hxnyWqow6uhRRl7mSW6pBQY+bQEnTdFoIE=
Received: from BN6PR10CA0047.namprd10.prod.outlook.com (2603:10b6:404:109::33)
 by DM5PR12MB1849.namprd12.prod.outlook.com (2603:10b6:3:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 17:30:45 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::60) by BN6PR10CA0047.outlook.office365.com
 (2603:10b6:404:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:30:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:43 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:42 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:36 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Use hardware sequencer functions for
 PG control
Date: Fri, 15 Jan 2021 12:27:06 -0500
Message-ID: <20210115172714.126866-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430efc1b-f539-4ed8-42d3-08d8b97b499b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:
X-Microsoft-Antispam-PRVS: <DM5PR12MB184987BA0B2C578B1258E108EBA70@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKwdLWGJ3tQMSfkGKAqniHGv1GIycP1s63UfvrjgxcdhNbgFr2HNcGMav9cSz4C1TUmd7qrHegw2NSuyf3JFEHbjDS8LPIs2oc3w+V3+5p28N6LC70tl2oA5IGyVlcY6ni+KzkuPOsf8NthsqV2W1m/t6WnEOeilnw/XbzWsV/K7kto/vi3dxAJq32ZEzj/C5JZOgT4eYICxY4eh6QhLgSs2DCAvsLb+TJm7M2hGTfHUuLCWsTZ/a7GPJdEuWrOBzWh/Hogi/XfeeAuSXLXETxS6EiHqia+VxCCKyy4EgtfGkyMjKz3fehLZFGh0+DBF48eGl/E/PhHM8Q3uUtEjrwECNDeBDBNGnY4dAm7S/uqhI+vcDXsqnxbhdQR3QKYgFqsTPzPthlzkoco6eQtc9HmjKPlAN+TeCDfP/hhGUbrb82xgbjhBnNHk/5lPmVh5MYdk48mAZLnERXPfNeOaTxLsvbtZVK891cW/tlBkUR1cRQBVQKBHsxkcisxmu1/Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(426003)(8936002)(6666004)(82310400003)(316002)(26005)(34020700004)(336012)(1076003)(36756003)(8676002)(4326008)(82740400003)(2616005)(2906002)(70586007)(81166007)(5660300002)(54906003)(6916009)(83380400001)(47076005)(356005)(478600001)(86362001)(7696005)(70206006)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:30:43.9503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430efc1b-f539-4ed8-42d3-08d8b97b499b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
These can differ per ASIC or not be present. Don't call the dcn20 ones
directly but rather the ones defined by the ASIC init table.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 18 ++++++++++++++----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  9 +++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index add86d4086e8..7a30d1d9b535 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -647,8 +647,13 @@ static void power_on_plane(
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
-		hws->funcs.dpp_pg_control(hws, plane_id, true);
-		hws->funcs.hubp_pg_control(hws, plane_id, true);
+
+		if (hws->funcs.dpp_pg_control)
+			hws->funcs.dpp_pg_control(hws, plane_id, true);
+
+		if (hws->funcs.hubp_pg_control)
+			hws->funcs.hubp_pg_control(hws, plane_id, true);
+
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
 		DC_LOG_DEBUG(
@@ -1082,8 +1087,13 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
-		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
-		hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+
+		if (hws->funcs.dpp_pg_control)
+			hws->funcs.dpp_pg_control(hws, dpp->inst, false);
+
+		if (hws->funcs.hubp_pg_control)
+			hws->funcs.hubp_pg_control(hws, hubp->inst, false);
+
 		dpp->funcs->dpp_reset(dpp);
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 18653c423c96..0726fb435e2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1062,8 +1062,13 @@ static void dcn20_power_on_plane(
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 1);
-		dcn20_dpp_pg_control(hws, pipe_ctx->plane_res.dpp->inst, true);
-		dcn20_hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true);
+
+		if (hws->funcs.dpp_pg_control)
+			hws->funcs.dpp_pg_control(hws, pipe_ctx->plane_res.dpp->inst, true);
+
+		if (hws->funcs.hubp_pg_control)
+			hws->funcs.hubp_pg_control(hws, pipe_ctx->plane_res.hubp->inst, true);
+
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 				IP_REQUEST_EN, 0);
 		DC_LOG_DEBUG(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
