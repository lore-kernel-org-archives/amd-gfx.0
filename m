Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72218C982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A3110EDB2;
	Thu, 17 Sep 2026 11:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhQvBQLm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB8510EDB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2zwO9QdvrzpwZVOHbTc+d8nMGJgfRlPd88FvNG1hSeggKSHCBjqf5av83ADj2EVjwnh6P/wk7E4wNg/Ck4tN6vZDq5Lq9TSHNXENWEgiEPutzd/c55vchEOSWG/d0/OQwMpi97npktVysYi6dvegdua/9Ds3bgkNO4yIEFeyc6HcVCE+UWWfSi6Y7SHEbM/APSaeH0d9gRcBAYGXaj/U7x58QvNM6zWTW49SuFNI29Ps8Y1GOgjnvEESQIYDyvjn5c4E4st/9XMLdU/lsx94+zwHy9rGbfVDlXIq9YVcgHUM3AF8htYbpUeKy+2b4suuSvQv5ySEGIt8/0GyY5ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxww30Y2Q9YatvXZQvsdUV8NaDwfx21M1j27YbRGG9Q=;
 b=KGYMPXUXtI3Wy0Dx4R2gSfIJF6d6hFw7wPT7K8SD5m2w+OLmaOv718VowVgWAEgEM0Dr/E4Apcl79GYmsl8ujd0wptbLxl8/4ImBdFSFV5YueP5PM8S1ro6VzwT7PRgZ19HUVFgZNVnva1QTc+ehLABnUZWGsRf5LOFloCWJKymFdxZMyk2ZGK+dCePdqgYuFmpI3CjfmxJgEiRCJYlCEwWEc+WZdWkUlf7MdtJ81g0vGDuSSh8TQAa0djyerUmNxT2ADp01wKWyqaRwrBgT0W5qX0PcO11L0BsdVykKUQ8wJxg94dbEs2Ay+4T9/9GgLcFBRSiFV5amQ5XfpW5wPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxww30Y2Q9YatvXZQvsdUV8NaDwfx21M1j27YbRGG9Q=;
 b=FhQvBQLmbyYBHDGMO6m0qcIIP4qdV2YyhOWd0llv17R15EHTc5A7FRBVxMaEKlIgbidOsPnWo7IFntNk/TGmuFk6ynU0CpcacEzoub8SDSQ5SkEJfEKs+vYdlGJSIv+zMHQsrqBBIVl/L1mPr6hrRWYE3RgOkLiQeN0NX5TO12s=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:03:12 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::ac) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 11:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:11 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:03:09 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amdgpu: pass an exclusive end to
 amdgpu_vm_pt_leaves()
Date: Thu, 17 Sep 2026 19:01:57 +0800
Message-ID: <20260917110158.296198-13-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d49d005-a639-4ea9-1981-08df14ab43d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|18002099003|22082099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fCgZ+du6ZmqSNiLy1fYQEf30nNkvDCaPYRJGcNKFDf2XU8qDwYvaisd8r89Dmks75RxiQME7SSq/rf/YrsZELQRV2eq9+3VdLlmvJKZ0iB0E2084aZvfb0V0X5XGYQDT3mXQMMnRaEuWsc5GhOj3UJo3Iy4ChLweBlF7PrY9n3MfRyIsEUSY9sfOdGzwqCqTw/Isp7U0AaaP0IAR1APOkNt+fPg9MXqPFFnpG+zTcCo1E2AImEnBfyQJYqMrlyYZrwHdzrxsOvIT3Fd2gcLxrnXNWRO9cktrcqmiTlgwp6dYuPs4aDPBmjKKWG4GrnsRqbBsImFCR8yVR+7cyxrOqB92L+COkVcL3Rf+ujJio8va7ER1ZpEEbojAyhLugpBFqNuJu2xIhbA8SoBIGef7n4eyDVchD5vVcksEoBtROZEqzrjqJbBuLZA32to6LW8kABXe3XKAhnI614IbDs9edvQGSNPXIxnsZD6L8raMA8WHnP+dU8rJfbk+FhqIYMdbWRXZuTWcOP/BZhh+vHPVGSsH2578AeRf5UVp6hvF42v6EvNxHMYXTaBxHIZYkHBeRJgYxbmie55N1R9NUj7IN7cAP7BRGkFbf8wenQmdKcRI/UGJM2W9VTAtb6u6xE5S+bZwBRpH657UXdvhdR19/YnvagrCfnIddg3BEmpuTasqnrktSCeZ2sMUh/A8s6gsrj3aDoVZPnuON4nqZyX8sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SYJI8YxF3DkYAA1CjayYCF2yMGC5Q4TQL6nEhFjY6crnvuzK158GFbmAPUDFXX32z2C+F/fe3/xF+GeTmApKWsJgfNLKnnZ8JDW3Y3Ju5jXRXqvg4WXmxj3C/H0RJUwH1KrpXXuet/2NbfRXHizFPMdrxkepBUZfPo5DIxh5INxWTU65HVBNW5eR+ovqFdWQwCY+B7fjIHP1tMp86rVfp72oo4QzdmIFDOUKWCmRiygzJNyqkDvyW7qyVmrJLuNu6weyFO4bK4SiyFu2b7Vfd2Tzd+Db6bSSDf/E3bC8/AkdO0GZ5Ic0HlB3w7Xywvcf4yrhA0IXaXg2F9CDzqNiEpgMxhBLkS1jVJuONokP6iD6iJhCaXVkP0YBwapIOKNwymmZ8c5CC1RZpKwuyJnmuWyjSOU00Y82l28hiEByu8NFkLLG/u2Ui7M0Lff2Js/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:11.9170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49d005-a639-4ea9-1981-08df14ab43d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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

From: Yu Huang <Yu.Huang@amd.com>

amdgpu_vm_pt_leaves() treats @end as exclusive - it loops on
"cursor.pfn < end" and clamps with "entry_end = min(entry_end, end)" -
but both callers passed an inclusive last address.

In amdgpu_vm_unmap_range() that silently left the last page of every
range untouched.

In amdgpu_vm_handle_fault() it is worse: the call passes the same value
as start and end, so "addr < addr" is false and the loop body never runs
at all. That is the path which installs AMDGPU_VM_NORETRY_FLAGS to turn
an unservicable retry fault into a no-retry fault, so nothing was
written and the faulting wave kept retrying the same address forever.

Pass last + 1 and addr + 1 so both calls describe the half-open range the
helper expects.

Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Change-Id: I0b89042774e1e3352829e8bf3b9d9953954bc870
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ea1a07577c2..4e9dd0485db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1312,7 +1312,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free;
 
-	amdgpu_vm_pt_leaves(&params, start, last, NULL, flags);
+	amdgpu_vm_pt_leaves(&params, start, last + 1, NULL, flags);
 
 	r = vm->update_funcs->commit(&params, fence);
 	if (r)
@@ -3171,7 +3171,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (r)
 		goto error_end_critical;
 
-	amdgpu_vm_pt_leaves(&params, addr, addr, values, flags);
+	amdgpu_vm_pt_leaves(&params, addr, addr + 1, values, flags);
 	r = vm->update_funcs->commit(&params, &vm->last_update);
 
 error_end_critical:
-- 
2.53.0

