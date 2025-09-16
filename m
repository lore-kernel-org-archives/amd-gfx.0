Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC08CAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6179F10E564;
	Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3SV0TF1F";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A6010E564
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnIdXJ34t18TJITpJLBCWZaCLw6RdteHQ1+NxNdn/NN5AMFDyveBLdVbS8P6PSe4KYz/2P/GS1Sa49zcUSKnkB9EzdlCnwgO2FIAAQwEAzsaBplLsGKNVnsvyRXLK4YFcRVpo/QmZNzfB7t6ATptF13MXjZ0cFEKkL+Elkzmo64w9aWF7p/62oR3l+qEsTP8ycBIYSxwTSChJKz6e/QR9EjW3E9efkRy1qx7g75qTbt9Pt/AEQm2ymDW7CH1IWUqWd+V5W0RogHEPVVv8QnfhyJIWud/9UbCOnIx5La4hQRkZwwyxVPAG6b0PJuBcZI+LP1E18Uu3+xG2VUdFIb3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgYbZ2ZIMN/H1ZVnOAooWsxH79VMFX4xHD5da1AYFys=;
 b=hXCXybl5No2ZlLDuFTWXKyy+FCs8BqBp1KJwfUZzBEYPwbn4umE0WIZMCuP8vHgckAFS0FG3vWFQWlfx8cyuyjpLpZzhGCwWRklakdANbmjafWiiXhKjMue4QOlaTpIdQ6OWnsLQ1uSvJ0SVhhAUWchqPXSAv7r5nANb49wTrY0Z8wJMGljhLjY3uPAxJErvc0NJ/mPe8lSuz8mwx1tSTkcoJgsH1gjbuMlwgdfn2ESRqVmNTIoHOfA7qastNbczfhb3A6/pX06Q67hvLIdB6stuaU9PI10s6hRABd0uXDxdjO4Mk7tZVHKhix8whVzIw5r2+GPf/14XOElQrlDWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgYbZ2ZIMN/H1ZVnOAooWsxH79VMFX4xHD5da1AYFys=;
 b=3SV0TF1F7/qR0worJGxt8w7Pp6ykf+wlPkFhcqPHNaWr3CYcXt9T8PScVKrPwlXK8V5BmCccXAf43+d7w+236eV1Y23j8wjLCqpE5FEf7IvfzznGJ8oHkpZvNPT/D5dwfcm2MCchkqcKHOcft8alp+BpkjIl+67rDRkyeukHgSw=
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:19 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::8a) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:14 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:14 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:13 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 12/20] drm/amd/display: Refactor SMU tracing
Date: Tue, 16 Sep 2025 15:09:32 -0400
Message-ID: <20250916191142.3504643-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c252c97-6bbb-4a8f-fda9-08ddf554f537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cMZCc+3imoHfGPudFw4tNZhLdpIz4K/UWWtVDIQDZ6Ig2/2Mlx/E7oKgaCAk?=
 =?us-ascii?Q?mB467JQH76caLPBUAYd/D6lLdkmYMVLf81I6eXHVmhEGqku2OMBEMfwySQlZ?=
 =?us-ascii?Q?GVnQuv2jZ9G3jEa6ZLgBE5RIEtxD1Du4v6Ui3VBGJm5fAvBwN+pMZDrPpUnk?=
 =?us-ascii?Q?HxXF1tCnRrVPw1Fxz+f+F1gn2hhWZcl9d1HsJ6LDD8wMVVCu+P/EG9HEGsak?=
 =?us-ascii?Q?omBWnz4wucVdpXxsBpMSJDHpqk/8gZ6lAC0jQBS/0LWxI5Sfccmug5IUuhFk?=
 =?us-ascii?Q?N43Vyn1RdrY7Q6YhK6Vq1mX8Oijqr719sldzZposgiVfb7vx+mD2FFxhulQ8?=
 =?us-ascii?Q?5PXmxkIkoWqfGi6CLJjdpxb0qSKYpRJZWntmQxepKLFLUWqliDr0xcBaI2a8?=
 =?us-ascii?Q?9DsMvQIsQNpr5BgyIyCBrquP8KTCIvTUm55Gnqx+0dxsuqdWcYShgyyrP9sm?=
 =?us-ascii?Q?BA3g6OwZTigrtbyLrnRZPgDBTe+s0uQZyCJgBpsUyf1PtjJIju7opRnQs6TD?=
 =?us-ascii?Q?JXCzb+bHFqtUVgX9xvg93a4oxdiTj3HYyP3xejJd8JMhgLYGbqb1qaZzW2em?=
 =?us-ascii?Q?QsDAZcL6kccdukC2mjJiVSq6HM80hJuPlBvRPMBYnSNZ/hs8bHd2YvWFSQtJ?=
 =?us-ascii?Q?PKWWaRcJCylh9mwhr+F9XinXwQN3uTvut8i49exAO6W6+C88nhEpK9PSmuh8?=
 =?us-ascii?Q?Df61XMf7kgyIYjk4+XMCbkXoqtLGQENxkpHS0450Y2h7mUnqanrM3jYt/dbq?=
 =?us-ascii?Q?jJyhTvUAPEIYYz1p8tXOsjpZRn5ZuZeUKNpJpddncVT7MxkY/SChizHtn5s8?=
 =?us-ascii?Q?U+FjeNJ1TcD8c2hyucy4eCnQkFD/PbccpTbMWOiOwcAnvnHnF2MCMbpZg1PB?=
 =?us-ascii?Q?V+Wj8dOGGDAM141RVZD7EFupn1LgzdG9o96O5V9+IkksiEla3sgwCyosTVVs?=
 =?us-ascii?Q?HvvoZbXgTLLwmcOXOi/0cHxNGT86630BdRMjqCvvIFlowjNt3luUuhjtkNiE?=
 =?us-ascii?Q?kQoZuJU5CVAjCcOcEMu3ONFHZaxEr38b4Xgmb6Tu5zUcNy6feKYp1Ju1h1AR?=
 =?us-ascii?Q?FKA7BRlZya/Ruv1emwN12CURd2JBi9vZzLNme15l7qIxOUNf9cVC9hp63JK5?=
 =?us-ascii?Q?8qzVQ4u5TV2jemzMsNDjoZgkba0QG8UUfp9S7wm9K93LdskqX6izOdfjzZiE?=
 =?us-ascii?Q?l1WRVfufchC/GInaaVsR4tMPJ3XuC7iYG8xcXxv3gcPLPBAG9Da3GulESMTA?=
 =?us-ascii?Q?uPjPZK9m9XJ7Sh0y381ACWWFNyLZdZ3XESJObphZpe633hdWOKSSoDlB6biB?=
 =?us-ascii?Q?buvIlurz2SPakbTP7SXIowx1EviOFnoglVRwH0lERA3QeJvdrSIjOThyeSVE?=
 =?us-ascii?Q?Rr850LFLn9joNGnXDird1Dil8PeNf3U2Q3ozxigA4i/1dK+Z1pkQX5yCz1wu?=
 =?us-ascii?Q?s1EpJbxtEje5sTauzmaGtkY3PopwJsklqfGsxUdlaJ/tmeRHPiBlQ1AyV3Gq?=
 =?us-ascii?Q?3uC1fioemhnTGABxbLTOZHnRpJuu/FTlL+Xz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:19.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c252c97-6bbb-4a8f-fda9-08ddf554f537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Add new tracing and performance measurements for SMU messaging.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c   |  4 ++--
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c |  2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c |  5 +++--
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c       | 12 ++++++++----
 drivers/gpu/drm/amd/display/dc/dm_services.h         | 11 ++++++-----
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 132de4071efd..8550d5e8b753 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -53,11 +53,11 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 				    func_name, line);
 }
 
-void dm_trace_smu_msg(uint32_t msg_id, uint32_t param_in, struct dc_context *ctx)
+void dm_trace_smu_enter(uint32_t msg_id, uint32_t param_in, unsigned int delay, struct dc_context *ctx)
 {
 }
 
-void dm_trace_smu_delay(uint32_t delay, struct dc_context *ctx)
+void dm_trace_smu_exit(bool success, uint32_t response, struct dc_context *ctx)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 3253115a153d..827bc2431d5d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -69,7 +69,7 @@ static uint32_t dcn30_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 
 	/* handle DALSMC_Result_CmdRejectedBusy? */
 
-	TRACE_SMU_DELAY(delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
+	TRACE_SMU_MSG_DELAY(0, 0, delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
 
 	return reg;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index cf2d35363e8b..5d80fdf63ffc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -63,7 +63,8 @@ static uint32_t dcn32_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 			udelay(delay_us);
 	} while (max_retries--);
 
-	TRACE_SMU_DELAY(delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
+	TRACE_SMU_MSG_DELAY(0, 0, delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
+
 
 	return reg;
 }
@@ -120,7 +121,7 @@ static uint32_t dcn32_smu_wait_for_response_delay(struct clk_mgr_internal *clk_m
 		*total_delay_us += delay_us;
 	} while (max_retries--);
 
-	TRACE_SMU_DELAY(*total_delay_us, clk_mgr->base.ctx);
+	TRACE_SMU_MSG_DELAY(0, 0, *total_delay_us, clk_mgr->base.ctx);
 
 	return reg;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 347a0d66d653..3a263840893e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -57,6 +57,8 @@ static bool dcn401_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uin
 	/* Wait for response register to be ready */
 	dcn401_smu_wait_for_response(clk_mgr, 10, 200000);
 
+	TRACE_SMU_MSG_ENTER(msg_id, param_in, clk_mgr->base.ctx);
+
 	/* Clear response register */
 	REG_WRITE(DAL_RESP_REG, 0);
 
@@ -71,9 +73,11 @@ static bool dcn401_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uin
 		if (param_out)
 			*param_out = REG_READ(DAL_ARG_REG);
 
+		TRACE_SMU_MSG_EXIT(true, param_out ? *param_out : 0, clk_mgr->base.ctx);
 		return true;
 	}
 
+	TRACE_SMU_MSG_EXIT(false, 0, clk_mgr->base.ctx);
 	return false;
 }
 
@@ -102,8 +106,6 @@ static uint32_t dcn401_smu_wait_for_response_delay(struct clk_mgr_internal *clk_
 		*total_delay_us += delay_us;
 	} while (max_retries--);
 
-	TRACE_SMU_DELAY(*total_delay_us, clk_mgr->base.ctx);
-
 	return reg;
 }
 
@@ -115,6 +117,8 @@ static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mg
 	/* Wait for response register to be ready */
 	dcn401_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay1_us);
 
+	TRACE_SMU_MSG_ENTER(msg_id, param_in, clk_mgr->base.ctx);
+
 	/* Clear response register */
 	REG_WRITE(DAL_RESP_REG, 0);
 
@@ -124,18 +128,18 @@ static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mg
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(DAL_MSG_REG, msg_id);
 
-	TRACE_SMU_MSG(msg_id, param_in, clk_mgr->base.ctx);
-
 	/* Wait for response */
 	if (dcn401_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay2_us) == DALSMC_Result_OK) {
 		if (param_out)
 			*param_out = REG_READ(DAL_ARG_REG);
 
 		*total_delay_us = delay1_us + delay2_us;
+		TRACE_SMU_MSG_EXIT(true, param_out ? *param_out : 0, clk_mgr->base.ctx);
 		return true;
 	}
 
 	*total_delay_us = delay1_us + 2000000;
+	TRACE_SMU_MSG_EXIT(false, 0, clk_mgr->base.ctx);
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 7b398d4f4439..fbbf9c757b3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -277,12 +277,13 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 /*
  * SMU message tracing
  */
-void dm_trace_smu_msg(uint32_t msg_id, uint32_t param_in, struct dc_context *ctx);
-void dm_trace_smu_delay(uint32_t delay, struct dc_context *ctx);
-
-#define TRACE_SMU_MSG(msg_id, param_in, ctx)	dm_trace_smu_msg(msg_id, param_in, ctx)
-#define TRACE_SMU_DELAY(response_delay, ctx)	dm_trace_smu_delay(response_delay, ctx)
+void dm_trace_smu_enter(uint32_t msg_id, uint32_t param_in, unsigned int delay, struct dc_context *ctx);
+void dm_trace_smu_exit(bool success, uint32_t response, struct dc_context *ctx);
 
+#define TRACE_SMU_MSG_DELAY(msg_id, param_in, delay, ctx)	dm_trace_smu_enter(msg_id, param_in, delay, ctx)
+#define TRACE_SMU_MSG(msg_id, param_in, ctx)	dm_trace_smu_enter(msg_id, param_in, 0, ctx)
+#define TRACE_SMU_MSG_ENTER(msg_id, param_in, ctx)	dm_trace_smu_enter(msg_id, param_in, 0, ctx)
+#define TRACE_SMU_MSG_EXIT(success, response, ctx)	dm_trace_smu_exit(success, response, ctx)
 
 /*
  * DMUB Interfaces
-- 
2.43.0

