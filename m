Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42C6C5DF89
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 07:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EADA10EF1F;
	Thu, 20 Aug 2026 07:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PGQHyV1L";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B12F10EF1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 07:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R58WuinjRT41vJQExufbDuxgW/xlimSbvtkswbDXkwW6CRxnL/osbkHQA6yum4kT2hVidrcHaJUEGsMR1VdeP4uFDdhyv47lm5GC6wtLn740LC0uMgsA13xhn9ttELyIhey156f5sE94SfHekJ5uqx8Q7xl23WtvRJNCqBzU/C5PZ98kyiC7Qg8aDZR2ip2Sy0jjyQvI2bWfjxfSxMducQVv5lJ2H0fz5GqKtaCMeCyF4We0Axelt+KVtvXFD2is0qg5SCE+CuqZ/ne+neuO1FtQGucm/xxHp879Kd6Zy89VkEbvFlvHyP3L2rmNAiEqhBnP0gcAyIiZvVDyTawAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ic5TI9zjsHiKg+vVyxdk+5xolLmLy886wZOkq5s79s=;
 b=HijN2oWjaFRw5a14fwL7Id+HkfQ56pNiBd61jMACwwse+9fWRsGivJjZBxBoGD774tJMj5P+Wkt3v6Qn/q0W8OO/Jo9KpfBUuPVKeqRQHLClkj3blFidZGjZPyGgzl6Tx/5HoJEh6hZ7n8yAc/mzHovi2mMRp7F5UPAPuFhUWUeGPAhi5qGvZThGK39KFUtP4n5QB6O/YOtm7BmEU7GsGJEgmTETRaHvld7K+XSs5Vg4ESe/haO7T0AJmfdAgCVJ35QBY8lzZL+0iPVbRO3/G3Mb4BLlN8ubvcuH/HJBCyJ35WJplh7zrfbhM+8LGJDDzkBkfzMB/zYc6WLGAhRDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ic5TI9zjsHiKg+vVyxdk+5xolLmLy886wZOkq5s79s=;
 b=PGQHyV1LfCgaa8YXK+9YXrUa14iBW2ssf8amuIn9ZO74buKub8I2th/CU7mnkEzsDbSziIZGI58wJHlkqqe1dx8YAw4Do9DjLB7BPTxeq8JttDLJZjqHpjINAAR4f92TISJLLRyMVDpoF7FWfSTwYqId7U0JLgFC/itAdS3+dF8=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 07:02:47 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::25) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 07:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 07:02:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 02:02:46 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 02:02:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>
Subject: [RFC PATCH 3/3] drm/amdgpu: Disable L2 trap handler when its VA range
 is unmapped
Date: Thu, 20 Aug 2026 12:31:43 +0530
Message-ID: <20260820070143.3916329-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b91b11-d4a5-46e4-2301-08defe890aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a2hfOkG150RvfECS7OGETbkmpwzmi6Slo80QizOaItyq81HsWWp4U7+WDB5YRzSywRZbQDYq4pV90lkdmRnWxKQNUypU5Z/RN9T7vgglLoJfTu/wOq1k08rlBXVz7ey9r8D9xUj62rFbE/i1jQI9x+gO4L6fun+s2IyDyRCB+F2ZnchDtqlbrggQyLbUrE1ejdUcDX1/licEtEdWqWt0XOgR++Zy/33KcJBCbJRJzCah/+96yvyigFDd/zRDatHhLFdXTM2eio3NQEGn1E8bj628pAkDHE5wWTy0Aw3KTSHu/mjejxU4uD9apLqIuWKNPVcsbT0bwdu4yEPFsC4D74ijp1rA3ODYz2Oi8mfZnLzd8jBYGBuJUEhmeaX2hkMQhgxlAiFTG/Z449JxXs/471Argz9pThY/eDM87KKOXD59FEhaS4uz5jXmWJi9tka34g3LTJGHgzoR/tIVlvuwATrvZd/uCu8tFBmKkM5RrrqMy2KUNDeECoMiz9dP2iYHxsu2CwDoKwd7kvDbvmA9T345h53Vwya8hxFtc3UP5Zj2xeaaKQX+7wqUasELY4pRHElX4i8+pXo4/8JdwIftTldxwNPlU/vFl8wqybcvPQ3WpbFJp1iuaNdsZY+63wZRShXHmEdfRbWsktxNGD9dE1CdGpA69dL6nV/AiaWdaWxlHKsnwK+1Pc69kZ2/bM3Pq8vwZTgJMQKEnZoe4drM6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0KC3jKJRAclyk344iCqb8Y8QfnPs4pDwVJQw6CrsFBMngKYLIOndTkETJbnRpcD0hjA6S2vwEnaDhZJwX1SMOVxa+M6Ar4d7+ZFWfSbcPrjYm15rgzEOYmf0/IRtRuT3LdHaznzsYIGMOICupFraoj/W5iWVqpdo3Wr5VS6Kg+9laSeduvENSPi2vZoUcRelv+w3DZYkkQSR61dGTcxVXdVI/8zHXhsOwOAr+MuVteAOqceXYjJ9w1oflmfU6KdvzeNG8DYc5ylVX+VZ4dMgtGvWMER/RPLxsszbNcJ0jvElKnk1b5/pXQatWn7waUOB7FatqrBEGPgmfx0/SzY5DErrfAhXjov2pbRKN3q4yHN/WR9oDDLLJnEArgaa5n77ySimWUjPN0Hef4o9juD6H8agzrp5Lvc2XSNz/otYwhOIV+CU4o74EhYq3VnLkgIB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:02:47.4154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b91b11-d4a5-46e4-2301-08defe890aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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

If userspace removes the TBA or TMA mapping via GEM_VA UNMAP without
calling CLEAR_L2_TRAP first, the GPU still holds a reference to the old
VA. The next shader exception would cause the GPU to jump to an unmapped
address, triggering a page fault or memory corruption.

Intercept UNMAP and CLEAR in amdgpu_gem_va_ioctl(). If the VA range
overlaps the active TBA or TMA, drain the VM scheduler, evict all user
queues, flush the GPU TLB, and zero the TBA/TMA slots before allowing
the unmap to proceed. GEM_VA UNMAP and CLEAR must never return an error
— this path cleans up silently and lets the unmap succeed.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I1f103c586c4c5ee444d08bba93a3b6a93d6de98d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index efc270e99b4e..b51b691edb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -47,6 +47,8 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_cwsr.h"
+#include "amdgpu_userq.h"
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -948,10 +950,31 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 				     args->flags);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
+		/*
+		 * If the range overlaps an active second-level trap TBA or TMA,
+		 * wait for VM idle, evict queues, flush TLB, and disable the
+		 * handler. UNMAP must not return an error for this condition.
+		 */
+		amdgpu_cwsr_handle_l2_trap_unmap(adev,
+						 &fpriv->vm,
+						 &fpriv->userq_mgr,
+						 fpriv->cwsr_trap,
+						 args->va_address,
+						 args->map_size);
 		r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
 		break;
 
 	case AMDGPU_VA_OP_CLEAR:
+		/*
+		 * Same as VA_OP_UNMAP — disable the handler if needed,
+		 * then clear all mappings in the range.
+		 */
+		amdgpu_cwsr_handle_l2_trap_unmap(adev,
+						 &fpriv->vm,
+						 &fpriv->userq_mgr,
+						 fpriv->cwsr_trap,
+						 args->va_address,
+						 args->map_size);
 		r = amdgpu_vm_bo_clear_mappings(adev, &fpriv->vm,
 						args->va_address,
 						args->map_size);
@@ -991,7 +1014,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			}
 		}
 		dma_fence_put(fence);
-
 	}
 
 error:
-- 
2.34.1

