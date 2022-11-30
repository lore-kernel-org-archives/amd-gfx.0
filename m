Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92BBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308A910E292;
	Wed, 30 Nov 2022 06:39:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BA110E28F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=midJ8nDLP6v3nuSsfhZ19tq0XaXl6vRtK8/rQtbF0qohGNTD987+z7IPVF9w3bdT/yXa6KKP3Seop9i9yg0FlvVErumbcZ8ky4cTdyGsXdC0ej+5K8GRUvtNUDa0qjGu27AAQSlMh0q9PJeJ+fSiYV+CQRZ480a/WqXVggOwkykxFwWv6uGG7nSkgSbP06Rv/AiMewa1WsfyiQk92BPyIy1oTl8xxYpvKa4edJ+gf2TR3Ea+TzCcAqLpES4kFdS2Lnh7t9r5KIvkDM5W82ytL1ctJX+6rpp01ASdRhr+di3q0lGAqZ0Ahc3snYOO5R6O4VqFm6frIpCYPR2Qt/wo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crfGytAIEgGTYheHNRqE/4BQbMuRzYl3umhWW47T0Zk=;
 b=ZdPre9+fqBhDlImnLJ3UdlHnNK0Eev6ju3EuJdiTCPmBQN4X96CmKZiplrQyIIfXBwIQpYQ6CGD3u/53yklgh+loIALEk7Kv3VKRISpi4qo1KQ+Lqp74MTdAG6DUMBXKdC7vL8soyUw0BWIbBusEYQf+5lJbK/PEI9QNUPLIGZn0fpOPuLHtxr1Rs9A08iF+yUreAGXVpewTr1I3wjAtTCT8GZZb+09P3ZJ9XCFoW85zTgwM3be6tnxXl4lzPCJJR8Fvz/5vc3j9TJVHyFR2FIdZQXTHtSAvBR5TwsqOBAX9OZgpb02MxAn46Icq1C+RA8eUkZoz9vYnm25kF4/KQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crfGytAIEgGTYheHNRqE/4BQbMuRzYl3umhWW47T0Zk=;
 b=C0+2PwUtRdQuO1rHOgL7UD5TA+W0uHQGpzSwCmh5ZTlcfZ/ibL8H5Msl8HumJt0824IvkDUBKZrQJHLENVdhModEhfou+XqGLNDr7hg7u5FpEsYwMKn+Ue484YL2zNqOwQAgzgc6qbGQA5CYRFUDkncbMsUaQ/DAPnKnSkPEtnY=
Received: from MW4PR02CA0023.namprd02.prod.outlook.com (2603:10b6:303:16d::16)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:38 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::98) by MW4PR02CA0023.outlook.office365.com
 (2603:10b6:303:16d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 06:39:37 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:33 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Fix DCN2.1 default DSC clocks
Date: Wed, 30 Nov 2022 14:36:18 +0800
Message-ID: <20221130063627.2398341-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: ce817188-9845-4af4-48c0-08dad29da6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEBBwZyiVyj1G2OOHE1GBAVJO6Xx7ZJ408qGqW8ecrIZPS/tOLRyV3eoUoHzA8ToXfuccECeIGpJbaL9j8w59PPqVBqELaLYJ3zXtpphSa/LNlEb0z2jkNsXtNNU2dbfWp6YxpAZlvOvGkz2cAlpGdYmt+NV2m+oqgsU6Z6w3BbzrxU1ncQbiOt4qWHdRyAM+PR1nVm3b03aQti1Bu34KzLyLCaSjZOMp2EMX+20GM3m/GK1k46ZvYwf0J8wgL1I+OC4Auay05itfe/cneqjdCNvrgh7RaU81jHIcn90s88xBZ4Mxsg5Zspzq5ebfQpyt+AJOvcIpSr0FTgWSIB+NGDYQ066qGf9sPM7iq+HEq6b9LC+Vk67FzWRxMPlbYRngaGKM7WFL9zjOaS7JCV0yId+2yWCx1CSKMdfYH+BCqCoMZwSoqV41gaSiVUZv4H5JtwdkwFNxg0w7Ub7UPpZRyRi+eJrOmD0W/t3mqk/6TPHaiDUA1BzrqUDTCF/fhqnBs7K0qQRVZf2elcw0ML76Zv5UfSEhdFecXS/YM6lbSP9pdSrYy3URlxlv4Wb3FT6cUbKKiqbW86UH6AENz/iSUnCZ9PS3uAxwKhHXbTlmIJaMETQrYe9sruOwdC4Z74tt2ugwAeqHIsQjDeXxkPOgqmwQqWheP3gvnF+bbwIfA15mcm1CEiQ3ftmWTZo5rmvnaw3Wt9PKY6IdR1oQ07us7aWOat30pSHbPKiytZ5G7Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(7696005)(86362001)(36860700001)(6666004)(26005)(8936002)(54906003)(336012)(40460700003)(2616005)(41300700001)(316002)(426003)(5660300002)(47076005)(40480700001)(44832011)(356005)(81166007)(2906002)(6916009)(82740400003)(186003)(1076003)(36756003)(70206006)(8676002)(16526019)(70586007)(82310400005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:37.4076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce817188-9845-4af4-48c0-08dad29da6c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Low dscclk in high vlevels blocks some DSC modes.

[HOW]
Update dscclk to 1/3 of dispclk.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c4eca10587a6..c26da3bb2892 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -565,7 +565,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 				.dppclk_mhz = 847.06,
 				.phyclk_mhz = 810.0,
 				.socclk_mhz = 953.0,
-				.dscclk_mhz = 489.0,
+				.dscclk_mhz = 300.0,
 				.dram_speed_mts = 2400.0,
 			},
 			{
@@ -576,7 +576,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 				.dppclk_mhz = 960.00,
 				.phyclk_mhz = 810.0,
 				.socclk_mhz = 278.0,
-				.dscclk_mhz = 287.67,
+				.dscclk_mhz = 342.86,
 				.dram_speed_mts = 2666.0,
 			},
 			{
@@ -587,7 +587,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 				.dppclk_mhz = 1028.57,
 				.phyclk_mhz = 810.0,
 				.socclk_mhz = 715.0,
-				.dscclk_mhz = 318.334,
+				.dscclk_mhz = 369.23,
 				.dram_speed_mts = 3200.0,
 			},
 			{
-- 
2.25.1

