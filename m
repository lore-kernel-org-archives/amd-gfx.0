Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F2C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CA720644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IoiR7d9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CA720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446FF89F53;
	Sun,  5 Apr 2020 20:42:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1A989F53
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7GansI6ngSWxd6pZTjEnySf4aCgC/LViU7R+b6DDpE4xdpuZjzoMExARDahJjGgiBFeKLFJij0kbSVmKaeJs0vl2Gv9cVn9fIDHfB0KqpeET0nQ1pXbQoJrcixowErdk4myN4DoRi/kATL99bxMUJrv8+YjimPEf3vHgQAj1SFy/on0jN/wRinsfdFmvFmEr9p4O/6kKqjapbn0Mf/wwe9c04vjEwY1q0dkj5WJMWrJi63sJ1TLugxUE8uMIDyiaqNOAKcrC2NOXMyDqtq57GBroYICEmmY04O4AzEp/hNc6CcBtkDRilc7CiBXWJ9BESyC6tJhBjHJEteN8vC/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4X0fljgcPSja5SheBZfaam3gMJSzJMHy2yJgkijeFs=;
 b=GHJTWOA7fqctu3i8w8xWGG3T0FuKkqZe3xOAu1+xCKjqUSz87B2JfXWQ0iPiwYFxVPOMembsU1k5j79EDMl1ysymSF0neTb9k5Mec7q/ujswuV3krHeQGMsk7mhXQuq/6407JTy5C18XzI9aSsT1Tor+PPub5asmJ0DrCk+dGh02KJ4F0EwM9octvbuvzrNrBF4aJ28nGPqTLv6GdfAt5sstIM3S+yL0QZii02PL/l2qHrwsdI8zt9aWqRjlFziARWQ9zE0orwvve/BZtfDnHtFxzYHlH2FUtBBT20toT42YzaqxkTEGrFz9/chi3K4ucLLY6LRJLdkWsqNC5KZ93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4X0fljgcPSja5SheBZfaam3gMJSzJMHy2yJgkijeFs=;
 b=IoiR7d9HvjpkUmzqiKp4+g7XMrRL+DjHL0n/mhS47/+gCqGkFPgDiOM79v8UGOXzV7Vj1mUGHPvO8/f5Q94vm0DjmRvkysLOgIOMA8+NKsVHVlqO7j/Bbsxh57QTnmIpLUibKMuLWB+ziS8HektTI1iGmHAFt3rCl4/oeCGCjNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/36] drm/amd/display: determine USB C DP2 mode only when USB
 DP Alt is enabled
Date: Sun,  5 Apr 2020 16:41:13 -0400
Message-Id: <20200405204115.683559-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:11 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c85d7adc-3e16-4ca4-3b39-08d7d9a1d18d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255571F4E5CFAC9F35CBDA2F98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(30864003)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMKCdHNPTIm9epmycaCxUtaF31oFYtZTy7wYUml0K13St/9asiBT5YJ0LU2c8nXcWqxa7QSaeG4AYj4VD9EpKhHjws7CYEAbJeD8/lgR/9E5pAhCVFFQ8tyl9lJ8/xNQRnPy+A37sANljWuQJo5mTpwg5citoIVVFQNzEyNgBkW59jC3pDDJ4LJxHEi5bTAPE9Q4bylR7pxYsWj3U+1x/l6mbAq/Yju8greqWEsTBcgKLFdBFYGgHuvQqca3vM8xQ9onCdO2012OeNR5QTk6PxcCVgFgB4nHo5/2FTamdqRqXYforLe/hMXPuEzUhWTg6DYZiZHmvIqwTtReqTRzGaVKV7vC/bl+FpEFiFFUmtyHVXmPwTcVNvMshJgpgAPdYSekT0GzpEl4k8HWeoeBNyl4L8rYtdW33TNExtNnPpAttLPuFrd6Qm4ASx+tUIsd
X-MS-Exchange-AntiSpam-MessageData: wYWGC5UJR6m9EX9cnI+KuJH5EGmrHDJpcepyZiW5AeLzjPozFWI8zqjEJQHtXrws2wGQqAWvjPvTkfHWzSDAkYH5DBrXIGG/vaaznlENIwvsPx2tzIPeJRII6uxEoIjBwfRh6l9PzT7mdyQHnef4RmnZTZw7rh6kjHqoYPoVSFs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85d7adc-3e16-4ca4-3b39-08d7d9a1d18d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:12.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUKN0XUL/a8WlIM3jkrJx3/J/FWzFlj65/ZUpivPd3zC3btyMrTfRC3gI2K6HSFd/Z9yQmMapGhcPQxh0M+2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Wenjing Liu <wenjing.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When display is connected with a native DP port, DP2 mode register value
is a don't care. Driver mistakenly reduce max supported lane count to 2
lane based on the don't care value.

[how]
Add additional check only if USB C DP alt mode is enabled, we will
determine max lane count supported based on current mode.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 15 +----
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 20 ++++++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  3 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 20 ++++++-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  3 +
 .../amd/display/dc/dcn20/dcn20_link_encoder.c | 60 ++++++++++++-------
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |  4 ++
 .../amd/display/dc/dcn21/dcn21_link_encoder.c | 27 +--------
 .../display/dc/virtual/virtual_link_encoder.c |  9 +++
 10 files changed, 101 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 574612ddd5d2..fb25475101cc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -686,7 +686,7 @@ static bool is_same_edid(struct dc_edid *old_edid, struct dc_edid *new_edid)
 	return (memcmp(old_edid->raw_edid, new_edid->raw_edid, new_edid->length) == 0);
 }
 
-static bool wait_for_alt_mode(struct dc_link *link)
+static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 {
 
 	/**
@@ -843,7 +843,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			if (link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
 
 				/* if alt mode times out, return false */
-				if (wait_for_alt_mode(link) == false) {
+				if (wait_for_entering_dp_alt_mode(link) == false) {
 					return false;
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7cbb1efb4f68..74cf06aacd6c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1710,19 +1710,10 @@ bool dc_link_dp_sync_lt_end(struct dc_link *link, bool link_down)
 
 static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 {
-	/* Set Default link settings */
-	struct dc_link_settings max_link_cap = {LANE_COUNT_FOUR, LINK_RATE_HIGH,
-			LINK_SPREAD_05_DOWNSPREAD_30KHZ, false, 0};
-
-	/* Higher link settings based on feature supported */
-	if (link->link_enc->features.flags.bits.IS_HBR2_CAPABLE)
-		max_link_cap.link_rate = LINK_RATE_HIGH2;
-
-	if (link->link_enc->features.flags.bits.IS_HBR3_CAPABLE)
-		max_link_cap.link_rate = LINK_RATE_HIGH3;
+	struct dc_link_settings max_link_cap = {0};
 
-	if (link->link_enc->funcs->get_max_link_cap)
-		link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
+	/* get max link encoder capability */
+	link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 8527cce81c6f..8d8c84c81b34 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -118,7 +118,8 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.enable_hpd = dce110_link_encoder_enable_hpd,
 	.disable_hpd = dce110_link_encoder_disable_hpd,
 	.is_dig_enabled = dce110_is_dig_enabled,
-	.destroy = dce110_link_encoder_destroy
+	.destroy = dce110_link_encoder_destroy,
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap
 };
 
 static enum bp_result link_transmitter_control(
@@ -1389,3 +1390,20 @@ void dce110_link_encoder_disable_hpd(struct link_encoder *enc)
 
 	set_reg_field_value(value, 0, DC_HPD_CONTROL, DC_HPD_EN);
 }
+
+void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	/* Set Default link settings */
+	struct dc_link_settings max_link_cap = {LANE_COUNT_FOUR, LINK_RATE_HIGH,
+			LINK_SPREAD_05_DOWNSPREAD_30KHZ, false, 0};
+
+	/* Higher link settings based on feature supported */
+	if (enc->features.flags.bits.IS_HBR2_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_HIGH2;
+
+	if (enc->features.flags.bits.IS_HBR3_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_HIGH3;
+
+	*link_settings = max_link_cap;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 3c9368df4093..384389f0e2c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -271,4 +271,7 @@ void dce110_psr_program_secondary_packet(struct link_encoder *enc,
 
 bool dce110_is_dig_enabled(struct link_encoder *enc);
 
+void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings);
+
 #endif /* __DC_LINK_ENCODER__DCE110_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index d3617d6785a7..7fd385be3f3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -90,7 +90,8 @@ static const struct link_encoder_funcs dcn10_lnk_enc_funcs = {
 	.is_dig_enabled = dcn10_is_dig_enabled,
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.get_dig_mode = dcn10_get_dig_mode,
-	.destroy = dcn10_link_encoder_destroy
+	.destroy = dcn10_link_encoder_destroy,
+	.get_max_link_cap = dcn10_link_encoder_get_max_link_cap,
 };
 
 static enum bp_result link_transmitter_control(
@@ -1370,7 +1371,6 @@ void dcn10_link_encoder_disable_hpd(struct link_encoder *enc)
 			DC_HPD_EN, 0);
 }
 
-
 #define AUX_REG(reg)\
 	(enc10->aux_regs->reg)
 
@@ -1425,3 +1425,19 @@ enum signal_type dcn10_get_dig_mode(
 	return SIGNAL_TYPE_NONE;
 }
 
+void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	/* Set Default link settings */
+	struct dc_link_settings max_link_cap = {LANE_COUNT_FOUR, LINK_RATE_HIGH,
+			LINK_SPREAD_05_DOWNSPREAD_30KHZ, false, 0};
+
+	/* Higher link settings based on feature supported */
+	if (enc->features.flags.bits.IS_HBR2_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_HIGH2;
+
+	if (enc->features.flags.bits.IS_HBR3_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_HIGH3;
+
+	*link_settings = max_link_cap;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index 762109174fb8..68395bcc24fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -575,4 +575,7 @@ void dcn10_aux_initialize(struct dcn10_link_encoder *enc10);
 
 enum signal_type dcn10_get_dig_mode(
 	struct link_encoder *enc);
+
+void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings);
 #endif /* __DC_LINK_ENCODER__DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index 15d513b79667..8d209dae66e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -49,6 +49,12 @@
 #define IND_REG(index) \
 	(enc10->link_regs->index)
 
+#ifndef MAX
+#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
+#endif
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 static struct mpll_cfg dcn2_mpll_cfg[] = {
 	// RBR
@@ -260,6 +266,38 @@ void dcn20_link_encoder_enable_dp_output(
 
 }
 
+void dcn20_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t is_in_usb_c_dp4_mode = 0;
+
+	dcn10_link_encoder_get_max_link_cap(enc, link_settings);
+
+	/* in usb c dp2 mode, max lane count is 2 */
+	if (enc->funcs->is_in_alt_mode && enc->funcs->is_in_alt_mode(enc)) {
+		REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
+		if (!is_in_usb_c_dp4_mode)
+			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
+	}
+
+}
+
+bool dcn20_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t dp_alt_mode_disable = 0;
+	bool is_usb_c_alt_mode = false;
+
+	if (enc->features.flags.bits.DP_IS_USB_C) {
+		/* if value == 1 alt mode is disabled, otherwise it is enabled */
+		REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
+		is_usb_c_alt_mode = (dp_alt_mode_disable == 0);
+	}
+
+	return is_usb_c_alt_mode;
+}
+
 #define AUX_REG(reg)\
 	(enc10->aux_regs->reg)
 
@@ -311,28 +349,6 @@ void enc2_hw_init(struct link_encoder *enc)
 	dcn10_aux_initialize(enc10);
 }
 
-void dcn20_link_encoder_get_max_link_cap(struct link_encoder *enc,
-	struct dc_link_settings *link_settings)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value;
-
-	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &value);
-
-	if (!value && link_settings->lane_count > LANE_COUNT_TWO)
-		link_settings->lane_count = LANE_COUNT_TWO;
-}
-bool dcn20_link_encoder_is_in_alt_mode(struct link_encoder *enc)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value;
-
-	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &value);
-
-	// if value == 1 alt mode is disabled, otherwise it is enabled
-	return !value;
-}
-
 static const struct link_encoder_funcs dcn20_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index 8cab8107fd94..284a1ee4d249 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -343,6 +343,10 @@ void dcn20_link_encoder_enable_dp_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source);
 
+bool dcn20_link_encoder_is_in_alt_mode(struct link_encoder *enc);
+void dcn20_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings);
+
 void dcn20_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
 	const struct encoder_init_data *init_data,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
index e45683ac871a..aa46c35b05a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
@@ -203,29 +203,6 @@ static bool update_cfg_data(
 	return true;
 }
 
-void dcn21_link_encoder_get_max_link_cap(struct link_encoder *enc,
-	struct dc_link_settings *link_settings)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value;
-
-	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &value);
-
-	if (!value && link_settings->lane_count > LANE_COUNT_TWO)
-		link_settings->lane_count = LANE_COUNT_TWO;
-}
-
-bool dcn21_link_encoder_is_in_alt_mode(struct link_encoder *enc)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t value;
-
-	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &value);
-
-	// if value == 1 alt mode is disabled, otherwise it is enabled
-	return !value;
-}
-
 bool dcn21_link_encoder_acquire_phy(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
@@ -348,8 +325,8 @@ static const struct link_encoder_funcs dcn21_link_enc_funcs = {
 	.fec_set_ready = enc2_fec_set_ready,
 	.fec_is_active = enc2_fec_is_active,
 	.get_dig_frontend = dcn10_get_dig_frontend,
-	.is_in_alt_mode = dcn21_link_encoder_is_in_alt_mode,
-	.get_max_link_cap = dcn21_link_encoder_get_max_link_cap,
+	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
+	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
 };
 
 void dcn21_link_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
index 3464b2d5b89a..348e9a600a72 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
@@ -84,6 +84,14 @@ static void virtual_link_encoder_destroy(struct link_encoder **enc)
 	*enc = NULL;
 }
 
+static void virtual_link_encoder_get_max_link_cap(struct link_encoder *enc,
+		struct dc_link_settings *link_settings)
+{
+	/* Set Default link settings */
+	struct dc_link_settings max_link_cap = {LANE_COUNT_FOUR, LINK_RATE_HIGH,
+				LINK_SPREAD_05_DOWNSPREAD_30KHZ, false, 0};
+	*link_settings = max_link_cap;
+}
 
 static const struct link_encoder_funcs virtual_lnk_enc_funcs = {
 	.validate_output_with_stream =
@@ -94,6 +102,7 @@ static const struct link_encoder_funcs virtual_lnk_enc_funcs = {
 	.enable_dp_output = virtual_link_encoder_enable_dp_output,
 	.enable_dp_mst_output = virtual_link_encoder_enable_dp_mst_output,
 	.disable_output = virtual_link_encoder_disable_output,
+	.get_max_link_cap = virtual_link_encoder_get_max_link_cap,
 	.dp_set_lane_settings = virtual_link_encoder_dp_set_lane_settings,
 	.dp_set_phy_pattern = virtual_link_encoder_dp_set_phy_pattern,
 	.update_mst_stream_allocation_table =
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
