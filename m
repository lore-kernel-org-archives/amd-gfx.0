Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3851CD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2337510E56A;
	Thu, 11 Jun 2026 03:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzLk0wW3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE71A10E56A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npDncF2sE/1iAJCOyq9G6QHsT2M3uNqDEGXj8ZlIkeruMbF4xRt0QVwfrzsI7t4G6cJeNfVvM5LMeUEsmZ/5JjE4mHmTyrhrhquRGDzBbIv5M1H8hax6pkRyJFzEz1dSiDlg3zhKYJaS8X5/pAbjvdLq0TFJaFNmITl9E/stobVnvzO1Mn7R6ORXTdcnS9mTEIOhL0Yh3x4zfD0JvO3iR5zP4lz/w1ryENl7gWTh6vwzmLUtlOro/Vv9p+H7/SCn3vnKFlpXuSfnwcBhLcrWPGPDqJRQwHvfTU3JMelZrRj8QLW6iOevR8WH6cLqmN9ecOgtBRcgtoDDbIdKwa2txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S41+f/eOgdh7lWzk4NiJC8DDZ8fF/Wru4Y9hQU3BI0=;
 b=ZM/RV+1a3eNW7I/zRNGD0kLs1ay4SnAiBih6JIg98RyRx8zFStaRfw2FHhJAyOHzC5PXcSY8yskb8G+36mjogEoMAoAXSYBvZt/+ux7J6cV4cBdmh3oBW9YzeROiUCCA7g/FdCoi/KtCiFmxIE/89jVxy0Y4QknBWR6MBh/Udlhtgy6OHOqJuHuI70qxCmuKMJY6uOg4+W8SOm4aPwZEX3licltdAgynxvuG/fWbdMMdajM3caZdTsfqdqMHlUqs/6lUvG8tQYF5IKtRkmXkZyMDP03K2OXf2Ulo4ywz7I4FTXnSjY8zwVsDBcuub6h4BLEqK3dP7zNUOWP30PWRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S41+f/eOgdh7lWzk4NiJC8DDZ8fF/Wru4Y9hQU3BI0=;
 b=yzLk0wW3iYq6FYBJPGNjlkzs/T0EUzTIGpX/FmeSFLGMUWf+RnM1mn7SoUqfqw4jiqzHOvLWlsFeDFAEb9HiW2pKvqQf7v73oiVyqZYJnRqPpiaRJ7+DJb5erX884w5QxCgpr7wDtgtf9PzGJOS6uk9zoZ4N8KZ7yMKjFvVZekQ=
Received: from BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 03:40:37 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::8b) by BL1PR13CA0201.outlook.office365.com
 (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 03:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:40:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:40:37 -0500
Received: from neptune-v2-01-host.tail61db7.ts.net (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 10 Jun 2026 22:40:35 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <mario.limonciello@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <victor.zhao@amd.com>, <amd-gfx@lists.freedesktop.org>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH] drm/amd: add AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU debug
 mask
Date: Thu, 11 Jun 2026 11:39:53 +0800
Message-ID: <20260611033953.362305-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c72c7c1-188c-42f7-ddfc-08dec76b3390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sSo7avHdCI2tCqM0jx13l4r1S+yfkSWTg+8ufd+icnCOpd0geGkAxX2ZlDZx5qsvK3an0dVKwHugtNy+YARuVGtLKc3lVBjEqcr8FCJNVV236GRqHG8ixkHRnPIcqemdpOUxEtGxqCwGD+MtdcnhBnLe7YQ+RnJq8f0jBHj0odC5w2ECRP4rYsaZPnv0E2F6oMi4vG7YPmmUcGPSGR14cOhDryNPuCf3i2FfG8VZMyXCq2bGS1bs6yyHlXWnMKllqyKYvmCUPKQqC1nLoUQS3zZdJDGStN26D0EAVbziFrnYdec0LErLknNI8gaPzosTeu6FjTOrHFYk0kFPYEtkQZcpTn44RM3F981y1ObY8dC1VxSQUuIlhB16P4J1ColAHlihKsRZ8aBSe2rQcdAct6RGRaISW38AQzu0sQcp7ejn59Z8HRnm6MR87d2kkqaxOexn0zM8aTnqCD7NOCb5KBZgw5yM2zUmGuDHJpJPLOvAtzLE18LTXAAN1FuZ2irnqv8859Y58am9ghxOSWxMyXG1l0INZQtowOkyGJl3i8qBGEIwBuGom2riZA8s1eGr9dGaIFRm80ZE/A292S8xnOKWzzXLVH4RWBfkStSvLHHCuRI6pQYx207EByyj+d+72bYI8Dqiu7izVW1pZF9UsD8zIZ1UuxKwTtZM+h7gJXxrX9EFBeq9FkeKidjiSszcUUk/vff4hx3C5h1tbubYPLPhEx7v+dZX5ciaYWLcZZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IC0EroQLBI0HKgA4OEcPt0Hs98/91j/hb7lCdnIQ9lvLAAhuvSpri8V03ic6NRclhLsEwgsDlMwds2jmoKKx1AMWrzmRaC1xfdjUAmBr1+YtxoFYuT/evqNbbf+z6EvudRJf84/eQjNWqJxKcyF3fO5nNCyeUv6kxInNci2u4vslGefZ1wX7e8LRbvZXU6BAXclE0ZUvXGchs5PbJ+V7ZklPC31VdEiNdfVw7btfNU0dUVR8H/UEH2rwSSY5PqsGXyFcJ3rm5K5B8IB9uTSQe2PeV4vJHTEBbsLxp4w3YZn9/bGihioCp1YKeVEFov58/NLu+5eWplU8O4ulfWAylyXi8OfPVV8Gv0NX2bpzf++XwXHGtFWOLGCsGtwnhKN+PIIqTEdxgfgRL4XWUpehlVZuGwufzUgJvoIBmhR35en4T1v+xcz7+NjTlR8YUUg9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:40:37.3398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c72c7c1-188c-42f7-ddfc-08dec76b3390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

Kernel parameter `no_console_suspend` is required to capture all
hibernation kernel log via serial console. But when the parameter
is set, GPU will be resumed in thaw stage. This causes many issues
on alinux3 kernel.

Fix: add new debug mask `AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU` to
replace the check of `console_suspend_enabled` in thaw() callback.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 503bb64c1e55..18385c09e9d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -33,7 +33,6 @@
 #include <drm/drm_vblank.h>
 
 #include <linux/cc_platform.h>
-#include <linux/console.h>
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
 #include <linux/mmu_notifier.h>
@@ -146,7 +145,8 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
 	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
 	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
-	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
+	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10),
+	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2707,7 +2707,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (console_suspend_enabled &&
+	if (!(amdgpu_debug_mask & AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU) &&
 	    !pm_hibernate_is_recovering() &&
 	    !pm_hibernation_mode_is_suspend())
 		return 0;
-- 
2.43.0

