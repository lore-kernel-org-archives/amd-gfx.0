Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35593C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5FFAA4AD;
	Fri,  3 Dec 2021 22:59:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE66AA4A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFmHU3fOG618/irWbSh4U2dhJ3MPRNsEEzKkMKtp6iFN76FkIfp0a3E7gbTEYE3JBzFlAdY2ey9ek6c4CG/UDwmEz11KQVuDaKkf5Taux9/o8bLimmK0LldD3i+3ixIPqAEC9bdUsV67HCQL3f86aQLmt1VJZNO3ETN2/qkY0TXgO7+qKm+8luOo2UuaFTvadOPp453x2OIgB3Yb21Fk0u2Hb1oQooCkN2da6tnvRoI9WbhMp+TSuEh20nUsb6GqEKhkJF3WuQ/vnyLBEUwlcA30No/xCxWWfWvomY9L51toJLMcOuJKnTjYpIxfEAL8e1ywePrHszMPwuRTQyqw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyp4MjxG4tithqJ3IgljvE8jlQk6VX/+WaSIpob7TQo=;
 b=Qn5sGm7CulcaTz71g7Re7OzS7q5mJQdjz21RiHwEfTIjgTwA9zniCzvffUukV/JG5bEIqiAmOrV0qYMi8h4C6R0+QVeSBM4JSjViWZylcLqT5xSTLzfpSuPGQGqkiBy/sN0qv0vY+plnDKpFj/AnMqMKgwOMIu5JVOqMXtlz2FEWnm7sZBzL7lLwH5yMoPptIxXiTMoP5xBPNcgq7kPtQe43k2g0VyYvsSSoSfWwNczXij3NVndHUT9D59fxaqrNcn66Xpn91BgE9oLIBFjwXxj42tjUZvwcWH1MXsYDt/KAJ5ZRy+gCYES+magM2i+Ix0LvFMP3IzsFxyK1XrJ09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyp4MjxG4tithqJ3IgljvE8jlQk6VX/+WaSIpob7TQo=;
 b=2/wb9+bvbU8OS8/C2ccCdjU9DEHop1XkDhn4B05VRitfURO4SVajh2iHpXuE9wvnO66POg/oA1dYcKMpZwQH/NoehdqQm0G4yVZqgcQkNdBvaReZy7Ayn7OFpQuPTdPMP1G40VyUSv8zXiGZ5SgTkAlGwiTJ5OW6kkG5d3lkmjI=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by MWHPR12MB1823.namprd12.prod.outlook.com (2603:10b6:300:112::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 22:59:15 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::8b) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:14 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:12 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/15] drm/amd/display: add a debug option to force dp2 lt
 fallback method
Date: Fri, 3 Dec 2021 14:57:58 -0800
Message-ID: <20211203225802.651367-12-Pavle.Kotarac@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5aa6d17b-ef08-46a3-9077-08d9b6b08732
X-MS-TrafficTypeDiagnostic: MWHPR12MB1823:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1823BDEDF4C5422DC145274EFC6A9@MWHPR12MB1823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3RJ2G8LnLqdCrwZIeeEi+dvzHnpCxvmjFFc4sTNhJ42h1uYbkQtRv3fbS5IWK7EPjuXRGSfnzEusWvXPzOZv8ZoRqouIXYnYsFuIvH2m6cABYXYaJgpZPMSerdCul537EieHXWeJlDOhCfYS/FAipNPMHbelraURi6uqDjJawrf9AohbTGdx6smrITV9OQ6T0CE4e9fx8km+aEVjw6U//fQzVyURqXGyoqHu6NPBto3mJ7PmQZYUq53UQPwcR4syjpfGVzt74QHHcLZX6i6zSY5opsMGxNTwJYczpcCmtqPfkRC9Bqk4Y89tpQ5oNl0PoXKhOKp+TKO407JqZXu+g9t18+Z343Pv7x7POpAbbVFr5wwD/A4aZugGmD2WgYk3Jog9phggV1LF6uoAea0jIDf9kTgfLGkLFplni4iqvgTTySzB4T4j90IGERWBedPnvsA0RcQHvASUCuPGe4X9x/g0fRJIMjCX2gRTGyXwt3hbd+D0Qw4bN0x+Bbuo73Oaojo9CIROx3e+l2EkM8AYuUY/GZHKol890CSuwRtNcnAxS/eaoqVKYMy/rAfWOGcfQfppGnGHnJiPAI81yER7YPAS60PZ+T3iP1QMArsHByBzgB542Yk/jb+pr1vvYGsEm3rmwpti2ynGVDSMdV0i0/Ndn4DKxaDcX8Kr+AUOMa5m1aIso2Ngl0kw567ZifL4NvsOOR+rXKKovKh0d5Yk46HiVrAoNNkeZoUzBZFK/cVbKjrgarLW25EbkGMq2aO/cLy1tQaODc6WjKaXxhZC1VKb9dQpouoUxs02rk/q4rX1qMIXeDn0aBxCRGikYrZ2UpzvwvsiX4Z9mLw+2lWKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(36756003)(316002)(54906003)(8676002)(5660300002)(86362001)(508600001)(1076003)(8936002)(36860700001)(4326008)(336012)(83380400001)(82310400004)(40460700001)(26005)(16526019)(6666004)(70586007)(70206006)(47076005)(356005)(426003)(2616005)(7696005)(2906002)(186003)(81166007)(161263001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:14.8060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa6d17b-ef08-46a3-9077-08d9b6b08732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1823
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
A debug option is needed to temporarily force dp2 new link training
fallback method for debugging purpose.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f1898f1c9e22..56e141fb2694 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -100,6 +100,7 @@ static const struct dp_lt_fallback_entry dp_lt_fallbacks[] = {
 #endif
 
 static bool decide_fallback_link_setting(
+		struct dc_link *link,
 		struct dc_link_settings initial_link_settings,
 		struct dc_link_settings *current_link_setting,
 		enum link_training_result training_result);
@@ -2609,7 +2610,7 @@ bool perform_link_training_with_retries(
 			uint32_t req_bw;
 			uint32_t link_bw;
 
-			decide_fallback_link_setting(*link_setting, &current_setting, status);
+			decide_fallback_link_setting(link, *link_setting, &current_setting, status);
 			/* Fail link training if reduced link bandwidth no longer meets
 			 * stream requirements.
 			 */
@@ -3124,7 +3125,7 @@ bool dp_verify_link_cap(
 		 * based on the actual mode we're driving
 		 */
 		dp_disable_link_phy(link, link->connector_signal);
-	} while (!success && decide_fallback_link_setting(
+	} while (!success && decide_fallback_link_setting(link,
 			initial_link_settings, cur, status));
 
 	/* Link Training failed for all Link Settings
@@ -3376,6 +3377,7 @@ static bool decide_fallback_link_setting_max_bw_policy(
  *					and no further fallback could be done
  */
 static bool decide_fallback_link_setting(
+		struct dc_link *link,
 		struct dc_link_settings initial_link_settings,
 		struct dc_link_settings *current_link_setting,
 		enum link_training_result training_result)
@@ -3383,7 +3385,8 @@ static bool decide_fallback_link_setting(
 	if (!current_link_setting)
 		return false;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (dp_get_link_encoding_format(&initial_link_settings) == DP_128b_132b_ENCODING)
+	if (dp_get_link_encoding_format(&initial_link_settings) == DP_128b_132b_ENCODING ||
+			link->dc->debug.force_dp2_lt_fallback_method)
 		return decide_fallback_link_setting_max_bw_policy(&initial_link_settings,
 				current_link_setting);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c2cb892d993..a43c008bd0f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -691,6 +691,7 @@ struct dc_debug_options {
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
 	bool set_mst_en_for_sst;
+	bool force_dp2_lt_fallback_method;
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
-- 
2.32.0

