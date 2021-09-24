Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C446C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E6610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C34E6610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6A76E226;
	Fri, 24 Sep 2021 19:10:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27AF6E226
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krac4d/2GjQ59+V5OpNkhT2Mvw5JJaoaOF9Dyyq9gyNyyK9nijaovqPlKGbO0BLj3z5eB9GcqjrHhJvd0dac7ZIJTc+qmgGt/n4WBzFo+3tlkSQWh4a57f5SuJM1oKucJflpWHYuyieHIQ0yUukhEGf0K9wr1lmy3roDv03KHVUw2EHS7ipoqHN86pRHCB4icNEnD8eMa7KnQye14lXM0eEotnnVZpUe4y9JU+AMt+6PLT5G7/pYXsThmbP1BN1hBIuAP5u1xbIBeTmVpXAZoUF8hHSBZvx59UkesXZMoe6L0lwj6KWyL1NqbSGYKb2PCc3Y1gBZhl/Qtuhj7LIzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3y270fp1m+g91+oJO5WB2m28CSK+YHUrhf3yRER+BTw=;
 b=Kjj4s//IMSVn0FUEtpE4GAeL5YLB9pvz8IT4v1wrUYcR72LRT9knAcSmBHX3LI7Eqpydrqzy+cLjoC2DaEYk9XAPdXBZb6CY/TB5ohFZisAHR1eMfmGZJ4UC1HN7G4tHogpHlhnYurAHkKz7p81I1fGq0Uic1m3Y7qTIiF8kgEv2nhovCDdZM+dNxRJilH0Oeix2Zz28Pv9poZpIvGVm2FoX2jjPX4nVrjc1BJuhcu9LvqC9h+yAMNROENySScMGOPW+4uAVPVV3mu+GBbP7phKOaT8sk0gAW/mKySlskC7qo1iHIID18JjXndyDDu6ny3dMpEkuAxELckH0eEDeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y270fp1m+g91+oJO5WB2m28CSK+YHUrhf3yRER+BTw=;
 b=AVddUn+bzxOpgfPqn+0GCfVXMEPimutTHAP7GVNOgtJpeGA0dfroxOcSTDBrSZc4lnvUStPObP2AnYaVwfxbIuN4+CmNCcBnGQrY3U/zmjSl7TbXCP9h1yTCvNLpLb23g6lIRLeu+K9uUK9PTBeni7/caMq/COFzG9tDzsc+Cfk=
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by DM6PR12MB2732.namprd12.prod.outlook.com (2603:10b6:5:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Fri, 24 Sep
 2021 19:10:40 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::8) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:10:38 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:37 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>
Subject: [PATCH 21/24] drm/amd/display: make verified link cap not exceeding
 max link cap
Date: Fri, 24 Sep 2021 15:09:31 -0400
Message-ID: <20210924190934.1193379-22-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317f5ffb-afc9-4500-e474-08d97f8eff80
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2732893C78ACD8E8AAAFD43CEBA49@DM6PR12MB2732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAKc67+UjD4rMR2uahB6LDZ/uH0WasDAuNJFltc2zePQoPz7x7D5UYSzEYyYinxJ+CtMqKtS9KolWL8UyDHuOq4RBXCslfQGDBZBNOIG0qcavsFOt7TY4W4mkEXAUYBixBdx6tDfd/xF+WraXcKFeyDL7RKd0uX1guLKU8KM3soVVzF6kzPhHtlUO2xVhbY0WBQO5cv6B9rfKrELPhuCu9PtbNaA2xjsfxLWkd9lxcZAyBYgsKV67IVIUYxS4LlfAV2ITeimnZ1aDjikDHB4BR6N+nRn18Jq9k0U41G2DkeZHr403UWDTjboKLokd8kvwF3h48WGnnSCiWl5x+OpfudY3RN8S3Y792N1Y+PW9ybHrq31DwNdjOW7odkFxlln0DZE3iex6hZQz+F3PHIFTkLxnMG+bAJ2+aVTzZbCa//Fo2vNilxBE0dRXe109dg1/GyHXyRU2xxuha97QLNmFr6W8iGgXkUM7Bvis6NhtymxJkX2SRSYssU2vWJOdacmrLt0Jui0BlQGc/m9uFlHPiMmb76SP/iaTJ0ynZlbYipYnNHe+MBIFiVN16tEKGHStaWIqEC+7CU2BBcvlwb7Jmls6Xt5YYeylWe0r1MsUZPhCGu8wk+mYsfmz/SOitd4N4HyMfjU2rKJw7DpBk8waSUFwrkqdkVMWj2zJx38bps3UsyDOIMp5U0juQDILlZ0vCPvZis9hh4Q8u8TnwvCn2wb0PeaGgwvVX6yXgnkW6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(47076005)(36756003)(83380400001)(8936002)(81166007)(6916009)(508600001)(4326008)(316002)(82310400003)(2906002)(2616005)(426003)(36860700001)(1076003)(15650500001)(7696005)(5660300002)(336012)(186003)(26005)(6666004)(70206006)(54906003)(8676002)(356005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:39.7936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317f5ffb-afc9-4500-e474-08d97f8eff80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a chance verified link cap can be greater than max link cap.
This causes software hang because we cannot power up PHY with link rate
that cannot handle.
The change is to guard verfieid link cap from becoming larger than max link cap
our PHy can support.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f55dac1c7ea1..ccfb0aceea5b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2710,14 +2710,25 @@ bool dp_verify_link_cap(
 	enum link_training_result status;
 	union hpd_irq_data irq_data;
 
+	/* link training starts with the maximum common settings
+	 * supported by both sink and ASIC.
+	 */
+	max_link_cap = get_max_link_cap(link);
+	initial_link_settings = get_common_supported_link_settings(
+			*known_limit_link_setting,
+			max_link_cap);
+
 	/* Accept reported capabilities if link supports flexible encoder mapping or encoder already in use. */
 	if (link->dc->debug.skip_detection_link_training ||
 			link->is_dig_mapping_flexible) {
+		/* TODO - should we check link encoder's max link caps here?
+		 * How do we know which link encoder to check from?
+		 */
 		link->verified_link_cap = *known_limit_link_setting;
 		return true;
 	} else if (link->link_enc && link->dc->res_pool->funcs->link_encs_assign &&
 			!link_enc_cfg_is_link_enc_avail(link->ctx->dc, link->link_enc->preferred_engine)) {
-		link->verified_link_cap = *known_limit_link_setting;
+		link->verified_link_cap = initial_link_settings;
 		return true;
 	}
 
@@ -2725,8 +2736,6 @@ bool dp_verify_link_cap(
 	success = false;
 	skip_link_training = false;
 
-	max_link_cap = get_max_link_cap(link);
-
 	/* Grant extended timeout request */
 	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
@@ -2748,12 +2757,6 @@ bool dp_verify_link_cap(
 
 	dp_cs_id = get_clock_source_id(link);
 
-	/* link training starts with the maximum common settings
-	 * supported by both sink and ASIC.
-	 */
-	initial_link_settings = get_common_supported_link_settings(
-			*known_limit_link_setting,
-			max_link_cap);
 	cur_link_setting = initial_link_settings;
 
 	/* Temporary Renoir-specific workaround for SWDEV-215184;
@@ -2847,7 +2850,7 @@ bool dp_verify_link_cap_with_retries(
 			link->verified_link_cap.link_spread = LINK_SPREAD_DISABLED;
 			break;
 		} else if (dp_verify_link_cap(link,
-				&link->reported_link_cap,
+				known_limit_link_setting,
 				&fail_count) && fail_count == 0) {
 			success = true;
 			break;
@@ -2862,11 +2865,21 @@ bool dp_verify_mst_link_cap(
 {
 	struct dc_link_settings max_link_cap = {0};
 
-	max_link_cap = get_max_link_cap(link);
-	link->verified_link_cap = get_common_supported_link_settings(
-		link->reported_link_cap,
-		max_link_cap);
-
+	if (dp_get_link_encoding_format(&link->reported_link_cap) ==
+			DP_8b_10b_ENCODING) {
+		max_link_cap = get_max_link_cap(link);
+		link->verified_link_cap = get_common_supported_link_settings(
+				link->reported_link_cap,
+				max_link_cap);
+	}
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	else if (dp_get_link_encoding_format(&link->reported_link_cap) ==
+			DP_128b_132b_ENCODING) {
+		dp_verify_link_cap_with_retries(link,
+				&link->reported_link_cap,
+				LINK_TRAINING_MAX_VERIFY_RETRY);
+	}
+#endif
 	return true;
 }
 
-- 
2.25.1

