Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF58C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F6D10E6D7;
	Fri,  3 Mar 2023 15:46:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7114F10E6D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDRGI25PuBtxOPkkcBAxJT/4LWkTj8eJTyV3yRavwkSKtxUmLnax9hqeHFyVkcykR05BG9oC5itOyTv12wsPszjRsuaUCnylpkpaSwcE9b32OAClCtUoQQ2CUKU5cft9tK4SJpA4F8Pn/DE/Z3yC3/awpUrKuNgDeTah3ykhe+9BaBBYlG+oVjyUnvQpyfTOuJ+jx2hb6TBsJ5Gmr5eO5RBjotsZY4iT7GxHjYhI2HF28Q3IqiI8JECgwlXAxzT88bdF4d7p5TKoW5YhUZ2oWOJTI34/Rws2sjz49QUglgy7httbWbDqIde6cjfmFRdhxtdm8KlsHRGfGdQ5H99MyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4RcfsMuYknu9xZph+NDoc7c5MVVx+kXDEl3r6i2P/s=;
 b=gx7Bb2fgD2qglMYnJanVpV64ZSsmwmKeyfrpSsco7VJANOQDu1m3sQG4iCzoNK4STH2+iPqwEjaFAh6bghl3fE5KNyTKn4V3AI4FT/TKMJaH0IGfmgyN08bcOei2gYHOA0Bmj8H/HGz3OTC5AyMHpJ7wQEZwpB2ixHFP4VSZDUDDERNgetavfYfVTxerS77Z3jQYn0KhG5G+R8jigM/KSd5f7nffAwPDbnK9PMK4e9/CFIvo+Sh3Di2DGfqhD6nPaqxm6JrLGC4hNVOlD/kF49spCPbLyQIC1Pd/Jrm/6A++7wvEo6Mpw116p4wfHiktJb+Do4o5cDwo7TUoiTg7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4RcfsMuYknu9xZph+NDoc7c5MVVx+kXDEl3r6i2P/s=;
 b=KZNKhYNVazCQxlii4mO6JvT1bJ6qX3XCIQ6tM50VQptUgAYvxz2arYqyXFQu909sW22Icq/aQCmnPwMUXV2X89D7AXQds4HRwQa7gqs1pWgMxi5EEqrZVx/S1w66k96l8eJ8VIkFwTSAaSqw3SMo4PuLgThD9zJtuvz/st7RSog=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 15:46:44 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a7) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 15:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:46:43 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:46:27 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/33] drm/amd/display: fix typo in dc_dsc_config_options
 structure
Date: Fri, 3 Mar 2023 10:39:58 -0500
Message-ID: <20230303154022.2667-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: c4225a94-b1cc-467c-d007-08db1bfe7d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1toAc5PN7jjpfVhqB/UvZPkQSS1G2e4FxE1rsIScXFteXpjTxsDUM+mPfbvlntUbDSmn0VxMobpgs+0jqZdBqzdArsvmMUR0v6wQcvK7jUzHBJyfZC0/VKUTvtQXhK6stDYhPOCYsLTdrHmEE5ZjnpK3TvIFnWWugksBYWwH+MUfGCgHH4+fKkZaQQ34xaz6bRVvcG4Bbb2do0a0y/34cpHoceTlv6zCGTAshRb6dKlGZK0WcS5lyURofGEt9zt/k8ZoVKTeZ94PgTZz0D2BrGoni+kbn8xIxcD/3j0qfMBmFKzs9GPwrvP5uo7bJGGfaaESalyNAebSrrGmJP1wEehyhfGd2b6TJ+QpbZ5VW2amBJfLUPTDQLZ4sd6/GxD+SUwBPG2MN+Gipq8gVM7cfyrUdj93wNfqZZtHy8ByznmjbXLuTtoWW5FHCB+BQ7PuH9cU16MpJp1IwwLp6SxdlMTau3YZWpbP8VG0QdKd4eBhWIm3GzpWgLNkBp+Tj7q58wvtfogYojd5b2bHQPtUioKWRqLxue5xhtA4hq8650rCbgawe66gj/NvxjNI8/TIoFvRqEIpj/3e7AkSmBgZYMEhuiCwWTybJb7CYMPyiV14HuFPE+/QP1ztF4I/3XoVDAFFlUpjzyo2ZZJ14NNlZzq7u/9fzA7Kv7EUCztdRPtW3eBd2G20dHKc2C0ueHQ1yDzsG72lGq2NiylLP8trXCUDUyZ2p9o4U7USvKXwSk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(86362001)(8676002)(4326008)(6916009)(41300700001)(8936002)(70586007)(70206006)(356005)(316002)(2906002)(54906003)(44832011)(478600001)(82740400003)(82310400005)(81166007)(6666004)(2616005)(1076003)(26005)(16526019)(426003)(47076005)(186003)(36756003)(36860700001)(40460700003)(336012)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:46:43.7685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4225a94-b1cc-467c-d007-08db1bfe7d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
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
Cc: stylon.wang@amd.com, Mike Hsieh <Mike.Hsieh@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <Mike.Hsieh@amd.com>

[WHY]
There is a typo in dc_dsc_config_options structure

[HOW]
Fix the typo

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mike Hsieh <Mike.Hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 81e62a630d78..0e92a322c2ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -57,7 +57,7 @@ struct dc_dsc_policy {
 struct dc_dsc_config_options {
 	uint32_t dsc_min_slice_height_override;
 	uint32_t max_target_bpp_limit_override_x16;
-	uint32_t slight_height_granularity;
+	uint32_t slice_height_granularity;
 };
 
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 8b5663853efb..d9622a0f448a 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -355,7 +355,7 @@ bool dc_dsc_compute_bandwidth_range(
 
 	options.dsc_min_slice_height_override = dsc_min_slice_height_override;
 	options.max_target_bpp_limit_override_x16 = max_bpp_x16;
-	options.slight_height_granularity = 1;
+	options.slice_height_granularity = 1;
 
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
@@ -918,7 +918,7 @@ static bool setup_dsc_config(
 		slice_height = min((int)(options->dsc_min_slice_height_override), pic_height);
 
 	while (slice_height < pic_height && (pic_height % slice_height != 0 ||
-		slice_height % options->slight_height_granularity != 0 ||
+		slice_height % options->slice_height_granularity != 0 ||
 		(timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && slice_height % 2 != 0)))
 		slice_height++;
 
@@ -1111,5 +1111,5 @@ void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_
 {
 	options->dsc_min_slice_height_override = dc->debug.dsc_min_slice_height_override;
 	options->max_target_bpp_limit_override_x16 = 0;
-	options->slight_height_granularity = 1;
+	options->slice_height_granularity = 1;
 }
-- 
2.34.1

