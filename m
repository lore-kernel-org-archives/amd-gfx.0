Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D9BC6FA86
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BB810E80F;
	Wed,  7 Sep 2022 18:12:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3449010E80D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5CnNeWrWLGVZrFcX7K2HkRCLPFSL25gH4lIa4Ee4z0Xe32rscurF4YyWroQA/EHNoeMnAl5Rdn8p/dsi5xlqIrMPtfvbqLLvyz/1HbK+58CIOaYHmSsUkbyA9wVCF0oY+eomNqkN3A7KWNH5ZAH4ry5ul0PQzEoK1Z0JU6DhD9f+AioGNpWNsoOP/O2QECS4zVfQax0ZVtsx5VIZEFfozPSqZW121SNsDPgA2nd3qhjvxT4KjYyypDzesU3dTe0KFOayyR377lXuEHjmz+o16D8SHzn/8LeB/yJpNGQeAmlkfzpdxyNvmVD/4EDC7uJPSfJZpiemjaMq8CfmFhz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQTGxgW+kOZOSMSlOvYfn43KDTJ7wgv63uJOfKTW/JQ=;
 b=QiXa0G9+wJfkjuwLstNfnCbPB2Lr3qFfXiS7Wpn7+wAJn7XBtcXZTeurjrZd7THtYzb+jOZmLBzvI1JPvlA7h+UJeWzcV9oAjFeXW2w9RSErs8giCSjHl9itUMAVBoGwtS9Pl7KYjaHodcdZ1E2yMchF9Dh3DBl/rjDs7UTpsdcgEPLPEp2BVzQpG3PSDek31v4LQ9gkrZMHdJi7aNlxjPBNM7Xxf/XCKqGNv+zP5M9tahU/lBwSxzgaumEKnnqZULno9rKWGPShhN325pq1EgM8bf0PPA1myLXCIY89SrXCnHYob6keF6oqC7w+ghjbDDAEfgdAKdQ6WehTjMBing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQTGxgW+kOZOSMSlOvYfn43KDTJ7wgv63uJOfKTW/JQ=;
 b=TjcFqygO2ymGBSPl53bjBJKDDHeDEi5sM1nZeu0SEM/fE8sscGqcxS1jrqYjnbLa644M328aUsBVy2lRYGQRIpurQnGaobOEZiaQIrL+AVJwMd+hzSPqcGZMKGk5HyRJwQuxELnyVwxQIGvURW6O1JAbpnFvEA82TzRykNmahSA=
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:12:36 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::84) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.6 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:36 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:33 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Don't adjust VRR unnecessarily
Date: Wed, 7 Sep 2022 14:11:56 -0400
Message-ID: <20220907181200.54726-17-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f8f61c-6540-4311-833a-08da90fc8b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IshPbDnmwcT5D0YM4WBttoBrp7IniKMnUm8wnDQpSAKBi9DGKB0t+6/jhDt23wtRGh0CrVcZIz/4+cfWvEHa4hPK6LEHZUDFms3vpK9eJDbmXaNQkpQ89PdN014Qw9XWPyzg1XWQ/SgtzCL78ZJjJNoVwMjJCHGpFVP9ZGKE4DADrTdJan+hLkrrHyHt8XyUEEU0R1JWgAzYMoVhL2W/ObW/l8EQ4PrReWKYthU83lX5fjIboeyLZc/etPDshHIUV8GDeksjragzoFM1Khk7WDd3kgK9Hg1T1wGj278rLdLEaa8lcqlN4nrZw2XFWvNCtvc+hM7HMv86lBQOniTyQaEo56twoDQr15f9KHN9sYbidBbzvf1dURT1w9GSTVcPpYU2EMq6cyUJUb+aE5jFunYmb8IWtOYP4DPoUKkXIbPMGz7DaD4ccRW3NgcGWC2WmnGtjWfUWPuTZyXx91EQ4OXSmCOq1OOcEaZldMn2OXP8FtYCETRm6+Y426CE/cOCPMsa/tFRfmSyN65Cz86/bQ1GvzfH02CyiG0YlshZm73Jyfvqp2pfoWhfh3PSPGp0lN2VukVxqtEySeLLqMjuOFMeUP7OwdNn1VNKuAgngjfyj1cUIXU566pQd0xrVywp0Dwj1B6kdCmGFvh3rdSLzDKcyUu02z5LYrh4btKu1cWIlKxehNUFBkHhzFJv4VLJxjS8P81felYZYqzN7PwezQbQD/xh7vAXftsECdP1/z7tfDz2LC5fJaLYOmilQLyyiXKNDb1l6D73h5KA7XTcSWI5tUHnC1ZtYvEbZUwOPwm7SQ6kvRxfMpMTKoLB/hys4KC4+vavaWrP1VPdFcqoUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(40470700004)(36840700001)(47076005)(44832011)(54906003)(16526019)(26005)(2906002)(6666004)(40460700003)(356005)(336012)(36756003)(82310400005)(316002)(36860700001)(478600001)(426003)(6916009)(4326008)(70586007)(82740400003)(40480700001)(70206006)(8936002)(5660300002)(86362001)(1076003)(41300700001)(8676002)(7696005)(81166007)(83380400001)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:36.3896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f8f61c-6540-4311-833a-08da90fc8b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Cyr, Aric" <Aric.Cyr@amd.com>

[why]
Do not need to spend time reprogramming DRR if there were no updates to
the parameters.

[how]
Compare the current stream state to the requested one to determine if an
update is required.

In amdgpu_dm the timing_changed flag is set but never used so can remove it.
Similarly, the stream update for VRR is done after dc_commit and should
not update its adjust field until after the update is completed.  The
adjust field is managed by dc_stream_adjust_vmin_vmax and should not be
manually updated in amdgpu_dm.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ----------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  3 +++
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dbe76b85552e..7a9f7c7da7d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7385,11 +7385,6 @@ static void update_freesync_state_on_stream(
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
-	new_crtc_state->freesync_timing_changed |=
-		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
-			&vrr_params.adjust,
-			sizeof(vrr_params.adjust)) != 0);
-
 	new_crtc_state->freesync_vrr_info_changed |=
 		(memcmp(&new_crtc_state->vrr_infopacket,
 			&vrr_infopacket,
@@ -7398,7 +7393,6 @@ static void update_freesync_state_on_stream(
 	acrtc->dm_irq_params.vrr_params = vrr_params;
 	new_crtc_state->vrr_infopacket = vrr_infopacket;
 
-	new_stream->adjust = acrtc->dm_irq_params.vrr_params.adjust;
 	new_stream->vrr_infopacket = vrr_infopacket;
 
 	if (new_crtc_state->freesync_vrr_info_changed)
@@ -7461,10 +7455,6 @@ static void update_stream_irq_parameters(
 				      new_stream,
 				      &config, &vrr_params);
 
-	new_crtc_state->freesync_timing_changed |=
-		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
-			&vrr_params.adjust, sizeof(vrr_params.adjust)) != 0);
-
 	new_crtc_state->freesync_config = config;
 	/* Copy state for access from DM IRQ handler */
 	acrtc->dm_irq_params.freesync_config = config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b44faaad9b0b..b5ce15c43bcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -681,7 +681,6 @@ struct dm_crtc_state {
 
 	int crc_skip_count;
 
-	bool freesync_timing_changed;
 	bool freesync_vrr_info_changed;
 
 	bool dsc_force_changed;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9860bf38c547..7481801c6d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -401,6 +401,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 {
 	int i;
 
+	if (memcmp(adjust, &stream->adjust, sizeof(struct dc_crtc_timing_adjust)) == 0)
+		return true;
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
-- 
2.34.1

