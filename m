Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC0C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE4010E3FD;
	Wed, 22 Feb 2023 06:42:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E38110E3FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfc/XVyLfay39PksIDnOpv2CEIge9U8v+B+xOnMZ30j3bIihCq9tiq8dazrJDsv68/ATYcy87dIQfkbIxLHuXwLvpcwR2eN04Vu2O5eALy3Sqk4lkgrKrJ3V/GPHdqrvObjuGHpgXMA2YcCbOhGleGPmycBDnfP8FnGvs8vCfSMYrX/9T/0NpVePJt/v6jmWOSYItXaj7kTl82RCqD8uQOg9Pwoyr5pjd4dupw+WYQhlSBjfkyEN7YuagRBUuEcaMlgGV0vzlHHliHALHcIJh3UON+ge4BTU4tXjSLi8lCBc+c2g1Z/uFClWDgf60y1XjGyLPN/vey4eNEWdwAys1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw2FBktRuR0ht07E3EF9YUj/IqIjaWy3mXeKFDgEK+o=;
 b=AvvK6itdojFyjRJzuEdO72c3+CDyU39hrx1C3mrUaMMkfekJ7e8kaeGhVv/Cd4yscHIiupf3KZkmJIqrcdp50jG7s5ymCYD4JpnzUZXiKvLOHFlZJ1eDFwownrFQSuDDE9L2djZC4b9iqUKsFK/Kh4Ka5Rxj3NmZPfqjhoKli8xrT3YRU7/Tv7qBN28g+1qUHWPH7s2V2TN9cj3aH040UsoJ6fy2qwIf28rUN4nF8A0aNusYUHmzatJx/IfscW3ap1/rOuCSZxad425jNjvG5FonqR53/8SMUfAuPjj77UKBOjwa8PJVV+o7i1wpIkr5yJ6WNGCMzMGMZK+dIHiaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw2FBktRuR0ht07E3EF9YUj/IqIjaWy3mXeKFDgEK+o=;
 b=YOuhpXLDJNktmh2OyVxdlVUqzhFEtVTS/n8EBQPaUNPYGEG5VejG0EtuMPDUlBvYTf3jh4a1DnEl4m0ZIAsBOZy4NhhqF/2KOY8QDJ4cLhyC6ItCwCAWp5oxzLVFgMAmX9fY8+r+UOhp2vh+VqPQpdytCagTQca3FtE4fzb7Vis=
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20; Wed, 22 Feb 2023 06:42:12 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::7a) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: update pixel format in DP hw sequence
Date: Wed, 22 Feb 2023 01:40:30 -0500
Message-ID: <20230222064041.2824-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 55365563-33a6-44c6-fc36-08db149fed70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snjNqf5PzXhjOh/MdCoFTGkvjOf8/NbpVuPR+xLVj8OcoZ5aR2MR1xaFkvJME6K+efv2quTIVLwgxXNwQgeGGQUo6DkoQzAw99SBgI83JTAqIPG70omDpwOX/Dr7J8/uyVHLqizkqeU3rYoAWYGRHyJMHk9AJj5bfh2fvImCJBPhzJbZ8jP5STOx9fIwseD/LJP4V1JYLWscHWvTyLq9KfJ0r5b6g13aUWQvzsbZvVDMFBeAvDHAMqpz+FjGr3nRuOFV7nc0sMZaVMnlQVT352fsJWKNGzn8q/c7y1ALJbC4WX8pXlgr/3+lIqMOucb5Ws0oJ06OlJIroo1MIjOb3qqbnCpHIo+QEE4xJvQCy/w/Dyh4HL6fFyQw2q19NBbHw3696b5OA1NzzTFQie3KGEW+LjeHCB1ecqicAK45UXdVEg7ZYBdsKr2rCe45bmSqS3oOtbsDeh90/Pz9Fuw6yyoJbapBLEhPdLlDoVtNJVqkZYSA+7ZPCmFovo3azp1Z2EyPHP6r5F7u8hbLaBBXAgD22Xkb2YyDSwY9BgnNT5TPFIUxI/AULl8kR5hvvPKU9JGl8iENYDDTbd0SWprtPC2s6XHmDXXGuINt3fIydxzENyPWKsVAiHQG0u4bLDDsEIJLMbaOztlXfZrhthG1hH69nW+3NHTr+Zj9zr9gS0QPwCVZ87SbojOe71zxj4YsK32CMJ9JwnvXsbBCnWR3u/1vCr1btz59B10jXUH8ex4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(82310400005)(356005)(36860700001)(36756003)(2616005)(40460700003)(40480700001)(1076003)(186003)(26005)(54906003)(16526019)(2906002)(6916009)(4326008)(8676002)(478600001)(70586007)(336012)(6666004)(70206006)(316002)(83380400001)(5660300002)(8936002)(86362001)(44832011)(41300700001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:11.7455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55365563-33a6-44c6-fc36-08db149fed70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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
 Yihan Zhu <yihan.zhu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yihan Zhu <yihan.zhu@amd.com>

[WHY]
DP 420 formats do not light up because the pixel processing mode
of the DP_FORMAT is misprogrammed

[HOW]
Added appropriate programming for DP pixel format

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Yihan Zhu <yihan.zhu@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 962a2c02b422..742e43cb8880 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -296,12 +296,14 @@ static void enc314_stream_encoder_dp_unblank(
 		uint32_t n_vid = 0x8000;
 		uint32_t m_vid;
 		uint32_t n_multiply = 0;
+		uint32_t pix_per_cycle = 0;
 		uint64_t m_vid_l = n_vid;
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
+			pix_per_cycle = 1;
 		}
 		/* M / N = Fstream / Flink
 		 * m_vid / n_vid = pixel rate / link rate
@@ -329,6 +331,10 @@ static void enc314_stream_encoder_dp_unblank(
 		REG_UPDATE_2(DP_VID_TIMING,
 				DP_VID_M_N_GEN_EN, 1,
 				DP_VID_N_MUL, n_multiply);
+
+		REG_UPDATE(DP_PIXEL_FORMAT,
+				DP_PIXEL_PER_CYCLE_PROCESSING_MODE,
+				pix_per_cycle);
 	}
 
 	/* make sure stream is disabled before resetting steer fifo */
-- 
2.34.1

