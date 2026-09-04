Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00CCC624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 13:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CDD10E423;
	Fri,  4 Sep 2026 13:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQl0WfMl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E281910E423
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 13:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiwaOBnZ8pv3tVnk0XI1R68PLedBtYvH5ORnBCVUgtrCKm/7kTxmNytQ4O818XBHDS9cdHwtkxCjh3F7vDlJIqm/MAIwtJjy6tOG49vEji3KVIEPGBRevCnZTdFoIFhbZiL60atj0L50JTba4zm8mmy94GmQlDDASn7THRpQjE7Xzascgvd4lHALQrSUCngo+poSmrhR0BDrp5la2zSDZy+L5zVscGYZSMByDmnbipacRLVON0PFyVd2A9z4MaGnnQ3gIj7OC3A572qPO2wwAdQQu7yBLWlIsBGtRdHM7KX5c6AWlYtzjM52/EoQXLQt+IZhYb2PkznDHxSQj6VHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E/Y5EZMVZZeDtnXwSCC7VnEvLjHEmIVbDx65Xv5Nd8=;
 b=nLmUn7d8uY3lRuTpT1Bnah7mYnAlPaoQPsifzcy5BoqMB67w6GJ8mzbXg2DRbSO+b5SjhMQOUefZgpKST8YC4k5l+LVyJeN6zivwVvEGZpi9wCeb9k+anAvIxVvbzQhSWzMruAHG8RGb8vEKqP/DzeTrpPGI1CekIv1UnDM8ajjmGxpysCLI+5a65A6kw8bIfRGgZT90lZtEDAEwv2zmOJ7SAKnb5O+S8q6L7lF0WvYp91NKMnuyysS7Z8k48DeKa8pbd4GGOxpj3QCXQxvavCY6nbcovbRhkp3la6Srq3mkdVa+bkFzbIIytDqRP3yqgdNjM7O/s5rN7gI3Uu1evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E/Y5EZMVZZeDtnXwSCC7VnEvLjHEmIVbDx65Xv5Nd8=;
 b=IQl0WfMlous9ERLLEqHadEs84Wme4QdF6ZnTfUj0qc2zq/h/3a6WRmUCeunQcpkMofjUgIBSMA5Ph4NVIiUacMMSPwXUBMaU5G4RacbG5Pp1OTi4ISN++P4YRHWdEYT4sOkRYYz1SzC35HQOyHpdv37V9wy5i09MLzJ7I82uXHI=
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:59:48 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:34a:cafe::2a) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:59:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Fri, 4 Sep 2026 12:59:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 07:59:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Disable L2 trap handler when its VA range is
 unmapped
Date: Fri, 4 Sep 2026 18:29:23 +0530
Message-ID: <20260904125923.321117-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
References: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb2ccf1-688e-4156-1364-08df0a8466af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: U8qe2I/q8wxFA3w4zpkafMYDNGp4jnMEI77YhAlJ/ed7MV2/sPEYzU8WTYya7MrdufeEsbtCdUGqiJXaGH8DCb+J5fg8/HNlVkLrJLMWG/PCIfWAm0mFCKEAeWfK3UgvwX9nnWi1cXfXrZeGxoeEGqhoyxZiOs3XehFpxDX+rfjxNPgIX2129R/4uuFMFUpPp4AdcMHAGSJ2hZDudzopJK9ho7pG+11qQdqo1A7L8fiOrGCrueQCYt+EzO5l/Ovi4u1afJe/1rhk0+4yq2+Mg2uw1SnSpSxHD5keUw/GZQQSqR4hEqS77ufTu58/kspp/RerFt3DP8SoTkxoDIePCiobueRt5gMpSu8qJHhY9La7tDLvtX2rWx0EGnlO5YYTX7egl88UWVl7kloHXCnvFghrTFZPXxJARe+5TDsGlR9E+ekvJDFMNKn6pEszfDclb2w0M3ir2cXgA61KtxoxJbu3eIXv5aPOMRXy7L1jFp61E/uNBMpxgXBfiFisddkQozos6bUgblCwizR3J9o/rzWh16Ii+iNX/HMm6dqpAp49wmFx+TkdNiGH+N/13uKPDjkuH5UpwcyyVw/7pjHbUHNKagn6bn0ynpF8cMWLx/mm6qIwYn6KqLaboffjLT1/+PJntOa4hfVidP4d0sbR22bCMGyRy/W/NpC3mt0293B8IOuUOj44doXd1xPyANCGtC9muBgsDAHe57mgwMdy1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QIh/coX437ufQA8UuJzXcwm1uC5irJT4+Xftos7TeyEvBJ1qB3O2G7hh9orONz69rLFSAFJYQlpzST1SnUP6FMxYjrCAF48eZB6jl8QtVWPaP0A29dY9uZNYvMVejcyzZW6tj55EeHlsldtYvFYyXkFOty4mbOix7f5cGOTtrlRyiVyFA6ftmefnY9ea1djIUS4WYSmCNlSbdRw+Qpw1pmC/3S6vW766VucPXRbHlbiNXCCNSEnHb2PLUeECQDvMghdo4f8duWRfMj5wK2tPmioo2y4gbL7vo2l4otALKLtIAu2+Q5Ts4A9+Ifs3Bulq4cwr153GR5GvbPG+Q2x0V75xFHcRprOWnToUO54JklDsXS6Cr3GeuwB/rdYiWNGeNPGKc6eeVhDjpQz6a4N9OsSxQ53fyBKzZz4LnQ2XJD0WKmYCmN/pg4eF1t/Eqrvr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:59:48.3313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb2ccf1-688e-4156-1364-08df0a8466af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
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
the unmap to proceed.

GEM_VA UNMAP and CLEAR must never return an error — this path cleans up
silently and lets the unmap succeed. Queues are marked INVALID_VA and
will not restart until userspace installs a new handler via SET_L2_TRAP.

No functional change from v1. Rebased on amdgpu_cwsr → amdgpu_trap
rename commit.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index efc270e99b4e..82c5d3bd8aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -47,6 +47,8 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_trap.h"
+#include "amdgpu_userq.h"
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -948,10 +950,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 				     args->flags);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
+		/*
+		 * If the range overlaps an active second-level trap TBA or TMA,
+		 * wait for VM idle, evict queues, flush TLB, and disable the
+		 * handler before the unmap proceeds. UNMAP must not return
+		 * an error for this condition.
+		 */
+		amdgpu_trap_handle_l2_unmap(adev, &fpriv->vm,
+					    &fpriv->userq_mgr,
+					    fpriv->trap_obj,
+					    args->va_address,
+					    args->map_size);
 		r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
 		break;
 
 	case AMDGPU_VA_OP_CLEAR:
+		/*
+		 * Same as VA_OP_UNMAP — disable the handler if needed,
+		 * then clear all mappings in the range.
+		 */
+		amdgpu_trap_handle_l2_unmap(adev, &fpriv->vm,
+					    &fpriv->userq_mgr,
+					    fpriv->trap_obj,
+					    args->va_address,
+					    args->map_size);
 		r = amdgpu_vm_bo_clear_mappings(adev, &fpriv->vm,
 						args->va_address,
 						args->map_size);
-- 
2.34.1

