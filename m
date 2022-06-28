Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEFDC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 23:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428B111B908;
	Tue, 28 Jun 2022 23:25:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DC111B901
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 23:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9dWHJxF3Qe954c+Ngg8Q61katROFN8HoDEP2Cge30XqccFH/vwT39WZxUJV5fu8eSJxnADxBVh6Mh0k5Bl1NGNf+OhXfJObK/kCwt/geh+UuJBBDZUNWAbfXgk0/K9/fOhkhXDkNReLByDC9pZUqjRZ3gQArkwfxlv1YYx+ph1mEo6c04EnvdL5kWxvTBBF1ziD6yzPcDJpSB1R67X+Xy1ZreP/ajgvTHbo575fX8Xv9TGlyG/mFpkhvS4AxiCKDTUArULBR24V3fCdBwfnMlaL+VX9bgTo6tPtfRc7Uqt+uFMsdOFxXamyMYgSxUpIURoiitKBr+DSLq0TKFT1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+gPgwUxu4HhIBiLq5FAfue7U5ZakLjBTR5G+K3gJFA=;
 b=ntjKhAKZV84ycJNrEu7vGNjQwbXAejfIo2y+cR6yO6mPr8p1enZn10wMWh33MdhLqUnyXKvTQ6KZZjOgFfDCQKqnjOhBAoVgJkB0UZ6H3iKxLaQgBZbkj59a277FSXk+pLB8wmpvpUPv4RJmZOinWSxnaa2uixL/McUDq/CL4EkxDoi/kJ6GLOCFjxdZhaMMkTVxEXa8bseCVryxO4Rmt0MWiGsbHGauM6Q5ICPbLWGPs1LGODVpa9bER8fuEngFQjl1/el1nNX83kuNqht18Bfv47vPV/eT5QyVMMBhIo8PRPCvRL5RW5V72RgfIAJ8mcYcuzjZNgSD8aNJEkLDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gPgwUxu4HhIBiLq5FAfue7U5ZakLjBTR5G+K3gJFA=;
 b=lKEhMqDWEq1tVK3uLI6pLnsK+6kldZ8uloqPqWyDEmga0j7hrqBGSycc7IN3SHJLsbLeSO2jy9d6dbZJHgpX8PdtaK3M4J6sAPi3FY0Zn/WCCaBFJA1McrTc0z0PL35UOmBSY41b6B6hQUYzZDX0/BRtJXwoGbiKQ98YYy94phY=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 23:25:47 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::57) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 28 Jun 2022 23:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 23:25:46 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 18:25:45 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Date: Tue, 28 Jun 2022 18:25:38 -0500
Message-ID: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51241de0-56b3-422f-4ace-08da595d87a7
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wUdN2jn5mAFi+IxADyJDpgWAhRRb5ZgIA1a2svJ1VHXP6DRmpW34cEnFu894t/1Gr3n8TxM3IOCSYfuAvIg8WVYfcwFoKftov8prOrCxvhapwgi1FH1XL8DVpVAUBDULOgj3MYVZ4h+527cetJYXsuI2qThG5ghHdTpxNoa7RC8DUtKmOyq7328nqmnyEwxrKsUHHwX0mdbwqnVSqbkwcR7kG23ne4JVhEoxiWK7froyY7Tbn0GkukQSh0GaoBEseTPE21bFqk3fu+0IQt9JtXAtcq0aPqnWyuIFLQVs2NPzGeZoxIjzCVpIQO/Xv5XUHaihPCxwYRQH0fgLJ7PtFWUgGri8TE6cFzcKPyYU7BAMfZO180a6SuRfByO1BEswWt+g7Spf2AosRke9f5OHB69J7UHob0FxNJWKnXCJ2f3592t41WGgfm4qDDfEBT0yvoh6KmZ0YSFcGW2XvtoIdhfLzZRf42wshsB5QIrHxh5Qk9CD3s0jbsFF9yS/ThyfWRNEyzaP3iDrF4ANCsNXiiMfsYCna97nGuJOIdS6Xnd6ZpsE1AhcKdkUf/q0lltC7Ol8NusEvWN3d/Jeh6Mioyhp4eezsivJnDJVA8lwUCeAKoVaSGsVQ/MJgZoTBUwI1hw12MmdG69OeXMtSQYydCnW57Ka+AdmSa3JqJU/mpHrMkS3Gmopqfcy2bDga6yl2FXwLfHBz3+nJfkXdLJJzJo3bhh9+ehhfNQnRnO7G/6dIJ7gVDTmzYqBE9Lr/1oQt9MZjb8Cc0qE5xePA5yHZmDjbM3/7LJqzcaV0IVMdGPTIgUkmRhlMVFpRNlmNKLmrR672Z2CvCt3uCWOun28g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(40470700004)(81166007)(40480700001)(8676002)(2906002)(7696005)(4326008)(110136005)(5660300002)(82740400003)(8936002)(356005)(26005)(83380400001)(316002)(70206006)(70586007)(478600001)(36860700001)(186003)(1076003)(40460700003)(426003)(336012)(16526019)(41300700001)(47076005)(6666004)(36756003)(86362001)(2616005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 23:25:46.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51241de0-56b3-422f-4ace-08da595d87a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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

The patch fixes couple of warnings, as reported by Smatch
a static analyzer

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 36 ++++++++++++-----------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..9d7b9ad70bc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1417,15 +1417,17 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 
 		/* find CPU <-->  CPU links */
 		cpu_dev = kfd_topology_device_by_proximity_domain(i);
-		if (cpu_dev) {
-			list_for_each_entry(cpu_link,
-					&cpu_dev->io_link_props, list) {
-				if (cpu_link->node_to == gpu_link->node_to)
-					break;
-			}
-		}
+		if (!cpu_dev)
+			continue;
+
+		cpu_link = NULL;
+		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
+			if (cpu_link->node_to == gpu_link->node_to)
+				break;
 
-		if (cpu_link->node_to != gpu_link->node_to)
+		/* Ensures we didn't exit from list search with no hits */
+		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list) ||
+			(cpu_link->node_to != gpu_link->node_to))
 			return -ENOMEM;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
@@ -1510,16 +1512,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
 		if (cpu_dev) {
 			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
-				if (iolink3->node_to == iolink2->node_to)
+				if (iolink3->node_to == iolink2->node_to) {
+					props->weight += iolink3->weight;
+					props->min_latency += iolink3->min_latency;
+					props->max_latency += iolink3->max_latency;
+					props->min_bandwidth = min(props->min_bandwidth,
+									iolink3->min_bandwidth);
+					props->max_bandwidth = min(props->max_bandwidth,
+									iolink3->max_bandwidth);
 					break;
-
-			props->weight += iolink3->weight;
-			props->min_latency += iolink3->min_latency;
-			props->max_latency += iolink3->max_latency;
-			props->min_bandwidth = min(props->min_bandwidth,
-							iolink3->min_bandwidth);
-			props->max_bandwidth = min(props->max_bandwidth,
-							iolink3->max_bandwidth);
+				}
 		} else {
 			WARN(1, "CPU node not found");
 		}
-- 
2.35.1

