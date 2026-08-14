Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B3C5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A0310F72A;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4yIioWa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A21110F715
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvtRPNNmidNdyqiLKwfYSiU1jmHHfFWIsfHsiQS2ZJcSbz1VOLFU33QAXE2Cr/yM2Ce557rwRvSIbjcK0UA5nYNmK+hx2r0dbFgKSBZM+auDL87CO+Eh/YcbRx5HbcmzbuhPVky8frlNX9pGbtEaofFa1SMP/7FKwrUxhmCn1e9AOir0Qsqi6LLyP9FoBl/kKWvj6Q2E55cMN/i3XZJZkH6xnEj8bp23SJArAyqI6t2nX2kwX46/pKNoQDlAEW8cAMeb2HMTpACWqFbw7I5RZ5pcpumG4n0/aWA+YQnMFEQpyTyoxWFmYZtY+ziZhzoFlRll9zu9nzIh7np6L/IGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UuS+Tr5vJcey7kJYHuc8wbfFHkK0eRaTDkrhmvHAIg=;
 b=THRJmiJXnfBLMBcoeRN6LonUu1lKhlbAHINRV/9XoXEVeYC6OPv6vyA1m4rFIHgB56U+v04peoQiP2Z2nRdgi9BlkJAPGjA8uxkqg/FXxHT1u+9BXWBihFV28TAfOGcB9yGijlKgmVipUC5JLYBOjx7TpJUeFRuiHuZa15Cl6TOoBYzdbOgtwnAd7kztcH0ishGI411Sxx41TGFvNTw29bTcXhFmWzy8P4gOMQAxt3H5UNb2qWyz2c63p6BrSVDo0l/leQypoAuu8jXYBniKLjh2JGLSNSU2UJD+YNLxLXUAg7YWjJamF74E7i5peGB3nGGdNb9dq9uL0Oc4MlGjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UuS+Tr5vJcey7kJYHuc8wbfFHkK0eRaTDkrhmvHAIg=;
 b=e4yIioWaU940yYACwSVibeIJ3WkDBGL1z/Uue5TyGa2m+/DQawtPro5YhH1vIaBl+udXe4719AGhG6ba4KA4eLkwNl/UJClR83s84Nzm3PTEl/yPiw8hkIAeNQ01GB/7j9GbvbZ2tV3d8AYzrM6snLesZsqz9JmHwP7wSkrV5Rk=
Received: from DS1PR07CA0026.namprd07.prod.outlook.com (2603:10b6:8:44d::11)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:44 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::a9) by DS1PR07CA0026.outlook.office365.com
 (2603:10b6:8:44d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 070/109] drm/amd/ras: fix driver unload failure when uniras is
 enabled
Date: Fri, 14 Aug 2026 17:02:07 -0400
Message-ID: <20260814210246.3067612-71-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f00f006-2bb0-4ec0-ccc6-08defa4786f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: DlQ/GtadCO9rrRFSUerfGn/ZYTy5wS06ExnHYkDkj1iR92T6QwQR3r9bEIDNjg9xrsBhTBWIphQrgJhgUdAGxAjihvJuj7n2kRqivmISIwVbhZJfxPqrAyTLGvXLYnzZcGvOv4ejFELP+LoHkCKTMoXA578iQcleV6AN+T3hBAjYb2Na9JLEazcckx4ak46VSsTTg5PY1qAqlcZ4nk3wMChAUlNh+8x1iXD6GLhhLuIapAR1eO8BwbUXPx4y9odpKz5u0LwqVxLG7/UTb95ISx93s2hQepZgAZUPIu1jaMYiq4XE0O37xfxdWTu9X6Kitnfb7pLR0Ybsx6nsCTHQQX3vavM/9rPnWIf4yCM8EFfZ9K6I+6zVz14Yu670NXJfgqMGsgQVOVQN945Ahp3jOQO0R42FOHT74nnCA9T8WOArheeTYNOr52NxpttDiZLfaVzn+gl5MBl2UA8gqF96j7Hw2NjXILPbdQMvYQzLmzKCvhXWMq4oOgknWaY8R+GIKAWJ+HUiyKQGEq6qDMZajX+ebARSvPWujzUPoMXV8pcWDaB/aJ7+GMl71WMBoaqAXH9kwhoCr0Wwz+0ek8FnRuPBnNVh1UWRVfq+CcNXasVY25kuIAuS0ENOqaT2t08qXvodMmRw5MJW5LBHFD+BUFWzt827Rs80YB6m5CweaU6kk30e/TtW/bnQmvhjgZPLeUtZNaGbIy7Z5yciwWqPrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0pKI+kiSg9HAG+Wr/UTG+DTpqdXLKBSj9XND88hxqHtP9q0egXVL/TPuFZHigiw5bXwopYwZa0j1rvfQqlA7pqBI2M/pCK6k7s7FmucIHh77akDQeVp0N53EWAaNTFeUz629GPjsuFtPlUEBDgcnOzjuZDAZfskSXZUcytIR4C3DryRQDvNMrMfntrdoObEAH9kQWBaeLCrJ6cddjjdm9i4q70YQbaQBq6LKyJj5KKFtZQPbI4jaG76gWF99PaPSEPyyXaT9Dv7L+GRZZG0CfeNX0OHmV01zIh1Sf6ImcMxw4bVlCkCHdQ0tIHP6pii+hUu+ig+Xeod0C1Kf7ocTyZ6zufQBCOBS9uf2iOtFQMgzW8ej582NxYgIjRBGG8r6cD6siUKquxpxLd+fxYw+BIN65om7Zbi0aTuvkfFiYGESqfRCsvQHfnU56luYFze8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:44.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f00f006-2bb0-4ec0-ccc6-08defa4786f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Fix driver unload failure when uniras is enabled.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 36d6021afcf76..06668332256c2 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -856,8 +856,6 @@ int ras_psp_sw_fini(struct ras_core_context *ras_core)
 	mutex_destroy(&psp->psp_ctx.internal_mutex);
 	mutex_destroy(&psp->ta_ctx.ta_mutex);
 
-	__ras_psp_mem_fini(ras_core);
-
 	memset(psp, 0, sizeof(*psp));
 
 	return 0;
@@ -916,6 +914,7 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 int ras_psp_hw_fini(struct ras_core_context *ras_core)
 {
 	unload_ras_all_fw(ras_core);
+	__ras_psp_mem_fini(ras_core);
 	return 0;
 }
 
-- 
2.55.0

