Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E89C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B2410F64A;
	Wed, 24 Jan 2024 07:02:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0777A10F64A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+mSLWVlrUMxH/gp9oVQYb95AuaqkarZWljbUvEYwKJXjkM94zrqYowQi0zSqo7/X2M2WzIdrM+AsF4MV7SZeR+v1V1mMdhUz3P7IMr8KgAsvpsI9BJxNgkC2RJ8ecMe0vY9t4szI2JVJzyhPWoKE1LokkJ9rdfttRe2Xzh41ecxLp2Th8yu+kjAvryamEn5RsIiPZUU6N2ZhNZXtPGG04oDOB8xY77/05Ci/wkRG40gtltMCMe9VARcawBB3Txg1F94g9O2UGaq4hUSV+Brc1t5RfayqDYR3H+DPlxmlgZrXGf/BJlymi2QbvNajvrRIQWApNQRIG6chbRWpTK+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lplw5rSBsdnM9v8LkMrhemY4I0RjYXHcP3TOHGAvAfE=;
 b=FA9F97B5aaWerTr9fP1TLBLkN7MMyrgcWpmp3Frgp7u6YhQx0ur4JDMxI1DDiLrQyVMkyJ0Rf8Ig1fH9wHjkUyr4ynZyU1m98djsPmXU/XYj7sXccNWtVc/qF5Xwpj/UkcLV1kCK9eAE5fz8b2FsKifO2VMSB5gVca1vUL5qIALVb69TgfnxVaW9IBr67NjIzvPFqfbYEcPhRr+eXnRUGvfBfDy8GrlK1xaztcAoGgNzqg5QC2/B9Zk8eLNq+8Nn8JFD/Jv1ssf/43+wqlXaL3hsUlqZOGdS4hXpWiww6JsQ+/OXoUolE8dJeZb6npXANRTHEHGI3epEvO/+yNzgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lplw5rSBsdnM9v8LkMrhemY4I0RjYXHcP3TOHGAvAfE=;
 b=y62CgZABKXi+OYaC1Vf31zdGP+84I8vJgCs3lWAIX8O85K6CwGO/8PhMRT/XaGCNTo7fWkcj7bMcqTCYeDPPjAEC114140IRWohVN+q2O7nxTqXSFhwJ8BuftnUOVitp27JNJG071yEBNPbZSg98b1k95qld2XFdanpHfaQrvgI=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 07:02:36 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::e8) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 23 Jan
 2024 23:02:34 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:32 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: add debugfs disallow edp psr
Date: Wed, 24 Jan 2024 15:01:45 +0800
Message-ID: <20240124070159.1900622-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: f05587ef-ce52-4786-a16c-08dc1caa71f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKHk1rVPOwUQKLCDeKCG7ICRh6xLNeAUIE2iOCjgT+3pmPNtOPXeSSRgKrY7A5STCKsC3xK4FhupH0dC5ZpIU7uCkXaWz0v4EfKkfcdj7g+KQzmh0Fz79wSWMAWPtK83nw5um1xB+Q6wHdLXD2ONOzQ/OjPophDO8Hfs2Ul+wf/dCFV3I6bulyra3mAyPLMiL6GHHrqrp8uzl0iAFHiPKVM2vdlip9od8mnkgCUDaVkiEI7EDCiZ4WGFBJPUQ+TUhDzztfUVXEZzUm75cQjjH7W3VOSCyyytd2c2hzj66mP3ZvEAKN/hFiNzt367AdPIIfUjQr8PUnQSvmt2IKOJwkTFo+1aJlW4aNiN8TBe3Xm2n27uOGOS3ooOD0SlqKnWz6fchKhJt1TCUVQf5mvQmUz88za8u8WkiY0Hd8FDwtYfhvD9BEgfc1W+CogVctCoPPjpNT5NnAMiY0iQTXuIetYKuY08MXuN5vvy14K5breVSDMZ9GbCylZzN1cqrpTPduoJq6JWpo2XgufOAqsEOGyqIwteTQ+YoBuCKTAW4jHD3V6Smm8zk7OuPXARyvQOya8noiIA9GYdWVpWwdqY/Cwhpv9BT29yHQeMDcDRhWvtp5zK3M7mjS7bg7c2yW4+myJ5pM7Ya2T+iThQfjhvZbfoYy5z+yA7BiG/tOqRaKsnZvktO7+7eHJaY8XgTMFb8riZXGCMxjtGWBtNMJF9sGK6J6AYSz0gkkSRcvvzHtFRu1uelIb2eDiMAqpm6XT6EEg3TOu86fC5FqlIcSiyfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(356005)(6666004)(26005)(336012)(1076003)(2616005)(7696005)(426003)(36860700001)(47076005)(83380400001)(2906002)(54906003)(5660300002)(70586007)(8676002)(8936002)(70206006)(316002)(478600001)(4326008)(41300700001)(36756003)(81166007)(82740400003)(86362001)(6916009)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:36.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05587ef-ce52-4786-a16c-08dc1caa71f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
fix reading edp rx crc timeout failure. after
bootup, kernel setup psr with dpcd 0x170 = 5. this
notify rx psr enable and let rx fw start checking crc
for fw internal logic. rx fw may not update crc read
count within dpcd 0x246. read count is always 0. this
will lead tx crc reading timeout.

[How]
add debugfs to let test app to disbable rx crc
checking for rx internal logic. then test app can read
rx crc dpcd 0x246 successfully.
expected app sequence is as below:
1. disable eDP PHY and notify eDP rx with dpcd 0x600 = 2.
2. echo 0x1 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr
3. enable eDP PHY and notify eDP rx with dpcd 0x600 = 1 but
   without dpcd 0x170 = 5.
4. read crc from rx dpcd 0x270, 0x246, etc.
5. echo 0x0 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr.
   this will let eDP back to normal with psr setup dpcd 0x170 = 5.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  7 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 53 +++++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 41994a60e2cd..a17b2edee269 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8568,7 +8568,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
 			} else if (acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
 					!acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
-				amdgpu_dm_link_setup_psr(acrtc_state->stream);
+
+				struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
+					acrtc_state->stream->dm_stream_context;
+
+				if (!aconn->disallow_edp_enter_psr)
+					amdgpu_dm_link_setup_psr(acrtc_state->stream);
 			}
 		}
 
@@ -8597,6 +8602,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
 			    !acrtc_state->stream->link->psr_settings.psr_allow_active &&
+			    !aconn->disallow_edp_enter_psr &&
 			    (timestamp_ns -
 			    acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns) >
 			    500000000)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9c1871b866cc..09519b7abf67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -693,6 +693,7 @@ struct amdgpu_dm_connector {
 	struct drm_display_mode freesync_vid_base;
 
 	int psr_skip_count;
+	bool disallow_edp_enter_psr;
 
 	/* Record progress status of mst*/
 	uint8_t mst_status;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index c5078e6e1a3c..e23a0a276e33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -142,7 +142,12 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 			amdgpu_dm_psr_disable(vblank_work->stream);
 	} else if (link->psr_settings.psr_feature_enabled &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
-		amdgpu_dm_psr_enable(vblank_work->stream);
+
+		struct amdgpu_dm_connector *aconn =
+			(struct amdgpu_dm_connector *) vblank_work->stream->dm_stream_context;
+
+		if (!aconn->disallow_edp_enter_psr)
+			amdgpu_dm_psr_enable(vblank_work->stream);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 68a846323912..f77ee5eb7f56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2971,6 +2971,53 @@ static int allow_edp_hotplug_detection_set(void *data, u64 val)
 	return 0;
 }
 
+/* check if kernel disallow eDP enter psr state
+ * cat /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr
+ * 0: allow edp enter psr; 1: disallow
+ */
+static int disallow_edp_enter_psr_get(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+
+	*val = (u64) aconnector->disallow_edp_enter_psr;
+	return 0;
+}
+
+/* set kernel disallow eDP enter psr state
+ * echo 0x0 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr
+ * 0: allow edp enter psr; 1: disallow
+ *
+ * usage: test app read crc from PSR eDP rx.
+ *
+ * during kernel boot up, kernel write dpcd 0x170 = 5.
+ * this notify eDP rx psr enable and let rx check crc.
+ * rx fw will start checking crc for rx internal logic.
+ * crc read count within dpcd 0x246 is not updated and
+ * value is 0. when eDP tx driver wants to read rx crc
+ * from dpcd 0x246, 0x270, read count 0 lead tx driver
+ * timeout.
+ *
+ * to avoid this, we add this debugfs to let test app to disbable
+ * rx crc checking for rx internal logic. then test app can read
+ * non-zero crc read count.
+ *
+ * expected app sequence is as below:
+ * 1. disable eDP PHY and notify eDP rx with dpcd 0x600 = 2.
+ * 2. echo 0x1 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr
+ * 3. enable eDP PHY and notify eDP rx with dpcd 0x600 = 1 but
+ *    without dpcd 0x170 = 5.
+ * 4. read crc from rx dpcd 0x270, 0x246, etc.
+ * 5. echo 0x0 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_psr.
+ *    this will let eDP back to normal with psr setup dpcd 0x170 = 5.
+ */
+static int disallow_edp_enter_psr_set(void *data, u64 val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+
+	aconnector->disallow_edp_enter_psr = val ? true : false;
+	return 0;
+}
+
 static int dmub_trace_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
@@ -3092,6 +3139,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(allow_edp_hotplug_detection_fops,
 			allow_edp_hotplug_detection_get,
 			allow_edp_hotplug_detection_set, "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_psr_fops,
+			disallow_edp_enter_psr_get,
+			disallow_edp_enter_psr_set, "%llu\n");
+
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
 
@@ -3265,6 +3316,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					&edp_ilr_debugfs_fops);
 		debugfs_create_file("allow_edp_hotplug_detection", 0644, dir, connector,
 					&allow_edp_hotplug_detection_fops);
+		debugfs_create_file("disallow_edp_enter_psr", 0644, dir, connector,
+					&disallow_edp_enter_psr_fops);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
-- 
2.34.1

