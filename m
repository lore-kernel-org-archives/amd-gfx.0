Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66857C7EE22
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 15:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3523F10E4F8;
	Thu, 11 May 2023 15:38:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20E810E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 15:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJSW04api1KtKSgr02B0ZZlfZoDk8mPawp+RrpIRgp1RVrgdAJVnrI1R09qtKg/r7zWTB4PMg67NAoeqKgBM+CE0PL0SfHjqQPnNSD/W/Kuj/cQBbpIhmg7GK5zz8r9uJfhUpkLvFxAf5OwTZImoVEQ5xxUzqskz+7KJSt8aVEItCnsHjKCa98jlWtgJ84k/YnrQITwgShOXmCLSWSmZtt2EI+bH7AewKcq/VZ321E9nxv16RzmEpuFzPDHRdVT9sAbu08BEFTynMo5nR774rYKm7cObjM0ieRKSaMe83GnRLzWTuRO795qRu50OezPAxK5Wexfb1iAxAHCkCpBrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvGg7Im+cM/yPTDuG3wmk59i3diz6VX7wiDvkBzmdDk=;
 b=Br0J2pqYOj6YU9JV6imbs6o2A+50wo++ibxYKRM2Yhh8cwMUx7697RGsJiBDBqoP+GwKi8VdreYsalQEiaUcY5Pc8JXzYpk9u5EXQEZvc4cDysIjkCkwQurdvB534TzrM271hpUMtip6nzGmt0V1W2SSoODvBz+hmkxp7zM347chLD3epWj7nnByIrKGEDvfOrtGj4i8WUNjRHn0qPUamHCFM1P4f46XzzNDUnh3yjzvZrDwHXU6CQ5XyG4Y/OeSUFIRPh7fdVRnTle5oUPcp4UqUDP2xfYi8uyNQCAT4sy0qvJ5Bm6lCKUrBpqfQo+1jtyuaHKnHUFK68P5qtKfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvGg7Im+cM/yPTDuG3wmk59i3diz6VX7wiDvkBzmdDk=;
 b=hb3Mn+Wm+dfqwCPbm5s5vHxPWlnuqTEQgOQP9h7wf7bsJm7Ol6VjoyQrr/OmSgUNOZx0W6Sso0TIGnPsMA3wnd0tA9aI3mm/OhzpY8xsUT5Fw1VnEjHp4oAA21Ju68s8hdrhko732FC05M09Ywfb1U9IOQW09f1xGUrOUmMVZi4=
Received: from BN0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:408:ec::12)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 15:38:09 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::72) by BN0PR04CA0097.outlook.office365.com
 (2603:10b6:408:ec::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 15:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 15:38:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 10:38:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 08:38:07 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 11 May 2023 10:38:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Add some missing register definitions
Date: Thu, 11 May 2023 11:38:05 -0400
Message-ID: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6e804a-63b6-4e69-7fef-08db5235b87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrT0OJ9oajfM5X8qpBEdHSTZ0P7q2q3rUEfsp56NMRtw8gN27iBaGVw9v5BRlrU+h3aWgryvzGUyLNdJ/C3WtUaSimQwEBAmpplM6xdmx5e8s/QtMowXLjJADfCvKTpwWaLsw10UqFSrIThg1Zl7KtlZSs2ZGUzHhoKysk7n2LHo9Vk55cHsRoln4Po2n/1/n94xavcSgdPYJpl1mONy6dZ9k69GNVdo45K+PazvuNco5QdMpwiMk6DJTX/KZPkD9RXD+Rq7tggFE09U1cuERonH4R400aGjRVFDZsEX5WWOS6OZvJI9Dq6y/4iyQl1kbwRHOg+QDZSQ/oEwoOoGgwDV4KnrG2s/A1To0+lyM9niGnbxYxuBLcOH5nWYtvIbJGrLwMEUfWIOMghxULwJ7hpDaJgn9ybRbiq/X3uKRMw6ZjNXSweEePkMpryJo6/d6SBAGUuXd4I5h+XLrTVpRgWDXgzXnMduby8cXRn/ZaJPbM8MbT+SymlDJF6bK8KurkmMwEEVyONg3R8zVVf6WA1ygdqpmx9S20cA5UA8YNkA9ggnzz52XG+yl9P36noABh9zjXFMJilXqiC8OuZlzHu3L3VFuf4R3n4nQws7XubxXb6UvodU1Ta7k98vo/YlIbamKI/9P2+oH0+Y7mvAHLxZm5ZMu5H78LKk/RLjwG0nOsSIR7/+Lq6SLSLBYnUiDXNwdNsDVNggk7prsoDwemTYXJbMAjiX8h8jMkYrvx6UzNeEWDkUM5BOBDiaSMKvX4gb8/8SgE3Dac3Z7/9ikA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82740400003)(81166007)(356005)(82310400005)(86362001)(8676002)(40460700003)(8936002)(7696005)(5660300002)(478600001)(44832011)(1076003)(26005)(40480700001)(2616005)(316002)(186003)(83380400001)(336012)(47076005)(2906002)(426003)(41300700001)(70206006)(70586007)(54906003)(6916009)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:38:08.4499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e804a-63b6-4e69-7fef-08db5235b87c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Add some missing register definitions and rearrange some others to
maintain consistency with related definitions.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
2.40.0

