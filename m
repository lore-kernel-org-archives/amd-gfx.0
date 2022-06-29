Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9155CC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 17:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BBD10E08C;
	Wed, 29 Jun 2022 17:04:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9505F10E08C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 17:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azHGgeqxmYR7X3b4ogvGQpDl/3CSirmBr+pAERQP7B14p0LOMe5HesPmBk3WKdBTKcFcx6hTVAloXO4Rzjb8kfLjHBbj8w4PwpnQaSdk9kivDNFMtp/Qz6o0ObIDkzHr8EhQ/1ObMq5QSqDpAWyyCRBUWlvwU6/ghyfgA5XoILBQ959luu4ZMTrg/RoipBflD+1zpyCNN/6aUpHqZtXLcvA1hu6rgpzM8SZEL5GkHXzYW8VhwDz4FbJd7cnMwkEi1cyKNlSI4l+1nUmTe1MHi6Eo/R4hSH2GsKV9aZvCvVNrWPxeiOuPjuEH0d1Gj3spXU277Yln6yoS9hNH2LMHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYXeaq1fu5PLPTVl9Z2FOd6PUIyDfgcKzf0t/yU4CTI=;
 b=hHqiofC9DQ6bxuOfStsarN42oHNIFLOc1rFz4ElrVcmrLAsfHZtFssz6ZLTCKnJRDWdxepIW5XuhtM0Kf820o/hjpBxmMOHEOoCF9cJPM9qKa2RezhY/28+nZ5BqGY5bvpdMxLdzH1y/lB9WtsBtZ86SgQG4KbWcZ2hdwiawy5jE+vIlDcu9Wdzhq9TEdoxtzJnRLJcflRdURF0I6rPO0ITnyrjRN3MBvdGMgkRGhDBBA00SWOWePfiS037/87pDF4gXBo4AjznqSUwCjGR8uOJteR5S7rWhYxnUfJk8MAD2ciz2Aewic/Qu+tNfvAI9rnz2P323cIwf+xmLwQiMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYXeaq1fu5PLPTVl9Z2FOd6PUIyDfgcKzf0t/yU4CTI=;
 b=pkZj8D7pEtWKso9i5IfFWJSj6PNUUh3Deq8q1k8H+tHOh5cE4PN8K8cpo55khipw8kiiBUT8Vx9Z8sigXofqGgd3iDOtiCfMFpoDm+gMu5FPk/8cgJriNhfU3LtfveRQyaGwtM2aoxqwn2ipLDzyfiqCN/+hXuxXiTcSKFM5qq0=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 17:04:28 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::f7) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 17:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 17:04:28 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 12:04:27 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Date: Wed, 29 Jun 2022 12:04:19 -0500
Message-ID: <20220629170419.364255-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e535f27e-e60f-47a8-0fb3-08da59f16d82
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPKOz6nzqLVUUzS/+5gHPVWVuF7jXie9sOC6pJD5FwPH9lr1O5FEdVsj5N0CYA6qpm3JN460GE39mVa7+KfCVCBeE7XfNfvH9cRgx6B7IivU2jBSkcjZUawBlTysDp6r3HMV88f3jR1riWiBEBk2W4ABJYE6c/ObVxTvrxaA8z6JHdK/qUCqSxOcEnSB5mzXHlmnfj6qnsIDEJywVjIeE64HqayAKUFPbLG30x3PVoNyhHOU7YG2PU0Lutp8zbsVESwHXdpoXJ5JX6FGKTvfg0CCrKfgQHVtiuFDrnmxjfYeSUgIzeoHs0miiqrx0iqD8vN5aQ250zafcUOXcTlmq/YuMXiz+YhaDGXkuH+ASUBXmYFlK0g7De80p1nSi82hxMsUSH9KWvD6xcsktv1L3NQQifKQ+SiCeHJ9L/d+E4N17DetyxgO0uhgUCx8/mVxCcCXAV1r1ClgxlRnIjTIV/dHT/SsGZjGCVla4aXlukHkxpqVe1J+mSugVeTLXOqsAev3alHWa92ti8mL1djIHI6m51wJbnR2DEV44Vvk727DOFhe67nKUwMbPOffOEEd7ddIXvUn5AU58u+hhnaGb59z2lySbSUfhOxRBQ1WnbmkiwRTX1oAZb2LbQkO1rC2Ypq6OERtrau0fe07/iw3mBt0LGhxUc3qaBnpskMqCl9nH/y0bHflhSQgTPz8lhZvIrwpnrL4ss7nWCm1cJXZBstgrDAPqiQ6x3EWdhK1E2X2yFSsxBn7zeguns0EWtCdEbNQCv9G13atS/HubnOuyuliGPO+/uAlc5ApUqko6pLN0+3MUAsKNS+GtHygckl1IRDrcQaGugklWmjAcE2Htw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(40470700004)(16526019)(1076003)(47076005)(426003)(336012)(186003)(40480700001)(6666004)(8676002)(110136005)(70206006)(70586007)(4326008)(26005)(2616005)(83380400001)(7696005)(81166007)(356005)(36756003)(82740400003)(36860700001)(40460700003)(86362001)(41300700001)(2906002)(316002)(82310400005)(8936002)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:04:28.4639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e535f27e-e60f-47a8-0fb3-08da59f16d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
a static analyzer.

Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..ca4825e555b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1417,15 +1417,15 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 
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
+		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
+			if (cpu_link->node_to == gpu_link->node_to)
+				break;
 
-		if (cpu_link->node_to != gpu_link->node_to)
+		/* Ensures we didn't exit from list search with no hits */
+		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
 			return -ENOMEM;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
@@ -1510,16 +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
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

