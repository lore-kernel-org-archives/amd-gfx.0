Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6A3C43219
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF8910E272;
	Thu, 24 Nov 2022 21:14:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A2910E26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN8cqwtfq4tfIfCzs6brefJc/i2sg7MwJik+ujoz+gzu6jMqyv9NtlvYd0+SqQFfu195z9Xy0iwzIMCHvwGlaQcIGhEZ22Fpq1nLdQfe0Fs3/psezza+hPC16Enl0EqVipUuXjnpQztUTdPHVnH9oSjJ0lkL+u1/5QZC/dDHgBHaLIeI4y84WLo/PdHIcWwqdYNZ87SVPah9yjVrCRmHRIN5pgacO6y0Qyk5itdSs1zS7FPqIfTBxJoR/0SFGiGuUBlQySiN6h+vrc1YajET8uSvrfM7KONoVrdvQ8essmWDUv82/YorKdHJ4ZEi4vbjwMUJgEeE8U71U5qTCgcdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biqySNT4+VKn2IGhajBlwMWX2P5teVdqy5qlMwP4pyI=;
 b=bUlnz3b0eYdHCG5ZhTXznghlpgMxhcLOx1IZnfeSqVpUDu+PEbPVHw67HSMY6d4mb+rprD1oo5jV5KQhUI4q21aKjmtpdxnDeaaKQHp59HIE2Iy9GR9cDWol5Z8jEbuo6AvrXGhbo+vXAkr/RQK4r+/cOb89n47QJl6NGdTdWcv14hIfPcEgJzf1Kme0uQKFvsDbScIxnPRTZe3CEigrl8QjDsXR1iNGaXvnhAcRO0ewkFrzJRAxjqVkhR93SJx4THTekzWyMFRgEoa7N8KQlzyfFd8pvwxWZwxUAIc+SCRPw3ecrSc2oHc/NWCQhcuCsDRTks305poqc7qPddfJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biqySNT4+VKn2IGhajBlwMWX2P5teVdqy5qlMwP4pyI=;
 b=JoOhE4Js/XLBAzWvED20M2Le+6FBPKndudJRzyHx/UBh/2QZASOjkBepU6XHFK4LlKnAWJMOCoTHvMoX42KrjcqAndZM2nYqxyjl1nnLyxYPxgpXtXkkdbIWNALcfi202I/LHc8Z1cfOV2PtQgJ8ENIQurHkDwmbPIMSBHyex8c=
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:07 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::4c) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 21:14:06 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:05 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Retain phantom pipes when min
 transition into subvp
Date: Thu, 24 Nov 2022 16:13:42 -0500
Message-ID: <20221124211348.214136-7-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CH0PR12MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2159042d-ba2e-4ec9-a2b2-08dace60d265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7YRdEPTHH61sD3z/pM7hfajp+lETZUuLOIwbj5Y12snXE5j80Jli7P4u4OwYWBUZT75IIjBHU6rLOUxuXafsGaPoqlyT3wuoyCs4RCEm5BC86hBPzBYP0xU98USHCbTKFvSGMG847iO9zqyQm0isL6BJauWLulU7L73auoOcrxt1/+FrmDYuYkDDMLrRuCPeR6L5w6V92Axqt83rYThWeh70RG0H04qSVVA98VOYWJSEJzA7p2e7FklhYp1d5CNcecS2fBTka98xQiRQSJvPLopj+ItlKQCp+H+s3ECMHfVMiDQcSHlWx392dXFGNdCNGuuAzmM+Cf69YkVoew2VNSwP2WXrmIXbG4X3N9Z4Il6RSGfpnETqUJsw3axKvpoN5IrPxgQ6W+lM7G7rgBT1pX4Eo69UsQ6gdGPEhBMTuz8C/hMScEo3ilhoqFju5dquTSN5ZxVvSiA0WQRTr34kdY1zAp+YLY4wk/2Pm1h6vNCrwmGVWSLnfWsQu68BBjgOb7dUVrmwCvAeun7q3Qfyh2Fpn1uuxYgwHAP4mu9pD2OiTAvXp+974Tp1hDJH/5nzfX8mHa7elvrCk9ZSOkeGwWU00128BpJp0ENSgq/nk0DmVQCuKJRSJdqMC8sPzDyqS6WcVzACoUXPMlCdCkZXxbpoCPiI+FHXnaP40I2llpe9AtrcSw+W4bdS6Ms7wVl1gPEk+kLmTcBEln7Qhe/oG0LWXFsceQtk7c7IyZr1EI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(5660300002)(41300700001)(8676002)(4326008)(8936002)(70586007)(70206006)(2906002)(6916009)(54906003)(36756003)(47076005)(426003)(83380400001)(478600001)(316002)(16526019)(26005)(336012)(2616005)(1076003)(82740400003)(186003)(82310400005)(40460700003)(36860700001)(81166007)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:06.7936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2159042d-ba2e-4ec9-a2b2-08dace60d265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When entering into a SubVP config that requires a minimal
  transition we need to retain phantom pipes and also restore
  the mall config
- This is because the min transition will remove phantom pipes
  from the context (shallow copy) and not restore it's original
  state
- This is just a workaround, and needs a proper fix

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 ++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 ++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 11 ----------
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 ++
 6 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f9b8b6f6fd31..a7bfe0b6a5f3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3954,6 +3954,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	struct dc_state *context;
 	enum surface_update_type update_type;
 	int i;
+	struct mall_temp_config mall_temp_config;
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -3985,11 +3986,29 @@ bool dc_update_planes_and_stream(struct dc *dc,
 
 	/* on plane removal, minimal state is the new one */
 	if (force_minimal_pipe_splitting && !is_plane_addition) {
+		/* Since all phantom pipes are removed in full validation,
+		 * we have to save and restore the subvp/mall config when
+		 * we do a minimal transition since the flags marking the
+		 * pipe as subvp/phantom will be cleared (dc copy constructor
+		 * creates a shallow copy).
+		 */
+		if (dc->res_pool->funcs->save_mall_state)
+			dc->res_pool->funcs->save_mall_state(dc, context, &mall_temp_config);
 		if (!commit_minimal_transition_state(dc, context)) {
 			dc_release_state(context);
 			return false;
 		}
-
+		if (dc->res_pool->funcs->restore_mall_state)
+			dc->res_pool->funcs->restore_mall_state(dc, context, &mall_temp_config);
+
+		/* If we do a minimal transition with plane removal and the context
+		 * has subvp we also have to retain back the phantom stream / planes
+		 * since the refcount is decremented as part of the min transition
+		 * (we commit a state with no subvp, so the phantom streams / planes
+		 * had to be removed).
+		 */
+		if (dc->res_pool->funcs->retain_phantom_pipes)
+			dc->res_pool->funcs->retain_phantom_pipes(dc, context);
 		update_type = UPDATE_TYPE_FULL;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e0cee9666c48..dfd3df1d2f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -160,6 +160,17 @@ struct mall_stream_config {
 	struct dc_stream_state *paired_stream;	// master / slave stream
 };
 
+/* Temp struct used to save and restore MALL config
+ * during validation.
+ *
+ * TODO: Move MALL config into dc_state instead of stream struct
+ * to avoid needing to save/restore.
+ */
+struct mall_temp_config {
+	struct mall_stream_config mall_stream_config[MAX_PIPES];
+	bool is_phantom_plane[MAX_PIPES];
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 99ddd2232322..06489df85ac1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2055,6 +2055,8 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
+	.save_mall_state = dcn32_save_mall_state,
+	.restore_mall_state = dcn32_restore_mall_state,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index c50bb34b515f..4e6b71832187 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -45,17 +45,6 @@
 extern struct _vcs_dpi_ip_params_st dcn3_2_ip;
 extern struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc;
 
-/* Temp struct used to save and restore MALL config
- * during validation.
- *
- * TODO: Move MALL config into dc_state instead of stream struct
- * to avoid needing to save/restore.
- */
-struct mall_temp_config {
-	struct mall_stream_config mall_stream_config[MAX_PIPES];
-	bool is_phantom_plane[MAX_PIPES];
-};
-
 struct dcn32_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index b66fe62cbd99..3406e7735357 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1622,6 +1622,8 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.remove_phantom_pipes = dcn32_remove_phantom_pipes,
 	.retain_phantom_pipes = dcn32_retain_phantom_pipes,
+	.save_mall_state = dcn32_save_mall_state,
+	.restore_mall_state = dcn32_restore_mall_state,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index aac1b3989c95..40a8096a6ccc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -243,6 +243,8 @@ struct resource_funcs {
 	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*retain_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
+	void (*save_mall_state)(struct dc *dc, struct dc_state *context, struct mall_temp_config *temp_config);
+	void (*restore_mall_state)(struct dc *dc, struct dc_state *context, struct mall_temp_config *temp_config);
 };
 
 struct audio_support{
-- 
2.34.1

