Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F1FC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4A410E1DC;
	Fri, 31 May 2024 16:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2rfFwmTm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1E610E2D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+1YcfMoNDsrGIfg7DeefHoJxLPUuMwcW8dLfgJ7JCWI0FOdEnkWtUNt5kL1HzwExf//ezYyH98nvhuCxYQB4I5n3UW2ksxXsDjn5hPRfmO67MAOw9zmtNLPXucDMfdOc7gAMlQM4fyWpQhE3NULPAgJJeDZjfGKzvEHMGKMS5aFadLs6XJf4Zo4l9jups2zwXAD6cvxfhiNQIQonFO+NidAYVKYSVyTenl6ojuPlIdRxhxEr/ahvZFZLaU1KHSNxen28a9lPWJVLRX3Nr5IknAAkZKLC86IgnZjslMOhDigX6y2L8JJHuUEI1O/05M6/NBvqyhM6C4zGntklSXs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wMmY+c1/loT/fhzezqL/8m4gVGkeD7ugvdg5KJzxag=;
 b=PEiWKJMlcO2UCANXbitt0ma4CsJLn6FGDMJwQZhgiYnn36Fwj/FPiv2DhgVC1taaiAzvXzxYBlMXkTgElfBCKYcRymIdmkQG2b5V7TOt6p/1TfrUJHdI7Ijee1tUW8nMcnbsTY/yObLOcmb74MGa/JXKE4OiTn31YrDkONpXrlNBNjYnef3evGozAyQgosmiCnFp4srZmh2mbIEmoRStkP7rQIMs8BQwsbliLeJQX0xtf1G/Ht8GvS1ZZJvw/fuxynAmoRNeN1VbF9iqEtb3RIGLG4EiwgoN6FfvL7lFpsVzcrYTC+WnYJgTr1LqXfYvzBraQtemkgN/4IpWbz4kAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wMmY+c1/loT/fhzezqL/8m4gVGkeD7ugvdg5KJzxag=;
 b=2rfFwmTmuzcEOAadN3Sev8rOxJX/vQH8cFGTBk1whsTdoOSgwACgH6tc8jQzGdE0jCuz9CcDx7LcQTl/srpolv1e9JKDc/rP5/Ku7/Ek+VgvuDpnGrz/b1JbKZk+GJjBSKkwVm6AJzWuOYu9l+FAFFyaizI4Fr6qPXt5Umf39TQ=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:32 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::52) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:31 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:25 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chun-LiangChang <chuchang@amd.com>, Jun Lei
 <jun.lei@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 05/32] drm/amd/display: Add params of set_abm_event for VB
 Scaling
Date: Fri, 31 May 2024 12:51:18 -0400
Message-ID: <20240531165145.1874966-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f010b2-7a5f-4116-df87-08dc81921050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zu2nRGqm1u/aKArmDgI8OgzB4ezHn8skXdaGtwCE9zoDieu6gOB9egVIECic?=
 =?us-ascii?Q?me+J/KKioVRUBrdCok2pJ+hIcBqLb5DE9FXQ6pbroJqDul3Q/rLVLvR5zS6Y?=
 =?us-ascii?Q?4fWv4QY5uOopqlsFxWsiEdLDKmkBLmsCFgiESCpd+XfMcM5z/W3wv8g9Og3T?=
 =?us-ascii?Q?0dIgKw+RsOm1TuNTJAVdxbEel1qTu6RpB7oShPgVAuQgKvyQb49pGc5BCif2?=
 =?us-ascii?Q?b4jAdwwS7fnLbpuNAzoQAIWBJsK9Hik2qBnm5LP4XZ7czrAlI0gotaDDlsUN?=
 =?us-ascii?Q?GsSU27V4ax4IL/Lp4zAOmo9KapH0QETHMBNykUqLiLCg4tP6Ry+0wJOwu15x?=
 =?us-ascii?Q?9QkGPtVtP8495W0tP1kuNeIQr7VwfHyeXI7cnKuny7lTZc2wOOxdhA3q2ZnP?=
 =?us-ascii?Q?pxZM2CXoJYBZvQ+SqB8zrjOk/1wjL+WV1pwxPori33nhYqOHehdi/JfT1Tnk?=
 =?us-ascii?Q?MohQ3n0csy5ksW5dS/RXfJv4RiNhY8vKShekA8/Om93w0sOmkA2Nk9KxKouM?=
 =?us-ascii?Q?zHD9bqf/H0Py65ysPijQd71iDJnxxWHReOfweXTmVN/XkCtdCiK4XIhvoZl7?=
 =?us-ascii?Q?lFKxbOh1pZr1cjkzpqsO7sFWsYkuemvsCgLujD/w+/Y8qCPMiDD3JgeaiD7C?=
 =?us-ascii?Q?E7dH6rz1s3sf59cuU0cQRrdk9/lXodr0ZT8kCr+Egn9oK8sGwq7LcIP5gkSW?=
 =?us-ascii?Q?FSv7+ZZyxVr/ht1GKdsYH5o0JvLGKfbBRjTQOksXf12fPcNJkMtrqXttQnby?=
 =?us-ascii?Q?9zOIGQFQhTxDQu8J/qp53Z9e9vvnuEPySFNuSSquuNSkA4V+UnKSEyB+Vpi0?=
 =?us-ascii?Q?Rk0fJshOgwRt1cwUYFuQU9JIU0t/qmcMlHrYAlpTogLPVGriUz2yW2EEn0ZV?=
 =?us-ascii?Q?lOAZ2f/5yrx5UYM18GLmxp2a3DmcW5XBYPr4GjEpMGw70YjkfxevGbcuBgtv?=
 =?us-ascii?Q?0p/JAnIrP1h2japNVN2juSsPMrmE8DDnQ9IRyTvdnI/8YdC7W7N+1bsL/xD9?=
 =?us-ascii?Q?CxfPgXYXgSJC9axj3PPdIKy693Azbfq/ssC3U5dJOV252ebIQWJWtbTFdopQ?=
 =?us-ascii?Q?h27miD5+4Itz+h8o+RopkcpgJoiYu6/D8VFW9mQZNskF+/61bcFNvxuPaPaC?=
 =?us-ascii?Q?8oaQfmTvGpJjIRy0xCSUj+whEqFb/RHyMJR06jBY0iZELyCLdT6aZNgfEpmf?=
 =?us-ascii?Q?nIXp9LLII9qCN9q8ZZxi1Urh+naQI8jTmSH4A9cD+IUtnfLrSKksPS5mUlcU?=
 =?us-ascii?Q?pCDwttFojJ6g8f86Hy8jQTmia89B81VPOqPc7d1UCjwzz7zC57Ct9dHeMoqI?=
 =?us-ascii?Q?6AHW3/cBaWWhLci/HHp60chlnpnisQELWAjsacAG26m60baCFvosqBYvV4C5?=
 =?us-ascii?Q?84KXWbQyKbuWPa1HXORfGwGJGFa9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:31.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f010b2-7a5f-4116-df87-08dc81921050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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

From: Chun-LiangChang <chuchang@amd.com>

[Why]
Add parameters for set_abm_event to enable varibright scaling.
VariBright Scaling is a feature to refer to system states like

1. Power mode
2. Battery Life percent
3. FullScreen video
4. Backlight slider

to adjust variBright strength to get low power or user experience.

[How]
Add parameters of set_abm_event for VB Scaling

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chun-LiangChang <chuchang@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 18 ++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 55 +++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index b851fc65f5b7..f4987e96fbf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -297,3 +297,21 @@ bool dmub_abm_set_backlight_level(struct abm *abm,
 	return true;
 }
 
+bool dmub_abm_set_event(struct abm *abm, unsigned int scaling_enable, unsigned int scaling_strength_map,
+		unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_event.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_event.header.sub_type = DMUB_CMD__ABM_SET_EVENT;
+	cmd.abm_set_event.abm_set_event_data.vb_scaling_enable = scaling_enable;
+	cmd.abm_set_event.abm_set_event_data.vb_scaling_strength_mapping = scaling_strength_map;
+	cmd.abm_set_event.abm_set_event_data.panel_mask = (1<<panel_inst);
+	cmd.abm_set_event.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_event_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 761685e5b8c9..13f54f1df780 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -49,4 +49,6 @@ bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int panel_inst);
+bool dmub_abm_set_event(struct abm *abm, unsigned int scaling_enable, unsigned int scaling_strength_map,
+		unsigned int panel_inst);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f52716c54180..4db4c5ad5169 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3911,6 +3911,11 @@ enum dmub_cmd_abm_type {
 	 * Query ABM caps.
 	 */
 	DMUB_CMD__ABM_QUERY_CAPS	= 8,
+
+	/**
+	 * Set ABM Events
+	 */
+	DMUB_CMD__ABM_SET_EVENT	= 9,
 };
 
 struct abm_ace_curve {
@@ -4469,6 +4474,51 @@ struct dmub_rb_cmd_abm_save_restore {
 	struct dmub_cmd_abm_init_config_data abm_init_config_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_SET_EVENT command.
+ */
+struct dmub_cmd_abm_set_event_data {
+
+	/**
+	 * VB Scaling Init. Strength Mapping
+	 * Byte 0: 0~255 for VB level 0
+	 * Byte 1: 0~255 for VB level 1
+	 * Byte 2: 0~255 for VB level 2
+	 * Byte 3: 0~255 for VB level 3
+	 */
+	uint32_t vb_scaling_strength_mapping;
+	/**
+	 * VariBright Scaling Enable
+	 */
+	uint8_t vb_scaling_enable;
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__ABM_SET_EVENT command.
+ */
+struct dmub_rb_cmd_abm_set_event {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_SET_EVENT command.
+	 */
+	struct dmub_cmd_abm_set_event_data abm_set_event_data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
  */
@@ -5008,6 +5058,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_query_caps abm_query_caps;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_SET_EVENT command.
+	 */
+	struct dmub_rb_cmd_abm_set_event abm_set_event;
+
 	/**
 	 * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
 	 */
-- 
2.34.1

