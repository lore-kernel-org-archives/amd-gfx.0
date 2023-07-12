Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DD6EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC92B10E5A8;
	Wed, 12 Jul 2023 17:13:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C69310E5A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dke9Fcll9cd2qwPE60zAJKm826FN5w6n+9CG1WkWTUjGW60A7amzwg0T4pOEnld9LUNkw5dn/wEIV+PJDL0hbIyrm8frzsqi8YT/E1mpiDiFZpbF2Z2/+3QcKPjncl3x7N9OxwlwdR+mWnkq9EaDildr9CtYXcQsl0u/SQRI3IeaWc87hdeAUsokHaNrZ0kb2WxGyyUb6G3e8dIH840SJPirFAqAL0b97TctIpfAFu0HbtXb/bDkUXgad0ddaTVQ6waFoI8XaliAttj7W89JPKVivgUsH4B3nqVVvkxFHI5v65+tk9p4ffDzq7JJhw/mSjsnb5Mzw7b/QLSIO3aWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHGZTVEGsTWCjblDlmA04MjdsHUJewq3BvqkjSVu8dc=;
 b=eucZTo5OGHTJU/5OsZjYq1/mUJlJhlb+Lmmks8nyttinRCxHt5ig5uBMw6ytBcwQGwOnH6NsGp+B4HtqoWm4kQ6bTosQTnVcqL1xrxlhujAwWRbka3bg2qIeeES291Q1E06GwJgfbaJ9zLVjA6VbHMFiIPgJ31Yy16Dz2qmOjfxd41jiAxbWBdBXT2HUPxsr8kwMB0Bh9xjdEqwey697qowcgt8mx66ZReAtpx0fLZXoOGVEMq6v7BeJioOLSYbaks+JjIwvgOOLhon2mnyUQyyILt6sqn3hEGGdN7xGmFo6dLMT4SyHodWIprqawgHccU35IUUewSZuOPenOj2L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHGZTVEGsTWCjblDlmA04MjdsHUJewq3BvqkjSVu8dc=;
 b=Y7Ktjq7OJr3GfK4GjHq7I8K0dFywIyNvN6dSi9fp+WZLVlo3fcLOp9Xa1Yx/DrwxY9CLvow/vlrQ3x/cgMJxzF/kgF2ZbERo29HQGujilNv7vMZMHAcr4+TT7QoyG6iUZz0h8lExmR9SfidsXwB3ynSWkWSu2nGTZWALVajwklA=
Received: from BN8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:60::27)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:13:47 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::1a) by BN8PR12CA0014.outlook.office365.com
 (2603:10b6:408:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:46 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:42 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Add link encoding to timing BW
 calculation parameters
Date: Thu, 13 Jul 2023 01:11:23 +0800
Message-ID: <20230712171137.3398344-20-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 97094ece-6aba-453e-0700-08db82fb5a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdUo7QUROvpY3lQThnr85fCgQSryphwOr7w0x3P6k37+fvBtLvU2qyONFVjLC5FspQynQ5QhVEjs7vLaIfMOTx1QW8MBTgivky3B+UalbOjl6SjbJgr/OUd/ls6VovxVgxILvjZrT9OoMbCb4kjzV8Cr4Ka0GKgnDmQ1gaWiP95Ufwdh9PyU9yFKydKkUzaxYOy0jS6XP2WvTIvApe4eR76Sh1lT2L1GnUIXmn0r7pq904Pn9p/csDJl6WmuSjqGOUyaJR2SbG1K0CBjsukkeS8w5EjaTpOpXmaa++gQSnfVEmvoG/KfKAH+WXbx8aSJURvMwFV17Fivg1wRrgg+LQiA3a1G5QYYhPG4ufewmqgmnYcozIpXQjHydbccgBbiSVXrrsrcV6UZkEjz0AchIHjpwZX3cVeDrk8pAveamlpT2TXAYUgKa0OpATSXg8lHCVdSO3aDB+/GNngxcvLtnbcm5Hf8pKPoWzRQf4fJnJdjrmkQz/QKHbt3w1fPcSlZwnvYBUXrQQrlbA4uA9P4E9hPWH9tTI63fzfEjFIdecVv9lDTH9dZI7qPhZjMRjs0mHrQ7CaVTi+DQ1NxYQHKuwf5X+liYGFOiWWM09cYtsWl806Y0o1XtxcF6p/cSXxwwSlS9dcFUpqYoQstxHBMVPmD/oOhEwpNvFwio3/Q3FCrjEVbLeuLMcVmNLa8BEmB8FipS5uoeaqAVbRySw/vJkMzz2p+gTdcJNLdmFggr/08KvwRpOvO0KqqdCuUTqhFb3bKeDHl1gIC4YUwcPEcrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(6666004)(36860700001)(47076005)(186003)(1076003)(26005)(426003)(83380400001)(336012)(36756003)(82310400005)(2616005)(86362001)(81166007)(356005)(82740400003)(40480700001)(4326008)(70586007)(70206006)(6916009)(30864003)(2906002)(41300700001)(316002)(8676002)(8936002)(54906003)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:47.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97094ece-6aba-453e-0700-08db82fb5a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
There certain cases where the timing BW is dependent on the type of link
encoding in use. Thus to calculate the correct BW required for a given
timing, the link encoding should be added as a parameter.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 14 +++++++----
 .../drm/amd/display/dc/core/dc_link_exports.c | 18 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 10 +++++++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 24 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 11 +++++++--
 .../drm/amd/display/dc/link/link_validation.c |  8 ++++---
 .../dc/link/protocols/link_dp_capability.c    |  5 ++--
 .../dc/link/protocols/link_dp_training.c      |  9 ++++++-
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 12 files changed, 101 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6372347edd3f..88057641972d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5797,6 +5797,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 				edp_min_bpp_x16, edp_max_bpp_x16,
 				dsc_caps,
 				&stream->timing,
+				dc_link_get_highest_encoding_format(aconnector->dc_link),
 				&bw_range)) {
 
 		if (bw_range.max_kbps < link_bw_in_kbps) {
@@ -5805,6 +5806,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 					&dsc_options,
 					0,
 					&stream->timing,
+					dc_link_get_highest_encoding_format(aconnector->dc_link),
 					&dsc_cfg)) {
 				stream->timing.dsc_cfg = dsc_cfg;
 				stream->timing.flags.DSC = 1;
@@ -5819,6 +5821,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 				&dsc_options,
 				link_bw_in_kbps,
 				&stream->timing,
+				dc_link_get_highest_encoding_format(aconnector->dc_link),
 				&dsc_cfg)) {
 		stream->timing.dsc_cfg = dsc_cfg;
 		stream->timing.flags.DSC = 1;
@@ -5862,12 +5865,14 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						&dsc_options,
 						link_bandwidth_kbps,
 						&stream->timing,
+						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 				stream->timing.flags.DSC = 1;
 				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
 			}
 		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
-			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
+					dc_link_get_highest_encoding_format(aconnector->dc_link));
 			max_supported_bw_in_kbps = link_bandwidth_kbps;
 			dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
 
@@ -5879,6 +5884,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						&dsc_options,
 						dsc_max_supported_bw_in_kbps,
 						&stream->timing,
+						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 					stream->timing.flags.DSC = 1;
 					DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from DP-HDMI PCON\n",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1d343f16e5b8..1abdec14344e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -828,6 +828,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 					&dsc_options,
 					0,
 					params[i].timing,
+					dc_link_get_highest_encoding_format(params[i].aconnector->dc_link),
 					&params[i].timing->dsc_cfg)) {
 			params[i].timing->flags.DSC = 1;
 
@@ -878,7 +879,9 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
 			&dsc_options,
-			(int) kbps, param.timing, &dsc_config);
+			(int) kbps, param.timing,
+			dc_link_get_highest_encoding_format(param.aconnector->dc_link),
+			&dsc_config);
 
 	return dsc_config.bits_per_pixel;
 }
@@ -1116,8 +1119,11 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 				dsc_policy.min_target_bpp * 16,
 				dsc_policy.max_target_bpp * 16,
 				&stream->sink->dsc_caps.dsc_dec_caps,
-				&stream->timing, &params[count].bw_range))
-			params[count].bw_range.stream_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+				&stream->timing,
+				dc_link_get_highest_encoding_format(dc_link),
+				&params[count].bw_range))
+			params[count].bw_range.stream_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
+					dc_link_get_highest_encoding_format(dc_link));
 
 		count++;
 	}
@@ -1577,7 +1583,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 				       dsc_policy.min_target_bpp * 16,
 				       dsc_policy.max_target_bpp * 16,
 				       &stream->sink->dsc_caps.dsc_dec_caps,
-				       &stream->timing, bw_range);
+				       &stream->timing, dc_link_get_highest_encoding_format(stream->link), bw_range);
 
 	return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 18e098568cb4..0d19d4cd1916 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -314,6 +314,24 @@ const struct dc_link_settings *dc_link_get_link_cap(const struct dc_link *link)
 	return link->dc->link_srv->dp_get_verified_link_cap(link);
 }
 
+enum dc_link_encoding_format dc_link_get_highest_encoding_format(const struct dc_link *link)
+{
+	if (dc_is_dp_signal(link->connector_signal)) {
+		if (link->dpcd_caps.dongle_type >= DISPLAY_DONGLE_DP_DVI_DONGLE &&
+				link->dpcd_caps.dongle_type <= DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE)
+			return DC_LINK_ENCODING_HDMI_TMDS;
+		else if (link->dc->link_srv->dp_get_encoding_format(&link->verified_link_cap) ==
+				DP_8b_10b_ENCODING)
+			return DC_LINK_ENCODING_DP_8b_10b;
+		else if (link->dc->link_srv->dp_get_encoding_format(&link->verified_link_cap) ==
+				DP_128b_132b_ENCODING)
+			return DC_LINK_ENCODING_DP_128b_132b;
+	} else if (dc_is_hdmi_signal(link->connector_signal)) {
+	}
+
+	return DC_LINK_ENCODING_UNSPECIFIED;
+}
+
 bool dc_link_is_dp_sink_present(struct dc_link *link)
 {
 	return link->dc->link_srv->dp_is_sink_present(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7aa7085c3bec..b0f53ef8c848 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1415,7 +1415,9 @@ void dc_set_disable_128b_132b_stream_overhead(bool disable);
 /* The function returns minimum bandwidth required to drive a given timing
  * return - minimum required timing bandwidth in kbps.
  */
-uint32_t dc_bandwidth_in_kbps_from_timing(const struct dc_crtc_timing *timing);
+uint32_t dc_bandwidth_in_kbps_from_timing(
+		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding);
 
 /* Link Interfaces */
 /*
@@ -1852,6 +1854,14 @@ enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(
  */
 const struct dc_link_settings *dc_link_get_link_cap(const struct dc_link *link);
 
+/* Get the highest encoding format that the link supports; highest meaning the
+ * encoding format which supports the maximum bandwidth.
+ *
+ * @link - a link with DP RX connection
+ * return - highest encoding format link supports.
+ */
+enum dc_link_encoding_format dc_link_get_highest_encoding_format(const struct dc_link *link);
+
 /* Check if a RX (ex. DP sink, MST hub, passive or active dongle) is connected
  * to a link with dp connector signal type.
  * @link - a link with dp connector signal type
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 9491b76d61f5..fe3078b8789e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -73,6 +73,7 @@ bool dc_dsc_compute_bandwidth_range(
 		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_bw_range *range);
 
 bool dc_dsc_compute_config(
@@ -81,6 +82,7 @@ bool dc_dsc_compute_config(
 		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_config *dsc_cfg);
 
 uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0564f55aa595..e6299e99335f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -878,7 +878,7 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_overall_throughput_0_mps; /* In MPs */
 	uint32_t branch_overall_throughput_1_mps; /* In MPs */
 	uint32_t branch_max_line_width;
-	bool is_dp;
+	bool is_dp; /* Decoded format */
 };
 
 struct dc_golden_table {
@@ -901,6 +901,14 @@ enum dc_gpu_mem_alloc_type {
 	DC_MEM_ALLOC_TYPE_AGP
 };
 
+enum dc_link_encoding_format {
+	DC_LINK_ENCODING_UNSPECIFIED = 0,
+	DC_LINK_ENCODING_DP_8b_10b,
+	DC_LINK_ENCODING_DP_128b_132b,
+	DC_LINK_ENCODING_HDMI_TMDS,
+	DC_LINK_ENCODING_HDMI_FRL
+};
+
 enum dc_psr_version {
 	DC_PSR_VERSION_1			= 0,
 	DC_PSR_VERSION_SU_1			= 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index aed0d3dafa24..3966845c7694 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -85,7 +85,8 @@ static uint32_t apply_128b_132b_stream_overhead(
 }
 
 uint32_t dc_bandwidth_in_kbps_from_timing(
-	const struct dc_crtc_timing *timing)
+	const struct dc_crtc_timing *timing,
+	const enum dc_link_encoding_format link_encoding)
 {
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
@@ -133,6 +134,9 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 			kbps = kbps * 2 / 3;
 	}
 
+	if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
+		kbps = apply_128b_132b_stream_overhead(timing, kbps);
+
 	return kbps;
 }
 
@@ -144,6 +148,7 @@ static bool decide_dsc_bandwidth_range(
 		const uint32_t num_slices_h,
 		const struct dsc_enc_caps *dsc_caps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_bw_range *range);
 
 static uint32_t compute_bpp_x16_from_target_bandwidth(
@@ -170,6 +175,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		const struct dc_dsc_config_options *options,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_config *dsc_cfg);
 
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
@@ -435,6 +441,7 @@ bool dc_dsc_compute_bandwidth_range(
 		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_bw_range *range)
 {
 	bool is_dsc_possible = false;
@@ -454,11 +461,11 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				&options, &config);
+				&options, link_encoding, &config);
 
 	if (is_dsc_possible)
 		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
-				config.num_slices_h, &dsc_common_caps, timing, range);
+				config.num_slices_h, &dsc_common_caps, timing, link_encoding, range);
 
 	return is_dsc_possible;
 }
@@ -594,6 +601,7 @@ static bool decide_dsc_bandwidth_range(
 		const uint32_t num_slices_h,
 		const struct dsc_enc_caps *dsc_caps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_bw_range *range)
 {
 	uint32_t preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
@@ -623,7 +631,7 @@ static bool decide_dsc_bandwidth_range(
 	/* populate output structure */
 	if (range->max_target_bpp_x16 >= range->min_target_bpp_x16 && range->min_target_bpp_x16 > 0) {
 		/* native stream bandwidth */
-		range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
+		range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing, link_encoding);
 
 		/* max dsc target bpp */
 		range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
@@ -649,6 +657,7 @@ static bool decide_dsc_target_bpp_x16(
 		const int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		const int num_slices_h,
+		const enum dc_link_encoding_format link_encoding,
 		int *target_bpp_x16)
 {
 	struct dc_dsc_bw_range range;
@@ -656,7 +665,7 @@ static bool decide_dsc_target_bpp_x16(
 	*target_bpp_x16 = 0;
 
 	if (decide_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
-			num_slices_h, dsc_common_caps, timing, &range)) {
+			num_slices_h, dsc_common_caps, timing, link_encoding, &range)) {
 		if (target_bandwidth_kbps >= range.stream_kbps) {
 			if (policy->enable_dsc_when_not_needed)
 				/* enable max bpp even dsc is not needed */
@@ -833,6 +842,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		const struct dc_dsc_config_options *options,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -1032,6 +1042,7 @@ static bool setup_dsc_config(
 				target_bandwidth_kbps,
 				timing,
 				num_slices_h,
+				link_encoding,
 				&target_bpp);
 		dsc_cfg->bits_per_pixel = target_bpp;
 	}
@@ -1060,6 +1071,7 @@ bool dc_dsc_compute_config(
 		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
+		const enum dc_link_encoding_format link_encoding,
 		struct dc_dsc_config *dsc_cfg)
 {
 	bool is_dsc_possible = false;
@@ -1069,7 +1081,7 @@ bool dc_dsc_compute_config(
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 		&dsc_enc_caps,
 		target_bandwidth_kbps,
-		timing, options, dsc_cfg);
+		timing, options, link_encoding, dsc_cfg);
 	return is_dsc_possible;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d8fcff0e5319..b3cfa3dc5f98 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1079,8 +1079,14 @@ static struct fixed31_32 get_pbn_from_bw_in_kbps(uint64_t kbps)
 static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
 {
 	uint64_t kbps;
+	enum dc_link_encoding_format link_encoding;
 
-	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
+	if (dp_is_128b_132b_signal(pipe_ctx))
+		link_encoding = DC_LINK_ENCODING_DP_128b_132b;
+	else
+		link_encoding = DC_LINK_ENCODING_DP_8b_10b;
+
+	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing, link_encoding);
 	return get_pbn_from_bw_in_kbps(kbps);
 }
 
@@ -1538,7 +1544,8 @@ struct fixed31_32 link_calculate_sst_avg_time_slots_per_mtp(
 			dc_fixpt_div_int(link_bw_effective, MAX_MTP_SLOT_COUNT);
 	struct fixed31_32 timing_bw =
 			dc_fixpt_from_int(
-					dc_bandwidth_in_kbps_from_timing(&stream->timing));
+					dc_bandwidth_in_kbps_from_timing(&stream->timing,
+							dc_link_get_highest_encoding_format(link)));
 	struct fixed31_32 avg_time_slots_per_mtp =
 			dc_fixpt_div(timing_bw, timeslot_bw_effective);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index e8b2fc4002a5..b45fda96eaf6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -130,7 +130,8 @@ static bool dp_active_dongle_validate_timing(
 				/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
 				outputTiming.flags.DSC = 0;
 #endif
-			if (dc_bandwidth_in_kbps_from_timing(&outputTiming) > dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
+			if (dc_bandwidth_in_kbps_from_timing(&outputTiming, DC_LINK_ENCODING_HDMI_FRL) >
+					dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
 				return false;
 		} else { // DP to HDMI TMDS converter
 			if (get_tmds_output_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
@@ -285,7 +286,7 @@ static bool dp_validate_mode_timing(
 		link_setting = &link->verified_link_cap;
 	*/
 
-	req_bw = dc_bandwidth_in_kbps_from_timing(timing);
+	req_bw = dc_bandwidth_in_kbps_from_timing(timing, dc_link_get_highest_encoding_format(link));
 	max_bw = dp_link_bandwidth_kbps(link, link_setting);
 
 	if (req_bw <= max_bw) {
@@ -357,7 +358,8 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 	for (uint8_t i = 0; i < num_streams; ++i) {
 
 		link[i] = stream[i].link;
-		bw_needed[i] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing);
+		bw_needed[i] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing,
+				dc_link_get_highest_encoding_format(link[i]));
 	}
 
 	ret = dpia_validate_usb4_bw(link, bw_needed, num_streams);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 3a5e80b57711..08a1961e00a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -906,7 +906,7 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting)
 {
 	struct dc_link *link = stream->link;
-	uint32_t req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+	uint32_t req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing, dc_link_get_highest_encoding_format(link));
 
 	memset(link_setting, 0, sizeof(*link_setting));
 
@@ -939,7 +939,8 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 
 				tmp_link_setting.link_rate = LINK_RATE_UNKNOWN;
 				tmp_timing.flags.DSC = 0;
-				orig_req_bw = dc_bandwidth_in_kbps_from_timing(&tmp_timing);
+				orig_req_bw = dc_bandwidth_in_kbps_from_timing(&tmp_timing,
+						dc_link_get_highest_encoding_format(link));
 				edp_decide_link_settings(link, &tmp_link_setting, orig_req_bw);
 				max_link_rate = tmp_link_setting.link_rate;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index e011df4bdaf2..90339c2dfd84 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1699,13 +1699,20 @@ bool perform_link_training_with_retries(
 		} else if (do_fallback) { /* Try training at lower link bandwidth if doing fallback. */
 			uint32_t req_bw;
 			uint32_t link_bw;
+			enum dc_link_encoding_format link_encoding = DC_LINK_ENCODING_UNSPECIFIED;
 
 			decide_fallback_link_setting(link, &max_link_settings,
 					&cur_link_settings, status);
+
+			if (link_dp_get_encoding_format(&cur_link_settings) == DP_8b_10b_ENCODING)
+				link_encoding = DC_LINK_ENCODING_DP_8b_10b;
+			else if (link_dp_get_encoding_format(&cur_link_settings) == DP_128b_132b_ENCODING)
+				link_encoding = DC_LINK_ENCODING_DP_128b_132b;
+
 			/* Flag if reduced link bandwidth no longer meets stream requirements or fallen back to
 			 * minimum link bandwidth.
 			 */
-			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing, link_encoding);
 			link_bw = dp_link_bandwidth_kbps(link, &cur_link_settings);
 			is_link_bw_low = (req_bw > link_bw);
 			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 2039a345f23a..78368b1204b8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -309,7 +309,7 @@ bool edp_is_ilr_optimization_required(struct dc_link *link,
 	core_link_read_dpcd(link, DP_LANE_COUNT_SET,
 				&lane_count_set.raw, sizeof(lane_count_set));
 
-	req_bw = dc_bandwidth_in_kbps_from_timing(crtc_timing);
+	req_bw = dc_bandwidth_in_kbps_from_timing(crtc_timing, dc_link_get_highest_encoding_format(link));
 
 	if (!crtc_timing->flags.DSC)
 		edp_decide_link_settings(link, &link_setting, req_bw);
-- 
2.34.1

