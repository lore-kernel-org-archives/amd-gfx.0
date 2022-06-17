Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7002AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0926910F2B6;
	Fri, 17 Jun 2022 19:35:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8CA10F2B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEImPshPViI7Us/F7uuo0RHU273knigYl7FpYV06oyhL138ttpVb/bkiuU53noINQPYvadgwH4oE/RDJ8y1yabQ9KNZxphTQJF19zDU6YYUigAVdY3pWnJbRXyKScaHgaJXD+epp9hSmdJLlDX7saIjaR8k+5kXbowN6VxYLnGBJRdwhauo9UdNNyxh28xQdcC+UJ8SLGMX+szQM8m6vI/yGWsz4uiJRg8dKrvDMBTHfvS29Rk+TuwcNqBPMQRGFGeyhI68ubGlXZVSwQn/y2XtMHt/HYD6e5FOMUgS3uHMGdO89HYnzUIB+EKNstcBJzA6DEIKmnr2akRq627/hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnhUeWB3bztCCPn/yUM7M9YBEHn+jIFbgIuoYxpjMWs=;
 b=NG576Pw6aGX6m4xWAjKeuP9xTYZuyW+vn9v4D4I4OrGkSfTOrtMARSDWVSbehVkq/lp9V+9C47wPOoDysB+LBreaQZNh5injmA2S0cNf4CYmtFEgVVrTuHAPuxb8JCSBbb9YZGUK2+RIh3uGa5j5f2HIy4yIisAjmZ/m5isL4HDI9zfbJAzFJu+hGL9qeIKQWSJArF2cvrg3I7ubLzJHZJCQ2jnAiapKjXzydY33IM4fd4C3LD3XU2mwCulku0Mb7huwut9jRAhGOff6A3rPbuTmd9ngpe8+XSjvK9+mr3CjipX5L5ShHMexTQzdgXPM5ekUT9FK94p9IxFDt9O37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnhUeWB3bztCCPn/yUM7M9YBEHn+jIFbgIuoYxpjMWs=;
 b=hk8fHJSxVL6683TQwYVnFA8yCqHlY4TWBA7Fu1HrgxSYvGXQ3Amw026QVwogHwSSLglG9sJqBoFkOcvvbGWtOXvjayQuLvNgq1dzFl7YbE1yPIjMwu0ovJLzyGppAoe21v6KZh/DV15Fwv1wemLZV+R0Gk0GBNDT6dS2AojGDJI=
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by MWHPR1201MB2478.namprd12.prod.outlook.com (2603:10b6:300:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:42 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::bd) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:41 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/31] drm/amd/display: Take emulated dc_sink into account for
 HDCP
Date: Fri, 17 Jun 2022 15:34:46 -0400
Message-ID: <20220617193512.3471076-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef8d8bfd-4786-4e2b-817a-08da5098906e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478D553647128E33CEB6EDA98AF9@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RO8miNsG1p0aNXDv1wHVN2Kc+OnIf20mijJZmLn7bhq2tS7ZJEk/cBI2XHWtm6n+lhk4LRUenJBhBTdBE4HCXkYICe3H64/BA7SyxDp2jQ8r+YZtrAh104IsTAIfhKdSFdXYk67ktavNJzWrh6Ps7Y7MB1o3+DFFX/fBNw2gI5+zdLo/9Y4FhFWJaKgosixRXJPRJoDL6CJiL3GgycqImi68tg6qQjDM7BtO61bllyoe2P5Xggm4AGoEbMa4ID9pu7LgUkh1IOFq6FJUG7/j37YFaJEwrSHOsJfBAGLKcP2CPQOb6yfjomTgt5/+EZ2bkYqFc130Awp1Sv5LSs5Pd9mamBGAiCS+8uNsgVXElCt+CqxhWmtocWMuIqmL4BOTiUaZpz3oROQU9hqEhGg7LWaNdi7upQZqp1V9epxhLNIHmurUwi/FyqqcKGIijA2ERYanLLDP0JNNHWnsqDGfFoAZqNZ0PeC8Kh+5zJd2LwvtN0raPkL8C/5iPql6xi3FGVUOWsx7UUWmLz18KpTqEPBOcQxjg6Vb4fiMeS1J8LqbL6pjGgVDxbVdFjxVqegbVZuHre5ax8YBbWK3OdjCPTi5z08wspDVghKyINeZ3QGvU2drvHrQmm1FS658InwG3F9qrXMwEG3YvGXJb2Km5CFrpA/GxJom3mjbf5TI0VWcN8QEfw7YRlIHNmBb8rkp3xc4+Vd2vLWNzIIPhrbygg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(336012)(54906003)(7696005)(15650500001)(2616005)(86362001)(82310400005)(47076005)(16526019)(426003)(186003)(6916009)(26005)(70206006)(1076003)(5660300002)(40460700003)(316002)(36860700001)(498600001)(8936002)(36756003)(83380400001)(356005)(2906002)(81166007)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:41.4133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8d8bfd-4786-4e2b-817a-08da5098906e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
While updating the config of hdcp, we use the sink_singal type of the
dc_sink to decide the HDCP operation mode. However, it doesn't consider
the case when the sink is a emulated one.

[How]
Take dc_em_sink into account while updating HDCP config.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 236a5ebab5ab..71e6d98410fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -448,6 +448,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
+	struct dc_sink *sink = NULL;
+	bool link_is_hdcp14 = false;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -460,8 +462,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->index = aconnector->base.index;
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
-	if (aconnector->dc_sink != NULL)
-		link->mode = mod_hdcp_signal_type_to_operation_mode(aconnector->dc_sink->sink_signal);
+	if (aconnector->dc_sink)
+		sink = aconnector->dc_sink;
+	else if (aconnector->dc_em_sink)
+		sink = aconnector->dc_em_sink;
+
+	if (sink != NULL)
+		link->mode = mod_hdcp_signal_type_to_operation_mode(sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
 	display->dig_fe = config->dig_fe;
@@ -472,8 +479,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dio_output_id = config->dio_output_idx;
 	link->phy_idx = config->phy_idx;
 
-	link->hdcp_supported_informational = dc_link_is_hdcp14(aconnector->dc_link,
-			aconnector->dc_sink->sink_signal) ? 1 : 0;
+	if (sink)
+		link_is_hdcp14 = dc_link_is_hdcp14(aconnector->dc_link, sink->sink_signal);
 	link->hdcp_supported_informational = link_is_hdcp14;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
-- 
2.25.1

