Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B7C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C88710F0AE;
	Wed, 15 Jul 2026 13:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LlrnE0Gf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9980E10F0AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEhvoaqC7mV6xPfVW/wRZrfCiqcbHtYJX03tG5CoNso54gmcvLisF8zox5GA4EkRcV8yEXXwIOx/fzn9l7qhX7ihmiIvviTdJsS8ZUjS8V2PgaeZuYGYfUfyZTRJIzCW978eefNo2dIRAueL0eFedT4LIV+FMr9wwa4qKktNAX1i44bQfx9TM663hCSxENHYuzfQm+VU+ENboXtOD84ugNXUBWAr31SG22sPMw3P7PUYb6223nQ5utSmiTpSebCjaZtN9EFT1+p1s2Wy/bFpvA6dY0Y3mG1hXiIRYrZdwdguVcqpaThmtR27hFIOrzmIwKS1Q8fN+YaVfD58QZy9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7T2hAVYeb9KQ010opLPRtBsUebtfOgx/deIbmgndLQ=;
 b=GAHOWeuAk88O9uOlbZUQYSRZQaeUbzdUnwaMeoL2efxDvyu4CWpumMgQ8JXHXdngixSoEqK23XQJOAgQ6MK4KcUiRETXc8CDxjAqxRBvkL5o3WOaAsh0u5DkgDQzfeXfEi24hlolyih9GlhUCbULDPRBdEGFox9lkHDtqkNsguZgLWMG8GeqoiwwdZ0veBK51z9dV8Tde+LJHSkhODRonA7kB7Tn9CjiMuYn6GTxmNu1LlllSxLSkt1P9zt+nKJiwjXkJVSXTe8cv/2CuWUHSPlLw5P3XiH9DEvQUAWlRZWqjCBn9JjlevfUHmfWdlKXtWebbau1CtzgguNymJFpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7T2hAVYeb9KQ010opLPRtBsUebtfOgx/deIbmgndLQ=;
 b=LlrnE0GfE6P25gfU+hXLW0MBQDHyAwPmFsvlten9QP+rY82kw3TZBL+9hA0TKt4o/HxtI3/var7Xoey/9FM0j67oE46LuyfqmM5akEIGL3/M5PYOug8ZAJXAzXii3ILGXMvu2RCrkK67mGCPonGUshoGyYqsdGMisjg1NZU6SXk=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:49:00 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::10) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:48 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 62/70] drm/amd/display: wire DCN42B mcache programming callback
Date: Wed, 15 Jul 2026 21:38:12 +0800
Message-ID: <20260715134432.1975118-63-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: b05eb1ed-c708-4a0b-9230-08dee277d303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|6133799003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: G/XFXzCi2ElDwTrcqbZ4op28ZAhx8b6FufYjdfSAfUipxn6pfUl1BcRMYiqQqtcU9tVx9f1qNYJKElwMv4gAIxeRjFJ+ycuoygA6oNg8gw9PKMSvTE0vlumKayMz1ndC482xLJrmUsbMi2YiLjZHRI3xdbiJ150A9FIaaPGJURKfxJvZTKZ3BZyyKB0cbd8bmx+eddfr1ye4DyZNWrw/X14aXVcExg5ByUnyrPOWH+TMfrIUChertWwjjfZUcsxgLPCewmSEfUMy/1cGlj5PDCwAWZQoN+XVAKcLKhcdAwZ1FDs0yQvIGApEYikjIH7W7i5Bue7Pu7hyE8gg8q6wiT0bSnN+XoCwhNsd+ffNW2Z2zMZK2C+PG1hvKZPzIPojHfR8jnNZZB+BMc1L0jdGgOtHOdLTsYFEygllUMV2dy9tjucAdobhct2m7TRZMZ2BRXRG4+inuJfSi0/iuaN2QGr73P8EFh4KfzWbnA/2lmi+5Sa4ToXYwkoxIcYMUdO2knqsH/HFUDtyNDNnqnUy/2gIAgDHyzEtXmpZTJblk/MbfwHmQXH6+NqbCzLfs+xqDJT8CE4JYUo/yd82e2skNpVUhKfOuU3P1ajoGzTliRvSbZlSzwGc0XsnUqO38y2d1xpeiGJ3PqGgtUKkD+1yrUY4Qpp3pzNl9d/fXjp9GfX9ZNO0t2RJbtDc1aPJJw7fVUJpXZ6O0wGV6Dwqb4JOVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DEvcRt/Yg0wQ1nGF71Nu7vo+A1F6dfX8sWEUgMMBWcOAoWvYNWeFs5UdZ7e5a+PUZL8uOCrIQrs3D2Vbp6lNR4u0xXRAYuL8bAQj3NBu0k2fivKfOl5EvbSXKL58K7A4wzhoMACYzLSiUverrQ8BrqwMOEm6+Wy4lhRkLmHjLH696wPwQgILdnxmGEQS0Vi2sLRpz5Awp1hrx9fp98N4IxWxThemzlyFpzj5NL6mtJEYwm16uYXjAnw/AaEb8F3aJNGZUazgRLdv15AndsHY5wlxu4gBoT8m5HOjYDrQ8MQsCknax1h5+73nBZGPBvIo4ADCKsqylmzT8lI9ORh7yXXp9EbTmUl0ljyTD2nC6DDjoRuCsBVJ728q7y0PVUCA/wmQKSfTuTD7L6VPlQs6A2g1XUUZXV+ZUsxTz5J2Z/xOnhjGBu2tNiTjvYoX9J7q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:00.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05eb1ed-c708-4a0b-9230-08dee277d303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
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

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

DCN42B enables DML2 and DML21 by default and defines
dcn42b_prepare_mcache_programming(), but the resource function table only
wires the callback when CONFIG_DRM_AMD_DC_DML21 is defined.

There is no in-tree Kconfig symbol named DRM_AMD_DC_DML21, so the
preprocessor always removes the callback entry. Sibling DCN42 and DCN401
resource tables wire their prepare_mcache_programming callbacks
unconditionally, and the core DC code already checks whether the callback
pointer is present before calling it.

Remove the stale guard so DCN42B exposes the callback relation that its
source and DML21 build world already provide.

Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 343e10b4e096..2334bc5b75b8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1915,9 +1915,7 @@ static struct resource_funcs dcn42b_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-#ifdef CONFIG_DRM_AMD_DC_DML21
 	.prepare_mcache_programming = dcn42b_prepare_mcache_programming,
-#endif
 	.build_pipe_pix_clk_params = dcn42b_build_pipe_pix_clk_params,
 	.get_power_profile = dcn401_get_power_profile,
 	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
-- 
2.43.0

