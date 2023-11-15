Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8108CC2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA18D10E58C;
	Wed, 15 Nov 2023 19:44:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A4010E586
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fii5AsHRSWk+9MwFNAc1RFiK+kqgzFe/MxkS16lXbioJDUJ6TZPCik1uSTHvespfoaf2nKmwMW5WqFwWhgaFlNDNZybPvaD4r5fXSJukRR/3RDgvYYGQ1HgdpOhgMzzNnF9uHJsC/ifn7CA3joYHPO00IhrydsUHU+QX+bS6we23kGbRpuDD0TY7lZQ+lxggoT0h/kj6zphZzmHkzmKG08+vIYL3dpRPdjt+opgWUVHHx9JNJr3hTUxdTc2Ku+C0VOKWd6BdU3ZUknwGZzS8Und75v9KM8btOuJXnz58q9pUQaetj0aIw/qvYXL+35ZMegyoQ0xBDFR4wDctFv2Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxE55l8vEhKbkt+++v+fNvQmFUZdJHSqlP1K9oXs9cA=;
 b=f3Hz1Mn2xU314dHazBdv7GcAQQ5HkJ8H4nWyKMDaArCrUk/dqLbTeWvZOg6iONU5+Onxx0lO3AdlMOO2w7fmZQ9zQcBHkfs6AbiJgrJono1xsy2Y0xicjXEMm0vEBAv9RRIB4eqRfIBGHEb+5KuvAGzQFGNnvn2hvh3FHp/o/+LFzLksuN27AVOdVQL5go48s3IsnpeajvRZvoIx0Jf+iKQeDNEAzpmtphNEKyd/JlxI4EQc66nr7o9Aculcx6IJ7eeXW0l8ktc76Z6N2O7Q+/F8gjBe2srOoBNDZC7BLfbtze+aM46VYBEjhl4WBOGbBLCpxPR0p5AJFIF6N/9r0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxE55l8vEhKbkt+++v+fNvQmFUZdJHSqlP1K9oXs9cA=;
 b=W37uCtTAsvXKrNHzfPLA32tu7/gxh+nP9SLGuMNLovdBwwjgYKmVPGLNoOxp9/lnhAA6k48rHXScrk4tnSze3QEgqaGM75S6mxpqkNdAt34jdCc5UwY5fYggQ7hJFaUnQL452wY0wuYCHVNHy14vr3g25IIWXnEDA5Wad7l7t7I=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:34 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::37) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:29 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/35] drm/amd/display: adjust flow for deallocation mst
 payload
Date: Wed, 15 Nov 2023 14:40:32 -0500
Message-ID: <20231115194332.39469-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a30c1a-da60-4dcc-8509-08dbe6134b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2VD9UhYxI/4yIX8YQ90Zh66xTddM15NjlOBp0z5dOa/ohg1xd5A/37x2vJbnt4pXnCCGBxEm4z3ihLIFDJIvf11JVv5s8jVeiOEag0YRphGsdZIHhUd5Ra2BGPE3e2gHWxUJNrrbAKXXHf1uDjQOZbc0/jMANrIorVkp1fnwpKYu/2i+/fCxd3aLbkOKTGjHxV/QB/5/WNTT5lFELi7x1cLgy+FI2oIU2YcntxImk+jhAY/6zy0h5R8481zum4yt5JawiLI7xNNgI/8KwIXP1lv1sL+8eKMEAZR5haM+c7P46WCBvi1Qq3X8/99bN4r/i17dOuXD4R/F8kfQt4I+mKBdRaI3fyCKvPknTncvIhFaDULOdzqrABUvELGgln4yTcaK4x7cla8PhAR9ai97plswAh6x2vftxsLc6UiLhQQDL2zOILFDQB8ocrK9x4Ba7qhQJnN6JVT3xof1dy5xaSG4NaP9yoe4II1HqcDJ/KkKb5H5WtPbx8HCzBCZ8w6pNkfVFZ6sLH9AtbUS8Slk8k91TNMtn2htIFgoVndHkDdcdvOCMqVsDH4TjwTiBnl/RTMvd4jM0J4tYrnJ7OF6W+aKwAgviRetiBK3XT8fw3jq3xKD40WGN+FYRBEtHvn5Cadw28G57w2SfG8RgONMhynhel26ygQ7aBeuigbj+fv+6KNes50EqPRX3klwcLICNhb0mLHDk/2Jlmw+SsyDPQ5pPkQECifjEMszy0XvfhQ05JncZeqxKeZO/az00JbIjmQh1VSi58FgIsdoNz/4P2s9PDjN7MXv1n91I2nLXmxS07X292XD7mUUKMMiRkV3bTXrDMxts2fKc5MTobAwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(83380400001)(36860700001)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002)(30864003)(336012)(426003)(36756003)(66574015)(41300700001)(1076003)(47076005)(16526019)(82740400003)(26005)(2616005)(6666004)(478600001)(66899024)(2906002)(44832011)(6916009)(40460700003)(316002)(86362001)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:34.3023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a30c1a-da60-4dcc-8509-08dbe6134b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <wayne.lin@amd.com>

[Why]
MST relevant variables are maintained at drm side. As the result, we
still have to call drm_dp_remove_payload_part2() to update the relevant
values regardless the link is under mst mode or not. We used to have a
workaround patch to tackle this: commit 3d8fcc6740c9 ("drm/amd/display:
Extract temp drm mst deallocation wa into its own function")

Now it's time to remove the workaround and adjust the flow.

[How]
During deallocate_mst_payload(), source actually doesn't send out
ALLOCATE_PAYLOAD at the end as like the flow in allocate_mst_payload().
Call function dm_helpers_dp_mst_send_payload_allocation() at the end of
deallocate_mst_payload() is a bit confusing.

Separate dm_helpers_dp_mst_send_payload_allocation() into 2 functions.
Have a new function dm_helpers_dp_mst_update_mst_mgr_for_deallocation()
to replace dm_helpers_dp_mst_send_payload_allocation() for payload
deallocation.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 ---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  53 +++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  12 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 105 ++----------------
 5 files changed, 50 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08f274988c94..5f5205176298 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1716,23 +1716,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
 	adev->dm.dc->debug.ignore_cable_id = true;
 
-	/* TODO: There is a new drm mst change where the freedom of
-	 * vc_next_start_slot update is revoked/moved into drm, instead of in
-	 * driver. This forces us to make sure to get vc_next_start_slot updated
-	 * in drm function each time without considering if mst_state is active
-	 * or not. Otherwise, next time hotplug will give wrong start_slot
-	 * number. We are implementing a temporary solution to even notify drm
-	 * mst deallocation when link is no longer of MST type when uncommitting
-	 * the stream so we will have more time to work on a proper solution.
-	 * Ideally when dm_helpers_dp_mst_stop_top_mgr message is triggered, we
-	 * should notify drm to do a complete "reset" of its states and stop
-	 * calling further drm mst functions when link is no longer of an MST
-	 * type. This could happen when we unplug an MST hubs/displays. When
-	 * uncommit stream comes later after unplug, we should just reset
-	 * hardware states only.
-	 */
-	adev->dm.dc->debug.temp_mst_deallocation_sequence = true;
-
 	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
 		DRM_INFO("DP-HDMI FRL PCON supported\n");
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c7a29bb737e2..e44ba5c1c48e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -333,15 +333,14 @@ enum act_return_status dm_helpers_dp_mst_poll_for_allocation_change_trigger(
 	return ACT_SUCCESS;
 }
 
-bool dm_helpers_dp_mst_send_payload_allocation(
+void dm_helpers_dp_mst_send_payload_allocation(
 		struct dc_context *ctx,
-		const struct dc_stream_state *stream,
-		bool enable)
+		const struct dc_stream_state *stream)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_state *mst_state;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
-	struct drm_dp_mst_atomic_payload *new_payload, old_payload;
+	struct drm_dp_mst_atomic_payload *new_payload;
 	enum mst_progress_status set_flag = MST_ALLOCATE_NEW_PAYLOAD;
 	enum mst_progress_status clr_flag = MST_CLEAR_ALLOCATED_PAYLOAD;
 	int ret = 0;
@@ -349,25 +348,13 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
 	if (!aconnector || !aconnector->mst_root)
-		return false;
+		return;
 
 	mst_mgr = &aconnector->mst_root->mst_mgr;
 	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
-
 	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
 
-	if (!enable) {
-		set_flag = MST_CLEAR_ALLOCATED_PAYLOAD;
-		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
-	}
-
-	if (enable) {
-		ret = drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, new_payload);
-	} else {
-		dm_helpers_construct_old_payload(mst_mgr, mst_state,
-						 new_payload, &old_payload);
-		drm_dp_remove_payload_part2(mst_mgr, mst_state, &old_payload, new_payload);
-	}
+	ret = drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, new_payload);
 
 	if (ret) {
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
@@ -378,10 +365,36 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			clr_flag, false);
 	}
-
-	return true;
 }
 
+void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
+		struct dc_context *ctx,
+		const struct dc_stream_state *stream)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_topology_mgr *mst_mgr;
+	struct drm_dp_mst_atomic_payload *new_payload, old_payload;
+	enum mst_progress_status set_flag = MST_CLEAR_ALLOCATED_PAYLOAD;
+	enum mst_progress_status clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
+
+	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+
+	if (!aconnector || !aconnector->mst_root)
+		return;
+
+	mst_mgr = &aconnector->mst_root->mst_mgr;
+	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
+	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
+	dm_helpers_construct_old_payload(mst_mgr, mst_state,
+					 new_payload, &old_payload);
+
+	drm_dp_remove_payload_part2(mst_mgr, mst_state, &old_payload, new_payload);
+
+	amdgpu_dm_set_mst_status(&aconnector->mst_status, set_flag, true);
+	amdgpu_dm_set_mst_status(&aconnector->mst_status, clr_flag, false);
+ }
+
 void dm_dtn_log_begin(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 85fa77d623f4..abaf23c1cedd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -956,7 +956,6 @@ struct dc_debug_options {
 	unsigned int min_prefetch_in_strobe_ns;
 	bool disable_unbounded_requesting;
 	bool dig_fifo_off_in_blank;
-	bool temp_mst_deallocation_sequence;
 	bool override_dispclk_programming;
 	bool otg_crc_db;
 	bool disallow_dispclk_dppclk_ds;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 7ce9a5b6c33b..6d7a15dcf8a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -103,10 +103,16 @@ enum act_return_status dm_helpers_dp_mst_poll_for_allocation_change_trigger(
 /*
  * Sends ALLOCATE_PAYLOAD message.
  */
-bool dm_helpers_dp_mst_send_payload_allocation(
+void dm_helpers_dp_mst_send_payload_allocation(
 		struct dc_context *ctx,
-		const struct dc_stream_state *stream,
-		bool enable);
+		const struct dc_stream_state *stream);
+
+/*
+ * Update mst manager relevant variables
+ */
+void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
+		struct dc_context *ctx,
+		const struct dc_stream_state *stream);
 
 bool dm_helpers_dp_mst_start_top_mgr(
 		struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index f8e01ca09d96..aa0a086aa7fc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1247,86 +1247,6 @@ static void remove_stream_from_alloc_table(
 	}
 }
 
-static enum dc_status deallocate_mst_payload_with_temp_drm_wa(
-		struct pipe_ctx *pipe_ctx)
-{
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc_link *link = stream->link;
-	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
-	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
-	int i;
-	bool mst_mode = (link->type == dc_connection_mst_branch);
-	/* adjust for drm changes*/
-	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
-	const struct dc_link_settings empty_link_settings = {0};
-	DC_LOGGER_INIT(link->ctx->logger);
-
-	if (link_hwss->ext.set_throttled_vcp_size)
-		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
-	if (link_hwss->ext.set_hblank_min_symbol_width)
-		link_hwss->ext.set_hblank_min_symbol_width(pipe_ctx,
-				&empty_link_settings,
-				avg_time_slots_per_mtp);
-
-	if (dm_helpers_dp_mst_write_payload_allocation_table(
-			stream->ctx,
-			stream,
-			&proposed_table,
-			false))
-		update_mst_stream_alloc_table(
-				link,
-				pipe_ctx->stream_res.stream_enc,
-				pipe_ctx->stream_res.hpo_dp_stream_enc,
-				&proposed_table);
-	else
-		DC_LOG_WARNING("Failed to update"
-				"MST allocation table for"
-				"pipe idx:%d\n",
-				pipe_ctx->pipe_idx);
-
-	DC_LOG_MST("%s"
-			"stream_count: %d: ",
-			__func__,
-			link->mst_stream_alloc_table.stream_count);
-
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
-		DC_LOG_MST("stream_enc[%d]: %p      "
-		"stream[%d].hpo_dp_stream_enc: %p      "
-		"stream[%d].vcp_id: %d      "
-		"stream[%d].slot_count: %d\n",
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
-		i,
-		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
-		i,
-		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-	}
-
-	if (link_hwss->ext.update_stream_allocation_table == NULL ||
-			link_dp_get_encoding_format(&link->cur_link_settings) == DP_UNKNOWN_ENCODING) {
-		DC_LOG_DEBUG("Unknown encoding format\n");
-		return DC_ERROR_UNEXPECTED;
-	}
-
-	link_hwss->ext.update_stream_allocation_table(link, &pipe_ctx->link_res,
-			&link->mst_stream_alloc_table);
-
-	if (mst_mode) {
-		dm_helpers_dp_mst_poll_for_allocation_change_trigger(
-			stream->ctx,
-			stream);
-	}
-
-	dm_helpers_dp_mst_send_payload_allocation(
-			stream->ctx,
-			stream,
-			false);
-
-	return DC_OK;
-}
-
 static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -1339,9 +1259,6 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	const struct dc_link_settings empty_link_settings = {0};
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	if (link->dc->debug.temp_mst_deallocation_sequence)
-		return deallocate_mst_payload_with_temp_drm_wa(pipe_ctx);
-
 	/* deallocate_mst_payload is called before disable link. When mode or
 	 * disable/enable monitor, new stream is created which is not in link
 	 * stream[] yet. For this, payload is not allocated yet, so de-alloc
@@ -1414,16 +1331,14 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	link_hwss->ext.update_stream_allocation_table(link, &pipe_ctx->link_res,
 			&link->mst_stream_alloc_table);
 
-	if (mst_mode) {
+	if (mst_mode)
 		dm_helpers_dp_mst_poll_for_allocation_change_trigger(
 			stream->ctx,
 			stream);
 
-		dm_helpers_dp_mst_send_payload_allocation(
-				stream->ctx,
-				stream,
-				false);
-	}
+	dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
+			stream->ctx,
+			stream);
 
 	return DC_OK;
 }
@@ -1504,12 +1419,10 @@ static enum dc_status allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 			stream->ctx,
 			stream);
 
-	if (ret != ACT_LINK_LOST) {
+	if (ret != ACT_LINK_LOST)
 		dm_helpers_dp_mst_send_payload_allocation(
 				stream->ctx,
-				stream,
-				true);
-	}
+				stream);
 
 	/* slot X.Y for only current stream */
 	pbn_per_slot = get_pbn_per_slot(stream);
@@ -1769,8 +1682,7 @@ enum dc_status link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_in
 	/* send ALLOCATE_PAYLOAD sideband message with updated pbn */
 	dm_helpers_dp_mst_send_payload_allocation(
 			stream->ctx,
-			stream,
-			true);
+			stream);
 
 	/* notify immediate branch device table update */
 	if (dm_helpers_dp_mst_write_payload_allocation_table(
@@ -1899,8 +1811,7 @@ enum dc_status link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_
 		/* send ALLOCATE_PAYLOAD sideband message with updated pbn */
 		dm_helpers_dp_mst_send_payload_allocation(
 				stream->ctx,
-				stream,
-				true);
+				stream);
 	}
 
 	/* increase throttled vcp size */
-- 
2.42.0

