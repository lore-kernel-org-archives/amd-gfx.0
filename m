Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAD5D6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E910F27C;
	Thu,  2 Apr 2026 18:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujiHl+br";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3DD10F288
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiCMJ3ezm0XNKfVTzDiazlszoXsfArT/VD+iCPyrWxtXY8YJFWBeerFufQ+rGmkLqJ/2UrKc5WgOXtz+bzgUh+QrTrquXKuPCr5gaADp6DCP1bKF2BpLo0Ve8f7HYZ747s4rRkg6tXG48XiMvxq81H4tXEpmvV5CM13R/rq5khAWdGnSZFt2fQyeTowVPSGB5AMTtEDovyWn8Nnv3L9THy0cLBqpQWTeRwBdG+BaqcJkIFVNgPANWQLII+62fbflV4Bbp5Z16ic4dwWbj/JJbQ6/g9exA3ly0II44wJRTpJdNWZ41W2W0nR8lxgqCbL1UfQ8fSFmYmQaLzzgvG/QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNSB9DTq9IOse7uK6fquS/RT9tjo9Ksxx2lsohItG7w=;
 b=RzMspwALIdQXaXJKfUsmiLKEBCBj7eQOsug4drln3AP4rA+odrwVyoGEcDSjld7vRMJWjyEFnHDiWr9cCr/2Vcubr4cXD5GKvxBtHDquJf1SRnrRT3X0dKzsv+aTArZj4KBaRqRBJHVi1Y/ivbK8urytlDslj6kPiyv9TRdP6bGet8eDeUnzhrmcyFz+P9CSef5ClCWQ09J9IIsAtnBBoW5OG/62+i6pZl/UsKrOPsHn2PuqlKwh8hUeg72l36rb7S8FUNi+NsA26q0mOrpxBJrMQAhipBGb6ensnF8zqpy309x+Mmbl6MVykBDmBSL3d755hjsIHzUtWoXAGGhDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNSB9DTq9IOse7uK6fquS/RT9tjo9Ksxx2lsohItG7w=;
 b=ujiHl+brFxSE4NgmBEQKKQ9dkmYD36Xqrv7gLVb4gJgRbO/N+Pa5E2ix6p1stLkupZ/3kqkRq9KK9MW7cyK5B/rRbTEy6EbamBPlYfnTVhDJct+Z5/PXnDvpuyJ5pVHpeqi9Pen2JS/4L+opYKTIo4TZ3VefU12Hcx/FbrhbWVQ=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:34:17 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::33) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 18:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:11 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 15/22] drm/amd/display: update dcn42 memory latencies
Date: Thu, 2 Apr 2026 14:33:07 -0400
Message-ID: <20260402183314.1388755-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: e383ee41-c34e-4144-42a8-08de90e67222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fywE7Bv/wlMe3T9P7cohn98Ti9MdLS27QewNnPuE3gzS4oqBm3DnQKxmoDF1ChxufN5/uTN7WLJlQQ6c2RHRDXfp6MoIfJr1uZva8hvgDuIPptKAE27+3cEsT91c7hez8HaKckUiBGkZ92zZgDbom8LauVdGrVDSyVqmrkd5e4tzbvDc/YDAuqfotGwXPIzqjnDe2RJtjGJmBbvrUxcNHr5V1xq1nLroyx9FhwUaERF3x6kNmvEaa0qVce0pag7xalzM/Qzljnfjoihyd1JOd7f+rIqULCOSolb8+TW04EsFvHsXmpnJbVN6DKpXLATjBgkDf4RK/P9ahL4UFgBRWhmJgbkUnK/Ei7/WeJg35WqF4/W2AsyZHOJigD2hxgr6TK9HQFgm4xZmy3fl5F8Nyud1bGCZYpkTWCVB8Pl0Hi+Js7qs2wd+j1/iFryQoGNnqLbXiw6JyNtQqp1MLuDsuU0GVrVapafkci/DyBtdvR5E9MhEi3LQ01wDiahCO6zcEkEkclaPqP4tlikbgQYxsiIm+6shWFG1og995iTqQU7re180L8zs0XFMtqV6bNlnloaBxPygO+2vS+4DWHJq/3ldUH8SVIUd9FOp7JGVgzKXLMBffn2UITVAjrjy/vUcaKSVuMxcSjZRJWiftypNJOKbUEllt6Dxcktt12p9xWEkePsPQDD9ZyE3nDp1n3T5Cu4T5IxCOGuNkNopiCwtA6Zr5f0f6wSs/1P6y4plSD628PAMZahiut1kdduJI6zvb7IPRAnw9JCQEyUQmSpq/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7h9krQFDRraqHc6XcbccExZxrAOArgHbsoh6PvgHRODGUIaryzn2XOdCjfXWSCZvBkRjAbscQygI2+h4JHLC51O2z++P3lxMPu6PCMtIuxZSR3Vvxv3BrloDsaU0Zqn8c+X2EpS/q5Ofhhs7OEYA8jRfDF4c3KSrABFSYEmuFbD0bvR28v8rqNWiN0GXqaOlU63VrZrvxDEoiMAOiuOuVgR/f8uCZMUYvluzlZeuqcPxLwdIl8yvufHVQbT9hL6py/ymkNFq7Rk1OI9Hfr+lZ/56lIMc+G+EH1Sdbp43fCAqvrCgPNez/04wk5RmUiAcl5OjgnWbMiCWzmakCceqGdMd4JfibLQVeEy9s9jTX/b8YxH3aGLZKu9xepzvUxuRHyfLDKSwtG4CNglPwjI+0EW1Ml3dnwdnYLgdc8LkeMQcsd+LpIBAQsdr+zqIqelN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:16.4630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e383ee41-c34e-4144-42a8-08de90e67222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Add latency update based on memory type to dml2.1

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 9ee092556233..040d89f6de35 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -68,6 +68,7 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 	.qos_type = dml2_qos_param_type_dcn3,
 };
 
+/* Default SOC bounding box for DCN42 based on LPDDR5/LPCAMM2 latencies*/
 static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.clk_table = {
 		.wck_ratio = {
@@ -185,12 +186,13 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 		.qos_type = dml2_qos_param_type_dcn3,
 	},
 
+	/* DCN42 params for LPDDR5/LPCAMM2 */
 	.power_management_parameters = {
-		.dram_clk_change_blackout_us = 29,
+		.dram_clk_change_blackout_us = 36,
 		.fclk_change_blackout_us = 0,
 		.g7_ppt_blackout_us = 0,
-		.stutter_enter_plus_exit_latency_us = 11,
-		.stutter_exit_latency_us = 9,
+		.stutter_enter_plus_exit_latency_us = 14,
+		.stutter_exit_latency_us = 12,
 		.z8_stutter_enter_plus_exit_latency_us = 300,
 		.z8_stutter_exit_latency_us = 200,
 	},
@@ -222,6 +224,17 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.max_fclk_for_uclk_dpm_khz = 2200 * 1000,
 };
 
+/* DCN42 params for DDR5 */
+struct dml2_soc_power_management_parameters dcn42_ddr5_power_management_parameters = {
+	.dram_clk_change_blackout_us = 36,
+	.fclk_change_blackout_us = 0,
+	.g7_ppt_blackout_us = 0,
+	.stutter_enter_plus_exit_latency_us = 23.5,
+	.stutter_exit_latency_us = 21.5,
+	.z8_stutter_enter_plus_exit_latency_us = 300,
+	.z8_stutter_exit_latency_us = 200,
+};
+
 static const struct dml2_ip_capabilities dml2_dcn42_max_ip_caps = {
 	.pipe_count = 4,
 	.otg_count = 4,
-- 
2.34.1

