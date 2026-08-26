Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB8C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A6610EE4D;
	Wed, 26 Aug 2026 23:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RL/ITr8y";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957EE10EE4D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvOw00oWRSOzGhddhs2+H0o22ixerHf4f0NB7SyoUAM8xkOzLh7W9iV7Z/LsTcKAlyOHfjexYvGqxlWJ6cvbdk0uUwAl4fXU7Nj8IeeNFbhSbfOoPhOnk7E1ygXZcSmceiJt9YfMpBG1ONcUTWYMHmDd07NU6Tdw3ZxwzDGpd38ghqBA/gHmu8aH6la6f2fQo1Tji7aBA2f7tfpvERTahkCC2aXzsOMsx9pEaFPyNzKI4z8738uDu827yH3jtQ5R7FY5zJnRfvPcpWLABekNircuN1uR5+PwPX1QQJPZgYdAx7yi7FXXBy+3OauFV1zEnnA2fHxDCmAv76OeDBCK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9QAuw0xjq1tyip6Ic6fdbyolYyWbDL4bH8KYbc6nWE=;
 b=tWvPpjF8VkNzntKtymTLvkm9m1sOvSGImEkndDzPCeoxMkfNFgmteq9OPL7F2/bSDKw2wKOVAfryakfwuGBEawb+1w8+5WXWNRgnUmQ5MJ2h1t5MGzX2EAesfqCT6Y6jBThiKaN1n0Q5zqS8G5UkOk3YTf8imxQgDWJyjEimfPIVdhiMkX/pFJ+q04DOBJtdCDwYVLhwDnEHw9BB5NKfwHLL/bemvqmtR4vJsfs0x+GtNQYGSPpapD21mNedUGBA/axvrC0q910S9ouI77TJOnq24K0TeHVPsV881xpur2k+hUBmoy8AADJifVkqFVV+jRSRpegdAKH1iECdyUe/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9QAuw0xjq1tyip6Ic6fdbyolYyWbDL4bH8KYbc6nWE=;
 b=RL/ITr8ysfTFGPMzSb64580oPDVgMGh95mlwqD+fWIgcuZMJyKqBbu4Zg6dajnU9TPEiXGNvOe/OCHG3c5K+l6gC2VTf6/2t/HYPgVRMwUFk0YaSJtDR48kGcWjXMZ+v3Xlkdl11mwdubE1WdhIrfOElVYndwKR1v1FIm0Nqg7Y=
Received: from PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::23)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:24:54 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::3b) by PH7P220CA0157.outlook.office365.com
 (2603:10b6:510:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.9 via Frontend Transport; Wed, 26
 Aug 2026 23:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:24:53 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:24:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 27/59] drm/amd/display: Skip ACPI backlight caps test
Date: Wed, 26 Aug 2026 17:04:58 -0600
Message-ID: <20260826231519.881949-28-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 158cab9b-7df8-45f2-4e4c-08df03c93bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: /scMkK3pIRCnKiKI8gmCXZuVz35lBZ/LfKhu5BnINxmYgTaoqaRZLsYOuKVDUrBYLd707yhFqkZU/CcgM0vgr/8kydlIT1e1eJnxJrp0EmFsWnLgQFsyE8knhbUO6UPcB7B2B9sGzc5gNWIwlzdFgV100Ev06o/1Xd/9iMvL3c2boXHOEDJ7cPYgXWCLVTrccLI5BqAiCMtdUIoGY/yDDJJiaoy6ozzvQGYj/gouLBz9ggONS3dHQkOVVYeccm5dXAliLuhAd0tKL3ozvlE5kRh4TwOIjypFKJiswbNtiwBOMgh9mwfN43u8+B89Z0Kog4Jj3aSuw/RIpB/0Hj15awtt2ItzyYzqYaBNvYyXAKXI5NVsUz+VaiHOtW/+HaPAgFCfoq92vF+a8vj3TXQpEq+whQUXgMv1u5I0Md2jNUzn+7vXiRYHLa3VS3ULnWbwaEhhkcA2uXDmrb5+le7hU877OuSV8keIKJrTIExuCHO0SnieiSibAb1IRTJ0pRv6rrb3QmgpHWhGgsCEAEWu4TRKwdS+qarbIqPj4hsZKTbx6ZeoiGBJuPbZkuRTXKXey6+rL3gdceIAvYhNZSIHtbA8/uPBsTbkoV6PIFM94fvW/nclouXlKBGWzIyDK7KZgyq1z9DcVkl1PZgUg8rKXKla8apAf1MvIxg9OgTPHLOnD/vng3HZbYgpvXeaEeko+b0Xnd6t7dVBX06BrUpEdg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fxzPpDZMYxhhVglJdAvvfVhOioQfqbRK9lvqsVoMcHx5pLGJOw6ieHKAkApAlQxhcZAxc2paPssKzt6TMBQ3udSOR2x0MbXzC1iwphk4O0dBKhuRqNSriUbUP0jYMe/QfwBgZb0CIdg538PPXwkjkgRG9CLZUHoHoTmQAYX2yL6og9IdOgtnCiiTUV5IYItlrgUoOyykCn0/AUUUUhqIwco9iufxi3Id+t/vWe1gVD1ml0ddxjJATdwD6/Pm+2QRGo+47RAW/cGjQK5TIyheQ7jsX1PI6TTxXXgJygi1R9cOdDn8O940Qs3PkdbSnKM5tC/PlUvjBYG+1jVoF8N9ftL2E+cHV/ltxupmO2WZq7rON9ok10u4Ao5iJCPo3/p7Of/hjGa2whFweldjHO0BVj6tImzQVee+/yOncTrk2Mb90a/NdnD5bcv1vtBogKTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:24:53.7800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158cab9b-7df8-45f2-4e4c-08df03c93bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

[WHAT]
dm_test_backlight_caps_aux_support_noop() covers the !CONFIG_ACPI
branch of amdgpu_dm_update_backlight_caps() and is wrapped in #if
!defined(CONFIG_ACPI). An ACPI build silently drops it from the
suite and never compiles it.

dm_test_backlight_caps_non_aux_sets_defaults() adds nothing: the
defaults block it asserts is already exercised by
dm_test_register_backlight_device_success().

[HOW]
Compile dm_test_backlight_caps_aux_support_noop() unconditionally and
call kunit_skip() when CONFIG_ACPI is enabled, so it is reported as
skipped instead of disappearing. Drop the redundant test and group the
remaining KUNIT_CASE entries under amdgpu_dm_update_backlight_caps().

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          | 31 +++----------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5a8eb9e54b6c..5221050dec2f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -747,8 +747,6 @@ static void dm_test_backlight_caps_valid_short_circuit(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 199);
 }
 
-#if !defined(CONFIG_ACPI)
-
 /**
  * dm_test_backlight_caps_aux_support_noop - Test Backlight caps aux support noop
  * @test: The KUnit test context
@@ -758,6 +756,9 @@ static void dm_test_backlight_caps_aux_support_noop(struct kunit *test)
 	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
 	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
 
+	if (IS_ENABLED(CONFIG_ACPI))
+		kunit_skip(test, "caps are queried from ACPI firmware in this build");
+
 	caps->caps_valid = false;
 	caps->aux_support = true;
 	caps->min_input_signal = 11;
@@ -770,28 +771,6 @@ static void dm_test_backlight_caps_aux_support_noop(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 222);
 }
 
-/**
- * dm_test_backlight_caps_non_aux_sets_defaults - Test Backlight caps non aux sets defaults
- * @test: The KUnit test context
- */
-static void dm_test_backlight_caps_non_aux_sets_defaults(struct kunit *test)
-{
-	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
-	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
-
-	caps->caps_valid = false;
-	caps->aux_support = false;
-	caps->min_input_signal = 0;
-	caps->max_input_signal = 0;
-
-	amdgpu_dm_update_backlight_caps(dm, 0);
-
-	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
-	KUNIT_EXPECT_EQ(test, caps->min_input_signal, AMDGPU_DM_DEFAULT_MIN_BACKLIGHT);
-	KUNIT_EXPECT_EQ(test, caps->max_input_signal, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
-}
-#endif
-
 /* Tests for amdgpu_dm_validate_backlight_caps() */
 
 struct dm_validate_caps_param {
@@ -1965,11 +1944,9 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
+	/* amdgpu_dm_update_backlight_caps */
 	KUNIT_CASE(dm_test_backlight_caps_valid_short_circuit),
-#if !defined(CONFIG_ACPI)
 	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
-	KUNIT_CASE(dm_test_backlight_caps_non_aux_sets_defaults),
-#endif
 	/* amdgpu_dm_validate_backlight_caps */
 	KUNIT_CASE_PARAM(dm_test_validate_backlight_caps, dm_validate_caps_gen_params),
 	/* get_brightness_range */
-- 
2.43.0

