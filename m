Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C602AC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D44493967;
	Fri, 22 Jul 2022 20:39:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79CF931C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHpcLzSUt24qKlS4W0WpmlXjVonwcAZ5374XOb5s28DaT4tk/PykLGS5m4oiZYk5xzGvuIneZF3VsiNWJCbC4g6z4RA0uePra/nMDVsBxkzMOyIeohq4O8a9KDCbRtI3W+sGC5/eAiewT3GftboGXCwruLH7ryXCwUKykjzhliuK3SjsbS1cTCdOY6LsxjIl9GeBl4sV/gNDh4NVdaZbHeoF2vUj93rCOL90r2X+hiEpKkA2yaiQAZ0F2QDMmrSE1puAccDWkNDpi5Lg7KM5lQIYeLkqAhbm9IuRBP7Sr6nTNVP9XN3+rqcwzvfIaoIWRRmZ2NomGnxo2HuBxjEO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btXAF++DPm0pwfziNw7A/LWQnQ17D7JRxkjOQpy3HqQ=;
 b=Mn6WtsuunfTyOF9BFLkwb7y6bWfAXXo4KOUwyVuJxwF246o2gTpRgrjkOTWcsTPpSY3nDU9OXZr9I/HYCNuoaneWsHgBaUwX83FZcv1SmfW3L4Rj91bkezLeqawCqQVazMH8jcUE+C/Mkq6YQsAdPeb2/HqgYWkQt4ao9XedSTyajbcYmcMdmMgqbpFbGlHYuVdHPVAhZQWbxKZ5XZ7VUlbMt+pIkcdJiZ5+U71OfR3ID5wUlnoEvjnNEGMClG8QR6JWCnhOCNuVo9R0CB3pQMMLPFg1grzrFnTPbQI80xUj1v7B0DdQNVIo5R+IEMGmx0beZzkIwZUVlkGs+pNwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btXAF++DPm0pwfziNw7A/LWQnQ17D7JRxkjOQpy3HqQ=;
 b=sdLfhhiQUsygcPAsOR3jANPTD8sHR4osoevyIWC3yO8oJDPb5vlj+dPCo3edopYmp6MSm4FLXs1GYzzXvFslZKNG9vJw/SrGV5UCEgiHJ+WGLQppvCIRR6Y72VuFD2zkycZadU6gflIKczbupYWlDUbzQCVYLkl7cHR7vOaJZkA=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:39:47 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::8c) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Fri, 22 Jul 2022 20:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:39:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:39:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/31] drm/amd/display: Reboot while unplug hdcp enabled dp
 from mst hub
Date: Fri, 22 Jul 2022 14:31:15 -0600
Message-ID: <20220722203137.4043516-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5654a0fd-e8e3-4193-960f-08da6c2250f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3969:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ba6V91WU65Ti5uJ/qYLY2dlDGK6UoG2CTrnfG70KeHBpl79bHoQhFmFxTYqcdTYAZZlvJrhaxtUlMLilydjLpj1eLnTol/SLo6gd78GofR8ogOHqZUWXVfdWSkPHvCxE8CZVNIQklW6jZSfcznVZ9tyHLbrX6zCYd/4QvFLVMSGPl92F6IiVuXaPfxRM/R3y8R5G5N/TiAZ9habg9SDlFP++2ZfpXUx9kAG8NSZL+Hlvst1QA50PP1dpm585/DkAgvq3GwzyzB+dZIMW2zEzZa68EwSLtLbXX3O7DcWRoEMcE8iHaJuaCRK0mlelraHBEIQTUUKqa7kdxAWl0tYs2jVYI9JQm27hmgGwzZN9xyG9hyjQxMYNTsehzXMI1U/+B7+WQ0rZDf/P2suompPwaeYv7uQ9JSvJCGsdY+LUyJbTJ9JZZyzNfRXZbut9wYNkcwUDfa0XBtt4UoKa9mpqI3oXbpYEn2gPcjs/ML/3KOAJdSWcTTW6n4h3T02eyYZ+4TsGxfiUZCNXihovAgsOa76z6Vzk5n8MBNDcvrr6r9u5SK9dQKr5lkpbhnxGMICJSYpPcDlXZMHhkc2b6Q+LgDWVJK1w8Go4sukOliqQu+ye5jfxNhkd1nom4unZ4B3+l9yiAAbVKzxIWp4omWQ72S0xQOnOsqEhMREmPLMuboEP9o4UdW5UjpRTMe3lnKCqeAwNOtXdJbibpdTNrTT2L3ID+LYlQLz1FfOjorKSFyU9aLB9jF801+2nCrsPrFq727wTX0pK8PaoqpzWAJPDa6+y209cbMUFhVzm3E+oYv9axm9mBZx/nh8P6BKnBOFgo47phOK5m7ZpEhZvI6yoRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(40470700004)(478600001)(86362001)(7696005)(26005)(40460700003)(70206006)(41300700001)(316002)(6666004)(40480700001)(82740400003)(54906003)(356005)(81166007)(82310400005)(4326008)(16526019)(186003)(336012)(36860700001)(2616005)(83380400001)(47076005)(1076003)(426003)(6916009)(8936002)(5660300002)(70586007)(2906002)(8676002)(36756003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:39:46.7628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5654a0fd-e8e3-4193-960f-08da6c2250f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
event_property_update does not check NULL pointer

[How]
check aconnector->base.state equals NULL

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index d76c8dfaf3f0..331dfb66c765 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -302,7 +302,7 @@ static void event_property_update(struct work_struct *work)
 	mutex_lock(&hdcp_work->mutex);
 
 
-	if (aconnector->base.state->commit) {
+	if (aconnector->base.state && aconnector->base.state->commit) {
 		ret = wait_for_completion_interruptible_timeout(&aconnector->base.state->commit->hw_done, 10 * HZ);
 
 		if (ret == 0) {
@@ -311,18 +311,26 @@ static void event_property_update(struct work_struct *work)
 		}
 	}
 
-	if (hdcp_work->encryption_status != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
-		if (aconnector->base.state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE0 &&
-		    hdcp_work->encryption_status <= MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
-			drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-		else if (aconnector->base.state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE1 &&
-			 hdcp_work->encryption_status == MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
-			drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-	} else {
-		drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_DESIRED);
+	if (aconnector->base.state) {
+		if (hdcp_work->encryption_status != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
+			if (aconnector->base.state->hdcp_content_type ==
+				DRM_MODE_HDCP_CONTENT_TYPE0 &&
+			hdcp_work->encryption_status <=
+				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
+				drm_hdcp_update_content_protection(&aconnector->base,
+					DRM_MODE_CONTENT_PROTECTION_ENABLED);
+			else if (aconnector->base.state->hdcp_content_type ==
+					DRM_MODE_HDCP_CONTENT_TYPE1 &&
+				hdcp_work->encryption_status ==
+					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
+				drm_hdcp_update_content_protection(&aconnector->base,
+					DRM_MODE_CONTENT_PROTECTION_ENABLED);
+		} else {
+			drm_hdcp_update_content_protection(&aconnector->base,
+				DRM_MODE_CONTENT_PROTECTION_DESIRED);
+		}
 	}
 
-
 	mutex_unlock(&hdcp_work->mutex);
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 }
@@ -495,7 +503,9 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 			(!!aconnector->base.state) ? aconnector->base.state->content_protection : -1,
 			(!!aconnector->base.state) ? aconnector->base.state->hdcp_content_type : -1);
 
-	hdcp_update_display(hdcp_work, link_index, aconnector, conn_state->hdcp_content_type, false);
+	if (conn_state)
+		hdcp_update_display(hdcp_work, link_index, aconnector,
+			conn_state->hdcp_content_type, false);
 }
 
 
-- 
2.37.1

