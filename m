Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731FDC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3AD10E811;
	Wed,  7 Sep 2022 18:12:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D4E10E80E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOXjwO8lTCprJ9cvBw19IkiMRoQBoXKALVyQd7f4ihxGPikHxdGkXcXBwrUOf1URp2KLmyyloUlZjNRlhSGgdbYbyQ6WRub1RUC2BCYNaAM62bzzvXhnwKAnrfQY7bjQPq4IUWlobGZ/x0Ni6sI14twBRP4d0qAvG8RQzeqH5e1hUtyKgKXCyoEQv4vcRmCKCmHXw44WGLEpztG1GtvMr0H0dgyG1mOWLLrLuf58M5J7pLkKnmpfOrb9/TFr4dtCQ9ad6VO+xZagudeHlzFXZpc1Z8OVcgNccuZGmmnr94uKCsB1ltD6Jh7+/ZvC1DFORA9oRRIlBYr9vafRKM73Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM95BSHoMr23qyYZXBx96NHF2aRY+RoHG98/0o+7qtc=;
 b=kymQYhE38CxhqQr7gQ31Qi95YR2CtJUMbo6nR/tu1Sy+Kj5qwldxa8zDMTMKBzmKH6E8DeBP+jFGWzhnYbe19hrNE0eI4alWrVnxbuUXQpbnqM9Ji2cc/0RyLkoBHDIvXdEjeZGoYBsBQTXet7jKRVch/B03gxLFNNQUJr9+OJyL6+oKQx7U0ZpT2/r9WxYyphERAoBRTesmeZZOUQjDruVSdfehZAbM3f0BK8L1u+MQIsWqrdlVTIHRV73kZz6yiTotIwtTjzB/MeYKS+vEzpqdPg3W5u6Zon/ETTrA038bHjzbrQaa2wgmMigS/v7YjRNdf8hFPXnE5PiVfOYcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM95BSHoMr23qyYZXBx96NHF2aRY+RoHG98/0o+7qtc=;
 b=KPmyjtn9Iq8qfF5qUtrDL4Bj5+tu33jknLUo+FfGPoGTwDNKhRfrsBdzeUWHw+XIQet4PnHrC8WbXxxzMceWObqWVbE7ROz/XQ+vSs3IsRsFUYfr4f/6YiZv9FVxI8hvsQ+jIAHDKi+0NHUdGh/EGxcSdsXcZcpfRZF6l2q1hLk=
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Wed, 7 Sep 2022 18:12:36 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::e9) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:35 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:32 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: Adding log for spread_spectrum_info
Date: Wed, 7 Sep 2022 14:11:55 -0400
Message-ID: <20220907181200.54726-16-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e707e61-0706-4002-4377-08da90fc8aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pg8AbNIJllepu9HXDaWOn9P+L4EZ7PbiDNSmp89I3r6NsjYAFXzwplYmJV3KOq2EVDbloTd6i9+k95ygVCgvT63jXTdpciMCzG0//EELmaajoEM31yusWurE0ARl/yLvInFg6nhW3iJ9oALINhrZYoVZW0ApE6f21LZETIbRFUt6GlV00Mm/joIAAjdp9NkZYeYEXNU22IeKJxJk7CvHmA6l3AetqFsNI05BOSShimzQxmOaFSdt+mKYbts8yXNC2rwIqm5OxG5oVi958uuazZgMWf4FhaCClt4Oa3/M2wIswBrGeIxcei3Gnt0pxVUMCamwV5EYZ3DwWXgLNAnOSSTjZwqOF8SP7xVPd5hxmzxOtexIUf/QH81R2PpeOugeltTbIlFL9sEKqhl8NdvQu/4HoX/1BgDh7YQHY1ki/vuxH1TuuzJpXKzf3WRSD5B1qeLT7L35nMby7HOnuwrhDBRAiw7N+EAabAoIIGg4B/kXD36llGeK+cXMfBtHk0ldbUvHsslj5jPx7oioqHtECdr6fpLNgvEZajw9W2qsv7+ipHkrxu2ZXa6gJUmGTpyF4ESn12a0WqBvkXgd+7HQENX+UYh/PSVANmB5huLHsWHC0w0aYeDMVvm417QknQi6D8plTzjLIp8r+0gW6L6T3pPPqvkxt/LTWsEGcVAO8ew4eAA5QM719bN8u/0DVQcJEJC1bNX/G6pGtKbGvdK05qPWxDDGmB1W5dRG86ls+WiPNogL10+waPSXD+LdS9wxY22qWOCzwtmP2hJdcZ9xqIziSWtdN1bMz0MvK/QTEdzPjazJ/E1of3AymGZWTsKf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(40470700004)(46966006)(16526019)(336012)(1076003)(186003)(426003)(47076005)(2616005)(5660300002)(2906002)(4326008)(8676002)(8936002)(44832011)(70206006)(70586007)(82310400005)(36756003)(26005)(7696005)(86362001)(6666004)(478600001)(41300700001)(40480700001)(40460700003)(81166007)(356005)(36860700001)(6916009)(54906003)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:35.7326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e707e61-0706-4002-4377-08da90fc8aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>, "Chen,
 Leo" <SanChuan.Chen@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Leo Chen <sancchen@amd.com>,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Chen, Leo" <SanChuan.Chen@amd.com>

[Why & How]
Enable logging for spread_spectrum_percentage in spread_spectrum_info
to facilitate debugging for audio compliance issues

Co-authored-by: Leo Chen <sancchen@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index ead4da11a992..85ed0afb74a9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -849,6 +849,8 @@ static enum bp_result get_ss_info_v4_1(
 				disp_cntl_tbl->dvi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -857,6 +859,8 @@ static enum bp_result get_ss_info_v4_1(
 				disp_cntl_tbl->hdmi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	/* TODO LVDS not support anymore? */
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
@@ -866,6 +870,8 @@ static enum bp_result get_ss_info_v4_1(
 				disp_cntl_tbl->dp_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_firmware: DAL only get data from dce_info table.
@@ -886,6 +892,8 @@ static enum bp_result get_ss_info_v4_1(
 				smu_info->gpuclk_ss_rate_10hz * 10;
 		if (smu_info->waflclk_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_XGMI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	default:
 		result = BP_RESULT_UNSUPPORTED;
@@ -935,6 +943,8 @@ static enum bp_result get_ss_info_v4_2(
 				disp_cntl_tbl->dvi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -943,6 +953,8 @@ static enum bp_result get_ss_info_v4_2(
 				disp_cntl_tbl->hdmi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	/* TODO LVDS not support anymore? */
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
@@ -952,6 +964,8 @@ static enum bp_result get_ss_info_v4_2(
 				smu_info->gpuclk_ss_rate_10hz * 10;
 		if (smu_info->gpuclk_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_firmware: DAL only get data from dce_info table.
@@ -1000,6 +1014,8 @@ static enum bp_result get_ss_info_v4_5(
 				disp_cntl_tbl->dvi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -1008,6 +1024,8 @@ static enum bp_result get_ss_info_v4_5(
 				disp_cntl_tbl->hdmi_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
 		ss_info->spread_spectrum_percentage =
@@ -1016,6 +1034,8 @@ static enum bp_result get_ss_info_v4_5(
 				disp_cntl_tbl->dp_ss_rate_10hz * 10;
 		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
+
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_smu_info_v4_0 does not have fields for SS for SMU Display PLL anymore.
-- 
2.34.1

