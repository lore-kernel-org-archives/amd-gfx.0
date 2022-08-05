Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D706C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A610218B1A0;
	Fri,  5 Aug 2022 18:00:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96046B9344
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDEUfC0g01tapbpY+HrkPVcw8Y91YNZkd5Kue1VkzEvlyfJPtHICJoamdG5GqAZJkshFX1bI6k5rGQEvEODvkJVOT0w66S2XaPlWM1+iC4EP+MKxvuMGV+jtGKBk5KM17gOVoJHr3JlyMP6GGnRG8QIhzPylXwhfmim5BIT2IKiJKXiVNtmrftAQBDjlBPmilqqK/SMgciUeFn47zSzl1dQqpce7AIrpO7AKESdmDDXU7GT2kp5aTyBPsYvT6BtithNDBI55L68CDnQLfgNMOQHWKiwniqvtbypOMVLdCpDwKtBNBIRAKF4RDY1NUJPydPwDXXdFgaEuEpywVfF6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrZZ+8pnolJikF3CtfTtiUuB7yRmFv/VZGncOd1kRKc=;
 b=WzyaXRjdKmNFLZfFsU/qXenB0Cj745wa8XPVnxVNd5+o0wioWvTjZKGBFmCwfME5NSWN/dztVCQdXgCKf8jUWDTZGeo9iVgrjs3uvBZXOSNxPTOggir0YMeesWpQt5NoKbG/Gtr7v6oaPQC0R2h5aiJOakIQhmosGOEdtBNgoGsFRhTc0CjCv+1xxOKI63ZF+JSQgRzufnl+QEagD3kHyH4YJP1GLR1L+OUbiw73kOjR4jjm/P3xc6YDakt7O5Lo5P0UT6WF7MUIhetd7SXHhrhgVidKRyR6Hy45ar+GfTFSgMQpmoksUmXN5pliFle50dvyiHebNOE/TXR/vPDdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrZZ+8pnolJikF3CtfTtiUuB7yRmFv/VZGncOd1kRKc=;
 b=GEg82BqDlJH4DI+hm6+jj4DLtK3GWz49i8xFoBdTisjK1bAalUgkBb5o9rXe8ddBCNTXVR7idO4BfyDhRsPl/wGmPdbNI3R9eKlBtFLvvvCL42YbEQR8mHWeGKABsyyDrsbw+pXYvxFJAzzGJbQYkJGJ+s3kZtIOQ5wi0qD9t38=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:00:24 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::86) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:21 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/32] drm/amd/display: Add some extra kernel doc to amdgpu_dm
Date: Sat, 6 Aug 2022 01:58:11 +0800
Message-ID: <20220805175826.2992171-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a55a2cd-1c91-46d2-08d6-08da770c5e27
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6242:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bZODq1AH5jlZZiSthDv0r58Fd+1Rk76uoDcrNTWaKPZxJRrRossgIv4KNRekF3RIC3gvRm2t+BcgV3PA7iO7ajScpRnDqF9xLidLrE7C/AEvaRiUjJppA2GIftsvyLQ9jCjoDbEVJGMGHEmsf9IxkmXh4IvC0zXNwxUqQUeUypblSiz8cdCe/X1+HMys+WhdulfW0R7z/FFCMbvAUcMVJIOAgQeqq78fxZ4tBXO5tC54AbrzHouLxIosEC8nEmhr54RPPrlF7eczN2Jsq+0lCuVwf8wazzzx8j8mFZV3YKNSR2FPt45M9lQv99iG+UUfVAhE+m/Em4qKmZ5vKql8SRPoPMnfBnI9OUc+EfrHfXaDxAZPhInnzMZbIQ/i+G6L4y9kZ+sj97Whb6odQauPU8faws94qxP1P3w0Km82feBuRiWNSWeYiy/jOG6yTAkurNXauKBmMk83lngJO72/O3b0KL1/SXgErEmQpKcwK9a1fzdir/WYhpJEr6cbpg1fGMbNsI9leKsyF6yXnopNLKRw0vFUvatWVhPCZbMjG9k4ABKF3LZtBLQyjUKweSEw5i6REpg7JvjNc2lwFia3YUf/lOKJrosLtEK+L1bi6frtbw787Z8bq4KEemlJpBMUepvUO31zAcT55SzLFosnvy1ck8JBNHn/qWxNbQrtoELEfLvINrh0lQ2djEHTwAt2SDKVdBvdI3VYxAF+fqcnSYc8lsLgLWau5e9iHOcqPV9z9feRmm1gLsD8S2lKxtqet1wRQCV/XtOl+w4jW1unCTrk2Kv2mh4W4zqxYaRpZ1h1G7Zh2fyApOZ1LhufnZHgboRk+vu7ZWvtO+YOCiC/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(2616005)(1076003)(40480700001)(5660300002)(426003)(336012)(186003)(47076005)(82310400005)(4326008)(8676002)(478600001)(7696005)(26005)(41300700001)(70586007)(36756003)(63370400001)(70206006)(83380400001)(63350400001)(40460700003)(6666004)(6916009)(86362001)(36860700001)(82740400003)(2906002)(54906003)(316002)(356005)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:22.7557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a55a2cd-1c91-46d2-08d6-08da770c5e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 +++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 46 +++++++++++++++++--
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d54c1486739..ddcb7845f642 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9322,6 +9322,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
+ *
  * @dev: The DRM device
  * @state: The atomic state to commit
  *
@@ -9936,8 +9937,18 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return valid_vsdb_found ? i : -ENODEV;
 }
 
+/**
+ * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
+ *
+ * @aconnector: Connector to query.
+ *
+ * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
+ * track of some of the display information in the internal data struct used by
+ * amdgpu_dm. This function checks which type of connector we need to set the
+ * FreeSync parameters.
+ */
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
-					struct edid *edid)
+				    struct edid *edid)
 {
 	int i = 0;
 	struct detailed_timing *timing;
@@ -9950,8 +9961,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	bool freesync_capable = false;
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	bool freesync_capable = false;
 
 	if (!connector->state) {
 		DRM_ERROR("%s - Connector has no state", __func__);
@@ -9980,7 +9991,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module)
 		goto update;
 
-
 	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
 		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
 		bool edid_check_required = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 90b306a1dd68..b44faaad9b0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -598,6 +598,10 @@ struct amdgpu_dm_connector {
 	 * The 'current' sink is in dc_link->sink. */
 	struct dc_sink *dc_sink;
 	struct dc_link *dc_link;
+
+	/**
+	 * @dc_em_sink: Reference to the emulated (virtual) sink.
+	 */
 	struct dc_sink *dc_em_sink;
 
 	/* DM only */
@@ -610,7 +614,16 @@ struct amdgpu_dm_connector {
 	struct amdgpu_i2c_adapter *i2c;
 
 	/* Monitor range limits */
-	int min_vfreq ;
+	/**
+	 * @min_vfreq: Minimal frequency supported by the display in Hz. This
+	 * value is set to zero when there is no FreeSync support.
+	 */
+	int min_vfreq;
+
+	/**
+	 * @max_vfreq: Maximum frequency supported by the display in Hz. This
+	 * value is set to zero when there is no FreeSync support.
+	 */
 	int max_vfreq ;
 	int pixel_clock_mhz;
 
@@ -705,11 +718,34 @@ struct dm_connector_state {
 	uint64_t pbn;
 };
 
+/**
+ * struct amdgpu_hdmi_vsdb_info - Keep track of the VSDB info
+ *
+ * AMDGPU supports FreeSync over HDMI by using the VSDB section, and this
+ * struct is useful to keep track of the display-specific information about
+ * FreeSync.
+ */
 struct amdgpu_hdmi_vsdb_info {
-	unsigned int amd_vsdb_version;		/* VSDB version, should be used to determine which VSIF to send */
-	bool freesync_supported;		/* FreeSync Supported */
-	unsigned int min_refresh_rate_hz;	/* FreeSync Minimum Refresh Rate in Hz */
-	unsigned int max_refresh_rate_hz;	/* FreeSync Maximum Refresh Rate in Hz */
+	/**
+	 * @amd_vsdb_version: Vendor Specific Data Block Version, should be
+	 * used to determine which Vendor Specific InfoFrame (VSIF) to send.
+	 */
+	unsigned int amd_vsdb_version;
+
+	/**
+	 * @freesync_supported: FreeSync Supported.
+	 */
+	bool freesync_supported;
+
+	/**
+	 * @min_refresh_rate_hz: FreeSync Minimum Refresh Rate in Hz.
+	 */
+	unsigned int min_refresh_rate_hz;
+
+	/**
+	 * @max_refresh_rate_hz: FreeSync Maximum Refresh Rate in Hz
+	 */
+	unsigned int max_refresh_rate_hz;
 };
 
 
-- 
2.25.1

