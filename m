Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460FBC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 18:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AD410E178;
	Fri,  8 Jul 2022 18:56:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF0710E178
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 18:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFMtxjKqb9D4BvOGybK34VY4dlc9uCJMJG8jTR9BZqk7wbp/L5AKUjemX0dmgDzvCEmdjbxvbwam9GXtQO19wFfHCuPjIdik1yHgDXCB0AypePkn9XB1KLqeUsSMkAm/7ql5UBaFAez0SwkefFU0wD9I0dxnbATPtFMmEMPJ2IA4g9kD4Dq3mPMTec77n94i0OAcRWnXf/gNkBNleSEdrEiD9horUVULevV17hRgiRsO7h/xMDALhjHua3egBhk+y8ZGSK/B7vnmLSpM3MnoOo1p7I1rMvOS2x6btKZh3yoHY1eAsDf9QminZJal9DU4Vzw6ST2/M1lOsR5hZoTM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FS94WkPYuOYOatRthU44GrvAHnkZ8Xue6eydw17zXQ=;
 b=EKDT85Y74QsNLyxy2hoM+2xhcFhY/uGObF1n7YVwD6MCtEpm0zWpuvaw+yeEtfTI8Enqv3Qw3fOJdNlzhkQEBw95Mh0jrImv9VbA8SjPd4fGfm4csecqMdtqkuZPu7SkXtC2BpG1YuoKlHNsSG5hHQGEfp5rEoGqpjzgCH4zOADBIES69e9t8Eq1tcSTVM6JLz1lQzari/BloJZUEj/pLCEbs6zfdWEt8FeM9BM17hJ3XbCnP8/VL6nzhWah4lqiE5Y5uEnVCJ0oF2DGwvJFMjEfXYaFmf1LqKCwluQTU0HI7Ikrj00lqznGqYhHz+t93a06YZCBNSh9sJWGH9pOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FS94WkPYuOYOatRthU44GrvAHnkZ8Xue6eydw17zXQ=;
 b=BOtz3pba5zHLmxPOhniTt9bjk5Evgw0AzgdvSNedKZlt5f53hn3GFJI3F1yt19aE2AKuVV/fen6en7ZgLirWdWUHJTjTeDPxDnI6NZOstfIjd6SSJSw0Rl+XtysxLlECs92H4QVQw+3j1FTcP4J033BXnSkV3+lDGm3glN3H8o8=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by DM5PR12MB1465.namprd12.prod.outlook.com (2603:10b6:4:7::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 8 Jul 2022 18:56:07 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::bf) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 8 Jul 2022 18:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 18:56:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 13:56:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 13:56:06 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 8 Jul 2022 13:56:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix unnecessary pipe split playing NV12
 1080p MPO video
Date: Fri, 8 Jul 2022 14:56:05 -0400
Message-ID: <20220708185605.1993083-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ce14fd-e894-44a7-9890-08da611383a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjSBHZjeuqboJcXUsUBV5UIPIQC+YnbdgU1botGqcdKzzA7Oakq209CUqhv61o1Dmj1/7c3Bqm61HLe5qw9987lVRQl36Kmgm7UDHIPTBu4OMz4I/B79Qn6uo7LCTzhGCrYPgPPB5tQ9XKdwkR7FXfAOBKbHpPiCyhOafxetOZl40Yk8ZOKIm4BIOGEAZISo8TlzzQUIDE3WShSSHtB3RxKeG+gNpfC3ebl4lO13Q7YJO6iwJO1wcdas6qV7cxDGtkJkVgq+d3bYRu81wD+ZSQ52gjByptFWIf8fv3Fwg2qm0Lz9xXaDDHLW/7WSESjax5irJwFtiTZnr61bQkeYfcv4+t6pQOtgNCoUCeIez07rjHB23USir+7rxQUd7jKdiZjKDXJ30XNhaeMJrd0shhOZvAVhz/WDgPG42anXaW7SJbg6hKo9rTUSz2oTn6jN3q60tgB3BCdjrrVw2wEC2gEXD9eXhBwZQYvPFLJ2V3fKJn0dYIZH8+JipCncyj/oWqm1FyyMA6gnZGORF/nfbJECeU+CmkmnJeqbXhcaSia5rthirV8zDDIi06z3SIWCtA4Chwa2GiSYkNylvm4aRcu2cDPX4xe4l018WYg/U2FlLlpj/+avjO2Acn+DRSS/jMPRiSxZ3fawl69BHWp4daNzBDxwLPXUsbrmq/nEXDO4Dl1CZjHhuj4T+M8CZmc7QpfXnFGQBa24nnAX7GoK3mG70jC8mwbRvhYrLZQNXp3Ix+SfmsZRvz6xj1AdeNOVk7TK5303aKnIkaSlFJhBMRD2rzk1vNNyGQFUZSJAo2ObKHHfX2K6qrId/Dobz6/FAHTVOY+0XsKjJhLY3sVhzbeBwEmkVAMlKodT/Lto3ed/dPp94n0VbfY6PMZMNTHh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(40470700004)(36840700001)(46966006)(1076003)(26005)(82740400003)(478600001)(6916009)(36756003)(186003)(81166007)(82310400005)(41300700001)(83380400001)(2616005)(336012)(47076005)(316002)(426003)(7696005)(54906003)(4326008)(2906002)(36860700001)(8936002)(5660300002)(86362001)(34020700004)(40480700001)(8676002)(70206006)(70586007)(356005)(44832011)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 18:56:06.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ce14fd-e894-44a7-9890-08da611383a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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
Cc: alexdeucher@gmail.com, Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com,
 Harry.Wentland@amd.com, Samson Tam <Samson.Tam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
When playing NV12 1080p MPO video, it is pipe splitting so
we see two pipes in fullscreen and four pipes in windowed
mode. Pipe split is happening because we are setting
MaximumMPCCombine = 1

[How]
Algorithm for MaximumMPCCombine has extra conditions we do
not need.  Use DCN31 algorithm instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 31 ++-----------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 04b13e765a52..c6c3a9e6731a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3733,35 +3733,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
 					|| mode_lib->vba.ModeSupport[i][1] == true;
 
-			if ((mode_lib->vba.ModeSupport[i][0] == false && mode_lib->vba.ModeSupport[i][1] == true)
-				|| MPCCombineMethodAsPossible
-				|| (MPCCombineMethodAsNeededForPStateChangeAndVoltage
-				&& mode_lib->vba.DRAMClockChangeRequirementFinal
-				&& (((mode_lib->vba.DRAMClockChangeSupport[i][1] == dm_dram_clock_change_vactive
-				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
-						dm_dram_clock_change_vactive_w_mall_full_frame
-				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
-						dm_dram_clock_change_vactive_w_mall_sub_vp)
-				&& !(mode_lib->vba.DRAMClockChangeSupport[i][0] == dm_dram_clock_change_vactive
-				|| mode_lib->vba.DRAMClockChangeSupport[i][0] ==
-						dm_dram_clock_change_vactive_w_mall_full_frame
-				|| mode_lib->vba.DRAMClockChangeSupport[i][0] ==
-						dm_dram_clock_change_vactive_w_mall_sub_vp))
-				|| ((mode_lib->vba.DRAMClockChangeSupport[i][1] == dm_dram_clock_change_vblank
-				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
-						dm_dram_clock_change_vblank_w_mall_full_frame
-				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
-						dm_dram_clock_change_vblank_w_mall_sub_vp)
-				&& mode_lib->vba.DRAMClockChangeSupport[i][0] == dm_dram_clock_change_unsupported)))
-				|| (MPCCombineMethodAsNeededForPStateChangeAndVoltage &&
-				mode_lib->vba.FCLKChangeRequirementFinal
-				&& ((mode_lib->vba.FCLKChangeSupport[i][1] == dm_fclock_change_vactive
-				&& mode_lib->vba.FCLKChangeSupport[i][0] != dm_fclock_change_vactive)
-				|| (mode_lib->vba.FCLKChangeSupport[i][1] == dm_fclock_change_vblank
-				&& mode_lib->vba.FCLKChangeSupport[i][0] == dm_fclock_change_unsupported)))) {
-				MaximumMPCCombine = 1;
-			} else {
+			if (mode_lib->vba.ModeSupport[i][0] == true) {
 				MaximumMPCCombine = 0;
+			} else {
+				MaximumMPCCombine = 1;
 			}
 		}
 	}
-- 
2.37.0

