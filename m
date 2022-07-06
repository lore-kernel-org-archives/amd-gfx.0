Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB48C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 18:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE03113C20;
	Wed,  6 Jul 2022 18:33:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AFC1139E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 18:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlDJgdpSD7AQvYBOT8cGkOenSrwnP6e6ABs8af8UNcxqaKvsk2rWUz1oDuurpNBD1ggrxxkJSSXs+EPTCnMbqbUdrsuLvkoNzPlZcXTzF+WPK4VOtatn0Vkg8NcyZUStZukmnmc/ctccRVXjPVJuOjwM4ZhbVXH4YoxmLiC0eVcsPmKAd4zuBKk10Now0HyXmDUsKEcFoOKN69rcdEfzl5O1JVB4q57AH3lB/zlnfenp2+fq0blNhUySh9xVzdh7YZder0fCADVPzSGc2oisyM8aqS7c13sd6Ui3MhhteaRAKtCTL/ieBsgffeGXjOzBl9jXQDIN2fSqE8RYJABrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIW1SYilVCgG/WifaDkdAlL/HeNvHqKBnomozQWgGM4=;
 b=KBGZHz7Soy/03ks4KrB08l2RbCuwHTQgKg0eOZs5iTFQcIQL2VtOvrh8LMKXO3X7ZLnDyy2tokv8XMHDSTjSwaoLMCvh1aNInZr7LhVmHYMuM+jkRgKbUjuhEUsyqqY2pek+kCMgt8l+JqjkdHd5YJIpOiFiiK8T/8mInS/qPF5NnruL0vK2vR8AtG4dnbkNDshNj78FBD0Zn6SScGGySwIE3Ljnl4zZHBeB9Vi+tkTqQ/MOabfc/nCDeqmNbzUkbHbo7bEeF3uPwvV637Sw6IycyxmCHQXFUYzU4tyPUBei3EnS97ZRD9NRdRd75ilx5p4o+7OJq8vRza34Fd1/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIW1SYilVCgG/WifaDkdAlL/HeNvHqKBnomozQWgGM4=;
 b=Gp9XrV/kLkzdL6Ovv6SlHEhoxQZuIKsaaWMBeWqG+0JcVis0KBd0YRqx0YAVcBYbzE8ACPOd/7AFoD219pl9SmzjSX/HY0xos7VaRwkAlFuk25wM0v7fJWCPUoTkSWdyTOVaNeQDrGlptyPbmlVTEcCJzNqzaZmVxVL/pNR/7KI=
Received: from CO2PR04CA0065.namprd04.prod.outlook.com (2603:10b6:102:1::33)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 18:33:12 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::91) by CO2PR04CA0065.outlook.office365.com
 (2603:10b6:102:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 18:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 18:33:11 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 13:33:10 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Date: Wed, 6 Jul 2022 13:33:02 -0500
Message-ID: <20220706183302.1719795-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4368685f-637e-48d9-4bdf-08da5f7dfb50
X-MS-TrafficTypeDiagnostic: BYAPR12MB3622:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAHFMMxPq6izhnUe7fM28dWeKveXD5PStbid6W9W9gK02EI2aXUn5qz7pMzpFP7Ei5aMNhP4md13OveHq7L3MXmGVRh4DUpHAxBxKzsFbTn6IrQcitQfGCDLMbiF+gE4j+0AnkGe66bPudL63Kcw6RzQkf5GQGUuO1vZHOEuwwrDOgAHFcDp8IfLpMopY/RU0Qq5mRol9AmHKOsiC8s3NUNKwhp8/+eAGjufr8V3cXWG7HXVA9JIuIlzDcbIcKS2S2KMyohH+DGj3Nk53CIEqb6UVJlxkKe3LDAUV15k9MyecV0JesnHZKLyAJ+tK/iOofmulRUuFLQ1S4ibZT7+XAOYSN1QE/B63qELp97aU5AU/U6A4Nnnto9If62uNwAFj6ViEpDkmk00lJgz10Cto5l1w0NN0ZCYkHkSUYLmJnvwnpr7P9nlLSFzN1Qjkw1o+CVpjiq4/8zj9BIY9ggHH1bx2RRdxd8yGqybi3DmHg+2gnjJFJFA/nrlcrgNnB6+NIDEqYVgVF1kNa0cVAmCZCtZmGe+tqVVzLIH9kRKXz2rT+SADkRFA+DtZ4hCmPEKLMoFBxMbXiyBgNQwiipBR+S/Z2nYdY08Y4Wq7i/IoYxCNxxu1lADvieEtdxC603hw9PI02xEQ0Hxsbn26l3mUmbV4U8y7JgVtGRmTp0K6O3KhT5r86qJxACFLV+B/GZXnl9gbuUTXIZ7iD/pi5V8xPdqi6Mw6zoLR7HIHrCWawcCXWWKm+qrHiiCG/7lJNLs/kqIFqHs2AAcJ21phYQ9Kv6SJT4NIuEQhJ/YyvowJl5svrsQffZzlOG3JWqRDr1TeFjRRYi0k0rW7NQtYlroQE5WAKnvt8iAcemFioxizLPlD+6HWh+kL6/VHeq3O7to
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(40470700004)(1076003)(70586007)(81166007)(8676002)(4326008)(70206006)(7696005)(5660300002)(2906002)(86362001)(40480700001)(356005)(8936002)(2616005)(6666004)(478600001)(82740400003)(41300700001)(336012)(47076005)(83380400001)(54906003)(110136005)(82310400005)(316002)(426003)(40460700003)(36860700001)(34020700004)(16526019)(186003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 18:33:11.6522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4368685f-637e-48d9-4bdf-08da5f7dfb50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
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
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch fixes warnings/error as reported by Smatch a static analyzer

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'

Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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

