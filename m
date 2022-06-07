Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28C8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 08:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED3411A267;
	Tue,  7 Jun 2022 08:27:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F4011A20B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 08:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZJpv9qVYAFpVfCkHyYDKt+AuaHY86YLUzzuDX5+XG4PQqmHWmWDklUYzoVtRhHFZ4+Du1LXHM5lhqJzW1YMZDqM4O7klUQ1OfBykQybQdOjeTWZ2lkV4vXegAziwhAphhpFOlQFEy1gpC7qLhLtq4HbDsNrhHoua5oHdiA79VJgVJv0VTQjL0PcNnZB1NNRPg15VWfUhuM8ta/AVmSzdkIzN7nQGD5JO7KzBlyd1FXSA75oJx2xW+3glYczDT6wcccrWptIgM2TZYMhRLh+YdAObbPSMCrBePPYO4sShk8+3QjTrcIod64KOHn1gukR4FbeZ46zrNnmO3wwGv0+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GfIaMRhoJGdG+8vV3EwAAAPsGqxYRmvg5Ixk1KmbcQ=;
 b=TDnuV6ZaP0ccn4NVavUa2K/P4FLGCHpXFkpHR10K66muHUGaEM60rYZDjPexCyeC/JVeAYntaoqWJAfxrM8Uht1amrH2N8aFz1q5d3t8zJBDqMR7Tf7dUyy6HU8l9uLdcDELFVoKzQ+/qWkcSisGTd/TKX2CQGzxLk97TBtHAFqkFMAvRftIKuMwTzkxctWOZ3IGY394QzuPYqn70tNLUZnvRQPEcE3L83L6xC7riWnHKjY5kjvk/500KpCEwTeetSJqGgUj6q1IN9UGAkSmMKE3c9VP5vpM3LlqtZb9LlXYKODU7rcuVUvEklYbg8aqrkkBYRPt+xI7G/sUFjuuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GfIaMRhoJGdG+8vV3EwAAAPsGqxYRmvg5Ixk1KmbcQ=;
 b=cGSrnP8ylqQ5kdVydFXMSx5FaIZO1W2jUtBUSnQlZiFTyvqMa59P3wh1khttwf8OQy+Y4gKratrlRIDzX/3R3waCI6aoNY5mkZym3ONU4RvPtimuR3miRS+o98Lkfq1C9DBhp5ndj1QFb7zRCb3moXiNdsMwRIbzqUw+bBhBJG8=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 08:27:06 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::9e) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 08:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 08:27:06 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 03:27:00 -0500
From: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: Fix compilation issues
Date: Tue, 7 Jun 2022 13:56:36 +0530
Message-ID: <20220607082636.847593-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b45d50-aa19-438a-5265-08da485f81fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB315098D9CAFDE1226F43C99996A59@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcDmcxlYU5tUtRT2dp6jh2/+1wNTxiH7Ti64NeGf0QdnD7D+7YCRhyPXRbVKOQ6YmgjMupIlp5mn5qWFpFKCp5B5AYlycyPVknGckuej5QotLIrNAOIz8BGpnEM+6bdJlR8Zf5j4X5jbsnjS2sGUKTTvUTrpDDTu2J8MpZT795lO5pQ5ZZuOLXaNgJ9AZ1f0siKoyIk6OuhINQ1h2TjP3WVE2RLdmjZYJXYMw91bovQk5zoBPR/fHnakHKMLJhkicZ3hQLfSPxIbPlVnPyAD8l0NLZ1YkxKoJodAcwfBTJ08QJsE5D3RwNYsUX4HGBAySEuUX1U80g0KHz/dm+kGXF32CEuNTYAUnUJ/tqq1fiE8oLxW/1mY+iQ9MQ9C8RbMDCP79tt3WbXP50QaGunXeGgys0bdPGBws6lguVDxwJuQowkIkO2KHd39793qHiXcD6r2NrCpy5dwMC7clAdSDS7HTco/QtGkDrefu/1Eu1zD8/YFKtbrQ2Az6yNL59fCT+Vm7Ah3C1LmDfzYmqmUjNEn5b+4TJyvjCHWrdSEgJAT0G5x4QYQpvTq7Z0bPzyrWrs4nN7E6IJYZq7uwwClFt7/AmxHItMohVZ8k+WsySvFGnBA/+GkXYpLRzmQkif46A+GWCukGstNJE4H4ErLu8J+OwkB0zlgivNaqWsIuyljMtLn3mocackqv9dr9gIlDR6cBcGgyp43PUla4+eJew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(2906002)(70586007)(5660300002)(40460700003)(2616005)(16526019)(8676002)(508600001)(8936002)(186003)(426003)(81166007)(26005)(316002)(36756003)(70206006)(336012)(83380400001)(1076003)(356005)(54906003)(6636002)(110136005)(7696005)(47076005)(86362001)(36860700001)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:27:06.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b45d50-aa19-438a-5265-08da485f81fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Getting below build errors:
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1419:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                default:
                ^
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1535:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
        default:
        ^

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:3276:20: error: variable 'v1_5' is uninitialized when used here [-Werror,-Wuninitialized]
                        for (i = 0; i < v1_5->number_of_path; ++i)
                                        ^~~~

[How]
Fix compilation issues

Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 3540b46765fb..25791ed0559d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1415,7 +1415,7 @@ static enum bp_result bios_parser_get_lttpr_caps(
 		case 5:
 			result = get_disp_caps_v4_5(bp, dce_caps);
 			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
-
+			break;
 		default:
 			break;
 		}
@@ -1532,6 +1532,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
@@ -3251,7 +3252,7 @@ static enum bp_result get_bracket_layout_record(
 	static enum bp_result result;
 	struct object_info_table *tbl;
 	struct display_object_info_table_v1_4 *v1_4;
-    struct display_object_info_table_v1_5 *v1_5;
+	struct display_object_info_table_v1_5 *v1_5;
 
 	if (slot_layout_info == NULL) {
 		DC_LOG_DETECTION_EDID_PARSER("Invalid slot_layout_info\n");
@@ -3259,6 +3260,7 @@ static enum bp_result get_bracket_layout_record(
 	}
 	tbl = &bp->object_info_tbl;
 	v1_4 = tbl->v1_4;
+	v1_5 = tbl->v1_5;
 
 	result = BP_RESULT_NORECORD;
 	switch (bp->object_info_tbl.revision.minor) {
-- 
2.25.1

