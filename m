Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4A60A2613
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LlUBOtsT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC6A10EC78;
	Wed, 18 Nov 2026 19:08:02 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4105C10EC78
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRMbqIaQ+FYm6FFbSKKrrmco1wuqzJ90YmVdAH7QBPIVNpT0AzimclHWO1ry4krbyW/82Zr793/KGXHbhZamGUWNZNnBFA32/EwX5cLgTLm9TQf4MWAtIAx/c5ZtLySN/Ln514VHvCC5+Hisfsg98v5GPOglTiBHKGcudzulk7qx0rTvz6hD5cCEhWk+XDzB/nbvses6v54yAS5GKXYIGNMRLcDvWxyaBkqpbYFEqQjg5KHj4acpkGbqjjO6leUHhI7BM+JbClOwhiGqs2ptQyBYJ8bh4NxWE0K53TyP+rOdR6T6aiEsmcTmjhu4LZz3SnFbq4Gu0uV+Yb8R3YwGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az9tSdOTM//dJrd0khcXm2wkE5IBq8Kvy73T11dA7q4=;
 b=By5oWJvQXGlIehumglvNT5uAPCN1d1soyvkNaiPZ+DRQqt/5/oftO0VpHuwRtMrj6zOUhIrd8f9rWBy9oKwNg5ymrmrNtV1wisxagttg+WYWhpcka5BralhTVvMtlXFnH81W9ctcQ6+/blpCTsOj35FOM8c3nwk2RO2dDxz0D2d8vjBAr0R5NEZ3ShxK0slzpLlH3kgqf8/+nKM1WSZbfg6xEsA750f6s4MTTdFipVBAtrcK90K6zHN+r9QfvHmSH7MeibGSGjxARkV0mMn8DUd9oMKxiz7slByTBFFSE4ybHcXR6m/Taxm+DJgSoNVgFdXOMCGfj9+jAZcjiF5EAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az9tSdOTM//dJrd0khcXm2wkE5IBq8Kvy73T11dA7q4=;
 b=LlUBOtsTHSVh9znDR7zJAFGlIk75+Pb7/rlqVbksKkXzKESl1H6NtAgtWthD3i16smRj2kmsIjA47orekMk4X24HQAkHpJZS/gEjMmYjEmHLvriIHf+v7kr25XzBIy8iSVYYO0njYDS6VHuNMcClGRxKjfYD1llkp0BybhYuAEY=
Received: from CY5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:930:1a::31)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:48 +0000
Received: from DS1PEPF00053453.namprd04.prod.outlook.com
 (2603:10b6:930:1a:cafe::6a) by CY5PR19CA0040.outlook.office365.com
 (2603:10b6:930:1a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 19:07:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053453.mail.protection.outlook.com (10.167.23.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:44 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:43 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 08/10] drm/amdgpu/vm: stop using amdgpu_bo_fence
Date: Wed, 18 Nov 2026 14:07:33 -0500
Message-ID: <20261118190735.1863676-9-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053453:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 471da0de-44f4-416c-6a74-08df45a73a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261028144727099003|261102123227099003|261022105027099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X/MfpzVDDMBOJ+U07dgs4EVnBudZIwV4oAnwbw1xii8XHkC0yPdTBu6A4vQQTehkdXZFgxhNl7xZEAiZYcQW4/dz+0N4bxycMBdUdeJ2XZKskiDs1aWJ/I7NV72NQD6QGHCTY7wxMmLtfDByclYiXC+ISsjMbFdq3Sy2mG2TtWVpBqcZgssU2Zp4JKBOjsLKXVT9p0R9vMzOoFzt1wJudkvXbXJaeUAoudyPH+zkR7hG/Ucwzmop6O7WDBSxaBB7c2iR16fZPepomQVJzFEJy1jjpJhb+qLhkF/4rNcukUGTj4WdJLezSCNk2Jv5RfCNFsRYYcZEpI4+Od1Oi434IYcQJ+TxYRsR2WrwF5bomsKyBy7haNeF2/gV45s9rECY0U3poZwX8Xj61TtF+AevXWCAlX7hZO6fbm0lCBtp+i7j74BKXMAXzWNAoP1C05fga82iXCAOsQRS6sP+fBJ77owLozF+0SZWYr0e/UUiHrA0i5NBzC6LFiqn3VhBapO8IbcxM2+BYzdSkaktxjxZ5me9LUZDBoSJWhWX3uxG7WiR8f/UCHBrH/7wnwkrR1N4BKvOAyB/2Fxiq9l7jsLy8W2J93SedLU7TmQ4WSbEP1TfbeQ2u3cymxYfE+bJJsFzdEFF7XCaoGWxMwT+s5rUjdPwBHIeLwvjitodgUR7uAt1DHw9gMtv65W7sP+aiigY0KxjzPPCeqUJc3SSLCfifw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RjDwKiJxITyp/mzA0QX3xXzDVBIgvGPlyKVoLy2l00RUmOBXlUtW2NdNEW2HaUlngD6OqmJJ4SkaQiRHcUuELNI4HvBiTxM3MqOvSFR32+6ID6aixbwCbfZ81SfAbC1LyQLd5A46W+oiVtX5yh0QZBSPS7uoCAVN+xMc0Tkg6fggUQphRChdxOiC1epDr3J/jyNK29dkgVRUgaZrNmWTuOVm0MJ+ZZ6CR9mmTnUuT0uG3QUNSxRPwTnXcJYG1ooX8F/o8Q4d9Ov09cgJD1ge0Ah8wkFMLc8Z3TqWiK8lNmI9nM8340kGWF3kZUGI7bXAIVaZwYIqiDTNUVwTUHyRIWKHzrT3QK5esyjXyKC9RR3FHzBPKDehHwb0wYrJxb6zIfxj8TQhkRp1p0qC5d569LIh1HtwLbsXpZ/5h6raZzhvsre7YJZ0iKhrouXY9lUv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:44.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471da0de-44f4-416c-6a74-08df45a73a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053453.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch to stop using this deprecated helper.

The original could be incorrect under certain circumstances, since the
amdgpu_bo_fence only reserves one slot, and at the time of calling the
SDMA commit and TLB flush fences were not added yet (the reserve_fences
is not additive). In addition this allows us to switch to use BOOKKEEP
usage.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index daf0e75d0bb1..2a8abc9684b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1216,7 +1216,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
-		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
+				   DMA_RESV_USAGE_BOOKKEEP);
 		swap(vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	}
-- 
2.56.1

