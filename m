Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C335F43857
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B81F10E724;
	Wed, 15 Apr 2026 16:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OGSIdEHi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F029610E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS8n6xxTWRSo3G9zZSQycgzqKlE0uXpaQ8zT5AoqYwfEvcAa+4gWENT0V+GFl1wX3mY7X337uq9ntARe2ABLDswKbjjjwy6/6nWwwuKbcgbzhDiASDb4gVsIWbB5Z37X8H+lNJo0r+FQSwh2omwZtXDhxSEDJZ2FB7vzz8toMoBIUAy0BZDm/CYRCelm2Um0XpJIrvEkseVwZWcxewoz46dTqvtk/uDZG3lEgauGEbI+vJNl5Guf4lrezC/ibxlR+z2Kps99meAm/JGv5zpJisPRuyXIRMqrHD6/gRhi2ZuwR87NLg4o3WNkQ7aovT4rukWPPpYRQXrv3QZkzZ8uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPq88cTSaUYKNtVqpUP5wjszpjcelObLevvPK6YPomE=;
 b=ThKD3IHNyzydRmuDeV3zx7nkMnupcYaC9tF81HkWFv58r7J5yB6A4HBIc57L6CuNLbP0ZsLhoDOrZiaqWfThWv+eiJ6ZAVyQvnekUOt+ZGjtkyqCeIoj2FixszC4BUFdwvfK0k5F434RQuM43xPGmvONsxuARQfImkF/ndLYH0o0OZ3LzHs+y3D7rawJmM7gbDo67R+lLQw1UDt2rtwdtmJKTjZAUVb16V4jphUNEYTcvV8VdtjgL9PAMHCftP2u/k9lYjAbahiTsSzuGUU9cQFF7JQPqS2wST64lUjaZN0CQNYH58dGXAQgHfX0LVGNy6kyD2Ochmz1xJaKcShaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPq88cTSaUYKNtVqpUP5wjszpjcelObLevvPK6YPomE=;
 b=OGSIdEHiCrJxTWNM4sdO14SEZU6OlRkhAKYTBeh+aDQQle1AQ4kLqENWT2BIpZHnO0lgVpMu582Ahi6jz0BUnlb3EmKJAU1iNC1PLCj9CUEgoK/BMC4mSTUbbYiVpQ6NWu5FWzP8Z9mV9qMPjeBWxDP5Im/Pe0vAUEzEUF11YmU=
Received: from SN7PR04CA0061.namprd04.prod.outlook.com (2603:10b6:806:121::6)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:52 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::1) by SN7PR04CA0061.outlook.office365.com
 (2603:10b6:806:121::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 16:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:52 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 10/10] drm/amdgpu: Add memory exception records to
 WAIT_EVENT
Date: Wed, 15 Apr 2026 21:37:11 +0530
Message-ID: <20260415160711.261553-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 53437e8e-1b6b-44bd-6f6f-08de9b0925b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: w6c/99ru7ZL2e+IFSmuM2puMVNrK85MUiD7oqEn5z8JysJVU8NgcEKZzC53EiwKbcDhu8Lzi07y+nOtSfPqFy3fovurVLbrA41XmrRfz/SkwgFBl5ly+giwzpl71e2IMRgFRhSIPwvcMSznFSrsZPaTZjunpDdX+Bcp5MYrAE2liTm9c+0c6REkl17s1S2Q6YPBZpVGIhsns2SfbmZPiZXeqAVTL8tRROtYEgvIhBANmAyRekWNBndK3QscwmlYgIq5g6mYtbTLpSmlydDWz87wetHxyr3V9xAUf9/wuYViMzLxkWoclcI5ucsvzc8QsS+TQcM+KK+f6BaWqiCyxKj5IK+PJp/DzDDT94AT+ss1/GjsDbFxBSes/V/Itz1clDwQoNd66ByZdCRiJuYN5aq/z29cVcn2+erbjLooqUWkXwJsHh82bpM35w921F8B/gsC7KblxH1lIBLytoPDrA1eV0skvuRHemm2oR0jtqXEJQmYxRoiocleZALWfKJt9fJuJS+g7FLw9MhGUxBxei2ISAxWauXvu7orJq+8mvEGFN5JOCMWr8tE0g4UmS9jsCfQnrJFPv0H5luHOPh2zgbWbpvWcVBUm+YvQkMs1sMwlZkAtOWG79NQxj2qdy9bjyEerA3WBeyEH5sf00hrQsntnm4Vf8kK7EA3fc2fUMy1Bej7tb/+bpZP0k9tBSmDeFZ340MF5o2ODRmrGQSyn4qztMxOA3eSBVVxQR2nP6ryPD89ADNXgKnAjI6xVyeMxoB1jkw99Xw/Fy5Tt+teY8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pHeE8CEorpQjIflCRo5T7yOLDz4h6Hl6mTEG5/f1Vwevmtm07/8F2sYZ4wHYQ/wHBCuI5GL/d/ixgJ2wN/Fn8bCNz2JtoDu5DU7ekQgeYYFqTu0l7E4apQXgZBxITWhzg5FhRX1sP8xp1PL8VpB3RqO12KFFS7R8LZu0fto57VtxVLh/JGdC0d1c4Aa3YbEQpMjeFyPJHTsGYtLKhG/8TOVAhL94qVQQZEYR3huAS8lPzzZjtTyYrisPU557WcBjoyHA+CbTg8q9eAF4UWWQnAyDPLB1UaoPH+ivY5iH3/o8uNWv60giwrXS9ceBI720ph7/7Il7/1Pvr3zHRW72SD/llQRFjVHXkF4iNBPZEgLcaHhEua8wamxobzMmN5gjNo7DzVEs2yDy9OOZy6cs3DxHJAN7qn/UwuHJYLMW0K9HlaQAnBq46qt0pg0qoWHi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:52.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53437e8e-1b6b-44bd-6f6f-08de9b0925b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

Queue memory exception records into the WAIT_EVENT path from the
KGD-side VM fault interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes
fault address and status, avoiding any additional fault decoding or
KFD-side dependencies.

Emit events as GPU-scoped (queue_id = 0) since queue association is not
always available at this stage.

This does not change WAIT_EVENT UAPI semantics.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..e3d59e842a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
 #include "umc_v8_10.h"
@@ -135,6 +136,19 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+
+		if (adev_to_drm(adev)) {
+			struct drm_file *file;
+
+			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
+				struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+				if (fpriv)
+					amdgpu_wait_event_push_memory_exception(
+						&fpriv->wait_event_mgr,
+						0, status, addr, 0);
+			}
+		}
 	}
 
 	if (printk_ratelimit()) {
-- 
2.34.1

