Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC67CDD1D0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6708510ECFE;
	Fri, 27 Sep 2024 17:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CVLpGiIC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035F710ECFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhA2tmPiwH/0Anzi8i7o/yrjvb/C4VaYgOi44s6iF6BtT5PBMNDBbXOnWO0w2B/OMI2Uws5LPSvkAjZSgMtjE+vHskPaCfKYIvzBalYTTLvDWN2qASDgqSjH+KZ/VpOw3i0wi936MVLa6KKPTRVmgz8Mi/GavbuZI4UGBJcgOqdeepQc68vvZ/i+jrzPGxvGsam/EC3MbBf1cOZvGFONm+SQOrsz1yOL+OF0M40PRnaSjY4GV/fjY1AMawxhdC8BOBAxC9CvKoQIg11ZY10NCvRTM8a3aw4wW9yNG8JslCJAUoOHlDAiQFl93SCybfko1+QeAa1A5lxsbJG5XpoLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0k3Q0f8cZKTe4934j+/J9Lsm323GQz3GCb8aWRwk2w=;
 b=rOFQCmJIv9B37FspyKK6oDa9FYY4aiaaklt0MDqmHAsy+Efv6rqo3bu/sY8aj6hKzAAmkWdI2EWyyrTSiDtUmeCdiyxLZSu2eHSRHtRgonLDJkF7elBqMvx6ySwxvVMgnAL20SuQ1p+CY0XClKf3Sf/pq5SJ2r8YTojxbdL/TcSVTSEkUeV3kUByaKvUh26J7JfrOcO1MqcJDdLHhSiL9PGhE3vhhhsKEr31QuZiJnHu389Kx3MY8Tjg4WYOqm+cn5mZ99tbwSQtBSdTwJZHf24XWzK15HdCcthdgZ37sDWiwl3ibwgHljh3c1Ud3K2UKQWp33ZX8OzY/8eQZpdc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0k3Q0f8cZKTe4934j+/J9Lsm323GQz3GCb8aWRwk2w=;
 b=CVLpGiIChioGKz0lVDdHA8yFFNFW624pudamE0egCT9JpAjuB3kDbpYSggzSe969/S+UMgCk5ozGxGUePhkJ8IIx1zWYYXI6gcI6dpgT9vx63TlFWxlAtclHJFIanuLc30RoSUJ2Svi0eRgZl6RSj/CZ9a3KdvFMJD4rq8TlaC0=
Received: from PH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::23)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Fri, 27 Sep
 2024 17:01:59 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::35) by PH0P220CA0023.outlook.office365.com
 (2603:10b6:510:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:50 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:49 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.0.236.0
Date: Fri, 27 Sep 2024 13:01:02 -0400
Message-ID: <20240927170103.102180-13-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb0fec4-6797-4d39-8b61-08dcdf161939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECG05400zh0ZPIQrDt95Vrvd7o2ftQNNf0VQQWYS32cOY7ovyZt/zCWLBEFV?=
 =?us-ascii?Q?gxT5sbmGemNGwMjIcJoVJ8IOtXYodSaf/AoiLGrXiHyhFkTHFWMcD+dmsSgR?=
 =?us-ascii?Q?aNTrIHqNk/4cSxY2t2BQ0O9SFnOrkk6EsG4BRNRak46dSUVPgRkfNn/xbrUB?=
 =?us-ascii?Q?gWUPIqPnWYs/sIsiVfdf+tDYVDkY4yId7fCqBa3T01VUEgEO+ZDaWs8X3UwL?=
 =?us-ascii?Q?jAjPprOZN/wFUBQwN07kCW0jSDIfQ3K0bLNuVVFDNO2NiDhRVC/+9es97sWP?=
 =?us-ascii?Q?S6i0YkyQvLIMvjR7zWw9n6QPf42TkJe1lY92wNLpsKK/+6HXCa9vsOeMEpcK?=
 =?us-ascii?Q?0QwMs1pyf9fNtHp4wDjHISeCwm79FmMK8M8E1rPEeaYi5oTI3tmMZ+2RCm4S?=
 =?us-ascii?Q?tJEQ2FsL1SUrgneEH43RXYgJQrtDxopcqSFu2e7+TWabOf7Vy/VJUOqoXLsk?=
 =?us-ascii?Q?UZREKT5XYpmwqydzdlfRqL765o4sfzwYpbxr17VP/1BNB/5grWlXy1/BU6jH?=
 =?us-ascii?Q?PZ7FnIz5Y9Byg5WyCZi/ifsFwBs9VRLujRjWhufPpSRe7CF3s0PVxvLPb6lN?=
 =?us-ascii?Q?89BIh7HbhXq0xDtFTsHWp8CBVuRZakhtBBbspcgFQ6CUibRuT/wLklb/a/qE?=
 =?us-ascii?Q?TagvnvmePL0M6aqmYo2i8atwL9s0ilH7dEXAIyvablJRuRcF8cP23wji6dx/?=
 =?us-ascii?Q?UhkVfoEwref5dwYIc7epqdozOev3rcMm2TuyjbBzUohaeJVYKwiLDoCQHiEA?=
 =?us-ascii?Q?nVjbQyg6gf8Qkhr6Xlr+MVFfSMTnsrDjcfeT80p+G97RIiSBcI3n4EoA9WGD?=
 =?us-ascii?Q?O26vbgc74i2gR6tKGM21rIwNPDiGm49e7zS8EUJ5g9/ANDvDLzoT/t8W45Ag?=
 =?us-ascii?Q?61rM+hbKoVA5RQ+6Roeg1rvLHv8147m/QtN/t3SDBS1Ok+Oh7EwTHkQC3Cbg?=
 =?us-ascii?Q?t+s3aF+OiuVqwM64maBebOI2RoAdPa/2UZ5uq9J0sRqP+NoWMGqZVBR2Jjtb?=
 =?us-ascii?Q?2Xj/+43Fp1tELOkjxtAvphJG+z/Gu8JCXnA7dmsJA1Kui7cVt/evjp8Pmz9S?=
 =?us-ascii?Q?DOp+VxzldjrbUGEYUCw/8Xb8rMSXno8MuW1Z7Xum8QWK+IUUuOQnJ+87XaID?=
 =?us-ascii?Q?r9t8T3pH0mipvZJFWrot67FxF0aS1luGodiIEd9G9YrgwvC7NVNcd+09vIEK?=
 =?us-ascii?Q?a+bgOHhPwsGxoA0gfwb5LDB9HKZ7bx01ySUkIFulet5IdoKtFookai2AMDz3?=
 =?us-ascii?Q?dlB8pX8tWX72lc/zWUfW1fRiLyOT0hy+zYl6vZ4qDzZl/MObqwAwBvXLgnCw?=
 =?us-ascii?Q?2r8BzXSMouiDDRVA23XDBLrD4wAHDuoHmsMdJHwVwjPsApeZR01HL7lwRfir?=
 =?us-ascii?Q?5toe0cA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:58.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0fec4-6797-4d39-8b61-08dcdf161939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 62 +++++++++++++++++--
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3296788731ec..05d352c7b1d3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1401,9 +1401,10 @@ enum dmub_out_cmd_type {
 /* DMUB_CMD__DPIA command sub-types. */
 enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
-	DMUB_CMD__DPIA_SET_CONFIG_ACCESS = 1,
+	DMUB_CMD__DPIA_SET_CONFIG_ACCESS = 1, // will be replaced by DPIA_SET_CONFIG_REQUEST
 	DMUB_CMD__DPIA_MST_ALLOC_SLOTS = 2,
 	DMUB_CMD__DPIA_SET_TPS_NOTIFICATION = 3,
+	DMUB_CMD__DPIA_SET_CONFIG_REQUEST = 4,
 };
 
 /* DMUB_OUT_CMD__DPIA_NOTIFICATION command types. */
@@ -2192,7 +2193,7 @@ struct dmub_rb_cmd_dig1_dpia_control {
 };
 
 /**
- * SET_CONFIG Command Payload
+ * SET_CONFIG Command Payload (deprecated)
  */
 struct set_config_cmd_payload {
 	uint8_t msg_type; /* set config message type */
@@ -2200,7 +2201,7 @@ struct set_config_cmd_payload {
 };
 
 /**
- * Data passed from driver to FW in a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
+ * Data passed from driver to FW in a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command. (deprecated)
  */
 struct dmub_cmd_set_config_control_data {
 	struct set_config_cmd_payload cmd_pkt;
@@ -2208,6 +2209,17 @@ struct dmub_cmd_set_config_control_data {
 	uint8_t immed_status; /* Immediate status returned in case of error */
 };
 
+/**
+ * SET_CONFIG Request Command Payload
+ */
+struct set_config_request_cmd_payload {
+	uint8_t instance; /* DPIA instance */
+	uint8_t immed_status; /* Immediate status returned in case of error */
+	uint8_t msg_type; /* set config message type */
+	uint8_t reserved;
+	uint32_t msg_data; /* set config message data */
+};
+
 /**
  * DMUB command structure for SET_CONFIG command.
  */
@@ -2216,6 +2228,14 @@ struct dmub_rb_cmd_set_config_access {
 	struct dmub_cmd_set_config_control_data set_config_control; /* set config data */
 };
 
+/**
+ * DMUB command structure for SET_CONFIG request command.
+ */
+struct dmub_rb_cmd_set_config_request {
+	struct dmub_cmd_header header; /* header */
+	struct set_config_request_cmd_payload payload; /* set config request payload */
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__DPIA_MST_ALLOC_SLOTS command.
  */
@@ -4410,10 +4430,38 @@ struct dmub_cmd_abm_set_backlight_data {
 	 */
 	uint8_t panel_mask;
 
+	/**
+	 * Backlight control type.
+	 * Value 0 is PWM backlight control.
+	 * Value 1 is VAUX backlight control.
+	 * Value 2 is AMD DPCD AUX backlight control.
+	 */
+	uint8_t backlight_control_type;
+
 	/**
 	 * Explicit padding to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad[1];
+
+	/**
+	 * Minimum luminance in nits.
+	 */
+	uint32_t min_luminance;
+
+	/**
+	 * Maximum luminance in nits.
+	 */
+	uint32_t max_luminance;
+
+	/**
+	 * Minimum backlight in pwm.
+	 */
+	uint32_t min_backlight_pwm;
+
+	/**
+	 * Maximum backlight in pwm.
+	 */
+	uint32_t max_backlight_pwm;
 };
 
 /**
@@ -5413,7 +5461,11 @@ union dmub_rb_cmd {
 	/**
 	 * Definition of a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
 	 */
-	struct dmub_rb_cmd_set_config_access set_config_access;
+	struct dmub_rb_cmd_set_config_access set_config_access; // (deprecated)
+	/**
+	 * Definition of a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
+	 */
+	struct dmub_rb_cmd_set_config_request set_config_request;
 	/**
 	 * Definition of a DMUB_CMD__DPIA_MST_ALLOC_SLOTS command.
 	 */
-- 
2.34.1

