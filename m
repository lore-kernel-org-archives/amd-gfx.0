Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D095EC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C40810F367;
	Fri, 21 Aug 2026 16:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMLBLD6W";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D2510F368
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrD67bBbE0jUuClgHC3ne2tN4WwmNwNSKePGYOUmMq+I15pOSg3NIgEOZsezuliLe7Iw7rRB/MGufCu8gsPRCYadIE/M1CmNNvs+Cp2rjVnJgMgjawf6crVjxWUAoanFFGxFbBHWoXx7F6hjuwr1uRzuAsCeZkyQ6GMdVEknFD+q0AcY8lVkKFmHUBpZXstw06jvqkmYChQSJWJ8LMu3ZeKrN9r3XZHqjLf7pbkW9xTrXEd8e1i8D0IRbxW65WbEW8pwVNWlG3IUt4A7jV5jLqw1a0xSGhbAWVHUNG3OdKHyyEE+mDFj8oIy3Tp7iYjA9XaWmAlW00iL6uUGv5Udsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLhLxtiM55rZeQYue56oAg1AtJrDLOhv0WCwJWTl+3s=;
 b=zFFmdg/fdTTRNk3vrIlCAt9PoI5T8I3OEPXheLwTO6QUhEfmwMu9GNrPnLTxVKGY/JaXArN3iLbIDKt47nOCRUEneP3y0gB2+YXLWB9yTenIxdT/a4QpHfLWccqWoGcZoUp8ajki3s0UoOTrppsn1SsQFSF1p82nBrsKbXhd/IwZvGGAAC8N1LCCmMC+mqhJoRuPCrFrn2B74/+HBppDuVD0Syv7TnTv/gne0aAMnrNlsCxHxs+qKMvjAy38JsVKKqyWavO7WhfhCAyoB2ufozT5Fu3epz1ir8hCk49M9AnW/ehE9qzK3XxjqCtjgcLuGpnOr0PejoFUOpyjNnHVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLhLxtiM55rZeQYue56oAg1AtJrDLOhv0WCwJWTl+3s=;
 b=hMLBLD6WxrdUW7Akx1IYK1SmrapmZeqiNYUUZ8+PD+rWG30/H7qiz5jyZVw09Y37SR7I4TTt8txufdWhmbaMzFdqqhFBJaETCvNJhqTd+mbIyJ/+zZXExT750ci9/oz1OZtLPQlyXA6mHeBNAvk842tjC9gkXobeSmi97Wd8maY=
Received: from SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::9) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 16:10:14 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::90) by SA9P221CA0004.outlook.office365.com
 (2603:10b6:806:25::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/13] drm/amdgpu: Update no-retry PTE flags for GFX12
Date: Fri, 21 Aug 2026 12:09:50 -0400
Message-ID: <20260821160958.753063-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 422963f1-dfcc-4e38-8599-08deff9eaf4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 72JSkIV7DQ/mxi1f0Uax6oXO8PLMupYuvHNb1BJpvPLWpg8N6NzOlWfsi4sD52rey5ZQHDHjneSUtfkqcsZcJ4gUm0c1vWMPFzzDhnx1r6PeBhZGL4kglrCj/pZ+F/vKoYrxR7EIkBKo+gAwytIM723WEiTDGcfRb1u3tY55ErfVYS5hFOuaukl+Pi0Qh5aw1Jzp8o2Imtl0+MvU6Yw/2t4fjeAo4baUSp5MTzZ9GTjEj524SJjXuiRftv3sllYhhtOuvmAUV8khajDH8LQqkgccYXx0QNvg2sE+30NhQT2VHgrkU2exE29kABY8uuf49gHty+/kH1I9L2xbpwuNjBDA8Dc09xgr58aRVVGWAa/Czlkla6mFCyPv1s2aBQDGMbbn+mS490z8Iuwh+zninadCYDoI4d23GSkyPDW2JrGQog2rNZJHh9TYUS1d077VZ7r/N0NiLQrl8E7f2z1AreYbqgvabrO7R0XxyPO/T2bRWk/LxhNtqvzKZrLC++CFioDrkhr9ICc31eYPqrikfX2fEnBKUPF/QZTyDtK3VvZFQY/riSlMrkgaw4P6fLEsLdGwmZw49Vt1lI8VUapafycl4vBKMGr3ICiYXiYG7pO0Oj2CnPv8+2On670BtyEMmRigEv64tIvn/2ZDzbdtkrF2Gl12ldZaO3674kvM7qjVIGlRFuQQ4KCUHqPcSuYshC7OaoAeM+gtEyml/BxTWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cCEkUcb3AFQJ9/0spVCPfTBIgK9agzFJVgAbAowcz1C/nu/ll6XipFP3ZCjdVn0cHncfcyxNHunK0eYcEmwdTnPKiaxJ3iEa/DVQAirduDQzRofDFcnXht5/dqRvN6qypz+xhernuEKyutFBWJpDtR2HBda3mDjZhDWWROpJdnU0nLUp3qwumL290fA8yAZQSMqa+TqjMwxA3RTGDIXXdQZtTcf0kW42Vqr4pRv0WfY88EJlDYAoade3EYF7WhB2ifzfgNuTAL2JWloL6t7OnbqzKzLpvKSqE/VnTZbGZeOfxud7bwOKQbgNxr3rrE/Vn1FPaKdadsc7c0q1JZD0QZhZjTB/8EkGj9x9Ac/mC+xrxbqKrx7ab59uKaiPeTSnl4IRr+IQMdIAlHC7Txn0TwpSLagFQwDH0z0hjc2AIXyVElR04yJK36trQJHaKLR/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:13.8068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422963f1-dfcc-4e38-8599-08deff9eaf4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

From: Mukul Joshi <mukul.joshi@amd.com>

The current combination of PTE flags to translate a retry
fault into a no-retry fault is not valid for GFX12. Use a
valid no-retry PTE flags combination that works for GFX 12.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d32183cd9e0fc..253ec6fc018f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -141,6 +141,8 @@ struct amdgpu_bo_vm;
 #define AMDGPU_PDE_PTE_FLAG(adev)	\
 	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PDE_PTE_GFX12 : AMDGPU_PDE_PTE)
 
+/* Flag combination to set no-retry on GFX 12 */
+#define AMDGPU_VM_NORETRY_FLAGS_GFX12	(AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED)
 /* How to program VM fault handling */
 #define AMDGPU_VM_FAULT_STOP_NEVER	0
 #define AMDGPU_VM_FAULT_STOP_FIRST	1
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 8ad0c1d0f9877..ea240aa1e4455 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -668,7 +668,7 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.private_aperture_end =
 			adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
-	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
+	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_GFX12;
 
 	return 0;
 }
-- 
2.55.0

