Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC8EC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6C121D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hIdpdRDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6C121D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85906E962;
	Thu, 10 Sep 2020 13:47:42 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680057.outbound.protection.outlook.com [40.107.68.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F4646E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTMIGhgeTysnzQ012VZHdIvagQXiN0zyqKsz8hU7iyPbWezd9nOI17UqRpFTcx6+WO6sdws4q8bBobco0bd1h2WINIuKzBN5NLZKaBHKIrAoB3YGACdeu71uPk9F+38ps7i+6GmNREdDf3Pwh0v+pjfYPn5og5eOAotMP//51SfbTiK81S0LvH1NmkAkkseVLnQtkR990mTtdsncg3TesfJAX/ItCtH3yO/FcsUm9WFBfSuhykp2xgYbluywCwCvnCyCS6Lo1JwGD/jfaikPBPOOh3e1TCwmdkSuRZWBaJDv0fewfN4t9SZqKy5tlI2IwaxkzRZwRvBqivwn9NSPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEZa9f7CR2XsG0ger0W8awuxqMTl9cc1K9lT8zpMBm4=;
 b=nqMLZZNEDvus5it7RU+WCzlvaq1a8OLYJZoyUcabp9yuWt2rGB9d+nl41EFe45zld0t1EBQla2OL0jx3ut0m41Y/twBwJDdgrJjAOVjILDs00w9dhAv2enmpxssVoYlrOUUpG7AtBW56+v5aui9v/JdwPxETU3jAMfuhUdr56ssWQEx2oBkz2kWJH3qjzkQ+32z2s8CI0BVgGqszf6GcTIjq15MDpDj1VgvICaGKbor+jmOOANDL8N1mUB/awoLUK8nt48rJ65MNKlWzlO/g6e0QOq5Te3QWA67jwVppiXnxFvU7R3EXWOQKSxmUC4SrwPqRoMYbXA0jrBklxQ5JIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEZa9f7CR2XsG0ger0W8awuxqMTl9cc1K9lT8zpMBm4=;
 b=hIdpdRDczJXnr+xyRYLHGCARzQEELPaDw+SlYYAKDkWcoDbWk+93PKjDB97JB6dvj1ylBEiCkvaD+EcSFYKXMlN/IC4Czpq2tFKW6Shvkha9ozb4ee9gFCNYDF+v1+YVvZDp1W9s39gGfSPxjA3o6JtmOMlKOy0ayLJ9IZMtKsM=
Received: from DM5PR19CA0007.namprd19.prod.outlook.com (2603:10b6:3:151::17)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:37 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::fc) by DM5PR19CA0007.outlook.office365.com
 (2603:10b6:3:151::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:36 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:36 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/42] drm/amd/display: Rename set_mst_bandwidth to align with
 DP spec
Date: Thu, 10 Sep 2020 09:46:59 -0400
Message-ID: <20200910134723.27410-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018c547e-f33a-462d-15a5-08d8559013ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803BA3FBD58972D219181588B270@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeGKehiLDEZiOYlu1wrpJQfgt6cLLAO5h/tWuakGOsrgVBQ4xz9NJDM4ED5kcBDn834iBRMamDKqeuK9OyWv/00ib8pwjLD8v4+UXCEbQsy6//o0mb0BB4V/6u8qN4RaW/zuuhIwE9e3xv4hC+oAG0onlmh+gKOQbVf88LrXLiyfYFmvgU2aw50gk4D4NY9U2QXVGiQ3GWw7d/nCi9wsT5Watnbd051aTBPVBE3yuAbzd5Of37h8UHUfjIH8vB8rkJnAUO9fvVVTTLmICx4DKJVk0OQPKiPrvs1nwpdDfcN6th98QBlEDP2UmTyZ9GJR3WXQwn17wBPwWGQvsiLIH5RKLTx9Rj5SgfV7DwYenKm07Lxy9FkHUO+1PRJdlZC11oZyScTcFt5qjXEa1B/G6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(81166007)(356005)(426003)(44832011)(7696005)(4326008)(36756003)(8676002)(82740400003)(6666004)(336012)(82310400003)(26005)(478600001)(186003)(2616005)(54906003)(83380400001)(5660300002)(316002)(2906002)(6916009)(8936002)(70206006)(1076003)(47076004)(70586007)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:37.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018c547e-f33a-462d-15a5-08d8559013ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 George Shen <george.shen@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The function set_mst_bandwidth is poorly name since it isn't clear what
it does, and it also does not reflect any part of the allocation sequence
described in the DP spec.

[How]
Rename the function set_mst_bandwidth to set_throttled_vcp_size.

(cherry picked from commit 9a630236f857562ae8a8af9c6b2a5ce79b409795)
Signed-off-by: George Shen <george.shen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c            | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c  | 6 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c  | 6 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h  | 2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c  | 4 ++--
 .../drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h   | 2 +-
 .../drm/amd/display/dc/virtual/virtual_stream_encoder.c  | 9 +++++----
 8 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 437d1a7a16fe..1871ff6119ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2946,7 +2946,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	pbn = get_pbn_from_timing(pipe_ctx);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
-	stream_encoder->funcs->set_mst_bandwidth(
+	stream_encoder->funcs->set_throttled_vcp_size(
 		stream_encoder,
 		avg_time_slots_per_mtp);
 
@@ -2974,7 +2974,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	 */
 
 	/* slot X.Y */
-	stream_encoder->funcs->set_mst_bandwidth(
+	stream_encoder->funcs->set_throttled_vcp_size(
 		stream_encoder,
 		avg_time_slots_per_mtp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 4cdaaf4d881c..5054bb567b74 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -710,7 +710,7 @@ static void dce110_stream_encoder_lvds_set_stream_attribute(
 	ASSERT(crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB);
 }
 
-static void dce110_stream_encoder_set_mst_bandwidth(
+static void dce110_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
 {
@@ -1621,8 +1621,8 @@ static const struct stream_encoder_funcs dce110_str_enc_funcs = {
 		dce110_stream_encoder_dvi_set_stream_attribute,
 	.lvds_set_stream_attribute =
 		dce110_stream_encoder_lvds_set_stream_attribute,
-	.set_mst_bandwidth =
-		dce110_stream_encoder_set_mst_bandwidth,
+	.set_throttled_vcp_size =
+		dce110_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
 		dce110_stream_encoder_update_hdmi_info_packets,
 	.stop_hdmi_info_packets =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 842abb4c475b..9cf139be3f40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -619,7 +619,7 @@ void enc1_stream_encoder_dvi_set_stream_attribute(
 	enc1_stream_encoder_set_stream_attribute_helper(enc1, crtc_timing);
 }
 
-void enc1_stream_encoder_set_mst_bandwidth(
+void enc1_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
 {
@@ -1616,8 +1616,8 @@ static const struct stream_encoder_funcs dcn10_str_enc_funcs = {
 		enc1_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		enc1_stream_encoder_dvi_set_stream_attribute,
-	.set_mst_bandwidth =
-		enc1_stream_encoder_set_mst_bandwidth,
+	.set_throttled_vcp_size =
+		enc1_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
 		enc1_stream_encoder_update_hdmi_info_packets,
 	.stop_hdmi_info_packets =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 30eae7459d50..b99d2527cf03 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -588,7 +588,7 @@ void enc1_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link);
 
-void enc1_stream_encoder_set_mst_bandwidth(
+void enc1_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index e3984f02b7b3..4075ae111530 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -561,8 +561,8 @@ static const struct stream_encoder_funcs dcn20_str_enc_funcs = {
 		enc1_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		enc1_stream_encoder_dvi_set_stream_attribute,
-	.set_mst_bandwidth =
-		enc1_stream_encoder_set_mst_bandwidth,
+	.set_throttled_vcp_size =
+		enc1_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
 		enc2_stream_encoder_update_hdmi_info_packets,
 	.stop_hdmi_info_packets =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index f5e80a0db72b..6c0f7ef0a3df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -790,8 +790,8 @@ static const struct stream_encoder_funcs dcn30_str_enc_funcs = {
 		enc3_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		enc3_stream_encoder_dvi_set_stream_attribute,
-	.set_mst_bandwidth =
-		enc1_stream_encoder_set_mst_bandwidth,
+	.set_throttled_vcp_size =
+		enc1_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
 		enc3_stream_encoder_update_hdmi_info_packets,
 	.stop_hdmi_info_packets =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 11ce06e69d3f..0184cefb083b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -143,7 +143,7 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc,
 		struct dc_crtc_timing *crtc_timing);
 
-	void (*set_mst_bandwidth)(
+	void (*set_throttled_vcp_size)(
 		struct stream_encoder *enc,
 		struct fixed31_32 avg_time_slots_per_mtp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 944c0327763c..f0a0d419e555 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -46,9 +46,10 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link) {}
 
-static void virtual_stream_encoder_set_mst_bandwidth(
+static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
-	struct fixed31_32 avg_time_slots_per_mtp) {}
+	struct fixed31_32 avg_time_slots_per_mtp)
+{}
 
 static void virtual_stream_encoder_update_hdmi_info_packets(
 	struct stream_encoder *enc,
@@ -107,8 +108,8 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
-	.set_mst_bandwidth =
-		virtual_stream_encoder_set_mst_bandwidth,
+	.set_throttled_vcp_size =
+		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
 		virtual_stream_encoder_update_hdmi_info_packets,
 	.stop_hdmi_info_packets =
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
