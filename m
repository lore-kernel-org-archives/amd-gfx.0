Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD78C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4E810E8AC;
	Fri,  1 Dec 2023 13:31:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB8410E8A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWTBGKVzEthwLPkxetpXx6jKZdGe3RaIlO8X8UuNDFAbxJ5WNQYdyifMSVBfwaB0YDVGZgskjHNKmrITao+ZH15D0IHULvDow7PyXgk2iKN4nL+XaZLO47A6YP4DqUHmDMRK7PJXxjWhJ9p67w0lZTIKQ/K/KxTQa7SA93nEHEeOboYxzkRW3A30iZZuXK5o9zTfxKq+NYvbx5MaLS3ugYmAERCI3YzkDVJpgrMaz56g+IgLb7VvpuTHXdaYHBN65XyPCsgderQrZFWtBpxbCG5CkBkeH032EkOIWdvej7E1Ph8GWwM2M8jjRl9WgY3LsMddfzA8bQSvB0Wl1a8SaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFo0evIzajkvNKNCz/rjlQeQifijR9V9bhR/yOrQ/0A=;
 b=T7NLyiYIbTVWO6ohhqybfxNUQFVjMfhJ8bmirvTK4ms6UkS+MGqMcOKIHdWbaAE4DKo8Kno8f9oh3bNcq3a6XeMJojHxLc2dF2iP8dl6PBX7AZPwfgD3O7jsPa/TT64z3w2PYoa59Rs5NAa7pkjgYFybOWCUVnARn1RUurskU1uJZzn9r3wcc8bZ71vLTCN7Dpq+IZ8hx0nqm3hCcrYHSZrd/m4dkOob+oOgoYsqP0zyD1Tn6jH+kosz4of+PS96YckTRyYJvXh9i71MrAY1vgBv+mjmpVeVSptoBNqPLKFqGUUoIshXYw6vC7ITF2l0cSBIPo6kk73o90JlGoPj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFo0evIzajkvNKNCz/rjlQeQifijR9V9bhR/yOrQ/0A=;
 b=cft/5n/w/Kuy+yrIqUplC6bZozYkI0wcRPpPc0ERP02gTPnB0v3IR126+Tz3WOhw37Ay/TTBhz86RD1WXAgnltqgm3X1MfnPwTj0otzfpT17CcdnHlpo+p/LEw2jDeLu/drNzsSIrXucLC4maJD5fQuOoc8Vzbd7LO3iaDikCqs=
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:40 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::59) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:37 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 45/47] drm/amd/display: Adjust code style
Date: Fri, 1 Dec 2023 06:25:41 -0700
Message-ID: <20231201132731.2354141-46-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 04613773-5f1d-4603-29b8-08dbf2719204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHJaB8zR+Oba2tW/NiY5/tFXXK5nqBKtcTGXMk3U6r1voZVXhkStrHbk61w9/gGTnbDuCnnCZgi88O7YMnTmh26JD9ujDS78y65EmhRPIFFTZQehh/xDOkfFpg588LAEzB6CmQJKg3/BmJvc2Y+zxMwhz605tBmIe5tSkVz3tkrffqJGhMZxY/+wzJ4jL9Q7kZ5roPLGVNZxeehrLOzBlb4ARRjIBvnEIXKMeFkHkgp0Q5L5clxHJJqdR8A/ygZ4L8x8ke0J61kTKlsGgbwCW/muAebCqZcIN4LcRDOuwCdvKg7LtY5+BKUWRzdEpO/9LWZBzoNa65/v3JPVO0amyE0TPaSZezkJX0wty/8JGsUfmVMyFwV51uRKeNFYBf4NUKva4TGpv5uTMgFfCUVMKatBKWaB3GkUyWLwqsIxuGxeYgjlc6hA0s4gGWP/L4U5niB9+BjWDj3QJ0ONIHE7wI3CgE83eEEUPLRy/7pTQx5tiaOfQwoxXb24ZDgwrkJ1nXyTFIWfLEBnF3DeqPameVVnlhGkfYFqnefEt2yxytMqP1ZqdFdzMOGV9n+VJagKx2bRCDzqV2wr0YtRQcjUNiV/l3P8x8am+QUZ2tURMzUAicvw8NPKni1GPP4+Awj6OUQbEk2EejE76L38+7T9OYdiDrQXyoROo5a0cxOTeT5WH97oyC6ANtKnTMS0cWycTLcc9TfEGQs13vudoBhvoGLRQh6LN1h0O5rvrEN33o9LBwu+NdWtsnCp2pEAxIhnWQDFI/A7ZHtpfNbK/3uaug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(83380400001)(82740400003)(86362001)(36756003)(356005)(81166007)(47076005)(36860700001)(70586007)(70206006)(8936002)(4326008)(8676002)(54906003)(6916009)(316002)(40480700001)(1076003)(5660300002)(2906002)(2616005)(16526019)(478600001)(26005)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:39.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04613773-5f1d-4603-29b8-08dbf2719204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This simple commit adjusts part of the code style in some of the dc bios
files.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 971473c69b32..aef964f1bcbe 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2215,22 +2215,22 @@ static enum bp_result bios_parser_get_disp_connector_caps_info(
 
 	switch (bp->object_info_tbl.revision.minor) {
 	case 4:
-	    default:
-		    object = get_bios_object(bp, object_id);
-
-		    if (!object)
-			    return BP_RESULT_BADINPUT;
-
-		    record = get_disp_connector_caps_record(bp, object);
-		    if (!record)
-			    return BP_RESULT_NORECORD;
-
-		    info->INTERNAL_DISPLAY =
-			    (record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY) ? 1 : 0;
-		    info->INTERNAL_DISPLAY_BL =
-			    (record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL) ? 1 : 0;
-		    break;
-	    case 5:
+		default:
+			object = get_bios_object(bp, object_id);
+
+			if (!object)
+				return BP_RESULT_BADINPUT;
+
+			record = get_disp_connector_caps_record(bp, object);
+			if (!record)
+				return BP_RESULT_NORECORD;
+
+			info->INTERNAL_DISPLAY =
+				(record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY) ? 1 : 0;
+			info->INTERNAL_DISPLAY_BL =
+				(record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL) ? 1 : 0;
+			break;
+	case 5:
 		object_path_v3 = get_bios_object_from_path_v3(bp, object_id);
 
 		if (!object_path_v3)
@@ -3330,27 +3330,28 @@ static enum bp_result get_bracket_layout_record(
 		DC_LOG_DETECTION_EDID_PARSER("Invalid slot_layout_info\n");
 		return BP_RESULT_BADINPUT;
 	}
+
 	tbl = &bp->object_info_tbl;
 	v1_4 = tbl->v1_4;
 	v1_5 = tbl->v1_5;
 
 	result = BP_RESULT_NORECORD;
 	switch (bp->object_info_tbl.revision.minor) {
-		case 4:
-		default:
-			for (i = 0; i < v1_4->number_of_path; ++i)	{
-				if (bracket_layout_id ==
-					v1_4->display_path[i].display_objid) {
-					result = update_slot_layout_info(dcb, i, slot_layout_info);
-					break;
-				}
+	case 4:
+	default:
+		for (i = 0; i < v1_4->number_of_path; ++i) {
+			if (bracket_layout_id == v1_4->display_path[i].display_objid) {
+				result = update_slot_layout_info(dcb, i, slot_layout_info);
+				break;
 			}
-		    break;
-		case 5:
-			for (i = 0; i < v1_5->number_of_path; ++i)
-				result = update_slot_layout_info_v2(dcb, i, slot_layout_info);
-			break;
+		}
+		break;
+	case 5:
+		for (i = 0; i < v1_5->number_of_path; ++i)
+			result = update_slot_layout_info_v2(dcb, i, slot_layout_info);
+		break;
 	}
+
 	return result;
 }
 
@@ -3359,9 +3360,7 @@ static enum bp_result bios_get_board_layout_info(
 	struct board_layout_info *board_layout_info)
 {
 	unsigned int i;
-
 	struct bios_parser *bp;
-
 	static enum bp_result record_result;
 	unsigned int max_slots;
 
@@ -3371,7 +3370,6 @@ static enum bp_result bios_get_board_layout_info(
 		0, 0
 	};
 
-
 	bp = BP_FROM_DCB(dcb);
 
 	if (board_layout_info == NULL) {
@@ -3552,7 +3550,6 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.bios_parser_destroy = firmware_parser_destroy,
 
 	.get_board_layout_info = bios_get_board_layout_info,
-	/* TODO: use this fn in hw init?*/
 	.pack_data_tables = bios_parser_pack_data_tables,
 
 	.get_atom_dc_golden_table = bios_get_atom_dc_golden_table,
-- 
2.42.0

