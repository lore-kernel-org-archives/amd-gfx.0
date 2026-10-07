Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442F8CA600C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A1A10F6F9;
	Wed,  7 Oct 2026 17:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/cNJrFX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C9E10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv9V+ewa7SDLPgX1BpB3ziKmzngPNzPam1SnUjaHSs18vgkqcFZaQWz4jkPzvTIX+YFrtNhBlohk1JAFeE6iyMF/xMjKXTvBAf2jD9V7yXww4ZUNWyQXoZtm18v9mwBiiERXQAecRFgcYJRue+jsY2HhPj3maPtGxmQNsJ3gZMjxNMK1igSJcRHoUUVvIYb1aFY/rg34yukgwjBPiL3tdqXoyEBVJxVf4z5TVv+6e3YIfgRPmBqeTffhtgPMU8EoErvCD2mxscoWKGeboUEGzMvV7MIfKfTdJSnkTKkMIfF0h4JgRbCBkGHJmm05qgVAqmiEpBa5QHOVfiq7Fng5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W3BZrCFslW8qI1wapbzIECZRaXFsFH5U1Iw9zn4hpM=;
 b=T0AaywVCtE9KrOZrkD5XeUBtlkYzpRpQ+9VZldgq4OM57Rqa7XWY2VPa4mJb05CMpOYs1CCro0eO4iea60ldtDRBGMyOeqULQHoCFZMonG6tpVYC7qet1ENGqef6C+Nvj8Pp7YTmHvYt0vP3CH0YK0ysG4j6KDLNidZ+EnopUGyf+wXF2cXQjaqXJ5QX9Wp0eFepEnFqcr2VW5pzafDJf0AtExLqRyiq2y8mX7UdM61tAGRCxrWh9Bk/GE3sIyjcu6R1S0MKEuMXe+fvHcp6qahShrVbRsk5ngaz3UKBDaeVYqaFT9xUStq0OUM4J78WsO4sKMfmXc1i4DcavZBJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W3BZrCFslW8qI1wapbzIECZRaXFsFH5U1Iw9zn4hpM=;
 b=r/cNJrFXfz+wAjMHIZbyzCgErHN27aUNuRHct7URGEaNYl7p8l2xdZOYBJQcswOgyZxWbZm6VN64BBX6nXtWkTL+icseTuHCh1YUi6X3me7i4BbQWltY9XhJj/NybiCv3qs8UcudXu3OoUX+V0sSYNTGX+iH5F7ZRUyk8EjnPKI=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:35 +0000
Received: from MW1PEPF0001888D.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::35) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888D.mail.protection.outlook.com (10.167.249.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:29 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:28 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 10/19] drm/amd/display: Update DCN42 cstate latencies
Date: Wed, 7 Oct 2026 12:59:43 -0400
Message-ID: <20261007170412.1898315-11-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888D:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: 8020771a-d137-4e6d-b278-08df24950ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p23jZAE4qK1lGGZj4dOdsdZf2G7l6pQSPx+OlDHNpKQ3OGnVmIZ9qfmtFFXrC4maM1YhzsGI9bb2uZdFCMLyrfnkO2uhd9C8D88bO3XlVryVu739cInkoZIbKTF8+tmU4RgV+7FsTT8HkmJxwPnkBoVQoQ23DFk9IMdBWGrxNjmeI5WT6818ghIFLnavy6yfQ51C0LmDF/uJlVQTbPHE76OuaAsE/q4guF63c73mAYBKJlEgj4ElUxPtqVpOUfzbyfrW8aEesq1x22jUQfrSMYcJNuMJ8Ac8OTN2QBaBsQyX4uO+3hOMRwXbOrVl8ErCDmrGcTLpKT5cJUv4AWG+IRoxWd1VPwcM1RUF9anwy043s1AuSTMOTN1ZWBwbdYYjYRYzPLF1NThhg9tT4dyO8doaARM/DqNAKFO1CmxmgF78bFR19Sz55TUYNqQvk/ffcR1ysgvnP8A/FbEQbA+GHrGA/d64m1sTaWU5G+YW7+HuetC8JTZVZdpmCL/7yyxhb2AaVfalg4RdvFMFhEEC9pqS9ve2c8VGZmBrtod6On2CbdZWbRhNKcUSJ1zfiboEo1RSXOXWqW9d4C6Qglri50xyzRZT+FaewfORgLRn7KDmcg2V9ntR6TzVBYyj/bmuGZeWQM4Wmx1+P8OPoqpX6EHagz9bVQci/cZjQDWxxeY1TEEcN3bwwG0GpeJDbJNlh78pSn5Ia0IxXH1NU9OYaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 59Xu0NKQcZpLpvuTY/uLAsjEGmlIhD8xvzuEBrF/E+mLIArFHWfxUoeNe306EwTS1uKkZUxlFe0EPxPUcKyRP7XeegSmcJUtTLXo+HKkosqebn1DIvTkVoo13tANagESyHk5djkuuy/uFMUx2yANAswFNAOh6RsM3OSqQKTOCZB64n+QawV6uIgt66nLkQpt/kEwj8+wiY335L95EJTOR/878XuLbPh9n0adznIA8NI8XBS2zuNyBGcocFVk/1ctbJsH71285VwvlKDJdwHVOcW9+RApoakh9ZFJfdzGQ87Z9u3Q7boFhw0D4O4iSbxx5hjTCvbM9qwIGAHDm3PbimdmfHEspTNAWg2LVztz8P/rxsypj2Vnz7d8oA5Fi/601Iir9evRsE131ygks3HosHs922CFoOz5F5xP6/QsxeIAPF/x+9bvYJWIilgKp37w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:34.5295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8020771a-d137-4e6d-b278-08df24950ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[WHY]
New cstate exit latency measurements from DCN IPSE for DCN42.

[HOW]
Update stutter latencies in the DCN42 soc bb:
- LPDDR5: exit 13.5us, enter plus exit 15.5us
- DDR5: exit 23.0us, enter plus exit 25.0us

Pstate change latency is already 36us for both.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 04c5f09499ac..139e0152fcd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -192,8 +192,8 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 		.dram_clk_change_blackout_us = 36,
 		.fclk_change_blackout_us = 0,
 		.g7_ppt_blackout_us = 0,
-		.stutter_enter_plus_exit_latency_us = 14,
-		.stutter_exit_latency_us = 12,
+		.stutter_enter_plus_exit_latency_us = 15.5,
+		.stutter_exit_latency_us = 13.5,
 		.z8_stutter_enter_plus_exit_latency_us = 300,
 		.z8_stutter_exit_latency_us = 200,
 	},
@@ -224,8 +224,8 @@ static struct dml2_soc_power_management_parameters dcn42_ddr5_power_management_p
 	.dram_clk_change_blackout_us = 36,
 	.fclk_change_blackout_us = 0,
 	.g7_ppt_blackout_us = 0,
-	.stutter_enter_plus_exit_latency_us = 23.5,
-	.stutter_exit_latency_us = 21.5,
+	.stutter_enter_plus_exit_latency_us = 25.0,
+	.stutter_exit_latency_us = 23.0,
 	.z8_stutter_enter_plus_exit_latency_us = 300,
 	.z8_stutter_exit_latency_us = 200,
 };
-- 
2.43.0

