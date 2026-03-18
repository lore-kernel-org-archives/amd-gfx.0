Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97502FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E10210E5F3;
	Wed, 18 Mar 2026 01:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCP/KyPb";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8F010E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpunU3AZ/JMwaYHH2uPlNJKw5BWSahlcwL0ycVNjtKyLUGK46xhV4xip7y48UFLVRBlMG4y0j7oT5PcJINdRv/8Z88D2PF0Nr7K0q1EW2xmm+Yj9sznJAeMXEjqgWIKD6GNMACWBrm9wciDwTxdR342Ie4XN9+e+7vQiCOPcenWNntGbM7PYevmKW6NEA5mD7riY1VyB01MlBJz9DIFXkB9b01Ii7l0Bwm1MxcOA8/2bOr2XDueFGZSx5JRmuE6Qr+L354TTf6sFyUG7MUIAmqrJSDJ5xKunMfZq1kQevNlMzx17vz1tJt838e3HbzDHb0YVxDMIE4s4XzAFIUVFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQvnorTo/2uarmsdQvbPXOIO9e8ZFE7g+w65cQBwa24=;
 b=uV7k3QR8XuWKm7zNeuC8kJOZD7lKKJPQ8z+a/usdonVvdfXnN8h59rgp7UTlVeGjNBY+szt3TW9Wv8wvvXL9luqNJFkPIIC0BI6lyla6Uar8z4eKHVdW1/+6hdPEzCRnZKeNcotVMNiJ3QKZ7bZgxaOzmgPVBBQEomtjixenuj6ehX+g4G12HPBM1iEmh+Z7e4xoG2gx6r/2VLDg111zHHb+OPVbsHHRPKdqqgCZM0Z7SzlQ9AXjkIQMScp/A1WqTxoeN8wfiEU8LXbKwSu2znaSCBvSwJf+DZhLaV+jIwcx4mzv4akNuQU5woj3b+oN8+6lKFaqEcmmXWVKb95qPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQvnorTo/2uarmsdQvbPXOIO9e8ZFE7g+w65cQBwa24=;
 b=nCP/KyPbyxuNCS6ibAc7LV5KMmPIMythXcj9hf4hr/xT8m+yXQTdFzJp5ady71zTuexDErfiME3Oid+3FIGN2F0gb7MLfN2+AlSJO5vOewtfPNkM9ttCf5lTYLnNs6H/3WLUImwWhUqada+aoMwbxnxkGlmbXdSTgTVLmVCrT64=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 01:01:31 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::f9) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:30 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:26 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Leo Chen
 <leo.chen@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 08/31] drm/amd/display: Add missing dcn42 hubbub function
 pointers
Date: Wed, 18 Mar 2026 08:59:17 +0800
Message-ID: <20260318010224.513094-9-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: da02673d-3731-40ac-0a7e-08de8489e3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MclH59Na09tYj2D9CWt3X80raZUWENe8bC6+BvvWGwtg8AqUZzoKHopt1oDl8bB93fBb7Efi3qZ4j2UnNMJXp8GcTTtBDBksD8BPnEsCwygpU9J2cbmUj8cQHZ2mr6rrtRCb8vOoGN4Zia4nML9MYliOddkkSulKEtV1u8BvyGzCFQCBUar+JnF0m721mEAenXfVkh+bEM/YBNEKZ2poxF/wGMX/KZMnbeh4ZlGtSpEBv0rhnTxngIR53MDuTFZKt6d7BR7KPcgVzyZfjZ7zL8gKxR57YFlVQw+9k+WMXTBskrGrSJY1gz2rCB5+dcebygGN4lTbCo3TMgZV8RgBDTKa1r52lmnVdZrHRzZiVp8Rvy8ZF5Txj52aQl7Lug/jYPwDhcqFjEvPEXto+aRUEno7bHbUYXkIaLuLbJ7tBj9vK9PykL3OPncBR0kRWLD2X9XILopIlq1JMLIfaGkds97On1gXfHEkEUFfHB92Cyd2d9JVUE5TL5FDH0ZjkIpkjE0jFatDdsuDiborr1HuaVrQa5HfsySgLANoJVaTLcAaA5w49ZnDgmci3l5EKVO9Q2iDQ/xFCHasx0Do+cACbhgR5WK5ahc19gzB6XSFJUiIVJkT72wGybnI5KhRQ9weI5u6BQH2JoZyjSkWODkTmKqVvnGsknq7ukuyATE6nX2mAR4xu5o+rJXtCQp1W3917R5CfHo7X13htR7ZObmLIyuOU00XD/Mu5xi5cypOTabAGfgd7zKtR/SpV/Ul1p3GNnJF8qSyYbB1sm7BYk48eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3MU6wZWcBMGiZY1V2dzfzI2v/o0jJkIE3/1/dXyMu988kNGLzpksu4vh87N+PgXGBX7pS/3FOm/c0b4NP5pSu7fIPoiUTHmKlb447XIiN5/Qk3ji26KK/TRhjWcvVOsx00iB+n2pA0DUVFWUozIk5Rq/J6Er9Ypaa+jlz0MtBwJux0GYNF/hhPDrIjZu1GCMdpX4YJ+XPkYR3E8VgC9RsWeVSPfcnBjN/LV49j/vG4KMy6NyQc5kqr7ktySU2EtHw7d+8sWUYFlwf0np+j7v0i7RW6y8P78D4mC1TgWzwJQnVktyaFyMu1uvbPyuFB0xGN9/zRfThMcE6h8T/mbVL5G5xSqNf2WPEMgpwIK878/k1htX+qItTYDhgF8oDRNL4hpcKwcFjn+hWqJJVNXQMsAW8uYP4lzQT5jQzG0u89muNbTVZrzoRzd3MAzhlV+Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:30.1478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da02673d-3731-40ac-0a7e-08de8489e3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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

From: Roman Li <Roman.Li@amd.com>

This aligning commit combines:
- fix dcn42 det programming)
- fix missing dcn42 pointers
- fix SDPIF_Request_Rate_Limit programming value

V2: Add back dchvm_init for DCN42

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index d6e6fbaa041b..9e4d526b6d52 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -6,6 +6,7 @@
 #include "dcn31/dcn31_hubbub.h"
 #include "dcn32/dcn32_hubbub.h"
 #include "dcn35/dcn35_hubbub.h"
+#include "dcn401/dcn401_hubbub.h"
 #include "dcn42/dcn42_hubbub.h"
 #include "dm_services.h"
 #include "reg_helper.h"
@@ -494,6 +495,14 @@ static bool hubbub42_program_watermarks(
 	return wm_pending;
 }
 
+static void hubbub42_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t request_limit = 96; //MAX(12 * memory_channel_count, 96);
+
+	REG_UPDATE(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, request_limit);
+}
+
 static const struct hubbub_funcs hubbub42_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
@@ -509,13 +518,16 @@ static const struct hubbub_funcs hubbub42_funcs = {
 	.force_wm_propagate_to_pipes = hubbub32_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub35_init_watermarks,
-	.program_det_size = dcn32_program_det_size,
-	.program_compbuf_size = dcn35_program_compbuf_size,
-	.init_crb = dcn35_init_crb,
+	.init_crb = dcn401_init_crb,
+	.dchvm_init = dcn35_dchvm_init,
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
-	.dchubbub_init = hubbub35_init,
-	.dchvm_init = dcn35_dchvm_init,
+	.set_request_limit = hubbub42_set_request_limit,
+	.program_det_segments = dcn401_program_det_segments,
+	.program_compbuf_segments = dcn401_program_compbuf_segments,
+	.wait_for_det_update = dcn401_wait_for_det_update,
+	.program_arbiter = dcn401_program_arbiter,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub42_construct(struct dcn20_hubbub *hubbub2,
-- 
2.43.0

