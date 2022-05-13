Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E4CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665FB10E988;
	Fri, 13 May 2022 20:51:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0CF10E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKEoMssFeeDZYa881IXTDXsdJ77AFaWK6419kPTLlwjcswCzA4eBv0iStkJya9pvuj0JGoRwjRVmkOzwy02qTRZvmNTx3vEsFzp1DC6g4NmJoKwy70gO38ko8uNuHpS8oqg9/t2mvfRgRaBBdwafJ/wKdTU9dcODXbV7d0l97h8eUdDf72WP8fTVoRy6XiGyQoKxttT9T5E8IOe27ZdbVq6SFIFXtRCpk6M4y8gmPk7Q0Pk6sfD8teYevbaSjgCJuwO6hgh0Y4ez7U7ThbmsKAzp4Zjs37/5g+iHJISEgP1i2He3hkfJCn25+2/bF0zBHYr+p4NmbAn6m0FwdU+Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ja0gwT6dkbm40bUytkuTsuI94DQ/KvtrUPsIkTQIlA=;
 b=mrOE9sYFHgdgaKd7kt1cw7UmtCqAFCFo1QV6oyxsW0iS+kQI6rrXLhzxUJJi+0ZbtCpRQWt1kRHt9W2W1cNMsXePBxh/FbC/kzQ+QrksjtGAenKL2LXAYLnXibSbrpULuWFsYdZqzrj+ao7/hYQLusF8OInJ1SB0uA8KojBRpw7I2rEQ7ygTgdlauY8eOC9w0pwhEwhhNsWVjB6OczdPxrL3r1cofhjh8UAHAYLPukaZrjIEFJiNdORFWEY7nrkM+zSZTwKMAoZmOLyn/zWq/1iEXhkbtCxYRbDC0nZ3wZmKO9qrm3QKQZPx/KXqUFSn+Ipnf7YIN6jFZC961LRz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ja0gwT6dkbm40bUytkuTsuI94DQ/KvtrUPsIkTQIlA=;
 b=YJ+do8J48/d6DL2JvL6YU9EpZtjbnQDIIbREKnjKE/js657Kl0T6AgS678EdKgFxZrfadUgPMXPz69DG0oPXEHb/HIfWW/98ft/FH8J+apFGytgrRG5bIEk6vwqj/abXcFYoEQEe3g/lIZk3DfNv/P6lEC4NwBbIdUlPFrXnbdY=
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:28 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5c) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:28 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:26 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: clear request when release aux engine
Date: Fri, 13 May 2022 16:50:34 -0400
Message-ID: <20220513205041.1311639-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6598995e-0e28-4476-514e-08da35225a18
X-MS-TrafficTypeDiagnostic: IA1PR12MB6353:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6353B8BA376BF85C10D450A2FBCA9@IA1PR12MB6353.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t+Av6soeulxgdVAMZhr9otIS+dhIOebzJwcy+P45lBkgyUZfcHJkZXUR/yxYda6jdBNwKy5cDM/kZD0kGgYl7t+jb1RHH/Dlh3ulpqj16MJVazxNUpHZ/5pJe4ECD5jLLoOOi4BY17a4MI6dnQimtEgyliZ3vXu3YJJ9cPOR1az+LE0y3nHIzYAATach1ERUkAztuF+Canpkieq3WoQmwIbbbxrxEDklhIaSVBXX82zXis4IoSvHOOlAfurzTHEfD2GzdhLN0p+PYchhTFPfYcPCTvISN/QDKdlf+63TWGHM7r3jLVNgsQbTomWTbcZs3trNb8A6YZb7z35Sp3G60eLvI6uxzO+ZkD/PK/TUz+EsPqTrSJl4ncb19g0KyRZP6Syt1nskOY+JLo74NwhgS9Krgszg8OgwImXwDyn0sHUdTFsz9WsTFNNRnq8q03mL0PjV4tgY5NINLpiLqhcXaHZcdm1YGHG7Q80JyA9TUGtJ3hyfOY1vDJ1qnRXzsQJSPAgrjhQtgwgSMAoo4yLm0OaVggdN4UnGEo6OfNrfYcsm4f252CbGps8lcv1gKCYT+oCU6dIrC6tAmwh/c6z7ohvP9sG2QAZQIjR3oJpZtuG0dUNeXygyZlz2Jjn3RW4QBq8hXkxEoLM95vZc3Aewv1c1FKTUtb2mNFSEq0f4+NEj1bv2kbIikVbGazrc9zQqDqbGlAJhVq8tM30Fo0g8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(5660300002)(81166007)(36860700001)(356005)(2906002)(83380400001)(44832011)(426003)(336012)(6666004)(47076005)(186003)(16526019)(70586007)(82310400005)(4326008)(1076003)(70206006)(2616005)(8676002)(8936002)(26005)(6916009)(316002)(508600001)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:28.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598995e-0e28-4476-514e-08da35225a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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

