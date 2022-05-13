Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A77C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0779310E516;
	Fri, 13 May 2022 21:17:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCBE10E516
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctw3hPUUhFwA/wTwKbDSLTuPUh5s4k7v4xVKrAEv5qv0+zG0N3ALcPJRDaeiwc3lgXEjjpRE3P7iG+exZBsyIW1ISVmDeysCdnx8xoGq7cKBpKoPtaw+qPxMaFAwXuxrzCfBm7ukVLudYMmgAgL+aS5ckjRmiyiPmUYTLI0kUkNO8qO/pFk7F1Pt5p5mgoKA3koKHcr1sLls1QU5TIag7KntB7SBeBRoZkavSeelDpRB5zhCOjy6EpLXjq2EPbHFThiMEioOojH0lsrAregX1PhH0tCnHCZ0xz0SoSrEft1WQNP5JLkcBuKrepXfRd1I0jjpl2QHoK898pfAqamNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ja0gwT6dkbm40bUytkuTsuI94DQ/KvtrUPsIkTQIlA=;
 b=DFKDbzTjd52X7qFGFOyXpfEPckg4lM1qxQiA+eah1LJOdN0VGWOFf+qTfiLaWq1bxqP9ZBWzwoy3ZKHkSJdlYT7/4jD6/XYeG8WR54B836/vwK+5+SyQ6027aLQh+2O8VhkJ7qckYBojQPOml/D4u1O09dD6RsequOzxeLe2a2K5I+p9/F9T9FIBCDNJzInOToUIabE/HNKN6oWDcxAccgrsgM5dKoqcgOGJAWXFMzxvbjfyjsxD0vOWS9weqC6lpzS8YUWmtB1Kjgqf5uKj7fdT1AT9yuZ5SQZi53aaWm6EBDYlYkAEXZKlFNWs/5xJip9pBgKxm59m0DWl4ZXqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ja0gwT6dkbm40bUytkuTsuI94DQ/KvtrUPsIkTQIlA=;
 b=1EcGIWBpgTV0q7V0HpDAUSv/5vgY71t/gVY9Lrb7AQx7eUMoJY3NSyIQAtVLcMCtyIQU/GrAeJsZYe62xyzmcO31wjKxvl+lWRKU0LA+iKeUh/jTQuzr2zwjNiJuEwcKzYDge18jxt9kY4FYg+0/Otfoc7Eu7kiYnHE58ghUCQY=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:17:22 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::89) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 21:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:21 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:19 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/11] drm/amd/display: clear request when release aux
 engine
Date: Fri, 13 May 2022 17:16:44 -0400
Message-ID: <20220513211651.1312846-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9fe97cb-52b3-4b00-7933-08da3525f83f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5852:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5852BBD1E4F44BE05E8378BAFBCA9@BL1PR12MB5852.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5St+dgXzrCn/SMlgG2PQLfkC0+DZAZj4sr9X+YXTFM6IM7gJ9HAe9PoYx7H5NTEB6BRNE1yNwtje1PfkCYtjpHk/W/YlVObeTLIEVIpbf9YcTzXfokjjdH7SM6SSF+/Qvx7AcP7cfM8OCajevI89bQBDuFk2oeBUGg85dsn+xu9QJZL95I8v4Mlv7pG+YPqAgaL49p2sfgOWPhj/74ZpUeL8ylZ0zNn26DHKZiQ2EvE49ihALQ4AnIMU76Q4X8/gsXITlSSClM4a2CxuZbKxMFixoDjhJqgSxIZ7S/hqS6b9LAwx1KScZvcD+3o6AfPWimaR6+FHVXEhGtf/bxDCvk3geKCcrqT0ussH4/aRXbI+QeKMQI5ryIYpLqad8aeTI/R4P5zQX88hkgcPjPGgzll/63ci5JhAuTWioetJ8e7DOUYQA5OZmSInJ8CV9njDtYAaPwW7b5woQcyUxPJAsqK99Ols/mQ6ctiuElz8hoeeF6ox9S+GXw6/sCN6e5MYLTJy1bLggmkjJp5x9ihj9bAxuZXz++o/g40XFPfA1MT8MCAIhJTP4f6u852dX+zXQ0/JIq0hHCo1FIrtBWfxaX64XWX7FHmeo2ynlcC9rFVYXOiXMsdU0Q2iwmeiS31yk1XSHC1MbYd3PdUnOOf8zcavBbaLE4RyAEBoig4ll1z+zAwWCfeqFuVI9XrTlUTwZoONFBO3hNeDAYyphKG0PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(1076003)(186003)(2616005)(36756003)(356005)(16526019)(81166007)(426003)(40460700003)(47076005)(83380400001)(336012)(36860700001)(6666004)(82310400005)(86362001)(508600001)(2906002)(316002)(6916009)(54906003)(70586007)(5660300002)(8936002)(8676002)(70206006)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:21.8818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fe97cb-52b3-4b00-7933-08da3525f83f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Paul Hsieh <paul.hsieh@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
when driver and dmub request aux engine at the same time,
dmub grant the aux engine but driver fail. Then driver
release aux engine but doesn't clear the request bit.
Then aux engine will be occupied by driver forever.

[How]
When driver release aux engine, clear request bit as well.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 29e20d92b0bb..9e39cd7b203e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -87,7 +87,8 @@ static void release_engine(
 
 	engine->ddc = NULL;
 
-	REG_UPDATE(AUX_ARB_CONTROL, AUX_SW_DONE_USING_AUX_REG, 1);
+	REG_UPDATE_2(AUX_ARB_CONTROL, AUX_SW_DONE_USING_AUX_REG, 1,
+		AUX_SW_USE_AUX_REG_REQ, 0);
 }
 
 #define SW_CAN_ACCESS_AUX 1
-- 
2.25.1

