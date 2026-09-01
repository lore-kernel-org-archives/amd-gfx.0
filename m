Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E48C624D4
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 14:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EE510EA31;
	Tue,  1 Sep 2026 14:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b5GO2CQR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6FF10ED19
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 14:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7vO27jh37OobAvt4crCZANIcrVav8rSPs9jMaLvR4xNqlUWqcW9uuKUKeS5216RMtUM37u3UJJDv/8VeeAaoIU7DCZ0+M/IPiTndDmiYf4x5gBDzjlcefcSy9N4myKKedvAPFpXc+wdUCEBvl2etqpEaZqmYaVdt/b1xnXfBqKbAfp1KELpn/h/GRFvyHdlc3pSrP/ly2r2nLMgi8smWOoigfstkPW3nRNtsokbLMFPQnyvEo/5f3pHdVKjSFIY0o8lKOqTUpjg9EQfPg2SwrQ9zlhxQLTbjZx+uBCGn2Wl+KtBrLcjk2Doj1GvRfaVPr6wYviOA3CggfHmjTsRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxPHT/6/sBNDOmMnToa1CGQ3xK6VZuOqDBkTGnV36f4=;
 b=UPImUjap7psCtABA7OKRig+ZdX0b9Dz8MLG5d7aEjVKv3UX/MVXDbWYXunJX2lep8LUnR1PA6MHhu6SaUTWhD7EMLlTgUUKGFZ7wSujFoy7ozHJ7yfA92iXfr6U5a6uzYDJWKZi4H30Y+t4qIjwJN4g3hLx6ABz9E6pQ5pMSOY8KBqZVGR5Vvy+3cNSpBoBUectPeKeaqYgQxURW7IPCsS+llNaJFMy4WnDkY4jbXZEl9xBuH3hppnpoRjTqu1HYu8N5b7coCQim0lDrTKwy/RYVyrCZ0PTD24PNBamzTLGeEwVImn3Bes9fwxp8TULNYxLuG2LK1FpPmX8sikB6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxPHT/6/sBNDOmMnToa1CGQ3xK6VZuOqDBkTGnV36f4=;
 b=b5GO2CQRX41RwFcpGTpvbZFoIcB1iHgiaB2HHkTke5mZyshLprCqWApY6qq+FitfyWyAicycaIFOqGY/XhbNggR4Lccljew4D9L5z1eLZca6amS48CHEAivo/CEh4UQDX6GF5lnkX9q+GZuZdhyqIqmQIcMMo3ULS0w2VwBKgrM=
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:17:31 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::63) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:17:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 09:17:29 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 09:17:29 -0500
From: <IVAN.LIPSKI@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amdgpu: Fix UALink build errors on 32-bit builds
Date: Tue, 1 Sep 2026 10:17:27 -0400
Message-ID: <20260901141727.196585-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe6b3cc-ea19-450d-bb77-08df0833c218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ggv0r7fxQAwW/NEBWRYhdrsWmmoCQntrKi+70DaamX3Dq5OW4L8ckAHvlvveMCtM9SpQUNTRJY4S6K47Ijv8eT1MGFggFqa5g/BowE/8q7lGRKnAyjSw8aw3srTEFsL+Ed9iZh0ywMOKLz6MrBMgR97ogxQBAqH5SdCZMM8ptzaJd/ZFwT18cAzdVWDgK2flmbRSPycjfEm9Qiu/12EhI3emnjxmNbDews5qKl37QkD7otuKsXyFadVye6RR6aBpR7CpMw4F9eKpJafJq8/f5D+d8zYVwnNCaWd0S8iadQrT4OR80BfL3GOxj57ra3ktCCwKds96QNr/KI3UzI2PeUHvPaocwjZkn6oxzW/caIN0z7EamkybHXi8h51QZCeaCY0+6jGCaa4K2+Br1mHAgTeWhNzFs9uroNSM9usAeHWiv03rryUixh0gY9TBdTIJgngI4PTc0B2sWD0r04AAKp6+D1tfVcXY91fgwjoDzkqndDAwCRluc+T2c7k4S9XHBOFpuQsq5T05JCLl3zouI648sXS+hnfSPKMVtWF1Q+mqL4zxS/aynM7I/46NsjWs0E1Z7J/meGbUo/xvqb+U5Pt8RSCxjLDxayMx6hL93INbsXD0k7ktM/XG+0bh5o83yFSZPJFaLCmNymC5FTMbr2FBhxC8ye4etH5R+wJ4bT2QEF/VSiLmpwK5sq8fCS7eSpvKzqivb1rwyVhEi1syrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EU6CJvkjNaHDsL47nYt6A4t99tg7/eOTWcqy+iNNiYn5o+j/NNOtb0h4ds2sgRW9Qj8Jewflb3gy6u7L403VwYrltG1Dz5NXhKE/mlpMcc2NQWRhjkm3qhiDJbRRTzfO5NmIWSxrCZAQZXfOArd3jgLT4BHmA0uTJqSyCkiYDJjCC4NnT5jWAuRW+lOddEtga7PUtEhs9br0b3p5uHw320xw91ouVl84tuRGLEmmllkdaUXhhp+eqoSLTZEEiEv4rnRoCc9QP55eKBMnj7zErWkOc/ptWjKXEJJMu9ruvDo7xlAcIiiirU4iLazTxy92OmBtgfq+qpfOJl+jNbRk52M54hbxfBqumMvcGlmysBDVGHTYH9TnJgY5KfaCwqyvhcj4wHAZhLxlPvKnapJXQwdWli8VGsO2WxCFnwkrL4xR5D7L9RQ8hzf4VAdfDp/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:17:30.1378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe6b3cc-ea19-450d-bb77-08df0833c218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Building the UALink code on x86-32 (ARCH=i386) triggers -Werror failures
due to pointer/integer width mismatches:

- In amdgpu_ualink_get_wb_addr(), casting the void * CPU addresses
  (rb_cpu_addr/rptr_cpu_addr) to u64 causes a pointer-to-int-cast and
  int-to-pointer-cast warning where pointers are 32-bit. Use uintptr_t
  for the writeback address so it matches pointer width on both 32- and
  64-bit targets.

- In amdgpu_ualink_peer_remote_init(), the doorbell NPA constant
  '0xFFFUL << 40' overflows on 32-bit where unsigned long is 32-bit,
  triggering a shift-count-overflow warning. Use a ULL literal so the
  constant is 64-bit on all architectures.

No functional change on 64-bit.

Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f82bc9a9d083..ad8cc95e6cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5674,15 +5674,16 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u32 accel_id = ualink_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
-	u64 wb, npa;
+	uintptr_t wb;
+	u64 npa;
 	u32 offset = 0;
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
-		wb = (u64)remote->rb_cpu_addr + rb_size * remote->num_accel;
+		wb = (uintptr_t)remote->rb_cpu_addr + rb_size * remote->num_accel;
 		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
 					     remote_accel_id, accel_id);
 	} else {
-		wb = (u64)remote->rptr_cpu_addr;
+		wb = (uintptr_t)remote->rptr_cpu_addr;
 		npa = remote->rptr_npa;
 		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
 	}
@@ -5914,7 +5915,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 		 *     1 - PMI1 Remote TLB Shootdown
 		 * ReqAddr[5:0]   = 6'h0
 		 */
-		npa = 0xFFFUL << 40 | (u64)dst_accel_id << 30;
+		npa = 0xFFFULL << 40 | (u64)dst_accel_id << 30;
 		r = amdgpu_ualink_gart_map(adev, 1, npa, &interrupt->mm_node_doorbell, flags);
 		if (r)
 			break;
-- 
2.43.0

