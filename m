Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDCC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AAE21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wgKYpBFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AAE21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087626E5CD;
	Mon,  2 Mar 2020 16:47:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF186E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2yGFW8O2rLj9HCuKTYjMfW9N6xUialGb5Gw+jhT5pYYLzpEmEctXsawuA01mTrGMJU3wLUm/3Z9Y3g7o1j+xM7gIYjvx4w3loveu5tfR+Ihj+rtNgnoSjQ/ciXqCGP9UYqW/8R/e1+aGtAlZS1/TKsKAcGSTKCFZdZsKR/4Bwv6Gzlq/J8HnpE9q+Kmwhv8EexVMacqQCnJDp/z+GjkP6BXMmqboHHO4xzuGJB+dk8pxjG4pHS//4DlFWowvqTzhtymegx5bJBFYAXgfUFziMlQv8mosmZIftFWZrzfwwqPE54pW7FVPTltvTUFt4bMY4vKf/LjqLWXCVmOa1A9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZLRkQDtt3RD2/Ma4Q80PaO+RLKgdsyTwNr15Od69GQ=;
 b=L5JAVBE09BxRjL5HQ5EESSdV0O9ikVxpiyzPPYWeKlWFgkvX43jb2xuz8U7MxVHOxKPMWK71Nip3fg9jj3XXnA6XiRAX6iXi80TKbNv4KoEdjUdMMVPu58iDBsvHzioqZln5d5g0RLuzZasvTimd6T7iS56G7s3b0ZRNCxY/6BtwlOXhKQGrkULTGT7VtIwruJefydaftucgtLlWYtmgP/htlaLrR4d6lVlDcu/GB6vvnIJFEHJ+SrP+fxG35nvknnwQgA8p0dQgQrKwWcKLviVUBkTpkUjVCHg1ecvqcnYK8wW8MiDa4yjKvZ/9Mhh51hAYaD1iZ+oKlO47yj1/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZLRkQDtt3RD2/Ma4Q80PaO+RLKgdsyTwNr15Od69GQ=;
 b=wgKYpBFY/tXIUxKOqxYwwGY6PJVdwmsRpP6sWrJn3EN8qK1vUEp+xk6jIAgLvQXD69y90mHRtuq0cZUBTSPlTq+AoF5ey7FZI0G9TmJc8R2W5H8khetn9KoaVY7eC6LbjFCAh+TMawVZPqwuLUddZfkHSMfiadbIk0vWwuqF78U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:47:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/22] drm/amd/display: only include FEC overhead if both asic
 and display support FEC
Date: Mon,  2 Mar 2020 11:47:18 -0500
Message-Id: <20200302164736.89429-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c8a9062-f29d-475f-13ac-08d7bec97363
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB254097C1958184F087478EB998E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viCbvDddN87rqdu3tI07v7cE/JQ99pegNwMHxoWtVCBc50z1BCTIsxhsp6/3bGC+xY6uDgyzaZqqFgMWEAL9Wpv1ZXeYHDahShvo7M+bbFV5Xnd8dUv0BnF0Nx40f0MN4Xk7Ep/Bd6lxIOfkME8Sg8H5PAy5PZxEna3eGQvaKxv5ENRPshHeHujewExZZ9/s0t6bpYr+7fZ60464oe6hUQi/hReQBhKZUNtw826zmobiy3XYpOzFdFZ197ysSE/7CWBqshiBwOWHFcC7QMOb/pi4H2eP/Eyqe8OGywh2LHQYuAmRGqXn7q24aMxjr9GVqiwk1bcQ1GzIYsVy2O/iXs5cGN04vmaV8FjBtCmml9xd5HAcDPtLD/z8YjJXTuJHhefGL5gggbX9clY1ZZMoAVP2Yl4YFrK3RDoRFyARCKmnXkHkwjVDvjf7VjImesBe
X-MS-Exchange-AntiSpam-MessageData: /3AO/4O5znlle6RpRTq/8FxA9uj+vgLT+aSk4FH7l3WRQ+xIY+ts8DJlXgy7ontT69kcxEclrukVCOqjE+mnGOBTMZdobwRBIQDxGkm7HekGl/3gUXvFTi9eJtuqG3G0WwDlxns9c3iEeBB3saCAPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8a9062-f29d-475f-13ac-08d7bec97363
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:53.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7tj+ZMVhgLg03IzeAzlo8p6Sf/R8WiXIXRkCflfFfKdAVZJ0xpU5IpZ1C9jr3QLXp9bHZRn7BnpiF2Ou+lwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
Some asics don't support FEC but FEC overhead is added into link
bandwidth calculation by mistake. This causes certain timing cannot be
validated.

[how]
Only include FEC overhead if both asic and display support FEC.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 11 ++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c      |  6 ++----
 drivers/gpu/drm/amd/display/dc/dc_link.h              |  3 +++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h  |  1 +
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 549bea1d725c..951b43dde4e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3406,7 +3406,7 @@ uint32_t dc_link_bandwidth_kbps(
 	link_bw_kbps *= 8;   /* 8 bits per byte*/
 	link_bw_kbps *= link_setting->lane_count;
 
-	if (link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
+	if (dc_link_is_fec_supported(link)) {
 		/* Account for FEC overhead.
 		 * We have to do it based on caps,
 		 * and not based on FEC being set ready,
@@ -3450,3 +3450,12 @@ void dc_link_overwrite_extended_receiver_cap(
 	dp_overwrite_extended_receiver_cap(link);
 }
 
+bool dc_link_is_fec_supported(const struct dc_link *link)
+{
+	return (dc_is_dp_signal(link->connector_signal) &&
+			link->link_enc->features.fec_supported &&
+			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
+			!link->dc->debug.disable_fec &&
+			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5aa3de9644ea..c805bec18044 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4126,8 +4126,7 @@ void dp_set_fec_ready(struct dc_link *link, bool ready)
 	struct link_encoder *link_enc = link->link_enc;
 	uint8_t fec_config = 0;
 
-	if (link->dc->debug.disable_fec ||
-			IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment))
+	if (!dc_link_is_fec_supported(link))
 		return;
 
 	if (link_enc->funcs->fec_set_ready &&
@@ -4162,8 +4161,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 {
 	struct link_encoder *link_enc = link->link_enc;
 
-	if (link->dc->debug.disable_fec ||
-			IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment))
+	if (!dc_link_is_fec_supported(link))
 		return;
 
 	if (link_enc->funcs->fec_set_enable &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index c45c7680fa58..00ff5e98278c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -333,4 +333,7 @@ bool dc_submit_i2c_oem(
 
 uint32_t dc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing);
+
+bool dc_link_is_fec_supported(const struct dc_link *link);
+
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 78971b6b195c..34483853e889 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1143,6 +1143,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.max_hdmi_pixel_clock = 600000,
 		.hdmi_ycbcr420_supported = true,
 		.dp_ycbcr420_supported = true,
+		.fec_supported = true,
 		.flags.bits.IS_HBR2_CAPABLE = true,
 		.flags.bits.IS_HBR3_CAPABLE = true,
 		.flags.bits.IS_TPS3_CAPABLE = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 88b51cae6178..de9047dd811d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1589,6 +1589,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.max_hdmi_pixel_clock = 600000,
 		.hdmi_ycbcr420_supported = true,
 		.dp_ycbcr420_supported = true,
+		.fec_supported = true,
 		.flags.bits.IS_HBR2_CAPABLE = true,
 		.flags.bits.IS_HBR3_CAPABLE = true,
 		.flags.bits.IS_TPS3_CAPABLE = true,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index fb748f082c56..c2b392a533b1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -68,6 +68,7 @@ struct encoder_feature_support {
 	unsigned int max_hdmi_pixel_clock;
 	bool hdmi_ycbcr420_supported;
 	bool dp_ycbcr420_supported;
+	bool fec_supported;
 };
 
 union dpcd_psr_configuration {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
