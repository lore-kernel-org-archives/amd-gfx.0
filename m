Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BAEC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAAE10E45A;
	Wed,  9 Aug 2023 15:08:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F3B10E45A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwqtLrz926Cv7yWD7oKcxS6t7+F7NIM7t4IT9NWg3xO16HncKB2bzZHpPrsDPgiCTUm85C5fo/MubnkKrVIPYa8048Sf8HK8d4fHpMG3x8YpeOPJLBzz6tzJe2vUocvrrFAlmbUDltr09Exum2SbrA46M453VW4ALjli5CxbCe5iBFXtxRs3Bm14do7aNhx1R9pa/73F3PWWebsmyrY/rSyS5hsfOWkfdw3TWZOb0Bw7F2UMbpqN4GkXOGqVvLxzLkxwcJwA+eTbmtCLF/PuRMUH3t2+cewceGAPRNzKSYGE20A7CfyarUvxaRkqhTu+2zMxWePWLliQh+KVbdYSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFCulF+r6Nx7OZ2bGukznOz8iY7minbjfUbzdKJQn7g=;
 b=a+Oc74MHiReVBNMSLda7GGBJfVdco/0h+qrK9G1Bvd42pdaBFaRgExU98ZkrsSfGfNQIfWqcpl07Fboem7VgxPNpRmnyHOtszIxRsWIbh2KWrgteMbqYv1YJDqUnqQY3HIObn7bGIUKlMrEti/Pgm3nG4RpqGcTb2XxGqKNCqyyKlW9iDBWmWRW3iizv4JY5L++S/l9ZWmr/X4D5lId3U2fVIKQK4qrDplYOo9uAaBrUqJ41KO2hfaHKKTB4eQpl/GWOm0fhAP58u1uAv6CVF7k9eNyG2rb8GpQwlhTSKgqrMqSaPQ2hVVeJSZPfxmnS5+14NTQ42I7OiszMkRwygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFCulF+r6Nx7OZ2bGukznOz8iY7minbjfUbzdKJQn7g=;
 b=eqvP1lW5U9snGb98vvKC1c7BIPK20XsHZN1bUOq3Y/r9LRtrO9KOGB1qWVAiLJG/YV5bLhXe2+kSoIty7cO0zr/PEnW+cdb2bs8Fd3ITNEqqG3/jbBlFBGCPpcElqnfGP8vu9qGskIdwL6psRZ4dDa7gMtWeazmV0flrICH6ZYQ=
Received: from CYZPR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:8e::14)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:08:53 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::2f) by CYZPR19CA0006.outlook.office365.com
 (2603:10b6:930:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:53 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:49 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/15] drm/amd/display: Add some missing register definitions
Date: Wed, 9 Aug 2023 23:05:01 +0800
Message-ID: <20230809150620.1071566-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de90b0d-2e3d-4138-e807-08db98ea8bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoFmD1pDbKKv7RMHVY3Y1fkli8QoWo4QoqSE3EAN/NRr9Jvd/WGxoTe22BHlQTvJj6JYy6E+9IV/jQBuNd4NL8Sghouxla6FNXFZkl+1nIsMeZ/1Mpfda52qYY5E4x6TY1iCwmLGFM5QQRqNxqI2bhYIDHbjwt08nnBdN+QYM9gVHHjBcB/PhZNgvxGCCHc2HQey7FXtRMJn0Ffc/gzeKCGtdwlYxK0iQt59DXLdQ6SVEjcwuBZGNF+baSP2fMYDKvV2vs7Hf17gd7ng7ksiH7bf3yCQhIpoKQ2ugi1GPTpcJ02KVYH5m4uHYCUNG3uFJr4k9VH/yE6xef8FVaiD1+2hrN1xvgZpKpVOirHd9szdoUBEb/blDnsx7k77stMRW2IfFmoiItJJQuVFkS0DtOl43H+xE4nHbGlaCV5geEDhBvHcjmvBVH2lZdKCUi5yTCQN2ISk0WVrgR78BK96/GCMIx0aGv8nlI/+pzI460YsMk2VhDdZelZ5FsMxYmks7kLaweXw6iAIPG+3rAUOAP73LQtLTc50rgrcc3AGLP2u1BeqTgGejF+eh2kZ7xzFC52cgtj1LD1maCzqGAy5P0uOx5a/imctOUPT3IhIUjX+X92antBoRDMA2bLbNmpn8hkUOqx9FqRz1wte2tJTsHAgGiFMOUihf9Xlcd4fi32Jd41PWFfs+E7wA/zR8d0UyJvV40kJabLh93pwyAfHaBDhpubVkxTO0rPEA/ftgcXRfEEcAspSTdQ00jfeK47A3eWwGe2TRgcZcPyyGxJ7TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799006)(82310400008)(186006)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(26005)(1076003)(40460700003)(36756003)(54906003)(44832011)(5660300002)(86362001)(2906002)(4326008)(6916009)(8676002)(70586007)(70206006)(8936002)(316002)(41300700001)(6666004)(7696005)(81166007)(82740400003)(478600001)(356005)(36860700001)(2616005)(47076005)(83380400001)(426003)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:53.5359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de90b0d-2e3d-4138-e807-08db98ea8bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Add some missing register definitions and rearrange some others to
maintain consistency with related definitions.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    | 69 +++++++++++--------
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |  5 ++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |  5 ++
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  4 ++
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |  5 +-
 5 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index a3fee929cd12..86233f94db4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -98,6 +98,29 @@
 	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4), \
 	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 5)
 
+#define HWSEQ_PIXEL_RATE_REG_LIST_302(blk) \
+	SRII(PIXEL_RATE_CNTL, blk, 0), \
+	SRII(PIXEL_RATE_CNTL, blk, 1),\
+	SRII(PIXEL_RATE_CNTL, blk, 2),\
+	SRII(PIXEL_RATE_CNTL, blk, 3), \
+	SRII(PIXEL_RATE_CNTL, blk, 4)
+
+#define HWSEQ_PHYPLL_REG_LIST_302(blk) \
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1),\
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 2),\
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 3), \
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4)
+
+#define HWSEQ_PIXEL_RATE_REG_LIST_303(blk) \
+	SRII(PIXEL_RATE_CNTL, blk, 0), \
+	SRII(PIXEL_RATE_CNTL, blk, 1)
+
+#define HWSEQ_PHYPLL_REG_LIST_303(blk) \
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
+	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
+
+
 #define HWSEQ_PHYPLL_REG_LIST_201(blk) \
 	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
 	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
@@ -387,7 +410,11 @@
 	SR(MPC_CRC_RESULT_C), \
 	SR(MPC_CRC_RESULT_AR), \
 	SR(AZALIA_AUDIO_DTO), \
-	SR(AZALIA_CONTROLLER_CLOCK_GATING)
+	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
+	SR(HPO_TOP_CLOCK_CONTROL), \
+	SR(ODM_MEM_PWR_CTRL3), \
+	SR(DMU_MEM_PWR_CNTL), \
+	SR(MMHUBBUB_MEM_PWR_CNTL)
 
 #define HWSEQ_DCN301_REG_LIST()\
 	SR(REFCLK_CNTL), \
@@ -508,8 +535,11 @@
 	SR(D5VGA_CONTROL), \
 	SR(D6VGA_CONTROL), \
 	SR(DC_IP_REQUEST_CNTL), \
+	HWSEQ_PIXEL_RATE_REG_LIST_302(OTG), \
+	HWSEQ_PHYPLL_REG_LIST_302(OTG), \
 	SR(AZALIA_AUDIO_DTO), \
-	SR(AZALIA_CONTROLLER_CLOCK_GATING)
+	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
+	SR(HPO_TOP_CLOCK_CONTROL)
 
 #define HWSEQ_DCN303_REG_LIST() \
 	HWSEQ_DCN_REG_LIST(), \
@@ -540,28 +570,6 @@
 	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
 	SR(HPO_TOP_CLOCK_CONTROL)
 
-#define HWSEQ_PIXEL_RATE_REG_LIST_302(blk) \
-	SRII(PIXEL_RATE_CNTL, blk, 0), \
-	SRII(PIXEL_RATE_CNTL, blk, 1),\
-	SRII(PIXEL_RATE_CNTL, blk, 2),\
-	SRII(PIXEL_RATE_CNTL, blk, 3), \
-	SRII(PIXEL_RATE_CNTL, blk, 4)
-
-#define HWSEQ_PHYPLL_REG_LIST_302(blk) \
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1),\
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 2),\
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 3), \
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4)
-
-#define HWSEQ_PIXEL_RATE_REG_LIST_303(blk) \
-	SRII(PIXEL_RATE_CNTL, blk, 0), \
-	SRII(PIXEL_RATE_CNTL, blk, 1)
-
-#define HWSEQ_PHYPLL_REG_LIST_303(blk) \
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
-	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
-
 struct dce_hwseq_registers {
 	uint32_t DCFE_CLOCK_CONTROL[6];
 	uint32_t DCFEV_CLOCK_CONTROL;
@@ -663,14 +671,15 @@ struct dce_hwseq_registers {
 	uint32_t MC_VM_XGMI_LFB_CNTL;
 	uint32_t AZALIA_AUDIO_DTO;
 	uint32_t AZALIA_CONTROLLER_CLOCK_GATING;
+	/* MMHUB VM */
+	uint32_t MC_VM_FB_LOCATION_BASE;
+	uint32_t MC_VM_FB_LOCATION_TOP;
+	uint32_t MC_VM_FB_OFFSET;
+	uint32_t MMHUBBUB_MEM_PWR_CNTL;
 	uint32_t HPO_TOP_CLOCK_CONTROL;
 	uint32_t ODM_MEM_PWR_CTRL3;
 	uint32_t DMU_MEM_PWR_CNTL;
-	uint32_t MMHUBBUB_MEM_PWR_CNTL;
 	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
-	uint32_t MC_VM_FB_LOCATION_BASE;
-	uint32_t MC_VM_FB_LOCATION_TOP;
-	uint32_t MC_VM_FB_OFFSET;
 	uint32_t HPO_TOP_HW_CONTROL;
 };
  /* set field name */
@@ -915,6 +924,7 @@ struct dce_hwseq_registers {
 #define HWSEQ_DCN30_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN2_MASK_SH_LIST(mask_sh), \
 	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
+	HWS_SF(, HPO_TOP_CLOCK_CONTROL, HPO_HDMISTREAMCLK_GATE_DIS, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
 	HWS_SF(, DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, mask_sh), \
@@ -1012,7 +1022,8 @@ struct dce_hwseq_registers {
 	HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN19_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DOMAIN20_PG_STATUS, DOMAIN20_PGFSM_PWR_STATUS, mask_sh), \
 	HWS_SF(, DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh), \
-	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh)
+	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
+	HWS_SF(, HPO_TOP_CLOCK_CONTROL, HPO_HDMISTREAMCLK_GATE_DIS, mask_sh)
 
 #define HWSEQ_DCN303_MASK_SH_LIST(mask_sh) \
 	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
index 537aee0536d3..f2f8f9b39c6b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
@@ -15805,6 +15805,11 @@
 #define mmDME6_DME_MEMORY_CONTROL                                                                      0x093d
 #define mmDME6_DME_MEMORY_CONTROL_BASE_IDX                                                             3
 
+// addressBlock: dce_dc_hpo_hpo_top_dispdec
+// base address: 0x0
+#define mmHPO_TOP_CLOCK_CONTROL                                                                        0x0e43
+#define mmHPO_TOP_CLOCK_CONTROL_BASE_IDX                                                               3
+
 // base address: 0x1a698
 #define mmDC_PERFMON29_PERFCOUNTER_CNTL                                                                0x0e66
 #define mmDC_PERFMON29_PERFCOUNTER_CNTL_BASE_IDX                                                       3
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index f9d90b098519..e0a447351623 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -60666,7 +60666,12 @@
 #define DME6_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE_MASK                                                       0x00000300L
 #define DME6_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                                     0x00003000L
 
+// addressBlock: dce_dc_hpo_hpo_top_dispdec
+//HPO_TOP_CLOCK_CONTROL
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
 
+// addressBlock: dce_dc_hpo_hpo_dcperfmon_dc_perfmon_dispdec
 //DC_PERFMON29_PERFCOUNTER_CNTL
 #define DC_PERFMON29_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT                                           0x0
 #define DC_PERFMON29_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT                                          0x9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
index 476469d41d73..b45a35aae241 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
@@ -14205,6 +14205,10 @@
 
 
 
+// addressBlock: dce_dc_hpo_hpo_top_dispdec
+// base address: 0x0
+#define mmHPO_TOP_CLOCK_CONTROL                                                                        0x0e43
+#define mmHPO_TOP_CLOCK_CONTROL_BASE_IDX                                                               3
 
 // base address: 0x1a698
 #define mmDC_PERFMON26_PERFCOUNTER_CNTL                                                                0x0e66
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
index b9de0ebc8b03..3dae29f9581e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
@@ -52401,7 +52401,10 @@
 #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW__SHIFT                                                          0x0
 #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW_MASK                                                            0xFFFFFFFFL
 
-
+// addressBlock: dce_dc_hpo_hpo_top_dispdec
+//HPO_TOP_CLOCK_CONTROL
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
 
 // addressBlock: dce_dc_hpo_hpo_dcperfmon_dc_perfmon_dispdec
 //DC_PERFMON26_PERFCOUNTER_CNTL
-- 
2.41.0

