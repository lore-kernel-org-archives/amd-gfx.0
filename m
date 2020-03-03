Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD8FC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15FD20716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tF5UiJ+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15FD20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781EA6EA89;
	Tue,  3 Mar 2020 23:27:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B466EA79
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO4p3UllfM/uYrbp1/I9+Np4FWgur5Cz0jQNuZUwlR/VGgQmIVmxp9npW6Ne0U/DIrpoS2x+fGsJHh5frsPfIHVdDkAEam1/Y7n9rbiawmUE37eTtsKRflvnGj4pHzppWSiX6GrNnDle+ukG/BHUg1EPfltwjnFfWyMz2aAVx2rUWbQ/92z20ZH5PsSEjHYSpKesJi/hff/FpW24Dn78Mpy2jGObHmX+SreGnKgUCR+r2veGOWguQeHRyIN1nFmL+MD02eY5ioSZV+A2MHPgs4S+qOGBxasyv0HkETs5qPRQXM+ruAYG9n07rJrkSgLgTm8KLj7awfrElukYwJbddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWcTGs6U1VecXbDS73RVY3caTgI8NxR4ulFtyVfezhI=;
 b=G8ualA1pylTXluPkEHkICxQPv4R+dZdHrm6EPDuVOk09PAMRYJ+Z9T7TcKjK0DDLnUc0aYiK/xJIhVdaJRZ2XYKxG/NscpKsuVbDGypT3YnJycSydHIdZBLKEfauElHQd3k3vh7CGLx30k9zQUr5Gu/8VQL07OKXfFCYbJ2Y2h6gJ9NqEUYspFn/pmhgI1/S1GUzau4qggr40Jjt7vC6X+HSPgppYDoEfPXnzMMwAqvBrXT4gbEUwZMphE6iKyMQ9PFEEVpcBuKJ9lExHL8JvEeWudSTuPqHYZHYE/jEAD5QnDt/La0A/U3W1ndstentQlDmOBGg+6LSlzLIx+yIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWcTGs6U1VecXbDS73RVY3caTgI8NxR4ulFtyVfezhI=;
 b=tF5UiJ+WhC514YXNW49cFKyYXQ1WwviGDMrI9BPnDBesEJ8XQXSYwNac1gqjmPV++Yu/JXzavTs/Z7N0dH3QWyLohG5wPtUDqz1c+9V4n3Ut25V7aM2OefV/eVS1+tLppJe8w5+u9fCQpZCOMlYwv2D1IrgJSBZp6J15lk1YuJo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 23:27:45 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/amd/display: separate FEC capability from fec debug
 flag
Date: Tue,  3 Mar 2020 18:27:17 -0500
Message-Id: <20200303232718.351364-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:43 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f41807e-9e27-4133-8d6e-08d7bfca7956
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:|MW2PR12MB2362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23628DDF58E4DF82AA1C72E598E40@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(6486002)(6666004)(54906003)(66946007)(186003)(66476007)(26005)(16526019)(2906002)(5660300002)(1076003)(52116002)(66556008)(4326008)(7696005)(316002)(478600001)(2616005)(956004)(36756003)(86362001)(81166006)(8676002)(6916009)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2362;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQzogpSzVTaXTphINc+2fgTJGXSKuECzsQog5ZsWCFhNbCE/VnSZE1nE0r6LoXJIdhPgsAQEC2ss+oDbxhYEkkyoSwQ1rasq8C8l0D/ipTLCkiS2mmhDSCJewoUpqW7Xlca4BdRFwhFT9raynLl6PtI3YcZSn/OACb22RyjBC22CtJfEJvimlk8YSn8nQ05fMRfTG45Tn47xdr4d16X337c7jH5NX52cvoiTsXqrEvQjV+xMKhnJsekpMNxPoDsch99ttM5I5OvzPZCTVgJFgBCF/r+NauoJl4njhdT37gTGMHC6oeRTLNktKzv1eEkvSext+7BMvMzj3dPhriGywZr/jAMWWF47wGLq89GRgyjQBCCBAbAnnpjgvL3XBEDGehjOkVKWOK3aaTdASS/GGi8p0BgdV3OzP1QfvyUA/oSG8aTKtxzB1H3H5sk/rUbz
X-MS-Exchange-AntiSpam-MessageData: vLR2FwqTuY4D5WHft48JtHE/QNTxI/L+Hj0vzqOyhDVHAvqC42z7QR3+Cag0Io+4CF9T+st23kcGn0beaO7K2nK2HoN3m/wuAuQ6Qh6gtul/M4om0VuSWobps0IbC658eRprIUr3tgXMTtPTyf4Ngg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41807e-9e27-4133-8d6e-08d7bfca7956
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:43.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a2JDtn7f0LDVb/wbyQqXezMgKQA114+iHDoyhE2vYW/5X4HQZtBWToRXGLYhCgUtwLziKqi1xSOFYAAY2WarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
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
FEC capability query should not be affected by debugging decision on
whether to disable FEC. We should not determine if display supports FEC
by checking debug option.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 16 ++++++++--------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  3 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h              |  8 +++++++-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 4837640530ad..cc1b52b72c0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -207,7 +207,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 
 	if (!dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
 				   dsc_caps, NULL,
-				   &dc_sink->sink_dsc_caps.dsc_dec_caps))
+				   &dc_sink->dsc_caps.dsc_dec_caps))
 		return false;
 
 	return true;
@@ -262,8 +262,8 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (!validate_dsc_caps_on_connector(aconnector))
-				memset(&aconnector->dc_sink->sink_dsc_caps,
-				       0, sizeof(aconnector->dc_sink->sink_dsc_caps));
+				memset(&aconnector->dc_sink->dsc_caps,
+				       0, sizeof(aconnector->dc_sink->dsc_caps));
 #endif
 		}
 	}
@@ -550,7 +550,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
 		if (vars[i].dsc_enabled && dc_dsc_compute_config(
 					params[i].sink->ctx->dc->res_pool->dscs[0],
-					&params[i].sink->sink_dsc_caps.dsc_dec_caps,
+					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
 					0,
 					params[i].timing,
@@ -571,7 +571,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
-			&param.sink->sink_dsc_caps.dsc_dec_caps,
+			&param.sink->dsc_caps.dsc_dec_caps,
 			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
 			(int) kbps, param.timing, &dsc_config);
 
@@ -768,14 +768,14 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].sink = stream->sink;
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 		params[count].port = aconnector->port;
-		params[count].compression_possible = stream->sink->sink_dsc_caps.dsc_dec_caps.is_dsc_supported;
+		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
 		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 				dsc_policy.min_target_bpp,
 				dsc_policy.max_target_bpp,
-				&stream->sink->sink_dsc_caps.dsc_dec_caps,
+				&stream->sink->dsc_caps.dsc_dec_caps,
 				&stream->timing, &params[count].bw_range))
 			params[count].bw_range.stream_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
 
@@ -857,7 +857,7 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (!aconnector || !aconnector->dc_sink)
 			continue;
 
-		if (!aconnector->dc_sink->sink_dsc_caps.dsc_dec_caps.is_dsc_supported)
+		if (!aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported)
 			continue;
 
 		if (computed_streams[i])
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 83df17a17271..fb603bd46fac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3407,7 +3407,7 @@ uint32_t dc_link_bandwidth_kbps(
 	link_bw_kbps *= 8;   /* 8 bits per byte*/
 	link_bw_kbps *= link_setting->lane_count;
 
-	if (dc_link_is_fec_supported(link)) {
+	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec) {
 		/* Account for FEC overhead.
 		 * We have to do it based on caps,
 		 * and not based on FEC being set ready,
@@ -3456,7 +3456,6 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 	return (dc_is_dp_signal(link->connector_signal) &&
 			link->link_enc->features.fec_supported &&
 			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
-			!link->dc->debug.disable_fec &&
 			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index fc3664dd5e88..9553755be286 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4152,7 +4152,7 @@ void dp_set_fec_ready(struct dc_link *link, bool ready)
 	struct link_encoder *link_enc = link->link_enc;
 	uint8_t fec_config = 0;
 
-	if (!dc_link_is_fec_supported(link))
+	if (!dc_link_is_fec_supported(link) || link->dc->debug.disable_fec)
 		return;
 
 	if (link_enc->funcs->fec_set_ready &&
@@ -4187,7 +4187,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 {
 	struct link_encoder *link_enc = link->link_enc;
 
-	if (!dc_link_is_fec_supported(link))
+	if (!dc_link_is_fec_supported(link) || link->dc->debug.disable_fec)
 		return;
 
 	if (link_enc->funcs->fec_set_enable &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2b538f477c82..5508c32f4484 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1025,6 +1025,11 @@ struct dc_sink_dsc_caps {
 	struct dsc_dec_dpcd_caps dsc_dec_caps;
 };
 
+struct dc_sink_fec_caps {
+	bool is_rx_fec_supported;
+	bool is_topology_fec_supported;
+};
+
 /*
  * The sink structure contains EDID and other display device properties
  */
@@ -1038,7 +1043,8 @@ struct dc_sink {
 	struct stereo_3d_features features_3d[TIMING_3D_FORMAT_MAX];
 	bool converter_disable_audio;
 
-	struct dc_sink_dsc_caps sink_dsc_caps;
+	struct dc_sink_dsc_caps dsc_caps;
+	struct dc_sink_fec_caps fec_caps;
 
 	/* private to DC core */
 	struct dc_link *link;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
