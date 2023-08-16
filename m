Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E411C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A78C10E2DB;
	Wed, 16 Aug 2023 06:08:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DE510E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAQ4X02SNn5XVDPxhz0HnCgRDmpw9jAeJYXHxv6vuwoEQ4RLZ51FATPCu3HYdFkTaMT1cVk6y/2ov2Kn6XuzIULNOHRbJAWYl79l2MU/qTlSd0Dir34uI/BS7Jz9Oqkm5jgnk3AN/GKCXCG/W7ankXO3CBFqqdX/dZHkxVgIZL3pmz23LYl6Lyi1EKHnBSfPM0zV74nmq9kbjCLWZO+IvAgpyY1mZhdmPCqPQQIqpS2BQ2+YWZP7gLF2Wiuy32QV7InziWhLKOTemz0J5v1gPM3CLpPNtVMqm9J7pZQ2yYAPD/zwrgD3ZFG4xhcgfyDsgNIKy+Oh2Vd9ZTlrpvNVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSDShwM0YVhQrR/yCnsp1HNPyPd50f/9THDEitsk1x4=;
 b=jiSJD0evJq/keiZJrsWqx4MH158J3+yDu0XAsCouX9WbOvljdEIzmQq3FF8mej0nSaugCmaubkp27fjMLMQmyHWtthNpdZ/fU2+qeBdHATugEO70WdPN4rOiUIoxkaDEwBEKncw3dNJAbXJwP8HA6yq2LSjKZ8++XO1UPYkkh9AJqykveyyHCJLOLm2D2V/S3EzZ6Eey073MANOL+Zw3BXJwagv7AKqMA9SaWjEXQT+ZJ3zoqZPkgxmE3OcLlSGIMVdugby8tz1l6s3W1es/rhj36Ke02MSDyQ2tU1KlsNTLdznK8A9SIHAC6/GleaR+56dDGQwSUdN7wjL8BRJMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSDShwM0YVhQrR/yCnsp1HNPyPd50f/9THDEitsk1x4=;
 b=nE5TumiwR8+KmFzphDl/OC4uxj5iexcXM7+WjhFlcWbU6Ehn/BdElR046a+c2I7bvRe4gJci2ckY5BrWAfsYKsyuW15xxStwsLRDauy81ehGRW9mjoMvbKyQk8dcFDy9Z+AKmdtOu2Ou5Q41EqqazTGes0x05IV/EVdYWLZUPCI=
Received: from BY5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:a03:1a0::28)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:08:44 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::8) by BY5PR16CA0015.outlook.office365.com
 (2603:10b6:a03:1a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: fix static screen detection setting
Date: Wed, 16 Aug 2023 14:06:53 +0800
Message-ID: <20230816060658.2141009-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d558e8f-b9dc-4ce2-ac78-08db9e1f3f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuKbwGF6WfofpPIPWY4SpyLdyXW6QTXMxEM6TH2glY31blS7kax/KwMHQPljYY2n9bJ0VtNBSlL37xqOP9xyxoKteNgTfyg+WJdDCOivhwVMCSY3Bmcf/QZJmcaUFS4YVCDW+PNoLTd2kHLaalD5g798mBx/4Ww9HE33m5vIgJFM1tl7uXHOjrkm7czQUbGdAPLuTdEWOAV45X6WK7lOb1Tc/ffarNV6HyxW/XsAiefqXmGRxMv1pG4t4s+AEYaiPVJerwH7Barlf7LFHu71WRScZxmyhpd1exf0HX/4kKpTC5/csrUVc/m2xGLpB0ZKoMBnO8w4SwCBcglvII2+q5iYQ/yOc9knbdggW2u43bi6iuh05iIPYG9tWwyUEEemUjsUJG/hkoXDEQ4ibcH2TyJt7+WQ0w3jrtCSkUZGkv6HaEspHVtv4HmB5K9yek4Uua0HAG7tDT1r4Wny4G3+qpjEzdV/ztltM86Jt24wqsI/0U8/tjNPJR3ulnDLH/nkn2T99J8tqs9p8fMY1wVyjKPHUZHaCgT5j78lDJghj/DuKLDOwQ9b2WqaF2rzke11dIh7VndA8zjjhbZ1A7xGdOaMNrVN1vlKpvGEQiTDPJsPAOTOSZEBI4fJvIqul1qbQ+VG6vGCUXG8H5gq51sv7qLvyoS7+xoeDLMVn8qrf1xf2w+2cP5W1Q3Bqh0JF50dTOOnjU8doChrjk3izYSmKwr13xvuYmnSOJ4QdYXrA7R89Eb0PibsAG4uNwsZomPJyRMXYWuj1QT3NGZ6e1F5Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:44.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d558e8f-b9dc-4ce2-ac78-08db9e1f3f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, SungHuai Wang <danny.wang@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: SungHuai Wang <danny.wang@amd.com>

[WHY]
OTG_STATIC_SCREEN_EVENT_MASK is changed in DCN3,
but we still follow DCN2 to apply setting for
OTG_STATIC_SCREEN_EVENT_MASK.

[How]
Add new function to apply correct settings for DCN3 series.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: SungHuai Wang <danny.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c  | 17 +++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c   |  2 +-
 6 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 6cef62d7a2e5..255713ec29bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -987,3 +987,20 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 	}
 }
 
+void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params)
+{
+	unsigned int i;
+	unsigned int triggers = 0;
+
+	if (params->triggers.surface_update)
+		triggers |= 0x100;
+	if (params->triggers.cursor_update)
+		triggers |= 0x8;
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
+
+	for (i = 0; i < num_pipes; i++)
+		pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index a24a8e33a3d2..ce19c54097f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -87,5 +87,7 @@ void dcn30_set_hubp_blank(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
+void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params);
 
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 3d19acaa12f3..0de8b2783cf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -64,7 +64,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index fc25cc300a17..1d7bc1e39afe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -67,7 +67,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index ca8fe55c33b8..4ef85c3a0688 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -69,7 +69,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 279f312f7407..eb4227926006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -65,7 +65,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
-- 
2.37.3

