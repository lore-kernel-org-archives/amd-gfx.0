Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E384C3DA49
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 03:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F7110E078;
	Wed, 24 Jul 2024 03:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubpRksR6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90DB10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 03:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDebMUy17g2Xl3LhZvJw0NG0zs8JRFJUGqWPUmpMOiJ1z8vgoYVxtH1E1PTuinW71f/sulRBwDpYgI9P1gFuxXokswawAg3ObCnAQ9YttSVsQVIuPpVDU5sAJ3YIQNpPqoFVk4BaLv7TRE/ZK05jOsBAvHRAh8kswqxV1ftoVBySDrFyG45kfTEmona+/tB+2crdwdM9TFId/hLUfTosk+HXnpoinX9iPwsWckL335U+C94TjuoD1kekcsxh89mesCNxWg0Sb0/RSSj5QqyJutdTqf/tLoEOc1M72zAKABueSPOmR4nUiWohymGB36/pOylakPolmJmaLlIn26tTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygYpERBfIkeQkXUg8QHMtdLoTWIhXGA5MU5rrlywwNY=;
 b=Sw20ODxnLPWAJqbPAeuJE4d689bpRPThLNlYB31YeZhnk6QpOSs0l59k5MP+pCXMeK8rbdK/4bvnaqLa1ka7R1sbBTGH70R9X0G6AQXbVsJhvNfpOTpvWvAhTzyNJvZrr9rKZUelMyGODDdRGAg1D7C8MbEx8GRd9Kqsiy/wBpXNr6fCdddNa5b7Ka4LuhyeCO2r2qRymLnFFz9CsgSrDfqAvkt4takn6/NElPz4Hrh1VtxlOTW/xHJDfj1GfGftu2fbAE4FvMkcFJCvWmVrnTEtUOX5Z2fzz1mpj4oJWHZZlWKuiuljmRiTQjEVcUt4X5id4jyZUXcoHAFAQt7prA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygYpERBfIkeQkXUg8QHMtdLoTWIhXGA5MU5rrlywwNY=;
 b=ubpRksR67pI49V15BLFuE+jQtDelc74ng3M6xivLzZnIGBOfd7+DDyl10qFW6powoUMW1vi62ZbS7WQF2bmKI97Ss/ju/s/kp3dJW/Gk2J9yz3h2tUr+6ndLc1L1yB/1Qd6B3o1sdIREt+hpBkKdo0RpS2t5hCoK4rNlDEW0570=
Received: from CH2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:610:53::18)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 03:02:31 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::dd) by CH2PR17CA0008.outlook.office365.com
 (2603:10b6:610:53::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 24 Jul 2024 03:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 03:02:30 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 22:00:55 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH v3] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
Date: Wed, 24 Jul 2024 11:00:36 +0800
Message-ID: <20240724030036.1350316-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d7ccce-d693-4056-eae3-08dcab8d0f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VWbjgCD7+j/+kCoa2Ob5gLLBfgXXHDCJelkLbh6sOeHEqW5qrL0UJye8OgHW?=
 =?us-ascii?Q?YtV+haD7IqtbnqilQbvtW4PG7h+53w4mGpm43TkjPeEBB5a2UD/fZvmkDT2S?=
 =?us-ascii?Q?VXrFpqnXrH1NhI1bSVlApE34UC7DnbUBU0ewvxCforAQtdSjBQwS51Eo9bxU?=
 =?us-ascii?Q?sz3eoR+Nax4pfJ50z0dourYY0GvE/rB8QiLvRElg42cRHi5zfaSuSSX0KbQY?=
 =?us-ascii?Q?ysOzDS5W6ObH/ZoGv7mC+0cG6GzCEfeYR/R6ZWyk4lL4GjiCUmhuii3GJevc?=
 =?us-ascii?Q?xyG/FmVXIQv09DAewuE8QOe/VYPCzwS32nh6ytExiyY10Vj3KtLcbI9kg2j9?=
 =?us-ascii?Q?bEjrkyjsQkwCzU9IZWjRH0S8ITkeeSNavXsP3/4JSvzAXna1JtrswGruvvll?=
 =?us-ascii?Q?SRTyfP3JQpMT9eAWSGZqq7w+VCnQAmf+cVmNqKoJXEOmkqL3iURggINM4om7?=
 =?us-ascii?Q?+osIfcCf8nCV2rSm1LWnYqQxa2MBXR1x5j8McDWMc5A3qmBTqKKdSRI0wDhX?=
 =?us-ascii?Q?TfI5GQaSRCPksuoheBqvsuaYzuFIJ+l2G5BgvlEfH+rxEDrmbVUZPBgMrIfL?=
 =?us-ascii?Q?B7WfWApm+g7KtRJIXHsHE3gm8lYk3ApQnT2XpZAjLtYM1INnu7t6+CAP1yoT?=
 =?us-ascii?Q?pRbSoMTHs3Df7bFq6gQ2O+/vBxmTxMY0bbFCIDxLJQ0Toj0E2cYwQYKQVoBo?=
 =?us-ascii?Q?Ryq8GesiMGI7syfUyQglw9SGeWwNDLAfOVoGl4iXWM7HQAsrlwwaiHsFZHf2?=
 =?us-ascii?Q?G+Anwl87/UstX4Oe+2Qe1UFTPkXQG2R4kCqyl7s3z65eWuD0NhfRqcQBRgr/?=
 =?us-ascii?Q?miQdJdtI4n58Qq7U9G3z/7ZXCEO3yprDpDcN8r58Z+auc9Rrkr56GuQuAeFL?=
 =?us-ascii?Q?4Jm9s1PIfi+9OAoZ4iNGu7TKed302yNUJhXwHNEfh0Ib2JrPIatePAMpJV0q?=
 =?us-ascii?Q?Zf4pkb4fD4VIrFYGXEgt8rmXKwlTNJGVvi6ZDhqnUpoLlY000dDNFHhAhSa9?=
 =?us-ascii?Q?2FbmDRDqAh1eou007OPO/Wk0CdeZiSxilcJcUclNTi20aRgUKlABSEPY6Rok?=
 =?us-ascii?Q?twCx0AKugVAYwECtuXApua9Ixm+7GkLnuvl/OlCi0GEnOE14Esw+0gAZqkxH?=
 =?us-ascii?Q?rruMtTxE8xa7rSlHZmeA1s0zdRvHTajdXg8NjGMaXH4e6gX2wNHXB/E8jed4?=
 =?us-ascii?Q?W1+dACg7pRTABQRJJFPy/UkbpJlkQM0CLH+S6baduSKvGMFbLiAQBRgZl7iy?=
 =?us-ascii?Q?5gW8Xb7/JNSrompc/7DsrBQ73qQmADzycfaLja6fI1EKpUVvqg65+jyqZ0Ad?=
 =?us-ascii?Q?BQZr549wfrmU6DPUm18W6yPFpXPhTfFp0Wmv9/NB5jBZAQ2qQydS7BWZUNDn?=
 =?us-ascii?Q?LjR0GvNdFT9qEdcaHeDWfw8vn4/6HPDAR+Qd5573nj0vuDUtXEtRby3anwQR?=
 =?us-ascii?Q?njexPncfSmzg36DF9mphHmgeyqRwJMj4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 03:02:30.8833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7ccce-d693-4056-eae3-08dcab8d0f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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
the new generation token.

v2: Check vm->generation instead of calling drm_sched_entity_error
in amdgpu_vm_validate.
v3: Use new generation token instead of vram_lost_counter for check.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..6c6170f0f318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (!vm)
 		return result;
 
-	result += vm->generation;
+	result += (vm->generation & 0xFFFFFFFFULL);
 	/* Add one if the page tables will be re-generated on next CS */
 	if (drm_sched_entity_error(&vm->delayed))
 		++result;
@@ -463,13 +463,14 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       int (*validate)(void *p, struct amdgpu_bo *bo),
 		       void *param)
 {
+	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *shadow;
 	struct amdgpu_bo *bo;
 	int r;
 
-	if (drm_sched_entity_error(&vm->delayed)) {
-		++vm->generation;
+	if (vm->generation != new_vm_generation) {
+		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
 		amdgpu_vm_fini_entities(vm);
 		r = amdgpu_vm_init_entities(adev, vm);
@@ -2439,7 +2440,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = 0;
+	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
-- 
2.35.1

