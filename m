Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC00C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050022173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="30zvefzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050022173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937F56EB91;
	Wed, 11 Dec 2019 15:34:21 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEDD6EB92
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0NYqFbBrp95TAw2MUL065DlOll/VjHzfuPoqp44EbeFyhVeEZyccRyDa+AvZmfkSHgXcXP7Dx1aKvXvRxCOamx0gVvaIwxwHew0YyJ32o6A7c9+eIom1pwQyxFHsiMdH4YT1EufIvbDgrscdPLV2Se6w2UOEQ5L/xord+u7Rlvv6Cjd8ylkGqKvPdSBK0LUbrHeoUfuv3NwLrTKz97O4Lu/3HcJOLZgYw6wRPAdHd7lJp2hQ9FilsevO1xkPDICZNMMH0XZwUH33d+5CM+34ivLMUlrcnMhof6sp5wI/G3lLnVGXIVfuCeH6JHYWh1O8kfO1UUopKF5AEoL3asIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeRiG8MLqWxfgeqgF6M98XUVEt4eHx+sxugGN2szn3o=;
 b=KZ9Rb/eB9AFbkiNEoNGaTp9lnLYzeMKZ6asIzOsqJx3Eke5X0pofYfGEi+msrQzCVouJ3uwsKxepABHVhkC8rsfxNB1XsWDReBTs5y6ODLQDsMUn+OYfedysV9eyg7RjDM4kRJd0SOgiIdNfrVYzJIDM4pDKWTVYeLCgz6ARU0IfxCMru5SZNYZft//qZMOk+KfuyatB3Fu+Y4cD2rT3QRmP3EersutUpClZJAOGSj2OetFLlk4PwDgmpoD/xLhVq5Ojz/192wUo8YkohcJWfjqbTSSvQ5xkU24z1ZV6mSqwA9V0uOyBTBAnd2vu4Etd6FRIK1N0ewmEtzUEXXfbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeRiG8MLqWxfgeqgF6M98XUVEt4eHx+sxugGN2szn3o=;
 b=30zvefzSfdXDN7uBSwG+BOFu2mXDBXcds7IHdnxQx3KIg1cxdK8lMdB/DnnrI+FdanB7WJ6x49axgHmXyfaMK6KKXb7GA2bi/MuMh2dSxNMW0dbbBxcrqVMczVI3V6d7r4EKc6Car0tScDWCP5EMwyMB5NI2ODyO71wIJ/pA7a0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:19 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/39] drm/amd/display: Add debug option to override DSC
 target bpp increment
Date: Wed, 11 Dec 2019 10:32:53 -0500
Message-Id: <20191211153253.2291112-40-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3f73859-f81e-45ff-36f9-08d77e4f8608
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491F62E0F8568AE735265D6985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/0c2WJx5EIWm9n6TDjfQoqMPGPH3z1FVT55zDcgu3teRJONbxix8qDiG5nnz++k97qkrI2tR4hyeevcfriYkIWjLzjfISCOWEj3ZatGllFxLMVM2ZeSl7eyhH393L63KpkClEA3vAqJS5VMtghE3NsXjPYC5uogJowMLwJnu/Y+DT3sDj6flNTsDnfjL6k029Q/efn40Le1OaHskHpYaABEJSQs/ot6M1y7rzMPhSu+1tglK/EhJkppQWT+n4isrRE6zkBzCwm8yg0DkH1UEFhUloUIVs+rdi4ftDtqcQXXDrDwEnyqFxdRKkNA/5mfbbT3Ql9NcP62SwzLL9Xp5QVaH6K7DNuxTfnA7sERlupRf1XDeGzP5OwjEad3datS8ZMBi43EbvVIO9LD+6OopSmIwkaQG9oipfFe3x+vkXKWV8Qq6sP8y9hg9qu8h4OP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f73859-f81e-45ff-36f9-08d77e4f8608
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:51.5254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lZbBpR+8iGVH82PifxJE1esx3R2miTcVu8U2m0Zvr1bNhcppNWgPmQfClfK5Wf4s8EM0CdNBHxfJlvCv8MUYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
It's required for debug purposes.

[how]
Add a dsc_bpp_increment_div debug option that overrides DPCD
BITS_PER_PIXEL_INCREMENT value. The value dsc_bpp_increment_div should
be set to is the one after parsing, i.e. it could be 1, 2, 4, 8 or 16
(meaning 1pix, 1/2pix, ..., 1/16pix).

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  3 ++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 19 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 745d8719ccc1..f90b5eb8db82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4148,7 +4148,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
+		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
+				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_ext_caps.raw,
 				      &dsc_caps);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c2ba93ab7e0..039004344dc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -367,6 +367,7 @@ struct dc_debug_options {
 	bool disable_hubp_power_gate;
 	bool disable_dsc_power_gate;
 	int dsc_min_slice_height_override;
+	int dsc_bpp_increment_div;
 	bool native422_support;
 	bool disable_pplib_wm_range;
 	enum wm_report_mode pplib_wm_report_mode;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 7ece8eb5f48c..3800340a5b4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -53,7 +53,8 @@ struct dc_dsc_policy {
 	uint32_t min_target_bpp;
 };
 
-bool dc_dsc_parse_dsc_dpcd(const uint8_t *dpcd_dsc_basic_data,
+bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
+		const uint8_t *dpcd_dsc_basic_data,
 		const uint8_t *dpcd_dsc_ext_data,
 		struct dsc_dec_dpcd_caps *dsc_sink_caps);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 71b048363506..8b78fcbfe746 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -760,7 +760,7 @@ static bool setup_dsc_config(
 	return is_dsc_possible;
 }
 
-bool dc_dsc_parse_dsc_dpcd(const uint8_t *dpcd_dsc_basic_data, const uint8_t *dpcd_dsc_ext_data, struct dsc_dec_dpcd_caps *dsc_sink_caps)
+bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_data, const uint8_t *dpcd_dsc_ext_data, struct dsc_dec_dpcd_caps *dsc_sink_caps)
 {
 	if (!dpcd_dsc_basic_data)
 		return false;
@@ -813,6 +813,23 @@ bool dc_dsc_parse_dsc_dpcd(const uint8_t *dpcd_dsc_basic_data, const uint8_t *dp
 	if (!dsc_bpp_increment_div_from_dpcd(dpcd_dsc_basic_data[DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT], &dsc_sink_caps->bpp_increment_div))
 		return false;
 
+	if (dc->debug.dsc_bpp_increment_div) {
+		/* dsc_bpp_increment_div should onl be 1, 2, 4, 8 or 16, but rather than rejecting invalid values,
+		 * we'll accept all and get it into range. This also makes the above check against 0 redundant,
+		 * but that one stresses out the override will be only used if it's not 0.
+		 */
+		if (dc->debug.dsc_bpp_increment_div >= 1)
+			dsc_sink_caps->bpp_increment_div = 1;
+		if (dc->debug.dsc_bpp_increment_div >= 2)
+			dsc_sink_caps->bpp_increment_div = 2;
+		if (dc->debug.dsc_bpp_increment_div >= 4)
+			dsc_sink_caps->bpp_increment_div = 4;
+		if (dc->debug.dsc_bpp_increment_div >= 8)
+			dsc_sink_caps->bpp_increment_div = 8;
+		if (dc->debug.dsc_bpp_increment_div >= 16)
+			dsc_sink_caps->bpp_increment_div = 16;
+	}
+
 	/* Extended caps */
 	if (dpcd_dsc_ext_data == NULL) { // Extended DPCD DSC data can be null, e.g. because it doesn't apply to SST
 		dsc_sink_caps->branch_overall_throughput_0_mps = 0;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
