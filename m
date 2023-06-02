Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B171CC7EE2A
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jun 2023 02:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0375D10E004;
	Sat,  3 Jun 2023 02:18:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58B410E004
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jun 2023 02:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb+Cle+LfiFCob8A5okvUdVk9EQZEo+Y5LaeTPzZ6aXYHkKayhmZ6TD2Xku1zZepLjlrbfly0wL9kWDWaSXEWSmhsRMnov2OtQsznTlX+vXY+D58qbttpJeRRLRamapRfyoZoiRzBUnRKPND0cVAtLrsi/aqUVKf6EIwA2XKya3TaiE6S3fBNEpeQufRypuC0oJOZzLXYr1il47BIFoMoOwwEVGNGm7uEnRZ5OsYbiO41a4TjUGtS1xr85GEKJ+cMWgixpbn8X24M6Nhk/PeL0fxgz9p8swiZD30otTB+66Al2D44DWXy/vs+UIGl+y1331/UmXreeTs+ldS96Orrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1uhqWSc6wSNId41+sZB/nueXlhcTyOWCGMPmf668Y8=;
 b=Xhogl+XKzS0Kf5DlD069gB3wjpOeQxFqdw0qWMGOvmlWsJFOdAAwnEoKftxhSsZFBULJqvoiRvzV2SktNYIcvCEN9zTo6ZCklIuFYyFTvqANQ0l8NlY+O+4rqV3iLHX5K12j1ABr4qtHmFepgfgNOE/QIDwJ5ewWsAr2c2OTE1lZw1x4JCxf5FdtH5LEBSrpmkuSqL2vSjUkU8Y4HtYkLlT5YxLAIQK1V0NCQN1QAF7kQ7bsWrTVTkhipL/CC6OjyRzEPkD4S9CL9+rVlkBz9IJBI4WLZZu8u3FjZDenBCPmkYmn7yJaVyBJzXoZlnYSdIa20fn3Z6Y7w9qIiq7ZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1uhqWSc6wSNId41+sZB/nueXlhcTyOWCGMPmf668Y8=;
 b=UO1co/x7nSKAkkv+OATyZUOPtiu1MLEshA2iF+Fa78qfVJnC7aT5aNwfN7ZRoJDVS9d4GAtc8RURU9y/KQOVfkkW7AEYJN3HmksK2YYsRbQvtRPgGH0sy+J0A1aWBCpW5uGQCI7766Rqim/w031aDgN6ImLQ0+sfC35+OLqRSrQ=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Sat, 3 Jun 2023 02:18:29 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::ea) by DS7PR06CA0004.outlook.office365.com
 (2603:10b6:8:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:18:29 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 21:18:28 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Check that a system is a NUMA system before looking
 for SRAT
Date: Fri, 2 Jun 2023 07:18:06 -0500
Message-ID: <20230602121806.25441-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4585b409-23bd-47d6-a74d-08db63d8d257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0h+Q+67Uzsm9UU/dPVI9Q5ahqJhvjILbAUj/odrcj+BYU/ddH6kcqtfUN6y/JXi/8BZinJyacLzLd53VMYtJBgxMy2gvQzhmWE1Rzo5wRUvZ0S68Pr0vIOd5Gqc+9mXTaeWaUjbm/B0WtMfWWVmdsQ+uDCIB32JOZLgAQpN9r2EHgF+6OTX/XaGJLGitjiLOTJJ2C7ZWwkV9LOLlQJiu4qAdJmDgqWfrOcxdEY5LkO9N56SdWIRQSLKp1ljoRoDsjma+g9+edijX4NSFIy8xv1vh+6SvbvVajyFFkc1AJbCglTwMwaieuZLT6SLkwQP6XH+vjMweTsquw7r4jbeIQkKh94cyau321G6laSGv4Nr6dAULOb5o3SAmDgsChqcR5nJNZ3CQPsTtkYRW4KEoXofpFS+EUs5VhvpV6ixAwFD/xMlAcCEYKokWswGY6ZKTm/csbanuYEj+Q3rX8HeFhiSFMkO33rqboW8Hw+4DqXVqhB7J8iq43iLV04buJet+lio9KzOYPvflQDRnJ0gICpn7sUiv0nJFUAf4Q4FbGqrkDlVQTZME9Y6oEmhl8ztvQD9fDqiGokK7ef3mQ8xGOJ1hesSUj/qsa3n3KEvQ1qnOI5yUVR4NpUSElpfYmJswa10EwCMAHHgXlMAl2E2UXpqnWx8IEsHi0zqa359LKCE8SPhxFjJ54Zc7yOFHkvBVTjCP6c8DOVLDlcTva9jLFFeZHW7TLAJu/DwwE/3cydYzoU9mDE9L0fJn7+zhXdNMfZTLZKdAP4TF7ynDQRP3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(356005)(316002)(41300700001)(4326008)(82740400003)(6666004)(81166007)(16526019)(4744005)(82310400005)(86362001)(8936002)(7696005)(2906002)(8676002)(6916009)(70586007)(70206006)(2616005)(36756003)(54906003)(26005)(44832011)(1076003)(478600001)(426003)(336012)(47076005)(5660300002)(186003)(83380400001)(40480700001)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:18:29.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4585b409-23bd-47d6-a74d-08db63d8d257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's pointless on laptops to look for the SRAT table as these are not
NUMA.  Check the number of possible nodes is > 1 to decide whether to
look for SRAT.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 950af6820153..3dcd8f8bc98e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2041,7 +2041,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	sub_type_hdr->proximity_domain_from = proximity_domain;
 
 #ifdef CONFIG_ACPI_NUMA
-	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
+	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE &&
+	    num_possible_nodes() > 1)
 		kfd_find_numa_node_in_srat(kdev);
 #endif
 #ifdef CONFIG_NUMA
-- 
2.34.1

