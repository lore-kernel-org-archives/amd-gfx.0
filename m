Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7228C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B7610E7E1;
	Wed, 13 Aug 2025 23:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTIESmVW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C1C10E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbAbNYLXwNkN6PfYHg+rDj3oiRlGUXyqO3qihcs19119OSwzetGPQY3BBEjaswhLkjAtNXkHYKSfQBGaRSuVNe2mjvHfbu7MGsd1/jia78lyxj3znxa4+WYXlL0EiELdtplNZJyj4dF+d4ZpGa4Mw/KuE+olG8c/z2qBFNqCPC/kWzqhZAZXMNImyeGbhBEDhh1yfp8QMAPi6lrLxwEZMk0YNmNmAfU76ciLQs8YxyL4nDAR8C76wET+YL9X7NsjQA1Rfa/DPFdbYzoXTXaVXBE5OdxdZvnwnTMaQMeJM3UrcR53FuHwEJPOoTvLNLG1c2vbG3wW/7wglRrAJdac/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqLVGus9LRpAy28uwkQ8MW1TSOTzMwuLhihjRFaEnrI=;
 b=Wh7bvIApMrmGY4PkB47yzllooA3feN3lo1hk9/kvKG8uX8Lo7s65hb3fyAUe9EiuFNaowogLN/5DKAF1u1b41oiKSBybCvHmN2aiAQuh6rh0Xprz6nyi0mOHRVqfQAP/Rl4Gj36KmSEf91JPGr2csJo9Hnn//lgsqwMvQ7R/5/0nhu/+q9kGrVO4dkgSxXugxXW4z4BzgdGIHvWUjiFf+ieL0tb7Zwvu+aeyE+cvzrR2NGqsN03mY0rhW8SN2/vSQOMp5s1fIX0tCrrB2yr7WBnjKswXKYgpPNXRSXe5rNVkEhOdouAPStcY+xKNEhbrIyrpebf2kNKidjikKxwMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqLVGus9LRpAy28uwkQ8MW1TSOTzMwuLhihjRFaEnrI=;
 b=nTIESmVWlLRH1050xYCuwA91OHfEIYHKhLVVhTHvw59rUJuCi9KXE5wuBqKkp5Z192QQhlQxQacgym39axSMVfcqXiDM3OtTOcCpc6Gen1gMUoWFwCoHtJZJjiSWtLoylx8bwqra1h5Me9Hbk4KDQUap9I36pjyuGvDv5FHv3ic=
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 23:27:14 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::2) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 23:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:27:14 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:27:13 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 03/11] drm/amd/display: Optimize amdgpu_dm_atomic_commit_tail()
Date: Wed, 13 Aug 2025 17:18:11 -0600
Message-ID: <20250813232532.2661638-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3399206e-ba0c-40ee-792c-08dddac0efe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3YvZ/zvbyggbWZqaDoKfNsLzemnXxYFajbsYjQKzdgEdbCY9bnbCOKOTs4Kb?=
 =?us-ascii?Q?PLRbiZZe61reSiTtjLdmRaH541+NmiiAsz8O+n01mJ35U/I2BixG5ZrW8j21?=
 =?us-ascii?Q?t17Wc6dh+bNoGELao1R4N97ZkPWPTZ8iaQ02mXOL1/BbGVUabpDt3ToeZfV0?=
 =?us-ascii?Q?u8EHT/SHVS8zUlW/8Ue3k8P0zjs0CdJNtItCg5neGIHeW3Nj5OH9to+1LCQk?=
 =?us-ascii?Q?2qonW9BMFtJgAskCTBCiPoTXUSx+bPAtp7tqvtAEOSl0lHpTEU817Sv3Aam/?=
 =?us-ascii?Q?5oSBwBWq3krX8Syp8kOAn6CEhmxl7SGSTGRHVW1KMdBupZWe8dkVA+Z5LZ8c?=
 =?us-ascii?Q?IBOwhM+lmnvSAqmgB81J48JaxUatewe8Ly9fz8YZVcm/olfS505hNvMMNloq?=
 =?us-ascii?Q?EPYAm67LVV7gnhCrA7euTNpXcf7nzr7O3vd4QdokNjlaSUNfTXs9XfI0bHI+?=
 =?us-ascii?Q?ymyKiGDNijo7HPQYqM+zKVWOLY7gREY6br9Y67T+WiHzEFoDEszB/rLRgSza?=
 =?us-ascii?Q?f7H6KUMDtX8Plwrp643jMQPymBPIt8B7wjEZWIbJ3rktiTC6IbnotS4d+F2M?=
 =?us-ascii?Q?Tk/AMSECsxsHxzYbgF0ufrmmA108IwDgIBnjR8e7qhOOOBa0WSOVd8Kjyz6W?=
 =?us-ascii?Q?76he7WnIWDxdwUpOLcfffptIKiMHjvThPHGWCw1AfWCBkeXuxCkRsFkCCi+l?=
 =?us-ascii?Q?BIbikhgIBkhFSUYEMxT2s66hFCbFp1PxLdzQxjEbaMlSBqoNiidHz1OqHAMC?=
 =?us-ascii?Q?HqAeds8Yp+YdaNG9MGv/53QOJUiczpkuQFgeESHcyJoTdNWblqH3R00oqEuB?=
 =?us-ascii?Q?Q5UILYW8wBVo4JrCuRroCgiRDvSKQWrrxjwnuCRIZyWI/hHZvztluoyvwCeD?=
 =?us-ascii?Q?kP1Fq1OK1ZGG3FWFc9tMIeGZwvuHGioM9nhrjvLQoVMZMqb0nHCfhYUeliWT?=
 =?us-ascii?Q?eRL3QwavKl43Uyjd/W3RKVf9IDvoWUvT+SxvkMrkJQA7zPabZp7dJVWqCiLi?=
 =?us-ascii?Q?wRzytbR/7DOnawE0Po3WYb36YXPgtlfXWCzweUK98TRqEfnNdx6i5vBTw8Hc?=
 =?us-ascii?Q?h01XSsk/3IGOM7z1Hk7QuSHB5LQQhRuqY0MFK23XJlbQ3TUT6yivqsPG+Xdu?=
 =?us-ascii?Q?gwqCS7yKzCr34J88yhjCbdfiig69M1CFkOM332N2eeFuN761N52K10bAkXEN?=
 =?us-ascii?Q?b1f6+zLhFA/fOS/kNxKqnYynwfnney+AiWET9ChNnMbDZKcs5hjEBqrK9os9?=
 =?us-ascii?Q?GeRMWHxhpWaNMdDNfLwXXhq0grFZH2uP59HX2VQkEk87V8bFlGRM7w50OFkB?=
 =?us-ascii?Q?y90MkrUPsB3If28TYTWLr5NV8qsFZD/YDk/pIfIyz/pXoxrIustcqhLYtlyS?=
 =?us-ascii?Q?1wmcBcrYtKUHxv9rPXveYy+bYAf1H1mEwOWTeS5tf+ESUcTTYlBCvsQbMdTR?=
 =?us-ascii?Q?rMsvWjWL36AjFwCBj89pAiNX1t8TEeEOvmrOoT5DHIEQLXOf7tPkqkNPntQZ?=
 =?us-ascii?Q?jzg8uDD++EVBVn6mcY9gy9h36Z9FiWJ9Sm3b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:27:14.8841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3399206e-ba0c-40ee-792c-08dddac0efe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
The first two loops of for_each_oldnew_connector_in_state() both operate
on an HDCP queue.  If one isn't setup then each connector is iterated but
skipped TWICE.  This is wasteful for the majority of cases.

[HOW]
Combine the two HDCP related loops of for_each_oldnew_connector_in_state()
and check for the HDCP workqueue before even running either of them. This
should avoid running the functions in most cases, and if HDCP is setup only
run once.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 116 +++++++++---------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c0d31c26850d..e8cfae2bd2ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10129,69 +10129,40 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	drm_writeback_queue_job(wb_conn, new_con_state);
 }
 
-/**
- * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
- * @state: The atomic state to commit
- *
- * This will tell DC to commit the constructed DC state from atomic_check,
- * programming the hardware. Any failures here implies a hardware failure, since
- * atomic check should have filtered anything non-kosher.
- */
-static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
+static void amdgpu_dm_update_hdcp(struct drm_atomic_state *state)
 {
+	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_device *dev = state->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct amdgpu_display_manager *dm = &adev->dm;
-	struct dm_atomic_state *dm_state;
-	struct dc_state *dc_state = NULL;
-	u32 i, j;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	unsigned long flags;
-	bool wait_for_vblank = true;
 	struct drm_connector *connector;
-	struct drm_connector_state *old_con_state, *new_con_state;
-	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
-	int crtc_disable_count = 0;
-
-	trace_amdgpu_dm_atomic_commit_tail_begin(state);
-
-	drm_atomic_helper_update_legacy_modeset_state(dev, state);
-	drm_dp_mst_atomic_wait_for_dependencies(state);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
-	dm_state = dm_atomic_get_new_state(state);
-	if (dm_state && dm_state->context) {
-		dc_state = dm_state->context;
-		amdgpu_dm_commit_streams(state, dc_state);
-	}
+	if (!adev->dm.hdcp_workqueue)
+		return;
 
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+		struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+		struct dm_crtc_state *dm_new_crtc_state;
 		struct amdgpu_dm_connector *aconnector;
 
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		if (!connector || connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
 		aconnector = to_amdgpu_dm_connector(connector);
 
-		if (!adev->dm.hdcp_workqueue)
-			continue;
-
-		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
-
-		if (!connector)
-			continue;
+		drm_dbg(dev, "[HDCP_DM] -------------- i : %x ----------\n", i);
 
-		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+		drm_dbg(dev, "[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
 			connector->index, connector->status, connector->dpms);
-		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+		drm_dbg(dev, "[HDCP_DM] state protection old: %x new: %x\n",
 			old_con_state->content_protection, new_con_state->content_protection);
 
 		if (aconnector->dc_sink) {
 			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
-				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
+				drm_dbg(dev, "[HDCP_DM] pipe_ctx dispname=%s\n",
 				aconnector->dc_sink->edid_caps.display_name);
 			}
 		}
@@ -10205,7 +10176,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 
 		if (old_crtc_state)
-			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			drm_dbg(dev, "old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
 			old_crtc_state->enable,
 			old_crtc_state->active,
 			old_crtc_state->mode_changed,
@@ -10213,29 +10184,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			old_crtc_state->connectors_changed);
 
 		if (new_crtc_state)
-			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			drm_dbg(dev, "NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
 			new_crtc_state->enable,
 			new_crtc_state->active,
 			new_crtc_state->mode_changed,
 			new_crtc_state->active_changed,
 			new_crtc_state->connectors_changed);
-	}
 
-	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
-		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
-		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
-
-		if (!adev->dm.hdcp_workqueue)
-			continue;
-
-		new_crtc_state = NULL;
-		old_crtc_state = NULL;
-
-		if (acrtc) {
-			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
-			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
-		}
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -10279,7 +10234,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				new_con_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED)
 				enable_encryption = true;
 
-			drm_info(adev_to_drm(adev), "[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
+			drm_info(dev, "[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
 			if (aconnector->dc_link)
 				hdcp_update_display(
@@ -10287,6 +10242,45 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					new_con_state->hdcp_content_type, enable_encryption);
 		}
 	}
+}
+
+/**
+ * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
+ * @state: The atomic state to commit
+ *
+ * This will tell DC to commit the constructed DC state from atomic_check,
+ * programming the hardware. Any failures here implies a hardware failure, since
+ * atomic check should have filtered anything non-kosher.
+ */
+static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
+{
+	struct drm_device *dev = state->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dm_atomic_state *dm_state;
+	struct dc_state *dc_state = NULL;
+	u32 i, j;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	unsigned long flags;
+	bool wait_for_vblank = true;
+	struct drm_connector *connector;
+	struct drm_connector_state *old_con_state, *new_con_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	int crtc_disable_count = 0;
+
+	trace_amdgpu_dm_atomic_commit_tail_begin(state);
+
+	drm_atomic_helper_update_legacy_modeset_state(dev, state);
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
+	dm_state = dm_atomic_get_new_state(state);
+	if (dm_state && dm_state->context) {
+		dc_state = dm_state->context;
+		amdgpu_dm_commit_streams(state, dc_state);
+	}
+
+	amdgpu_dm_update_hdcp(state);
 
 	/* Handle connector state changes */
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
-- 
2.43.0

