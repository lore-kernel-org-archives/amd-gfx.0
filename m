Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33028C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BD010E6C3;
	Fri, 17 Dec 2021 21:24:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF68B10E6B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbz/y4+OWx2kTAfp9Cek3gSi3c3eTnWxEMnEcN+KyzJXhMBnJqfyyWtRob0TgIBhVbmyNRbjp5OROm+zKV1zQky9H6TYd+FKOpPRCx84lEWsJJ4xW0wUBtY+AB3ci7AL7LsRu+x1TMqikHa8N8FN6ry1uspokQ85zzhX+kDEirtRmzU/TM22CF8yKhkkRf3grBJ9IHIROm5DfptLcZSvEQRPWOu6SnAD/RY2+5+vxX/M6r4R3LpauSeBUaTg6aCdoFrS2evUD+LaljlMirsehmQRyaWvSh387LAcxtFqNelnAzl8gDUcr0Lg7xGuduqtNJ950wuDzfCSSdTbLw34xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWNx6ThlXigjsflbEolVrVaXkn6gwNtyRG3JavcLXxs=;
 b=IaBFdDoRpKKJE5JdAUzYOf8sFmScno3OODsHuCCzk0WXS3u/JB8L7JuQLwW5mvtTsecAoLbr/eDRR1FgBg6rIfcYzRqL9D9kjMm8eQyX3dYO5Ufb1sLNrnJz/TtEhW6PE1HAY7hHac4DQNOKhtI2f8P3Hqlq9vb7YEZ0GcnbvoWkhDJTSi5fz9J791U4/rx45jI1+yvuqH3rkE4rDcnSM+aygOdaMIf6a6J99sB5GRpNJfYA8xrJodgTFMboixwPnnvRu3n0vaJ8Aoh3Cb76gtd+eTCBM6gTJJgCD4pOvG+d9jv0sWVWLiI5tVREcgZm4+FkyX5HZdl+FneXGZz+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWNx6ThlXigjsflbEolVrVaXkn6gwNtyRG3JavcLXxs=;
 b=4cn0TrbozZ8/D0AsefrgZafkJxdYeE9kJk9hPTs5//jetvGmHqqOUvU+OU1eExiW6qK1nYlNf8Wadm7OG2b7jLz5MfLFdL45leBXhAJtCfJZ9cCQSfH/b6M4lKfky5koKuGJp7qElMc9Eern8l+k3h6F0XWIeCFlJaWKPiTZGfo=
Received: from MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23)
 by BYAPR12MB3158.namprd12.prod.outlook.com (2603:10b6:a03:13a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 21:24:42 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::f4) by MW4PR04CA0258.outlook.office365.com
 (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:42 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:40 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: populate link res in both detection
 and validation
Date: Fri, 17 Dec 2021 16:24:04 -0500
Message-ID: <20211217212407.3583190-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e709049f-e2d3-43ba-c89d-08d9c1a3a3d5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3158:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3158AEDFCF74584059909B5098789@BYAPR12MB3158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGbbxykR/VQm+NlRnVuZFTUsbVrKGSzeCUOpYbPosqkHeSOiy52x9D3Q/6yW5mlY2ZN7BH8cATPB3PoWYM692vpAS3gZ45MibiXzL2HX9pbcoRycpJD30nKjHqdYCXaYThhFOWdKjFEyxTcbO9h2NoWWEyHN0+vdLqXW86a3k9fim2vfRXptliTRGFGmdgDc929OIEEFAF/YW2V/SoCiHCyt4p0c0PYzHucWRSAmCwzY8xEUbtyWYq6Gx84bD5ePZnR3Ty2gayRpoCkNee5v1d5EMFQyzXam5yj+jJ5DgEb0pN5unZjmiV1kJxb1gE2OqnCS+cZZ17ce6V1H+Pro/a9MqnzppOqvBatiAkPd164LVvuCIp3suPlrmesV6T+zbvqJbXBODRz6XUvplYLpDmdI8nXIMEKzBX2Kwogrj9Bez8GCL4eiGIxy717J+AQTq/DcBvVkYJIHFXjTc8GbjyX1MOIGTc6HifEpPm9Kk8rIQ5ejttuPKdQUPn/U62crTY51qpsEcaAhuxBYImtAgZsCIlauc2DIiUG6UUHmDSHujKzI6PEhf12eL17JKecMSRzOvYg/3pWFtsff24HLOLiOzeScqEi1x/W5espX+Gjuf6FUPpFp6mShgZDnXII24lSceyqw7p7s88kcXzKaLMp1gy6tIk+RfUPQYGQqTnXQXj0WYQrawVW9UD2qoM145A1dX54moTXnEMmAmXiTDWT8KI9kgZRev1C/18EvQkJXkXwUhFS1exnyOkm8pPGeObrg2Ub73RpAXS3M6atT6GqrbVyuJAXBzC3nv8WA98k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(36756003)(186003)(2616005)(83380400001)(86362001)(2906002)(8676002)(336012)(47076005)(70206006)(6916009)(508600001)(36860700001)(40460700001)(316002)(8936002)(6666004)(4326008)(54906003)(5660300002)(1076003)(81166007)(26005)(426003)(356005)(16526019)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:42.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e709049f-e2d3-43ba-c89d-08d9c1a3a3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3158
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
This commit is to populate link res in preparation of the next commit.
The next commit will replace all existing code to use link res instead

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h   | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4130cd98f1ce..a394946ef513 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -881,6 +881,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	enum dc_connection_type pre_connection_type = dc_connection_none;
 	bool perform_dp_seamless_boot = false;
 	const uint32_t post_oui_delay = 30; // 30ms
+	struct link_resource link_res = { 0 };
 
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -974,8 +975,10 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-			if (dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING)
+			if (dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING) {
 				add_dp_hpo_link_encoder_to_link(link);
+				link_res.hpo_dp_link_enc = link->hpo_dp_link_enc;
+			}
 #endif
 
 			if (link->type == dc_connection_mst_branch) {
@@ -986,7 +989,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				 * empty which leads to allocate_mst_payload() has "0"
 				 * pbn_per_slot value leading to exception on dc_fixpt_div()
 				 */
-				dp_verify_mst_link_cap(link, NULL);
+				dp_verify_mst_link_cap(link, &link_res);
 
 				/*
 				 * This call will initiate MST topology discovery. Which
@@ -1150,7 +1153,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			// verify link cap for SST non-seamless boot
 			if (!perform_dp_seamless_boot)
 				dp_verify_link_cap_with_retries(link,
-								NULL,
+								&link_res,
 								&link->reported_link_cap,
 								LINK_TRAINING_MAX_VERIFY_RETRY);
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0da692c9a543..60a9eb6e521f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2161,6 +2161,7 @@ enum dc_status resource_map_pool_resources(
 					&context->res_ctx, pool,
 					pipe_ctx->stream_res.hpo_dp_stream_enc,
 					true);
+			pipe_ctx->link_res.hpo_dp_link_enc = stream->link->hpo_dp_link_enc;
 		}
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9381ea0549d8..0bd28a332fcb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -336,7 +336,11 @@ struct plane_resource {
 
 /* all mappable hardware resources used to enable a link */
 struct link_resource {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct hpo_dp_link_encoder *hpo_dp_link_enc;
+#else
 	void *dummy;
+#endif
 };
 
 union pipe_update_flags {
-- 
2.25.1

