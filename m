Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E87C71133
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 03:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA81E10E372;
	Wed, 11 Jun 2025 03:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ode0aDfJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED7710E37D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 03:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi1k0u4QyuYNU864pUkf23vZlnjDQSdMQTHOQpvUCfBFePvg4OpIHFU+y5eMwPf3xJW5CGEedQyWzyXdEWW/lfngpiuPXogIyEtSO1b5gz+35Y0vB8QQU1NN2sw29Q6WDtSNFd4jxCiphZZqHneNUl+SF3jzyX6xnQhyYPhcXswr5ahnrGE3wf5fY417noePZh5QUKYCp91ZgGVt+Yeo/p/XnHw7tKl/UoE3IymITUelUoQbVQclZWPut6BOz/bVVq0ekWzLbHN9b5k0SYG1g3DxyAvLlzg1yz4BgMTdmGjJa2osuxz/1bc19DZUDtr61VAOcIC9UJjTzsL7wsG9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFQI/sNWlPkzj3LYkdUICJT1ScxtFSkPC+cIJEXjnHc=;
 b=iIXQqPl9eUGYu/VvXzJvG7GGLjz7U1XPqST/LZbyV+koUQiQPzgd+CJJthrwiLZ3+00ZmyLx7nQnyrQOxECPTy9PhEBzAT4QL5HnvM4sxts/p1naBBHuqMMWAUHZf3CubrxT4t/DD3HMpIrHYJ1tWYDUr28suBw0d9dsOiF2wN0VB1UhYK39X5Ds1+Fn3KlZqndZbj1B4pRjrQqcFYebXTWUhAMQ+nZiVFYKFObqdqVALlzGHBLf5L6ysBQP22BI18hJmGj7DARryHo3EkFR9ni6NSHPKTIPFRLtFkxUZK+pHJaqbIT8ALu9yZWPlHRELpFmEMe6rwMreYjQVb9XZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFQI/sNWlPkzj3LYkdUICJT1ScxtFSkPC+cIJEXjnHc=;
 b=Ode0aDfJ+ddqyTY4hp9M5t17fTYqmj+ebEXHIZ8TEKzQOpn5QoaeC8IFxgYaZ6+aDqGOTnJ3BlJmiERF1IsNYKSaTnDOB+F+lVt29Cf2DDdQdrb0LPWNykgSze6LTllLs2kPU0CoSvjLhdj5oSZFZvvi5FfU30Z26EaoglMrrfI=
Received: from DM5PR07CA0099.namprd07.prod.outlook.com (2603:10b6:4:ae::28) by
 PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 03:35:10 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::44) by DM5PR07CA0099.outlook.office365.com
 (2603:10b6:4:ae::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 03:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 03:35:10 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 22:35:02 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: get sdma instance from irq id
Date: Wed, 11 Jun 2025 11:34:50 +0800
Message-ID: <20250611033453.48610-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 17933b04-d815-49d2-5a5d-08dda898f7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FHlSQxWV73ceWBeg4hMJmBBTONvvT0LbzLZ8xZUG43NUCcE5YqhH5ygz3fkh?=
 =?us-ascii?Q?dxbpvv9DSFl3GwKv0rkwV0i/f/iAXZ/CVeubZAvOzBtq2lst+Kh/CbVIRg9T?=
 =?us-ascii?Q?GjsX+ogofTMfhhADLKSIw5B9hoCN4ZwSuxAMyf7A7/HuwSz7aPxX1JBOm2YE?=
 =?us-ascii?Q?4bI3keNZ2LdNrP+5MqpTYPsatKNfWhujDPiKyl4vl3WLUhAyCyyWHtpPpi8S?=
 =?us-ascii?Q?YlmJ1zf/yO3lMDDdJBSpelf1oelu9MovuLlL/zQxy2I12rM9bcKlsfOTywsd?=
 =?us-ascii?Q?gCQV7G6rgHEGIKqKZqfqoePI9MFOubhFwz7D3040yEwKcOJI+OfpDDZMxyvx?=
 =?us-ascii?Q?lLua1jLPo7ZrCDljY5gOdl0gURA4cNZmE4J4cpER1JVOg58JdLiVARzbB9Ix?=
 =?us-ascii?Q?6f9w4pNECyDuXGiyQ7VlFaZSY1WtnoORUvb364TCJp8S8Xe00nJ971HOSiGt?=
 =?us-ascii?Q?Q7wjc/G1714AYggo/NenMpP55yzZxh+iRZtVsmj0jG8UwuoNyvzQ7dnnGLeR?=
 =?us-ascii?Q?V3Ux2ZN+l3Z4S9vmjc0jYddcVeCapFgo0tschkwBCJRFI8bFlt3ISNFSZQS4?=
 =?us-ascii?Q?0n0EwlThH0g+9+LmcRmLWboOSWMKnrfOAgfgsh6sw2rrvutuvqTr6v4wq/wj?=
 =?us-ascii?Q?skdAFTza3s+UynUXDEwQYWcMT5qAzAHpiPOZGqD4pkixENJUSN59OzZyTcsg?=
 =?us-ascii?Q?JHYC1ujXmZHZOaSg8lTxAJnrx6WMk1iebciwHfzikVeNxAaZUU9JIF0D7s9u?=
 =?us-ascii?Q?Eq41ECBF77JXjo8bxjMlnpwg8evPfhS0TIhBRee4fIyw5f/5Cmpt8YMSXO8p?=
 =?us-ascii?Q?BIAKcnhwRWFfzfkxslQLZCKnotNAHj2FMDzwADlYZ7HNTESaJZyAEjdUaUdl?=
 =?us-ascii?Q?zgeZeIayByrwAlp6F2aRwA7GDzpUtvl0+MVFxJOrzYYs4kgDg2KS9aPvIMSN?=
 =?us-ascii?Q?EsHBZPDh5JGHYnpdJnFBLeRW5pvNdvMhFGJhz+rzmrHt8Kp1VcVJyoyyKHC/?=
 =?us-ascii?Q?cx4i7hrWS0QAAehRuyTWVTduYLhTdAq5X0g6+bj/ngidohRuLWNLyigJcuc7?=
 =?us-ascii?Q?2OPOn6P1nqJl4qNjhkrRW4gELQNCKA+RvHccqUpaf9rNUYLUl6soLC/kyQpQ?=
 =?us-ascii?Q?4qKPKW2JwogJvd4J2thHvZ48IVlS5V252TwFGv46qw8d+06Criv6vGcU4yYE?=
 =?us-ascii?Q?iRz0FN8lhOnmePs93TdT9+B9dwgYWERtfamFREE99XdKbVn9uhrxtFvcbzFd?=
 =?us-ascii?Q?i73KiZIgncgABpEcj5nHvce/yIMOeGJo8hHS6/WznPyz40A4FGfYb1mw9ySv?=
 =?us-ascii?Q?2vz0JDRYJuw8vlQdjT4DqsP/2Rs+t+h/kIRGQlbqWK9s2j/aZv9bQ58Rw6lp?=
 =?us-ascii?Q?s5tEI+BNfLSPvgtw5Q/6Wetp3QWqOF9qEBDjaL2NPsLBYzUq42SmtzAPRclT?=
 =?us-ascii?Q?WTNxzbao+ksYoaXsKx0H01QUmbPPLNW2USOCyCDljaC8qKn9rYHiVnn0RYfE?=
 =?us-ascii?Q?CYmB3UXcr3ZPG7Qi7MOAHLKiKun/cSgf8oDm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 03:35:10.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17933b04-d815-49d2-5a5d-08dda898f7c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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

And the interface can be accessed globally.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 51 ++++++++++++++++--------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5f8951bbb6f..262321a0aa4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -54,6 +54,8 @@ struct amdgpu_sdma_funcs {
 	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
 	int (*start_kernel_queue)(struct amdgpu_ring *ring);
 	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+	int (*sdma_irq_id_to_seq)(struct amdgpu_device *adev,
+			uint16_t client_id, uint16_t node_id);
 };
 
 struct amdgpu_sdma_instance {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..96ea9a0f952c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -156,6 +156,35 @@ static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client
 	}
 }
 
+static int sdma_v4_4_2_irq_id_to_seq_global(struct amdgpu_device *adev,
+		uint16_t client_id, uint16_t node_id)
+{
+	uint32_t instance, i;
+
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, client_id);
+
+	/* Client id gives the SDMA instance in AID. To know the exact SDMA
+	 * instance, interrupt entry gives the node id which corresponds to
+	 * the AID instance. Match node id with the AID id associated with
+	 * the SDMA instance.
+	 */
+	for (i = instance; i < adev->sdma.num_instances;
+		 i += adev->sdma.num_inst_per_aid) {
+		if (adev->sdma.instance[i].aid_id ==
+			node_id_to_phys_map[node_id])
+			break;
+	}
+
+	if (i >= adev->sdma.num_instances) {
+		dev_WARN_ONCE(
+			adev->dev, 1,
+			"Couldn't find the right sdma instance in trap handler");
+		return -EINVAL;
+	}
+
+	return i;
+}
+
 static void sdma_v4_4_2_inst_init_golden_registers(struct amdgpu_device *adev,
 						   uint32_t inst_mask)
 {
@@ -1337,6 +1366,7 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
 	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
 	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
+	.sdma_irq_id_to_seq = &sdma_v4_4_2_irq_id_to_seq_global,
 };
 
 static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
@@ -1764,27 +1794,14 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance, i;
+	int i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
-	/* Client id gives the SDMA instance in AID. To know the exact SDMA
-	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
-	 * Match node id with the AID id associated with the SDMA instance. */
-	for (i = instance; i < adev->sdma.num_instances;
-	     i += adev->sdma.num_inst_per_aid) {
-		if (adev->sdma.instance[i].aid_id ==
-		    node_id_to_phys_map[entry->node_id])
-			break;
-	}
-
-	if (i >= adev->sdma.num_instances) {
-		dev_WARN_ONCE(
-			adev->dev, 1,
-			"Couldn't find the right sdma instance in trap handler");
+	i = sdma_v4_4_2_irq_id_to_seq_global(adev, entry->client_id,
+				entry->node_id);
+	if (i < 0)
 		return 0;
-	}
 
 	switch (entry->ring_id) {
 	case 0:
-- 
2.34.1

