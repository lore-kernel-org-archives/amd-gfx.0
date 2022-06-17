Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C76C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB82210F454;
	Fri, 17 Jun 2022 19:36:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2AF10F47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOBg5rD5mpAwA+XCjahHpwvtqbOg550d/ntP8u47Tuvb5OdBJhf2WRgh4raWRUgRj4A5ThzMTBbvq4F+Frt7F4Bb48xGJ+dfzJ1BM32wHRzE8dcW/+DRR7OCiDdlkksKJlcj2hzjUJgxkUsNrOhSJO2/IZlkaFCKMzTN/qg3Kv5YIiUdvOjL/Vx6C4B1EhGifFbcQaHksFYlqjHKwQd+NZmJqx7XACBlIpBaJ+2kT+iSPZvQVSq5yxUK6N/ncxMjl72DQHuKk1AK9uoSXHz/rQ70Phicn7F8H7f+J9IKsHEL8kKaNgntaze7mrDql3hbnssBtDsP8m7OIaUTWcbTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1LwO006tT11mHod3YJh5v9FqmRotXXuAKI4kf5AK08=;
 b=I7AJfN3JEetw4bMrNPYu9fhJsjaEDxxGsBj8mhk7TwybjJHOvsBigrrx2KAfdprWXah9qy1y+Sut7t9UImEpmGiJxbBMAhA//LTo7XJIVf91sR1vjwoeSCWzzhWZLXwIo5leQolfkp8QwAA8LmRNR4g5kiTt6cA2xvDyXAKKl5SkGS2sXqFMTXVSCmj/G7CkUjDLBChYteAvxR+PdamTVK7MN2/F6JZ7694Oh03B9x8KV0duyC9eSkPviW4Rs3xnMDvfS1z3mWSjQq1bZBx9kjK+m/Te6YHT/E+q289XmE5Gz3+EcVluEoZUMmMktkvuC3y/ezpCPhWExm2eo19FJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1LwO006tT11mHod3YJh5v9FqmRotXXuAKI4kf5AK08=;
 b=AZ98Pw1T8HvYWpC+2LvitZJNPqaYcfAmWixOMnGiSFEu4Nhsni9xXBcvrX9XfjQCokpdhUldwHaGTKzIDJEDwK+oWna6Y2vnwD0mJR6OenDeeuiyKUqWcSLG9NvevIstnmXxgB3pZB85xzaAQj4sX4toTve9bX+/gB3ZA76XE3M=
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:05 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::75) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:02 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/31] drm/amd/display: Fix typo in override_lane_settings
Date: Fri, 17 Jun 2022 15:34:59 -0400
Message-ID: <20220617193512.3471076-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5427aa0-68ed-4afc-1049-08da50989d46
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5088B5CAB8D7DD05475A0FD998AF9@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMql1ab/82o2daqC3JrFGLi0JBPBOzeI2m1aIc2jqFhkmLaELtSim70ykp03T4GyZiFyTq56EDJCxLLg3+oX6FRYjz8aBLsj9eRmyZyEJZaqMmNdDhoqk/PScw0k2AeVO6sVAfHaOopkvtlE77fNciRsS1bIazNXMHmaVAI4Uk8qmQjhQsCxZwBQPQaq8EyIni608PNF6HekpQwoOC/d1WdSBcJvF5xfP8bqILaw8p94qYnvMD1tO6NlWn8xm45hdGhbV0kqvBcyihhPUGmSkd5rm1IejrTlJY2KE6Z8WBW6NK6FPUxBrNMg+aq9/RpLTvWJhpeT0COUX2EIQa8ch7sHaEhqsXeKKKjWkmz+ZJgifjl0QNDTMytWn74YabthrS3HCOdukeBLqdgIF86TdmXFC///fmwE7ZQ8MWE/MBYxL5hu2O5LIC92hj8G97K5VP/0y7Cdu+vOIi8XIZtlXU3Y2nAXCp8zrYBMuK8H43ACjiRBkpM/cZ0BkO5navAM2f2VsX4ucMoOorayS+t3o9UzCwmGXLDrWQ5BvHtUPKrJ7GXWthQiyKlj/Uh5ElTlK3MLm8fApIQJKZ526u0arBTrSQk3e+XYNXJzDeSDeMRRp87Q6OAyfD74xa6NYtTsTLBuTpZ6fdbqveZhaEWmWxrrlRg+gk0q3VhdgrAU3zhgYVY+iyV+yuJjOF/S79w2ytJBYkzQuWNiqOsaaEYRSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(2616005)(2906002)(26005)(186003)(40460700003)(83380400001)(426003)(47076005)(336012)(1076003)(5660300002)(7696005)(8936002)(86362001)(16526019)(36860700001)(6916009)(36756003)(70206006)(356005)(54906003)(316002)(81166007)(82310400005)(498600001)(8676002)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:02.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5427aa0-68ed-4afc-1049-08da50989d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The function currently skips overriding the drive
settings of the first lane.

[How]
Change for loop to start at 0 instead of 1.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 76efac8300a9..972dbbcc36da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -944,7 +944,7 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
 
 		return;
 
-	for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
 		if (lt_settings->voltage_swing)
 			lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
 		if (lt_settings->pre_emphasis)
-- 
2.25.1

