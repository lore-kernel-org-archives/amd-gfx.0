Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71DDC04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDF120720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fVKEXZsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDF120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0826FD17;
	Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581526FD0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVxaiK/TNX6xY+mM94B8sUBcpted0le7hsQUGVc9YGX+FFJHAmN5qC9i5NIZWktVuIGM+xeiaQACa+dKsRe2pMuzCus6dudmF6atCeZIhtYQxUbl/V2ktaq+4x34d66EIN/JFpDHcFpAyinnMoypgb8oIoiQO4lJU/c0nvllvshdkUiZkB1Ol65Vj9UlVLqkoHTvK8le7cNH2eY5EXYDhCI90zPtCpJnOqDaTLE9zAq/v+VNUeNyUMYLtGTAHJZv9LRXvAPxU//qxq5qiYF4HL1EYkAexdNdjpeBM3ogSR704ZeTN3JYXb3tazX2k9TxZ/gpDfTONJpmjZJjcrhoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Custi36LrYLarbLmfYHNxrgZQa8cOgenhWX6UkaDTE=;
 b=Y35aFmKRjr+9iyCL0jg+/+ftTtXHPID7hd+fY/2zKwrTYwAzy52SrPxtxIw5hWiVVRO5or7DyU1pz80dWuwD55WoSyGL24vufmDKhIq2+qfgFOL8Zyv2BfyK+mP6hazTfWgieYiDxhSeTX6Cvi20YbHSFNm5zTqPcD9bpDl6acZZ1cK4USBpbbqywjwtkn3MSGX7YaRK7uc3w/OOTArkd5ck663uHyWEMrCoxBbQ94DqAIPa6xDrrtUvuNneBcvN+8Pp9eFlxvX8e9RzntU6Kmnmwz2OWxm4hGnRVMSCxaJNLLb4sSgJ/XXdcRnNwlcvade0jM24q6y6TVPA4gyJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Custi36LrYLarbLmfYHNxrgZQa8cOgenhWX6UkaDTE=;
 b=fVKEXZsW2NAY4EHar7dgj7N9PHfG3nzN//Y8Phgdw17Lk89tDeOuPkpiHS57KZJO5HRO1OL+0zezrM3YMXmjNTn/3PEHPuiIosVocA/H/i4SJWnXhD13QDkEqSknfv0DOFgytWQkecXmP278fex4mpaHHgx5tZR7EYRYx2xuUT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:50 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/17] drm/amd/display: add monitor patch to disable SCDC
 read/write
Date: Fri,  7 Feb 2020 10:50:06 -0500
Message-Id: <20200207155010.1070737-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86c56378-c5b9-4899-42f8-08d7abe580e8
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440B75D53E73ECC442803A6981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgGtIVzw3Sw7s0rVXdKjIo4ORGdBW8vjyjIQIpFmcMcQEVzsFKycSmkmVMNriMVEz/5p3kVSchEjF88nNZQ6h0JjHJYIQjZlk7jXqbfKuiVPLLpMwylEBy6L/GTaGxj3l5P17zrGZCUSQku1MihwHb6exSCvRF1bEoLkmIdWuVqg6+8vlLldLJ+qVYZnovFwgdaOxJUNQM1AygoOo1/r4WcCJg/H70AvLcvN9iAlp0vZbGtswZe0y/fyPA4A7QGJ/HrmOrAAOLd4mjuCgczy2qWzr9e0hXwLBDfPZ72LZroN0g8w1K/kLYBVL0eQdCMzGBE7QMvMqwuOcoUarmH+cxeMIkuuwMoIoeXg2FoaKFPvwS+ts0L/QRXG/lV+dKswwMLANk4EmmJYdVhFesy+4ET7hZMsSp+RoEU/C3+J4TAlxBp+k37B9rSCGBavSr3i
X-MS-Exchange-AntiSpam-MessageData: WW+DneIBUCwbdS8pyXsjJWf6q2S60YsZHP7esDc5aJOEu66HQoro/oU8swTLol2bYhqnxNUAkEFdObe8KUro1GTe5y7HoF+rA9rBxhQ+Vk5foCTyCCKRz+ptAM4HoltIJ0G1hMjf3LV4wKLZuP97GA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c56378-c5b9-4899-42f8-08d7abe580e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:49.6968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiGpb9pYIhhU9MePxxZ4Y1IbjiFAaBt7QMsxEsTferZIqFMWzghPigrqMRI/VCdVsK3eEads3I2wO4OOIeC3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Martin Leung <martin.leung@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
customer issue: found that for their specific panel, EDID register space
being overwritten during SCDC read write

[how]
customer accepted HDMI 2 features not working - disabled SCDC read/write
as well as HDMI 2 in general based on monitor patch

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c             | 4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c         | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bed57051f04d..66d8d56f6abd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -977,6 +977,10 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		if ((prev_sink != NULL) && ((edid_status == EDID_THE_SAME) || (edid_status == EDID_OK)))
 			same_edid = is_same_edid(&prev_sink->dc_edid, &sink->dc_edid);
 
+		if (&sink->edid_caps.panel_patch.skip_scdc_overwrite)
+			link->ctx->dc->debug.hdmi20_disable = true;
+
+
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 			/*
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index a49c10d5df26..a5586f68b4da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -686,6 +686,10 @@ void dal_ddc_service_write_scdc_data(struct ddc_service *ddc_service,
 	uint8_t write_buffer[2] = {0};
 	/*Lower than 340 Scramble bit from SCDC caps*/
 
+	if (ddc_service->link->local_sink &&
+		ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
+		return;
+
 	dal_ddc_service_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &sink_version, sizeof(sink_version));
 	if (sink_version == 1) {
@@ -715,6 +719,10 @@ void dal_ddc_service_read_scdc_data(struct ddc_service *ddc_service)
 	uint8_t offset = HDMI_SCDC_TMDS_CONFIG;
 	uint8_t tmds_config = 0;
 
+	if (ddc_service->link->local_sink &&
+		ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
+		return;
+
 	dal_ddc_service_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &tmds_config, sizeof(tmds_config));
 	if (tmds_config & 0x1) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 122c96455792..1490732a4b44 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -229,6 +229,7 @@ struct dc_panel_patch {
 	unsigned int extra_t12_ms;
 	unsigned int extra_delay_backlight_off;
 	unsigned int extra_t7_ms;
+	unsigned int skip_scdc_overwrite;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 1a37c90e9d43..d3617d6785a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -782,6 +782,11 @@ bool dcn10_link_encoder_validate_output_with_stream(
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	bool is_valid;
 
+	//if SCDC (340-600MHz) is disabled, set to HDMI 1.4 timing limit
+	if (stream->sink->edid_caps.panel_patch.skip_scdc_overwrite &&
+		enc10->base.features.max_hdmi_pixel_clock > 300000)
+		enc10->base.features.max_hdmi_pixel_clock = 300000;
+
 	switch (stream->signal) {
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
