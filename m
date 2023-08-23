Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7EEEE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5383610E43A;
	Wed, 23 Aug 2023 15:51:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E9A10E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5m6U06zjfmrjUszAkqZZDtgIilev5VUYz6NNS9heUmBTsBpJA7Srn/DMx2dfuRnC554mjMCjOM/NfqGEAcYwrio04Z/llxpmfr2kdQ0f+fENAlwNtxNmUgOZXtxNWLQFOEyeEjMZVHbCyiZawockLC4Hp6x1nq3+ayZ4trZcqroh0LCq1vqLVL1VfOLEmgCJJVs837KL9FwlebK1GL4btJEz98gUxa6wS5/cNsuxSzA4OTIGcJzS2eSBaeyQKjbsPK3PdQHDxRGHahhKkfh8hmeeyWGjg8AHfvL521KpxJG5EB1uXxOHUvA766RqHtG/YBzimukB8W3CaPyFKL2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LjrfcHAUMGcNOeamXAP+jhiCkMb8Jtd2Vshks0yelo=;
 b=kLn6zPAI22nC50wfk7I+vmgTEPb5Z8RLy6ds8yMLuGAoQilbjfRATiaBS446835XCyzsLrKWl3z+ba2NRCAwXWWQR6gMiUShl4tn5GKWYNXP+TqP90YYxuzqhwInZV2qEoDzwPvQCAsd4p0q8oTKEMiEhCAgQZCjaH9LbFMeBb401eConQz6xYs1foaPcQXqrcbd/P56sM5BKwhHT+tNG7Ul46gpI8lrbSX36SDy0BNUKtnyk9jrBn+yLyWlsS8k5mQo+2fnCHV6qTb4FWtTiSiISdPoFRjlawT19MUMmcDl5beZlOovVyp4tmxMZRhLNdcsna61olCYkbf0DHI0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LjrfcHAUMGcNOeamXAP+jhiCkMb8Jtd2Vshks0yelo=;
 b=CoDK9y8niwCNnfOnon6RXg8/wEirtOWf/UWgpZz3fWjIhd73ZGD/34pEd+7EFXZDrLrx1txUrAi1Wvdv1hBP0MPXWWAv+GtUbduXiNOmtWRNweUJnpon0v2Hz8+6TqBd9TDzfoo5TL7RBCwaqMjwv5VP/UxjLHeE/psaF5sV2I4=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:09 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::23) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/35] drm/amd/display: Update DCE for DCN35 support
Date: Wed, 23 Aug 2023 11:50:17 -0400
Message-ID: <20230823155048.2526343-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c6154b-dcde-437a-0659-08dba3f0c486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1SqKdnVx1d2upnUnXhSNRxFJQx8b5UbJhsSvycZo99ePKTT1H1OCq7ouoai6opoZqYFLXBWs918OKgBk3RN+AHCe41zNWG1iCeQ687dPcRXHzYLmQCvp/gn4dCe4/MMwcrF/SHeeynMrFSoArCHRNTtFnbdMcQOF+7lvyCBHzVxy3ovnBevFFX8j3V0ms3GhTA+yNgKqq6EfzE7etuIZ9gxDuGoVM2GuG9BAjW5w3XO6k3CkYzybeW+TD25Zeax2mOu9c3m4MpYMaFWB5nKEkIy0wB+juIHZUSqMK4REi9aKUzHISrNfoLjy+VnwGl7gxAq6sQ5QB4hygtGf40GB+ve7ZToXR2On1MfuA+Vq4H0DdyHDwzqMN0DtqH1itKEvBZxQml3Qw0uvfFANKdn80BlGce5d0CSXFVgCQet57RLR9Y5XMZugDnDmPmMpo0HDUgwd9Dn2UTcwJbDz2Ao8+qn+M0bMhJxY5x+RW3FClRIL7rB+FpHDLDeE6QE2O5rgWznrWb5zydWZj0eJY9nPoDFbun+R98ytBdx4hwsEpkCdsRMfh5zXFoMTT6+BHu1fVzXxDQapvYU/uTEciHYcyg/Y9Kh/PQAHeHpWI5roJTsBk75Kz9d+6K+zcj1/hOAgRt7tmRUVM7ytm8OOnh/wg3ZWaCiuEHBu/LNENAjw8zfSy9cTXQEqrlY4XnJuwwzWOOS0MRq5STvx/FGvNvAhSInLYZRDsWO48dy5zxh7E0VXaeV/otVCezl8ojgz4zXmu5S9t0ts9FaWvnsfBZ1FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(15650500001)(40480700001)(83380400001)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:08.6715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c6154b-dcde-437a-0659-08dba3f0c486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCE files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  9 ++++++---
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    | 20 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  4 ++++
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |  6 ++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index 168cb7094c95..c50aa30614be 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -183,8 +183,7 @@
 	ABM_SF(DC_ABM1_HGLS_REG_READ_PROGRESS, \
 			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, mask_sh)
 
-#define ABM_MASK_SH_LIST_DCN10(mask_sh) \
-	ABM_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh), \
+#define ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh) \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
 			ABM1_HG_NUM_OF_BINS_SEL, mask_sh), \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
@@ -214,9 +213,13 @@
 	ABM_SF(ABM0_DC_ABM1_HGLS_REG_READ_PROGRESS, \
 			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, mask_sh)
 
-#define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
+#define ABM_MASK_SH_LIST_DCN10(mask_sh) \
+	ABM_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh), \
+	ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh)
 
+#define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
 #define ABM_MASK_SH_LIST_DCN30(mask_sh) ABM_MASK_SH_LIST_DCN10(mask_sh)
+#define ABM_MASK_SH_LIST_DCN35(mask_sh) ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh)
 
 #define ABM_MASK_SH_LIST_DCN32(mask_sh) \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index 86233f94db4a..2fefdf40612d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -681,6 +681,8 @@ struct dce_hwseq_registers {
 	uint32_t DMU_MEM_PWR_CNTL;
 	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
 	uint32_t HPO_TOP_HW_CONTROL;
+	uint32_t DMU_CLK_CNTL;
+	uint32_t DCCG_GATE_DISABLE_CNTL5;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -1167,12 +1169,29 @@ struct dce_hwseq_registers {
 	type I2C_LIGHT_SLEEP_FORCE;\
 	type HPO_IO_EN;
 
+#define HWSEQ_DCN35_REG_FIELD_LIST(type) \
+	type DISPCLK_R_DMU_GATE_DIS;\
+	type DISPCLK_G_RBBMIF_GATE_DIS;\
+	type RBBMIF_FGCG_REP_DIS;\
+	type IHC_FGCG_REP_DIS;\
+	type DPREFCLK_ALLOW_DS_CLKSTOP;\
+	type DISPCLK_ALLOW_DS_CLKSTOP;\
+	type DPPCLK_ALLOW_DS_CLKSTOP;\
+	type DTBCLK_ALLOW_DS_CLKSTOP;\
+	type DCFCLK_ALLOW_DS_CLKSTOP;\
+	type DPIACLK_ALLOW_DS_CLKSTOP;\
+	type LONO_FGCG_REP_DIS;\
+	type LONO_DISPCLK_GATE_DISABLE;\
+	type LONO_SOCCLK_GATE_DISABLE;\
+	type LONO_DMCUBCLK_GATE_DISABLE;
+
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN3_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN301_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN31_REG_FIELD_LIST(uint8_t)
+	HWSEQ_DCN35_REG_FIELD_LIST(uint8_t)
 };
 
 struct dce_hwseq_mask {
@@ -1181,6 +1200,7 @@ struct dce_hwseq_mask {
 	HWSEQ_DCN3_REG_FIELD_LIST(uint32_t)
 	HWSEQ_DCN301_REG_FIELD_LIST(uint32_t)
 	HWSEQ_DCN31_REG_FIELD_LIST(uint32_t)
+	HWSEQ_DCN35_REG_FIELD_LIST(uint32_t)
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 4f552c3e7663..a2f48d46d199 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -308,6 +308,10 @@ static bool setup_engine(
 		     }
 	     }
 
+	if (dce_i2c_hw->masks->DC_I2C_DDC1_CLK_EN)
+		REG_UPDATE_N(SETUP, 1,
+			     FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_CLK_EN), 1);
+
 	/* we have checked I2c not used by DMCU, set SW use I2C REQ to 1 to indicate SW using it*/
 	REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_USE_I2C_REG_REQ, 1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
index 3f45ecd189a2..3da32217d9ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h
@@ -188,6 +188,7 @@ struct dce_i2c_shift {
 	uint8_t DC_I2C_REG_RW_CNTL_STATUS;
 	uint8_t I2C_LIGHT_SLEEP_FORCE;
 	uint8_t I2C_MEM_PWR_STATE;
+	uint8_t DC_I2C_DDC1_CLK_EN;
 };
 
 struct dce_i2c_mask {
@@ -232,6 +233,7 @@ struct dce_i2c_mask {
 	uint32_t DC_I2C_REG_RW_CNTL_STATUS;
 	uint32_t I2C_LIGHT_SLEEP_FORCE;
 	uint32_t I2C_MEM_PWR_STATE;
+	uint32_t DC_I2C_DDC1_CLK_EN;
 };
 
 #define I2C_COMMON_MASK_SH_LIST_DCN2(mask_sh)\
@@ -243,6 +245,10 @@ struct dce_i2c_mask {
 	I2C_SF(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh),\
 	I2C_SF(DIO_MEM_PWR_STATUS, I2C_MEM_PWR_STATE, mask_sh)
 
+#define I2C_COMMON_MASK_SH_LIST_DCN35(mask_sh)\
+	I2C_COMMON_MASK_SH_LIST_DCN30(mask_sh),\
+	I2C_SF(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_CLK_EN, mask_sh)
+
 struct dce_i2c_registers {
 	uint32_t SETUP;
 	uint32_t SPEED;
-- 
2.41.0

