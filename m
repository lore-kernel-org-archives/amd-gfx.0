Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA41C46CD3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 09:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325C110E15B;
	Fri, 29 Dec 2023 09:43:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BB710E15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV26v+nxTjZIW7WNM602XtvhcNnVqsZZNnRDtUgbklO5FmQz2u/ZMuifOw44YgkGVWwbyNtqwgu52i+R7RSUbuO6JkdoGMAEkjFXYD3jxzhLLAEBLkZhBItFs/lrQ54FY1VePjfAQFP0s41snfBKE1wXXZyqkTxnwp2MymWrJQr2saDfJ0y3yNkGUCit7ctY40sTey3Zk+wCucaqa2Roc920+3uHf1sogQbquYuxrjeTP3hGdNrsjLWZEhq643ebZFf59DjW+5D8yPm+ImbYRdWPgUcgXqgocukGJ4SniZzRU2GofQUJt3K/2/Y6f/vNyP2qf6nvoufAjld0sJLPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbyhMRhMcAk552Ft8QGPgRuoe6y0LVAgI/i3eob+ROQ=;
 b=C4RuzQXVklShH+xpa8uvxnvQ8u30h8/qJhZNinz+Gv6p18y4OZ47K3tlmxE0li3GwGdO5Z6lMrjsMmyEfLX8unwCpWYG6nsIwIJa+A2RD4SeNgIDZUfWYuhRosng8/W8E3HPcs2HUxiqprgINxQ9CPslktFME4f+jr9RslepuqyvT9P2hLjscP8Z7b9RlM7cEWBD8qY3NdoD3VhB8qehHPncc9qOETPIF3HrU/EtMvJSFbe3BgZLfvS6CG6KO3YSSP0NacQ0aAkew7E1uu50z6w8k2NYc3Bjn7ZFHLSvoj0jXFgyajjfhj0eWgnfHHhc1JsUbwFFgmwvpeIyTT8g3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbyhMRhMcAk552Ft8QGPgRuoe6y0LVAgI/i3eob+ROQ=;
 b=tqoPfqyOuySaYknC295XByffcjBW6Eb5tJpfcANvnmNPKuFJFrKjRDu7OwzqLXiYauwp2TcdouofzJn00kA0uqdFwjaowEJgW0rTFcw1aH72thF14VVXn5kEag8gVcLd90rQoQeZ2RMRevvXGTeAhlZ/lGOQhSvnM7KF88uHqZU=
Received: from CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21) by
 MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Fri, 29 Dec
 2023 09:43:50 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::8b) by CH2PR05CA0008.outlook.office365.com
 (2603:10b6:610::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Fri, 29 Dec 2023 09:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 29 Dec 2023 09:43:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 29 Dec 2023 03:43:47 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix iterator used outside loop in
 'kfd_add_peer_prop()'
Date: Fri, 29 Dec 2023 15:13:24 +0530
Message-ID: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d3abcc-fd92-4a4a-8fff-08dc0852a926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWvUJzTpiNyL+oKBQBjFOJK09v7Gk1gSV0xzIP3yCr7jJtybKFc8qDt4h4+nwWa/QLeH63uRW8LyVhEgNwKTV/lDKkLkaeWM8mBiEAKvcRgRFlFtTC8nBRUXg9fQvARkuhQ7mm15zR/ztDmXjJ5emhio29TK44LXdDeN1MytoeK7zfQSmiNds+cdyaf8lPV5WXjf1KdTGsykjEyBN52/+S3UPpinlj031hkEYz76Nef4K/qeYZt8n5mz0M4nsMnrBqe3iuaEx4IVq77ewiJIxo777Nm/mFfBU3Fb3ZubQQWG7pIEHp8CH1l5TfWSr2HT8I9kQC6Hdf5Xfld4nKHTAlO0Cya0Qnex/b1BlHaCsoLg5SaP0R0evL2y2pQLS813SyqAyg435ZNdqpAEGBmmf3oFZo9qUhAsE2vbJtp8Zj5T4HPSfBQAEXhY4ctYeSMkhiMpAHMPPbTThWkY5H20aOldh0IN2XUI4zhs8OWRxeWa5ENkc3oyrWGgmQcGZ/02zIcpvMgsoW2z0/AhC3DFrFVAk+Gpdxah+sPAKAtEhyVgYpcwZX+cGuFy+dqavc5534JJgzcR+7SKugAGDj5xGMqqqzZRwV3iVbtJlx5hwUm2VPVQ7Rbxf1fhINzUsIRkuD58iyKy5V/UhxYPIS2vWwGorpTLNzXkFVBSWGkbhL18SxJHKC5y5sib8/lZ/327pAEFVXXY+u2VS5hjuXhligZnkZfoWTOsS3Ikj+GXjQghB7f2STV5GMR/lHlv4abJ3JwJI4lo0cIvDKb+o0vuMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6666004)(2616005)(81166007)(478600001)(36860700001)(82740400003)(110136005)(86362001)(41300700001)(70586007)(7696005)(6636002)(54906003)(70206006)(36756003)(316002)(47076005)(8936002)(8676002)(83380400001)(2906002)(4326008)(426003)(336012)(356005)(44832011)(16526019)(1076003)(5660300002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:43:49.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d3abcc-fd92-4a4a-8fff-08dc0852a926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following about iterator use:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1456 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dc7c8312e8c7..68640e46312f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1449,17 +1449,19 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
 		/* CPU->CPU  link*/
 		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
 		if (cpu_dev) {
-			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
-				if (iolink3->node_to == iolink2->node_to)
-					break;
-
-			props->weight += iolink3->weight;
-			props->min_latency += iolink3->min_latency;
-			props->max_latency += iolink3->max_latency;
-			props->min_bandwidth = min(props->min_bandwidth,
-							iolink3->min_bandwidth);
-			props->max_bandwidth = min(props->max_bandwidth,
-							iolink3->max_bandwidth);
+			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list) {
+				if (iolink3->node_to != iolink2->node_to)
+					continue;
+
+				props->weight += iolink3->weight;
+				props->min_latency += iolink3->min_latency;
+				props->max_latency += iolink3->max_latency;
+				props->min_bandwidth = min(props->min_bandwidth,
+							   iolink3->min_bandwidth);
+				props->max_bandwidth = min(props->max_bandwidth,
+							   iolink3->max_bandwidth);
+				break;
+			}
 		} else {
 			WARN(1, "CPU node not found");
 		}
-- 
2.34.1

