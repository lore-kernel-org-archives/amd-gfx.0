Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D9CCDB475
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918D10E915;
	Tue, 23 Jun 2026 03:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wp6+oleT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1492210E915
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w72cTM47C6qOQQdkWVQB8VMyawWD9LEG0oQVJksV9diSzSCfLpngeFj3AzPBrbeYLiWs/f+5ps5yMFK0vVwiIA02s5Ofk5hseZNx3Spnx62QhmFCS2CdBFDyetQ68L/B428UKnUQgSU9SfymVtOuDGRCdinp9wLFKvPwD1w9NNAOtKdjyeZLOJn40fFuWYtHa0vPuXd4HL8x1nJUpiW13jU83mLi6eQsgzP/1Lwe6vnOM4VTkJ6QyxB3GFdy15FuHt549qQQ6GspnhJWRDTAgP8k189A1LnuMAtrQo5jFcw8LNlrkM1QWxNg1zTTuEmDAgHqEC8kJdAshUnP7m4xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x11cGNWkm9Stv/SKbmOs4ApGzr0W0jmB4CboYebn/Q=;
 b=OkJNZC6L6o+st62L1M8vgNSKNRSKXprJpNXapAEioIg6Qn/GykdSSuRlDH3BO/sC+M9at/+1F/VsWN840oF5bintxLKPlc8xvQvJhHLYtvgiERvbpn0oeYa38usMZaC3xF42U+Bp9XUQQkFHS4QBsvuV7hQtOd9QjAoe/llEQtYPR2S9iMsuaZUxf7K+F70pCdKIYegCJvnzXmnh2Ai2uGlqGP/8hGcK3moadZ7KbtuMqE7zPh+N1+AklpkAxbbMZeeoiMfrWCcXpbKtJn0Ylv7mGgM2mZDgn2yaVINnNqkZI6hcrHqHUTsnE/QoqDFIPaNUbhhvqXsaI3Uos3nYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x11cGNWkm9Stv/SKbmOs4ApGzr0W0jmB4CboYebn/Q=;
 b=wp6+oleTFzeGmlqF/BHfKlhZBUFeQBKoP81fG+tuJjdnVhUMk6ennf5AZKdxoVO54d0kMScIV93xMLL/KvneLPU2Tvj0i8QfVYrnJ5ulJFjdudEiOaBchFMtGnJ4EG/LbZGGONNhA8hQRRGkAnTRwbf8UJHLraDWETJhuXSeyaA=
Received: from CH0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:610:74::19)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 03:42:08 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::5e) by CH0PR04CA0074.outlook.office365.com
 (2603:10b6:610:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Tue,
 23 Jun 2026 03:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 03:42:08 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:42:05 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Use uploaded size for legacy custom PPTable
Date: Tue, 23 Jun 2026 11:41:48 +0800
Message-ID: <20260623034151.263746-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623034151.263746-1-kevinyang.wang@amd.com>
References: <20260623034151.263746-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 287eb015-0645-4383-0a90-08ded0d966c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9SmFgY3/Zv6SQ8sFqb7VqhuN6Mxea15oTtWaE1EgiXEfeZR46D6BqQKJ7bwqutczpYAPRTzPGMCqOj6dx2bds21P6+SCUPrEk561D4lobiSexmSjpmITWRySms5cfhz1bZb2KuBTbcwQ1r5znHXitB3CKI1SQKt5FvxsNMrQq98zLtPwbl7787ahx2XkgVrGl8GaRX66FT42ZXBOgXPJPTmjAU8afpbMYEe02TmvpWLmatxQ/9Cv/0fKjbC1XXWYQL184el1aXmb0X6n43QJ46eOYeO4ZSbJAYHeicekAZkZGRd7dnn7hZa8xIoTb+gKCtXENEFTVo2xDpLAlCL42n52WXR2c3Gr++r45di60+XRacALp1gpIqeW2RGsf+kjYDVHG94DdPQSEhbkE0aLM8D0gm2WFvSYy6nxX66RFUWiAIPQVsc3CdLvC3ac1egQWCz2d/8lC5wXFVeRPOB3apSyP4wyMplWcnOc1lEP+6etCt94Oly6SLysCx6htkxMzEseWXfUWb+NmfutHXiitKwBddHJZxyU9GO8GXsXWmVLRFaSaRJoPVtZMpqIb/tuqhzakVHU+vloq5iv0CddqrdZIV2GBuIiLgCCiM1PFsLUed+SttcbOgfm8vPqVOrg77nzTiXeV1ar2OSkMCowSEPu9wKT9/PXPb48NDzBtfMYeYeHRT0KrGH+KVeZECTy9x3VIMbB99ykbYsGDwu3Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zNemFTU+kZZcfOzJ+QuRSzSAhuCaN9oWw2Ef90mgS2eQCPbvu+7LVv+TlQfuRzhJOk+/PzcqglJB6YHSFhgap9Gq5VaSDIC7uGFu8KuCVmvIKOcAD8yWzUvzho8Bl7fxl+3STfrTOwbnugxOCMN7J9vkgB3bLeDiANxDmfI89KiFeKsV3q4zlMukGyf9kMoXDoIrvkhMIW3E3/CqyxSWWl7h8iTn4qKhrZAE6a/Z5o3El36WmGkyITv+mvFWcqF5Z8+O0XZ+lJXdZYtxT8lvYsWDj0ETN9Uei68Lhw4Dh1K5wEp7GCivUWs2QAhgkqov/3XFFAKrIe3mksR5MZFAtsnyKs9bhTHbfNx+vQoUYhhyF7ubQJahwdEsVfbdeaMAgUxkHoyveRkhOE88p+zH9EHlazKtwkMGMFGul6KIOjDlykqmMgwmTR0q1LbLUJZW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:42:08.3690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287eb015-0645-4383-0a90-08ded0d966c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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

The legacy powerplay path used to allocate hardcode_pp_table from
the original VBIOS PPTable size, copy only the uploaded bytes into it,
and keep soft_pp_table_size unchanged. If a custom PPTable is shorter
than the original table, later code can still treat the stale tail as
valid table data.

Treat the uploaded buffer as the complete custom PPTable: duplicate the
uploaded buffer directly, replace hardcode_pp_table atomically, and set
soft_pp_table_size to the uploaded size.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 35974fd02b27..fc1089993018 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -660,25 +660,20 @@ static int amd_powerplay_reset(void *handle)
 static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
+	void *hardcode_pp_table;
 	int ret = -ENOMEM;
 
-	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
-
-	if (size > hwmgr->soft_pp_table_size)
+	if (!hwmgr || !hwmgr->pm_en || !buf || !size || size > U32_MAX)
 		return -EINVAL;
 
-	if (!hwmgr->hardcode_pp_table) {
-		hwmgr->hardcode_pp_table = kmemdup(hwmgr->soft_pp_table,
-						   hwmgr->soft_pp_table_size,
-						   GFP_KERNEL);
-		if (!hwmgr->hardcode_pp_table)
-			return ret;
-	}
-
-	memcpy(hwmgr->hardcode_pp_table, buf, size);
+	hardcode_pp_table = kmemdup(buf, size, GFP_KERNEL);
+	if (!hardcode_pp_table)
+		return ret;
 
+	kfree(hwmgr->hardcode_pp_table);
+	hwmgr->hardcode_pp_table = hardcode_pp_table;
 	hwmgr->soft_pp_table = hwmgr->hardcode_pp_table;
+	hwmgr->soft_pp_table_size = size;
 
 	ret = amd_powerplay_reset(handle);
 	if (ret)
-- 
2.47.3

