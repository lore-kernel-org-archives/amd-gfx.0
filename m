Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D689EEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B427F10E2C9;
	Mon, 10 Jul 2023 19:27:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF81210E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph4yIetEArW385YjOTiZSIoL5u5ITWXG4kgpSTVEa6tG7sGjxR/02+TGbq370Z1WqR/ucxKg90stFwpHGbCVryjex2RSwl4wDzbBThGhFRacqudV/da9ba93agKjdNqMg6Cmli1o921RiD8AU9g5+3uhGdgdCNkjoePNSTIhvUxy1hSSUFrY6Ix6Q0Ai81fJiSb9RIk5cdWhSWxyyT2/BdwM5ApsEKpIcemBsHbIIeYdPgTU9MEsCac2ONIiKR8WDx195kFkBrWEj7UhFONJuIcbdpngtTUk9s/idUXpqWv26K4M1aoU4VOv/OfTxu3H0dZPVA0EN9UgLcxJ0JU8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUuxinQpq2WIwqANSHzlVJXmb6MV3mvwGf1bEjmHJYA=;
 b=njI2/asLbSKts2dpSO2Fb23glo4dc6P3HmB0yM4KkU6b2Ji07LWMBq6i7Ytp+je/HMnk6PM0gF/BJ5vnyLtNPYLjl6glrrEiI2TKzyac77pXrnLKKfJC9TS99SYiw+x/s9qpDL3OMVJjce3pSwZJ/1bzRrs/57ZusfJqW2ceRenl+XJflI9FVftGpycF4Ac7uw8bwBwbYGVkHryg3g9dxv62SjUAiVmEIkSE/t5SnzyJ4mdRZXHM77GH/y+wEaLxxno6Uv7Amy23NDIZyydrCGYVOmaSKCyvbXTV4CH704gqfJXhb933pNpg3UrHix3vJV7xhB1/5uBRcElPYU8nIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUuxinQpq2WIwqANSHzlVJXmb6MV3mvwGf1bEjmHJYA=;
 b=l6YkQRCCUyU2KXeKGFuw3HZXq9J6PnS3fnkrVarUZr5/wFwwJHaVODw9lWYDKoecMiKgA6V5z9RlyyVoFVJ5g81zx0Y4gjwlpbfDU9IhXHuAchwktjoBmBDtxIt6zGwPFOVqK/Ae5qLpzfsVXRyEeLlcjimETLcDF/w6YiSPRys=
Received: from BN7PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:20::15)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:39 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::78) by BN7PR02CA0002.outlook.office365.com
 (2603:10b6:408:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:38 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:38 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amd/display: Get replay info from VSDB
Date: Mon, 10 Jul 2023 15:27:28 -0400
Message-ID: <20230710192733.1344403-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9d8e6f-054d-4312-036f-08db817bb956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z052foavyid4XPq3M/+LhjlysypHynfOm7jNvBfyFoHuxANVw4tDvFVD/Efmtb7cISS8nsiGRqjMk4Z1BntVghGuYhnziegYPshnGPIm64eTKr4h54ZHoSqApvcrtujzz6K91Z7X/naqLMoWvOAVeakB3RTz5VmeFz4a9pzfeq8xB+90whNdSuQgISstVeDZJzV8lpfTN6a7JAvKp7A/kjf3977oXjJwyfx1osBOyPLF1dq0rCz74AyN5WcCnoM3AhMuKStLSQK5bMcCXfAEWBcERm12rI0SIYjzWES/Kxkfq7m0+iJfuAcPnxvZ0/Rwvhg8sDFHr2xXCheggMlEkMX+SIF8jGStIp8f4Hs/iUDql9i+ZL9kzaxOKxvfoXG/SoSmFDRKB3AE0rdW7iIXg9q3T3dJCIE/rQ1w5LCgru06BXruK3i6rG+T4hF2eZj5MJ1rdClPcMF86QPFWSdFlzvV4ROZgeoVrjBzgUc5QpeRR6TLUo2jBhpWkILxaF+6t2jPYdpu/HMxkrmO124AqBnZhKf4wdEhH2chMo2FGF0uoDC12OEIrR3cmNBxuxiT92/8zK7NfMgumD8IrVS3jkh3lA7coEKN8LYotOuF03kD7j/4iP3mtGM7Ar6D+W3O3cqdKYtiVpC2fGOJnmy6qofVACtkgdRnnjKgnnIYqduYeoFUxT0l+wYJNX+7micOn34CUI1bu6QQwc5zqGozmtWYiUe4jg7xH0and0fwO4d9wPsR/8Bah+jdG/8l+GHJcLWPPiTX7752r4VIEyFHrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(7696005)(6666004)(478600001)(6636002)(110136005)(426003)(83380400001)(336012)(2616005)(40460700003)(47076005)(86362001)(40480700001)(36860700001)(36756003)(2906002)(186003)(82310400005)(26005)(1076003)(81166007)(356005)(82740400003)(316002)(8676002)(70206006)(8936002)(5660300002)(41300700001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:38.9846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9d8e6f-054d-4312-036f-08db817bb956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to make sure that the panel supports replay.

This info is inside the amd vsdb (vendor specific data block). Create a
function to parse the block and read the replay_mode bit.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 44 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  7 +++
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..c574a11a10bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10527,6 +10527,42 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
+static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+{
+	u8 *edid_ext = NULL;
+	int i;
+	int j = 0;
+
+	if (edid == NULL || edid->extensions == 0)
+		return -ENODEV;
+
+	/* Find DisplayID extension */
+	for (i = 0; i < edid->extensions; i++) {
+		edid_ext = (void *)(edid + (i + 1));
+		if (edid_ext[0] == DISPLAYID_EXT)
+			break;
+	}
+
+	while (j < EDID_LENGTH) {
+
+		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
+		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
+
+		if (ieeeId == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID &&
+				amd_vsdb->version == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3) {
+			vsdb_info->replay_mode = (amd_vsdb->feature_caps & AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE) ? true : false;
+			vsdb_info->amd_vsdb_version = HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3;
+			DRM_DEBUG_KMS("Panel supports Replay Mode: %d\n", vsdb_info->replay_mode);
+
+			return true;
+		}
+		j++;
+	}
+
+	return false;
+}
+
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -10662,6 +10698,14 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 			}
 		}
+		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		
+		if(vsdb_info.replay_mode){
+			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
+			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
+			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
+		}
+
 	} else if (edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4561f55afa99..5c9cf6c147d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -51,6 +51,9 @@
 
 #define AMDGPU_DMUB_NOTIFICATION_MAX 5
 
+#define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
+#define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
+#define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3 0x3
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -75,6 +78,12 @@ struct dmub_srv;
 struct dc_plane_state;
 struct dmub_notification;
 
+struct amd_vsdb_block {
+	unsigned char ieee_id[3];
+	unsigned char version;
+	unsigned char feature_caps;
+};
+
 struct common_irq_params {
 	struct amdgpu_device *adev;
 	enum dc_irq_source irq_src;
@@ -604,6 +613,11 @@ struct amdgpu_hdmi_vsdb_info {
 	 * @max_refresh_rate_hz: FreeSync Maximum Refresh Rate in Hz
 	 */
 	unsigned int max_refresh_rate_hz;
+
+	/**
+	 * @replay mode: Replay supported
+	 */
+	bool replay_mode;
 };
 
 struct amdgpu_dm_connector {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index b3e14997b470..32d3086c4cb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -46,6 +46,9 @@ static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connecto
 	if (!state->freesync_capable)
 		return false;
 
+	if (!aconnector->vsdb_info.replay_mode)
+		return false;
+
 	// Check the eDP version
 	if (dpcd_caps->edp_rev < EDP_REVISION_13)
 		return false;
@@ -71,6 +74,10 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	struct replay_config pr_config;
 	union replay_debug_flags *debug_flags = NULL;
 
+	// For eDP, if Replay is supported, return true to skip checks
+	if (link->replay_settings.config.replay_supported)
+		return true;
+
 	if (!dc_is_embedded_signal(link->connector_signal))
 		return false;
 
-- 
2.25.1

