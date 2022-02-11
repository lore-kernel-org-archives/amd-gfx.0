Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AEBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B1810EB3A;
	Fri, 11 Feb 2022 21:52:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23B310EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUzfiasUuTICuGF622NFoEfhFvGtHJIHw4UnIwdoRb81/rQQFqnGeh18wkGBxWOsfp8+2UuAV73QB2dy0MhLWewKA46r45qrWIEl/DQlu4jyESGUtiUtVajfl01wpnZzJnGMvhNF9YxgFS3fIyT0ZmyIZ/F68qCvpc+AxjNC+VuZCTDRryd7aZB6ircgP96tQqWGx6yaHiQNAltpo8oOSPwlyHQUQc8RX6/+9IYRlgBFLJAl7p/23jRzx5AFtgie6aTCkJRz8nT/zvPgLgBwjl/24hL+lasOLnKEg///iWIl9jK4cSG+dBwoko/2yVSTWiL3iJYklwIOgSUFh6px/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9j1+sYmV02uuvNDF60ij6sn/Ms/b5RZrRw6+8eJGAY=;
 b=KGjzt5w6vMTKFrfWZIkPLeyhTg8teLoHmJPFbxS+7umBRBWVXMZOCO1xzZaNab8wzclk+e600XFcm7zi0PSHRKOMwmOEu3kL0a18PQVr3QFh0/4jCh/KyhXMhKR2z58LwBiZV7XV3y7c5BNrXMuAyfWLeYgh5ZFMIcXbekNNHto6aa3Ov2XgbX6j544XEvOlpxWMLubdePDHoPTzQw79t9XiaIj5DyFU1Pn5BqqtLA2SxEVyxLwyOWmwyYRtU1uOurqZ78savuE87rQ8C6f3kf9VfIZb4LBYfe/xFXECXOZ8nAx1XxrJE23AbEvm1X9sd2pSVkEgi3KnbvrnTobTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9j1+sYmV02uuvNDF60ij6sn/Ms/b5RZrRw6+8eJGAY=;
 b=1J3NnyS83PsqD2MP+YHoncZYIhLD5GVyKj8Xcw/hdQh4AOTh4hfgz7J57MbEJdPLjcbZwXW+DmRuuq+SxRZf3avYCdxMZYz9y0kEpWzQe4sNJbykuvGy8IcsQaWIgd9T+3CihzZELPunco/r1AXXLIUQHVl5eCMNaQnkwoyUeDY=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 21:52:05 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::4d) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:04 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:51:59 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: dsc mst re-compute pbn for changes on
 hub
Date: Fri, 11 Feb 2022 16:51:34 -0500
Message-ID: <20220211215142.94169-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53aa901-3886-477b-1541-08d9eda8be1c
X-MS-TrafficTypeDiagnostic: LV2PR12MB5944:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59443EEE767AD81C5DF27D8DFB309@LV2PR12MB5944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFNSq/tlPCRiF9ZMWP7DS7HbAyIwyKHwwDgJ0UmdBgepQ9uKS4YIyDdzZGikkmvTh5Ps+KZmz+JDDYbHlg5Dwc+TQNkcyQvLEB7wRmwiB8y813i7O8kT8GBilDOsgn5MifTOPgczR3Z16wuHrJyNnuYYMOeY+owypIkM8VcIvmpETmeJuPe9Kea24bgpEKU7O071BLW3FxUS2ytTL2Jc5nVt2LhUd6NPr5VOFuydVi7ttwET6jA4qxw6551t0ou3LhtwlzNKwHPHgyHMItG7X3PhUeIyCdaAtLeF+tqkK8fX1MzJCPIu5CWvFXaS/G6hnyfLAzsy8jbG8RwNMOyncEpYDLeQV3HvOiVjB1NqYZsSxNsjbtIuSgRgU8W/J7lwDvxbtmpA8Ydhdc7k/rFSi1WxGBQoyzddu9VGp/jWOZ9rkITV2T0q+E8ard+o2WJHW1kSFlRcW2EoLsa+5PU9EbPTWhND9jBjxOMjPmzj4tsEdRQf8VyXdQCWcMZuynvYdYIfKMxfKZ3hkzdYuNkZOShdCjKHRxlzgsFI6RzdEoLQIgfDv7F6Vato2+G9+Rrlpw4EQkmmM3u/lRa7QKBDd6xQHgLthRkTZGs/T/Ykm/RLfRvI6woE+wLsFwXR8WR6uzLPxQMqml8ybVAFFe2SeX5WKnZa4RuxXfKWgxElzOXUJ9T87timNSwrmmtDbGeP+gs24zs1Ow4EybwI1HrtFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(336012)(316002)(6916009)(186003)(6666004)(508600001)(54906003)(82310400004)(16526019)(26005)(426003)(1076003)(83380400001)(2906002)(356005)(81166007)(4326008)(5660300002)(70206006)(70586007)(36756003)(8936002)(47076005)(2616005)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:04.7404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53aa901-3886-477b-1541-08d9eda8be1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Hersen Wu <hersenwu@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenwu@amd.com>

[why]
when unplug 1 dp from dsc mst hub, atomic_check new request
dc_state only include info for the unplug dp. this will not
trigger re-compute pbn for displays still connected to hub.

[how] all displays connected to dsc hub are available in
dc->current_state, by comparing dc->current_state and new
request from atomic_chceck, it will provide info of
displays connected to hub and do pbn re-compute.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Hersen Wu <hersenwu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 53 ++++++++++++++++---
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8e97d21bdf5c..914d59821c03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -911,22 +911,31 @@ static bool is_dsc_need_re_compute(
 	struct dc_state *dc_state,
 	struct dc_link *dc_link)
 {
-	int i;
+	int i, j;
 	bool is_dsc_need_re_compute = false;
+	struct amdgpu_dm_connector *stream_on_link[MAX_PIPES];
+	int new_stream_on_link_num = 0;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+	const struct dc *dc = dc_link->dc;
 
-	/* only check phy used by mst branch */
+	/* only check phy used by dsc mst branch */
 	if (dc_link->type != dc_connection_mst_branch)
 		return false;
 
+	if (!(dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
+		dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
+		return false;
+
+	for (i = 0; i < MAX_PIPES; i++)
+		stream_on_link[i] = NULL;
+
 	/* check if there is mode change in new request */
 	for (i = 0; i < dc_state->stream_count; i++) {
-		struct amdgpu_dm_connector *aconnector;
-		struct dc_stream_state *stream;
 		struct drm_crtc_state *new_crtc_state;
 		struct drm_connector_state *new_conn_state;
 
 		stream = dc_state->streams[i];
-
 		if (!stream)
 			continue;
 
@@ -938,8 +947,10 @@ static bool is_dsc_need_re_compute(
 		if (!aconnector)
 			continue;
 
-		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
+		stream_on_link[new_stream_on_link_num] = aconnector;
+		new_stream_on_link_num++;
 
+		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
 		if (!new_conn_state)
 			continue;
 
@@ -950,7 +961,6 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
-
 		if (!new_crtc_state)
 			continue;
 
@@ -960,7 +970,34 @@ static bool is_dsc_need_re_compute(
 		if (new_crtc_state->enable && new_crtc_state->active) {
 			if (new_crtc_state->mode_changed || new_crtc_state->active_changed ||
 				new_crtc_state->connectors_changed)
-				is_dsc_need_re_compute = true;
+				return true;
+		}
+	}
+
+	/* check current_state if there stream on link but it is not in
+	 * new request state
+	 */
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		stream = dc->current_state->streams[i];
+		/* only check stream on the mst hub */
+		if (stream->link != dc_link)
+			continue;
+
+		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+		if (!aconnector)
+			continue;
+
+		for (j = 0; j < new_stream_on_link_num; j++) {
+			if (stream_on_link[j]) {
+				if (aconnector == stream_on_link[j])
+					break;
+			}
+		}
+
+		if (j == new_stream_on_link_num) {
+			/* not in new state */
+			is_dsc_need_re_compute = true;
+			break;
 		}
 	}
 
-- 
2.25.1

