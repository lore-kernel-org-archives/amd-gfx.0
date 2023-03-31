Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74052C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CE610F32F;
	Fri, 31 Mar 2023 22:39:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D8C10F323
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgaE7s2ype9t0KdLqhovI1CmhOiNRvITLk66eK0us7xMvGHSiXbdV7fCDAhn2rtT45XxihLgl2tMwgZFinMqNAEp36LFUpoZnLafDpiBk2eXBkOPr1LBddgbOdILIWhxoedj+rqbb1UtddeUEQ9dJwBYRgGoStAiJo5p2MYoaVwwQUDEp89PGa885vgt8dlzBVW3Ml2SlxdX6bdv1CwQkugm+AT/QcdMEqsIGjAqGaYN43nTeP04gpwY7RKynq2qdqIfSgSwqpISIafQ7uJmwFP9qSX2YvqqChcVEQFt/Dq+v11bGwqaFt/jSU+iINRDiFQOXVRPX5M/liRtImMF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLZfMhIsYbdMHM22nPnq3Pobkrdg7Se9fziKdGeMk4g=;
 b=TyeZ15k4CjhwHTspDF0h92IRt9H4Whe2hljS3alH+lpeTpsZ9iFDT+hCqr7gLxuB55IAMv+S/UjlwJPPx81rKi0GP2BRxl54rNZPbYbo/tFR6D1ArNBczbElzza7Xsn1R9UNG0QIKDSWAggy5F/qFmfcW6IWjB7QiDaR6SKxCjjuE3JuZMV2qRM4M8k/8Ka03pLuf1i1vvGPSO29EKq2c72fQBrMekX9qURBI215GFgdh2kqWjqcQtxnZ2HJnUO/ny9Re0QNF/uu37+bW3cMu4BZjeIRWYrjptXvBONYt+XQ8HkCn8/bZ7pHVB9fVPyLMv6DZuTSp2jzO4Ra4OGrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLZfMhIsYbdMHM22nPnq3Pobkrdg7Se9fziKdGeMk4g=;
 b=qbqLzMVwQ5Jnm8Ffp9MM68dPDWUecIfeOgPU8jHcqIIQuB8eCcbiOoETaTXAOVU+QIJtiYLBi3b36+PCN0uI2PWjArzznzOwHiLKCEIvrN3jIvlIlYwNq+G+LXlpYlubOoxwHox0fBm1gH/Qx9OL7+OiurWJEQlf+TsajZ7RQyA=
Received: from CY8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:930:45::19)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:39:42 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:45:cafe::42) by CY8PR22CA0011.outlook.office365.com
 (2603:10b6:930:45::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 22:39:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:39:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: bind cpu and hiveless gpu to a hive if xgmi
 connected
Date: Fri, 31 Mar 2023 18:39:24 -0400
Message-ID: <20230331223927.8388-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dd7ed6-3a2f-4362-139d-08db3238d1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0W+Ko03A8WOaGphCgyLT1BEMvMl30fBIEzr8ZK7DeG6uUMPm4GylONfkjAX+bhUd2Xqk8oT78W1k8BATJXEXjUo65zVdBlEdq5THHAMt+V+7ZOlttS9kRA0xMS73iDglR8l6VkJIi9WWOvD0flNL8bIMvXgmHU+riRRoNVID0PeyKNW8aGcWbtr7b6josRMm0n2OIj+wZRc8f9IBHJgNCP5KHkHabVYUlOomnd9bxjGLeydSHCQzMMMCgy5mniwi1fc9JcMqh/dafl1n5P62Nku6umh7P1FMHOlQ9U3nqbT6YtcOnzoxhXmOlb2XQXomMIjLhRc24k45jHYHFd+cr1g5nx8y3H7YjrdAVOwsCFGW3POCTms4pgrUyNuYkGNEp6s0lAXUWom+CCxSVrjfliZp066qUd5HzxO5RlmZdJHHkOUF9MW3oHGH1a012YvNLdMTnz+e38w3oxJXx8ueIjnma4HCjzcmePmWnYH0KndYFXsUaVte6ZdUnb7DHSKXgUOQCKqAz+F7BkLZohmMkOY3J73V6X9WG9TDp0vDldpyVj7gkx88R6MUzPOKHR3XMTOVQZnrAakJMKVx28knLdezmNHFX5yq62EkT41FteFTnD9pkQmydqICzmxW+i2hBpr+Jy4K0NRuSGFlYGn0k+GX0Sz6NrHmzpSL2QJZ053kyVixnk3fXAjcHyf6cbcEnmZEnu0JjAozTfxEQr8fWcEXiUiz+jwElzzLF3lCIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(336012)(316002)(6916009)(8676002)(4326008)(186003)(426003)(2616005)(16526019)(83380400001)(47076005)(356005)(54906003)(478600001)(8936002)(36860700001)(7696005)(70206006)(70586007)(41300700001)(82740400003)(81166007)(2906002)(5660300002)(1076003)(26005)(6666004)(36756003)(86362001)(40460700003)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:39:41.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dd7ed6-3a2f-4362-139d-08db3238d1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

If a CPU and GPU are xGMI connected but the GPU is hiveless with
respect to other GPUs, create a new CPU-GPU hive using the GPU's PCI
device location ID as the new hive ID to maintain fine grain memory
access usage.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5373a79ac6a1..c7072fff778e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1328,8 +1328,15 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
 		/* Include the CPU peer in GPU hive if connected over xGMI. */
 		if (!peer_dev->gpu &&
-		    link->iolink_type == CRAT_IOLINK_TYPE_XGMI)
+		    link->iolink_type == CRAT_IOLINK_TYPE_XGMI) {
+			/*
+			 * If the GPU is not part of a GPU hive, use its pci
+			 * device location as the hive ID to bind with the CPU.
+			 */
+			if (!dev->node_props.hive_id)
+				dev->node_props.hive_id = pci_dev_id(dev->gpu->adev->pdev);
 			peer_dev->node_props.hive_id = dev->node_props.hive_id;
+		}
 
 		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
 									list) {
-- 
2.39.2

