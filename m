Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E1C33CA6
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157AE2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ai2b5kF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157AE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BE76EA51;
	Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2FB6EA45
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrUtz3770he7PZcy230dw2bosXRPlnRJXkpd4YgBDrDuSHfJMqdr2PfTXJVg9x5OwvqEAX9A4oaQKEc7gFhphHrdgj1PjM1bHFGtivmgrlMyA4p9RLw36qwhMphIoZ3saULqYL+RbuXBpe1Rn+DE6JPBKayEACjItS6Mh1eDfR9dA6q3feLoadc9aJNdnvWXtSe+aI3lQwq3XBUbaScz8cuXRJ0xsGZemOiP8NIltBmy1/HKqCe297Gshj02X+EEbGFl1oWsWmS+48VV+0RydDrJGoRKQMPwPpGz42ZtE7PBmDuYBwguRk6Zzo/GndlIu62tQ6Nqok38GLRdx7vLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTbb3LOi9x2cTE8u3225A2AHRZ9Dx6rtJoUenGhQYUs=;
 b=OL5++DHbxzijH9Z3lJQKT2r+33t0/mm40bpp55n2UQqOqnbTLIDxoqUWtjxA1kZ2d2tZnKwhrNPykBkycviyOUkm+fxPgFnBUZPsswNy82uy8y7XzP3PPi0xhe99tu1VcKefoCdd7OExugtbt/j9lPM7Gqux03bNanKEoj3YdXE5zrgl9PbPjOH5UmLKqWxNwdvwqGg+zURoQusbzRQcY1P7CoKaKEfg+Q3SL91Fx6j5Kmwxw0+W6mjPEHkaJWEnwvcyExhVBSOwlNndWApCHv4KATieykPP9q/ezhhddPLVMIz50Gkt6hBpcCRrrhU0zYO8ixi2sZdiWiPvoOWyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTbb3LOi9x2cTE8u3225A2AHRZ9Dx6rtJoUenGhQYUs=;
 b=ai2b5kF0eoi0LuJ/9QmJ4gqhXySMY1XCmAawBfYw6s0v550brr7wixjE5XuoqMMaZ2mGliFCGG9xOA4GmKdV37tEd2FCo43ooSoCbjzfiQ3D5jfHDNmTucxcCgKhQDcwVhB/O71QlPpm6sMt1bj0znh17fxNKErjR3x27c08RgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:20 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:20 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/43] drm/amd/display: Add monitor patch for AUO dpcd issue
Date: Fri, 10 Jan 2020 09:46:48 -0500
Message-Id: <20200110144655.55845-37-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:52 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81c4043b-ecf0-4082-6c1c-08d795dc124b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378DCE62B3BAE25A90B2F7198380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBkHbGFdxFw6g4nn3I1dbHMzwlFgfud8mNniiABTmP4umNMHtjJUT1N7OX/yeIY+tish61qtm6XDwmqSsssfu2z+ezOBhyq6bu/XWnaFm8UbJDbn4FywNwd2tz/ETafJZkdQOB9r32AXw694kkZLrGXfux3LRqyDkMLfEK5znsnCShF6SmbWnJbwdo68KzBqelll0wUoekuycDIKFGq+gVKe8tp4WVrIL3BXLx8rwyu110N9/3qS+7+v4mjZMEbyj5JjDlAjPgcPWUQcsqdEyd1rxvBNi2UKeRd2u13espAfk0VJjbbn0kYWpNrEA+wzhWz2A8ZmRXa4EOoqaMabvD8bjQj2lEA858Hbjnx0Q7LF9oZ8gTi+QOE1sBzucqFFKTYFMvRyJHnu17/j4B2uEsphoZLjqywIFFGv9zq/YQNLOtVQvzNhZJJKtw9LDV3V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c4043b-ecf0-4082-6c1c-08d795dc124b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:53.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgDrBck4Qn9z3kuf87bktK1RTeeNtZT7hAPOLmleBm54QKMS1v0yLcRh+lopcb3RPLr18UA2vuWWJQ6bvnhL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Lewis Huang <Lewis.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
dpcd cap mismatch in 2200 vs base

[How]
Add monitor patch which using based caps to overwrite 2200

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 +++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 62 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7fcae8d63811..a397b6a28633 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3371,3 +3371,10 @@ const struct dc_link_settings *dc_link_get_link_cap(
 		return &link->preferred_link_setting;
 	return &link->verified_link_cap;
 }
+
+void dc_link_overwrite_extended_receiver_cap(
+		struct dc_link *link)
+{
+	dp_overwrite_extended_receiver_cap(link);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9ab6b7402288..8206bb3f74ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3447,6 +3447,68 @@ static bool retrieve_link_cap(struct dc_link *link)
 	return true;
 }
 
+bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
+{
+	uint8_t dpcd_data[16];
+	uint32_t read_dpcd_retry_cnt = 3;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	union dp_downstream_port_present ds_port = { 0 };
+	union down_stream_port_count down_strm_port_count;
+	union edp_configuration_cap edp_config_cap;
+
+	int i;
+
+	for (i = 0; i < read_dpcd_retry_cnt; i++) {
+		status = core_link_read_dpcd(
+				link,
+				DP_DPCD_REV,
+				dpcd_data,
+				sizeof(dpcd_data));
+		if (status == DC_OK)
+			break;
+	}
+
+	link->dpcd_caps.dpcd_rev.raw =
+		dpcd_data[DP_DPCD_REV - DP_DPCD_REV];
+
+	if (dpcd_data[DP_MAX_LANE_COUNT - DP_DPCD_REV] == 0)
+		return false;
+
+	ds_port.byte = dpcd_data[DP_DOWNSTREAMPORT_PRESENT -
+			DP_DPCD_REV];
+
+	get_active_converter_info(ds_port.byte, link);
+
+	down_strm_port_count.raw = dpcd_data[DP_DOWN_STREAM_PORT_COUNT -
+			DP_DPCD_REV];
+
+	link->dpcd_caps.allow_invalid_MSA_timing_param =
+		down_strm_port_count.bits.IGNORE_MSA_TIMING_PARAM;
+
+	link->dpcd_caps.max_ln_count.raw = dpcd_data[
+		DP_MAX_LANE_COUNT - DP_DPCD_REV];
+
+	link->dpcd_caps.max_down_spread.raw = dpcd_data[
+		DP_MAX_DOWNSPREAD - DP_DPCD_REV];
+
+	link->reported_link_cap.lane_count =
+		link->dpcd_caps.max_ln_count.bits.MAX_LANE_COUNT;
+	link->reported_link_cap.link_rate = dpcd_data[
+		DP_MAX_LINK_RATE - DP_DPCD_REV];
+	link->reported_link_cap.link_spread =
+		link->dpcd_caps.max_down_spread.bits.MAX_DOWN_SPREAD ?
+		LINK_SPREAD_05_DOWNSPREAD_30KHZ : LINK_SPREAD_DISABLED;
+
+	edp_config_cap.raw = dpcd_data[
+		DP_EDP_CONFIGURATION_CAP - DP_DPCD_REV];
+	link->dpcd_caps.panel_mode_edp =
+		edp_config_cap.bits.ALT_SCRAMBLER_RESET;
+	link->dpcd_caps.dpcd_display_control_capable =
+		edp_config_cap.bits.DPCD_DISPLAY_CONTROL_CAPABLE;
+
+	return true;
+}
+
 bool detect_dp_sink_caps(struct dc_link *link)
 {
 	return retrieve_link_cap(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index f420aeac7fbd..f9aae35aec92 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -301,6 +301,9 @@ uint32_t dc_link_bandwidth_kbps(
 const struct dc_link_settings *dc_link_get_link_cap(
 		const struct dc_link *link);
 
+void dc_link_overwrite_extended_receiver_cap(
+		struct dc_link *link);
+
 bool dc_submit_i2c(
 		struct dc *dc,
 		uint32_t link_index,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 6198bccd6199..8b1f0ce6c2a7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -76,6 +76,8 @@ void dp_enable_mst_on_sink(struct dc_link *link, bool enable);
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 
+bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
+
 void dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
