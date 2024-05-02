Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B340C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 01:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BB710EA0E;
	Thu,  2 May 2024 01:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uq6w8Sa4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1516B10EA0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 01:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH7plMI51XQWnC/Ab79c0IXcV4xHKYSDiL0KaXbX8ksecRYBstz5jDkV3wcJbL9jOgphAWEwh/nT3DhrNJTGUaXqyKWdMNXinEKqal7GqxwRANFxnPJ2OvnQ0bk14tZvntfM062OWLTNryB2UJfoJawrHmptUKreI3gDXmoHBcQrst4tuVSn6w7us9XPzxD5UDaiwkfduisFVAM0NHBmG04mgkVfDjPtecQSuL4g69+IjrVLeb8Bjzdo5DzjLjSvlyJrrlPd7ch/U13cPonNOTWeKMHvfRKJKSi064YgjZ9b3J2tKKH7PqT0GtHamFTkD3H71FVPrfDqubvCP8Xw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIUMTkgGShcCsvsoiO5kCCAH5pll/tfqtxtH1o2rMGM=;
 b=aieN59OjNFzw3uCqyszWlpG8JWC42n8pQPQSO67SCpJcpCIB6+xRuNp9iI0FU7LbZZleWRzlYa68UykTo1Gs+OBCx2Npdl/GnIp+HZQosXrTABoagV92tQX2O6Z2a5L1SejbhGAAnxuEVgow6moWwoOM9Leu+2MQdffu0zdWbBuWTCLOjg3XJVZn3m0DIgqM1BHt6ES86tVRkCB5bEmvDKd1HiW0KmYwEf4ziV5abggDJrYec7kttnAZj/FEjb7zIUWKoPfy/jfQI7sYDrFOWJ2JM/++j0IL4DJqYSLIqSsZkhDqQIIB8PLDo6wzP2wDRd46V1wIxPvRegUCCbScfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIUMTkgGShcCsvsoiO5kCCAH5pll/tfqtxtH1o2rMGM=;
 b=Uq6w8Sa4Vg3xVcRTXoud7wousg+LO5U5O9Lw3xE/MXj7M/NnkId1BFNlZt/WLSJqMOUTz6uaDsubcNxlv5CEZXlniN4t/49M5wA+FqeH4saN6NJgfao+QfVHfqQCPREjz0+IauLFknGYqJLemFIzVvohkUZlAhHK/VBO+P5LuYE=
Received: from DM6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:5:1f4::45)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 01:08:19 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::78) by DM6PR02CA0104.outlook.office365.com
 (2603:10b6:5:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 01:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 01:08:18 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 20:08:17 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Use dev_error intead of pr_error
Date: Wed, 1 May 2024 21:08:03 -0400
Message-ID: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 779a6dfe-6a60-4480-ea02-08dc6a445a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k0B89jNjD2d9rHLpZJX+VGwTWxfkoyR0Pk60BZTO8hCstu3kJGXVUkncrQyM?=
 =?us-ascii?Q?YJjWyjkLQ9nzAsESJU3xcKfHoV0rACybROLnRO9DfHn7PaMpFZY895SsifD+?=
 =?us-ascii?Q?+p1RQQ5raiRflR1Sqqz8QewdysGiAwH7BRubB3ALKdLB888sBdYIEKfkLsHj?=
 =?us-ascii?Q?tj2T/cSVsyOHFEU4SbLlpO347HB8Pv2pI80wB8LkEbWTnfC/8/sr6JYvUeKU?=
 =?us-ascii?Q?R6Q/P9yp3JQrkADJ9INdcV23pDtXaJMniOD2neHjtpVZWdGnZVFf6eoyM8Gq?=
 =?us-ascii?Q?oSMF58VcgRF7oKbuXw+lbImHUupjjU6+I2kxoQIysl4H/TQl9W34IrEefBsN?=
 =?us-ascii?Q?HW+oCciV2l5YsBmSOxJlLBBiuEkDImReKcOSqZty3ycd/Ns5tM0P2ocwSM+D?=
 =?us-ascii?Q?QDgFP/jjXOgkEpgtVm6KeGLG6VCqpSM1hnpEl/E2qmarYnJLi0cV//wrnCna?=
 =?us-ascii?Q?eTm4LGJWRRIGuNrdSpLPpi1UBGQNsDCAcRufNstQQbnmPcNz2t8BEdALr7rZ?=
 =?us-ascii?Q?yHlGWTmvRQDF07UNp7LV8YXYtvX6m9oyWwdMILQhhkc45vpEn3k2OihXlpDk?=
 =?us-ascii?Q?wRfTx+Z4nV6IppqOgVY8d5xbvpq8VeDIchIZRvIZMLjvsU87jnNFz4BOHfNx?=
 =?us-ascii?Q?MgGsRjKVKxGlPclLh4tApXkGhAt3RmDG5xUMEjVVrVeii+8UXnRbNOfzLHfA?=
 =?us-ascii?Q?xDc179LXmfIYqhbJtlfI8mCTUBBL+fLTa8KDV3/pneApBatFIMh/uMXUGqmG?=
 =?us-ascii?Q?ZRC5LAfsSUxiNYH+0QXax7t1G7GfCdDRxPXHPMqe1RPne5SW3c1pXFgLtXw4?=
 =?us-ascii?Q?XF4tP9Wy0QO4arWpOU/WpjFaJPSOYg3QrCfrZ2jAztlnhl+qIHI9ck0kcltZ?=
 =?us-ascii?Q?ZubEVSUgn9dTJbRtoc04pb6FK+PjqOaPXOClM0VmcwFiCpGtluQm2z8y9j7F?=
 =?us-ascii?Q?0V8h/IAHP1vI9GRME+qTLE5tbO9jh6nMqQSKCjjMzouJe1D9G4Y9R5RchZg7?=
 =?us-ascii?Q?0DdBtDodv7s7/ckuYhwHz/jbRBsD4j/6/QN3xZJDsaAiZF7na+/m2eO/ZUeL?=
 =?us-ascii?Q?0ldOQTcL5SMGh+sUyWB2feoqUWfb/+loybaMuy6WQzkz5pocN/vaHJ2JnVe/?=
 =?us-ascii?Q?4T6HSxWZRbVT+GDzwLnW3Y2cANw3kSQ7apPSLlh1eYacItS2Y75QpgEo7n5v?=
 =?us-ascii?Q?nUUIKLFhbHinftO7O0L47XqrU+YP/0vIMTWgtVklFz92MQucBv+C6mmdRetO?=
 =?us-ascii?Q?zES7u+Wv4yNWD8AZGqs3eCISdOFGljqfaeBByqR3qkiQvhc4DMkeCp4LxDPY?=
 =?us-ascii?Q?Br/Pt9a9F5Ftjut42z073dXTESRi26uGSqX49ZNWuoLBljyfzcUXYZhauV90?=
 =?us-ascii?Q?SM4qotJm/HTROFhwgDTtu6yJoMEX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 01:08:18.1937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779a6dfe-6a60-4480-ea02-08dc6a445a28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional change. This will help in moving gpu_id creation to next
step while still being able to identify the correct GPU

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ba326b43bec5..b93913934b03 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1773,7 +1773,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
 }
 
-static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
+static int kfd_topology_add_device_locked(struct kfd_node *gpu,
 					  struct kfd_topology_device **dev)
 {
 	int proximity_domain = ++topology_crat_proximity_domain;
@@ -1786,8 +1786,7 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
 					    COMPUTE_UNIT_GPU, gpu,
 					    proximity_domain);
 	if (res) {
-		pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
-		       gpu_id);
+		dev_err(gpu->adev->dev, "Error creating VCRAT\n");
 		topology_crat_proximity_domain--;
 		goto err;
 	}
@@ -1798,8 +1797,7 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
 				   &temp_topology_device_list,
 				   proximity_domain);
 	if (res) {
-		pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
-		       gpu_id);
+		dev_err(gpu->adev->dev, "Error parsing VCRAT\n");
 		topology_crat_proximity_domain--;
 		goto err;
 	}
@@ -1825,8 +1823,8 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
 	if (!res)
 		sys_props.generation_count++;
 	else
-		pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
-		       gpu_id, res);
+		dev_err(gpu->adev->dev, "Failed to update GPU to sysfs topology. res=%d\n",
+			res);
 
 err:
 	kfd_destroy_crat_image(crat_image);
@@ -1951,11 +1949,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
 		dev_warn(gpu->adev->dev,
-		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
-		gpu_id);
+			 "Won't add GPU to topology since it has no drm node assigned.");
 		return 0;
 	} else {
-		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+		dev_dbg(gpu->adev->dev, "Adding new GPU to topology\n");
 	}
 
 	/* Check to see if this gpu device exists in the topology_device_list.
@@ -1967,7 +1964,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	down_write(&topology_lock);
 	dev = kfd_assign_gpu(gpu);
 	if (!dev)
-		res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
+		res = kfd_topology_add_device_locked(gpu, &dev);
 	up_write(&topology_lock);
 	if (res)
 		return res;
-- 
2.34.1

