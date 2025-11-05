Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE6ACCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 06:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B842810E6BB;
	Wed,  5 Nov 2025 06:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxxIA1AX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939C310E2A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 06:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak31mYm7knKaQOJwgkLt/pUw8plzPt6oK1Yuf6Y6W2V0eLdFbgFvUw60y1yOuk+SPt2tFe+uHm3CA2mVbs08FYU4AT0O1TV1CcQHZIQlRkgBNbhft3yGwiebX+ZLPlr9n2l8d6AHytCPHBykeXSzO5exPsGR4ZCfGTaNJcw5U+YcIH7A5N3zb+peLBdgjOi2A7kZlobmTE34F3NBadhyVbBQFy9ZEWXHRLTFK0BL4QlWcmKJiG7Cc8/P80QW8h8aLH9kLpIA+4KtVSuPmTQGBeTilDUCOIIXW2Kwe30h1ucssXEf12z6o8rLGpJx4lIwrr+jUgqsGbTwFumGSDPWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0M9EkDOd9iwqIWYECq9nnXXzxgHfohOXx/tBX0giB4=;
 b=es1UcLMWQbi5bgQzDNv47lR6hZ2OqnfbwrxC/gM//a8EuKH/1olqbS29KpZSBSzm76loVeGYRCq0Ck21QNmv/dlQHjnNYAfGM3+W8cDKjBnURLFXh0WbNNS7FqD+2rDCxA/7l5IQT+0FPJXWYiWTfJFAeFB5n4nPzhE8l7K13EEpGnQSwV6il9k9bFl3UtrM5axn26gX63RmTWcR0jftp7G4SRIFWOhvv8K/lJHvZh4qGBIpC1IekB0VzZ0MCbIDOWkxwl85XA46wAwAzrUty+JqRJTZCoPwB2vWKPffMFrOanws6MhCQUIV4MIgTM2s0oXQZHyaiFm9qq570Bj1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0M9EkDOd9iwqIWYECq9nnXXzxgHfohOXx/tBX0giB4=;
 b=NxxIA1AXlCNdO1N1BJU87UMTKWQ6loU8AtVDfCEfQSXlw8uQC/QSyyUAh37V6k3bmyOsafmH0R5BeSzdxz4y8kRjV38ron1jNaOAKwERjYvRyV7xceUeHXVOE2Byw48MJiHKeGTYn2vTCr2HVEzfj6cRV1bVa2w+mRM9g7Laeb8=
Received: from BYAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:c0::29)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 06:16:43 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::ca) by BYAPR05CA0016.outlook.office365.com
 (2603:10b6:a03:c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 06:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:16:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 22:16:41 -0800
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: rework the userq tlb flush
Date: Wed, 5 Nov 2025 14:16:29 +0800
Message-ID: <20251105061630.4146604-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105061630.4146604-1-Prike.Liang@amd.com>
References: <20251105061630.4146604-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dc97b7-ad27-464a-0567-08de1c32e445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/U6YrXsdiO1yNB8GrL9lQ6EagJir3HAd24K/5bs6EjwN7nNa0AgkU381EZgX?=
 =?us-ascii?Q?TlBTKZjrYlPHt099gC5vMqT3DFBRjuiKdUz8O0H5ID6WFB6yfscqPxESxJgU?=
 =?us-ascii?Q?WqyGMnbUgNUVnLgnPuflXA3i3v0fPWkL9vg6Z4R6Zr895+JHbpfR5K7rRpNz?=
 =?us-ascii?Q?6t2NXuxAas4cSzeHa6YFRSR1jVBcbL8MK5zjGc28f2E/J4AodYs46ORTqWXu?=
 =?us-ascii?Q?8Qfsv1yG+BQJ+GbdwuA/E7xWXnlWp7ubP4hlUSUHtRAykzirGXoDTURf+WtY?=
 =?us-ascii?Q?OMosvRNB/gWUkaq1Zqe5A0FOELJWlEcf7cYPxHAPz3RYSMNcdAiuSE1V8TkN?=
 =?us-ascii?Q?Sbk0yDcYEyDPkQbGSkOkxvTBCMkzH8iQVY9JaL8eZd2CUxedp6g4vG++eYse?=
 =?us-ascii?Q?ersi9XWjm84k3zwhGAhPyX3S56eDE1ox6aO317TiLlFvdayemHEb0RSZfI8g?=
 =?us-ascii?Q?sWg8iX0JTDDA+uyw3Ugoj0dnvMvHshj8p2HXDh5ecmptCNAzjfVE5BUN+cp6?=
 =?us-ascii?Q?8nfJYtHE/eQln6x1XQT6tEy3Q3Jf43XXJGk0xnHqd+6ICjTn5Q3ra1Nmgu4I?=
 =?us-ascii?Q?TGniRU7FbtbRdvN1iOZREC76lMvRmlSHGUga9xFYboepK84672AAouRo12li?=
 =?us-ascii?Q?i3dvf4Z+SpcW/RFuelhAeiabUems90WTKG0Yop3kBTpSvn26usy5uiZb/n1Y?=
 =?us-ascii?Q?EFjfrguy8JQK7fcZp3ADtcMeEvcA53zAOqZWO0knbgvBc5lhY3qSTBnrWtT2?=
 =?us-ascii?Q?JRKfncSa4CA36TRjbDrV7NCgcgjxSt+K03fjWqo3VQTQzpeXPsv5Hv6B9eKc?=
 =?us-ascii?Q?uUkKsPeixsupn41JknVM1yWBhjhvHNldcXTEwL4Dkm1uQMZgxRrstkKCVOyp?=
 =?us-ascii?Q?N4NvfmbDuf2AsnKDe+/RjmPb2Ai91+zR+HsUDR39Gqzmv/er5LnS7psjNdRE?=
 =?us-ascii?Q?JqrqlY6+6aGaA3wFa7UKvYSh9L/z7/JeuPsEDWJzzjVE4FiOTUfizU/QWqZN?=
 =?us-ascii?Q?6hNDqnEPOxpeiqQKS/v4oH666x3+oPx6Dn5kKwwCZ0SmavdokKHSdLG9db1M?=
 =?us-ascii?Q?QYU2b4C1xyjogLT8Pp2fSU8S2njamaz1lZdtkglNOmjeJv9x068sGiybU0Km?=
 =?us-ascii?Q?81lEYnvwb3MOV7+FyFVmHDQnTuSa074AOJHBttFYzCN5459+AKOITPGpunym?=
 =?us-ascii?Q?8DCrXDtJefZ/hWxY9NGBPxKdjRjqDX51MOv+duko5ldEjYCEX00MY8sU17nv?=
 =?us-ascii?Q?LxkfKRe+hnQzQhnHafsKEY77GaNgaFg3jGuqxevLd5cWcws0Ljawp1HNwzc1?=
 =?us-ascii?Q?9vzZkTa8gMHmuld0CQ1td6HUNvNuMQHLX9+6QhlZwaPbJ2dd1dpB7RN8AtO5?=
 =?us-ascii?Q?pQx1iT8JWU3DDE/G2SMLDzsIhAlumDi4I7K5gvkwnb9onb15ovKZnQDuzbdc?=
 =?us-ascii?Q?K5/1u40rSYc5Acw27NGMv7zqH3abVcInvefGHTF/aB8D03Tt7nCHtka2HsQ0?=
 =?us-ascii?Q?9AAHgOMf8SMwI9pMmScsVn1TRf6+nkOIwETtqU04UIGw5+fTaiDeKAnYxOzQ?=
 =?us-ascii?Q?QV8ulBMfoGb20ky/u4s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:16:43.5527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc97b7-ad27-464a-0567-08de1c32e445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

The userq TLB flush should be performed after
the vm update complete and input fence signal.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a8bb3f1b8649..01707d72d982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -384,6 +384,7 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 			return -ETIME;
 		}
 	}
+	amdgpu_gmc_flush_gpu_tlb_pasid(uq_mgr->adev, queue->vm->pasid, 2, true, 0);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48a64d828eb8..1537f0b6b712 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1062,7 +1062,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked && vm->is_compute_context) {
+	if (!params->unlocked && (vm->is_compute_context ||
+	     vm->is_userq_context)) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
@@ -2792,7 +2793,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
 	WARN_ON(vm->root.bo);
-
+	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
 	amdgpu_vm_fini_entities(vm);
 
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
-- 
2.34.1

