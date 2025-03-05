Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1678C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5142C10E6DB;
	Wed,  5 Mar 2025 05:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gpawq+A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258CF10E6DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irKkUVdRzjavcgci53rxr1agt6hqVqisOVegeXviRe5s+W+3CDTZ2Br6Q/NbYv/qV9KK0E2VSDxn+ULHjk/MrKCaTwkzNcsdTyRW7mGEXU6q7N1bhPMDSroYYFR4jV9E9tCMr0mqtUtZCUA4N6oiPDbw2IvEaPPcf+MlSOmmfIpLJhoYURaTpCEcOeo3AT3OqLDjFEUInbAoVRrZegj5HueQtoyYuwf1QYiUCl5upqxbQ4aeR/32KQjmFJ5kmhQAzFAtsxCfX8lzemZyEHiSwyQJfmXejq0TtevidzAZ2GGUut71Fz5j+K6owIzGFj8jXbX7Ns/q0zXcqOp4St9DQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dxlxehqom7ooKvFS7Hedr2Py7TGcQBO37rfnorMRiU=;
 b=Q/HC6fvImAMq1rfU5niTYUrmUyr8D0WlTztYdYfEO7lCk58xFVhnPOOjwRFZ/wSuVSfUKZFBo8WxyEmKJHuUc0aY6bwmW3RI+KMPjzMcs7VIYZoezwV+6LsqTvUCwp1ZNPiUJM8wQMOhuqDVdpNVFMHs8zlfxON7XTpSXVP/oyhE3aPIye4CZF2406fCJ6Yq2ykhPwOaxcKQa1Ncv/WJrr6N2Jn5GH9eymOPWMq5kBnM756eYDu42/InisXuQR90iIxIWKhK5q4RE52E/6sJsfFTcfhRZr9dlrD7HZsQJVyiMbczn9Ee2PLIkaJ6zsiq0S809mGF/BNAR5r1wWRFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dxlxehqom7ooKvFS7Hedr2Py7TGcQBO37rfnorMRiU=;
 b=1gpawq+AlGNzHXM4UbSxODzn2uLsWuFJVvN+LNgcH8nWDg3ALe64yrNTdDyfd3XhLNAoifF4SpzqcEsvuyoc7hNRAz/w8NOKieZ4HzKw5HbdmzPc0iFbqLO2FfV5YVGuyoNe7gAiUZxzNl/NmYfA2OqHio+/dvUFuJepSgQu6DE=
Received: from BN0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:408:ec::17)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:15 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::6d) by BN0PR04CA0102.outlook.office365.com
 (2603:10b6:408:ec::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:14 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:17:11 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp
Date: Wed, 5 Mar 2025 13:13:59 +0800
Message-ID: <20250305051402.1550046-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e1fd71-746f-4e53-4f57-08dd5ba4fde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q6RT7YmBsyjt9EsgpoIbFgJBO3GaLfc63Vedf9JLDxTAmh3DXlpvDm9HasFq?=
 =?us-ascii?Q?OPwThSlgcfWTxfQnoS8xgr4MSwOEW3ZO9ig9w+6p7UIyth+Oc3d4SR2vVY6H?=
 =?us-ascii?Q?YgGSPSsYyRDqptN/b1SvDqoAaIhxNeoCF2+1NuwZWseB5VjLdQTsXxape2y1?=
 =?us-ascii?Q?/YRWc8ua4vErLl+zfj8MFIeU5QTU9JfesGF/pTK8E62309ySOpDIP8QdXtQK?=
 =?us-ascii?Q?zdWD/RopsG1lxm/02cjEAsuFcIHtBYFhONylPH5XyDaaXzIWFvVrcJYyuL4B?=
 =?us-ascii?Q?ygAsRw6A2X+Paoo0C+EgYM8+juE7srrSQvFBReWkzcjcz0MrD3t6LFP9zVEY?=
 =?us-ascii?Q?w/XwjT2Eu80eHsfYPUe/K/fF2HrpdZBzIT4ohi/kg8gY2OS6kteVprDB4WrF?=
 =?us-ascii?Q?XZ/Onc0XEN93jt7KZeAvZ8DWk1Mu3miVqrVLm6R2/c7jwGPrpzWSi3r87o2p?=
 =?us-ascii?Q?nyoU3gmLes2o5zYP6ac2QiD1P5PyPK0pZVGaFJ5O+LP7LLQ3EsqJCGXeGbPt?=
 =?us-ascii?Q?Ap1cFtHyujK74rh51EFu2LWhA/QtjyhtZA1gZzLwYPN1CZ7qoUOGDRsNqjFF?=
 =?us-ascii?Q?QOCvu4Aas7siBVucpRMOM7z2/nTOiazQ+Pr0PrEFsRUt/h5eIgie0trRhgt/?=
 =?us-ascii?Q?4mZzx3yXt9FlkhkJeBzNncOmc+kixhZakCZw3zw3pDOL1xmbEw/waAt97Gqu?=
 =?us-ascii?Q?JbxXa5aUKBD36Mw9/iz8g9LqyvCO+NNUaugtrkS8hdAEiT9RagA1qyp3LJnK?=
 =?us-ascii?Q?jHCzmBla2Z6muDh90PaaCRP/ORebG1EnN/4sHH9fetae8bb3Ys82A90MxQ5/?=
 =?us-ascii?Q?um+V1oCZJOPVGOIUjMW1rRnDy2X8l/wRA1krr2iGeqHYzboGS0/O+1K1SYzV?=
 =?us-ascii?Q?o0W2VmWIlPew/f2wNntvo/wS+WVAsoVtbtNhBEMGGo0BmXpegKGFqf2H/JbI?=
 =?us-ascii?Q?rWkEXo5n2WQmTFr6kfaoQdZXG07IHyD39y7OCnJX1sMdencmj5VTwYahcF1T?=
 =?us-ascii?Q?Be87sOk4vwm26Pc2WMoN28wgNJsN6BbJicd4CTlWhXjd0enEBow/Yz9DsUCd?=
 =?us-ascii?Q?TIK6NfCoKBd2/WKWvTeg/fnG6rWg79qQOPcXtML8wVWuGnhs1BIekFv7u+Ke?=
 =?us-ascii?Q?JCIPEb0b7RIR6qBLHHEJwkpHss4X9nryU479bM02IxGbFqo7emhTcoVcdAnE?=
 =?us-ascii?Q?OPOjVRiWsLS0+JumtkUjr/Hs2Se1r9NT63wDuFyOLBKQHC0eR/IhinB7gmr6?=
 =?us-ascii?Q?V7RKQBifCy1Dm1hY4sU2ICbeQ893DphTmW+RGjRdOormdVX30H5DdPgyoAph?=
 =?us-ascii?Q?XZKB2NRz1tjtAYiheuqv+51fjQvDWXNfxc1ypHKMTGpC1wAdBt4qYjNzVFkF?=
 =?us-ascii?Q?2H3OVT4+EwzSVX3SwlMfu/7BgkI8oQjCoP3c+nyUoNEPmxCtWPpSf+LGQt3Y?=
 =?us-ascii?Q?/sqZaDnMLoTJ/hziQrfwNXANRTCfe3wbcfUl5XBMSQSD6QHhnOFdLOPQdOdY?=
 =?us-ascii?Q?DbuJMNBsAvqFTRo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:14.8699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e1fd71-746f-4e53-4f57-08dd5ba4fde9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Guards automatically release mutex when it goes out of scope making
code easier to follow.

[How]
Replace all use of mutex_lock()/mutex_unlock() with guard(mutex).

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 37 +++++--------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 6a4b5f4d8a9d..6f8f21e123c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -172,7 +172,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	struct mod_hdcp_display_adjustment display_adjust;
 	unsigned int conn_index = aconnector->base.index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
 	memset(&link_adjust, 0, sizeof(link_adjust));
@@ -209,7 +209,6 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	mod_hdcp_update_display(&hdcp_w->hdcp, conn_index, &link_adjust, &display_adjust, &hdcp_w->output);
 
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
@@ -220,7 +219,7 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	struct drm_connector_state *conn_state = aconnector->base.state;
 	unsigned int conn_index = aconnector->base.index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
@@ -239,7 +238,6 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
 
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
@@ -247,7 +245,7 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	unsigned int conn_index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);
 
@@ -259,8 +257,6 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 	}
 
 	process_output(hdcp_w);
-
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
@@ -277,7 +273,7 @@ static void event_callback(struct work_struct *work)
 	hdcp_work = container_of(to_delayed_work(work), struct hdcp_workqueue,
 				 callback_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->callback_dwork);
 
@@ -285,8 +281,6 @@ static void event_callback(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_property_update(struct work_struct *work)
@@ -323,7 +317,7 @@ static void event_property_update(struct work_struct *work)
 			continue;
 
 		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-		mutex_lock(&hdcp_work->mutex);
+		guard(mutex)(&hdcp_work->mutex);
 
 		if (conn_state->commit) {
 			ret = wait_for_completion_interruptible_timeout(&conn_state->commit->hw_done,
@@ -355,7 +349,6 @@ static void event_property_update(struct work_struct *work)
 			drm_hdcp_update_content_protection(connector,
 							   DRM_MODE_CONTENT_PROTECTION_DESIRED);
 		}
-		mutex_unlock(&hdcp_work->mutex);
 		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
 }
@@ -368,7 +361,7 @@ static void event_property_validate(struct work_struct *work)
 	struct amdgpu_dm_connector *aconnector;
 	unsigned int conn_index;
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX;
 	     conn_index++) {
@@ -408,8 +401,6 @@ static void event_property_validate(struct work_struct *work)
 			schedule_work(&hdcp_work->property_update_work);
 		}
 	}
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_watchdog_timer(struct work_struct *work)
@@ -420,7 +411,7 @@ static void event_watchdog_timer(struct work_struct *work)
 				 struct hdcp_workqueue,
 				      watchdog_timer_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->watchdog_timer_dwork);
 
@@ -429,8 +420,6 @@ static void event_watchdog_timer(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_cpirq(struct work_struct *work)
@@ -439,13 +428,11 @@ static void event_cpirq(struct work_struct *work)
 
 	hdcp_work = container_of(work, struct hdcp_workqueue, cpirq_work);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	mod_hdcp_process_event(&hdcp_work->hdcp, MOD_HDCP_EVENT_CPIRQ, &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
@@ -479,7 +466,7 @@ static bool enable_assr(void *handle, struct dc_link *link)
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
-	mutex_lock(&psp->dtm_context.mutex);
+	guard(mutex)(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
 
 	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE;
@@ -494,8 +481,6 @@ static bool enable_assr(void *handle, struct dc_link *link)
 		res = false;
 	}
 
-	mutex_unlock(&psp->dtm_context.mutex);
-
 	return res;
 }
 
@@ -557,13 +542,11 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 			 (!!aconnector->base.state) ?
 			 aconnector->base.state->hdcp_content_type : -1);
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
 
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
-
 }
 
 /**
-- 
2.34.1

