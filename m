Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46477C7EE2E
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05B310E473;
	Wed, 31 May 2023 04:49:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2B710E473
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izJpkLcuWoiyW6DyKtkLmQVhYflTe1qUY+Id1k8nq+IhZeHRr3Q65eEmAr+2UbsrziutMLE4ix4gz8CnVyWFE4mSoGgf4/zCxdPjKcNhhKJI5eukBB2a3ew8T+qyqqpdavaFUO1EfY5bToyo+B8UCJv9wGv4Knq9ofcscfObeWxh6kDd82L+2ATdZMk3yCDSlyHT6VnRk+rl7JjXIKQxbUPjqlxb/2LnPCJ0GIA3vtSCa26EGPuKCtx0CDlaviCBshYcFEqPC19NIfyldhIOodNZH6r1Y0GKqYnUPTDQGpQ5WYroFbg+YISXCXy22rjhqQ/U14MGMzfgs7QG9Rjrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOyx3SE6wFYF1UjfPqnkAC5m6FwL1CN5eoRf973Llac=;
 b=e4IrISMlMR7M01xEiRKpwA6+E7VYINJVPT0J+JnHw66vXQiwo+vdHLIAzk7ZXyBk38mo6vcv+8hqpa8paLXVNKGCF6wfnhCLYYFyug1son5XCO+4usiSrTE8WIvkjOJ0b/0d5sbc91hJCCvhEeXnfFHxIfzVJwMC4eFFd8Upm2SVpWllBoLJ5qR8JVkkE1Go3zMv7n6UrMU0q8Wo25471i8pJIPSOyARoE02phCo7Sp9HX3lvEUq52EbqMuVzgQLUFfDOawjA82zWEEi4Yaosrwvzg2faDhZ65XiftHW7REQUoypl+F8qXJZILrDKEim7dAsSoP9/t9FESiiS86BWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOyx3SE6wFYF1UjfPqnkAC5m6FwL1CN5eoRf973Llac=;
 b=43tazocAvkr0sD2YLb+C4c4s8RmCJpklwCQKz375cjKA22EPofRsAz+Xek5pfPUtyPh/8Y9DTtdmbTXRGJ7RdY0Mwem2LJdyuiocdwo9Qjy0JZoL+9x3HmpNfA+jT4mBihJkxwy9VULx4fkanXsMNbXVBU8ZpufEftYZ5wZn2vU=
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:28 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::2d) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:27 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:23 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Enable Freesync Video Mode by default
Date: Wed, 31 May 2023 12:48:07 +0800
Message-ID: <20230531044813.145361-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d383369-fb28-4936-6e07-08db61926a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOPDPLwf+KXVCxvcAaKa5R7nkjo+saNctvT74yArQoYJUSacHDIcaVfcO27k66v4lpxmH6sONSPRShIspxEqG0E9YlBVXuQTmzpvZv7biHvlUHDLHKjWeZmJzzomP8bTSXavMJd2HBIJ9Q1O9BISR87WhrW3HO9yWwW+ao35krxUma3Uk0Pw28ln8IdIaiHGg/63hkeNZtIxS7SdrLyFI8wVVQDpYJLwd0kXd+CpXTTvBs/mnV8et8s7VJNYqytt4HfcCU5DeqDLIFkj6Bal/aYvFMvqxRAE0H73Wa38wXYxfPhwFbMSKg49Uyeqe1a7Rrj54xOWCMeyfXnm6Hjt91Kr1YPqPfvAqUzKyHjQRL+askCW6W5Q3Qv+DyB1mihRixabdkKjiXFcSjpDvBHsU9b5kKdyChKqmpgGo/dPkaRRVzJ7CP5KTke54GaJuhIrJbHmxiqf0G/0MEA5kbg3IiT+oTQBjyQGPWcf6a/s3ak0PoH8RRBSFMROPtmGQcZBJ2/ugkX1b5Mkf264f4Ir7xETV1i9BIZnxMh1/RQNlYpcKRdadYM8RAM9SVSKyJG2VbGBBuESXA1u4ff2DWBmG6CJcVG4+F5HvN8D3u0NA5BbYck1df3RbiKUdLEKBQhUUJu1Qu2Y5NcQRuTHPCxdc1A/6br0BT5iwsR+eaj68CjI2F3VxpWMVKAcHKRSivX+N9cnWeloG97E+LKJfJsAvzLUl2nsAFSlHQUw/O8pi8Q6+N1x7nSn092szp1fw8VOzKv0YXeUm0uvKg5DeK2AOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(16526019)(36860700001)(82740400003)(186003)(47076005)(336012)(426003)(86362001)(478600001)(2616005)(2906002)(356005)(81166007)(44832011)(6916009)(4326008)(26005)(40460700003)(6666004)(316002)(40480700001)(1076003)(36756003)(70586007)(70206006)(5660300002)(7696005)(8936002)(8676002)(41300700001)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:27.7266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d383369-fb28-4936-6e07-08db61926a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Rodrigo Siqueira <rjordrigo@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Revert commit d54f66bc9c37 ("Revert drm/amd/display: Enable Freesync Video Mode by default")

Enables freesync video by default, since the hang and corruption issue
on eDP panels are now fixed.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <rjordrigo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a69f4a39d92a..52dca7898390 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6017,8 +6017,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
-		recalculate_timing = amdgpu_freesync_vid_mode &&
-				 is_freesync_video_mode(&mode, aconnector);
+		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
@@ -7201,7 +7200,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-	if (!(amdgpu_freesync_vid_mode && edid))
+	if (!edid)
 		return;
 
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
@@ -9246,8 +9245,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * TODO: Refactor this function to allow this check to work
 		 * in all conditions.
 		 */
-		if (amdgpu_freesync_vid_mode &&
-		    dm_new_crtc_state->stream &&
+		if (dm_new_crtc_state->stream &&
 		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
 			goto skip_modeset;
 
@@ -9289,7 +9287,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		}
 
 		/* Now check if we should set freesync video mode */
-		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		if (dm_new_crtc_state->stream &&
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
@@ -9303,7 +9301,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
-		} else if (amdgpu_freesync_vid_mode && aconnector &&
+		} else if (aconnector &&
 			   is_freesync_video_mode(&new_crtc_state->mode,
 						  aconnector)) {
 			struct drm_display_mode *high_mode;
-- 
2.40.1

