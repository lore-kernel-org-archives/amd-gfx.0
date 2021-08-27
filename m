Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E3C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A3860EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77A3860EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333F26E9D6;
	Fri, 27 Aug 2021 20:45:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69136E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpYfCQap1ys+YwquoOzcI+gixYSw018slcx/CXjvsN1m6W/FgQWjCs0d5vwLAGh5txP1R8QWCfDaya0gPxJzMSqjHAbbsK+NBqwZ8dXnfEuew/fUB93+tNCMMnlvz+6G5HFHS3H/MmnTKr3OilMtlST+GsdVejd3NLjtxTgihy4ouMLdPFJV1bqeIURrlxQffsjPpaeCtGPmLCpzR9fCfyBFUBbm86I28lf0SA/yYkisrNi9834vnOq881qz3B9LPsX0tDt3k95AqjnFu1HUubWSP8KiqwrfjhnmBOBkplPbp4tQOgFwNKEYAfqa+yaCkUeCfWtrOuSyS8qn2rBa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58rhG0Z5sGRDHQJqT4+ZKHzmVvSKd6WljC4WiwRb3f4=;
 b=dqiWv95zApDG2mnWoia02JUuV7ekZEPAzLLTv2p5Ck579fRFMtpByD9rueJ8K4qLOrZAZkl5j+BaEx0al4UackuinXQ9REIp76ISEFuWCwPMxgsBntOpaDRkRskyZ8ORpZYUfjppNY1IvqI6b0Gt/UyiCd1Ub6T3g+jlHv5XnyFUwzmODTedkNx2SsvcDJfx2KS/cATBgxO09TNdbc44HUZ/lsN5iv3v65l0BoDL7kaoraNOvbpTKpjEmMhHaTbFWPZqrtYwnUICVOKRUAIPALdo0lE5b1Ok4R2imSXspp1SSz5CBMfCEn7H9syvR3PhwwnIItZH0Guk8C5U2sw1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58rhG0Z5sGRDHQJqT4+ZKHzmVvSKd6WljC4WiwRb3f4=;
 b=tbXNJBuS95JHEG4Eo+RkdlADTaebJMC0H/ZVCqxE9ti+e1NWilCLAiC/sehmJTqvXk8/qXuaK836FiqC84LXaapJDziMPMauIzZU5iDEky11Snovnsi3TOvvi8YsoBozToBLur3gQmv5cdb4FuEcfWkXxgPE5lDs4doIFPUaPVU=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19; Fri, 27 Aug 2021 20:29:43 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::6c) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:42 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:41 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>
Subject: [PATCH 16/19] drm/amd/display: Fix multiple memory leaks reported by
 coverity
Date: Fri, 27 Aug 2021 16:29:07 -0400
Message-ID: <20210827202910.20864-17-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafb67c3-ba75-4d20-c585-08d969996715
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5431DF8230CB5981A1D2B5C4E4C89@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2skZWREVLhSCdrvGWpY0KEaAi17nO3TlPaI5zGCUXF2DtHQC6q4U1C0LgiFcMHg/MxUUh3gPEUlgflMYNcm/RsddjvkKcyxfDu6jziDxm+o3puzR1jfDhDUee/D1lmUV3ur2fMh7nCi46xBmnyzFSx4gXNM2Ur6evE88d/rtky8ryCh39ygSDQMESV05fFu90BMDcVuOI1StB26aMpPJAZSxtjSMpnGfo0CSh+0F6dvmp+JJC4VbJTPk7YdSocxLjq1swkXrFe9the06I+Y8kUm3K1vmzpu7nmjfut/GGxh21CFEakA7f7WnBO8+4vGUYNp3zZxLECKh8AN0e1uDxrzLnpp3Euqq8b8tt+ZniEfqCuf5U6uOIk72kTq9ATqG4U+VBU4hT1FzA1Pvq/3J/PbZgEYw1JBqZg+EIywJD9fnpdYWkKJqjNIEmndKWrNOhyXBG+PWyKyOt7h9n2IIyeWR66Zwlgch5Epem7oi22OtaKcKdg5twiFZK1tfJ7l16/IZg0HiUvsaaHRlwmBBx0c2/mcnxrFLDqJQZ4cJYJVJaswcOXYXwBB05z64fIhDxyuxdaNnEaz/pWiE3u7JKPdASr8CWu3rARinpwGZ22eAiisJ5m/rnyvizTssEdki5cziTv1ubK5aHoW9OiNpjVMrfiBa+v0V8qgfQU2FaLLxr/u/Yw093jFDQwnpC3NsttG5SV1jScoSuroVgolrLYYwihXS/RBg8WIbF3DEDWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(1076003)(36756003)(16526019)(26005)(186003)(2616005)(336012)(86362001)(47076005)(426003)(83380400001)(82310400003)(2906002)(316002)(8936002)(44832011)(356005)(81166007)(6666004)(82740400003)(478600001)(4326008)(70586007)(8676002)(36860700001)(54906003)(6916009)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:42.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb67c3-ba75-4d20-c585-08d969996715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 6 +++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 596c97dce67e..338f7a8f7c2a 100644
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
index 9776d1737818..5350c93d7772 100644
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
index 7d3ff5d44402..3c196414b1e7 100644
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
index 38c010afade1..d83b9c47aef8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1281,8 +1281,12 @@ static struct stream_encoder *dcn31_stream_encoder_create(
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
-- 
2.25.1

