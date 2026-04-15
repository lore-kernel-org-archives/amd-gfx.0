Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8BBFA0C3D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561F610E0FB;
	Wed, 15 Apr 2026 07:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ooaFmOpL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFBF10E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHQbcdY3LkfxQb5K/WVX2QjPCL2gxbIeRZbCGq8KYOf/+nON8Mdsf8rgDO519Ch90eyAvxZXVZRcFTC1jl2cwehEd0UmOYKmzAhXOUqBBDIpq/WsL7IxGZO87DpM/rSQ7gDtBbYh89shL+vvDddjGjJkKlomxCfSphy0T3jghNElP23WriCn6dDZtv1UvX6Li0jw3/lsbJRKOUgVNCT9xhn/dEkmlGqR0bFsopXqiSCE173yQfTtF8b2E/F33XXbNl2+Jh28VEPljyukRPQp+TTzgyp3sJMK1upWXNfPtNbWnoUlplqFERMIxdUplyVkd278Sw3wMsi/SEVErEzCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJIAXJ0460XmJFB0lwB4FwaxIMH5FvKoTFb/rAm4XcI=;
 b=FKJJZK5IHOjH0S5oWUlie+eDeNypAx48PVvsWcWLHgf1UBLN4VEPYTnnok+BCMoAOHMNeTn1Tca5cusL3W1+EpNIrHKFGkbJ0FFdjpeU9WlAh3b2IOP0U1MxiU+EjQdVC/LLyFLP4/SrB48iHYnWkU35Lkd/az8F3QLpwg6GksTd5Gp/tcPJAN2eSD5LEX3Gdj4GdzDJJJdoJ0xw8bJm3pde0HGy39umHprdcgmdBXM8MhdtNoHGZrHh7XYBmsJF5bNiwJZDwuyTaFLhqgSLYbc118kIjHJmvH+MCYVyQlGuCu/1k5movranmnqwus5wOGIVNu0DYXK/+YBUO8/S4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJIAXJ0460XmJFB0lwB4FwaxIMH5FvKoTFb/rAm4XcI=;
 b=ooaFmOpLAeB8e5W4RLD6gE22gMzoKB9bSg13qATe8rjZtjpG5KwWFKM4K1Q7B7nEkhEFsunDQNEZqUJDadOVK0fY7/SmiF433Hnhct7HJL1MjtSs55P26ht+Ad0YZfQ+3KPMyWJvlPMIrnIyB9ptECdBZKFgy+Sy4rdW5AAG09E=
Received: from MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 15 Apr
 2026 07:44:24 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::25) by MN2PR04CA0020.outlook.office365.com
 (2603:10b6:208:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Apr
 2026 02:44:24 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:20 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 18/19] drm/amd/display: Move dml2_destroy to non-FPU
 compilation unit
Date: Wed, 15 Apr 2026 15:39:57 +0800
Message-ID: <20260415074223.34848-19-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0a5435-9304-48ff-858b-08de9ac2d0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4NJB88KYHJmxAQ5UtYlU/Xy2qsacql5ya+pVwNf3mRklLMgf0abLH8MmI8gd5kYZi9Z1FVjEWSfxLeF3Z4e0UJ0HeAAwCbQpphiZq9v27P+uJXyX8CDiBHe8GfhLagF5e4wPuI8DTMPh5YQ+YbSQpHDsYV9F9MKVwsAujQ4v9Q5UcmMb1EanQhudQ3b6jFx8ms0LXc9nxgMI/2KAaN6cDAStN9AgalUgN1iNlRJ0xIECv796L8dkJrnaTDHk7lvVqQmPjKZEfLMpmJxfHS1xYWhFtaM8WIk+WJ6X85+eXiTHVVeEWmaezWfVB2tgvwYkyHsFXzt8D8t+KW+TAqbGjs98obDy+3VxHf9sPv56Aevy2PjEBseJIJyGdnH0l88qkC7vJsckkWVEHu4z1qnY3gp99HroGWB39gNRCAiHJU+ExGCK+EdRenCMXuXHNrA7yT8xrcG0hHE2yE/npud5wa07fhag6xBA+nWQYMxABBpU+/E2zDJv3NAWKGhM/OCWmqd2b6lgpRKCqXqr5V53HJ9yx3e83CdEtpsS2/HbubI29wea/nj1M5hf8FH4DZo63Q8nYNKW9awLpeLYMzAyjShe2fTFu2W7dJmjqwCmRjBI1oslsmWd1iUb4WM/KVdZWQAgZtWsE+ljRGbyu/lHO+NF8g/SLA89J7FYgpd6QZpzuaB/lfrvepy1A7lYinRi9IJaGzPVRwxHZvu1MOHCr4nbfA1KDfCVQTio1A4H1ZJ/4tE648+bTqw8m5ZxKFkREspw2gbwXwyrjGbnuwD1Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2rCimZMmtNJ8VEEHaIlKI1toriwu9YdrOpPTGXE8vH7t9NLhVBKScsfeIWAfF1go8GkC3IcPooOVXxDPeasWk9NeV3O8fr+CnMqeLcYlcNhBHMyWYroVTtPljlM8eSecEzlUDLQlTYXCXLKrEET4o9phDby2zDNpKN9iVoMLbnXGY7U67BcgN4uCBJjyhjr5PNuU61X1+TtsAhWXq/CpVAPEik2XEfDsLYrbq93boYpYVNkQHCKUy4xZE5IxMXn4ILJQhNSAy4p8Tdu2H1gDn7G8eIbCdzX0MCtMfxSVpysdX+WWi8YKXpv2UyLcynbOQ6Mm/BJHNTvcy90rnfFXTJFQ9vbtiafK9Rg+1ejC+5ffsPSd+9gJbDNq288q3Yp5XaUEjqRNW4wzPYXqeYHf+lS/58q1mXV1Q1th2pibyiQDcU7IE5SvNNVQJ2aXjvoW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:24.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a5435-9304-48ff-858b-08de9ac2d0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

On PREEMPT_RT kernels, vfree() can sleep because spin_lock is
converted to rt_mutex. dml2_destroy() calls vfree() while inside
an FPU-guarded region (preempt_count=2), which is illegal.

dml2_wrapper_fpu.c is compiled with CC_FLAGS_FPU which defines
_LINUX_FPU_COMPILATION_UNIT, making DC_RUN_WITH_PREEMPTION_ENABLED()
resolve to a no-op. This prevents the macro from cycling FPU
context off/on around vfree().

Move dml2_destroy() to dml2_wrapper.c (non-FPU compilation unit)
where DC_RUN_WITH_PREEMPTION_ENABLED() properly cycles DC_FP_END/
DC_FP_START around vfree(). This pairs it with dml2_allocate_memory()
which already lives there.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c  | 11 +++++++++++
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c  | 10 ----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 7398f8b69adb..8bed59e976d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -58,8 +58,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 
 void dml21_destroy(struct dml2_context *dml2)
 {
-	vfree(dml2->v21.dml_init.dml2_instance);
-	vfree(dml2->v21.mode_programming.programming);
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.dml_init.dml2_instance));
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.mode_programming.programming));
 }
 
 void dml21_copy(struct dml2_context *dst_dml_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index 93b7613fc4f2..1772e74349c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -108,6 +108,17 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	return true;
 }
 
+void dml2_destroy(struct dml2_context *dml2)
+{
+	if (!dml2)
+		return;
+
+	if (dml2->architecture == dml2_architecture_21)
+		dml21_destroy(dml2);
+
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2));
+}
+
 void dml2_reinit(const struct dc *in_dc,
 				 const struct dml2_configuration_options *config,
 				 struct dml2_context **dml2)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index 66624cfc27b1..a14e3004a7b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -548,16 +548,6 @@ void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
 	}
 }
 
-void dml2_destroy(struct dml2_context *dml2)
-{
-	if (!dml2)
-		return;
-
-	if (dml2->architecture == dml2_architecture_21)
-		dml21_destroy(dml2);
-	vfree(dml2);
-}
-
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
 	unsigned int *fclk_change_support, unsigned int *dram_clk_change_support)
 {
-- 
2.43.0

