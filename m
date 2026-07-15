Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB03C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDBF10F0B0;
	Wed, 15 Jul 2026 13:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaBxLa2J";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA4310F0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h25BedyR/esw9P7XFEzrDyoBn1EJRJuSgfneBq0aHy83fc0snTo+DlsmZ/QEXt8V1+UJX6dDHR/sjyuLqwXx3OKl8K5OUtvlcNYiTEDCK5tsyuNe+EeCmpdYjELeSs4Hy/Xq5b7pZqXSBKSjTCJ8bEumek3vqsRZZHkR29PqOIR7tpi/ZY9sATTBGhQCNfN4Bvv2zdjLz+5aCprZGUEjJbnA2DhaCNED8jjq/d9XKkySXukKcn7I3kz8rcVNkqt+I7rr1kGWVq3PenxqtJQiQ4cTims9wdCmXSCQqAWYBOoahv5guf601HmuyPD2XY8/OBjAGu79/op+C+enDfFd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izGme/aue8A4wnMRfuuBELs7gqpPnZN161iadNyNJ/8=;
 b=A/T1HsXg29dHihwsV099xHmGkxYM+1yGYPtdPxrGGimS+jqpdRRvo8x8p0y+fWurvDC8jff2GLz/pZgqUn/21x9tzTIcgBJwJur35aQVwNsXchvZtyXqwdazldZWMFE0gDon9ygOF1QyjotoSLP9e7g5ZZA3gInKL/SwH2I5PwHZ3f65PTip4GW0XdWljgfED9Bu6106yTqD8twEbdqPmWh8LYwguVYqhvkefNpNclFdO9F4isNOAgDWprXJX646z6m/nDjFgebqpNWBxMFok+HplmcSxP12w2Katv6oCZ0JcTNdPN7rQGxbobXDbPlA5v7V9f7gJTAeBRre+Q0Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izGme/aue8A4wnMRfuuBELs7gqpPnZN161iadNyNJ/8=;
 b=OaBxLa2JDRLZoqyeuJdLWIPUgj7iN106DzmXcFlCmB078vImOaqJPRG98ONW7BSlRDPyg2FWZUjAv6vTfw/LQbDtfUZL8rWA/bOdqIBlhMONPD0pd6FVenZsX0WYukc+5gHTrigh2SizWrHAncSUuuuJhx0n9hQfobTXM4ijay8=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:49:03 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a1) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:52 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:48 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 "Aric Cyr" <aric.cyr@amd.com>
Subject: [PATCH 63/70] drm/amd/display: Trim DCE from DCN-only builds
Date: Wed, 15 Jul 2026 21:38:13 +0800
Message-ID: <20260715134432.1975118-64-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d66322c-b771-4058-2894-08dee277d4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|20052099010|11063799006|5023799004|18092099006|3023799007|10067099003|17096099006|18096099006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: X1TqEz0hZztKmidhu7b6CUyqQXltMpwrkKwIeJCm4KsHnNvybJHFV3Z8kPFRm3wiJmZZMNeLM/S++2TqickHCxEGp0DkDggbCwuCAnW7sEhSuoc4rQb5nr3Px7GL+Gh2JgJdvHwxJ/eq+yont+bpENQWKCDiZUPD4WAVfx0pUsRY/lYznJ96I0R6QutApXjTLIzEAAGjp7fbwot6J84w70mV8Gvd14do/BOT/VAZckXgoQ53B4qq82nYSLrTYHYxz+Ghe3Esa+Ey2IEB+MZHjvcVPeAN9yp/ajD95J4xT1FBy6iRuratrk1SR0yVY204+Twu5JjdCSvt0J2yw4LJMuABJijdFvb+LjyZEaQl94DfY6FdLJkls2ur28sa9mTIY3fP4uGSp3oEMrzK2+TH9cG6vys+JNUB7hEyWlhiwxt2WKCfOy20KmwdWkZwrcN+vk3cSmW8vHy+8Fks9fRO8Ymm6vsr3HBcodBD8ViI5btxxsB0mvZVZOpmJsKxOq8uCgxB62sUXn5DzHDeJnWmhpurY5nQp3Kq9ExVc1+TarHJsR0D/UbK5WJ96LlvAiKvyCUaEYTa+7g6FeTLElHTaejX0CTLrip1TEz0RUDbKxnoz65qtHE8QXrHj1Dini2Xr19pcCywrcv1P+isliIIvxGurEONVZGLcknqv7zpUwch3lVYGy7d4Jrqs3GI2x5PcB43kCA71cauG9jyH0Qs2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(20052099010)(11063799006)(5023799004)(18092099006)(3023799007)(10067099003)(17096099006)(18096099006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xCMtwxcJuBKCUpnr++ePyTMyHyihTeAlO4lHLAUndLx0+mdH5juCi4rqAksApSs6PcKdpgKC2NCZq7LgjOC2qiRVo4VGo9cjbkGtUQSKLviaz7GO7yvNTouPaNtfeqvhmLuD9HD8ZRqJGBHbwZ6XAzYwlic8otBMfgRL8jmTO2NUYVlClVD64Gd7xC3q1wiZx8B2cUgaI44+5/aT8MOdYhpQTodzxjZUAMBBNNLL+pwBHW+gEGY0dCAXsgonRn5T6VVLAkhhCPRebQkjQWthnWSbKFYbSpOBgaZgru51FV1/OkSVKMvhXNq2GteioaGNDivpedTAdCyh2hkjd8l7JKAWviJ6dCkEZh0MCawzJ12goAfKE1i+6Kg/XU8nBrPAuepdQ2DgAwWH7FoENUwYDYvuPi9zmBo4FJJU7ocW5OqaJToxon1Wi3Gcm8EvPvo6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:03.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d66322c-b771-4058-2894-08dee277d4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Removed dependency on legacy DCE sources in production builds for
platforms that only support DCN ASICs. This decouples the always-compiled
shared/DCN code from DCE while preserving DCE for platforms that need it.

No functional change when TRIM_DCE is disabled.
DCE support is preserved for platforms that require it.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/bios/bios_parser_interface.c   |    2 +
 .../display/dc/bios/command_table_helper.c    |    2 +
 .../display/dc/bios/command_table_helper.h    |    2 +
 .../display/dc/bios/command_table_helper2.c   |    2 +
 .../display/dc/bios/command_table_helper2.h   |    4 +-
 .../dc/bios/command_table_helper_struct.h     |    2 +
 .../dc/bios/dcn10/command_table_helper2_dcn.c |  293 +++
 .../dc/bios/dcn10/command_table_helper2_dcn.h |   34 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    4 +
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  203 ++
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |   43 +
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |    9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |    6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |    6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    6 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |    8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |    8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   18 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   14 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   10 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   78 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |    2 +-
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |    4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |    4 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |    3 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 1958 +++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   66 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   44 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   42 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   44 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   36 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   32 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   34 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   34 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   31 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |    9 +
 .../dc/resource/dcn10/dcn10_resource.c        |    2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |    2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |    2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |    2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |    2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |    2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    2 +-
 .../amd/display/include/link_service_types.h  |    6 +-
 70 files changed, 3074 insertions(+), 357 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_interface.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_interface.c
index 0079a1e26efd..02ac1993c71c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_interface.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_interface.c
@@ -40,9 +40,11 @@ struct dc_bios *dal_bios_parser_create(
 
 	bios = firmware_parser_create(init, dce_version);
 
+#if !defined(TRIM_DCE)
 	/* Fall back to old bios parser for older asics */
 	if (bios == NULL)
 		bios = bios_parser_create(init, dce_version);
+#endif
 
 	return bios;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index 91bc8a06e2cf..7d64aa9cc733 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -31,6 +31,7 @@
 
 #include "command_table_helper.h"
 
+#if !defined(TRIM_DCE)
 bool dal_bios_parser_init_cmd_tbl_helper(
 	const struct command_table_helper **h,
 	enum dce_version dce)
@@ -69,6 +70,7 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 		return false;
 	}
 }
+#endif
 
 /* real implementations */
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
index 547700e119a6..f0849abcbe08 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.h
@@ -29,9 +29,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/command_table_helper_dce60.h"
 #endif
+#if !defined(TRIM_DCE)
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper_dce112.h"
+#endif
 #include "command_table_helper_struct.h"
 
 bool dal_bios_parser_init_cmd_tbl_helper(const struct command_table_helper **h,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 902f06ac43c6..b974c57e92d0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -45,6 +45,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 		return true;
 #endif
 
+#if !defined(TRIM_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -58,6 +59,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCE_VERSION_11_0:
 		*h = dal_cmd_tbl_helper_dce110_get_table();
 		return true;
+#endif
 
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
index 66e0a3e73768..9e6c44afeceb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
@@ -29,9 +29,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/command_table_helper_dce60.h"
 #endif
+#if !defined(TRIM_DCE)
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
-#include "dce112/command_table_helper2_dce112.h"
+#endif
+#include "dcn10/command_table_helper2_dcn.h"
 #include "command_table_helper_struct.h"
 
 bool dal_bios_parser_init_cmd_tbl_helper2(const struct command_table_helper **h,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
index 1f2c0a3f06f9..31e56fba15b8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper_struct.h
@@ -26,9 +26,11 @@
 #ifndef __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
 #define __DAL_COMMAND_TABLE_HELPER_STRUCT_H__
 
+#if !defined(TRIM_DCE)
 #include "dce80/command_table_helper_dce80.h"
 #include "dce110/command_table_helper_dce110.h"
 #include "dce112/command_table_helper_dce112.h"
+#endif
 
 struct _DIG_ENCODER_CONTROL_PARAMETERS_V2;
 struct command_table_helper {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.c b/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.c
new file mode 100644
index 000000000000..5b483ac29192
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.c
@@ -0,0 +1,293 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dm_services.h"
+
+#include "atom.h"
+
+#include "include/bios_parser_types.h"
+
+#include "../command_table_helper.h"
+
+#include "../command_table_helper2.h"
+
+static uint8_t signal_type_to_atom_dig_mode(enum signal_type s)
+{
+	uint8_t atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP;
+
+	switch (s) {
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_EDP:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP;
+		break;
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DVI;
+		break;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_HDMI;
+		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		atom_dig_mode = 4;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DP_MST;
+		break;
+	default:
+		atom_dig_mode = ATOM_TRANSMITTER_DIGMODE_V6_DVI;
+		break;
+	}
+
+	return atom_dig_mode;
+}
+
+static uint8_t hpd_sel_to_atom(enum hpd_source_id id)
+{
+	uint8_t atom_hpd_sel = 0;
+
+	switch (id) {
+	case HPD_SOURCEID1:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD1_SEL;
+		break;
+	case HPD_SOURCEID2:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD2_SEL;
+		break;
+	case HPD_SOURCEID3:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD3_SEL;
+		break;
+	case HPD_SOURCEID4:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD4_SEL;
+		break;
+	case HPD_SOURCEID5:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD5_SEL;
+		break;
+	case HPD_SOURCEID6:
+		atom_hpd_sel = ATOM_TRANSMITTER_V6_HPD6_SEL;
+		break;
+	case HPD_SOURCEID_UNKNOWN:
+	default:
+		atom_hpd_sel = 0;
+		break;
+	}
+	return atom_hpd_sel;
+}
+
+static uint8_t dig_encoder_sel_to_atom(enum engine_id id)
+{
+	(void)id;
+	/* On any ASIC after DCE80, we manually program the DIG_FE
+	 * selection (see connect_dig_be_to_fe function of the link
+	 * encoder), so translation should always return 0 (no FE).
+	 */
+
+	return 0;
+}
+
+static bool clock_source_id_to_atom(
+	enum clock_source_id id,
+	uint32_t *atom_pll_id)
+{
+	bool result = true;
+
+	if (atom_pll_id != NULL)
+		switch (id) {
+		case CLOCK_SOURCE_COMBO_PHY_PLL0:
+			*atom_pll_id = ATOM_COMBOPHY_PLL0;
+			break;
+		case CLOCK_SOURCE_COMBO_PHY_PLL1:
+			*atom_pll_id = ATOM_COMBOPHY_PLL1;
+			break;
+		case CLOCK_SOURCE_COMBO_PHY_PLL2:
+			*atom_pll_id = ATOM_COMBOPHY_PLL2;
+			break;
+		case CLOCK_SOURCE_COMBO_PHY_PLL3:
+			*atom_pll_id = ATOM_COMBOPHY_PLL3;
+			break;
+		case CLOCK_SOURCE_COMBO_PHY_PLL4:
+			*atom_pll_id = ATOM_COMBOPHY_PLL4;
+			break;
+		case CLOCK_SOURCE_COMBO_PHY_PLL5:
+			*atom_pll_id = ATOM_COMBOPHY_PLL5;
+			break;
+		case CLOCK_SOURCE_COMBO_DISPLAY_PLL0:
+			*atom_pll_id = ATOM_PPLL0;
+			break;
+		case CLOCK_SOURCE_ID_DFS:
+			*atom_pll_id = ATOM_GCK_DFS;
+			break;
+		case CLOCK_SOURCE_ID_VCE:
+			*atom_pll_id = ATOM_DP_DTO;
+			break;
+		case CLOCK_SOURCE_ID_DP_DTO:
+			*atom_pll_id = ATOM_DP_DTO;
+			break;
+		case CLOCK_SOURCE_ID_UNDEFINED:
+			/* Should not happen */
+			*atom_pll_id = ATOM_PPLL_INVALID;
+			result = false;
+			break;
+		default:
+			result = false;
+			break;
+		}
+
+	return result;
+}
+
+static uint8_t encoder_action_to_atom(enum bp_encoder_control_action action)
+{
+	uint8_t atom_action = 0;
+
+	switch (action) {
+	case ENCODER_CONTROL_ENABLE:
+		atom_action = ATOM_ENABLE;
+		break;
+	case ENCODER_CONTROL_DISABLE:
+		atom_action = ATOM_DISABLE;
+		break;
+	case ENCODER_CONTROL_SETUP:
+		atom_action = ATOM_ENCODER_CMD_STREAM_SETUP;
+		break;
+	case ENCODER_CONTROL_INIT:
+		atom_action = ATOM_ENCODER_INIT;
+		break;
+	default:
+		BREAK_TO_DEBUGGER(); /* Unhandle action in driver.!! */
+		break;
+	}
+
+	return atom_action;
+}
+
+static uint8_t disp_power_gating_action_to_atom(
+	enum bp_pipe_control_action action)
+{
+	uint8_t atom_pipe_action = 0;
+
+	switch (action) {
+	case ASIC_PIPE_DISABLE:
+		atom_pipe_action = ATOM_DISABLE;
+		break;
+	case ASIC_PIPE_ENABLE:
+		atom_pipe_action = ATOM_ENABLE;
+		break;
+	case ASIC_PIPE_INIT:
+		atom_pipe_action = ATOM_INIT;
+		break;
+	default:
+		ASSERT_CRITICAL(false); /* Unhandle action in driver! */
+		break;
+	}
+
+	return atom_pipe_action;
+}
+
+static bool dc_clock_type_to_atom(
+		enum bp_dce_clock_type id,
+		uint32_t *atom_clock_type)
+{
+	bool retCode = true;
+
+	if (atom_clock_type != NULL) {
+		switch (id) {
+		case DCECLOCK_TYPE_DISPLAY_CLOCK:
+			*atom_clock_type = DCE_CLOCK_TYPE_DISPCLK;
+			break;
+
+		case DCECLOCK_TYPE_DPREFCLK:
+			*atom_clock_type = DCE_CLOCK_TYPE_DPREFCLK;
+			break;
+
+		default:
+			ASSERT_CRITICAL(false); /* Unhandle action in driver! */
+			break;
+		}
+	}
+
+	return retCode;
+}
+
+static uint8_t transmitter_color_depth_to_atom(enum transmitter_color_depth id)
+{
+	uint8_t atomColorDepth = 0;
+
+	switch (id) {
+	case TRANSMITTER_COLOR_DEPTH_24:
+		atomColorDepth = PIXEL_CLOCK_V7_DEEPCOLOR_RATIO_DIS;
+		break;
+	case TRANSMITTER_COLOR_DEPTH_30:
+		atomColorDepth = PIXEL_CLOCK_V7_DEEPCOLOR_RATIO_5_4;
+		break;
+	case TRANSMITTER_COLOR_DEPTH_36:
+		atomColorDepth = PIXEL_CLOCK_V7_DEEPCOLOR_RATIO_3_2;
+		break;
+	case TRANSMITTER_COLOR_DEPTH_48:
+		atomColorDepth = PIXEL_CLOCK_V7_DEEPCOLOR_RATIO_2_1;
+		break;
+	default:
+		ASSERT_CRITICAL(false); /* Unhandle action in driver! */
+		break;
+	}
+
+	return atomColorDepth;
+}
+
+/* function table */
+static const struct command_table_helper command_table_helper_funcs = {
+	.controller_id_to_atom = dal_cmd_table_helper_controller_id_to_atom2,
+	.encoder_action_to_atom = encoder_action_to_atom,
+	.engine_bp_to_atom = engine_bp_to_atom,
+	.clock_source_id_to_atom = clock_source_id_to_atom,
+	.clock_source_id_to_atom_phy_clk_src_id =
+			clock_source_id_to_atom_phy_clk_src_id,
+	.signal_type_to_atom_dig_mode = signal_type_to_atom_dig_mode,
+	.hpd_sel_to_atom = hpd_sel_to_atom,
+	.dig_encoder_sel_to_atom = dig_encoder_sel_to_atom,
+	.phy_id_to_atom = phy_id_to_atom,
+	.disp_power_gating_action_to_atom = disp_power_gating_action_to_atom,
+	.clock_source_id_to_ref_clk_src = NULL,
+	.transmitter_bp_to_atom = NULL,
+	.encoder_id_to_atom = dal_cmd_table_helper_encoder_id_to_atom2,
+	.encoder_mode_bp_to_atom =
+			dal_cmd_table_helper_encoder_mode_bp_to_atom2,
+	.dc_clock_type_to_atom = dc_clock_type_to_atom,
+	.transmitter_color_depth_to_atom = transmitter_color_depth_to_atom,
+};
+
+/*
+ * dal_cmd_tbl_helper_dce112_get_table2
+ *
+ * @brief
+ * Initialize command table helper functions
+ *
+ * @param
+ * const struct command_table_helper **h - [out] struct of functions
+ *
+ */
+const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void)
+{
+	return &command_table_helper_funcs;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.h b/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.h
new file mode 100644
index 000000000000..b6fca8fa6b88
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DAL_COMMAND_TABLE_HELPER2_DCN_H__
+#define __DAL_COMMAND_TABLE_HELPER2_DCN_H__
+
+struct command_table_helper;
+
+/* Initialize command table helper functions */
+const struct command_table_helper *dal_cmd_tbl_helper_dce112_get_table2(void);
+
+#endif /* __DAL_COMMAND_TABLE_HELPER2_DCN_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index fb234a729bdc..a0e0e1ecf3ad 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -66,7 +66,7 @@ ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN10
 ###############################################################################
-CLK_MGR_DCN10 = rv1_clk_mgr.o rv1_clk_mgr_vbios_smu.o rv2_clk_mgr.o
+CLK_MGR_DCN10 = dcn10_clk_mgr.o rv1_clk_mgr.o rv1_clk_mgr_vbios_smu.o rv2_clk_mgr.o
 
 AMD_DAL_CLK_MGR_DCN10 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn10/,$(CLK_MGR_DCN10))
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 5f9a6bb84324..f99d12b648b6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -30,10 +30,12 @@
 #include "dc_state_priv.h"
 #include "link_service.h"
 
+#if !defined(TRIM_DCE)
 #include "dce100/dce_clk_mgr.h"
 #include "dce110/dce110_clk_mgr.h"
 #include "dce112/dce112_clk_mgr.h"
 #include "dce120/dce120_clk_mgr.h"
+#endif /* !TRIM_DCE */
 #include "dcn10/rv1_clk_mgr.h"
 #include "dcn10/rv2_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
@@ -151,6 +153,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	struct hw_asic_id asic_id = ctx->asic_id;
 
 	switch (asic_id.chip_family) {
+#if !defined(TRIM_DCE)
 	case FAMILY_SI:
 	case FAMILY_CI:
 	case FAMILY_KV: {
@@ -210,6 +213,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dce120_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
+#endif /* !TRIM_DCE */
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	case FAMILY_RV: {
 		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
new file mode 100644
index 000000000000..374aea165ed0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
@@ -0,0 +1,203 @@
+/*
+ * Copyright 2012-16 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "core_types.h"
+#include "clk_mgr_internal.h"
+#include "dcn10_clk_mgr.h"
+#include "dal_asic_id.h"
+
+int dcn10_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+	struct dc *dc = clk_mgr->base.ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	int actual_clock = requested_clk_khz;
+	/* Prepare to program display clock*/
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/* Make sure requested clock isn't lower than minimum threshold*/
+	if (requested_clk_khz > 0)
+		requested_clk_khz = max(requested_clk_khz,
+				clk_mgr->base.dentist_vco_freq_khz / 62);
+
+	dce_clk_params.target_clock_frequency = requested_clk_khz;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+	actual_clock = dce_clk_params.target_clock_frequency;
+
+		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
+			if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
+				dmcu->funcs->set_psr_wait_loop(dmcu,
+						actual_clock / 1000 / 7);
+		}
+
+	clk_mgr->dfs_bypass_disp_clk = actual_clock;
+	return actual_clock;
+
+}
+
+int dcn10_set_dprefclk(struct clk_mgr_internal *clk_mgr)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/*Program DP ref Clock*/
+	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
+	dce_clk_params.target_clock_frequency = 0;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DPREFCLK;
+	if (!((clk_mgr->base.ctx->asic_id.chip_family == FAMILY_AI) &&
+	       ASICREV_IS_VEGA20_P(clk_mgr->base.ctx->asic_id.hw_internal_rev)))
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK =
+			(dce_clk_params.pll_id ==
+					CLOCK_SOURCE_COMBO_DISPLAY_PLL0);
+	else
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK = false;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+
+	/* Returns the dp_refclk that was set */
+	return dce_clk_params.target_clock_frequency;
+}
+
+unsigned int dcn_dentist_get_divider_from_did(unsigned int did)
+{
+	if (did < DENTIST_BASE_DID_1)
+		did = DENTIST_BASE_DID_1;
+	if (did > DENTIST_MAX_DID)
+		did = DENTIST_MAX_DID;
+
+	if (did < DENTIST_BASE_DID_2) {
+		return DENTIST_DIVIDER_RANGE_1_START + DENTIST_DIVIDER_RANGE_1_STEP
+							* (did - DENTIST_BASE_DID_1);
+	} else if (did < DENTIST_BASE_DID_3) {
+		return DENTIST_DIVIDER_RANGE_2_START + DENTIST_DIVIDER_RANGE_2_STEP
+							* (did - DENTIST_BASE_DID_2);
+	} else if (did < DENTIST_BASE_DID_4) {
+		return DENTIST_DIVIDER_RANGE_3_START + DENTIST_DIVIDER_RANGE_3_STEP
+							* (did - DENTIST_BASE_DID_3);
+	} else {
+		return DENTIST_DIVIDER_RANGE_4_START + DENTIST_DIVIDER_RANGE_4_STEP
+							* (did - DENTIST_BASE_DID_4);
+	}
+}
+
+/* SW will adjust DP REF Clock average value for all purposes
+ * (DP DTO / DP Audio DTO and DP GTC)
+ if clock is spread for all cases:
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with SW
+ calculations for DS_INCR/DS_MODULO (this is planned to be default case)
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with HW
+ calculations (not planned to be used, but average clock should still
+ be valid)
+ -if SS enabled on DP Ref clock and HW de-spreading disabled
+ (should not be case with CIK) then SW should program all rates
+ generated according to average value (case as with previous ASICs)
+  */
+
+int dcn_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
+{
+	if (clk_mgr_dce->ss_on_dprefclk && clk_mgr_dce->dprefclk_ss_divider != 0) {
+		struct fixed31_32 ss_percentage = dc_fixpt_div_int(
+				dc_fixpt_from_fraction(clk_mgr_dce->dprefclk_ss_percentage,
+							clk_mgr_dce->dprefclk_ss_divider), 200);
+		struct fixed31_32 adj_dp_ref_clk_khz;
+
+		ss_percentage = dc_fixpt_sub(dc_fixpt_one, ss_percentage);
+		adj_dp_ref_clk_khz = dc_fixpt_mul_int(ss_percentage, dp_ref_clk_khz);
+		dp_ref_clk_khz = dc_fixpt_floor(adj_dp_ref_clk_khz);
+	}
+	return dp_ref_clk_khz;
+}
+
+int dcn_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dcn_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
+}
+
+void dcn_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
+{
+	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
+	int ss_info_num = bp->funcs->get_ss_entry_number(
+			bp, AS_SIGNAL_TYPE_GPU_PLL);
+
+	if (ss_info_num) {
+		struct spread_spectrum_info info = { { 0 } };
+		enum bp_result result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for GPU PLL SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* TODO: Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+
+			return;
+		}
+
+		result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_DISPLAY_PORT, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for DPREFCLK SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+			if (clk_mgr_dce->base.ctx->dc->config.ignore_dpref_ss)
+				clk_mgr_dce->dprefclk_ss_percentage = 0;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
new file mode 100644
index 000000000000..24c7a78522c5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2012-16 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef DAL_DC_DCN10_CLK_MGR_H_
+#define DAL_DC_DCN10_CLK_MGR_H_
+
+#include "dc.h"
+
+/* functions shared with higher DCN clk mgrs */
+int dcn10_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
+int dcn10_set_dprefclk(struct clk_mgr_internal *clk_mgr);
+
+int dcn_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
+
+void dcn_clock_read_ss_info(struct clk_mgr_internal *dccg_dce);
+
+int dcn_get_dp_ref_freq_khz(struct clk_mgr *dccg);
+
+unsigned int dcn_dentist_get_divider_from_did(unsigned int did);
+
+#endif /* DAL_DC_DCN10_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 06a51f47aed7..e36ef034a534 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -26,8 +26,7 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "rv1_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
-#include "dce112/dce112_clk_mgr.h"
+#include "dcn10_clk_mgr.h"
 #include "rv1_clk_mgr_vbios_smu.h"
 #include "rv1_clk_mgr_clk.h"
 
@@ -303,14 +302,14 @@ static void rv1_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 
 static struct clk_mgr_funcs rv1_clk_funcs = {
 	.init_clocks = rv1_init_clocks,
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = rv1_update_clocks,
 	.enable_pme_wa = rv1_enable_pme_wa,
 };
 
 static struct clk_mgr_internal_funcs rv1_clk_internal_funcs = {
 	.set_dispclk = rv1_vbios_smu_set_dispclk,
-	.set_dprefclk = dce112_set_dprefclk
+	.set_dprefclk = dcn10_set_dprefclk
 };
 
 void rv1_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_mgr, struct pp_smu_funcs *pp_smu)
@@ -342,7 +341,7 @@ void rv1_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
 			clk_mgr->dfs_bypass_enabled = true;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn_clock_read_ss_info(clk_mgr);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
index b9ba6dbc2b46..5c33b520e70d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
@@ -27,11 +27,11 @@
 #include "clk_mgr_internal.h"
 #include "rv1_clk_mgr.h"
 #include "rv2_clk_mgr.h"
-#include "dce112/dce112_clk_mgr.h"
+#include "dcn10_clk_mgr.h"
 
 static struct clk_mgr_internal_funcs rv2_clk_internal_funcs = {
-	.set_dispclk = dce112_set_dispclk,
-	.set_dprefclk = dce112_set_dprefclk
+	.set_dispclk = dcn10_set_dispclk,
+	.set_dprefclk = dcn10_set_dprefclk
 };
 
 void rv2_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_mgr, struct pp_smu_funcs *pp_smu)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index cbd989b6a3df..2dc9417969ed 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -26,7 +26,7 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
@@ -436,8 +436,8 @@ void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, &dppclk_wdivider);
 
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
-	dpp_divider = dentist_get_divider_from_did(dppclk_wdivider);
+	disp_divider = dcn_dentist_get_divider_from_did(dispclk_wdivider);
+	dpp_divider = dcn_dentist_get_divider_from_did(dppclk_wdivider);
 
 	if (disp_divider && dpp_divider) {
 		/* Calculate the current DFS clock, in kHz.*/
@@ -518,7 +518,7 @@ static void dcn2_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc
 }
 
 static struct clk_mgr_funcs dcn2_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks,
 	.init_clocks = dcn2_init_clocks,
 	.enable_pme_wa = dcn2_enable_pme_wa,
@@ -558,7 +558,7 @@ void dcn20_clk_mgr_construct(
 	/* DFS Slice 2 should be used for DPREFCLK */
 	dprefclk_did = REG_READ(CLK3_CLK2_DFS_CNTL);
 	/* Convert DPREFCLK DFS Slice DID to actual divider */
-	target_div = dentist_get_divider_from_did(dprefclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dprefclk_did);
 	/* get FbMult value */
 	pll_req_reg = REG_READ(CLK3_CLK_PLL_REQ);
 
@@ -588,5 +588,5 @@ void dcn20_clk_mgr_construct(
 	//Also there is no plan for now that DFS BYPASS will be used on NV10/12/14.
 	clk_mgr->dfs_bypass_enabled = false;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 76c612ecfe3c..192e1bf905e3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -29,7 +29,7 @@
 #include "clk_mgr_internal.h"
 #include "dcn201_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dm_helpers.h"
 #include "dm_services.h"
 
@@ -170,7 +170,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 }
 
 static struct clk_mgr_funcs dcn201_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = dcn201_update_clocks,
 	.init_clocks = dcn201_init_clocks,
 	.get_clock = dcn2_get_clock,
@@ -213,5 +213,5 @@ void dcn201_clk_mgr_construct(struct dc_context *ctx,
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
 			clk_mgr->dfs_bypass_enabled = true;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index b5378344d2bc..6c24cf204ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -29,7 +29,7 @@
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dml/dcn20/dcn20_fpu.h"
 
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "rn_clk_mgr_vbios_smu.h"
 #include "reg_helper.h"
 #include "core_types.h"
@@ -565,7 +565,7 @@ static void rn_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_l
 }
 
 static struct clk_mgr_funcs dcn21_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = rn_update_clocks,
 	.init_clocks = rn_init_clocks,
 	.enable_pme_wa = rn_enable_pme_wa,
@@ -770,7 +770,7 @@ void rn_clk_mgr_construct(
 	rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
 
 	clk_mgr->base.dprefclk_khz = 600000;
-	dce_clock_read_ss_info(clk_mgr);
+	dcn_clock_read_ss_info(clk_mgr);
 
 
 	clk_mgr->base.bw_params = &rn_bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 958b8d1dad2f..1e8056657257 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -27,7 +27,7 @@
 #include "clk_mgr_internal.h"
 #include "dcn30_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn30/dcn30_clk_mgr.h"
 #include "dml/dcn30/dcn30_fpu.h"
 #include "dcn30/dcn30m_clk_mgr.h"
@@ -493,7 +493,7 @@ static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct d
 }
 
 static struct clk_mgr_funcs dcn3_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 		.update_clocks = dcn3_update_clocks,
 		.init_clocks = dcn3_init_clocks,
 		.notify_wm_ranges = dcn3_notify_wm_ranges,
@@ -517,7 +517,7 @@ static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
 }
 
 struct clk_mgr_funcs dcn3_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks_fpga,
 	.init_clocks = dcn3_init_clocks_fpga,
 };
@@ -567,7 +567,7 @@ void dcn3_clk_mgr_construct(
 
 	clk_mgr->smu_present = false;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
 	if (!clk_mgr->base.bw_params) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index e40bbc495fc4..24e084448121 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -26,8 +26,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -482,7 +482,7 @@ static bool vg_are_clock_states_equal(struct dc_clocks *a,
 
 
 static struct clk_mgr_funcs vg_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = vg_update_clocks,
 	.init_clocks = vg_init_clocks,
 	.enable_pme_wa = vg_enable_pme_wa,
@@ -748,7 +748,7 @@ void vg_clk_mgr_construct(
 	vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 
 	clk_mgr->base.base.bw_params = &vg_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index ff47af3854b6..2c90b5e68dc1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -666,7 +666,7 @@ int dcn31_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 }
 
 static struct clk_mgr_funcs dcn31_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn31_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -744,9 +744,9 @@ void dcn31_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
-	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
+	//clk_mgr->base.dccg->ref_dtbclk_khz = dcn_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn31_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 24f6304011ae..c00f33385ff4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -31,8 +31,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -200,7 +200,7 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn314_is_spll_ssc_enabled(clk_mgr))
 		clk_mgr->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+			dcn_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 }
@@ -766,7 +766,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 }
 
 static struct clk_mgr_funcs dcn314_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn314_update_clocks,
 	.init_clocks = dcn314_init_clocks,
@@ -861,7 +861,7 @@ void dcn314_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 75d39cb26dba..aa52fed048de 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
@@ -600,7 +600,7 @@ static void dcn315_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 }
 
 static struct clk_mgr_funcs dcn315_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -675,8 +675,8 @@ void dcn315_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
-	dce_clock_read_ss_info(&clk_mgr->base);
-	clk_mgr->base.base.clks.ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
+	dcn_clock_read_ss_info(&clk_mgr->base);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index c7fecbdfda2c..d9f76aa2a8c8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
@@ -576,7 +576,7 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 
 static struct clk_mgr_funcs dcn316_funcs = {
 	.enable_pme_wa = dcn316_enable_pme_wa,
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn316_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -659,9 +659,9 @@ void dcn316_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	/*clk_mgr->base.dccg->ref_dtbclk_khz =
-	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
+	dcn_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
 
 	clk_mgr->base.base.bw_params = &dcn316_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index be0e3836a6c1..66c26b0f1fd3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -27,7 +27,7 @@
 #include "clk_mgr_internal.h"
 #include "dcn32/dcn32_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 #include "dcn32/dcn32_clk_mgr.h"
 #include "reg_helper.h"
@@ -409,7 +409,7 @@ static void dcn32_update_clocks_update_dentist(
 		}
 	} else if (new_dispclk_wdivider == 127 && old_dispclk_wdivider != 127) {
 		/* request clock with 126 divider first */
-		uint32_t temp_disp_divider = dentist_get_divider_from_did(126);
+		uint32_t temp_disp_divider = dcn_dentist_get_divider_from_did(126);
 		uint32_t temp_dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / temp_disp_divider;
 
 		if (clk_mgr->smu_present)
@@ -490,7 +490,7 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -922,31 +922,31 @@ static void dcn32_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 	}
 
 	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dispclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dispclk_did);
 	//Get dispclk in khz
 	regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dppclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dppclk_did);
 	//Get dppclk in khz
 	regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DPREFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dprefclk_did);
 	//Get dprefclk in khz
 	regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DCFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dcfclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dcfclk_did);
 	//Get dcfclk in khz
 	regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DTBCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dtbclk_did);
+	target_div = dcn_dentist_get_divider_from_did(dtbclk_did);
 	//Get dtbclk in khz
 	regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
@@ -1139,7 +1139,7 @@ static void dcn32_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memc
 }
 
 static struct clk_mgr_funcs dcn32_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 		.update_clocks = dcn32_update_clocks,
 		.dump_clk_registers = dcn32_dump_clk_registers,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index a69824e1eb26..600746d6013c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -29,8 +29,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -758,7 +758,7 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn35_is_spll_ssc_enabled(clk_mgr))
 		clk_mgr->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+			dcn_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 
@@ -1346,7 +1346,7 @@ static unsigned int dcn35_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum c
 }
 
 static struct clk_mgr_funcs dcn35_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn35_update_clocks,
 	.init_clocks = dcn35_init_clocks,
@@ -1360,7 +1360,7 @@ static struct clk_mgr_funcs dcn35_funcs = {
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = dcn35_update_clocks_fpga,
 	.init_clocks = dcn35_init_clocks_fpga,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1499,7 +1499,7 @@ void dcn35_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn35_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 42ce5a304125..add0b9ee53db 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -6,7 +6,7 @@
 #include "clk_mgr_internal.h"
 #include "dcn401/dcn401_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 #include "dcn32/dcn32_clk_mgr.h"
 #include "dcn401/dcn401_clk_mgr.h"
@@ -358,37 +358,37 @@ static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *reg
 		fclk_did = REG_READ(CLK2_CLK2_DFS_CNTL);
 
 		/* Convert DISPCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dispclk_did);
+		target_div = dcn_dentist_get_divider_from_did(dispclk_did);
 		//Get dispclk in khz
 		regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DISPCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dppclk_did);
+		target_div = dcn_dentist_get_divider_from_did(dppclk_did);
 		//Get dppclk in khz
 		regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DPREFCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dprefclk_did);
+		target_div = dcn_dentist_get_divider_from_did(dprefclk_did);
 		//Get dprefclk in khz
 		regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DCFCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dcfclk_did);
+		target_div = dcn_dentist_get_divider_from_did(dcfclk_did);
 		//Get dcfclk in khz
 		regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DTBCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dtbclk_did);
+		target_div = dcn_dentist_get_divider_from_did(dtbclk_did);
 		//Get dtbclk in khz
 		regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DTBCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(fclk_did);
+		target_div = dcn_dentist_get_divider_from_did(fclk_did);
 		//Get fclk in khz
 		regs_and_bypass->fclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
@@ -1552,7 +1552,7 @@ static int dcn401_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -1599,7 +1599,7 @@ static void dcn401_execute_clk_mgr_block_sequence_bls(struct clk_mgr *clk_mgr_ba
 }
 
 static struct clk_mgr_funcs dcn401_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn401_get_dtb_ref_freq_khz,
 		.update_clocks = dcn401_update_clocks,
 		.dump_clk_registers = dcn401_dump_clk_registers,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index c7b9bad93a93..1cac2c9d4e60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -7,8 +7,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -624,7 +624,7 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
+			dcn_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
 	else
 		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
 
@@ -911,7 +911,7 @@ int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -1053,7 +1053,7 @@ void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 }
 
 static struct clk_mgr_funcs dcn42_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn42_update_clocks,
 	.init_clocks = dcn42_init_clocks,
@@ -1069,7 +1069,7 @@ static struct clk_mgr_funcs dcn42_funcs = {
 };
 
 struct clk_mgr_funcs dcn42_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.update_clocks = dcn42_update_clocks_fpga,
 	.init_clocks = dcn42_init_clocks_fpga,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1131,7 +1131,7 @@ void dcn42_clk_mgr_construct(
 		/* Saved clocks configured at boot for debug purposes */
 		dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 4be5abdc60ea..f2bc8b3bd9ad 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -9,8 +9,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -238,7 +238,7 @@ void dcn42b_init_clocks(struct clk_mgr *clk_mgr_base)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
+			dcn_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
 	else
 		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
 
@@ -398,7 +398,7 @@ uint32_t dcn42b_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clo
  */
 
 static struct clk_mgr_funcs dcn42b_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn42_update_clocks,
 	.init_clocks = dcn42b_init_clocks,
@@ -467,7 +467,7 @@ void dcn42b_clk_mgr_construct(
 		/* Saved clocks configured at boot for debug purposes */
 		dcn42b_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42b_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b970f152d67f..0447137159bf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -55,11 +55,13 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
 #endif
+#if !defined(TRIM_DCE)
 #include "dce80/dce80_resource.h"
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
 #include "dce120/dce120_resource.h"
+#endif
 #include "dcn10/dcn10_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
@@ -289,6 +291,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 			init_data->num_virtual_links, dc);
 		break;
 #endif
+#if !defined(TRIM_DCE)
 	case DCE_VERSION_8_0:
 		res_pool = dce80_create_resource_pool(
 				(uint8_t)init_data->num_virtual_links, dc);
@@ -320,6 +323,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 		res_pool = dce120_create_resource_pool(
 				(uint8_t)init_data->num_virtual_links, dc);
 		break;
+#endif
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	case DCN_VERSION_1_0:
@@ -5254,6 +5258,80 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 	patch_gamut_packet_checksum(&info->gamut);
 }
 
+/*
+ * In the trimmed build the dce112 resource dir (which owns these) is excluded,
+ * so provide the definitions here. The non-trimmed build uses the originals in
+ * dce112/dce112_resource.c instead.
+ */
+#if defined(TRIM_DCE)
+/*
+ * find_matching_pll - return the PLL clock source dedicated to a stream's
+ * transmitter. clock_sources[] are ordered PLL0..PLL5 across all pools, so
+ * index by transmitter position (UNIPHY_A -> 0 ... UNIPHY_F -> 5).
+ */
+static struct clock_source *find_matching_pll(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct dc_stream_state *const stream)
+{
+	(void)res_ctx;
+	switch (stream->link->link_enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		return pool->clock_sources[0];
+	case TRANSMITTER_UNIPHY_B:
+		return pool->clock_sources[1];
+	case TRANSMITTER_UNIPHY_C:
+		return pool->clock_sources[2];
+	case TRANSMITTER_UNIPHY_D:
+		return pool->clock_sources[3];
+	case TRANSMITTER_UNIPHY_E:
+		return pool->clock_sources[4];
+	case TRANSMITTER_UNIPHY_F:
+		return pool->clock_sources[5];
+	default:
+		return NULL;
+	}
+}
+
+enum dc_status resource_map_phy_clock_resources(
+		const struct dc *dc,
+		struct dc_state *context,
+		struct dc_stream_state *stream)
+{
+
+	/* acquire new resources */
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(
+			&context->res_ctx, stream);
+
+	if (!pipe_ctx)
+		return DC_ERROR_UNEXPECTED;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)
+		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
+		pipe_ctx->clock_source =
+				dc->res_pool->dp_clock_source;
+	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL)
+			pipe_ctx->clock_source =
+				dc->res_pool->dp_clock_source;
+	else {
+		if (stream && stream->link && stream->link->link_enc)
+			pipe_ctx->clock_source = find_matching_pll(
+				&context->res_ctx, dc->res_pool,
+				stream);
+	}
+
+	if (pipe_ctx->clock_source == NULL)
+		return DC_NO_CLOCK_SOURCE_RESOURCE;
+
+	resource_reference_clock_source(
+		&context->res_ctx,
+		dc->res_pool,
+		pipe_ctx->clock_source);
+
+	return DC_OK;
+}
+#endif /* TRIM_DCE */
+
 enum dc_status resource_map_clock_resources(
 		const struct dc  *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index feb6ca92802c..4298e6d34aa5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -28,7 +28,7 @@
 #include "resource.h"
 #include "custom_float.h"
 #include "dcn10/dcn10_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dce/dce_hwseq.h"
 #include "abm.h"
 #include "dmcu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index a907f7d0628b..a6c67490dc10 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -43,9 +43,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_factory_dce60.h"
 #endif
+#if !defined(TRIM_DCE)
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
+#endif
 #include "dcn10/hw_factory_dcn10.h"
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
@@ -70,6 +72,7 @@ bool dal_hw_factory_init(
 		dal_hw_factory_dce60_init(factory);
 		return true;
 #endif
+#if !defined(TRIM_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -88,6 +91,7 @@ bool dal_hw_factory_init(
 	case DCE_VERSION_12_1:
 		dal_hw_factory_dce120_init(factory);
 		return true;
+#endif
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_factory_dcn10_init(factory);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index b58af86dee10..debf58e3a3d2 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -43,9 +43,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_translate_dce60.h"
 #endif
+#if !defined(TRIM_DCE)
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
+#endif
 #include "dcn10/hw_translate_dcn10.h"
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
@@ -74,6 +76,7 @@ bool dal_hw_translate_init(
 		dal_hw_translate_dce60_init(translate);
 		return true;
 #endif
+#if !defined(TRIM_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -89,6 +92,7 @@ bool dal_hw_translate_init(
 	case DCE_VERSION_12_1:
 		dal_hw_translate_dce120_init(translate);
 		return true;
+#endif
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_translate_dcn10_init(translate);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 9c032e449481..390fd7b92234 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -87,6 +87,9 @@ void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
 
+void dce110_edp_wait_for_T12(
+		struct dc_link *link);
+
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct set_backlight_level_params *params);
 void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 3be0bde5aea1..234f786d49c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -58,6 +58,23 @@
 #include "dce/dmub_outbox.h"
 #include "link_service.h"
 #include "dc_state_priv.h"
+/* Headers required by the sequencer functions folded in from dce110_hwseq.c */
+#include "dc.h"
+#include "dc_bios_types.h"
+#include "core_status.h"
+#include "dm_helpers.h"
+#include "gpio_service_interface.h"
+#include "bios/bios_parser_helper.h"
+#include "mem_input.h"
+#include "transform.h"
+#include "stream_encoder.h"
+#include "link_encoder.h"
+#include "link_enc_cfg.h"
+#include "clock_source.h"
+#include "audio.h"
+#include "panel_cntl.h"
+#include "dc_dp_types.h"
+#include "atomfirmware.h"
 
 #define DC_LOGGER \
 	dc_ctx->logger
@@ -82,6 +99,48 @@
 #define PGFSM_POWER_ON 0
 #define PGFSM_POWER_OFF 2
 
+/* Timeouts/delays moved from dce110_hwseq.c with the folded functions */
+#define PANEL_POWER_UP_TIMEOUT 300
+#define PANEL_POWER_DOWN_TIMEOUT 500
+#define HPD_CHECK_INTERVAL 10
+#define OLED_POST_T7_DELAY 100
+#define OLED_PRE_T11_DELAY 150
+
+/* Forward declarations for file-local helpers moved from dce110_hwseq.c */
+static void enable_display_pipe_clock_gating(
+	struct dc_context *ctx,
+	bool clock_gating);
+static enum bp_result link_transmitter_control(
+		struct dc_bios *bios,
+	struct bp_transmitter_control *cntl);
+static void power_down_encoders(struct dc *dc);
+static void power_down_controllers(struct dc *dc);
+static void power_down_clock_sources(struct dc *dc);
+static void power_down_all_hw_blocks(struct dc *dc);
+static void disable_vga_and_power_gate_all_controllers(
+		struct dc *dc);
+static void get_edp_streams(struct dc_state *context,
+		struct dc_stream_state **edp_streams,
+		int *edp_stream_num);
+static void get_edp_links_with_sink(
+		struct dc *dc,
+		struct dc_link **edp_links_with_sink,
+		int *edp_with_sink_num);
+static void clean_up_dsc_blocks(struct dc *dc);
+static void dc_hwss_enable_otg_pwa(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+static bool should_enable_fbc(struct dc *dc,
+		struct dc_state *context,
+		uint32_t *pipe_idx);
+static void
+dcn10_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing);
+static void dcn10_setup_audio_dto(
+		struct dc *dc,
+		struct dc_state *context);
+
 static void print_microsec(struct dc_context *dc_ctx,
 			   struct dc_log_buffer_ctx *log_ctx,
 			   uint32_t ref_cycle)
@@ -4211,3 +4270,1902 @@ void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
 							&plane_state->address,
 							true);
 }
+
+/*======================================================================================
+ * The following functions were folded into dcn10_hwseq.c and renamed to dcn10_;
+ * four generic helpers were given a dcn10_ prefix to avoid link collisions with
+ * dce110_hwseq.c on Linux builds.
+ *====================================================================================*/
+static void enable_display_pipe_clock_gating(
+	struct dc_context *ctx,
+	bool clock_gating)
+{
+	(void)ctx;
+	(void)clock_gating;
+	/*TODO*/
+}
+
+void dcn10_update_info_frame(struct pipe_ctx *pipe_ctx)
+{
+	bool is_hdmi_tmds;
+	bool is_dp;
+
+	ASSERT(pipe_ctx->stream);
+
+	if (pipe_ctx->stream_res.stream_enc == NULL)
+		return;  /* this is not root pipe */
+
+	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
+	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
+
+	if (!is_hdmi_tmds && !is_dp)
+		return;
+
+	if (is_hdmi_tmds)
+		pipe_ctx->stream_res.stream_enc->funcs->update_hdmi_info_packets(
+			pipe_ctx->stream_res.stream_enc,
+			&pipe_ctx->stream_res.encoder_info_frame);
+	else {
+		if (pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num)
+			pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num(
+				pipe_ctx->stream_res.stream_enc,
+				&pipe_ctx->stream_res.encoder_info_frame);
+
+		pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets(
+			pipe_ctx->stream_res.stream_enc,
+			&pipe_ctx->stream_res.encoder_info_frame);
+	}
+}
+
+static void
+dcn10_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	const struct dc_link_settings *link_settings = &link->cur_link_settings;
+	enum bp_result bp_result = BP_RESULT_OK;
+	struct bp_external_encoder_control ext_cntl = {
+		.action = action,
+		.connector_obj_id = link->link_enc->connector,
+		.encoder_id = link->ext_enc_id,
+		.lanes_number = link_settings->lane_count,
+		.link_rate = link_settings->link_rate,
+
+		/* Use signal type of the real link encoder, ie. DP */
+		.signal = link->connector_signal,
+
+		/* We don't know the timing yet when executing the SETUP action,
+		 * so use a reasonably high default value. It seems that ENABLE
+		 * can change the actual pixel clock but doesn't work with higher
+		 * pixel clocks than what SETUP was called with.
+		 */
+		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
+		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
+	};
+	DC_LOGGER_INIT(dc->ctx);
+
+	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
+
+	if (bp_result != BP_RESULT_OK)
+		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
+}
+
+void dcn10_enable_stream(struct pipe_ctx *pipe_ctx)
+{
+	enum dc_lane_count lane_count =
+		pipe_ctx->stream->link->cur_link_settings.lane_count;
+	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	struct dc_link *link = pipe_ctx->stream->link;
+	const struct dc *dc = link->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	uint32_t active_total_with_borders;
+	uint32_t early_control = 0;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+
+	link_hwss->setup_stream_encoder(pipe_ctx);
+
+	dc->hwss.update_info_frame(pipe_ctx);
+
+	/* enable early control to avoid corruption on DP monitor*/
+	active_total_with_borders =
+			timing->h_addressable
+				+ timing->h_border_left
+				+ timing->h_border_right;
+
+	if (lane_count != 0)
+		early_control = active_total_with_borders % lane_count;
+
+	if (early_control == 0)
+		early_control = lane_count;
+
+	tg->funcs->set_early_control(tg, early_control);
+
+	if (link->ext_enc_id.id)
+		dcn10_external_encoder_control(EXTERNAL_ENCODER_CONTROL_ENABLE, link, timing);
+}
+
+static enum bp_result link_transmitter_control(
+		struct dc_bios *bios,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result;
+
+	result = bios->funcs->transmitter_control(bios, cntl);
+
+	return result;
+}
+
+void dcn10_edp_wait_for_hpd_ready(
+		struct dc_link *link,
+		bool power_up)
+{
+	struct graphics_object_id connector = link->link_enc->connector;
+	bool edp_hpd_high = false;
+	uint32_t time_elapsed = 0;
+	uint32_t timeout = power_up ?
+		PANEL_POWER_UP_TIMEOUT : PANEL_POWER_DOWN_TIMEOUT;
+
+	DC_LOGGER_INIT(link->ctx);
+
+	if (dal_graphics_object_id_get_connector_id(connector)
+			!= CONNECTOR_ID_EDP) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (!power_up)
+		/*
+		 * From KV, we will not HPD low after turning off VCC -
+		 * instead, we will check the SW timer in power_up().
+		 */
+		return;
+
+	/*
+	 * When we power on/off the eDP panel,
+	 * we need to wait until SENSE bit is high/low.
+	 */
+
+	if (link->panel_config.pps.extra_t3_ms > 0) {
+		int extra_t3_in_ms = link->panel_config.pps.extra_t3_ms;
+
+		msleep(extra_t3_in_ms);
+	}
+
+	/* wait until timeout or panel detected */
+
+	do {
+		if (!(link->dc->link_srv->get_hpd_state(link) ^ power_up)) {
+			edp_hpd_high = true;
+			break;
+		}
+
+		msleep(HPD_CHECK_INTERVAL);
+
+		time_elapsed += HPD_CHECK_INTERVAL;
+	} while (time_elapsed < timeout);
+
+	/* ensure that the panel is detected */
+	if (!edp_hpd_high)
+		DC_LOG_DC("%s: wait timed out!\n", __func__);
+}
+
+void dcn10_edp_power_control(
+		struct dc_link *link,
+		bool power_up)
+{
+	struct dc_context *ctx = link->ctx;
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result bp_result;
+	uint8_t pwrseq_instance;
+
+	DC_LOGGER_INIT(ctx);
+
+	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
+			!= CONNECTOR_ID_EDP) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (!link->panel_cntl)
+		return;
+	if (power_up !=
+		link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl)) {
+
+		unsigned long long current_ts = dm_get_timestamp(ctx);
+		unsigned long long time_since_edp_poweroff_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link)), 1000000);
+		unsigned long long time_since_edp_poweron_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						ctx->dc->link_srv->dp_trace_get_edp_poweron_timestamp(link)), 1000000);
+		DC_LOG_HW_RESUME_S3(
+				"%s: transition: power_up=%d current_ts=%llu edp_poweroff=%llu edp_poweron=%llu time_since_edp_poweroff_ms=%llu time_since_edp_poweron_ms=%llu",
+				__func__,
+				power_up,
+				current_ts,
+				ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link),
+				ctx->dc->link_srv->dp_trace_get_edp_poweron_timestamp(link),
+				time_since_edp_poweroff_ms,
+				time_since_edp_poweron_ms);
+
+		/* Send VBIOS command to prompt eDP panel power */
+		if (power_up) {
+			/* edp requires a min of 500ms from LCDVDD off to on */
+			unsigned long long remaining_min_edp_poweroff_time_ms = 500;
+
+			/* add time defined by a patch, if any (usually patch extra_t12_ms is 0) */
+			if (link->local_sink != NULL)
+				remaining_min_edp_poweroff_time_ms +=
+					link->panel_config.pps.extra_t12_ms;
+
+			/* Adjust remaining_min_edp_poweroff_time_ms if this is not the first time. */
+			if (ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link) != 0) {
+				if (time_since_edp_poweroff_ms < remaining_min_edp_poweroff_time_ms)
+					remaining_min_edp_poweroff_time_ms =
+						remaining_min_edp_poweroff_time_ms - time_since_edp_poweroff_ms;
+				else
+					remaining_min_edp_poweroff_time_ms = 0;
+			}
+
+			if (remaining_min_edp_poweroff_time_ms) {
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: begin wait.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+				msleep((unsigned int)remaining_min_edp_poweroff_time_ms);
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: end wait.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+				dm_output_to_console("%s: wait %lld ms to power on eDP.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+			} else {
+				DC_LOG_HW_RESUME_S3(
+						"%s: remaining_min_edp_poweroff_time_ms=%llu: no wait required.\n",
+						__func__, remaining_min_edp_poweroff_time_ms);
+			}
+		}
+
+		DC_LOG_HW_RESUME_S3(
+				"%s: BEGIN: Panel Power action: %s\n",
+				__func__, (power_up ? "On":"Off"));
+
+		cntl.action = power_up ?
+			TRANSMITTER_CONTROL_POWER_ON :
+			TRANSMITTER_CONTROL_POWER_OFF;
+		cntl.transmitter = link->link_enc->transmitter;
+		cntl.connector_obj_id = link->link_enc->connector;
+		cntl.coherent = false;
+		cntl.lanes_number = LANE_COUNT_FOUR;
+		cntl.hpd_sel = link->link_enc->hpd_source;
+		pwrseq_instance = (uint8_t)link->panel_cntl->pwrseq_inst;
+
+		if (ctx->dc->ctx->dmub_srv &&
+				ctx->dc->debug.dmub_command_table) {
+
+			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
+				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_POWER_ON,
+						pwrseq_instance, link->link_powered_externally);
+			} else {
+				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+						LVTMA_CONTROL_POWER_OFF,
+						pwrseq_instance, link->link_powered_externally);
+			}
+		}
+
+		bp_result = link_transmitter_control(ctx->dc_bios, &cntl);
+
+		DC_LOG_HW_RESUME_S3(
+				"%s: END: Panel Power action: %s bp_result=%u\n",
+				__func__, (power_up ? "On":"Off"),
+				bp_result);
+
+		ctx->dc->link_srv->dp_trace_set_edp_power_timestamp(link, power_up);
+
+		DC_LOG_HW_RESUME_S3(
+				"%s: updated values: edp_poweroff=%llu edp_poweron=%llu\n",
+				__func__,
+				ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link),
+				ctx->dc->link_srv->dp_trace_get_edp_poweron_timestamp(link));
+
+		if (bp_result != BP_RESULT_OK)
+			DC_LOG_ERROR(
+					"%s: Panel Power bp_result: %d\n",
+					__func__, bp_result);
+	} else {
+		DC_LOG_HW_RESUME_S3(
+				"%s: Skipping Panel Power action: %s\n",
+				__func__, (power_up ? "On":"Off"));
+	}
+}
+
+void dcn10_edp_wait_for_T12(
+		struct dc_link *link)
+{
+	struct dc_context *ctx = link->ctx;
+
+	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
+			!= CONNECTOR_ID_EDP) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (!link->panel_cntl)
+		return;
+
+	if (!link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl) &&
+			ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link) != 0) {
+		unsigned int t12_duration = 500; // Default T12 as per spec
+		unsigned long long current_ts = dm_get_timestamp(ctx);
+		unsigned long long time_since_edp_poweroff_ms =
+				div64_u64(dm_get_elapse_time_in_ns(
+						ctx,
+						current_ts,
+						ctx->dc->link_srv->dp_trace_get_edp_poweroff_timestamp(link)), 1000000);
+
+		t12_duration += link->panel_config.pps.extra_t12_ms; // Add extra T12
+
+		if (time_since_edp_poweroff_ms < t12_duration)
+			msleep((unsigned int)(t12_duration - time_since_edp_poweroff_ms));
+	}
+}
+
+void dcn10_edp_backlight_control(
+		struct dc_link *link,
+		bool enable)
+{
+	struct dc_context *ctx = link->ctx;
+	struct bp_transmitter_control cntl = { 0 };
+	uint8_t pwrseq_instance = 0;
+	unsigned int pre_T11_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_PRE_T11_DELAY : 0);
+	unsigned int post_T7_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_POST_T7_DELAY : 0);
+
+	DC_LOGGER_INIT(ctx);
+
+	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
+		!= CONNECTOR_ID_EDP) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (link->panel_cntl && !(link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
+		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
+
+		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
+			DC_LOG_HW_RESUME_S3(
+				"%s: panel already powered up/off. Do nothing.\n",
+				__func__);
+			return;
+		}
+	}
+
+	/* Send VBIOS command to control eDP panel backlight */
+
+	DC_LOG_HW_RESUME_S3(
+			"%s: backlight action: %s\n",
+			__func__, (enable ? "On":"Off"));
+
+	cntl.action = enable ?
+		TRANSMITTER_CONTROL_BACKLIGHT_ON :
+		TRANSMITTER_CONTROL_BACKLIGHT_OFF;
+
+	/*cntl.engine_id = ctx->engine;*/
+	cntl.transmitter = link->link_enc->transmitter;
+	cntl.connector_obj_id = link->link_enc->connector;
+	/*todo: unhardcode*/
+	cntl.lanes_number = LANE_COUNT_FOUR;
+	cntl.hpd_sel = link->link_enc->hpd_source;
+	cntl.signal = SIGNAL_TYPE_EDP;
+
+	/* For eDP, the following delays might need to be considered
+	 * after link training completed:
+	 * idle period - min. accounts for required BS-Idle pattern,
+	 * max. allows for source frame synchronization);
+	 * 50 msec max. delay from valid video data from source
+	 * to video on dislpay or backlight enable.
+	 *
+	 * Disable the delay for now.
+	 * Enable it in the future if necessary.
+	 */
+	/* dc_service_sleep_in_milliseconds(50); */
+		/*edp 1.2*/
+	if (link->panel_cntl) {
+		pwrseq_instance = (uint8_t)link->panel_cntl->pwrseq_inst;
+	}
+
+	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
+		if (!link->dc->config.edp_no_power_sequencing)
+		/*
+		 * Sometimes, DP receiver chip power-controlled externally by an
+		 * Embedded Controller could be treated and used as eDP,
+		 * if it drives mobile display. In this case,
+		 * we shouldn't be doing power-sequencing, hence we can skip
+		 * waiting for T7-ready.
+		 */
+			ctx->dc->link_srv->edp_receiver_ready_T7(link);
+		else
+			DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
+	}
+
+	/* Setting link_powered_externally will bypass delays in the backlight
+	 * as they are not required if the link is being powered by a different
+	 * source.
+	 */
+	if (ctx->dc->ctx->dmub_srv &&
+			ctx->dc->debug.dmub_command_table) {
+		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
+			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+					LVTMA_CONTROL_LCD_BLON,
+					pwrseq_instance, link->link_powered_externally);
+		else
+			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
+					LVTMA_CONTROL_LCD_BLOFF,
+					pwrseq_instance, link->link_powered_externally);
+	}
+
+	link_transmitter_control(ctx->dc_bios, &cntl);
+
+	if (enable && link->dpcd_sink_ext_caps.bits.oled &&
+	    !link->dc->config.edp_no_power_sequencing &&
+	    !link->local_sink->edid_caps.panel_patch.oled_optimize_display_on) {
+		post_T7_delay += link->panel_config.pps.extra_post_t7_ms;
+		msleep(post_T7_delay);
+	}
+
+	if (link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
+		ctx->dc->link_srv->edp_backlight_enable_aux(link, enable);
+
+	/*edp 1.2*/
+	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF) {
+		if (!link->dc->config.edp_no_power_sequencing)
+		/*
+		 * Sometimes, DP receiver chip power-controlled externally by an
+		 * Embedded Controller could be treated and used as eDP,
+		 * if it drives mobile display. In this case,
+		 * we shouldn't be doing power-sequencing, hence we can skip
+		 * waiting for T9-ready.
+		 */
+			ctx->dc->link_srv->edp_add_delay_for_T9(link);
+		else
+			DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
+	}
+
+	if (!enable) {
+		/*follow oem panel config's requirement*/
+		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
+		if (pre_T11_delay)
+			msleep(pre_T11_delay);
+	}
+}
+
+void dcn10_enable_audio_stream(struct pipe_ctx *pipe_ctx)
+{
+	/* notify audio driver for audio modes of monitor */
+	struct dc *dc;
+	struct clk_mgr *clk_mgr;
+	unsigned int i, num_audio = 1;
+	const struct link_hwss *link_hwss;
+
+	if (!pipe_ctx->stream)
+		return;
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		return;
+
+	dc = pipe_ctx->stream->ctx->dc;
+	clk_mgr = dc->clk_mgr;
+	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
+
+	if (pipe_ctx->stream_res.audio && pipe_ctx->stream_res.audio->enabled == true)
+		return;
+
+	if (pipe_ctx->stream_res.audio) {
+		for (i = 0; i < MAX_PIPES; i++) {
+			/*current_state not updated yet*/
+			if (dc->current_state->res_ctx.pipe_ctx[i].stream_res.audio != NULL)
+				num_audio++;
+		}
+		if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa) {
+			/*wake AZ from D3 first before access az endpoint*/
+			clk_mgr->funcs->enable_pme_wa(clk_mgr);
+		}
+
+		pipe_ctx->stream_res.audio->funcs->az_enable(pipe_ctx->stream_res.audio);
+
+		link_hwss->enable_audio_packet(pipe_ctx);
+
+		if (pipe_ctx->stream_res.audio)
+			pipe_ctx->stream_res.audio->enabled = true;
+	}
+}
+
+void dcn10_disable_audio_stream(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc;
+	struct clk_mgr *clk_mgr;
+	const struct link_hwss *link_hwss;
+
+	if (!pipe_ctx || !pipe_ctx->stream)
+		return;
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		return;
+
+	dc = pipe_ctx->stream->ctx->dc;
+	clk_mgr = dc->clk_mgr;
+	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
+
+	if (pipe_ctx->stream_res.audio && pipe_ctx->stream_res.audio->enabled == false)
+		return;
+
+	link_hwss->disable_audio_packet(pipe_ctx);
+
+	if (pipe_ctx->stream_res.audio) {
+		pipe_ctx->stream_res.audio->enabled = false;
+
+		if (clk_mgr->funcs->enable_pme_wa)
+			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
+			clk_mgr->funcs->enable_pme_wa(clk_mgr);
+
+		/* TODO: notify audio driver for if audio modes list changed
+		 * add audio mode list change flag */
+		/* dal_audio_disable_azalia_audio_jack_presence(stream->audio,
+		 * stream->stream_engine_id);
+		 */
+	}
+}
+
+void dcn10_disable_stream(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct dtbclk_dto_params dto_params = {0};
+	int dp_hpo_inst;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
+		pipe_ctx->stream_res.stream_enc->funcs->stop_hdmi_info_packets(
+			pipe_ctx->stream_res.stream_enc);
+		pipe_ctx->stream_res.stream_enc->funcs->hdmi_reset_stream_attribute(
+			pipe_ctx->stream_res.stream_enc);
+	}
+
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->stop_hdmi_info_packets(
+			pipe_ctx->stream_res.hpo_frl_stream_enc);
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->stop_dp_info_packets(
+					pipe_ctx->stream_res.hpo_dp_stream_enc);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
+			pipe_ctx->stream_res.stream_enc);
+
+	dc->hwss.disable_audio_stream(pipe_ctx);
+
+	link_hwss->reset_stream_encoder(pipe_ctx);
+
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
+		dto_params.otg_inst = tg->inst;
+		dto_params.timing = &pipe_ctx->stream->timing;
+		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		if (dccg) {
+			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+			if (!(dc->ctx->dce_version >= DCN_VERSION_3_5)) {
+				if (dccg && dccg->funcs->set_dtbclk_dto)
+					dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			}
+		}
+	} else if (dccg && dccg->funcs->disable_symclk_se) {
+		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_FRL)
+		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
+					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+	}
+
+	if (link->ext_enc_id.id)
+		dcn10_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DISABLE, link, NULL);
+}
+
+void dcn10_blank_stream(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dce_hwseq *hws = link->dc->hwseq;
+
+	if (hws && hws->wa_state.skip_blank_stream)
+		return;
+
+	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
+		if (!link->skip_implict_edp_power_control && hws)
+			hws->funcs.edp_backlight_control(link, false);
+		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	}
+
+	if (link->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		/* TODO - DP2.0 HW: Set ODM mode in dp hpo encoder here */
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_blank(
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(link, pipe_ctx->stream_res.stream_enc);
+
+		if (!dc_is_embedded_signal(pipe_ctx->stream->signal)) {
+			/*
+			 * After output is idle pattern some sinks need time to recognize the stream
+			 * has changed or they enter protection state and hang.
+			 */
+			msleep(60);
+		}
+	}
+
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+	    !link->dc->config.edp_no_power_sequencing) {
+			/*
+			 * Sometimes, DP receiver chip power-controlled externally by an
+			 * Embedded Controller could be treated and used as eDP,
+			 * if it drives mobile display. In this case,
+			 * we shouldn't be doing power-sequencing, hence we can skip
+			 * waiting for T9-ready.
+			 */
+		link->dc->link_srv->edp_receiver_ready_T9(link);
+	}
+
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_blank(pipe_ctx->stream_res.hpo_frl_stream_enc);
+
+		/* Set HDMISTREAMCLK source to REFCLK */
+		if (link->dc->res_pool->dccg &&
+			link->dc->res_pool->dccg->funcs->set_hdmistreamclk) {
+			link->dc->res_pool->dccg->funcs->set_hdmistreamclk(
+					link->dc->res_pool->dccg,
+					REFCLK,
+					pipe_ctx->stream_res.tg->inst);
+		}
+	}
+}
+
+void dcn10_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	if (pipe_ctx != NULL && pipe_ctx->stream_res.stream_enc != NULL)
+		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(pipe_ctx->stream_res.stream_enc, enable);
+}
+
+enum audio_dto_source dcn10_translate_to_dto_source(enum controller_id crtc_id)
+{
+	switch (crtc_id) {
+	case CONTROLLER_ID_D0:
+		return DTO_SOURCE_ID0;
+	case CONTROLLER_ID_D1:
+		return DTO_SOURCE_ID1;
+	case CONTROLLER_ID_D2:
+		return DTO_SOURCE_ID2;
+	case CONTROLLER_ID_D3:
+		return DTO_SOURCE_ID3;
+	case CONTROLLER_ID_D4:
+		return DTO_SOURCE_ID4;
+	case CONTROLLER_ID_D5:
+		return DTO_SOURCE_ID5;
+	default:
+		return DTO_SOURCE_UNKNOWN;
+	}
+}
+
+void dcn10_populate_audio_dp_link_info(
+	const struct pipe_ctx *pipe_ctx,
+	struct audio_dp_link_info *dp_link_info)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	const struct dc_link *link = stream->link;
+	struct fixed31_32 link_bw_kbps;
+
+	dp_link_info->encoding = link->dc->link_srv->dp_get_encoding_format(
+				&pipe_ctx->link_config.dp_link_settings);
+	dp_link_info->is_mst = (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST);
+	dp_link_info->lane_count = pipe_ctx->link_config.dp_link_settings.lane_count;
+	dp_link_info->link_rate = pipe_ctx->link_config.dp_link_settings.link_rate;
+
+	link_bw_kbps = dc_fixpt_from_int(dc_link_bandwidth_kbps(link,
+			&pipe_ctx->link_config.dp_link_settings));
+
+	/* For audio stream calculations, the video stream should not include FEC or SSC
+	 * in order to get the most pessimistic values.
+	 */
+	if (dp_link_info->encoding == DP_8b_10b_ENCODING &&
+			link->dc->link_srv->dp_is_fec_supported(link)) {
+		link_bw_kbps = dc_fixpt_mul(link_bw_kbps,
+				dc_fixpt_from_fraction(100, DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100));
+	} else if (dp_link_info->encoding == DP_128b_132b_ENCODING) {
+		link_bw_kbps = dc_fixpt_mul(link_bw_kbps,
+				dc_fixpt_from_fraction(10000, 9975)); /* 99.75% SSC overhead*/
+	}
+
+	dp_link_info->link_bandwidth_kbps = dc_fixpt_floor(link_bw_kbps);
+
+	/* Calculates hblank_min_symbol_width for 128b/132b
+	 * Corresponding HBLANK_MIN_SYMBOL_WIDTH register is calculated as:
+	 *   floor(h_blank * bits_per_pixel / 128)
+	 */
+	if (dp_link_info->encoding == DP_128b_132b_ENCODING) {
+		struct dc_crtc_timing *crtc_timing = &pipe_ctx->stream->timing;
+
+		uint32_t h_active = crtc_timing->h_addressable + crtc_timing->h_border_left
+				+ crtc_timing->h_border_right;
+		uint32_t h_blank = crtc_timing->h_total - h_active;
+
+		uint32_t bpp;
+
+		if (crtc_timing->flags.DSC) {
+			bpp = crtc_timing->dsc_cfg.bits_per_pixel;
+		} else {
+			/* When the timing is using DSC, dsc_cfg.bits_per_pixel is in 16th bits.
+			 * The bpp in this path is scaled to 16th bits so the final calculation
+			 * is correct for both cases.
+			 */
+			bpp = 16;
+			switch (crtc_timing->display_color_depth) {
+			case COLOR_DEPTH_666:
+				bpp *= 18;
+				break;
+			case COLOR_DEPTH_888:
+				bpp *= 24;
+				break;
+			case COLOR_DEPTH_101010:
+				bpp *= 30;
+				break;
+			case COLOR_DEPTH_121212:
+				bpp *= 36;
+				break;
+			default:
+				bpp = 0;
+				break;
+			}
+
+			switch (crtc_timing->pixel_encoding) {
+			case PIXEL_ENCODING_YCBCR422:
+				bpp = bpp * 2 / 3;
+				break;
+			case PIXEL_ENCODING_YCBCR420:
+				bpp /= 2;
+				break;
+			default:
+				break;
+			}
+		}
+
+		/* Min symbol width = floor(h_blank * (bpp/16) / 128) */
+		dp_link_info->hblank_min_symbol_width = dc_fixpt_floor(
+				dc_fixpt_div(dc_fixpt_from_int(h_blank * bpp),
+						dc_fixpt_from_int(128 / 16)));
+
+	} else {
+		dp_link_info->hblank_min_symbol_width = 0;
+	}
+}
+
+void dcn10_build_audio_output(
+	struct dc_state *state,
+	const struct pipe_ctx *pipe_ctx,
+	struct audio_output *audio_output)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	audio_output->engine_id = pipe_ctx->stream_res.stream_enc->id;
+
+	audio_output->signal = pipe_ctx->stream->signal;
+
+	/* audio_crtc_info  */
+
+	audio_output->crtc_info.h_total =
+		stream->timing.h_total;
+
+	/*
+	 * Audio packets are sent during actual CRTC blank physical signal, we
+	 * need to specify actual active signal portion
+	 */
+	audio_output->crtc_info.h_active =
+			stream->timing.h_addressable
+			+ stream->timing.h_border_left
+			+ stream->timing.h_border_right;
+
+	audio_output->crtc_info.v_active =
+			stream->timing.v_addressable
+			+ stream->timing.v_border_top
+			+ stream->timing.v_border_bottom;
+
+	audio_output->crtc_info.pixel_repetition = 1;
+
+	audio_output->crtc_info.interlaced =
+			(stream->timing.flags.INTERLACE != 0);
+
+	audio_output->crtc_info.refresh_rate =
+		(uint16_t)((stream->timing.pix_clk_100hz*100)/
+		(stream->timing.h_total*stream->timing.v_total));
+
+	audio_output->crtc_info.color_depth =
+		stream->timing.display_color_depth;
+
+	audio_output->crtc_info.requested_pixel_clock_100Hz =
+			pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz;
+
+	audio_output->crtc_info.calculated_pixel_clock_100Hz =
+			pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz;
+
+	audio_output->crtc_info.pixel_encoding =
+		stream->timing.pixel_encoding;
+
+	audio_output->crtc_info.dsc_bits_per_pixel =
+			stream->timing.dsc_cfg.bits_per_pixel;
+
+	audio_output->crtc_info.dsc_num_slices =
+			stream->timing.dsc_cfg.num_slices_h;
+
+/*for HDMI, audio ACR is with deep color ratio factor*/
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) &&
+		audio_output->crtc_info.requested_pixel_clock_100Hz ==
+				(stream->timing.pix_clk_100hz)) {
+		if (pipe_ctx->stream_res.pix_clk_params.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			audio_output->crtc_info.requested_pixel_clock_100Hz =
+					audio_output->crtc_info.requested_pixel_clock_100Hz/2;
+			audio_output->crtc_info.calculated_pixel_clock_100Hz =
+					pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz/2;
+
+		}
+	}
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		switch (pipe_ctx->stream->link->frl_link_settings.frl_link_rate) {
+		case HDMI_FRL_LINK_RATE_3GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 166667;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS:
+		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+			audio_output->crtc_info.frl_character_clock_kHz = 333333;
+			break;
+		case HDMI_FRL_LINK_RATE_8GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 444444;
+			break;
+		case HDMI_FRL_LINK_RATE_10GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 555555;
+			break;
+		case HDMI_FRL_LINK_RATE_12GBPS:
+		default:
+			audio_output->crtc_info.frl_character_clock_kHz = 666667;
+			break;
+		}
+	} else
+			audio_output->crtc_info.frl_character_clock_kHz = 0;
+
+	if (state->clk_mgr &&
+		(pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+			pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL ||
+			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)) {
+		audio_output->pll_info.audio_dto_source_clock_in_khz =
+				state->clk_mgr->funcs->get_dp_ref_clk_frequency(
+						state->clk_mgr);
+	}
+
+	audio_output->pll_info.dto_source =
+		dcn10_translate_to_dto_source(
+			pipe_ctx->stream_res.tg->inst + 1);
+
+	/* TODO hard code to enable for now. Need get from stream */
+	audio_output->pll_info.ss_enabled = true;
+
+	audio_output->pll_info.ss_percentage =
+			pipe_ctx->pll_settings.ss_percentage;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		dcn10_populate_audio_dp_link_info(pipe_ctx, &audio_output->dp_link_info);
+	}
+}
+
+enum dc_status dcn10_apply_single_controller_ctx_to_hw(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct dc *dc)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct drr_params params = {0};
+	unsigned int event_triggers = 0;
+	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
+	struct dce_hwseq *hws = dc->hwseq;
+	const struct link_hwss *link_hwss = get_link_hwss(
+			link, &pipe_ctx->link_res);
+
+
+	if (hws->funcs.disable_stream_gating) {
+		hws->funcs.disable_stream_gating(dc, pipe_ctx);
+	}
+
+	if (pipe_ctx->stream_res.audio != NULL) {
+		struct audio_output audio_output = {0};
+
+		dcn10_build_audio_output(context, pipe_ctx, &audio_output);
+
+		link_hwss->setup_audio_output(pipe_ctx, &audio_output,
+				pipe_ctx->stream_res.audio->inst);
+
+		pipe_ctx->stream_res.audio->funcs->az_configure(
+				pipe_ctx->stream_res.audio,
+				pipe_ctx->stream->signal,
+				&audio_output.crtc_info,
+				&pipe_ctx->stream->audio_info,
+				&audio_output.dp_link_info);
+
+		if (dc->config.disable_hbr_audio_dp2)
+			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
+					dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio(pipe_ctx->stream_res.audio);
+	}
+
+	/* make sure no pipes syncd to the pipe being enabled */
+	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
+		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
+
+	pipe_ctx->stream_res.opp->funcs->opp_program_fmt(
+		pipe_ctx->stream_res.opp,
+		&stream->bit_depth_params,
+		&stream->clamping);
+
+	pipe_ctx->stream_res.opp->funcs->opp_set_dyn_expansion(
+			pipe_ctx->stream_res.opp,
+			COLOR_SPACE_YCBCR601,
+			stream->timing.display_color_depth,
+			stream->signal);
+
+	while (odm_pipe) {
+		odm_pipe->stream_res.opp->funcs->opp_set_dyn_expansion(
+				odm_pipe->stream_res.opp,
+				COLOR_SPACE_YCBCR601,
+				stream->timing.display_color_depth,
+				stream->signal);
+
+		odm_pipe->stream_res.opp->funcs->opp_program_fmt(
+				odm_pipe->stream_res.opp,
+				&stream->bit_depth_params,
+				&stream->clamping);
+		odm_pipe = odm_pipe->next_odm_pipe;
+	}
+
+	/* DCN3.1 FPGA Workaround
+	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
+	 * To do so, move calling function enable_stream_timing to only be done AFTER calling
+	 * function core_link_enable_stream
+	 */
+	if (!(hws->wa.dp_hpo_and_otg_sequence && dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)))
+		/*  */
+		/* Do not touch stream timing on seamless boot optimization. */
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
+
+	if (hws->funcs.setup_vupdate_interrupt)
+		hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
+
+	params.vertical_total_min = stream->adjust.v_total_min;
+	params.vertical_total_max = stream->adjust.v_total_max;
+	set_drr_and_clear_adjust_pending(pipe_ctx, stream, &params);
+
+	// DRR should set trigger event to monitor surface update event
+	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
+		event_triggers = 0x80;
+	/* Event triggers and num frames initialized for DRR, but can be
+	 * later updated for PSR use. Note DRR trigger events are generated
+	 * regardless of whether num frames met.
+	 */
+	if (pipe_ctx->stream_res.tg->funcs->set_static_screen_control)
+		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
+				pipe_ctx->stream_res.tg, event_triggers, 2);
+
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
+		!dc_is_rgb_signal(pipe_ctx->stream->signal) &&
+		!dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
+			pipe_ctx->stream_res.stream_enc,
+			pipe_ctx->stream_res.tg->inst);
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
+
+	/* Temporary workaround to perform DSC programming ahead of stream enablement
+	 * for smartmux/SPRS
+	 * TODO: Remove SmartMux/SPRS checks once movement of DSC programming is generalized
+	 */
+	if (pipe_ctx->stream->timing.flags.DSC) {
+		if ((pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+			((link->dc->config.smart_mux_version && link->dc->is_switch_in_progress_dest)
+			|| link->is_dds || link->skip_implict_edp_power_control)) &&
+			(dc_is_dp_signal(pipe_ctx->stream->signal) ||
+			dc_is_virtual_signal(pipe_ctx->stream->signal)))
+			dc->link_srv->set_dsc_enable(pipe_ctx, true);
+	}
+
+	if (!stream->dpms_off)
+		dc->link_srv->set_dpms_on(context, pipe_ctx);
+
+	/* DCN3.1 FPGA Workaround
+	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
+	 * To do so, move calling function enable_stream_timing to only be done AFTER calling
+	 * function core_link_enable_stream
+	 */
+	if (hws->wa.dp_hpo_and_otg_sequence && dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
+	}
+
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != NULL;
+
+	/* Phantom and main stream share the same link (because the stream
+	 * is constructed with the same sink). Make sure not to override
+	 * and link programming on the main.
+	 */
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
+		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
+	}
+	return DC_OK;
+}
+
+static void power_down_encoders(struct dc *dc)
+{
+	int i;
+
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+		struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+		enum signal_type signal = link->connector_signal;
+
+		dc->link_srv->blank_dp_stream(link, false);
+		if (signal != SIGNAL_TYPE_EDP)
+			signal = SIGNAL_TYPE_NONE;
+
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY && link_enc)
+			link_enc->funcs->disable_output(link_enc, signal);
+
+		if (link->fec_state == dc_link_fec_enabled) {
+			if (link_enc && link_enc->funcs->fec_set_enable && link_enc->funcs->fec_set_ready) {
+				link_enc->funcs->fec_set_enable(link_enc, false);
+				link_enc->funcs->fec_set_ready(link_enc, false);
+				link->fec_state = dc_link_fec_not_ready;
+			}
+		}
+
+		link->link_status.link_active = false;
+		memset(&link->cur_link_settings, 0, sizeof(link->cur_link_settings));
+	}
+}
+
+static void power_down_controllers(struct dc *dc)
+{
+	unsigned int i;
+
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		dc->res_pool->timing_generators[i]->funcs->disable_crtc(
+				dc->res_pool->timing_generators[i]);
+	}
+}
+
+static void power_down_clock_sources(struct dc *dc)
+{
+	unsigned int i;
+
+	if (dc->res_pool->dp_clock_source->funcs->cs_power_down(
+		dc->res_pool->dp_clock_source) == false)
+		dm_error("Failed to power down pll! (dp clk src)\n");
+
+	for (i = 0; i < dc->res_pool->clk_src_count; i++) {
+		if (dc->res_pool->clock_sources[i]->funcs->cs_power_down(
+				dc->res_pool->clock_sources[i]) == false)
+			dm_error("Failed to power down pll! (clk src index=%u)\n", i);
+	}
+}
+
+static void power_down_all_hw_blocks(struct dc *dc)
+{
+	power_down_encoders(dc);
+
+	power_down_controllers(dc);
+
+	power_down_clock_sources(dc);
+
+	if (dc->fbc_compressor)
+		dc->fbc_compressor->funcs->disable_fbc(dc->fbc_compressor);
+}
+
+static void disable_vga_and_power_gate_all_controllers(
+		struct dc *dc)
+{
+	uint8_t i;
+	struct timing_generator *tg;
+	struct dc_context *ctx = dc->ctx;
+
+	if (dc->caps.ips_support)
+		return;
+
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		tg = dc->res_pool->timing_generators[i];
+
+		if (tg->funcs->disable_vga)
+			tg->funcs->disable_vga(tg);
+	}
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		/* Enable CLOCK gating for each pipe BEFORE controller
+		 * powergating. */
+		enable_display_pipe_clock_gating(ctx,
+				true);
+
+		dc->current_state->res_ctx.pipe_ctx[i].pipe_idx = i;
+		dc->hwss.disable_plane(dc, dc->current_state,
+			&dc->current_state->res_ctx.pipe_ctx[i]);
+	}
+}
+
+static void get_edp_streams(struct dc_state *context,
+		struct dc_stream_state **edp_streams,
+		int *edp_stream_num)
+{
+	uint8_t i;
+
+	*edp_stream_num = 0;
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->signal == SIGNAL_TYPE_EDP) {
+			edp_streams[*edp_stream_num] = context->streams[i];
+			if (++(*edp_stream_num) == MAX_NUM_EDP)
+				return;
+		}
+	}
+}
+
+static void get_edp_links_with_sink(
+		struct dc *dc,
+		struct dc_link **edp_links_with_sink,
+		int *edp_with_sink_num)
+{
+	int i;
+
+	/* check if there is an eDP panel not in use */
+	*edp_with_sink_num = 0;
+	for (i = 0; i < dc->link_count; i++) {
+		if (dc->links[i]->local_sink &&
+			dc->links[i]->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
+			edp_links_with_sink[*edp_with_sink_num] = dc->links[i];
+			if (++(*edp_with_sink_num) == MAX_NUM_EDP)
+				return;
+		}
+	}
+}
+
+static void clean_up_dsc_blocks(struct dc *dc)
+{
+	struct display_stream_compressor *dsc = NULL;
+	struct timing_generator *tg = NULL;
+	struct stream_encoder *se = NULL;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+	unsigned int i;
+
+	if (!dc->caps.is_apu ||
+		dc->ctx->dce_version < DCN_VERSION_3_15)
+		return;
+	/*VBIOS supports dsc starts from dcn315*/
+	for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++) {
+		struct dcn_dsc_state s  = {0};
+
+		dsc = dc->res_pool->dscs[i];
+		dsc->funcs->dsc_read_state(dsc, &s);
+		if (s.dsc_fw_en) {
+			/* disable DSC in OPTC */
+			if (i < dc->res_pool->timing_generator_count) {
+				tg = dc->res_pool->timing_generators[i];
+				if (tg->funcs->set_dsc_config)
+					tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+			}
+			/* disable DSC in stream encoder */
+			if (i < dc->res_pool->stream_enc_count) {
+				se = dc->res_pool->stream_enc[i];
+				if (se->funcs->dp_set_dsc_config)
+					se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				if (se->funcs->dp_set_dsc_pps_info_packet)
+					se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+			}
+			/* disable DSC block */
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			dsc->funcs->dsc_disable(dsc);
+
+			/* power down DSC */
+			if (pg_cntl != NULL)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, dsc->inst, false);
+		}
+	}
+}
+
+static void dc_hwss_enable_otg_pwa(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct timing_generator *tg = NULL;
+
+	if (dc->debug.enable_otg_frame_sync_pwa == 0)
+		return;
+
+	if (pipe_ctx == NULL || pipe_ctx->stream_res.tg == NULL)
+		return;
+	tg = pipe_ctx->stream_res.tg;
+
+	/*only enable this if one active*/
+	if (tg->funcs->enable_otg_pwa) {
+		struct otc_pwa_frame_sync pwa_param = {0};
+
+		DC_LOGGER_INIT(dc->ctx);
+		/* mode 1 to choose generate pwa sync signal on line 0 counting
+		 * from vstartup at very beginning of the frame
+		 */
+		pwa_param.pwa_frame_sync_line_offset = 0;
+		pwa_param.pwa_sync_mode = DC_OTG_PWA_FRAME_SYNC_MODE_VSTARTUP;
+		/*frame sync line for generating high frame sync*/
+		tg->funcs->enable_otg_pwa(tg, &pwa_param);
+		DC_LOG_DC("Enable OTG PWA frame sync on TG %d\n", tg->inst);
+	}
+}
+
+void dcn10_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
+{
+	struct dc_link *edp_links_with_sink[MAX_NUM_EDP];
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
+	struct dc_link *edp_link_with_sink = NULL;
+	struct dc_link *edp_link = NULL;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct dce_hwseq *hws = dc->hwseq;
+	int edp_with_sink_num;
+	unsigned int j, edp_num;
+	int edp_stream_num;
+	int i;
+	bool can_apply_edp_fast_boot = false;
+	bool can_apply_seamless_boot = false;
+	bool keep_edp_vdd_on = false;
+	bool should_clean_dsc_block = true;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+	DC_LOGGER_INIT(dc->ctx);
+
+	get_edp_links_with_sink(dc, edp_links_with_sink, &edp_with_sink_num);
+	dc_get_edp_links(dc, edp_links, &edp_num);
+
+	if (hws->funcs.init_pipes)
+		hws->funcs.init_pipes(dc, context);
+
+	get_edp_streams(context, edp_streams, &edp_stream_num);
+
+	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
+		for (j = 0; j < edp_num; j++) {
+			edp_link = edp_links[j];
+			if (edp_link != edp_streams[0]->link)
+				continue;
+			// enable fastboot if backend is enabled on eDP
+			if (edp_link->link_enc->funcs->is_dig_enabled &&
+			    edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+			    edp_link->link_status.link_active) {
+				struct dc_stream_state *edp_stream = edp_streams[0];
+
+				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
+					edp_stream->sink, &edp_stream->timing);
+
+				// For Mux-platform, the default value is false.
+				// Disable fast boot during mux switching.
+				// The flag would be clean after switching done.
+				if (dc->is_switch_in_progress_dest && edp_link->is_dds)
+					can_apply_edp_fast_boot = false;
+
+				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
+				if (can_apply_edp_fast_boot) {
+					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot Enable\n");
+
+					// Vbios & Driver support different pixel rate div policy.
+					pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, edp_stream);
+					if (pipe_ctx &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
+						// Get Vbios div factor from register
+						dc->res_pool->dccg->funcs->get_pixel_rate_div(
+							dc->res_pool->dccg,
+							pipe_ctx->stream_res.tg->inst,
+							&pipe_ctx->pixel_rate_divider.div_factor1,
+							&pipe_ctx->pixel_rate_divider.div_factor2);
+
+						// VBios doesn't support pixel rate div, so force it.
+						// If VBios supports it, we check it from reigster or other flags.
+						pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle = 1;
+					}
+					dc_hwss_enable_otg_pwa(dc, pipe_ctx);
+				}
+				break;
+			}
+		}
+		// We are trying to enable eDP, don't power down VDD
+		if (can_apply_edp_fast_boot)
+			keep_edp_vdd_on = true;
+	}
+
+	// Check seamless boot support
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->apply_seamless_boot_optimization) {
+			can_apply_seamless_boot = true;
+			break;
+		}
+	}
+
+	/* eDP should not have stream in resume from S4 and so even with VBios post
+	 * it should get turned off
+	 */
+	if (edp_with_sink_num)
+		edp_link_with_sink = edp_links_with_sink[0];
+
+	// During a mux switch, powering down the HW blocks and then enabling
+	// the link via a DPCD SET_POWER write causes a brief flash
+	keep_edp_vdd_on |= dc->is_switch_in_progress_dest;
+
+	if (!can_apply_edp_fast_boot && !can_apply_seamless_boot) {
+		if (edp_link_with_sink && !keep_edp_vdd_on) {
+			/*turn off backlight before DP_blank and encoder powered down*/
+			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
+		}
+		/*resume from S3, no vbios posting, no need to power down again*/
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+
+		power_down_all_hw_blocks(dc);
+
+		/* DSC could be enabled on eDP during VBIOS post.
+		 * To clean up dsc blocks if all eDP dpms_off is true.
+		 */
+		for (i = 0; i < edp_stream_num; i++) {
+			if (!edp_streams[i]->dpms_off) {
+				should_clean_dsc_block = false;
+			}
+		}
+
+		if (should_clean_dsc_block)
+			clean_up_dsc_blocks(dc);
+
+		disable_vga_and_power_gate_all_controllers(dc);
+		if (edp_link_with_sink && !keep_edp_vdd_on)
+			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+	}
+	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
+}
+
+static bool should_enable_fbc(struct dc *dc,
+		struct dc_state *context,
+		uint32_t *pipe_idx)
+{
+	uint32_t i;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &context->res_ctx;
+	unsigned int underlay_idx = dc->res_pool->underlay_pipe_index;
+
+
+	ASSERT(dc->fbc_compressor);
+
+	/* FBC memory should be allocated */
+	if (!dc->ctx->fbc_gpu_addr)
+		return false;
+
+	/* Only supports single display */
+	if (context->stream_count != 1)
+		return false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (res_ctx->pipe_ctx[i].stream) {
+
+			pipe_ctx = &res_ctx->pipe_ctx[i];
+
+			/* fbc not applicable on underlay pipe */
+			if (pipe_ctx->pipe_idx != underlay_idx) {
+				*pipe_idx = i;
+				break;
+			}
+		}
+	}
+
+	if (i == dc->res_pool->pipe_count)
+		return false;
+
+	if (!pipe_ctx->stream->link)
+		return false;
+
+	/* Only supports eDP */
+	if (pipe_ctx->stream->link->connector_signal != SIGNAL_TYPE_EDP)
+		return false;
+
+	/* PSR should not be enabled */
+	if (pipe_ctx->stream->link->psr_settings.psr_feature_enabled)
+		return false;
+
+	/* Replay should not be enabled */
+	if (pipe_ctx->stream->link->replay_settings.replay_feature_enabled)
+		return false;
+
+	/* Nothing to compress */
+	if (!pipe_ctx->plane_state)
+		return false;
+
+	/* Only for non-linear tiling */
+	if (pipe_ctx->plane_state->tiling_info.gfx8.array_mode == DC_ARRAY_LINEAR_GENERAL)
+		return false;
+
+	return true;
+}
+
+void dcn10_enable_fbc(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t pipe_idx = 0;
+
+	if (should_enable_fbc(dc, context, &pipe_idx)) {
+		/* Program GRPH COMPRESSED ADDRESS and PITCH */
+		struct compr_addr_and_pitch_params params = {0, 0, 0};
+		struct compressor *compr = dc->fbc_compressor;
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
+
+		params.source_view_width = pipe_ctx->stream->timing.h_addressable;
+		params.source_view_height = pipe_ctx->stream->timing.v_addressable;
+		params.inst = pipe_ctx->stream_res.tg->inst;
+		compr->compr_surface_address.quad_part = dc->ctx->fbc_gpu_addr;
+
+		compr->funcs->surface_address_and_pitch(compr, &params);
+		compr->funcs->set_fbc_invalidation_triggers(compr, 1);
+
+		compr->funcs->enable_fbc(compr, &params);
+	}
+}
+
+static void dcn10_setup_audio_dto(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	unsigned int i;
+
+	/* program audio wall clock. use HDMI as clock source if HDMI
+	 * audio active. Otherwise, use DP as clock source
+	 * first, loop to find any HDMI audio, if not, loop find DP audio
+	 */
+	/* Setup audio rate clock source */
+	/* Issue:
+	* Audio lag happened on DP monitor when unplug a HDMI monitor
+	*
+	* Cause:
+	* In case of DP and HDMI connected or HDMI only, DCCG_AUDIO_DTO_SEL
+	* is set to either dto0 or dto1, audio should work fine.
+	* In case of DP connected only, DCCG_AUDIO_DTO_SEL should be dto1,
+	* set to dto0 will cause audio lag.
+	*
+	* Solution:
+	* Not optimized audio wall dto setup. When mode set, iterate pipe_ctx,
+	* find first available pipe with audio, setup audio wall DTO per topology
+	* instead of per pipe.
+	*/
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == NULL)
+			continue;
+
+		if (pipe_ctx->top_pipe)
+			continue;
+		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A &&
+			pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_FRL)
+			continue;
+		if (pipe_ctx->stream_res.audio != NULL) {
+			struct audio_output audio_output;
+
+			dcn10_build_audio_output(context, pipe_ctx, &audio_output);
+
+			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
+				struct dtbclk_dto_params dto_params = {0};
+				dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+
+				if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+					/* For DCN3.1, audio to HPO FRL encoder is using audio DTBCLK DTO */
+					/* set audio DTBCLK DTO to 24MHz */
+					dto_params.req_audio_dtbclk_khz = 24000;
+					dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+						dc->res_pool->dccg,
+						&dto_params);
+				} else {
+					/* Audio DTBCLK params default to disabled */
+					dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+						dc->res_pool->dccg,
+						&dto_params);
+
+					pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+						pipe_ctx->stream_res.audio,
+						pipe_ctx->stream->signal,
+						&audio_output.crtc_info,
+						&audio_output.pll_info);
+				}
+			} else
+				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+					pipe_ctx->stream_res.audio,
+					pipe_ctx->stream->signal,
+					&audio_output.crtc_info,
+					&audio_output.pll_info);
+			break;
+		}
+	}
+
+	/* no HDMI audio is found, try DP audio */
+	if (i == dc->res_pool->pipe_count) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->stream == NULL)
+				continue;
+
+			if (pipe_ctx->top_pipe)
+				continue;
+
+			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
+				continue;
+
+			if (pipe_ctx->stream_res.audio != NULL) {
+				struct audio_output audio_output = {0};
+
+				dcn10_build_audio_output(context, pipe_ctx, &audio_output);
+
+				/* Audio to HPO DP encoder is using audio DTBCLK DTO */
+				if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
+					struct dtbclk_dto_params dto_params = {0};
+					dto_params.ref_dtbclk_khz =
+							dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+
+					if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+						/* set audio DTBCLK DTO to 24MHz */
+						dto_params.req_audio_dtbclk_khz = 24000;
+						dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+							dc->res_pool->dccg,
+							&dto_params);
+					} else {
+						/* Audio DTBCLK params default to disabled */
+						dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+							dc->res_pool->dccg,
+							&dto_params);
+
+						pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+							pipe_ctx->stream_res.audio,
+							pipe_ctx->stream->signal,
+							&audio_output.crtc_info,
+							&audio_output.pll_info);
+					}
+				} else {
+					pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+						pipe_ctx->stream_res.audio,
+						pipe_ctx->stream->signal,
+						&audio_output.crtc_info,
+						&audio_output.pll_info);
+				}
+				break;
+			}
+		}
+	}
+}
+
+enum dc_status dcn10_apply_ctx_to_hw(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+	enum dc_status status;
+	unsigned int i;
+	bool was_hpo_acquired = resource_is_hpo_acquired(dc->current_state);
+	bool is_hpo_acquired = resource_is_hpo_acquired(context);
+
+	/* reset syncd pipes from disabled pipes */
+	if (dc->config.use_pipe_ctx_sync_logic)
+		reset_syncd_pipes_from_disabled_pipes(dc, context);
+
+	/* Reset old context */
+	/* look up the targets that have been removed since last commit */
+	hws->funcs.reset_hw_ctx_wrap(dc, context);
+
+	/* Skip applying if no targets */
+	if (context->stream_count <= 0)
+		return DC_OK;
+
+	/* Apply new context */
+	dcb->funcs->set_scratch_critical_state(dcb, true);
+
+	/* below is for real asic only */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx_old =
+					&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == NULL || pipe_ctx->top_pipe)
+			continue;
+
+		if (pipe_ctx->stream == pipe_ctx_old->stream) {
+			if (pipe_ctx_old->clock_source != pipe_ctx->clock_source)
+				dce_crtc_switch_to_clk_src(dc->hwseq,
+						pipe_ctx->clock_source, i);
+			continue;
+		}
+
+		hws->funcs.enable_display_power_gating(
+				dc, (uint8_t)i, dc->ctx->dc_bios,
+				PIPE_GATING_CONTROL_DISABLE);
+	}
+
+	if (dc->fbc_compressor)
+		dc->fbc_compressor->funcs->disable_fbc(dc->fbc_compressor);
+
+	dcn10_setup_audio_dto(dc, context);
+
+	if (dc->hwseq->funcs.setup_hpo_hw_control && was_hpo_acquired != is_hpo_acquired) {
+		dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, is_hpo_acquired);
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx_old =
+					&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == NULL)
+			continue;
+
+		if (pipe_ctx->stream == pipe_ctx_old->stream &&
+			pipe_ctx->stream->link->link_state_valid) {
+			continue;
+		}
+
+		if (pipe_ctx_old->stream && !pipe_need_reprogram(pipe_ctx_old, pipe_ctx))
+			continue;
+
+		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe)
+			continue;
+
+		status = dcn10_apply_single_controller_ctx_to_hw(
+				pipe_ctx,
+				context,
+				dc);
+
+		if (DC_OK != status)
+			return status;
+
+#ifdef CONFIG_DRM_AMD_DC_FP
+		if (hws->funcs.resync_fifo_dccg_dio)
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context, i);
+#endif
+	}
+
+
+	if (dc->debug.enable_otg_frame_sync_pwa && context->stream_count == 1) {
+		/* only enable this on one OTG*/
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx && pipe_ctx->stream != NULL) {
+				dc_hwss_enable_otg_pwa(dc, pipe_ctx);
+				break;
+			}
+		}
+	}
+	if (dc->fbc_compressor)
+		dcn10_enable_fbc(dc, dc->current_state);
+
+	dcb->funcs->set_scratch_critical_state(dcb, false);
+
+	return DC_OK;
+}
+
+void dcn10_power_down(struct dc *dc)
+{
+	power_down_all_hw_blocks(dc);
+	disable_vga_and_power_gate_all_controllers(dc);
+}
+
+bool dcn10_set_backlight_level(struct pipe_ctx *pipe_ctx,
+	struct set_backlight_level_params *backlight_level_params)
+{
+	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = backlight_level_params->frame_ramp;
+	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc  *dc = link->ctx->dc;
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = link->panel_cntl;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	bool fw_set_brightness = true;
+	/* DMCU -1 for all controller id values,
+	 * therefore +1 here
+	 */
+	uint32_t controller_id = pipe_ctx->stream_res.tg->inst + 1;
+
+	if (abm == NULL || panel_cntl == NULL || (abm->funcs->set_backlight_level_pwm == NULL))
+		return false;
+
+	if (dmcu)
+		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
+
+	if (!fw_set_brightness && panel_cntl->funcs->driver_set_backlight)
+		panel_cntl->funcs->driver_set_backlight(panel_cntl, backlight_pwm_u16_16);
+	else
+		abm->funcs->set_backlight_level_pwm(
+				abm,
+				backlight_pwm_u16_16,
+				frame_ramp,
+				controller_id,
+				link->panel_cntl->inst);
+
+	return true;
+}
+
+void dcn10_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	if (abm)
+		abm->funcs->set_abm_immediate_disable(abm,
+				pipe_ctx->stream->link->panel_cntl->inst);
+
+	if (panel_cntl)
+		panel_cntl->funcs->store_backlight_level(panel_cntl);
+}
+
+void dcn10_set_pipe(struct pipe_ctx *pipe_ctx)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst + 1;
+
+	if (abm && panel_cntl)
+		abm->funcs->set_pipe(abm, otg_inst, panel_cntl->inst);
+}
+
+void dcn10_enable_lvds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum clock_source_id clock_source,
+		uint32_t pixel_clock)
+{
+	(void)link_res;
+	link->link_enc->funcs->enable_lvds_output(
+			link->link_enc,
+			clock_source,
+			pixel_clock);
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+}
+
+void dcn10_enable_tmds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		enum dc_color_depth color_depth,
+		uint32_t pixel_clock)
+{
+	(void)link_res;
+	link->link_enc->funcs->enable_tmds_output(
+			link->link_enc,
+			clock_source,
+			color_depth,
+			signal,
+			pixel_clock);
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+}
+
+void dcn10_enable_dp_link_output(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct pipe_ctx *pipes =
+			link->dc->current_state->res_ctx.pipe_ctx;
+	struct clock_source *dp_cs =
+			link->dc->res_pool->dp_clock_source;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	unsigned int i;
+
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	}
+
+	/* If the current pixel clock source is not DTO(happens after
+	 * switching from HDMI passive dongle to DP on the same connector),
+	 * switch the pixel clock source to DTO.
+	 */
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream != NULL &&
+				pipes[i].stream->link == link) {
+			if (pipes[i].clock_source != NULL &&
+					pipes[i].clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
+				pipes[i].clock_source = dp_cs;
+				pipes[i].stream_res.pix_clk_params.requested_pix_clk_100hz =
+						pipes[i].stream->timing.pix_clk_100hz;
+				pipes[i].clock_source->funcs->program_pix_clk(
+						pipes[i].clock_source,
+						&pipes[i].stream_res.pix_clk_params,
+						dc->link_srv->dp_get_encoding_format(link_settings),
+						&pipes[i].pll_settings);
+			}
+		}
+	}
+
+	if (link->ext_enc_id.id) {
+		dcn10_external_encoder_control(EXTERNAL_ENCODER_CONTROL_INIT, link, NULL);
+		dcn10_external_encoder_control(EXTERNAL_ENCODER_CONTROL_SETUP, link, NULL);
+	}
+
+	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (dc->clk_mgr->funcs->notify_link_rate_change)
+			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+	}
+
+	if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (link_hwss->ext.enable_dp_link_output)
+		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
+				clock_source, link_settings);
+
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
+}
+
+void dcn10_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 2cb674ba54e1..2484707757d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -111,7 +111,7 @@ void dcn10_program_gamut_remap(struct program_gamut_remap_params *params);
 void dcn10_init_hw(struct dc *dc);
 void dcn10_init_pipes(struct dc *dc, struct dc_state *context);
 void dcn10_power_down_on_boot(struct dc *dc);
-enum dc_status dce110_apply_ctx_to_hw(
+enum dc_status dcn10_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context);
 void dcn10_plane_atomic_disconnect(struct dc *dc,
@@ -119,8 +119,8 @@ void dcn10_plane_atomic_disconnect(struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
 void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data);
 void dcn10_update_pending_status(struct pipe_ctx *pipe_ctx);
-void dce110_power_down(struct dc *dc);
-void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context);
+void dcn10_power_down(struct dc *dc);
+void dcn10_enable_accelerated_mode(struct dc *dc, struct dc_state *context);
 void dcn10_enable_timing_synchronization(
 		struct dc *dc,
 		struct dc_state *state,
@@ -136,13 +136,13 @@ void dcn10_enable_per_frame_crtc_position_reset(
 		struct dc *dc,
 		int group_size,
 		struct pipe_ctx *grouped_pipes[]);
-void dce110_update_info_frame(struct pipe_ctx *pipe_ctx);
+void dcn10_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn10_send_immediate_sdp_message(struct pipe_ctx *pipe_ctx,
 		const uint8_t *custom_sdp_message,
 		unsigned int sdp_message_size);
-void dce110_blank_stream(struct pipe_ctx *pipe_ctx);
-void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx);
-void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx);
+void dcn10_blank_stream(struct pipe_ctx *pipe_ctx);
+void dcn10_enable_audio_stream(struct pipe_ctx *pipe_ctx);
+void dcn10_disable_audio_stream(struct pipe_ctx *pipe_ctx);
 bool dcn10_dummy_display_power_gating(
 		struct dc *dc,
 		uint8_t controller_id,
@@ -156,7 +156,7 @@ void dcn10_get_position(struct pipe_ctx **pipe_ctx,
 void dcn10_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params);
 void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc);
-void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
+void dcn10_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn10_log_hw_state(struct dc *dc,
 		struct dc_log_buffer_ctx *log_ctx);
 void dcn10_get_hw_state(struct dc *dc,
@@ -168,15 +168,15 @@ void dcn10_wait_for_mpcc_disconnect(
 		struct dc *dc,
 		struct resource_pool *res_pool,
 		struct pipe_ctx *pipe_ctx);
-void dce110_edp_backlight_control(
+void dcn10_edp_backlight_control(
 		struct dc_link *link,
 		bool enable);
-void dce110_edp_wait_for_T12(
+void dcn10_edp_wait_for_T12(
 		struct dc_link *link);
-void dce110_edp_power_control(
+void dcn10_edp_power_control(
 		struct dc_link *link,
 		bool power_up);
-void dce110_edp_wait_for_hpd_ready(
+void dcn10_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
 void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx);
@@ -219,4 +219,46 @@ void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
 void dcn10_config_stereo_parameters(
 		struct dc_stream_state *stream, struct crtc_stereo_flags *flags);
 
+/* Declarations for sequencer functions folded in from dce110_hwseq.c */
+void dcn10_enable_stream(struct pipe_ctx *pipe_ctx);
+void dcn10_disable_stream(struct pipe_ctx *pipe_ctx);
+enum audio_dto_source dcn10_translate_to_dto_source(enum controller_id crtc_id);
+void dcn10_populate_audio_dp_link_info(
+		const struct pipe_ctx *pipe_ctx,
+		struct audio_dp_link_info *dp_link_info);
+void dcn10_build_audio_output(
+		struct dc_state *state,
+		const struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output);
+enum dc_status dcn10_apply_single_controller_ctx_to_hw(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct dc *dc);
+void dcn10_enable_fbc(
+		struct dc *dc,
+		struct dc_state *context);
+bool dcn10_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		struct set_backlight_level_params *backlight_level_params);
+void dcn10_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
+void dcn10_set_pipe(struct pipe_ctx *pipe_ctx);
+void dcn10_enable_lvds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum clock_source_id clock_source,
+		uint32_t pixel_clock);
+void dcn10_enable_tmds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		enum dc_color_depth color_depth,
+		uint32_t pixel_clock);
+void dcn10_enable_dp_link_output(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings);
+void dcn10_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index b5e82e190124..b91256c6f88c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -24,7 +24,7 @@
  */
 
 #include "hw_sequencer_private.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 
@@ -32,7 +32,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
@@ -42,17 +42,17 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.update_pending_status = dcn10_update_pending_status,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.program_output_csc = dcn10_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
-	.update_info_frame = dce110_update_info_frame,
+	.update_info_frame = dcn10_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
-	.enable_stream = dce110_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.enable_stream = dcn10_enable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn10_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
 	.pipe_control_lock = dcn10_pipe_control_lock,
 	.cursor_lock = dcn10_cursor_lock,
@@ -63,14 +63,14 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn10_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
-	.set_avmute = dce110_set_avmute,
+	.set_avmute = dcn10_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -79,13 +79,13 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dce110_set_backlight_level,
-	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
-	.set_pipe = dce110_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.set_backlight_level = dcn10_set_backlight_level,
+	.set_abm_immediate_disable = dcn10_set_abm_immediate_disable,
+	.set_pipe = dcn10_set_pipe,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
@@ -97,12 +97,12 @@ static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.update_mpcc = dcn10_update_mpcc,
 	.set_input_transfer_func = dcn10_set_input_transfer_func,
 	.set_output_transfer_func = dcn10_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn10_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn10_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn10_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = NULL,
 	.enable_stream_gating = NULL,
 	.setup_vupdate_interrupt = dcn10_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 1797a91b0186..3cc65e2678b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 
@@ -33,7 +33,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot =  dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -43,18 +43,18 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_vblanks_synchronization = dcn10_enable_vblanks_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
-	.update_info_frame = dce110_update_info_frame,
+	.update_info_frame = dcn10_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
@@ -66,15 +66,15 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn10_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
-	.set_avmute = dce110_set_avmute,
+	.set_avmute = dcn10_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.log_color_state = dcn20_log_color_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -92,13 +92,13 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dce110_set_backlight_level,
-	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
-	.set_pipe = dce110_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.set_backlight_level = dcn10_set_backlight_level,
+	.set_abm_immediate_disable = dcn10_set_abm_immediate_disable,
+	.set_pipe = dcn10_set_pipe,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
@@ -110,12 +110,12 @@ static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
 	.set_output_transfer_func = dcn20_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index dec57fb4c05c..fb45235f0e34 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn201/dcn201_hwseq.h"
@@ -33,7 +33,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn201_init_hw,
 	.power_down_on_boot = NULL,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -43,17 +43,17 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
-	.update_info_frame = dce110_update_info_frame,
+	.update_info_frame = dcn10_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
-	.enable_stream = dce110_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.enable_stream = dcn10_enable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn201_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
 	.pipe_control_lock = dcn201_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
@@ -65,14 +65,14 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn10_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
-	.set_avmute = dce110_set_avmute,
+	.set_avmute = dcn10_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
@@ -84,13 +84,13 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn201_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
-	.set_backlight_level = dce110_set_backlight_level,
-	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
-	.set_pipe = dce110_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.set_backlight_level = dcn10_set_backlight_level,
+	.set_abm_immediate_disable = dcn10_set_abm_immediate_disable,
+	.set_pipe = dcn10_set_pipe,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
@@ -102,12 +102,12 @@ static const struct hwseq_private_funcs dcn201_private_funcs = {
 	.update_mpcc = dcn201_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
 	.set_output_transfer_func = dcn20_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn10_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = NULL,
 	.enable_stream_gating = NULL,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 2be68f8dd0fc..2fae6161b3a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 #include "resource.h"
 #include "dce/dce_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn21_hwseq.h"
 #include "vmid.h"
 #include "reg_helper.h"
@@ -211,7 +211,7 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	}
 
 	if (dmcu) {
-		dce110_set_abm_immediate_disable(pipe_ctx);
+		dcn10_set_abm_immediate_disable(pipe_ctx);
 		return;
 	}
 
@@ -248,7 +248,7 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 	otg_inst = tg->inst;
 
 	if (dmcu) {
-		dce110_set_pipe(pipe_ctx);
+		dcn10_set_pipe(pipe_ctx);
 		return;
 	}
 
@@ -289,7 +289,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
-		dce110_set_backlight_level(pipe_ctx, backlight_level_params);
+		dcn10_set_backlight_level(pipe_ctx, backlight_level_params);
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index c7701a8b574a..f90c88ace2a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -34,7 +34,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -44,17 +44,17 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
-	.update_info_frame = dce110_update_info_frame,
+	.update_info_frame = dcn10_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
@@ -66,15 +66,15 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn10_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
-	.set_avmute = dce110_set_avmute,
+	.set_avmute = dcn10_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.log_color_state = dcn20_log_color_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -97,10 +97,10 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
@@ -113,12 +113,12 @@ static const struct hwseq_private_funcs dcn21_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
 	.set_output_transfer_func = dcn20_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index d5aa58462855..7965285b587b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -34,7 +34,7 @@
 static const struct hw_sequencer_funcs dcn30_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn30_init_hw,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -44,17 +44,17 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn30_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -73,10 +73,10 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -101,10 +101,10 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
@@ -120,12 +120,12 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index a570333aeac1..cd083fadc6bd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -36,7 +36,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -46,17 +46,17 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn30_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
@@ -74,9 +74,9 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -98,10 +98,10 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
@@ -116,12 +116,12 @@ static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 7197414e5bd6..9ffe03bf21d5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -37,7 +37,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn31_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -47,17 +47,17 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -76,10 +76,10 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -102,10 +102,10 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dce110_disable_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
+	.disable_link_output = dcn10_disable_link_output,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
@@ -122,12 +122,12 @@ static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 4966c044a864..53d9097d7ce5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -24,7 +24,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -39,7 +39,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn31_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -49,17 +49,17 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -78,10 +78,10 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.log_color_state = dcn30_log_color_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -104,9 +104,9 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn314_disable_link_output,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
@@ -125,12 +125,12 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 364b4108f5d6..b1e1e74a26b5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -37,7 +37,7 @@
 static const struct hw_sequencer_funcs dcn32_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn32_init_hw,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -47,17 +47,17 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn32_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -75,10 +75,10 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -105,9 +105,9 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn32_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
@@ -133,12 +133,12 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn32_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
@@ -164,7 +164,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
-	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.apply_single_controller_ctx_to_hw = dcn10_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
 	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index fc18d2207711..8cdbbe92e398 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -24,7 +24,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -41,7 +41,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn35_init_hw,
 	.power_down_on_boot = dcn35_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -51,17 +51,17 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn32_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -79,10 +79,10 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -111,9 +111,9 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn35_disable_link_output,
 	.z10_restore = dcn35_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
@@ -143,12 +143,12 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn32_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.did_underflow_occur = dcn10_did_underflow_occur,
 	.init_blank = dcn20_init_blank,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 19ec5b4edfdc..e51bd356849d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -40,7 +40,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn35_init_hw,
 	.power_down_on_boot = dcn35_power_down_on_boot,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -50,17 +50,17 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn32_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -78,10 +78,10 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -104,9 +104,9 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn32_disable_link_output,
 	.z10_restore = dcn35_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
@@ -132,12 +132,12 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn32_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.did_underflow_occur = dcn10_did_underflow_occur,
 	.init_blank = dcn20_init_blank,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index f206e221f926..99bec66322a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -2,7 +2,7 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -16,7 +16,7 @@
 static const struct hw_sequencer_funcs dcn401_funcs = {
 	.program_gamut_remap = dcn401_program_gamut_remap,
 	.init_hw = dcn401_init_hw,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn401_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -27,17 +27,17 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
 	.trigger_3dlut_dma_load = dcn401_trigger_3dlut_dma_load,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn401_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn401_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_plane_sequence = dcn401_disable_plane_sequence,
 	.pipe_control_lock = dcn20_pipe_control_lock,
@@ -58,10 +58,10 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
 	.wait_for_mpcc_disconnect_sequence = dcn401_wait_for_mpcc_disconnect_sequence,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
 	.set_cursor_position = dcn401_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -93,9 +93,9 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn401_hardware_release,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn401_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
@@ -130,13 +130,13 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.update_mpcc_sequence = dcn401_update_mpcc_sequence,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn401_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.blank_pixel_data_sequence = dcn401_blank_pixel_data_sequence,
 	.reset_hw_ctx_wrap = dcn401_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.setup_vupdate_interrupt_sequence = dcn401_setup_vupdate_interrupt_sequence,
 	.did_underflow_occur = dcn10_did_underflow_occur,
@@ -164,7 +164,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.program_mall_pipe_config_sequence = dcn401_program_mall_pipe_config_sequence,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
-	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.apply_single_controller_ctx_to_hw = dcn10_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
 	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index 49c13611a518..3f6be27ce51c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -2,7 +2,7 @@
 //
 // Copyright 2026 Advanced Micro Devices, Inc.
 
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
@@ -18,7 +18,7 @@
 static const struct hw_sequencer_funcs dcn42_funcs = {
 	.program_gamut_remap = dcn401_program_gamut_remap,
 	.init_hw = dcn42_init_hw,
-	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_to_hw = dcn10_apply_ctx_to_hw,
 	.power_down_on_boot = dcn42_power_down_on_boot,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn401_program_front_end_for_ctx,
@@ -30,17 +30,17 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
 	.trigger_3dlut_dma_load = dcn401_trigger_3dlut_dma_load,
-	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_accelerated_mode = dcn10_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
 	.update_info_frame = dcn31_update_info_frame,
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn401_enable_stream,
-	.disable_stream = dce110_disable_stream,
+	.disable_stream = dcn10_disable_stream,
 	.unblank_stream = dcn401_unblank_stream,
-	.blank_stream = dce110_blank_stream,
-	.enable_audio_stream = dce110_enable_audio_stream,
-	.disable_audio_stream = dce110_disable_audio_stream,
+	.blank_stream = dcn10_blank_stream,
+	.enable_audio_stream = dcn10_enable_audio_stream,
+	.disable_audio_stream = dcn10_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn401_interdependent_update_lock,
@@ -57,10 +57,10 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
-	.edp_backlight_control = dce110_edp_backlight_control,
-	.edp_power_control = dce110_edp_power_control,
-	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
-	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_backlight_control = dcn10_edp_backlight_control,
+	.edp_power_control = dcn10_edp_power_control,
+	.edp_wait_for_hpd_ready = dcn10_edp_wait_for_hpd_ready,
+	.edp_wait_for_T12 = dcn10_edp_wait_for_T12,
 	.set_cursor_position = dcn401_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
@@ -92,9 +92,9 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn42_hardware_release,
 	.set_pipe = dcn21_set_pipe,
-	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_lvds_link_output = dcn10_enable_lvds_link_output,
+	.enable_tmds_link_output = dcn10_enable_tmds_link_output,
+	.enable_dp_link_output = dcn10_enable_dp_link_output,
 	.disable_link_output = dcn401_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
@@ -132,12 +132,12 @@ static const struct hwseq_private_funcs dcn42_private_funcs = {
 	.update_mpcc = dcn42_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn401_set_output_transfer_func,
-	.power_down = dce110_power_down,
+	.power_down = dcn10_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn401_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
-	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_backlight_control = dcn10_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
 	.did_underflow_occur = dcn10_did_underflow_occur,
 	.init_blank = dcn32_init_blank,
@@ -153,7 +153,7 @@ static const struct hwseq_private_funcs dcn42_private_funcs = {
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
-	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
+	.apply_single_controller_ctx_to_hw = dcn10_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
 	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index b595a11c5eaf..f8ae3b2669d2 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -28,14 +28,18 @@
 #include "include/irq_service_interface.h"
 #include "include/logger_interface.h"
 
+#if !defined(TRIM_DCE)
 #include "dce110/irq_service_dce110.h"
+#endif
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/irq_service_dce60.h"
 #endif
 
+#if !defined(TRIM_DCE)
 #include "dce80/irq_service_dce80.h"
 #include "dce120/irq_service_dce120.h"
+#endif
 #include "dcn10/irq_service_dcn10.h"
 
 #include "reg_helper.h"
@@ -92,6 +96,33 @@ static const struct irq_source_info *find_irq_source_info(
 	return &irq_service->info[source];
 }
 
+/*
+ * In the trimmed build the dce110 irq dir (which owns these dummy handlers)
+ * is excluded, so provide the definitions here. In the non-trimmed build the
+ * originals in dce110/irq_service_dce110.c are used instead.
+ */
+#if defined(TRIM_DCE)
+bool dal_irq_service_dummy_set(struct irq_service *irq_service,
+			       const struct irq_source_info *info,
+			       bool enable)
+{
+	(void)enable;
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
+	return false;
+}
+
+bool dal_irq_service_dummy_ack(struct irq_service *irq_service,
+			       const struct irq_source_info *info)
+{
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
+	return false;
+}
+#endif /* TRIM_DCE */
+
 void dal_irq_service_set_generic(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info,
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index bbcef3d2fe33..8b6a842f38cc 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -82,6 +82,15 @@ void dal_irq_service_set_generic(
 	const struct irq_source_info *info,
 	bool enable);
 
+bool dal_irq_service_dummy_set(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info,
+	bool enable);
+
+bool dal_irq_service_dummy_ack(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info);
+
 bool hpd0_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 214461f5d2f2..5975432c174c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -41,7 +41,7 @@
 #include "dcn10/dcn10_dpp.h"
 #include "dcn10/dcn10_optc.h"
 #include "dcn10/dcn10_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_opp.h"
 #include "dcn10/dcn10_link_encoder.h"
 #include "dcn10/dcn10_stream_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 2cfe69708bf6..9e7839032b81 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -44,7 +44,7 @@
 #include "dcn20/dcn20_dpp.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn20/dcn20_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn20/dcn20_opp.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 447f61965295..72164140bdec 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -44,7 +44,7 @@
 #include "dcn201/dcn201_dccg.h"
 #include "dcn201/dcn201_optc.h"
 #include "dcn201/dcn201_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn201/dcn201_opp.h"
 #include "dcn201/dcn201_link_encoder.h"
 #include "dcn20/dcn20_stream_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 0ee386c3bc23..6707a7062955 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -49,7 +49,7 @@
 #include "dcn20/dcn20_dpp.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn21/dcn21_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn21/dcn21_link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index ec74538472ee..57fb333beee8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -44,7 +44,7 @@
 #include "dcn30/dcn30_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 77f9e371f48e..263722ee6a5c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -45,7 +45,7 @@
 #include "dcn301/dcn301_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index e6d7da830440..45e2c348e251 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -48,7 +48,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
@@ -2442,7 +2442,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-			build_audio_output(state, &pipes[i], &audio_output[i]);
+			dcn10_build_audio_output(state, &pipes[i], &audio_output[i]);
 	}
 #else
 	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index ef2038efbfc2..1bcd9ffbbab8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -50,7 +50,7 @@
 #include "dcn314/dcn314_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index dbf9cb934c76..71b9aa1ca757 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -47,7 +47,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 3a776959767c..2aca863e5269 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -47,7 +47,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 697463622a10..bbd98a29b35c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -48,7 +48,7 @@
 #include "dcn32/dcn32_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 6ebab0f185c9..4991ddea6b53 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -50,7 +50,7 @@
 #include "dcn32/dcn32_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 800a030990bd..563e6001a03c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -51,7 +51,7 @@
 #include "dcn35/dcn35_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn35/dcn35_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 8e276c333dbe..aebf48e4e182 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -29,7 +29,7 @@
 #include "dcn35/dcn35_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn35/dcn35_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index e2368a5c1eed..f8cc20ed1264 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -30,7 +30,7 @@
 #include "dcn35/dcn35_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn35/dcn35_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 302c1f4bc7bc..25b0ab401a98 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -27,7 +27,7 @@
 #include "dcn401/dcn401_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_opp.h"
 #include "dcn401/dcn401_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 547a0b816539..99e6be1423cd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -34,7 +34,7 @@
 #include "dcn42/dcn42_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dcn31/dcn31_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 2334bc5b75b8..0698e68a0b09 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -38,7 +38,7 @@
 #include "dcn42/dcn42_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dcn31/dcn31_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index da74ed66c8f9..7c691dda8aac 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -202,13 +202,13 @@ enum dpcd_source_sequence {
 	DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE,      /*done in perform_link_training_with_retries/dcn20_enable_stream */
 	DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY,        /*done in dp_enable_link_phy */
 	DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN,     /*done in dp_set_hw_test_pattern */
-	DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM,    /*done in dce110_enable_audio_stream */
+	DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM,    /*done in dcn10_enable_audio_stream */
 	DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM,   /*done in enc1_stream_encoder_dp_unblank */
 	DPCD_SOURCE_SEQ_AFTER_DISABLE_DP_VID_STREAM,  /*done in enc1_stream_encoder_dp_blank */
 	DPCD_SOURCE_SEQ_AFTER_FIFO_STEER_RESET,       /*done in enc1_stream_encoder_dp_blank */
-	DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM,   /*done in dce110_disable_audio_stream */
+	DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM,   /*done in dcn10_disable_audio_stream */
 	DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY,       /*done in dp_disable_link_phy */
-	DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE,   /*done in dce110_disable_stream */
+	DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE,   /*done in dcn10_disable_stream */
 };
 
 /* DPCD_ADDR_TRAINING_LANEx_SET registers value */
-- 
2.43.0

