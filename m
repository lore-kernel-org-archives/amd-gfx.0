Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CCDC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DB08F344;
	Mon, 22 Aug 2022 14:00:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883A618A3F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO0Mq2+tAo5Qfcfpcf/iqJTa3dZxlT/SxELu3xXkkJxHtRmDTy6RpyUajmyDsohUS47SiLQ9J2dGvR3viZwTPI0UVde+DoB1rzO9GbtH1PGPY2klzJoTNrDOifloJfAZb9Aluo9hfhKJhHnN0dOux7w8lTL1HLcm57jQWWH9X0iZ4bypehXSjcHjc9p3MaqKBDN+RKj/w4Oub//NBE8kcYviAI6ydfn3hms0IaqigDHXXNHG6aHKGMV98Yy9DG41oST2Z+4/fwe7jA+ZmKN7CfP8K1HMtqzvByzRPDTDpxYZREEQQlmrL0PCS22ZD0TRZC5DNxb5fZIXbz+vDehCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTlPuzfgKM66NH9hrWrWtNt+e9WLyT8TElVtmI+xsY0=;
 b=EimDyw0zGmDElYDQvWVTwQJI5ZxzQYGWdZJmzVIitjed0fWP0L3bx7/cbZ+2X0tFQnmuRjnYRyxdi+np7bsVNOU+TIvij/CI2rUP9+peeFb8LEtGncKPEOwMJ3ev2LAPsseuMbT35k26RIEk5yDy9ZXt6FtoUWIACHO+0UvtaUAoi1SPwIHFLjJ04UuyHermSQVuuc6uuG/TP3OOTsANuH43YAx27wBkoICh+xM1lOr31lxgc0KrVXi9WsFq8tSNGvoavAGD8pTzkIpuZadyxShDNeKVJnvgFDWC4vNDCwiiTp8c34Hv2tfaYByECpECjj4kvjoXl3lScwgOaygVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTlPuzfgKM66NH9hrWrWtNt+e9WLyT8TElVtmI+xsY0=;
 b=VKliNaF2otlmPXVD76QdFIC4N06Tgei6s+6iN55UZH+P4fJTTQx6CBV/H8SqE8WwsLDhxTrb1H5QdZCF/tfl7p+gvFYnZ2KfONso2xiV6w6v/wt9pozymUjZcPpITSWfjg/1Ub2BlS+qDL8KK1z7VfoPCZW2TOTZpVyJpB4kaXs=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:59:38 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::89) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:59:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:59:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:59:27 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:59:18
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: change to runtime initialization for
 reg offsets for DCN321
Date: Mon, 22 Aug 2022 17:57:45 +0800
Message-ID: <20220822095752.3750614-8-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66bceb33-088c-4a3d-2ce5-08da84468dca
X-MS-TrafficTypeDiagnostic: BN8PR12MB2931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k/NILrkNYGKhYcAEeod/keKIlG/hUNO56rH9fNQi49NuFVuJsoNVXkjmGfogPpyBJZGY3mJG85olG9E/QCqoesff3qtu4w7+bNNRaKwQOQ0izc7AJQ++HNeDgURlLg2A3IVCQdUhVrcoKi6Mg6TemSbzxxS9AruxYC3oGNHwvorcGquV9WKN1S73vrn2CfAPuhDV2trwEVdBL6teWgJ9OLBfQxcOcHyaHH3XSNEQx1RFTnG/draAVhGotSpGeFBQ9ZG6t2YhNnMf2Lx+GZl53O6iu9HVR2k8z+GtaxiBPo3P2U6aYuUOfLc2GjNYiq9Aaxtb8sMC6wIS7qqpzkyTNNreVJMdV/cViUj7FR+E0Atl6aOc2zan36xL27oynYuUBUyDI64NbMDQ0h7I5FpMZ2eimVjT1K20ur2fWw33NF5mThLWiKiaxk72nRftbYViI2MVLPmTeVlOctBOWUZ4/fChifEHloue69yiMGvpSTcx4EGkJlh09pQad54vRRO5BIK/f/27Wgjc2hIXC8lb554eiN1gnFE7MgcxUxXJzWFhEdZz1naE9rC6OU8rqQj9z9u0Yegl3nTRs/R0PCf611QAQenWj4E9wMt+Ldakv4WhbYe4gfdwkMEXeSAeiTM5yS+9EoyfGzb2RbkKg3RoMWkcqZF4eGAX2QNmPM9D4SmYEBNnyehZAXkpG9YygTo8VwJDmxCUazSCgNTknumsez+JhoQnU33RxW6H9NQqSZWurnJe3JaZG3h9VY2zWaaFN/yrrZD8rqbAJGQApt/qF2/VS9vHTuv65BIpHnu6hXwOb8LGgnSm7mUHGdXr2zU/ypQCds2/6AlEn8JNGMmOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(40460700003)(356005)(82740400003)(81166007)(6916009)(316002)(54906003)(2906002)(8676002)(4326008)(70586007)(70206006)(30864003)(8936002)(5660300002)(47076005)(2616005)(426003)(336012)(186003)(1076003)(40480700001)(82310400005)(41300700001)(478600001)(83380400001)(26005)(7696005)(6666004)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:59:38.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bceb33-088c-4a3d-2ce5-08da84468dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

DC was using compile time initialization of register addresses using
SR_* macros and their variants. These have been converted to use runtime
initialization.

The REG_STRUCT macro is a definition that is added to SR_* macros.
During initialization, this must be defined before SR_* macros are
invoked, which are in turn invoked through various IP initialization macros.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn321/dcn321_resource.c   | 638 ++++++++++--------
 1 file changed, 346 insertions(+), 292 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index c8b7d6ff38f4..dbc674bb8e90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -138,78 +138,93 @@ enum dcn321_clk_src_array_id {
 /* DCN */
 /* TODO awful hack. fixup dcn20_dwb.h */
 #undef BASE_INNER
-#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
 #define BASE(seg) BASE_INNER(seg)
 
 #define SR(reg_name)\
-		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
-					reg ## reg_name
+	REG_STRUCT.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+		reg ## reg_name
+#define SR_ARR(reg_name, id)\
+	REG_STRUCT[id].reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+		reg ## reg_name
+#define SR_ARR_INIT(reg_name, id, value)\
+	REG_STRUCT[id].reg_name =  value
 
 #define SRI(reg_name, block, id)\
-	.reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## reg_name
+	REG_STRUCT.reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
+#define SRI_ARR(reg_name, block, id)\
+	REG_STRUCT[id].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
+#define SRI_ARR_ALPHABET(reg_name, block, index, id)\
+	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
 
 #define SRI2(reg_name, block, id)\
 	.reg_name = BASE(reg ## reg_name ## _BASE_IDX) + \
-					reg ## reg_name
+		reg ## reg_name
+#define SRI2_ARR(reg_name, block, id)\
+	REG_STRUCT[id].reg_name = BASE(reg ## reg_name ## _BASE_IDX) + \
+		reg ## reg_name
 
 #define SRIR(var_name, reg_name, block, id)\
 	.var_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## reg_name
+		reg ## block ## id ## _ ## reg_name
 
 #define SRII(reg_name, block, id)\
-	.reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## reg_name
+	REG_STRUCT.reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
+#define SRII_ARR_2(reg_name, block, id, inst)\
+	REG_STRUCT[inst].reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
 
 #define SRII_MPC_RMU(reg_name, block, id)\
 	.RMU##_##reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## reg_name
+		reg ## block ## id ## _ ## reg_name
 
 #define SRII_DWB(reg_name, temp_name, block, id)\
-	.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## temp_name
+	REG_STRUCT.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## temp_name
 
 #define DCCG_SRII(reg_name, block, id)\
-	.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					reg ## block ## id ## _ ## reg_name
+	REG_STRUCT.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
 
 #define VUPDATE_SRII(reg_name, block, id)\
-	.reg_name[id] = BASE(reg ## reg_name ## _ ## block ## id ## _BASE_IDX) + \
-					reg ## reg_name ## _ ## block ## id
+	REG_STRUCT.reg_name[id] = BASE(reg ## reg_name ## _ ## block ## id ## _BASE_IDX) + \
+		reg ## reg_name ## _ ## block ## id
 
 /* NBIO */
-#define NBIO_BASE_INNER(seg) \
-	NBIO_BASE__INST0_SEG ## seg
+#define NBIO_BASE_INNER(seg) ctx->nbio_reg_offsets[seg]
 
 #define NBIO_BASE(seg) \
 	NBIO_BASE_INNER(seg)
 
 #define NBIO_SR(reg_name)\
-		.reg_name = NBIO_BASE(regBIF_BX0_ ## reg_name ## _BASE_IDX) + \
-					regBIF_BX0_ ## reg_name
+	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX0_ ## reg_name ## _BASE_IDX) + \
+		regBIF_BX0_ ## reg_name
+#define NBIO_SR_ARR(reg_name, id)\
+	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX0_ ## reg_name ## _BASE_IDX) + \
+		regBIF_BX0_ ## reg_name
 
 #define CTX ctx
 #define REG(reg_name) \
-	(DCN_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
+	(ctx->dcn_reg_offsets[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
-static const struct bios_registers bios_regs = {
-		NBIO_SR(BIOS_SCRATCH_3),
+static struct bios_registers bios_regs;
+
+#define bios_regs_init() \
+		NBIO_SR(BIOS_SCRATCH_3),\
 		NBIO_SR(BIOS_SCRATCH_6)
-};
 
-#define clk_src_regs(index, pllid)\
-[index] = {\
-	CS_COMMON_REG_LIST_DCN3_0(index, pllid),\
-}
+#define clk_src_regs_init(index, pllid)\
+	CS_COMMON_REG_LIST_DCN3_0_RI(index, pllid)
 
-static const struct dce110_clk_src_regs clk_src_regs[] = {
-	clk_src_regs(0, A),
-	clk_src_regs(1, B),
-	clk_src_regs(2, C),
-	clk_src_regs(3, D),
-	clk_src_regs(4, E)
-};
+static struct dce110_clk_src_regs clk_src_regs[5];
 
 static const struct dce110_clk_src_shift cs_shift = {
 		CS_COMMON_MASK_SH_LIST_DCN3_2(__SHIFT)
@@ -219,17 +234,10 @@ static const struct dce110_clk_src_mask cs_mask = {
 		CS_COMMON_MASK_SH_LIST_DCN3_2(_MASK)
 };
 
-#define abm_regs(id)\
-[id] = {\
-		ABM_DCN32_REG_LIST(id)\
-}
+#define abm_regs_init(id)\
+		ABM_DCN32_REG_LIST_RI(id)
 
-static const struct dce_abm_registers abm_regs[] = {
-		abm_regs(0),
-		abm_regs(1),
-		abm_regs(2),
-		abm_regs(3),
-};
+static struct dce_abm_registers abm_regs[4];
 
 static const struct dce_abm_shift abm_shift = {
 		ABM_MASK_SH_LIST_DCN32(__SHIFT)
@@ -239,18 +247,10 @@ static const struct dce_abm_mask abm_mask = {
 		ABM_MASK_SH_LIST_DCN32(_MASK)
 };
 
-#define audio_regs(id)\
-[id] = {\
-		AUD_COMMON_REG_LIST(id)\
-}
+#define audio_regs_init(id)\
+		AUD_COMMON_REG_LIST_RI(id)
 
-static const struct dce_audio_registers audio_regs[] = {
-	audio_regs(0),
-	audio_regs(1),
-	audio_regs(2),
-	audio_regs(3),
-	audio_regs(4)
-};
+static struct dce_audio_registers audio_regs[5];
 
 #define DCE120_AUD_COMMON_MASK_SH_LIST(mask_sh)\
 		SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),\
@@ -265,23 +265,10 @@ static const struct dce_audio_mask audio_mask = {
 		DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
-#define vpg_regs(id)\
-[id] = {\
-	VPG_DCN3_REG_LIST(id)\
-}
+#define vpg_regs_init(id)\
+	VPG_DCN3_REG_LIST_RI(id)
 
-static const struct dcn30_vpg_registers vpg_regs[] = {
-	vpg_regs(0),
-	vpg_regs(1),
-	vpg_regs(2),
-	vpg_regs(3),
-	vpg_regs(4),
-	vpg_regs(5),
-	vpg_regs(6),
-	vpg_regs(7),
-	vpg_regs(8),
-	vpg_regs(9),
-};
+static struct dcn30_vpg_registers vpg_regs[10];
 
 static const struct dcn30_vpg_shift vpg_shift = {
 	DCN3_VPG_MASK_SH_LIST(__SHIFT)
@@ -291,19 +278,10 @@ static const struct dcn30_vpg_mask vpg_mask = {
 	DCN3_VPG_MASK_SH_LIST(_MASK)
 };
 
-#define afmt_regs(id)\
-[id] = {\
-	AFMT_DCN3_REG_LIST(id)\
-}
+#define afmt_regs_init(id)\
+	AFMT_DCN3_REG_LIST_RI(id)
 
-static const struct dcn30_afmt_registers afmt_regs[] = {
-	afmt_regs(0),
-	afmt_regs(1),
-	afmt_regs(2),
-	afmt_regs(3),
-	afmt_regs(4),
-	afmt_regs(5)
-};
+static struct dcn30_afmt_registers afmt_regs[6];
 
 static const struct dcn30_afmt_shift afmt_shift = {
 	DCN3_AFMT_MASK_SH_LIST(__SHIFT)
@@ -313,17 +291,10 @@ static const struct dcn30_afmt_mask afmt_mask = {
 	DCN3_AFMT_MASK_SH_LIST(_MASK)
 };
 
-#define apg_regs(id)\
-[id] = {\
-	APG_DCN31_REG_LIST(id)\
-}
+#define apg_regs_init(id)\
+	APG_DCN31_REG_LIST_RI(id)
 
-static const struct dcn31_apg_registers apg_regs[] = {
-	apg_regs(0),
-	apg_regs(1),
-	apg_regs(2),
-	apg_regs(3)
-};
+static struct dcn31_apg_registers apg_regs[4];
 
 static const struct dcn31_apg_shift apg_shift = {
 	DCN31_APG_MASK_SH_LIST(__SHIFT)
@@ -333,18 +304,10 @@ static const struct dcn31_apg_mask apg_mask = {
 		DCN31_APG_MASK_SH_LIST(_MASK)
 };
 
-#define stream_enc_regs(id)\
-[id] = {\
-	SE_DCN32_REG_LIST(id)\
-}
+#define stream_enc_regs_init(id)\
+	SE_DCN32_REG_LIST_RI(id)
 
-static const struct dcn10_stream_enc_registers stream_enc_regs[] = {
-	stream_enc_regs(0),
-	stream_enc_regs(1),
-	stream_enc_regs(2),
-	stream_enc_regs(3),
-	stream_enc_regs(4)
-};
+static struct dcn10_stream_enc_registers stream_enc_regs[5];
 
 static const struct dcn10_stream_encoder_shift se_shift = {
 		SE_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
@@ -355,46 +318,22 @@ static const struct dcn10_stream_encoder_mask se_mask = {
 };
 
 
-#define aux_regs(id)\
-[id] = {\
-	DCN2_AUX_REG_LIST(id)\
-}
+#define aux_regs_init(id)\
+	DCN2_AUX_REG_LIST_RI(id)
 
-static const struct dcn10_link_enc_aux_registers link_enc_aux_regs[] = {
-		aux_regs(0),
-		aux_regs(1),
-		aux_regs(2),
-		aux_regs(3),
-		aux_regs(4)
-};
+static struct dcn10_link_enc_aux_registers link_enc_aux_regs[5];
 
-#define hpd_regs(id)\
-[id] = {\
-	HPD_REG_LIST(id)\
-}
+#define hpd_regs_init(id)\
+	HPD_REG_LIST_RI(id)
 
-static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
-		hpd_regs(0),
-		hpd_regs(1),
-		hpd_regs(2),
-		hpd_regs(3),
-		hpd_regs(4)
-};
+static struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[5];
 
-#define link_regs(id, phyid)\
-[id] = {\
-	LE_DCN31_REG_LIST(id), \
-	UNIPHY_DCN2_REG_LIST(phyid), \
+#define link_regs_init(id, phyid)\
+	LE_DCN31_REG_LIST_RI(id), \
+	UNIPHY_DCN2_REG_LIST_RI(id, phyid)
 	/*DPCS_DCN31_REG_LIST(id),*/ \
-}
 
-static const struct dcn10_link_enc_registers link_enc_regs[] = {
-	link_regs(0, A),
-	link_regs(1, B),
-	link_regs(2, C),
-	link_regs(3, D),
-	link_regs(4, E)
-};
+static struct dcn10_link_enc_registers link_enc_regs[5];
 
 static const struct dcn10_link_enc_shift le_shift = {
 	LINK_ENCODER_MASK_SH_LIST_DCN31(__SHIFT), \
@@ -406,17 +345,10 @@ static const struct dcn10_link_enc_mask le_mask = {
 //	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
-#define hpo_dp_stream_encoder_reg_list(id)\
-[id] = {\
-	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST(id)\
-}
+#define hpo_dp_stream_encoder_reg_init(id)\
+	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
 
-static const struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[] = {
-	hpo_dp_stream_encoder_reg_list(0),
-	hpo_dp_stream_encoder_reg_list(1),
-	hpo_dp_stream_encoder_reg_list(2),
-	hpo_dp_stream_encoder_reg_list(3),
-};
+static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[4];
 
 static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift = {
 	DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)
@@ -427,20 +359,14 @@ static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask = {
 };
 
 
-#define hpo_dp_link_encoder_reg_list(id)\
-[id] = {\
-	DCN3_1_HPO_DP_LINK_ENC_REG_LIST(id),\
-	/*DCN3_1_RDPCSTX_REG_LIST(0),*/\
-	/*DCN3_1_RDPCSTX_REG_LIST(1),*/\
-	/*DCN3_1_RDPCSTX_REG_LIST(2),*/\
-	/*DCN3_1_RDPCSTX_REG_LIST(3),*/\
-	/*DCN3_1_RDPCSTX_REG_LIST(4)*/\
-}
+#define hpo_dp_link_encoder_reg_init(id)\
+	DCN3_1_HPO_DP_LINK_ENC_REG_LIST_RI(id)
+	/*DCN3_1_RDPCSTX_REG_LIST(0),*/
+	/*DCN3_1_RDPCSTX_REG_LIST(1),*/
+	/*DCN3_1_RDPCSTX_REG_LIST(2),*/
+	/*DCN3_1_RDPCSTX_REG_LIST(3),*/
 
-static const struct dcn31_hpo_dp_link_encoder_registers hpo_dp_link_enc_regs[] = {
-	hpo_dp_link_encoder_reg_list(0),
-	hpo_dp_link_encoder_reg_list(1),
-};
+static struct dcn31_hpo_dp_link_encoder_registers hpo_dp_link_enc_regs[2];
 
 static const struct dcn31_hpo_dp_link_encoder_shift hpo_dp_le_shift = {
 	DCN3_2_HPO_DP_LINK_ENC_MASK_SH_LIST(__SHIFT)
@@ -450,17 +376,10 @@ static const struct dcn31_hpo_dp_link_encoder_mask hpo_dp_le_mask = {
 	DCN3_2_HPO_DP_LINK_ENC_MASK_SH_LIST(_MASK)
 };
 
-#define dpp_regs(id)\
-[id] = {\
-	DPP_REG_LIST_DCN30_COMMON(id),\
-}
+#define dpp_regs_init(id)\
+	DPP_REG_LIST_DCN30_COMMON_RI(id)
 
-static const struct dcn3_dpp_registers dpp_regs[] = {
-	dpp_regs(0),
-	dpp_regs(1),
-	dpp_regs(2),
-	dpp_regs(3)
-};
+static struct dcn3_dpp_registers dpp_regs[4];
 
 static const struct dcn3_dpp_shift tf_shift = {
 		DPP_REG_LIST_SH_MASK_DCN30_COMMON(__SHIFT)
@@ -471,17 +390,10 @@ static const struct dcn3_dpp_mask tf_mask = {
 };
 
 
-#define opp_regs(id)\
-[id] = {\
-	OPP_REG_LIST_DCN30(id),\
-}
+#define opp_regs_init(id)\
+	OPP_REG_LIST_DCN30_RI(id)
 
-static const struct dcn20_opp_registers opp_regs[] = {
-	opp_regs(0),
-	opp_regs(1),
-	opp_regs(2),
-	opp_regs(3)
-};
+static struct dcn20_opp_registers opp_regs[4];
 
 static const struct dcn20_opp_shift opp_shift = {
 	OPP_MASK_SH_LIST_DCN20(__SHIFT)
@@ -491,21 +403,13 @@ static const struct dcn20_opp_mask opp_mask = {
 	OPP_MASK_SH_LIST_DCN20(_MASK)
 };
 
-#define aux_engine_regs(id)\
-[id] = {\
-	AUX_COMMON_REG_LIST0(id), \
-	.AUXN_IMPCAL = 0, \
-	.AUXP_IMPCAL = 0, \
-	.AUX_RESET_MASK = DP_AUX0_AUX_CONTROL__AUX_RESET_MASK, \
-}
+#define aux_engine_regs_init(id) \
+	AUX_COMMON_REG_LIST0_RI(id), SR_ARR_INIT(AUXN_IMPCAL, id, 0), \
+	SR_ARR_INIT(AUXP_IMPCAL, id, 0), \
+	SR_ARR_INIT(AUX_RESET_MASK, id, DP_AUX0_AUX_CONTROL__AUX_RESET_MASK), \
+	SR_ARR_INIT(AUX_RESET_MASK, id, DP_AUX0_AUX_CONTROL__AUX_RESET_MASK)
 
-static const struct dce110_aux_registers aux_engine_regs[] = {
-		aux_engine_regs(0),
-		aux_engine_regs(1),
-		aux_engine_regs(2),
-		aux_engine_regs(3),
-		aux_engine_regs(4)
-};
+static struct dce110_aux_registers aux_engine_regs[5];
 
 static const struct dce110_aux_registers_shift aux_shift = {
 	DCN_AUX_MASK_SH_LIST(__SHIFT)
@@ -515,15 +419,10 @@ static const struct dce110_aux_registers_mask aux_mask = {
 	DCN_AUX_MASK_SH_LIST(_MASK)
 };
 
+#define dwbc_regs_dcn3_init(id)\
+	DWBC_COMMON_REG_LIST_DCN30_RI(id)
 
-#define dwbc_regs_dcn3(id)\
-[id] = {\
-	DWBC_COMMON_REG_LIST_DCN30(id),\
-}
-
-static const struct dcn30_dwbc_registers dwbc30_regs[] = {
-	dwbc_regs_dcn3(0),
-};
+static struct dcn30_dwbc_registers dwbc30_regs[1];
 
 static const struct dcn30_dwbc_shift dwbc30_shift = {
 	DWBC_COMMON_MASK_SH_LIST_DCN30(__SHIFT)
@@ -533,14 +432,10 @@ static const struct dcn30_dwbc_mask dwbc30_mask = {
 	DWBC_COMMON_MASK_SH_LIST_DCN30(_MASK)
 };
 
-#define mcif_wb_regs_dcn3(id)\
-[id] = {\
-	MCIF_WB_COMMON_REG_LIST_DCN32(id),\
-}
+#define mcif_wb_regs_dcn3_init(id)\
+	MCIF_WB_COMMON_REG_LIST_DCN32_RI(id)
 
-static const struct dcn30_mmhubbub_registers mcif_wb30_regs[] = {
-	mcif_wb_regs_dcn3(0)
-};
+static struct dcn30_mmhubbub_registers mcif_wb30_regs[1];
 
 static const struct dcn30_mmhubbub_shift mcif_wb30_shift = {
 	MCIF_WB_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
@@ -550,17 +445,10 @@ static const struct dcn30_mmhubbub_mask mcif_wb30_mask = {
 	MCIF_WB_COMMON_MASK_SH_LIST_DCN32(_MASK)
 };
 
-#define dsc_regsDCN20(id)\
-[id] = {\
-	DSC_REG_LIST_DCN20(id)\
-}
+#define dsc_regsDCN20_init(id)\
+	DSC_REG_LIST_DCN20_RI(id)
 
-static const struct dcn20_dsc_registers dsc_regs[] = {
-	dsc_regsDCN20(0),
-	dsc_regsDCN20(1),
-	dsc_regsDCN20(2),
-	dsc_regsDCN20(3)
-};
+static struct dcn20_dsc_registers dsc_regs[4];
 
 static const struct dcn20_dsc_shift dsc_shift = {
 	DSC_REG_LIST_SH_MASK_DCN20(__SHIFT)
@@ -570,17 +458,21 @@ static const struct dcn20_dsc_mask dsc_mask = {
 	DSC_REG_LIST_SH_MASK_DCN20(_MASK)
 };
 
-static const struct dcn30_mpc_registers mpc_regs = {
-		MPC_REG_LIST_DCN3_2(0),
-		MPC_REG_LIST_DCN3_2(1),
-		MPC_REG_LIST_DCN3_2(2),
-		MPC_REG_LIST_DCN3_2(3),
-		MPC_OUT_MUX_REG_LIST_DCN3_0(0),
-		MPC_OUT_MUX_REG_LIST_DCN3_0(1),
-		MPC_OUT_MUX_REG_LIST_DCN3_0(2),
-		MPC_OUT_MUX_REG_LIST_DCN3_0(3),
-		MPC_DWB_MUX_REG_LIST_DCN3_0(0),
-};
+static struct dcn30_mpc_registers mpc_regs;
+#define dcn_mpc_regs_init()\
+		MPC_REG_LIST_DCN3_0_RI(0),\
+		MPC_REG_LIST_DCN3_0_RI(1),\
+		MPC_REG_LIST_DCN3_0_RI(2),\
+		MPC_REG_LIST_DCN3_0_RI(3),\
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
+		MPC_MCM_REG_LIST_DCN32_RI(0),\
+		MPC_MCM_REG_LIST_DCN32_RI(1),\
+		MPC_MCM_REG_LIST_DCN32_RI(2),\
+		MPC_MCM_REG_LIST_DCN32_RI(3),\
+		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
 
 static const struct dcn30_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
@@ -590,15 +482,10 @@ static const struct dcn30_mpc_mask mpc_mask = {
 	MPC_COMMON_MASK_SH_LIST_DCN32(_MASK)
 };
 
-#define optc_regs(id)\
-[id] = {OPTC_COMMON_REG_LIST_DCN3_2(id)}
+#define optc_regs_init(id)\
+	OPTC_COMMON_REG_LIST_DCN3_2_RI(id)
 
-static const struct dcn_optc_registers optc_regs[] = {
-	optc_regs(0),
-	optc_regs(1),
-	optc_regs(2),
-	optc_regs(3)
-};
+static struct dcn_optc_registers optc_regs[4];
 
 static const struct dcn_optc_shift optc_shift = {
 	OPTC_COMMON_MASK_SH_LIST_DCN3_2(__SHIFT)
@@ -608,18 +495,10 @@ static const struct dcn_optc_mask optc_mask = {
 	OPTC_COMMON_MASK_SH_LIST_DCN3_2(_MASK)
 };
 
-#define hubp_regs(id)\
-[id] = {\
-	HUBP_REG_LIST_DCN32(id)\
-}
-
-static const struct dcn_hubp2_registers hubp_regs[] = {
-		hubp_regs(0),
-		hubp_regs(1),
-		hubp_regs(2),
-		hubp_regs(3)
-};
+#define hubp_regs_init(id) \
+	HUBP_REG_LIST_DCN32_RI(id)
 
+static struct dcn_hubp2_registers hubp_regs[4];
 
 static const struct dcn_hubp2_shift hubp_shift = {
 		HUBP_MASK_SH_LIST_DCN32(__SHIFT)
@@ -628,9 +507,10 @@ static const struct dcn_hubp2_shift hubp_shift = {
 static const struct dcn_hubp2_mask hubp_mask = {
 		HUBP_MASK_SH_LIST_DCN32(_MASK)
 };
-static const struct dcn_hubbub_registers hubbub_reg = {
-		HUBBUB_REG_LIST_DCN32(0)
-};
+
+static struct dcn_hubbub_registers hubbub_reg;
+#define hubbub_reg_init()\
+		HUBBUB_REG_LIST_DCN32_RI(0)
 
 static const struct dcn_hubbub_shift hubbub_shift = {
 		HUBBUB_MASK_SH_LIST_DCN32(__SHIFT)
@@ -640,9 +520,10 @@ static const struct dcn_hubbub_mask hubbub_mask = {
 		HUBBUB_MASK_SH_LIST_DCN32(_MASK)
 };
 
-static const struct dccg_registers dccg_regs = {
-		DCCG_REG_LIST_DCN32()
-};
+static struct dccg_registers dccg_regs;
+
+#define dccg_regs_init()\
+	DCCG_REG_LIST_DCN32_RI()
 
 static const struct dccg_shift dccg_shift = {
 		DCCG_MASK_SH_LIST_DCN32(__SHIFT)
@@ -715,9 +596,10 @@ static const struct dccg_mask dccg_mask = {
 	SR(AZALIA_AUDIO_DTO), \
 	SR(AZALIA_CONTROLLER_CLOCK_GATING)
 
-static const struct dce_hwseq_registers hwseq_reg = {
-		HWSEQ_DCN32_REG_LIST()
-};
+static struct dce_hwseq_registers hwseq_reg;
+
+#define hwseq_reg_init()\
+	HWSEQ_DCN32_REG_LIST()
 
 #define HWSEQ_DCN32_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
@@ -760,29 +642,10 @@ static const struct dce_hwseq_shift hwseq_shift = {
 static const struct dce_hwseq_mask hwseq_mask = {
 		HWSEQ_DCN32_MASK_SH_LIST(_MASK)
 };
-#define vmid_regs(id)\
-[id] = {\
-		DCN20_VMID_REG_LIST(id)\
-}
+#define vmid_regs_init(id)\
+		DCN20_VMID_REG_LIST_RI(id)
 
-static const struct dcn_vmid_registers vmid_regs[] = {
-	vmid_regs(0),
-	vmid_regs(1),
-	vmid_regs(2),
-	vmid_regs(3),
-	vmid_regs(4),
-	vmid_regs(5),
-	vmid_regs(6),
-	vmid_regs(7),
-	vmid_regs(8),
-	vmid_regs(9),
-	vmid_regs(10),
-	vmid_regs(11),
-	vmid_regs(12),
-	vmid_regs(13),
-	vmid_regs(14),
-	vmid_regs(15)
-};
+static struct dcn_vmid_registers vmid_regs[16];
 
 static const struct dcn20_vmid_shift vmid_shifts = {
 		DCN20_VMID_MASK_SH_LIST(__SHIFT)
@@ -905,6 +768,14 @@ static struct dce_aux *dcn321_aux_engine_create(
 	if (!aux_engine)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT aux_engine_regs
+	aux_engine_regs_init(0),
+	aux_engine_regs_init(1),
+	aux_engine_regs_init(2),
+	aux_engine_regs_init(3),
+	aux_engine_regs_init(4);
+
 	dce110_aux_engine_construct(aux_engine, ctx, inst,
 				    SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,
 				    &aux_engine_regs[inst],
@@ -914,15 +785,10 @@ static struct dce_aux *dcn321_aux_engine_create(
 
 	return &aux_engine->base;
 }
-#define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST_DCN30(id) }
-
-static const struct dce_i2c_registers i2c_hw_regs[] = {
-		i2c_inst_regs(1),
-		i2c_inst_regs(2),
-		i2c_inst_regs(3),
-		i2c_inst_regs(4),
-		i2c_inst_regs(5),
-};
+#define i2c_inst_regs_init(id)\
+	I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)
+
+static struct dce_i2c_registers i2c_hw_regs[6];
 
 static const struct dce_i2c_shift i2c_shifts = {
 		I2C_COMMON_MASK_SH_LIST_DCN30(__SHIFT)
@@ -942,6 +808,14 @@ static struct dce_i2c_hw *dcn321_i2c_hw_create(
 	if (!dce_i2c_hw)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT i2c_hw_regs
+		i2c_inst_regs_init(1),
+		i2c_inst_regs_init(2),
+		i2c_inst_regs_init(3),
+		i2c_inst_regs_init(4),
+		i2c_inst_regs_init(5);
+
 	dcn2_i2c_hw_construct(dce_i2c_hw, ctx, inst,
 				    &i2c_hw_regs[inst], &i2c_shifts, &i2c_masks);
 
@@ -981,6 +855,29 @@ static struct hubbub *dcn321_hubbub_create(struct dc_context *ctx)
 	if (!hubbub2)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT hubbub_reg
+	hubbub_reg_init();
+
+#undef REG_STRUCT
+#define REG_STRUCT vmid_regs
+	vmid_regs_init(0),
+	vmid_regs_init(1),
+	vmid_regs_init(2),
+	vmid_regs_init(3),
+	vmid_regs_init(4),
+	vmid_regs_init(5),
+	vmid_regs_init(6),
+	vmid_regs_init(7),
+	vmid_regs_init(8),
+	vmid_regs_init(9),
+	vmid_regs_init(10),
+	vmid_regs_init(11),
+	vmid_regs_init(12),
+	vmid_regs_init(13),
+	vmid_regs_init(14),
+	vmid_regs_init(15);
+
 	hubbub32_construct(hubbub2, ctx,
 			&hubbub_reg,
 			&hubbub_shift,
@@ -1013,6 +910,13 @@ static struct hubp *dcn321_hubp_create(
 	if (!hubp2)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT hubp_regs
+		hubp_regs_init(0),
+		hubp_regs_init(1),
+		hubp_regs_init(2),
+		hubp_regs_init(3);
+
 	if (hubp32_construct(hubp2, ctx, inst,
 			&hubp_regs[inst], &hubp_shift, &hubp_mask))
 		return &hubp2->base;
@@ -1038,6 +942,13 @@ static struct dpp *dcn321_dpp_create(
 	if (!dpp3)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT dpp_regs
+	dpp_regs_init(0),
+	dpp_regs_init(1),
+	dpp_regs_init(2),
+	dpp_regs_init(3);
+
 	if (dpp32_construct(dpp3, ctx, inst,
 			&dpp_regs[inst], &tf_shift, &tf_mask))
 		return &dpp3->base;
@@ -1058,6 +969,10 @@ static struct mpc *dcn321_mpc_create(
 	if (!mpc30)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT mpc_regs
+	dcn_mpc_regs_init();
+
 	dcn32_mpc_construct(mpc30, ctx,
 			&mpc_regs,
 			&mpc_shift,
@@ -1079,6 +994,13 @@ static struct output_pixel_processor *dcn321_opp_create(
 		return NULL;
 	}
 
+#undef REG_STRUCT
+#define REG_STRUCT opp_regs
+	opp_regs_init(0),
+	opp_regs_init(1),
+	opp_regs_init(2),
+	opp_regs_init(3);
+
 	dcn20_opp_construct(opp2, ctx, inst,
 			&opp_regs[inst], &opp_shift, &opp_mask);
 	return &opp2->base;
@@ -1095,6 +1017,13 @@ static struct timing_generator *dcn321_timing_generator_create(
 	if (!tgn10)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT optc_regs
+	optc_regs_init(0),
+	optc_regs_init(1),
+	optc_regs_init(2),
+	optc_regs_init(3);
+
 	tgn10->base.inst = instance;
 	tgn10->base.ctx = ctx;
 
@@ -1129,6 +1058,30 @@ static struct link_encoder *dcn321_link_encoder_create(
 	if (!enc20)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_aux_regs
+	aux_regs_init(0),
+	aux_regs_init(1),
+	aux_regs_init(2),
+	aux_regs_init(3),
+	aux_regs_init(4);
+
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_hpd_regs
+	hpd_regs_init(0),
+	hpd_regs_init(1),
+	hpd_regs_init(2),
+	hpd_regs_init(3),
+	hpd_regs_init(4);
+
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_regs
+	link_regs_init(0, A),
+	link_regs_init(1, B),
+	link_regs_init(2, C),
+	link_regs_init(3, D),
+	link_regs_init(4, E);
+
 	dcn321_link_encoder_construct(enc20,
 			enc_init_data,
 			&link_enc_feature,
@@ -1145,7 +1098,7 @@ static void read_dce_straps(
 	struct dc_context *ctx,
 	struct resource_straps *straps)
 {
-	generic_reg_get(ctx, regDC_PINSTRAPS + BASE(regDC_PINSTRAPS_BASE_IDX),
+	generic_reg_get(ctx, ctx->dcn_reg_offsets[regDC_PINSTRAPS_BASE_IDX] + regDC_PINSTRAPS,
 		FN(DC_PINSTRAPS, DC_PINSTRAPS_AUDIO), &straps->dc_pinstraps_audio);
 
 }
@@ -1153,6 +1106,15 @@ static void read_dce_straps(
 static struct audio *dcn321_create_audio(
 		struct dc_context *ctx, unsigned int inst)
 {
+
+#undef REG_STRUCT
+#define REG_STRUCT audio_regs
+	audio_regs_init(0),
+	audio_regs_init(1),
+	audio_regs_init(2),
+	audio_regs_init(3),
+	audio_regs_init(4);
+
 	return dce_audio_create(ctx, inst,
 			&audio_regs[inst], &audio_shift, &audio_mask);
 }
@@ -1166,6 +1128,19 @@ static struct vpg *dcn321_vpg_create(
 	if (!vpg3)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT vpg_regs
+	vpg_regs_init(0),
+	vpg_regs_init(1),
+	vpg_regs_init(2),
+	vpg_regs_init(3),
+	vpg_regs_init(4),
+	vpg_regs_init(5),
+	vpg_regs_init(6),
+	vpg_regs_init(7),
+	vpg_regs_init(8),
+	vpg_regs_init(9);
+
 	vpg3_construct(vpg3, ctx, inst,
 			&vpg_regs[inst],
 			&vpg_shift,
@@ -1183,6 +1158,15 @@ static struct afmt *dcn321_afmt_create(
 	if (!afmt3)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT afmt_regs
+	afmt_regs_init(0),
+	afmt_regs_init(1),
+	afmt_regs_init(2),
+	afmt_regs_init(3),
+	afmt_regs_init(4),
+	afmt_regs_init(5);
+
 	afmt3_construct(afmt3, ctx, inst,
 			&afmt_regs[inst],
 			&afmt_shift,
@@ -1200,6 +1184,13 @@ static struct apg *dcn321_apg_create(
 	if (!apg31)
 		return NULL;
 
+#undef REG_STRUCT
+#define REG_STRUCT apg_regs
+	apg_regs_init(0),
+	apg_regs_init(1),
+	apg_regs_init(2),
+	apg_regs_init(3);
+
 	apg31_construct(apg31, ctx, inst,
 			&apg_regs[inst],
 			&apg_shift,
@@ -1236,6 +1227,14 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 		return NULL;
 	}
 
+#undef REG_STRUCT
+#define REG_STRUCT stream_enc_regs
+	stream_enc_regs_init(0),
+	stream_enc_regs_init(1),
+	stream_enc_regs_init(2),
+	stream_enc_regs_init(3),
+	stream_enc_regs_init(4);
+
 	dcn32_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
 					&stream_enc_regs[eng_id],
@@ -1286,6 +1285,13 @@ static struct hpo_dp_stream_encoder *dcn321_hpo_dp_stream_encoder_create(
 		return NULL;
 	}
 
+#undef REG_STRUCT
+#define REG_STRUCT hpo_dp_stream_enc_regs
+	hpo_dp_stream_encoder_reg_init(0),
+	hpo_dp_stream_encoder_reg_init(1),
+	hpo_dp_stream_encoder_reg_init(2),
+	hpo_dp_stream_encoder_reg_init(3);
+
 	dcn31_hpo_dp_stream_encoder_construct(hpo_dp_enc31, ctx, ctx->dc_bios,
 					hpo_dp_inst, eng_id, vpg, apg,
 					&hpo_dp_stream_enc_regs[hpo_dp_inst],
@@ -1303,6 +1309,11 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
 
+#undef REG_STRUCT
+#define REG_STRUCT hpo_dp_link_enc_regs
+	hpo_dp_link_encoder_reg_init(0),
+	hpo_dp_link_encoder_reg_init(1);
+
 	hpo_dp_link_encoder32_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
 					&hpo_dp_le_shift, &hpo_dp_le_mask);
@@ -1315,6 +1326,10 @@ static struct dce_hwseq *dcn321_hwseq_create(
 {
 	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
 
+#undef REG_STRUCT
+#define REG_STRUCT hwseq_reg
+	hwseq_reg_init();
+
 	if (hws) {
 		hws->ctx = ctx;
 		hws->regs = &hwseq_reg;
@@ -1505,6 +1520,10 @@ static bool dcn321_dwbc_create(struct dc_context *ctx, struct resource_pool *poo
 			return false;
 		}
 
+#undef REG_STRUCT
+#define REG_STRUCT dwbc30_regs
+		dwbc_regs_dcn3_init(0);
+
 		dcn30_dwbc_construct(dwbc30, ctx,
 				&dwbc30_regs[i],
 				&dwbc30_shift,
@@ -1530,6 +1549,10 @@ static bool dcn321_mmhubbub_create(struct dc_context *ctx, struct resource_pool
 			return false;
 		}
 
+#undef REG_STRUCT
+#define REG_STRUCT mcif_wb30_regs
+		mcif_wb_regs_dcn3_init(0);
+
 		dcn32_mmhubbub_construct(mcif_wb30, ctx,
 				&mcif_wb30_regs[i],
 				&mcif_wb30_shift,
@@ -1552,6 +1575,13 @@ static struct display_stream_compressor *dcn321_dsc_create(
 		return NULL;
 	}
 
+#undef REG_STRUCT
+#define REG_STRUCT dsc_regs
+	dsc_regsDCN20_init(0),
+	dsc_regsDCN20_init(1),
+	dsc_regsDCN20_init(2),
+	dsc_regsDCN20_init(3);
+
 	dsc2_construct(dsc, ctx, inst, &dsc_regs[inst], &dsc_shift, &dsc_mask);
 
 	dsc->max_image_width = 6016;
@@ -1616,6 +1646,30 @@ static bool dcn321_resource_construct(
 	uint32_t pipe_fuses = 0;
 	uint32_t num_pipes  = 4;
 
+#undef REG_STRUCT
+#define REG_STRUCT bios_regs
+	bios_regs_init();
+
+#undef REG_STRUCT
+#define REG_STRUCT clk_src_regs
+	clk_src_regs_init(0, A),
+	clk_src_regs_init(1, B),
+	clk_src_regs_init(2, C),
+	clk_src_regs_init(3, D),
+	clk_src_regs_init(4, E);
+
+#undef REG_STRUCT
+#define REG_STRUCT abm_regs
+		abm_regs_init(0),
+		abm_regs_init(1),
+		abm_regs_init(2),
+		abm_regs_init(3);
+
+#undef REG_STRUCT
+#define REG_STRUCT dccg_regs
+		dccg_regs_init();
+
+
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_dcn321;
-- 
2.25.1

