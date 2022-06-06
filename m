Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEFACCA473
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 21:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4D810F09E;
	Mon,  6 Jun 2022 21:04:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFA710F8A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 21:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL8drb1Fqemrra6Be9e+Tvwww9MTkDlzji55SkDfdZ8BAGYNUDXt4a7ZOmxBp4La2uUuoqh6vAAYrVXyFeUGAeK+ucf7oYvG7scKE//pWJGTsS4ip6tGHYMN/0UxyzDUkoo0dOP4xW3J45D9DDc56uAbKdNBN3BkvziZG0kvW3kmUYByl5k2uMTgYwP2JJIwyg26fbGvTwpVKz9QpTALXmdygtLWt2ihSRcwxvWJ3b9FfWqSarT9IYVsTzF/HopPtgUyF+/Ewnnyccgy8cAXpmqSqGdi89N3S3oocTu33kYx5DecqQSEzyamjwUnOnc9l7C7ULSkkABJr5fnwT5iKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4OQc8tgbBxfOKwQv2EB06NI7VjqAk/Rs/Fx0d7c/9I=;
 b=dXpxF5+iNnoZjTmHNv13FvuCc/oOMWCtaQODqCgeoI8yaeqj3wc0pgA5QVTbf5fnav1dh/PePt2+2OKhGAFvdU/j5BRImIPHodbSsZZWDAm1S/BSVwgUJKHeWsF6+yXcj0egqXzju0gVsQuccZ0GyOqN6T+9TS0rCaIWYkY6LTOnWAtk8xJb6tGYxofi/2nRdbDOnTjFPD6ofpObpLsC1MU5mOlsnRboAZWEYWAIyevCb44+rKOaNf2UttlOflOmMx30stOezUoTYN6Vy2mkXNZcGE2AqmeWpTwonLCLKq+CKxnFZfApYRTvHFEEYzO5PR3YWABRizpg9mPfcQ63+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4OQc8tgbBxfOKwQv2EB06NI7VjqAk/Rs/Fx0d7c/9I=;
 b=ANw4DPlZ3+pAYPjTi8g2tglVXMMhJG4vHTvK6XqsxL9ZDoAWGmh9m2i9v4O8E6dXnb+skk3731BOgQpKnDWuq+B/UM7uHHYMG8vHfrv8Xp1nnOCbvRMyiogEC6ltQFn/kxY+vqqp2DB/MToQ6CGjBJ9NQH+ol8Yp85uyWoR3HLM=
Received: from BN9PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:fb::11)
 by BN8PR12MB2851.namprd12.prod.outlook.com (2603:10b6:408:9f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 21:04:44 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::69) by BN9PR03CA0036.outlook.office365.com
 (2603:10b6:408:fb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14 via Frontend
 Transport; Mon, 6 Jun 2022 21:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 21:04:44 +0000
Received: from jgreatho-ryzen-vega20-01.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 16:04:43 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] umr: print MODE register as part of wave state
Date: Mon, 6 Jun 2022 16:04:32 -0500
Message-ID: <20220606210432.116508-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46582c55-a444-4a8c-2161-08da48002e7e
X-MS-TrafficTypeDiagnostic: BN8PR12MB2851:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2851D45DB28113F51DFEBE74F9A29@BN8PR12MB2851.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyFJ6tu1bUi6PUwBlwEM4bHmErR9F7z+2lwLcSQ+e4i0nKtXnAB7PKO9+azbfB8bq5Mw3rZdMmvDELNP+scPRwWqLNXkQAINsQRc3O1dQSwg5kOy6QI7LCWuUR6dn3U/STBcBbsZ2e6PeK1PauthrLDh2uAvZ1FY8x3PWdGiqIu8Z/wZGXHqmBPHqf1bW/neiPFR6DVcuEk+QfU6BniCfIYSUECakNKcOmQQGt/pc5C2noD13zSAa+EaVWZqov5jtAhrB0KP4IM+ZyVK91HWCKAsVlu3t5ef89RuXCLT7C5WVOaMPRl8b47fmyNdKSt8aG+t2e/10Fpj8fXZeXh1hwUBaZgK8E6mFfjLkGxK6PDBQeYjmBgAb73RVlQIi8nhNYz1Bl78N6RY2RMingEZr36KNojROFpJTNAnzFXimqZiLzKc/o7DJKZbE8sQxP1vcto21SLJWHjk/Skr1CNGmxY6RzjCbf2oJG4Ajjj0EoUUGG6GkB5bOEDtNrHHESsG3N89a3SZ70HkC5GvGBId95bW0Tu28Wju8u4o7y8M3E8XTYydovPHigOSYtWLxnbBdP2dRJ8MEs4bNduMqtY1aPFReKAziepqrZvUIX5uOZ9VFZCDAWjhX9Jqp7L8c8VsTKZK5sZbX8O+tlpjrnZlo0Se1wmaQ0d0mFLqFaGa3tB4IUU4flj40lTs+zdZJj0yqOYKkQNCP/MfStSoCwH/ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(508600001)(1076003)(8936002)(54906003)(4326008)(81166007)(5660300002)(7696005)(26005)(2616005)(6666004)(82310400005)(426003)(336012)(47076005)(6916009)(83380400001)(186003)(36860700001)(16526019)(316002)(2906002)(86362001)(70586007)(8676002)(70206006)(40460700003)(30864003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 21:04:44.2783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46582c55-a444-4a8c-2161-08da48002e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2851
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
Cc: Tom.StDenis@amd.com, Joseph Greathouse <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MODE register contains detailed per-wave information, but UMR
skipped printing it. This patch adds the ability to print each wave's
MODE register as part of the wave scan operation, and prints the MODE
register's sub-fields as part of the deeper print option.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/app/print_waves.c | 41 ++++++++++++++++++++++++++++++++++------
 src/lib/scan_waves.c  | 44 +++++++++++++++++++++++++++++++++++++++++++
 src/umr.h             | 19 +++++++++++++++++++
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/src/app/print_waves.c b/src/app/print_waves.c
index 07dae2d..daedc24 100644
--- a/src/app/print_waves.c
+++ b/src/app/print_waves.c
@@ -91,7 +91,7 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
 		if (!asic->options.bitfields && first) {
 			static const char* titles[] = {
 				"WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "INST_DW1", "EXEC_HI", "EXEC_LO", "HW_ID", "GPRALLOC",
-				"LDSALLOC", "TRAPSTS", "IBSTS", "TBA_HI", "TBA_LO", "TMA_HI", "TMA_LO", "IB_DBG0", "M0", NULL
+				"LDSALLOC", "TRAPSTS", "IBSTS", "TBA_HI", "TBA_LO", "TMA_HI", "TMA_LO", "IB_DBG0", "M0", "MODE", NULL
 			};
 			first = 0;
 			printf("SE SH CU SIMD WAVE# ");
@@ -106,13 +106,13 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
 "   %08lx %08lx %08lx " // wave_status pc/hi/lo
 "%08lx %08lx %08lx %08lx " // inst0/1 exec hi/lo
 "%08lx %08lx %08lx %08lx %08lx " // HW_ID GPR/LDSALLOC TRAP/IB STS
-"%08lx %08lx %08lx %08lx %08lx %08lx " // TBA_HI TBA_LO TMA_HI TMA_LO IB_DBG0 M0\n");
+"%08lx %08lx %08lx %08lx %08lx %08lx %08lx " // TBA_HI TBA_LO TMA_HI TMA_LO IB_DBG0 M0 MODE\n");
 "\n",
 (unsigned)wd->se, (unsigned)wd->sh, (unsigned)wd->cu, (unsigned)wd->ws.hw_id.simd_id, (unsigned)wd->ws.hw_id.wave_id,
 (unsigned long)wd->ws.wave_status.value, (unsigned long)wd->ws.pc_hi, (unsigned long)wd->ws.pc_lo,
 (unsigned long)wd->ws.wave_inst_dw0, (unsigned long)wd->ws.wave_inst_dw1, (unsigned long)wd->ws.exec_hi, (unsigned long)wd->ws.exec_lo,
 (unsigned long)wd->ws.hw_id.value, (unsigned long)wd->ws.gpr_alloc.value, (unsigned long)wd->ws.lds_alloc.value, (unsigned long)wd->ws.trapsts.value, (unsigned long)wd->ws.ib_sts.value,
-(unsigned long)wd->ws.tba_hi, (unsigned long)wd->ws.tba_lo, (unsigned long)wd->ws.tma_hi, (unsigned long)wd->ws.tma_lo, (unsigned long)wd->ws.ib_dbg0, (unsigned long)wd->ws.m0
+(unsigned long)wd->ws.tba_hi, (unsigned long)wd->ws.tba_lo, (unsigned long)wd->ws.tma_hi, (unsigned long)wd->ws.tma_lo, (unsigned long)wd->ws.ib_dbg0, (unsigned long)wd->ws.m0, (unsigned long)wd->ws.mode.value
 );
 			if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
 				for (x = 0; x < ((wd->ws.gpr_alloc.sgpr_size + 1) << shift); x += 4)
@@ -318,6 +318,24 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
 			PP(trapsts, excp_cycle);
 			PP(trapsts, dp_rate);
 
+			Hv("MODE", wd->ws.mode.value);
+			PP(mode, fp_round);
+			PP(mode, fp_denorm);
+			PP(mode, dx10_clamp);
+			PP(mode, ieee);
+			PP(mode, lod_clamped);
+			PP(mode, debug_en);
+			PP(mode, excp_en);
+			if (asic->family > FAMILY_VI)
+				PP(mode, fp16_ovfl);
+			PP(mode, pops_packer0);
+			PP(mode, pops_packer1);
+			if (asic->family > FAMILY_VI)
+				PP(mode, disable_perf);
+			PP(mode, gpr_idx_en);
+			PP(mode, vskip);
+			PP(mode, csp);
+
 			printf("\n"); col = 0;
 		}
 		wd = wd->next;
@@ -393,7 +411,7 @@ static void umr_print_waves_nv(struct umr_asic *asic)
 	while (wd) {
 		if (!asic->options.bitfields && first) {
 			static const char* titles[] = {
-				"WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "EXEC_HI", "EXEC_LO", "HW_ID1", "HW_ID2", "GPRALLOC", "LDSALLOC", "TRAPSTS", "IBSTS1", "IBSTS2", "IB_DBG1", "M0", NULL
+				"WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "EXEC_HI", "EXEC_LO", "HW_ID1", "HW_ID2", "GPRALLOC", "LDSALLOC", "TRAPSTS", "IBSTS1", "IBSTS2", "IB_DBG1", "M0", "MODE", NULL
 			};
 			first = 0;
 			printf("SE SA WGP SIMD WAVE# ");
@@ -408,13 +426,13 @@ static void umr_print_waves_nv(struct umr_asic *asic)
 "   %08lx %08lx %08lx " // wave_status pc/hi/lo
 "%08lx %08lx %08lx " // inst0 exec hi/lo
 "%08lx %08lx %08lx %08lx %08lx %08lx %08lx " // HW_ID1 HW_ID2 GPR/LDSALLOC TRAP/IB STS
-"%08lx %08lx " // IB_DBG1 M0\n");
+"%08lx %08lx %08lx " // IB_DBG1 M0 MODE\n");
 "\n",
 (unsigned)wd->se, (unsigned)wd->sh, (unsigned)wd->cu, (unsigned)wd->ws.hw_id1.simd_id, (unsigned)wd->ws.hw_id1.wave_id, // TODO: wgp printed out won't match geometry for now w.r.t. to SPI
 (unsigned long)wd->ws.wave_status.value, (unsigned long)wd->ws.pc_hi, (unsigned long)wd->ws.pc_lo,
 (unsigned long)wd->ws.wave_inst_dw0, (unsigned long)wd->ws.exec_hi, (unsigned long)wd->ws.exec_lo,
 (unsigned long)wd->ws.hw_id1.value, (unsigned long)wd->ws.hw_id2.value, (unsigned long)wd->ws.gpr_alloc.value, (unsigned long)wd->ws.lds_alloc.value, (unsigned long)wd->ws.trapsts.value,
-(unsigned long)wd->ws.ib_sts.value, (unsigned long)wd->ws.ib_sts2.value, (unsigned long)wd->ws.ib_dbg1, (unsigned long)wd->ws.m0);
+(unsigned long)wd->ws.ib_sts.value, (unsigned long)wd->ws.ib_sts2.value, (unsigned long)wd->ws.ib_dbg1, (unsigned long)wd->ws.m0, (unsigned long)wd->ws.mode.value);
 			if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
 				for (x = 0; x < 112; x += 4)
 					printf(">SGPRS[%u..%u] = { %08lx, %08lx, %08lx, %08lx }\n",
@@ -627,6 +645,17 @@ static void umr_print_waves_nv(struct umr_asic *asic)
 			PP(trapsts, excp_group_mask);
 			PP(trapsts, utc_error);
 
+			Hv("MODE", wd->ws.mode.value);
+			PP(mode, fp_round);
+			PP(mode, fp_denorm);
+			PP(mode, dx10_clamp);
+			PP(mode, ieee);
+			PP(mode, lod_clamped);
+			PP(mode, debug_en);
+			PP(mode, excp_en);
+			PP(mode, fp16_ovfl);
+			PP(mode, disable_perf);
+
 			printf("\n"); col = 0;
 		}
 		wd = wd->next;
diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
index dae858e..71e595f 100644
--- a/src/lib/scan_waves.c
+++ b/src/lib/scan_waves.c
@@ -139,6 +139,7 @@ int umr_read_wave_status_via_mmio_gfx8_9(struct umr_asic *asic, uint32_t simd, u
 	}
 	dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_DBG0")->addr);
 	dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_M0")->addr);
+	dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_MODE")->addr);
 
 	return 0;
 }
@@ -163,6 +164,7 @@ int umr_read_wave_status_via_mmio_gfx10(struct umr_asic *asic, uint32_t wave, ui
 	dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_STS2")->addr);
 	dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_DBG1")->addr);
 	dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_M0")->addr);
+	dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_MODE")->addr);
 
 	return 0;
 }
@@ -258,6 +260,19 @@ static int umr_parse_wave_data_gfx_8(struct umr_asic *asic, struct umr_wave_stat
 	ws->tma_hi = buf[x++];
 	ws->ib_dbg0 = buf[x++];
 	ws->m0 = buf[x++];
+
+	ws->mode.value = value = buf[x++];
+		reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
+		ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
+		ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
+		ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
+		ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
+		ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
+		ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
+		ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
+		ws->mode.gpr_idx_en = umr_bitslice_reg(asic, reg, "GPR_IDX_EN", value);
+		ws->mode.vskip = umr_bitslice_reg(asic, reg, "VSKIP", value);
+		ws->mode.csp = umr_bitslice_reg(asic, reg, "CSP", value);
 	return 0;
 }
 
@@ -348,6 +363,23 @@ static int umr_parse_wave_data_gfx_9(struct umr_asic *asic, struct umr_wave_stat
 
 	ws->ib_dbg0 = buf[x++];
 	ws->m0 = buf[x++];
+
+	ws->mode.value = value = buf[x++];
+		reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
+		ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
+		ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
+		ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
+		ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
+		ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
+		ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
+		ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
+		ws->mode.fp16_ovfl = umr_bitslice_reg(asic, reg, "FP16_OVFL", value);
+		ws->mode.pops_packer0 = umr_bitslice_reg(asic, reg, "POPS_PACKER0", value);
+		ws->mode.pops_packer1 = umr_bitslice_reg(asic, reg, "POPS_PACKER1", value);
+		ws->mode.disable_perf = umr_bitslice_reg(asic, reg, "DISABLE_PERF", value);
+		ws->mode.gpr_idx_en = umr_bitslice_reg(asic, reg, "GPR_IDX_EN", value);
+		ws->mode.vskip = umr_bitslice_reg(asic, reg, "VSKIP", value);
+		ws->mode.csp = umr_bitslice_reg(asic, reg, "CSP", value);
 	return 0;
 }
 
@@ -468,6 +500,18 @@ static int umr_parse_wave_data_gfx_10(struct umr_asic *asic, struct umr_wave_sta
 
 	ws->ib_dbg1 = buf[x++];
 	ws->m0 = buf[x++];
+
+	ws->mode.value = value = buf[x++];
+		reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
+		ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
+		ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
+		ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
+		ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
+		ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
+		ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
+		ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
+		ws->mode.fp16_ovfl = umr_bitslice_reg(asic, reg, "FP16_OVFL", value);
+		ws->mode.disable_perf = umr_bitslice_reg(asic, reg, "DISABLE_PERF", value);
 	return 0;
 }
 
diff --git a/src/umr.h b/src/umr.h
index ca62560..f541dd3 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -713,6 +713,25 @@ struct umr_wave_status {
 			excp_group_mask,
 			utc_error;
 	} trapsts;
+
+	struct {
+		uint32_t
+			value,
+			fp_round,
+			fp_denorm,
+			dx10_clamp,
+			ieee,
+			lod_clamped,
+			debug_en,
+			excp_en,
+			fp16_ovfl,
+			pops_packer0,
+			pops_packer1,
+			disable_perf,
+			gpr_idx_en,
+			vskip,
+			csp;
+	} mode;
 };
 
 struct umr_wave_data {
-- 
2.25.1

