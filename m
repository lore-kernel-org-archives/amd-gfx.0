Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECEDCD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FAB10F5E9;
	Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WX5aGfb8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C7A10F5E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJyG35/9/AWaO02zHeh96M3Om38xJkR6pT2YXqvPS/ZIb8ytm9uv9Fgnt+mNtsxyN/T+sjhAdGbvAKtd3We1zWiPiUX6qj+uQE4NkSgkSXZdOKAKYvdGaWKlwbbZiCRGYkZunsCaret+ECAM5Pnc/Qth9VsEBM7VCcrOIG3ls1sJcIf5jxl53Ih/QJvKuxQryi38zjibXjuiC0gmA1jbXhA06aJZBdJOjz1Kp288RIF7elijxcyCF3PhAP+R5GgcP6UIfBDqNIK0eYrJoM8kBGL6OdO5NCdN6d/I7C+UDRuS6MamJaF+TbNpfOE4IRfZx5kSgImFrvypNCR6WSHl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z25Ee3MAH7TBStzYd0jk+LZOufpnlLK/WQdXy5iFYrE=;
 b=fLkdDjoluFDJP6Xc2KsRGGBX2jiRey7gqZBS235bL0rl6totxRQzvS1eTgElm4qKp5X9GoAF+HOvb8F2vfOoUniNxXm6QzWE6QF9iHuaUjNg3TraQ8JefZhiyIQktY6RnJhgAbT68S1dUMPCPF1s457HyIWoDAzeKCmYA53j6P/WvbtL64WO6Le5Gdoh0LcRprd+uqH+KzMJZBIEUcaybJEJSa9KC8+NJRdJwppnngS/mL1ewOUMhUC4SvordejsF2dCT2ENoWh/H6z0YPkw9Wiv9v1k1Rtb5zBTFFTkyuuG32GBhSZlzMppCjzYu7OygZVJmxZLBrfp7JP8ond+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z25Ee3MAH7TBStzYd0jk+LZOufpnlLK/WQdXy5iFYrE=;
 b=WX5aGfb8YAKNc3ooxz0NR3bspu5TOYnqhGKWYbkNVspQI+ToqcYun3TvlspMGsIda/gIUC0ubLxLgBZFFoCHLcrsFwwklYT2i5OwOKoj6r+YVrskgjub3XgyVoXdq9Iaw3QDWrGqJjR3GDSgjXkb8Wo/gDBzE7g308hrVG65NiA=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:32 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::1a) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:32 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:29 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Add flag to disable dynamic expansion
 for 12bpc
Date: Fri, 19 Jun 2026 09:21:30 -0400
Message-ID: <20260619133154.116746-16-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4b63e3-273d-4f8d-26c6-08dece073750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|11063799006|56012099006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: dvXY//3aVwiUR7YvMSyxq4eFFjmbCvP2sp8gW2LusqyHh9RvPXoU2rRWIMs5WPrKPjjXSvdw1wt1/0KwA9H15jcsR7jjuhMqHs+7aAWmh19Tnv0YsRvGZfrNZCvrZzETcqWodLomBDVx8IqXzPjnGE0Q66ZNftHdMYg0IDHllhqKy03CI23c6Y95+LeJitR7w+JtGxlO6unLAEbTakgrPzOHjx2JVuqxbD+rQHl9wu9KSLnhTpKKRMfLAT7htc9LaGNB69poZy2i5DvdgWXWz2awomXCCXkd2HGwmhHFoNrQh9pc3tzvCeEgfbCWu8qJov/qyiYzuk81pEuaLOqTxtppzD1a993mWVXSmiXbiYZN24MpAqXY3z52wsIVg6PmxEmuHcE5XT0lbz8KE3XVmwUi+Ipyoi1/TOf0qynA3v4mM3IDgjjM4WAzekCM1tVqzwJ6L/SFh985H2tUwYRvYEMUuuLTHl1wKz5TMIAS9JPhax4lcSJiiM4ykpQTaaMXKV245kzrxi7lacnrUVGAO2G8tsmRrg1r3C5WBpni6RLkQzuHmuPLWfIKQ867Y4ewp4JlxX2pcTsKLPONH30st6IEePY6VywJaSnHq6I0e3fejSuJyW9zyOkTiZN95uKAMjZGk3PMxENA1NRnB9Cb9h+cQWoBmoyjddcw1mtG1TPNzUx1h3OC+JW7vcNfqc80afpjdeYhlnj/Pc1nk4//AA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oIfg7Hx7xDWO6eaTVJKqiN775umYGuVnap0fR+1JFuEkanZdURVO42PRBQICO3/JAce9H9q6WjZM4ooTTygqDiQUlOD7ocvdRLAxRTtPhAwTl96YxNivBS0m2r67Eo9wRPQmSO0Wd8ibSv53caTIs66KsT1SjzLL5EJ+GBOm/0wTpH5/B8tz+Y9lh5yqrcTKdOr8JZN0Nm5aMfMZEmubJYcThVkrCT/eKjphdodPdx+thwWyLCF3+Ci4U5LwRzUmrW+Tmu4+Xvp2TgWtlOZ6xsIqAsKZhH9f5xWI2D4We3b36zjeC/hdZhQ705gq0iTnxbuWnPvwPG51fLis0JhNXQT7ocdF2294H+bkmIaHLAzd91URs2ORruz0vhYkxLpghM5uapDWBwuH5tj2M/NrOeas3RQgu8BUDBbd1pQprMnEa//HXLCn79qxLju2RFhb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:32.0856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4b63e3-273d-4f8d-26c6-08dece073750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

From: George Shen <george.shen@amd.com>

[Why]
Dynamic expansion is not needed when outputting 12bpc test patterns.

[How]
Add a debug flag to control disabling dynamic expansion in the case
of 12bpc test patterns.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b21fdea5fca3..c2a1f75ae9ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1288,6 +1288,7 @@ struct dc_debug_options {
 	unsigned int force_odm2to1_for_edp_pixclk_mhz;
 	bool enable_replay_esd_recovery;
 	uint8_t iommu_mismatch_temp_wka;
+	bool disable_dynamic_expansion_for_test_pattern;
 };


diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index 50b6973ef123..881b8da656b2 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -89,6 +89,24 @@ void opp2_set_disp_pattern_generator(
 	break;
 	}

+	if (opp->ctx->dc->debug.disable_dynamic_expansion_for_test_pattern) {
+		switch (test_pattern) {
+		case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES:
+		case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES_CEA:
+		case CONTROLLER_DP_TEST_PATTERN_VERTICALBARS:
+		case CONTROLLER_DP_TEST_PATTERN_HORIZONTALBARS:
+		case CONTROLLER_DP_TEST_PATTERN_COLORRAMP:
+			if (color_depth == COLOR_DEPTH_121212)
+				REG_UPDATE(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_EN, 0);
+		break;
+		case CONTROLLER_DP_TEST_PATTERN_VIDEOMODE:
+			REG_UPDATE(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_EN, 1);
+		break;
+		default:
+		break;
+		}
+	}
+
 	/* set DPG dimentions */
 	REG_SET_2(DPG_DIMENSIONS, 0,
 		DPG_ACTIVE_WIDTH, width,
--
2.54.0

