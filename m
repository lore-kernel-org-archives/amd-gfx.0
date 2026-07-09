Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C827C4450E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7098810F6F4;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3smc8VRl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C8110F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKbuTHH4ZHWXB3BgkjQue6IWR2Hole6cftsti6vz5ifY7KVliQ8nFMc+QXtmuBDnzttsrSGsrHkHa3N/agCqDmbOGnyXrqlYF9OgFeco34I10BFUlCOGcYigdoStCnUeo0RllTUFOk9tRMC1A5H912mVRbpzfLvlEpmTLGX0J2CRhXaA4YPPV0U1xovSPEQ0CiIC79Vvpr+5hgT8xPLKqNJ6DT5wqs8RyJBWXwiPHCe86RcBtmqxuHkNS+uHSLyte4yQ94iyQv2P62CfUd+ByHwLVeTqcDUBMeDRQRCPV9guwMLHXLBhXigXjvj27BFaw6KdR/IEi/ghG+jsmg+ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4DPjNZdPQKWYzncxb7N7ZATHL4q4KwbqxV2GX0i/pw=;
 b=ubZCwYIbLaQ6BL5DVLYDHLnjNaAAb+pde41rla16hqOz1sFQJcQY6nKHTKU4pU50IdriwxRcoKQ7gHa3yi7cGElAVlbj/fmq6nTPLjcRPmaMs/h2rcomnLUxCQns85TgXxBDZkQi4qv1eGEOIm6sIF8LXVRQmWBR9LdIH/PMY8quK0yZ3tgWkr2BvBDvBuq6/t+lugjQa2uhDQN3KKq0/9gH2GS3c/+YaXZ+Y5jn9nypBpCqXJmkPz1w6KxceQbMQeHVVLTIXcOCDFlTB2ignf95uXgVa4AvRBavnaA+d473WSlPsDFzhcDw89dgQG/EMB8K65E61sUOmTbOoTo4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4DPjNZdPQKWYzncxb7N7ZATHL4q4KwbqxV2GX0i/pw=;
 b=3smc8VRlVGs/VKe7XgUyIdtK4ckYiZtCW4MmpF0wQu6+lkIyxtyP5kdPPx+OKVKaBvEOk2bkj1BAd9369NteOciTQ8omF72KTTveMyCR6NMhk0rebYhJWYGyGc5w2ZoXjbFKJN3drVh0fWInzibdggq1m0gqDCzu02zY6OwJmbk=
Received: from MN2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:208:1a0::23)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:34 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a3) by MN2PR07CA0013.outlook.office365.com
 (2603:10b6:208:1a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:19 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 57/80] drm/amd/display: Skip Update HDCP Config In Transition
 State
Date: Thu, 9 Jul 2026 16:48:25 -0400
Message-ID: <20260709205936.5719-58-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: c04ef18d-f92a-448b-4ff8-08deddfd6630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zO971smZtYo4RFN3xiQjP9C8Jyf//uxm2jgC4SWsOytiQ9ZNkW1Xp9EijcFyDZZ8K/cJQvVzmWCYMnAo60U6M0dZ/xgLxSykjMOF2j5elObAxQgfhAbeCtlkkQ4vmMr0j4pAwbtfnG9/l9A8hbhlbnFAngQPZAspN3GcA7+7tVLcNtq4YwANKcly3sLhAz/bphEttTey4XxjDvpHeO1qG7OgXl5Nc/o0yAb7/VP3Q5HdI1Xv4fqRHXrxvKpki1JxUIm9UEFon87Sg5wZCPDn8HZUkk9EvVOBG/gm72ljU6/lyVaWlmnliwYceZrw5vqzy1DrkbLAghyJgUJ9wcj6gqLcwYtpHHrdogoNQ4wnmWDTEd7clzfhlOXJyg1EVBH+7rkBYO/VIH6hqgei3zDSxRi/VhJHvT6ZIN0TP5pmV1LxKQmysKSY4tQJq8HAlfFEXQwY61rYJo3w7BVbmuCjbWJrAugF8ZDJ2HL43zgJ1kU0VeO5UMC6ax1tblX2UWdoCHWRQ7X8EXCHDx7tUBqSemTotKP+fLTozYnkrc1eOGLGLuPMcW8WELk6ZZ+Ol7vePfdQrRxRHgo5N4LdkVf42lADrHBEkVvKGRPnw4lRVxvEQ7MCNg2/NytwPeKGYnChmE2ASmqbAVJ8mPJZjLBpCpAe04qbyviKrQJ/05XD+RgrmIaVPBUe9O8XBJkK7QCejLX07gvrFkloOwxbhr82lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Prn5K+s9cABKNq25Wk7Y1Nld+kRKCdYsJ24qPudd8cl0HgGsDsyJjnmq0fLFfnER1ZSukmoCc5hGMp/I+PE8rKmq7sP7Cc7eBuYJKgmzAbgpXFk/EUS9XMjBpGpMXrSpUm9V3R/wSqb1DjOs1x9XX/2gl38AegyRnut+HEi65LrTS0fYDOa2k2fgglXoudUaBBlv6fmlymSxupfz4KK60AlTfqj3YRe4jfOMpxeuLF/DT7V3e1GPv2coG3lZoGF4ILzSv59T630k53ZEIelVFvnsbh+wkkd647jRrKS5UJv7kHepvitDS5nylRN/slgRULhMUf3zIZ47sD7lvxilhMy617ISb+RprYqlDynuJqSO9vW3876rDLg/pDbsruxK47S+VptO8uY4D6zi0NO2emU2tdBX/N45sHrX6jAuzowlqJqFNQfU27J2DDEAl9TZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:34.3660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ef18d-f92a-448b-4ff8-08deddfd6630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Transition state does not have a valid dm_stream_ctx that should skip
configuring HDCP routine. The routine is valid to go through only when
a valid stream is created.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8f7585d3efa4..9a2d2706deb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -589,15 +589,27 @@ static bool enable_assr(void *handle, struct dc_link *link)
 static void update_config(void *handle, struct cp_psp_stream_config *config)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
-	struct amdgpu_dm_connector *aconnector = config->dm_stream_ctx;
-	int link_index = aconnector->dc_link->link_index;
-	unsigned int conn_index = aconnector->base.index;
-	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
-	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
-	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	struct amdgpu_dm_connector *aconnector;
+	const struct dc *dc;
+	int link_index;
+	unsigned int conn_index;
+	struct mod_hdcp_display *display;
+	struct mod_hdcp_link *link;
+	struct hdcp_workqueue *hdcp_w;
 	struct dc_sink *sink = NULL;
 	bool link_is_hdcp14 = false;
-	const struct dc *dc = aconnector->dc_link->dc;
+
+	aconnector = config->dm_stream_ctx;
+	if (!aconnector || !aconnector->dc_link)
+		return;
+
+	link_index = aconnector->dc_link->link_index;
+	display = &hdcp_work[link_index].display;
+	link = &hdcp_work[link_index].link;
+	hdcp_w = &hdcp_work[link_index];
+
+	conn_index = aconnector->base.index;
+	dc = aconnector->dc_link->dc;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -635,7 +647,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.mst_enabled = config->mst_enabled;
 	link->dp.dp2_enabled = config->dp2_enabled;
 	link->dp.usb4_enabled = config->usb4_enabled;
-	if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+	if (sink && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
 		link->hdmi.frl_enabled = config->frl_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 2;
-- 
2.55.0

