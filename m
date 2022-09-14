Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925BECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BB610E856;
	Wed, 14 Sep 2022 05:20:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C38910E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXg52qC575TXhvaQHDB5JFCQ3aOP5bD/29af7O/gTUl9OkrOec7YTqETJJR7ZKWhRPlEKUudshxD2HpZko9eiJkWODJdfDXGWz7dHmWjXTH0usRlgKFGAQ+q0ZW68yfzKbHZACePSSC9qu89yNu9jDVB8iAgoA7EjmEtsPoYq6yG9aTtA6WYRt7diwkBuBuLjF6d5LAPUDfYQ7taUBNDpgZ3lUN0NUtL/gS/tC/M4VrI8SuZ5wiTWzdPEZVnDmHvP6+yySO5vERxrdVAkmX09rfViZZjLynKZkyNVRveaXL2d274nWliKZxj6+/rjka/y/EwjD7/iY0ZYOC+884fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDzVgp1Hgr/5HX4jZ4ykuVE0QG4hWoD52N/C/1U+n5c=;
 b=KHsr1dLxqRwBF5q8cWYfQHKXwPCV2P1Kz6PfPv9p/wQ2jjCBU1Y6h3l4EBq7htqV/HhRYkz86uwpm1/TtT69upj/L7TrSqDQEGxxRCzRPvMpUkVZPIYaT17K9bZm9268HXZeeg1B4/jP2tFg9rKqwqagfLos+dhnIMjQVdxDUDMMTluJlr906E8WJLZylref5ooAVefuuxfX9VRs8H+gtfRY81us01HkdIWcl2Nt+UobVmYa6KP7JYW2nEJfqMohsTQXbgCX+2YjubMXGSxPM7w8kODFIZmFcknIrzHtawvCdVZCNTQ/JDC08dCqyhV4pCqvjer2R0H22V00IvFvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDzVgp1Hgr/5HX4jZ4ykuVE0QG4hWoD52N/C/1U+n5c=;
 b=0mNMCxgd2j6uR/y+k2lMAT7E5hVVUfkinbbgS4x6q3FtqX+l8Yft6YHhI3+At1M1cG7NV8DVv8giuNpT0Wy/K1K5C5RKvsPzfPUaaVLN+kigRwkTIg+qZTg6/JCrFGifFiqwXT1gQCTFnbHdUq+fA1h3sWFNsXCd8s67Fu/fXFs=
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:20:10 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::7a) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:20:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:19:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 45/47] drm/amd/display: correct num_dsc based on HW cap
Date: Wed, 14 Sep 2022 13:10:44 +0800
Message-ID: <20220914051046.1131186-46-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 2509de1a-9ab4-4e7e-dabe-08da9610cb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+H27BbsQ/UE7fXNm8lqofEyLDgaOfglFe1SBXCrRApGczuuHLLF40VuvqUEcZfuiRG6sytvSgq7uDoYfg561WZneigX0EAFd7qoGOYQup178z/KcnLy78Kvx/n0VaD+yIgBHwfAKYuc10pOyqLlAvH/pXAeTDDYNUzX5fJ3aizG3S7aelGiqXqn7ku8Dqgq/q1C53J/xdDM6+tPpN1mvt5Cdw98CFzro3YQ7XMd8bSOpV7CFwFHgMtqa1iKTCI6jF2H3qcfWX8W7WreK6qJUcsdN9sqZKaS06LnL87JfzcJmH49TletY51BcAjJ7zO5tClv2Wqip89uBGorGzhxxceKsPb8qFsTdSDS//Oks5QKKOMOA132Fgq/TJEbTNBcFQcq5u7zPMQPe5JLd6n/7SMH7HX1JBwGE1ozHwW7zI3BNBrnz5Tn0d3lS8B3JxITbVbqGelRhehjVgKmVJCiKo3K4Rd7qniUNCqDifMXoaVFSyiT3tP2/1N2Lx+2tgTTzayArUL61FeV2YY5buH0d0DrJKc8siXs2QbAW04J5S5iYIsarwaRWsA4fVAla3FuIfdqj5WCPDUndLEeB/7R1LkIWrAkazeVZVG+LmYpD1NNai/AY1y7OPgS4fm5s2u6buIInB8kG5n0LTHG6ZGXuMjfqh7NpVPPSHfcC42XFwYpWqtcgo5evz/QrQXNbA7O7VKjgeqk5ex1xb7/Z06dM2t/GhD9To+czhOyj8YeNWjKkDVKd4jgTe7v2p1KEL4/7pRnTT5RC57+izMoujjvIk7SDTvno1ue0UxiBgZl1LtHKxDXBkVf83xAB8pNosC8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(5660300002)(2906002)(40460700003)(4326008)(8936002)(83380400001)(4744005)(8676002)(70206006)(7696005)(478600001)(6916009)(40480700001)(26005)(47076005)(82740400003)(54906003)(81166007)(316002)(186003)(86362001)(70586007)(1076003)(82310400005)(36756003)(336012)(41300700001)(356005)(426003)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:20:09.9142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2509de1a-9ab4-4e7e-dabe-08da9610cb41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
num_dsc is 3 for dcn314 based on HW capablity.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a6c5ad9b67db..24ec71cbd3e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -847,7 +847,7 @@ static const struct resource_caps res_cap_dcn314 = {
 	.num_ddc = 5,
 	.num_vmid = 16,
 	.num_mpc_3dlut = 2,
-	.num_dsc = 4,
+	.num_dsc = 3,
 };
 
 static const struct dc_plane_cap plane_cap = {
-- 
2.37.3

