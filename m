Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77631F433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 04:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F6D10E167;
	Thu, 16 Apr 2026 04:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmVFuqBY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC7310E167
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 04:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHsqeYVh00zJhsGYIrB8XlUVON77W9ArkFmGaoffMvxmrm+KSH/IySagCN9y8nmzud861tNXLRjaFH8ExonHyr0hA+gW8CDVYHNO+fYtlU6ZL+9+3s+qYgypi48gCFynXjWoHFAoDn3f2aSFK4y83b3SWjWUz3qLv220y46BllfqafoRCps89Iekej/p0Z0XxoWQm/yjh9klNEQ1J3JyosO94oLUjFFkNO6k0K1nA60zXO+KO5DW/0MT2f2ZQttVTKtJYPPY7hWcMZo+PxRUY4bcjcISPj0pOlrqpkQTYAWlq7ieokdlzXdbxEFJIFKvudSIXXvPGld58iDQ8kqhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVTt7+lp9cFr+zW2/4eqCxPbTzxPoE1N5i0MdXoBz8w=;
 b=b31PmQvIcw1lMdQ5Hi1yzF/eGAA+lBLWushq/ZkBmDJia6kPkLMQdme2OZOFzTa7qcrXbGlEQTWImAHD38daDMU81VE+Lx4GBDu117vZq70H2smdTK+4bPR52l8H825Vqri6rHgM9jBjfitzcXS2LP/WirD184mzOASP6LO/paUAT2/Zl6jRJCWaWSQBR8e0BXx5vMzB9cCK0f82omMqJqIYx5zD71Yix26O+ycvRWdWWXq4ayn8uqDnDaDbKFXYei6/FNG0MJuHWF7R0KG8QPU4hzP0ywDcR6d1eE5q9qbM2jdzdat1aqKWpEw3XmNTk8hCv0ZH9VUyQrzhBOq0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVTt7+lp9cFr+zW2/4eqCxPbTzxPoE1N5i0MdXoBz8w=;
 b=AmVFuqBYCWiJe1+XbanbziECNkj75UlwyQ6373BLIeXmJIBuPmDt67PIOyzAZTAFZAAZKjABd5wniH/5kPbM8Jqck+AZr3xOnK6GfyXGBR23KS8xChvzuDN2egXJ2i9S9J0fFPVL3mtd+w5EyFLaOpWIdhp7/KKzjJD5+LxoaNU=
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 04:43:11 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::25) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 04:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 04:43:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 23:43:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>
Subject: [PATCH] drm/amd/display: Fix sleeping in atomic context in
 dc_state_free
Date: Thu, 16 Apr 2026 10:12:49 +0530
Message-ID: <20260416044249.2369024-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: a00d16fb-3dfa-4d45-9cfa-08de9b72a972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: j7YygKLZipwEYrVadOmGJwiBoBPGVtyib5xz67ks22xxnMR/w6ZirUzR0wbQMOIorVpvoCe14OFbPGI5nAiSkmgaEfbo/MX2pi4hAmD7uRZypE0qd8BfFM8v/w8XNSugxCze7LoAELZaJxkHnhHmvJZ28lbi8hgKG2BxQF+zd9yWLFTcpnuaDphhST8u9NYwG/wL3CLXNOhBbtDNYVtYDl8c3BYj5EDVF6cAv9kzbGd9otmzSnbob+cEHkLMXpv/HdT6O9WQYALek8cDK8roIUYDikXUuKmb+Fya4qfvvqDm22ddlrAQfYCwGuNJ5jPoBWFel2W0pTw3ha5DJsHBTMH44vurb+URRJwuFgJQ81bT+tgwEYABiHHq0r4fRGwT+o/xz67dz19qMmHQtsTeG3polzkCgxBazIJK3ZTxISve9oRO2Q4NArn0O7cXY4DLxhLEMAEcc6ViFVYE5su0vgsHr6ICfKFZdR/Q3G5oHayfxOxMqOW8WFev6EAZ3ZFnC4HmXJ+F8jScMky3c72eHTotfOC92F2M68qITJ/QSon8K1KSrAFWx3UzCJBKaX9Ayr9ybyR8CbIMIKXfB5cG1s8pDFAwMmqkwFnWaP+blEjKmrte1OzI/dLGSQs+cgLcbxkmaKhlkoNIvZvF5qcOtPThXGjw+dWkGTrHsUr+BRcpDDYLF5Q3tqq8FkQALCw4AHejx2Xxp3/L0WHjwrcOqYKpXf9qL2+AL5B7zpRdXXgxZO0QEZNkK3R9ttJCmMDcuiSJu0c7VU9RlqTF6brgfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zNAoCbE3RqzpgAz2ehcLAtagnxIye+RkWHDawo32UrDhMHu32HrNTiWMgKC73+Vm733QTEzdr/lk9kGDWCRAprr9lpSGMi4uXnoAHjzUWYkHZgVkRX+qPWTaneNGWsmjYwtlsTFCERjxJObpPdPGkqYuxXv7+Q7Kyyen8+RfCnLa2myJMxj5/0JiF6GAJp3FzUY2fphbgaoXtt2qHBGX3RdqjqrGlaCxrJhnP1VyjtVS5Gz1SP+7WDk4iIv4MrtxQx2u/zP+Cn1jTNrjs0y5s6aqw7RJ6TLz7VPbaXxGn2QJobCcctdyATYFkZ8y/HzlcpUdpCW28Ttl66mkBOR68hM7J6WqdGoQPpNjBfWqbbjv02QU+cxHusXh6H/ne94tJ3kFdCsdEsxADfF3U3c8GmgL4SQ5Ufa2fkJdMs+KIz8GFc55bZ0aCmRKxRfLwAKB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:43:10.4194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00d16fb-3dfa-4d45-9cfa-08de9b72a972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

dc_state_free() is called when a dc_state object is no longer used.
This happens when all users of the state release it and the reference
count becomes zero.

The function cleans up the display state by releasing streams, planes,
and other resources using dc_state_destruct(). It also frees the DML2
contexts associated with the state.

Each dc_state may have DML2 contexts:
- bw_ctx.dml2
- bw_ctx.dml2_dc_power_source

These contexts store bandwidth and display calculation data used by the
display mode library (DML2). They are allocated during state creation
and must be freed when the state is destroyed.

The DML2 contexts are freed using dml2_destroy(), which internally calls
vfree() to release memory.

Currently, dc_state_free() calls dml2_destroy() inside the
DC_FP_START()/DC_FP_END() section. This section disables preemption and
runs in atomic context.

In atomic context, sleeping is not allowed. However, vfree() may sleep.
So calling dml2_destroy() here is not safe and triggers a "sleeping in
atomic context" warning reported by Smatch.

Fix this by moving the dml2_destroy() calls outside the FPU section.
Save the pointers first, clear them from the state, and then free them
after exiting the atomic section.

This ensures that memory is freed in a safe, sleepable context.

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index dbee34935c2f..b71417e2e102 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -382,16 +382,21 @@ static void dc_state_free(struct kref *kref)
 {
 	struct dc_state *state = container_of(kref, struct dc_state, refcount);
 
+#ifdef CONFIG_DRM_AMD_DC_FP
+	struct dml2_context *dml2, *dml2_dc_power_source;
+#endif
+
 	dc_state_destruct(state);
 
 #ifdef CONFIG_DRM_AMD_DC_FP
-	DC_FP_START();
-	dml2_destroy(state->bw_ctx.dml2);
-	state->bw_ctx.dml2 = 0;
+	dml2 = state->bw_ctx.dml2;
+	state->bw_ctx.dml2 = NULL;
+
+	dml2_dc_power_source = state->bw_ctx.dml2_dc_power_source;
+	state->bw_ctx.dml2_dc_power_source = NULL;
 
-	dml2_destroy(state->bw_ctx.dml2_dc_power_source);
-	state->bw_ctx.dml2_dc_power_source = 0;
-	DC_FP_END();
+	dml2_destroy(dml2);
+	dml2_destroy(dml2_dc_power_source);
 #endif
 
 	kvfree(state);
-- 
2.34.1

