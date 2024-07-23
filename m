Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A2C3DA5D
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 03:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E491310E2AA;
	Tue, 23 Jul 2024 03:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCniPyD4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493D010E2AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 03:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bq+r0a6G1y5i2UQQ1afFzmt23xzqoUU+qrzyy81JzMfeyZ+cF+jXYhg4oEMxy8QbjikneKk6LFnblZ/TLyFxKTxHfabTqBR1VoF2it/Ke2XYG+S/VyMPA3KcxqJ2RwiUwCJd5LTyrbFOuMULcXW/YgUgAbFLfEnOTp/W8qXn9fUgwfDn98k4tuetkEznphNCxmiUGNoT+AvQt9MRkfK+KtwmmVeaUkmix3nZ6/NS/n/EJHbZ51t6EmzISHocznZroZYb1nALtH17Z6fYJtwYP6TD1jJpRnHCdWr+nkHRPVEAlrJYZUZJfCB5iUgCY/yeSk9ZSieXHBSIFg+pEL2Jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPwruiJph6v4f1u8EhS4wpQjm229CskubB5q1Pr5L5s=;
 b=JGPpmCJfXxfwxaQ9tBmennX0o72HojZhZ8NAijf+az/l+gqLpM9nqCcoxFyDbmufJH67Xdw6eUVqQWSBDGIfhE/Trj04tVhpJ6ZQVjXFS29JnfwVc6MNQVnqm/VRIx06xg2z7zhj5BCuwmTmSlRUDfjDSA/B2ZAND5cTdL6OpOORSmvpipT37KGhTRpqT16Yj/4MC0qj+alvlVCVTkwnZvujcF5xx0WveivNM3r8jS1WoOXph9pSxoPFt/cyMEoLbyLG9yAilfZjctCLLiIp9ZS0vEcrPsR8E092iNrkXEVDFYR0CxQlSKEiCjr/TXwZmvk6zxwQsWIeqTIdVdh3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPwruiJph6v4f1u8EhS4wpQjm229CskubB5q1Pr5L5s=;
 b=rCniPyD4k++w6zQBPjpuz4lvUpnkCdrk9QFWmWmpavTi1DGzeE1yVp2hdV7JjwypGnhcX1CnhoH0ZHNMd+zQc2LU3ufX2YPrNRcU4yXrU/bwymPfmshFO3Y8ppv8I4oqFNLwS6WEQVYFs1/9wrEHNCZssteKmgNs58leUv9VskU=
Received: from BYAPR07CA0002.namprd07.prod.outlook.com (2603:10b6:a02:bc::15)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 03:06:49 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::53) by BYAPR07CA0002.outlook.office365.com
 (2603:10b6:a02:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Tue, 23 Jul 2024 03:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 03:06:48 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 22:06:08 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH v2] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
Date: Tue, 23 Jul 2024 11:05:48 +0800
Message-ID: <20240723030548.1283366-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ff59d6-56d0-4970-7fa7-08dcaac47e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bEFzycybPNGWgQTIuZcqsB8idKrlRhjQhQeBBP4XibWxqYjlcx2oHVmUPdx8?=
 =?us-ascii?Q?vJn0j1oCNn7pzThbZfDFDQHYqmFAogfOaQTV7dcMxPO5tqRZo5t72luaxSTd?=
 =?us-ascii?Q?EYPTw8+mrpHMSZJ7nlZlA5XHihVbZfv3ZtKCUBWF7o11vX4zJi2QCQ5trZO4?=
 =?us-ascii?Q?WIZHV+x/TraOKkeDwb2H3HVtqEtEAS/IBMNiXRmTgoptEIXZcHA9OkDwATmd?=
 =?us-ascii?Q?863LYR75HVw0Zfz84WYHVPNLGbPEf4t3WGp4w0ZL1ZWbd8fipWzGk+KoyytM?=
 =?us-ascii?Q?mmEeJJdDQ1STalFlE0gjdfplCJD7jnfofiyFvDJUAmKxBCWjjt9ISRW5bCfB?=
 =?us-ascii?Q?4q8s0Tdu3BWCnYzeBhf74GOy/DMLgDJfNyCkVnH4XZrYnrCe7kDyXcRTdxFw?=
 =?us-ascii?Q?Pqz38ZWmb4jd+q0i5FBGxoQpfgKDx8kS+acCEPSDNNfpMN3HaRmw5Wln8fPF?=
 =?us-ascii?Q?ouWAfEO8tb26chpWrUWM63teE0hfJqOgMmvDJAALXKHlulBPfejDgGRlI1i4?=
 =?us-ascii?Q?h+6S/j2om5+7cU5Iq9Ru0L+HlRY/40kVVWHE5jsm/K6JzF8btvteWF/9Gior?=
 =?us-ascii?Q?OLKQXoStQSziHRmZwlPbustvbcBINbC9wfpDO66i6q3fTmFr7ZlTlgOWgGYg?=
 =?us-ascii?Q?Ho9vhCPKeJR4OFCUDqgbPT/tRrFZrcxVzf9CDM4zBN7ojX8Okkq1TO+CYcul?=
 =?us-ascii?Q?vKFNKG/ayGb8oNbItJNIS5XJWqwNwH2vENXA4IMmE+XniApjMjpM1gjNrlII?=
 =?us-ascii?Q?2rGETrbnHwuZ+uWYIz0QCmU2YxdqKpMp9yJLeB7yJ8IxXWBtyrEUe4QjrONj?=
 =?us-ascii?Q?jNXLSYqYl4lIySMN5wlXWqNVTbmyo2+TdgvdPauFQmjnO8SJ/xPrqA3p6DJJ?=
 =?us-ascii?Q?tW45plxlXyj1aWBZSsDqUUGAnAgEmmcpdtTKaMFOdL5cTZJFzhhAk1zqDtf1?=
 =?us-ascii?Q?Wcz1xmzmgaP+S9Y2iQLKu9oFsmG43P0eqUK9Hj9i3L4cXEVFcyLkl13oMK7o?=
 =?us-ascii?Q?BpclI0Axk2z5YGS1JTZ84ItkTL31dfAMybweDCtaN0UGrk/HWFeEXFlLOPyf?=
 =?us-ascii?Q?O1HxLOMYXjhOk41wwqI3gcX9UexO9PSXNHwjBnn48pPffh5NXzJp2QaeZ9yb?=
 =?us-ascii?Q?yPuIXRVAXljSkfvfHES3/89pViXREH6OZ30jxBjCGwLF0AFfY3bSocNWa007?=
 =?us-ascii?Q?FAPRHcVlKrD34aV+gd7BRqPlKTCFj2ICWR6tVn2O9hfVztFsl0i6Ijz/Xvtq?=
 =?us-ascii?Q?0KsSvMiFoGFgLLob/g2wSnmHvODAgzYiFYlvtROX49pG85wXGfUvWKtNDs/N?=
 =?us-ascii?Q?5D6AHZHuI2XnXqYsDdGVu+EyFRWwzrVxSWhjZvCCb2L1wT1WuiHCQ/SqpfXP?=
 =?us-ascii?Q?9V1/rs7n7YyPeHBLgj+M/GYCI0dYxoQUXSLcqgn+yTuD69lsoRtUPMUJApl4?=
 =?us-ascii?Q?dTzfpWeslMtGRVklWmiSGqSpvl3kKcOE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 03:06:48.3280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ff59d6-56d0-4970-7fa7-08dcaac47e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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

[Why]
Page table of compute VM in the VRAM will lost after gpu reset.
VRAM won't be restored since compute VM has no shadows.

[How]
Use higher 32-bit of vm->generation to record a vram_lost_counter.
Reset the VM state machine when vm->genertaion is not equal to
re-generation token.

v2: Check vm->generation instead of calling drm_sched_entity_error
in amdgpu_vm_validate.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..9e2f84c166e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (!vm)
 		return result;
 
-	result += vm->generation;
+	result += (vm->generation & 0xFFFFFFFF);
 	/* Add one if the page tables will be re-generated on next CS */
 	if (drm_sched_entity_error(&vm->delayed))
 		++result;
@@ -467,9 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *shadow;
 	struct amdgpu_bo *bo;
 	int r;
+	uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
 
-	if (drm_sched_entity_error(&vm->delayed)) {
-		++vm->generation;
+	if (vm->generation != amdgpu_vm_generation(adev, vm)) {
+		if (drm_sched_entity_error(&vm->delayed))
+			++vm->generation;
+		vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);
 		amdgpu_vm_bo_reset_state_machine(vm);
 		amdgpu_vm_fini_entities(vm);
 		r = amdgpu_vm_init_entities(adev, vm);
@@ -2439,7 +2442,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = 0;
+	vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
-- 
2.35.1

