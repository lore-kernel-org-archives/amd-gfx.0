Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C56BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEBAAA4AF;
	Fri,  3 Dec 2021 22:59:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A99AA4AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfoemSkInOVEJ72LYpYbEggPkBMZl9qUk6iFd4XtvQ4OVZ3VKG9Bn2VwkdG1pik2g3adpUznw6LfnMkdJa4NDQRQOWaCie738iQDyBbWTG4Gjq1nj7TIlJLU0yUaEkf7YnaeChk5oywJyZX34/GWoHJ/eoNNOOuPNBnAe9KZJzhUHtctWL3c6rVrNFYLjxxZSsJblVlWCwseLgcm6WrbvwJiSHNpF0x1Mazbumw56rEro+jY7mrDEg0tjMcVeeIEe3cpFq35WimKRO1JW0Q+wdBfTcalSrKaKjV3Jm45WrNAzzofbaXIhQay6CB/9reSVKLoB2P2jqZD7KGLDhAdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqkISDNiThp5c8/8KZmjEKm3AVCrqpkmW5qo4Ixcjzc=;
 b=NV3fHh0tZkp69jjgs4BjtDHw2GB2P3YtOVzl86MpYndMQ9SV2nqmNQtD+F30ohWBmHrAEiyb98swJFIvqVd/OdQe+SQql/drVJRhuTBexzoKC8NhGdMtUA4ULnMAQPBFp5NwFQsnB4Yf2tJAXlQPOdrn8SsnoDcvRGBeB3CBhm+5UBN/T7iMFrlUHi3K/5oTPviUnqA3JJ1zoXG1jAC4DVc8zCKiQs4ewaerpCoxXGuFGwplHSEj2HMl9nZDAKDnqvbuk3SmEkVcLHIYMZvv41Q8Vr96hkMwupUmZYuqcAotH8UV2rWn8N0kE5H0XKlBwE2Dd7uwIqDxpeDvrt6FWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqkISDNiThp5c8/8KZmjEKm3AVCrqpkmW5qo4Ixcjzc=;
 b=CHdAXi2H1iC9xZe1bPpqx/tEOTtgavpEu0Ckf/WXg91oLYVFaphZZM881oJ408PWa3AOF7R4dGMgPcAdMzZFEVcfAB5mGmsvHwWIfDvVf14NisQYFI7wbkRSntRiCryVCiKkmiGAk0To9xFuKCKjTW2Bspm1EDSd74ZiZVDJ3dk=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:59:08 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::7e) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:08 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:03 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/15] drm/amd/display: Move link_enc init logic to DC
Date: Fri, 3 Dec 2021 14:57:55 -0800
Message-ID: <20211203225802.651367-9-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20367050-78f5-4723-cf7c-08d9b6b08378
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3965188DF50BD2F3B173D9E3FC6A9@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpWfYODKrnxcL6lLRQCvWBV0Je5EgiaWzivHfbamRWmwv6wGmH016uZVfWsrHWPAGPrPfJ/Ll3efYc8jFDeQO0a3y0AYEHRWBTzoX0hfehv2tE+wvbnaaWERuqOlnaTCKZ9xJNrWQa7qc0mq8OyjLWjcV4gtZV1daULPShn1XOlpcILSlp2mbun5N7nslTZhdKa3b/rxnlBJjKwTXWIA+Q0CgwAlTykmH2fE9/4ZvQoojS8AswUJ7ExKPvouS8dg/McKRfl/gsrh2VXlP4Z/PswT0iAKk4bD4dYWTjWGVFSzTAwk96ofoWna83p1imWk1dJkW5K1RVuvmrd2EqhP/JFZW7Z60jE56F/3O18tkdUz/sjo5+iteBwgEu3IIKnxbNxd8aAetV4qKUFoCj540dlVkGXUQh4c6AGyr00qfHVP8JjE1WfApFklWKXiWyvO+MOgNifIi2OkyMMWkHfCWg7rVCSLRJHhX+DcGluR1lU09yD9s7fzcgVyGZa/6/7gg5z8Mjtj7uI++1FNkmKWQlJBojrIYnXQ5dOtb2hoV58SSdO8kHq65kX79nbW5HXNjqoFYMXJxYEjhlGdD8vOYEO7P0bk2KdIJEDMTHnGTh54dCN3aP5EeHDZmQ1Mh2xitOaOuySH8WdErzdtUUvXVMltERwE3qBQtTr6VzcMrVFnPQine6HHLKkdRuuvxbSKjER1fWeD9yTxAgoMlpaHT2wFhpmcopw/oBzbbHKKYoRvOh0Lhw4JTMM2Q4MR0rFK+ixGHsH8Lb4onkZDr+2LbXnO8RnzgIXjbKR8sn8jZ44=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(1076003)(6916009)(8936002)(47076005)(26005)(6666004)(16526019)(54906003)(70206006)(316002)(356005)(40460700001)(336012)(36860700001)(5660300002)(2616005)(7696005)(36756003)(2906002)(83380400001)(186003)(8676002)(82310400004)(508600001)(86362001)(4326008)(70586007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:08.5399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20367050-78f5-4723-cf7c-08d9b6b08378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jude Shih <shenshih@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jude Shih <shenshih@amd.com>

[Why]

We shouldn't be accessing res_pool funcs from DM level,
therefore, we should create API and let the flow
be done in DC level.

[How]

We create new interface dp_get_link_enc to access and get the correct link_enc

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 11 ++---------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h |  1 +
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3b6dd92b0f36..b8b303260302 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8330,15 +8330,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		break;
 	case DRM_MODE_CONNECTOR_DisplayPort:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
-		if (link->is_dig_mapping_flexible &&
-		    link->dc->res_pool->funcs->link_encs_assign) {
-			link->link_enc =
-				link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-			if (!link->link_enc)
-				link->link_enc =
-					link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
-		}
-
+		link->link_enc = dp_get_link_enc(link);
+		ASSERT(link->link_enc);
 		if (link->link_enc)
 			aconnector->base.ycbcr_420_allowed =
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2cb40912c144..f1898f1c9e22 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6174,6 +6174,23 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 	}
 }
 
+struct link_encoder *dp_get_link_enc(struct dc_link *link)
+{
+	struct link_encoder *link_enc;
+
+	link_enc = link->link_enc;
+	if (link->is_dig_mapping_flexible &&
+	    link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc,
+								  link);
+		if (!link->link_enc)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(
+				link->ctx->dc);
+	}
+
+	return link_enc;
+}
+
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 8f50b1ba2058..52bdfea7897b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -170,6 +170,7 @@ uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
+struct link_encoder *dp_get_link_enc(struct dc_link *link);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
-- 
2.32.0

