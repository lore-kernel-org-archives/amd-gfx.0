Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F0FC88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D2910F693;
	Fri, 11 Sep 2026 15:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/Xacocf";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEBC10E41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H91NXHtUt3xLVYzb5n/0JY2biN/cKsW0vz+2pI3tabTd04ls2SF8BVGzB9Tyu7p6Rx98C7+t8vrMb7t6s/RXf20G9BuUYI4SJwLEI/21/5GS5DOHKEQXw2nN8aMg16Jd5UVWjxN34NrX0dWZhjwJIP4p8L4Y6D83dyZ4MzJA4mUnQwhUCcBjmmdfSjI5y7C2crB1ZKT6OrSv0ckZ7c7Ilalrc1MEE4VqWj/BCyPhe8yZRqVV3V5yaZJhdhjb1XmjxdB3yzMnjghugwdpQEbUYsbODXWVRGhL80hpr5nA4Hc8TVuq5Oq5U1f2l949hrEV2X+t32WXz22q/q9m1tpQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwkPD65ZZJmwZQ04dVkiodPee8Hpu5Z4gY04o4Z6uX0=;
 b=rUHzNEod6xs8mblX43Y5ng8Nzn+2mkx+Oqg0W9gAUVO9RT6I+mCr/HFyy0nlHjaHALgIPgtvnlFHwRNXdgcdPjBTd1xVzxC/JBMQp0f5PikbXPUTFQb4a5ns1Rfn1O2PDQDqgOsH3Uo48r7I6E2vgBep0jcMUCgKC/j9U3eXgscg41iK2uneUnIXxKTGHOVDvqiY8cXTDYqUadI3t+ddiGPv9PkU90xjAOBeUW5duTCon8w2AeIaXs/ik7nAt+0nB0zczfPlAtCh7JHPavCLBIfdWfU9YTAtRx4gZs8nQ+RGQUamOJhoTYChy7Cyh5miF32jqlFaT+78nWTBzbkobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwkPD65ZZJmwZQ04dVkiodPee8Hpu5Z4gY04o4Z6uX0=;
 b=z/Xacocfzyf7AE6VGYgvZLt/awGThJgFLtgUXhgDxVz1DkrDrOyrV5lNej3VevxinC/3v/c303ut8yAkJTnkl8DzjoILGloUtLapgXuievxIWI+2S2QZ92LJoZcq/bDjRzCsrXK3appCiZllsG8pN9H6nvyPSJxpaPEGpYxWgW0=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:25 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::c) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:24 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:23 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
Date: Fri, 11 Sep 2026 11:42:05 -0400
Message-ID: <20260911154212.591213-3-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: e46e7557-ee41-4178-396a-08df101b46b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0H96TIKjsi3hudrzYYjI0/SiE842ZjQBuG21GZf/lgttmnqagwuXkiki+TSXbX+xo279u1dD5Fpx7bkR5fiHv9nREe4LX5XZ9jSG209nNwKEELEd26sh5+CwQ6bx7a4FOja5NpXxVXlEcmyTok3vVQnl9aOfobNu5P5fVulsGmzlmnGw3AfHyMwvRJRPdN7qvQcuh8ODTRJeXLdG5svbn4lDUHeNq9XVsjiLyZ87bq1FB6/+vsAp6Mb/nfwakyR6fQRcL6Muxv9Q1Ag3nsXUYR0jGaYov1UVcgqVqL6mCj8VkFm5HTrACUjBfYb6BV3NR8NoUIQQy1s19d6JzUUa3+u3lNFDeDYfN7DxqNQpkRyT008vTO5ms9zlOUxkDZzZ9bxo3aXN5Zy8+KZaFPha39EvaCQpvW76yxKiceVSz3nxKU0k36K9IjLkeBxgCZx2tA8CD5S1MdTbe8wlZ7EB3oQ2Tdv31Rhzj0nGnneqdqIhTZcft5rNQTtRYlgEFWTMyw6HkQfS6btY2xhH7oBFvL3HXNHt58LStmT2DOAm8/7n3qKJMQL5D+mILlBw8UeTHiJJW7nrcJB6boVqShB0eJwiWkzhkbVBY0FI48pdAzMODS+HdpDljcP+POUc3ogkB/t6DofkuwnMIo7FIViiZmXUJwk/3I8JplmIHLCEXCK+uB72PcF6KrjV4xSwPCFiPFxjz9zQ1sgKaQbsvn+NAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ql8ocfkrTO23y9cQ4zoXNMA4hABAdqlmH1O832wuoOdOgnqU2d0piBaxEawmW3IcHTHh4rWaTJ1aIexWkDie3GZ6tjIxXxxQEV60KtaclmKO74pVbiTIxnpfsLmZIL7ksZG4jrV+EpVHwBjJFfCXDHd8vT64bADyxuaXMcswm25DmA2nXXwMbmANZSX+PXGV3oq2UBlJkzBTt+TDoZHtC4oxIpU90u4Gqm/pgoWPnkIZAmO/DCaawO/qQHSaR/zA18xcLhHe2AbaT0AOskyqhBJ/TSiIOzpMsP0mqHDOxCeb/MfHX0TLZiBlGn3/AuXZ1UcK3dvMIkjF75Bv+z3y9B5SBeJfsF8HsZjDGscJe7DGBuvTBqzVp1FWzVWfPR59lt4UhMe91q6x6XiLS/itdptEUKNvQkE2sYbSZgBuKcc8taNgEwfW54nygWwbF8K9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:24.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46e7557-ee41-4178-396a-08df101b46b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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

Only amdgpu_ctx_stable_pstate communicates with the hw.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index b15ed4a534f1..a87f26139496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -28,6 +28,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
 #include <linux/nospec.h>
+#include <linux/pm_runtime.h>
 
 #define to_amdgpu_ctx_entity(e)	\
 	container_of((e), struct amdgpu_ctx_entity, entity)
@@ -643,10 +644,15 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	 * context id.
 	 */
 
-	if (set)
+	if (set) {
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			return r;
 		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
-	else
+		pm_runtime_put_autosuspend(adev->dev);
+	} else {
 		*stable_pstate = amdgpu_get_stable_pstate(adev);
+	}
 
 	amdgpu_ctx_put(ctx);
 	return r;
-- 
2.55.0

