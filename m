Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C2CC433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17BB10ECBF;
	Sat,  5 Feb 2022 04:33:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C4D10ECBF
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6d3cutb0UdP6YhhMBFBUvr03qqUWnoASI1iiQoK5RFH3UIFyZf4+d/lOckrH/PortLRKbwO4nw6qwe7QzcasDzStyXeEG3KYHkuCgPKEZ0k2ZIwVNjO0RhbkZ5t50zLorOoItaPmecRoRfn//GnZEJqrIW0g8Ll23lOCmGfNLLK6MuSLp7/Mu30u/AQv72ej5ncUIB3sqlKTkt7KMqEfzN+xjWTmSvrwcro8WzBvaoALb1fHqVZGtTBQtfzK/VP2gU1AZB2TlPqS7VRnMwsz39e2RzV0MELu+UvtTq44igO617aw75+JEENQLYlQ1SFwICw4f35c35aetoKO4/yTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUMVssbPtUOOK/chGXhbNaR8hUXUXkMl1iOc6a+ycF4=;
 b=ScbMmiqwgMLxOxecwJSIaFa1J2rgc8hFlMJqUiZz810Zto9g9HW58bBix6wpwz35jEBXKUiDSwJ6a1Efun18Kqyd2CzAK0Pzp7micXaslwMGHW52Y/5P4MCE5nwu7EsMfu8S70P3fXHLmSSGAePSikbyvCvsRAgZ64Xwi5p/tfSn+8/qOGh6Typ/tizVmtJT0787z6VYglj6j814YHYziMTbQHXdc+VaHM+QRhxVfhR93XDXavLh6nxERuaj8noYBmkiKIUTwFhcJ7QXkEqpYyQ3Pw29BnATTIpuDduzR9ueMELcshbuwTQZFQMZ4xgeAcBIMdTHFqoENFuXqMgUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUMVssbPtUOOK/chGXhbNaR8hUXUXkMl1iOc6a+ycF4=;
 b=EtWA0D9aqllH3i9LPpv/fZMNA67OYjyZLcURoDZ2HN7E7vGQRPqUGFU39+kCbG5l5137LdxturV2DoVf4+GTLPm8JSrYn+4Y5FkYiPIvOjzq965W91NeOEKOTj0XWjPjcnU+LRug0LdVP/V7PBel+ssq62uqOgEPfxoUKROoKrg=
Received: from MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47) by
 DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Sat, 5 Feb 2022 04:33:34 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::80) by MW2PR16CA0034.outlook.office365.com
 (2603:10b6:907::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:33 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:31 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: keep eDP Vdd on when eDP stream is
 already enabled
Date: Fri, 4 Feb 2022 23:33:05 -0500
Message-ID: <20220205043310.165991-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6baec0c4-77fa-4056-fe68-08d9e860ab36
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27795EAE072830C7BF8FA650FB2A9@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/VL0WzrkivBe8eekx2XrzkY1wKu6OEzRP+ueSgyVHM28Ut63xsTou2jLX+eaRZVqz7EpHKT4UO+RhVRtTXp4QcMHMOySHiJbwVkZbHrSRzJO/KXcdRbFidqxremd0dh5sUXFzl0ALqBPi/S+klxeZayG2za5Oj45yhuWscn2sCYe4jiDseDBnzCfEOiClEtDpeLiNyuwTi5mltBK27B2uKNkAdE3t5kXpnNgh2NBAi2oYqTiO4HVBydMRktHaO/3CSuPIjNO6+lpZBFe3NFq6Tr56ZwKJvzjutsy7AqdTKrS6rPzkEAZ7El/xINQay2hSFm9AdonUT6wL4lcdmMhXws/XkXaCdSGO1igpydjxThgY3LtSHyqXyMN/vSAL7+FFFRf0s/P3JYXEoKpLbdC5APwo923ljDNpjNMenDbUctXEzGJ9OknDGrg2rmXtd7jafhJbdj1ddPAhyx4bGQCVbor3RVzlRz+Yn7DjuzEjQNlrkUvJCYzTsvUCEIJYNV7+fJt2e66cw2GR38YDj/xwiFCPGow6dzv4yBMXE+OX5YpvcMICCCxiyxTaiOhQQRkb9i0D8JbCUO2b4/0ofV3clt9Ef1koMdP94IwNkRVM2RJ+FG4vnEE7iFet6CtWP2fV9ohBsnoiDXycO5w5rbla6Vza9IBXW3aCCzgYBShxr0rRgLU515hahfBoNdDQBv6jrXJmn/e0bq575Q3SRcKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(4326008)(8936002)(356005)(70206006)(81166007)(5660300002)(16526019)(82310400004)(8676002)(36860700001)(316002)(47076005)(2906002)(426003)(54906003)(186003)(26005)(6666004)(2616005)(508600001)(36756003)(83380400001)(40460700003)(6916009)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:33.4773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baec0c4-77fa-4056-fe68-08d9e860ab36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
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
 Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <Zhan.Liu@amd.com>

[Why]
Even if can_apply_edp_fast_boot is set to 1 at boot, this flag will
be cleared to 0 at S3 resume.

[How]
Keep eDP Vdd on when eDP stream is already enabled.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 52b22a944f94..ace04e2ed34e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1770,9 +1770,29 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
-		// We are trying to enable eDP, don't power down VDD
-		if (can_apply_edp_fast_boot)
+
+		/*
+		 * TO-DO: So far the code logic below only addresses single eDP case.
+		 * For dual eDP case, there are a few things that need to be
+		 * implemented first:
+		 *
+		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
+		 * stream[0 or 1] will all be checked.
+		 *
+		 * 2. Change keep_edp_vdd_on to an array, and maintain keep_edp_vdd_on
+		 * for each eDP.
+		 *
+		 * Once above 2 things are completed, we can then change the logic below
+		 * correspondingly, so dual eDP case will be fully covered.
+		 */
+
+		// We are trying to enable eDP, don't power down VDD if eDP stream is existing
+		if ((edp_stream_num == 1 && edp_streams[0] != NULL) || can_apply_edp_fast_boot) {
 			keep_edp_vdd_on = true;
+			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd on\n");
+		} else {
+			DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, turn eDP Vdd off\n");
+		}
 	}
 
 	// Check seamless boot support
-- 
2.25.1

