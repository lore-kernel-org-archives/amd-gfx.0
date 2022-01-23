Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB3C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB0A10E26B;
	Sun, 23 Jan 2022 18:21:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A37410E29F
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFsGrO74X4FfA8TpHwzHVQeXN/pJcR8qB1zbeL1AY12f83/XfORznrG1jTgyISjGtxlE78Ur9ah4w460jR38wV5j24LxX1RUhJrAV0TRMvJqGgZtDU6nxHvk1YMbYqd1KvhUR/MkNAlP5uNuCunpj/xb9PUT1JT2lXJYcHhBCjKjFOoYC8wmzn5psUoTAxQCdY+ro0v9ULIwxX91ToZ6uBbDybzVMUpHRDRHMHIRlV66PqLf0mNSCFRyQmYbqaLuagbEH3qxWPEC+ilJXPGRYStGBkqJ38AykXkiyZ6F3O0lKywxIPps0d/lGRA67mWGTXDj2VidmY4g9F2ZRjLKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN4yQKjYxVofMr4rE+6vBOrKUPdb8gy1eMFTYCpKDDk=;
 b=NVo9F89Aodxd2Xc/gAUxiTLODupVERxXHPcpkjoNMqX2FMANjB9sTM/xrVh7vluxY2dnGoujM/xmf7s9uuSwh1cljpjyIm5yx+ZcCqALZBH79lQzBDNfOKxIW+ug9BPSMJeMnLYDRoTA31AHPY66EARBKn2WxQwXhzgAUvu2W1IlXQqtSEgTzTgNQOZhjKd3FnoJtmw2CJJsNVRxXyUkg0U2RQUrM8neuXSx5hh0TMSONVIMHehO5tHlA6YUug8cZ12q8QFqbOQ9e9or6w9dzqM3rfbYRQ6vhuLtzAaErBnwIDX5+Puzxol/iquLtHe2a8LOLsG7XJo8pvCqnhErgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN4yQKjYxVofMr4rE+6vBOrKUPdb8gy1eMFTYCpKDDk=;
 b=vkg/uSA2sg8dYJVNuukfSzf6XKPIG9fDB+crA0hQ5wp7qom438KMiJkunRE2MXOSElDRk7Mvyg8fnEku7Pw0LxgkKp8ZYIsPRJd8XqWORuZSgzedFpqHRGm/xvEhrBk2WHYIV2V5Ke84nBGc4InAKNd1GdeD79LDJDNNssIUyQQ=
Received: from BN6PR14CA0002.namprd14.prod.outlook.com (2603:10b6:404:79::12)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:20:55 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::37) by BN6PR14CA0002.outlook.office365.com
 (2603:10b6:404:79::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:55 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/24] drm/amd/display: add protection in link encoder
 matching logic
Date: Sun, 23 Jan 2022 13:19:58 -0500
Message-ID: <20220123182021.4154032-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5a83908-d6e2-4bd9-6648-08d9de9d186c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3970A728FABAB23D553BB586985D9@BY5PR12MB3970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjavOgR1/H/wQfGsQUquOXKqf5phOZ8M0Y4bY+hNk2A6QEzSIH5WiZp6FPVMFEmyIMf//QFLXbL2CJnGfVvHOQdkV0Hftl4K3Va6DnsbHWvMGFwclzWtjBmRniPRlHgknqtF/j1trVvNuObia95v4+ishbwYQK/okeHdGv2v/PKUGTee/2CURTN61q0I1mkTKxsEgFMXlECLQmoB2xG2ZAMJdr5VNU1zCn8etfBiu9VYyflrEZ21XhJf1hm0m+qnV7CDiSUfzY41lOIQwhp4lagHIUMXtu0fUrBC6ehYKahXfeQRDcHCPA9mokzPm7IwFC32M34k/fvxo2HHwttSJxSFRHd0sxBi6uFRe7Eau7Y+a0WcLguzSpS/V+/lBtzo5HRebby9xm73hKKsnN3LP5Q2Tu2+u3UV0UWB+qQekOtYhrUuYXeXf+dEqYCW7kVWJDXZfP1dw1utTRcrnrieI/Sh/ZedF0OkcqR2b1qV/KJ1k6s7Z6ZsqGYpsI6L1cJBZT3HwYr9pC5kcGqewWleGXkcWEPmtGiSX7VgMjzbzCh5vv/UhuzyYKyn+A1fkO0fSL+WExtl5JBrr0QfHcDLkF7ufUvqrI2pVgkyMInPkK3BJ2LJp/Yyj68Rkjk3+6JOFL4t9t463S+d6fg0EfOvOl54ZMqjKeGnfcVqv217yrGmBmqNio7+dDo3vB6qludaM2vsy0cTnju6IUlXDYV6d7Aq9qReBZat+A7/nBj1zXsH6Ze9ntVgD4IDD+RTlck86uXpCZ9/WJNA1u2pDDBS5FDrCYoQ1ucZ1Ko/u0lh6WI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(356005)(6916009)(81166007)(70586007)(82310400004)(70206006)(2906002)(54906003)(508600001)(336012)(26005)(1076003)(8936002)(8676002)(16526019)(83380400001)(30864003)(186003)(4326008)(47076005)(36860700001)(86362001)(36756003)(40460700003)(2616005)(316002)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:55.0156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a83908-d6e2-4bd9-6648-08d9de9d186c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Link encoders are created based on its engine ID. The position of a link
encoder in an array could be null since it didn't be allocated.  Current
matching logic didn't consider this situation and could get null
encoder.

[How]
To add null encoder check to make the matching logic can go to next to
get a valid one.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 +---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 66 ++-----------------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 23 ++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 22 ++-----
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  1 -
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  3 +
 7 files changed, 36 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87299e62fe12..94b4d7f70e45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8366,7 +8366,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		break;
 	case DRM_MODE_CONNECTOR_DisplayPort:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
-		link->link_enc = dp_get_link_enc(link);
+		link->link_enc = link_enc_cfg_get_link_enc(link);
 		ASSERT(link->link_enc);
 		if (link->link_enc)
 			aconnector->base.ycbcr_420_allowed =
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 507ed14a1eb1..2ff4869d190c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4620,16 +4620,7 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 	 */
 	struct link_encoder *link_enc = NULL;
 
-	/* Links supporting dynamically assigned link encoder will be assigned next
-	 * available encoder if one not already assigned.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
-	} else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	return (dc_is_dp_signal(link->connector_signal) && link_enc &&
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9511c65e0603..1730be6c64ed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -261,14 +261,7 @@ static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *li
 	struct dpcd_caps *rx_caps = &link->dpcd_caps;
 	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_2;
 
-	/* Access link encoder capability based on whether it is statically
-	 * or dynamically assigned to a link.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-	else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 	enc_caps = &link_enc->features;
 
@@ -2997,16 +2990,7 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 		return false;
 	}
 
-	/* Links supporting dynamically assigned link encoder will be assigned next
-	 * available encoder if one not already assigned.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
-	} else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (link_enc && link_enc->funcs->get_max_link_cap) {
@@ -3027,16 +3011,7 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	enum dc_link_rate lttpr_max_link_rate;
 	struct link_encoder *link_enc = NULL;
 
-	/* Links supporting dynamically assigned link encoder will be assigned next
-	 * available encoder if one not already assigned.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
-	} else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	/* get max link encoder capability */
@@ -6175,14 +6150,7 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	enum dc_status status = DC_OK;
 	uint8_t fec_config = 0;
 
-	/* Access link encoder based on whether it is statically
-	 * or dynamically assigned to a link.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-	else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!dc_link_should_enable_fec(link))
@@ -6222,14 +6190,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 {
 	struct link_encoder *link_enc = NULL;
 
-	/* Access link encoder based on whether it is statically
-	 * or dynamically assigned to a link.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-	else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!dc_link_should_enable_fec(link))
@@ -6255,23 +6216,6 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 	}
 }
 
-struct link_encoder *dp_get_link_enc(struct dc_link *link)
-{
-	struct link_encoder *link_enc;
-
-	link_enc = link->link_enc;
-	if (link->is_dig_mapping_flexible &&
-	    link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc,
-								  link);
-		if (!link->link_enc)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(
-				link->ctx->dc);
-	}
-
-	return link_enc;
-}
-
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index a55944da8d53..a380611b1e42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -486,7 +486,8 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
 	}
 
 	for (i = 0; i < dc->res_pool->res_cap->num_dig_link_enc; i++) {
-		if (encs_assigned[i] == ENGINE_ID_UNKNOWN) {
+		if (encs_assigned[i] == ENGINE_ID_UNKNOWN &&
+				dc->res_pool->link_encoders[i] != NULL) {
 			link_enc = dc->res_pool->link_encoders[i];
 			break;
 		}
@@ -506,6 +507,26 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 	return link_enc;
 }
 
+struct link_encoder *link_enc_cfg_get_link_enc(
+		const struct dc_link *link)
+{
+	struct link_encoder *link_enc = NULL;
+
+	/* Links supporting dynamically assigned link encoder will be assigned next
+	 * available encoder if one not already assigned.
+	 */
+	if (link->is_dig_mapping_flexible &&
+	    link->dc->res_pool->funcs->link_encs_assign) {
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
+		if (link_enc == NULL)
+			link_enc = link_enc_cfg_get_next_avail_link_enc(
+				link->ctx->dc);
+	} else
+		link_enc = link->link_enc;
+
+	return link_enc;
+}
+
 bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link)
 {
 	bool is_avail = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index c5146263f93c..5e9054fdb339 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -86,11 +86,7 @@ void dp_enable_link_phy(
 			link->dc->res_pool->dp_clock_source;
 	unsigned int i;
 
-	/* Link should always be assigned encoder when en-/disabling. */
-	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(dc, link);
-	else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
@@ -228,11 +224,7 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 	struct hpo_dp_link_encoder *hpo_link_enc = link_res->hpo_dp_link_enc;
 	struct link_encoder *link_enc;
 
-	/* Link should always be assigned encoder when en-/disabling. */
-	if (link->is_dig_mapping_flexible && dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_link(dc, link);
-	else
-		link_enc = link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!link->wa_flags.dp_keep_receiver_powered)
@@ -360,14 +352,8 @@ void dp_set_hw_test_pattern(
 	struct link_encoder *encoder;
 	enum dp_link_encoding link_encoding_format = dp_get_link_encoding_format(&link->cur_link_settings);
 
-	/* Access link encoder based on whether it is statically
-	 * or dynamically assigned to a link.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign)
-		encoder = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
-	else
-		encoder = link->link_enc;
+	encoder = link_enc_cfg_get_link_enc(link);
+	ASSERT(encoder);
 
 	pattern_param.dp_phy_pattern = test_pattern;
 	pattern_param.custom_pattern = custom_pattern;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b18c8198f66d..b7c5c42d67ed 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -171,7 +171,6 @@ uint8_t dc_dp_initialize_scrambling_data_symbols(
 
 enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource *link_res, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
-struct link_encoder *dp_get_link_enc(struct dc_link *link);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_update);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index a4e43b4826e0..c2f08514a1d9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -96,6 +96,9 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream(
 		struct dc *dc,
 		const struct dc_stream_state *stream);
 
+/* Return DIG link encoder. NULL if unused. */
+struct link_encoder *link_enc_cfg_get_link_enc(const struct dc_link *link);
+
 /* Return true if encoder available to use. */
 bool link_enc_cfg_is_link_enc_avail(struct dc *dc, enum engine_id eng_id, struct dc_link *link);
 
-- 
2.25.1

