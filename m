Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7005C7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1861E10E30E;
	Tue,  6 Jun 2023 09:17:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9538510E30E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeJWjjWa07GhALxQrWhe1/oliPCAjBTph6m1i7FAXP2YACzSQLZeCnRsU3MHhddpaYzU8Zuqpmi8DVFeA/DStCSryvKQPZwNF286rnaqbx8mEv5s75zPHuXyVT/uH2ktjxqHYu+urGHkkkWYBYl/44zcTAkzt68dHo2YsX0JhY7Ye0odHgu7oafcvvFnKMOUD+KD12hAxdDU4QGK6r2tWDstLReUgAqWIIQSJLotXHhE5seUAS1Yk4lfvQd402ixynMx9eRmsgYShBgFp+HEOrd8Oct3Do5X+eweexyPSYpG5DT4pG3LqRmvAfAUgBqsAa0RKqGkPGOds4teHAkkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO9A/2aDJUaec2BV4aSpVYwvvW1wFfgyb31fkBIbR44=;
 b=KlcH+ZQAN80h0GfAAMVpSCtCjN92ZenlXGI0DlAYQU7dR1ytFpizHgdP47E6cKYSdU7NHf5up462pGA6nr8gGCS+nHP9ggJ0dvNkMav4prQ3+eZC4yTiEdJpG+iyChWbrh6CcBPq20OKe0ekqW2oZztFbPGW2ZpwrVSGT6pLnt5cTSSJMEE6WZ8ejIUSOGaDBwl2vADu4AkqqOe17gjpxkmCQZhjEkvX7CUztu23cOJFqIO6gnLUoh7vuX9DUfw06eH9jsY41xdAlSVWpd93iD69lHs2G38+RzmvCOh/clGfQKt8q+tBtaxyT/u7SNN29a81Y45iJPSIQKvrCZKdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO9A/2aDJUaec2BV4aSpVYwvvW1wFfgyb31fkBIbR44=;
 b=fXkfrJFVFP+UrxtTH3pIkq5iJz+qIiJG2BQvdqaLm5sl1A3rfhkxYlcBN7zwzkQ5YY3wY6IkCJU2qgpPWFibcM5sqnZRETh+cenFKHhdy0tERLUSYir9SnpEiuisArOS1JPnsxY87BlwKpsPpOBNH1arrdEdliZKTFdwPW7rJ0I=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:54 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2d) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:53 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:52 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 09/17] gfx11: ignore wave status fields that were removed
Date: Tue, 6 Jun 2023 11:17:17 +0200
Message-ID: <20230606091725.20080-10-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e7ba15-0d7a-4923-34ab-08db666ee88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8fmvWbYbw4Twd0PDCEeSQwnyemWTjB6RIsrJ3PfDEieWu2f/ts7zO8ylopFMDFFnXKBIwQXdzBCHdH23K9/J1kntUHSNRF/5Mpnolz2sry3uBUeiTVFow5YfyFS8L/uch+a9PSpZcrvBDu1iP7AtZstOk7huJR3qi4NQzFOyDkfak4IGYwRfBup05SyYId7JxZ+SPfGToeNXjmyNF+kK/xL01SwGMjwIrteK73r7nowkJ/4zDUTukLUxHiDrWaMrxeeb5MvO0TgmdRoagr5q+nHC/W1Jl/yLqIaxcLAusQeduSHxY5yzSFi56bJWNEKQTCjrFBTGl1FX2uACNiy8lmhlxYipbUeqcip5i8cgF8qVmedi7kPRAdwJWcMhlYkj9b1Sl/F25PqJ2M7zH3pQIT1T++p90hoCneFxt3DpaPFt3xqqkfQ0H4nf1AsABJQoiYP3f62loqxzfMSC7aMKNnXIn/40iAgZZ+/AVVbYheWiOBT4jJd2jEiW5vn0HoQ4NnLtbmTW1wuLQPoQwdSQlRvXoe6ZdGa4YPbK4HInh68FzbH/D5coo7AaDmOz3thXkkC5ku4XMOJRK2fQev1sSffl8x+CuYjNfVtBNvlaV6f/B4z2s6wZCNRHbvfl8weOgh8tOm8xK9bNm+jdDDtIc+t4bVrzCsTV6WYD5TMGpncchRQghuk4YE2cvku9vDBRHAfUtBnFGM/o/AOmfzcpeTWnU4sE/o7igzrD2YVh1QfvlZWJCQkyEokZ0t+V5YeeQhX/CkbLZQp7aywDHIFdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(66574015)(47076005)(83380400001)(336012)(426003)(478600001)(82740400003)(110136005)(40480700001)(8676002)(8936002)(316002)(81166007)(4326008)(70586007)(356005)(70206006)(5660300002)(40460700003)(6636002)(41300700001)(86362001)(36756003)(6666004)(7696005)(2906002)(36860700001)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:53.5589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e7ba15-0d7a-4923-34ab-08db666ee88c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/scan_waves.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
index 37ebcff..ca1d9fb 100644
--- a/src/lib/scan_waves.c
+++ b/src/lib/scan_waves.c
@@ -451,77 +451,77 @@ static int umr_parse_wave_data_gfx_10_11(struct umr_asic *asic, struct umr_wave_
 		ws->hw_id2.vm_id        = umr_bitslice_reg(asic, reg, "VM_ID", value);
 		ws->hw_id2.compat_level = umr_bitslice_reg_quiet(asic, reg, "COMPAT_LEVEL", value); // not on 10.3
 
 	if (asic->family < FAMILY_GFX11)
 		ws->wave_inst_dw0 = buf[x++];
 
 	ws->gpr_alloc.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_GPR_ALLOC");
 		ws->gpr_alloc.vgpr_base = umr_bitslice_reg(asic, reg, "VGPR_BASE", value);
 		ws->gpr_alloc.vgpr_size = umr_bitslice_reg(asic, reg, "VGPR_SIZE", value);
-		ws->gpr_alloc.sgpr_base = umr_bitslice_reg(asic, reg, "SGPR_BASE", value);
-		ws->gpr_alloc.sgpr_size = umr_bitslice_reg(asic, reg, "SGPR_SIZE", value);
 
 	ws->lds_alloc.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_LDS_ALLOC");
 		ws->lds_alloc.lds_base = umr_bitslice_reg(asic, reg, "LDS_BASE", value);
 		ws->lds_alloc.lds_size = umr_bitslice_reg(asic, reg, "LDS_SIZE", value);
 		ws->lds_alloc.vgpr_shared_size = umr_bitslice_reg(asic, reg, "VGPR_SHARED_SIZE", value);
 
 	ws->trapsts.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_TRAPSTS");
 		ws->trapsts.excp          = umr_bitslice_reg(asic, reg, "EXCP", value) |
 								    (umr_bitslice_reg(asic, reg, "EXCP_HI", value) << 9);
 		ws->trapsts.savectx       = umr_bitslice_reg(asic, reg, "SAVECTX", value);
 		ws->trapsts.illegal_inst  = umr_bitslice_reg(asic, reg, "ILLEGAL_INST", value);
 		ws->trapsts.excp_hi       = umr_bitslice_reg(asic, reg, "EXCP_HI", value);
 		ws->trapsts.buffer_oob    = umr_bitslice_reg(asic, reg, "BUFFER_OOB", value);
-		ws->trapsts.excp_cycle    = umr_bitslice_reg(asic, reg, "EXCP_CYCLE", value);
+		ws->trapsts.excp_cycle    = umr_bitslice_reg_quiet(asic, reg, "EXCP_CYCLE", value);
 		ws->trapsts.excp_group_mask = umr_bitslice_reg_quiet(asic, reg, "EXCP_GROUP_MASK", value);
-		ws->trapsts.excp_wave64hi = umr_bitslice_reg(asic, reg, "EXCP_WAVE64HI", value);
+		ws->trapsts.excp_wave64hi = umr_bitslice_reg_quiet(asic, reg, "EXCP_WAVE64HI", value);
 		ws->trapsts.xnack_error   = umr_bitslice_reg_quiet(asic, reg, "XNACK_ERROR", value);
 		ws->trapsts.utc_error     = umr_bitslice_reg_quiet(asic, reg, "UTC_ERROR", value);
-		ws->trapsts.dp_rate       = umr_bitslice_reg(asic, reg, "DP_RATE", value);
+		ws->trapsts.dp_rate       = umr_bitslice_reg_quiet(asic, reg, "DP_RATE", value);
 
 	ws->ib_sts.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_IB_STS");
-		ws->ib_sts.vm_cnt   = umr_bitslice_reg(asic, reg, "VM_CNT", value) |
-							  (umr_bitslice_reg(asic, reg, "VM_CNT_HI", value) << 4);
+		ws->ib_sts.vm_cnt   = umr_bitslice_reg(asic, reg, "VM_CNT", value);
+		if (asic->family == FAMILY_NV)
+			ws->ib_sts.vm_cnt |= (umr_bitslice_reg(asic, reg, "VM_CNT_HI", value) << 4);
 		ws->ib_sts.exp_cnt  = umr_bitslice_reg(asic, reg, "EXP_CNT", value);
-		ws->ib_sts.lgkm_cnt = umr_bitslice_reg(asic, reg, "LGKM_CNT", value) |
-							  (umr_bitslice_reg(asic, reg, "LGKM_CNT_BIT4", value) << 4) |
-							  (umr_bitslice_reg(asic, reg, "LGKM_CNT_BIT5", value) << 5);
-		ws->ib_sts.valu_cnt = umr_bitslice_reg(asic, reg, "VALU_CNT", value);
+		ws->ib_sts.lgkm_cnt = umr_bitslice_reg(asic, reg, "LGKM_CNT", value);
+		if (asic->family == FAMILY_NV)
+			ws->ib_sts.lgkm_cnt |= (umr_bitslice_reg(asic, reg, "LGKM_CNT_BIT4", value) << 4) |
+								   (umr_bitslice_reg(asic, reg, "LGKM_CNT_BIT5", value) << 5);
+		ws->ib_sts.valu_cnt = umr_bitslice_reg_quiet(asic, reg, "VALU_CNT", value);
 		ws->ib_sts.replay_w64h = umr_bitslice_reg_quiet(asic, reg, "REPLAY_W64H", value);
 		ws->ib_sts.vs_cnt   = umr_bitslice_reg(asic, reg, "VS_CNT", value);
 
 	ws->ib_sts2.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_IB_STS2");
 		ws->ib_sts2.inst_prefetch     = umr_bitslice_reg(asic, reg, "INST_PREFETCH", value);
-		ws->ib_sts2.resource_override = umr_bitslice_reg(asic, reg, "RESOURCE_OVERRIDE", value);
+		ws->ib_sts2.resource_override = umr_bitslice_reg_quiet(asic, reg, "RESOURCE_OVERRIDE", value);
 		ws->ib_sts2.mem_order         = umr_bitslice_reg(asic, reg, "MEM_ORDER", value);
 		ws->ib_sts2.fwd_progress      = umr_bitslice_reg(asic, reg, "FWD_PROGRESS", value);
 		ws->ib_sts2.wave64            = umr_bitslice_reg(asic, reg, "WAVE64", value);
 		ws->ib_sts2.wave64hi          = umr_bitslice_reg_quiet(asic, reg, "WAVE64HI", value);
 		ws->ib_sts2.subv_loop         = umr_bitslice_reg_quiet(asic, reg, "SUBV_LOOP", value);
 
 	ws->ib_dbg1 = buf[x++];
 	ws->m0 = buf[x++];
 
 	ws->mode.value = value = buf[x++];
 		reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "ixSQ_WAVE_MODE");
 		ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
 		ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
 		ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
 		ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
 		ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
-		ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
+		ws->mode.debug_en = umr_bitslice_reg_quiet(asic, reg, "DEBUG_EN", value);
 		ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
 		ws->mode.fp16_ovfl = umr_bitslice_reg(asic, reg, "FP16_OVFL", value);
 		ws->mode.disable_perf = umr_bitslice_reg(asic, reg, "DISABLE_PERF", value);
 	return 0;
 }
 
 int umr_parse_wave_data_gfx(struct umr_asic *asic, struct umr_wave_status *ws, const uint32_t *buf)
 {
 	if (asic->family < FAMILY_AI)
 		return umr_parse_wave_data_gfx_8(asic, ws, buf);
-- 
2.40.0

