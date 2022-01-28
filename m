Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4426DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02C410EF98;
	Fri, 28 Jan 2022 14:06:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8A910EF98
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MayOLxXNxi27ej5QoUTc/9K+QwEAd6/2sYCyCw+smhXbRLs/X2LfP70qLlpk84e3yPQDp0GVER83MMWINuSmwBhhGGVTmyxxw8wG5HyJVIEn/xUmVvOKbDZnowHiX8GhGimkXwjANJeUKylxm4r3BFvvW/FfOmljohUrsFhkWKm8/VVxq6fcIeryMoTOkPDpB5S9biDfwT1wb2oCbG1LN0LaqykTieuTJi9H2MJoIHyiyOVQX22sxTKtvzbmJC7zFiiccZ1zAerSE1nGDAKAMYeYqq7t17H6pniWGsPxeysyod8zCRPCpfCgtvKTJ1W9ubrDcGNuSvjMFP/84buntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcD4/dn2ihkPk2oZtSfa6fQmDjlAW9p5BXyXrKb4hm4=;
 b=W2KUk0uP11ohhwg+W7qMkdnrSBKMcsyinhLRJjTlR7XJn+yIIkkoAr9cY9frOEh2fKen089T8Q9nLQXr/7dS7ECR0nzwH4n+dtUT+dklUMNvS/beyt4/yRS7Gezd9auidvnKwGe/qj+giIy69XxJLtTgTCA65gIq68CB8DTRN4/tdqsEOLzKcOJpAiDQrYJpNK20/yAL1W0B4cyvIIH41dX1aEPeHo63ahA66zeT17MtrDDBGhqWEDH7w32dfe0YrDSqlWkdbgGSK8gaYmudXzEdkemah6YWqvxqSfjJukT9yYKHh+zVSLlwKATkD324w4S1dO/9Y/5rr0wyvlfjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcD4/dn2ihkPk2oZtSfa6fQmDjlAW9p5BXyXrKb4hm4=;
 b=AM831BUpqoqfxYopC0lbQeDMj+01GKSTdEuUAjF9hF0ZDBAZUkL4/zgpWeG4nIOQIqW+eTAvBUvvoxKymgn74789ko7l0bRrxzXw30PgPye668DbR/Fg5L4qLYupbAGoi/6KWsqq2JxsvVetO2wNszkltEDZOIsTaOv7MMcMFq0=
Received: from DM5PR10CA0019.namprd10.prod.outlook.com (2603:10b6:4:2::29) by
 BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:06:02 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::8c) by DM5PR10CA0019.outlook.office365.com
 (2603:10b6:4:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 14:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:06:01 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:56 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/17] drm/amd/display: [FW Promotion] Release 0.0.102.0
Date: Fri, 28 Jan 2022 22:04:08 +0800
Message-ID: <20220128140411.3683309-15-stylon.wang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 395ab543-8b99-4287-b4b8-08d9e2675111
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48889261502C4F29B85603E3FF229@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5C6yRxgqXUE6+Zlj2MZ7x3N5D1ecW/6vPjClGrZzI/PaaeSi/F5R8YEhU/486gxOHKYeR7NairkUQ3wQITg07yd/RcFrA2vfEkuZFXUYsjRsOC2Qp4mgua+sh6/JRVirSs2PzjZdxdbzcuSLNG8HmPWfBvfn3+L+9MCM+i+axoouXnA9qHX1FYTb4oLabJtqYnAPYwsx33aIjQob+ccHsNUu5Zo3snN+XB41OyonrcVgmvwPOB7etj1zm/C+N6eozX/WS5SbyFkMtcj/Vf9wyKWEzwld4cUFb5O0s6YAfrJDqG6ytO5P+vvs659BJiqIyZhOWLFMYPOu5h+pRMvBb8l7iXMsUGTJyrlLg4O53+phW8HoSyqeMbl36iy9mQHZUyQ2yDGHHCbsrLN0RRu5tmCYcYb50Xb7O/d0QPknw9OJUNUkJfbiH2D/6A9ay8Hqf7fmLgdoqcxtnrseHC9xsJ2mD5dUQDBrrg3x4h4Xnq4LUlwMPDx5xft7enPWUEEmMPbYIfk65Bg18ThrDnRdN+REmp9M7RzsXHGtHSzl9SggjGdSZzL92sdrspW2UnlVNiDEE7S1kFoOqH3k7I1bWPKPW0DcA0imO9yO827Ol9/735xmwxqJ7OISijM36QS9zOfe85jsLa1nSOGoYV9+9H1aqF7wA64toZ5u8vV79knH0ynDcv6BgYOEUUiNr+5SFAB4vgDDdtfEARu5id//n7YudR9C/NTMkHKy8fjLdmlWfHbAe7m4PuJv77FHQBRzJ6xGtRQzUW1nOfYUxCM5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(40460700003)(6916009)(54906003)(508600001)(316002)(36756003)(4326008)(82310400004)(2906002)(70206006)(8936002)(8676002)(70586007)(83380400001)(16526019)(426003)(2616005)(1076003)(86362001)(47076005)(336012)(186003)(26005)(5660300002)(81166007)(44832011)(36860700001)(356005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:06:01.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ab543-8b99-4287-b4b8-08d9e2675111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Correct number of reserved bits in cmd_lock_hw
 - Extend bits of hw_lock_client to allow for more clients

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9f609829955d..a01814631911 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x1288a7b7
+#define DMUB_FW_VERSION_GIT_HASH 0xab0ae3c8
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 101
+#define DMUB_FW_VERSION_REVISION 102
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -525,7 +525,7 @@ union dmub_inbox0_cmd_lock_hw {
 		uint32_t command_code: 8;
 
 		/* NOTE: Must be have enough bits to match: enum hw_lock_client */
-		uint32_t hw_lock_client: 1;
+		uint32_t hw_lock_client: 2;
 
 		/* NOTE: Below fields must match with: struct dmub_hw_lock_inst_flags */
 		uint32_t otg_inst: 3;
@@ -540,7 +540,7 @@ union dmub_inbox0_cmd_lock_hw {
 
 		uint32_t lock: 1;				/**< Lock */
 		uint32_t should_release: 1;		/**< Release */
-		uint32_t reserved: 8; 			/**< Reserved for extending more clients, HW, etc. */
+		uint32_t reserved: 7; 			/**< Reserved for extending more clients, HW, etc. */
 	} bits;
 	uint32_t all;
 };
-- 
2.34.1

