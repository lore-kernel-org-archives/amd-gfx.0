Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B2AC77B76
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 16:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A0310E3FB;
	Mon, 17 Apr 2023 16:58:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC3E10E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 16:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzI5UoFSTN1+cfbMFvxtl7sF1tHsDzc2X4AuyJoikK2K9JeTxlgoOluRK/A4iDilceAr7I3NJtQIquxIhFQ1MHMPFHIFYJuYzD6AYhgSYDOHqPJNvmH4ZDjPREZakmbLZkwTF8kiA4OwVKcxmxrb01S5EYgWw/NKTUqTbPb/sEMUEZ71dp+ffgFvgCQEC0Ay+hKezs+qCADYXmu3mhPTDcni00iwv1jebgJ8Spyih4w8JlUuKZ3GyfZHuEqLHaGsPXCO4sYUkYPREBvpHBj7kX0z+q2WWsCW0CxSK1AOSE+GGIckAKRELBY38z1sX7TqMvgKO7++2npx9idufhP5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORh3C8LDIzhGYYnNlNglp/7mYAA1/m2OvNoRl1W8wRw=;
 b=jSaC0eM9NBM5viXz/9vEWloImupApXhYGHdMfQyZ+VXS2zOQAw4iVacGqnB9G7Q4QwPI3Z9d//V3Yj3X6/t9ckiVFN/YnRqg02DB+SWw+j5f6YOJTnRvZpg86dgAGuqHzXaru2m8msHKbU72rsEdZoYlYM13clQfPf9feeW7OtIYsbHV+YhrIlqkwrk60EYe4YzVSEdnKccdPR5/HkyRlOII/NxsVvLvGQcz0oqBM1QY54UNmLAjNCrNlUtIaDEVugtV7BHtsdDhqlqS5iT5ux/d1fEhkyQ3CThMmDXWbwfyPLPDi8tioA6MlHWCFTJ+fi6ESPjw16s7YaxyeRllZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORh3C8LDIzhGYYnNlNglp/7mYAA1/m2OvNoRl1W8wRw=;
 b=Vmfa2xiy79a30Z7zcFr68KDbXo6DLBR3gNGNgiXLddVL5F4EyASpWI8/PbTqSZvgprEKJHYaXndPcWtJWK5iH4HZUKD4dS+toTsYlg8Bwc1trmBBOZOCEwMcJqqxrVRmooNgzRpWBbrML+64Ezt4EFJvyjEbo2GRKfZQY5BabpE=
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 16:57:57 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::e0) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 16:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.19 via Frontend Transport; Mon, 17 Apr 2023 16:57:57 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 11:57:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH v3] drm/amd/display: Check & log if receiver supports MST,
 DSC & FEC.
Date: Mon, 17 Apr 2023 22:27:34 +0530
Message-ID: <20230417165734.3812299-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b331443-dd2f-494b-6f02-08db3f64e4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AUnRAhvOHAlAcK/jOafPsS5DAkeYyQ6p3C2Y9tc2ylyL35aN7jbsSwMayLq0fhrbj0BTzMheD3SkdnB2yLMRkeAjcwEzP7bqx2rjnRbq7hXPuf5b75Q1d/En92QaLDSUmNf3FweCNLuaF2101BygQPrEABUU8f9KeSJS3IGMpFkR27h1e6EFIvgoYCVKRucNIHPtvOoMek/pDiWUa7AQJRjTz1ZWjX/ZjZbeCY6aXP+NfbuFTb3hqFBAlI7iPLgHcvfAWKxR5nzQufcjNQMMy3fdeaVnhlfsx6WsEC+HuYH3EgfqyOSGXGvJX2egUqb0NyZyoYhVM725WhOotj2Dqut8iLUFfDlOtZ+O4zLduNqdrHp7aZ+a9QZF1lUNzqorLN7cO9UNomOnOmStwLnd0ZigqzdVPSKzUCwRDEfqa5jHqWeMcVC1us9JdKcBaNxjNSMeYQ9SuDisB6/yefTwTLPI2BdyIwCvdE8Atf2H3hOiJe3HuRFZZbRVFZ6q4DKMUq6R0hv4CkQNbor0zlnyvoqZlvfQDbnr9yas1LzZDnDhBfVD9lq6aqD6gg6JBK7pzq2fSINH3MboNLaUUiE0lZpaJ+O4VGyMQvfhWkAkUNAkka5eyoUo52Vo7tSyCmi/VkKNCNWU3y6u01sl9LYbichYkosGwA4aI1HELx0YSZ96ow3CqUchr3yxLETbshwAiLUBF/13thGt7DwIh9GvXNSBkfcN+Hdpnkg1CsFsBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(336012)(426003)(1076003)(26005)(47076005)(82310400005)(36756003)(16526019)(186003)(40460700003)(2906002)(44832011)(2616005)(36860700001)(7696005)(5660300002)(6666004)(8936002)(8676002)(478600001)(54906003)(81166007)(356005)(110136005)(82740400003)(41300700001)(316002)(70586007)(70206006)(40480700001)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 16:57:57.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b331443-dd2f-494b-6f02-08db3f64e4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After reading from receiver via DPCD, check & log if it supports MST,
DSC & FEC

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Added %s: to print the function name.

v3:
 - Used the defined struct instead of the bitwise logic here, like 
fec_cap.bits.FEC_CAPABLE. Makes it more readable. (Aurabindo)

 - For DSC, it would be useful to print both basic DSC and passthrough 
capability. (Aurabindo)

 .../dc/link/protocols/link_dp_capability.c       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ba98013fecd0..59adc61156cb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1554,6 +1554,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
+	bool is_fec_supported = false;
+	bool is_dsc_basic_supported = false;
+	bool is_dsc_passthrough_supported = false;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(&down_strm_port_count,
@@ -1696,6 +1699,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 
 	/* TODO - decouple raw mst capability from policy decision */
 	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
+	DC_LOG_DC("%s: MST_Support: %s\n", __func__, str_yes_no(link->dpcd_caps.is_mst_capable));
 
 	get_active_converter_info(ds_port.byte, link);
 
@@ -1803,6 +1807,18 @@ static bool retrieve_link_cap(struct dc_link *link)
 				DP_DSC_SUPPORT,
 				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
+		if (status == DC_OK) {
+			is_fec_supported = link->dpcd_caps.fec_cap.bits.FEC_CAPABLE;
+			is_dsc_basic_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT;
+			is_dsc_passthrough_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT;
+			DC_LOG_DC("%s: FEC_Sink_Support: %s\n", __func__,
+				  str_yes_no(is_fec_supported));
+			DC_LOG_DC("%s: DSC_Basic_Sink_Support: %s\n", __func__,
+				  str_yes_no(is_dsc_basic_supported));
+			if (link->dpcd_caps.is_mst_capable)
+				DC_LOG_DC("%s: DSC_Passthrough_Sink_Support: %s\n", __func__,
+					  str_yes_no(is_dsc_passthrough_supported));
+		}
 		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
 			status = core_link_read_dpcd(
 					link,
-- 
2.25.1

