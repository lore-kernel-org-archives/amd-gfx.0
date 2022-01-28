Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAD3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A2710EF9B;
	Fri, 28 Jan 2022 14:06:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EC710EF9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R++L5N0ecY9ckC2tjdhCt0zQHccW87T0yGiXd88JigvcVpk2UMOoApFUSYd1DC34HPJDAPl4JOKgP5H3y0j4lDWzLfWMgCEvsvQ274j1f0jhfCDRsQCRyxvEjmzX2HAB674CLehkpKBL5Uz+fvqnqeUwtWQnZLw0r5Lq/c7WZVCY6gPD48hQEoKZA9epT7LNtzTm2afu1YohE19OAWnayWskEGvpfNxoK5W2Vyi5myHfDyBGScHs9gYo+cFOsgLa3LvTKzpXuSDJMtQn/SBKpLRxLf+vcjtXJROMA6qot1Id5WPVEdbA5vCeW3KuAsfP771HIvIek+yCmlD5aBbX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOcHhBMqshC5Z46KJA0XwDOtgN5T0/AiBeb9fy7RNyY=;
 b=oQfgSjAfkuVq6rXitFZBbptj7oJx7bK9N9Z1lgRm3v1BKWQ/b6MVPHxIiilIaG+PTU005jgln+eCLeGPuRBagBZjsSLAVuW3+GON3ifPd4I7/rsLZbs2eD9A706LPx0wFsdQBbJYwsy3Q8gGAjUcQbC0x82fbj/Fwb7yo/CDomKkf1GukZVC71Sed5s6q918UwANZb572BuVgzX1AV/tNbzrZxPMYRC+bBZBH2mcLmBzSdpmcRJznDMjd+U0uDf9K2yWrkFOSd5l3JhAKmIUoBv14oyeffo09wZm8cWKkBj4VdfRfnTx2lMxAYF1brse5M971mrU7UEg+vw/w9+GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOcHhBMqshC5Z46KJA0XwDOtgN5T0/AiBeb9fy7RNyY=;
 b=JFnJxr2QPgccR5T2zbsXMsQ7lHMbhR6ClMkB6LsYLyGVAQODO/qd2CrWamiI27pzJ42r+c4TXXlp84A1KDrtV2lPtcN81siyMIrm+Dz5DXcBVo32lG4jSQBgk/faK+XJpTUwqo/qJMbEir42gcZku13OWh3Lr1BxbywoT6G5Iy4=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:06:06 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::56) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:06:06 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:06:01 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/17] drm/amd/display: 3.2.171
Date: Fri, 28 Jan 2022 22:04:09 +0800
Message-ID: <20220128140411.3683309-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d61890-e61d-4ee4-9cdc-08d9e26753c5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0254B9E2E8D445A53742DB4FFF229@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdxRH0/LvdVMGJtQATQ8qMifoDaFtirm6jWYpFxzzGgjxkwt0V2bJJEFbDW+q7QOCUeZvUuwo744FfSQrisI89o3y3YVRQ02HJOreVctVG95vPmi9MoCf9JCe6zOeOfVJXCRr3nv8x8j4g0nQUIg5104/1piIaEub6c0BkOnbyOaF9G2Wv9L1ClvgFLpLWjg7l75tAN7GRlpeC4lBZ26tLI4CDuRZzVoMpkp4eMtTRde0aQBKQHnV18gjxrI5CcAT5FeCDcvXbtBUnDbYLWrzxDztxUJXSvKchHKSoqvFTBGeM9fs7e40odJG24EDY9mYYWLTwRQIuya0DQm/+C6exNbqBNth9nxTVVi+6ai/coUtfI47OsXkZYUePJ7xuuygX3kEeJFAFvujyAFznQTyCe58ZziZTtIMENUgk+TKE/LqrY5Y9Boh65KjgtodSefwInDPsSWJpx6G2H60mEm649gqOByHp56H0eZzbRYRylP77YJzjtqosAlPTs7a0qd1we2TLgy+cH4HXQXSaDMvtP/6yVGfQGjELAT7NB2IMoDv2cGAXGAlHpU/yJQ4bQbGLGHPFIxNXaL1dMGmhrkVmCLQo9C5hHXtUdwlJBxLHw8R6sXEn6KGt6Cnv3FaKTL5oz6EQKGZf9IeZye9QQ18GuvDcU0vA+hMfMpY/IpiaIKeW5bkEATB8jTdma2g31Fw5/o3vPJNlybhQpe6XqHzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(8936002)(83380400001)(81166007)(4326008)(70586007)(8676002)(356005)(2906002)(2616005)(47076005)(36756003)(7696005)(36860700001)(316002)(54906003)(336012)(186003)(16526019)(1076003)(26005)(4744005)(508600001)(40460700003)(426003)(82310400004)(5660300002)(86362001)(6916009)(44832011)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:06:06.3510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d61890-e61d-4ee4-9cdc-08d9e26753c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- DC refactor and bug fixes for DP links
- Bug fixes for DP2
- Fix regressions causing display not light up
- Improved debug trace
- Improved DP AUX transfer
- Updated watermark latencies to fix underflows in some modes

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4f9dacd09856..69d264dd69a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.170"
+#define DC_VER "3.2.171"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

