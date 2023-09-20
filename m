Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D9CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9298C10E431;
	Wed, 20 Sep 2023 03:20:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3961510E42F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/Hg0hTTc0lg3F6jyUqAnJkxJEd2kPupM9TSnhGg67uYw58rqjMrq5ITLPMebv3ar9LLdOV9AgOF9eylX7iFxOa+DfLoUv0UcdNFnHAnf8S9dMje1WgzKlA/C11RYVNdhgL/Cw69vqlAefZgwUVEVgm/ff+Ir27uNTsgZGlHCbz0X3kVlKDqaeUkTJHo+wu+QF6St2tIfFOdFvJ7FnCqyf0oE3oYjDlFLWopCterCG6yyUdjkUhsmBjQSxfBD4M6H1zt7oOxztrgmObNt571FQ8tO0wfwS0L9Q/gDo3q6RtcI5oNMLPo8IbUsyvZDh1WS7lvSWi5rNZSKHwEXhSJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhosZSefV0Qw4nA/6hfGuzQW5PVMwAmIS6cCrjEXHZc=;
 b=gcC1JqteoLCXThZiOMqW3WYVY7PmM9+nNBpz7JI2fYVDDZ3gegddm+RyMzGuWAgoagith/5Y2jCCxitcIM0w3lZEO8p37iFh61MdmFd5ZVDNrijF3gjxiBxb4Ds3ftjf5HelsGu2gYjnmG3HVLkbXRTeJx+xl0ozcbAY8XJawb3Or3dfFTcGruWS5EY7Opw/Ba05GCyZaJzDPPiXMa35wxgoWGrPMQVv+Eh2QY47VRH5BODDz1Bo0REo7+2ktUfWU+ybeW7s9FO62nsN7F8tNJm87sM1lvhMJhdqBsRzC2+3mDUWLgMoyLwvg7JCeY86K3WKaNT/SNQh2KmU/z0rjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhosZSefV0Qw4nA/6hfGuzQW5PVMwAmIS6cCrjEXHZc=;
 b=4dOBGP4mv5EuwkinfdQ/zKeXOWDtahwzvGIq6IkLRoKFTgjxXjoeESlNuqF2kK0kyCQ2Vdf+r4580ztkUvVDrofR8RL8vJx1Qc7QXUyTtDPa0sF3mVbGk/9l+pwV0otyF1E0Gf8dN9AiAYGNM3Md+grUONiYYvXsqZVUfKtl/UE=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 03:20:49 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::d3) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:20:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:19:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Improve code style on bios_parser2
Date: Wed, 20 Sep 2023 11:16:15 +0800
Message-ID: <20230920031624.3129206-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: d1863b81-ebfe-4121-859c-08dbb988964c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+efIfbDyE3+P6TQbeYTaWkXS1m5TS7r78NxCkOtjkfxX0G0mdP+J6KFu6NlE+RDzDYQiv6WBxfGfFtmScnmDoGz2kq9EiXaWB7KReYunsnS2UlIANWAyB03sULYw/tovwUTNWOtUQss+WzzvnzTh92a7T+okGtyKXaonzvQVvUWi/hFQOVFk14uZv0A6pkNm0my2AELAwAUyly0YlQPAqKIv+BrO9fOjUchnitkBRQFw7eP+pFgWdGMK1p/SUijufiYgq85j0LRrStGprNO3nEDz8vvh+k3WlLwTFeeFdij4RjFTRlAAFEz+MUsfh7Xl6FZKiFbfN8/LKQeuHgZfTMQRxOzwW9ikl3NU/S93T/N1uhsVXoGcTwuzXTkMPjdbrjWrn5B65+Jxl3GnIUql7nxB2E97wD4B+qCrhmlbNp/y9AoM2gZ8p5o+M2J6PNOphXd9D2xX9582/A0sBUBUdV+eOgDCMSq+8Wtvwpr9UgBFizpTOSCMQzmTePvjm8BG7H1LnSHXQm+6JX7EWm+aoe4mDOLSpv7d1TCATSp5RZGzLj5ossp7tta51D9vGtMWjbGjkbRqHtStQvd2skFobzd+/IaDfQDj1XsS9rwsOW3RC6flcPmp4+wbGuwP6NeemKABd1z9oj+77KGlZb4sAr06FhrOrcHkCwgEvObJMlz0Q9QgZahSWDC6YPyZN8PPyKt6zYsBuuXIMiOC7vpt7LW7kjKSitcccRmIx7e6Sw0coC5UOK7iDYe7JpisHeXHRVTMD4yYW5Gh+sgLIph6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(7696005)(6666004)(54906003)(8936002)(47076005)(26005)(5660300002)(2616005)(426003)(336012)(2906002)(70206006)(316002)(70586007)(6916009)(41300700001)(4326008)(8676002)(40460700003)(356005)(40480700001)(36860700001)(1076003)(82740400003)(36756003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:20:49.0876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1863b81-ebfe-4121-859c-08dbb988964c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

bios_parser2 uses space instead of tabs in multiple areas; this commit
converts those spaces into tabs. It also removes some other small
details.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 37 +++++++++----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2ec496be778a..7cdb1a8a0ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -355,7 +355,7 @@ static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(struct b
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_5->display_path[i];
 		}
-        break;
+	break;
 
 	case OBJECT_TYPE_CONNECTOR:
 	case OBJECT_TYPE_GENERIC:
@@ -369,7 +369,7 @@ static struct atom_display_object_path_v3 *get_bios_object_from_path_v3(struct b
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_5->display_path[i];
 		}
-        break;
+	break;
 
 	default:
 		return NULL;
@@ -405,16 +405,16 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	}
 
 	switch (bp->object_info_tbl.revision.minor) {
-	    case 4:
-	    default:
-	        object = get_bios_object(bp, id);
+	case 4:
+	default:
+		object = get_bios_object(bp, id);
 
-	        if (!object)
-				return BP_RESULT_BADINPUT;
+		if (!object)
+			return BP_RESULT_BADINPUT;
 
-	        offset = object->disp_recordoffset + bp->object_info_tbl_offset;
-	        break;
-	    case 5:
+		offset = object->disp_recordoffset + bp->object_info_tbl_offset;
+		break;
+	case 5:
 		object_path_v3 = get_bios_object_from_path_v3(bp, id);
 
 		if (!object_path_v3)
@@ -568,17 +568,16 @@ static enum bp_result bios_parser_get_hpd_info(
 		return BP_RESULT_BADINPUT;
 
 	switch (bp->object_info_tbl.revision.minor) {
-	    case 4:
-	    default:
-	        object = get_bios_object(bp, id);
+	case 4:
+	default:
+		object = get_bios_object(bp, id);
 
 		if (!object)
 			return BP_RESULT_BADINPUT;
 
-	        record = get_hpd_record(bp, object);
-
-	        break;
-	    case 5:
+		record = get_hpd_record(bp, object);
+		break;
+	case 5:
 		object_path_v3 = get_bios_object_from_path_v3(bp, id);
 
 		if (!object_path_v3)
@@ -1746,7 +1745,7 @@ static enum bp_result bios_parser_get_firmware_info(
 			case 2:
 			case 3:
 				result = get_firmware_info_v3_2(bp, info);
-			break;
+				break;
 			case 4:
 				result = get_firmware_info_v3_4(bp, info);
 				break;
@@ -2206,10 +2205,8 @@ static enum bp_result bios_parser_get_disp_connector_caps_info(
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct atom_display_object_path_v2 *object;
-
 	struct atom_display_object_path_v3 *object_path_v3;
 	struct atom_connector_caps_record *record_path_v3;
-
 	struct atom_disp_connector_caps_record *record = NULL;
 
 	if (!info)
-- 
2.37.3

