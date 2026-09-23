Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C64C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01D810F164;
	Wed, 23 Sep 2026 19:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KuhFr4uG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D33910F156
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxH8LNnuaySP2lFKwrQb+7PRcSB2S8E5EwSFXuTjLc6f0K00Rp5DtHmspjljkHabY1jZC2MVVl9Y0gY7Xlu3D5RD8IMXTIfm+Xw/yX260KbHqVjFpTYcANQh6ti07wM/k2qijE9bbRYhZhRZQcgyfPoaJwz8IKM99EmBbdUvcJqrIe6019JJtGNHVI/jR7ZFoYH3pdRq37Sbz4AOFpblW8RZMYvShm5n7hFx4H/gkyYk88OhoqmyPCIMJeT7BUkWDGUnX21dgAODdoii58bRZM0kmeA0tgOHqAN2oBnxUGN7WbfvyzQbXoVLYzuQX7LNbxAA2hdViJoGr3X5Uvx0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQXrtBGkDkGJW+a3hXZcyvf+4IxmeoYwl9uQXk9nvbs=;
 b=gkqJiFSOzxGGePCF0qpk9wJD69t9xS8kKYJP3woj/PAmxL+ba+09Ry2wO+XzycIusbJpxGnom1b+hPWUfNCIDRrJaOesLR07maB1VfzQlWqMZBiKFegjcNT8CQmwQvaNuK+Ev7M+80wJMkzpT5+gwfals8Me958uihE2d8tVIXxpeuPqCJyIbAuhv9QxdlIAaPbGE3SCM+IHGtDMCI69nFmqH2vcoaZj3nBA0F9Jxoe8XP93nELFwgLAoEJ7pSJM8ao7adAXD28d+GzKG+pgQMPOFmUkKCuDiIkJKEg5jFwngLC+7RWrS7mrsYVaOC94GxSQHhTlN5NK3vaVga2lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQXrtBGkDkGJW+a3hXZcyvf+4IxmeoYwl9uQXk9nvbs=;
 b=KuhFr4uG3gVHjKMFK2ocq5vG24tSO+4nVxcv7USuugzAgQDk1nbqTej39EJ0vJjJxWt+57PYTuxy3+Wxr48ll/Emc8y8dHWLT7z9Z1QNW4cen8UT/Z8Kdp/KF0cTRjNawTNFyY4/V5zxGNErUF2pF3EiXWScCocHZxnfFtNpaMo=
Received: from SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::30)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:34:28 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::7f) by SA9P223CA0025.outlook.office365.com
 (2603:10b6:806:26::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Wed,
 23 Sep 2026 19:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:27 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 09/10] drm/amdgpu: remove redundant amdgpu_vm_bo_update()
 call
Date: Wed, 23 Sep 2026 15:33:45 -0400
Message-ID: <20260923193346.2292597-10-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: fc931d32-8f33-4d81-305d-08df19a9ae59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qfO2v/JbJaDqR4F/NAGpvALwQFDlBaNP19F04Lb2IHQO/oZp4/F3NbMOlssAPa6J8LoeBfgjGgpr1GiGLlg/hLAZYsvqWQSQSb49P1/jSjKsarzypKO9F6Tc7oOq4YHNsI4Nh8pnhRE4POZAJ9aKjQqZ7GfDiQ492ic8d1sgJXAUNAWR8fPS/TRLjHtM/sKcvuzILt80FbIMB9IdvM7kK3mGu2Cp3vW7UKp+Ef4QbteOAbwjhaFmcs1oy+kZA32q2klMnV3b8yIuM9rIev+W82BhCT/A9hM8AKlp1j0UcHkUD7ZShTs5l3kGOuTM0Ch9CHxUbLmK5nSIzqJC3dbOcz3anBl1el+MYY59ZfVcrL5FYNYkfMJqJIRQVEI2fPxk05y/q60THLNfKwoO+64eg2VTvob8iLXtcvQ8vIO5g63MGmKIZVKp2BPSHOQbR0xNzk4XIkmtgYCaJgm9V/8u97sHdwhh8Y7yqxYhXgVt24fQcEgSF8LBmJWe0z2WW6k31IHYu8YAdAB5ypGI5DnswVvsCA/vGd23Iig97/GYuj1Vui5H0v5IeUBZ8rScCRB8Ga3IRfeAJDIWwRc4J60cl1DBh5auH191K+31kqc65GhhhArxuk8/KVhvr/K0DOZ63M0VvfuMSzVlBM/ezLZwhzSNyS27PTlC8Seq0ebTazuC6rA60ZiZWROOwkBYQQidR7ZtuMDy9EVdWhDPUs0aew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U86/8deyWb121SY3Pqbngs4zPIV+No/m3E1sFXwW+H3ePTmeeUyx5iJeXbuSn671w6z7HgMMr+F+zTBi366Pp1zNMH/rCkGNIuxDMxff8J54G0CP4On9bWwLGeW+UyKsWgVqQwBE5jL9BeAGc6QuDUbNiRhBySmK6w3Vx47wWBXsITCI6sFwu6+OsBiIW2+WSx4PVy7WRpZTUCr4r2NK1DaXmvhneOsnrpl8BAgXI+c1NPkcNzJsmp7jFE5er9p6JAsA2bxYwcGtxGaHp2uh4SOo44NK83H9FvZaW8RVVZ1c33+h9BdOo02f/5EbmogCzUfHAE2xL4yW30X6bLhKezdnrfqCKVG+wtDn6tXRaVb4Bt/x8Vagn+nkhlqCp6Igfsdo2rqFo47ApTagO/jNUC0bSJT0M8VjWtK0yBugAxRH4MoPr8y78jSGRPSbhLVp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:27.4513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc931d32-8f33-4d81-305d-08df19a9ae59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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

This is already handled in amdgpu_cs_vm_handling() and calling it this
early is unnecessary. Removing it is required to allow the vm to
initialize without waking up sleep.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 21a225b0116a..fbf9ec7d467b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -103,13 +103,6 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error;
 	}
 
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
-	}
-
 error:
 	drm_exec_fini(&exec);
 	return r;
-- 
2.55.0

