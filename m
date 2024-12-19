Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F457E7718A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F89E10E0FC;
	Thu, 19 Dec 2024 14:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hf5bxYZX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC1A10E0FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 14:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0lS356xmM1/XhNyknCazVIX1ZBQZlzks7wFa2cFybfQTO3W/YRhbLcsu9MxwaQpJSGYZ/HXKhswcR0b3wkLjvcjU8EkldwokEzK/2JXWG+6UL7/PSk+JzpKjvd38+cZ9HlNiRpiUs2UnNQ5R0hxJxi4UCv1Jxur70qB6FAOQM6e2Xgu14oRob0rGs0Yzdn55aaHcyhFp02IyzMGMdKlLXVicBuaXDKxnRmJ5NWTh1mfX45x/oNtIwPIzUL2udBM3L2in4P4kAOwrr9o54Zg47TAlTmVjjj1x9T7xWVBLgmG0lsYft0GU5w5icughjcpHSuy9CuIWvfJBJtBWKYWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmXM0pDGX2yu46wpUiNknqtkrfHxM4I7eRN0fiQ+MqY=;
 b=vHXV67Un05NhrEq5cgzZbJIDzkKspPsDjgTPVcMxNjpiUJodK5aVZ79uJjgHMorjym6UHywFiZvx8v4CHzKwihHkUcHsSwCm2rlYyoD7OeeK0q80IAXBN171+Bvkjz9LAGW3fd5fYJ0g7rXNz1E+ET0f8bwefjhC0s/ep9RQdcuzTfQw/sOTC0OTWscmOEr70e/G0IOkVTzAnUWMLvTTta2pozM8/GwuklhF1JO3XJpdLwkEca+u/q/aoF6ZYjyAsU+bKzQkgnwf/xriv4zRk/jbLh4oRa1qMP2SRx+8m5lDoLMaKlrZN6QrRjYugXVwGsIoov/0w2PovEjx3B2EsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmXM0pDGX2yu46wpUiNknqtkrfHxM4I7eRN0fiQ+MqY=;
 b=hf5bxYZXmhH8fks5RL9ewuG5TyRMCLIrzw/BDPOVToWUss6zmBC6X+AOwvdbMv3BLuUpyKypa0CKBv1TP9zZ3dnsb4qGSuOurSK68F10kvtH9EzlZb+FuLLaF640tynmVHYa7GTKS9+gb0AVoMKrEPk+/Fpqvlo/8tKR8mgSR3U=
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 14:56:58 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::fa) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 14:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 14:56:57 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Dec 2024 08:56:55 -0600
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>,
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Illegal opcode in command stream Error
Date: Thu, 19 Dec 2024 20:26:32 +0530
Message-ID: <20241219145632.15734-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb88ead-f6f7-404c-efa3-08dd203d62d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+bHIXOMqihNJOkYrx44TeXK5X1X2eOQpWipfpNJiTc/0eKaDpB+XBBvg5M0?=
 =?us-ascii?Q?rqku4Cj0/rCR0KaoWZMyIHAf37Jm9pkP0zkd2IWC35kliFHsjarT7bnPEpw0?=
 =?us-ascii?Q?SYcUnJjr3yBwzVA5UKg0vVe2WbLa0GHyxEsCLz3qDimskccMEzWSuO+BiHUx?=
 =?us-ascii?Q?9eT8ZnDeCy0GBbiwLRIF83irG2Z2jjgG3DXeWOLzGmwOmWCaMvcRaPDbYGJ7?=
 =?us-ascii?Q?nIYjWPu0OzlMZfTzrrhfAw0EyuOzlVkcvkHfE8f1P/3Ewh73fQX11wdMDT77?=
 =?us-ascii?Q?ajDz5zuH+ztSZtH7dyoJriezfDuqLJRopgz0RCt9MvUSmrMh+6Pyg2gvl7Kv?=
 =?us-ascii?Q?tbTbvEIe7h2Wk+q/7X3CiGpFxiDZf15rDNjo6UPYCM2hEtyT1FOESDcx+f4D?=
 =?us-ascii?Q?3Zqk88KXCPdcCgVJ4qO7odZrfxKNDqoyTRHUwksp9SuJRYa3e9f5umhvv7fv?=
 =?us-ascii?Q?xx0G5DwFXKTVmCCyyq2fGaeaFg1TE377B3CEsMgAXqfkSextQk0ZrLPLdXfF?=
 =?us-ascii?Q?GMFC7qB6oS+6b1GdHUmQj3CLIFLgCUbHB9w8eix1jqeOB/Ce6k4Sbuxs4XV1?=
 =?us-ascii?Q?scFg4+14S1WkdbKrLvb1pguzMasG69/bR66FRH4luiGw4kSZC2//epXhEAKm?=
 =?us-ascii?Q?e9aQFumwMcqolp2YNa8l5UF9PA2APWQNhB/bA8MBDPFflWHF8vDyBIMbqSSe?=
 =?us-ascii?Q?+UpwSLyTB99fm18zfWab+jmwgXCq7Ty7WgVpa82n0cN5kNX0gc5QRckB0AwA?=
 =?us-ascii?Q?zTjOCU3S0qDp0+EWT0s3AjE9U57RKg0SAOtqRHm3xox7WhiGorkCho/mKzKX?=
 =?us-ascii?Q?Qi0uqXfPHGOuIo8q8ff5E9E9pXjxnw/k+/5k8eDlCUSce+GGmVIgkV+S0aOZ?=
 =?us-ascii?Q?T/NhOEqyQHJ4Mt+NnCLZWcVftvBWa8lYVV/y+SBpQwnRk2EmZdx+VE2JhPDS?=
 =?us-ascii?Q?J5t6Xiknh+Hmyp10rPg4SwMJnHvWY4HaFisNOVM7cgx2/PtHx7XHsAKt02GH?=
 =?us-ascii?Q?70dESQ2/uJ60p42bSWEQB2gqk3wPFxl+wJyMwNmDxd3bI1Cv2LiRdNSYV6ey?=
 =?us-ascii?Q?3gr4bG9S+Hqn0tqWOvL+b2m0ZAd2kh4FEUZZqJ2miNMzS1OjFJfRNbIVxMFp?=
 =?us-ascii?Q?F5c7oGo2t7/0x4hVeRum0FZzC5SjOedRWRv9LRN0y6Ziq4tECJUIL1rubcQG?=
 =?us-ascii?Q?rMiIHFvw2ihhRgiQRX0QkGW3jeS2r64/YTgdwL8m9QYS4EDEm55CEkWHfLAm?=
 =?us-ascii?Q?RWZRmZ/xZohEkK8Mi/EEKDdILGkF3ELQD/T7X/wIxpINhzbSupjTaTNrFIX4?=
 =?us-ascii?Q?Jkbh0rjDmGkeptLRumsT5lTl+QMzlNVSMd+nWbB7BqOgun3nEruT6PC7Qkyn?=
 =?us-ascii?Q?np7xo8Xod+CEGEJ8rIZCUxiWo0n6t+/s9ZTKfalrchkima9tM9Tvsbe8XUA7?=
 =?us-ascii?Q?IvmQrvdlRT2YdLb7LjK96vDHOdDnLwCKbm1x4RUdA7FSSgZTntnkbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:56:57.9397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb88ead-f6f7-404c-efa3-08dd203d62d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

When applications closes, it triggers the drm_file_free
function which subsequently releases all allocated buffer
objects. Concurrently, the resume_worker thread will attempt
to map the usermode queue. However, since the wptr buffer
object has already been deallocated, this will result in
an Illegal opcode error being raised in the command stream.
Now the usermode queue will not be mapped if the wptr buffer
object is freed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index c11fcdd604fc..378a6284e05b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -28,6 +28,21 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
+static bool
+amdgpu_userq_validate_bo_mapping(struct amdgpu_usermode_queue *queue,
+				 uint64_t addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = queue->vm;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
+	if (!mapping)
+		return false;
+
+	return true;
+}
+
 static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
@@ -390,9 +405,12 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
 
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret = userq_funcs->resume(uq_mgr, queue);
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		if (amdgpu_userq_validate_bo_mapping(queue,
+				queue->userq_prop->wptr_gpu_addr))
+			ret = userq_funcs->resume(uq_mgr, queue);
 
+	}
 	if (ret)
 		DRM_ERROR("Failed to resume all the queue\n");
 	return ret;
-- 
2.34.1

