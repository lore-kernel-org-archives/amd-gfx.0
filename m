Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2FAC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B030AA4DD4;
	Sat, 13 Aug 2022 02:12:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B5295358
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5UdUpQeq62JMbsRzMQiYSz5Wf7iHAAwvkMWXkouf+OFt6+T9yr3rIwu84H/+DrPIjRLJ0XPpnYj6Z0Mptxb3dWCK7FetLpgWVo6BJO3tfBMKsPJexlK1ISCNHDxGjVqMipoOC2ghQd2o1b5N+I/VBIwgmH9rnVdO/MtJrqzuHZRV21lWDbTUM6Mw9fbOqxKXicX73JrwTCuXe36SEHITpcYoTZ0AUhG/HRuXJWjpD2JFIOyjqqLEkr5An4gQEuOxEldrD0Iw/ViQS9TXquaK2MQeBhSdzX++crvupzlcfUQ96+EYNVjkLjx+qMb6e4nSn9vt5ukfr7oVValIp4ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/W6pSRaZmewXCW8r8gDsFQOdaJ0+Wn3QDOxvGwWog8=;
 b=VmI4bVkPS5I7NDwUZLDAFvDCcfdiWm9bZKAf274S9BBmQ6ct4EYbCpnXw+NLxv+0bHQR3+YzQ6IJiT1melGqTBMIcgckeluVoz5kkQufWC/YxQR4Oh/QfiTV3MuS2Dro81yjtelirFJiHuxSxQXwvtG0t7T/soez3FLn9OEa+S7R3rTWZWRNob47FOzrSUpNkcO4oXoThhBS2ffPXGhSYOqTzIexA7eH+HjKJ/9pw4/ZjAcXxC5DTU8YT5amj4ugVSLDbkm3s9keB+1BmI6HPSpTydS6P0ku1zD81m0DuT6Unv8LnWbeAzrkkm/wWXQsXSzFeavoCSqCQUMBDPNvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/W6pSRaZmewXCW8r8gDsFQOdaJ0+Wn3QDOxvGwWog8=;
 b=BrN1OY3pNwpG+vE7tBrQxnQZ/goWivYJztl+VSrmKhoASGYFr0f8AUVW22u2WV9h8pX9gxXeAzH0iL40apLNSMVMQdAn/f79uBSJmy/vsRFz5n53tle7/1UDWsozAluhEadebZ2/g/CiIPUoIvw1+bd3B6xwhBSX0PAI7KJk20Y=
Received: from DM6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:5:1b3::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sat, 13 Aug
 2022 02:12:35 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::3f) by DM6PR17CA0006.outlook.office365.com
 (2603:10b6:5:1b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:01 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:11:58
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: reverted limiting
 vscsdp_for_colorimetry and ARGB16161616 pixel format addition
Date: Sat, 13 Aug 2022 06:12:09 +0800
Message-ID: <20220812221222.1700948-2-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c44d59b4-b101-4aa6-e4b6-08da7cd149a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIyV4AgkxX1rS1wVvdrsbp4oJIQVS4MZuLkh58ywCw0ZcuRe4fGKXqQGpZKRFQaMUFgq6aIh33cbPqOccx6iNAk9ZKve4a+ZTIPnxb/2DZfjvzzcyIB4GAQRQX/1cDmi6VJu8QgErzvm4NCvZbFb3O5lAYbaRIaiJnuZc9xlVk4YB/PQ3mt9lO6GnnmvPS2DLB6/nbK45wFv4sahtmNBm2Vy0bbl7C4B5sPBen3pS4H4Ln43hQK3FF1C9JEvt4JB+87T4p0Yg/pmyix9/jiGqUgxz02YSZruvVSy+U2G/aT5T9v6eM2ugskWNGpqTmcJC/BhE32UzFArqzXmeUZRV/4cu/ei+HuIrj4OTR0enBNoRNPVlMkMBvhcXrUOEQionipRy6yIa44R7YhhQ91ZNEE/g3a3frsKkPmVfJMLk8S902IAwwhwecURgX81R2cYbwHwNMc23oCuyFel0MyWW5DpWoAkQ2kdQ2NcnWjizUhDENFBCsoFLFMa9jdi2CCPfKEhXNCHwxsj7KhAQ7JTMlerg9Wbjz/v02CK6/7hj33KUymGobKuLYsr5wJaQM3aPXr6vt2qWEQZSiuLyqOdPZNDKZYvan4QtpY5plRJBtc1lJidGf9EJ+sF+oJ8UXAhfcI2/+VX+knZypBB8dczsf4jSBVsK7BBfxuQUFz09Rrcxboo93mXaPIxSAWgvMdc/u/CljWs2nd1slu3ac/IHorE/cbf4Kl+CEW4Q6T6G1OIdJXBnR5ld6VP4jk1FT6+CSyJA76RD0dr9BdTTkBz5zJi7uF0XEwLVE4eTLq4NBYMO4kcGookGWXef/s6Y4JY45Cue42Me7011mViESr93PvhpSmikbzqv43IGwtBYkY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(8676002)(2906002)(8936002)(36860700001)(4326008)(83380400001)(70586007)(5660300002)(36756003)(70206006)(186003)(478600001)(316002)(82310400005)(40480700001)(41300700001)(54906003)(47076005)(2616005)(1076003)(6916009)(426003)(336012)(81166007)(40460700003)(82740400003)(7696005)(6666004)(86362001)(26005)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:35.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c44d59b4-b101-4aa6-e4b6-08da7cd149a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: stylon.wang@amd.com, Brian
 Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>

[WHY]
Limiting vscsdp_for_colorimetry for YCbCr420/BT2020 resulted in red/green
point failures in HDR10 DTN tests. The re-implementation of ARGB16161616
was to fix this however it did not actually fix this issue but a side effect of the
issue.

[HOW]
Change ARGB16161616 pixel format to 26.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 2 --
 5 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
index d4a6504dfe00..db7ca4b0cdb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -361,8 +361,6 @@ void dpp1_cnv_setup (
 		select = INPUT_CSC_SELECT_ICSC;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
-		pixel_format = 22;
-		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index b54c12400323..564e061ccb58 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -278,9 +278,6 @@ void hubp1_program_pixel_format(
 				SURFACE_PIXEL_FORMAT, 10);
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
-		REG_UPDATE(DCSURF_SURFACE_CONFIG,
-				SURFACE_PIXEL_FORMAT, 22);
-		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616: /*we use crossbar already*/
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 26); /* ARGB16161616_UNORM */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index ea1f14af0db7..eaa7032f0f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -166,8 +166,6 @@ static void dpp2_cnv_setup (
 		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
-		pixel_format = 22;
-		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 936af65381ef..9570c2118ccc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -463,9 +463,6 @@ void hubp2_program_pixel_format(
 				SURFACE_PIXEL_FORMAT, 10);
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
-		REG_UPDATE(DCSURF_SURFACE_CONFIG,
-				SURFACE_PIXEL_FORMAT, 22);
-		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616: /*we use crossbar already*/
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 26); /* ARGB16161616_UNORM */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 77b00f86c216..4a668d6563df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -244,8 +244,6 @@ void dpp3_cnv_setup (
 		select = INPUT_CSC_SELECT_ICSC;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
-		pixel_format = 22;
-		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 		pixel_format = 26; /* ARGB16161616_UNORM */
 		break;
-- 
2.25.1

