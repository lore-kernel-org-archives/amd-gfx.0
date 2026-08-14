Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048DFC5DF75
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D29610F738;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwLykktz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E315110F730
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXeW/lVJzYtU8LJhhpEzDMz1Qhui2c0jIgVMo2lyIFr5B0EBRCP+dpDbxMje9XtnZn1KLHMSRK2kqtUvh9X4olu49na9QivBSgQi+2A9KiQS6FzSX8ruf/zHolHFYjL/PGKJP8jgEKDKNTek+juHRqEmjjII6rykIlciXSY+hQjlZfsLjI/6rTf1qEz7uY784mjImtxkyVTtxAx8vVWWuzmzYaA8nTLyrPjGrALrpXULvfSDU8hgwSo1oAMpFflU5lAvCHBXvi0JdBMcoQKPvB6Sf2Ng+eLbS4W2NCelm46/XgjwqYjoGN5ZvCs8OHgUgPzzwvU1xtEIbG2f5uUTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFKAL8e15yGGTXjOcxv8hIbjNTe1TAJ02ZI73W0s/s8=;
 b=IpSwZTnMmQMgcdd+PZGio3E9eC61kT1zsFQ3GoLsKS8fm7fHzDswMMiafIV215fOZjKSHYBPIwx/Dr/56di9bzBI1inUbzTXn3I8RF6I1LqKjTBuatYbmjHyFmBcWGYZSXLlKG8BbXIfclqjupTjleGnB3o18h7i0AMEcuyN8yeJQfvM8pgML0WhwAS/CM/olRrZK8cCH5st3X6FxnqTlF6H9MN0Md75POYKHMvkRKNVKXr3flKGLkBZy5TiVYrY0HkBnbzJKypl/PAeMuGLYXNVgxIXxZkSfWhbS3ydkEJeUDVg7X02viwHnbFbfCHICcNYV1BjPFGM7cHrqYKk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFKAL8e15yGGTXjOcxv8hIbjNTe1TAJ02ZI73W0s/s8=;
 b=bwLykktzwEOttJTl4AYBpGRcdlk7kYmlmauVlgpBhAhvuYwmbr4q5L3NiDRU9ZDC1kETcjqqmc2dAP9C5gWopLM/zTsT51XIzGO30Lon9yd4FI5Jl1mUerg5y0tNE5+WkmsECI1FPq200m6HFwl/QqCvl6iAIJtHrCW1eXPFtjw=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:55 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::5b) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 089/109] drm/amdgpu: extend ras feature mask to 64-bit for A +
 A
Date: Fri, 14 Aug 2026 17:02:26 -0400
Message-ID: <20260814210246.3067612-90-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a243d8a-7ba6-4140-b30e-08defa478d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 38Y8rSYk0P7Jk0gz+BCDpzi68ECu9NfP/fPGWqPBtwUhYZZI5/slwKdzE2wzSi0DqEFjyyVK17aQ/0c/OwTmrk3Cl9OeNe0xJxxWZ8DWtfMIUF4rfo0hIjTDRKj4R6P36JySZWncjQ1xuFVNSLiBxmqatSVrAEcn2S9FQ20ebiBgrN7NwfgaQnHeA118ePfDyXt6j5BnN+/8HU7NSrjto02GADe6doMZqfZGShOt1l/mg+xwi6GlSbExD/Mny5hsyX22Gs+3VQx4RM+t6kUQiIEiQ89j9Cwx9HStJFBOYBh5a31JqjNHC/4Pubra3Aj/ZaKqaLxVmCzfqvEeA0KOGmJy5KJ7wGt0AIo9bm34Hggz6p4tx0zPpXIlrPJnB6qqSZH3wchsYag+kLrHTaH1UkFKVPg2ZMkRsVXm9jMLXMnAtwGFMxJtUKEeW79O2S4Xy5BC23nXCEQsrR757RpvJmxz7eks8cDTkZh5dtpxXwqPis4U/f45JRUgWDYT1JuXlcZ95NlCOcFKP2IGaZ3pyhxSut/qijEE4XMZlFCzipFX9KwjMl/0G/lLS76GwtckIvaVHmIb379/DaVeEBErxA8y54IOZovi/Onc56zM7CBU7bAp9tOFRyQ9Ugj4DSSw8TiqCva1UGxvDF7XB32ZAWAmtCAEmjCNZDC/edXl9hBFBpf7NbuBfepu9q5nbFgWL10oxwejOUwPSOykXejYwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7T0mWvpZSo0fGSgq5zstDLmnoaee4h7WzazXIXpa6TBDuAmtklPVcZKl9p04//8n7uc4+7TMEPhu5ebI6BrWSHyAk95GuLwuPyOmTfFuSlXn07nxH0m5lGV/W4zyc0S447gW3YtiBezMVW3/EaxDh6+Ert/xu7DOYq5YyAtYj5GTWFra0371X6vPbioBxCXTkTvQvrvb97c/QR7sox26gXCoHmjdA6xh5g3ysp9F2Jgs9OtZrQiAgojRTNEiSpLqfKWucsEzsABo4Ry2EQC6ssKvoh0papqvx0SKYIDnUWLc7RntxLjuZo9z2UIR+89KaPuWVd6XIKNvdV/BJKM6LKhRpkWC5/raLBP/bdP8P5Uv74NMkSQFt8vpa2r/fRjGGDJPc55gQd8/1a2DRBt/2WTWXzN48zMEFdeB7r/va5iYJY4rO35AWhMuOBi5Oli
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:55.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a243d8a-7ba6-4140-b30e-08defa478d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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

Extend ras feature mask to 64-bit for A + A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f3..c7fa2fa982e93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -208,7 +208,7 @@ extern int amdgpu_backlight;
 extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
-extern uint amdgpu_ras_mask;
+extern u64 amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
 extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ab380ca7e645..8b0030fa6d737 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -264,7 +264,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
 };
 int amdgpu_ras_enable = -1;
-uint amdgpu_ras_mask = 0xffffffff;
+u64 amdgpu_ras_mask = U64_MAX;
 int amdgpu_bad_page_threshold = -1;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
@@ -596,12 +596,12 @@ MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 = disable, 1 = e
 module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 
 /**
- * DOC: ras_mask (uint)
- * Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1
+ * DOC: ras_mask (ullong)
+ * Mask of RAS features to enable (default 0xffffffffffffffff), only valid when ras_enable == 1
  * See the flags in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
  */
-MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1");
-module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
+MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffffffffffff), only valid when ras_enable == 1");
+module_param_named(ras_mask, amdgpu_ras_mask, ullong, 0444);
 
 /**
  * DOC: timeout_fatal_disable (bool)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4def1bf489c3b..263ac4b2ab582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3469,7 +3469,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
-		adev->ras_hw_enabled & amdgpu_ras_mask;
+		(uint32_t)(adev->ras_hw_enabled & amdgpu_ras_mask);
 
 	/* bad page feature is not applicable to specific app platform */
 	if (adev->gmc.is_app_apu &&
@@ -4384,7 +4384,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 	     block == AMDGPU_RAS_BLOCK__SDMA ||
 	     block == AMDGPU_RAS_BLOCK__VCN ||
 	     block == AMDGPU_RAS_BLOCK__JPEG) &&
-		(amdgpu_ras_mask & (1 << block)) &&
+		(amdgpu_ras_mask & BIT_ULL(block)) &&
 	    amdgpu_ras_is_poison_mode_supported(adev) &&
 	    amdgpu_ras_get_ras_block(adev, block, 0))
 		ret = 1;
-- 
2.55.0

