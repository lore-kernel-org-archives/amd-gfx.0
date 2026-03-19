Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7CE1075274
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D64C10E8E5;
	Thu, 19 Mar 2026 08:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X51z3atz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ECD10E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaMdAPLln8E7RT5PeuYZ6rXespieH04ODev39jJqxzc0fCdZtgqoAe41sutVV3YBjd/pBdhRKfsavIas3L8FwXkMdR7MZOORs9T9eQc10JVVZkJcePzvDPXSsIh5VNT6Qgy6cd/bJxuHyRABUAAdBpvCmbF74DFYCEnNspAYEJnVk8HTvbpayJ5t7LpCvyMZxigIYq6NNTSC3VSZGF1ASEpw0KffJDQTWgL+UjOnS8MPoCHRqeZR6psT3krhrTg7Ut6XLrt9StG1ho7pDsQlgFIYCjgYnoMeVvqGp/ETRf/TijZUbfHcHqNJhiNytBHCYGXJi4P3K5L8kCTc5nd30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HldSnO1QCl38IbviO0YOi8qQj0nkdTgyK1zxjGrfxZI=;
 b=IVDHNPfDG0SsaCwW/osSOLSN7gCm6XvHoAK98ZSOYGdZ646e7SfYob+oy/P9yNhgTKD2ndQtNlCMaSpvaEi9ELbFSGR3KwU+AsSZ9apNwS/96LhSSaEjn87mjtTtmQSxamwDyf3+0vx6AnF7oUpq2mOuKNnLoauMFbmGeyofDiQwFYBvFrDphv4/nBaxQiY2KQa2L4t33Zwdsyf7UF854ztEum7A4gcowUqoktKMlUb4WBEwH8EzXXbLdJas/mmIvaJjZENg2usTeIUXqJUmQaF7DILWVUCHZELAXP/sD7RqGwLq7dyJUbe9VDAEkb5zaIcp4QxmtZhlqRaqVyYrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HldSnO1QCl38IbviO0YOi8qQj0nkdTgyK1zxjGrfxZI=;
 b=X51z3atzAN2AjlJE4lbwtDD69eAXms4RAjgWhvkqC+6OV5XCGDxygXtpZjAoEIpr+e3D2Abnou5s0ZKP1WKpd7PT71xALLWkZycVsZJ34jEWceyBuC8FooomRjPx2yJMF3AsOVEWcSh69gxXGSIMlAHmfDdTo5Q3zxkAFebqMRg=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 08:22:02 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::34) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 08:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 08:22:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 03:22:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix the tlb flush fence leak
Date: Thu, 19 Mar 2026 16:21:48 +0800
Message-ID: <20260319082150.3324177-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: f47128ad-c5c5-45d1-d99e-08de859098eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UDB4cUagbwC8vpoX/nprFHMnDqvF8IsUZMwr8TXek5v77xwDU5YgA94BspK+ItpKTxW/dhDCJ70mSVKNQx1MgLDD5Don8Q6QyH/SEvI5z9662Chr0jMps7xm7rzZrOIE+cZdrZdxlPTQ6ngDO5p2J6MqhzRMSZhjQrmtthoteM+wWlhzPWSrjKs1dAn2d41t0YDIaK+g6fhvYOjY/nAV+qSc4cs0lJeIgyGaliru6b3eoCg47VgGw4vIUfAWJF56LOfuZO70f9W6k7dOcCrAn0lQ6pPbFqnTJJgMypWw6nh7rgVzDBEs/fjKil8zJEoH/IS31HdDpCj3tn5xTsMRtpn7vrpb5IOrBtPB6qebumrToW9VDt6XkdH1ov/uE49Q3t7LVGdYjfONnCJX/pqDc9bSX5RBXuWAnoVpbz6qbDyC+wMb3DFnvyczUEDNyg2xy6cRa8ESh5GI0W0Zr2gOrgsHRasItm/3gxexJxPSSXUq+fq5qbCa8WK+SEPREUquUXIVJiqt0EfrTrOmtUPB4ffOthRm9eMnDxVRKIR9w7YCv8I7Nx9Rt6I/9rXlfG5HSCK0Hyi8p+vo2twBnA/Q4IjLnmzQ/5dEPqi9NfVXPpiAsxjTSed/ykIBMaUMOZ9e3TZuasdH2N+w6Ox+eB2QlYIFlZjapko3ZiURkWInwjEi8rQbTftd5ylA1aHR4Q/wJSLWXWnFk53Rl7VNbJSC8sa2XvrXdYzEkAo6+lvVwv/6CLSJwhvUY3KVO1psEz1TzEXkc4MV8C9614NWIGMqtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: emOJORTkcY/Em37VMHePqHmAmZ/xwj7rsUx/3kyhQhL1WCosoEWx9lLzrV8Pb+BGNvICNs2i2lC7/aUB38KIG/srpNq+3uEbxEfQvDHWYeFcqTPQorRFIKQeX2CnXlKDtzZ5bh6L6ZBe2+tV3eFytBHQIYsp1dRs99U1MkpkGxQp6PjvbREghKfoNJ88H+pA0X9LDZzG4MWd8lQy9gkVihrN03qSkFDxgQJVgPgZaBc3wJm4Tq5QkeRwgXmLdWfhLPj+LvawZ6zSF6AemkmPdQt4i6mvpCmsFZRmEnbb0F72cLXHPF3cbTw2adwNtDJ9MfS2u5DPl/jlv8InjbK4d0DYvGFMpSwVrX4/3HkJBWO8Z67LmGhHeryJ++BJfIxGH0Oi4NA7e7QZkip/VuOnJBoJaS/FuZjmHBSq0fb2rL37OfXntIq9OFloVqVo6tL3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:22:01.9255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47128ad-c5c5-45d1-d99e-08de859098eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

The TLB flush fence leaked during walking over
the free mapping list. Meanwhile, the TLB flush fence
is referenced by root BOs reservation which is a false
leak and we should mark it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7ef0cb6bcbda..1cd4c4217b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1560,6 +1560,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		goto error_free;
 
 	while (!list_empty(&vm->freed)) {
+		struct dma_fence *old_f = f;
+
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
@@ -1572,6 +1574,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			dma_fence_put(f);
 			goto error_free;
 		}
+		dma_fence_put(old_f);
 	}
 
 	if (fence && f) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 5d26797356a3..93b72289e7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -23,6 +23,7 @@
 
 #include <linux/dma-fence.h>
 #include <linux/workqueue.h>
+#include <linux/kmemleak.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -106,6 +107,10 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&f->base);
 	schedule_work(&f->work);
-
+	/* The TLB fence is referenced by dma_resv and
+	 * the resv ref is the remaining ref, so that's
+	 * a false positive leak.
+	 */
+	kmemleak_not_leak(f);
 	*fence = &f->base;
 }
-- 
2.34.1

