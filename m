Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEACC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CED10E41C;
	Wed, 22 Feb 2023 06:44:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE7210E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLyrhN67lB4ziDkmm5lQ5ski7gtvoefTc1EpvFJ+0cZFuutTMdMGcIxzfjqkLXS/z8BPuzIafN73btYizAKGPxH9Fr53vTNQPBs5Uh3TSztxZWOOVMl5Nihw1fZnuB3Miujzc0d1EaYylaUxwlhbO5kwHk07QynN3VGMTp371G9mTrgIoMxaZ7G8g0/ePMTPB3t1ym5bDIMuuxI3eIjaCFDVWUQKYLL3G6azE1liOCfAOWRX0qedB8JagAtdNCOjRJ0gHrF0LZVtiA/fca+9UYN8OgwhcovWLwUFf4p005CjDIojfVOFx9MWpSM8/AblDOIjJuBkrJ7XUjELFx/buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+O6TtRv7LuHADLWuyFY7A3szNJcWHZMC+0/gU9/Cek=;
 b=HWXfPe10HSMum8Y2nuNiGU+F5ISDRGuA+5tMQF3P08nS6F/94preBGKpXq1qKwDkJe5uIcuHu0F6U/0wOjXSzyEEM9+tNt9cJIYXUGnJUA6Y7lAwCPvWIUSF2iERJbPa9wBt29bx/DKPjxB4YzAT/CO0AJDVPkygNlef9v9+5OBMihNI2SE+9vUbhj2As9EHWH7Zkgz/gTH6yauvargUePg+Yhg+uio8AIDEovW2oR9dWwXxqR3KbmcEE6ITMF/l/6tgWtKE4vwct2vxbhxJNovsZ1xj8l1rnqEXgNBXG90sxFej/q4iCEE8RZnVHxjzsRbiC3R9XGE8EfGC2rkONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+O6TtRv7LuHADLWuyFY7A3szNJcWHZMC+0/gU9/Cek=;
 b=0eDvGYC5CFNHz/8Xaw3iFDT14aGq9I5c9Y+A4SdC2040ZBGsiJIpYa2w3t378GBGUkikf5FFpPP9ZcWw5VZdsnAH8+yiBjyEsZp1E+VnOnyVTZdvBK4zswRT5+u+K73qrokRwuCZFUZMqc+8xJWpSwzUp4ZHZxjZK4pWeqDTWH8=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 06:43:33 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::da) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:43:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:43:26 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/20] drm/amd/display: Promote DAL to 3.2.224
Date: Wed, 22 Feb 2023 01:40:41 -0500
Message-ID: <20230222064041.2824-21-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aba2288-b2ee-4cf0-85ff-08db14a01dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9Drood3cnV7pmx6aHY0JXYL2DSmrEvZ3MjH08yz5eGa0HuvvlOffksTQttznmFj7NBiQrhCEvuQhiMNJHqlELRTN+6FMcM3a/SI3FLnTDiZw5k9acrRBGyXqoOauEixFRuDxL2bE3M042BMV/Zetyo3NbxOonfW5MPA4n5OekrNvCUgmBNb7PtQOKGduex84hxxPHUPlAK1kpYoJEjH+vUCWv7Tfoyq5J8x3wO3+kHFD8Py+Q2J8DMfeSNmEZMinoMR796XmIQUQ2XVmjWoZaRPveDtLScorKRONrVUNNM70sM9Huculpl/JMW3RhYH05jAnJj6CDGSbyWf5W0LVx6p81AHOQYxy8J6aQRGbH9rwNUDoCJRzf6DYXYO0w8pdmVTu/BG8cVS4zM/I93tPoaCC3KOENlgzFVUu7wHCh+/1KIuBchlnwOu/3/20YAmJb+BVTXOxcp6Siqa8i0vJrmzUYYabWTPQ191GmXdJFeqoGn8FoVkEdkBTJ/4ILz0mjgi26x++RFQyojJpKrWZ+L4Gaami5pBXe4zb8eoUXyCnR08caGOpYHWAqTB60xqTTELmdSbU45d6crCZpNrkhPEaa7R5mYR6RxBMAhRzaF4GbVED+zQ2ifFMULOIIvSBc8Xaz9Pg55UfH3Pkxbod07NhHJt8x3llYFoFaYiaH5H1j+vJlVZI/Slm1znoDbxv/0BHTg+G+GlCfV3FuyUDg/rodGPRjjuU83htF+GmN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(1076003)(6666004)(26005)(16526019)(186003)(70586007)(81166007)(70206006)(36860700001)(40460700003)(478600001)(40480700001)(54906003)(86362001)(82740400003)(83380400001)(2906002)(82310400005)(4744005)(356005)(316002)(36756003)(5660300002)(6916009)(4326008)(8676002)(2616005)(426003)(336012)(47076005)(41300700001)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:43:33.0721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aba2288-b2ee-4cf0-85ff-08db14a01dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Correct DML calculation
- Extend Freesync over Pcon support
- Fixes in pstate hang and more
- Code cleanup for dc_link.h and dc_link.c

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c84554933dc2..36dbe11256ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.223"
+#define DC_VER "3.2.224"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

