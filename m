Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E29FC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA88610E254;
	Fri, 31 Jul 2026 21:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTGOoeqz";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7745C10F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRsQ7hbKurMwARNgdwO2i8wCpXkZrw7IX5GvUoOKIoIF5KCRKu3QwAyh0BxXc4BxRTuK6kOnI2OG/278pJxIDZU85F9e+60LcLcK4GJHUHiv0YR95ea1yYYyXpXc2oZlv5cLe9uBxVOh98YIfqdDD8uWumDJkI7PVHnxUSHBG/0jaLpEUQjidfmIukGepRXPuJUiu9h7eRcB81G8YxNcjFMyXg2sUyNm6JNZdbl453QHu3j0UPthMAHf2YxRs8kccAZ/tHHmd8iSgRLxSu33UBUbggOL+AzJtwUgHZoKFMLRJ6zoqvlkEJJcLsmhaiXygRY01YJNA+pKP6OUQZ+KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIcRO7Pv98QZtfujcWvU/6bAKrBIINh0Li5EApCk8EM=;
 b=Ocm/m7k0RgVLter5AHhtXoMU+aqb97htbUFR+f39BJCxoNgX+Ehuq5JQWfcvS/E8bfLKO1J8qtiSC7jcXfFmNgL0QV1hy/oBYUDiOJmtucsrj8y31GfeIYfVjjBoQc3r8aMELje7P1PokUyQPOZ+MMpLU0uwR9PoER3EEAbf/jTpb8F+XTZoxwOOQybCPD4iTnMD85ZlV9ruFoUzNLZBXiAU/nqz3pCty7fc4O3CTUR3HkcQVo4mu+UzHYm7rXuSEVSTUf5Q8aHsKKjQZLS4KPNT9q6A34P9JP05GAyCh+qS4FmZa29OeIK6hpJF+waSoedBYUPC7ByOV+EyLfshxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIcRO7Pv98QZtfujcWvU/6bAKrBIINh0Li5EApCk8EM=;
 b=nTGOoeqzc5X7mea5wm/3h58ttZmH9RgXjVuVrKgEbSKHg2iw1JOT4IxzQLaN+XddktL19AcHwQwCVqc5bOmRvUfT8CvKfmRAFzMPTUGQxqb3EerOJmPU68reS7hTWkgLYExYB7DVsTDT/6PsJ8mdkQ1tL64F0PtGe9ylHofZPFM=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:34 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::2d) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:33 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:31 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 07/41] drm/amd/display: Resize MST HDCP per-connector arrays
 to 32
Date: Fri, 31 Jul 2026 17:12:28 -0400
Message-ID: <20260731211302.3040343-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: b87221ad-180e-4bf2-39a1-08deef48dc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|11063799006|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: uCPqisSzxoqgp8yTW0DzT3hzRvFiSQD/AHtFdX50ypEJbJ4UN5OwncqeX6Hj9j8XwNiOEKqZWu0Xt/h6/BXVnZLnM2incxF/4CzejMvYsztKcS/ySxEx6q9hpKylk7N3B3Gq1IUdNVAnmzffCIZLahniOYyPUNLgp1QYajRidVFGcCb18dRqKc6gM1YIuBzZOSRRdWODu1iffmIHPZWr+htxGTkGYaNP08iGKOsm6xxuENg74SANQDH3fEss5/N/Z+E5Oekr/OabfOf+QvU0GtpgPwFIAiCbHxM2ig5tsTebL+CAxTxS+j0cjPWRUexETWBp/6zfqNcC40qgyCvMlAYCtsCgFY2ftssOnBdUDCyEBpYcZB6xo33kYLtOJqgo4+3ET4H2PW8GxGyp0oj476B/Zk/cZzo9FUrg01ZblCwldv/IXG7kfZEgq/MHNZjKjFLCg1iEuMY65dkvGV7h+FqvIMfGrNEb4vlXvN1LKYtyUpemQd4BNZnKVOb8DDTVMF009ayGnyYf/AVM8gFgwMS8lS9h3sLN/cxp92mmqR9jY/LFmnFUPAXs9B1zwHGgvQgmi/oR7Jiq3SUQwgJdcNCzpKnz/ahatx0qM9Y9wnJzh16JkI3a5bpJ/d7d4McDhKY+NQhnwaP+2zthSvBT4ZKwyUpJZ5DkLYoUnNJeE0AwprND76/wBM+aVjyYcTzR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lfAKXHZI3CCVeD65ege2Djd9kLJBP33zkH9BlGrO067ztEoyHuPLCfifGK+CMpwyzDWjs5XsgAvKz+ocsbS8q2aniq2NfA3Gc5NoDrgM20vqbw044guR8C+2dBKOcTmF0YP+4gN6CV5mGJZvTNXz2JN6k27G8ZzJ3OMb7vI67kpKDLVzdYgQHe1RHy0hD2MZGpv92WDwaZwM/5XrkTX3NMR+yxBMAtOzvFlc24iHadQXSz1REh6USNv1rNUCN+EiC5n1oRsrCbHLA3JgShz/NgyXVI8Ag2LJPLiRVt6N2yo7S/yIZKDXt+EMkP4a6h0TE5/krosktVdozq6EsY1TDUWU0pQMF9xH8xkqk24mY2IWY6/kHa0PP9dk+eNgbgMV9v2jkeobSaFRY/8jIWbwZ3x29Vu97qQLEr8nLKHQQl6ufWU/jqvFi4QqOWkeslFE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:34.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b87221ad-180e-4bf2-39a1-08deef48dc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110
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

From: Harry Wentland <harry.wentland@amd.com>

AMDGPU_DM_MAX_DISPLAY_INDEX is 31. It suggest a maximum number of
32 connectors. But the way it's used is like MAX_DISPLAY_COUNT.
Hence we're off by one with DRM core, which supports a max of 32
connectors.

Rename AMDGPU_DM_MAX_DISPLAY_INDEX to AMDGPU_DM_MAX_DISPLAY_COUNT
to match its actual use, and increase the size to 32 to match the
originally intended size.

Fixes: 82986fd631fa ("drm/amd/display: save restore hdcp state when display is unplugged from mst hub")
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 +++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c887a70ae74d..47cbc826ed45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -365,7 +365,7 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 
 	cancel_delayed_work(&hdcp_w->property_validate_dwork);
 
-	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_COUNT; conn_index++) {
 		hdcp_w->encryption_status[conn_index] =
 			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 		if (hdcp_w->aconnector[conn_index]) {
@@ -418,7 +418,7 @@ void event_property_update(struct work_struct *work)
 	struct drm_connector *connector;
 	struct drm_connector_state *conn_state;
 
-	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_COUNT; conn_index++) {
 		aconnector = hdcp_work->aconnector[conn_index];
 
 		if (!aconnector)
@@ -478,7 +478,7 @@ void event_property_validate(struct work_struct *work)
 
 	guard(mutex)(&hdcp_work->mutex);
 
-	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX;
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_COUNT;
 	     conn_index++) {
 		aconnector = hdcp_work->aconnector[conn_index];
 
@@ -897,10 +897,10 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 
 		memset(hdcp_work[i].aconnector, 0,
 		       sizeof(struct amdgpu_dm_connector *) *
-			       AMDGPU_DM_MAX_DISPLAY_INDEX);
+			       AMDGPU_DM_MAX_DISPLAY_COUNT);
 		memset(hdcp_work[i].encryption_status, 0,
 		       sizeof(enum mod_hdcp_encryption_status) *
-			       AMDGPU_DM_MAX_DISPLAY_INDEX);
+			       AMDGPU_DM_MAX_DISPLAY_COUNT);
 	}
 
 	cp_psp->funcs.update_stream_config = update_config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 665fa4839a25..01c61e4d1176 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -36,7 +36,7 @@
  * Minimal declarations needed by this header.
  * Full amdgpu/DM definitions come from amdgpu_dm.h included by each .c file.
  */
-#define AMDGPU_DM_MAX_DISPLAY_INDEX 31
+#define AMDGPU_DM_MAX_DISPLAY_COUNT 32
 struct amdgpu_dm_connector;
 
 struct mod_hdcp;
@@ -57,7 +57,7 @@ struct hdcp_workqueue {
 	struct delayed_work callback_dwork;
 	struct delayed_work watchdog_timer_dwork;
 	struct delayed_work property_validate_dwork;
-	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_COUNT];
 	struct mutex mutex;
 
 	struct mod_hdcp hdcp;
@@ -65,7 +65,7 @@ struct hdcp_workqueue {
 	struct mod_hdcp_display display;
 	struct mod_hdcp_link link;
 
-	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_COUNT];
 	/* when display is unplugged from mst hub, connctor will be
 	 * destroyed within dm_dp_mst_connector_destroy. connector
 	 * hdcp perperties, like type, undesired, desired, enabled,
@@ -75,9 +75,9 @@ struct hdcp_workqueue {
 	 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
 	 */
 	/* un-desired, desired, enabled */
-	unsigned int content_protection[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	unsigned int content_protection[AMDGPU_DM_MAX_DISPLAY_COUNT];
 	/* hdcp1.x, hdcp2.x */
-	unsigned int hdcp_content_type[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	unsigned int hdcp_content_type[AMDGPU_DM_MAX_DISPLAY_COUNT];
 
 	uint8_t max_link;
 
-- 
2.34.1

