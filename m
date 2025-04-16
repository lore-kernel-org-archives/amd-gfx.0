Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843F4C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A9F10E9CF;
	Wed, 16 Apr 2025 22:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bx3OnLoK";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF4610E9D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efxP4e0M19Wb3keLUdkm0gDDjgmjO+716zj4NuKdmC4tCESpw9+YxsmW5w20Vkbzz1qkUPZUOdeDTklGj1IixxGq2twe229+zUha3YcuXZdGGgnDDI3H8QFEEXCSH3yR/iSG85TIdjVJAp1+FmXXWYgj1Nbvc6flrDRi9wmjFN57Me0FIuBlR2iRJPDdUnuAEVjPZDCuq+IZvIdceYwkwJYsVuzdHyxaGS2fhLLwLJ6EohpuGmpubsMwXmQdjGCKWELwGLMAhTISHcCPYJdSwUiHuf6r9CiEVthQZbrTzNk1qLY+kFecrZSd2IKy4q3W4iWnWedFGX6dInqP/OHLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLXI0ymWR3hsJNpSRuqyZd3YI3lsaWCv7PalgtUJIUE=;
 b=Yq2DmzWKTRIKPV+H34kHRnSWTrSwbtlHCyb0BaiBxc/cB0faD0Pb0JVYGArvH2b3YcWgPqfdCJT4WwIlT4chEEXRE1iIkP7c3ufxcJ6ApNZ9ZCydSUOkjiKp6NaRrWTwxTJwrA8zSKfARb/xhaviVgJ6kYZnY6IrVu7SGdRerD3tohO/8rQ+e8Uy8X4CFzzKl3ibYdIyHrBgHCoM5neRdNioaDo6NrefpSBgMBnqDbFGZ4rtvQQObf7HCYWjjvjltNX6TqXUxNkYeYRpckTyoVTGO0QTCLmu4d9a4pIzwjxg9+5ZYCd48BYsfWjmCz9gjFh5YUbyV0E4JGppZjE/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLXI0ymWR3hsJNpSRuqyZd3YI3lsaWCv7PalgtUJIUE=;
 b=bx3OnLoKl6KeLZRXXVyNvvEawUcPH+EVSkw3UJKsBLAOe7aoh87nOlCxsaG6VtMH9355OMBJbUiyyDwe1IWYR9vJbZK2u4K2TLPRL+YtO8emAEMAkwNhxqi6bfLLLZHWpI3OUT868WZs+KZltFs/IlTxsGfFaTxdTUmbD+N+pm8=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 22:21:01 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::c0) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 22:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:20:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/userq: add a helper to check which IPs are
 enabled
Date: Wed, 16 Apr 2025 18:20:40 -0400
Message-ID: <20250416222046.1142257-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: edded60e-0ee1-4f9c-50be-08dd7d34f817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b7QKql157A3APXXRBsGnS2LPamqZ2AAU7irIbioAsE7hQbt28bRn0GAhI4Eo?=
 =?us-ascii?Q?ogoGK3D+l4MlskffkEwH5iSXpaDh37PHH8VPhEzOb7g3hvQj605qu5FqhOXp?=
 =?us-ascii?Q?2BWRRlEesHjK4DBCP+JG9S7WkEvbHPqkHKG25ft0B/xqCmZlxyjsnw9ZtP8V?=
 =?us-ascii?Q?uq/8dXmNguXdGHllnhqESNQSZ5y+2UF/LLq+c6zS3KiSZSgwuclGfJPtUTKd?=
 =?us-ascii?Q?R/Uws3uysFxCU/hnkuNsZD2bld+Tsw1AyeQRdpGKDOKzB1rhmiOOWLpuMQlz?=
 =?us-ascii?Q?4Zxxk9YnCLvLr9O8QZmdoLQXL8On62sBAJ310Y2wz1ohxCyBi0wWRG6PPEDq?=
 =?us-ascii?Q?6oLuEsr0dxxh+i714CjSo4yIV91smAQOzAlHT1kPvjHwCoYfUH5ydgtK/Fub?=
 =?us-ascii?Q?+k8Mf4CSjAVqC+OLH71F8ZrhgRCS1wOb9ZpOA0zW2b8X07bKw2IqvxwhpxWo?=
 =?us-ascii?Q?qNYknL3QfjZ8D4e+Xxg299IJVh+V/QMioE4+N8jVqnHXow3uzmbCSfXZf6DE?=
 =?us-ascii?Q?CSAP0yZNrWb0I0uC9E94SODZUOunMl2k2KrV+z4zQrYDx3QSuwLln369P3qT?=
 =?us-ascii?Q?S1oyTwkTAQ4MXZTsf6mf1+StfSpLRB34fMwAoiQRTS9M42Oqzud+pbGTnFU+?=
 =?us-ascii?Q?pigjOFEHIuROaUJs8a4e0EC/sp/hpelUe2nZliLMQEfnQABU1ua6QqYivGt6?=
 =?us-ascii?Q?2qZOGMiEOIkzJCoF1yqXVbyoqhF9QGurPo0gSaZU+G4K7T7x/WgO5KsBUdYW?=
 =?us-ascii?Q?bIM90Ub0KW9HLVGgfpA5WUIuuY0hD5npttaFIud1IJkx837GusUXfywFCRrn?=
 =?us-ascii?Q?FCnxPOKDfQjIqTf9hmyelZUmN/ImNn8gevS+cCBe4fXioIULFY0FEzCOiNWI?=
 =?us-ascii?Q?Cw+GjqY6U9vR89R97HN4Qk8+ZN0Pt/Xko6J8km+ygEz/Zi8tBuA4kk3fNCNH?=
 =?us-ascii?Q?xW1oDD/+6ggT1rFF43VM4LAIZGKJPuD/uQTwMpUtQIrYfXthulqp/u9eXviA?=
 =?us-ascii?Q?ZvNeYPZebp2e7qJkghYSirM5VHUoIHby27LJbhAClFQL17yAZLUpoRXzQNiw?=
 =?us-ascii?Q?vGN7VQXxRF57PuzOfaSEinx961IR6skcGQgjLJX5MqCW2ryuuaLgjApJa2C8?=
 =?us-ascii?Q?HtBOdJJ1KeTuT6KmlNw8/PUn+V7C7IrXtsEQijjeORSMV73zNaUu2Ldqn3sB?=
 =?us-ascii?Q?1Tg0O8t1MxbOfCyKXT23RYqtzWWpZ5U1vNATDE/MmhOy981BjHjiT8SiBkyW?=
 =?us-ascii?Q?cw+1bdM7zK5oR/s/ULxnp6il9ftW4Bsg4+gHSkzW3LejB1Uew0qu9/bqSpLN?=
 =?us-ascii?Q?7RsNGqlDBXTkclVo3e/kfm0ZnP4XJYCWZfn5eZ3cm3Q6vrneUYTqFuL9wQMf?=
 =?us-ascii?Q?DVZ3rwoZNFFrTIT4GSaSJzvjw3NGGrpgrim/AorEXdOkTqj3fKXCBrcYCSLl?=
 =?us-ascii?Q?n8REng/ZnWHAVAhkErEl9maVZ807oMVeVmCZVgeo6ZLym/j6jNRIk7JV0GB2?=
 =?us-ascii?Q?bMnivm2E/11dlplJlAvhETBavQO6CO2ft9DV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:01.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edded60e-0ee1-4f9c-50be-08dd7d34f817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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

Add a helper to get a mask of IPs which support user queues.
Use this in the INFO IOCTL to get the IP mask to replace
the current code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  2 ++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3d319687c1c9c..151366ecc0af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1009,12 +1009,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 		}
 
-		if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
-			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_GFX);
-		if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
-			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_COMPUTE);
-		if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
-			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_DMA);
+		dev_info->userq_ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
 
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 249722dc40446..dbc1fcdc0f73b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -31,6 +31,19 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
+u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
+{
+	int i;
+	u32 userq_ip_mask = 0;
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
+		if (adev->userq_funcs[i])
+			userq_ip_mask |= (1 << i);
+	}
+
+	return userq_ip_mask;
+}
+
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index b2da513b3d021..b49f147eb69cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -113,6 +113,8 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 					     struct amdgpu_db_info *db_info,
 					     struct drm_file *filp);
 
+u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev);
+
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
-- 
2.49.0

