Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFDAC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 19:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBBB10EC13;
	Thu, 13 Apr 2023 19:57:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D133F10EBFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 19:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq9PXtaeSgmV4xe+4iTsQabRJTEJj7ETxS0RDNlOr2IYSQlQmqyvkjtoJAd6qX37ZxHqib9c7waGuhoGQrgdcHZEPnbpsRnC1yuRUbdZ9bbfJuaLCLw5+y6GkfriAW917B4ZZ2acad5oYV4oDlMb0EQe14K4V3w3ycxQjqyLMwvXxA2lAYuEbyhwSGCZmnFq8xWsB2t2AHO4JPlNN1K0nNo4a+uw12B7Q0pPD5Gj2Db6Vxseq1DZFS9xJnDJHH5jlRUWRuqcLkGzQT33tl8UuPGznfVOfey9iA+CDdanmymro699BHsCauAC/EazJ6tzMZZZT/u95ZdrCxfnYd/+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBCpCL8XhDGx26FXPMnYGccSkhTM1us8IY+cOSVlJGk=;
 b=LUqeWl0mG806RpeWkudsfuYSkkpgIzH3i4wEC1+Ux6zPwqjBv/fkSHAS9swA6MZoFhekmaeEWG/eBdb5rIeB4nzBHM9IpoO1lcOPqEhM6ouK0UgY20LXfAEovWX7LwAgvM1mUOAaScBrPJk5s4r4xtn81zqyI72HBBlsPSBk/OcaaNF07cz4/TMGH/JocP5qnLtfukYmLxwO9vfh6noDpXGc+gUd3LNZJy9/JYnxtEHjdZK7mKzSU1sNn0A2X2OcikTkplqChnXtSHQHK1t18CVTJD3WtT9K+3RNP5G4boJgOuBZT6yytVq5oFJzCnKEGuVEmhiVJgvfTsHlyHm0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBCpCL8XhDGx26FXPMnYGccSkhTM1us8IY+cOSVlJGk=;
 b=MS4sk7DKO/3oSfBs3OcpOVWyidrZMCWDGFGYszTFquBRqghZQEztWFfGnSwwe3FsRyiYXv89h1mOQVkBlhYjErKgl8CNx93K+TIFi5myFMCQzz6vgRlH5SxQSZhRlkhnHXFw5Ble7Kw/PgFgTCninz27TuwtHiOx4e8ROpEimxU=
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 19:57:29 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c2) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 19:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Thu, 13 Apr 2023 19:57:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 14:57:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add logging when DP link training Channel EQ
 is Successful
Date: Fri, 14 Apr 2023 01:26:35 +0530
Message-ID: <20230413195635.2368590-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e5bdf2-1e69-4336-12bd-08db3c594f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5D6LZWmsRAUX8WGkoDUUZsyflc/FdxUpqrBa2N3r+Ws7lXUXrRBB5LAHUuaSGUc3fNCsIJtmYMvrm3ELdFjBTZonfyIBCabZqNgZCMu2CdjCHBuZNxsGtiL5H00zxmnp702PNwPQ4xA9hfcev5CCBpOP3V7ji3Z2crIJRvENBq9Kr0Rht/IlyEW96mBX/Dgo4JmYcFR2lIAA/1iKguGrwNyv0JuQr08vp3Uc/WF27FEjewuEdqGj3gkcSqR/gJyoUg48++aZblMt8tNdxWgCx5I4Tcj0nczl9o1NRYRaZ25YTGOcOJRekSlxip8Czl/iAGL6B2tDGWLo2MGXIAdRmYqoH6/j00yNt9dtyyA3efVjks60EKOQMQ14weRu1Ughdqa5iFdIKxmcJbcKp9GEPl4DWsCRiR86AUpDIgiLc9B6ICmni2PUoVCTnjnsDFyugWPhbh/fZhm18oyGSCIXpXhr9fefC5zY4xxvTb58C363fSM+MhfI3nLPIHEA/Sl9+o1EQIALyO4a5Z2A/gIB/I+wN8d7MCCz/uvpuI9g16B+Rg6at4kX6kP0vFaCpvU/3NXR2NikupmJ46Y7KxDGvIljgQt4RDTKGnfato7ouApbJawjKmPvCfxdrBqsLQVrJ/cd9AGcRtArsDJ0SmZLrOMapRH9GV1qna4ViEThZf2+BdPuAfDFAeTw/WaVxS6xwR6Mlprk1bOlGTiBxdKYDkXz+BCR8mQtAiEWo59ZMk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(110136005)(86362001)(44832011)(54906003)(40460700003)(6636002)(478600001)(356005)(81166007)(316002)(82740400003)(41300700001)(8676002)(8936002)(5660300002)(70206006)(4326008)(70586007)(40480700001)(26005)(36756003)(1076003)(426003)(336012)(16526019)(36860700001)(186003)(6666004)(2906002)(83380400001)(47076005)(2616005)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:57:28.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e5bdf2-1e69-4336-12bd-08db3c594f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log when Channel Equalization is successful,
and DP link training completed.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../display/dc/link/protocols/link_dp_training_128b_132b.c   | 2 ++
 .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index 23d380f09a21..db9abb7ceeb9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -118,6 +118,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		} else if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
 			/* pass */
+			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
+			DC_LOG_HW_LINK_TRAINING("DP 128b/132b Link Training successful\n");
 			break;
 		} else if (loop_count >= lt_settings->eq_loop_count_limit) {
 			result = DP_128b_132b_MAX_LOOP_COUNT_REACHED;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 14b98e096d39..41b38da9feb4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -337,8 +337,11 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
 				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-				dp_is_interlane_aligned(dpcd_lane_status_updated))
+				dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n",  __func__);
+			DC_LOG_HW_LINK_TRAINING("DP 8b/10b Link Training successful\n");
 			return LINK_TRAINING_SUCCESS;
+		}
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-- 
2.25.1

