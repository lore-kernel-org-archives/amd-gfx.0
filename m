Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BAFC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 11:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7E910EB75;
	Wed,  8 Jun 2022 11:37:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC2B10EB74
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 11:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIbSRDxyk79jbqTfhhfNfm4JsxONXd5FPSCjZVHeafbfcFUaQMFbnNdY5cfMgrx+CvJaeGxd9dk10rQpAVN0l/ZzfKCg1QPeBAIL/x1uUQRY9Ra1pkLrOOq+QNnxVXmhXTqihtTS+EtYsRG2n8fznO0O1FTy8756K7az6nKCrP56l5zOw0EmBP+inqwZcliFKSnI0K2QHW9RXzcToYfTSzG9Df6fQTQVJMf6bNz8qykSFKIvahKiVKwDRn/NjuX+A+tmHyTr4LB+ck5fXgVbBVxEUUA7KS3D+b0nbyAQuCZmzMO++fR7ieWPUQf01Ro8mGho4HLlSfA+Vs5RTZWd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF/ROjiehNovLMUHSxN/Q6zVokokA89jdNzoBxN+1ow=;
 b=Gl8/C1i6v6rZNuZPnCoyjuT9t/lHUFhHP/5e5SRiUn7GE6fqxDBIAAgqJzu3LZPMxLmTi5SEmztY+MM/T9a72SjPn5hdf4xjZWOnUcHSuhrqw61tSfBS32pvWcGjAN7FfSLdJzCmqkjy/0lHHhWO4ZlzmM9SZQYiwGKCUm7TSP6VMDMrJ1W+yAVEjhiWlgw0i+KM1Q+GHoY/rtp9BEZTJuvY2eQnyDG9eOHnHtIjAQ/ehlXzCKTUc9qgbi3ajEzDqg8wHfOYJjlah2nY1FqTtF5uaGsxBDEBS3HfoSmxpZbVDZyQQxErzORQvl9C4NWD8XYQsbXLwbmpzlkr5x2rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF/ROjiehNovLMUHSxN/Q6zVokokA89jdNzoBxN+1ow=;
 b=dS8w3OAm1hpK+WMQXUxHnxD4/U0gka4B17PMEjXgMHeXo5peCxpJfR5WKnT9p+d508oEAw/wupw4M9b1PXRs1OD9TsqwUCwLy/kB3y6wHUDeAYV74uf6oe5E78Kl087dBSUJXVQYGnIVPHLeRCx2ZXUIc2Fq7qa44kyZAe+3Ay8=
Received: from BN6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:405:2::34)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 11:37:29 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::59) by BN6PR11CA0024.outlook.office365.com
 (2603:10b6:405:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 8 Jun 2022 11:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 11:37:28 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 06:37:28 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove field io_link_count from struct
 kfd_topology_device
Date: Wed, 8 Jun 2022 06:37:19 -0500
Message-ID: <20220608113719.1483269-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d30f667-98c4-4731-029f-08da4943448f
X-MS-TrafficTypeDiagnostic: MW5PR12MB5649:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5649B84EDEFFCA908D020172E3A49@MW5PR12MB5649.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0bGBxXOIaxNzRDcJ6iY6QYz2ueHnixNKrEB3C280HyHY5gXMipuEZIJCvh8Jtx7J1rIpvGS/ket32Z2z3K8FEvpX3Msg4FvhFoq1OREwPa7xI9PVVAL7e6JiarS/i2tdWu4pa4PWT7ZOnBJJkheTfJpg4ikg5tgyW6aHx1jO4PRT+t81wV9HzdX/hxDM3ltvPGD17OJ0qGRaXobdOGc/jfVsO72T6e0HA3ZTwRdKYxa8ihIM7SLw2SbdrMOgqgAAeI3EfSHP6JS+P7Pf0o0lq7raMOppgf+04wAT+FCleSeDnmPn3MRenRiCSzz5zqtaJO1VUKbuvWBnn2BKx2HhCHjNoV8onCTqFzLes0BNyrMjfLaIrsT4el+hKa1letr+fNmBtajE46fy8fhJAjIVwMQCzM2t4gG5AYhyQZUjRsRB0eRJoRH2W7rWOC78deNQC6GEAKsFoWrceNi7HP8oIpBdNyN+RSy/FpD4FQAGJyxaXQO4yQv1AhHflCQkWBMoDC8UZSLQMfBL1XDrbiyDT1v6xjQeWbEubeTRb9dny/CtBRxLJ4n6dor03xC38CxsE5el40pRlUWPhYwxC4bcKH6VjuY3u6AuMgCltdJdo9CirjA8wrIocFtSHe21bSvNQ8/bb7FT71AHfveIRX8wNJwo492ywLAiYqYl6MI6R5UXKDKBUKMShQi5rgvQ6WWSoXyjda0huZX0EqFlvA+iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(36860700001)(83380400001)(356005)(4326008)(8676002)(6916009)(70586007)(70206006)(81166007)(36756003)(86362001)(426003)(47076005)(336012)(186003)(16526019)(2616005)(6666004)(1076003)(8936002)(2906002)(26005)(508600001)(5660300002)(40460700003)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 11:37:28.7581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30f667-98c4-4731-029f-08da4943448f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The field is redundant and does not serve any functional role

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cbfb32b3d235..a5409531a2fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1040,7 +1040,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			props->rec_transfer_size =
 					iolink->recommended_transfer_size;
 
-			dev->io_link_count++;
 			dev->node_props.io_links_count++;
 			list_add_tail(&props->list, &dev->io_link_props);
 			break;
@@ -1067,7 +1066,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-		to_dev->io_link_count++;
 		to_dev->node_props.io_links_count++;
 		list_add_tail(&props2->list, &to_dev->io_link_props);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3e240b22ec91..304322ac39e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1819,7 +1819,6 @@ static void kfd_topology_update_io_links(int proximity_domain)
 			 */
 			if (iolink->node_to == proximity_domain) {
 				list_del(&iolink->list);
-				dev->io_link_count--;
 				dev->node_props.io_links_count--;
 			} else {
 				if (iolink->node_from > proximity_domain)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2fb5664e1041..9f6c949186c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -130,7 +130,6 @@ struct kfd_topology_device {
 	struct list_head		mem_props;
 	uint32_t			cache_count;
 	struct list_head		cache_props;
-	uint32_t			io_link_count;
 	struct list_head		io_link_props;
 	struct list_head		p2p_link_props;
 	struct list_head		perf_props;
-- 
2.35.1

