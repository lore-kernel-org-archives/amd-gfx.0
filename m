Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83953C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 20:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE5C10F284;
	Thu,  9 May 2024 20:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvLud+EB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCFB10F284
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0+hdLT9C64hVbZBzoT+Y0USfq7kV98UMmFpmhIBbW1UhI81iU84y33cpXLpbTOTXINZcPQwbGrWWI0Pfh1rym0K7n1ycw+PL3I87DewtzqXuue9LaSBE9ySjC8Fd1j5u4DrufByX9iylIO3I07i4ap9bkxUYrvJ0JCMLPlqi1RW0AFtmf1rROSqMJWAZ1L2UdumN5cNsszYU/gQUlzvSHn+iUS7b1jeLTveNZguS7fo2GU96qm2oA1YOuQLLtNWu19xwLbBcrK5Tk3ouqPLsHwS21btfLZybfgZTaLkv83wbtEe2oVPEJhgAfRkwT+/lNEyZsEI6zJqulX4+XNYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdSC9chRoUkkmFjyTDfO0ScaZ/7ty8KN1IxxqCOaTI4=;
 b=N23cA4Ae4SjiSxJ6WDWEr7vLi2/qZz2hXicF0kSRPCBLCdc9mQ53b2gz1dGPCRS70PlNYtQv3DPKpHFOk9h0ge8AnlRN/sHuf48IbgIGwEOIXyoPtXO60uMoms5b8xsOfvek8P94lNG0umZzzUhHPOVEFPDVzvulcfeA9OT/92FIpnkoBx+xEiX3vzj1vP4PAmgrnKFi/72Q/GJZ2rWwq5ImUdbnF9zf1zsCuqWSWt62NbLwTw7PpaJxOdlqSgXeZLXZFuQ15zGZ8kWkygMM0Lt7FWlVU+Y63ZtuH1gZ2ZgjABsNrrLQEl0GwgQ4AKlHSN9IbScBaEeGhv8bMOE/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdSC9chRoUkkmFjyTDfO0ScaZ/7ty8KN1IxxqCOaTI4=;
 b=ZvLud+EBJteOJA8CqaJKyPLqdBefWMwLrE6aMFPjh3U0ug7gO4ORZLmpmeWwwC6kxwQWDkfCjckPLUGbth9NIgRJyAQpqK/rUTFrFEVrsyWaeeuoPVGCh4s+8wjDDF58smyAb9AcCfX5YuHrwNxg+Jk46XQQY/pghFOxp5U8cGA=
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 20:07:30 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::cd) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 20:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 20:07:27 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 15:07:27 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Ensure gpu_id is unique
Date: Thu, 9 May 2024 16:06:26 -0400
Message-ID: <20240509200626.497769-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f09385-4eb0-40e5-5343-08dc7063a6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YY+J4PY+fGdU0CRBAyVmuwanIQ20oZPZrBj1k2rPG0AFIe+m5JurRrAo6ORc?=
 =?us-ascii?Q?RAOcrpC5fIysRJ2iLZDTvXdoIIbeadwMqdeXr9YBDFMUAKDmZaEWstqo4UUb?=
 =?us-ascii?Q?V/HKjz4hnON/8kFUYz4vIONkeulvRvDWNOEeGLwBIx8Gawi7/lSfv8o8HwqN?=
 =?us-ascii?Q?eLkuqwSTKeEh4AxrsoYP2Get5JBeU7fs3FjD8//V2LqJJomFy4vmcdq/z3VO?=
 =?us-ascii?Q?W6PHLt0j4Ij4YRV2vtIRWK4w+tddFpk9bTcX5Z0blONwRqRVRb3h4LPeJiFd?=
 =?us-ascii?Q?pbWEL7ie37vWObk5C9dPCpprezBc5Tl34aD+ur9StACbl0oCiqs9fwu92F2s?=
 =?us-ascii?Q?Aa1Jz96rZafh+r10FShwz1QLEbi2I5QsaYZVrb7mBbF517lVHvupm2kJ1ghQ?=
 =?us-ascii?Q?JW11M5sKLT5hj4ESzusfg6+YBoTqDT5cGaDsFGjcgCaV1suWC+QRJMjVcc4E?=
 =?us-ascii?Q?nQIPuBNOsngDlssF8MiHYew949ZtmWZ0XOdXIYCWeP3elML4DuK17azMk43W?=
 =?us-ascii?Q?4t8ymYLC3Q2zuSVEwOlH+V1HY5RvPNGDjM7PbtIidM1u/ZR+bBVS2qmjYjzv?=
 =?us-ascii?Q?Wlm04kM7L/TjPoYj0KxArir7d6CQVL5ohX54JSM1jxrQxVgVvDEWbaMw2Dna?=
 =?us-ascii?Q?YRVbRawEsVOkrhOBCxFz93aZ8mwA+lHLPDIQNt+a2lVVwhW/OKGgQTY8/FZk?=
 =?us-ascii?Q?FcLbT9vFpHNg8UE65nn1yuC+arWjD50K+yF14wgZFKVaNxXMfOE+kCrjXgfh?=
 =?us-ascii?Q?DugjB3sTyjm1KyJS2oXJDUVCq4TDDHdcex1vQcG1aZ80s1J8NwGt+uWSYurR?=
 =?us-ascii?Q?AWUF80mjcAXJC4mFG96MSgrK7kAWdDasPzlD/vrY58/eabIwL0DEAlL3/YGD?=
 =?us-ascii?Q?rEBuDtoczELYGB7rL2gCq4E4GxbdALEKxV702oKNwHsTmA0e7N3sVi7+BaS2?=
 =?us-ascii?Q?VuoiBNgVUCuNVyB3TUCT9njZ47KUZyty6cu2kiH0V0s3nWmO5S71DQmSbuXB?=
 =?us-ascii?Q?iENHY9rBhaE4Pox7xV7C2THgn6mx6dKP7uk+esTEPdLeWrCvSfvYPb7U4kOW?=
 =?us-ascii?Q?ae+6ZPrFxXc0NCBGrmoJIirSSqeUjRU1RONshUCOXJI/AnAGKnTpK7dqudYh?=
 =?us-ascii?Q?PiFlIdoNkUh3MPoso+pKxGj8iDwkA72nu/eweFVUf0SLDwsybKXooLjnsgZ1?=
 =?us-ascii?Q?JfkAsmhFOiz9431VBWRG/oulX6BC1ctte1hvyuEl8xIBGEoRHqmGUvb8w5Bh?=
 =?us-ascii?Q?wIw2hwQeYtsLOyYIC6tckL97/5iLFTwwvJ/YxSdEOgNMEf+9pQKBWL5FWzVD?=
 =?us-ascii?Q?Tw8ocZS0j8FuiQQTCqYWikiov0VtOAewGVrY7gpedtWsFdPA/QLD6oQwKvgv?=
 =?us-ascii?Q?Yoxc8VKOVErnxlor9/AMqolPrMOa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 20:07:27.9356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f09385-4eb0-40e5-5343-08dc7063a6a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

gpu_id needs to be unique for user space to identify GPUs via KFD
interface. In the current implementation there is a very small
probability of having non unique gpu_ids.

v2: Add check to confirm if gpu_id is unique. If not unique, find one
    Changed commit header to reflect the above
v3: Use crc16 as suggested-by: Lijo Lazar <lijo.lazar@amd.com>
    Ensure that gpu_id != 0

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 40 +++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 219dcf504f24..4954a3021f70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -31,6 +31,7 @@
 #include <linux/log2.h>
 #include <linux/dmi.h>
 #include <linux/atomic.h>
+#include <linux/crc16.h>
 
 #include "kfd_priv.h"
 #include "kfd_crat.h"
@@ -1091,14 +1092,17 @@ void kfd_topology_shutdown(void)
 
 static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 {
-	uint32_t hashout;
+	uint32_t gpu_id;
 	uint32_t buf[8];
 	uint64_t local_mem_size;
-	int i;
+	struct kfd_topology_device *dev;
+	bool is_unique;
+	uint8_t *crc_buf;
 
 	if (!gpu)
 		return 0;
 
+	crc_buf = (uint8_t*)&buf;
 	local_mem_size = gpu->local_mem_info.local_mem_size_private +
 			gpu->local_mem_info.local_mem_size_public;
 	buf[0] = gpu->adev->pdev->devfn;
@@ -1111,10 +1115,34 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	buf[6] = upper_32_bits(local_mem_size);
 	buf[7] = (ffs(gpu->xcc_mask) - 1) | (NUM_XCC(gpu->xcc_mask) << 16);
 
-	for (i = 0, hashout = 0; i < 8; i++)
-		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
+	gpu_id = crc16(0, crc_buf, sizeof(buf)) &
+		 ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
 
-	return hashout;
+	/* There is a very small possibility when generating a
+	 * 16 (KFD_GPU_ID_HASH_WIDTH) bit value from 8 word buffer
+	 * that the value could be 0 or non-unique. So, check if
+	 * it is unique and non-zero. If not unique increment till
+	 * unique one is found. In case of overflow, restart from 1
+	 */
+
+	down_read(&topology_lock);
+	do {
+		is_unique = true;
+		if (!gpu_id)
+			gpu_id = 1;
+		list_for_each_entry(dev, &topology_device_list, list) {
+			if (dev->gpu && dev->gpu_id == gpu_id) {
+				is_unique = false;
+				break;
+			}
+		}
+		if (unlikely(!is_unique))
+			gpu_id = (gpu_id + 1) &
+				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
+	} while (!is_unique);
+	up_read(&topology_lock);
+
+	return gpu_id;
 }
 /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
  *		the GPU device is not already present in the topology device
@@ -1945,7 +1973,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
 	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
 
-	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
 		dev_warn(gpu->adev->dev,
 			 "Won't add GPU to topology since it has no drm node assigned.");
@@ -1968,6 +1995,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	if (res)
 		return res;
 
+	gpu_id = kfd_generate_gpu_id(gpu);
 	dev->gpu_id = gpu_id;
 	gpu->id = gpu_id;
 
-- 
2.34.1

