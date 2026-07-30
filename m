Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95005C55165
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 12:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0D810EED1;
	Thu, 30 Jul 2026 12:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PsbZoqQM";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A9810EED7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 12:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcxcvYtdilvhrAF7GmNkhVNJm9NVFke+ebonvodsOTM6OTBtQ/CQB64S2kt2RciOe6lUvpjf7DI2oAGg9yQs5EMRAwqTBTeTifr6JZAe1ofzivxYT+XAZZhzwS58oz9uqXHicHJjoNtST+NZ/EYnHTFX0vADNJfAc/HDFml4uw864FsTnpL00XWZkk18M3jpx5qlrQ8XUmt0/XERrJ5rBc6SPn3P7/IS+rQa580PaueL0W04OGDF+DT3dLp5Xub6rM9Yb2xIF6yTp4IQPQQg7fUky3e62KJbbrDnBryz/xIyQsnJSqd6SA5kH+Fahud6yZ8ttYgcK8fOYnRGhXGoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9e4YhnCmSUJC+7MaV7y5u8fVeHrmh1P8UcPYsBlg9k=;
 b=mc3puWLHsfS6jGPvsubKN59+drOsJZ/vf1bz6zaIV/o2AIHb/a83UIO4ZAC9NrIGMYFs82V5IDjNoN37uBrvVeQ7NtkSfeyx2DJrm5KB+Ry43I8i0EY8NQvmU8D49iyy4+6ZvLUz+Jg29DMW6MdgMaWqyJKo3cJqrNo/PIvZaM4hHvt44bs7T0GvNIp+xRTRGMWwXFUWw43riAQG1zBNMTtqLJry2535wUUptWv91XSlepiJ0R+p6eaSfENJ8M8ISvnO1Ommvj9v7462vhWeruIOFwnRBlIizTElYWAvj2Tj47SZCOmmCbWRFiSZXpbc40xIEHFL48NOdn1IcyX9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9e4YhnCmSUJC+7MaV7y5u8fVeHrmh1P8UcPYsBlg9k=;
 b=PsbZoqQM3HmM6FvVYTl4te0ba0DV25a7Slu55HN5H+/8xwzi7r9dB+Fja52NPpPYncZFOr6NTFN4zhE2Hj4cI7pJYSjgJghvqI2SRYrIQbYiEvlKSDxFu867+w70pW0LU6VuVlY9r94gP4lgMA9GXwevdsz053LhFd3QkJLg5PI=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 12:48:00 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7d) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 12:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 12:47:59 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 07:47:58 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Candice Li
 <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: fix userq VA validation for sub-page buffers
Date: Thu, 30 Jul 2026 20:47:23 +0800
Message-ID: <20260730124723.3500677-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: fce2e12e-5096-44d7-78ef-08deee38c977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: TZmMb3DRiBX7l0TGO6UBrpWRZgwlfI8GWCRord0x9aK2wEWj5v3KK+FQsF4ipscpw6A9sjS/EAocTHNn9CVIEFarhWrWjRlZeP/kvOORIw1Kvj5RCsvKmh+fQ8LTKpS9aH1ScTBALQeq4KqgzaRYv2extc1TyIeqUP9OIWqQhBN2D6qhwRTjGf3ou6oyWgSS8H8q6IXU/IEY3+QTrv4A/J3/2zwIO5pCCitiH5xQ7Uaid3ZKBg3zi3xSOrzXPYCVrCHSOBKG4kYyEccnU5SXjN2L4RZmwpdBhL1QAdOx4yloHgm35a3tK6PAz2oN6EDuFj+UScvnXppHrhmTX0gKutZ5FaNNsIpt0JLunHELLrZzBMGHsZ+yLXoQqcmRplWvalVIw8Mno2Aox9/OErxrCkAiFiBeuQebnPp/Iq3rq+kVLt6xartEO1mGM7OojtgDxs9lfNBlftJD3jhdiqgIW80cNT6HtyJh/E5RPJNwOdRl6XiiiZntUtMgIPrnmg6tOa9uV5BNuhVpY7lmp3C3HsufYZIshTwmPtX5g966iA4T1/lsvXmNq5qabYk5cfHKmGkxn5pTiBbReCGTqIEakRd56CMe7sEc5hk2dngJSjI3IlPWjz7Yww9y4zjcGzUf/SjM8bMfpa1pO0SK1RwGrVNngKZkb47wU1a0tPN/CbP3mj9kwXypYSwvgKlOmmUD6bezwftOz7ZY6Un32eVpBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lu83HJVgCYIAl74+xdqA3GuUmYQ4+iyZMww4KknpSeGpieVM1J91gIT9Ijv3FPmqoMChfucL47qlpuKe3oEBh5j5LTjPTNqIJAq80XyjcdGbLZ2C3LMw0DkVuV4PiJpnBfIP/RlfQqZg1CK7XIwN0ZLFdbmw4e8uZwkAwDvTbtCmuusnim5D1VTJXSmDSDqHJnaUhPTBjPcWEdxudiKdLlNWeVV/ZToffjRHbSRrFZakggcCsLYfGo3mwQoif084T5sYyQjV1alK869uGjwjQ4sgqYEp34J4WBnVGcZJJ5+yTdP6TEp0oebuypCXhXAxBxyyo4Wh9DS0FEpWhwpGWa6lHBUVlLkDMpuKkMYFDYWPT81XuI+6go9pOXhu4n9ec1xf2hy8JpJLHOhbXVVNdUl/cRD4CekasnokHKGVtHr0/trleOj0PnkLmTHHB89X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:47:59.8399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2e12e-5096-44d7-78ef-08deee38c977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

amdgpu_userq_input_va_validate() converts expected_size to page count
with a plain right shift. For expected_size smaller than one GPU page,
the computed size becomes 0 and the range check is effectively bypassed.

This allows sub-page userq buffers (e.g. EOP/CSA) to pass validation
as long as the start VA is mapped, without verifying the full span.

Fix it by rejecting zero expected_size, checking overflow when
computing end address, and deriving page span from [start_addr,
end_addr] inclusive.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 25 +++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af7575d..652599f0899024 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,7 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <linux/overflow.h>
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -238,24 +239,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va_mapping *va_map;
 	struct amdgpu_vm *vm = queue->vm;
-	u64 user_addr;
-	u64 size;
+	u64 start_addr;
+	u64 end_addr;
+	u64 start_page;
 
 	/* Caller must hold vm->root.bo reservation */
 	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
 
-	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+	if (!expected_size)
+		return -EINVAL;
+
+	start_addr = addr & AMDGPU_GMC_HOLE_MASK;
+	if (check_add_overflow(start_addr, expected_size - 1, &end_addr))
+		return -EINVAL;
+
+	start_page = start_addr >> AMDGPU_GPU_PAGE_SHIFT;
 
-	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_page);
 	if (!va_map)
 		return -EINVAL;
 
-	/* Only validate the userq whether resident in the VM mapping range */
-	if (user_addr >= va_map->start  &&
-	    va_map->last - user_addr + 1 >= size) {
+	/* Lookup guarantees start_page is mapped; ensure full span is covered. */
+	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <= va_map->last) {
 		va_map->bo_va->userq_va_mapped = true;
-		*va_out = user_addr;
+		*va_out = start_page;
 		return 0;
 	}
 
-- 
2.25.1

