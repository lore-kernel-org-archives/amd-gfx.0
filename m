Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC46EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED23210E549;
	Thu, 15 Jun 2023 20:40:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8572310E544
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOHf2K8h9PG0FeIZMfiGhDEnE7b1llj1bKapw4cwfpH616ULqH7SZiPLAM57yFCcgNqllNT3AhACHQHsnyCYy/oUn/aVjP6NfNr/kCknbGe1daFRiFckTBNYNpTOi/yzJg5tow/s7WDJox9xu9Fl3p0p0HhITZB3owA/Zgz3groc30/avCoSuigxtlpkDFQg/K0xfsnCnyKj58ZsJ/pTDo9Zn1qhvz2yBcuRdJ7NkplfRNEuxd0v9E/FimJgAcvsDgJhRSWsrwrbu0YDOBKTfa6ebvozCGlrmckxUeBgb8OevQZTXeMWa9Xc82bBCGerJcGB6jNa+hLpkfIIJpI+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2yMd8uPLLUa7G1TJ45dKzie3b4+f53gEpEdgAprefk=;
 b=h4zi1p0T7ipqPdVZ6hDeLCg3oCKmJ648ilXu0cWEpvWTaAWP7U1fDNwaqUNz7TTYRB0YOzkXYIP3r7IiPPq/D94xc0WllWGQYd6BgPCZm+hHBkzjNnEtEvZfUpuRsYJROKQ8I1RXWfPTwepsklnOAogfn4oN8CdBF/AcrQZBH4sv7OBix9HrmowbO+yrDctAg8mJm/eakBfgXnvW8RI8NiXVXONOKF/qvykgNqzp3rxNczmYIkfHkZ7fdcm4EzBxcUy7zrR8rWBcPhb9bBNIVdi4U6B0PRf9PjaUK/tH5T1t/pGSqEdqo8nfSzOJXAkrBYp8KdJUTLVDFmNm+8YwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2yMd8uPLLUa7G1TJ45dKzie3b4+f53gEpEdgAprefk=;
 b=EY6xVz9dHaO+fr/DH8EE+Zqd5zjGmdNN5eoMPVRS13h5r7KVv4BuB9g8/TiEbSKln5DT+G089a2qStQ3BCgjtV5+8CICmjeX3qVa+9t5SOL5Z+f94mU5cLwJoSOmt8ICnHwaE9M/sdJoAbNosvyhCNFbYiDYxrqxyd8Z8GPULQY=
Received: from BY5PR17CA0057.namprd17.prod.outlook.com (2603:10b6:a03:167::34)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 20:39:56 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::79) by BY5PR17CA0057.outlook.office365.com
 (2603:10b6:a03:167::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Thu, 15 Jun 2023 20:39:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 13:39:54 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:53 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Get replay info from VSDB
Date: Thu, 15 Jun 2023 16:39:30 -0400
Message-ID: <20230615203930.1715722-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a3cd49-7714-4d79-d6f8-08db6de0ae23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ae4waZzq0+3tLVcx6y3lzYAKKgWLwboIt1EbUFmC9wTOfFikmk0i4PB1X/DEfCjGE6tb6kBMr3QCRP1ROMQZzuLKEFo5rbvbRdK2kLjxhV/j2GMXDjBJqq2mU3fsfK8u/udIg/gkuV+nuE/gtQlxR3En7weCUzPUMcD3+bPoXUiXSQCCCrT1PujrqjAGPKorg6poDa1URlBPXMtGRliOAls8qk+V6z+FB9tLGVY1gGQdEnvMWY9aiWQ9IrnM1UQ22c3I5FYBLCSw9h+UQLf0YEiGYrvywFPN10UavpDZ0OgkefcmJFouPuPsR1lht2oymPx4qnjBcUXXJ4TyXP42rTZQC1WfX4+TPfwBdzPGcEtwAj3kGKgyav5l9IRYs30UYsCR1X7x4TFPiypp7ymMDwYPR2wJ6vYSJ2wfu0WnQzCBrbrFeEU9E6iLUpVUZxeC5BryI3MBUlwVnybcQiAAL37OALg6pMnMQgtR5kiXGInSFsCpuYurA/BbZaAGh5B8WdFvAGc/q9Mu060tVU1//8bjKdbirGr6o4VTLqrxeHruOpu4X7+KhmxyyiSxTlWDmQvrc79p8gM29NEbJUs6BERhl9dacw1S2AWXMY0IhNsWWseRj4AVWF7WDMCkcypmNItrc7GiXx1mtJulIW7U/b4jot43A1kUukBnhZ/8e1zx6djzpmGRt/JFxmkAoE1/EfNpKUs7uSXkH7kFHskYpuu6fpZC6YexR/wndZaqIyeA//qaKlIPOrq1TT7XK4WPBCJ1G13EQQsqR9Ds8LuECw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(5660300002)(81166007)(47076005)(110136005)(82740400003)(356005)(478600001)(8936002)(41300700001)(8676002)(4326008)(316002)(70206006)(6636002)(70586007)(2616005)(336012)(186003)(36860700001)(6666004)(426003)(7696005)(83380400001)(26005)(1076003)(82310400005)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:56.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a3cd49-7714-4d79-d6f8-08db6de0ae23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 11 +++---
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a6551c049cc1..d74d5ba39d92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10546,6 +10546,41 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
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
@@ -10681,6 +10716,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 			}
 		}
+		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
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
index 7690ab6125a1..f82575e09848 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -46,11 +46,8 @@ static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connecto
 	if (!state->freesync_capable)
 		return false;
 
-	//TODO VSDB replay check
-	/* i = parse_amd_vsdb(aconnector, edid, &vsdb_info); */
-
-	/* if(!vsdb_info.replay_mode) */
-	/* 	return false; */
+	if (!aconnector->vsdb_info.replay_mode)
+		return false;
 
 	// Check the eDP version
 	if (dpcd_caps->edp_rev < EDP_REVISION_13)
@@ -77,6 +74,10 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
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

