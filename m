Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FFC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E293C60FEA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E293C60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A668A6E931;
	Mon,  7 Jun 2021 16:48:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF0C6E935
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+byW2rGEwL86F9jyjdxByG55X/nZJctFSKPe/PSjBNEEpqMzOTs+v94e2w7ZULCbi4jLQEJ39fFYTIm3nlC6lNYsTnOyEFzM7nF8592EyIzNeHhr4MINxXX8Ru0a9YiDMnXDoFn/z3N43eZr1D2gL93rgT8i4dp4uBb70EGHdstcESsnvjjfur52xoucVb3sHwC4t4Eg5oU0/1cgbxDwKLR+erFMYu+jtFNVcvT8bS+NIv0vSr1xeO+DTBci5To2sfD4qj4JFP7SK9UXVvKYaILnd6s9nqIfOfjpsuZXVoWGfzmaG1+7Muy3MZL0zQhCUL0BG3SKo7dRBcoiijDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBRTy+O++qYi3RaTqYEAlNTpw6WuQv6f4xSkDSFME6Q=;
 b=Dy0OoWGRCR6Bcx6y8WLp4z59ObqlJoeArHJOWjRD21h4Yk+gXGIp+BnXsAL4/eonBMmHLqg+ibhFWxZpbU6JdNLiqX5BMSUbwoTotXOY3rb9oNLM/nFrvJxcibXnGXxARuVFG8koAdQwTqmT2r825D1W77WlRDbi56fIKq0XsDtZPnby+eeDRTHopFleh65n0fEafLanq/SWL+jXvXj+fw+jLxO6h6apkUJEwzcPQGZ+Ll+vF0gN3rSQwg87tgcbB8zzHJxtk+k/71rYnMVfbs9LQ7Dq5yaZC+FdQ7CBBfvulw8PkUWBTrB1NTQ+ZymRA5Yk48gAd7rD8Mp05vNO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBRTy+O++qYi3RaTqYEAlNTpw6WuQv6f4xSkDSFME6Q=;
 b=PTG+Rlc9beVa3bPalW0YgmiobwlBggPKMY1Gw/dII+AqTLfGio59vEi7HNHYGhoJ9Cj/wRUYjNES1WLPqntCJ/0LtwI4LejAweSRh5AsfX0hf4A4pHwJOAbqW5ApZdKwKswQEuHNE8wlfOZZX3BY91yLVt0mW3fSxQRuiYvcRQM=
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:48:17 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::27) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:17 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:13 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/30] drm/amd/display: Expand DP module equalization API.
Date: Tue, 8 Jun 2021 00:46:53 +0800
Message-ID: <20210607164714.311325-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472cfa4a-524f-4e93-c8f9-08d929d40cac
X-MS-TrafficTypeDiagnostic: BYAPR12MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2902B061B42D87430C136D21FF389@BYAPR12MB2902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVZrFn3UvmjQEhBf1kbV89eWJBCDVF1d3WKMPMS2DJB4rbawVWS9kfRcY6kJrQWq1PeZpPuN3NKNhAwayPjynmGKureoylPXc/8l0KUQT/FoQaNF7pz8CFYE/K+5Q3pZnWk8Lb+f9kwMGunWAw7bqMfRdS0PF/akE9da/bQUz73y1vAOXXaSCOppFYIF+DEPZM4ogeIEKCRmSybTxa3PdJd3xakpVm67nukQ0guaWKjqh1VAPp5ehcjwN95f2rhYC5wKbQUHngimf196s4V6TwDmwEtLxqUmnbsbD7hMb5GvKjXdG1RZRn+wO9DwsxamIeOnnmB79JIvJf01ESs3m92MriPxLB4Vy0x88BmlgvxnPqa1iNRRZlElTvDjrHMUaOFY8hd3cItr0ycrAD6/ImH2IX2oyfNXsayuTi8+aEjjejaDoX+eUC6oOVjvGAL7THlfqSEdyOHFr/xS9NAIiUbTSkqq/WQM7PNIuhh8Fm9yV4vrpx1W6m2ZJXdP+jaizFiL9fp/vDKZpOETOJgKaIVZ03T2151T6BMGTU5JbTYdH6RRD43gZne3R61JXBJQTX0xlhi9zhiYT9aEds4TKOLy0XiS3B0JQjk8lxjeUxbIg95V87xj9k9o2KDznQctgEM2BR7u+b0y0UTDVYRS1d1agetnnVuE0RcbumfJZOffraF0AovSFngZUB5CA95a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(36840700001)(46966006)(82310400003)(47076005)(316002)(2906002)(82740400003)(8676002)(6666004)(8936002)(81166007)(86362001)(83380400001)(7696005)(186003)(16526019)(478600001)(336012)(36756003)(2616005)(26005)(70586007)(70206006)(426003)(36860700001)(44832011)(54906003)(356005)(1076003)(6916009)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:17.1662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472cfa4a-524f-4e93-c8f9-08d929d40cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add functionality useful for DP equalization phase of link training to
public interface.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 22 +++++++++----------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  8 +++++++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5a70f55e075c..87f955820c0f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -435,7 +435,7 @@ bool dp_is_cr_done(enum dc_lane_count ln_count,
 	return true;
 }
 
-static bool is_ch_eq_done(enum dc_lane_count ln_count,
+bool dp_is_ch_eq_done(enum dc_lane_count ln_count,
 		union lane_status *dpcd_lane_status)
 {
 	bool done = true;
@@ -446,7 +446,7 @@ static bool is_ch_eq_done(enum dc_lane_count ln_count,
 	return done;
 }
 
-static bool is_symbol_locked(enum dc_lane_count ln_count,
+bool dp_is_symbol_locked(enum dc_lane_count ln_count,
 		union lane_status *dpcd_lane_status)
 {
 	bool locked = true;
@@ -457,7 +457,7 @@ static bool is_symbol_locked(enum dc_lane_count ln_count,
 	return locked;
 }
 
-static inline bool is_interlane_aligned(union lane_align_status_updated align_status)
+bool dp_is_interlane_aligned(union lane_align_status_updated align_status)
 {
 	return align_status.bits.INTERLANE_ALIGN_DONE == 1;
 }
@@ -865,9 +865,9 @@ static bool perform_post_lt_adj_req_sequence(
 			if (!dp_is_cr_done(lane_count, dpcd_lane_status))
 				return false;
 
-			if (!is_ch_eq_done(lane_count, dpcd_lane_status) ||
-					!is_symbol_locked(lane_count, dpcd_lane_status) ||
-					!is_interlane_aligned(dpcd_lane_status_updated))
+			if (!dp_is_ch_eq_done(lane_count, dpcd_lane_status) ||
+					!dp_is_symbol_locked(lane_count, dpcd_lane_status) ||
+					!dp_is_interlane_aligned(dpcd_lane_status_updated))
 				return false;
 
 			for (lane = 0; lane < (uint32_t)(lane_count); lane++) {
@@ -913,7 +913,7 @@ static bool perform_post_lt_adj_req_sequence(
 }
 
 /* Only used for channel equalization */
-static uint32_t translate_training_aux_read_interval(uint32_t dpcd_aux_read_interval)
+uint32_t dp_translate_training_aux_read_interval(uint32_t dpcd_aux_read_interval)
 {
 	unsigned int aux_rd_interval_us = 400;
 
@@ -998,7 +998,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 		if (is_repeater(link, offset))
 			wait_time_microsec =
-					translate_training_aux_read_interval(
+					dp_translate_training_aux_read_interval(
 						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
 
 		dp_wait_for_training_aux_rd_interval(
@@ -1021,9 +1021,9 @@ static enum link_training_result perform_channel_equalization_sequence(
 			return LINK_TRAINING_EQ_FAIL_CR;
 
 		/* 6. check CHEQ done*/
-		if (is_ch_eq_done(lane_count, dpcd_lane_status) &&
-				is_symbol_locked(lane_count, dpcd_lane_status) &&
-				is_interlane_aligned(dpcd_lane_status_updated))
+		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
+				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
+				dp_is_interlane_aligned(dpcd_lane_status_updated))
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index bbb054f58fe2..883c3af51022 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -130,6 +130,12 @@ bool dp_is_cr_done(enum dc_lane_count ln_count,
 enum link_training_result dp_get_cr_failure(enum dc_lane_count ln_count,
 	union lane_status *dpcd_lane_status);
 
+bool dp_is_ch_eq_done(enum dc_lane_count ln_count,
+	union lane_status *dpcd_lane_status);
+bool dp_is_symbol_locked(enum dc_lane_count ln_count,
+	union lane_status *dpcd_lane_status);
+bool dp_is_interlane_aligned(union lane_align_status_updated align_status);
+
 bool dp_is_max_vs_reached(
 	const struct link_training_settings *lt_settings);
 
@@ -137,6 +143,8 @@ void dp_update_drive_settings(
 	struct link_training_settings *dest,
 	struct link_training_settings src);
 
+uint32_t dp_translate_training_aux_read_interval(uint32_t dpcd_aux_read_interval);
+
 enum dpcd_training_patterns
 	dc_dp_training_pattern_to_dpcd_training_pattern(
 	struct dc_link *link,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
