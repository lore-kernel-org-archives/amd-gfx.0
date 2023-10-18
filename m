Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71257CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1339610E3D0;
	Wed, 18 Oct 2023 11:40:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DCE10E3E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blAZFKEsZ5+eihUKprBa5j2aWKbrOwme8Yh1D95IxTTsAwqZIHkEPZ49UpNcpZWfN+qFg/IQ2FOSEBbPCIu5qUGL5gWSu+BaljFew4S/E4vFOyt8EfNHVwTxJAsj71oxcd7cZrOjFgykLW2BJB/SyIaZ12hdbdzvfjpmS3IRSfnmwsNKynMwz5bY5hDq68K/rBvJgHuErCRGx0OIYKyP0UH2LEV7btESuyZpePckfTD3OA/L6QHMSsveGNcCMc/GY9W6rE9n1HXSgCTnhYom4HXZA07kK3uu4yuo6bDfuGmLTjJ9a/+WaDY4+2l02q19eB1mUWvV8Ohg1OXQLvDVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlFS8UdaIWBxAYy+puSQsnfnuEXTF9yVHyVH996aNkI=;
 b=PyzFzG2IhhHmesQ7evi291TkfwxwreUpuIrPvOuwYGV/ervY+BK7gKjIb52ansZvTMGe6cjudeIXzEkCunHk8fOG7hYR1ILZhQ2fmElivpF42oJtA2lvk3MuQB9kiQSxEUoqiczPEtdfHm6Xr2thMbK5EUEkEvBIuMuZVcFKC9Q5kkVPs2/+36sBNv0XTH3nBv3MkMSULDLbT+OQBArUPNFk50iPBRbYukjXrUrElxVKoHn//EwrGkUOw3KdPnPfewMgvNb+5TnbMsm7HCr4/DpWoxXw8gh1Kqom68l/a1UyzZK/VERPP4wVsB9VLfDCZw6+vpiMdbIgsdT1vqbzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlFS8UdaIWBxAYy+puSQsnfnuEXTF9yVHyVH996aNkI=;
 b=xLAKxUQRTKL5zZNRmNkVZG7FzrElXi7gRG9A74BNnYv+6JmQGo/TY+ertyzLOWOp6N+g2iSXWUd//XurMWWNfRDUCSKFs6ssizDnyZjrCmHDtEXukLPlyGgqrXlTR2iFV/QGvKkU7VhX/tdNIf/YaookNOLG8Ttw3IODn/iAt04=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Wed, 18 Oct 2023 11:40:36 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::a0) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 11:40:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:33 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: drop status query/reset for GCEA 9.4.3 and
 MMEA 1.8
Date: Wed, 18 Oct 2023 19:39:57 +0800
Message-ID: <20231018113957.20079-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231018113957.20079-1-tao.zhou1@amd.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM8PR12MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 067dabfd-c11f-40c3-7896-08dbcfcf0bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjnWRMY98tUzVGSM3pLY2vx5d3kZN3sHBQQyocdt05aT7WRoDDY7yU6TtV02D6eRrR26ao/07nDQe+NpMVOzj2W+cbsW7q3wWZQS3bnlJs15W1WIwD7UI1lVs3bP1KnfbGaAH+4DzM8DVFDSHJvJXVRLEbnD98Rok6s4vvfosm9RMkk1+bGrOHM2Po0Vl0foTzUex+K7/6G2WxFfgjg9i8jZ9Ac6sCBJ8a31SlNdxn9p85ffgoL3573unw/8AmMLxnrYdto/XQL2T5bREmpWrTnQ96xcfkJWjbhbcPXLmxlmv1Z7kTBbK2t1MyGcjQgw+jINMpvqxxXPjf7sfeRnfTCWCiv04fvBbDjpNFNRrf79hAlXaiQTGHKLvQJv3UvT4PQUBGEizGj4yTcbKPn1vofJvQGa96OHGJ3mnPtoAfavhEz3AMJF5/Q0OLeQvOlDJPwauWtATP3ZOISMfCPKPnUILmxFs1iPBvkUHLRoc7dO/0cRhmHOEfKixqvyAS1pLDvpfKvqPx4nss9P3f1hNR5opr/4Xy1gsNKHif4IUHCf1wA0a+B/Wr/V2r0/63G4sEYUgzFkLb/eRCAmAzABadJtvzPK9lM1Ikfjtv7JljmxjAPRcndfXwQej+3tb8ytPojAV5dChpfR6Zj452qjg5YoBhOy8scjXxOhWslEXh8trNbVTjy0rcQCJeQIhdfUvxTDdwzuwPCk6VbDjSg3IyHBYcSbAUpHCIWKR2oQ1xAU8R9MTj0HXaHk1L4z12upWUL/rAOJ+IR6JVTdkA80fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(70586007)(478600001)(110136005)(70206006)(6636002)(6666004)(47076005)(36860700001)(86362001)(356005)(82740400003)(83380400001)(316002)(26005)(7696005)(4326008)(336012)(16526019)(2616005)(1076003)(426003)(81166007)(36756003)(8936002)(5660300002)(2906002)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:36.5667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067dabfd-c11f-40c3-7896-08dbcfcf0bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW will be responsible for them.

v2: remove query interfaces.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  60 ----------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 143 ------------------------
 2 files changed, 203 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a1c2c952d882..362bf51ab1d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3754,10 +3754,6 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] = {
 	    AMDGPU_GFX_LDS_MEM, 4},
 };
 
-static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs = {
-	SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16
-};
-
 static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
@@ -3846,39 +3842,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-static void gfx_v9_4_3_inst_query_ea_err_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t i, j;
-	uint32_t reg_value;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-
-	for (i = 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j++) {
-			gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
-			reg_value = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-					regGCEA_ERR_STATUS);
-			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
-			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
-			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
-				dev_warn(adev->dev,
-					"GCEA err detected at instance: %d, status: 0x%x!\n",
-					j, reg_value);
-			}
-			/* clear after read */
-			reg_value = REG_SET_FIELD(reg_value, GCEA_ERR_STATUS,
-						  CLEAR_ERROR_STATUS, 0x1);
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS,
-					reg_value);
-		}
-	}
-
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-			xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-}
-
 static void gfx_v9_4_3_inst_query_utc_err_status(struct amdgpu_device *adev,
 					int xcc_id)
 {
@@ -3983,7 +3946,6 @@ static void gfx_v9_4_3_inst_query_sq_timeout_status(struct amdgpu_device *adev,
 static void gfx_v9_4_3_inst_query_ras_err_status(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
-	gfx_v9_4_3_inst_query_ea_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_query_sq_timeout_status(adev, xcc_id);
 }
@@ -3996,27 +3958,6 @@ static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS, 0x3);
 }
 
-static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t i, j;
-	uint32_t value;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j++) {
-			gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
-			value = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS);
-			value = REG_SET_FIELD(value, GCEA_ERR_STATUS,
-						CLEAR_ERROR_STATUS, 0x1);
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS, value);
-		}
-	}
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-			xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-}
-
 static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device *adev,
 					int xcc_id)
 {
@@ -4042,7 +3983,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
 	gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
-	gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index aa00483e7b37..ea142611be1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -700,152 +700,9 @@ static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
 }
 
-static const u32 mmhub_v1_8_mmea_err_status_reg[] __maybe_unused = {
-	regMMEA0_ERR_STATUS,
-	regMMEA1_ERR_STATUS,
-	regMMEA2_ERR_STATUS,
-	regMMEA3_ERR_STATUS,
-	regMMEA4_ERR_STATUS,
-};
-
-static void mmhub_v1_8_inst_query_ras_err_status(struct amdgpu_device *adev,
-						 uint32_t mmhub_inst)
-{
-	uint32_t reg_value;
-	uint32_t mmea_err_status_addr_dist;
-	uint32_t i;
-
-	/* query mmea ras err status */
-	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
-	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) {
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_ERR_STATUS,
-						i * mmea_err_status_addr_dist);
-		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_STATUS) ||
-		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_STATUS) ||
-		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
-			dev_warn(adev->dev,
-				 "Detected MMEA%d err in MMHUB%d, status: 0x%x\n",
-				 i, mmhub_inst, reg_value);
-		}
-	}
-
-	/* query mm_cane ras err status */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS);
-	if (REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_STATUS) ||
-	    REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_WRRSP_STATUS) ||
-	    REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_DATAPARITY_ERROR)) {
-		dev_warn(adev->dev,
-			 "Detected MM CANE err in MMHUB%d, status: 0x%x\n",
-			 mmhub_inst, reg_value);
-	}
-}
-
-static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
-{
-	uint32_t inst_mask;
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-		return;
-	}
-
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask)
-		mmhub_v1_8_inst_query_ras_err_status(adev, i);
-}
-
-static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
-						 uint32_t mmhub_inst)
-{
-	uint32_t mmea_cgtt_clk_cntl_addr_dist;
-	uint32_t mmea_err_status_addr_dist;
-	uint32_t reg_value;
-	uint32_t i;
-
-	/* reset mmea ras err status */
-	mmea_cgtt_clk_cntl_addr_dist = regMMEA1_CGTT_CLK_CTRL - regMMEA0_CGTT_CLK_CTRL;
-	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
-	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) {
-		/* force clk branch on for response path
-		 * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 1
-		 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_CGTT_CLK_CTRL,
-						i * mmea_cgtt_clk_cntl_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-					  SOFT_OVERRIDE_RETURN, 1);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_CGTT_CLK_CTRL,
-				    i * mmea_cgtt_clk_cntl_addr_dist,
-				    reg_value);
-
-		/* set MMEA0_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_ERR_STATUS,
-						i * mmea_err_status_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
-					  CLEAR_ERROR_STATUS, 1);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_ERR_STATUS,
-				    i * mmea_err_status_addr_dist,
-				    reg_value);
-
-		/* set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 0 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_CGTT_CLK_CTRL,
-						i * mmea_cgtt_clk_cntl_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-					  SOFT_OVERRIDE_RETURN, 0);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_CGTT_CLK_CTRL,
-				    i * mmea_cgtt_clk_cntl_addr_dist,
-				    reg_value);
-	}
-
-	/* reset mm_cane ras err status
-	 * force clk branch on for response path
-	 * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 1
-	 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-				  SOFT_OVERRIDE_ATRET, 1);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-
-	/* set MM_CANE_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ERR_STATUS,
-				  CLEAR_ERROR_STATUS, 1);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS, reg_value);
-
-	/* set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 0 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-				  SOFT_OVERRIDE_ATRET, 0);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-}
-
-static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device *adev)
-{
-	uint32_t inst_mask;
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-		return;
-	}
-
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask)
-		mmhub_v1_8_inst_reset_ras_err_status(adev, i);
-}
-
 static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
 	.query_ras_error_count = mmhub_v1_8_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
-	.query_ras_error_status = mmhub_v1_8_query_ras_error_status,
-	.reset_ras_error_status = mmhub_v1_8_reset_ras_error_status,
 };
 
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
-- 
2.35.1

