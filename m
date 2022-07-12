Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788E9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0BF95092;
	Tue, 12 Jul 2022 15:40:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86D695098
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoKX4P8qdZ32eyQ5zSvWbDenDCpN5Fo9zct/VkxVF4/oWvxdH8D6ARDU9j/wMSpQtB9Qndz6dxlDUQVU2VO8XRwm/4sJFnR6zkM1kP8j0Vjq995WKOkbz145TkHWK0f6x6hApijGp7WJ/mih3wZl+ZwyonJvTwuhHZNJQXmPu1UhqZvCmqKk/6QR1xeQnqJKF5chAtQQelntOhDE59qEVO9/7xaTY4RiCLg977vNy793kpV9FuYlr1+N5gSKIDr29O9Im7Q6jKfuL6BpGAUZxG43tfIZUG/CHIj2DZo9dIiZewXLlRDYmXhBZdtby3EovJyrqTjodYr38j1UK9EcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNwl8W57b993cQLQyRzt6fb+3M6PLC9DHtZtUMkxZmk=;
 b=jioleEEoKuYkV83pEMRkksPjexlnQVjleCbw22dTvc3sjRrA1Qh5IA4JRmwBoRkLNcLhsJusU8VaO2auTuLTlbHLrHO3Ku2cIXZcTKyJEBQbv03znSSpQ3Ke0qDpKRobOU5XsA28wBoihboqPygR2wvlTP4ne2y6zBuiuM+J7MAHoyd3fWRvg5FKc5UPisrt8sAIrp2P+5pY2wBDCr6m3LS8mceEp7JpX95TIBMX9iAu19Dsesr1aLjJmIydoOFey+ZaL+GYcepRDfOuaKpVjCva/DM6ScN2EbnP1/z8nnT6kL+3vdxf0l0A+Zc1nPKz5VFjyEOxwg0hsmVoztsWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNwl8W57b993cQLQyRzt6fb+3M6PLC9DHtZtUMkxZmk=;
 b=g7CtI89p9gHFoeDXPSPcgk3L6kRv86ySvjF2ccNuRo5hHOwssRHM4BEfFuqr7E9xgOiuW+Mx2lG3SrU4Ig67Mxkr1br4wcDoOsx8PgM91aX+VcGxLhcUpX5RdV8uj/IDiwrPFYazjEEugNEYWYn6i7DbB6Qjb2eosjCoEdcC5Ck=
Received: from BN9PR03CA0130.namprd03.prod.outlook.com (2603:10b6:408:fe::15)
 by BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:40:03 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::57) by BN9PR03CA0130.outlook.office365.com
 (2603:10b6:408:fe::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Tue, 12 Jul 2022 15:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:40:03 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:39:58 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amd/display: add system info table log
Date: Tue, 12 Jul 2022 23:39:42 +0800
Message-ID: <20220712153942.501396-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778cca1c-8c6c-4019-ec05-08da641cc9be
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcKGcUU0v5D3nKfWWMvaG4dKpqUqyO0tWnEO4rKL8Mzk8zLy+TzVDDVjduZlwsBiYvZAVToP0SCb4k00ao00gycRjrKFsBdKomNUOvC0LMdNUPD5wD+ifYgwzK5TGXP2TLnllrLS7psaqYkjlgovGGSxwcLcG8ZZNHjLJejN7uXOrLIVqZzqBIe/+vZXcHECzopaifKys7KVn8LQuMCGEusnfcvc3B222LP96FTNouUfyyz/UP3UZqJk78xZClk/pPMLeFSq9ehB9dclppbj6X33cjSvRCsaO+tiY618oFMUBa0F3L045UAXfGiB5Jg1swXDjkiWQ/0/GO7a5TsJkZkjIe/QSvaA9olOG9hvpl/lMvWqmQv6wixlFgrmz6Wx9plf5LoVknAC9ZJx7WuvPry5OT8YBf8zsYEb3C8mWTXA/5IRInZca2mI9TkaOtCf4Q9kPA5owxmRaxt7Qs4UNCYeQXcibmYiROFRpJo8nSBpaQacvKZx3nx1otCAOSFHS3MPlEVUngp+/RpIej8s/0eUCy8L3iP32KwqjOlQtK4sU972XoXae2X9f5s0X57+fvLcYwsCSHpC0U3igbXgBYHTugdG6NAVGisYyALQ+1PEhXUYD3s/34bfbv9+xRRa4r7WgKFd4Thoi0xDkbC0un9mqFW/sngSqfj8lvzvHiYhhTCIPg3udfCAe6WrWqTNiuOLKFmGPvHICsE7e7PRxmBKdl2yLIs0BRdyn8KjvDHHhgqH4VcburLb6NuHUrRUoHMrsqLp/Oth+wZkQVx1NiLK+LEJ6CyR3drvBlINS9E8Jba/blk81wWMPm5uWSWc8qWdICuCbUIymZFmCKdujxGdqOcSjJi9lYhz6rZ9xSU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(7696005)(1076003)(356005)(81166007)(8936002)(2906002)(316002)(82740400003)(4326008)(70206006)(6916009)(40460700003)(86362001)(44832011)(70586007)(54906003)(8676002)(40480700001)(36860700001)(426003)(5660300002)(82310400005)(16526019)(186003)(26005)(36756003)(47076005)(2616005)(336012)(478600001)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:40:03.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778cca1c-8c6c-4019-ec05-08da641cc9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
insert log for debug use.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6f514d92b401..c2a5ab3e5f2f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2079,6 +2079,7 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 	record = get_encoder_cap_record(bp, object);
 	if (!record)
 		return BP_RESULT_NORECORD;
+	DC_LOG_BIOS("record->encodercaps 0x%x for object_id 0x%x", record->encodercaps, object_id);
 
 	info->DP_HBR2_CAP = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_HBR2) ? 1 : 0;
@@ -2098,6 +2099,7 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 			ATOM_ENCODER_CAP_RECORD_UHBR20_EN) ? 1 : 0;
 	info->DP_IS_USB_C = (record->encodercaps &
 			ATOM_ENCODER_CAP_RECORD_USB_C_TYPE) ? 1 : 0;
+	DC_LOG_BIOS("\t info->DP_IS_USB_C %d", info->DP_IS_USB_C);
 
 	return BP_RESULT_OK;
 }
@@ -2944,7 +2946,35 @@ static enum bp_result construct_integrated_info(
 
 	if (result != BP_RESULT_OK)
 		return result;
+	else {
+		// Log each external path
+		for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
+			if (info->ext_disp_conn_info.path[i].device_tag != 0)
+				DC_LOG_BIOS("integrated_info:For EXTERNAL DISPLAY PATH %d --------------\n"
+						"DEVICE_TAG: 0x%x\n"
+						"DEVICE_ACPI_ENUM: 0x%x\n"
+						"DEVICE_CONNECTOR_ID: 0x%x\n"
+						"EXT_AUX_DDC_LUT_INDEX: %d\n"
+						"EXT_HPD_PIN_LUT_INDEX: %d\n"
+						"EXT_ENCODER_OBJ_ID: 0x%x\n"
+						"Encoder CAPS: 0x%x\n",
+						i,
+						info->ext_disp_conn_info.path[i].device_tag,
+						info->ext_disp_conn_info.path[i].device_acpi_enum,
+						info->ext_disp_conn_info.path[i].device_connector_id,
+						info->ext_disp_conn_info.path[i].ext_aux_ddc_lut_index,
+						info->ext_disp_conn_info.path[i].ext_hpd_pin_lut_index,
+						info->ext_disp_conn_info.path[i].ext_encoder_obj_id,
+						info->ext_disp_conn_info.path[i].caps
+						);
+		}
 
+		// Log the Checksum and Voltage Swing
+		DC_LOG_BIOS("Integrated info table CHECKSUM: %d\n"
+					"Integrated info table FIX_DP_VOLTAGE_SWING: %d\n",
+					info->ext_disp_conn_info.checksum,
+					info->ext_disp_conn_info.fixdpvoltageswing);
+	}
 	/* Sort voltage table from low to high*/
 	for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 		for (j = i; j > 0; --j) {
-- 
2.25.1

