Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9715A60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9715A60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B4C6E1D5;
	Wed,  8 Sep 2021 14:55:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1235B6E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfp17aHLaq4MLynV4PMHRoe1V6Vdu4mH34z3AnwJ/qHrl6i5/e0dfWNdJpJZXylMyABzWta6I5WI/KFcNGmbB0lrCd5exO4Liz4uECcy9AsFTbY4XRgk3p7mwfiEaAM+qEMS57JWpro9Pk1UPQAS7OV/cFp9LgY8dcItxe+7OU7WMCiR4gEJYs+7zWNYKlIpLlGREtF/BfdlJZHASci/dbsxBpPxV/qUrLnaU0Mc9gqgGFilBL2qZDSwgKY4fkrmC4RGqo9sFGRMj8I3haT7SX/rQD0AIeBHiswlAe1ItuXmPq/06Paekh5OI3oqroja3B6KQCsbS7ilr635B4Bm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QIlPyBY2qOb9EgzqYO4lSDtaaweSt+Kj8idGWHlbJwQ=;
 b=G6kEfKVNH/BABABqgOp3Sux/oYNIU/na8HcK02SFXyr5HbFp2+dXXSCOYJh2G7KT7ADyQsxT83gIkkOBnJ16bi58qnjUR2cA1kJfvOlaCFMs37RR2gDTvGF/YDuQuDQQpJRcLTialU2f96jl/dXUaWgb7pvYhI/7OIAOO3JM+qNyNTqDBcOE3O8IOEwuudT9yMpBDA9hyIpvtSW33aTT2nzvk2CiPsQ9kqk53gIojR9bKMxWsgChbYGfuJVERALVKF+1cV8fkiqq9F6/+HYAwtXPzczFLmIdcKnFg+Q+qeZprVFCcIqmB+Pd5wotpF5Lr8+y7qjz1sHroP1PPhYwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIlPyBY2qOb9EgzqYO4lSDtaaweSt+Kj8idGWHlbJwQ=;
 b=N/wkAekFnjAP+NWwJkqVr+d77cIhaoWSO9COqLoTGpREMXWuvKcfJL+rVGXzY7PRhI19heuvuPeEsdqOlaVwqbSBVJ9O4iecy7m9wQ7CvFLfrILae51+esW/UL92i+AMV7zMDnfd9E1Gyvn5WSmWuSP3Yt0YYUyLr3tCyJKkDpQ=
Received: from DM6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:5:134::37)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 14:54:57 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::27) by DM6PR13CA0060.outlook.office365.com
 (2603:10b6:5:134::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:56 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:53 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 15/33] drm/amd/display: Fix multiple memory leaks reported by
 coverity
Date: Wed, 8 Sep 2021 10:54:06 -0400
Message-ID: <20210908145424.3311-16-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7991e3fb-9cd0-474d-7a9f-08d972d89fe3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-Microsoft-Antispam-PRVS: <MN2PR12MB375945258A45460D4B485954E4D49@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXnOD+SxXOcBwr6Op5g2JZUd5zJgRof9xid7j5zofLD5FLTgMAkpmxM7OE/Dc9RNLRXQUru7rZz14h1oRWJmS0ScbRUhd5FyGKFjAsnJyIMnmEHk37KJ85mLPw+2bg45MidTqigCM5lqpdX0fazWeGY3dBJdFRxOCW3cvozCXmOxVZSoY2FKOfOfCi4qmaQmI2Flh2+j0wVrlWD6om8grFiZbAZskv5uor7V2X99aXTVVGSrvsrRB/9Ue9mIt4VnE1rmyGCEFBbDyv+dE+eB3vHu2bJFf507FzbhI+YBc6M3fRQZi3C9J1eBX/+aVQMHspP67SsjC23hz3f8yFtHMRIY8Unoro0RnnK3HjtCmilUFlfuAeNY0W8mTKIoX97Zc0XAUP384fLrexVwpe9rQYQOPQQrqWWmOWBoh8U3GqTo+zM3AGLzoVnS/kvm5XojBKO0WGa7bNLKXN6/7Mwu7e91XcrA03CFcaieVeRsH6DQhao1y0rWqhaPx+v2KnTrvoIUNKSGdR0IcVSjDjs76ziWtUMYw0QJ2sdr11E+ncEipW8kWKGXt6SHDdxOUE2EsZFCZ1ttxeZXwYLEmwwcpsSmPAeEAZIkdFn7Rs+QMFf85hylry8tWP6gj/H8oxp9e4sdb3E1OFyv2643Gsn6U+3NrZsuUTqsRchGXvdREEscn+WDlvQtp5SXlcWjeb+7xSD8DSdBs5uZ2PhGtKAHw9NIcGGU14P9FDlV2DoXjKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(82310400003)(4326008)(82740400003)(26005)(6666004)(2616005)(5660300002)(1076003)(6916009)(8676002)(70206006)(16526019)(186003)(336012)(70586007)(8936002)(426003)(36860700001)(316002)(44832011)(86362001)(47076005)(83380400001)(54906003)(36756003)(478600001)(81166007)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:56.9584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7991e3fb-9cd0-474d-7a9f-08d972d89fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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

From: Anson Jacob <Anson.Jacob@amd.com>

coccinelle patch used:

@@ expression enc1,vpg,afmt; @@
-       if (!enc1 || !vpg || !afmt)
+       if (!enc1 || !vpg || !afmt) {
+               kfree(enc1);
+               kfree(vpg);
+               kfree(afmt);
                return NULL;
+       }

Addresses-Coverity-ID: 1466017: ("Resource leaks")

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c    |  6 +++++-
 .../gpu/drm/amd/display/dc/dcn301/dcn301_resource.c  |  6 +++++-
 .../gpu/drm/amd/display/dc/dcn302/dcn302_resource.c  |  6 +++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c    | 12 ++++++++++--
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 2feffe75ca62..3a8a3214f770 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1164,8 +1164,12 @@ struct stream_encoder *dcn30_stream_encoder_create(
 	vpg = dcn30_vpg_create(ctx, vpg_inst);
 	afmt = dcn30_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 912285fdce18..73b8fcb3c5c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1195,8 +1195,12 @@ struct stream_encoder *dcn301_stream_encoder_create(
 	vpg = dcn301_vpg_create(ctx, vpg_inst);
 	afmt = dcn301_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 5cd55e8573f7..fcf96cf08c76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -542,8 +542,12 @@ static struct stream_encoder *dcn302_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn302_vpg_create(ctx, vpg_inst);
 	afmt = dcn302_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios, eng_id, vpg, afmt, &stream_enc_regs[eng_id],
 			&se_shift, &se_mask);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 91cbc0922ad4..e0b93665bf55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1366,8 +1366,12 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt)
+	if (!enc1 || !vpg || !afmt) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(afmt);
 		return NULL;
+	}
 
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
@@ -1412,8 +1416,12 @@ static struct hpo_dp_stream_encoder *dcn31_hpo_dp_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	apg = dcn31_apg_create(ctx, apg_inst);
 
-	if (!hpo_dp_enc31 || !vpg || !apg)
+	if (!hpo_dp_enc31 || !vpg || !apg) {
+		kfree(hpo_dp_enc31);
+		kfree(vpg);
+		kfree(apg);
 		return NULL;
+	}
 
 	dcn31_hpo_dp_stream_encoder_construct(hpo_dp_enc31, ctx, ctx->dc_bios,
 					hpo_dp_inst, eng_id, vpg, apg,
-- 
2.25.1

