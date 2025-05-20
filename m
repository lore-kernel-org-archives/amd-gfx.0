Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D8C3ABDA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C48410E06A;
	Tue, 20 May 2025 04:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AkF8aXOB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0121F10E06A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+uhsXKfsMQb5WFZvFaMOm20QtJAb4fpLyzn7LPDaymoyUYm+WYWSGa5RnGv9ezSaqTxsi78uWye6dZku92VP6xnIkqXnU+/HlK6odzWiI2QAx3HatlznSiK96HgbKzogMTsfCIpuK4wQ9nqtOzBsYD4b415fAsdBnvfwVkIcNrzc1B8HLR21813cv7rlUZTQYX+RVQYbABh4Y4wkz3gGoQ5UhZuxOCwvIyiogrxMP/k1LE2r2gTlj9M+PRd/Ab1wBoKeVmUENh1iQ3bKrpDUUpjPwuLHfkCCSNQ7f8F9YS59+MervjakLt0blxNzVLi0wz1952gXIiMKoltW/7PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzA5z641UjgN5accJ7Azmzfa4Jo7LhN2R/8rqHCbpXw=;
 b=n/FVWmTrXT0jgoeNo5V1T0IVnihZV59B/KurZGFZKMhdpuc+8LaFuIb71eCPS54wPfcLKmmQ+ktZGBEcHrg+EsrYIzjkuc5fdWhc7a5Txrzfpp5lTtvKu94jl3wofBnX+QfxQ3Ue6TffBeWGxC60z5maKywIJn3/1Ggut3j5+eHe1K6hS8ann7ztIVJzUYtilNwafi+PGz/t7PmfdooamURnlHOKe5sJKYIlrseuC7itb/iGQYfa6B8Em1uRRB2zxC89DWEEajVLfCcwtnMuxCPCInNV94tjA4gL2qeFpfQ+395KrKhMf4sXJlFQ6CAOEB3DLBSozd8lQ/W1Bzx2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzA5z641UjgN5accJ7Azmzfa4Jo7LhN2R/8rqHCbpXw=;
 b=AkF8aXOBtHbsslkgYiJ+Fj4TwDqW239h9x6VkKMHJSOG2Vms58p8pCy/XQwPnDFt/QoAKPN1Rfm9INDSW9DSomXHS+OGvapMSqGUnRaUN+F0l0xmxZKisWE0YcqnXPlERIhZ65xKpHFT2z1J84LSqPZNobetg8WYapO+3Lc2lng=
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:54:29 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::da) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Tue,
 20 May 2025 04:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 04:54:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 May 2025 23:54:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v3
Date: Tue, 20 May 2025 10:24:10 +0530
Message-ID: <20250520045410.3404517-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518060324.1384914-1-srinivasan.shanmugam@amd.com>
References: <20250518060324.1384914-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 12239e0a-d5f4-41fa-08c5-08dd975a66dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2drSVRKTlM3YmpyTEJUSzFkVmU5TTgwRkhhdk9sTVU5Q1M4M2V1L2ZxaUk0?=
 =?utf-8?B?QVEyUThoV01WcjgrWExVcHJMQUJjRmFoSlZETEF6bEpReG92SWMrQlJuaWZk?=
 =?utf-8?B?OXdYcUtvUlVvbkJWdDF1cVAwY283ZmFMRFFGZHZsZkNiNHlNTzlBbzYyNkJa?=
 =?utf-8?B?a0RSN0pRdTdpblJRdjFlZnM1eWFub3l3V3NGMjVqbGVoYnB1WDlOTldIK2lz?=
 =?utf-8?B?N3g1dDVVMmNOOStFMm9ZUnI5NFFUaEorSVFPVGMzOE1HU25SV3pRTHBDSXVa?=
 =?utf-8?B?dXFobFRlbmJIOVo3c2xmSUZGbjdrNnZZV20xMEsyT0ZpL2c5aDM5S2R1bU45?=
 =?utf-8?B?TWJCTDV5NEFzVXZiclE3c0EwcFJBNjUrR3B3d21Nc0huazU1RkhmaHY4Mits?=
 =?utf-8?B?bUlPcnpTRTlrbmJ3MGNNVFdaR210VmxoZTBWMTdUam5TSThnQWRzTE9QL2hi?=
 =?utf-8?B?TGUwSHZNWDVKZExCQUoyMllzbnBuckxhbFRjZ21vcWVzd0xOb0dyQ1hUQzEr?=
 =?utf-8?B?d1NLUVg0YnliZHh4bWExajdEZW16QzJmc3prMlhzMzhONExtUUkyK1JGZ3Jz?=
 =?utf-8?B?MmQ3WVgrN3Z3MG5PZ2JjWTRQT0NqeXVjcXE5dElpYytIVmdrVnVzRGpmVGVI?=
 =?utf-8?B?VklPaXNFelJIandJTHg5NHpVOWM4cldtSUhpN1FvTmphNWRQbE9ndWpkZmVD?=
 =?utf-8?B?MHZ3MnluQnpOOWtPRW9WdUZrWjZtVmNTUlZKWmg2RStDYk1DVHMrdWNKMXlz?=
 =?utf-8?B?eUVCM01xM1Y5Q3R5K2FlUzBSTTZiQWVYN1A2MU42UFZQWG9BL1czZW9WL25w?=
 =?utf-8?B?bWI4NHpKRHZkUnpsRWdFdzNKTjBMZzFCanZRMnptNmRlZU5DQnB0Q0MwZitu?=
 =?utf-8?B?YUtJaEtZM0lOTitpOFEzdFYxaTBxYndCTHRkQUwrRWRFbHpZSk1Hd28vMStD?=
 =?utf-8?B?L1JRdCtZY2Fnemx4a0d0WnBDZDk2bDBXblhvNzgwc0NKQVRRRGFET2RSS3c3?=
 =?utf-8?B?Tmtnc08rK1lkRXI5UzM0UmpTRE4yMVZIelBHR1p4TURBYjFtUENoUUJHeU91?=
 =?utf-8?B?V243SVF4b3FRcnpWVmp0NWRBeEx5aS83Y0hXNENFc0pJbFJZbVR4Yzh5NG1Y?=
 =?utf-8?B?cFJTQlBDTFF6QnZpWUVvSWVwS2NXNTVOWlFkRFJFcU5VSjlGUTZwcTRWWTdH?=
 =?utf-8?B?UDBXWnJrOG92RmVLMXlqSW92dWZjcWdoVFJRcDAzbnpTMlRnb0s1THkxT2hF?=
 =?utf-8?B?cGlhRytpcVM4TU5Rd2tqTUlxU1RJQW5xNkJEd1dEMWNpeUlkQU5hM2JoM2pq?=
 =?utf-8?B?ZmRXeWQ4aU5BVkJCQThPQlduR3VNODkrbWUrWExWMTkzZGlidlZHcW16UFoy?=
 =?utf-8?B?bklzeW9nTEtvNTYrSnVJSFVYOEE0ZTB3L0dmMkRJME5pSzBoWnZsQmY3QVVi?=
 =?utf-8?B?NWF2NWZ4b01pWTZSajh5TGNpbE5sQ2Y5VDdkUXN4RWl2ejVCbzdJM3lEQmc4?=
 =?utf-8?B?czdQRnl2S1AvcmdqT1A0K24zSkRFZWttZDVGYSsvbEU5Ukgvd0ZMYy9QMklw?=
 =?utf-8?B?ZVVCSkVRN2pCNUFON1YwQVoyN20vVXFhY2pONHMvRUxrb3hzZmt0Mis3bzh6?=
 =?utf-8?B?RktIc3RrckJFYW1OQ0tNOEIvUUtISnc5YjRsMFp0bDdsT29ZSGlMbHp6eTI1?=
 =?utf-8?B?dSt2UHB1aHZYMHc4Ym1pSzFnUGt3UkMvaEc1bklreTZ3QUlXOVR3Z2FMeTVs?=
 =?utf-8?B?V0taQndNVitlTzFTWDBOOUJIK2ZOc0M2NFhxcG5xN1BSeFFMQ0MwNkYrb0N6?=
 =?utf-8?B?c2RtNitZU2xxMTdsTmQzU0dOYmtacGdxbm1VZndFTUk3aTZEK2ZLR1VWNGhu?=
 =?utf-8?B?blh4cG0raXNocTNYdHh3Tk05cURPenYzUnRMZGFWd0IvaSt2eTBId0FHc05n?=
 =?utf-8?B?N0t6VWV4dGVLelJmcWxpVnQrQkgzc2FqcjNkWTVrdkFsemM0eXJtblB6eDFB?=
 =?utf-8?B?dDE3UzBEekFLSExqaUh2WER4VFQ3d1E2bnJNcDk4Nk9ROFRiMWdIbEw3UTdY?=
 =?utf-8?Q?L3/mfH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:54:28.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12239e0a-d5f4-41fa-08c5-08dd975a66dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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

This commit simplifies the amdgpu_gem_va_ioctl function, key updates
include:
 - Moved the logic for managing the last update fence directly into
   amdgpu_gem_va_update_vm.
 - Introduced checks for the timeline point to enable conditional
   replacement or addition of fences.

v2: Addressed review comments from Christian.
v3: Updated comments (Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 90 +++++++++++--------------
 1 file changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..1b701cb9fd96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
-static void
-amdgpu_gem_update_bo_mapping(struct drm_file *filp,
-			     struct amdgpu_bo_va *bo_va,
-			     uint32_t operation,
-			     uint64_t point,
-			     struct dma_fence *fence,
-			     struct drm_syncobj *syncobj,
-			     struct dma_fence_chain *chain)
-{
-	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct dma_fence *last_update;
-
-	if (!syncobj)
-		return;
-
-	/* Find the last update fence */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
-		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
-			last_update = vm->last_update;
-		else
-			last_update = bo_va->last_pt_update;
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-		last_update = fence;
-		break;
-	default:
-		return;
-	}
-
-	/* Add fence to timeline */
-	if (!point)
-		drm_syncobj_replace_fence(syncobj, last_update);
-	else
-		drm_syncobj_add_point(syncobj, chain, last_update, point);
-}
-
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -780,6 +739,17 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
+
+		/* Determine which last update fence to use based on buffer object validity */
+		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
+			/* If the buffer object is always valid within the VM context,
+			 * use the VM's last update fence
+			 */
+			fence = vm->last_update;
+		} else {
+			/* Otherwise, use the buffer object's own last update fence */
+			fence = bo_va->last_pt_update;
+		}
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
@@ -845,6 +815,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	/* Validate virtual address */
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
@@ -878,6 +849,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Operational check */
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_UNMAP:
@@ -901,6 +873,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	/* Add input fence for synchronization */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
 				       args->num_syncobj_handles);
@@ -923,6 +896,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			goto error;
 	}
 
+	/* Find buffer object virtual address */
 	if (abo) {
 		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
 		if (!bo_va) {
@@ -935,6 +909,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	/* Update the timeline node to ensure synchronization of the latest operations
+	 * This helps manage the execution order of GPU tasks, allowing dependent operations
+	 * to wait for the completion of the virtual address updates.
+	 */
 	r = amdgpu_gem_update_timeline_node(filp,
 					    args->vm_timeline_syncobj_out,
 					    args->vm_timeline_point,
@@ -943,6 +921,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	/* Call to update VM and retrieve the resulting fence */
+	fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
+					args->operation);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -968,19 +950,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	default:
 		break;
 	}
+
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
-		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
-
-		if (timeline_syncobj)
-			amdgpu_gem_update_bo_mapping(filp, bo_va,
-					     args->operation,
-					     args->vm_timeline_point,
-					     fence, timeline_syncobj,
-					     timeline_chain);
-		else
+		if (timeline_syncobj) {
+			if (!args->vm_timeline_point) {
+				/* Replace the existing fence if point is not set */
+				drm_syncobj_replace_fence(timeline_syncobj,
+							  fence);
+			} else {
+				/* Add last update fence at a specific timeline point */
+				drm_syncobj_add_point(timeline_syncobj,
+						      timeline_chain,
+						      fence,
+						      args->vm_timeline_point);
+			}
+		} else {
 			dma_fence_put(fence);
-
+		}
 	}
 
 error:
-- 
2.34.1

