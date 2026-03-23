Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3318D58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F6D10E3C3;
	Mon, 23 Mar 2026 04:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAo7WPgh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6A210E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9g7TAOaP3hnQHCCr51YpG8kvlUz9l5C4bFONF4Qq68yr5ff3DjPOyoP+DzcouPOEoy+xrKi8L7Q7BZrZxYXEputyP9w/0gVFYR9QY7RUUJAONypU6dMH1KRGE2tu5JyHiXwl+sUooYNU6F1T4x4q0mAVEToMuGv8Ewc495Kcx/euFED3ytP+SqUiNW285dve4OQKvYKP92WJ1emKYJF8qcxdm4GpIkuGmZApbQccwEnzRMNElbl0KxbWqDLoSDar6izQvDnE51ev0VAVcIKtgntE3UuKPpAa7PN0sXOtDTQ7+zKBjJ5CDJbaQ4c0lY+h7ABCtLcnnGPUFVUBrL9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NYkWmqSr1KGF+gj3fgqCYjgBe8rBsnCZULdYWhNscA=;
 b=w+3c/fuTNRsK48FALWen6lsmbevDm0/cF6Jm45zDGPuws8y6DqyRAon7jJmpofdKRg0a2xOlIK2bnKfMRRadjF1nuhJVMfRozryPszBuIAFmpDe1l5DqtIrHlPaQGeSjGkuxBC9xaWDYjd7EnA/r9nJA/5qoNQOKwGfAfVaIwULeP+ZSPDtphe6uqhIcR21kR0HZyKFiEG+HPahubfrsfCu1rGbaTNLAVpRqZiDbBc5RPJzC0pmI+R/YAEplfirTqxEXrkngEKD1qSGWRzU/JocaaOB74ZhJVmSTSm9cMk+dKBOWGEWhQzDhOcv6fwqqGJRonUrMZaiUiEYbJFbZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NYkWmqSr1KGF+gj3fgqCYjgBe8rBsnCZULdYWhNscA=;
 b=PAo7WPghargqV86+iH538hfXDxafsc/xRI/20qb3zNZKVFF0z+NqI5EPZiPu5ySF7b2kOvKY+l/YDxq29LLCr3jPcF7wKokI4tP+ZatZvkgih9cqr/ltI/Vz07BpbXyBhzLiNLY0AxSC9E/EZUv5UAHnuBzz0R7dpGEpcEk2NHc=
Received: from PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::14)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 04:54:38 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::ca) by PH5P222CA0009.outlook.office365.com
 (2603:10b6:510:34b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 04:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Mon, 23 Mar 2026 04:54:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 23:54:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amd/display: Add NULL check for integrated_info in
 clk_mgr_construct
Date: Mon, 23 Mar 2026 10:24:15 +0530
Message-ID: <20260323045415.2044583-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2ce930-ab68-468c-31ca-08de88984946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SaSPpJdFu5mCEbFh5tqlsIvKKLj71b5NULjK5T35f4U15abSvvDItDDPJW1QX5NtMwI9lS1h5zJshmd5To5XNEBpsOj0UBxWDUNzph4HNLSTMgklJghc+SfqTFI2gt5rHhXOdLfWpPz48q/DwCL8fjearJd5rd/zlr5YEP7h2C9EcGUcU79we8HKd2E5IWJwNRjWkyscOgsj/UFg2I+/C5luyWWEHJNlrHyfXPH7El1H/T9YgEQ+gvD1mZclZDNz6QZgqHNjdiLaEn1Bs6+8dvv7+PeQD4vlOBBrs+2skARCOI6q9sT7s2N3IxPCX+LHc5UHfqqBHPqjB5oee7bHS4eScgdI+9gByXG58ejiwLOUCz+LzESqBSMED3l/vuqmi2R5Q6InBtIZUGYeGoTCS/53RYiEDAblQD5irX5zy4BotgkgMf1T/j4QFh2oraPiYxQ+4neldg5Pq3nn6dNrT/VIDfoDX0IDqeBEErUmdIHGIR2T8y31IGqZRtZYUmPf30vFk9kxJj5oGR2WEgtpCbERruLIvm164wxudXpN2gztv0FkR8acOUYJt+wNZMET1PNFi2rSjg50hOWdL4wFJpccBi6SQt4M0oZaWiLO7UFKxAI0YEaFRVf1Rn5wJjDNZNXQ1sqt8EZ3dWu/4YXJRfxr9sb1NsJHvdyAGeT9LZQ3ANvt/bKSE8oFMQb0FH2vtNiXR180gIoegXTTs/GqmSIHlzKyT3EHDLLPA/wKd7GZ9TVa2cyRQicZYyxE51JZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gk2SkvK3zW8K6p+vvhPjxiwmEeQMmjWirTUXpsGAwwZqweluSngyvZFy2e9Zb9sBvAMD3bpqRrQJDOTEXISWO3LGuZK/01zVo0jY9+SVUZrynx+/ZmpL+l1BiyKaOusnxU0KfOnlc4dQAlUVyPxFEZbJIaIhRT2QtcdOKUp/W9AOq9DhXEcwGlldjBvMLdUuwlMJxdqwOPxVzImNS/34CABO23y2/HdQ98Hwfe5LdmVtC0DdMtdbbvJOBSObByKAc8aVStK9nMBjH+SkQg7RLPeMyD6hqZsXTxvBjY9YzmUkLVQrXXgTZGBsUP2NtpCH49XGwulwqfqmP2e7fH5SdMy3ocoeMKKwSLPyWssgzGqDBb+m/66SnLfhKnkQpKd+hY7f4oIX4+Hnfg4qXAZjE3+cwEvW3xhlpMJMtQuLivH2+q9OKDJhbzE39gGUsdJb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 04:54:37.8085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ce930-ab68-468c-31ca-08de88984946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

clk_mgr_construct() initializes display clock and memory bandwidth
settings during driver bring-up.

As part of this, the driver selects a watermark table based on the
memory type (DDR4, LPDDR4, LPDDR5) from ctx->dc_bios->integrated_info.

The display pipeline continuously reads pixel data from memory,
processes it (such as scaling, color conversion, and blending), and
sends it to the screen. To keep this pipeline running smoothly, the
driver must ensure there is enough memory bandwidth and that clocks are
increased when needed.

Watermark tables define when the GPU should increase clocks to ensure
there is enough bandwidth to feed pixel data without underflow.

However, ctx->dc_bios->integrated_info is dereferenced without checking
for NULL in multiple clk_mgr_construct() implementations. On some
platforms, BIOS may not provide this information, and accessing it
directly can cause a NULL pointer dereference during initialization.

Fix this by adding a NULL check before accessing integrated_info.

If integrated_info is not available, the driver safely falls back to
default watermark tables.

Fixes:
../dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)
../dcn301/vg_clk_mgr.c:750 vg_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 736)
../dcn31/dcn31_clk_mgr.c:789 dcn31_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 728)
../dcn314/dcn314_clk_mgr.c:906 dcn314_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 845)
../dcn315/dcn315_clk_mgr.c:716 dcn315_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 655)
../dcn316/dcn316_clk_mgr.c:660 dcn316_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 639)
../dcn35/dcn35_clk_mgr.c:1540 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 1467)

Fixes: 25879d7b4986 ("drm/amd/display: Clean FPGA code in dc")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I972e6837222f0181bc2c44ca1e31abaf8c64a088
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 3 ++-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 3 ++-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 ++++---
 7 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index e18097f82091..09e83097a623 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -740,7 +740,8 @@ void rn_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 3600000;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
 		if (clk_mgr->periodic_retraining_disabled) {
 			rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 7aee02d56292..57ba7bc4d16e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -733,11 +733,12 @@ void vg_clk_mgr_construct(
 	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		vg_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		vg_bw_params.wm_table = ddr4_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 051052bd10c9..44bf48f96183 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -725,11 +725,12 @@ void dcn31_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn31_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn31_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				 &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 0cb37827a62b..c69ec7a0e0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -842,7 +842,8 @@ void dcn314_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn314_bw_params.wm_table = lpddr5_wm_table;
 	else
 		dcn314_bw_params.wm_table = ddr5_wm_table;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index c49268db85f6..8d6949ad700d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -652,11 +652,12 @@ void dcn315_clk_mgr_construct(
 	if (clk_mgr->base.smu_ver > 0)
 		clk_mgr->base.smu_present = true;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn315_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn315_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 1769b1f26e75..b858e21ca070 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -636,11 +636,12 @@ void dcn316_clk_mgr_construct(
 		clk_mgr->base.base.dentist_vco_freq_khz = 2500000; /* 2400MHz */
 
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn316_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn316_bw_params.wm_table = ddr4_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn316_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 6fc524752613..2798088842f4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1464,11 +1464,12 @@ void dcn35_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn35_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn35_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn35_save_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-- 
2.34.1

