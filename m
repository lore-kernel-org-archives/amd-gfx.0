Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36166C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D41110E3EF;
	Sat,  5 Feb 2022 01:51:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC67310E3EF
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlp9HTkL/zo2GHrKQMZRvvca1Fek9vl8mydOv/eYaUVVfzXVqmIz09Mdppb6VTCDEhAjYWhR/DoHcn9sZvrud+kshwACUNu9sW7fBe+IMeQjwG2Gwnqisc473FUQBnIVXrTXdQT5qHpNWOAzW44dula1hfSYLh3OttdWUAm1GPds5E7K4p4cSCp1U4bd3iAfyDdT0VxXw1Wrli/E2eAlHKdNAXubavz3nPD61sGeWMJwUMqiHR7AdjZtd0bQxHSO+ezNpo2sX/nO0arZcFuN+Y2JVgJrM+X7JNkk1eKM9pf60gL6nCTQJI2NfUsbXvNf5C1IKlD0qltRSh/bgOzOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg059U8lqVXHq37dVi0CnSr6LD82DIdc6U7hlU8zZRc=;
 b=lSa2cLUOGivFwo8M+SPFGHja53M6mLCzfoYDUNaLJQ/RIMz0N0rp5vC+18E31+LlxaioEYoWV3UXQ0ELK/hUrvIsbDT2zIFPGUoHJcADu6gEglNDtzpieECZKY1GbEWxrgWlnV5trw9ftCbehR4CduyObR1yiQywFGsoXxpuizJCyARrKUqSCdXQ522nWDfETKCydzVP8mthTdP3YUn9pFRdCUChTPJuzTkxxXVBmeilrzUml0JoJWcE22yx5Dkq88oFv1OAPwdkC3us532LelFv0ZuLKF8YjoudVz3hYcdmZiLxKurNZv12tfF5HHjTivIfpsJfecb+1jWrzYxbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg059U8lqVXHq37dVi0CnSr6LD82DIdc6U7hlU8zZRc=;
 b=EgkZUKAQO/9iAs+OzjiMTMgwaiCV6PCcQj93JOOiEhumoSkiirLA3rW7QzwUtPp9JVTPDepGq5yri/t64Pr6z/c9xPy61U6la9LYZwTXHKjIH3GuNADthRbltyxq2AFj+KtzI1TzpVtqb+18FaaBlfU8NDTvDMz1BmoLUV/213Q=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by BN6PR12MB1426.namprd12.prod.outlook.com
 (2603:10b6:404:22::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sat, 5 Feb
 2022 01:51:08 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::1f) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:07 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:51:02 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: 3.2.172
Date: Fri, 4 Feb 2022 20:50:27 -0500
Message-ID: <20220205015029.143768-13-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cebd1135-1e99-4b53-72fd-08d9e849f9f9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1426:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14266310D8FDDB208A182DC3FB2A9@BN6PR12MB1426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwK860nhD7oCHt0OsOYorR5jqS6jeA8IO9rLh19nlXQDm6ppfbCH2evoSdbh02CJuppO+QqJCd4FGC8+eIzlWG0c+2q/9MkcoxfKdTe2g8fblEFbF58VZ+4CGQVMgNKd9H3X0BhYZzR1Q8W0bAcNVCFUEoPWIRK43+tQWieuOBFM3NFHvKSn7FR6zA5MGqh2kbVMJotqs1kDg1fS5RTZBAf5j41ybHtBn+gcKvI6BQUY4Whp9RRNDX+aoiH1KJouOZmpUNxv2PutwBRS7W1v3u1fuIOE+thFHtLUJSaNG8yg+5RTU/5wFkdzp2lkgFfe7SSCT7ocno8yZFrH74Op9n5S+1iZfV6y1n+iGFTz3Y8iw6YLBHyiQfcaT1SEZJ3aqJoMueiI594gFdp1eRzsNwtlORCOFxmeohXyKJZ53tzP3kdanGKkb6ZDpgXth5dCxr2pRJOwU7RgIEHPVN3a+f4g5jdttKo7vQWjbkajEyL2sxwE9w+bF2ae7cE36kHnzgSkPYucUko8if2wjD7z9TkCC9E880UccYhRReUwd9DOdEsddN91zEhtQEkMX9hR2jL0uNqL9/CszTGAII4yacklERx/XCxBEA/pf4nMsK1lEdxas5ZSYK8Sg+c5jNhc7kZgIkMtFhJpFTtB3KnxMfHhXFCw8NAQw4QLPCUzZ96KabAw3XwEnRikPiDA74QbPxg50tlsI8pV1VC9rePtnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(6916009)(8676002)(70206006)(4326008)(54906003)(70586007)(8936002)(6666004)(426003)(336012)(356005)(186003)(47076005)(2616005)(40460700003)(83380400001)(316002)(2906002)(5660300002)(36860700001)(508600001)(82310400004)(81166007)(1076003)(36756003)(26005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:07.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebd1135-1e99-4b53-72fd-08d9e849f9f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1426
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following fixes:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4

Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8248d4b75066..89ca672866f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.171"
+#define DC_VER "3.2.172"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

