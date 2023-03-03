Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045ABC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819CA10E6E5;
	Fri,  3 Mar 2023 15:51:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5254110E6E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDHsJ5L/KxQlnmP/JOAa7qmuSs81/t1Wq1P4+mmXVjjwgyK98i4pICwvqY41u5cRO6e9WhrHUOHVh4t+Tx7Ru4WUxrKwxHUdWsMkqXmbmGVxGrqIlrsd9oFUkBgTHggZ3MEtYc6yMt1o5WQevhhzPD/4XLeHlmidXJNSg4mNllucclGXjVakLH0GU8C6QF9W5+DHqgel8i59zM4nQIE73ZsLKPbM1X/iD4UOXNmlZw6KhYLLs0oue/o6iulEEyJNY8bpVHAEu3kjhDDdD3E7Wx90xR0HvFy90PGpTqqGf79rrErpmA/EK9PrY2Vyet1EtPCiFQ5A9Ed0mT5QBIvCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh2Y3l3WucVjquGlMUNU6u8uV6iHMuCkw5eeG3t/x7Y=;
 b=ccCS9feuMguYWmQKrbK6I3YnMKSFDd9cOA7z8m4H8x/8Vkdm0yFcW4LYRvnUCOmxCVNQuCqsheMQyIrn9WKA9yYCDPMcdaT3Susx/9RaSjTJroxp6kj4DCUEKlHojfgrg7KNMJk8FsK/9jWpFTm7sMH9XTop+Tbf+1yItXq3dqVLZ7X+wwjVEdv62ymCoyt3Y33Dofya9gRRmLimBNS5+YZRrfnnOQnECxUgWGtnrgZRFWT5dXqB49qasAcFnpk7nsrddZUS89qk4bkAH6g9ZZFvBfkvVdZoFxk6tTKfRpLA3h6Rk2XyUXloOyaCZswq54IilytD/CweZH8qOOEwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh2Y3l3WucVjquGlMUNU6u8uV6iHMuCkw5eeG3t/x7Y=;
 b=Q/9tbmM8GJNGJ+aQv2MhRsbB5PaIK1fbkWdNn/phA/AqZcdOY6CXWwjfSoY421HKdzRw5j9KJAyuj/7w96A3RuVlvB+ZX349wd5Lk/+G4hOV4V1aQKf3AFma3XuqeuqwqYoa9rs8xJPDwkT45BXz09EpyGa6mh2UIUBvGAdhw54=
Received: from DM5PR07CA0083.namprd07.prod.outlook.com (2603:10b6:4:ad::48) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 15:51:45 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::fb) by DM5PR07CA0083.outlook.office365.com
 (2603:10b6:4:ad::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:45 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:38 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: Drop dc_commit_state in favor of
 dc_commit_streams
Date: Fri, 3 Mar 2023 10:40:17 -0500
Message-ID: <20230303154022.2667-29-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: d2904a25-fa8e-4d24-e52d-08db1bff30e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDL/UZkC6RH5FStHu1aqu4oM0XCwv53Q7MlesSFTibIUbbn0RvQcboqNvWqInPFXE90VYD2lXl6xkxC4m1heUT84FP7nvh8lsaN9T86kK19WVakpL8RxG4D4WtttERJdTDaTUg0L/+bVToTSTBl+uaaveWvpTyHZTgKi+Yher+CfpIzlh8vqZt5yZx6fCLpMfWqSKm3KE1P4BHCh4N4Z9VNdAjj+fjpCf6gxHIvOZfLaz8NqJryoVd6YgsDEM+1T2NRQtdWdmSfcuxPXqExHgzxjib6IzF6Ros9FULkmJc6LdVV3fQElVNC1Moj3eIJqNxds1XYd9av0jjidogf3oouVAn9O3cB0jEjFXPthkeUkYVub8pnkZuy8qzJG88QSkI3plti/kj7Zg5J/eMebFqr+8g75En5ILIa+XA17IIakh/4cVtcwxKYRmnBRlTj0ChUDsQH2K7dgYOVtf/Ji15gE6LL8+Xm8MsDVSuzdw9sxIhwE5rqbtqldrLWLPYUeU7jDk1Qq3DoW7mY0ovTAHq4pmzJZqOvYawKsLnhF4g4gGunHLah9dvb2pxd6j9s2lEuQgon8LDR2OqifD9yhBVpjHdZJj0aoZhhlG+ESSOGkLC0OJmYmCVYTidsviu3FPtGKyb99dZ7j3/NK63TTCh8nY67iiV23UyJ7dSDUQkv/Mr9al8BLsyi8EyfG2o5fFA0eYYohdMe+z2SvBEQ6I2LB3Pe1Qq2f+LzJaOzOVOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(186003)(70586007)(70206006)(47076005)(426003)(36756003)(478600001)(40480700001)(40460700003)(16526019)(2906002)(6666004)(26005)(86362001)(1076003)(356005)(2616005)(336012)(316002)(44832011)(41300700001)(8676002)(8936002)(54906003)(81166007)(82310400005)(5660300002)(82740400003)(6916009)(36860700001)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:45.3455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2904a25-fa8e-4d24-e52d-08db1bff30e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
There are two functions responsible for handling the DC commit state:
dc_commit_state and dc_commit_streams. Both have the same goal, but
dc_commit_streams surpess dc_commit_state in terms of completeness. For
this reason, maintaining these two functions makes maintainability
unnecessarily complicated. This commit replaces the old dc_commit_state
in favor of dc_commit_streams, and removes the old dc_commit_state.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 47 -------------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 --
 3 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b560a6711682..f692a0d3dc4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2486,7 +2486,7 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 			goto fail;
 	}
 
-	res = dc_commit_state(dc, context);
+	res = dc_commit_streams(dc, context->streams, context->stream_count);
 
 fail:
 	dc_release_state(context);
@@ -2745,7 +2745,7 @@ static int dm_resume(void *handle)
 			dc_enable_dmub_outbox(adev->dm.dc);
 		}
 
-		WARN_ON(!dc_commit_state(dm->dc, dc_state));
+		WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
 
@@ -8484,7 +8484,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		dm_enable_per_frame_crtc_master_sync(dc_state);
 		mutex_lock(&dm->dc_lock);
-		WARN_ON(!dc_commit_state(dm->dc, dc_state));
+		WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
 
 		/* Allow idle optimization when vblank count is 0 for display off */
 		if (dm->active_vblank_irq_count == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9146c9667c7d..6acbb757d082 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2061,53 +2061,6 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	return res;
 }
 
-/* TODO: When the transition to the new commit sequence is done, remove this
- * function in favor of dc_commit_streams. */
-bool dc_commit_state(struct dc *dc, struct dc_state *context)
-{
-	enum dc_status result = DC_ERROR_UNEXPECTED;
-	int i;
-
-	/* TODO: Since change commit sequence can have a huge impact,
-	 * we decided to only enable it for DCN3x. However, as soon as
-	 * we get more confident about this change we'll need to enable
-	 * the new sequence for all ASICs. */
-	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		result = dc_commit_streams(dc, context->streams, context->stream_count);
-		return result == DC_OK;
-	}
-
-	if (!streams_changed(dc, context->streams, context->stream_count)) {
-		return DC_OK;
-	}
-
-	DC_LOG_DC("%s: %d streams\n",
-				__func__, context->stream_count);
-
-	for (i = 0; i < context->stream_count; i++) {
-		struct dc_stream_state *stream = context->streams[i];
-
-		dc_stream_log(dc, stream);
-	}
-
-	/*
-	 * Previous validation was perfomred with fast_validation = true and
-	 * the full DML state required for hardware programming was skipped.
-	 *
-	 * Re-validate here to calculate these parameters / watermarks.
-	 */
-	result = dc_validate_global_state(dc, context, false);
-	if (result != DC_OK) {
-		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
-			     dc_status_to_str(result), result);
-		return result;
-	}
-
-	result = dc_commit_state_no_check(dc, context);
-
-	return (result == DC_OK);
-}
-
 bool dc_acquire_release_mpc_3dlut(
 		struct dc *dc, bool acquire,
 		struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0f6873449d15..b51dfe0f507c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1360,10 +1360,6 @@ enum dc_status dc_commit_streams(struct dc *dc,
 				 struct dc_stream_state *streams[],
 				 uint8_t stream_count);
 
-/* TODO: When the transition to the new commit sequence is done, remove this
- * function in favor of dc_commit_streams. */
-bool dc_commit_state(struct dc *dc, struct dc_state *context);
-
 struct dc_state *dc_create_state(struct dc *dc);
 struct dc_state *dc_copy_state(struct dc_state *src_ctx);
 void dc_retain_state(struct dc_state *context);
-- 
2.34.1

