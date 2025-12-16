Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4DCD5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C5F10E7AB;
	Tue, 16 Dec 2025 09:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dkhOmcBA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5158310E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkW+2eKZod3LnCz4YbA0lRArcMpv4gvy506kN+nuwMLLah80pfQ+EduhT7tLq71TgOqlLdMhWX3SQmiQ6QY8IHedoKDxcr7gt4WoqRD0T61caEKhl+RVUL3I80j0QtvxbEZ8kOK5ucxNxyjrP315XkVla4na2gyLt3XOnA9SlXGr/2l8cfAtpEqUCTVW2uKCg1JYRfBNflrOPQeLjKZNFrrs3wcP7ArpY5cxfomh+ajPuJ4OQzCmPY/Bd1JjejP5Kn1JAmjCcuytj7UeMUwrUPV9icFdc77YQDIcuokSud7q19+W+0EiJYwBlc62IRNFjVniTSaFnInQvVRcPxjdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwLUrk+VZCt47B2Kl4oIFCVZus1AKdzIJWHdeDzsjMI=;
 b=ZiNfWEkPIWAbSszKxsEHZHk2y5M5Pvzv9F9CWOZIbFMgMpoosIR1Tb33USChBKdqUAMUd8sKUb1gl0mZPEFS3A24U2PPQTrmTV/RWUCsmrrlq0vMToL2JuUjmWTXdy2ik/wIWCfxwHemsD7AFClABhd3EMb1mema5yKn4034+XafXJ95HFs/QNqX2YCiiKmIEaSsC+u1aKVhX1u1MkOnlDcf5uXrAcJnIGomKw5sjWOXAbkFgi4FRDMdRx6WRLDRbr6Mw9BIfYxpDPeC3i1+yv0wFVW/plD7DFoDSK1CYH04qsPi+vHvlnx7oGXD9tOB/chj7E0zNQkpU3SCSGwfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwLUrk+VZCt47B2Kl4oIFCVZus1AKdzIJWHdeDzsjMI=;
 b=dkhOmcBAoJA3GG3ik7XXqDN1YhZ2teLLedc47noPf7uQ2QQcSJdkzBMbSx8wfMWqrBSf9P7qI04E0rnUdmZbgYrliDpLhjjxNBQrOJfUZEuTkFccHIpy5Me5G6XQkCm+PQ0HoXqfRA8xJRSrywR4SsusVSXLM/l7OOnJ/1ccEnE=
Received: from CH0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:610:e4::12)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:58:10 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::1c) by CH0PR03CA0187.outlook.office365.com
 (2603:10b6:610:e4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:09 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:06 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Mohit Bawa
 <mohit.bawa@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Fix dsc eDP issue
Date: Tue, 16 Dec 2025 17:56:11 +0800
Message-ID: <20251216095723.39018-12-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 994f83c7-b9b4-4013-0e1f-08de3c899ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z4gkazQUJpqATZj8arbq8Op9/G/ULQDYb/hrgvJvSKRNpadcXDW0z29G0QrZ?=
 =?us-ascii?Q?jHZP5Cpg23WOBsDW9WZtbMqMdYjzHaqc4V3q3L5y4SX1fGxOhp/05yqEP0XG?=
 =?us-ascii?Q?paGluuXp4dutbRiR7xEHwg7fZ+J6zmFdEoMnRRStY4ZhVeMB/aZQi2ctvwDr?=
 =?us-ascii?Q?AggXRffuCdfM6kxi3pqkVo4UyynGrD0t1xacdtWzi7Hn3sI+x1cHH4fnVKIm?=
 =?us-ascii?Q?pNC2jUQXKUmqpauB+mQml4+2jWPa7e0wz3Ax/CNZN9MeSfS0KmUOUDCgjwOJ?=
 =?us-ascii?Q?9y8hDZGhSPgafS4YoKnCoKYJ+2xnM5R5kwq89OGU0H7Qtc5dD2CdXintY4N7?=
 =?us-ascii?Q?0x3mHdgibP9I4S6cc2oC/aJQrTrJFKu7WhwRezsPMwOCZGmcVy1juF6SvHMa?=
 =?us-ascii?Q?CF9tau8PTbiko1gLYnfHEoNZp9O23Vz3MJsPKK7XhwDvSoMsUH2wi7bRYqT6?=
 =?us-ascii?Q?OqDRPEbNG+wHCUPUu1Vgqvzl/LGa+tSsCtOdJmlQcM1D4Yeor6EPD+2VThhq?=
 =?us-ascii?Q?a9SErQfpC/DJarjljT+kReLLMyvkhsU5qqPpRylwHbozDEbNxq6Ehf1P1oGi?=
 =?us-ascii?Q?v/r/4Yxkz0XVzJWb4abAVBUdCUVzFLD7KWGypM3Kl6BD1dJx5Eg6LeEJaUT9?=
 =?us-ascii?Q?vEQ4JpcVehabxLfR40esrA87rase0ICOCryohRD/YWnaeuZsYm2+eXR6Sox5?=
 =?us-ascii?Q?Q6L8hAQIIhtNKdV0pdmGo2fXi+WgoNXDjJltMLbQjfrRXQRe0gC8n38rxMqG?=
 =?us-ascii?Q?hqeDzmhGTmScVOXDz2ufRjlfo28WVv6X1NSUG8EV3IhKXdQpD0ovvDLF64W1?=
 =?us-ascii?Q?75eBaaNSAVp+f5W0KFAh6gLUVjVjRf+5hHVXccpS7lakzmqMmdCaMc5F2dh6?=
 =?us-ascii?Q?4CwXK8Qdzht3O6e8NcahVwyqPMQK+M+cVS0roB3F9Rpeuy2X5XZl/4quZBbM?=
 =?us-ascii?Q?1N/BpW9+7gmw9sVXz++RTGWYKUbWQ70GRJLOw2vZTUXv3nybUVl6hdphmx6X?=
 =?us-ascii?Q?5wbTlEvK5Dvqe12s5WqUGkGiPOi37pDQorBuQH6YRUWzaMZYIM+FbmLbpDPn?=
 =?us-ascii?Q?DrHw031J7OjRLEe/uJRXFCiDz78Jv9q1yvJZchHS5+ZWSqhRAxtdRaiVjXyF?=
 =?us-ascii?Q?Y2tYHap6B3H+XHcfy3lB/W16V77W3Eb19JCuQip8RLRgULBwkX9tpNZqRlYT?=
 =?us-ascii?Q?AHS4hnZqiiBiprcEM5FKtEMOMSEzJIXVOPig3Bb187usYrlB+k27Bg8yxudY?=
 =?us-ascii?Q?2EB1Z5VeKua1JihHcEv3jfgjC+/YLKI5vsl9v3+oIVaYqHjaY6Ep0q5vg++/?=
 =?us-ascii?Q?3DRMdweJbCl0N27j7u2FAhaSzzjQ8O4h8nVvQVeRNGvznFMhZdeFJ+9WjhBN?=
 =?us-ascii?Q?f5ZJSbQoEKi16jGTHdDU+JDETj9LA6EDVauIh9oGiAZWNP7fLTZ62EwEu4pG?=
 =?us-ascii?Q?QlGyOnlrdMAmYMfYLczuVpCHzYdFNduyDGthxAMi+qhAqIeuzVdEPHwm0ELb?=
 =?us-ascii?Q?1GFq1Ie2ef9KnoSxJaiMS3aU/m9zI9FVITKIKPjei2v28EckhjzpWQ0P/lC0?=
 =?us-ascii?Q?Gx5pgfL29mvaYVzEjdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:10.5870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f83c7-b9b4-4013-0e1f-08de3c899ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Need to add function hook check before use

Reviewed-by: Mohit Bawa <mohit.bawa@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ebdb885826aa..c5761f3ed0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1846,6 +1846,9 @@ static void disable_vga_and_power_gate_all_controllers(
 	struct timing_generator *tg;
 	struct dc_context *ctx = dc->ctx;
 
+	if (dc->caps.ips_support)
+		return;
+
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		tg = dc->res_pool->timing_generators[i];
 
@@ -1922,13 +1925,16 @@ static void clean_up_dsc_blocks(struct dc *dc)
 			/* disable DSC in OPTC */
 			if (i < dc->res_pool->timing_generator_count) {
 				tg = dc->res_pool->timing_generators[i];
-				tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+				if (tg->funcs->set_dsc_config)
+					tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
 			}
 			/* disable DSC in stream encoder */
 			if (i < dc->res_pool->stream_enc_count) {
 				se = dc->res_pool->stream_enc[i];
-				se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
-				se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+				if (se->funcs->dp_set_dsc_config)
+					se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				if (se->funcs->dp_set_dsc_pps_info_packet)
+					se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
 			}
 			/* disable DSC block */
 			if (dccg->funcs->set_ref_dscclk)
-- 
2.43.0

