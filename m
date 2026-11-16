Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E3606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TxKTNWUH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97A610F852;
	Tue, 17 Nov 2026 17:18:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A85E10F848
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmJcfhCASpwVx3XeK43AsCdf5YxuMMgb11M7kAQ98hdSl8gyCTaxqCVoHdZqd+AkpYL6lbip2UnvwefpEIcgIpnjPpnpDmWaS10zmz0aBVvAYKUIoTIHXXsu5A9bBwDU+/kYlmk84Awc2TH4hWl1y2cg2zBxUcVTV9Bg8HE/1pZXDFXc2kPHczPnni6Utrw1XvHDXgr1toPMo4JZBMLg1xyI8Pj+juFYQt5M3+0x9shLQEami1VNfyXV0QxFWgeqEWmA+mKUrdyQ6n8MGKgvJSrkFN8fnSNLxl/tiylcQtw4cj9Grpycn/ctdUJWc6dtVYADfAXO5oqFV1fR98n8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYTUAfbop3kOFmjG2NU4C8Da9waE1pCEMSUNG39kFzA=;
 b=yXmCQkluJGgXZbThaMJEYav2RmYomqaDkB3if9XtZ79odbv24e/3m4MWroF+U9kI5gnwpwABX0avNGHxyqgu5xEiIyFUxU6XAOERlkqoj5IdJS999Cd5n6BBk93fb0w4meEZHy0eWeeNyDILYpIXpP770eJ1GATHKvkyMJW9gxAENy0UHj8Z9vfT416XPXqOTC/hfOAehCLW9U/4+eOkKP76HaJGxy/cARhsOGZqHuoGyy9GzHku/5rYWLT5EJozL+IxJlQfe6Qw+DQTJ4av6M2Zdtn8yTPI15Ca4LFucdszXD4JD59TZICc/6C4c5iZruiQ8xXkY2gmYd1Y0I5uAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYTUAfbop3kOFmjG2NU4C8Da9waE1pCEMSUNG39kFzA=;
 b=TxKTNWUHUzkfHP6GgqCXg0km5SRWH979ln4RaKTemSGAoSnN+1y/WaGHHK4unCTY04XFzl16zntKDueDMd1Tj8LdtcEuRDxUDwapNc0ARJP6BqvjB+qKy8CgjMcT/7Sv9e5VqeS9+zAazJZUw3lxX8LQsotO4Wtg7eW0CzMFv7Y=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:17:40 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::65) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 17:17:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:17:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:38 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:17:29 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 32/33] drm/amd/display: [FW Promotion] Release 0.1.85.0
Date: Tue, 17 Nov 2026 05:51:09 +0800
Message-ID: <20261116215641.2800595-33-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d0b428-9fcc-42f0-8430-08df44ceae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: gg3vAFbQ4ieYESj51uvZa1L77HcJpyPT0rffld70nzaDumXjw8aNUVph7iTg2lnL4qZAecoKb+XU3bSBl3TqRQ/12mipMQsq9pYMI+sP0WRUSqFjP3+aFjhqDgYzb3dJw4kbLtTW1EqOJQQXmjm6qtgWRN1U4aUnJLdTOfaARrs0qnMPrOG53XjMIJv8sbV7GPp0nJB2eSZBVzaIEtgMHobevRSHQgPNwqqDqTf0hDxv2LQM+i+t3s8eic182PjG9AFcXTCgVrpbbd1cCMU9NJgJT2qQdBLVqwP+L/+onysR2AO8Sn+Vl2XgRYRzk/qiFEQ8nqbCGYVTqXPYz0mEH4I13FIs72b5D51D7UmpMnV/0/+V0FcuV+YLxVU+3koCJjx0XjsyzpYAH67056OLYMTmByNTsXKRWH4os0008MCN2BtffXIXbCthVYzmBt/8J0kN70u8dkrhOguhV1/9f2Q47lBpptTzMihteJb5UJyNXwJjwxmQPq/esgQtKa0JVDGuC8xscxmqk1L4pZ03BilQyzMxqDapCa9RGBPHCLL8YWBxGhhxqFd3XghozBeXtiwMy0AnnIr/wg6JykSTkAnOSpe5BlyfGgaGO6uR5jv21C6NsWQMdpp3Ued2PLiXnWJ+C1Lw5Yrf6qGoicwmI9+DPhc2EEVidwlc9zwemJqjVjRLd6sj7y5yEAyxzJzLnO/GVG+aHHmaBSqJw7nJjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m12O27zhKpthaLJ/Vi+Qlp1HssApKYHprotCljt7VV9qnZVh4uk/5ohoI/9BNHO+rNt3jyFB3HyQYa0GVFW0nXAB9NpxCL5pklzIPTqAkU606EQO1MAhG5cv3Xw2P6aN4gNO2EzYecBsO63jxD6y95XLfIZwZ7UhQeB3jMv4tfp7N/rjwAVsKNRO0L04HHkOuUcYO/o+9O8DF0eCI1Zy3uSLSOWXJXc44MfAwStFU9xN51uqtpz65fZsPgQbR2utzhKj0b39r4j/vzkkGqHZoVk188y1MxtCmUrPmbqHXioMabM7bAbQRI7nJzmtiwXU6Y6lghZLTrj+eTEdRVr/U5b5Bg11ZXSAy0KpBndGe14vl4AXiZ70WE1moh0P+kqs0zY0SL2raSY0Sk+pGTq2H7gb/hnXSl8D1lOTZkE1PQ7uIx6uolrCpxkuiIGGRIgo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:17:38.7861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d0b428-9fcc-42f0-8430-08df44ceae4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated display microcontroller (DMUB) interface
- Add the PSR command DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED
  to tell the firmware whether an external (non-eDP) display is
  connected. While it is set, the firmware skips HUBP/DPG memory
  control for PSR.
- Add the Replay general command subtype
  REPLAY_GENERAL_CMD_SET_EXTERNAL_DISPLAY_CONNECTED.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e9eee64fd834..3b0c9707437e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3817,6 +3817,11 @@ enum dmub_cmd_psr_type {
 	 * Set PSR power option
 	 */
 	DMUB_CMD__SET_PSR_POWER_OPT = 7,
+	/**
+	 * Set whether an external (non-eDP) display is connected.
+	 * While set, FW skips HUBP/DPG memory control for PSR.
+	 */
+	DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED = 8,
 };
 
 /**
@@ -4568,6 +4573,44 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED command.
+ */
+struct dmub_cmd_psr_set_external_display_connected_data {
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel instance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * 1 if an external (non-eDP) display is connected, 0 otherwise.
+	 */
+	uint8_t external_display_connected;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
+/**
+ * Definition of a DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED command.
+ */
+struct dmub_rb_cmd_psr_set_external_display_connected {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED command.
+	 */
+	struct dmub_cmd_psr_set_external_display_connected_data psr_set_external_display_connected_data;
+};
+
 enum dmub_alpm_mode {
 	ALPM_AUXWAKE = 0,
 	ALPM_AUXLESS = 1,
@@ -4766,6 +4809,7 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_SET_CONTINUOUSLY_RESYNC,
 	REPLAY_GENERAL_CMD_SET_COASTING_VTOTAL_WITHOUT_FRAME_UPDATE,
 	REPLAY_GENERAL_CMD_LIVE_CAPTURE_WITH_CVT,
+	REPLAY_GENERAL_CMD_SET_EXTERNAL_DISPLAY_CONNECTED,
 };
 
 struct dmub_alpm_auxless_data {
@@ -8009,6 +8053,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
 	 */
 	struct dmub_rb_cmd_psr_set_power_opt psr_set_power_opt;
+	/**
+	 * Definition of a DMUB_CMD__PSR_SET_EXTERNAL_DISPLAY_CONNECTED command.
+	 */
+	struct dmub_rb_cmd_psr_set_external_display_connected psr_set_external_display_connected;
 	/**
 	 * Definition of a DMUB_CMD__PLAT_54186_WA command.
 	 */
-- 
2.43.0

