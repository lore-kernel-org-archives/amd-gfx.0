Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A5CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF1F10E20F;
	Thu,  5 May 2022 20:08:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C69510E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBCxFEj8UiNQLgokEYkWTJLutBRbxl9GeuEns+2peuHatDAeJv3+5fDT9uBtpprqAeRGN3e7aw/7ziAK+2jShLgM+qEo2F5nA6HpWbLG/LgAKwSTFV7PDcNwLXciZa8CfzWfWer+iMr1xMxXXMOXLota28jlbd/8UXF0ZKsr+v/2jxNtOCxE/GHDfO+3gBYAliOtoUl+jx0kX6EaU9wOanmcW5hPEiS5BhXuBO9J6KenCPax+ERk5DkQdyj6QHy0gF8GRHJ0fsUJ13W3+wxgf0nvBuEEGj4A9NlXYJSkbPVbqxwXJYPLbYCpxyMveddis/qNXx9v50lDfSmOJtMhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6ChyLCSp/dd2aG6S6oldNSbpbu8mRS3Lh7GZ6C7IK8=;
 b=FvQvD9e7rMlS76Xxhl0nwvY/9iXOq8FyKesBIYDTMo6VNthmv0hl9vsk4uu/k8XOcPAAe/e2xMkaBiqffa5TgR8hzyUbBMrjRxmrjUSxWLyZuYYzY8Zg+xccL7y1d2dN9SUmvMP0b8+jPnChfwOUVaGr9RHDUAimMwyr20wQCGGjhkDAQoMPHdXeEKQLCPnR/miF68K6POncdjzZW+oqVBF5ed46dmyXKAh/VLXIdT38YiqFFBhvDZdqKOn3YDQZ6+2rfwRb3mdtsNPLO8UsYp7fgVDovpTU+ScoyS/4buhGjOFLtb0ZT/NSqAJymddbMqa6moi7nNQly5x8crEkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6ChyLCSp/dd2aG6S6oldNSbpbu8mRS3Lh7GZ6C7IK8=;
 b=o1Jy+aDk/A7GPgAA9u9HyzsMajLzewkBp3n3qW5zEQgHnhPxdUt3zRmnSuqBwEiixRga2p1HmVeEgB5lRbQiBSEAV87oon/tfkwp7qZlfwLBYJlElaHe2hyrrWF6T5lEpk+3imlahTz546UdOZjhOxw+TGmJ/ZZ6vmdOCiil31w=
Received: from DM6PR06CA0048.namprd06.prod.outlook.com (2603:10b6:5:54::25) by
 BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:08:36 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::52) by DM6PR06CA0048.outlook.office365.com
 (2603:10b6:5:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the way for retrieving current fclk
 frequency
Date: Thu, 5 May 2022 16:07:42 -0400
Message-ID: <20220505200750.1293725-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be1e6eb-7b41-414f-2821-08da2ed309b9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4932:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4932BFEE7B1D6F6F84939C79F7C29@BL0PR12MB4932.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfgDgR/Sitt9XD/J2nSoluvX7+UCr7FZxh+zgKP9YDhFIn6DP1sZd8tRXzRDb5Vm7A3dUhp3Ntf4GEMn6YgiugNAbNbpTSFqUjpjGbGdQ8ukipDpTkZ1cS5MQdHnEH+96k6+3d7LriFBObqUnJPu+PTQXRgcLixtEyRmc6w2WRh+29VZxGc03W1t4y6MHe490k2QAcvWtAJw7Vy5I5XF9kxI0Wdzru7r3MzxLqsLkbmOA0b0toXusF8jk9PHhEuj/YZCOkPeTldyBF3Exyase1dwYnVtCCfXk56fcOuynaXVB8F4uhTt2ck/Wa+KPtagZ461ZVexN0ky3xASvwquIsDZXIoQM97lZRFHPBDBrp9fbz/GMWKDVKzoY/GL+Y2mk6lmNuKvKwuwoT2Q7zI0JAHvhU3tWwBJWasGAi0CiH+Sx/5N+sRH8ow9VAcDjOLWFoF1tabFzbUKhyVkYtCPXk+avMufWSrZoFMYgQ+pLZLfu+aDAVtzZo4w8eDho8AXfYXpCBHcKcNzxK7mIXXArMxbGF6ZtXQindNDQt/koHe+0jIpLwwyiMa0tCzQMic7lhugnysAff74ibBQRBv3ICYJV2OEdBD1I0a+Jv46T3KogMi3sSS0s7xnZxfVr5KDmGPeIkxT1X5HbYFURNxFBkeXjoFgZItjITh/0aconhyV/dcmF2+gTsb0Cuy+3yJmLj3LP6pRebQRp6qMURx9mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(82310400005)(1076003)(7696005)(356005)(36860700001)(2616005)(8676002)(70206006)(6666004)(86362001)(70586007)(40460700003)(81166007)(4326008)(36756003)(336012)(186003)(47076005)(8936002)(16526019)(2906002)(316002)(5660300002)(426003)(508600001)(54906003)(26005)(4744005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:36.1359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be1e6eb-7b41-414f-2821-08da2ed309b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Instead of using AverageFclkFrequencyPostDs/AverageFclkFrequencyPreDs,
we turn to target clock frequency(CurrClock[PPCLK_FCLK]).

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f01227e5e96e..6a4fbcb5c4aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -852,7 +852,7 @@ static int smu_v13_0_0_get_current_clk_freq_by_table(struct smu_context *smu,
 		member_type = METRICS_CURR_UCLK;
 		break;
 	case PPCLK_FCLK:
-		member_type = METRICS_AVERAGE_FCLK;
+		member_type = METRICS_CURR_FCLK;
 		break;
 	case PPCLK_SOCCLK:
 		member_type = METRICS_CURR_SOCCLK;
-- 
2.35.1

