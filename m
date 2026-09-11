Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC51C88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E259610F694;
	Fri, 11 Sep 2026 15:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2f7Ox7f";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2B310F693
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSORhh89cwxAvwGYS05M+TzliBCRKQ61W4uRMKfmD4EVWtARzUrAMIGK+rje7Hmr/kuDGTuDAU8fAAIqYo9pkiDieItIizDDQ+B0nscPHKQYuXWmBlp4cw25gsGTTd4vZ67Xowaby3JC9VfD+qn9qBIxDsWQOunvVYDjETIzcpn/iHYlZYbtP1XvR0JHB84C8JaFsC8o4CMOKRUTyqwtbzVM38nY7HVPggoDznHNpXPxEOVEbL1rc6dSUpO73JQOnaIc9Jhfs9Q3zNLy/1Mr7JwcbK5BuzwsM55JMvdnjycTLSOLpPcOwC4Fvte2x05TYurd8m2Q9tCEvaSCRiV+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UA2WCgUOFL3KLHIL0y1Jz8EzMdDCHgRM3b1a1t8kp0=;
 b=dNJE1bHiOTfbyA8ZU7+Dqp5w1xfawl6XOf+Vu/Ju/Jk0zJmotnSiOr0gKV5CMduk0gexoqTaU1sIXIbU1a2g5+umBrxhe3ryY7gRJvyPYfROJLskk/7tR8ZUob2uN3xehaVLhGC0WTLehJP1R0PRfwv1L+TFAj4jP665U+9WZ6HZZ6RbLLHaUynYRl2blBrsAGW/PDgeo5a04vk60/fp+05T/3zQb2be8jiewbRHup17DxHnZyExEfywh00Qa4jHr0YrffKl/3hBjiKPV8Pi1Gp+u2uLD8Hd4LqDW3k82fjYre7zFPbcTzHFu3JfioLsKmygwwD9gCvZcaLxlb7JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UA2WCgUOFL3KLHIL0y1Jz8EzMdDCHgRM3b1a1t8kp0=;
 b=P2f7Ox7f68bfpFz1P+g4HnJS53FO4mvPwHxIgyvu6hkOwwCgN/m2xKYprlyPUXlRI2qX/uiEYU3ITK7ApoezL/iC97oXp3bJIh82VFGk/7ArseQ7oqK0EscFvnWcXeOsu3WgE01um90rc4ae0D00w/4kwg5k1B0mSmLVcMB2AOE=
Received: from CH2PR07CA0057.namprd07.prod.outlook.com (2603:10b6:610:5b::31)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:42:29 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::13) by CH2PR07CA0057.outlook.office365.com
 (2603:10b6:610:5b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:29 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:25 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: prevent suspend in fault handler
Date: Fri, 11 Sep 2026 11:42:09 -0400
Message-ID: <20260911154212.591213-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 117f3fc3-3c85-42ff-1e2b-08df101b4979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sYczF/OBAauw3b4rgafbM2iajx0aWoboR9lM07CXJ33SSJtgva8oQPXvudiZUk7vSiolPaYcVEFQqx9scAZ5Z3IrWrUxA931tW5pGtrR2F8UgJFfX1D1jaV2rQqG/pAqbYFG16o6npEiUJJXNMV+T9iCcqusuMSuS23C5w9ffG6XP70RFCrxgTDZnXH488JaSgQFeA3+SG2v7LTTnVlj4thkP8PvyljYoYx+0C7WljI/uu+rH+ONXeN8X12Vh3zL2SFFLzec7TdicQx7PPMF0j/xIVZN9E3wMFmBqXZl3AupS6W3OSkgmijQ5m0+g5QA0b5kdBXadDzzo4iz933Ae4YoByb0VQWFNmlfKEof5rCxr+piCS/c/Vt0SAoCkZduQ/eeeVK2gEfiPAUE5mXGIROo3VNVOD43JBIveMSYCiGm8QZhAk2TztQ7WlnxJRA39tcL2U9itLqbzKbd+plFnSywyWXFyXPg01g9vOiS7Fy1rz+CXf9pP7nKSzkkZ4wOYyKcMPHjEWrqOpHjdWO061KCZgtB6VbaEw38Anf1L6UP2I4R9jjOW60+obh9QCgv1UZB79scfKxxRljxTy2Df2/AFcGdsiVaiFGe3KOQ9lf+SMz1RTkjNxO2b93u43SRbI52zeG+qEt0S0VanKSWJv1634WlhWdu6Q70/FkQW9XAsOMyM6Dadxv29GF/Pg7OanSkTMNz/DktU3LLhGbmnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FE1u+ARpqXo1RLOyieqtUTahr9x+Qv6mPHZyeTZ4IRlrt1L/YAGKKGECzxBK1iTLq3KQgUvEM8+wtAdlNsaR8pZ+2Uwxf2vm4F7+rh1nwIb0TjqJdUCP+/dIvXYcOAH5HjXPS4rjuMTCI/HhsxEiAyCb4wdTyBKpS1gItswqHxVJKgJ6mOx7Pa09e7zFcI0/MuVYsye/dF1LjtvPkeVwgT2MKAsVaS6sbnt7mQ1xl2NV7wy8ygE1tQBInuAp2ayTflDl4oRdodzRsmoY3+R7+Ri2QJVnJqjVfuToPmdNK1rCKA93y34jElHgE4SDkt7iZLX7o9DLZh7+osEWSm+hGameLw31b3fiarc0CoL7oXq60mZF34QOPFpPDMEN29FKBBwu10XlMiQQDLbAV/h8ZKeVGrS3lRGY2eearilNpYQPpttZHosJr023sVpxMjDO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:29.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f3fc3-3c85-42ff-1e2b-08df101b4979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Temporarily increment the PM reference count during page handling to
ensure the GPU does not enter a sleep state.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
[shahyan.soltani@amd.com: Added commit description]
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 27b7c35559a2..18dab5562279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -129,6 +129,8 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		return ret;
 
 	if (drm_dev_enter(ddev, &idx)) {
+		pm_runtime_get_noresume(ddev->dev);
+
 		ret = amdgpu_bo_fault_reserve_notify(bo);
 		if (ret) {
 			drm_dev_exit(idx);
@@ -138,6 +140,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
 					       TTM_BO_VM_NUM_PREFAULT);
 
+		pm_runtime_put_noidle(ddev->dev);
 		drm_dev_exit(idx);
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
-- 
2.55.0

