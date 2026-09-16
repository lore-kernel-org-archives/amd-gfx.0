Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78E4C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EEB10E7D3;
	Wed, 16 Sep 2026 17:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXzY0O/g";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599B510E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7fNk+3edIm2P46OG5X6RvAiwL/aPbcRfyICp+58EXIbL4uKyJ8GZClMRQ4s+ywsrgl0/WZ3Z/NYNkMDgYNrvuYJjPtKQBLMHSru7lO9HlsmgqZLPZ4LtBji87LxB1PibtlxjBQ0AMrOVGbeHSn0AJvmceBDx9YGmc2m6nzOZnJdzVyTY+u/twYVFnY5no5gy54a3RIo5skpoScmhB/4X3CKQ1zo9FU2mQQ7BMIu+VJQBBXfjklNJtipblnAd8i2W7jTUgNiQa0TfcWkTnJedQsnukHrb+UQ68LKRKoyiM0nrf0Jkg/Xq2P146HXXhMHMluo/C08fQvULe+PcEPVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDChQoPlqyXhc/jWN6xI4+YrXMreFwWKmfNuUpAPKrY=;
 b=OzfEDzrMlFlTKAFGyexQPRJWOCb5JYtuUYXlkzVuqoe14W4ixgyLvm6GajCsstdu4hWcz5GpHvg9WApB2jn2AYWq26FDJdXdu9MHZni2zdarSeclSaMalFHGRpvhA1hUrM7TgF5Pl7ppYJ/UUWMZyC1hHit82DC1qWgamm7VghTmdvoX2OmnciWwhl80CNrQBiXvIKvC5se2dLnJHV9TNsn6HWMMRrnAJWHwnXSrqhnkLOfz6vTctW65+brsAnctJ7pGUr3gJkMwN/ULJBlcE0qe7nkxT/SGrRHUtSYouYBvCBy/In9AAgyfhJGHjn5HEHnZ+pZchYi9OILUrhf4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDChQoPlqyXhc/jWN6xI4+YrXMreFwWKmfNuUpAPKrY=;
 b=cXzY0O/giVU/E2gwWC+xptUw9avn6299pscPU1zzo1MBfErcCE9hEBPiuug9MCQEakxQc4AeJyIV9fZURZI1qOwu044gZfSO7m7iRq9j2a64XRmmBc6Ph+YUBKLOawbNzJutb3sdiZjBOXQIq9LF1pTpU7KqSaT346KMkQ+iNYs=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:20 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::66) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:19 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:14 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 04/64] drm/amd/display: Add inst field to struct hubbub
Date: Wed, 16 Sep 2026 13:51:19 -0400
Message-ID: <20260916175301.368306-5-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a6253-1045-48c9-e7f1-08df141b4104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m+JFgcpC38Sww1IPNQwVGBlypNvnR/MsbJG0koDPWFqep1kODOHDvn2yWE849UurHmvwoPkTZecRbhcej9rBCB0yB3W8gDA7XNEsVtwVXZ/OuMXu+khysDHJRq2HzDrcZAA6FZeZA5ndh44njtgXAjy56wJayZBdWoGkyLkvZRnxWTCgYGJ7r/5YGjwy9i0Y3mkhJ55zevOZV5+TcnveZDgz1puirxLOqloMyk/Jr2HFTsP/zhNrI6S5lE0ln74P+6f5LOs4mIjwASvxN3TCrUPc9qO7T0NtdWyvX3O92bf4kSSGs9d0VnjBGUuR5sb0mmp81rTMj21KEiDRV/wa66M6Coka/J9IkjdjcwrzZiUIS4KMyN767bXEWggCevssUkwx8O5vupcZChjXoAKgaKqIp1E6w1EwVJEbY8RaGPgCEo0Ob3EFrY0i+/x+Z5CVS5fLjslN0GAcpIwxfwr0MSM1vl4cZPPe4SpMzb4vcSGibDX7+axx7v2NAD7paW5z7CQHSajCjpXtCil7CCA7rokkUox2fbMeo9a3wBPIFWcGL6wZqbaAVMgip5RHF2/sVBYlEChpCTzNGTHvlFvDbxuSyxa8i0yDC6OtWVyWdcdo1icGjHvyDrHd2i7qAhFNv2Im4YT7qf5206W50f5+gDI2WPTcNgCxpcenua9KAB+K7/ca0zIFXKRJFNXFWFE/0zKsk70KLRlX/0sSSyPJtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1SjInMMA4SgsTqX6O5Vm7cHlY3elxhO451zoMI+Lr1KdjSswZwU/xQKWZ9BFufvgU0sMnW6lMGgERX0/SON0pM/8jOIae7jQmdzqJGPNE50FK8ulOktuIdWbYmqt7P3XKuNp5FEweWd4mTKrU9qqznqPCdzydLDsuH4poXS3tm5nEGU/8ZF0cyR0bv0wdiIccJBxgmKQtSDG3dkGFlqNnWH+r+4TqlyrE7ky53jv+ie5QGwVfD2mebCaPC6BVkKjsBREPc253PJV8GROSAL9hN6AvFv62t22cXTTGRe2PgwX795zn5ko1D3dlX6ccANVbi2TRnknRHZwaioJkYjDcEQSNEj5I1L+7EJmLn+nbbRKbAf0zfJAbBJaYDytlUPNZfX8KyIyZyJHOemJUP1luPxcbnBLFtbqCjc2LotXWQX2bQktqLPFY540q933HmZj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:19.6853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a6253-1045-48c9-e7f1-08df141b4104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member and initialize it to 0 in every hubbub*_construct()
from DCN10 through DCN60.

No functional change.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h             | 1 +
 13 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index d683d0740c13..4e33648f74bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -933,6 +933,8 @@ void hubbub1_construct(struct hubbub *hubbub,
 
 	hubbub1->base.ctx = ctx;
 
+	hubbub1->base.inst = 0;
+
 	hubbub1->base.funcs = &hubbub1_funcs;
 
 	hubbub1->regs = hubbub_regs;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 9fb2907361c3..e5b55fe502ca 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -680,6 +680,8 @@ void hubbub2_construct(struct dcn20_hubbub *hubbub,
 {
 	hubbub->base.ctx = ctx;
 
+	hubbub->base.inst = 0;
+
 	hubbub->base.funcs = &hubbub2_funcs;
 
 	hubbub->regs = hubbub_regs;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
index 63798132ed95..e6b527cd2047 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
@@ -96,6 +96,8 @@ void hubbub201_construct(struct dcn20_hubbub *hubbub,
 {
 	hubbub->base.ctx = ctx;
 
+	hubbub->base.inst = 0;
+
 	hubbub->base.funcs = &hubbub201_funcs;
 
 	hubbub->regs = hubbub_regs;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
index d790d6ee359a..881e91e9385d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
@@ -712,6 +712,8 @@ void hubbub21_construct(struct dcn20_hubbub *hubbub,
 {
 	hubbub->base.ctx = ctx;
 
+	hubbub->base.inst = 0;
+
 	hubbub->base.funcs = &hubbub21_funcs;
 
 	hubbub->regs = hubbub_regs;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index 6a7c1bee5747..582d647da812 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -478,6 +478,8 @@ void hubbub3_construct(struct dcn20_hubbub *hubbub3,
 	const struct dcn_hubbub_mask *hubbub_mask)
 {
 	hubbub3->base.ctx = ctx;
+
+	hubbub3->base.inst = 0;
 	hubbub3->base.funcs = &hubbub30_funcs;
 	hubbub3->regs = hubbub_regs;
 	hubbub3->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
index c1959672df50..f432874b32dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
@@ -74,6 +74,8 @@ void hubbub301_construct(struct dcn20_hubbub *hubbub3,
 	const struct dcn_hubbub_mask *hubbub_mask)
 {
 	hubbub3->base.ctx = ctx;
+
+	hubbub3->base.inst = 0;
 	hubbub3->base.funcs = &hubbub301_funcs;
 	hubbub3->regs = hubbub_regs;
 	hubbub3->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 35c94ca8335a..8dd4b7b9ba36 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -1080,6 +1080,7 @@ void hubbub31_construct(struct dcn20_hubbub *hubbub31,
 	int pixel_chunk_size_kb,
 	int config_return_buffer_size_kb)
 {
+	hubbub31->base.inst = 0;
 
 	hubbub3_construct(hubbub31, ctx, hubbub_regs, hubbub_shift, hubbub_mask);
 	hubbub31->base.funcs = &hubbub31_funcs;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 237331b35378..dd9bc1f08b56 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -1050,6 +1050,8 @@ void hubbub32_construct(struct dcn20_hubbub *hubbub2,
 	int config_return_buffer_size_kb)
 {
 	hubbub2->base.ctx = ctx;
+
+	hubbub2->base.inst = 0;
 	hubbub2->base.funcs = &hubbub32_funcs;
 	hubbub2->regs = hubbub_regs;
 	hubbub2->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 466bab437e37..ad333cd3241b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -655,6 +655,8 @@ void hubbub35_construct(struct dcn20_hubbub *hubbub2,
 	int config_return_buffer_size_kb)
 {
 	hubbub2->base.ctx = ctx;
+
+	hubbub2->base.inst = 0;
 	hubbub2->base.funcs = &hubbub35_funcs;
 	hubbub2->regs = hubbub_regs;
 	hubbub2->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index e9ff20c02b1e..d948525bc09e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1264,6 +1264,8 @@ void hubbub401_construct(struct dcn20_hubbub *hubbub2,
 	int config_return_buffer_size_kb)
 {
 	hubbub2->base.ctx = ctx;
+
+	hubbub2->base.inst = 0;
 	hubbub2->base.funcs = &hubbub4_01_funcs;
 	hubbub2->regs = hubbub_regs;
 	hubbub2->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 71bc926c7035..b8657de84d31 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -555,6 +555,8 @@ void hubbub42_construct(struct dcn20_hubbub *hubbub2,
 	int config_return_buffer_size_kb)
 {
 	hubbub2->base.ctx = ctx;
+
+	hubbub2->base.inst = 0;
 	hubbub2->base.funcs = &hubbub42_funcs;
 	hubbub2->regs = hubbub_regs;
 	hubbub2->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index c89c8ff42185..639c71cf1123 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1982,6 +1982,8 @@ void hubbub60_construct(struct dcn20_hubbub *hubbub2,
 	int config_return_buffer_size_kb)
 {
 	hubbub2->base.ctx = ctx;
+
+	hubbub2->base.inst = 0;
 	hubbub2->base.funcs = &hubbub60_funcs;
 	hubbub2->regs = hubbub_regs;
 	hubbub2->shifts = hubbub_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 22a0e3dcb25c..8d1024a875a7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -301,6 +301,7 @@ struct hubbub_funcs {
 struct hubbub {
 	const struct hubbub_funcs *funcs;
 	struct dc_context *ctx;
+	int inst;
 	bool riommu_active;
 };
 
-- 
2.55.0

