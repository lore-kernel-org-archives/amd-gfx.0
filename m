Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE18CE936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D8310E3B8;
	Wed,  4 Oct 2023 21:22:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF3710E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAgHxE2OQuGs0vbpK6uqRdsR1o6Q5hiXQ/FI3ZP8B6LgBPjWOSYeWKj54cD9fZ1mFerIM2cRdQ/QLq5XxGA/yD7ZMTLP4V3cdKUMWNhoJrc4DcDfzEkTKJ7KNGDxIspp/PXrc5agGzmW81eu9wQAN/mYg/oCJZWs3NPIyBSiHBSgcTYQ5qKgYzFFTBle3gbVhVh50pM2JQ5wzp4B8nfs/tAwU/KFGTdMAoElcb5IYk8EyiqJKTPVW5i8hgLKkGgUZDNBQ/sLx3/UnwDEg7xK23RaxV6Cwea4pJbDS6xV+bKsSfu5v03NCqAz4r5fsUneM+VNQ3smWpPh92uEtpid0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSoAH/9z2Xp67JFbS8szX3mbVzYut/WvparftGonVDA=;
 b=SuoEI+qQEoqjnr3C4caveonT253RtmlMQGerpBUYEDVv+N6f1rAuxC0wTlcGEYnHfjapmlYotIYRcsuKSKZiKAwBYm6CfVufWoTBJzB0A99Fonxbzz0eCUKehfMaDP/nIo6tTS2yU/zMcjn1wpgZpVdcPCYiRfg6hEJAMqgVpUJFlWUbDsDh5i3JvStG3kaR1l8n58aUd5XPvkdqiulvQLXuXWlCAPfdw9a2ORoakeaqsCKaXFUu1glW5ExZzo9DsslgT8DMU2brJqiXyS7mLcBfiGA+WoRWvHpFu34yhMhShP6Y6dprJfGhKL4xsqdDiCBo/A5fyo5XVZ9eT75FUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSoAH/9z2Xp67JFbS8szX3mbVzYut/WvparftGonVDA=;
 b=0mze+0NX+/xCOgI+s4juJCYcYu8eHTAx/AIT0tpCsIVttXHwtqk8J+M2odVNwAKSyO26Boruqn/WHjPUwozJEHPyzYAysJSkNEUzXF7VLO9rIFcEmu/ZQFgT3RgcpaUsFFn2/cJ3JwXFB3+Rh5QS7pv6CcE0yZmRWWWQuT50zI4=
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 21:22:08 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::ac) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 09/16] drm/amd/display: Use fixed DET Buffer Size
Date: Wed, 4 Oct 2023 15:21:03 -0600
Message-ID: <20231004212110.3753955-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1e3c30-b3e5-4bca-b60c-08dbc51ff6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQOAG9P7mWEON9wgPoKa5w1ecZ3ZbNEmKzFkia4aK5wcsXmBOwXYskZ/dOvAsflAeWHwxZk/b861pVYGpGjDU9acDNQbunpLuMG8tngmly5emVkcFr0/8TbjJHespzW5SFmod+GDx/I9EV5ucb045y/Ro7yqMMv+FtKwigLHfytEU4zvvX0X/+2hSjNgSdM0ZPO/JlaMbIBWYwKpOJ7GMI/loL2eqC1aoeej8iUBOsAZNMzuaoqeTolZso5uFE/KQdcp1wyigWiKddG/O4QHLJImxM5FLOdkTV+zbAyn/F2Xcn1ycUfd34qWjT+R8Dn2mDQcyVHTPyIYzhpsGesRSwvp8J4/FLVBb8kvpuU8RfrmhhAQDDUPITA3GqDWkl5m40D7sZhV/GiC2DFoIPLPQXcYMnLqMptk9N07U4UIUkmJAsyx7a+b9Te0OdNQzb//JMOY98rRT5M6dYOKieA4XFjzRkqKvIbg9gqKzVhi+qhAk+TajYKwmXZIVFOTDMKKNtIZp1fyAtZmW9wWcWsH5wFRmy1JT0EDYFlAbz0XK5T3TF8Lvqb1K1UKV7arNR/mumSgQktaFc8zcVXD09Zi0JE/MQH5Y+AGoskzstWp6cjiFWS+DYN7tgArVfeUdZsXVkKrNDrYDgHmHY1YHbEM0pWwgau2IHJFHGmcHPjthdnQi4Sw8OQ5CoA/12u/gSbOJNIu/hqgM3s2nUc0DiqT5J6qVa7L1x8NMOROsJRHQ9SyK3GZJSQZL7ZJSj41uFU31/VBNT0usMaSxBXaidtzdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(426003)(336012)(40460700003)(2616005)(1076003)(16526019)(26005)(36860700001)(81166007)(356005)(82740400003)(86362001)(36756003)(40480700001)(316002)(47076005)(83380400001)(6916009)(4326008)(8936002)(54906003)(5660300002)(8676002)(41300700001)(70586007)(70206006)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:07.7509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1e3c30-b3e5-4bca-b60c-08dbc51ff6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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
Cc: Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com, Sung
 Joon Kim <sungkim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Regression from DML1.0 where we use differen DET buffer sizes for each
pipe. From the spec, we need to use DET buffer size of 384 kb for each
pipe

[how]
Ensure to use 384 kb DET buffer sizes for each available pipe.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  3 ++-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 22 +++++++++++--------
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 2fa876d9e1f7..e2f3ddb3f225 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -2078,7 +2078,8 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
-	dc->dml2_options.max_segments_per_hubp = 18;
+	dc->dml2_options.max_segments_per_hubp = 24;
+
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 946a98af0020..4c3661fbecbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -414,17 +414,21 @@ void dml2_apply_det_buffer_allocation_policy(struct dml2_context *in_ctx, struct
 
 	for (plane_index = 0; plane_index < dml_dispcfg->num_surfaces; plane_index++) {
 
-		dml_dispcfg->plane.DETSizeOverride[plane_index] = ((max_det_size / num_of_streams) / num_of_planes_per_stream[stream_index] / in_ctx->det_helper_scratch.dpps_per_surface[plane_index]);
+		if (in_ctx->config.override_det_buffer_size_kbytes)
+			dml_dispcfg->plane.DETSizeOverride[plane_index] = max_det_size / in_ctx->config.dcn_pipe_count;
+		else {
+			dml_dispcfg->plane.DETSizeOverride[plane_index] = ((max_det_size / num_of_streams) / num_of_planes_per_stream[stream_index] / in_ctx->det_helper_scratch.dpps_per_surface[plane_index]);
+
+			/* If the override size is not divisible by det_segment_size then round off to nearest number divisible by det_segment_size as
+				* this is a requirement.
+				*/
+			if (dml_dispcfg->plane.DETSizeOverride[plane_index] % in_ctx->config.det_segment_size != 0) {
+				dml_dispcfg->plane.DETSizeOverride[plane_index] = dml_dispcfg->plane.DETSizeOverride[plane_index] & ~0x3F;
+			}
 
-		/* If the override size is not divisible by det_segment_size then round off to nearest number divisible by det_segment_size as
-		 * this is a requirement.
-		 */
-		if (dml_dispcfg->plane.DETSizeOverride[plane_index] % in_ctx->config.det_segment_size != 0) {
-			dml_dispcfg->plane.DETSizeOverride[plane_index] = dml_dispcfg->plane.DETSizeOverride[plane_index] & ~0x3F;
+			if (plane_index + 1 < dml_dispcfg->num_surfaces && dml_dispcfg->plane.BlendingAndTiming[plane_index] != dml_dispcfg->plane.BlendingAndTiming[plane_index + 1])
+				stream_index++;
 		}
-
-		if (plane_index + 1 < dml_dispcfg->num_surfaces && dml_dispcfg->plane.BlendingAndTiming[plane_index] != dml_dispcfg->plane.BlendingAndTiming[plane_index + 1])
-			stream_index++;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 4d0377354bdd..f3b85b0891d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -137,6 +137,7 @@ struct dml2_configuration_options {
 	bool skip_hw_state_mapping;
 	bool optimize_odm_4to1;
 	bool minimize_dispclk_using_odm;
+	bool override_det_buffer_size_kbytes;
 	struct dml2_dc_callbacks callbacks;
 	struct {
 		bool force_disable_subvp;
-- 
2.40.1

