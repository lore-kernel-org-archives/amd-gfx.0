Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063F8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D991090429;
	Tue, 12 Jul 2022 15:37:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FA112BCFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvtzjVSCY6MrhrP+Ch6RSsZacdaqw4kgT8CL4W7nyBIoYPOnFgiyTpwMBwIyUOIkLUJrY8FobWfx+QUGZrs4spls4XxLh9wtpv2nziImOr7yS8V2tiW8TQmXjbpP2f1rI8kdyDHVrr/L12VMcbEF8HnimKICe7i2OIB15UOLjViqbqItEKFC/9M/c3enp+VVGQiwolCAPwuItqdiGTSAJs56iFBBpBi4OfreMt+tYULZf3ZAo+dkb2Epquv+85hzqPM8/JxTUReIogYkpiRtPBv2I3FaXL595roJVKdso4zrb2ZsscTisexVrKSPzo/QSzUpPGBdL+yJvfBlIBFggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecaaXoKZmOqPnMJykLDeDpOPPm8NvT4Ii4i+K5jJbiE=;
 b=HWzhC+S+3wSyaCHx9FkL8rJkV3WEMjvWckuLto2jpvX8cYOzXYKHrqM9cXtnmWPMCTX+Th6u3KadA4zzj1ZUZhDk/JwtRaxuFGraIYV2pDCEo2OmR0zjiwKuKvsfFyS/Mix9i+KyOMnwaayEj/caicIfrgcFsZJEaSVlY6/vUjFs8dn/k8yQT6LwMlu4g/mUZsz1IMmagtkVshXVT65h+YB3d7wc5R60Y+M7ZewbAZZ0viyXW1kdwfH2MFctQFiKwz0WHoK6Oc7fih298H5dIE55ycM61mme+QEY1phFpeMloBOpi4tDt+EEmGVaDGv3GbQD7Q3U+3Zvaq+ea4bvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecaaXoKZmOqPnMJykLDeDpOPPm8NvT4Ii4i+K5jJbiE=;
 b=REo0tFTr+jwqrsCdodSY6NgHc49VO2pm5ZLIrygHz6ZpRTTziTFh3mK5VQxHGAByxe9Aqccv6yQVR1VdSgmLrjd1o9dyFMfMzxCtD/51sVjKVCyevDFm3p6c17uS0JFx8l3qBYJiwoXlIKhkhHeFM/FcnFd/veb/2K/PeeUsH9U=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:37:52 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::24) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 15:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:37:51 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:37:46 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: Re-implementing ARGB16161616 pixel
 format as 22
Date: Tue, 12 Jul 2022 23:37:32 +0800
Message-ID: <20220712153733.501210-1-solomon.chiu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1c8edaa-c518-4ad7-6e43-08da641c7b7b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04epUYsOxAjVme7yrXA7t9xBMjcZ6LKXzZtgRYNv6EDwmxq7m5zbDN8fiJWkmicE89j8E025PYrdQvO9q6gexkonyJOWU7f1cMKYVo1UJOX6cU8ZrCFvzd6297NFUt8ac47MRypKbn6K5Z7kxocnSFiWKV13+X/CjmkuEJhLm+lDAumdhb8hlbSizJT4ylqx+ZtZT27kK3NGGjJvlhOGXW2nkjz4+vDCf7C2/CIOMhXZvsVc3RgLLK8PU/uT+YxGj/pdTa0hAI27D03Pkpzke5Eo2iTwopEcQOfXTWpfG93l1uxVwAeQ+StNrjhEm9laVXG6s83JOOm9G6JWNZJR/scOPwOHnxLc9OdyjYj5Z1wzRsLMFMUDT4XuEZrb4AnQAIa/J28AOL42B2+KEEcySo0VP80O9cvtzZtfSxGj/g6/S3dTbEf/nzloCPji2lHJo3kRTZNAqn8TvundSeH2ohlwt4HCUX+1msuA99BqvL5nlw3RZ0n4NZ/q8dPHVFWGop2Nvd2q+mt8e5ZoBg9fAaPj6PZ+RwK3Nyg+pgGsgfhrMbpbwMV3h7zcEp71edCJJaautx3t7srBEr46y9GlDCwLkZ2FDj3hH1hbZ/c5S6EGBMAtvyZYxiLel11GFJFmWX9RFG67onZOUY4DA3FxrDp+Bcrp3nhzONaeRK/tSQCb8Ftptf4wKtMrdKjQn6z71h/ofjCLG2MP3mJ0syvO4/q24GY2fxB5srGYLGNxEuvb+jzv4OwMl4uAk17yRMaL6/+/B/2e0c0mmqC7y0VdDs+HcGdrpC5MR5KXnwFajJsoomPBSIap6Q7lJB3pZHbFsaQ5mTTU69VGsh6nMiyBFAfwr+PD5oAkUl2ScxjmRU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(40470700004)(6666004)(426003)(83380400001)(4326008)(70586007)(82310400005)(186003)(86362001)(336012)(47076005)(356005)(1076003)(70206006)(16526019)(2906002)(478600001)(8676002)(41300700001)(26005)(8936002)(316002)(44832011)(2616005)(40460700003)(36756003)(5660300002)(7696005)(81166007)(82740400003)(36860700001)(54906003)(6916009)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:37:51.8957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c8edaa-c518-4ad7-6e43-08da641c7b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Wellenreiter Ethan <Ethan.Wellenreiter@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wellenreiter Ethan <Ethan.Wellenreiter@amd.com>

[Why]
ABGR16161616 colour format was added to dcn10/20/30, and set
any ARGB16161616 to the same value as it (26). As such, the
HDR10 Green Point y value was too far off of the EDID stated
value for DisplayPort.

[How]
Added back the pixel format as 22 for ARGB16161616 for
dcn10/20/30.

Reviewed-by: Reza Amini <reza.amini@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wellenreiter Ethan <Ethan.Wellenreiter@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 2 ++
 5 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index db7ca4b0cdb9..d4a6504dfe00 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -361,6 +361,8 @@ void dpp1_cnv_setup (
 		select = INPUT_CSC_SELECT_ICSC;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+		pixel_format = 22;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 564e061ccb58..b54c12400323 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -278,6 +278,9 @@ void hubp1_program_pixel_format(
 				SURFACE_PIXEL_FORMAT, 10);
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 22);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616: /*we use crossbar already*/
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 26); /* ARGB16161616_UNORM */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index eaa7032f0f1a..ea1f14af0db7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -166,6 +166,8 @@ static void dpp2_cnv_setup (
 		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+		pixel_format = 22;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 9570c2118ccc..936af65381ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -463,6 +463,9 @@ void hubp2_program_pixel_format(
 				SURFACE_PIXEL_FORMAT, 10);
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 22);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616: /*we use crossbar already*/
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 26); /* ARGB16161616_UNORM */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 3c77949b8110..787b852eeaf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -244,6 +244,8 @@ void dpp3_cnv_setup (
 		select = INPUT_CSC_SELECT_ICSC;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+		pixel_format = 22;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
-- 
2.25.1

